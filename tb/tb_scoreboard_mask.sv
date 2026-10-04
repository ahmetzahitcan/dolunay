// =============================================================================
// tb_scoreboard_mask.sv — Self-checking testbench for src/scoreboard_mask.sv
// =============================================================================
//
// The mask scoreboard tracks a *set* of hazard entries per warp:
//
//   * Combinational per-entry busy mask:
//         busy_o = busy_r[busy_group_id_i]
//
//   * One clocked acquire port. acq_mask_i selects the entries to acquire and
//     all of them receive the same sequence tag acq_seq_i. Acquiring an
//     already-busy entry overwrites its tag, dropping the earlier acquire, and
//     reports the dropped busy/seq per entry:
//         acq_old_busy_o[i] <= old busy_r[acq_group_id_i][i]
//         acq_old_seq_o[i]  <= old seq_r [acq_group_id_i][i]
//
//   * One clocked drop-acquire port. dacq_mask_i selects the entries to undo;
//     per entry it restores the state captured by the acquire port:
//         seq_r[dacq_group_id_i][i]  <= dacq_seq_i[i]
//         busy_r[dacq_group_id_i][i] <= !dacq_empty_i[i]
//     This mirrors the register scoreboard's drop-acquire, and is how a flushed
//     and replayed instruction undoes the acquire it made in register access.
//
//   * One half-synchronous release port. rel_valid_o is combinational and
//     reports, per entry, whether that release *will* succeed at the posedge:
//         rel_valid_o[i] = rel_mask_i[i] && busy_r[rel_group_id_i][i]
//                          && (rel_seq_i == seq_r[rel_group_id_i][i])
//
// N_ENTRIES is chosen larger than the 2 hazards used in core_top so that
// multi-entry masks (partial release, acquire/release/drop overlap) are
// exercised.
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
    warp_id_t    busy_group_id_i;
    entry_mask_t busy_o;

    warp_id_t    acq_group_id_i;
    entry_mask_t acq_mask_i;
    seq_t        acq_seq_i;
    entry_mask_t acq_old_busy_o;
    seq_t        acq_old_seq_o [0:N_ENTRIES-1];

    warp_id_t    dacq_group_id_i;
    entry_mask_t dacq_mask_i;
    seq_t        dacq_seq_i [0:N_ENTRIES-1];
    entry_mask_t dacq_empty_i;

    warp_id_t    rel_group_id_i;
    entry_mask_t rel_mask_i;
    seq_t        rel_seq_i;
    entry_mask_t rel_valid_o;

    scoreboard_mask #(
        .N_ENTRIES(N_ENTRIES)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .busy_group_id_i(busy_group_id_i),
        .busy_o(busy_o),
        .acq_group_id_i(acq_group_id_i),
        .acq_mask_i(acq_mask_i),
        .acq_seq_i(acq_seq_i),
        .acq_old_busy_o(acq_old_busy_o),
        .acq_old_seq_o(acq_old_seq_o),
        .dacq_group_id_i(dacq_group_id_i),
        .dacq_mask_i(dacq_mask_i),
        .dacq_seq_i(dacq_seq_i),
        .dacq_empty_i(dacq_empty_i),
        .rel_group_id_i(rel_group_id_i),
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

    task automatic expect_seq(input seq_t dut_val, input seq_t exp, input string label);
        checks++;
        if (dut_val !== exp) begin
            errors++;
            $display("  [FAIL] %s (expected %h, got %h)", label, exp, dut_val);
        end else begin
            $display("  [ ok ] %s (expected %h, got %h)", label, exp, dut_val);
        end
    endtask

    // -----------------------------------------------------------------------
    // Stimulus helpers
    // -----------------------------------------------------------------------
    task automatic init_inputs();
        busy_group_id_i = '0;
        acq_group_id_i  = '0;
        rel_group_id_i  = '0;
        dacq_group_id_i = '0;
        acq_mask_i = '0; acq_seq_i = '0;
        dacq_mask_i = '0; dacq_empty_i = '0;
        for (int i = 0; i < N_ENTRIES; i++) dacq_seq_i[i] = '0;
        rel_mask_i = '0; rel_seq_i = '0;
    endtask

    // Captured acquire old-value, used to drive a matching drop.
    entry_mask_t got_old_busy;
    seq_t        got_old_seq [0:N_ENTRIES-1];

    // Clocked masked acquire; also captures the reported dropped state.
    task automatic do_acq(input warp_id_t w, input entry_mask_t mask, input seq_t seq);
        @(negedge clk);
        busy_group_id_i = w; acq_group_id_i = w; rel_group_id_i = w; dacq_group_id_i = w;
        acq_mask_i = mask; acq_seq_i = seq;
        rel_mask_i = '0; dacq_mask_i = '0;
        @(posedge clk);
        @(negedge clk);
        got_old_busy = acq_old_busy_o;
        for (int i = 0; i < N_ENTRIES; i++) got_old_seq[i] = acq_old_seq_o[i];
        acq_mask_i = '0;
    endtask

    // Load dacq_seq_i from the most recent acquire's old-value capture, so the
    // drop restores exactly the state that acquire observed.
    task automatic load_dacq_seq_from_old();
        for (int i = 0; i < N_ENTRIES; i++) dacq_seq_i[i] = got_old_seq[i];
    endtask

    // Clocked masked drop-acquire. `empty` should be ~old_busy & mask.
    task automatic do_dacq(input warp_id_t w, input entry_mask_t mask, input entry_mask_t empty);
        @(negedge clk);
        busy_group_id_i = w; acq_group_id_i = w; rel_group_id_i = w; dacq_group_id_i = w;
        acq_mask_i = '0; rel_mask_i = '0;
        dacq_mask_i = mask; dacq_empty_i = empty;
        @(posedge clk);
        @(negedge clk) dacq_mask_i = '0;
    endtask

    // Half-synchronous masked release. `dut_valid` is rel_valid_o sampled
    // combinationally before the posedge; the entries free on that posedge.
    task automatic do_rel(input warp_id_t w, input entry_mask_t mask, input seq_t seq,
                          output entry_mask_t dut_valid);
        @(negedge clk);
        busy_group_id_i = w; acq_group_id_i = w; rel_group_id_i = w; dacq_group_id_i = w;
        rel_mask_i = mask; rel_seq_i = seq;
        acq_mask_i = '0; dacq_mask_i = '0;
        #1 dut_valid = rel_valid_o;
        @(posedge clk);
        @(negedge clk) rel_mask_i = '0;
    endtask

    // Read the busy mask for a given group.
    task automatic read_busy(input warp_id_t w, output entry_mask_t b);
        busy_group_id_i = w;
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
        expect_mask(got_old_busy, 4'b0000, "acquire on free entries reports old-busy clear");
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
        expect_mask(got_old_busy, 4'b0001, "re-acquire reports old-busy set");
        expect_seq(got_old_seq[0], 8'h10, "re-acquire reports dropped seq");
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

        // ---------------- Drop-acquire (rollback) ----------------
        $display("\n== G. Drop restores a previously-free entry to free ==");
        do_acq(0, 4'b0001, 8'h40);
        expect_mask(got_old_busy, 4'b0000, "acquire on free entry old-busy clear");
        read_busy(0, got); expect_mask(got, 4'b0001, "entry busy after acquire");
        load_dacq_seq_from_old();
        do_dacq(0, 4'b0001, ~got_old_busy & 4'b0001);
        read_busy(0, got); expect_mask(got, 4'b0000, "drop frees a free-before entry");

        $display("\n== H. Drop restores an older in-flight owner ==");
        do_acq(0, 4'b0001, 8'h11);                 // older owner B
        do_acq(0, 4'b0001, 8'h22);                 // younger A supersedes B
        expect_mask(got_old_busy, 4'b0001, "supersede reports old-busy set");
        expect_seq(got_old_seq[0], 8'h11, "supersede reports B's seq");
        load_dacq_seq_from_old();                   // drop A, restore B
        do_dacq(0, 4'b0001, ~got_old_busy & 4'b0001);
        read_busy(0, got); expect_mask(got, 4'b0001, "entry busy after restore");
        do_rel(0, 4'b0001, 8'h11, valid);
        expect_mask(valid, 4'b0001, "restored owner B release valid");
        read_busy(0, got); expect_mask(got, 4'b0000, "entry free after B release");

        $display("\n== I. Multi-entry drop with mixed old state ==");
        do_acq(0, 4'b0001, 8'h50);                 // bit0 busy seq 0x50
        do_acq(0, 4'b0010, 8'h51);                 // bit1 busy seq 0x51
        do_acq(0, 4'b0011, 8'h60);                 // supersede bit0, (re)acquire bit1
        expect_mask(got_old_busy, 4'b0011, "both bits were busy before");
        expect_seq(got_old_seq[0], 8'h50, "bit0 old seq");
        expect_seq(got_old_seq[1], 8'h51, "bit1 old seq");
        load_dacq_seq_from_old();
        do_dacq(0, 4'b0011, ~got_old_busy & 4'b0011); // restore both to busy
        read_busy(0, got); expect_mask(got, 4'b0011, "both bits busy after restore");
        do_rel(0, 4'b0001, 8'h50, valid); expect_mask(valid, 4'b0001, "bit0 restored owner release valid");
        do_rel(0, 4'b0010, 8'h51, valid); expect_mask(valid, 4'b0010, "bit1 restored owner release valid");
        read_busy(0, got); expect_mask(got, 4'b0000, "all bits free after restored releases");

        // ---------------- Per-warp isolation ----------------
        $display("\n== J. Per-warp isolation ==");
        do_acq(1, 4'b1111, 8'h70);          // warp 1 acquires everything
        do_rel(0, 4'b1111, 8'h70, valid);
        expect_mask(valid, 4'b0000, "warp0 release cannot touch warp1 entries");
        read_busy(0, got);
        expect_mask(got, 4'b0000, "warp0 sees its own (empty) mask");
        read_busy(1, got);
        expect_mask(got, 4'b1111, "warp1 sees its own busy mask");
        do_rel(1, 4'b1111, 8'h70, valid);
        expect_mask(valid, 4'b1111, "owning warp release valid");

        // ---------------- Duplicate / stale release ----------------
        $display("\n== K. Duplicate release on a free entry ==");
        do_acq(0, 4'b0010, 8'h71);
        do_rel(0, 4'b0010, 8'h71, valid); expect_mask(valid, 4'b0010, "first release valid");
        do_rel(0, 4'b0010, 8'h71, valid); expect_mask(valid, 4'b0000, "duplicate release invalid");
        read_busy(0, got); expect_mask(got, 4'b0000, "still free");

        // ---------------- Cross-warp drop independence ----------------
        $display("\n== L. Drop only affects the dropping group ==");
        do_acq(1, 4'b0001, 8'h72);
        load_dacq_seq_from_old();
        do_dacq(0, 4'b0001, ~got_old_busy & 4'b0001);   // drop warp 0, not warp 1
        read_busy(1, got); expect_mask(got, 4'b0001, "warp1 entry untouched by warp0 drop");
        do_rel(1, 4'b0001, 8'h72, valid); expect_mask(valid, 4'b0001, "warp1 owner release valid");

        // ---------------- Simultaneous acquire + release ----------------
        $display("\n== M. Simultaneous acquire and release ==");
        do_acq(0, 4'b0001, 8'h80);
        @(negedge clk);
        busy_group_id_i = 0; acq_group_id_i = 0; rel_group_id_i = 0; dacq_group_id_i = 0;
        rel_mask_i = 4'b0001; rel_seq_i = 8'h80;   // free bit 0
        acq_mask_i = 4'b0010; acq_seq_i = 8'h81;   // acquire bit 1
        dacq_mask_i = '0;
        #1 valid = rel_valid_o;
        @(posedge clk);
        #1 got = busy_o;
        @(negedge clk) begin rel_mask_i = '0; acq_mask_i = '0; end
        expect_mask(valid, 4'b0001, "simultaneous release recognised");
        expect_mask(got,   4'b0010, "simultaneous acquire applied");
        do_rel(0, 4'b0010, 8'h81, valid); expect_mask(valid, 4'b0010, "cleanup acquired bit");

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

    initial begin
        #100000;
        $display("\n  [FAIL] global simulation timeout");
        $display(" scoreboard_mask TB: %0d checks, %0d failures", checks, errors + 1);
        $finish;
    end

endmodule

`default_nettype wire
