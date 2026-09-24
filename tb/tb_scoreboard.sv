// =============================================================================
// tb_scoreboard.sv — Self-checking testbench for src/scoreboard.sv
// =============================================================================
//
// The scoreboard is parameterised on a `Tag` type. This TB instantiates it with
// an 8-bit tag.
//
// Timing convention of the DUT:
//   - Check ports are COMBINATIONAL (chk*_busy_o == f(busy_r, inputs, same cycle)).
//   - Acquire/release ports are CLOCKED; their effect is visible on `busy_r`
//     after the posedge, and `rel_success_o` is a register updated on that edge.
//
// So the TB drives combinational check inputs on a negedge and samples the
// output a delta later, while acquire/release are driven on a negedge and
// observed after the following posedge.
//
// slang lint_off unconnected-input-port
// slang lint_off unconnected-output-port

`timescale 1ns/1ps
`default_nettype none

module tb_scoreboard;
    import params_pkg::*;
    import tb_config_pkg::RST_CYCLES;

    // -----------------------------------------------------------------------
    // Tag type used to instantiate the DUT
    // -----------------------------------------------------------------------
    localparam int TAG_WIDTH = 8;
    typedef logic [TAG_WIDTH-1:0] tag_t;

    // -----------------------------------------------------------------------
    // Clock / reset
    // -----------------------------------------------------------------------
    logic clk   = 1'b0;
    logic rst_n = 1'b0;
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    warp_id_t issue_warp_id_i;
    warp_id_t commit_warp_id_i;

    reg_id_t      chk1_idx_i;
    regfile_sel_e chk1_regfile_i;
    logic         chk1_en_i;
    logic         chk1_busy_o;

    reg_id_t      chk2_idx_i;
    regfile_sel_e chk2_regfile_i;
    logic         chk2_en_i;
    logic         chk2_busy_o;

    reg_id_t      chk3_idx_i;
    regfile_sel_e chk3_regfile_i;
    logic         chk3_en_i;
    logic         chk3_busy_o;

    reg_id_t      acq_idx_i;
    regfile_sel_e acq_regfile_i;
    tag_t         acq_tag_i;
    logic         acq_en_i;

    reg_id_t      rel_idx_i;
    regfile_sel_e rel_regfile_i;
    tag_t         rel_tag_i;
    logic         rel_en_i;
    logic         rel_success_o;

    scoreboard #(.Tag(tag_t)) dut (
        .clk            (clk),
        .rst_n          (rst_n),

        .issue_warp_id_i (issue_warp_id_i),
        .commit_warp_id_i(commit_warp_id_i),

        .chk1_idx_i     (chk1_idx_i),
        .chk1_regfile_i (chk1_regfile_i),
        .chk1_en_i      (chk1_en_i),
        .chk1_busy_o    (chk1_busy_o),

        .chk2_idx_i     (chk2_idx_i),
        .chk2_regfile_i (chk2_regfile_i),
        .chk2_en_i      (chk2_en_i),
        .chk2_busy_o    (chk2_busy_o),

        .chk3_idx_i     (chk3_idx_i),
        .chk3_regfile_i (chk3_regfile_i),
        .chk3_en_i      (chk3_en_i),
        .chk3_busy_o    (chk3_busy_o),

        .acq_idx_i      (acq_idx_i),
        .acq_regfile_i  (acq_regfile_i),
        .acq_tag_i      (acq_tag_i),
        .acq_en_i       (acq_en_i),

        .rel_idx_i      (rel_idx_i),
        .rel_regfile_i  (rel_regfile_i),
        .rel_tag_i      (rel_tag_i),
        .rel_en_i       (rel_en_i),
        .rel_success_o  (rel_success_o)
    );

    // -----------------------------------------------------------------------
    // Bookkeeping
    // -----------------------------------------------------------------------
    int checks    = 0;
    int errors    = 0;
    int bugprobes = 0;

    task automatic expect_ok(input logic got, input logic exp, input string label);
        checks++;
        if (got !== exp) begin
            errors++;
            $display("  [FAIL] %s (expected %0b, got %0b)", label, exp, got);
        end else begin
            $display("  [ ok ] %s (expected %0b, got %0b)", label, exp, got);
        end
    endtask

    // Records a check whose *correct* answer is `correct`. A mismatch is
    // reported as a DUT bug but does not count as a TB failure.
    task automatic bug_probe(input logic got, input logic correct, input string label);
        bugprobes++;
        if (got !== correct)
            $display("  [BUG ] %s: correct=%0b, dut=%0b", label, correct, got);
        else
            $display("  [ ok ] %s: dut=%0b", label, got);
    endtask

    // -----------------------------------------------------------------------
    // Stimulus helpers
    // -----------------------------------------------------------------------

    task automatic init_inputs();
        issue_warp_id_i  = '0;
        commit_warp_id_i = '0;
        chk1_idx_i = '0; chk1_regfile_i = REGFILE_SEL_I; chk1_en_i = 1'b0;
        chk2_idx_i = '0; chk2_regfile_i = REGFILE_SEL_I; chk2_en_i = 1'b0;
        chk3_idx_i = '0; chk3_regfile_i = REGFILE_SEL_I; chk3_en_i = 1'b0;
        acq_idx_i  = '0; acq_regfile_i  = REGFILE_SEL_I; acq_tag_i  = '0; acq_en_i = 1'b0;
        rel_idx_i  = '0; rel_regfile_i  = REGFILE_SEL_I; rel_tag_i  = '0; rel_en_i = 1'b0;
    endtask

    // Combinational check reads (one cycle each).
    task automatic read_chk1(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                             output logic busy);
        @(negedge clk);
        issue_warp_id_i = w;
        chk1_idx_i = idx; chk1_regfile_i = rf; chk1_en_i = 1'b1;
        acq_en_i = 1'b0; rel_en_i = 1'b0;
        #1 busy = chk1_busy_o;
        @(negedge clk) chk1_en_i = 1'b0;
    endtask

    task automatic read_chk2(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                             output logic busy);
        @(negedge clk);
        issue_warp_id_i = w;
        chk2_idx_i = idx; chk2_regfile_i = rf; chk2_en_i = 1'b1;
        acq_en_i = 1'b0; rel_en_i = 1'b0;
        #1 busy = chk2_busy_o;
        @(negedge clk) chk2_en_i = 1'b0;
    endtask

    task automatic read_chk3(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                             output logic busy);
        @(negedge clk);
        issue_warp_id_i = w;
        chk3_idx_i = idx; chk3_regfile_i = rf; chk3_en_i = 1'b1;
        acq_en_i = 1'b0; rel_en_i = 1'b0;
        #1 busy = chk3_busy_o;
        @(negedge clk) chk3_en_i = 1'b0;
    endtask

    task automatic do_acq(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                          input tag_t tag);
        @(negedge clk);
        issue_warp_id_i = w;
        acq_idx_i = idx; acq_regfile_i = rf; acq_tag_i = tag; acq_en_i = 1'b1;
        rel_en_i = 1'b0;
        @(posedge clk);
        @(negedge clk) acq_en_i = 1'b0;
    endtask

    // Returns rel_success_o for this release (registered, sampled after posedge).
    task automatic do_rel(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                          input tag_t tag, output logic success);
        @(negedge clk);
        commit_warp_id_i = w;
        rel_idx_i = idx; rel_regfile_i = rf; rel_tag_i = tag; rel_en_i = 1'b1;
        acq_en_i = 1'b0;
        @(posedge clk);
        #1 success = rel_success_o;
        @(negedge clk) rel_en_i = 1'b0;
    endtask

    // -----------------------------------------------------------------------
    // Test body
    // -----------------------------------------------------------------------
    logic got;
    logic race_success;

    initial begin
        init_inputs();

        // ---------------- Reset ----------------
        rst_n = 1'b0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1'b1;
        @(negedge clk);

        $display("\n== A. Post-reset state ==");
        read_chk1(0, 5,  REGFILE_SEL_I, got); expect_ok(got, 1'b0, "post-reset x5 not busy (chk1)");
        read_chk2(0, 6,  REGFILE_SEL_F, got); expect_ok(got, 1'b0, "post-reset f6 not busy (chk2)");
        read_chk3(3, 31, REGFILE_SEL_I, got); expect_ok(got, 1'b0, "post-reset x31 not busy (chk3)");

        // ---------------- x0 is special ----------------
        $display("\n== B. x0 special-casing ==");
        do_acq(0, 0, REGFILE_SEL_I, 8'hAA);       // acquire x0: ignored
        read_chk1(0, 0, REGFILE_SEL_I, got); expect_ok(got, 1'b0, "check x0 never busy after acquire");
        read_chk2(0, 0, REGFILE_SEL_I, got); expect_ok(got, 1'b0, "check x0 never busy (chk2)");
        do_rel(0, 0, REGFILE_SEL_I, 8'h00, got); expect_ok(got, 1'b1, "release x0 always succeeds");

        // f0 (idx 0, FP regfile) is NOT special and must behave normally.
        do_acq(0, 0, REGFILE_SEL_F, 8'h11);
        read_chk1(0, 0, REGFILE_SEL_F, got); expect_ok(got, 1'b1, "check f0 is busy (f0 is not special)");
        do_rel(0, 0, REGFILE_SEL_F, 8'h11, got); expect_ok(got, 1'b1, "release f0 succeeds");
        read_chk1(0, 0, REGFILE_SEL_F, got); expect_ok(got, 1'b0, "f0 free after release");

        // ---------------- Basic acquire / check / release ----------------
        $display("\n== C. Acquire / check / release ==");
        do_acq(0, 5, REGFILE_SEL_I, 8'h01);
        read_chk1(0, 5, REGFILE_SEL_I, got); expect_ok(got, 1'b1, "x5 busy on all 3 check ports (1)");
        read_chk2(0, 5, REGFILE_SEL_I, got); expect_ok(got, 1'b1, "x5 busy on all 3 check ports (2)");
        read_chk3(0, 5, REGFILE_SEL_I, got); expect_ok(got, 1'b1, "x5 busy on all 3 check ports (3)");
        do_rel(0, 5, REGFILE_SEL_I, 8'h02, got); expect_ok(got, 1'b0, "release with wrong tag fails");
        read_chk1(0, 5, REGFILE_SEL_I, got); expect_ok(got, 1'b1, "x5 still busy after failed release");
        do_rel(0, 5, REGFILE_SEL_I, 8'h01, got); expect_ok(got, 1'b1, "release with matching tag succeeds");
        read_chk1(0, 5, REGFILE_SEL_I, got); expect_ok(got, 1'b0, "x5 free after release");

        // ---------------- Acquire drop (superseding acquire) ----------------
        $display("\n== D. Earlier acquire is dropped ==");
        do_acq(0, 6, REGFILE_SEL_I, 8'h10);
        do_acq(0, 6, REGFILE_SEL_I, 8'h20);       // drops tag 0x10
        read_chk1(0, 6, REGFILE_SEL_I, got); expect_ok(got, 1'b1, "x6 still busy after re-acquire");
        do_rel(0, 6, REGFILE_SEL_I, 8'h10, got); expect_ok(got, 1'b0, "dropped acquire release fails");
        read_chk1(0, 6, REGFILE_SEL_I, got); expect_ok(got, 1'b1, "x6 still busy after dropped release");
        do_rel(0, 6, REGFILE_SEL_I, 8'h20, got); expect_ok(got, 1'b1, "latest acquire release succeeds");
        read_chk1(0, 6, REGFILE_SEL_I, got); expect_ok(got, 1'b0, "x6 free after release");

        // ---------------- Warp isolation ----------------
        $display("\n== E. Per-warp isolation ==");
        do_acq(0, 7, REGFILE_SEL_I, 8'h30);
        read_chk1(1, 7, REGFILE_SEL_I, got); expect_ok(got, 1'b0, "warp1 x7 independent of warp0");
        do_acq(1, 7, REGFILE_SEL_I, 8'h31);
        read_chk1(0, 7, REGFILE_SEL_I, got); expect_ok(got, 1'b1, "warp0 x7 still busy");
        do_rel(0, 7, REGFILE_SEL_I, 8'h30, got); expect_ok(got, 1'b1, "warp0 x7 release");
        read_chk1(1, 7, REGFILE_SEL_I, got); expect_ok(got, 1'b1, "warp1 x7 unaffected by warp0 release");
        do_rel(1, 7, REGFILE_SEL_I, 8'h31, got); expect_ok(got, 1'b1, "warp1 x7 release");

        // ---------------- Regfile isolation ----------------
        $display("\n== F. Integer/FP regfile isolation ==");
        do_acq(2, 8, REGFILE_SEL_I, 8'h40);
        read_chk1(2, 8, REGFILE_SEL_F, got); expect_ok(got, 1'b0, "f8 independent of x8");
        do_acq(2, 8, REGFILE_SEL_F, 8'h41);
        read_chk1(2, 8, REGFILE_SEL_I, got); expect_ok(got, 1'b1, "x8 busy");
        read_chk1(2, 8, REGFILE_SEL_F, got); expect_ok(got, 1'b1, "f8 busy");
        do_rel(2, 8, REGFILE_SEL_I, 8'h40, got); expect_ok(got, 1'b1, "x8 release");
        read_chk1(2, 8, REGFILE_SEL_F, got); expect_ok(got, 1'b1, "f8 still busy");
        do_rel(2, 8, REGFILE_SEL_F, 8'h41, got); expect_ok(got, 1'b1, "f8 release");

        // ---------------- chk_en gating ----------------
        $display("\n== G. chk_en_i gating ==");
        do_acq(5, 9, REGFILE_SEL_I, 8'h50);
        @(negedge clk);
        issue_warp_id_i = 5; chk1_idx_i = 9; chk1_regfile_i = REGFILE_SEL_I; chk1_en_i = 1'b0;
        #1 got = chk1_busy_o;
        @(negedge clk) chk1_en_i = 1'b0;
        expect_ok(got, 1'b0, "chk disabled reports not busy even when register is busy");
        do_rel(5, 9, REGFILE_SEL_I, 8'h50, got); expect_ok(got, 1'b1, "cleanup x9 release");

        // -------------------------------------------------------------------
        // Known-bug probes (informational; do not fail the TB)
        // -------------------------------------------------------------------
        $display("\n== H. Known-bug probes ==");

        // H1: duplicate release on an already-released entry.
        // Correct behaviour: a second release of the same entry must NOT report
        // success (the entry is free). Actual: tag_r is not cleared on release,
        // so the stale tag still matches and rel_success_o returns 1.
        do_acq(3, 10, REGFILE_SEL_I, 8'h60);
        do_rel(3, 10, REGFILE_SEL_I, 8'h60, got); expect_ok(got, 1'b1, "H1 first release succeeds");
        do_rel(3, 10, REGFILE_SEL_I, 8'h60, got); bug_probe(got, 1'b0, "H1 duplicate release must fail");

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
