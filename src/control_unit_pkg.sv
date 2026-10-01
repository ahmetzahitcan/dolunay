`default_nettype none

package control_unit_pkg;
	import params_pkg::*;

	typedef enum logic [1:0] {
		IMM_TYPE_I,
		IMM_TYPE_B,
		IMM_TYPE_J,
		IMM_TYPE_U
	} imm_type_e;

	typedef enum logic [1:0] {
		HAZARDS_IGN,
		HAZARDS_CKAQ,
		HAZARDS_AQ,
		HAZARDS_CK
	} hazards_e;

	typedef enum logic {
		CSRR_SRC_FFLAGS
	} csrr_src_e;

	typedef enum logic {
		CSRW_METHOD_WRITE
	} csrw_method_e;

	typedef enum logic [1:0] {
		FFLAGS_UPDATE_NONE,
		FFLAGS_UPDATE_CSRW,
		FFLAGS_UPDATE_ACC_FPU_STATUS
	} fflags_update_e;

	typedef enum logic [3:0] {
		ALU_FUNCT_ADDY,
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
		ALU_OP2_SEL_RS2,
		ALU_OP2_SEL_IMM
	} alu_op2_sel_e;

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

	typedef enum logic [1:0] {
		BJ_TYPE_NONE,
		BJ_TYPE_BEQ,
		BJ_TYPE_JAL
	} bj_type_e;

	localparam int N_HAZARDS = 2;
	localparam int W_HAZARDS = $clog2(N_HAZARDS);
	localparam int I_HAZARDS_FFLAGS = 0;
	localparam int I_HAZARDS_FRM = 1;

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
		logic rd_used;
		params_pkg::regfile_sel_e rd_regfile;
		logic rs1_used;
		params_pkg::regfile_sel_e rs1_regfile;
		logic rs2_used;
		params_pkg::regfile_sel_e rs2_regfile;
		logic rs3_used;
		params_pkg::regfile_sel_e rs3_regfile;
		hazards_e [N_HAZARDS-1:0] hazards;
		params_pkg::function_unit_e fu_sel;
		csrr_src_e csrr_src;
		csrw_method_e csrw_method;
		fflags_update_e fflags_update;
		alu_funct_e alu_funct;
		alu_addy_funct_e alu_addy_funct;
		alu_op1_sel_e alu_op1_sel;
		alu_op2_sel_e alu_op2_sel;
		fpnew_pkg::operation_e fpu_opcode;
		logic fpu_op_modifier;
		fpu_op0_sel_e fpu_op0_sel;
		fpu_op1_sel_e fpu_op1_sel;
		fpu_op2_sel_e fpu_op2_sel;
		bj_type_e bj_type;
	} instr_s;

endpackage

`default_nettype wire
