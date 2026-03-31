module instr_mem 
    import params_pkg::*;
#(
    parameter int DEPTH      = 256
) (
    input  logic clk,
    input  logic [XLEN-1:LOG_PC_ALIGN]   addr_i,
    output logic [31:2]   undec_instr32_o
);

    // -------------------------------------------------------------------------
    // Instructions
    // -------------------------------------------------------------------------
    localparam ADD = 32'b0000000_00000_00000_000_00000_01100_11;
    localparam BEQ_P100 = 32'b000110000000000000001000011000_11;
    localparam BINIT = 32'b1000000_00000_00000_000_00000_00010_11;
    localparam BWAIT = 32'b0100000_00000_00000_000_00000_00010_11;
    localparam YIELD = 32'b0010000_00000_00000_000_00000_00010_11;
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
    logic [31:0] mem_r [0:DEPTH-1];

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
        mem_r[107] = 32'hdeadc0b7; // LUI x1, 0xdeadc
        mem_r[108] = 32'h0de08093; // ADDI x1, x1, 0x0de
        mem_r[109] = 32'hf1401173; // CSRRW x2, mhartid, x0
        mem_r[110] = 32'h00211113; // SLLI x2, x2, 2
        mem_r[111] = 32'h00112023; // SW x1, 0(x2)
        mem_r[112] = 32'h02111023; // SH x1, 32(x2)
        mem_r[113] = 32'h0100d193; // SRLI x3, x1, 16
        mem_r[114] = 32'h02311123; // SH x3, 34(x2)
        mem_r[115] = 32'h04110023; // SB x1, 64(x2)
        mem_r[116] = 32'h04310123; // SB x3, 66(x2)
        mem_r[117] = 32'h0080d193; // SRLI x3, x1, 8
        mem_r[118] = 32'h043100a3; // SB x3, 65(x2)
        mem_r[119] = 32'h0180d193; // SRLI x3, x1, 24
        mem_r[120] = 32'h043101a3; // SB x3, 67(x2)
        mem_r[121] = BINIT; // BINIT
        mem_r[122] = 32'h00417193; // ANDI x3, x2, 4
        mem_r[123] = 32'h00018863; // BEQ x3, x0, 4
        mem_r[124] = 32'h00010083; // LB x1, 0(x2)
        mem_r[125] = 32'h00011183; // LH x3, 0(x2)
        mem_r[126] = 32'h00000663; // BEQ x0, x0, 3
        mem_r[127] = 32'h00014083; // LBU x1, 0(x2)
        mem_r[128] = 32'h00015183; // LHU x3, 0(x2)
        mem_r[129] = 32'h00012103; // LW x2, 0(x2)
        mem_r[130] = BWAIT; // BWAIT
    end

    // -------------------------------------------------------------------------
    // Synchronous read
    // -------------------------------------------------------------------------
    logic [31:2] data_r;
    assign undec_instr32_o = data_r;

    always_ff @(posedge clk) begin
        data_r <= mem_r[addr_i][31:2];
    end

endmodule