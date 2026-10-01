`default_nettype none

/*
    Front-end of the core. Responsible for instruction issuing.
    - In-order issue
    - No register renaming
    - Reads register file
    - Scoreboard to keep track of hazards
    - Can acquire scoreboard entries, but release must be done by the back-end.

    TODO: Add support for branching and ITS features.
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

    input wire logic [N_FUNCTION_UNITS-1:0] fu_in_ready_i,
    output logic [N_FUNCTION_UNITS-1:0] fu_in_valid_o,
    output fu_operation_s fu_in_operation_o,

    // IROM Interface
    output logic [W_IROM_ADDR-1:Z_PC] instr_addr_o,
    input wire logic [RLEN-1:0] undec_instr32_i,

    // Register File Interface
    output warp_id_t rf_read_warp_id_o,

    output reg_id_t rf_rs1_idx_o,
    output regfile_sel_e rf_rs1_regfile_o,
    input wire simd_data_t rf_rs1_data_i,

    output reg_id_t rf_rs2_idx_o,
    output regfile_sel_e rf_rs2_regfile_o,
    input wire simd_data_t rf_rs2_data_i,

    output reg_id_t rf_rs3_idx_o,
    output regfile_sel_e rf_rs3_regfile_o,
    input wire simd_data_t rf_rs3_data_i,

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
    output seq_t hsb_acq_seq_o
);

    // Pipeline control
    logic dp_in_handshake_w;
    logic ra_sb_busy_w, ra_hsb_busy_w;
    logic if_delay_slot;

    // - Indicate whether a stage contains a valid instruction.
    logic if_stage_valid_r, id_stage_valid_r, ra_stage_valid_r, dp_stage_valid_r;

    // - Indicate whether a stage should stall. These stages will send bubbles to the next stages.
    logic ws_stage_stall_w, if_stage_stall_w, id_stage_stall_w, ra_stage_stall_w, dp_stage_stall_w;

    assign ws_stage_stall_w = if_stage_stall_w;
    assign if_stage_stall_w = id_stage_stall_w;
    assign id_stage_stall_w = ra_stage_stall_w;
    assign ra_stage_stall_w = dp_stage_stall_w || (ra_stage_valid_r && (ra_sb_busy_w || ra_hsb_busy_w));
    assign dp_stage_stall_w = dp_stage_valid_r && !dp_in_handshake_w;

    // - Indicate whether a stage should be flushed. For each flushed stage, in the next cycle, NEXT stage will contain a bubble.
    logic ws_stage_flush_w, if_stage_flush_w, id_stage_flush_w, ra_stage_flush_w;

    assign ws_stage_flush_w = '0;
    assign if_stage_flush_w = if_delay_slot;
    assign id_stage_flush_w = '0;
    assign ra_stage_flush_w = '0;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            if_stage_valid_r <= '0;
            id_stage_valid_r <= '0;
            ra_stage_valid_r <= '0;
            dp_stage_valid_r <= '0;
        end else begin
            if (!if_stage_stall_w) if_stage_valid_r <= !ws_stage_stall_w & !ws_stage_flush_w;
            if (!id_stage_stall_w) id_stage_valid_r <= if_stage_valid_r & !if_stage_stall_w & !if_stage_flush_w;
            if (!ra_stage_stall_w) ra_stage_valid_r <= id_stage_valid_r & !id_stage_stall_w & !id_stage_flush_w;
            if (!dp_stage_stall_w) dp_stage_valid_r <= ra_stage_valid_r & !ra_stage_stall_w & !ra_stage_flush_w;
        end
    end

    // Cross-stage signals

    // - Instruction Fetch stage signals
    warp_id_t if_warp_id_r;

    // - Instruction Decode stage signals
    pc_t id_jump_addr_w;
    logic id_jump_w;
    pc_t id_pc_r;
    simd_mask_t id_mask_r;
    logic [31:2] id_undec_instr32_w;
    warp_id_t id_warp_id_r;

    // - Register Access stage signals
    pc_t ra_pc_r;
    simd_mask_t ra_mask_r;
    instr_s ra_instr_r;
    warp_id_t ra_warp_id_r;

    // - Dispatch stage signals
    simd_data_t dp_rs1_data_w;
    simd_data_t dp_rs2_data_w;
    simd_data_t dp_rs3_data_w;
    simd_mask_t dp_mask_r;
    seq_t dp_seq_r;
    instr_s dp_instr_r;
    warp_id_t dp_warp_id_r;
    pc_t dp_pc_r;

    // Warp Select
    warp_id_t ws_warp_id_w;

    warp_scheduler u_warp_scheduler(
        .clk(clk),
        .rst_n(rst_n),
        .stall_i(ws_stage_stall_w),
        .warp_id_o(ws_warp_id_w)
    );

    always_ff @( posedge clk ) begin
        if (!if_stage_stall_w) begin
            if_warp_id_r <= ws_warp_id_w;
        end
    end

    // Instruction Fetch
    pc_t [N_WARPS-1:0] u_thread_scheduler_pc_w;
    simd_mask_t [N_WARPS-1:0] u_thread_scheduler_mask_w;

    pc_t if_pc_w;
    simd_mask_t if_mask_w;

    assign if_pc_w = u_thread_scheduler_pc_w[if_warp_id_r];
    assign if_mask_w = u_thread_scheduler_mask_w[if_warp_id_r];

    pc_t if_pc_p1_w;
    assign if_pc_p1_w = if_pc_w + 1;

    assign if_delay_slot = id_jump_w && (if_warp_id_r == id_warp_id_r);

    // - Thread Schedulers
    generate
        for (genvar I = 0; I < N_WARPS; I++) begin : gen_thread_schedulers
            pc_t pc_w;
            simd_mask_t mask_w;

            assign u_thread_scheduler_pc_w[I] = pc_w;
            assign u_thread_scheduler_mask_w[I] = mask_w;

            thread_scheduler u_thread_scheduler(
                .clk(clk),
                .rst_n(rst_n), // FIXME: start_i
                .en(if_stage_valid_r && !if_stage_stall_w && (if_warp_id_r == I)),

                // INFO: Hazards are now managed by the scoreboard. Therefore, increase so long as there is no branch/jump.
                .pc_next_i(id_jump_w ? id_jump_addr_w : if_pc_p1_w),
                .yield_i(),

                .barr_sync_i(),
                .barr_sync_total_o(),
                .barr_sync_parked_next_o(),
                .barr_sync_release_o(), // Not needed

                .barr_load_i(),
                .barr_load_total_i(),
                .barr_load_parked_i(),

                .branch_i(),
                .pc_branch_i(),
                .mask_branch_i(),

                .pc_o(pc_w),
                .mask_o(mask_w)
            );
        end
    endgenerate

    // - Instruction Memory

    assign instr_addr_o = if_pc_w[W_IROM_ADDR-1:Z_PC];

    logic [31:0] undec_instr32_skid_r;

    logic id_stage_stall_skid_r;
    always_ff @(posedge clk) begin
        if (!rst_n) id_stage_stall_skid_r <= 1'b0;
        else        id_stage_stall_skid_r <= id_stage_stall_w;
    end

    always_ff @(posedge clk) begin
        if (!id_stage_stall_skid_r)      // capture the correct word at stall onset
            undec_instr32_skid_r <= undec_instr32_i;
    end

    assign id_undec_instr32_w = id_stage_stall_skid_r
                           ? undec_instr32_skid_r[31:2]
                           : undec_instr32_i[31:2];      // first stalled cycle still uses the live word


    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        if (!id_stage_stall_w) begin
            id_pc_r <= if_pc_w;
            id_mask_r <= if_mask_w;
            id_warp_id_r <= if_warp_id_r;
        end
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

    // - Branch/Jump

    assign id_jump_addr_w = id_pc_r + id_instr_w.imm[RLEN-1:Z_PC];
    always_comb begin
        id_jump_w = 'x;
        if (id_stage_valid_r) begin
            unique case (id_instr_w.bj_type)
                BJ_TYPE_NONE: id_jump_w = 0;
                BJ_TYPE_JAL: id_jump_w = 1;
            endcase
        end else begin
            id_jump_w = 0;
        end
    end

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        if (!ra_stage_stall_w) begin
            ra_pc_r <= id_pc_r;
            ra_mask_r <= id_mask_r;
            ra_warp_id_r <= id_warp_id_r;
            ra_instr_r <= id_instr_w;
        end
    end

    // Register Access

    // - Sequence generation

    seq_t ra_seq_list_r [0:N_WARPS-1];
    seq_t ra_seq_w;
    assign ra_seq_w = ra_seq_list_r[id_warp_id_r];

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            for (int i = 0; i < N_WARPS; i++) begin
                ra_seq_list_r[i] <= '0;
            end
        end else if (ra_stage_valid_r && !ra_stage_stall_w) begin
            ra_seq_list_r[id_warp_id_r] <= ra_seq_w + 1;
        end
    end

    // - Register File Access

    assign rf_read_warp_id_o = ra_warp_id_r;

    assign rf_rs1_idx_o = ra_instr_r.rs1_idx;
    assign rf_rs1_regfile_o = ra_instr_r.rs1_regfile;

    assign rf_rs2_idx_o = ra_instr_r.rs2_idx;
    assign rf_rs2_regfile_o = ra_instr_r.rs2_regfile;

    assign rf_rs3_idx_o = ra_instr_r.rs3_idx;
    assign rf_rs3_regfile_o = ra_instr_r.rs3_regfile;

    simd_data_t dp_rs1_data_skid_r, dp_rs2_data_skid_r, dp_rs3_data_skid_r;
    logic       dp_stage_stall_skid_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            dp_stage_stall_skid_r <= 1'b0;
        end else begin
            dp_stage_stall_skid_r <= dp_stage_stall_w;
            if (!dp_stage_stall_skid_r) begin
                dp_rs1_data_skid_r <= rf_rs1_data_i;
                dp_rs2_data_skid_r <= rf_rs2_data_i;
                dp_rs3_data_skid_r <= rf_rs3_data_i;
            end
        end
    end

    assign dp_rs1_data_w = dp_stage_stall_skid_r ? dp_rs1_data_skid_r : rf_rs1_data_i;
    assign dp_rs2_data_w = dp_stage_stall_skid_r ? dp_rs2_data_skid_r : rf_rs2_data_i;
    assign dp_rs3_data_w = dp_stage_stall_skid_r ? dp_rs3_data_skid_r : rf_rs3_data_i;

    // - Register Scoreboard

    assign sb_warp_id_o = ra_warp_id_r;

    // -- Check

    assign sb_chk1_idx_o = ra_instr_r.rs1_idx;
    assign sb_chk1_regfile_o = ra_instr_r.rs1_regfile;
    assign sb_chk1_en_o = ra_stage_valid_r &&
        ra_instr_r.rs1_used &&
        !(ra_instr_r.rs1_idx == 0 && ra_instr_r.rs1_regfile == REGFILE_SEL_I);

    assign sb_chk2_idx_o = ra_instr_r.rs2_idx;
    assign sb_chk2_regfile_o = ra_instr_r.rs2_regfile;
    assign sb_chk2_en_o = ra_stage_valid_r &&
        ra_instr_r.rs2_used &&
        !(ra_instr_r.rs2_idx == 0 && ra_instr_r.rs2_regfile == REGFILE_SEL_I);

    assign sb_chk3_idx_o = ra_instr_r.rs3_idx;
    assign sb_chk3_regfile_o = ra_instr_r.rs3_regfile;
    assign sb_chk3_en_o = ra_stage_valid_r &&
        ra_instr_r.rs3_used &&
        !(ra_instr_r.rs3_idx == 0 && ra_instr_r.rs3_regfile == REGFILE_SEL_I);

    assign ra_sb_busy_w = sb_chk1_busy_i ||
        sb_chk2_busy_i ||
        sb_chk3_busy_i;

    // -- Acquire

    assign sb_acq_idx_o = ra_instr_r.rd_idx;
    assign sb_acq_regfile_o = ra_instr_r.rd_regfile;
    assign sb_acq_seq_o = ra_seq_w;
    assign sb_acq_en_o = ra_stage_valid_r &&
        !ra_sb_busy_w &&
        ra_instr_r.rd_used &&
        !(ra_instr_r.rd_idx == 0 && ra_instr_r.rd_regfile == REGFILE_SEL_I);

    // - Hazards Scoreboard

    assign hsb_warp_id_o = ra_warp_id_r;

    // -- Check

    hazard_mask_t ra_checked_hazards_w;
    always_comb begin
        ra_checked_hazards_w = '0;
        for (int i = 0; i < N_HAZARDS; i++) begin
            unique case(ra_instr_r.hazards[i])
                HAZARDS_IGN: ra_checked_hazards_w[i] = 0;
                HAZARDS_AQ: ra_checked_hazards_w[i] = 0;
                HAZARDS_CK: ra_checked_hazards_w[i] = 1;
                HAZARDS_CKAQ: ra_checked_hazards_w[i] = 1;
            endcase
        end
    end

    hazard_mask_t ra_busy_hazards_w;
    assign ra_busy_hazards_w = ra_checked_hazards_w & hsb_busy_i;
    assign ra_hsb_busy_w = ra_stage_valid_r && |ra_busy_hazards_w;

    // -- Acquire

    logic hsb_acq_valid_w;
    assign hsb_acq_valid_w = !ra_hsb_busy_w;

    always_comb begin
        hsb_acq_mask_o = '0;
        if (ra_stage_valid_r) begin
            for (int i = 0; i < N_HAZARDS; i++) begin
                unique case(ra_instr_r.hazards[i])
                    HAZARDS_IGN: hsb_acq_mask_o[i] = 0;
                    HAZARDS_AQ: hsb_acq_mask_o[i] = hsb_acq_valid_w;
                    HAZARDS_CK: hsb_acq_mask_o[i] = 0;
                    HAZARDS_CKAQ: hsb_acq_mask_o[i] = hsb_acq_valid_w;
                endcase
            end
        end
    end

    assign hsb_acq_seq_o = ra_seq_w;

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        if (!dp_stage_stall_w) begin
            dp_instr_r <= ra_instr_r;
            dp_warp_id_r <= ra_warp_id_r;
            dp_pc_r <= ra_pc_r;
            dp_mask_r <= ra_mask_r;
            dp_seq_r <= ra_seq_w;
        end
    end

    // Dispatch

    // - Operation

    fu_operation_s dp_operation_w;
    assign dp_operation_w = '{
        seq: dp_seq_r,
        mask: dp_mask_r,
        warp_id: dp_warp_id_r,
        instr: dp_instr_r,
        rs1_data: dp_rs1_data_w,
        rs2_data: dp_rs2_data_w,
        rs3_data: dp_rs3_data_w,
        pc: dp_pc_r
    };

    assign fu_in_operation_o = dp_operation_w;

    // - Handshake

    logic [N_FUNCTION_UNITS-1:0] fu_in_valid_w;
    logic [N_FUNCTION_UNITS-1:0] fu_in_ready_w;
    logic [N_FUNCTION_UNITS-1:0] fu_in_handshake_w;
    assign fu_in_handshake_w = fu_in_valid_w & fu_in_ready_w;
    assign dp_in_handshake_w = |fu_in_handshake_w;

    always_comb begin
        fu_in_valid_w = '0;
        if (dp_stage_valid_r) begin
            fu_in_valid_w[dp_instr_r.fu_sel] = '1;
        end
    end

    assign fu_in_ready_w = fu_in_ready_i;
    assign fu_in_valid_o = fu_in_valid_w;

endmodule

`default_nettype wire
