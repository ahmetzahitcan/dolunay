`default_nettype none

// Function Unit - Load-Store Unit

module fu_lsu
    import params_pkg::*;
    import core_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,
    input wire fu_operation_s in_operation_i,

    output logic out_valid_o,
    input wire logic out_ready_i,
    output fu_result_s out_result_o,

    output logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] spad_addr_o,
    output logic [N_SPAD_BANKS-1:0][RLEN-1:0] spad_wdata_o,
    output logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0] spad_wen_o,
    input wire logic [N_SPAD_BANKS-1:0][RLEN-1:0] spad_rdata_i
);

    `ifndef SYNTHESIS
    initial assert (N_SPAD_BANKS == N_THREADS) else $error("LSU does not support N_SPAD_BANKS != N_THREADS");
    `endif

    logic [N_THREADS-1:0][W_SPAD_BANK_SEL-1:Z_SPAD_BANK_SEL] addr_sel_w;
    logic [N_THREADS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] addr_off_w;
    logic [N_THREADS-1:0][Z_ADDR-1:0] addr_align_w;
    for (genvar i = 0; i < N_THREADS; i++) begin : gen_addr
        logic [RLEN-1:0] addr_w;
        assign addr_w = in_operation_i.rs1_data[i] + in_operation_i.instr.imm;
        assign addr_sel_w[i] = addr_w[W_SPAD_BANK_SEL-1:Z_SPAD_BANK_SEL];
        assign addr_off_w[i] = addr_w[W_SPAD_BANK_ADDR-1:Z_ADDR];
        assign addr_align_w[i] = addr_w[Z_ADDR-1:0];

        // TODO: check that this is where the spad is mapped in memory
    end

    // Assigning threads to banks
    // TODO: parallel decode + prio-encoder (maybe ask agent)
    logic [N_SPAD_BANKS-1:0][W_THREADS-1:0] bank_thrid_w;
    logic [N_SPAD_BANKS-1:0] bank_accessed_w;
    simd_mask_t thread_successful_w;
    always_comb begin
        bank_thrid_w = 'x;
        bank_accessed_w = '0;
        thread_successful_w = '0;
        for (int i = 0; i < N_THREADS; i++) begin
            if (in_operation_i.mask[i] && !bank_accessed_w[addr_sel_w[i]]) begin
                bank_thrid_w[addr_sel_w[i]] = W_THREADS'(unsigned'(i));
                bank_accessed_w[addr_sel_w[i]] = 1;
                thread_successful_w[i] = 1; // FIXME: Perhaps masked threads should be considered successful.
            end
        end
    end

    simd_data_t rfmt_pdata_w;

    mem_read_formatter #(
        .DATA_LEN(N_THREADS)
     ) mem_read_formatter (
    	.opsize_i    (in_operation_i.instr.mem_opsize),
    	.extendmode_i(in_operation_i.instr.mem_extendmode),
    	.m_data_i    (m_data_i), // TODO: From spad
    	.alignment_i (addr_align_w),
    	.p_data_o    (rfmt_pdata_w)
    );

    simd_data_t wfmt_mdata_w;
    logic [N_THREADS-1:0][ADDR_ALIGN-1:0] wfmt_wen_w;

    mem_write_formatter #(
        .DATA_LEN(N_THREADS)
     ) mem_write_formatter (
    	.p_data_i   (in_operation_i.rs2_data),
    	.opsize_i   (in_operation_i.instr.mem_opsize),
    	.alignment_i(addr_align_w),
    	.m_data_o   (wfmt_mdata_w),
    	.m_wen_o    (wfmt_wen_w)
    );

endmodule

`default_nettype wire
