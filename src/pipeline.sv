`default_nettype none

module pipeline
    import params_pkg::*;
    import control_unit_pkg::*;
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
    // Typedefs
    typedef enum logic [1:0] {
        MSEL_IROM,
        MSEL_WRAM,
        MSEL_TLOCAL,
        MSEL_UNDEFINED='x
    } msel_e;

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
                if (memwb_instr_r.is_wdone & wb_stage_valid_r) begin
                    wdone_r[memwb_warp_id_r] <= 1'b1;
                end
            end
            ws_stage_valid_r <= running_w;
            if_stage_valid_r <= ws_stage_valid_r;
            id_stage_valid_r <= if_stage_valid_r;
            ex_stage_valid_r <= id_stage_valid_r;
            ls_stage_valid_r <= ex_stage_valid_r;
            mem_stage_valid_r <= ls_stage_valid_r;
            tsu_stage_valid_r <= mem_stage_valid_r;
            wb_stage_valid_r <= tsu_stage_valid_r;
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
    logic [N_THREADS-1:0] ls_store_wen_w;

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
    logic [N_THREADS-1:0] lsma_store_wen_r;
    logic [N_THREADS-1:0] lsma_coalesced_r;
    logic [XLEN-1:0] lsma_leader_target_r;
    
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
    logic [XLEN-1:0] suwb_irom_data_fmt_w;
    logic [XLEN-1:0] suwb_wram_rdata_fmt_w;

    logic [N_THREADS-1:0] wb_write_en_mask_w;
    logic [N_THREADS-1:0][XLEN-1:0] wb_write_data_w;

    logic [31:0] su_irom_data_w;

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

    assign if_pc_w = u_thread_scheduler_pc_w[wsif_warp_id_r];   
    assign if_mask_w = u_thread_scheduler_mask_w[wsif_warp_id_r];

    // - Thread Schedulers
    generate
        for (genvar I = 0; I < N_WARPS; I++) begin
            logic mem_en_w;
            assign mem_en_w = (exmem_warp_id_r == I) & mem_stage_valid_r;

            logic wb_en_w;
            assign wb_en_w = (memwb_warp_id_r == I) & wb_stage_valid_r;

            // FIXME: this is a hack
            assign bsync_1_w[I] = mem_en_w ? (bsync_1_r[I] ^ (exmem_instr_r.barr_load | exmem_instr_r.barr_sync)) : bsync_1_r[I];

            // FIXME: this is a hack
            logic instruction_retire_w;
            assign instruction_retire_w = ~exmem_instr_r.barr_load & mem_en_w;

            assign winst_retired_w[I] = instruction_retire_w;
            assign inst_retired_w[I] = instruction_retire_w ? mem_instr_retired_mask_w : '0;

            (* DONT_TOUCH = "true" *)
            thread_scheduler u_thread_scheduler(
                .clk(clk),
                .rst_n(rst_n & ~start_i),

                .instr_completed_i(winst_retired_w[I]), 
                .instr_replay_mask_i(mem_instr_replay_mask_w),

                .yield_i(exmem_instr_r.yield & mem_en_w),

                .barr_sync_i(exmem_instr_r.barr_sync & mem_en_w),
                .barr_sync_total_o(barr_sync_total_w[I]),
                .barr_sync_parked_next_o(barr_sync_parked_next_w[I]),
                .barr_sync_release_o(), // Not needed

                .barr_load_i(memwb_instr_r.barr_load & wb_en_w),
                .barr_load_total_i(barr_load_total_w),
                .barr_load_parked_i(barr_load_parked_w),

                .branch_i(mem_branching_w & mem_en_w),
                .pc_branch_i(mem_branch_target_w),
                .mask_branch_i(mem_branch_mask_w),

                .pc_o(u_thread_scheduler_pc_w[I]),
                .mask_o(u_thread_scheduler_mask_w[I])
            );
        end
    endgenerate

    // - Instruction Memory

    logic [XLEN-1:0] if_irom_data_w;

    assign irom_addr_a_o = if_pc_w[W_IROM_ADDR-1:Z_PC];
    assign if_irom_data_w = irom_data_a_i;

    assign irom_addr_b_o = exmem_alu_result_r[mem_leader_id_w][W_IROM_ADDR-1:Z_PC];
    assign su_irom_data_w = irom_data_b_i;

    assign ifid_undec_instr32_w = if_irom_data_w[31:2];

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        ifid_pc_r <= if_pc_w;
        ifid_mask_r <= if_mask_w;
        ifid_warp_id_r <= wsif_warp_id_r;
    end

    // Decode

    // - Control Unit

    instr_s id_instr_w;

    (* DONT_TOUCH = "true" *)
    control_unit_ext u_control_unit(
        .undec_instr32_i(ifid_undec_instr32_w),
        .pc_i(ifid_pc_r),
        .valid_i(id_stage_valid_r),
        .bsync_1_i(bsync_1_r[ifid_warp_id_r]),
        .instr_o(id_instr_w)
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

        .write_warp_id_i(memwb_warp_id_r),
        .write_en_mask_i(wb_write_en_mask_w),
        .rd_idx_i(memwb_instr_r.rd_idx),
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

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin
            (* DONT_TOUCH = "true" *)
            alu #(
                .THREAD_ID(I)
            ) u_alu (
                .rs1_val_i(idex_rs1_data_w[I]),
                .rs2_val_i(idex_rs2_data_w[I]),
                .instr_i(idex_instr_r),
                .warp_id_i(idex_warp_id_r),
                .pc_i(idex_pc_r),
                .result_o(ex_alu_result_w[I]),
                .cycle_time_i(cycletime_w),
                .instret_i(instret_w[idex_warp_id_r][I]),
                .wuinstret_i(wuinstret_w[idex_warp_id_r]),
                .wtinstret_i(wtinstret_w[idex_warp_id_r])
            );
        end
    endgenerate

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
    logic [N_WARPS-1:0][N_THREADS-1:0] ls_reservation_next_w;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            ls_reservation_r <= '0;
        end else if (ls_stage_valid_r) begin
            ls_reservation_r <= ls_reservation_next_w;
        end
    end

    always_comb begin
        ls_reservation_next_w = ls_reservation_r;
        if (exls_instr_r.is_lr) begin
            ls_reservation_next_w[exls_warp_id_r] = ls_reservation_r[exls_warp_id_r] | exls_mask_r;
        end else if (exls_instr_r.is_sc) begin
            ls_reservation_next_w = '0;
        end
    end

    // -- Memory Regions Accessed

    msel_e [N_THREADS-1:0] ls_msel_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            case (exls_alu_result_r[i][XLEN-1:XLEN-2]) inside // FIXME: unique
                2'b00: ls_msel_w[i] = MSEL_IROM;
                2'b01: ls_msel_w[i] = MSEL_WRAM;
                2'b1?: ls_msel_w[i] = MSEL_TLOCAL;
                default: ls_msel_w[i] = MSEL_UNDEFINED;
            endcase
        end
    end

    // - Leader Selection

    logic [N_THREADS-1:0] ls_leader_candidates_w;

    always_comb begin
        if (exls_instr_r.mem_active) begin
            for (int i = 0; i < N_THREADS; i++) begin
                case (ls_msel_w[i]) // FIXME: unique
                    MSEL_IROM: ls_leader_candidates_w[i] = exls_mask_r[i] & (exls_instr_r.mem_loadstore == MEM_LOADSTORE_LOAD); // FIXME: can this be just exls_mask_r[i]?
                    MSEL_WRAM: begin
                        if (exls_instr_r.is_sc) begin
                            ls_leader_candidates_w[i] = ls_reservation_r[exls_warp_id_r][i] & exls_mask_r[i];
                        end else begin
                            ls_leader_candidates_w[i] = exls_mask_r[i];
                        end
                    end
                    MSEL_TLOCAL: ls_leader_candidates_w[i] = '0;
                endcase
            end
        end else begin
            ls_leader_candidates_w = exls_mask_r;
        end
    end

    logic [W_THREADS-1:0] ls_leader_id_w;
    logic [N_THREADS-1:0] ls_leader_one_hot_w;
    logic ls_leader_valid_w;

    priority_encoder #(
        .WIDTH(N_THREADS)
    ) u_ls_leader_pe (
        .input_i(ls_leader_candidates_w),
        .index_o(ls_leader_id_w),
        .one_hot_o(ls_leader_one_hot_w),
        .valid_o(ls_leader_valid_w)
    );

    // - Formatting

    logic [N_THREADS-1:0][XLEN-1:0] ls_store_data_w;

    always_comb begin
        case (exls_instr_r.mem_store_source) // FIXME: unique
            MEM_STORE_SOURCE_RS2: ls_store_data_w = exls_rs2_data_r;
            MEM_STORE_SOURCE_BINIT: for(int i = 0; i < N_THREADS; i++) begin
                ls_store_data_w[i] = {{(XLEN-N_THREADS*2){1'b0}}, exls_mask_r, {N_THREADS{1'b0}}};
            end
            MEM_STORE_SOURCE_BSYNC: for(int i = 0; i < N_THREADS; i++) begin
                ls_store_data_w[i] = {{(XLEN-N_THREADS*2){1'b0}}, barr_sync_total_w[exls_warp_id_r], barr_sync_parked_next_w[exls_warp_id_r]};
            end
            default: ls_store_data_w = 'x;
        endcase
    end

    logic [N_THREADS-1:0][Z_ADDR-1:0] ls_mem_alignment_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            ls_mem_alignment_w[i] = exls_alu_result_r[i][Z_ADDR-1:0];
        end
    end

    mem_write_formatter #(
        .DATA_LEN(N_THREADS)
    ) u_wfmt (
        .p_data_i(ls_store_data_w),
        .opsize_i(exls_instr_r.mem_opsize),
        .alignment_i(ls_mem_alignment_w),
        .m_data_o(ls_store_data_fmt_w),
        .m_wen_o(ls_store_wen_w)
    );

    // - Coalescing Logic

    logic [XLEN-1:0] ls_leader_target_w;
    assign ls_leader_target_w = exls_alu_result_r[ls_leader_id_w][XLEN-1:0];

    logic [N_THREADS-1:0] ls_coalesced_w;

    generate
        for(genvar I = 0; I < N_THREADS; I++) begin
            assign ls_coalesced_w[I] = exls_alu_result_r[I][XLEN-1:0] == ls_leader_target_w;
        end
    endgenerate

    // - Pipeline Registers - FIXME: Declare this!

    always_ff @( posedge clk ) begin
        lsma_instr_r <= exls_instr_r;
        lsma_alu_result_r <= exls_alu_result_w;
        lsma_rs2_data_r <= exls_rs2_data_w;
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

    // - Write Enable Signals

    logic [N_THREADS-1:0] ma_write_en_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            ma_write_en_w[i] = 
                ma_stage_valid_r & 
                lsma_mask_r[i] & 
                lsma_instr_r.mem_active & 
                (lsma_instr_r.mem_loadstore == MEM_LOADSTORE_STORE);
        end
    end

    // - Work RAM

    assign wram_addr_o = lsma_alu_result_r[lsma_leader_id_r][W_WRAM_ADDR-1:Z_ADDR];
    assign wram_wdata_o = lsma_store_data_fmt_r[lsma_leader_id_r];
    assign wram_wen_o = (lsma_leader_valid_r & ma_write_en_w[lsma_leader_id_r]) ? lsma_store_wen_r[lsma_leader_id_r] : '0;
    assign su_wram_rdata_w = wram_rdata_i;

    `ifndef SYNTHESIS
        always_ff @(negedge clk) begin
            if (ma_stage_valid_r & lsma_instr_r.mem_active & lsma_leader_valid_r) begin
                assert (lsma_msel_r[lsma_leader_id_r] != MSEL_TLOCAL) 
                    else $error("Leader cannot have MSEL_TLOCAL");

                assert (lsma_instr_r.mem_loadstore != MEM_LOADSTORE_STORE || lsma_msel_r[lsma_leader_id_r] != MSEL_IROM) 
                    else $error("Leader cannot have MSEL_IROM during store operation");
            end
        end
    `endif

    logic [Z_ADDR-1:0] ma_leader_alignment_w;
    assign ma_leader_alignment_w = lsma_alu_result_r[lsma_leader_id_r][Z_ADDR-1:0];

    // - Thread-local Memory

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin
            logic [W_TLOCAL_BANK_ADDR-1:Z_ADDR] bank_addr;
            assign bank_addr = {lsma_warp_id_r, lsma_alu_result_r[I][W_TLOCAL_ADDR_PT-1:Z_ADDR]};

            logic wen_any_w;
            assign wen_any_w = 
                ma_write_en_w[I] & 
                (lsma_msel_r[I] == MSEL_TLOCAL) &
                ~lsma_instr_r.is_sc;

            logic [ADDR_ALIGN-1:0] wen_byte_w;
            assign wen_byte_w = wen_any_w ? ma_store_wen_w[I] : '0;

            ram #(
                .DEPTH(TLOCAL_BANK_DEPTH)
            ) u_tlocal_bank (
                .clk(clk),
                .addr_i(bank_addr),
                .wdata_i(lsma_store_data_fmt_r[I]),
                .wen_i(wen_byte_w),
                .rdata_o(su_tlocal_rdata_w[I])
            );
        end
    endgenerate    

    // - Branching Logic

    logic [N_THREADS-1:0] ma_branch_flag_w;
    logic [N_THREADS-1:0] ma_branch_mask_w;
    logic ma_branching_w;
    logic [XLEN-1:Z_PC] ma_branch_target_w;

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin
            (* DONT_TOUCH = "true" *)
            branch_cond_unit u_bcu(
                .alu_result_i(lsma_alu_result_r[I]),
                .coalesced_i(lsma_coalesced_r[I]),
                .branch_cond_i(lsma_instr_r.branch_cond),
                .branch_flag_o(ma_branch_flag_w[I])
            );
        end
    endgenerate
 
    assign ma_branch_mask_w = ma_branch_flag_w & lsma_mask_r; 
    assign ma_branching_w = |ma_branch_mask_w;
    
    always_comb begin
        if (lsma_instr_r.is_jalr) begin
            ma_branch_target_w = lsma_leader_target_r[XLEN-1:Z_PC];
        end else begin
            ma_branch_target_w = lsma_pc_r + lsma_instr_r.imm[31:2];
        end
    end

    // - Replay Logic

    always_comb begin
        if (lsma_instr_r.is_jalr) begin
            ma_instr_replay_mask_w = lsma_mask_r & ~lsma_coalesced_w;
        end else if (lsma_instr_r.mem_active) begin
            for (int i = 0; i < N_THREADS; i++) begin
                case (lsma_msel_r[i]) // FIXME: unique
                    MSEL_IROM: ma_instr_replay_mask_w[i] = lsma_mask_r[i] & (~lsma_coalesced_r[i]) & lsma_instr_r.mem_loadstore == MEM_LOADSTORE_LOAD;
                    MSEL_WRAM: ma_instr_replay_mask_w[i] = lsma_mask_r[i] & (~lsma_coalesced_r[i]) & ~lsma_instr_r.is_sc;
                    MSEL_TLOCAL: ma_instr_replay_mask_w[i] = '0;
                endcase
            end
        end else begin
            ma_instr_replay_mask_w = '0;
        end
    end

    assign ma_instr_retired_mask_w = lsma_mask_r & ~ma_instr_replay_mask_w;

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        masu_pc_r <= lsma_pc_r;
        masu_instr_r <= lsma_instr_r;
        masu_alu_result_r <= lsma_alu_result_w;
        masu_mask_r <= lsma_mask_r;
        masu_warp_id_r <= lsma_warp_id_r;
        masu_msel_r <= lsma_msel_r;
        masu_branch_target_r <= ma_branch_target_w;
        masu_branch_flag_r <= ma_branch_flag_w;
        masu_branch_mask_r <= ma_branch_mask_w;
        masu_branching_r <= ma_branching_w;
        masu_instr_replay_mask_r <= ma_instr_replay_mask_w;
        masu_instr_retired_mask_r <= ma_instr_retired_mask_w;
    end

    // Scheduler Update Stage

    logic [XLEN-1:0] su_wram_rdata_fmt_w;
    logic [XLEN-1:0] su_irom_rdata_fmt_w;
    logic [N_THREADS-1:0][XLEN-1:0] su_tlocal_rdata_fmt_w;

    logic [N_THREADS+1:0][XLEN-1:0] su_rfmt_in_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            su_rfmt_in_w[i] = masu_tlocal_rdata_w[i];
        end
        su_rfmt_in_w[N_THREADS] = su_wram_rdata_w;
        su_rfmt_in_w[N_THREADS+1] = su_irom_rdata_w;
    end

    logic [N_THREADS+1:0][XLEN-1:0] su_rfmt_out_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            su_tlocal_rdata_fmt_w[i] = su_rfmt_out_w[i];
        end
        su_wram_rdata_fmt_w = su_rfmt_out_w[N_THREADS];
        su_irom_rdata_fmt_w = su_rfmt_out_w[N_THREADS+1];
    end

    logic [N_THREADS+1:0][Z_ADDR-1:0] su_rfmt_alignment_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            su_rfmt_alignment_w[i] = masu_alu_result_r[i][Z_ADDR-1:0];
        end
        su_rfmt_alignment_w[N_THREADS] = masu_leader_alignment_r;
        su_rfmt_alignment_w[N_THREADS+1] = masu_leader_alignment_r;
    end

    mem_read_formatter #(
        .DATA_LEN(N_THREADS + 2)
    ) u_rfmt (
        .opsize_i(masu_instr_r.mem_opsize),
        .extendmode_i(masu_instr_r.mem_extendmode),
        .m_data_i(su_rfmt_in_w),
        .alignment_i(su_rfmt_alignment_w),
        .p_data_o(su_rfmt_out_w)
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

    // - SC Output

    logic [N_THREADS-1:0] wb_sc_output_w;
    assign wb_sc_output_w = ~suwb_leader_one_hot_r;

    logic [XLEN-1:0] wb_pc_p4_w;
    assign wb_pc_p4_w = {memwb_pc_r + 1'b1, 2'b00};

    always_comb begin
        wb_write_data_w = 'x;

        if (wb_stage_valid_r & suwb_instr_r.wb_active) begin
            case (suwb_instr_r.wb_source) // FIXME: unique
                WB_SOURCE_ALU: wb_write_data_w = suwb_alu_result_r;
                WB_SOURCE_MEM: for (int i = 0; i < N_THREADS; i++) begin
                    case (suwb_msel_r[i]) // FIXME: unique
                        MSEL_IROM: wb_write_data_w[i] = suwb_irom_data_fmt_r;
                        MSEL_WRAM: wb_write_data_w[i] = suwb_wram_rdata_fmt_r;
                        MSEL_TLOCAL: wb_write_data_w[i] = suwb_tlocal_rdata_fmt_r[i];
                    endcase
                end
                WB_SOURCE_PC_P4: for (int i = 0; i < N_THREADS; i++) wb_write_data_w[i] = wb_pc_p4_w;
                WB_SOURCE_SC: for (int i = 0; i < N_THREADS; i++) wb_write_data_w[i] = {{(XLEN-1){1'b0}}, wb_sc_output_w[i]};
            endcase
        end 
    end

    assign wb_write_en_mask_w = suwb_instr_r.wb_active ? suwb_mask_r : '0;

    // - Barrier Load Logic
    assign barr_load_total_w = suwb_wram_rdata_fmt_r[N_THREADS*2-1:N_THREADS];
    assign barr_load_parked_w = suwb_wram_rdata_fmt_r[N_THREADS-1:0];

endmodule

`default_nettype wire