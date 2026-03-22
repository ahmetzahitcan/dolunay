// =============================================================================
// decode.sv — Instruction decode + register file read
// =============================================================================
`default_nettype none

module decode
    import proto_pkg::*;
(
    input  logic clk,
    input  logic rst_n,

    // Pipeline handshake
    input  logic           valid_i,
    output logic           done_o,

    // Raw instruction from ROM
    input  logic [31:0]    instr_i,

    // Register file read interface
    output logic [REG_ADDR_WIDTH-1:0] rs1_addr_o,
    output logic [REG_ADDR_WIDTH-1:0] rs2_addr_o,
    input  logic [NUM_LANES-1:0][XLEN-1:0] rs1_data_i,
    input  logic [NUM_LANES-1:0][XLEN-1:0] rs2_data_i,

    // Decoded outputs
    output decoded_instr_t              decoded_o,
    output logic [NUM_LANES-1:0][XLEN-1:0] rs1_data_o,
    output logic [NUM_LANES-1:0][XLEN-1:0] rs2_data_o
);

    // -------------------------------------------------------------------------
    // Decode logic (combinational)
    // -------------------------------------------------------------------------
    decoded_instr_t decoded_w;
    logic [1:0] opcode_w;

    control_unit ctrl_i (
        .instr_i (instr_i[31:2]),
        .opcode_o(opcode_w)
    );

    always_comb begin
        decoded_w = '0;
        decoded_w.opcode = opcode_t'(opcode_w);

        case (opcode_t'(opcode_w))
            OP_ADD: begin // R-type → ADD
                decoded_w.rd     = instr_i[11:7];
                decoded_w.rs1    = instr_i[19:15];
                decoded_w.rs2    = instr_i[24:20];
                decoded_w.imm    = '0;
            end
            OP_BEQ: begin // B-type → BEQ
                decoded_w.rd     = '0;
                decoded_w.rs1    = instr_i[19:15];
                decoded_w.rs2    = instr_i[24:20];
                decoded_w.imm    = {{20{instr_i[31]}}, instr_i[7],
                                    instr_i[30:25], instr_i[11:8], 1'b0};
            end
            default: begin
                decoded_w = '0;
            end
        endcase
    end

    // -------------------------------------------------------------------------
    // Register addresses driven combinationally for regfile read
    // -------------------------------------------------------------------------
    assign rs1_addr_o = decoded_w.rs1;
    assign rs2_addr_o = decoded_w.rs2;

    // -------------------------------------------------------------------------
    // Registered outputs
    // -------------------------------------------------------------------------
    decoded_instr_t decoded_r;
    logic [NUM_LANES-1:0][XLEN-1:0] rs1_data_r;
    logic [NUM_LANES-1:0][XLEN-1:0] rs2_data_r;
    logic done_r;

    assign decoded_o  = decoded_r;
    assign rs1_data_o = rs1_data_r;
    assign rs2_data_o = rs2_data_r;
    assign done_o     = done_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            decoded_r  <= '0;
            rs1_data_r <= '0;
            rs2_data_r <= '0;
            done_r     <= 1'b0;
        end else begin
            done_r <= 1'b0;

            if (valid_i) begin
                decoded_r  <= decoded_w;
                rs1_data_r <= rs1_data_i;
                rs2_data_r <= rs2_data_i;
                done_r     <= 1'b1;
            end
        end
    end

endmodule

`default_nettype wire
