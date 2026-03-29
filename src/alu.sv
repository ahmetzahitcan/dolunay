module alu 
    import proto_pkg::*; // TODO: switch to a non-mock package
    import control_unit_pkg::*;
#(
    parameter int DATA_WIDTH = 32,
    parameter int THREAD_ID = 0
) (
    input logic [DATA_WIDTH-1:0] rs1_val_i,
    input logic [DATA_WIDTH-1:0] rs2_val_i,
    input decoded_instr_s instr_i,
    // TODO: this should not be DATA_WIDTH long
    input logic [DATA_WIDTH-1:0] warp_id_i,
    input logic [DATA_WIDTH-1:0] pc_i,
    output logic [DATA_WIDTH-1:0] result_o,
    output logic cond_o
);

logic [DATA_WIDTH-1:0] op1_w;
always_comb begin
    case (instr_i.control_signals.alu_op1_sel)
        ALU_OP1_SEL_RS1: op1_w = rs1_val_i;
        ALU_OP1_SEL_PC: op1_w = pc_i;
        default: op1_w = 'x;
    endcase
end

logic [DATA_WIDTH-1:0] op2_w;
always_comb begin
    case (instr_i.control_signals.alu_op2_sel)
        ALU_OP2_SEL_RS2: op2_w = rs2_val_i;
        ALU_OP2_SEL_IMM: op2_w = instr_i.imm;
        default: op2_w = 'x;
    endcase
end

logic [DATA_WIDTH-1:0] result_w;
always_comb begin
    case (instr_i.control_signals.alu_funct)
        ALU_FUNCT_ADD: result_w = op1_w + op2_w;
        ALU_FUNCT_SUB: result_w = op1_w - op2_w;
        ALU_FUNCT_SLL: result_w = op1_w << op2_w[4:0];
        ALU_FUNCT_SLT: result_w = $signed(op1_w) < $signed(op2_w);
        ALU_FUNCT_SLTU: result_w = $unsigned(op1_w) < $unsigned(op2_w);
        ALU_FUNCT_XOR: result_w = op1_w ^ op2_w;
        ALU_FUNCT_SRL: result_w = op1_w >> op2_w[4:0];
        ALU_FUNCT_SRA: result_w = $signed(op1_w) >>> op2_w[4:0];
        ALU_FUNCT_OR: result_w = op1_w | op2_w;
        ALU_FUNCT_AND: result_w = op1_w & op2_w;
        ALU_FUNCT_HARTID: result_w = (warp_id_i << 16) | THREAD_ID;
        ALU_FUNCT_ZERO: result_w = '0;
        ALU_FUNCT_OP2: result_w = op2_w;
        default: result_w = 'x;
    endcase
end

assign result_o = result_w;

logic cond_w;
always_comb begin
    case (instr_i.control_signals.alu_cond)
        ALU_COND_ZERO: cond_w = (result_w == '0);
        ALU_COND_NONZERO: cond_w = (result_w != '0);
        default: cond_w = 'x;
    endcase
end

assign cond_o = cond_w;


endmodule