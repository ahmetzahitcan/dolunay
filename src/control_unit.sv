`default_nettype none

module control_unit
    import control_unit_pkg::*;
(
    input  wire  [31:2] instr_i,
    output control_signals_s control_signals_o
);

    always_comb begin
        case (instr_i) inside
            30'b000000000000000001000000000010: begin // YIELD
                control_signals_o.alu_funct = ALU_FUNCT_UNDEFINED;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b1;
            end
            30'b111100010100?????????????11100: begin // CSR_MHARTID
                control_signals_o.alu_funct = ALU_FUNCT_HARTID;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????000?????01100: begin // ADD
                control_signals_o.alu_funct = ALU_FUNCT_ADD;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0100000??????????000?????01100: begin // SUB
                control_signals_o.alu_funct = ALU_FUNCT_SUB;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????001?????01100: begin // SLL
                control_signals_o.alu_funct = ALU_FUNCT_SLL;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????010?????01100: begin // SLT
                control_signals_o.alu_funct = ALU_FUNCT_SLT;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????011?????01100: begin // SLTU
                control_signals_o.alu_funct = ALU_FUNCT_SLTU;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????100?????01100: begin // XOR
                control_signals_o.alu_funct = ALU_FUNCT_XOR;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????101?????01100: begin // SRL
                control_signals_o.alu_funct = ALU_FUNCT_SRL;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0100000??????????101?????01100: begin // SRA
                control_signals_o.alu_funct = ALU_FUNCT_SRA;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????110?????01100: begin // OR
                control_signals_o.alu_funct = ALU_FUNCT_OR;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????111?????01100: begin // AND
                control_signals_o.alu_funct = ALU_FUNCT_AND;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????001?????00100: begin // SLLI
                control_signals_o.alu_funct = ALU_FUNCT_SLL;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????101?????00100: begin // SRLI
                control_signals_o.alu_funct = ALU_FUNCT_SRL;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0100000??????????101?????00100: begin // SRAI
                control_signals_o.alu_funct = ALU_FUNCT_SRA;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????001?????00010: begin // BINIT
                control_signals_o.alu_funct = ALU_FUNCT_UNDEFINED;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b1;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b0000000??????????010?????00010: begin // BWAIT
                control_signals_o.alu_funct = ALU_FUNCT_UNDEFINED;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b1;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????000?????00100: begin // ADDI
                control_signals_o.alu_funct = ALU_FUNCT_ADD;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????010?????00100: begin // SLTI
                control_signals_o.alu_funct = ALU_FUNCT_SLT;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????011?????00100: begin // SLTIU
                control_signals_o.alu_funct = ALU_FUNCT_SLTU;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????100?????00100: begin // XORI
                control_signals_o.alu_funct = ALU_FUNCT_XOR;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????110?????00100: begin // ORI
                control_signals_o.alu_funct = ALU_FUNCT_OR;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????111?????00100: begin // ANDI
                control_signals_o.alu_funct = ALU_FUNCT_AND;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????000?????11000: begin // BEQ
                control_signals_o.alu_funct = ALU_FUNCT_SUB;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_ZERO;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b1;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????001?????11000: begin // BNE
                control_signals_o.alu_funct = ALU_FUNCT_SUB;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_NONZERO;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b1;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????100?????11000: begin // BLT
                control_signals_o.alu_funct = ALU_FUNCT_SLT;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_ZERO;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b1;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????101?????11000: begin // BGE
                control_signals_o.alu_funct = ALU_FUNCT_SLT;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_NONZERO;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b1;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????110?????11000: begin // BLTU
                control_signals_o.alu_funct = ALU_FUNCT_SLTU;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_ZERO;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b1;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????111?????11000: begin // BGEU
                control_signals_o.alu_funct = ALU_FUNCT_SLTU;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                control_signals_o.alu_cond = ALU_COND_NONZERO;
                control_signals_o.writeback = 1'b0;
                control_signals_o.branch = 1'b1;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            30'b?????????????????????????11100: begin // CSR_OTHER
                control_signals_o.alu_funct = ALU_FUNCT_ZERO;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 1'b1;
                control_signals_o.branch = 1'b0;
                control_signals_o.binit = 1'b0;
                control_signals_o.bwait = 1'b0;
                control_signals_o.yield = 1'b0;
            end
            default: begin // INVALID
                control_signals_o.alu_funct = ALU_FUNCT_UNDEFINED;
                control_signals_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                control_signals_o.alu_cond = ALU_COND_UNDEFINED;
                control_signals_o.writeback = 'x;
                control_signals_o.branch = 'x;
                control_signals_o.binit = 'x;
                control_signals_o.bwait = 'x;
                control_signals_o.yield = 'x;
            end
        endcase
    end

endmodule

`default_nettype wire
