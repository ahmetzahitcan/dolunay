`default_nettype none

package control_unit_pkg;
	import params_pkg::*;

	typedef enum logic [1:0] {
		IMM_TYPE_I,
		IMM_TYPE_B,
		IMM_TYPE_S,
		IMM_TYPE_U,
		IMM_TYPE_UNDEFINED='x
	} imm_type_e;

	typedef enum logic [3:0] {
		ALU_FUNCT_HARTID,
		ALU_FUNCT_ADD,
		ALU_FUNCT_SUB,
		ALU_FUNCT_SLL,
		ALU_FUNCT_SLT,
		ALU_FUNCT_SLTU,
		ALU_FUNCT_XOR,
		ALU_FUNCT_SRL,
		ALU_FUNCT_SRA,
		ALU_FUNCT_OR,
		ALU_FUNCT_AND,
		ALU_FUNCT_OP2,
		ALU_FUNCT_ZERO,
		ALU_FUNCT_UNDEFINED='x
	} alu_funct_e;

	typedef enum logic {
		ALU_OP1_SEL_RS1,
		ALU_OP1_SEL_PC,
		ALU_OP1_SEL_UNDEFINED='x
	} alu_op1_sel_e;

	typedef enum logic {
		ALU_OP2_SEL_RS2,
		ALU_OP2_SEL_IMM,
		ALU_OP2_SEL_UNDEFINED='x
	} alu_op2_sel_e;

	typedef enum logic {
		ALU_COND_ZERO,
		ALU_COND_NONZERO,
		ALU_COND_UNDEFINED='x
	} alu_cond_e;

	typedef enum logic {
		WB_SOURCE_ALU_OUT,
		WB_SOURCE_MEM_OUT,
		WB_SOURCE_UNDEFINED='x
	} wb_source_e;

	typedef enum logic {
		MEM_LOADSTORE_LOAD,
		MEM_LOADSTORE_STORE,
		MEM_LOADSTORE_UNDEFINED='x
	} mem_loadstore_e;

	typedef enum logic [1:0] {
		MEM_OPSIZE_BYTE,
		MEM_OPSIZE_HALF,
		MEM_OPSIZE_WORD,
		MEM_OPSIZE_UNDEFINED='x
	} mem_opsize_e;

	typedef enum logic {
		MEM_EXTENDMODE_SIGN,
		MEM_EXTENDMODE_ZERO,
		MEM_EXTENDMODE_UNDEFINED='x
	} mem_extendmode_e;

	typedef struct packed {
		logic [XLEN-1:0] imm;
		logic [LOG_NUM_REGISTERS-1:0] rd_idx;
		logic [LOG_NUM_REGISTERS-1:0] rs1_idx;
		logic [LOG_NUM_REGISTERS-1:0] rs2_idx;
		logic [LOG_NUM_BARRIERS-1:0] barr_idx;
		alu_funct_e alu_funct;
		alu_op1_sel_e alu_op1_sel;
		alu_op2_sel_e alu_op2_sel;
		alu_cond_e alu_cond;
		logic wb_active;
		wb_source_e wb_source;
		logic branch;
		logic binit;
		logic bwait;
		logic yield;
		logic mem_active;
		mem_loadstore_e mem_loadstore;
		mem_opsize_e mem_opsize;
		mem_extendmode_e mem_extendmode;
	} instr_s;

endpackage

`default_nettype wire
