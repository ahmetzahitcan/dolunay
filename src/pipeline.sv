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
        .rst_n(rst_n),
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
    logic mem_stage_valid_r;
    logic wb_stage_valid_r;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            wdone_r <= '1;
            ws_stage_valid_r <= '0;
            if_stage_valid_r <= '0;
            id_stage_valid_r <= '0;
            ex_stage_valid_r <= '0;
            mem_stage_valid_r <= '0;
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
            mem_stage_valid_r <= ex_stage_valid_r;
            wb_stage_valid_r <= mem_stage_valid_r;
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

    // - Memory stage signals
    instr_s exmem_instr_r;
    logic [N_THREADS-1:0][XLEN-1:0] exmem_alu_result_r;
    logic [N_THREADS-1:0][XLEN-1:0] exmem_rs2_data_r;
    logic [XLEN-1:Z_PC] exmem_pc_r;
    logic [N_THREADS-1:0] exmem_mask_r;
    logic [W_WARPS-1:0] exmem_warp_id_r;
    logic [N_THREADS-1:0] mem_instr_replay_mask_w;

    // - Barrier signals
    logic [N_THREADS-1:0] barr_load_total_w;
    logic [N_THREADS-1:0] barr_load_parked_w;
    logic [N_WARPS-1:0][N_THREADS-1:0] barr_sync_total_w;
    logic [N_WARPS-1:0][N_THREADS-1:0] barr_sync_parked_next_w;

    // - Writeback stage signals
    instr_s memwb_instr_r;
    logic [N_THREADS-1:0][XLEN-1:0] memwb_alu_result_r;
    logic [XLEN-1:Z_PC] memwb_pc_r;
    logic [N_THREADS-1:0] memwb_mask_r;
    logic [W_WARPS-1:0] memwb_warp_id_r;
    msel_e [N_THREADS-1:0] memwb_msel_r;
    logic [Z_ADDR-1:0] memwb_leader_alignment_r;
    logic [XLEN-1:0] memwb_wram_rdata_w;
    logic [N_THREADS-1:0][XLEN-1:0] memwb_tlocal_rdata_w;
    logic [N_THREADS-1:0] memwb_sc_output_r;

    logic [N_THREADS-1:0] wb_write_en_mask_w;
    logic [N_THREADS-1:0][XLEN-1:0] wb_write_data_w;

    logic [31:0] wb_irom_data_w;

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
            assign inst_retired_w[I] = instruction_retire_w ? exmem_mask_r : '0;

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
    assign wb_irom_data_w = irom_data_b_i;

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
        exmem_instr_r <= idex_instr_r;
        exmem_alu_result_r <= ex_alu_result_w;
        exmem_rs2_data_r <= idex_rs2_data_w;
        exmem_mask_r <= idex_mask_r;
        exmem_pc_r <= idex_pc_r;
        exmem_warp_id_r <= idex_warp_id_r;
    end

    // Memory

    logic [N_WARPS-1:0][N_THREADS-1:0] mem_reservation_r;
    logic [N_WARPS-1:0][N_THREADS-1:0] mem_reservation_next_w;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            mem_reservation_r <= '0;
        end else if (mem_stage_valid_r) begin
            mem_reservation_r <= mem_reservation_next_w;
        end
    end

    always_comb begin
        mem_reservation_next_w = mem_reservation_r;
        if (exmem_instr_r.is_lr) begin
            mem_reservation_next_w[exmem_warp_id_r] = mem_reservation_r[exmem_warp_id_r] | exmem_mask_r;
        end else if (exmem_instr_r.is_sc) begin
            mem_reservation_next_w = '0;
        end
    end

    msel_e [N_THREADS-1:0] mem_msel_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            case (exmem_alu_result_r[i][XLEN-1:XLEN-2]) inside // FIXME: unique
                2'b00: mem_msel_w[i] = MSEL_IROM;
                2'b01: mem_msel_w[i] = MSEL_WRAM;
                2'b1?: mem_msel_w[i] = MSEL_TLOCAL;
                default: mem_msel_w[i] = MSEL_UNDEFINED;
            endcase
        end
    end

    logic [N_THREADS-1:0][XLEN-1:0] mem_store_data_fmt_w;
    logic [N_THREADS-1:0][ADDR_ALIGN-1:0] mem_store_wen_w;

    // - Leader Selection

    logic [N_THREADS-1:0] mem_leader_candidates_w;

    always_comb begin
        if (exmem_instr_r.mem_active) begin
            for (int i = 0; i < N_THREADS; i++) begin
                case (mem_msel_w[i]) // FIXME: unique
                    MSEL_IROM: mem_leader_candidates_w[i] = exmem_mask_r[i] & (exmem_instr_r.mem_loadstore == MEM_LOADSTORE_LOAD); // FIXME: can this be just exmem_mask_r[i]?
                    MSEL_WRAM: begin
                        if (exmem_instr_r.is_sc) begin
                            mem_leader_candidates_w[i] = mem_reservation_r[exmem_warp_id_r][i] & exmem_mask_r[i];
                        end else begin
                            mem_leader_candidates_w[i] = exmem_mask_r[i];
                        end
                    end
                    MSEL_TLOCAL: mem_leader_candidates_w[i] = '0;
                endcase
            end
        end else begin
            mem_leader_candidates_w = exmem_mask_r;
        end
    end

    logic [W_THREADS-1:0] mem_leader_id_w;
    logic [N_THREADS-1:0] mem_leader_one_hot_w;
    logic mem_leader_valid_w;

    priority_encoder #(
        .WIDTH(N_THREADS)
    ) u_mem_leader_pe (
        .input_i(mem_leader_candidates_w),
        .index_o(mem_leader_id_w),
        .one_hot_o(mem_leader_one_hot_w),
        .valid_o(mem_leader_valid_w)
    );

    // - Write Enable Signals

    logic [N_THREADS-1:0] mem_write_en_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            mem_write_en_w[i] = 
                mem_stage_valid_r & 
                exmem_mask_r[i] & 
                exmem_instr_r.mem_active & 
                (exmem_instr_r.mem_loadstore == MEM_LOADSTORE_STORE);
        end
    end

    // - Work RAM

    assign wram_addr_o = exmem_alu_result_r[mem_leader_id_w][W_WRAM_ADDR-1:Z_ADDR];
    assign wram_wdata_o = mem_store_data_fmt_w[mem_leader_id_w];
    assign wram_wen_o = (mem_leader_valid_w & mem_write_en_w[mem_leader_id_w]) ? mem_store_wen_w[mem_leader_id_w] : '0;
    assign memwb_wram_rdata_w = wram_rdata_i;

    `ifndef SYNTHESIS
        always_ff @(negedge clk) begin
            if (mem_stage_valid_r & exmem_instr_r.mem_active & mem_leader_valid_w) begin
                assert (mem_msel_w[mem_leader_id_w] != MSEL_TLOCAL) 
                    else $error("Leader cannot have MSEL_TLOCAL");

                assert (exmem_instr_r.mem_loadstore != MEM_LOADSTORE_STORE || mem_msel_w[mem_leader_id_w] != MSEL_IROM) 
                    else $error("Leader cannot have MSEL_IROM during store operation");
            end
        end
    `endif

    logic [Z_ADDR-1:0] mem_leader_alignment_w;
    assign mem_leader_alignment_w = exmem_alu_result_r[mem_leader_id_w][Z_ADDR-1:0];

    // - Thread-local Memory

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin
            logic [W_TLOCAL_BANK_ADDR-1:Z_ADDR] bank_addr;
            assign bank_addr = {exmem_warp_id_r, exmem_alu_result_r[I][W_TLOCAL_ADDR_PT-1:Z_ADDR]};

            logic wen_any_w;
            assign wen_any_w = 
                mem_write_en_w[I] & 
                (mem_msel_w[I] == MSEL_TLOCAL) &
                ~exmem_instr_r.is_sc;

            logic [ADDR_ALIGN-1:0] wen_byte_w;
            assign wen_byte_w = wen_any_w ? mem_store_wen_w[I] : '0;

            ram #(
                .DEPTH(TLOCAL_BANK_DEPTH)
            ) u_tlocal_bank (
                .clk(clk),
                .addr_i(bank_addr),
                .wdata_i(mem_store_data_fmt_w[I]),
                .wen_i(wen_byte_w),
                .rdata_o(memwb_tlocal_rdata_w[I])
            );
        end
    endgenerate    

    // - Formatting

    logic [N_THREADS-1:0][XLEN-1:0] mem_store_data_w;

    always_comb begin
        case (exmem_instr_r.mem_store_source) // FIXME: unique
            MEM_STORE_SOURCE_RS2: mem_store_data_w = exmem_rs2_data_r;
            MEM_STORE_SOURCE_BINIT: for(int i = 0; i < N_THREADS; i++) begin
                mem_store_data_w[i] = {{(XLEN-N_THREADS*2){1'b0}}, exmem_mask_r, {N_THREADS{1'b0}}};
            end
            MEM_STORE_SOURCE_BSYNC: for(int i = 0; i < N_THREADS; i++) begin
                mem_store_data_w[i] = {{(XLEN-N_THREADS*2){1'b0}}, barr_sync_total_w[exmem_warp_id_r], barr_sync_parked_next_w[exmem_warp_id_r]};
            end
            default: mem_store_data_w = 'x;
        endcase
    end

    logic [N_THREADS-1:0][Z_ADDR-1:0] mem_alignment_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            mem_alignment_w[i] = exmem_alu_result_r[i][Z_ADDR-1:0];
        end
    end

    mem_write_formatter #(
        .DATA_LEN(N_THREADS)
    ) u_wfmt (
        .p_data_i(mem_store_data_w),
        .opsize_i(exmem_instr_r.mem_opsize),
        .alignment_i(mem_alignment_w),
        .m_data_o(mem_store_data_fmt_w),
        .m_wen_o(mem_store_wen_w)
    );

    // - Coalescing Logic

    logic [XLEN-1:0] mem_leader_target_w;
    assign mem_leader_target_w = exmem_alu_result_r[mem_leader_id_w][XLEN-1:0];

    logic [N_THREADS-1:0] mem_coalesced_w;

    generate
        for(genvar I = 0; I < N_THREADS; I++) begin
            assign mem_coalesced_w[I] = exmem_alu_result_r[I][XLEN-1:0] == mem_leader_target_w;
        end
    endgenerate

    // - Branching Logic

    logic [N_THREADS-1:0] mem_branch_flag_w;
    logic [N_THREADS-1:0] mem_branch_mask_w;
    logic mem_branching_w;
    logic [XLEN-1:Z_PC] mem_branch_target_w;

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin
            (* DONT_TOUCH = "true" *)
            branch_cond_unit u_bcu(
                .alu_result_i(exmem_alu_result_r[I]),
                .coalesced_i(mem_coalesced_w[I]),
                .branch_cond_i(exmem_instr_r.branch_cond),
                .branch_flag_o(mem_branch_flag_w[I])
            );
        end
    endgenerate
 
    assign mem_branch_mask_w = mem_branch_flag_w & exmem_mask_r; 
    assign mem_branching_w = |mem_branch_mask_w;
    
    always_comb begin
        if (exmem_instr_r.is_jalr) begin
            mem_branch_target_w = mem_leader_target_w[XLEN-1:Z_PC];
        end else begin
            mem_branch_target_w = exmem_pc_r + exmem_instr_r.imm[31:2];
        end
    end

    // - Replay Logic

    always_comb begin
        if (exmem_instr_r.is_jalr) begin
            mem_instr_replay_mask_w = exmem_mask_r & ~mem_coalesced_w;
        end else if (exmem_instr_r.mem_active) begin
            for (int i = 0; i < N_THREADS; i++) begin
                case (mem_msel_w[i]) // FIXME: unique
                    MSEL_IROM: mem_instr_replay_mask_w[i] = exmem_mask_r[i] & (~mem_coalesced_w[i]) & memwb_instr_r.mem_loadstore == MEM_LOADSTORE_LOAD;
                    MSEL_WRAM: mem_instr_replay_mask_w[i] = exmem_mask_r[i] & (~mem_coalesced_w[i]) & ~exmem_instr_r.is_sc;
                    MSEL_TLOCAL: mem_instr_replay_mask_w[i] = '0;
                endcase
            end
        end else begin
            mem_instr_replay_mask_w = '0;
        end
    end

    // - SC Output

    logic [N_THREADS-1:0] mem_sc_output_w;
    assign mem_sc_output_w = ~mem_leader_one_hot_w;

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        memwb_instr_r <= exmem_instr_r;
        memwb_alu_result_r <= exmem_alu_result_r;
        memwb_mask_r <= exmem_mask_r;
        memwb_pc_r <= exmem_pc_r;
        memwb_warp_id_r <= exmem_warp_id_r;
        memwb_msel_r <= mem_msel_w;
        memwb_leader_alignment_r <= mem_leader_alignment_w;
        memwb_sc_output_r <= mem_sc_output_w;
    end

    // Writeback

    logic [XLEN-1:0] wb_wram_rdata_fmt_w;
    logic [XLEN-1:0] wb_irom_rdata_fmt_w;
    logic [N_THREADS-1:0][XLEN-1:0] wb_tlocal_rdata_fmt_w;

    logic [N_THREADS+1:0][XLEN-1:0] wb_rfmt_in_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            wb_rfmt_in_w[i] = memwb_tlocal_rdata_w[i];
        end
        wb_rfmt_in_w[N_THREADS] = memwb_wram_rdata_w;
        wb_rfmt_in_w[N_THREADS+1] = wb_irom_data_w;
    end

    logic [N_THREADS+1:0][XLEN-1:0] wb_rfmt_out_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            wb_tlocal_rdata_fmt_w[i] = wb_rfmt_out_w[i];
        end
        wb_wram_rdata_fmt_w = wb_rfmt_out_w[N_THREADS];
        wb_irom_rdata_fmt_w = wb_rfmt_out_w[N_THREADS+1];
    end

    logic [N_THREADS+1:0][Z_ADDR-1:0] wb_rfmt_alignment_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            wb_rfmt_alignment_w[i] = memwb_alu_result_r[i][Z_ADDR-1:0];
        end
        wb_rfmt_alignment_w[N_THREADS] = memwb_leader_alignment_r;
        wb_rfmt_alignment_w[N_THREADS+1] = memwb_leader_alignment_r;
    end

    mem_read_formatter #(
        .DATA_LEN(N_THREADS + 2)
    ) u_rfmt (
        .opsize_i(memwb_instr_r.mem_opsize),
        .extendmode_i(memwb_instr_r.mem_extendmode),
        .m_data_i(wb_rfmt_in_w),
        .alignment_i(wb_rfmt_alignment_w),
        .p_data_o(wb_rfmt_out_w)
    );

    logic [XLEN-1:0] wb_pc_p4_w;
    assign wb_pc_p4_w = {memwb_pc_r + 1'b1, 2'b00};

    always_comb begin
        wb_write_data_w = 'x;

        if (wb_stage_valid_r & memwb_instr_r.wb_active) begin
            case (memwb_instr_r.wb_source) // FIXME: unique
                WB_SOURCE_ALU: wb_write_data_w = memwb_alu_result_r;
                WB_SOURCE_MEM: for (int i = 0; i < N_THREADS; i++) begin
                    case (memwb_msel_r[i]) // FIXME: unique
                        MSEL_IROM: wb_write_data_w[i] = wb_irom_rdata_fmt_w;
                        MSEL_WRAM: wb_write_data_w[i] = wb_wram_rdata_fmt_w;
                        MSEL_TLOCAL: wb_write_data_w[i] = wb_tlocal_rdata_fmt_w[i];
                    endcase
                end
                WB_SOURCE_PC_P4: for (int i = 0; i < N_THREADS; i++) wb_write_data_w[i] = wb_pc_p4_w;
                WB_SOURCE_SC: for (int i = 0; i < N_THREADS; i++) wb_write_data_w[i] = {{(XLEN-1){1'b0}}, memwb_sc_output_r[i]};
            endcase
        end 
    end

    assign wb_write_en_mask_w = memwb_instr_r.wb_active ? memwb_mask_r : '0;

    // - Barrier Load Logic
    assign barr_load_total_w = wb_wram_rdata_fmt_w[N_THREADS*2-1:N_THREADS];
    assign barr_load_parked_w = wb_wram_rdata_fmt_w[N_THREADS-1:0];

endmodule

`default_nettype wire