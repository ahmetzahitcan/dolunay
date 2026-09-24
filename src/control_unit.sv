`default_nettype none

module control_unit
    import params_pkg::*;
    import control_unit_pkg::*;
(
`ifndef SYNTHESIS
    input  wire logic sim__runasserts_i,
`endif
    input  wire logic [31:2] undec_instr32_i,
    input  wire logic [RLEN-1:Z_PC] pc_i,
    output instr_s instr_o
);

    imm_type_e imm_type_w;

    immediate_decoder u_imm(
`ifndef SYNTHESIS
        .sim__pc_i(pc_i),
        .sim__runasserts_i(sim__runasserts_i),
`endif
        .undec_instr32_i(undec_instr32_i),
        .imm_type_i(imm_type_w),
        .imm_o(instr_o.imm)
    );

    `ifndef SYNTHESIS
    string sim__disasm_format_w;
    sim__instr_formatter sim__u_instr_formatter(
        .format_i(sim__disasm_format_w),
        .rd_i(instr_o.rd_idx),
        .rs1_i(instr_o.rs1_idx),
        .rs2_i(instr_o.rs2_idx),
        .rs3_i(instr_o.rs3_idx),
        .roundmode_i(instr_o.fpu_roundmode),
        .imm_i(instr_o.imm),
        .pc_i(pc_i),
        .disasm_o(instr_o.sim__disasm)
    );
    `endif

    always_comb begin
        instr_o.rd_idx = undec_instr32_i[W_REGISTERS+6:7];
        instr_o.rs1_idx = undec_instr32_i[W_REGISTERS+14:15];
        instr_o.rs2_idx = undec_instr32_i[W_REGISTERS+19:20];
        instr_o.rs3_idx = undec_instr32_i[W_REGISTERS+26:27];
        instr_o.fpu_roundmode = undec_instr32_i[14:12];
        case (undec_instr32_i) inside
            30'b111000000000?????001?????10100: begin // FCLASS_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fclass.s $d, $1";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::CLASSIFY;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b111100000000?????000?????10100: begin // FMV_W_X
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fmv.w.x $d, $1";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b111000000000?????000?????10100: begin // FMV_X_W
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fmv.x.w $d, $1";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b010110000000?????????????10100: begin // FSQRT_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fsqrt.s $d, $1, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::SQRT;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b110000000000?????????????10100: begin // FCVT_W_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fcvt.w.s $d, $1, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::F2I;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b110000000001?????????????10100: begin // FCVT_WU_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fcvt.wu.s $d, $1, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::F2I;
                instr_o.fpu_op_modifier = 1'b1;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b110100000000?????????????10100: begin // FCVT_S_W
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fcvt.s.w $d, $1, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::I2F;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b110100000001?????????????10100: begin // FCVT_S_WU
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fcvt.s.wu $d, $1, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::I2F;
                instr_o.fpu_op_modifier = 1'b1;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????000?????01100: begin // ADD
                `ifndef SYNTHESIS
                sim__disasm_format_w = "add $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0010000??????????010?????01100: begin // SH1ADD
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sh1add $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SH1ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0010000??????????100?????01100: begin // SH2ADD
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sh2add $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SH2ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0010000??????????110?????01100: begin // SH3ADD
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sh3add $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SH3ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0100000??????????000?????01100: begin // SUB
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sub $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SUB;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????001?????01100: begin // SLL
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sll $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SLL;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????010?????01100: begin // SLT
                `ifndef SYNTHESIS
                sim__disasm_format_w = "slt $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????011?????01100: begin // SLTU
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sltu $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????100?????01100: begin // XOR
                `ifndef SYNTHESIS
                sim__disasm_format_w = "xor $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_XOR;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????101?????01100: begin // SRL
                `ifndef SYNTHESIS
                sim__disasm_format_w = "srl $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SRL;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0100000??????????101?????01100: begin // SRA
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sra $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SRA;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????110?????01100: begin // OR
                `ifndef SYNTHESIS
                sim__disasm_format_w = "or $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_OR;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????111?????01100: begin // AND
                `ifndef SYNTHESIS
                sim__disasm_format_w = "and $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_AND;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????001?????00100: begin // SLLI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "slli $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SLL;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????101?????00100: begin // SRLI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "srli $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SRL;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0100000??????????101?????00100: begin // SRAI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "srai $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SRA;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000111??????????101?????01100: begin // CZERO_EQZ
                `ifndef SYNTHESIS
                sim__disasm_format_w = "czero.eqz $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_CZERO_EQZ;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000111??????????111?????01100: begin // CZERO_NEZ
                `ifndef SYNTHESIS
                sim__disasm_format_w = "czero.nez $d, $1, $2";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_CZERO_NEZ;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0010100??????????00??????10100: begin // FMINMAX_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fminmax.s $d, $1, $2, $m";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::MINMAX;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS2;
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0010000??????????0???????10100: begin // FSGNJ_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fsgnj(n|x).s $d, $1, $2, $s";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::SGNJ;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS2;
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b1010000??????????0???????10100: begin // FCMP_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fcmp.s $d, $1, $2, $c";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::CMP;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS2;
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0000000??????????????????10100: begin // FADD_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fadd.s $d, $1, $2, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::ADD;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS1;
                instr_o.fpu_op2_sel = FPU_OP2_SEL_RS2;
            end
            30'b0000100??????????????????10100: begin // FSUB_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fsub.s $d, $1, $2, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::ADD;
                instr_o.fpu_op_modifier = 1'b1;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS1;
                instr_o.fpu_op2_sel = FPU_OP2_SEL_RS2;
            end
            30'b0001000??????????????????10100: begin // FMUL_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fmul.s $d, $1, $2, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::MUL;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS2;
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b0001100??????????????????10100: begin // FDIV_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fdiv.s $d, $1, $2. $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::DIV;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS2;
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b?????????????????000?????00100: begin // ADDI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "addi $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b?????????????????010?????00100: begin // SLTI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "slti $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b?????????????????011?????00100: begin // SLTIU
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sltiu $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b?????????????????100?????00100: begin // XORI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "xori $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_XOR;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b?????????????????110?????00100: begin // ORI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "ori $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_OR;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b?????????????????111?????00100: begin // ANDI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "andi $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_AND;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b?????00??????????????????10000: begin // FMADD_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fmadd.s $d, $1, $2, $3, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b1;
                instr_o.rs3_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::FMADD;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS2;
                instr_o.fpu_op2_sel = FPU_OP2_SEL_RS3;
            end
            30'b?????00??????????????????10001: begin // FMSUB_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fmsub.s $d, $1, $2, $3, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b1;
                instr_o.rs3_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::FMADD;
                instr_o.fpu_op_modifier = 1'b1;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS2;
                instr_o.fpu_op2_sel = FPU_OP2_SEL_RS3;
            end
            30'b?????00??????????????????10010: begin // FNMSUB_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fnmsub.s $d, $1, $2, $3, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b1;
                instr_o.rs3_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::FNMSUB;
                instr_o.fpu_op_modifier = 1'b0;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS2;
                instr_o.fpu_op2_sel = FPU_OP2_SEL_RS3;
            end
            30'b?????00??????????????????10011: begin // FNMADD_S
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fnmadd.s $d, $1, $2, $3, $r";
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs1_used = 1'b1;
                instr_o.rs1_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs2_used = 1'b1;
                instr_o.rs2_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.rs3_used = 1'b1;
                instr_o.rs3_regfile = params_pkg::REGFILE_SEL_F;
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_FPU;
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::FNMSUB;
                instr_o.fpu_op_modifier = 1'b1;
                instr_o.fpu_op0_sel = FPU_OP0_SEL_RS1;
                instr_o.fpu_op1_sel = FPU_OP1_SEL_RS2;
                instr_o.fpu_op2_sel = FPU_OP2_SEL_RS3;
            end
            30'b?????????????????????????01101: begin // LUI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "lui $d, $i";
                `endif
                imm_type_w = IMM_TYPE_U;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b0;
                instr_o.rs1_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_OP2;
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            30'b?????????????????????????00101: begin // AUIPC
                `ifndef SYNTHESIS
                sim__disasm_format_w = "auipc $d, $i";
                `endif
                imm_type_w = IMM_TYPE_U;
                instr_o.rd_used = 1'b1;
                instr_o.rd_regfile = params_pkg::REGFILE_SEL_I;
                instr_o.rs1_used = 1'b0;
                instr_o.rs1_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs2_used = 1'b0;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 1'b0;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::FUNCTION_UNIT_ALU;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_PC;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
            default: begin // INVALID
                `ifndef SYNTHESIS
                sim__disasm_format_w = "INVALID";
                if (sim__runasserts_i) begin
                    $warning("Invalid instruction (%h) encountered at %d", undec_instr32_i, pc_i);
                end
                `endif
                imm_type_w = imm_type_e'('x);
                instr_o.rd_used = 'x;
                instr_o.rd_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs1_used = 'x;
                instr_o.rs1_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs2_used = 'x;
                instr_o.rs2_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.rs3_used = 'x;
                instr_o.rs3_regfile = params_pkg::regfile_sel_e'('x);
                instr_o.fu_sel = fu_pkg::function_unit_e'('x);
                instr_o.alu_funct = alu_funct_e'('x);
                instr_o.alu_addy_funct = alu_addy_funct_e'('x);
                instr_o.alu_op1_sel = alu_op1_sel_e'('x);
                instr_o.alu_op2_sel = alu_op2_sel_e'('x);
                instr_o.fpu_opcode = fpnew_pkg::operation_e'('x);
                instr_o.fpu_op_modifier = 'x;
                instr_o.fpu_op0_sel = fpu_op0_sel_e'('x);
                instr_o.fpu_op1_sel = fpu_op1_sel_e'('x);
                instr_o.fpu_op2_sel = fpu_op2_sel_e'('x);
            end
        endcase
    end

endmodule

`default_nettype wire
