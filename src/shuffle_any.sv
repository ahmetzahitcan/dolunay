// =============================================================================
// shuffle_any — Sequential shuffle unit for an arbitrary shuffle mask
//
// Parameters
//   M : number of array elements.
//   N : element width in bits.
//
// Ports
//   clk          : clock (rising-edge triggered)
//   rst_n        : asynchronous active-low reset
//   start_i      : pulse high for one cycle to begin a new shuffle operation;
//                  latches data_i and mask_i on that same rising edge.
//   data_i       : input  array to shuffle
//   mask_i       : arbitrary M-bit shuffle mask.  A mask with K ones takes
//                  exactly K clock cycles to complete.
//   data_o       : shuffled output array; valid whenever done_o=1.
//                  Retains the result of the most recent completed operation.
//   done_o       : high when the unit is idle / result is ready.
//                  Goes low on the cycle after start_i (if K ≥ 1) and returns
//                  high K cycles later.
//
// Operation
//   The mask is decomposed into its individual set bits (one-hot components).
//   Each cycle one component is applied via shuffle_one_hot and composed into
//   an accumulating permutation, exactly as if the one-hot shuffles are chained.
//   The least-significant set bit is consumed first.
//
//   Example: mask_i = 5'b01101  (bits {3,2,0} set → 3 ones → 3 cycles)
//     cycle 1: apply one-hot mask 5'b00001  (XOR with 1)
//     cycle 2: apply one-hot mask 5'b00100  (XOR with 4)
//     cycle 3: apply one-hot mask 5'b01000  (XOR with 8)
//
//  Special case: mask_i = 0 → done_o is never de-asserted (zero cycles needed).
// =============================================================================

module shuffle_any #(
    parameter int M = 8,
    parameter int N = 8
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 start_i,
    input  logic [M-1:0][N-1:0] data_i,
    input  logic [M-1:0]        mask_i,
    output logic [M-1:0][N-1:0] data_o,
    output logic                 done_o
);

    // -------------------------------------------------------------------------
    // Internal state
    // -------------------------------------------------------------------------
    logic [M-1:0][N-1:0] state_r;    // accumulates the permuted result
    logic [M-1:0]        pending_r;  // remaining one-hot components to apply
    logic                busy_r;

    // -------------------------------------------------------------------------
    // Isolate the lowest set bit of pending_r — this is the current one-hot mask
    // Two's-complement trick:  lowest_bit = x & (-x)
    // -------------------------------------------------------------------------
    logic [M-1:0] current_bit_w;
    assign current_bit_w = pending_r & (~pending_r + M'(1));

    // -------------------------------------------------------------------------
    // Instantiate the combinatorial shuffle unit
    // -------------------------------------------------------------------------
    logic [M-1:0][N-1:0] shuffled_w;

    shuffle_one_hot #(
        .M (M),
        .N (N)
    ) u_shuffle (
        .data_i  (state_r),
        .mask_i  (current_bit_w),
        .data_o  (shuffled_w)
    );

    // -------------------------------------------------------------------------
    // Sequential control
    // -------------------------------------------------------------------------
    always_ff @(posedge clk) begin : seq_ctrl
        if (!rst_n) begin
            state_r   <= '0;
            pending_r <= '0;
            busy_r    <= 1'b0;
        end else if (start_i) begin
            // Latch new operands; start processing immediately next cycle.
            state_r   <= data_i;
            pending_r <= mask_i;
            busy_r    <= (mask_i != '0);
        end else if (busy_r) begin
            // Apply the lowest-bit one-hot shuffle and remove it from pending_r.
            state_r   <= shuffled_w;
            pending_r <= pending_r & ~current_bit_w;
            busy_r    <= |(pending_r & ~current_bit_w);   // any bits left?
        end
    end

    // -------------------------------------------------------------------------
    // Outputs
    // -------------------------------------------------------------------------
    // data_o tracks state_r continuously; valid result is available when done_o=1.
    assign data_o = state_r;
    assign done_o = ~busy_r;

endmodule
