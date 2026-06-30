`default_nettype none

module pipeline
    import params_pkg::*;
    import control_unit_pkg::*;
    import pipeline_pkg::*;
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
    output logic [XLEN-1:0] wram_wdata_o,
    output logic [ADDR_ALIGN-1:0] wram_wen_o,
    input wire logic [XLEN-1:0] wram_rdata_i,

    // IROM Interface A
    output logic [W_IROM_ADDR-1:Z_PC] irom_addr_a_o,
    input wire logic [XLEN-1:0] irom_data_a_i,

    // IROM Interface B
    output logic [W_IROM_ADDR-1:Z_PC] irom_addr_b_o,
    input wire logic [XLEN-1:0] irom_data_b_i
);
    // Typedefs moved to pipeline_pkg

    // HPMs
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

    // Stage valid registers -- indicating whether other pipeline registers are valid
    logic [N_WARPS-1:0] wdone_r;
    logic running_w;
    assign running_w = ~&wdone_r;
    assign ready_o = ~running_w & ~wb_stage_valid_r & rst_n;

    logic ws_stage_valid_r;
    logic if_stage_valid_r;
    logic id_stage_valid_r;
    logic ex_stage_valid_r;
    logic ls_stage_valid_r;
    logic ma_stage_valid_r;
    logic su_stage_valid_r;
    logic wb_stage_valid_r;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            wdone_r <= '1;
            ws_stage_valid_r <= '0;
            if_stage_valid_r <= '0;
            id_stage_valid_r <= '0;
            ex_stage_valid_r <= '0;
            ls_stage_valid_r <= '0;
            ma_stage_valid_r <= '0;
            su_stage_valid_r <= '0;
            wb_stage_valid_r <= '0;
        end else begin           
            unique0 if (start_i & ready_o) begin
                wdone_r <= '0;
            end else if (running_w) begin
                if (suwb_instr_r.is_wdone & wb_stage_valid_r) begin
                    wdone_r[suwb_warp_id_r] <= 1'b1;
                end
            end
            ws_stage_valid_r <= running_w;
            if_stage_valid_r <= ws_stage_valid_r;
            id_stage_valid_r <= if_stage_valid_r;
            ex_stage_valid_r <= id_stage_valid_r;
            ls_stage_valid_r <= ex_stage_valid_r;
            ma_stage_valid_r <= ls_stage_valid_r;
            su_stage_valid_r <= ma_stage_valid_r;
            wb_stage_valid_r <= su_stage_valid_r;
        end
    end

    // Cross-stage signals

    // - Fetch stage signals
    logic [W_WARPS-1:0] wsif_warp_id_r;

    // - Decode stage signals
    logic [XLEN-1:Z_PC] ifid_pc_r;
    logic [N_THREADS-1:0] ifid_mask_r;
    logic [31:2] ifid_undec_instr32_w;
    logic [W_WARPS-1:0] ifid_warp_id_r;

    // - Execute stage signals
    logic [N_THREADS-1:0][XLEN-1:0] idex_rs1_data_w;
    logic [N_THREADS-1:0][XLEN-1:0] idex_rs2_data_w;
    instr_s idex_instr_r;
    logic [W_WARPS-1:0] idex_warp_id_r;
    logic [XLEN-1:Z_PC] idex_pc_r;
    logic [N_THREADS-1:0] idex_mask_r;

    // - Leader Select stage signals
    instr_s exls_instr_r;
    logic [N_THREADS-1:0][XLEN-1:0] exls_alu_result_r;
    logic [N_THREADS-1:0][XLEN-1:0] exls_rs2_data_r;
    logic [XLEN-1:Z_PC] exls_pc_r;
    logic [N_THREADS-1:0] exls_mask_r;
    logic [W_WARPS-1:0] exls_warp_id_r;

    logic [N_THREADS-1:0][XLEN-1:0] ls_store_data_fmt_w;
    logic [N_THREADS-1:0][ADDR_ALIGN-1:0] ls_store_wen_w;

    // - Memory Access stage signals
    instr_s lsma_instr_r;
    logic [N_THREADS-1:0][XLEN-1:0] lsma_alu_result_r;
    logic [XLEN-1:Z_PC] lsma_pc_r;
    logic [N_THREADS-1:0] lsma_mask_r;
    logic [W_WARPS-1:0] lsma_warp_id_r;
    logic [W_THREADS-1:0] lsma_leader_id_r;
    logic [N_THREADS-1:0] lsma_leader_one_hot_r;
    logic lsma_leader_valid_r;
    logic [N_WARPS-1:0][N_THREADS-1:0] lsma_reservation_r;
    msel_e [N_THREADS-1:0] lsma_msel_r;
    logic [N_THREADS-1:0][XLEN-1:0] lsma_store_data_fmt_r;
    logic [N_THREADS-1:0][ADDR_ALIGN-1:0] lsma_store_wen_r;
    logic [N_THREADS-1:0] lsma_coalesced_r;
    logic [XLEN-1:0] lsma_leader_target_r;
    logic [N_THREADS-1:0][XLEN-1:0] lsma_rs2_data_r;
    
    logic [N_THREADS-1:0] ma_instr_replay_mask_w;
    logic [N_THREADS-1:0] ma_instr_retired_mask_w;

    // - Scheduler Update stage signals
    instr_s masu_instr_r;
    logic [N_THREADS-1:0][XLEN-1:0] masu_alu_result_r;
    logic [XLEN-1:Z_PC] masu_pc_r;
    logic [N_THREADS-1:0] masu_mask_r;
    logic [W_WARPS-1:0] masu_warp_id_r;
    msel_e [N_THREADS-1:0] masu_msel_r;
    logic [XLEN-1:0] masu_branch_target_r;
    logic [N_THREADS-1:0] masu_branch_flag_r;
    logic [N_THREADS-1:0] masu_branch_mask_r;
    logic masu_branching_r;
    logic [N_THREADS-1:0] masu_instr_replay_mask_r;
    logic [N_THREADS-1:0] masu_instr_retired_mask_r;
    logic [Z_ADDR-1:0] masu_leader_alignment_r;
    logic [N_THREADS-1:0] masu_leader_one_hot_r;

    logic [XLEN-1:0] su_wram_rdata_w;
    logic [31:0] su_irom_data_w;
    logic [N_THREADS-1:0][XLEN-1:0] su_tlocal_rdata_w;

    // - Barrier signals
    logic [N_THREADS-1:0] barr_load_total_w;
    logic [N_THREADS-1:0] barr_load_parked_w;
    logic [N_WARPS-1:0][N_THREADS-1:0] barr_sync_total_w;
    logic [N_WARPS-1:0][N_THREADS-1:0] barr_sync_parked_next_w;

    // - Writeback stage signals
    instr_s suwb_instr_r;
    logic [N_THREADS-1:0][XLEN-1:0] suwb_alu_result_r;
    logic [XLEN-1:Z_PC] suwb_pc_r;
    logic [N_THREADS-1:0] suwb_mask_r;
    logic [W_WARPS-1:0] suwb_warp_id_r;
    msel_e [N_THREADS-1:0] suwb_msel_r;
    logic [Z_ADDR-1:0] suwb_leader_alignment_r;
    logic [N_THREADS-1:0] suwb_leader_one_hot_r;
    logic [N_THREADS-1:0][XLEN-1:0] suwb_tlocal_rdata_fmt_r;
    logic [XLEN-1:0] suwb_irom_data_fmt_r;
    logic [XLEN-1:0] suwb_wram_rdata_fmt_r;

    logic [N_THREADS-1:0] wb_write_en_mask_w;
    logic [N_THREADS-1:0][XLEN-1:0] wb_write_data_w;

    // Warp Select
    logic [W_WARPS-1:0] ws_warp_id_w;
    logic [W_WARPS-1:0] ws_warp_id_r;
    (* DONT_TOUCH = "true" *)
    warp_scheduler u_warp_scheduler(
        .clk(clk),
        .rst_n(rst_n),
        .warp_id_o(ws_warp_id_w)
    );

    always_ff @( posedge clk ) begin
        ws_warp_id_r <= ws_warp_id_w;
        wsif_warp_id_r <= ws_warp_id_r;
    end

    // Fetch
    logic [N_WARPS-1:0] bsync_1_r;
    logic [N_WARPS-1:0] bsync_1_w;
    always_ff @( posedge clk ) begin
        if (~rst_n) begin
            bsync_1_r <= '0;
        end else begin
            bsync_1_r <= bsync_1_w;
        end
    end

    logic [N_WARPS-1:0][XLEN-1:Z_PC] u_thread_scheduler_pc_w;
    logic [N_WARPS-1:0][N_THREADS-1:0] u_thread_scheduler_mask_w;

    logic [XLEN-1:Z_PC] if_pc_w;
    logic [N_THREADS-1:0] if_mask_w;

    // - Thread Schedulers
    generate
        for (genvar I = 0; I < N_WARPS; I++) begin
            logic su_en_w;
            assign su_en_w = (masu_warp_id_r == I) & su_stage_valid_r;

            logic wb_en_w;
            assign wb_en_w = (suwb_warp_id_r == I) & wb_stage_valid_r;

            // FIXME: this is a hack
            assign bsync_1_w[I] = su_en_w ? (bsync_1_r[I] ^ (masu_instr_r.barr_load | masu_instr_r.barr_sync)) : bsync_1_r[I];

            // FIXME: this is a hack
            logic instruction_retire_w;
            assign instruction_retire_w = ~masu_instr_r.barr_load & su_en_w;

            assign winst_retired_w[I] = instruction_retire_w;
            assign inst_retired_w[I] = instruction_retire_w ? masu_instr_retired_mask_r : '0;

            (* DONT_TOUCH = "true" *)
            thread_scheduler u_thread_scheduler(
                .clk(clk),
                .rst_n(rst_n & ~start_i),

                .instr_completed_i(winst_retired_w[I]), 
                .instr_replay_mask_i(masu_instr_replay_mask_r),

                .yield_i(masu_instr_r.yield & su_en_w),

                .barr_sync_i(masu_instr_r.barr_sync & su_en_w),
                .barr_sync_total_o(barr_sync_total_w[I]),
                .barr_sync_parked_next_o(barr_sync_parked_next_w[I]),
                .barr_sync_release_o(), // Not needed

                .barr_load_i(suwb_instr_r.barr_load & wb_en_w),
                .barr_load_total_i(barr_load_total_w),
                .barr_load_parked_i(barr_load_parked_w),

                .branch_i(masu_branching_r & su_en_w),
                .pc_branch_i(masu_branch_target_r),
                .mask_branch_i(masu_branch_mask_r),

                .pc_o(u_thread_scheduler_pc_w[I]),
                .mask_o(u_thread_scheduler_mask_w[I])
            );
        end
    endgenerate

    // - Instruction Memory

    pipeline_stage_if #(
        .W_IROM_ADDR(W_IROM_ADDR)
    ) u_stage_if (
        .wsif_warp_id_r(wsif_warp_id_r),
        .u_thread_scheduler_pc_w(u_thread_scheduler_pc_w),
        .u_thread_scheduler_mask_w(u_thread_scheduler_mask_w),
        .irom_data_a_i(irom_data_a_i),
        .if_pc_w(if_pc_w),
        .if_mask_w(if_mask_w),
        .irom_addr_a_o(irom_addr_a_o),
        .ifid_undec_instr32_w(ifid_undec_instr32_w)
    );

    assign irom_addr_b_o = lsma_alu_result_r[lsma_leader_id_r][W_IROM_ADDR-1:Z_PC];
    assign su_irom_data_w = irom_data_b_i;

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        ifid_pc_r <= if_pc_w;
        ifid_mask_r <= if_mask_w;
        ifid_warp_id_r <= wsif_warp_id_r;
    end

    // Decode

    // - Control Unit

    instr_s id_instr_w;

    pipeline_stage_id u_stage_id (
        .ifid_undec_instr32_w(ifid_undec_instr32_w),
        .ifid_pc_r(ifid_pc_r),
        .id_stage_valid_r(id_stage_valid_r),
        .bsync_1_i(bsync_1_r[ifid_warp_id_r]),
        .id_instr_w(id_instr_w)
    );

    // - Register File

    (* DONT_TOUCH = "true" *)
    register_file u_register_file(
        .clk(clk),

        .read_warp_id_i(ifid_warp_id_r),

        .rs1_idx_i(id_instr_w.rs1_idx),
        .rs1_data_o(idex_rs1_data_w),

        .rs2_idx_i(id_instr_w.rs2_idx),
        .rs2_data_o(idex_rs2_data_w),

        .write_warp_id_i(suwb_warp_id_r),
        .write_en_mask_i(wb_write_en_mask_w),
        .rd_idx_i(suwb_instr_r.rd_idx),
        .write_data_i(wb_write_data_w)
    );

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        idex_instr_r <= id_instr_w;
        idex_warp_id_r <= ifid_warp_id_r;
        idex_pc_r <= ifid_pc_r;
        idex_mask_r <= ifid_mask_r;
    end

    // Execute

    // - ALU Lanes

    logic [N_THREADS-1:0][XLEN-1:0] ex_alu_result_w;

    pipeline_stage_ex u_stage_ex (
        .idex_rs1_data_w(idex_rs1_data_w),
        .idex_rs2_data_w(idex_rs2_data_w),
        .idex_instr_r(idex_instr_r),
        .idex_warp_id_r(idex_warp_id_r),
        .idex_pc_r(idex_pc_r),
        .cycletime_w(cycletime_w),
        .instret_w(instret_w),
        .wuinstret_w(wuinstret_w),
        .wtinstret_w(wtinstret_w),
        .ex_alu_result_w(ex_alu_result_w)
    );

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        exls_instr_r <= idex_instr_r;
        exls_alu_result_r <= ex_alu_result_w;
        exls_rs2_data_r <= idex_rs2_data_w;
        exls_mask_r <= idex_mask_r;
        exls_pc_r <= idex_pc_r;
        exls_warp_id_r <= idex_warp_id_r;
    end

    // Leader Select Stage

    // -- LR/SC Reservations

    logic [N_WARPS-1:0][N_THREADS-1:0] ls_reservation_r;
    msel_e [N_THREADS-1:0] ls_msel_w;
    logic [W_THREADS-1:0] ls_leader_id_w;
    logic [N_THREADS-1:0] ls_leader_one_hot_w;
    logic ls_leader_valid_w;
    logic [N_THREADS-1:0] ls_coalesced_w;
    logic [XLEN-1:0] ls_leader_target_w;

    pipeline_stage_ls u_stage_ls (
        .clk(clk),
        .rst_n(rst_n),
        .exls_instr_r(exls_instr_r),
        .exls_alu_result_r(exls_alu_result_r),
        .exls_rs2_data_r(exls_rs2_data_r),
        .exls_mask_r(exls_mask_r),
        .exls_warp_id_r(exls_warp_id_r),
        .exls_pc_r(exls_pc_r),
        .ls_stage_valid_r(ls_stage_valid_r),
        .barr_sync_total_w(barr_sync_total_w),
        .barr_sync_parked_next_w(barr_sync_parked_next_w),
        .ls_reservation_r(ls_reservation_r),
        .ls_msel_w(ls_msel_w),
        .ls_leader_id_w(ls_leader_id_w),
        .ls_leader_one_hot_w(ls_leader_one_hot_w),
        .ls_leader_valid_w(ls_leader_valid_w),
        .ls_store_data_fmt_w(ls_store_data_fmt_w),
        .ls_store_wen_w(ls_store_wen_w),
        .ls_coalesced_w(ls_coalesced_w),
        .ls_leader_target_w(ls_leader_target_w)
    );

    // - Pipeline Registers - FIXME: Declare this!

    always_ff @( posedge clk ) begin
        lsma_instr_r <= exls_instr_r;
        lsma_alu_result_r <= exls_alu_result_r;
        lsma_rs2_data_r <= exls_rs2_data_r;
        lsma_mask_r <= exls_mask_r;
        lsma_pc_r <= exls_pc_r;
        lsma_warp_id_r <= exls_warp_id_r;
        lsma_leader_id_r <= ls_leader_id_w;
        lsma_leader_one_hot_r <= ls_leader_one_hot_w;
        lsma_leader_valid_r <= ls_leader_valid_w;
        lsma_reservation_r <= ls_reservation_r;
        lsma_msel_r <= ls_msel_w;
        lsma_store_data_fmt_r <= ls_store_data_fmt_w;
        lsma_store_wen_r <= ls_store_wen_w;
        lsma_coalesced_r <= ls_coalesced_w;
        lsma_leader_target_r <= ls_leader_target_w;
    end

    // Memory Access Stage

    logic [N_THREADS-1:0] ma_write_en_w;
    logic [N_THREADS-1:0] ma_branch_flag_w;
    logic [N_THREADS-1:0] ma_branch_mask_w;
    logic ma_branching_w;
    logic [XLEN-1:Z_PC] ma_branch_target_w;
    logic [Z_ADDR-1:0] ma_leader_alignment_w;

    assign su_wram_rdata_w = wram_rdata_i;

    pipeline_stage_ma #(
        .W_WRAM_ADDR(W_WRAM_ADDR)
    ) u_stage_ma (
        .clk(clk),
        .ma_stage_valid_r(ma_stage_valid_r),
        .lsma_instr_r(lsma_instr_r),
        .lsma_alu_result_r(lsma_alu_result_r),
        .lsma_mask_r(lsma_mask_r),
        .lsma_warp_id_r(lsma_warp_id_r),
        .lsma_pc_r(lsma_pc_r),
        .lsma_leader_id_r(lsma_leader_id_r),
        .lsma_leader_one_hot_r(lsma_leader_one_hot_r),
        .lsma_leader_valid_r(lsma_leader_valid_r),
        .lsma_msel_r(lsma_msel_r),
        .lsma_store_data_fmt_r(lsma_store_data_fmt_r),
        .lsma_store_wen_r(lsma_store_wen_r),
        .lsma_coalesced_r(lsma_coalesced_r),
        .lsma_leader_target_r(lsma_leader_target_r),
        .ma_write_en_w(ma_write_en_w),
        .ma_branch_flag_w(ma_branch_flag_w),
        .ma_branch_mask_w(ma_branch_mask_w),
        .ma_branching_w(ma_branching_w),
        .ma_branch_target_w(ma_branch_target_w),
        .ma_instr_replay_mask_w(ma_instr_replay_mask_w),
        .ma_instr_retired_mask_w(ma_instr_retired_mask_w),
        .ma_leader_alignment_w(ma_leader_alignment_w),
        .wram_addr_o(wram_addr_o),
        .wram_wdata_o(wram_wdata_o),
        .wram_wen_o(wram_wen_o),
        .su_tlocal_rdata_w(su_tlocal_rdata_w)
    );

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        masu_pc_r <= lsma_pc_r;
        masu_instr_r <= lsma_instr_r;
        masu_alu_result_r <= lsma_alu_result_r;
        masu_mask_r <= lsma_mask_r;
        masu_warp_id_r <= lsma_warp_id_r;
        masu_msel_r <= lsma_msel_r;
        masu_branch_target_r <= ma_branch_target_w;
        masu_branch_flag_r <= ma_branch_flag_w;
        masu_branch_mask_r <= ma_branch_mask_w;
        masu_branching_r <= ma_branching_w;
        masu_instr_replay_mask_r <= ma_instr_replay_mask_w;
        masu_instr_retired_mask_r <= ma_instr_retired_mask_w;
        masu_leader_alignment_r <= ma_leader_alignment_w;
        masu_leader_one_hot_r <= lsma_leader_one_hot_r;
    end

    // Scheduler Update Stage

    logic [XLEN-1:0] su_wram_rdata_fmt_w;
    logic [XLEN-1:0] su_irom_data_fmt_w;
    logic [N_THREADS-1:0][XLEN-1:0] su_tlocal_rdata_fmt_w;

    pipeline_stage_su u_stage_su (
        .masu_instr_r(masu_instr_r),
        .masu_alu_result_r(masu_alu_result_r),
        .masu_leader_alignment_r(masu_leader_alignment_r),
        .su_tlocal_rdata_w(su_tlocal_rdata_w),
        .su_wram_rdata_w(su_wram_rdata_w),
        .su_irom_data_w(su_irom_data_w),
        .su_tlocal_rdata_fmt_w(su_tlocal_rdata_fmt_w),
        .su_wram_rdata_fmt_w(su_wram_rdata_fmt_w),
        .su_irom_data_fmt_w(su_irom_data_fmt_w)
    );

    // - Pipeline Registers
    always_ff @( posedge clk ) begin
        suwb_instr_r <= masu_instr_r;
        suwb_alu_result_r <= masu_alu_result_r;
        suwb_mask_r <= masu_instr_retired_mask_r;
        suwb_pc_r <= masu_pc_r;
        suwb_warp_id_r <= masu_warp_id_r;
        suwb_msel_r <= masu_msel_r;
        suwb_leader_alignment_r <= masu_leader_alignment_r;
        suwb_leader_one_hot_r <= masu_leader_one_hot_r;
        suwb_tlocal_rdata_fmt_r <= su_tlocal_rdata_fmt_w;
        suwb_wram_rdata_fmt_r <= su_wram_rdata_fmt_w;
        suwb_irom_data_fmt_r <= su_irom_data_fmt_w;
    end

    // Writeback

    pipeline_stage_wb u_stage_wb (
        .wb_stage_valid_r(wb_stage_valid_r),
        .suwb_instr_r(suwb_instr_r),
        .suwb_alu_result_r(suwb_alu_result_r),
        .suwb_pc_r(suwb_pc_r),
        .suwb_mask_r(suwb_mask_r),
        .suwb_leader_one_hot_r(suwb_leader_one_hot_r),
        .suwb_msel_r(suwb_msel_r),
        .suwb_tlocal_rdata_fmt_r(suwb_tlocal_rdata_fmt_r),
        .suwb_wram_rdata_fmt_r(suwb_wram_rdata_fmt_r),
        .suwb_irom_data_fmt_r(suwb_irom_data_fmt_r),
        .wb_write_data_w(wb_write_data_w),
        .wb_write_en_mask_w(wb_write_en_mask_w),
        .barr_load_total_w(barr_load_total_w),
        .barr_load_parked_w(barr_load_parked_w)
    );

endmodule

`default_nettype wire