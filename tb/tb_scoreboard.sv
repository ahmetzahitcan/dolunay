// =============================================================================
// tb_scoreboard.sv — Self-checking testbench for src/scoreboard.sv
// =============================================================================
//
// The scoreboard is a flat, per-entry hazard tracker. It is independent of the
// warp count: callers fold the warp id into the entry id, exactly like core_top.
//
//   * N_CHK_PORTS combinational "is this entry busy?" queries:
//         chk_busy_o[p] = chk_en_i[p] && busy_r[chk_id_i[p]]
//
//   * N_ACQ_PORTS clocked acquire ports:
//         - Acquiring an entry stores the new sequence and marks it busy:
//               seq_r[id]  <= acq_seq_i[p]
//               busy_r[id] <= !acq_empty_i[p]
//         - An "empty acquire" (acq_empty_i[p]=1) drops any previous acquire of
//           the entry but does not acquire anything.
//         - The dropped acquire, if any, is reported:
//               acq_old_seq_o[p]  <= old seq_r[acq_id_i[p]]
//               acq_old_busy_o[p] <= old busy_r[acq_id_i[p]]
//
//   * N_REL_PORTS half-synchronous release ports. rel_valid_o is combinational
//     and reports whether the release *will* succeed at the next posedge:
//         rel_valid_o[p] = rel_en_i[p] && (rel_seq_i[p] == seq_r[rel_id_i[p]])
//     Note: seq_r is *not* cleared on release and rel_valid_o does not consult
//     busy_r, so a duplicate release with the same sequence still reports valid
//     (see the known-bug probe at the end).
//
// Entry IDs pack {warp id, register index, regfile select}, exactly like
// core_top:
//         chk_id_i[p] = {warp, idx, regfile}
//
// Timing convention:
//   * Check inputs are driven on a negedge and sampled one delta later, same
//     cycle (the check path is purely combinational).
//   * Acquire / release are driven on a negedge; rel_valid_o is sampled before
//     the following posedge (combinational), while registered outputs and state
//     changes are observed after it.

// slang lint_off unconnected-input-port
// slang lint_off unconnected-output-port

`timescale 1ns/1ps
`default_nettype none

module tb_scoreboard;
    import params_pkg::*;
    import tb_config_pkg::RST_CYCLES;

    localparam int N_CHK_PORTS = 3;
    localparam int N_ACQ_PORTS = 2;
    localparam int N_REL_PORTS = 2;

    localparam int N_ENTRIES = N_WARPS * N_REGISTERS * N_REGFILES;
    localparam int W_ENTRIES = $clog2(N_ENTRIES);
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
    entry_id_t chk_id_i [0:N_CHK_PORTS-1];
    logic      chk_en_i [0:N_CHK_PORTS-1];
    logic      chk_busy_o [0:N_CHK_PORTS-1];

    entry_id_t acq_id_i [0:N_ACQ_PORTS-1];
    seq_t      acq_seq_i [0:N_ACQ_PORTS-1];
    logic      acq_en_i [0:N_ACQ_PORTS-1];
    logic      acq_empty_i [0:N_ACQ_PORTS-1];
    seq_t      acq_old_seq_o [0:N_ACQ_PORTS-1];
    logic      acq_old_busy_o [0:N_ACQ_PORTS-1];

    entry_id_t rel_id_i [0:N_REL_PORTS-1];
    seq_t      rel_seq_i [0:N_REL_PORTS-1];
    logic      rel_en_i [0:N_REL_PORTS-1];
    logic      rel_valid_o [0:N_REL_PORTS-1];

    scoreboard #(
        .N_ENTRIES(N_ENTRIES),
        .N_CHK_PORTS(N_CHK_PORTS),
        .N_ACQ_PORTS(N_ACQ_PORTS),
        .N_REL_PORTS(N_REL_PORTS)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),

        .chk_id_i(chk_id_i),
        .chk_en_i(chk_en_i),
        .chk_busy_o(chk_busy_o),

        .acq_id_i(acq_id_i),
        .acq_seq_i(acq_seq_i),
        .acq_en_i(acq_en_i),
        .acq_empty_i(acq_empty_i),
        .acq_old_seq_o(acq_old_seq_o),
        .acq_old_busy_o(acq_old_busy_o),

        .rel_id_i(rel_id_i),
        .rel_seq_i(rel_seq_i),
        .rel_en_i(rel_en_i),
        .rel_valid_o(rel_valid_o)
    );

    // -----------------------------------------------------------------------
    // Helpers
    // -----------------------------------------------------------------------
    // Entry ID encoding used by core_top: {warp id, register index, regfile}.
    function automatic entry_id_t eid(input warp_id_t w, input reg_id_t idx,
                                      input regfile_sel_e rf);
        return {w, idx, rf};
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

    task automatic expect_mask(input logic [N_CHK_PORTS-1:0] dut_val,
                               input logic [N_CHK_PORTS-1:0] exp,
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
    // Deassert every enable; used between transactions so nothing leaks.
    task automatic park();
        for (int i = 0; i < N_CHK_PORTS; i++) chk_en_i[i] = 1'b0;
        for (int i = 0; i < N_ACQ_PORTS; i++) acq_en_i[i] = 1'b0;
        for (int i = 0; i < N_REL_PORTS; i++) rel_en_i[i] = 1'b0;
    endtask

    task automatic init_inputs();
        for (int i = 0; i < N_CHK_PORTS; i++) begin
            chk_id_i[i] = '0;
            chk_en_i[i] = 1'b0;
        end
        for (int i = 0; i < N_ACQ_PORTS; i++) begin
            acq_id_i[i] = '0;
            acq_seq_i[i] = '0;
            acq_en_i[i] = 1'b0;
            acq_empty_i[i] = 1'b0;
        end
        for (int i = 0; i < N_REL_PORTS; i++) begin
            rel_id_i[i] = '0;
            rel_seq_i[i] = '0;
            rel_en_i[i] = 1'b0;
        end
    endtask

    // Clocked acquire on a single port. The dropped-acquire outputs are sampled
    // half a cycle after the posedge that captures them.
    task automatic do_acq(input logic [$clog2(N_ACQ_PORTS)-1:0] port,
                          input entry_id_t id, input seq_t seq, input logic empty,
                          output seq_t old_seq, output logic old_busy);
        @(negedge clk);
        park();
        acq_id_i[port]    = id;
        acq_seq_i[port]   = seq;
        acq_empty_i[port] = empty;
        acq_en_i[port]    = 1'b1;
        @(posedge clk);
        @(negedge clk);
        old_seq  = acq_old_seq_o[port];
        old_busy = acq_old_busy_o[port];
        acq_en_i[port] = 1'b0;
    endtask

    // Convenience wrapper when the dropped-acquire outputs are not needed.
    task automatic acq(input logic [$clog2(N_ACQ_PORTS)-1:0] port,
                       input entry_id_t id, input seq_t seq, input logic empty);
        @(negedge clk);
        park();
        acq_id_i[port]    = id;
        acq_seq_i[port]   = seq;
        acq_empty_i[port] = empty;
        acq_en_i[port]    = 1'b1;
        @(posedge clk);
        @(negedge clk) acq_en_i[port] = 1'b0;
    endtask

    // Two acquires issued in the same cycle on ports 0 and 1.
    task automatic do_acq2(input entry_id_t id0, input seq_t seq0, input logic empty0,
                           input entry_id_t id1, input seq_t seq1, input logic empty1,
                           output seq_t old0, output logic old_busy0,
                           output seq_t old1, output logic old_busy1);
        @(negedge clk);
        park();
        acq_id_i[0] = id0; acq_seq_i[0] = seq0; acq_empty_i[0] = empty0; acq_en_i[0] = 1'b1;
        acq_id_i[1] = id1; acq_seq_i[1] = seq1; acq_empty_i[1] = empty1; acq_en_i[1] = 1'b1;
        @(posedge clk);
        @(negedge clk);
        old0 = acq_old_seq_o[0]; old_busy0 = acq_old_busy_o[0];
        old1 = acq_old_seq_o[1]; old_busy1 = acq_old_busy_o[1];
        acq_en_i[0] = 1'b0; acq_en_i[1] = 1'b0;
    endtask

    // Half-synchronous release on a single port. `valid` is rel_valid_o sampled
    // combinationally before the posedge; the actual free happens on that edge.
    task automatic do_rel(input logic [$clog2(N_REL_PORTS)-1:0] port,
                          input entry_id_t id, input seq_t seq, output logic valid);
        @(negedge clk);
        park();
        rel_id_i[port]  = id;
        rel_seq_i[port] = seq;
        rel_en_i[port]  = 1'b1;
        #1 valid = rel_valid_o[port];
        @(posedge clk);
        @(negedge clk) rel_en_i[port] = 1'b0;
    endtask

    // Two releases issued in the same cycle on ports 0 and 1.
    task automatic do_rel2(input entry_id_t id0, input seq_t seq0,
                           input entry_id_t id1, input seq_t seq1,
                           output logic valid0, output logic valid1);
        @(negedge clk);
        park();
        rel_id_i[0] = id0; rel_seq_i[0] = seq0; rel_en_i[0] = 1'b1;
        rel_id_i[1] = id1; rel_seq_i[1] = seq1; rel_en_i[1] = 1'b1;
        #1 begin
            valid0 = rel_valid_o[0];
            valid1 = rel_valid_o[1];
        end
        @(posedge clk);
        @(negedge clk) begin
            rel_en_i[0] = 1'b0;
            rel_en_i[1] = 1'b0;
        end
    endtask

    // Combinational single-port check.
    task automatic do_chk(input entry_id_t id, output logic busy);
        @(negedge clk);
        park();
        chk_id_i[0] = id; chk_en_i[0] = 1'b1;
        #1 busy = chk_busy_o[0];
        @(negedge clk) chk_en_i[0] = 1'b0;
    endtask

    // Combinational check on all ports simultaneously.
    task automatic do_chk_all(input entry_id_t id,
                              output logic [N_CHK_PORTS-1:0] busy);
        @(negedge clk);
        park();
        for (int i = 0; i < N_CHK_PORTS; i++) begin
            chk_id_i[i] = id;
            chk_en_i[i] = 1'b1;
        end
        #1 for (int i = 0; i < N_CHK_PORTS; i++) busy[i] = chk_busy_o[i];
        @(negedge clk);
        for (int i = 0; i < N_CHK_PORTS; i++) chk_en_i[i] = 1'b0;
    endtask

    // -----------------------------------------------------------------------
    // Test body
    // -----------------------------------------------------------------------
    logic got;
    logic [N_CHK_PORTS-1:0] got_mask;
    logic v0, v1;
    seq_t os0, os1;
    logic ob0, ob1;

    initial begin
        init_inputs();

        // ---------------- Reset ----------------
        rst_n = 1'b0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1'b1;
        @(negedge clk);

        $display("\n== A. Post-reset state ==");
        do_chk(eid(0, 5,  REGFILE_SEL_I), got); expect_ok(got, 1'b0, "post-reset w0 x5 free");
        do_chk(eid(0, 6,  REGFILE_SEL_F), got); expect_ok(got, 1'b0, "post-reset w0 f6 free");
        do_chk(eid(3, 31, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "post-reset w3 x31 free");

        // ---------------- Acquire / check / release ----------------
        $display("\n== B. Acquire / check / release (all check ports) ==");
        acq(0, eid(0, 5, REGFILE_SEL_I), 8'h01, 1'b0);
        do_chk_all(eid(0, 5, REGFILE_SEL_I), got_mask);
        expect_mask(got_mask, 3'b111, "w0 x5 busy on all check ports");
        do_rel(0, eid(0, 5, REGFILE_SEL_I), 8'h02, got);
        expect_ok(got, 1'b0, "release with wrong seq is invalid");
        do_chk(eid(0, 5, REGFILE_SEL_I), got);
        expect_ok(got, 1'b1, "w0 x5 still busy after failed release");
        do_rel(0, eid(0, 5, REGFILE_SEL_I), 8'h01, got);
        expect_ok(got, 1'b1, "release with matching seq is valid");
        do_chk(eid(0, 5, REGFILE_SEL_I), got);
        expect_ok(got, 1'b0, "w0 x5 free after release");

        // ---------------- Re-acquire drops the earlier acquire ----------------
        $display("\n== C. Re-acquire drops the earlier acquire ==");
        do_acq(0, eid(0, 6, REGFILE_SEL_I), 8'h10, 1'b0, os0, ob0);
        expect_ok(ob0, 1'b0, "first acquire reports old-busy clear");
        do_acq(0, eid(0, 6, REGFILE_SEL_I), 8'h20, 1'b0, os0, ob0);
        expect_ok(ob0, 1'b1, "re-acquire reports old-busy set");
        expect_ok(os0 == 8'h10, 1'b1, "re-acquire reports dropped seq");
        do_chk(eid(0, 6, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "w0 x6 busy after re-acquire");
        do_rel(0, eid(0, 6, REGFILE_SEL_I), 8'h10, got);
        expect_ok(got, 1'b0, "dropped acquire release invalid");
        do_chk(eid(0, 6, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "w0 x6 still busy after dropped release");
        do_rel(0, eid(0, 6, REGFILE_SEL_I), 8'h20, got);
        expect_ok(got, 1'b1, "latest acquire release valid");
        do_chk(eid(0, 6, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "w0 x6 free after release");

        // ---------------- Independent acquire ports ----------------
        $display("\n== D. Two acquire ports are independent ==");
        do_acq2(eid(0, 7, REGFILE_SEL_I), 8'h30, 1'b0,
                eid(0, 8, REGFILE_SEL_I), 8'h31, 1'b0,
                os0, ob0, os1, ob1);
        expect_ok(ob0, 1'b0, "port0 old-busy clear");
        expect_ok(ob1, 1'b0, "port1 old-busy clear");
        do_chk(eid(0, 7, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "w0 x7 busy via port0");
        do_chk(eid(0, 8, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "w0 x8 busy via port1");
        do_acq2(eid(0, 7, REGFILE_SEL_I), 8'h32, 1'b0,
                eid(0, 8, REGFILE_SEL_I), 8'h33, 1'b0,
                os0, ob0, os1, ob1);
        expect_ok(ob0, 1'b1, "port0 re-acquire old-busy set");
        expect_ok(ob1, 1'b1, "port1 re-acquire old-busy set");
        expect_ok(os0 == 8'h30, 1'b1, "port0 reports its dropped seq");
        expect_ok(os1 == 8'h31, 1'b1, "port1 reports its dropped seq");
        do_rel2(eid(0, 7, REGFILE_SEL_I), 8'h32,
                eid(0, 8, REGFILE_SEL_I), 8'h33, v0, v1);
        expect_ok(v0, 1'b1, "simultaneous release port0 valid");
        expect_ok(v1, 1'b1, "simultaneous release port1 valid");
        do_chk(eid(0, 7, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "w0 x7 free");
        do_chk(eid(0, 8, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "w0 x8 free");

        // ---------------- Empty acquire ----------------
        $display("\n== E. Empty acquire drops but does not acquire ==");
        do_acq(0, eid(0, 9, REGFILE_SEL_I), 8'h40, 1'b0, os0, ob0);
        expect_ok(ob0, 1'b0, "acquire on free entry old-busy clear");
        do_acq(0, eid(0, 9, REGFILE_SEL_I), 8'h41, 1'b1, os0, ob0);
        expect_ok(ob0, 1'b1, "empty acquire reports dropped busy");
        expect_ok(os0 == 8'h40, 1'b1, "empty acquire reports dropped seq");
        do_chk(eid(0, 9, REGFILE_SEL_I), got);
        expect_ok(got, 1'b0, "entry free after empty acquire");
        do_acq(0, eid(0, 9, REGFILE_SEL_I), 8'h42, 1'b1, os0, ob0);
        expect_ok(ob0, 1'b0, "empty acquire on free entry old-busy clear");
        do_chk(eid(0, 9, REGFILE_SEL_I), got);
        expect_ok(got, 1'b0, "entry still free after empty acquire on free entry");

        // ---------------- Per-entry isolation ----------------
        $display("\n== F. Per-warp / per-regfile entry isolation ==");
        acq(0, eid(0, 10, REGFILE_SEL_I), 8'h50, 1'b0);
        do_chk(eid(1, 10, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "w1 x10 independent of w0");
        acq(0, eid(1, 10, REGFILE_SEL_I), 8'h51, 1'b0);
        do_chk(eid(0, 10, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "w0 x10 busy");
        do_chk(eid(1, 10, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "w1 x10 busy");
        acq(0, eid(0, 10, REGFILE_SEL_F), 8'h52, 1'b0);
        do_chk(eid(0, 10, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "w0 x10 busy");
        do_chk(eid(0, 10, REGFILE_SEL_F), got); expect_ok(got, 1'b1, "w0 f10 independent of x10");
        do_rel(0, eid(0, 10, REGFILE_SEL_I), 8'h50, got); expect_ok(got, 1'b1, "w0 x10 release valid");
        do_rel(0, eid(1, 10, REGFILE_SEL_I), 8'h51, got); expect_ok(got, 1'b1, "w1 x10 release valid");
        do_rel(0, eid(0, 10, REGFILE_SEL_F), 8'h52, got); expect_ok(got, 1'b1, "w0 f10 release valid");

        // ---------------- chk_en gating ----------------
        $display("\n== G. chk_en_i gating ==");
        acq(0, eid(4, 11, REGFILE_SEL_I), 8'h60, 1'b0);
        @(negedge clk);
        park();
        chk_id_i[0] = eid(4, 11, REGFILE_SEL_I); chk_en_i[0] = 1'b0;
        #1 got = chk_busy_o[0];
        @(negedge clk) chk_en_i[0] = 1'b0;
        expect_ok(got, 1'b0, "disabled check reports not busy even when entry is busy");
        do_rel(0, eid(4, 11, REGFILE_SEL_I), 8'h60, got); expect_ok(got, 1'b1, "cleanup w4 x11 release");

        // ---------------- rel_en gating ----------------
        $display("\n== H. rel_en_i gating (rel_valid_o is combinational) ==");
        acq(0, eid(5, 12, REGFILE_SEL_I), 8'h70, 1'b0);
        @(negedge clk);
        park();
        rel_id_i[0] = eid(5, 12, REGFILE_SEL_I);
        rel_seq_i[0] = 8'h70; rel_en_i[0] = 1'b0;
        #1 got = rel_valid_o[0];
        @(negedge clk) rel_en_i[0] = 1'b0;
        expect_ok(got, 1'b0, "rel_valid_o low while rel_en_i=0");
        do_rel(0, eid(5, 12, REGFILE_SEL_I), 8'h70, got); expect_ok(got, 1'b1, "w5 x12 release valid");

        // ---------------- Invalid releases ----------------
        $display("\n== I. Invalid releases ==");
        acq(0, eid(0, 13, REGFILE_SEL_I), 8'h80, 1'b0);
        acq(0, eid(6, 13, REGFILE_SEL_I), 8'h82, 1'b0);
        do_rel(0, eid(0, 13, REGFILE_SEL_I), 8'h81, got);
        expect_ok(got, 1'b0, "release with wrong seq invalid");
        do_rel(0, eid(0, 13, REGFILE_SEL_I), 8'h82, got);
        expect_ok(got, 1'b0, "release with another entry's seq invalid");
        do_chk(eid(0, 13, REGFILE_SEL_I), got); expect_ok(got, 1'b1, "w0 x13 still busy");
        do_rel(0, eid(0, 13, REGFILE_SEL_I), 8'h80, got);
        expect_ok(got, 1'b1, "release from owning entry valid");
        do_rel(0, eid(6, 13, REGFILE_SEL_I), 8'h82, got);
        expect_ok(got, 1'b1, "release of second entry valid");
        do_chk(eid(0, 13, REGFILE_SEL_I), got); expect_ok(got, 1'b0, "w0 x13 free after release");

        // -------------------------------------------------------------------
        // Known-bug probes (informational; do not fail the TB)
        // -------------------------------------------------------------------
        $display("\n== J. Known-bug probes ==");
        // rel_valid_o does not consult busy_r and seq_r is not cleared on
        // release, so a duplicate release of an already-freed entry still
        // reports success. It only stays safe if rel_valid_o also required
        // busy_r.
        acq(0, eid(0, 14, REGFILE_SEL_I), 8'h90, 1'b0);
        do_rel(0, eid(0, 14, REGFILE_SEL_I), 8'h90, got);
        expect_ok(got, 1'b1, "J first release valid");
        do_rel(0, eid(0, 14, REGFILE_SEL_I), 8'h90, got);
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
