// =============================================================================
// tb_scoreboard.sv — Self-checking testbench for src/scoreboard.sv
// =============================================================================
//
// The scoreboard is a per-warp, per-entry hazard tracker:
//
//   * N_CHECK_PORTS combinational "is this entry busy?" queries:
//         chk_busy_o[p] = chk_en_i[p] && busy_r[frontend_warp_id_i][chk_id_i[p]]
//
//   * One clocked acquire port. Acquiring an already-busy entry overwrites the
//     stored sequence tag, so the earlier acquire is dropped.
//
//   * One half-synchronous release port. rel_valid_o is combinational and
//     reports whether the release *will* succeed at the next posedge:
//         rel_valid_o = rel_en_i && busy && (rel_seq_i == stored seq)
//
// Entry IDs pack {register index, regfile select}, exactly like core_top:
//         chk_id_i[p] = {idx, regfile}
//
// Timing convention:
//   * Check inputs are driven on a negedge and sampled one delta later, same
//     cycle (the check path is purely combinational).
//   * Acquire / release are driven on a negedge; rel_valid_o is sampled before
//     the following posedge, and the state change is observed after it.
//
// slang lint_off unconnected-input-port
// slang lint_off unconnected-output-port

`timescale 1ns/1ps
`default_nettype none

module tb_scoreboard;
    import params_pkg::*;
    import tb_config_pkg::RST_CYCLES;

    localparam int N_ENTRIES     = N_REGISTERS * N_REGFILES;
    localparam int N_CHECK_PORTS = 3;
    localparam int W_ENTRIES     = $clog2(N_ENTRIES);
    typedef logic [W_ENTRIES-1:0] entry_id_t;

    // -----------------------------------------------------------------------
    // Clock / reset
    // -----------------------------------------------------------------------
    logic clk   = 1'b0;
    logic rst_n = 1'b0;
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    warp_id_t frontend_warp_id_i;
    warp_id_t backend_warp_id_i;

    entry_id_t chk_id_i [0:N_CHECK_PORTS-1];
    logic      chk_en_i [0:N_CHECK_PORTS-1];
    logic      chk_busy_o [0:N_CHECK_PORTS-1];

    entry_id_t acq_id_i;
    seq_t      acq_seq_i;
    logic      acq_en_i;

    entry_id_t rel_id_i;
    seq_t      rel_seq_i;
    logic      rel_en_i;
    logic      rel_valid_o;

    scoreboard #(
        .N_ENTRIES(N_ENTRIES),
        .N_CHECK_PORTS(N_CHECK_PORTS)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),

        .frontend_warp_id_i(frontend_warp_id_i),
        .backend_warp_id_i(backend_warp_id_i),

        .chk_id_i(chk_id_i),
        .chk_en_i(chk_en_i),
        .chk_busy_o(chk_busy_o),

        .acq_id_i(acq_id_i),
        .acq_seq_i(acq_seq_i),
        .acq_en_i(acq_en_i),

        .rel_id_i(rel_id_i),
        .rel_seq_i(rel_seq_i),
        .rel_en_i(rel_en_i),
        .rel_valid_o(rel_valid_o)
    );

    // -----------------------------------------------------------------------
    // Helpers
    // -----------------------------------------------------------------------
    // Entry ID encoding used by core_top: {register index, regfile select}.
    function automatic entry_id_t eid(input reg_id_t idx, input regfile_sel_e rf);
        return {idx, rf};
    endfunction

    // -----------------------------------------------------------------------
    // Bookkeeping
    // -----------------------------------------------------------------------
    int checks    = 0;
    int errors    = 0;
    int bugprobes = 0;

    task automatic expect_ok(input logic dut_val, input logic exp, input string label);
        checks++;
        if (dut_val !== exp) begin
            errors++;
            $display("  [FAIL] %s (expected %0b, got %0b)", label, exp, dut_val);
        end else begin
            $display("  [ ok ] %s (expected %0b, got %0b)", label, exp, dut_val);
        end
    endtask

    task automatic expect_mask(input logic [N_CHECK_PORTS-1:0] dut_val,
                               input logic [N_CHECK_PORTS-1:0] exp,
                               input string label);
        checks++;
        if (dut_val !== exp) begin
            errors++;
            $display("  [FAIL] %s (expected %b, got %b)", label, exp, dut_val);
        end else begin
            $display("  [ ok ] %s (expected %b, got %b)", label, exp, dut_val);
        end
    endtask

    // Records a check whose *correct* answer is `correct`. A mismatch is
    // reported as a DUT bug but does not count as a TB failure.
    task automatic bug_probe(input logic dut_val, input logic correct, input string label);
        bugprobes++;
        if (dut_val !== correct)
            $display("  [BUG ] %s: correct=%0b, dut=%0b", label, correct, dut_val);
        else
            $display("  [ ok ] %s: dut=%0b", label, dut_val);
    endtask

    // -----------------------------------------------------------------------
    // Stimulus helpers
    // -----------------------------------------------------------------------
    task automatic init_inputs();
        frontend_warp_id_i = '0;
        backend_warp_id_i  = '0;
        for (int i = 0; i < N_CHECK_PORTS; i++) begin
            chk_id_i[i] = '0;
            chk_en_i[i] = 1'b0;
        end
        acq_id_i = '0; acq_seq_i = '0; acq_en_i = 1'b0;
        rel_id_i = '0; rel_seq_i = '0; rel_en_i = 1'b0;
    endtask

    // Clocked acquire; effect visible after the following posedge.
    task automatic do_acq(input warp_id_t w, input entry_id_t id, input seq_t seq);
        @(negedge clk);
        frontend_warp_id_i = w;
        backend_warp_id_i  = w;
        acq_id_i = id; acq_seq_i = seq; acq_en_i = 1'b1;
        rel_en_i = 1'b0;
        @(posedge clk);
        @(negedge clk) acq_en_i = 1'b0;
    endtask

    // Half-synchronous release. `valid` is rel_valid_o sampled combinationally
    // before the posedge; the actual free happens on that posedge.
    task automatic do_rel(input warp_id_t w, input entry_id_t id, input seq_t seq,
                          output logic valid);
        @(negedge clk);
        frontend_warp_id_i = w;
        backend_warp_id_i  = w;
        rel_id_i = id; rel_seq_i = seq; rel_en_i = 1'b1;
        acq_en_i = 1'b0;
        #1 valid = rel_valid_o;
        @(posedge clk);
        @(negedge clk) rel_en_i = 1'b0;
    endtask

    // Combinational single-port check.
    task automatic do_chk(input warp_id_t w, input entry_id_t id, output logic busy);
        @(negedge clk);
        frontend_warp_id_i = w;
        backend_warp_id_i  = w;
        for (int i = 0; i < N_CHECK_PORTS; i++) chk_en_i[i] = 1'b0;
        chk_id_i[0] = id; chk_en_i[0] = 1'b1;
        acq_en_i = 1'b0; rel_en_i = 1'b0;
        #1 busy = chk_busy_o[0];
        @(negedge clk);
        chk_en_i[0] = 1'b0;
    endtask

    // Combinational check on all ports simultaneously.
    task automatic do_chk_all(input warp_id_t w, input entry_id_t id,
                              output logic [N_CHECK_PORTS-1:0] busy);
        @(negedge clk);
        frontend_warp_id_i = w;
        backend_warp_id_i  = w;
        for (int i = 0; i < N_CHECK_PORTS; i++) begin
            chk_id_i[i] = id;
            chk_en_i[i] = 1'b1;
        end
        acq_en_i = 1'b0; rel_en_i = 1'b0;
        #1 for (int i = 0; i < N_CHECK_PORTS; i++) busy[i] = chk_busy_o[i];
        @(negedge clk);
        for (int i = 0; i < N_CHECK_PORTS; i++) chk_en_i[i] = 1'b0;
    endtask

    // -----------------------------------------------------------------------
    // Test body
    // -----------------------------------------------------------------------
    logic got;
    logic [N_CHECK_PORTS-1:0] got_mask;

    initial begin
        init_inputs();

        // ---------------- Reset ----------------
        rst_n = 1'b0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1'b1;
        @(negedge clk);

        $display("\n== A. Post-reset state ==");
        do_chk(0, eid(5,  REGFILE_SEL_I), got); expect_ok(got, 1'b0, "post-reset x5 free");
        do_chk(0, eid(6,  REGFILE_SEL_F), got); expect_ok(got, 1'b0, "post-reset f6 free");
        do_chk(3, eid(31, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "post-reset warp3 x31 free");

        // ---------------- Acquire / check / release ----------------
        $display("\n== B. Acquire / check / release (all 3 check ports) ==");
        do_acq(0, eid(5, REGFILE_SEL_I), 8'h01);
        do_chk_all(0, eid(5, REGFILE_SEL_I), got_mask);
        expect_mask(got_mask, 3'b111, "x5 busy on all check ports");
        do_rel(0, eid(5, REGFILE_SEL_I), 8'h02, got);
        expect_ok(got, 1'b0, "release with wrong seq is invalid");
        do_chk(0, eid(5, REGFILE_SEL_I), got);
        expect_ok(got, 1'b1, "x5 still busy after failed release");
        do_rel(0, eid(5, REGFILE_SEL_I), 8'h01, got);
        expect_ok(got, 1'b1, "release with matching seq is valid");
        do_chk(0, eid(5, REGFILE_SEL_I), got);
        expect_ok(got, 1'b0, "x5 free after release");

        // ---------------- Re-acquire drops the earlier acquire ----------------
        $display("\n== C. Re-acquire drops the earlier acquire ==");
        do_acq(0, eid(6, REGFILE_SEL_I), 8'h10);
        do_acq(0, eid(6, REGFILE_SEL_I), 8'h20);
        do_chk(0, eid(6, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "x6 busy after re-acquire");
        do_rel(0, eid(6, REGFILE_SEL_I), 8'h10, got); expect_ok(got, 1'b0, "dropped acquire release invalid");
        do_chk(0, eid(6, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "x6 still busy after dropped release");
        do_rel(0, eid(6, REGFILE_SEL_I), 8'h20, got); expect_ok(got, 1'b1, "latest acquire release valid");
        do_chk(0, eid(6, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "x6 free after release");

        // ---------------- Per-warp isolation ----------------
        $display("\n== D. Per-warp isolation ==");
        do_acq(0, eid(7, REGFILE_SEL_I), 8'h30);
        do_chk(1, eid(7, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "warp1 x7 independent of warp0");
        do_acq(1, eid(7, REGFILE_SEL_I), 8'h31);
        do_chk(0, eid(7, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "warp0 x7 still busy");
        do_rel(0, eid(7, REGFILE_SEL_I), 8'h30, got); expect_ok(got, 1'b1, "warp0 x7 release valid");
        do_chk(1, eid(7, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "warp1 x7 unaffected");
        do_rel(1, eid(7, REGFILE_SEL_I), 8'h31, got); expect_ok(got, 1'b1, "warp1 x7 release valid");
        do_chk(0, eid(7, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "warp0 x7 free");

        // ---------------- Per-entry isolation ----------------
        $display("\n== E. Per-entry isolation ==");
        do_acq(2, eid(8, REGFILE_SEL_I), 8'h40);
        do_chk(2, eid(9, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "x9 free while x8 busy");
        do_chk(2, eid(8, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "x8 busy");
        do_rel(2, eid(8, REGFILE_SEL_I), 8'h40, got); expect_ok(got, 1'b1, "x8 release valid");
        do_chk(2, eid(8, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "x8 free after release");

        // ---------------- Integer/FP entry isolation ----------------
        $display("\n== F. Integer/FP entry isolation ==");
        do_acq(3, eid(10, REGFILE_SEL_I), 8'h50);
        do_chk(3, eid(10, REGFILE_SEL_F), got); expect_ok(got, 1'b0, "f10 independent of x10");
        do_acq(3, eid(10, REGFILE_SEL_F), 8'h51);
        do_chk(3, eid(10, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "x10 busy");
        do_chk(3, eid(10, REGFILE_SEL_F), got); expect_ok(got, 1'b1, "f10 busy");
        do_rel(3, eid(10, REGFILE_SEL_I), 8'h50, got); expect_ok(got, 1'b1, "x10 release valid");
        do_chk(3, eid(10, REGFILE_SEL_F), got); expect_ok(got, 1'b1, "f10 still busy after x10 release");
        do_rel(3, eid(10, REGFILE_SEL_F), 8'h51, got); expect_ok(got, 1'b1, "f10 release valid");

        // ---------------- chk_en gating ----------------
        $display("\n== G. chk_en_i gating ==");
        do_acq(4, eid(11, REGFILE_SEL_I), 8'h60);
        @(negedge clk);
        frontend_warp_id_i = 4; chk_id_i[0] = eid(11, REGFILE_SEL_I); chk_en_i[0] = 1'b0;
        #1 got = chk_busy_o[0];
        @(negedge clk) chk_en_i[0] = 1'b0;
        expect_ok(got, 1'b0, "disabled check reports not busy even when entry is busy");
        do_rel(4, eid(11, REGFILE_SEL_I), 8'h60, got); expect_ok(got, 1'b1, "cleanup x11 release");

        // ---------------- rel_en gating ----------------
        $display("\n== H. rel_en_i gating (rel_valid_o is combinational) ==");
        do_acq(5, eid(12, REGFILE_SEL_I), 8'h70);
        @(negedge clk);
        frontend_warp_id_i = 5; rel_id_i = eid(12, REGFILE_SEL_I);
        rel_seq_i = 8'h70; rel_en_i = 1'b0;
        #1 got = rel_valid_o;
        @(negedge clk) rel_en_i = 1'b0;
        expect_ok(got, 1'b0, "rel_valid_o low while rel_en_i=0");
        do_rel(5, eid(12, REGFILE_SEL_I), 8'h70, got); expect_ok(got, 1'b1, "x12 release valid");

        // ---------------- Invalid releases ----------------
        $display("\n== I. Invalid releases ==");
        do_rel(6, eid(13, REGFILE_SEL_I), 8'h80, got);
        expect_ok(got, 1'b0, "release of never-acquired entry invalid");
        do_acq(6, eid(13, REGFILE_SEL_I), 8'h81);
        do_rel(7, eid(13, REGFILE_SEL_I), 8'h81, got);
        expect_ok(got, 1'b0, "release from wrong warp invalid");
        do_rel(6, eid(13, REGFILE_SEL_I), 8'h81, got);
        expect_ok(got, 1'b1, "release from owning warp valid");
        do_chk(6, eid(13, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "x13 free after release");

        // -------------------------------------------------------------------
        // Known-bug probes (informational; do not fail the TB)
        // -------------------------------------------------------------------
        $display("\n== J. Known-bug probes ==");
        // Once an entry is free, a second release of the same entry must not
        // report success. The stored seq is *not* cleared on release, so this
        // stays correct only because rel_valid_o also requires busy_r.
        do_acq(8, eid(14, REGFILE_SEL_I), 8'h90);
        do_rel(8, eid(14, REGFILE_SEL_I), 8'h90, got);
        expect_ok(got, 1'b1, "J first release valid");
        do_rel(8, eid(14, REGFILE_SEL_I), 8'h90, got);
        bug_probe(got, 1'b0, "J duplicate release must be invalid");

        // -------------------------------------------------------------------
        // Summary
        // -------------------------------------------------------------------
        $display("\n=================================================");
        $display(" scoreboard TB: %0d checks, %0d failures, %0d bug probes", checks, errors, bugprobes);
        if (errors == 0)
            $display(" RESULT: PASS (all spec checks passed)");
        else
            $display(" RESULT: FAIL (%0d spec checks failed)", errors);
        $display("=================================================\n");

        $finish;
    end

endmodule

`default_nettype wire
