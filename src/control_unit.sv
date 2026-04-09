`default_nettype none

module control_unit
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input  wire  [31:2] undec_instr32_i,
    output instr_s instr_o
);

    imm_type_e imm_type_w;

    immediate_decoder u_imm(
        .undec_instr32_i(undec_instr32_i),
        .imm_type_i(imm_type_w),
        .imm_o(instr_o.imm)
    );

    always_comb begin
        instr_o.rd_idx = undec_instr32_i[W_REGISTERS+6:7];
        instr_o.rs1_idx = undec_instr32_i[W_REGISTERS+14:15];
        instr_o.rs2_idx = undec_instr32_i[W_REGISTERS+19:20];
        case (undec_instr32_i) inside
            30'b000000000000000001110000000010: begin // YIELD
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_UNDEFINED;
                instr_o.alu_op1_sel = ALU_OP1_SEL_UNDEFINED;
                instr_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b1;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b111100010100?????????????11100: begin // CSR_MHARTID
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_HARTID;
                instr_o.alu_op1_sel = ALU_OP1_SEL_UNDEFINED;
                instr_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????000?????01100: begin // ADD
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0100000??????????000?????01100: begin // SUB
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SUB;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????001?????01100: begin // SLL
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SLL;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????010?????01100: begin // SLT
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????011?????01100: begin // SLTU
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????100?????01100: begin // XOR
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_XOR;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????101?????01100: begin // SRL
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SRL;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0100000??????????101?????01100: begin // SRA
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SRA;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????110?????01100: begin // OR
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_OR;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????111?????01100: begin // AND
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_AND;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????001?????00100: begin // SLLI
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SLL;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000000??????????101?????00100: begin // SRLI
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SRL;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0100000??????????101?????00100: begin // SRAI
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SRA;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000111??????????101?????01100: begin // CZERO_EQZ
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_CZERO_EQZ;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b0000111??????????111?????01100: begin // CZERO_NEZ
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_CZERO_NEZ;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????0000000000010: begin // BINIT
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_STORE;
                instr_o.mem_opsize = MEM_OPSIZE_WORD;
                instr_o.mem_store_source = MEM_STORE_SOURCE_BINIT;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????0010000000010: begin // BLOAD
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b1;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_LOAD;
                instr_o.mem_opsize = MEM_OPSIZE_WORD;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????0100000000010: begin // BSYNC
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b1;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_STORE;
                instr_o.mem_opsize = MEM_OPSIZE_WORD;
                instr_o.mem_store_source = MEM_STORE_SOURCE_BSYNC;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????000?????00100: begin // ADDI
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????010?????00100: begin // SLTI
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????011?????00100: begin // SLTIU
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????100?????00100: begin // XORI
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_XOR;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????110?????00100: begin // ORI
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_OR;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????111?????00100: begin // ANDI
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_AND;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????000?????11000: begin // BEQ
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SUB;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_ZERO;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????001?????11000: begin // BNE
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SUB;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NONZERO;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????100?????11000: begin // BLT
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_ZERO;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????101?????11000: begin // BGE
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NONZERO;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????110?????11000: begin // BLTU
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_ZERO;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????111?????11000: begin // BGEU
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_RS2;
                instr_o.branch_cond = BRANCH_COND_NONZERO;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????000?????11001: begin // JALR
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_COALESCE;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_PC_P4;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b1;
            end
            30'b?????????????????000?????00000: begin // LB
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_MEM;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_LOAD;
                instr_o.mem_opsize = MEM_OPSIZE_BYTE;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_SIGN;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????001?????00000: begin // LH
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_MEM;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_LOAD;
                instr_o.mem_opsize = MEM_OPSIZE_HALF;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_SIGN;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????010?????00000: begin // LW
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_MEM;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_LOAD;
                instr_o.mem_opsize = MEM_OPSIZE_WORD;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????100?????00000: begin // LBU
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_MEM;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_LOAD;
                instr_o.mem_opsize = MEM_OPSIZE_BYTE;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_ZERO;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????101?????00000: begin // LHU
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_MEM;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_LOAD;
                instr_o.mem_opsize = MEM_OPSIZE_HALF;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_ZERO;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????000?????01000: begin // SB
                imm_type_w = IMM_TYPE_S;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_STORE;
                instr_o.mem_opsize = MEM_OPSIZE_BYTE;
                instr_o.mem_store_source = MEM_STORE_SOURCE_RS2;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????001?????01000: begin // SH
                imm_type_w = IMM_TYPE_S;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_STORE;
                instr_o.mem_opsize = MEM_OPSIZE_HALF;
                instr_o.mem_store_source = MEM_STORE_SOURCE_RS2;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????010?????01000: begin // SW
                imm_type_w = IMM_TYPE_S;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_STORE;
                instr_o.mem_opsize = MEM_OPSIZE_WORD;
                instr_o.mem_store_source = MEM_STORE_SOURCE_RS2;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????000?????00011: begin // FENCE
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_UNDEFINED;
                instr_o.alu_op1_sel = ALU_OP1_SEL_UNDEFINED;
                instr_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b0;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????????????11011: begin // JAL
                imm_type_w = IMM_TYPE_J;
                instr_o.alu_funct = ALU_FUNCT_UNDEFINED;
                instr_o.alu_op1_sel = ALU_OP1_SEL_UNDEFINED;
                instr_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                instr_o.branch_cond = BRANCH_COND_ALWAYS;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_PC_P4;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????????????01101: begin // LUI
                imm_type_w = IMM_TYPE_U;
                instr_o.alu_funct = ALU_FUNCT_OP2;
                instr_o.alu_op1_sel = ALU_OP1_SEL_UNDEFINED;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????????????00101: begin // AUIPC
                imm_type_w = IMM_TYPE_U;
                instr_o.alu_funct = ALU_FUNCT_ADD;
                instr_o.alu_op1_sel = ALU_OP1_SEL_PC;
                instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            30'b?????????????????????????11100: begin // CSR_OTHER
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_ZERO;
                instr_o.alu_op1_sel = ALU_OP1_SEL_UNDEFINED;
                instr_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_ALU;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
            end
            default: begin // INVALID
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_UNDEFINED;
                instr_o.alu_op1_sel = ALU_OP1_SEL_UNDEFINED;
                instr_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                instr_o.branch_cond = BRANCH_COND_UNDEFINED;
                instr_o.wb_active = 'x;
                instr_o.wb_source = WB_SOURCE_UNDEFINED;
                instr_o.barr_load = 'x;
                instr_o.barr_sync = 'x;
                instr_o.yield = 'x;
                instr_o.mem_active = 'x;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 'x;
            end
        endcase
    end

endmodule

`default_nettype wire
