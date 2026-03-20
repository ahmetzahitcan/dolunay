// =============================================================================
// tb_shuffle_any.sv — Basic testbench for shuffle_any
// =============================================================================
`timescale 1ns/1ps

module tb_shuffle_any;
    import tb_config_pkg::RST_CYCLES;

    // -----------------------------------------------------------------------
    // Parameters
    // -----------------------------------------------------------------------
    localparam int M = 8;
    localparam int N = 8;

    // RST_CYCLES is imported from tb_config_pkg — edit tb_config_pkg.sv

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic                 clk     = 0;
    logic                 rst_n   = 0;
    logic                 start_i = 0;
    logic [M-1:0][N-1:0] data_i;
    logic [M-1:0]        mask_i;
    logic [M-1:0][N-1:0] data_o;
    logic                 done_o;

    // -----------------------------------------------------------------------
    // Clock: 10 ns period
    // -----------------------------------------------------------------------
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT
    // -----------------------------------------------------------------------
    shuffle_any #(.M(M), .N(N)) dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .start_i (start_i),
        .data_i  (data_i),
        .mask_i  (mask_i),
        .data_o  (data_o),
        .done_o  (done_o)
    );

    // -----------------------------------------------------------------------
    // Helper: compute expected result of chained one-hot XOR shuffles
    // -----------------------------------------------------------------------
    function automatic logic [M-1:0][N-1:0] expected_result(
        input logic [M-1:0][N-1:0] din,
        input logic [M-1:0]        msk
    );
        automatic logic [M-1:0][N-1:0] tmp = din;
        automatic logic [M-1:0]        rem = msk;
        automatic logic [M-1:0]        cb;
        automatic logic [M-1:0][N-1:0] next_tmp;

        while (rem != '0) begin
            cb = rem & (~rem + M'(1));  // isolate lowest set bit
            // Apply one-hot shuffle: next_tmp[i ^ cb] = tmp[i]
            next_tmp = tmp;
            for (int i = 0; i < M; i++)
                next_tmp[i ^ cb] = tmp[i];
            tmp = next_tmp;
            rem = rem & ~cb;
        end
        return tmp;
    endfunction

    // -----------------------------------------------------------------------
    // Task: run one shuffle transaction and verify
    // -----------------------------------------------------------------------
    task automatic run_shuffle(
        input string          test_name,
        input logic [M-1:0][N-1:0] din,
        input logic [M-1:0]        msk
    );
        automatic int popcount = $countones(msk);
        automatic logic [M-1:0][N-1:0] exp;

        // Assert start_i for one cycle
        @(posedge clk);
        data_i  = din;
        mask_i  = msk;
        start_i = 1;
        @(posedge clk);
        start_i = 0;
        #1;

        if (msk == '0) begin
            // Zero mask: done_o should stay high, result unchanged
            assert (done_o === 1'b1)
                else $error("%s: done_o should stay high for mask_i=0", test_name);
            // data_o retains whatever state_r held; at minimum done_o must be high
            $display("PASS  %s (mask_i=0, done_o immediately)", test_name);
        end else if (popcount == 1) begin
            assert (done_o === 1'b1)
                else $error("%s: done_o should be high as soon as start_i=0", test_name);

            // Check output
            exp = expected_result(din, msk);
            for (int i = 0; i < M; i++) begin
                assert (data_o[i] === exp[i])
                    else $error("%s: data_o[%0d] expected %0h got %0h",
                                test_name, i, exp[i], data_o[i]);
            end
            $display("PASS  %s (mask_i=%0b, 1 cycle)", test_name, msk);
        end else begin
            // Expect done_o to go low after start_i
            assert (done_o === 1'b0)
                else $error("%s: done_o should be low while busy", test_name);

            // Wait for exactly popcount-1 more rising edges, after which 
            // done_o should be high
            repeat (popcount - 1) @(posedge clk);
            #1;
            assert (done_o === 1'b1)
                else $error("%s: done_o should be high after %0d cycles, got %0b",
                            test_name, popcount, done_o);

            // Check output
            exp = expected_result(din, msk);
            for (int i = 0; i < M; i++) begin
                assert (data_o[i] === exp[i])
                    else $error("%s: data_o[%0d] expected %0h got %0h",
                                test_name, i, exp[i], data_o[i]);
            end
            $display("PASS  %s (mask_i=%0b, %0d cycles)", test_name, msk, popcount);
        end
    endtask

    // -----------------------------------------------------------------------
    // Stimulus
    // -----------------------------------------------------------------------
    initial begin
        // Initialise data_i: data_i[i] = i
        for (int i = 0; i < M; i++) data_i[i] = N'(i);

        // Hold reset low for at least RST_CYCLES clock cycles
        rst_n = 0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1;
        @(posedge clk);

        // Test 1: mask_i = 0 → no-op, done_o never de-asserted
        run_shuffle("mask_zero",
            '{8'h00, 8'h01, 8'h02, 8'h03, 8'h04, 8'h05, 8'h06, 8'h07},
            8'b0000_0000);

        // Test 2: single-bit mask_i → 1 cycle
        run_shuffle("mask_single_bit",
            '{8'hAA, 8'hBB, 8'hCC, 8'hDD, 8'hEE, 8'hFF, 8'h11, 8'h22},
            8'b0000_0010);

        // Test 3: 3-bit mask_i → 3 cycles
        run_shuffle("mask_3bits",
            '{8'h10, 8'h20, 8'h30, 8'h40, 8'h50, 8'h60, 8'h70, 8'h80},
            8'b0000_0111);

        $display("\ntb_shuffle_any: all checks complete.");
        $finish;
    end

endmodule
