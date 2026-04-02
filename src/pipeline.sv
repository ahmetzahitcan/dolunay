`default_nettype none

module pipeline
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire clk,
    input wire rst_n
);

    genvar I;

    // Stage valid registers -- indicating whether other pipeline registers are valid
    logic ws_stage_valid_r;
    logic if_stage_valid_r;
    logic id_stage_valid_r;
    logic ex_stage_valid_r;
    logic wb_stage_valid_r;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            ws_stage_valid_r <= '0;
            if_stage_valid_r <= '0;
            id_stage_valid_r <= '0;
            ex_stage_valid_r <= '0;
            wb_stage_valid_r <= '0;
        end else begin
            ws_stage_valid_r <= 1'b1;
            if_stage_valid_r <= ws_stage_valid_r;
            id_stage_valid_r <= if_stage_valid_r;
            ex_stage_valid_r <= id_stage_valid_r;
            wb_stage_valid_r <= ex_stage_valid_r;
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

    logic [N_THREADS-1:0] ex_branch_mask_w;
    logic ex_branching_w;
    logic [XLEN-1:Z_PC] ex_branch_target_w;

    instr_s exwb_instr_r;
    logic [N_THREADS-1:0][XLEN-1:0] exwb_alu_result_r;
    logic [XLEN-1:Z_PC] exwb_pc_r;
    logic [N_THREADS-1:0] exwb_mask_r;
    logic [W_WARPS-1:0] exwb_warp_id_r;

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
        for (I = 0; I < N_WARPS; I++) begin
            logic en_w;
            assign en_w = idex_warp_id_r == I & ex_stage_valid_r;

            (* DONT_TOUCH = "true" *)
            thread_scheduler u_thread_scheduler(
                .clk(clk),
                .rst_n(rst_n),
                .inc_pc_i(en_w & ~idex_instr_r.is_jalr),

                .yield_i(idex_instr_r.yield & en_w),
                .binit_i(idex_instr_r.binit & en_w),
                .bwait_i(idex_instr_r.bwait & en_w),
                .barr_idx_i(idex_instr_r.barr_idx),

                .branch_i(ex_branching_w & en_w),
                .pc_branch_i(ex_branch_target_w),
                .mask_branch_i(ex_branch_mask_w),

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

        .write_warp_id_i(exwb_warp_id_r),
        .write_en_mask_i(wb_write_en_mask_w),
        .rd_idx_i(exwb_instr_r.rd_idx),
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

    logic [N_THREADS-1:0] coalesced_w;
    logic [XLEN-1:Z_PC] leader_target_w;

    // - ALU Lanes

    logic [N_THREADS-1:0][XLEN-1:0] ex_alu_result_w;
    logic [N_THREADS-1:0] ex_branch_cond_w;

    generate
        for (I = 0; I < N_THREADS; I++) begin
            (* DONT_TOUCH = "true" *)
            alu #(
                .THREAD_ID(I)
            ) u_alu (
                .rs1_val_i(idex_rs1_data_w[I]),
                .rs2_val_i(idex_rs2_data_w[I]),
                .instr_i(idex_instr_r),
                .warp_id_i(idex_warp_id_r),
                .pc_i(idex_pc_r),
                .coalesced_i(coalesced_w[I]),
                .result_o(ex_alu_result_w[I]),
                .branch_cond_o(ex_branch_cond_w[I])
            );
        end
    endgenerate

    // - JALR Coalescing Logic

    logic [W_THREADS-1:0] leader_id_w;

    priority_encoder #(
        .WIDTH(N_THREADS)
    ) u_priority_encoder (
        .input_i(idex_mask_r),
        .index_o(leader_id_w)
    );

    assign leader_target_w = ex_alu_result_w[leader_id_w][XLEN-1:Z_PC];

    generate
        for(I = 0; I < N_THREADS; I++) begin
            assign coalesced_w[I] = ex_alu_result_w[I][XLEN-1:Z_PC] == leader_target_w;
        end
    endgenerate

    // - Branching Logic
 
    assign ex_branch_mask_w = ex_branch_cond_w & idex_mask_r; 
    assign ex_branching_w = |ex_branch_mask_w;
    assign ex_branch_target_w = idex_instr_r.is_jalr ? leader_target_w : idex_pc_r + idex_instr_r.imm[31:2];

    // - Pipeline Registers

    always_ff @( posedge clk ) begin
        exwb_instr_r <= idex_instr_r;
        exwb_alu_result_r <= ex_alu_result_w;
        exwb_mask_r <= idex_mask_r;
        exwb_pc_r <= idex_pc_r;
        exwb_warp_id_r <= idex_warp_id_r;
    end

    // Writeback

    logic [XLEN-1:0] wb_pc_p4_w;
    assign wb_pc_p4_w ={exwb_pc_r + 1'b1, 2'b00};

    assign wb_write_en_mask_w = exwb_instr_r.wb_active ? exwb_mask_r : '0;
    
    always_comb begin
        wb_write_data_w = 'x;

        if (wb_stage_valid_r) begin
            case (exwb_instr_r.wb_source)
                WB_SOURCE_ALU: wb_write_data_w = exwb_alu_result_r;
                WB_SOURCE_MEM: begin // TODO
                    $warning("LOAD operations are not implemented. Writing zero to rd instead.");
                    wb_write_data_w = '0;
                end
                WB_SOURCE_PC_P4: begin
                    for (int i = 0; i < N_THREADS; i++) begin
                        wb_write_data_w[i] = wb_pc_p4_w;
                    end
                end
            endcase
        end 
    end

endmodule

`default_nettype wire