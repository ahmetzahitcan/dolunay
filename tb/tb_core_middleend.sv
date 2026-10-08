// =============================================================================
// tb_core_middleend.sv — Self-checking testbench for src/core_middleend.sv
// =============================================================================
//
// Scope: the "first half" of the middle-end — operand fetch and dispatch.
//   * Reads operands from the two register-file ports (rs2 on port A, rs1 then
//     rs3 on port B), with the same one-cycle, registered-read behaviour as
//     src/register_file.sv.
//   * x0 and unused operands are delivered as zero and are never fetched.
//   * Ops are dispatched to the function unit selected by the instruction, with
//     the correct operand payload and the correct warp id.
//   * The per-warp operand-fetch queues (OFQ) apply back-pressure via me_ready_o.
//   * A register-file port that is being written by the (fake) write-back unit
//     defers the read instead of capturing stale data.
//   * The warp selector prefers a warp whose target FU is ready, and otherwise
//     falls back to the fastest FU.
//
// The output/collect side is not implemented in the DUT yet, so this TB drives
// the internal `fu_out_ready_w` with `force` to let the FUs drain, and observes
// the dispatch at the middle-end's own FU interface via hierarchical reads.
// The DUT is exercised only through its ports (plus those two test hooks).
//
// =============================================================================

`timescale 1ns/1ps
`default_nettype none

module tb_core_middleend;
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
    import tb_config_pkg::RST_CYCLES;

    // -----------------------------------------------------------------------
    // Clock / reset
    // -----------------------------------------------------------------------
    logic clk   = 1'b0;
    logic rst_n = 1'b0;
    always #5 clk = ~clk;

`ifdef WAVE
    initial begin
        $dumpfile("sim/tb_core_middleend.fst");
        $dumpvars(0, tb_core_middleend);
    end
`endif

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic [N_WARPS-1:0] me_ready_o;
    logic [N_WARPS-1:0] me_valid_i;
    me_operation_s      me_op_i;

    phys_reg_id_t rfa_idx_o;
    logic         rfa_write_en_i;
    simd_data_t   rfa_data_i;

    phys_reg_id_t rfb_idx_o;
    logic         rfb_write_en_i;
    simd_data_t   rfb_data_i;

    logic         branch_complete_o;
    simd_mask_t   branch_mask_o;
    branch_type_e branch_type_o;
    warp_id_t     branch_warp_id_o;
    pc_t          branch_pc_o, branch_target_o;

    fpnew_pkg::status_t [N_WARPS-1:0][N_THREADS-1:0] fflags_i;

    core_middleend dut (
        .clk             (clk),
        .rst_n           (rst_n),
        .me_ready_o      (me_ready_o),
        .me_valid_i      (me_valid_i),
        .me_op_i         (me_op_i),
        .rfa_idx_o       (rfa_idx_o),
        .rfa_write_en_i  (rfa_write_en_i),
        .rfa_data_i      (rfa_data_i),
        .rfb_idx_o       (rfb_idx_o),
        .rfb_write_en_i  (rfb_write_en_i),
        .rfb_data_i      (rfb_data_i),
        .branch_complete_o(branch_complete_o),
        .branch_mask_o   (branch_mask_o),
        .branch_type_o   (branch_type_o),
        .branch_warp_id_o(branch_warp_id_o),
        .branch_pc_o     (branch_pc_o),
        .branch_target_o (branch_target_o),
        .fflags_i        (fflags_i)
    );

    // -----------------------------------------------------------------------
    // Register-file model — one-cycle read, per-(reg,thread) payload so operand
    // routing is observable. Port A is shared with the fake write-back unit:
    // when it owns the port its read comes from the write-back address.
    // -----------------------------------------------------------------------
    function automatic simd_data_t rf_payload(input phys_reg_id_t p);
        simd_data_t d;
        for (int t = 0; t < N_THREADS; t++)
            d[t] = 32'(int'(p) * N_THREADS + t);
        return d;
    endfunction

    phys_reg_id_t wb_addr_a = '0;
    simd_data_t   wb_data_a = '0;
    phys_reg_id_t wb_addr_b = '0;
    simd_data_t   wb_data_b = '0;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            rfa_data_i <= '0;
            rfb_data_i <= '0;
        end else begin
            rfa_data_i <= rf_payload(rfa_write_en_i ? wb_addr_a : rfa_idx_o);
            rfb_data_i <= rf_payload(rfb_write_en_i ? wb_addr_b : rfb_idx_o);
        end
    end

    function automatic simd_data_t exp_op(input logic used, input warp_id_t w,
                                          input regfile_sel_e rf, input reg_id_t idx);
        if (!used || (idx == 0 && rf == REGFILE_SEL_I)) return '0;
        return rf_payload({w, rf, idx});
    endfunction

    // -----------------------------------------------------------------------
    // Expected tables / bookkeeping
    // -----------------------------------------------------------------------
    localparam int MAX_SEQ = 8;

    logic           exp_set  [N_WARPS][MAX_SEQ];
    function_unit_e exp_fu   [N_WARPS][MAX_SEQ];
    simd_data_t     exp_rs1  [N_WARPS][MAX_SEQ];
    simd_data_t     exp_rs2  [N_WARPS][MAX_SEQ];
    simd_data_t     exp_rs3  [N_WARPS][MAX_SEQ];
    logic           disp_seen[N_WARPS][MAX_SEQ];
    int             last_seq [N_WARPS];

    int checks;
    int errors;
    int dispatches;

    bit monitor_en = 1'b0;

    localparam logic [N_FUNCTION_UNITS-1:0] READY_BJU  = 4'b0001;
    localparam logic [N_FUNCTION_UNITS-1:0] READY_CSRR = 4'b0010;
    localparam logic [N_FUNCTION_UNITS-1:0] READY_ALU  = 4'b0100;
    localparam logic [N_FUNCTION_UNITS-1:0] READY_FPU  = 4'b1000;

    task automatic fail(input string label);
        errors++;
        $display("  [FAIL] %s", label);
    endtask

    function automatic me_operation_s make_op(
        input logic [W_ROB_ADDR-1:0] s,
        input function_unit_e        fu,
        input logic r1u, input regfile_sel_e r1f, input reg_id_t r1i,
        input logic r2u, input regfile_sel_e r2f, input reg_id_t r2i,
        input logic r3u, input regfile_sel_e r3f, input reg_id_t r3i);
        me_operation_s op;
        op = '0;
        op.seq = s;
        op.pc  = '0;
        op.mask = '1;
        op.instr.fu_sel     = fu;
        op.instr.rs1_used   = r1u; op.instr.rs1_regfile = r1f; op.instr.rs1_idx = r1i;
        op.instr.rs2_used   = r2u; op.instr.rs2_regfile = r2f; op.instr.rs2_idx = r2i;
        op.instr.rs3_used   = r3u; op.instr.rs3_regfile = r3f; op.instr.rs3_idx = r3i;
        return op;
    endfunction

    task automatic clear_exp();
        for (int w = 0; w < N_WARPS; w++) begin
            last_seq[w] = -1;
            for (int s = 0; s < MAX_SEQ; s++) begin
                exp_set[w][s]   = 1'b0;
                disp_seen[w][s] = 1'b0;
                exp_fu[w][s]    = FUNCTION_UNIT_BJU;
                exp_rs1[w][s]   = '0;
                exp_rs2[w][s]   = '0;
                exp_rs3[w][s]   = '0;
            end
        end
    endtask

    function automatic bit all_dispatched();
        for (int w = 0; w < N_WARPS; w++)
            for (int s = 0; s < MAX_SEQ; s++)
                if (exp_set[w][s] && !disp_seen[w][s]) return 1'b0;
        return 1'b1;
    endfunction

    task automatic expect_op(input warp_id_t w, input me_operation_s op);
        automatic int s = int'(op.seq);
        exp_set[w][s] = 1'b1;
        exp_fu[w][s]  = op.instr.fu_sel;
        exp_rs1[w][s] = exp_op(op.instr.rs1_used, w, op.instr.rs1_regfile, op.instr.rs1_idx);
        exp_rs2[w][s] = exp_op(op.instr.rs2_used, w, op.instr.rs2_regfile, op.instr.rs2_idx);
        exp_rs3[w][s] = exp_op(op.instr.rs3_used, w, op.instr.rs3_regfile, op.instr.rs3_idx);
        checks++;
    endtask

    // Push one op into warp w's OFQ, honoring me_ready_o back-pressure.
    task automatic push_op(input warp_id_t w, input me_operation_s op);
        @(negedge clk);
        while (!me_ready_o[w]) @(negedge clk);
        me_valid_i     = '0;
        me_valid_i[w]  = 1'b1;
        me_op_i        = op;
        @(posedge clk);
        #1;
        me_valid_i = '0;
    endtask

    task automatic wait_all(input int timeout, output bit ok);
        ok = 1'b0;
        for (int i = 0; i < timeout; i++) begin
            @(negedge clk);
            if (all_dispatched()) begin ok = 1'b1; break; end
        end
    endtask

    task automatic wait_seen(input int w, input int s, input int timeout, output bit ok);
        ok = 1'b0;
        for (int i = 0; i < timeout; i++) begin
            @(negedge clk);
            if (disp_seen[w][s]) begin ok = 1'b1; break; end
        end
    endtask

    // -----------------------------------------------------------------------
    // Dispatch monitor — sampled mid-cycle, when of_dispatch_w is stable.
    // -----------------------------------------------------------------------
    always @(negedge clk) begin
        if (monitor_en && dut.of_dispatch_w) begin
            automatic int w = int'(dut.of_warp_id_r);
            automatic int s = int'(dut.of_operation_r.seq);
            dispatches++;
            checks++;
            if (!exp_set[w][s]) begin
                fail($sformatf("unexpected dispatch w=%0d seq=%0d", w, s));
            end else begin
                if (disp_seen[w][s])
                    fail($sformatf("duplicate dispatch w=%0d seq=%0d", w, s));
                if (dut.of_fu_sel_r !== exp_fu[w][s])
                    fail($sformatf("w=%0d s=%0d wrong FU got=%0d exp=%0d",
                                   w, s, int'(dut.of_fu_sel_r), int'(exp_fu[w][s])));
                if (dut.of_rs1_data_w !== exp_rs1[w][s])
                    fail($sformatf("w=%0d s=%0d wrong rs1 data", w, s));
                if (dut.of_rs2_data_w !== exp_rs2[w][s])
                    fail($sformatf("w=%0d s=%0d wrong rs2 data", w, s));
                if (dut.of_rs3_data_w !== exp_rs3[w][s])
                    fail($sformatf("w=%0d s=%0d wrong rs3 data", w, s));
                if (s <= last_seq[w])
                    fail($sformatf("w=%0d per-warp order violated (s=%0d after %0d)",
                                   w, s, last_seq[w]));
                last_seq[w] = s;
            end
            disp_seen[w][s] = 1'b1;
        end
    end

    // -----------------------------------------------------------------------
    // Simulation control
    // -----------------------------------------------------------------------
    bit ok;

    task automatic do_reset();
        monitor_en = 1'b0;
        rst_n = 1'b0;
        me_valid_i = '0;
        me_op_i    = '0;
        rfa_write_en_i = 1'b0;
        rfb_write_en_i = 1'b0;
        wb_addr_a = '0;
        wb_addr_b = '0;
        fflags_i  = '0;
        repeat (RST_CYCLES) @(negedge clk);
        rst_n = 1'b1;
        repeat (2) @(negedge clk);
        monitor_en = 1'b1;
    endtask

    initial begin
        checks = 0;
        errors = 0;
        dispatches = 0;
        // Test hook: let the FUs drain even though the collect side is unwired.
        force dut.fu_out_ready_w = 4'hF;

        // ---------------- Test 1: operand fetch / dispatch datapath -------------
        $display("\n[TEST 1] operand fetch / dispatch datapath");
        do_reset();
        clear_exp();
        begin
            me_operation_s o;
            // w0: rs1,rs2 (I)         -> ALU
            o = make_op(3'd0, FUNCTION_UNIT_ALU,  1, REGFILE_SEL_I, 5'd5, 1, REGFILE_SEL_I, 5'd7, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd0, o); push_op(3'd0, o);
            // w0: rs1(F), rs2=x0, rs3(F) -> ALU  (x0 rs2, three-reg path)
            o = make_op(3'd1, FUNCTION_UNIT_ALU,  1, REGFILE_SEL_F, 5'd2, 1, REGFILE_SEL_I, 5'd0, 1, REGFILE_SEL_F, 5'd3);
            expect_op(3'd0, o); push_op(3'd0, o);
            // w1: rs1,rs2 (I)         -> BJU
            o = make_op(3'd0, FUNCTION_UNIT_BJU,  1, REGFILE_SEL_I, 5'd1, 1, REGFILE_SEL_I, 5'd2, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd1, o); push_op(3'd1, o);
            // w1: rs1 only            -> CSRR
            o = make_op(3'd1, FUNCTION_UNIT_CSRR, 1, REGFILE_SEL_I, 5'd9, 0, REGFILE_SEL_I, 5'd0, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd1, o); push_op(3'd1, o);
            // w2: rs1,rs2,rs3 (F)     -> FPU
            o = make_op(3'd0, FUNCTION_UNIT_FPU,  1, REGFILE_SEL_F, 5'd1, 1, REGFILE_SEL_F, 5'd2, 1, REGFILE_SEL_F, 5'd3);
            expect_op(3'd2, o); push_op(3'd2, o);
            // w3: no operands         -> ALU
            o = make_op(3'd0, FUNCTION_UNIT_ALU,  0, REGFILE_SEL_I, 5'd0, 0, REGFILE_SEL_I, 5'd0, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd3, o); push_op(3'd3, o);
        end
        wait_all(1000, ok);
        if (!ok) fail("test1: not all ops dispatched");

        // ---------------- Test 2: OFQ back-pressure ----------------------------
        $display("\n[TEST 2] operand-fetch-queue back-pressure");
        force dut.fu_in_ready_w = 4'h0;      // hold the OF unit busy
        do_reset();
        clear_exp();
        begin
            me_operation_s o;
            o = make_op(3'd0, FUNCTION_UNIT_ALU, 1, REGFILE_SEL_I, 5'd3, 1, REGFILE_SEL_I, 5'd4, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd0, o); push_op(3'd0, o);   // loads into OF unit
            o = make_op(3'd1, FUNCTION_UNIT_ALU, 1, REGFILE_SEL_I, 5'd5, 1, REGFILE_SEL_I, 5'd6, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd0, o); push_op(3'd0, o);   // fills OFQ slot 1
            o = make_op(3'd2, FUNCTION_UNIT_ALU, 1, REGFILE_SEL_I, 5'd7, 1, REGFILE_SEL_I, 5'd8, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd0, o); push_op(3'd0, o);   // fills OFQ slot 2 -> full
        end
        @(negedge clk);
        checks++;
        if (me_ready_o[0] !== 1'b0) fail("test2: OFQ should report not-ready when full");
        checks++;
        if (dut.ofq_full_r[0] !== 1'b1) fail("test2: OFQ should be full");
        release dut.fu_in_ready_w;
        wait_all(1000, ok);
        if (!ok) fail("test2: ops did not drain after release");

        // ---------------- Test 3: port-A write gating / retry ------------------
        $display("\n[TEST 3] port-A write gating defers the rs2 read");
        do_reset();
        clear_exp();
        rfa_write_en_i = 1'b1;                                  // write-back owns port A
        wb_addr_a      = {3'd6, REGFILE_SEL_I, 5'd30};          // distinct address
        begin
            me_operation_s o;
            o = make_op(3'd0, FUNCTION_UNIT_ALU, 1, REGFILE_SEL_I, 5'd5, 1, REGFILE_SEL_I, 5'd7, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd0, o); push_op(3'd0, o);
        end
        repeat (5) @(negedge clk);                              // hold port A busy
        checks++;
        if (disp_seen[0][0]) fail("test3: dispatched while rs2 read was blocked");
        rfa_write_en_i = 1'b0;                                  // free port A
        wait_all(1000, ok);
        if (!ok) fail("test3: op did not dispatch after port A freed");

        // ---------------- Test 4: warp-selector priority ----------------------
        $display("\n[TEST 4] warp selector: prefer ready FU, else fastest");
        force dut.fu_in_ready_w = 4'h0;      // hold everything
        do_reset();
        clear_exp();
        begin
            me_operation_s o;
            // w1 BJU (fastest, loaded first and held), w2 ALU, w3 CSRR
            o = make_op(3'd0, FUNCTION_UNIT_BJU,  1, REGFILE_SEL_I, 5'd1, 1, REGFILE_SEL_I, 5'd2, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd1, o); push_op(3'd1, o);
            o = make_op(3'd0, FUNCTION_UNIT_ALU,  1, REGFILE_SEL_I, 5'd3, 1, REGFILE_SEL_I, 5'd4, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd2, o); push_op(3'd2, o);
            o = make_op(3'd0, FUNCTION_UNIT_CSRR, 1, REGFILE_SEL_I, 5'd5, 1, REGFILE_SEL_I, 5'd6, 0, REGFILE_SEL_I, 5'd0);
            expect_op(3'd3, o); push_op(3'd3, o);
        end
        // BJU + ALU ready, CSRR not: w1 then w2 must go, and CSRR must wait.
        force dut.fu_in_ready_w = READY_BJU | READY_ALU;
        wait_seen(2, 0, 1000, ok);
        if (!ok) fail("test4: ALU warp did not dispatch while its FU was ready");
        checks++;
        if (!disp_seen[1][0]) fail("test4: BJU warp did not dispatch first");
        checks++;
        if (disp_seen[3][0])  fail("test4: CSRR warp dispatched although its FU was busy");
        // Now let CSRR become ready too.
        force dut.fu_in_ready_w = READY_BJU | READY_ALU | READY_CSRR;
        wait_all(1000, ok);
        if (!ok) fail("test4: ops did not drain after CSRR became ready");

        // ---------------- Summary ---------------------------------------------
        release dut.fu_in_ready_w;
        release dut.fu_out_ready_w;
        $display("\n=================================================");
        $display(" core_middleend TB: %0d checks, %0d failures, %0d dispatches",
                 checks, errors, dispatches);
        if (errors == 0) $display(" RESULT: PASS");
        else             $display(" RESULT: FAIL (%0d checks failed)", errors);
        $display("=================================================\n");
        $finish;
    end

    initial begin
        #200000;
        $display("\n  [FAIL] global simulation timeout");
        $display(" core_middleend TB: %0d checks, %0d failures, %0d dispatches",
                 checks, errors + 1, dispatches);
        $display(" RESULT: FAIL (timeout)\n");
        $finish;
    end

endmodule

`default_nettype wire
