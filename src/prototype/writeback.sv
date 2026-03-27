// =============================================================================
// writeback.sv — Write results back to register file
// =============================================================================
// `default_nettype none

module writeback
    import proto_pkg::*;
(
    input  logic clk,
    input  logic rst_n,

    // Pipeline handshake
    input  logic           valid_i,
    output logic           done_o,

    // From execute
    input  decoded_instr_t              decoded_i,
    input  logic [NUM_LANES-1:0][XLEN-1:0] result_i,

    // Register file write interface
    output logic                        reg_write_en_o,
    output logic [REG_ADDR_WIDTH-1:0]   reg_write_addr_o,
    output logic [NUM_LANES-1:0][XLEN-1:0] reg_write_data_o
);

    // -------------------------------------------------------------------------
    // Write enable: only for ADD (BEQ has no destination register)
    // -------------------------------------------------------------------------
    logic writes_rd_w;
    assign writes_rd_w = decoded_i.control_signals.writeback;

    // -------------------------------------------------------------------------
    // Registered outputs
    // -------------------------------------------------------------------------
    logic done_r;
    assign done_o = done_r;

    assign reg_write_en_o   = valid_i && writes_rd_w;
    assign reg_write_addr_o = decoded_i.rd;
    assign reg_write_data_o = result_i;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            done_r <= 1'b0;
        end else begin
            done_r <= valid_i;
        end
    end

endmodule

// `default_nettype wire
