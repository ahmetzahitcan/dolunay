// =============================================================================
// tb_scoreboard_mask.sv — Self-checking testbench for src/scoreboard_mask.sv
// =============================================================================
//
// The mask scoreboard tracks a *set* of hazard entries per warp:
//
//   * Combinational per-entry busy mask:
//         busy_o = busy_r[frontend_warp_id_i]          (intended semantics)
//
//   * One clocked acquire port. acq_mask_i selects the entries to acquire and
//     all of them receive the same sequence tag acq_seq_i. Acquiring an
//     already-busy entry overwrites its tag, dropping the earlier acquire.
//
//   * One half-synchronous release port. rel_valid_o is combinational and
//     reports, per entry, whether that release *will* succeed at the posedge:
//         rel_valid_o[i] = rel_mask_i[i] && busy_r[backend_warp_id_i][i]
//                          && (rel_seq_i == seq_r[backend_warp_id_i][i])
//
// N_ENTRIES is chosen larger than the 2 hazards used in core_top so that
// multi-entry masks (partial release, acquire/release overlap) are exercised.
//
// slang lint_off unconnected-input-port
// slang lint_off unconnected-output-port

`timescale 1ns/1ps
`default_nettype none

module tb_scoreboard_mask;
    import params_pkg::*;
    import tb_config_pkg::RST_CYCLES;

    localparam int N_ENTRIES = 4;
    typedef logic [N_ENTRIES-1:0] entry_mask_t;

    // -----------------------------------------------------------------------
    // Clock / reset
    // -----------------------------------------------------------------------
    logic clk   = 1'b0;
    logic rst_n = 1'b0;
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    warp_id_t    frontend_warp_id_i;
    warp_id_t    backend_warp_id_i;
    entry_mask_t busy_o;
    entry_mask_t acq_mask_i;
    seq_t        acq_seq_i;
    entry_mask_t rel_mask_i;
    seq_t        rel_seq_i;
    entry_mask_t rel_valid_o;

    scoreboard_mask #(
        .N_ENTRIES(N_ENTRIES)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .frontend_warp_id_i(frontend_warp_id_i),
        .backend_warp_id_i(backend_warp_id_i),
        .busy_o(busy_o),
        .acq_mask_i(acq_mask_i),
        .acq_seq_i(acq_seq_i),
        .rel_mask_i(rel_mask_i),
        .rel_seq_i(rel_seq_i),
        .rel_valid_o(rel_valid_o)
    );

    // -----------------------------------------------------------------------
    // Bookkeeping
    // -----------------------------------------------------------------------
    int checks    = 0;
    int errors    = 0;
    int bugprobes = 0;

    task automatic expect_mask(input entry_mask_t dut_val, input entry_mask_t exp, input string label);
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
    task automatic bug_probe_mask(input entry_mask_t dut_val, input entry_mask_t correct, input string label);
        bugprobes++;
        if (dut_val !== correct)
            $display("  [BUG ] %s: correct=%b, dut=%b", label, correct, dut_val);
        else
            $display("  [ ok ] %s: dut=%b", label, dut_val);
    endtask

    // -----------------------------------------------------------------------
    // Stimulus helpers
    // -----------------------------------------------------------------------
    task automatic init_inputs();
        frontend_warp_id_i = '0;
        backend_warp_id_i  = '0;
        acq_mask_i = '0; acq_seq_i = '0;
        rel_mask_i = '0; rel_seq_i = '0;
    endtask

    // Clocked masked acquire.
    task automatic do_acq(input warp_id_t w, input entry_mask_t mask, input seq_t seq);
        @(negedge clk);
        frontend_warp_id_i = w;
        backend_warp_id_i  = w;
        acq_mask_i = mask; acq_seq_i = seq;
        rel_mask_i = '0;
        @(posedge clk);
        @(negedge clk) acq_mask_i = '0;
    endtask

    // Half-synchronous masked release. `dut_valid` is rel_valid_o sampled
    // combinationally before the posedge; the entries free on that posedge.
    task automatic do_rel(input warp_id_t w, input entry_mask_t mask, input seq_t seq,
                          output entry_mask_t dut_valid);
        @(negedge clk);
        frontend_warp_id_i = w;
        backend_warp_id_i  = w;
        rel_mask_i = mask; rel_seq_i = seq;
        acq_mask_i = '0;
        #1 dut_valid = rel_valid_o;
        @(posedge clk);
        @(negedge clk) rel_mask_i = '0;
    endtask

    // Read the combinational-ish busy mask for a given frontend warp.
    task automatic read_busy(input warp_id_t w, output entry_mask_t b);
        frontend_warp_id_i = w;
        #1 b = busy_o;
    endtask

    // -----------------------------------------------------------------------
    // Test body
    // -----------------------------------------------------------------------
    entry_mask_t got;
    entry_mask_t valid;

    initial begin
        init_inputs();

        // ---------------- Reset ----------------
        rst_n = 1'b0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1'b1;
        @(negedge clk);

        $display("\n== A. Post-reset state ==");
        read_busy(0, got); expect_mask(got, 4'b0000, "post-reset busy mask clear");

        // ---------------- Masked acquire / release ----------------
        $display("\n== B. Masked acquire and busy mask ==");
        do_acq(0, 4'b1010, 8'h01);
        read_busy(0, got);
        expect_mask(got, 4'b1010, "acquired bits are busy");

        $display("\n== C. Release with wrong seq ==");
        do_rel(0, 4'b1010, 8'h02, valid);
        expect_mask(valid, 4'b0000, "wrong-seq release invalid on every bit");
        read_busy(0, got);
        expect_mask(got, 4'b1010, "entries remain busy after invalid release");

        $display("\n== D. Release with matching seq ==");
        do_rel(0, 4'b1010, 8'h01, valid);
        expect_mask(valid, 4'b1010, "matching-seq release valid on released bits");
        read_busy(0, got);
        expect_mask(got, 4'b0000, "released entries free");

        $display("\n== E. Re-acquire drops the earlier acquire ==");
        do_acq(0, 4'b0001, 8'h10);
        do_acq(0, 4'b0001, 8'h20);
        do_rel(0, 4'b0001, 8'h10, valid); expect_mask(valid, 4'b0000, "dropped acquire release invalid");
        read_busy(0, got); expect_mask(got, 4'b0001, "entry still busy after dropped release");
        do_rel(0, 4'b0001, 8'h20, valid); expect_mask(valid, 4'b0001, "latest acquire release valid");
        read_busy(0, got); expect_mask(got, 4'b0000, "entry free after release");

        $display("\n== F. Partial release of a wider mask ==");
        do_acq(0, 4'b1111, 8'h30);
        do_rel(0, 4'b0101, 8'h30, valid);
        expect_mask(valid, 4'b0101, "only masked bits are released");
        read_busy(0, got);
        expect_mask(got, 4'b1010, "unreleased bits stay busy");
        do_rel(0, 4'b1010, 8'h30, valid);
        expect_mask(valid, 4'b1010, "remaining bits released");
        read_busy(0, got);
        expect_mask(got, 4'b0000, "all entries free");

        // ---------------- Per-warp isolation ----------------
        $display("\n== G. Per-warp isolation ==");
        do_acq(1, 4'b1111, 8'h40);          // warp 1 acquires everything
        do_rel(0, 4'b1111, 8'h40, valid);
        expect_mask(valid, 4'b0000, "warp0 release cannot touch warp1 entries");
        read_busy(0, got);
        expect_mask(got, 4'b0000, "warp0 sees its own (empty) mask");
        do_rel(1, 4'b1111, 8'h40, valid);
        expect_mask(valid, 4'b1111, "owning warp release valid");

        // ---------------- Duplicate / stale release ----------------
        $display("\n== H. Duplicate release on a free entry ==");
        do_acq(0, 4'b0010, 8'h50);
        do_rel(0, 4'b0010, 8'h50, valid); expect_mask(valid, 4'b0010, "first release valid");
        do_rel(0, 4'b0010, 8'h50, valid); expect_mask(valid, 4'b0000, "duplicate release invalid");
        read_busy(0, got); expect_mask(got, 4'b0000, "still free");

        // ---------------- Simultaneous acquire + release ----------------
        $display("\n== I. Simultaneous acquire and release ==");
        do_acq(0, 4'b0001, 8'h60);
        @(negedge clk);
        frontend_warp_id_i = 0; backend_warp_id_i = 0;
        rel_mask_i = 4'b0001; rel_seq_i = 8'h60;   // free bit 0
        acq_mask_i = 4'b0010; acq_seq_i = 8'h61;   // acquire bit 1
        #1 valid = rel_valid_o;
        @(posedge clk);
        #1 got = busy_o;
        @(negedge clk) begin rel_mask_i = '0; acq_mask_i = '0; end
        expect_mask(valid, 4'b0001, "simultaneous release recognised");
        expect_mask(got,   4'b0010, "simultaneous acquire applied");
        do_rel(0, 4'b0010, 8'h61, valid); expect_mask(valid, 4'b0010, "cleanup acquired bit");

        // -------------------------------------------------------------------
        // Known-bug probes (informational; do not fail the TB)
        // -------------------------------------------------------------------
        $display("\n== J. Known-bug probes ==");
        // busy_o is documented as "whether each entry is busy". With a
        // frontend_warp_id_i input it should report that warp's busy mask
        // (busy_r[frontend_warp_id_i]), but the RTL assigns the full
        // [N_WARPS-1:0][N_ENTRIES-1:0] array to the narrow N_ENTRIES-wide
        // output. That truncates to warp 0, so any other frontend warp always
        // reads an all-zero busy mask.
        do_acq(1, 4'b1111, 8'h70);          // warp 1 acquires everything
        read_busy(1, got);
        bug_probe_mask(got, 4'b1111, "busy_o reflects frontend warp 1");
        read_busy(0, got);
        expect_mask(got, 4'b0000, "warp0 still empty");

        // -------------------------------------------------------------------
        // Summary
        // -------------------------------------------------------------------
        $display("\n=================================================");
        $display(" scoreboard_mask TB: %0d checks, %0d failures, %0d bug probes", checks, errors, bugprobes);
        if (errors == 0)
            $display(" RESULT: PASS (all spec checks passed)");
        else
            $display(" RESULT: FAIL (%0d spec checks failed)", errors);
        $display("=================================================\n");

        $finish;
    end

endmodule

`default_nettype wire
