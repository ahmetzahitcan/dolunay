`default_nettype none

module pipeline
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n
);

    // Stage valid registers -- indicating whether other pipeline registers are valid
    logic ws_stage_valid_r;
    logic if_stage_valid_r;
    logic id_stage_valid_r;
    logic ex_stage_valid_r;
    logic mem_stage_valid_r;
    logic wb_stage_valid_r;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            ws_stage_valid_r <= '0;
            if_stage_valid_r <= '0;
            id_stage_valid_r <= '0;
            ex_stage_valid_r <= '0;
            mem_stage_valid_r <= '0;
            wb_stage_valid_r <= '0;
        end else begin
            ws_stage_valid_r <= 1'b1;
            if_stage_valid_r <= ws_stage_valid_r;
            id_stage_valid_r <= if_stage_valid_r;
            ex_stage_valid_r <= id_stage_valid_r;
            mem_stage_valid_r <= ex_stage_valid_r;
            wb_stage_valid_r <= mem_stage_valid_r;
        end
    end

    // Cross-stage signals
    logic [W_WARPS-1:0] wsif_warp_id_r;

    logic [XLEN-1:Z_PC] ifid_pc_r;
    logic [N_THREADS-1:0] ifid_mask_r;
    logic [31:2] ifid_undec_instr32_w;
    logic [W_WARPS-1:0] ifid_warp_id_r;

    logic [N_THREADS-1:0][XLEN-1:0] idex_rs1_data_w;
    logic [N_THREADS-1:0][XLEN-1:0] idex_rs2_data_w;
    instr_s idex_instr_r;
    logic [W_WARPS-1:0] idex_warp_id_r;
    logic [XLEN-1:Z_PC] idex_pc_r;
    logic [N_THREADS-1:0] idex_mask_r;

    instr_s exmem_instr_r;
    logic [N_THREADS-1:0][XLEN-1:0] exmem_alu_result_r;
    logic [N_THREADS-1:0][XLEN-1:0] exmem_store_data_r;
    logic [XLEN-1:Z_PC] exmem_pc_r;
    logic [N_THREADS-1:0] exmem_mask_r;
    logic [W_WARPS-1:0] exmem_warp_id_r;


    logic [N_THREADS-1:0] mem_instr_replay_w;
    instr_s memwb_instr_r;
    logic [N_THREADS-1:0][XLEN-1:0] memwb_alu_result_r;
    logic [XLEN-1:Z_PC] memwb_pc_r;
    logic [N_THREADS-1:0] memwb_mask_r;
    logic [W_WARPS-1:0] memwb_warp_id_r;
    logic [N_THREADS-1:0] memwb_msel_r;
    logic [Z_ADDR-1:0] memwb_leader_alignment_r;
    logic [XLEN-1:0] memwb_shared_rdata_w;
    logic [N_THREADS-1:0][XLEN-1:0] memwb_spad_rdata_w;

    logic [N_THREADS-1:0] wb_write_en_mask_w;
    logic [N_THREADS-1:0][XLEN-1:0] wb_write_data_w;

    // Warp Select
    logic [W_WARPS-1:0] ws_warp_id_w;
    logic [W_WARPS-1:0] ws_warp_id_r;
    (* DONT_TOUCH = "true" *)
    warp_scheduler u_warp_scheduler(
        .clk(clk),
        .rst_n(rst_n),
        .skip_i(0), // TODO: implement
        .skip_warp_id_i(0), // TODO: implement
        .warp_id_o(ws_warp_id_w)
    );

    always_ff @( posedge clk ) begin
        ws_warp_id_r <= ws_warp_id_w;
        wsif_warp_id_r <= ws_warp_id_r;
    end

    // Fetch
    logic [N_WARPS-1:0][XLEN-1:Z_PC] u_thread_scheduler_pc_w;
    logic [N_WARPS-1:0][N_THREADS-1:0] u_thread_scheduler_mask_w;

    logic [XLEN-1:Z_PC] if_pc_w;
    logic [N_THREADS-1:0] if_mask_w;

    assign if_pc_w = u_thread_scheduler_pc_w[wsif_warp_id_r];   
    assign if_mask_w = u_thread_scheduler_mask_w[wsif_warp_id_r];

    // - Thread Schedulers
    generate
        for (genvar I = 0; I < N_WARPS; I++) begin
            logic en_w;
            assign en_w = exmem_warp_id_r == I & mem_stage_valid_r;

            (* DONT_TOUCH = "true" *)
            thread_scheduler u_thread_scheduler(
                .clk(clk),
                .rst_n(rst_n),
                .instr_completed_i(en_w),
                .instr_replay_i(mem_instr_replay_w),

                .yield_i(exmem_instr_r.yield & en_w),
                .binit_i(exmem_instr_r.binit & en_w),
                .bwait_i(exmem_instr_r.bwait & en_w),
                .barr_idx_i(exmem_instr_r.barr_idx),

                .branch_i(mem_branching_w & en_w),
                .pc_branch_i(mem_branch_target_w),
                .mask_branch_i(mem_branch_mask_w),

                .pc_o(u_thread_scheduler_pc_w[I]),
                .mask_o(u_thread_scheduler_mask_w[I])
            );
        end
    endgenerate

    // - Instruction Memory

    (* DONT_TOUCH = "true" *)
    instr_mem u_instr_mem(
        .clk(clk),
        .addr_i(if_pc_w),
        .undec_instr32_o(ifid_undec_instr32_w)
    );

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
    control_unit u_control_unit(
        .undec_instr32_i(ifid_undec_instr32_w),
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

    logic [XLEN-1:Z_PC] mem_leader_target_w;

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
                .result_o(ex_alu_result_w[I])
            );
        end
    endgenerate

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        exmem_instr_r <= idex_instr_r;
        exmem_alu_result_r <= ex_alu_result_w;
        exmem_store_data_r <= idex_rs2_data_w;
        exmem_mask_r <= idex_mask_r;
        exmem_pc_r <= idex_pc_r;
        exmem_warp_id_r <= idex_warp_id_r;
    end

    // Memory -- TODO: shared memory

    enum logic {MSEL_SHARED, MSEL_SPAD} [N_THREADS-1:0] mem_msel_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            mem_msel_w[i] = exmem_alu_result_r[i][XLEN-1] ? MSEL_SPAD : MSEL_SHARED;
        end
    end

    logic [N_THREADS-1:0][XLEN-1:0] mem_store_data_fmt_w;
    logic [N_THREADS-1:0][ADDR_ALIGN-1:0] mem_store_wen_w;

    // - Leader Selection

    logic [N_THREADS-1:0] mem_leader_candidates_w;

    always_comb begin
        if (exmem_instr_r.is_jalr) begin
            mem_leader_candidates_w = exmem_mask_r;
        end else if (exmem_instr_r.mem_active) begin
            for (int i = 0; i < N_THREADS; i++) begin
                mem_leader_candidates_w[i] = exmem_mask_r[i] & (mem_msel_w[i] == MSEL_SHARED);
            end
        end else begin
            mem_leader_candidates_w = 'x;
        end
    end

    logic [W_THREADS-1:0] mem_leader_id_w;

    priority_encoder #(
        .WIDTH(N_THREADS)
    ) u_priority_encoder (
        .input_i(mem_leader_candidates_w),
        .index_o(mem_leader_id_w)
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

    // - Shared Memory

    `ifndef SYNTHESIS
        always_ff @(negedge clk) begin
            if (mem_stage_valid_r & exmem_instr_r.mem_active) begin
                assert (mem_msel_w[mem_leader_id_w] == MSEL_SHARED) else $error("Leader should always have MSEL_SHARED");
            end
        end
    `endif

    logic [Z_ADDR-1:0] mem_leader_alignment_w;
    assign mem_leader_alignment_w = exmem_alu_result_r[mem_leader_id_w][Z_ADDR-1:0];

    wram #(
        .DEPTH(SHARED_MEM_DEPTH)
    ) u_shared_mem (
        .clk(clk),
        .addr_i(exmem_alu_result_r[mem_leader_id_w][W_SHARED_MEM_ADDR-1:Z_ADDR]),
        .wdata_i(mem_store_data_fmt_w[mem_leader_id_w]),
        .wen_i(mem_write_en_w[mem_leader_id_w] ? mem_store_wen_w[mem_leader_id_w] : '0),
        .rdata_o(memwb_shared_rdata_w)
    );

    // - Scratchpad

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin
            logic [W_SPAD_BANK_ADDR-1:Z_ADDR] bank_addr;
            assign bank_addr = {exmem_warp_id_r, exmem_alu_result_r[I][W_SPAD_ADDR_PT-1:Z_ADDR]};

            logic wen_any_w;
            assign wen_any_w = 
                mem_write_en_w[I] & 
                (mem_msel_w[I] == MSEL_SPAD);

            logic [ADDR_ALIGN-1:0] wen_byte_w;
            assign wen_byte_w = wen_any_w ? mem_store_wen_w[I] : '0;

            (* DONT_TOUCH = "true" *)
            wram #(
                .DEPTH(SPAD_BANK_DEPTH)
            ) u_spad_bank (
                .clk(clk),
                .addr_i(bank_addr),
                .wdata_i(mem_store_data_fmt_w[I]),
                .wen_i(wen_byte_w),
                .rdata_o(memwb_spad_rdata_w[I])
            );
        end
    endgenerate    

    // - Formatting

    logic [N_THREADS-1:0][Z_ADDR-1:0] mem_alignment_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            mem_alignment_w[i] = exmem_alu_result_r[i][Z_ADDR-1:0];
        end
    end

    mem_write_formatter #(
        .DATA_LEN(N_THREADS)
    ) u_wfmt (
        .p_data_i(exmem_store_data_r),
        .opsize_i(exmem_instr_r.mem_opsize),
        .alignment_i(mem_alignment_w),
        .m_data_o(mem_store_data_fmt_w),
        .m_wen_o(mem_store_wen_w)
    );

    // - JALR Coalescing Logic

    logic [N_THREADS-1:0] jalr_coalesced_w;

    assign mem_leader_target_w = exmem_alu_result_r[mem_leader_id_w][XLEN-1:Z_PC];

    generate
        for(genvar I = 0; I < N_THREADS; I++) begin
            assign jalr_coalesced_w[I] = exmem_alu_result_r[I][XLEN-1:Z_PC] == mem_leader_target_w;
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
                .branch_cond_i(exmem_instr_r.branch_cond),
                .branch_flag_o(mem_branch_flag_w[I])
            );
        end
    endgenerate
 
    assign mem_branch_mask_w = mem_branch_flag_w & exmem_mask_r; 
    assign mem_branching_w = |mem_branch_mask_w;
    
    always_comb begin
        if (exmem_instr_r.is_jalr) begin
            mem_branch_target_w = mem_leader_target_w;
        end else begin
            mem_branch_target_w = exmem_pc_r + exmem_instr_r.imm[31:2];
        end
    end

    // - Replay Logic

    always_comb begin
        if (exmem_instr_r.is_jalr) begin
            mem_instr_replay_w = '1; // Note: Replay value is ignored for threads that are not part of this path.
        end else if (exmem_instr_r.mem_active) begin
            for (int i = 0; i < N_THREADS; i++) begin
                mem_instr_replay_w[i] = (mem_leader_id_w != i) & (mem_msel_w[i] == MSEL_SHARED);
            end
        end else begin
            mem_instr_replay_w = '0;
        end
    end

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        memwb_instr_r <= exmem_instr_r;
        memwb_alu_result_r <= exmem_alu_result_r;
        memwb_mask_r <= exmem_mask_r;
        memwb_pc_r <= exmem_pc_r;
        memwb_warp_id_r <= exmem_warp_id_r;
        memwb_msel_r <= mem_msel_w;
        memwb_leader_alignment_r <= mem_leader_alignment_w;
    end

    // Writeback

    logic [XLEN-1:0] wb_shared_rdata_fmt_w;
    logic [N_THREADS-1:0][XLEN-1:0] wb_spad_rdata_fmt_w;

    logic [N_THREADS:0][XLEN-1:0] wb_rfmt_in_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            wb_rfmt_in_w[i] = memwb_spad_rdata_w[i];
        end
        wb_rfmt_in_w[N_THREADS] = memwb_shared_rdata_w;
    end

    logic [N_THREADS:0][XLEN-1:0] wb_rfmt_out_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            wb_spad_rdata_fmt_w[i] = wb_rfmt_out_w[i];
        end
        wb_shared_rdata_fmt_w = wb_rfmt_out_w[N_THREADS];
    end

    logic [N_THREADS:0][Z_ADDR-1:0] wb_rfmt_alignment_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            wb_rfmt_alignment_w[i] = memwb_alu_result_r[i][Z_ADDR-1:0];
        end
        wb_rfmt_alignment_w[N_THREADS] = memwb_leader_alignment_r;
    end

    mem_read_formatter #(
        .DATA_LEN(N_THREADS + 1)
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

        if (mem_stage_valid_r) begin
            case (memwb_instr_r.wb_source)
                WB_SOURCE_ALU: wb_write_data_w = memwb_alu_result_r;
                WB_SOURCE_MEM: for (int i = 0; i < N_THREADS; i++) begin
                    unique case (memwb_msel_r[i]) 
                        MSEL_SHARED: wb_write_data_w[i] = wb_shared_rdata_fmt_w;
                        MSEL_SPAD: wb_write_data_w[i] = wb_spad_rdata_fmt_w[i];
                    endcase
                end
                WB_SOURCE_PC_P4: for (int i = 0; i < N_THREADS; i++) wb_write_data_w[i] = wb_pc_p4_w;
            endcase
        end 
    end

    assign wb_write_en_mask_w = memwb_instr_r.wb_active ? memwb_mask_r : '0;

endmodule

`default_nettype wire