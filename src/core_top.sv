`default_nettype none

module core_top
    import params_pkg::*;
    import fu_pkg::*;
# (
    parameter int WRAM_SIZE,
    localparam int WRAM_DEPTH = WRAM_SIZE / ADDR_ALIGN,
    localparam int W_WRAM_ADDR = $clog2(WRAM_SIZE),

    parameter int IROM_SIZE,
    localparam int IROM_DEPTH = IROM_SIZE / ADDR_ALIGN,
    localparam int W_IROM_ADDR = $clog2(IROM_SIZE)
) (
    input wire logic clk,
    input wire logic rst_n,

    input wire logic start_i,
    output logic ready_o,

    // WRAM Interface
    output logic [W_WRAM_ADDR-1:Z_ADDR] wram_addr_o,
    output logic [RLEN-1:0] wram_wdata_o,
    output logic [ADDR_ALIGN-1:0] wram_wen_o,
    input wire logic [RLEN-1:0] wram_rdata_i,

    // IROM Interface A
    output logic [W_IROM_ADDR-1:Z_PC] irom_addr_a_o,
    input wire logic [RLEN-1:0] irom_data_a_i,

    // IROM Interface B
    output logic [W_IROM_ADDR-1:Z_PC] irom_addr_b_o,
    input wire logic [RLEN-1:0] irom_data_b_i
);
    logic [N_FUNCTION_UNITS-1:0] fu_in_ready_w;
    logic [N_FUNCTION_UNITS-1:0] fu_in_valid_w;
    fu_operation_s fu_in_operation_w;

    logic [N_FUNCTION_UNITS-1:0] fu_out_ready_w;
    logic [N_FUNCTION_UNITS-1:0] fu_out_valid_w;

    // HPMs
    /*
    logic [N_WARPS-1:0] winst_retired_w;
    logic [N_WARPS-1:0][N_THREADS-1:0] inst_retired_w;
    logic [63:0] cycletime_w;
    logic [N_WARPS-1:0][N_THREADS-1:0][63:0] instret_w;
    logic [N_WARPS-1:0][63:0] wtinstret_w;
    logic [N_WARPS-1:0][63:0] wuinstret_w;
    hpms u_hpms(
        .clk(clk),
        .rst_n(rst_n & ~start_i),
        .winst_retired_i(winst_retired_w),
        .inst_retired_i(inst_retired_w),
        .cycletime_o(cycletime_w),
        .instret_o(instret_w),
        .wtinstret_o(wtinstret_w),
        .wuinstret_o(wuinstret_w)
    );
    */

    // - Scoreboard

    warp_id_t sb_issue_warp_id_w;
    warp_id_t sb_commit_warp_id_w;

    reg_id_t sb_chk1_idx_w;
    regfile_sel_e sb_chk1_regfile_w;
    logic sb_chk1_en_w;
    logic sb_chk1_busy_w;

    reg_id_t sb_chk2_idx_w;
    regfile_sel_e sb_chk2_regfile_w;
    logic sb_chk2_en_w;
    logic sb_chk2_busy_w;

    reg_id_t sb_chk3_idx_w;
    regfile_sel_e sb_chk3_regfile_w;
    logic sb_chk3_en_w;
    logic sb_chk3_busy_w;

    reg_id_t sb_acq_idx_w;
    regfile_sel_e sb_acq_regfile_w;
    seq_t sb_acq_seq_w;
    logic sb_acq_en_w;

    reg_id_t sb_rel_idx_w;
    regfile_sel_e sb_rel_regfile_w;
    seq_t sb_rel_seq_w;
    logic sb_rel_en_w;
    logic sb_rel_valid_w;

    scoreboard u_scoreboard (
        .clk(clk),
        .rst_n(rst_n),

        .issue_warp_id_i(sb_issue_warp_id_w),
        .commit_warp_id_i(sb_commit_warp_id_w),

        .chk1_idx_i(sb_chk1_idx_w),
        .chk1_regfile_i(sb_chk1_regfile_w),
        .chk1_en_i(sb_chk1_en_w),
        .chk1_busy_o(sb_chk1_busy_w),

        .chk2_idx_i(sb_chk2_idx_w),
        .chk2_regfile_i(sb_chk2_regfile_w),
        .chk2_en_i(sb_chk2_en_w),
        .chk2_busy_o(sb_chk2_busy_w),

        .chk3_idx_i(sb_chk3_idx_w),
        .chk3_regfile_i(sb_chk3_regfile_w),
        .chk3_en_i(sb_chk3_en_w),
        .chk3_busy_o(sb_chk3_busy_w),

        .acq_idx_i(sb_acq_idx_w),
        .acq_regfile_i(sb_acq_regfile_w),
        .acq_seq_i(sb_acq_seq_w),
        .acq_en_i(sb_acq_en_w),

        .rel_idx_i(sb_rel_idx_w),
        .rel_regfile_i(sb_rel_regfile_w),
        .rel_seq_i(sb_rel_seq_w),
        .rel_en_i(sb_rel_en_w),
        .rel_valid_o(sb_rel_valid_w)
    );

    // - Register File

    warp_id_t rf_read_warp_id_w;

    reg_id_t rf_rs1_idx_w;
    regfile_sel_e rf_rs1_regfile_w;
    simd_data_t rf_rs1_data_w;

    reg_id_t rf_rs2_idx_w;
    regfile_sel_e rf_rs2_regfile_w;
    simd_data_t rf_rs2_data_w;

    reg_id_t rf_rs3_idx_w;
    regfile_sel_e rf_rs3_regfile_w;
    simd_data_t rf_rs3_data_w;

    warp_id_t rf_write_warp_id_w;
    reg_id_t rf_rd_idx_w;
    regfile_sel_e rf_rd_regfile_w;
    simd_data_t rf_write_data_w;
    simd_mask_t rf_write_en_mask_w;

    register_file u_register_file(
        .clk(clk),

        .read_warp_id_i(rf_read_warp_id_w),

        .rs1_idx_i(rf_rs1_idx_w),
        .rs1_regfile_i(rf_rs1_regfile_w),
        .rs1_data_o(rf_rs1_data_w),

        .rs2_idx_i(rf_rs2_idx_w),
        .rs2_regfile_i(rf_rs2_regfile_w),
        .rs2_data_o(rf_rs2_data_w),

        .rs3_idx_i(rf_rs3_idx_w),
        .rs3_regfile_i(rf_rs3_regfile_w),
        .rs3_data_o(rf_rs3_data_w),

        .write_warp_id_i(rf_write_warp_id_w),
        .write_en_mask_i(rf_write_en_mask_w),
        .rd_idx_i(rf_rd_idx_w),
        .rd_regfile_i(rf_rd_regfile_w),
        .write_data_i(rf_write_data_w)
    );

    // - Front-end

    core_frontend #(
        .IROM_SIZE(IROM_SIZE)
    ) u_core_frontend (
        .clk(clk),
        .rst_n(rst_n),
        .fu_in_ready_i(fu_in_ready_w),
        .fu_in_valid_o(fu_in_valid_w),
        .fu_in_operation_o(fu_in_operation_w),
        .instr_addr_o(irom_addr_a_o),
        .undec_instr32_i(irom_data_a_i),

        .rf_read_warp_id_o(rf_read_warp_id_w),
        .rf_rs1_idx_o(rf_rs1_idx_w),
        .rf_rs1_regfile_o(rf_rs1_regfile_w),
        .rf_rs1_data_i(rf_rs1_data_w),
        .rf_rs2_idx_o(rf_rs2_idx_w),
        .rf_rs2_regfile_o(rf_rs2_regfile_w),
        .rf_rs2_data_i(rf_rs2_data_w),
        .rf_rs3_idx_o(rf_rs3_idx_w),
        .rf_rs3_regfile_o(rf_rs3_regfile_w),
        .rf_rs3_data_i(rf_rs3_data_w),

        .sb_warp_id_o(sb_issue_warp_id_w),

        .sb_chk1_idx_o(sb_chk1_idx_w),
        .sb_chk1_regfile_o(sb_chk1_regfile_w),
        .sb_chk1_en_o(sb_chk1_en_w),
        .sb_chk1_busy_i(sb_chk1_busy_w),
        .sb_chk2_idx_o(sb_chk2_idx_w),
        .sb_chk2_regfile_o(sb_chk2_regfile_w),
        .sb_chk2_en_o(sb_chk2_en_w),
        .sb_chk2_busy_i(sb_chk2_busy_w),
        .sb_chk3_idx_o(sb_chk3_idx_w),
        .sb_chk3_regfile_o(sb_chk3_regfile_w),
        .sb_chk3_en_o(sb_chk3_en_w),
        .sb_chk3_busy_i(sb_chk3_busy_w),

        .sb_acq_idx_o(sb_acq_idx_w),
        .sb_acq_regfile_o(sb_acq_regfile_w),
        .sb_acq_seq_o(sb_acq_seq_w),
        .sb_acq_en_o(sb_acq_en_w)
    );

    // - Function Units

    fu_result_s fu_result_w [0:N_FUNCTION_UNITS-1];

    fu_multialu u_multialu (
    	.clk            (clk),
    	.rst_n          (rst_n),
    	.in_valid_i     (fu_in_valid_w[FUNCTION_UNIT_ALU]),
    	.in_ready_o     (fu_in_ready_w[FUNCTION_UNIT_ALU]),
    	.out_valid_o    (fu_out_valid_w[FUNCTION_UNIT_ALU]),
    	.out_ready_i    (fu_out_ready_w[FUNCTION_UNIT_ALU]),
    	.in_operation_i (fu_in_operation_w),
        .out_result_o   (fu_result_w[FUNCTION_UNIT_ALU])
    );

    fu_fpnew u_fpnew (
    	.clk            (clk),
    	.rst_n          (rst_n),
    	.in_valid_i     (fu_in_valid_w[FUNCTION_UNIT_FPU]),
    	.in_ready_o     (fu_in_ready_w[FUNCTION_UNIT_FPU]),
    	.out_valid_o    (fu_out_valid_w[FUNCTION_UNIT_FPU]),
    	.out_ready_i    (fu_out_ready_w[FUNCTION_UNIT_FPU]),
    	.in_operation_i (fu_in_operation_w),
        .out_result_o   (fu_result_w[FUNCTION_UNIT_FPU])
    );

    // - Back-end

    core_backend u_core_backend (
    	.clk               (clk),
    	.rst_n             (rst_n),
    	.fu_out_valid_i    (fu_out_valid_w),
    	.fu_out_ready_o    (fu_out_ready_w),
    	.fu_out_result_i   (fu_result_w),
    	.sb_warp_id_o      (sb_commit_warp_id_w),
    	.sb_rel_idx_o      (sb_rel_idx_w),
    	.sb_rel_regfile_o  (sb_rel_regfile_w),
    	.sb_rel_seq_o      (sb_rel_seq_w),
    	.sb_rel_en_o       (sb_rel_en_w),
    	.sb_rel_valid_i    (sb_rel_valid_w),
        .rf_warp_id_o      (rf_write_warp_id_w),
    	.rf_write_en_mask_o(rf_write_en_mask_w),
    	.rf_rd_idx_o       (rf_rd_idx_w),
    	.rf_rd_regfile_o   (rf_rd_regfile_w),
    	.rf_write_data_o   (rf_write_data_w)
    );

endmodule

`default_nettype wire
