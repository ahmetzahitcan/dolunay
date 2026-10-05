`default_nettype none

/*
    Front-end of the core. Responsible for instruction issuing.
    - In-order issue
    - No register renaming
    - Scoreboard to keep track of hazards
    - Can acquire scoreboard entries, but release must be done by the back-end.
*/

module core_frontend
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
# (
    parameter int IROM_SIZE,
    localparam int W_IROM_ADDR = $clog2(IROM_SIZE)
) (
    input wire logic clk,
    input wire logic rst_n,

    // IROM Interface
    output logic [W_IROM_ADDR-1:Z_PC] instr_addr_o,
    input wire logic [RLEN-1:0] undec_instr32_i,

    // Scoreboard Interface

    output warp_id_t sb_warp_id_o,

    output reg_id_t sb_chk1_idx_o,
    output regfile_sel_e sb_chk1_regfile_o,
    output logic sb_chk1_en_o,
    input wire logic sb_chk1_busy_i,

    output reg_id_t sb_chk2_idx_o,
    output regfile_sel_e sb_chk2_regfile_o,
    output logic sb_chk2_en_o,
    input wire logic sb_chk2_busy_i,

    output reg_id_t sb_chk3_idx_o,
    output regfile_sel_e sb_chk3_regfile_o,
    output logic sb_chk3_en_o,
    input wire logic sb_chk3_busy_i,

    output reg_id_t sb_acq_idx_o,
    output regfile_sel_e sb_acq_regfile_o,
    output seq_t sb_acq_seq_o,
    output logic sb_acq_en_o,

    output warp_id_t hsb_warp_id_o,
    input wire hazard_mask_t hsb_busy_i,
    output hazard_mask_t hsb_acq_mask_o,
    output seq_t hsb_acq_seq_o,

    // Branch interface
    input wire logic branch_complete_i,
    input wire simd_mask_t branch_mask_i,
    input wire branch_type_e branch_type_i,
    input wire warp_id_t branch_warp_id_i,
    input wire pc_t branch_pc_i,
    input wire pc_t branch_target_i,

    // Output to middle-end
    input wire logic [N_WARPS-1:0] me_ready_i,
    output logic [N_WARPS-1:0] me_valid_o,
    output me_operation_s me_op_o
);
    // Cross-stage signals

    // - Warp Select stage signals
    logic ws_warp_valid_w;

    // - Instruction Fetch stage signals
    warp_id_t if_warp_id_r;
    logic if_delay_slot_w;

    // - Instruction Decode stage signals
    pc_t id_pc_r;
    simd_mask_t id_mask_r;
    logic [31:2] id_undec_instr32_w;
    warp_id_t id_warp_id_r;
    logic id_delay_slot_w;

    // - Instruction Issue stage signals
    pc_t is_pc_r;
    simd_mask_t is_mask_r;
    instr_s is_instr_r;
    warp_id_t is_warp_id_r;
    logic is_sb_busy_w, is_hsb_busy_w;
    logic is_jump_w;
    logic is_branching_w;
    pc_t is_jump_addr_w;

    logic is_handshake_w;
    assign is_handshake_w = |(me_ready_i & me_valid_o);

    // Pipeline control

    // - Branching signals
    logic [N_WARPS-1:0] branching_r;

    // - Indicate whether a stage contains a valid instruction.
    logic if_stage_valid_r, id_stage_valid_r, is_stage_valid_r;

    // - Indicate whether a stage should be flushed. Flushed stages will fail their instructions,
    //   and in the next cycle, NEXT stage will contain a bubble.
    // - No reason to flush WS because all it does is generate a warp ID.
    logic if_stage_flush_w, id_stage_flush_w, is_stage_flush_w;

    // - Indicate whether a warp/stage combination failed to execute its instruction. PC and seq should be rolled back accordingly.
    logic [N_WARPS-1:0] if_stage_fail_w, id_stage_fail_w, is_stage_fail_w;

    // INFO: So the relationship between flushing and failing is complex.
    //      Obviously a flushed instruction will fail.
    //      However, failing an instruction means that any instructions after it that were in the pipeline must also be flushed.
    //      But, this does not mean any instruction in the previous stages.
    //      Rather, it means instructions from the same warp.

    always_comb begin
        for (int i = 0; i < N_WARPS; i++) begin
            if_stage_fail_w[i] = if_stage_valid_r && if_stage_flush_w && if_warp_id_r == warp_id_t'(i);
            id_stage_fail_w[i] = id_stage_valid_r && id_stage_flush_w && id_warp_id_r == warp_id_t'(i);
            is_stage_fail_w[i] = is_stage_valid_r && is_stage_flush_w && is_warp_id_r == warp_id_t'(i);
        end
    end

    assign if_stage_flush_w = if_delay_slot_w ||
        id_stage_fail_w[if_warp_id_r] ||
        is_stage_fail_w[if_warp_id_r];

    assign id_stage_flush_w = id_delay_slot_w ||
        is_stage_fail_w[id_warp_id_r];

    assign is_stage_flush_w = !is_handshake_w;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            if_stage_valid_r <= 0;
            id_stage_valid_r <= 0;
            is_stage_valid_r <= 0;
        end else begin
            if_stage_valid_r <= ws_warp_valid_w;
            id_stage_valid_r <= if_stage_valid_r & !if_stage_flush_w;
            is_stage_valid_r <= id_stage_valid_r & !id_stage_flush_w;
        end
    end

    // Warp Select
    warp_id_t ws_warp_id_w;

    warp_scheduler u_warp_scheduler(
        .clk(clk),
        .rst_n(rst_n),
        .ready_i('1), // TODO: un-ready stalling warps
        .warp_id_o(ws_warp_id_w),
        .warp_valid_o(ws_warp_valid_w)
    );

    always_ff @( posedge clk ) begin
        if_warp_id_r <= ws_warp_id_w;
    end

    // Instruction Fetch
    pc_t [N_WARPS-1:0] u_thread_scheduler_pc_w;
    simd_mask_t [N_WARPS-1:0] u_thread_scheduler_mask_w;

    pc_t if_pc_w;
    simd_mask_t if_mask_w;

    assign if_pc_w = u_thread_scheduler_pc_w[if_warp_id_r];
    assign if_mask_w = u_thread_scheduler_mask_w[if_warp_id_r];

    assign if_delay_slot_w = (is_jump_w && if_warp_id_r == is_warp_id_r) ||
        (branch_complete_i && branch_type_i == BR_UNIFORM_ALL && if_warp_id_r == branch_warp_id_i);

    logic split_w;
    // pc_t pc_next_w;
    pc_t split_addr_w;

    assign split_w = 0; // FIXME: disabling branching for now
    assign split_addr_w = 'x;

    /*
    always_comb begin
        pc_next_w = 'x;
        split_w = 'x;
        split_addr_w = 'x;

        if (branch_complete_i) begin
            unique case (branch_type_i)
                BR_UNIFORM_ALL: begin
                    pc_next_w = branch_target_i;
                    split_w = 0;
                    split_addr_w = 'x;
                end
                BR_UNIFORM_NONE: begin
                    pc_next_w = branch_pc_i + 1; // FIXME: Wait, these are p1? Analyze why.
                    split_w = 0;
                    split_addr_w = 'x;
                end
                BR_DIVERGENT: begin
                    pc_next_w = branch_pc_i + 1; // FIXME: Wait, these are p1? Analyze why.
                    split_w = 1;
                    split_addr_w = branch_target_i;
                end
            endcase
        end else begin
            if (is_jump_w) begin
                pc_next_w = is_jump_addr_w;
                split_w = 0;
                split_addr_w = 'x;
            end else begin
                pc_next_w = if_pc_p1_w;
                split_w = 0;
                split_addr_w = 'x;
            end
        end
    end
    */
    // - Thread Schedulers
    generate
        for (genvar I = 0; I < N_WARPS; I++) begin : gen_thread_schedulers
            pc_t pc_w;
            simd_mask_t mask_w;

            assign u_thread_scheduler_pc_w[I] = pc_w;
            assign u_thread_scheduler_mask_w[I] = mask_w;

            logic en;
            assign en = 1; // always active for now, apparently. if needed, i'll get rid of en entirely.

            localparam int N_ROLLBACK_TABLE = 8;
            localparam int W_ROLLBACK_TABLE = $clog2(N_ROLLBACK_TABLE);

            pc_t pc_rollback_table_w [0:N_ROLLBACK_TABLE];
            pc_t pc_p1_rollback_table_w [0:N_ROLLBACK_TABLE];

            always_comb begin
                for (int j = 0; j < N_ROLLBACK_TABLE; j++) begin
                    automatic int rollback_amount = $countones(j);

                    pc_rollback_table_w[j] = pc_w - rollback_amount[RLEN-Z_PC-1:0];
                    pc_p1_rollback_table_w[j] = pc_rollback_table_w[j] + 1;
                end
            end

            logic [W_ROLLBACK_TABLE-1:0] rollback_table_idx_w;
            assign rollback_table_idx_w = {if_stage_fail_w[I], id_stage_fail_w[I], is_stage_fail_w[I]};

            pc_t pc_next_w;
            always_comb begin
                if (is_stage_valid_r && is_jump_w && is_warp_id_r == I) begin
                    pc_next_w = is_jump_addr_w;
                end else if (if_stage_valid_r && if_warp_id_r == I) begin
                    pc_next_w = pc_p1_rollback_table_w[rollback_table_idx_w];
                end else begin
                    pc_next_w = pc_rollback_table_w[rollback_table_idx_w];
                end
            end

            thread_scheduler u_thread_scheduler(
                .clk(clk),
                .rst_n(rst_n), // FIXME: start_i
                .en(en),

                .pc_next_i(pc_next_w),
                .yield_i(0),

                .split_i(split_w),
                .split_pc_i(split_addr_w),
                .split_mask_i(branch_mask_i),
/*
                .barr_sync_i(),
                .barr_sync_total_o(),
                .barr_sync_parked_next_o(),
                .barr_sync_release_o(), // Not needed

                .barr_load_i(),
                .barr_load_total_i(),
                .barr_load_parked_i(),
*/
                .pc_o(pc_w),
                .mask_o(mask_w)
            );
        end
    endgenerate

    // - Instruction Memory

    assign instr_addr_o = if_pc_w[W_IROM_ADDR-1:Z_PC];
    assign id_undec_instr32_w = undec_instr32_i[31:2];      // first stalled cycle still uses the live word

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        id_pc_r <= if_pc_w;
        id_mask_r <= if_mask_w;
        id_warp_id_r <= if_warp_id_r;
    end

    // Instruction Decode

    // - Control Unit

    instr_s id_instr_w;

    control_unit u_control_unit(
`ifndef SYNTHESIS
        .sim__runasserts_i(id_stage_valid_r),
`endif
        .undec_instr32_i(id_undec_instr32_w),
        .pc_i(id_pc_r),
        .instr_o(id_instr_w)
    );

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        is_pc_r <= id_pc_r;
        is_mask_r <= id_mask_r;
        is_warp_id_r <= id_warp_id_r;
        is_instr_r <= id_instr_w;
    end

    // Instruction Issue

    // - Sequence generation

    seq_t is_seq_list_r [0:N_WARPS-1];
    seq_t is_seq_list_next_w [0:N_WARPS-1];

    generate
        for (genvar I = 0; I < N_WARPS; I++) begin : gen_is_seq_list
            localparam int N_ROLLBACK_TABLE = 2;
            localparam int W_ROLLBACK_TABLE = $clog2(N_ROLLBACK_TABLE);

            seq_t seq_w;
            assign seq_w = is_seq_list_r[I];

            seq_t seq_rollback_table_w [0:N_ROLLBACK_TABLE-1];
            seq_t seq_p1_rollback_table_w [0:N_ROLLBACK_TABLE-1];
            always_comb begin
                for (int j = 0; j < N_ROLLBACK_TABLE; j++) begin
                    automatic int rollback_amount = $countones(j);

                    seq_rollback_table_w[j] = seq_w - rollback_amount[W_ROB_ADDR-1:0];
                    seq_p1_rollback_table_w[j] = seq_rollback_table_w[j] + 1;
                end
            end

            logic [W_ROLLBACK_TABLE-1:0] rollback_table_idx_w;
            assign rollback_table_idx_w = {is_stage_fail_w[I]};

            seq_t seq_next_w;
            always_comb begin
                if (is_stage_valid_r && is_warp_id_r == I) begin
                    seq_next_w = seq_p1_rollback_table_w[rollback_table_idx_w];
                end else begin
                    seq_next_w = seq_rollback_table_w[rollback_table_idx_w];
                end
            end

            assign is_seq_list_next_w[I] = seq_next_w;
        end
    endgenerate

    seq_t is_seq_w;
    assign is_seq_w = is_seq_list_r[is_warp_id_r];

    always_ff @( posedge clk ) begin
        for (int i = 0; i < N_WARPS; i++) begin
            if (!rst_n) begin
                is_seq_list_r[i] <= '0;
            end else begin
                is_seq_list_r[i] <= is_seq_list_next_w[i];
            end
        end
    end

    // - Branch/Jump

    // JAL redirects in register access. Its fall-through is fetched after the
    // jump, so it may already sit in fetch and/or decode for the jump's warp;
    // drop it wherever it is.
    assign id_delay_slot_w = (is_jump_w && id_warp_id_r == is_warp_id_r) ||
        (branch_complete_i && branch_type_i == BR_UNIFORM_ALL && id_warp_id_r == branch_warp_id_i);
    assign is_jump_addr_w = is_pc_r + is_instr_r.imm[RLEN-1:Z_PC];

    always_comb begin
        is_jump_w = 'x;
        is_branching_w = 'x;
        if (is_stage_valid_r) begin
            unique case (is_instr_r.bj_type)
                BJ_TYPE_NONE: begin is_jump_w = 0; is_branching_w = 0; end
                BJ_TYPE_JAL:  begin is_jump_w = 1; is_branching_w = 0; end
                BJ_TYPE_BEQ:  begin is_jump_w = 0; is_branching_w = 1; end
                BJ_TYPE_BNE:  begin is_jump_w = 0; is_branching_w = 1; end
                BJ_TYPE_BLT:  begin is_jump_w = 0; is_branching_w = 1; end
                BJ_TYPE_BGE:  begin is_jump_w = 0; is_branching_w = 1; end
                BJ_TYPE_BLTU: begin is_jump_w = 0; is_branching_w = 1; end
                BJ_TYPE_BGEU: begin is_jump_w = 0; is_branching_w = 1; end
            endcase
        end else begin
            is_jump_w = 0;
            is_branching_w = 0;
        end
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            branching_r <= '0;
        end else begin
            // branching_r is per-warp: update each warp's bit independently, so
            // that a branch issuing in register access for one warp and a branch
            // resolving for another warp in the same cycle are both honoured.
            for (int w = 0; w < N_WARPS; w++) begin
                if (is_branching_w && is_warp_id_r == warp_id_t'(w)) begin
                    branching_r[w] <= 1'b1;   // a branch is now in register access for warp w
                end else if (branch_complete_i && branch_warp_id_i == warp_id_t'(w)) begin
                    branching_r[w] <= 1'b0;   // warp w's branch resolved
                end
            end
        end
    end

    // - Register Scoreboard

    assign sb_warp_id_o = is_warp_id_r;

    // -- Check

    assign sb_chk1_idx_o = is_instr_r.rs1_idx;
    assign sb_chk1_regfile_o = is_instr_r.rs1_regfile;
    assign sb_chk1_en_o = is_stage_valid_r &&
        is_instr_r.rs1_used &&
        !(is_instr_r.rs1_idx == 0 && is_instr_r.rs1_regfile == REGFILE_SEL_I);

    assign sb_chk2_idx_o = is_instr_r.rs2_idx;
    assign sb_chk2_regfile_o = is_instr_r.rs2_regfile;
    assign sb_chk2_en_o = is_stage_valid_r &&
        is_instr_r.rs2_used &&
        !(is_instr_r.rs2_idx == 0 && is_instr_r.rs2_regfile == REGFILE_SEL_I);

    assign sb_chk3_idx_o = is_instr_r.rs3_idx;
    assign sb_chk3_regfile_o = is_instr_r.rs3_regfile;
    assign sb_chk3_en_o = is_stage_valid_r &&
        is_instr_r.rs3_used &&
        !(is_instr_r.rs3_idx == 0 && is_instr_r.rs3_regfile == REGFILE_SEL_I);

    assign is_sb_busy_w = sb_chk1_busy_i ||
        sb_chk2_busy_i ||
        sb_chk3_busy_i;

    // -- Acquire

    assign sb_acq_idx_o = is_instr_r.rd_idx;
    assign sb_acq_regfile_o = is_instr_r.rd_regfile;
    assign sb_acq_seq_o = is_seq_w;
    assign sb_acq_en_o = is_stage_valid_r &&
        !is_sb_busy_w &&
        is_instr_r.rd_used &&
        !(is_instr_r.rd_idx == 0 && is_instr_r.rd_regfile == REGFILE_SEL_I);

    // - Hazards Scoreboard

    assign hsb_warp_id_o = is_warp_id_r;

    // -- Check

    hazard_mask_t is_checked_hazards_w;
    always_comb begin
        is_checked_hazards_w = '0;
        for (int i = 0; i < N_HAZARDS; i++) begin
            unique case(is_instr_r.hazards[i])
                HAZARDS_IGN: is_checked_hazards_w[i] = 0;
                HAZARDS_AQ: is_checked_hazards_w[i] = 0;
                HAZARDS_CK: is_checked_hazards_w[i] = 1;
                HAZARDS_CKAQ: is_checked_hazards_w[i] = 1;
            endcase
        end
    end

    hazard_mask_t is_busy_hazards_w;
    assign is_busy_hazards_w = is_checked_hazards_w & hsb_busy_i;
    assign is_hsb_busy_w = is_stage_valid_r && |is_busy_hazards_w;

    // -- Acquire

    logic hsb_acq_valid_w;
    assign hsb_acq_valid_w = !is_hsb_busy_w;

    always_comb begin
        hsb_acq_mask_o = '0;
        if (is_stage_valid_r) begin
            for (int i = 0; i < N_HAZARDS; i++) begin
                unique case(is_instr_r.hazards[i])
                    HAZARDS_IGN: hsb_acq_mask_o[i] = 0;
                    HAZARDS_AQ: hsb_acq_mask_o[i] = hsb_acq_valid_w;
                    HAZARDS_CK: hsb_acq_mask_o[i] = 0;
                    HAZARDS_CKAQ: hsb_acq_mask_o[i] = hsb_acq_valid_w;
                endcase
            end
        end
    end

    assign hsb_acq_seq_o = is_seq_w;

    // - Output to Middle-end

    always_comb begin
        me_valid_o = '0;
        me_valid_o[is_warp_id_r] = is_stage_valid_r && !is_sb_busy_w && !is_hsb_busy_w;
    end

    assign me_op_o = '{
        seq: is_seq_w,
        instr: is_instr_r,
        pc: is_pc_r,
        mask: is_mask_r
    };

endmodule

`default_nettype wire
