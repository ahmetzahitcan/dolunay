`default_nettype none

module core_top
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
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
    logic [N_WARPS-1:0] me_in_ready_w;
    logic [N_WARPS-1:0] me_in_valid_w;
    me_operation_s me_in_operation_w;

    logic me_out_ready_w;
    logic me_out_valid_w;
    fu_result_s me_out_result_w;

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

    hazard_mask_t hsb_rel_mask_w;
    seq_t hsb_rel_seq_w;
    hazard_mask_t hsb_rel_valid_w;

    scoreboard_mask #(
        .N_ENTRIES(N_HAZARDS)
     ) u_haz_scoreboard (
    	.clk               (clk),
    	.rst_n             (rst_n),
    	.frontend_warp_id_i(hsb_frontend_warp_id_w),
    	.backend_warp_id_i (hsb_backend_warp_id_w),
    	.busy_o            (hsb_busy_w),
    	.acq_mask_i        (hsb_acq_mask_w),
    	.acq_seq_i         (hsb_acq_seq_w),
    	.rel_mask_i        (hsb_rel_mask_w),
    	.rel_seq_i         (hsb_rel_seq_w),
    	.rel_valid_o       (hsb_rel_valid_w)
    );

    // - Registers Scoreboard

    warp_id_t sb_frontend_warp_id_w;
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

    reg_id_t sb_rel_idx_w;
    regfile_sel_e sb_rel_regfile_w;
    seq_t sb_rel_seq_w;
    logic sb_rel_en_w;
    logic sb_rel_valid_w;

    logic sb_chk_busy_w [0:2];
    assign sb_chk1_busy_w = sb_chk_busy_w[0];
    assign sb_chk2_busy_w = sb_chk_busy_w[1];
    assign sb_chk3_busy_w = sb_chk_busy_w[2];

    scoreboard #(
        .N_ENTRIES(N_WARPS * N_REGISTERS * N_REGFILES),
        .N_CHECK_PORTS(3)
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

        .acq_id_i({sb_frontend_warp_id_w, sb_acq_idx_w, sb_acq_regfile_w}),
        .acq_seq_i(sb_acq_seq_w),
        .acq_en_i(sb_acq_en_w),

        .rel_id_i({sb_backend_warp_id_w, sb_rel_idx_w, sb_rel_regfile_w}),
        .rel_seq_i(sb_rel_seq_w),
        .rel_en_i(sb_rel_en_w),
        .rel_valid_o(sb_rel_valid_w)
    );

    // - Register File

    phys_reg_id_t rfa_me_idx_w, rfa_be_idx_w, rfa_idx_w;
    simd_mask_t rfa_wen_mask_w;
    logic rfa_wen_any_w;
    simd_data_t rfa_wdata_w;
    simd_data_t rfa_rdata_w;

    assign rfa_wen_any_w = |rfa_wen_mask_w;
    assign rfa_idx_w = rfa_wen_any_w ? rfa_be_idx_w : rfa_me_idx_w;

    phys_reg_id_t rfb_idx_w;
    simd_data_t rfb_rdata_w;

    register_file u_register_file (
    	.clk                  (clk),
    	.porta_idx_i          (rfa_idx_w),
    	.porta_write_en_mask_i(rfa_wen_mask_w),
    	.porta_write_data_i   (rfa_wdata_w),
    	.porta_data_o         (rfa_rdata_w),
    	.portb_idx_i          (rfb_idx_w),
    	.portb_write_en_mask_i('0),
    	.portb_write_data_i   ('x),
    	.portb_data_o         (rfb_rdata_w)
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
        .me_ready_i(me_in_ready_w),
        .me_valid_o(me_in_valid_w),
        .me_op_o(me_in_operation_w),
        .instr_addr_o(irom_addr_a_o),
        .undec_instr32_i(irom_data_a_i),

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

        .hsb_warp_id_o(hsb_frontend_warp_id_w),
        .hsb_acq_mask_o(hsb_acq_mask_w),
        .hsb_acq_seq_o(hsb_acq_seq_w),
        .hsb_busy_i(hsb_busy_w),

        .branch_complete_i(branch_complete_w),
        .branch_mask_i(branch_mask_w),
        .branch_type_i(branch_type_w),
        .branch_warp_id_i(branch_warp_id_w),
        .branch_pc_i(branch_pc_w),
        .branch_target_i(branch_target_w)
    );

    // - Middle-end

    // FIXME: THERE MUST BE A BETTER PLACE TO PUT THIS! MUST BE!
    fpnew_pkg::status_t [N_WARPS-1:0][N_THREADS-1:0] fflags_w;

    core_middleend u_core_middleend (
    	.clk              (clk),
    	.rst_n            (rst_n),
    	.me_ready_o       (me_in_ready_w),
    	.me_valid_i       (me_in_valid_w),
    	.me_op_i          (me_in_operation_w),
    	.rfa_idx_o        (rfa_me_idx_w),
    	.rfa_write_en_i   (rfa_wen_any_w),
    	.rfa_data_i       (rfa_rdata_w),
    	.rfb_idx_o        (rfb_idx_w),
    	.rfb_write_en_i   ('0),
    	.rfb_data_i       (rfb_rdata_w),
    	.result_valid_o   (me_out_valid_w),
    	.result_ready_i   (me_out_ready_w),
    	.result_o         (me_out_result_w),
    	.branch_complete_o(branch_complete_w),
    	.branch_mask_o    (branch_mask_w),
    	.branch_type_o    (branch_type_w),
    	.branch_warp_id_o (branch_warp_id_w),
    	.branch_pc_o      (branch_pc_w),
    	.branch_target_o  (branch_target_w),
    	.fflags_i         (fflags_w)
    );


    // - Back-end

    core_backend u_core_backend (
    	.clk               (clk),
    	.rst_n             (rst_n),
    	.result_valid_i    (me_out_valid_w),
    	.result_ready_o    (me_out_ready_w),
    	.result_i          (me_out_result_w),
    	.sb_warp_id_o      (sb_backend_warp_id_w),
    	.sb_rel_idx_o      (sb_rel_idx_w),
    	.sb_rel_regfile_o  (sb_rel_regfile_w),
    	.sb_rel_seq_o      (sb_rel_seq_w),
    	.sb_rel_en_o       (sb_rel_en_w),
    	.sb_rel_valid_i    (sb_rel_valid_w),
    	.rf_write_en_mask_o(rfa_wen_mask_w),
    	.rf_write_idx_o    (rfa_be_idx_w),
    	.rf_write_data_o   (rfa_wdata_w),
        .hsb_warp_id_o     (hsb_backend_warp_id_w),
        .hsb_rel_mask_o    (hsb_rel_mask_w),
        .hsb_rel_seq_o     (hsb_rel_seq_w),
        .hsb_rel_valid_i   (hsb_rel_valid_w),
        .fflags_o          (fflags_w)
    );

endmodule

`default_nettype wire
