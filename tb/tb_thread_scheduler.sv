`timescale 1ns/1ps
`default_nettype none

module tb_thread_scheduler;

    // Parameters
    localparam int NUM_THREADS = 32;
    localparam int PC_WIDTH = 30;
    localparam int NUM_BARRIERS = 8;
    localparam int LOG_NUM_BARRIERS = $clog2(NUM_BARRIERS);

    // Signals
    logic clk;
    logic rst_n;

    logic fetch_i;
    logic yield_i;
    logic binit_i;
    logic bwait_i;
    logic [LOG_NUM_BARRIERS-1:0] bsel_i;
    logic branch_i;
    logic [PC_WIDTH-1:0] pc_branch_i;
    logic [NUM_THREADS-1:0] mask_branch_i;

    logic [PC_WIDTH-1:0] pc_o;
    logic [NUM_THREADS-1:0] mask_o;

    // DUT instantiation
    thread_scheduler #(
        .NUM_THREADS(NUM_THREADS),
        .PC_WIDTH(PC_WIDTH),
        .NUM_BARRIERS(NUM_BARRIERS)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .fetch_i(fetch_i),
        .yield_i(yield_i),
        .binit_i(binit_i),
        .bwait_i(bwait_i),
        .bsel_i(bsel_i),
        .branch_i(branch_i),
        .pc_branch_i(pc_branch_i),
        .mask_branch_i(mask_branch_i),
        .pc_o(pc_o),
        .mask_o(mask_o)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // --------------------------------------------------------------------
        // INITIALIZATION
        // --------------------------------------------------------------------
        rst_n = 0;
        fetch_i = 0;
        yield_i = 0;
        binit_i = 0;
        bwait_i = 0;
        bsel_i = 0;
        branch_i = 0;
        pc_branch_i = 0;
        mask_branch_i = 0;

        // Apply reset
        repeat(5) @(posedge clk);
        rst_n = 1;
        @(posedge clk);
        #1;
        
        // Let's print out what is going on at each fetch
        $display("--- TEST START ---");

        // --------------------------------------------------------------------
        // TEST 1: FETCH
        // --------------------------------------------------------------------
        $display("TEST 1: Fetching sequentially");
        fetch_i = 1;
        @(posedge clk);
        #1;
        $display("Fetch: PC=%0d, Mask=%h", pc_o, mask_o);
        if (pc_o !== 0 || mask_o !== 32'hFFFFFFFF) $error("T1: Unexpected PC or Mask at PC=0");
        
        @(posedge clk);
        #1;
        $display("Fetch: PC=%0d, Mask=%h", pc_o, mask_o);
        if (pc_o !== 1 || mask_o !== 32'hFFFFFFFF) $error("T1: Unexpected PC or Mask at PC=1");
        
        fetch_i = 0; // stop fetching
        @(posedge clk);
        #1;

        // --------------------------------------------------------------------
        // TEST 2: BARRIER INIT
        // Initialize barrier 0 with all threads
        // --------------------------------------------------------------------
        $display("\nTEST 2: Initializing Barrier 0 with all threads.");
        binit_i = 1;
        bsel_i = 3'd0;
        @(posedge clk);
        #1;
        binit_i = 0;
        @(posedge clk);
        #1;

        // --------------------------------------------------------------------
        // TEST 3: DIVERGENT BRANCH (Threads splitting)
        // Let's assume lower 16 threads take a branch to PC=100.
        // Upper 16 threads (fall-through) stay on the current path.
        // --------------------------------------------------------------------
        $display("\nTEST 3: Divergent Branch (lower 16 threads take branch to PC: 100).");
        branch_i = 1;
        pc_branch_i = 30'd100;
        mask_branch_i = 32'h0000FFFF; // threads 0 to 15
        @(posedge clk);
        #1;
        branch_i = 0;
        @(posedge clk);
        #1;
        
        // After branching, the current active path (ID: 0) should be the fall-through threads.
        // The newly allocated path (ID: 1) should be for taken threads.
        // Let's do a fetch to observe the current path (fall-through, PC=2).
        fetch_i = 1;
        @(posedge clk);
        #1;
        $display("Fetch after branch (Fall-through Path): PC=%0d, Mask=%h", pc_o, mask_o);
        if (pc_o !== 2 || mask_o !== 32'hFFFF0000) $error("T3: Unexpected Fall-through PC or Mask");
        fetch_i = 0;
        @(posedge clk);
        #1;

        // --------------------------------------------------------------------
        // TEST 4: YIELD
        // Yield from path 0 to path 1. Next path is the taken branch path.
        // --------------------------------------------------------------------
        $display("\nTEST 4: Yielding path");
        yield_i = 1;
        @(posedge clk);
        #1;
        yield_i = 0;
        @(posedge clk);
        #1;
        
        // Fetch to see the new path
        fetch_i = 1;
        @(posedge clk);
        #1;
        $display("Fetch after yield (Taken Path): PC=%0d, Mask=%h", pc_o, mask_o);
        if (pc_o !== 100 || mask_o !== 32'h0000FFFF) $error("T4: Unexpected Taken path PC or Mask");
        fetch_i = 0;
        @(posedge clk);
        #1;

        // --------------------------------------------------------------------
        // TEST 5: BARRIER WAIT WITH YIELD
        // We are on path 1 (Taken). Wait at barrier 0.
        // Since fall-through hasn't arrived, this path should yield.
        // --------------------------------------------------------------------
        $display("\nTEST 5: Barrier Wait on Taken Path (Expecting yield since barrier incomplete).");
        bwait_i = 1;
        bsel_i = 3'd0;
        @(posedge clk);
        #1;
        bwait_i = 0;
        @(posedge clk);
        #1;

        // Expected currently active path is back to path 0 (Fall-through).
        fetch_i = 1;
        @(posedge clk);
        #1;
        $display("Fetch after bwait (Back to Fall-through Path): PC=%0d, Mask=%h", pc_o, mask_o);
        if (pc_o !== 3 || mask_o !== 32'hFFFF0000) $error("T5: Expected Fall-through path after bwait");
        fetch_i = 0;
        @(posedge clk);
        #1;

        // --------------------------------------------------------------------
        // TEST 6: BARRIER WAIT FOR WARP RECONVERGENCE
        // Fall-through path now arrives at the barrier.
        // It should complete the barrier, absorbing the aggregate mask.
        // --------------------------------------------------------------------
        $display("\nTEST 6: Barrier Wait on Fall-through Path (Expecting reconvergence).");
        bwait_i = 1;
        bsel_i = 3'd0;
        @(posedge clk);
        #1;
        bwait_i = 0;
        @(posedge clk);
        #1;

        // Post-barrier, the active path should absorb all threads (32'hFFFFFFFF)
        fetch_i = 1;
        @(posedge clk);
        #1;
        $display("Fetch after reconvergence: PC=%0d, Mask=%h", pc_o, mask_o);
        if (mask_o !== 32'hFFFFFFFF) $error("T6: Expected fully converged mask after bwait!");
        fetch_i = 0;
        @(posedge clk);
        #1;

        $display("\n--- ALL TESTS COMPLETED ---");
        $finish;
    end

endmodule

`default_nettype wire
