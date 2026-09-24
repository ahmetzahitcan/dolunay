`default_nettype none

package control_unit_pkg;
	import params_pkg::*;

	typedef enum logic {
		IMM_TYPE_I,
		IMM_TYPE_U
	} imm_type_e;

	typedef enum logic [3:0] {
		ALU_FUNCT_SLT,
		ALU_FUNCT_ADDY,
		ALU_FUNCT_SLL,
		ALU_FUNCT_SLTU,
		ALU_FUNCT_XOR,
		ALU_FUNCT_SRL,
		ALU_FUNCT_SRA,
		ALU_FUNCT_OR,
		ALU_FUNCT_AND,
		ALU_FUNCT_CZERO_EQZ,
		ALU_FUNCT_CZERO_NEZ,
		ALU_FUNCT_OP2
	} alu_funct_e;

	typedef enum logic [2:0] {
		ALU_ADDY_FUNCT_ADD,
		ALU_ADDY_FUNCT_SH1ADD,
		ALU_ADDY_FUNCT_SH2ADD,
		ALU_ADDY_FUNCT_SH3ADD,
		ALU_ADDY_FUNCT_SUB
	} alu_addy_funct_e;

	typedef enum logic {
		ALU_OP1_SEL_RS1,
		ALU_OP1_SEL_PC
	} alu_op1_sel_e;

	typedef enum logic {
		ALU_OP2_SEL_IMM,
		ALU_OP2_SEL_RS2
	} alu_op2_sel_e;

	typedef enum logic {
		BRANCH_COND_NEVER
	} branch_cond_e;

	typedef enum logic {
		WB_SOURCE_ALU,
		WB_SOURCE_FPU
	} wb_source_e;

	typedef enum logic {
		FPU_OP0_SEL_RS1
	} fpu_op0_sel_e;

	typedef enum logic {
		FPU_OP1_SEL_RS2,
		FPU_OP1_SEL_RS1
	} fpu_op1_sel_e;

	typedef enum logic {
		FPU_OP2_SEL_RS2,
		FPU_OP2_SEL_RS3
	} fpu_op2_sel_e;

	typedef struct packed {
		`ifndef SYNTHESIS
		sim__disasm_t sim__disasm;
		`endif
		logic [RLEN-1:0] imm;
		logic [W_REGISTERS-1:0] rd_idx;
		logic [W_REGISTERS-1:0] rs1_idx;
		logic [W_REGISTERS-1:0] rs2_idx;
		logic [W_REGISTERS-1:0] rs3_idx;
		logic [2:0] fpu_roundmode;
		params_pkg::regfile_sel_e rd_regfile;
		params_pkg::regfile_sel_e rs1_regfile;
		params_pkg::regfile_sel_e rs2_regfile;
		params_pkg::regfile_sel_e rs3_regfile;
		params_pkg::function_unit_e fu_sel;
		alu_funct_e alu_funct;
		alu_addy_funct_e alu_addy_funct;
		alu_op1_sel_e alu_op1_sel;
		alu_op2_sel_e alu_op2_sel;
		branch_cond_e branch_cond;
		logic wb_active;
		wb_source_e wb_source;
		logic barr_load;
		logic barr_sync;
		logic yield;
		logic mem_active;
		logic mem_loadstore;
		logic mem_opsize;
		logic mem_store_source;
		logic mem_extendmode;
		logic is_jalr;
		logic is_lr;
		logic is_sc;
		logic is_wdone;
		logic fpu_active;
		fpnew_pkg::operation_e fpu_opcode;
		logic fpu_op_modifier;
		fpu_op0_sel_e fpu_op0_sel;
		fpu_op1_sel_e fpu_op1_sel;
		fpu_op2_sel_e fpu_op2_sel;
	} instr_s;

endpackage

`default_nettype wire
