`default_nettype none

package control_unit_pkg;

	typedef enum logic {
		ALU_ADD,
		ALU_BEQ,
		UNDEFINED='x
	} alu_funct_e;

	typedef struct packed {
		alu_funct_e alu_funct;
		logic writeback;
		logic branch;
		logic binit;
		logic bwait;
		logic yield;
	} control_signals_s;

endpackage

`default_nettype wire
