`default_nettype none

module core_top
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
# (
    parameter int WRAM_SIZE = 65536,
    localparam int WRAM_DEPTH = WRAM_SIZE / ADDR_ALIGN,
    localparam int W_WRAM_ADDR = $clog2(WRAM_SIZE),

    parameter int IROM_SIZE = 65536,
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

    // - Special Hazards Scoreboard

    warp_id_t hsb_frontend_warp_id_w;
    warp_id_t hsb_backend_warp_id_w;

    hazard_mask_t hsb_busy_w;

    hazard_mask_t hsb_acq_mask_w;
    seq_t hsb_acq_seq_w;

    hazard_mask_t hsb_acq_old_busy_w;
    seq_t hsb_acq_old_seq_w [0:N_HAZARDS-1];

    warp_id_t hsb_dacq_warp_id_w;
    hazard_mask_t hsb_dacq_mask_w;
    seq_t hsb_dacq_seq_w [0:N_HAZARDS-1];
    hazard_mask_t hsb_dacq_empty_w;

    hazard_mask_t hsb_rel_mask_w;
    seq_t hsb_rel_seq_w;
    hazard_mask_t hsb_rel_valid_w;

    scoreboard_mask #(
        .N_GROUPS(N_WARPS),
        .N_ENTRIES(N_HAZARDS)
     ) u_haz_scoreboard (
    	.clk               (clk),
    	.rst_n             (rst_n),
    	.busy_group_id_i   (hsb_frontend_warp_id_w),
    	.busy_o            (hsb_busy_w),
        .acq_group_id_i    (hsb_frontend_warp_id_w),
    	.acq_mask_i        (hsb_acq_mask_w),
    	.acq_seq_i         (hsb_acq_seq_w),
        .acq_old_busy_o    (hsb_acq_old_busy_w),
        .acq_old_seq_o     (hsb_acq_old_seq_w),
        .dacq_group_id_i   (hsb_dacq_warp_id_w),
        .dacq_mask_i       (hsb_dacq_mask_w),
        .dacq_seq_i        (hsb_dacq_seq_w),
        .dacq_empty_i      (hsb_dacq_empty_w),
        .rel_group_id_i    (hsb_backend_warp_id_w),
    	.rel_mask_i        (hsb_rel_mask_w),
    	.rel_seq_i         (hsb_rel_seq_w),
    	.rel_valid_o       (hsb_rel_valid_w)
    );

    // - Registers Scoreboard

    warp_id_t sb_frontend_warp_id_w;
    warp_id_t sb_frontend_dacq_warp_id_w;
    warp_id_t sb_backend_warp_id_w;

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
    seq_t sb_acq_old_seq_w;
    logic sb_acq_old_busy_w;

    reg_id_t sb_dacq_idx_w;
    regfile_sel_e sb_dacq_regfile_w;
    seq_t sb_dacq_seq_w;
    logic sb_dacq_en_w;
    logic sb_dacq_empty_w;

    reg_id_t sb_rel_idx_w;
    regfile_sel_e sb_rel_regfile_w;
    seq_t sb_rel_seq_w;
    logic sb_rel_en_w;
    logic sb_rel_valid_w;

    logic sb_rel_valid_list_w [0:0];
    assign sb_rel_valid_w = sb_rel_valid_list_w[0];

    logic sb_chk_busy_w [0:2];
    assign sb_chk1_busy_w = sb_chk_busy_w[0];
    assign sb_chk2_busy_w = sb_chk_busy_w[1];
    assign sb_chk3_busy_w = sb_chk_busy_w[2];

    seq_t sb_acq_old_seq_list_w [0:1];
    logic sb_acq_old_busy_list_w [0:1];

    assign sb_acq_old_seq_w = sb_acq_old_seq_list_w[0];
    assign sb_acq_old_busy_w = sb_acq_old_busy_list_w[0];

    scoreboard #(
        .N_ENTRIES(N_WARPS * N_REGISTERS * N_REGFILES),
        .N_CHK_PORTS(3),
        .N_ACQ_PORTS(2),
        .N_REL_PORTS(1)
    ) u_reg_scoreboard (
        .clk(clk),
        .rst_n(rst_n),

        .chk_id_i({
            {sb_frontend_warp_id_w, sb_chk1_idx_w, sb_chk1_regfile_w},
            {sb_frontend_warp_id_w, sb_chk2_idx_w, sb_chk2_regfile_w},
            {sb_frontend_warp_id_w, sb_chk3_idx_w, sb_chk3_regfile_w}
        }),
        .chk_en_i({sb_chk1_en_w, sb_chk2_en_w, sb_chk3_en_w}),
        .chk_busy_o(sb_chk_busy_w),

        .acq_id_i({
            {sb_frontend_warp_id_w, sb_acq_idx_w, sb_acq_regfile_w},
            {sb_frontend_dacq_warp_id_w, sb_dacq_idx_w, sb_dacq_regfile_w}
        }),
        .acq_seq_i({sb_acq_seq_w, sb_dacq_seq_w}),
        .acq_en_i({sb_acq_en_w, sb_dacq_en_w}),
        .acq_empty_i({0, sb_dacq_empty_w}),
        .acq_old_seq_o(sb_acq_old_seq_list_w),
        .acq_old_busy_o(sb_acq_old_busy_list_w),

        .rel_id_i({{sb_backend_warp_id_w, sb_rel_idx_w, sb_rel_regfile_w}}),
        .rel_seq_i({sb_rel_seq_w}),
        .rel_en_i({sb_rel_en_w}),
        .rel_valid_o(sb_rel_valid_list_w)
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

    // FIXME: find a better place to put these
    logic branch_complete_w;
    simd_mask_t branch_mask_w;
    branch_type_e branch_type_w;
    warp_id_t branch_warp_id_w;
    pc_t branch_pc_w;
    pc_t branch_target_w;

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

        .sb_warp_id_o(sb_frontend_warp_id_w),

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
        .sb_acq_en_o(sb_acq_en_w),
        .sb_acq_old_seq_i(sb_acq_old_seq_w),
        .sb_acq_old_busy_i(sb_acq_old_busy_w),

        .sb_dacq_warp_id_o(sb_frontend_dacq_warp_id_w),
        .sb_dacq_idx_o(sb_dacq_idx_w),
        .sb_dacq_regfile_o(sb_dacq_regfile_w),
        .sb_dacq_seq_o(sb_dacq_seq_w),
        .sb_dacq_en_o(sb_dacq_en_w),
        .sb_dacq_empty_o(sb_dacq_empty_w),

        .hsb_warp_id_o(hsb_frontend_warp_id_w),
        .hsb_acq_mask_o(hsb_acq_mask_w),
        .hsb_acq_seq_o(hsb_acq_seq_w),
        .hsb_busy_i(hsb_busy_w),
        .hsb_acq_old_busy_i(hsb_acq_old_busy_w),
        .hsb_acq_old_seq_i(hsb_acq_old_seq_w),
        .hsb_dacq_warp_id_o(hsb_dacq_warp_id_w),
        .hsb_dacq_mask_o(hsb_dacq_mask_w),
        .hsb_dacq_seq_o(hsb_dacq_seq_w),
        .hsb_dacq_empty_o(hsb_dacq_empty_w),

        .branch_complete_i(branch_complete_w),
        .branch_mask_i(branch_mask_w),
        .branch_type_i(branch_type_w),
        .branch_warp_id_i(branch_warp_id_w),
        .branch_pc_i(branch_pc_w),
        .branch_target_i(branch_target_w)
    );

    // - Function Units

    fu_result_s fu_result_w [0:N_FUNCTION_UNITS-1];

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

    fpnew_pkg::status_t [N_WARPS-1:0][N_THREADS-1:0] fflags_w; // FIXME: Put this in a better place lol

    fu_csru u_csru (
    	.clk            (clk),
    	.rst_n          (rst_n),
    	.in_valid_i     (fu_in_valid_w[FUNCTION_UNIT_CSRR]),
    	.in_ready_o     (fu_in_ready_w[FUNCTION_UNIT_CSRR]),
    	.out_valid_o    (fu_out_valid_w[FUNCTION_UNIT_CSRR]),
    	.out_ready_i    (fu_out_ready_w[FUNCTION_UNIT_CSRR]),
    	.in_operation_i (fu_in_operation_w),
        .out_result_o   (fu_result_w[FUNCTION_UNIT_CSRR]),
        .fflags_i       (fflags_w)
    );

    fu_bju u_bju (
    	.clk            (clk),
    	.rst_n          (rst_n),
    	.in_valid_i     (fu_in_valid_w[FUNCTION_UNIT_BJU]),
    	.in_ready_o     (fu_in_ready_w[FUNCTION_UNIT_BJU]),
    	.out_valid_o    (fu_out_valid_w[FUNCTION_UNIT_BJU]),
    	.out_ready_i    (fu_out_ready_w[FUNCTION_UNIT_BJU]),
    	.in_operation_i (fu_in_operation_w),
        .out_result_o   (fu_result_w[FUNCTION_UNIT_BJU]),
        .branch_complete_o(branch_complete_w),
        .branch_mask_o(branch_mask_w),
        .branch_type_o(branch_type_w),
        .branch_warp_id_o(branch_warp_id_w),
        .branch_pc_o(branch_pc_w),
        .branch_target_o(branch_target_w)
    );

    // - Back-end

    core_backend u_core_backend (
    	.clk               (clk),
    	.rst_n             (rst_n),
    	.fu_out_valid_i    (fu_out_valid_w),
    	.fu_out_ready_o    (fu_out_ready_w),
    	.fu_out_result_i   (fu_result_w),
    	.sb_warp_id_o      (sb_backend_warp_id_w),
    	.sb_rel_idx_o      (sb_rel_idx_w),
    	.sb_rel_regfile_o  (sb_rel_regfile_w),
    	.sb_rel_seq_o      (sb_rel_seq_w),
    	.sb_rel_en_o       (sb_rel_en_w),
    	.sb_rel_valid_i    (sb_rel_valid_w),
        .rf_warp_id_o      (rf_write_warp_id_w),
    	.rf_write_en_mask_o(rf_write_en_mask_w),
    	.rf_rd_idx_o       (rf_rd_idx_w),
    	.rf_rd_regfile_o   (rf_rd_regfile_w),
    	.rf_write_data_o   (rf_write_data_w),
        .hsb_warp_id_o     (hsb_backend_warp_id_w),
        .hsb_rel_mask_o    (hsb_rel_mask_w),
        .hsb_rel_seq_o     (hsb_rel_seq_w),
        .hsb_rel_valid_i   (hsb_rel_valid_w),
        .fflags_o          (fflags_w)
    );

endmodule

`default_nettype wire
