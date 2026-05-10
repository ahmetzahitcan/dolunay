`default_nettype none

module alu 
    import params_pkg::*;
    import control_unit_pkg::*;
#(
    parameter int THREAD_ID = 0
) (
    input wire logic [XLEN-1:0] rs1_val_i,
    input wire logic [XLEN-1:0] rs2_val_i,
    input wire instr_s instr_i,
    input wire logic [W_WARPS-1:0] warp_id_i,
    input wire logic [XLEN-1:Z_PC] pc_i,
    output logic [XLEN-1:0] result_o,
    input wire logic [63:0] cycle_time_i,
    input wire logic [63:0] instret_i,
    input wire logic [63:0] wuinstret_i,
    input wire logic [63:0] wtinstret_i
);

    logic [XLEN-1:0] op1_w;
    always_comb begin
        case (instr_i.alu_op1_sel)
            ALU_OP1_SEL_RS1: op1_w = rs1_val_i;
            ALU_OP1_SEL_PC: op1_w = {pc_i, {Z_PC{1'b0}}};
            default: op1_w = 'x;
        endcase
    end

    logic [XLEN-1:0] op2_w;
    always_comb begin
        case (instr_i.alu_op2_sel)
            ALU_OP2_SEL_RS2: op2_w = rs2_val_i;
            ALU_OP2_SEL_IMM: op2_w = instr_i.imm;
            default: op2_w = 'x;
        endcase
    end

    logic [XLEN-1:0] addy_op1_w;
    always_comb begin
        case (instr_i.alu_addy_funct)
            ALU_ADDY_FUNCT_ADD: addy_op1_w = op1_w;
            ALU_ADDY_FUNCT_SUB: addy_op1_w = op1_w;
            ALU_ADDY_FUNCT_SH1ADD: addy_op1_w = op1_w << 1;
            ALU_ADDY_FUNCT_SH2ADD: addy_op1_w = op1_w << 2;
            ALU_ADDY_FUNCT_SH3ADD: addy_op1_w = op1_w << 3;
            default: addy_op1_w = 'x;
        endcase
    end

    logic [XLEN-1:0] addy_op2_w;
    assign addy_op2_w = (instr_i.alu_addy_funct == ALU_ADDY_FUNCT_SUB) ? ~op2_w : op2_w;

    logic addy_cin_w;
    assign addy_cin_w = (instr_i.alu_addy_funct == ALU_ADDY_FUNCT_SUB) ? 1'b1 : 1'b0;

    logic [XLEN-1:0] addy_result_w;
    assign addy_result_w = addy_op1_w + addy_op2_w + addy_cin_w;

    logic [XLEN-1:0] result_w;
    always_comb begin
        case (instr_i.alu_funct)
            ALU_FUNCT_ADDY: result_w = addy_result_w;
            ALU_FUNCT_SLL: result_w = op1_w << op2_w[4:0];
            ALU_FUNCT_SLT: result_w = $signed(op1_w) < $signed(op2_w);
            ALU_FUNCT_SLTU: result_w = $unsigned(op1_w) < $unsigned(op2_w);
            ALU_FUNCT_XOR: result_w = op1_w ^ op2_w;
            ALU_FUNCT_SRL: result_w = op1_w >> op2_w[4:0];
            ALU_FUNCT_SRA: result_w = $signed(op1_w) >>> op2_w[4:0];
            ALU_FUNCT_OR: result_w = op1_w | op2_w;
            ALU_FUNCT_AND: result_w = op1_w & op2_w;
            ALU_FUNCT_HARTID: result_w = {{(XLEN-W_WARPS-W_THREADS){1'b0}}, warp_id_i, {W_THREADS{1'b0}}} | THREAD_ID;
            ALU_FUNCT_WARPID: result_w = warp_id_i;
            ALU_FUNCT_THRID: result_w = THREAD_ID;
            ALU_FUNCT_CYCLETIME: result_w = cycle_time_i[31:0];
            ALU_FUNCT_CYCLETIMEH: result_w = cycle_time_i[63:32];
            ALU_FUNCT_INSTRET: result_w = instret_i[31:0];
            ALU_FUNCT_INSTRETH: result_w = instret_i[63:32];
            ALU_FUNCT_WUINSTRET: result_w = wuinstret_i[31:0];
            ALU_FUNCT_WUINSTRETH: result_w = wuinstret_i[63:32];
            ALU_FUNCT_WTINSTRET: result_w = wtinstret_i[31:0];
            ALU_FUNCT_WTINSTRETH: result_w = wtinstret_i[63:32];
            ALU_FUNCT_ZERO: result_w = '0;
            ALU_FUNCT_OP1: result_w = op1_w;
            ALU_FUNCT_OP2: result_w = op2_w;
            ALU_FUNCT_CZERO_EQZ: result_w = (rs2_val_i == '0) ? 1'b0 : rs1_val_i;
            ALU_FUNCT_CZERO_NEZ: result_w = (rs2_val_i != '0) ? 1'b0 : rs1_val_i;
            default: result_w = 'x;
        endcase
    end

    assign result_o = result_w;


endmodule

`default_nettype wire