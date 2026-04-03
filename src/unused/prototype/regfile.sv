// =============================================================================
// regfile.sv — SIMD register file (N_REGS × N_LANES × XLEN)
// =============================================================================
// `default_nettype none

module regfile
    import proto_pkg::*;
(
    input wire  logic clk,

    // Read port 1
    input wire  logic [REG_ADDR_WIDTH-1:0]       rs1_addr_i,
    output logic [N_LANES-1:0][XLEN-1:0]  rs1_data_o,

    // Read port 2
    input wire  logic [REG_ADDR_WIDTH-1:0]       rs2_addr_i,
    output logic [N_LANES-1:0][XLEN-1:0]  rs2_data_o,

    // Write port
    input wire  logic [N_THREADS-1:0]          write_en_i,
    input wire  logic [REG_ADDR_WIDTH-1:0]        write_addr_i,
    input wire  logic [N_LANES-1:0][XLEN-1:0]   write_data_i
);

    // -------------------------------------------------------------------------
    // Storage: each register holds N_LANES × XLEN bits
    // -------------------------------------------------------------------------
    logic [N_LANES-1:0][XLEN-1:0] regs_r [1:N_REGS];

    initial begin
        for(int j = 0; j < N_LANES; j++) begin
            regs_r[1][j] <= 1;
            regs_r[2][j] <= 2;
            regs_r[3][j] <= j;
        end
    end

    // -------------------------------------------------------------------------
    // Combinational reads
    // -------------------------------------------------------------------------
    assign rs1_data_o = (rs1_addr_i == '0) ? '0 : regs_r[rs1_addr_i];
    assign rs2_data_o = (rs2_addr_i == '0) ? '0 : regs_r[rs2_addr_i];

    // -------------------------------------------------------------------------
    // Synchronous write
    // -------------------------------------------------------------------------
    always_ff @(posedge clk) begin
        for(int i = 0; i < N_THREADS; i++) begin
            if (write_en_i[i] && (write_addr_i != '0)) begin
                regs_r[write_addr_i][i] <= write_data_i[i];
            end
        end
    end

endmodule

// `default_nettype wire
