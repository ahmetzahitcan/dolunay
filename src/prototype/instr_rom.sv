// =============================================================================
// instr_rom.sv — Synchronous instruction ROM
// =============================================================================
// `default_nettype none

module instr_rom #(
    parameter int ADDR_WIDTH = 30,
    parameter int DATA_WIDTH = 32,
    parameter int DEPTH      = 256
) (
    input  logic clk,

    input  logic                    read_en_i,
    input  logic [ADDR_WIDTH-1:0]   addr_i,
    output logic [DATA_WIDTH-1:0]   instr_o
);
    // -------------------------------------------------------------------------
    // Instructions
    // -------------------------------------------------------------------------
    localparam ADD = 32'b0000000_00000_00000_000_00000_01100_11;
    localparam BEQ_P100 = 32'b000001100000000000000010011000_11;
    localparam BINIT = 32'b0000000_00000_00000_001_00000_00010_11;
    localparam BWAIT = 32'b0000000_00000_00000_010_00000_00010_11;
    localparam YIELD = 32'b0000000_00000_00000_100_00000_00010_11;
    localparam X1_RD = 32'b0000000_00000_00000_000_00001_00000_11;
    localparam X2_RD = 32'b0000000_00000_00000_000_00010_00000_11;
    localparam X3_RD = 32'b0000000_00000_00000_000_00011_00000_11;
    localparam X1_RS1 = 32'b0000000_00000_00001_000_00000_00000_11;
    localparam X2_RS1 = 32'b0000000_00000_00010_000_00000_00000_11;
    localparam X3_RS1 = 32'b0000000_00000_00011_000_00000_00000_11;
    localparam X1_RS2 = 32'b0000000_00001_00000_000_00000_00000_11;
    localparam X2_RS2 = 32'b0000000_00010_00000_000_00000_00000_11;
    localparam X3_RS2 = 32'b0000000_00011_00000_000_00000_00000_11;

    // -------------------------------------------------------------------------
    // Memory
    // -------------------------------------------------------------------------
    logic [DATA_WIDTH-1:0] mem_r [0:DEPTH-1];

    initial begin
        for (int i = 0; i < DEPTH; i++) begin
            mem_r[i] = ADD; // NOP
        end
        mem_r[0] = BINIT; // BINIT
        mem_r[1] = BEQ_P100 | X3_RS1; // BEQ x3, x0, 100
        mem_r[2] = BEQ_P100 | X3_RS1 | X1_RS2; // BEQ x3, x1, 100
        mem_r[3] = BEQ_P100 | X3_RS1 | X2_RS2; // BEQ x3, x2, 100
        mem_r[4] = ADD | X1_RD | X1_RS1 | X2_RS2; // ADD x1, x1, x2
        mem_r[5] = BEQ_P100 | X3_RS1 | X1_RS2; // BEQ x3, x1, 100
        mem_r[6] = BEQ_P100; // BEQ x0, x0, 100
        mem_r[106] = BWAIT; // BWAIT
    end

    // -------------------------------------------------------------------------
    // Synchronous read
    // -------------------------------------------------------------------------
    logic [DATA_WIDTH-1:0] data_r;
    assign instr_o = data_r;

    always_ff @(posedge clk) begin
        if (read_en_i) begin
            data_r <= mem_r[addr_i];
        end
    end

endmodule

// `default_nettype wire
