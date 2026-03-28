// =============================================================================
// memory.sv — Memory access stage (placeholder, passes instructions through)
// =============================================================================
// `default_nettype none

module memory
    import proto_pkg::*;
(
    input  logic clk,
    input  logic rst_n,

    // Pipeline handshake
    input  logic           valid_i,
    output logic           done_o,

    // From execute
    input  decoded_instr_s                    decoded_i,
    input  logic [NUM_LANES-1:0][XLEN-1:0]   result_i,

    // Pass-through to writeback
    output decoded_instr_s                    decoded_o,
    output logic [NUM_LANES-1:0][XLEN-1:0]   result_o
);

    // -------------------------------------------------------------------------
    // Registered outputs — no memory logic yet, just pass instructions through
    // -------------------------------------------------------------------------
    logic done_r;
    decoded_instr_s                  decoded_r;
    logic [NUM_LANES-1:0][XLEN-1:0] result_r;

    assign done_o    = done_r;
    assign decoded_o = decoded_r;
    assign result_o  = result_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            done_r    <= 1'b0;
            decoded_r <= '0;
            result_r  <= '0;
        end else begin
            done_r <= 1'b0;

            if (valid_i) begin
                decoded_r <= decoded_i;
                result_r  <= result_i;
                done_r    <= 1'b1;
            end
        end
    end

endmodule

// `default_nettype wire
