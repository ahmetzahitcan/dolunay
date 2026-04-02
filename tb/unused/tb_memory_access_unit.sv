// =============================================================================
// tb_memory_access_unit.sv — Testbench for memory_access_unit
//
// Uses N_THREADS=4 for clarity.
// Includes a 1-cycle-latency synchronous memory model.
//
// Test cases
//   T1: Coalesced load   — 4 threads, 1 group
//   T2: Non-coalesced load  — 4 threads, 2 groups
//   T3: Coalesced store  — 4 threads, 1 group
//   T4: Non-coalesced store — 4 threads, 2 groups
//   T5: Partial mask load   — 2 of 4 threads active
// =============================================================================
`timescale 1ns/1ps

module tb_memory_access_unit;
    import tb_config_pkg::*;

    // -----------------------------------------------------------------------
    // Parameters — keep N_THREADS small so waveforms are readable
    // -----------------------------------------------------------------------
    localparam int N_THREADS     = 4;
    localparam int DATA_WIDTH      = 32;
    localparam int ADDR_WIDTH      = 32;
    localparam int LOG_N           = $clog2(N_THREADS);   // 2
    localparam int MEM_DATA_WIDTH  = DATA_WIDTH * N_THREADS;
    localparam int MEM_ADDR_WIDTH  = ADDR_WIDTH - LOG_N;
    localparam int MEM_LINES       = 64;

    // Convenience: build a full address from (block, offset)
    function automatic logic [ADDR_WIDTH-1:0] mkaddr(input int blk, input int ofs);
        return ADDR_WIDTH'((blk << LOG_N) | ofs);
    endfunction

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic clk           = 0;
    logic rst_n         = 0;
    logic start_i       = 0;
    logic store_i       = 0;
    logic [N_THREADS-1:0][ADDR_WIDTH-1:0]  addr_i;
    logic [N_THREADS-1:0]                   active_mask_i = '0;
    logic [N_THREADS-1:0][DATA_WIDTH-1:0]  data_i;
    logic [N_THREADS-1:0][DATA_WIDTH-1:0]  data_o;
    logic                                     busy_o;
    logic [MEM_DATA_WIDTH-1:0]               mem_data_i;
    logic [MEM_DATA_WIDTH-1:0]               mem_data_o;
    logic                                     mem_en_o;
    logic                                     mem_write_o;
    logic [MEM_ADDR_WIDTH-1:0]               mem_addr_o;

    // -----------------------------------------------------------------------
    // Clock
    // -----------------------------------------------------------------------
    always #5 clk = ~clk;
    
    int cycle_count;
    always_ff @(posedge clk) cycle_count <= cycle_count + 1;

    // -----------------------------------------------------------------------
    // DUT
    // -----------------------------------------------------------------------
    memory_access_unit #(
        .N_THREADS(N_THREADS),
        .DATA_WIDTH (DATA_WIDTH),
        .ADDR_WIDTH (ADDR_WIDTH)
    ) dut (
        .clk          (clk),
        .rst_n        (rst_n),
        .start_i      (start_i),
        .store_i      (store_i),
        .addr_i       (addr_i),
        .active_mask_i(active_mask_i),
        .data_i       (data_i),
        .data_o       (data_o),
        .busy_o       (busy_o),
        .mem_data_i   (mem_data_i),
        .mem_data_o   (mem_data_o),
        .mem_en_o     (mem_en_o),
        .mem_write_o  (mem_write_o),
        .mem_addr_o   (mem_addr_o)
    );

    // -----------------------------------------------------------------------
    // Synchronous memory model — 1-cycle read latency, write-through
    // -----------------------------------------------------------------------
    logic [MEM_DATA_WIDTH-1:0] mem [MEM_LINES];
    logic [MEM_DATA_WIDTH-1:0] mem_rdata_r = '0;

    always_ff @(posedge clk) begin
        if (mem_en_o) begin
            if (mem_write_o)
                mem[mem_addr_o] <= mem_data_o;
            else
                mem_rdata_r <= mem[mem_addr_o];
        end
    end
    assign mem_data_i = mem_rdata_r;

    // -----------------------------------------------------------------------
    // Helper: read one DATA_WIDTH word from a memory line
    // -----------------------------------------------------------------------
    function automatic logic [DATA_WIDTH-1:0] mem_word(input int line, input int ofs);
        return mem[line][ofs * DATA_WIDTH +: DATA_WIDTH];
    endfunction

    // -----------------------------------------------------------------------
    // Task: drive one memory access, hold en_i high until busy_o de-asserts
    // -----------------------------------------------------------------------
    task automatic run_access(
        input string                             tname,
        input logic                              store,
        input logic [N_THREADS-1:0]            mask,
        input logic [N_THREADS-1:0][ADDR_WIDTH-1:0] addrs,
        input logic [N_THREADS-1:0][DATA_WIDTH-1:0] wdata
    );
        int start_cycle;
        start_cycle = cycle_count;

        // Align to the cycle after the current edge, then apply inputs
        @(posedge clk); #1;
        store_i       = store;
        active_mask_i = mask;
        addr_i        = addrs;
        data_i        = wdata;

        // start_i is pulsed for one cycle
        start_i       = 1;
        @(posedge clk); #1;
        start_i       = 0;

        // Wait until operation completes (busy_o returns low)
        do begin
            // These shouldn't change the result.
            store_i       = $urandom();
            active_mask_i = $urandom();
            for (int i = 0; i < N_THREADS; i++) begin
                addr_i[i] = $urandom();
                data_i[i] = $urandom();
            end

            @(posedge clk); #1;
        end while (busy_o);

        store_i = 0;
        $display("  [%s] complete in %0d cycles", tname, cycle_count - start_cycle);
    endtask

    // -----------------------------------------------------------------------
    // Stimulus
    // -----------------------------------------------------------------------
    initial begin
        // Initialise memory: mem[line][word] = 32'h1000_0000 + line*16 + word
        for (int l = 0; l < MEM_LINES; l++)
            for (int w = 0; w < N_THREADS; w++)
                mem[l][w * DATA_WIDTH +: DATA_WIDTH] = 32'h1000_0000 + l * 16 + w;

        // Reset
        rst_n = 0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1;
        @(posedge clk); #1;

        $display("=== tb_memory_access_unit ===");

        // --------------------------------------------------------------------
        // T1: Coalesced load — all 4 threads in block 5
        //   thread[i] → addr = mkaddr(5, i), so word offset within line = i
        // --------------------------------------------------------------------
        $display("\nT1: Coalesced load (block 5, all threads)");
        run_access("T1", /*store=*/0, 4'b1111,
            '{mkaddr(5,3), mkaddr(5,2), mkaddr(5,1), mkaddr(5,0)},
            '{default: '0});

        for (int t = 0; t < N_THREADS; t++) begin
            automatic logic [DATA_WIDTH-1:0] exp = mem_word(5, t);
            assert (data_o[t] === exp)
                else $error("T1: data_o[%0d] = %0h, expected %0h", t, data_o[t], exp);
        end
        $display("  [T1] data_o verified");

        // --------------------------------------------------------------------
        // T2: Non-coalesced load — 2 groups: block 3 (threads 0,2) and
        //                                    block 7 (threads 1,3)
        //   thread 0 → block 3, offset 0
        //   thread 1 → block 7, offset 1
        //   thread 2 → block 3, offset 2
        //   thread 3 → block 7, offset 3
        // --------------------------------------------------------------------
        $display("\nT2: Non-coalesced load (blocks 3 and 7)");
        run_access("T2", 0, 4'b1111,
            '{mkaddr(7,3), mkaddr(3,2), mkaddr(7,1), mkaddr(3,0)},
            '{default: '0});

        assert (data_o[0] === mem_word(3, 0))
            else $error("T2: data_o[0]=%0h exp=%0h", data_o[0], mem_word(3,0));
        assert (data_o[1] === mem_word(7, 1))
            else $error("T2: data_o[1]=%0h exp=%0h", data_o[1], mem_word(7,1));
        assert (data_o[2] === mem_word(3, 2))
            else $error("T2: data_o[2]=%0h exp=%0h", data_o[2], mem_word(3,2));
        assert (data_o[3] === mem_word(7, 3))
            else $error("T2: data_o[3]=%0h exp=%0h", data_o[3], mem_word(7,3));
        $display("  [T2] data_o verified");

        // --------------------------------------------------------------------
        // T3: Coalesced store — all 4 threads write to block 10
        // --------------------------------------------------------------------
        $display("\nT3: Coalesced store (block 10, all threads)");
        run_access("T3", 1, 4'b1111,
            '{mkaddr(10,3), mkaddr(10,2), mkaddr(10,1), mkaddr(10,0)},
            '{32'hDEAD_0003, 32'hDEAD_0002, 32'hDEAD_0001, 32'hDEAD_0000});

        assert (mem_word(10,0) === 32'hDEAD_0000)
            else $error("T3: mem[10][0]=%0h", mem_word(10,0));
        assert (mem_word(10,1) === 32'hDEAD_0001)
            else $error("T3: mem[10][1]=%0h", mem_word(10,1));
        assert (mem_word(10,2) === 32'hDEAD_0002)
            else $error("T3: mem[10][2]=%0h", mem_word(10,2));
        assert (mem_word(10,3) === 32'hDEAD_0003)
            else $error("T3: mem[10][3]=%0h", mem_word(10,3));
        $display("  [T3] mem[10] verified");

        // --------------------------------------------------------------------
        // T4: Non-coalesced store — block 32 (threads 0,2) and block 33 (threads 1,3)
        //   Only the scattered offsets are checked; non-scattered slots in each
        //   line may contain stale data (design limitation: no read-modify-write).
        // --------------------------------------------------------------------
        $display("\nT4: Non-coalesced store (blocks 32 and 33)");
        run_access("T4", 1, 4'b1111,
            '{mkaddr(33,3), mkaddr(32,2), mkaddr(33,1), mkaddr(32,0)},
            '{32'hCAFE_0003, 32'hCAFE_0002, 32'hCAFE_0001, 32'hCAFE_0000});

        // block 32: threads 0 and 2 → offsets 0 and 2
        assert (mem_word(32,0) === 32'hCAFE_0000)
            else $error("T4: mem[32][0]=%0h", mem_word(32,0));
        assert (mem_word(32,1) === 32'h1000_0201)
            else $error("T4: mem[32][1]=%0h", mem_word(32,1));
        assert (mem_word(32,2) === 32'hCAFE_0002)
            else $error("T4: mem[32][2]=%0h", mem_word(32,2));
        assert (mem_word(32,3) === 32'h1000_0203)
            else $error("T4: mem[32][3]=%0h", mem_word(32,3));
        // block 33: threads 1 and 3 → offsets 1 and 3
        assert (mem_word(33,0) === 32'h1000_0210)
            else $error("T4: mem[33][0]=%0h", mem_word(33,0));
        assert (mem_word(33,1) === 32'hCAFE_0001)
            else $error("T4: mem[33][1]=%0h", mem_word(33,1));
        assert (mem_word(33,2) === 32'h1000_0212)
            else $error("T4: mem[33][2]=%0h", mem_word(33,2));
        assert (mem_word(33,3) === 32'hCAFE_0003)
            else $error("T4: mem[33][3]=%0h", mem_word(33,3));
        $display("  [T4] mem[32] and mem[33] verified");

        // --------------------------------------------------------------------
        // T5: Partial mask load — only threads 0 and 2, both in block 8
        // --------------------------------------------------------------------
        $display("\nT5: Partial mask load (threads 0,2 only, block 8)");
        run_access("T5", 0, 4'b0101,
            '{mkaddr(8,3), mkaddr(8,2), mkaddr(8,1), mkaddr(8,0)},
            '{default: '0});

        assert (data_o[0] === mem_word(8, 0))
            else $error("T5: data_o[0]=%0h exp=%0h", data_o[0], mem_word(8,0));
        assert (data_o[2] === mem_word(8, 2))
            else $error("T5: data_o[2]=%0h exp=%0h", data_o[2], mem_word(8,2));
        $display("  [T5] data_o verified");

        $display("\n=== ALL TESTS PASSED ===");
        $finish;
    end

endmodule
