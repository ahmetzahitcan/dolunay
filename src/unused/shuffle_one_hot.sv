// =============================================================================
// shuffle_one_hot — Combinatorial one-hot shuffle unit
//
// Parameters
//   M : number of array elements.  Should be a power of 2 so that XOR-based
//       index arithmetic stays in-range for every element.
//   N : element width in bits.
//
// Ports
//   data_i  [M-1:0][N-1:0] : input wire  array
//   mask_i  [M-1:0]         : one-hot shuffle mask  (undefined behaviour if
//                              not one-hot)
//   data_o  [M-1:0][N-1:0] : output array
//
// Operation
//   For every index i:  data_o[ i XOR mask_i ] = data_i[ i ]
// =============================================================================

module shuffle_one_hot #(
    parameter int M = 8,
    parameter int N = 8
) (
    input wire  logic [M-1:0][N-1:0] data_i,
    input wire  logic [M-1:0]        mask_i,
    output logic [M-1:0][N-1:0] data_o
);
    // Assertion that mask_i is one-hot or zero
    always_comb assert ($onehot0(mask_i)) else $error("mask_i is %b, not one-hot", mask_i);

    // -------------------------------------------------------------------------
    // Shuffle:  data_o[ i ^ mask_i ] = data_i[ i ] when mask_i
    // -------------------------------------------------------------------------
    always_comb begin : do_shuffle
        data_o = data_i;
        for (int i = 0; i < M; i++) begin
            data_o[i ^ mask_i] = data_i[i];
        end
    end

endmodule
