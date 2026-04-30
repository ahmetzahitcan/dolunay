`default_nettype none

module control_unit
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input  wire  [31:2] undec_instr32_i,
    input  wire  [XLEN-1:Z_PC] pc_i,
    input  wire  valid_i,
    output instr_s instr_o
);

    imm_type_e imm_type_w;

    immediate_decoder u_imm(
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
        .imm_i(instr_o.imm),
        .pc_i(pc_i),
        .disasm_o(instr_o.sim__disasm)
    );
    `endif

    always_comb begin
        instr_o.rd_idx = undec_instr32_i[W_REGISTERS+6:7];
        instr_o.rs1_idx = undec_instr32_i[W_REGISTERS+14:15];
        instr_o.rs2_idx = undec_instr32_i[W_REGISTERS+19:20];
        case (undec_instr32_i) inside
            30'b000000000000000001000000000010: begin // YIELD
                `ifndef SYNTHESIS
                sim__disasm_format_w = "yield";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_UNDEFINED;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b000000000000000000100000000100: begin // WDONE
                `ifndef SYNTHESIS
                sim__disasm_format_w = "wdone";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b1;
            end
            30'b00010??00000?????010?????01011: begin // LR
                `ifndef SYNTHESIS
                sim__disasm_format_w = "lr.w $d, ($1)";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_OP1;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
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
                instr_o.is_lr = 1'b1;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b111100010100?????????????11100: begin // CSR_MHARTID
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, mhartid";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_HARTID;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b110011000000?????????????11100: begin // CSR_XWARPID
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, xwarpid";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_WARPID;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b110011000001?????????????11100: begin // CSR_XTHRID
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, xthrid";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_THRID;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b110011000010?????????????11100: begin // CSR_XROLE
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, xrole";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_UNDEFINED;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
                instr_o.alu_op1_sel = ALU_OP1_SEL_UNDEFINED;
                instr_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_SC;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b0;
                instr_o.mem_loadstore = MEM_LOADSTORE_UNDEFINED;
                instr_o.mem_opsize = MEM_OPSIZE_UNDEFINED;
                instr_o.mem_store_source = MEM_STORE_SOURCE_UNDEFINED;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b110000000010?????????????11100: begin // CSR_INSTRET
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, instret";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_INSTRET;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b110010000010?????????????11100: begin // CSR_INSTRETH
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, instreth";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_INSTRETH;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b110000000011?????????????11100: begin // CSR_WUINSTRET
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, wuinstret";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_WUINSTRET;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b110010000011?????????????11100: begin // CSR_WUINSTRETH
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, wuinstreth";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_WUINSTRETH;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b110000000100?????????????11100: begin // CSR_WTINSTRET
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, wtinstret";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_WTINSTRET;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b110010000100?????????????11100: begin // CSR_WTINSTRETH
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, wtinstreth";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_WTINSTRETH;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b11000000000??????????????11100: begin // CSR_CYCLETIME
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, cycle|time";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_CYCLETIME;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b11001000000??????????????11100: begin // CSR_CYCLETIMEH
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, cycleh|timeh";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_CYCLETIMEH;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????000?????01100: begin // ADD
                `ifndef SYNTHESIS
                sim__disasm_format_w = "add $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0010000??????????010?????01100: begin // SH1ADD
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sh1add $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SH1ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0010000??????????100?????01100: begin // SH2ADD
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sh2add $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SH2ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0010000??????????110?????01100: begin // SH3ADD
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sh3add $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SH3ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0100000??????????000?????01100: begin // SUB
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sub $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SUB;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????001?????01100: begin // SLL
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sll $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SLL;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????010?????01100: begin // SLT
                `ifndef SYNTHESIS
                sim__disasm_format_w = "slt $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????011?????01100: begin // SLTU
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sltu $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????100?????01100: begin // XOR
                `ifndef SYNTHESIS
                sim__disasm_format_w = "xor $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_XOR;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????101?????01100: begin // SRL
                `ifndef SYNTHESIS
                sim__disasm_format_w = "srl $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SRL;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0100000??????????101?????01100: begin // SRA
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sra $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_SRA;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????110?????01100: begin // OR
                `ifndef SYNTHESIS
                sim__disasm_format_w = "or $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_OR;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????111?????01100: begin // AND
                `ifndef SYNTHESIS
                sim__disasm_format_w = "and $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_AND;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????001?????00100: begin // SLLI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "slli $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SLL;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000000??????????101?????00100: begin // SRLI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "srli $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SRL;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0100000??????????101?????00100: begin // SRAI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "srai $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SRA;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000111??????????101?????01100: begin // CZERO_EQZ
                `ifndef SYNTHESIS
                sim__disasm_format_w = "czero.eqz $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_CZERO_EQZ;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b0000111??????????111?????01100: begin // CZERO_NEZ
                `ifndef SYNTHESIS
                sim__disasm_format_w = "czero.nez $d, $1, $2";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_CZERO_NEZ;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b00011????????????010?????01011: begin // SC
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sc.w $d, $2, ($1)";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_OP1;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
                instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
                instr_o.alu_op2_sel = ALU_OP2_SEL_UNDEFINED;
                instr_o.branch_cond = BRANCH_COND_NEVER;
                instr_o.wb_active = 1'b1;
                instr_o.wb_source = WB_SOURCE_SC;
                instr_o.barr_load = 1'b0;
                instr_o.barr_sync = 1'b0;
                instr_o.yield = 1'b0;
                instr_o.mem_active = 1'b1;
                instr_o.mem_loadstore = MEM_LOADSTORE_STORE;
                instr_o.mem_opsize = MEM_OPSIZE_WORD;
                instr_o.mem_store_source = MEM_STORE_SOURCE_RS2;
                instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
                instr_o.is_jalr = 1'b0;
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b1;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????0010000000010: begin // BINIT
                `ifndef SYNTHESIS
                sim__disasm_format_w = "binit $i($1)";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????0100000000010: begin // BSYNC_0
                `ifndef SYNTHESIS
                sim__disasm_format_w = "bsync $i($1)";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????000?????00100: begin // ADDI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "addi $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????010?????00100: begin // SLTI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "slti $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????011?????00100: begin // SLTIU
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sltiu $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????100?????00100: begin // XORI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "xori $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_XOR;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????110?????00100: begin // ORI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "ori $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_OR;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????111?????00100: begin // ANDI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "andi $d, $1, $i";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_AND;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????000?????11000: begin // BEQ
                `ifndef SYNTHESIS
                sim__disasm_format_w = "beq $1, $2, $p";
                `endif
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SUB;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????001?????11000: begin // BNE
                `ifndef SYNTHESIS
                sim__disasm_format_w = "bne $1, $2, $p";
                `endif
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_SUB;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????100?????11000: begin // BLT
                `ifndef SYNTHESIS
                sim__disasm_format_w = "blt $1, $2, $p";
                `endif
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????101?????11000: begin // BGE
                `ifndef SYNTHESIS
                sim__disasm_format_w = "bge $1, $2, $p";
                `endif
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SLT;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????110?????11000: begin // BLTU
                `ifndef SYNTHESIS
                sim__disasm_format_w = "bltu $1, $2, $p";
                `endif
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????111?????11000: begin // BGEU
                `ifndef SYNTHESIS
                sim__disasm_format_w = "bgeu $1, $2, $p";
                `endif
                imm_type_w = IMM_TYPE_B;
                instr_o.alu_funct = ALU_FUNCT_SLTU;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????000?????11001: begin // JALR
                `ifndef SYNTHESIS
                sim__disasm_format_w = "jalr $d, $i($1)";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????000?????00000: begin // LB
                `ifndef SYNTHESIS
                sim__disasm_format_w = "lb $d, $i($1)";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????001?????00000: begin // LH
                `ifndef SYNTHESIS
                sim__disasm_format_w = "lh $d, $i($1)";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????010?????00000: begin // LW
                `ifndef SYNTHESIS
                sim__disasm_format_w = "lw $d, $i($1)";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????100?????00000: begin // LBU
                `ifndef SYNTHESIS
                sim__disasm_format_w = "lbu $d, $i($1)";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????101?????00000: begin // LHU
                `ifndef SYNTHESIS
                sim__disasm_format_w = "lhu $d, $i($1)";
                `endif
                imm_type_w = IMM_TYPE_I;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????000?????01000: begin // SB
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sb $2, $i($1)";
                `endif
                imm_type_w = IMM_TYPE_S;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????001?????01000: begin // SH
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sh $2, $i($1)";
                `endif
                imm_type_w = IMM_TYPE_S;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????010?????01000: begin // SW
                `ifndef SYNTHESIS
                sim__disasm_format_w = "sw $2, $i($1)";
                `endif
                imm_type_w = IMM_TYPE_S;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????000?????00011: begin // FENCE
                `ifndef SYNTHESIS
                sim__disasm_format_w = "fence";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_UNDEFINED;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????????????11011: begin // JAL
                `ifndef SYNTHESIS
                sim__disasm_format_w = "jal $d, $p";
                `endif
                imm_type_w = IMM_TYPE_J;
                instr_o.alu_funct = ALU_FUNCT_UNDEFINED;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????????????01101: begin // LUI
                `ifndef SYNTHESIS
                sim__disasm_format_w = "lui $d, $i";
                `endif
                imm_type_w = IMM_TYPE_U;
                instr_o.alu_funct = ALU_FUNCT_OP2;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????????????00101: begin // AUIPC
                `ifndef SYNTHESIS
                sim__disasm_format_w = "auipc $d, $i";
                `endif
                imm_type_w = IMM_TYPE_U;
                instr_o.alu_funct = ALU_FUNCT_ADDY;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            30'b?????????????????????????11100: begin // CSR_OTHER
                `ifndef SYNTHESIS
                sim__disasm_format_w = "csrr $d, $i";
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_ZERO;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 1'b0;
                instr_o.is_sc = 1'b0;
                instr_o.is_wdone = 1'b0;
            end
            default: begin // INVALID
                `ifndef SYNTHESIS
                sim__disasm_format_w = "INVALID";
                if (valid_i) begin
                    $warning("Invalid instruction (%h) encountered at %d", undec_instr32_i, pc_i);
                end
                `endif
                imm_type_w = IMM_TYPE_UNDEFINED;
                instr_o.alu_funct = ALU_FUNCT_UNDEFINED;
                instr_o.alu_addy_funct = ALU_ADDY_FUNCT_UNDEFINED;
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
                instr_o.is_lr = 'x;
                instr_o.is_sc = 'x;
                instr_o.is_wdone = 'x;
            end
        endcase
    end

endmodule

`default_nettype wire
