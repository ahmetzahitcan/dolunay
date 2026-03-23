// =============================================================================
// regfile.sv — SIMD register file (NUM_REGS × NUM_LANES × XLEN)
// =============================================================================
// `default_nettype none

module regfile
    import proto_pkg::*;
(
    input  logic clk,

    // Read port 1
    input  logic [REG_ADDR_WIDTH-1:0]       rs1_addr_i,
    output logic [NUM_LANES-1:0][XLEN-1:0]  rs1_data_o,

    // Read port 2
    input  logic [REG_ADDR_WIDTH-1:0]       rs2_addr_i,
    output logic [NUM_LANES-1:0][XLEN-1:0]  rs2_data_o,

    // Write port
    input  logic                             write_en_i,
    input  logic [REG_ADDR_WIDTH-1:0]        write_addr_i,
    input  logic [NUM_LANES-1:0][XLEN-1:0]   write_data_i
);

    // -------------------------------------------------------------------------
    // Storage: each register holds NUM_LANES × XLEN bits
    // -------------------------------------------------------------------------
    logic [NUM_LANES-1:0][XLEN-1:0] regs_r [0:NUM_REGS-1];

    // -------------------------------------------------------------------------
    // Combinational reads
    // -------------------------------------------------------------------------
    assign rs1_data_o = (rs1_addr_i == '0) ? '0 : regs_r[rs1_addr_i];
    assign rs2_data_o = (rs2_addr_i == '0) ? '0 : regs_r[rs2_addr_i];

    // -------------------------------------------------------------------------
    // Synchronous write
    // -------------------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (write_en_i && (write_addr_i != '0)) begin
            regs_r[write_addr_i] <= write_data_i;
        end
    end

endmodule

// `default_nettype wire
