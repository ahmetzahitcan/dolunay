// =============================================================================
// tb_shuffle_one_hot.sv — Basic testbench for shuffle_one_hot
// =============================================================================
`timescale 1ns/1ps

module tb_shuffle_one_hot;

    // -----------------------------------------------------------------------
    // Parameters
    // -----------------------------------------------------------------------
    localparam int M = 8;
    localparam int N = 8;

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic [M-1:0][N-1:0] data_i;
    logic [M-1:0]        mask_i;
    logic [M-1:0][N-1:0] data_o;

    // -----------------------------------------------------------------------
    // DUT
    // -----------------------------------------------------------------------
    shuffle_one_hot #(.M(M), .N(N)) dut (
        .data_i  (data_i),
        .mask_i  (mask_i),
        .data_o  (data_o)
    );

    // -----------------------------------------------------------------------
    // Task: apply one stimulus and verify all output indices
    // -----------------------------------------------------------------------
    task automatic check(
        input wire string          test_name,
        input wire logic [M-1:0][N-1:0] din,
        input wire logic [M-1:0]        msk
    );
        data_i = din;
        mask_i = msk;
        #1;
        for (int i = 0; i < M; i++) begin
            automatic int dst = i ^ int'(msk);
            assert (data_o[dst] === din[i])
                else $error("%s: data_o[%0d] expected %0h got %0h",
                            test_name, dst, din[i], data_o[dst]);
        end
        $display("PASS  %s (mask_i=%0b)", test_name, msk);
    endtask

    // -----------------------------------------------------------------------
    // Stimulus
    // -----------------------------------------------------------------------
    initial begin
        // Load data_i with a simple identity pattern: data_i[i] = i
        for (int i = 0; i < M; i++) data_i[i] = N'(i);

        // mask_i = 8'b00000001 (bit 0 set) — XOR with 1 → swap adjacent pairs
        check("mask_bit0", data_i, 8'b0000_0001);

        // mask_i = 8'b00000010 (bit 1 set) — XOR with 2 → swap pairs at distance 2
        check("mask_bit1", data_i, 8'b0000_0010);

        // mask_i = 8'b00000100 (bit 2 set) — XOR with 4 → swap halves
        check("mask_bit2", data_i, 8'b0000_0100);

        $display("\ntb_shuffle_one_hot: all checks complete.");
        $finish;
    end

endmodule
