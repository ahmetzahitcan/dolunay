`default_nettype none

// =============================================================================
// tb_fu_lsu_cocotb — the harness of the cocotb load/store unit testbench.
//
// This is the SystemVerilog testbench (tb/tb_fu_lsu.sv) reduced to what
// cocotb needs. The shadow copy of the scratchpad and the reference model
// live in Python (pytb/fu_lsu/lsu_model.py), so all that is left here is
// the hardware.
//
// The LSU and the real scratchpad are instantiated together, so the
// scratchpad's registered read is part of what is being tested rather than
// something the testbench assumes.
//
// The scratchpad is written by the LSU, except while the testbench fills it
// with the initial pattern. cocotb cannot drive a wire that the RTL also
// drives, so that mux stays here: Python flips init_mode to fill the memory
// and then hands the ports over to the LSU.
//
// The packed structs are packed and unpacked *here*, and not in the
// testbench, because only SystemVerilog knows where their fields are. The
// testbench talks in the fields it cares about — the mask, the addresses,
// the size of the access — and the harness puts them where the LSU expects
// them. A change of a struct is therefore a change of this file, and the
// compiler says so, instead of a change that silently misdrives the
// testbench.
// =============================================================================

module tb_fu_lsu_cocotb
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
(
    input  wire logic clk,
    input  wire logic rst_n,

    // The handshake, which is the same for every function unit.
    input  wire logic in_valid_i,
    output logic      in_ready_o,
    output logic      out_valid_o,
    input  wire logic out_ready_i,

    // The operation, in the fields the testbench thinks in.
    input  wire seq_t                        op_seq,
    input  wire simd_mask_t                  op_mask,
    input  wire simd_data_t                  op_rs1,
    input  wire simd_data_t                  op_rs2,
    input  wire logic [RLEN-1:0]            op_imm,
    input  wire mem_loadstore_e              op_mem_loadstore,
    input  wire mem_opsize_e                 op_mem_opsize,
    input  wire mem_extendmode_e             op_mem_extendmode,

    // The result, in the same spirit.
    output simd_mask_t                    res_mask,
    output logic [N_THREADS-1:0][RLEN-1:0]  res_wb_result,
    output logic [$bits(instr_s)-1:0]        res_instr,
    output logic [$bits(instr_s)-1:0]        op_instr,

    // The parameters of the design, so that the testbench can check that
    // the model it has is a model of *this* design.
    output logic [15:0] param_rlen_o,
    output logic [15:0] param_n_threads_o,
    output logic [15:0] param_n_spad_banks_o,
    output logic [15:0] param_spad_bank_depth_o,
    output logic [15:0] param_addr_align_o,

    // While init_mode is high the scratchpad is written with init_* instead
    // of the LSU's outputs, so that the testbench can fill it with a
    // pattern before the test starts.
    input  wire logic        init_mode,
    input  wire logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] init_addr,
    input  wire logic [N_SPAD_BANKS-1:0][RLEN-1:0]                init_wdata,
    input  wire logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0]          init_wen
);

    // ---------------------------------------------------------------------------
    // The parameters of the design
    // ---------------------------------------------------------------------------

    assign param_rlen_o           = RLEN;
    assign param_n_threads_o      = N_THREADS;
    assign param_n_spad_banks_o   = N_SPAD_BANKS;
    assign param_spad_bank_depth_o = SPAD_BANK_DEPTH;
    assign param_addr_align_o     = ADDR_ALIGN;

    // ---------------------------------------------------------------------------
    // The operation, packed into the struct the LSU takes
    //
    // The fields the LSU does not look at are given the values the
    // SystemVerilog testbench gives them, so that the two testbenches
    // present the same instruction.
    // ---------------------------------------------------------------------------

    instr_s instr_w;

    always_comb begin
        instr_w = '{
            imm:            op_imm,
            rd_used:        (op_mem_loadstore == MEM_LOADSTORE_LOAD),
            rd_regfile:     REGFILE_SEL_I,
            rs1_regfile:    REGFILE_SEL_I,
            rs2_regfile:    REGFILE_SEL_I,
            rs3_regfile:    REGFILE_SEL_I,
            fu_sel:         FUNCTION_UNIT_LSU,
            csrr_src:       CSRR_SRC_FFLAGS,
            csrw_method:    CSRW_METHOD_WRITE,
            fflags_update:  FFLAGS_UPDATE_NONE,
            alu_funct:      ALU_FUNCT_ADDY,
            alu_addy_funct: ALU_ADDY_FUNCT_ADD,
            alu_op1_sel:    ALU_OP1_SEL_RS1,
            alu_op2_sel:    ALU_OP2_SEL_RS2,
            fpu_opcode:     fpnew_pkg::ADD,
            fpu_op0_sel:    FPU_OP0_SEL_RS1,
            fpu_op1_sel:    FPU_OP1_SEL_RS1,
            fpu_op2_sel:    FPU_OP2_SEL_RS2,
            bj_type:        BJ_TYPE_NONE,
            mem_active:     1'b1,
            mem_loadstore:  op_mem_loadstore,
            mem_opsize:     op_mem_opsize,
            mem_extendmode: op_mem_extendmode,
            hazards:        '{default: HAZARDS_IGN},
            default:        '0
        };
    end

    fu_operation_s operation_w;

    always_comb begin
        operation_w = '{
            seq:      op_seq,
            warp_id:  '0,
            instr:    instr_w,
            pc:       '0,
            mask:     op_mask,
            rs1_data: op_rs1,
            rs2_data: op_rs2,
            rs3_data: '0
        };
    end

    // ---------------------------------------------------------------------------
    // The result, unpacked out of the struct the LSU gives
    // ---------------------------------------------------------------------------

    fu_result_s out_result_o;

    assign res_mask      = out_result_o.mask;
    assign res_wb_result = out_result_o.wb_result;
    assign res_instr     = out_result_o.instr;
    assign op_instr      = instr_w;

    // ---------------------------------------------------------------------------
    // The LSU and the scratchpad
    // ---------------------------------------------------------------------------

    logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] spad_addr;
    logic [N_SPAD_BANKS-1:0][RLEN-1:0]                spad_wdata;
    logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0]          spad_wen;

    logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] spad_addr_o;
    logic [N_SPAD_BANKS-1:0][RLEN-1:0]                spad_wdata_o;
    logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0]          spad_wen_o;

    logic [N_SPAD_BANKS-1:0][RLEN-1:0]                spad_rdata;

    assign spad_addr  = init_mode ? init_addr  : spad_addr_o;
    assign spad_wdata = init_mode ? init_wdata : spad_wdata_o;
    assign spad_wen   = init_mode ? init_wen   : spad_wen_o;

    fu_lsu u_dut (
        .clk            (clk),
        .rst_n          (rst_n),
        .in_valid_i     (in_valid_i),
        .in_ready_o     (in_ready_o),
        .in_operation_i (operation_w),
        .out_valid_o    (out_valid_o),
        .out_ready_i    (out_ready_i),
        .out_result_o   (out_result_o),
        .spad_addr_o    (spad_addr_o),
        .spad_wdata_o   (spad_wdata_o),
        .spad_wen_o     (spad_wen_o),
        .spad_rdata_i   (spad_rdata)
    );

    scratchpad u_spad (
        .clk    (clk),
        .addr_i (spad_addr),
        .wdata_i(spad_wdata),
        .wen_i  (spad_wen),
        .rdata_o(spad_rdata)
    );

endmodule

`default_nettype wire
