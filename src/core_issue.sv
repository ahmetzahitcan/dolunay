`default_nettype none

module core_issue
    import params_pkg::*;
    import control_unit_pkg::*;
    import fu_pkg::*;
# (
    parameter int IROM_SIZE,
    localparam int W_IROM_ADDR = $clog2(IROM_SIZE)
) (
    input wire logic clk,
    input wire logic rst_n,

    input wire logic [N_FUNCTION_UNITS-1:0] fu_in_ready_i,
    output logic [N_FUNCTION_UNITS-1:0] fu_in_valid_o,
    output operation_s fu_in_operation_o,

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

    // TODO: Think of Sequence number
    output reg_id_t sb_acq_idx_o,
    output regfile_sel_e sb_acq_regfile_o,
    output logic sb_acq_en_o
);

    // Pipeline control

    logic dp_no_in_handshake_w;
    logic dp_sb_busy_w;

    logic pipeline_issue_stall_w;
    assign pipeline_issue_stall_w = dp_no_in_handshake_w || dp_sb_busy_w;

    // Stage valid registers -- indicating whether other pipeline registers are valid

    logic ws_stage_valid_r;
    logic if_stage_valid_r;
    logic id_stage_valid_r;
    logic dp_stage_valid_r;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            ws_stage_valid_r <= '0;
            if_stage_valid_r <= '0;
            id_stage_valid_r <= '0;
            dp_stage_valid_r <= '0;
        end else begin
            if (!pipeline_issue_stall_w) begin
                ws_stage_valid_r <= '1;
                if_stage_valid_r <= ws_stage_valid_r;
                id_stage_valid_r <= if_stage_valid_r;
                dp_stage_valid_r <= id_stage_valid_r;
            end
        end
    end

    // Cross-stage signals

    // - Fetch stage signals
    warp_id_t if_warp_id_r;

    // - Decode stage signals
    pc_t id_pc_r;
    simd_mask_t id_mask_r;
    logic [31:2] id_undec_instr32_w;
    warp_id_t id_warp_id_r;

    // - Dispatch stage signals
    simd_data_t dp_rs1_data_w;
    simd_data_t dp_rs2_data_w;
    simd_data_t dp_rs3_data_w;
    simd_mask_t dp_mask_r;
    instr_s dp_instr_r;
    warp_id_t dp_warp_id_r;
    pc_t dp_pc_r;

    // Warp Select
    warp_id_t ws_warp_id_w;
    warp_id_t ws_warp_id_r;

    warp_scheduler u_warp_scheduler(
        .clk(clk),
        .rst_n(rst_n),
        .stall_i(pipeline_issue_stall_w),
        .warp_id_o(ws_warp_id_w)
    );

    always_ff @( posedge clk ) begin
        if (!pipeline_issue_stall_w) begin
            ws_warp_id_r <= ws_warp_id_w;
            if_warp_id_r <= ws_warp_id_r;
        end
    end

    // Fetch
    logic [N_WARPS-1:0][RLEN-1:Z_PC] u_thread_scheduler_pc_w;
    logic [N_WARPS-1:0][N_THREADS-1:0] u_thread_scheduler_mask_w;

    logic [RLEN-1:Z_PC] if_pc_w;
    logic [N_THREADS-1:0] if_mask_w;

    assign if_pc_w = u_thread_scheduler_pc_w[if_warp_id_r];
    assign if_mask_w = u_thread_scheduler_mask_w[if_warp_id_r];

    // - Thread Schedulers
    generate
        for (genvar I = 0; I < N_WARPS; I++) begin : gen_thread_schedulers
            thread_scheduler u_thread_scheduler(
                .clk(clk),
                .rst_n(rst_n), // FIXME: start_i

                .instr_completed_i(),
                .instr_replay_mask_i(),

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

                .pc_o(u_thread_scheduler_pc_w[I]),
                .mask_o(u_thread_scheduler_mask_w[I])
            );
        end
    endgenerate

    // - Instruction Memory

    assign instr_addr_o = if_pc_w[W_IROM_ADDR-1:Z_PC];
    assign id_undec_instr32_w = undec_instr32_i[31:2];

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        if (!pipeline_issue_stall_w) begin
            id_pc_r <= if_pc_w;
            id_mask_r <= if_mask_w;
            id_warp_id_r <= if_warp_id_r;
        end
    end

    // Decode

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

    // - Register File Access

    assign rf_read_warp_id_o = id_warp_id_r;

    assign rf_rs1_idx_o = id_instr_w.rs1_idx;
    assign rf_rs1_regfile_o = id_instr_w.rs1_regfile;
    assign dp_rs1_data_w = rf_rs1_data_i;

    assign rf_rs2_idx_o = id_instr_w.rs2_idx;
    assign rf_rs2_regfile_o = id_instr_w.rs2_regfile;
    assign dp_rs2_data_w = rf_rs2_data_i;

    assign rf_rs3_idx_o = id_instr_w.rs3_idx;
    assign rf_rs3_regfile_o = id_instr_w.rs3_regfile;
    assign dp_rs3_data_w = rf_rs3_data_i;

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        if (!pipeline_issue_stall_w) begin
            dp_instr_r <= id_instr_w;
            dp_warp_id_r <= id_warp_id_r;
            dp_pc_r <= id_pc_r;
            dp_mask_r <= id_mask_r;
        end
    end

    // Dispatch

    // - Scoreboard access

    assign sb_warp_id_o = dp_warp_id_r;

    assign sb_chk1_idx_o = dp_instr_r.rs1_idx;
    assign sb_chk1_regfile_o = dp_instr_r.rs1_regfile;
    assign sb_chk1_en_o = dp_instr_r.rs1_used;

    assign sb_chk2_idx_o = dp_instr_r.rs2_idx;
    assign sb_chk2_regfile_o = dp_instr_r.rs2_regfile;
    assign sb_chk2_en_o = dp_instr_r.rs2_used;

    assign sb_chk3_idx_o = dp_instr_r.rs3_idx;
    assign sb_chk3_regfile_o = dp_instr_r.rs3_regfile;
    assign sb_chk3_en_o = dp_instr_r.rs3_used;

    assign dp_sb_busy_w = sb_chk1_busy_i || sb_chk2_busy_i || sb_chk3_busy_i;

    // -- Operation

    operation_s dp_operation_w;
    assign dp_operation_w = '{
        warp_id: dp_warp_id_r,
        instr: dp_instr_r,
        rs1_data: dp_rs1_data_w,
        rs2_data: dp_rs2_data_w,
        rs3_data: dp_rs3_data_w,
        pc: dp_pc_r
    };

    assign fu_in_operation_o = dp_operation_w;

    // -- Handshake

    logic [N_FUNCTION_UNITS-1:0] fu_in_valid_w;
    logic [N_FUNCTION_UNITS-1:0] fu_in_ready_w;
    logic [N_FUNCTION_UNITS-1:0] fu_in_handshake_w;
    assign fu_in_handshake_w = fu_in_valid_w & fu_in_ready_w;
    assign dp_no_in_handshake_w = ~|fu_in_handshake_w;

    always_comb begin
        fu_in_valid_w = '0;
        fu_in_valid_w[dp_instr_r.fu_sel] = '1;
    end

    assign fu_in_ready_w = fu_in_ready_i;
    assign fu_in_valid_o = fu_in_valid_w;

endmodule

`default_nettype wire
