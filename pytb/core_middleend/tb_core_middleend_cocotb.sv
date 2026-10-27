`default_nettype none

// =============================================================================
// tb_core_middleend_cocotb — the harness of the cocotb middle-end testbench.
//
// This is the SystemVerilog testbench (tb/tb_core_middleend.sv) reduced to
// what cocotb needs. The reference model and the bookkeeping of what the
// middle end dispatched live in Python
// (pytb/core_middleend/test_core_middleend.py), so all that is left here is
// the hardware.
//
// Two things happen here that cannot happen in Python:
//
//   * the me_operation_s is packed and the fu_result_s is unpacked, because
//     only SystemVerilog knows where their fields are,
//   * the signals the middle end dispatches with are read out of the middle
//     end's own signals, for the same reason.
//
// The testbench also holds the function units busy, to see the back-pressure.
// It does that by driving a port here, and the force itself is here, because
// a force from Python would depend on the simulator's VPI.
//
// The scratchpad is here because the LSU is inside the middle end.
//
// The ports of the harness are named for the testbench: an input is driven
// by the testbench, an output is read by it.
// =============================================================================

module tb_core_middleend_cocotb
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    // -----------------------------------------------------------------------
    // The operation, in the fields the testbench thinks in
    // -----------------------------------------------------------------------

    input wire logic [N_WARPS-1:0]           me_valid,
    input wire logic [W_ROB_ADDR-1:0]        me_seq,
    input wire logic [N_THREADS-1:0]         me_mask,
    input wire logic [RLEN-1:Z_PC]            me_pc,
    input wire logic [W_FUNCTION_UNITS-1:0]   me_fu_sel,

    input wire logic                         me_rs1_used,
    input wire logic                         me_rs1_regfile,
    input wire logic [W_REGISTERS-1:0]       me_rs1_idx,
    input wire logic                         me_rs2_used,
    input wire logic                         me_rs2_regfile,
    input wire logic [W_REGISTERS-1:0]       me_rs2_idx,
    input wire logic                         me_rs3_used,
    input wire logic                         me_rs3_regfile,
    input wire logic [W_REGISTERS-1:0]       me_rs3_idx,

    // -----------------------------------------------------------------------
    // The register file
    //
    // The testbench has a model of the register file, so the ports are passed
    // through: the index comes out of the middle end and the data goes in.
    // -----------------------------------------------------------------------

    output wire phys_reg_id_t                rfa_idx,
    input  wire logic                        rfa_write_en,
    input  wire simd_data_t                  rfa_data,
    output wire phys_reg_id_t                rfb_idx,
    input  wire logic                        rfb_write_en,
    input  wire simd_data_t                  rfb_data,

    // -----------------------------------------------------------------------
    // Holding the function units busy
    // -----------------------------------------------------------------------

    input wire logic                         fu_ready_override_en,
    input wire logic [N_FUNCTION_UNITS-1:0] fu_ready_override,

    // -----------------------------------------------------------------------
    // What the middle end dispatched, read out of its own signals
    // -----------------------------------------------------------------------

    output wire logic                        of_dispatch,
    output wire logic [W_WARPS-1:0]          of_warp_id,
    output wire logic [W_ROB_ADDR-1:0]       of_seq,
    output wire logic [W_FUNCTION_UNITS-1:0] of_fu_sel,
    output wire simd_data_t                  of_rs1_data,
    output wire simd_data_t                  of_rs2_data,
    output wire simd_data_t                  of_rs3_data,
    output wire logic                        of_valid,

    // -----------------------------------------------------------------------
    // The result, unpacked out of the fu_result_s
    // -----------------------------------------------------------------------

    output wire logic                        result_valid,
    output wire logic [W_WARPS-1:0]          result_warp_id,
    output wire logic [W_ROB_ADDR-1:0]       result_seq,
    output wire logic [W_FUNCTION_UNITS-1:0] result_fu_sel,

    // -----------------------------------------------------------------------
    // Whether the middle end can take an operation
    // -----------------------------------------------------------------------

    output wire logic [N_WARPS-1:0]          me_ready
);

    // ---------------------------------------------------------------------------
    // The operation, packed into the struct the middle end takes
    //
    // The fields that are enums are cast, because SystemVerilog does not
    // convert a plain logic to one on its own.
    // ---------------------------------------------------------------------------

    instr_s instr_w;

    always_comb begin
        instr_w = '0;
        instr_w.fu_sel      = function_unit_e'(me_fu_sel);
        instr_w.rs1_used    = me_rs1_used;
        instr_w.rs1_regfile = regfile_sel_e'(me_rs1_regfile);
        instr_w.rs1_idx     = me_rs1_idx;
        instr_w.rs2_used    = me_rs2_used;
        instr_w.rs2_regfile = regfile_sel_e'(me_rs2_regfile);
        instr_w.rs2_idx     = me_rs2_idx;
        instr_w.rs3_used    = me_rs3_used;
        instr_w.rs3_regfile = regfile_sel_e'(me_rs3_regfile);
        instr_w.rs3_idx     = me_rs3_idx;
    end

    me_operation_s me_op_w;

    always_comb begin
        me_op_w = '0;
        me_op_w.seq   = me_seq;
        me_op_w.instr = instr_w;
        me_op_w.pc    = me_pc;
        me_op_w.mask  = me_mask;
    end

    // ---------------------------------------------------------------------------
    // The middle end
    // ---------------------------------------------------------------------------

    logic [N_WARPS-1:0]  me_ready_w;
    fu_result_s          result_w;

    logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] spad_addr_w;
    logic [N_SPAD_BANKS-1:0][RLEN-1:0]                spad_wdata_w;
    logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0]          spad_wen_w;
    logic [N_SPAD_BANKS-1:0][RLEN-1:0]                spad_rdata_w;

    // The branch output of the middle end is not looked at.
    logic         branch_complete_w;
    simd_mask_t   branch_mask_w;
    branch_type_e branch_type_w;
    warp_id_t     branch_warp_id_w;
    pc_t          branch_pc_w;
    pc_t          branch_target_w;

    core_middleend u_dut (
        .clk              (clk),
        .rst_n            (rst_n),
        .me_ready_o       (me_ready_w),
        .me_valid_i       (me_valid),
        .me_op_i          (me_op_w),
        .rfa_idx_o        (rfa_idx),
        .rfa_write_en_i   (rfa_write_en),
        .rfa_data_i       (rfa_data),
        .rfb_idx_o        (rfb_idx),
        .rfb_write_en_i   (rfb_write_en),
        .rfb_data_i       (rfb_data),
        .result_valid_o   (result_valid),
        .result_ready_i   (1'b1),
        .result_o         (result_w),
        .spad_addr_o      (spad_addr_w),
        .spad_wdata_o     (spad_wdata_w),
        .spad_wen_o       (spad_wen_w),
        .spad_rdata_i     (spad_rdata_w),
        .branch_complete_o(branch_complete_w),
        .branch_mask_o   (branch_mask_w),
        .branch_type_o   (branch_type_w),
        .branch_warp_id_o(branch_warp_id_w),
        .branch_pc_o     (branch_pc_w),
        .branch_target_o (branch_target_w),
        .fflags_i        ('0)
    );

    // The scratchpad, for the LSU in the middle end.
    scratchpad u_scratchpad (
        .clk    (clk),
        .addr_i (spad_addr_w),
        .wdata_i(spad_wdata_w),
        .wen_i  (spad_wen_w),
        .rdata_o(spad_rdata_w)
    );

    // ---------------------------------------------------------------------------
    // What the middle end dispatched
    // ---------------------------------------------------------------------------

    assign of_dispatch = u_dut.of_dispatch_w;
    assign of_warp_id  = u_dut.of_warp_id_r;
    assign of_seq      = u_dut.of_operation_r.seq;
    assign of_fu_sel   = u_dut.of_fu_sel_r;
    // The operands as the function unit receives them, not as the operand
    // fetch stage holds them: that is the last point where a mistake in the
    // routing of an operand can still be caught.
    assign of_rs1_data = u_dut.fu_in_operation_w.rs1_data;
    assign of_rs2_data = u_dut.fu_in_operation_w.rs2_data;
    assign of_rs3_data = u_dut.fu_in_operation_w.rs3_data;
    assign of_valid    = u_dut.of_valid_r;

    // ---------------------------------------------------------------------------
    // The result
    // ---------------------------------------------------------------------------

    assign result_warp_id = result_w.warp_id;
    assign result_seq     = result_w.seq;
    assign result_fu_sel  = result_w.instr.fu_sel;
    assign me_ready       = me_ready_w;

    // ---------------------------------------------------------------------------
    // Holding the function units busy
    //
    // The middle end reads the readiness of the function units from
    // fu_in_ready_w, so forcing it is how the testbench makes the units look
    // busy. The SystemVerilog testbench forces the same signal.
    // ---------------------------------------------------------------------------

    always @(fu_ready_override_en or fu_ready_override) begin
        if (fu_ready_override_en) force u_dut.fu_in_ready_w = fu_ready_override;
        else                      release u_dut.fu_in_ready_w;
    end

endmodule

`default_nettype wire
