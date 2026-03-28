// =============================================================================
// tb_scheduler.sv — Basic testbench for scheduler
// =============================================================================
`timescale 1ns/1ps

module tb_scheduler;
    import tb_config_pkg::RST_CYCLES;

    // -----------------------------------------------------------------------
    // Parameters (match defaults)
    // -----------------------------------------------------------------------
    localparam int NUM_WARPS  = 4;
    localparam int ADDR_WIDTH = 32;
    localparam int LOG_WARPS  = $clog2(NUM_WARPS);

    // RST_CYCLES is imported from tb_config_pkg — edit tb_config_pkg.sv

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic                      clk    = 0;
    logic                      rst_n  = 0;
    logic [ADDR_WIDTH-1:2]     pc;
    logic [LOG_WARPS-1:0]      warp_id;

    // -----------------------------------------------------------------------
    // Clock: 10 ns period
    // -----------------------------------------------------------------------
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT
    // -----------------------------------------------------------------------
    scheduler #(
        .NUM_WARPS  (NUM_WARPS),
        .ADDR_WIDTH (ADDR_WIDTH)
    ) dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .pc      (pc),
        .warp_id (warp_id)
    );

    // -----------------------------------------------------------------------
    // Stimulus
    // -----------------------------------------------------------------------
    initial begin
        // Hold reset low for at least RST_CYCLES clock cycles
        rst_n = 0;
        repeat (RST_CYCLES) @(posedge clk);
        @(negedge clk);   // sample after falling edge while still in reset
        assert (pc      === '0) else $error("RST: pc should be 0, got %0h", pc);
        assert (warp_id === '0) else $error("RST: warp_id should be 0, got %0d", warp_id);
        $display("PASS  reset state");

        // Release reset
        rst_n = 1;

        // Run for NUM_WARPS * 2 cycles and check round-robin + PC increment
        begin
            // Track expected state: after reset release each posedge should
            // output the previously latched (pc, warp_id) then update internals.
            //
            // The scheduler latches outputs on posedge, so we sample one cycle
            // after the cycle of interest.
            //
            // After N cycles (warp 0..N-1 each appeared once), warp 0 should
            // appear again with pc = 1 (it was incremented once).

            automatic logic [ADDR_WIDTH-1:2]  exp_pc;
            automatic logic [LOG_WARPS-1:0]   exp_warp;
            automatic int                     pass_count = 0;

            for (int cycle = 0; cycle < NUM_WARPS * 2; cycle++) begin
                @(posedge clk); #1; // tiny delta to let outputs settle
                exp_warp = LOG_WARPS'(cycle % NUM_WARPS);
                // warp exp_warp has been through the loop (cycle/NUM_WARPS) times
                exp_pc   = (ADDR_WIDTH-2)'(cycle / NUM_WARPS);

                assert (warp_id === exp_warp)
                    else $error("cycle %0d: warp_id expected %0d got %0d",
                                cycle, exp_warp, warp_id);
                assert (pc === exp_pc)
                    else $error("cycle %0d: pc expected %0h got %0h",
                                cycle, exp_pc, pc);
                pass_count++;
            end
            $display("PASS  round-robin and PC increment (%0d cycles checked)", pass_count);
        end

        $display("\ntb_scheduler: all checks complete.");
        $finish;
    end

endmodule
