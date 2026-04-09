`default_nettype none

package control_unit_pkg;
	import params_pkg::*;

	typedef enum logic [2:0] {
		IMM_TYPE_I,
		IMM_TYPE_B,
		IMM_TYPE_S,
		IMM_TYPE_J,
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
		ALU_FUNCT_CZERO_EQZ,
		ALU_FUNCT_CZERO_NEZ,
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

	typedef enum logic [2:0] {
		BRANCH_COND_NEVER,
		BRANCH_COND_ZERO,
		BRANCH_COND_NONZERO,
		BRANCH_COND_COALESCE,
		BRANCH_COND_ALWAYS,
		BRANCH_COND_UNDEFINED='x
	} branch_cond_e;

	typedef enum logic [1:0] {
		WB_SOURCE_ALU,
		WB_SOURCE_PC_P4,
		WB_SOURCE_MEM,
		WB_SOURCE_UNDEFINED='x
	} wb_source_e;

	typedef enum logic {
		MEM_LOADSTORE_STORE,
		MEM_LOADSTORE_LOAD,
		MEM_LOADSTORE_UNDEFINED='x
	} mem_loadstore_e;

	typedef enum logic [1:0] {
		MEM_OPSIZE_WORD,
		MEM_OPSIZE_BYTE,
		MEM_OPSIZE_HALF,
		MEM_OPSIZE_UNDEFINED='x
	} mem_opsize_e;

	typedef enum logic [1:0] {
		MEM_STORE_SOURCE_BINIT,
		MEM_STORE_SOURCE_RS2,
		MEM_STORE_SOURCE_BSYNC,
		MEM_STORE_SOURCE_UNDEFINED='x
	} mem_store_source_e;

	typedef enum logic {
		MEM_EXTENDMODE_SIGN,
		MEM_EXTENDMODE_ZERO,
		MEM_EXTENDMODE_UNDEFINED='x
	} mem_extendmode_e;

	typedef struct packed {
		logic [XLEN-1:0] imm;
		logic [W_REGISTERS-1:0] rd_idx;
		logic [W_REGISTERS-1:0] rs1_idx;
		logic [W_REGISTERS-1:0] rs2_idx;
		alu_funct_e alu_funct;
		alu_op1_sel_e alu_op1_sel;
		alu_op2_sel_e alu_op2_sel;
		branch_cond_e branch_cond;
		logic wb_active;
		wb_source_e wb_source;
		logic barr_load;
		logic barr_sync;
		logic yield;
		logic mem_active;
		mem_loadstore_e mem_loadstore;
		mem_opsize_e mem_opsize;
		mem_store_source_e mem_store_source;
		mem_extendmode_e mem_extendmode;
		logic is_jalr;
	} instr_s;

endpackage

`default_nettype wire
