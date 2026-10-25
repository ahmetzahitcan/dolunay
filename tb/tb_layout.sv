// Prints the bit layout of the packed structs the LSU testbench has to
// drive and sample. Build it with the project's file list:
//   cd sim && verilator --binary --timing --top-module tb_layout \
//       --Mdir "$HOME/dolunay-sim/layout" -o layout -f lsu.f ../build/tb_layout.sv
//
// A packed struct puts its first member in the most significant bits.

module tb_layout;
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;

    // ---- fu_operation_s ----------------------------------------------------
    localparam int OP_SEQ_MSB   = $bits(fu_operation_s)-1;
    localparam int OP_SEQ_LSB   = OP_SEQ_MSB   - $bits(seq_t)   + 1;
    localparam int OP_WARP_MSB  = OP_SEQ_LSB   - 1;
    localparam int OP_WARP_LSB  = OP_WARP_MSB  - $bits(warp_id_t) + 1;
    localparam int OP_INSTR_MSB = OP_WARP_LSB  - 1;
    localparam int OP_INSTR_LSB = OP_INSTR_MSB - $bits(instr_s) + 1;
    localparam int OP_PC_MSB    = OP_INSTR_LSB - 1;
    localparam int OP_PC_LSB    = OP_PC_MSB    - $bits(pc_t)     + 1;
    localparam int OP_MASK_MSB  = OP_PC_LSB    - 1;
    localparam int OP_MASK_LSB  = OP_MASK_MSB  - $bits(simd_mask_t) + 1;
    localparam int OP_RS1_MSB   = OP_MASK_LSB  - 1;
    localparam int OP_RS1_LSB   = OP_RS1_MSB   - $bits(simd_data_t) + 1;
    localparam int OP_RS2_MSB   = OP_RS1_LSB   - 1;
    localparam int OP_RS2_LSB   = OP_RS2_MSB   - $bits(simd_data_t) + 1;
    localparam int OP_RS3_MSB   = OP_RS2_LSB   - 1;
    localparam int OP_RS3_LSB   = OP_RS3_MSB   - $bits(simd_data_t) + 1;

    // ---- fu_result_s -------------------------------------------------------
    localparam int RE_SEQ_MSB    = $bits(fu_result_s)-1;
    localparam int RE_SEQ_LSB    = RE_SEQ_MSB    - $bits(seq_t)   + 1;
    localparam int RE_WARP_MSB   = RE_SEQ_LSB    - 1;
    localparam int RE_WARP_LSB   = RE_WARP_MSB   - $bits(warp_id_t) + 1;
    localparam int RE_INSTR_MSB  = RE_WARP_LSB   - 1;
    localparam int RE_INSTR_LSB  = RE_INSTR_MSB  - $bits(instr_s) + 1;
    localparam int RE_PC_MSB     = RE_INSTR_LSB  - 1;
    localparam int RE_PC_LSB     = RE_PC_MSB     - $bits(pc_t)     + 1;
    localparam int RE_MASK_MSB   = RE_PC_LSB     - 1;
    localparam int RE_MASK_LSB   = RE_MASK_MSB   - $bits(simd_mask_t) + 1;
    localparam int RE_UWB_MSB    = RE_MASK_LSB   - 1;
    localparam int RE_UWB_LSB    = RE_UWB_MSB    - 1;
    localparam int RE_WB_MSB     = RE_UWB_LSB    - 1;
    localparam int RE_WB_LSB     = RE_WB_MSB     - $bits(simd_data_t) + 1;
    localparam int RE_UWB_V_MSB  = RE_WB_LSB     - 1;
    localparam int RE_UWB_V_LSB  = RE_UWB_V_MSB  - $bits(uniform_data_t) + 1;
    localparam int RE_CSRW_MSB   = RE_UWB_V_LSB  - 1;
    localparam int RE_CSRW_LSB   = RE_CSRW_MSB   - $bits(simd_data_t) + 1;
    localparam int RE_FPU_MSB    = RE_CSRW_LSB   - 1;
    localparam int RE_FPU_LSB    = RE_FPU_MSB    - $bits(fpnew_pkg::status_t)*N_THREADS + 1;

    // ---- instr_s -----------------------------------------------------------
    localparam int IN_DISASM_MSB = $bits(instr_s)-1;
    localparam int IN_DISASM_LSB = IN_DISASM_MSB - $bits(sim__disasm_t) + 1;
    localparam int IN_IMM_MSB    = IN_DISASM_LSB - 1;
    localparam int IN_IMM_LSB    = IN_IMM_MSB    - $bits(logic [RLEN-1:0]) + 1;
    localparam int IN_RD_MSB     = IN_IMM_LSB    - 1;
    localparam int IN_RD_LSB     = IN_RD_MSB     - $bits(logic [W_REGISTERS-1:0]) + 1;
    localparam int IN_RS1I_MSB   = IN_RD_LSB     - 1;
    localparam int IN_RS1I_LSB   = IN_RS1I_MSB   - $bits(logic [W_REGISTERS-1:0]) + 1;
    localparam int IN_RS2I_MSB   = IN_RS1I_LSB   - 1;
    localparam int IN_RS2I_LSB   = IN_RS2I_MSB   - $bits(logic [W_REGISTERS-1:0]) + 1;
    localparam int IN_RS3I_MSB   = IN_RS2I_LSB   - 1;
    localparam int IN_RS3I_LSB   = IN_RS3I_MSB   - $bits(logic [W_REGISTERS-1:0]) + 1;
    localparam int IN_RND_MSB   = IN_RS3I_LSB   - 1;
    localparam int IN_RND_LSB   = IN_RND_MSB   - 3 + 1;
    localparam int IN_RDUSED_MSB = IN_RND_LSB   - 1;
    localparam int IN_RDUSED_LSB = IN_RDUSED_MSB - 1 + 1;
    localparam int IN_RDF_MSB    = IN_RDUSED_LSB - 1;
    localparam int IN_RDF_LSB    = IN_RDF_MSB    - $bits(regfile_sel_e) + 1;
    localparam int IN_RS1U_MSB   = IN_RDF_LSB    - 1;
    localparam int IN_RS1U_LSB   = IN_RS1U_MSB   - 1 + 1;
    localparam int IN_RS1F_MSB   = IN_RS1U_LSB   - 1;
    localparam int IN_RS1F_LSB   = IN_RS1F_MSB   - $bits(regfile_sel_e) + 1;
    localparam int IN_RS2U_MSB   = IN_RS1F_LSB   - 1;
    localparam int IN_RS2U_LSB   = IN_RS2U_MSB   - 1 + 1;
    localparam int IN_RS2F_MSB   = IN_RS2U_LSB   - 1;
    localparam int IN_RS2F_LSB   = IN_RS2F_MSB   - $bits(regfile_sel_e) + 1;
    localparam int IN_RS3U_MSB   = IN_RS2F_LSB   - 1;
    localparam int IN_RS3U_LSB   = IN_RS3U_MSB   - 1 + 1;
    localparam int IN_RS3F_MSB   = IN_RS3U_LSB   - 1;
    localparam int IN_RS3F_LSB   = IN_RS3F_MSB   - $bits(regfile_sel_e) + 1;
    localparam int IN_HAZ_MSB    = IN_RS3F_LSB   - 1;
    localparam int IN_HAZ_LSB    = IN_HAZ_MSB    - $bits(hazards_e)*N_HAZARDS + 1;
    localparam int IN_FUSEL_MSB  = IN_HAZ_LSB    - 1;
    localparam int IN_FUSEL_LSB  = IN_FUSEL_MSB  - $bits(function_unit_e) + 1;
    localparam int IN_CSRRS_MSB  = IN_FUSEL_LSB  - 1;
    localparam int IN_CSRRS_LSB  = IN_CSRRS_MSB  - 1 + 1;
    localparam int IN_CSRW_MSB   = IN_CSRRS_LSB  - 1;
    localparam int IN_CSRW_LSB   = IN_CSRW_MSB   - 1 + 1;
    localparam int IN_FFU_MSB    = IN_CSRW_LSB   - 1;
    localparam int IN_FFU_LSB    = IN_FFU_MSB    - 1 + 1;
    localparam int IN_ALUF_MSB   = IN_FFU_LSB    - 1;
    localparam int IN_ALUF_LSB   = IN_ALUF_MSB   - $bits(alu_funct_e) + 1;
    localparam int IN_ALUAF_MSB  = IN_ALUF_LSB   - 1;
    localparam int IN_ALUAF_LSB  = IN_ALUAF_MSB  - $bits(alu_addy_funct_e) + 1;
    localparam int IN_ALU1_MSB   = IN_ALUAF_LSB  - 1;
    localparam int IN_ALU1_LSB   = IN_ALU1_MSB   - $bits(alu_op1_sel_e) + 1;
    localparam int IN_ALU2_MSB   = IN_ALU1_LSB   - 1;
    localparam int IN_ALU2_LSB   = IN_ALU2_MSB   - $bits(alu_op2_sel_e) + 1;
    localparam int IN_FPUOP_MSB  = IN_ALU2_LSB   - 1;
    localparam int IN_FPUOP_LSB  = IN_FPUOP_MSB  - $bits(fpnew_pkg::operation_e) + 1;
    localparam int IN_FPUMOD_MSB = IN_FPUOP_LSB  - 1;
    localparam int IN_FPUMOD_LSB = IN_FPUMOD_MSB - 1 + 1;
    localparam int IN_FPU0_MSB   = IN_FPUMOD_LSB - 1;
    localparam int IN_FPU0_LSB   = IN_FPU0_MSB   - 1 + 1;
    localparam int IN_FPU1_MSB   = IN_FPU0_LSB   - 1;
    localparam int IN_FPU1_LSB   = IN_FPU1_MSB   - $bits(fpu_op1_sel_e) + 1;
    localparam int IN_FPU2_MSB   = IN_FPU1_LSB   - 1;
    localparam int IN_FPU2_LSB   = IN_FPU2_MSB   - $bits(fpu_op2_sel_e) + 1;
    localparam int IN_BJ_MSB     = IN_FPU2_LSB   - 1;
    localparam int IN_BJ_LSB     = IN_BJ_MSB     - $bits(bj_type_e) + 1;
    localparam int IN_MEMACT_MSB = IN_BJ_LSB     - 1;
    localparam int IN_MEMACT_LSB = IN_MEMACT_MSB - 1 + 1;
    localparam int IN_LS_MSB     = IN_MEMACT_LSB - 1;
    localparam int IN_LS_LSB     = IN_LS_MSB     - 1 + 1;
    localparam int IN_OS_MSB     = IN_LS_LSB     - 1;
    localparam int IN_OS_LSB     = IN_OS_MSB     - $bits(mem_opsize_e) + 1;
    localparam int IN_EM_MSB     = IN_OS_LSB     - 1;
    localparam int IN_EM_LSB     = IN_EM_MSB     - 1 + 1;

    initial begin
        $display("=== widths ===");
        $display("seq_t                %0d", $bits(seq_t));
        $display("warp_id_t            %0d", $bits(warp_id_t));
        $display("pc_t                 %0d", $bits(pc_t));
        $display("simd_mask_t          %0d", $bits(simd_mask_t));
        $display("simd_data_t          %0d", $bits(simd_data_t));
        $display("uniform_data_t       %0d", $bits(uniform_data_t));
        $display("instr_s              %0d", $bits(instr_s));
        $display("fu_operation_s       %0d", $bits(fu_operation_s));
        $display("fu_result_s          %0d", $bits(fu_result_s));

        $display("=== fu_operation_s ===");
        $display("seq                 [%0d:%0d]", OP_SEQ_MSB,  OP_SEQ_LSB);
        $display("warp_id             [%0d:%0d]", OP_WARP_MSB, OP_WARP_LSB);
        $display("instr               [%0d:%0d]", OP_INSTR_MSB,OP_INSTR_LSB);
        $display("pc                  [%0d:%0d]", OP_PC_MSB,   OP_PC_LSB);
        $display("mask                [%0d:%0d]", OP_MASK_MSB, OP_MASK_LSB);
        $display("rs1_data            [%0d:%0d]", OP_RS1_MSB,  OP_RS1_LSB);
        $display("rs2_data            [%0d:%0d]", OP_RS2_MSB,  OP_RS2_LSB);
        $display("rs3_data            [%0d:%0d]", OP_RS3_MSB,  OP_RS3_LSB);

        $display("=== fu_result_s ===");
        $display("seq                 [%0d:%0d]", RE_SEQ_MSB,   RE_SEQ_LSB);
        $display("warp_id             [%0d:%0d]", RE_WARP_MSB,  RE_WARP_LSB);
        $display("instr               [%0d:%0d]", RE_INSTR_MSB, RE_INSTR_LSB);
        $display("pc                  [%0d:%0d]", RE_PC_MSB,    RE_PC_LSB);
        $display("mask                [%0d:%0d]", RE_MASK_MSB,  RE_MASK_LSB);
        $display("use_uwb             [%0d:%0d]", RE_UWB_MSB,   RE_UWB_LSB);
        $display("wb_result           [%0d:%0d]", RE_WB_MSB,    RE_WB_LSB);
        $display("uwb_result          [%0d:%0d]", RE_UWB_V_MSB, RE_UWB_V_LSB);
        $display("csrw_result         [%0d:%0d]", RE_CSRW_MSB,  RE_CSRW_LSB);
        $display("fpu_status          [%0d:%0d]", RE_FPU_MSB,   RE_FPU_LSB);

        $display("=== instr_s ===");
        $display("sim__disasm         [%0d:%0d]", IN_DISASM_MSB, IN_DISASM_LSB);
        $display("imm                 [%0d:%0d]", IN_IMM_MSB,    IN_IMM_LSB);
        $display("rd_idx              [%0d:%0d]", IN_RD_MSB,     IN_RD_LSB);
        $display("rs1_idx             [%0d:%0d]", IN_RS1I_MSB,   IN_RS1I_LSB);
        $display("rs2_idx             [%0d:%0d]", IN_RS2I_MSB,   IN_RS2I_LSB);
        $display("rs3_idx             [%0d:%0d]", IN_RS3I_MSB,   IN_RS3I_LSB);
        $display("fpu_roundmode       [%0d:%0d]", IN_RND_MSB,    IN_RND_LSB);
        $display("rd_used             [%0d:%0d]", IN_RDUSED_MSB, IN_RDUSED_LSB);
        $display("rd_regfile          [%0d:%0d]", IN_RDF_MSB,    IN_RDF_LSB);
        $display("rs1_used            [%0d:%0d]", IN_RS1U_MSB,   IN_RS1U_LSB);
        $display("rs1_regfile         [%0d:%0d]", IN_RS1F_MSB,   IN_RS1F_LSB);
        $display("rs2_used            [%0d:%0d]", IN_RS2U_MSB,   IN_RS2U_LSB);
        $display("rs2_regfile         [%0d:%0d]", IN_RS2F_MSB,   IN_RS2F_LSB);
        $display("rs3_used            [%0d:%0d]", IN_RS3U_MSB,   IN_RS3U_LSB);
        $display("rs3_regfile         [%0d:%0d]", IN_RS3F_MSB,   IN_RS3F_LSB);
        $display("hazards             [%0d:%0d]", IN_HAZ_MSB,    IN_HAZ_LSB);
        $display("fu_sel              [%0d:%0d]", IN_FUSEL_MSB,  IN_FUSEL_LSB);
        $display("csrr_src            [%0d:%0d]", IN_CSRRS_MSB,  IN_CSRRS_LSB);
        $display("csrw_method         [%0d:%0d]", IN_CSRW_MSB,   IN_CSRW_LSB);
        $display("fflags_update       [%0d:%0d]", IN_FFU_MSB,    IN_FFU_LSB);
        $display("alu_funct           [%0d:%00d]", IN_ALUF_MSB,   IN_ALUF_LSB);
        $display("alu_addy_funct      [%0d:%0d]", IN_ALUAF_MSB,  IN_ALUAF_LSB);
        $display("alu_op1_sel         [%0d:%0d]", IN_ALU1_MSB,   IN_ALU1_LSB);
        $display("alu_op2_sel         [%0d:%0d]", IN_ALU2_MSB,   IN_ALU2_LSB);
        $display("fpu_opcode          [%0d:%0d]", IN_FPUOP_MSB,  IN_FPUOP_LSB);
        $display("fpu_op_modifier     [%0d:%0d]", IN_FPUMOD_MSB, IN_FPUMOD_LSB);
        $display("fpu_op0_sel         [%0d:%0d]", IN_FPU0_MSB,   IN_FPU0_LSB);
        $display("fpu_op1_sel         [%0d:%0d]", IN_FPU1_MSB,   IN_FPU1_LSB);
        $display("fpu_op2_sel         [%0d:%0d]", IN_FPU2_MSB,   IN_FPU2_LSB);
        $display("bj_type             [%0d:%0d]", IN_BJ_MSB,     IN_BJ_LSB);
        $display("mem_active          [%0d:%0d]", IN_MEMACT_MSB, IN_MEMACT_LSB);
        $display("mem_loadstore       [%0d:%0d]", IN_LS_MSB,     IN_LS_LSB);
        $display("mem_opsize          [%0d:%0d]", IN_OS_MSB,     IN_OS_LSB);
        $display("mem_extendmode      [%0d:%0d]", IN_EM_MSB,     IN_EM_LSB);

        $display("=== enums ===");
        $display("regfile_sel_e        %0d", $bits(regfile_sel_e));
        $display("hazards_e            %0d", $bits(hazards_e));
        $display("function_unit_e      %0d", $bits(function_unit_e));
        $display("csrr_src_e           %0d", $bits(csrr_src_e));
        $display("csrw_method_e        %0d", $bits(csrw_method_e));
        $display("fflags_update_e      %0d", $bits(fflags_update_e));
        $display("alu_funct_e          %0d", $bits(alu_funct_e));
        $display("alu_addy_funct_e     %0d", $bits(alu_addy_funct_e));
        $display("alu_op1_sel_e        %0d", $bits(alu_op1_sel_e));
        $display("alu_op2_sel_e        %0d", $bits(alu_op2_sel_e));
        $display("fpnew operation_e    %0d", $bits(fpnew_pkg::operation_e));
        $display("fpu_op0_sel_e        %0d", $bits(fpu_op0_sel_e));
        $display("fpu_op1_sel_e        %0d", $bits(fpu_op1_sel_e));
        $display("fpu_op2_sel_e        %0d", $bits(fpu_op2_sel_e));
        $display("bj_type_e            %0d", $bits(bj_type_e));
        $display("mem_loadstore_e      %0d", $bits(mem_loadstore_e));
        $display("mem_opsize_e         %0d", $bits(mem_opsize_e));
        $display("mem_extendmode_e     %0d", $bits(mem_extendmode_e));
        $display("sim__disasm_t        %0d", $bits(sim__disasm_t));
        $display("fpnew status_t       %0d", $bits(fpnew_pkg::status_t));
        $display("MEM_OPSIZE_BYTE %0d HALF %0d WORD %0d",
                 MEM_OPSIZE_BYTE, MEM_OPSIZE_HALF, MEM_OPSIZE_WORD);
        $display("MEM_LOADSTORE_LOAD %0d STORE %0d",
                 MEM_LOADSTORE_LOAD, MEM_LOADSTORE_STORE);
        $display("MEM_EXTENDMODE_SIGN %0d ZERO %0d",
                 MEM_EXTENDMODE_SIGN, MEM_EXTENDMODE_ZERO);
        $display("FUNCTION_UNIT_LSU %0d", FUNCTION_UNIT_LSU);
        $finish;
    end
endmodule
