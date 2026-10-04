// =============================================================================
// tb_register_file_2port.sv — Self-checking testbench for
//                            src/register_file_2port.sv
// =============================================================================
//
// The DUT is a SIMD register file with two identical read/write ports:
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
//   C. Integer x0 is hardwired to zero.
//   D. Floating-point x0 is an ordinary register.
//   E. Read-before-write on port B.
//   F. Read-before-write on port A.
//   G. Per-thread write-enable masking (driven through port A).
//   H. Warp isolation.
//   I. Integer/floating register-file isolation.
//   J. Ports read independent addresses in the same cycle.
//   K. Both ports write distinct addresses in the same cycle.
//
// slang lint_off unconnected-input-port
// slang lint_off unconnected-output-port

`timescale 1ns/1ps
`default_nettype none

module tb_register_file_2port;
    import params_pkg::*;

    // -----------------------------------------------------------------------
    // Clock
    // -----------------------------------------------------------------------
    logic clk = 1'b0;
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    warp_id_t     porta_warp_id_i;
    reg_id_t      porta_idx_i;
    regfile_sel_e porta_regfile_i;
    simd_mask_t   porta_write_en_mask_i;
    simd_data_t   porta_write_data_i;
    simd_data_t   porta_data_o;

    warp_id_t     portb_warp_id_i;
    reg_id_t      portb_idx_i;
    regfile_sel_e portb_regfile_i;
    simd_mask_t   portb_write_en_mask_i;
    simd_data_t   portb_write_data_i;
    simd_data_t   portb_data_o;

    register_file_2port dut (
        .clk(clk),
        .porta_warp_id_i(porta_warp_id_i),
        .porta_idx_i(porta_idx_i),
        .porta_regfile_i(porta_regfile_i),
        .porta_write_en_mask_i(porta_write_en_mask_i),
        .porta_write_data_i(porta_write_data_i),
        .porta_data_o(porta_data_o),
        .portb_warp_id_i(portb_warp_id_i),
        .portb_idx_i(portb_idx_i),
        .portb_regfile_i(portb_regfile_i),
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
        porta_warp_id_i = '0; porta_idx_i = '0; porta_regfile_i = REGFILE_SEL_I;
        porta_write_en_mask_i = '0; porta_write_data_i = '0;
        portb_warp_id_i = '0; portb_idx_i = '0; portb_regfile_i = REGFILE_SEL_I;
        portb_write_en_mask_i = '0; portb_write_data_i = '0;
    endtask

    // ---- Port A / port B single-operation drivers -------------------------
    task automatic read_a(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                          output simd_data_t d);
        @(negedge clk);
        porta_warp_id_i = w; porta_idx_i = idx; porta_regfile_i = rf;
        porta_write_en_mask_i = '0;
        @(negedge clk);
        d = porta_data_o;
    endtask

    task automatic read_b(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                          output simd_data_t d);
        @(negedge clk);
        portb_warp_id_i = w; portb_idx_i = idx; portb_regfile_i = rf;
        portb_write_en_mask_i = '0;
        @(negedge clk);
        d = portb_data_o;
    endtask

    task automatic write_a(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                           input simd_mask_t mask, input simd_data_t data);
        @(negedge clk);
        porta_warp_id_i = w; porta_idx_i = idx; porta_regfile_i = rf;
        porta_write_en_mask_i = mask; porta_write_data_i = data;
        @(posedge clk);
        @(negedge clk);
        porta_write_en_mask_i = '0;
    endtask

    task automatic write_b(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                           input simd_mask_t mask, input simd_data_t data);
        @(negedge clk);
        portb_warp_id_i = w; portb_idx_i = idx; portb_regfile_i = rf;
        portb_write_en_mask_i = mask; portb_write_data_i = data;
        @(posedge clk);
        @(negedge clk);
        portb_write_en_mask_i = '0;
    endtask

    // Read-and-write the same address in one cycle; returns the pre-write value.
    task automatic readwrite_a(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                               input simd_mask_t mask, input simd_data_t data,
                               output simd_data_t d);
        @(negedge clk);
        porta_warp_id_i = w; porta_idx_i = idx; porta_regfile_i = rf;
        porta_write_en_mask_i = mask; porta_write_data_i = data;
        @(negedge clk);
        d = porta_data_o;
        porta_write_en_mask_i = '0;
    endtask

    task automatic readwrite_b(input warp_id_t w, input reg_id_t idx, input regfile_sel_e rf,
                               input simd_mask_t mask, input simd_data_t data,
                               output simd_data_t d);
        @(negedge clk);
        portb_warp_id_i = w; portb_idx_i = idx; portb_regfile_i = rf;
        portb_write_en_mask_i = mask; portb_write_data_i = data;
        @(negedge clk);
        d = portb_data_o;
        portb_write_en_mask_i = '0;
    endtask

    // Read both ports with independent addresses in the same cycle.
    task automatic read_both(input warp_id_t wa, input reg_id_t ia, input regfile_sel_e ra,
                             input warp_id_t wb, input reg_id_t ib, input regfile_sel_e rb,
                             output simd_data_t da, output simd_data_t db);
        @(negedge clk);
        porta_warp_id_i = wa; porta_idx_i = ia; porta_regfile_i = ra;
        portb_warp_id_i = wb; portb_idx_i = ib; portb_regfile_i = rb;
        porta_write_en_mask_i = '0; portb_write_en_mask_i = '0;
        @(negedge clk);
        da = porta_data_o; db = portb_data_o;
    endtask

    // Write two distinct addresses from the two ports in the same cycle.
    task automatic write_both(input warp_id_t wa, input reg_id_t ia, input regfile_sel_e ra,
                              input simd_mask_t maska, input simd_data_t dataa,
                              input warp_id_t wb, input reg_id_t ib, input regfile_sel_e rb,
                              input simd_mask_t maskb, input simd_data_t datab);
        @(negedge clk);
        porta_warp_id_i = wa; porta_idx_i = ia; porta_regfile_i = ra;
        porta_write_en_mask_i = maska; porta_write_data_i = dataa;
        portb_warp_id_i = wb; portb_idx_i = ib; portb_regfile_i = rb;
        portb_write_en_mask_i = maskb; portb_write_data_i = datab;
        @(posedge clk);
        @(negedge clk);
        porta_write_en_mask_i = '0; portb_write_en_mask_i = '0;
    endtask

    // -----------------------------------------------------------------------
    // Test body
    // -----------------------------------------------------------------------
    simd_data_t exp_d, got_a, got_b, got_lo, got_hi, tmp;
    simd_data_t exp_h_lo, exp_h_hi, exp_i_lo, exp_i_hi;
    simd_mask_t mask_lo;

    initial begin
        init_inputs();

        // Let the simulation-only register initialisation finish (2 edges).
        repeat (4) @(posedge clk);
        @(negedge clk);

        // ---------------- A. Port B write visible on both ports ----------------
        $display("\n== A. Port B write seen by both ports ==");
        set_pattern(exp_d, 16'h1111);
        write_b(2, 5, REGFILE_SEL_I, '1, exp_d);
        read_a(2, 5, REGFILE_SEL_I, got_a);
        expect_simd(got_a, exp_d, "port A reads value written by port B");
        read_b(2, 5, REGFILE_SEL_I, got_b);
        expect_simd(got_b, exp_d, "port B reads value written by port B");

        // ---------------- B. Port A write visible on both ports ----------------
        $display("\n== B. Port A write seen by both ports ==");
        set_pattern(exp_d, 16'h2222);
        write_a(4, 5, REGFILE_SEL_I, '1, exp_d);
        read_a(4, 5, REGFILE_SEL_I, got_a);
        expect_simd(got_a, exp_d, "port A reads value written by port A");
        read_b(4, 5, REGFILE_SEL_I, got_b);
        expect_simd(got_b, exp_d, "port B reads value written by port A");

        // ---------------- C. Integer x0 hardwired to zero ----------------
        $display("\n== C. Integer x0 hardwired to zero ==");
        tmp = '0;
        set_pattern(exp_d, 16'hDEAD);
        write_b(0, 0, REGFILE_SEL_I, '1, exp_d);
        write_a(0, 0, REGFILE_SEL_I, '1, exp_d);
        read_a(0, 0, REGFILE_SEL_I, got_a);
        expect_simd(got_a, tmp, "port A reads integer x0 as zero");
        read_b(0, 0, REGFILE_SEL_I, got_b);
        expect_simd(got_b, tmp, "port B reads integer x0 as zero");

        // ---------------- D. Float x0 is an ordinary register ----------------
        $display("\n== D. Float x0 is a normal register ==");
        set_pattern(exp_d, 16'hF0F0);
        write_b(0, 0, REGFILE_SEL_F, '1, exp_d);
        read_b(0, 0, REGFILE_SEL_F, got_b);
        expect_simd(got_b, exp_d, "port B reads float x0 back");
        read_a(0, 0, REGFILE_SEL_F, got_a);
        expect_simd(got_a, exp_d, "port A reads float x0 back");

        // ---------------- E. Read-before-write on port B ----------------
        $display("\n== E. Read-before-write on port B ==");
        set_pattern(got_lo, 16'h0A0A);                 // old value
        set_pattern(exp_d, 16'h0B0B);                  // new value
        write_b(1, 7, REGFILE_SEL_I, '1, got_lo);
        readwrite_b(1, 7, REGFILE_SEL_I, '1, exp_d, got_b);
        expect_simd(got_b, got_lo, "same-cycle port B read returns pre-write value");
        read_b(1, 7, REGFILE_SEL_I, got_b);
        expect_simd(got_b, exp_d, "port B value updates on the next read");

        // ---------------- F. Read-before-write on port A ----------------
        $display("\n== F. Read-before-write on port A ==");
        set_pattern(got_lo, 16'h1C1C);                 // old value
        set_pattern(exp_d, 16'h1D1D);                  // new value
        write_a(1, 8, REGFILE_SEL_I, '1, got_lo);
        readwrite_a(1, 8, REGFILE_SEL_I, '1, exp_d, got_a);
        expect_simd(got_a, got_lo, "same-cycle port A read returns pre-write value");
        read_a(1, 8, REGFILE_SEL_I, got_a);
        expect_simd(got_a, exp_d, "port A value updates on the next read");

        // ---------------- G. Per-thread write masking ----------------
        $display("\n== G. Per-thread write-enable masking ==");
        set_pattern(got_hi, 16'hAAAA);                 // baseline, all threads
        set_pattern(got_lo, 16'h3333);                 // new value, lower half only
        write_b(3, 9, REGFILE_SEL_I, '1, got_hi);
        mask_lo = '0;
        for (int t = 0; t < N_THREADS / 2; t++) mask_lo[t] = 1'b1;
        write_a(3, 9, REGFILE_SEL_I, mask_lo, got_lo);
        for (int t = 0; t < N_THREADS; t++) begin
            exp_d[t] = mask_lo[t] ? got_lo[t] : got_hi[t];
        end
        read_b(3, 9, REGFILE_SEL_I, got_b);
        expect_simd(got_b, exp_d, "only unmasked threads keep the old value");

        // ---------------- H. Warp isolation ----------------
        $display("\n== H. Warp isolation ==");
        set_pattern(exp_h_lo, 16'hA000);
        set_pattern(exp_h_hi, 16'hB000);
        write_b(0, 4, REGFILE_SEL_I, '1, exp_h_lo);
        write_b(1, 4, REGFILE_SEL_I, '1, exp_h_hi);
        read_a(0, 4, REGFILE_SEL_I, got_a);
        expect_simd(got_a, exp_h_lo, "warp 0 keeps its own value");
        read_a(1, 4, REGFILE_SEL_I, got_a);
        expect_simd(got_a, exp_h_hi, "warp 1 keeps its own value");

        // ---------------- I. Register-file isolation ----------------
        $display("\n== I. Integer/float register-file isolation ==");
        set_pattern(exp_i_lo, 16'h4444);
        set_pattern(exp_i_hi, 16'h5555);
        write_a(0, 6, REGFILE_SEL_I, '1, exp_i_lo);
        write_a(0, 6, REGFILE_SEL_F, '1, exp_i_hi);
        read_b(0, 6, REGFILE_SEL_I, got_b);
        expect_simd(got_b, exp_i_lo, "integer regfile holds its value");
        read_b(0, 6, REGFILE_SEL_F, got_b);
        expect_simd(got_b, exp_i_hi, "float regfile holds its value");

        // ---------------- J. Independent port addresses ----------------
        $display("\n== J. Ports read independent addresses ==");
        read_both(1, 4, REGFILE_SEL_I,
                  0, 6, REGFILE_SEL_F, got_a, got_b);
        expect_simd(got_a, exp_h_hi, "port A reads warp1/reg4/int in shared cycle");
        expect_simd(got_b, exp_i_hi, "port B reads warp0/reg6/float in shared cycle");

        // ---------------- K. Simultaneous writes to distinct addresses ----------------
        $display("\n== K. Both ports write distinct addresses in one cycle ==");
        set_pattern(got_lo, 16'h6666);
        set_pattern(got_hi, 16'h7777);
        write_both(5, 10, REGFILE_SEL_I, '1, got_lo,
                   6, 11, REGFILE_SEL_I, '1, got_hi);
        read_a(5, 10, REGFILE_SEL_I, got_a);
        expect_simd(got_a, got_lo, "port A address holds its value");
        read_b(6, 11, REGFILE_SEL_I, got_b);
        expect_simd(got_b, got_hi, "port B address holds its value");

        // -------------------------------------------------------------------
        // Summary
        // -------------------------------------------------------------------
        $display("\n=================================================");
        $display(" register_file_2port TB: %0d checks, %0d failures", checks, errors);
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
        $display(" register_file_2port TB: %0d checks, %0d failures", checks, errors + 1);
        $finish;
    end

endmodule

`default_nettype wire
