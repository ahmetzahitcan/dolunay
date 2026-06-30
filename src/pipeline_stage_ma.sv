`default_nettype none

module pipeline_stage_ma
    import params_pkg::*;
    import control_unit_pkg::*;
    import pipeline_pkg::*;
#(
    parameter int W_WRAM_ADDR = 32
) (
    input wire logic clk,
    input wire logic ma_stage_valid_r,

    input wire instr_s lsma_instr_r,
    input wire logic [N_THREADS-1:0][XLEN-1:0] lsma_alu_result_r,
    input wire logic [N_THREADS-1:0] lsma_mask_r,
    input wire logic [W_WARPS-1:0] lsma_warp_id_r,
    input wire logic [XLEN-1:Z_PC] lsma_pc_r,
    input wire logic [W_THREADS-1:0] lsma_leader_id_r,
    input wire logic [N_THREADS-1:0] lsma_leader_one_hot_r,
    input wire logic lsma_leader_valid_r,
    input wire msel_e [N_THREADS-1:0] lsma_msel_r,
    input wire logic [N_THREADS-1:0][XLEN-1:0] lsma_store_data_fmt_r,
    input wire logic [N_THREADS-1:0][ADDR_ALIGN-1:0] lsma_store_wen_r,
    input wire logic [N_THREADS-1:0] lsma_coalesced_r,
    input wire logic [XLEN-1:0] lsma_leader_target_r,

    output logic [N_THREADS-1:0] ma_write_en_w,
    output logic [N_THREADS-1:0] ma_branch_flag_w,
    output logic [N_THREADS-1:0] ma_branch_mask_w,
    output logic ma_branching_w,
    output logic [XLEN-1:Z_PC] ma_branch_target_w,
    output logic [N_THREADS-1:0] ma_instr_replay_mask_w,
    output logic [N_THREADS-1:0] ma_instr_retired_mask_w,
    output logic [Z_ADDR-1:0] ma_leader_alignment_w,

    output logic [W_WRAM_ADDR-1:Z_ADDR] wram_addr_o,
    output logic [XLEN-1:0] wram_wdata_o,
    output logic [ADDR_ALIGN-1:0] wram_wen_o,
    
    output logic [N_THREADS-1:0][XLEN-1:0] su_tlocal_rdata_w
);

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            ma_write_en_w[i] = 
                ma_stage_valid_r & 
                lsma_mask_r[i] & 
                lsma_instr_r.mem_active & 
                (lsma_instr_r.mem_loadstore == MEM_LOADSTORE_STORE);
        end
    end

    assign wram_addr_o = lsma_alu_result_r[lsma_leader_id_r][W_WRAM_ADDR-1:Z_ADDR];
    assign wram_wdata_o = lsma_store_data_fmt_r[lsma_leader_id_r];
    assign wram_wen_o = (lsma_leader_valid_r & ma_write_en_w[lsma_leader_id_r]) ? lsma_store_wen_r[lsma_leader_id_r] : '0;

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

    assign ma_leader_alignment_w = lsma_alu_result_r[lsma_leader_id_r][Z_ADDR-1:0];

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin : gen_tlocal
            logic [W_TLOCAL_BANK_ADDR-1:Z_ADDR] bank_addr;
            assign bank_addr = {lsma_warp_id_r, lsma_alu_result_r[I][W_TLOCAL_ADDR_PT-1:Z_ADDR]};

            logic wen_any_w;
            assign wen_any_w = 
                ma_write_en_w[I] & 
                (lsma_msel_r[I] == MSEL_TLOCAL) &
                ~lsma_instr_r.is_sc;

            logic [ADDR_ALIGN-1:0] wen_byte_w;
            assign wen_byte_w = wen_any_w ? lsma_store_wen_r[I] : '0;

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

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin : gen_bcu
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

    always_comb begin
        if (lsma_instr_r.is_jalr) begin
            ma_instr_replay_mask_w = lsma_mask_r & ~lsma_coalesced_r;
        end else if (lsma_instr_r.mem_active) begin
            for (int i = 0; i < N_THREADS; i++) begin
                case (lsma_msel_r[i]) // FIXME: unique
                    MSEL_IROM: ma_instr_replay_mask_w[i] = lsma_mask_r[i] & (~lsma_coalesced_r[i]) & lsma_instr_r.mem_loadstore == MEM_LOADSTORE_LOAD;
                    MSEL_WRAM: ma_instr_replay_mask_w[i] = lsma_mask_r[i] & (~lsma_coalesced_r[i]) & ~lsma_instr_r.is_sc;
                    MSEL_TLOCAL: ma_instr_replay_mask_w[i] = '0;
                    default: ma_instr_replay_mask_w[i] = '0;
                endcase
            end
        end else begin
            ma_instr_replay_mask_w = '0;
        end
    end

    assign ma_instr_retired_mask_w = lsma_mask_r & ~ma_instr_replay_mask_w;

endmodule

`default_nettype wire
