`default_nettype none

// Function Unit - Load-Store Unit
//
// The LSU serves one warp-wide memory operation at a time. The scratchpad has
// N_SPAD_BANKS single-ported banks and several threads of the warp may target
// the same bank, so the LSU arbitrates: one thread per bank is served per
// cycle, and the threads that lost are replayed in the following cycles until
// every thread of the operation has been served.
//
// The scratchpad has a registered read (see ram.sv), so the word addressed in
// cycle N is returned in cycle N+1. The read path therefore selects the bank
// from a registered copy of the bank select.
//
// The bank and offset of an address come from params_pkg (spad_bank_of and
// spad_offset_of), see the comment there for the mapping.

module fu_lsu
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,
    input wire fu_operation_s in_operation_i,

    output logic out_valid_o,
    input wire out_ready_i,
    output fu_result_s out_result_o,

    output logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] spad_addr_o,
    output logic [N_SPAD_BANKS-1:0][RLEN-1:0] spad_wdata_o,
    output logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0] spad_wen_o,
    input wire logic [N_SPAD_BANKS-1:0][RLEN-1:0] spad_rdata_i
);

    `ifndef SYNTHESIS
    initial assert (N_SPAD_BANKS == N_THREADS) else $error("LSU does not support N_SPAD_BANKS != N_THREADS");
    `endif

    // ---------------------------------------------------------------------------
    // Operation state
    //
    // busy_r     an operation is in flight
    // done_r     the result is ready
    // last_win_r every thread was served in the previous cycle
    // pending_r  the threads that have not been served yet
    // capture_r  the threads whose read data arrives this cycle
    // rdata_r    the read data collected so far
    // ---------------------------------------------------------------------------

    logic       busy_r;
    logic       done_r;
    logic       last_win_r;
    simd_mask_t pending_r;
    simd_mask_t capture_r;
    simd_data_t rdata_r;

    // The per-thread state of the operation in flight, latched when it is
    // accepted.
    logic [N_THREADS-1:0][W_SPAD_BANKS-1:0]        bank_r;
    logic [N_THREADS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] off_r;
    logic [N_THREADS-1:0][Z_ADDR-1:0]              align_r;
    logic [N_THREADS-1:0][RLEN-1:0]                wdata_r; // formatted store data
    logic [N_THREADS-1:0][ADDR_ALIGN-1:0]          wen_r;   // formatted byte enables

    // The bank select of the previous cycle, used to pick up the read data.
    logic [N_THREADS-1:0][W_SPAD_BANKS-1:0]        sel_r;

    // The context of the operation, needed to build the result.
    seq_t       op_seq_r;
    warp_id_t   op_warp_id_r;
    pc_t        op_pc_r;
    simd_mask_t op_mask_r;
    instr_s     op_instr_r;
    logic       op_is_store_r;

    // ---------------------------------------------------------------------------
    // Handshake
    //
    // The LSU holds the operation until the back-end takes the result, so it
    // is only ready for a new operation when it is idle.
    // ---------------------------------------------------------------------------

    assign in_ready_o  = !busy_r;
    assign out_valid_o = done_r;

    logic in_fire_w;
    assign in_fire_w = in_valid_i & in_ready_o;

    // ---------------------------------------------------------------------------
    // Address decode
    // ---------------------------------------------------------------------------

    logic [N_THREADS-1:0][RLEN-1:0]                addr_w;
    logic [N_THREADS-1:0][W_SPAD_BANKS-1:0]        bank_w;
    logic [N_THREADS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] off_w;
    logic [N_THREADS-1:0][Z_ADDR-1:0]              align_w;

    for (genvar i = 0; i < N_THREADS; i++) begin : gen_addr
        assign addr_w[i] = in_operation_i.rs1_data[i] + in_operation_i.instr.imm;
        assign bank_w[i] = spad_bank_of(addr_w[i]);
        assign off_w[i]  = spad_offset_of(addr_w[i]);
        assign align_w[i] = addr_w[i][Z_ADDR-1:0];

        // TODO: check that this is where the spad is mapped in memory
    end

    logic is_store_w;
    assign is_store_w = (in_operation_i.instr.mem_loadstore == MEM_LOADSTORE_STORE);

    // The store data, already formatted into the scratchpad's byte lanes.
    simd_data_t                     wfmt_mdata_w;
    logic [N_THREADS-1:0][ADDR_ALIGN-1:0] wfmt_wen_w;

    mem_write_formatter #(
        .DATA_LEN(N_THREADS)
     ) mem_write_formatter (
    	.p_data_i   (in_operation_i.rs2_data),
    	.opsize_i   (in_operation_i.instr.mem_opsize),
    	.alignment_i(align_w),
    	.m_data_o   (wfmt_mdata_w),
    	.m_wen_o    (wfmt_wen_w)
    );

    // ---------------------------------------------------------------------------
    // Arbitration
    //
    // Every bank picks the lowest-numbered pending thread that targets it, so
    // all banks are served at the same time and the critical path does not
    // grow with the number of threads that conflict.
    // ---------------------------------------------------------------------------

    logic [N_SPAD_BANKS-1:0][W_THREADS-1:0] winner_w;
    logic [N_SPAD_BANKS-1:0]                  hit_any_w;

    always_comb begin
        for (int b = 0; b < N_SPAD_BANKS; b++) begin
            // '0 and not 'x: an unknown value reaching the comparison below
            // would make the success mask unknown, and an unknown mask is
            // silently zero under a 2-state simulator.
            winner_w[b]  = '0;
            hit_any_w[b] = 1'b0;
            for (int i = N_THREADS-1; i >= 0; i--) begin
                if (pending_r[i] && (bank_r[i] == b[W_SPAD_BANKS-1:0])) begin
                    winner_w[b]  = W_THREADS'(i);
                    hit_any_w[b] = 1'b1;
                end
            end
        end
    end

    // The threads that are served in this cycle.
    simd_mask_t success_w;
    always_comb begin
        success_w = '0;
        for (int i = 0; i < N_THREADS; i++) begin
            success_w[i] = pending_r[i] &&
                           hit_any_w[bank_r[i]] &&
                           (winner_w[bank_r[i]] == W_THREADS'(i));
        end
    end

    // Every thread is served once nothing is left pending.
    logic all_won_w;
    assign all_won_w = (pending_r & ~success_w) == '0;

    `ifndef SYNTHESIS
    always_comb begin
        assert (!$isunknown(success_w))
            else $error("LSU success mask contains an unknown value");
    end
    `endif

    // ---------------------------------------------------------------------------
    // Scratchpad access
    //
    // The bank is addressed with the winner's offset, so the word it returns
    // belongs to that winner. The write data and the byte enables are the
    // winner's, gathered by the winner's index.
    // ---------------------------------------------------------------------------

    always_comb begin
        for (int b = 0; b < N_SPAD_BANKS; b++) begin
            if (hit_any_w[b]) begin
                spad_addr_o[b]  = off_r[winner_w[b]];
                spad_wdata_o[b] = wdata_r[winner_w[b]];
                spad_wen_o[b]   = op_is_store_r ? wen_r[winner_w[b]] : '0;
            end else begin
                // Nobody asked for this bank, so it must not be written.
                spad_addr_o[b]  = '0;
                spad_wdata_o[b] = '0;
                spad_wen_o[b]   = '0;
            end
        end
    end

    // ---------------------------------------------------------------------------
    // Read path
    //
    // A thread's data is the word in the bank it asked for, so the read is a
    // mux on the thread's own bank select. A thread that lost its bank reads
    // the winner's word, which is harmless because the success mask masks it
    // off.
    //
    // The select has to be registered, because the scratchpad's read is
    // registered: the data returned in cycle N+1 belongs to the address
    // driven in cycle N.
    // ---------------------------------------------------------------------------

    always_ff @(posedge clk) begin
        for (int i = 0; i < N_THREADS; i++) begin
            sel_r[i] <= bank_r[i];
        end
    end

    // ---------------------------------------------------------------------------
    // Result
    //
    // The read data is formatted at the end, once every thread has been
    // served, so each thread's byte, half or word is taken at its own
    // alignment and extended as the instruction asks.
    // ---------------------------------------------------------------------------

    simd_data_t rfmt_pdata_w;

    mem_read_formatter #(
        .DATA_LEN(N_THREADS)
     ) mem_read_formatter (
    	.opsize_i    (op_instr_r.mem_opsize),
    	.extendmode_i(op_instr_r.mem_extendmode),
    	.m_data_i    (rdata_r),
    	.alignment_i (align_r),
    	.p_data_o    (rfmt_pdata_w)
    );

    always_comb begin
        out_result_o = '{
            seq: op_seq_r,
            warp_id: op_warp_id_r,
            instr: op_instr_r,
            pc: op_pc_r,
            mask: op_mask_r,
            // A store has no result to write back.
            wb_result: op_is_store_r ? 'x : rfmt_pdata_w,
            use_uwb: '0,
            uwb_result: 'x,
            csrw_result: 'x,
            fpu_status: 'x
        };
    end

    // ---------------------------------------------------------------------------
    // Sequencing
    // ---------------------------------------------------------------------------

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            busy_r     <= 1'b0;
            done_r     <= 1'b0;
            last_win_r <= 1'b0;
            pending_r  <= '0;
            capture_r  <= '0;
            rdata_r    <= '0;
        end else if (in_fire_w) begin
            // Accept the operation.
            busy_r     <= 1'b1;
            done_r     <= 1'b0;
            last_win_r <= 1'b0;
            pending_r  <= in_operation_i.mask;
            capture_r  <= '0;
            rdata_r    <= '0;

            for (int i = 0; i < N_THREADS; i++) begin
                bank_r[i]  <= bank_w[i];
                off_r[i]   <= off_w[i];
                align_r[i] <= align_w[i];
                wdata_r[i] <= wfmt_mdata_w[i];
                wen_r[i]   <= wfmt_wen_w[i];
            end

            op_seq_r     <= in_operation_i.seq;
            op_warp_id_r <= in_operation_i.warp_id;
            op_pc_r      <= in_operation_i.pc;
            op_mask_r    <= in_operation_i.mask;
            op_instr_r   <= in_operation_i.instr;
            op_is_store_r <= is_store_w;
        end else if (busy_r) begin
            // The read data of the threads that won in the previous cycle has
            // arrived.
            for (int i = 0; i < N_THREADS; i++) begin
                if (capture_r[i]) rdata_r[i] <= spad_rdata_i[sel_r[i]];
            end

            pending_r  <= pending_r & ~success_w;
            capture_r  <= success_w;
            last_win_r <= all_won_w;

            if (done_r) begin
                // The result is waiting to be taken by the back-end.
                if (out_ready_i) begin
                    done_r <= 1'b0;
                    busy_r <= 1'b0;
                end
            end else begin
                // The result is ready one cycle after the last thread's data
                // has been collected.
                done_r <= last_win_r;
            end
        end
    end

endmodule

`default_nettype wire
