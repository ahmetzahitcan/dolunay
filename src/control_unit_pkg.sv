`default_nettype none

package control_unit_pkg;

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
		ALU_FUNCT_ZERO,
		ALU_FUNCT_UNDEFINED='x
	} alu_funct_e;

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

	typedef struct packed {
		alu_funct_e alu_funct;
		alu_op2_sel_e alu_op2_sel;
		alu_cond_e alu_cond;
		logic writeback;
		logic branch;
		logic binit;
		logic bwait;
		logic yield;
	} control_signals_s;

endpackage

`default_nettype wire
