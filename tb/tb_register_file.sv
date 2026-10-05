// =============================================================================
// tb_register_file.sv — Self-checking testbench for src/register_file.sv
// =============================================================================
//
// The DUT is a SIMD register file with two identical read/write ports, addressed
// by a single flat physical-register index (phys_reg_id_t) into a pool of
// params_pkg::N_PHYS_REGS registers:
//
//   * porta / portb: one address, one per-thread write-enable mask, one
//     write-data vector and one registered read-data output each. A port reads
//     and/or writes the single address it presents.
//
// A read output appears one clock after the address is presented. A read of the
// address a port writes in the same cycle returns the pre-write value
// (read-before-write).
//
// Checks performed:
//   A. Port B write is visible on both ports.
//   B. Port A write is visible on both ports.
//   C. Register index 0 is an ordinary register (no special zero handling).
//   D. Read-before-write on port B.
//   E. Read-before-write on port A.
//   F. Per-thread write-enable masking (driven through port A).
//   G. The top index (N_PHYS_REGS-1) works.
//   H. Distinct indices hold independent values.
//   I. Ports read independent indices in the same cycle.
//   J. Both ports write distinct indices in the same cycle.
//
// slang lint_off unconnected-input-port
// slang lint_off unconnected-output-port

`timescale 1ns/1ps
`default_nettype none

module tb_register_file;
    import params_pkg::*;

    // -----------------------------------------------------------------------
    // Clock
    // -----------------------------------------------------------------------
    logic clk = 1'b0;
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    phys_reg_id_t porta_idx_i;
    simd_mask_t   porta_write_en_mask_i;
    simd_data_t   porta_write_data_i;
    simd_data_t   porta_data_o;

    phys_reg_id_t portb_idx_i;
    simd_mask_t   portb_write_en_mask_i;
    simd_data_t   portb_write_data_i;
    simd_data_t   portb_data_o;

    register_file dut (
        .clk(clk),
        .porta_idx_i(porta_idx_i),
        .porta_write_en_mask_i(porta_write_en_mask_i),
        .porta_write_data_i(porta_write_data_i),
        .porta_data_o(porta_data_o),
        .portb_idx_i(portb_idx_i),
        .portb_write_en_mask_i(portb_write_en_mask_i),
        .portb_write_data_i(portb_write_data_i),
        .portb_data_o(portb_data_o)
    );

    // -----------------------------------------------------------------------
    // Bookkeeping
    // -----------------------------------------------------------------------
    int checks = 0;
    int errors = 0;

    task automatic expect_simd(input simd_data_t got, input simd_data_t exp, input string label);
        bit ok = 1;
        int bad = -1;
        for (int t = 0; t < N_THREADS; t++) begin
            if (got[t] !== exp[t]) begin
                ok = 0;
                if (bad < 0) bad = t;
            end
        end
        checks++;
        if (!ok) begin
            errors++;
            $display("  [FAIL] %s (thread %0d: expected %h, got %h)", label, bad, exp[bad], got[bad]);
        end else begin
            $display("  [ ok ] %s", label);
        end
    endtask

    // -----------------------------------------------------------------------
    // Stimulus helpers
    // -----------------------------------------------------------------------
    // Build a per-thread pattern: value = {tag, thread_index}.
    task automatic set_pattern(output simd_data_t d, input logic [15:0] tag);
        for (int t = 0; t < N_THREADS; t++) d[t] = {tag, t[15:0]};
    endtask

    task automatic init_inputs();
        porta_idx_i = '0; porta_write_en_mask_i = '0; porta_write_data_i = '0;
        portb_idx_i = '0; portb_write_en_mask_i = '0; portb_write_data_i = '0;
    endtask

    // ---- Port A / port B single-operation drivers -------------------------
    task automatic read_a(input phys_reg_id_t idx, output simd_data_t d);
        @(negedge clk);
        porta_idx_i = idx; porta_write_en_mask_i = '0;
        @(negedge clk);
        d = porta_data_o;
    endtask

    task automatic read_b(input phys_reg_id_t idx, output simd_data_t d);
        @(negedge clk);
        portb_idx_i = idx; portb_write_en_mask_i = '0;
        @(negedge clk);
        d = portb_data_o;
    endtask

    task automatic write_a(input phys_reg_id_t idx, input simd_mask_t mask, input simd_data_t data);
        @(negedge clk);
        porta_idx_i = idx; porta_write_en_mask_i = mask; porta_write_data_i = data;
        @(posedge clk);
        @(negedge clk);
        porta_write_en_mask_i = '0;
    endtask

    task automatic write_b(input phys_reg_id_t idx, input simd_mask_t mask, input simd_data_t data);
        @(negedge clk);
        portb_idx_i = idx; portb_write_en_mask_i = mask; portb_write_data_i = data;
        @(posedge clk);
        @(negedge clk);
        portb_write_en_mask_i = '0;
    endtask

    // Read-and-write the same index in one cycle; returns the pre-write value.
    task automatic readwrite_a(input phys_reg_id_t idx, input simd_mask_t mask, input simd_data_t data,
                               output simd_data_t d);
        @(negedge clk);
        porta_idx_i = idx; porta_write_en_mask_i = mask; porta_write_data_i = data;
        @(negedge clk);
        d = porta_data_o;
        porta_write_en_mask_i = '0;
    endtask

    task automatic readwrite_b(input phys_reg_id_t idx, input simd_mask_t mask, input simd_data_t data,
                               output simd_data_t d);
        @(negedge clk);
        portb_idx_i = idx; portb_write_en_mask_i = mask; portb_write_data_i = data;
        @(negedge clk);
        d = portb_data_o;
        portb_write_en_mask_i = '0;
    endtask

    // Read both ports with independent indices in the same cycle.
    task automatic read_both(input phys_reg_id_t ia, input phys_reg_id_t ib,
                             output simd_data_t da, output simd_data_t db);
        @(negedge clk);
        porta_idx_i = ia; portb_idx_i = ib;
        porta_write_en_mask_i = '0; portb_write_en_mask_i = '0;
        @(negedge clk);
        da = porta_data_o; db = portb_data_o;
    endtask

    // Write two distinct indices from the two ports in the same cycle.
    task automatic write_both(input phys_reg_id_t ia, input simd_mask_t maska, input simd_data_t dataa,
                              input phys_reg_id_t ib, input simd_mask_t maskb, input simd_data_t datab);
        @(negedge clk);
        porta_idx_i = ia; porta_write_en_mask_i = maska; porta_write_data_i = dataa;
        portb_idx_i = ib; portb_write_en_mask_i = maskb; portb_write_data_i = datab;
        @(posedge clk);
        @(negedge clk);
        porta_write_en_mask_i = '0; portb_write_en_mask_i = '0;
    endtask

    // -----------------------------------------------------------------------
    // Test body
    // -----------------------------------------------------------------------
    localparam phys_reg_id_t IDX_TOP = N_PHYS_REGS - 1;

    simd_data_t exp_d, got_a, got_b, got_lo, got_hi;
    simd_data_t exp_h_lo, exp_h_hi;
    simd_mask_t mask_lo;

    initial begin
        init_inputs();

        // Let the simulation-only register initialisation finish (2 edges).
        repeat (4) @(posedge clk);
        @(negedge clk);

        // ---------------- A. Port B write visible on both ports ----------------
        $display("\n== A. Port B write seen by both ports ==");
        set_pattern(exp_d, 16'h1111);
        write_b(5, '1, exp_d);
        read_a(5, got_a);
        expect_simd(got_a, exp_d, "port A reads value written by port B");
        read_b(5, got_b);
        expect_simd(got_b, exp_d, "port B reads value written by port B");

        // ---------------- B. Port A write visible on both ports ----------------
        $display("\n== B. Port A write seen by both ports ==");
        set_pattern(exp_d, 16'h2222);
        write_a(7, '1, exp_d);
        read_a(7, got_a);
        expect_simd(got_a, exp_d, "port A reads value written by port A");
        read_b(7, got_b);
        expect_simd(got_b, exp_d, "port B reads value written by port A");

        // ---------------- C. Index 0 is an ordinary register ----------------
        $display("\n== C. Index 0 is an ordinary register ==");
        set_pattern(exp_d, 16'hABCD);
        write_a(0, '1, exp_d);
        read_a(0, got_a);
        expect_simd(got_a, exp_d, "port A reads index 0 back (no zero forcing)");
        read_b(0, got_b);
        expect_simd(got_b, exp_d, "port B reads index 0 back (no zero forcing)");

        // ---------------- D. Read-before-write on port B ----------------
        $display("\n== D. Read-before-write on port B ==");
        set_pattern(got_lo, 16'h0A0A);                 // old value
        set_pattern(exp_d, 16'h0B0B);                  // new value
        write_b(9, '1, got_lo);
        readwrite_b(9, '1, exp_d, got_b);
        expect_simd(got_b, got_lo, "same-cycle port B read returns pre-write value");
        read_b(9, got_b);
        expect_simd(got_b, exp_d, "port B value updates on the next read");

        // ---------------- E. Read-before-write on port A ----------------
        $display("\n== E. Read-before-write on port A ==");
        set_pattern(got_lo, 16'h1C1C);                 // old value
        set_pattern(exp_d, 16'h1D1D);                  // new value
        write_a(10, '1, got_lo);
        readwrite_a(10, '1, exp_d, got_a);
        expect_simd(got_a, got_lo, "same-cycle port A read returns pre-write value");
        read_a(10, got_a);
        expect_simd(got_a, exp_d, "port A value updates on the next read");

        // ---------------- F. Per-thread write masking ----------------
        $display("\n== F. Per-thread write-enable masking ==");
        set_pattern(got_hi, 16'hAAAA);                 // baseline, all threads
        set_pattern(got_lo, 16'h3333);                 // new value, lower half only
        write_b(11, '1, got_hi);
        mask_lo = '0;
        for (int t = 0; t < N_THREADS / 2; t++) mask_lo[t] = 1'b1;
        write_a(11, mask_lo, got_lo);
        for (int t = 0; t < N_THREADS; t++) begin
            exp_d[t] = mask_lo[t] ? got_lo[t] : got_hi[t];
        end
        read_b(11, got_b);
        expect_simd(got_b, exp_d, "only unmasked threads keep the old value");

        // ---------------- G. Top index works ----------------
        $display("\n== G. Top index (N_PHYS_REGS-1) works ==");
        set_pattern(exp_d, 16'h7777);
        write_b(IDX_TOP, '1, exp_d);
        read_a(IDX_TOP, got_a);
        expect_simd(got_a, exp_d, "port A reads the top index back");
        read_b(IDX_TOP, got_b);
        expect_simd(got_b, exp_d, "port B reads the top index back");

        // ---------------- H. Distinct indices are independent ----------------
        $display("\n== H. Distinct indices are independent ==");
        set_pattern(exp_h_lo, 16'h4444);
        set_pattern(exp_h_hi, 16'h5555);
        write_b(20, '1, exp_h_lo);
        write_b(21, '1, exp_h_hi);
        read_a(20, got_a);
        expect_simd(got_a, exp_h_lo, "index 20 holds its own value");
        read_a(21, got_a);
        expect_simd(got_a, exp_h_hi, "index 21 holds its own value");

        // ---------------- I. Independent port indices ----------------
        $display("\n== I. Ports read independent indices ==");
        read_both(20, 21, got_a, got_b);
        expect_simd(got_a, exp_h_lo, "port A reads index 20 in shared cycle");
        expect_simd(got_b, exp_h_hi, "port B reads index 21 in shared cycle");

        // ---------------- J. Simultaneous writes to distinct indices ----------------
        $display("\n== J. Both ports write distinct indices in one cycle ==");
        set_pattern(got_lo, 16'h6666);
        set_pattern(got_hi, 16'h8888);
        write_both(30, '1, got_lo, 31, '1, got_hi);
        read_a(30, got_a);
        expect_simd(got_a, got_lo, "port A index holds its value");
        read_b(31, got_b);
        expect_simd(got_b, got_hi, "port B index holds its value");

        // -------------------------------------------------------------------
        // Summary
        // -------------------------------------------------------------------
        $display("\n=================================================");
        $display(" register_file TB: %0d checks, %0d failures", checks, errors);
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
        $display(" register_file TB: %0d checks, %0d failures", checks, errors + 1);
        $finish;
    end

endmodule

`default_nettype wire
