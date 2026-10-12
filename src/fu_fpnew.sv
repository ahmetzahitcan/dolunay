`default_nettype none

// Function Unit - FPnew wrapper
//
// FPnew uses a top-down handshake at its input port:
//     in_ready_o = in_valid_i & opgrp_in_ready[op_i]
// i.e. the FPU's ready depends combinationally on the incoming valid. This
// wrapper instead exposes a bottom-up handshake at both of its boundaries:
//   * input:  in_ready_o must not depend on in_valid_i
//   * output: out_valid_o may depend on out_ready_i
//
// A single-entry skid register on each side of the FPU performs the conversion.
// Both sides always register (no combinational pass-through), which keeps the
// external operation / valid / result off the FPU's combinational paths and
// costs one cycle of latency. The ready/valid expressions still allow a slot to
// be drained and refilled on the same edge, so throughput is unaffected.

module fu_fpnew
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
#(
    localparam FPU_WIDTH = N_THREADS * RLEN
) (
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,
    input wire fu_operation_s in_operation_i,

    output logic out_valid_o,
    input wire logic out_ready_i,
    output fu_result_s out_result_o
);

    typedef struct packed {
        seq_t seq;
        warp_id_t warp_id;
        pc_t pc;
        simd_mask_t mask;
        instr_s instr;
    } tag_s;

    // - FPU input skid register
    //
    // Every operation is registered before reaching the FPU. Upstream is told
    // ready when the slot is empty, or when the slot is being drained this
    // cycle, so it can be drained and refilled on the same edge.

    logic in_skid_valid_r;
    fu_operation_s in_skid_operation_r;

    logic fpu_in_valid_w;
    logic fpu_in_ready_w;
    logic fpu_in_fire_w;
    logic in_fire_w;

    assign fpu_in_valid_w = in_skid_valid_r;

    // FPU accepted the buffered operation this cycle.
    assign fpu_in_fire_w = fpu_in_valid_w & fpu_in_ready_w;

    // Bottom-up: ready only depends on registered state and the FPU's own
    // (registered) operation, never on in_valid_i.
    assign in_ready_o = !in_skid_valid_r | fpu_in_fire_w;
    assign in_fire_w  = in_valid_i & in_ready_o;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            in_skid_valid_r <= 1'b0;
            in_skid_operation_r <= 'x;
        end else if (fpu_in_fire_w) begin
            // Slot drained: refill it if upstream delivered a new operation.
            in_skid_valid_r <= in_fire_w;
            if (in_fire_w) begin
                in_skid_operation_r <= in_operation_i;
            end
        end else if (in_fire_w) begin
            // Slot was empty: latch the incoming operation.
            in_skid_valid_r <= 1'b1;
            in_skid_operation_r <= in_operation_i;
        end
    end

    // - FPU input signals (all driven from the skid register)

    logic [2:0][FPU_WIDTH-1:0] fpu_operands;
    always_comb begin
        fpu_operands = 'x;
        if (fpu_in_valid_w) begin
            for (integer I = 0; I < N_THREADS; I++) begin
                unique case(in_skid_operation_r.instr.fpu_op0_sel) // FIXME: Vivado gives unnecessary warnings, even when these unique cases don't execute.
                    FPU_OP0_SEL_RS1: fpu_operands[0][I*RLEN +: RLEN] = in_skid_operation_r.rs1_data[I];
                endcase
                unique case(in_skid_operation_r.instr.fpu_op1_sel)
                    FPU_OP1_SEL_RS1: fpu_operands[1][I*RLEN +: RLEN] = in_skid_operation_r.rs1_data[I];
                    FPU_OP1_SEL_RS2: fpu_operands[1][I*RLEN +: RLEN] = in_skid_operation_r.rs2_data[I];
                endcase
                unique case(in_skid_operation_r.instr.fpu_op2_sel)
                    FPU_OP2_SEL_RS2: fpu_operands[2][I*RLEN +: RLEN] = in_skid_operation_r.rs2_data[I];
                    FPU_OP2_SEL_RS3: fpu_operands[2][I*RLEN +: RLEN] = in_skid_operation_r.rs3_data[I];
                endcase
            end
        end
    end

    // FIXME: For simplicity, we hard code dynamic to RNE
    // TODO: FRM needs replay! There is no real use for SIMD rounding mode, but coscheduled threads can still have their own FRM.
    fpnew_pkg::roundmode_e fpu_rnd_mode;
    assign fpu_rnd_mode = in_skid_operation_r.instr.fpu_roundmode == 3'b111 ? fpnew_pkg::RNE : fpnew_pkg::roundmode_e'(in_skid_operation_r.instr.fpu_roundmode);

    // FIXME: For simplicity, we hard code formats too; but this time, this might make it into the final product!
    fpnew_pkg::fp_format_e fpu_src_fmt;
    fpnew_pkg::fp_format_e fpu_dst_fmt;
    fpnew_pkg::int_format_e fpu_int_fmt;
    assign fpu_src_fmt = fpnew_pkg::FP32;
    assign fpu_dst_fmt = fpnew_pkg::FP32;
    assign fpu_int_fmt = fpnew_pkg::INT32;

    // FIXME: I am unsure if SIMD mask should be all ones, or match the thread mask.
    logic [N_THREADS-1:0] fpu_simd_mask;
    assign fpu_simd_mask = '1;

    tag_s in_tag_w;
    assign in_tag_w = '{
        seq: in_skid_operation_r.seq,
        warp_id: in_skid_operation_r.warp_id,
        pc: in_skid_operation_r.pc,
        mask: in_skid_operation_r.mask,
        instr: in_skid_operation_r.instr
    };

    // -- FPU declaration

    localparam fpnew_pkg::fpu_features_t FPU_FEATURES = '{
        Width:           FPU_WIDTH,
        EnableVectors:   1'b1,
        EnableNanBox:    1'b1,
        FpFmtMask:       5'b10000,
        IntFmtMask:      4'b0010
    };

    localparam fpnew_pkg::fpu_implementation_t FPU_IMPLEMENTATION = '{
        PipeRegs: '{default: 32'd1},
        UnitTypes: '{
            '{default: fpnew_pkg::PARALLEL}, // ADDMUL - Merged or Parallel
            '{default: fpnew_pkg::MERGED},   // DIVSQRT - Merged
            '{default: fpnew_pkg::PARALLEL}, // NONCOMP - Parallel
            '{default: fpnew_pkg::MERGED}    // CONV - Merged
        },
        PipeConfig: fpnew_pkg::INSIDE
    };

    logic [FPU_WIDTH-1:0] result_1d_w;
    logic fpu_out_valid_w;
    logic fpu_out_ready_w;

    fpnew_pkg::status_t [N_THREADS-1:0] status_w;
    tag_s out_tag_w;

    // - FPU output skid register
    //
    // Every result is registered before reaching downstream. The FPU is told
    // ready when the slot is empty, or when the slot is drained this cycle, so
    // it can be drained and refilled on the same edge. out_valid_o is therefore
    // registered and independent of out_ready_i.

    logic out_skid_valid_r;
    logic [FPU_WIDTH-1:0] out_skid_result_r;
    fpnew_pkg::status_t [N_THREADS-1:0] out_skid_status_r;
    tag_s out_skid_tag_r;

    logic out_fire_w;
    logic fpu_out_fire_w;

    assign out_valid_o    = out_skid_valid_r;
    assign out_fire_w     = out_valid_o & out_ready_i;
    assign fpu_out_fire_w = fpu_out_valid_w & fpu_out_ready_w;

    // Accept from the FPU when the slot is empty, or when it is drained now.
    assign fpu_out_ready_w = !out_skid_valid_r | out_fire_w;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            out_skid_valid_r <= 1'b0;
            out_skid_result_r <= 'x;
            out_skid_status_r <= 'x;
            out_skid_tag_r <= 'x;
        end else if (fpu_out_fire_w) begin
            // Slot filled, or refilled after being consumed this cycle.
            out_skid_valid_r <= 1'b1;
            out_skid_result_r <= result_1d_w;
            out_skid_status_r <= status_w;
            out_skid_tag_r <= out_tag_w;
        end else if (out_fire_w) begin
            // Slot drained by downstream with no new FPU result.
            out_skid_valid_r <= 1'b0;
        end
    end

    // - FPU instantiation

    fpnew_top #(
        .Features       (FPU_FEATURES),
        .Implementation (FPU_IMPLEMENTATION),
        .TagType        ( tag_s )
    ) u_fpu (
    	.clk_i         (clk),
    	.rst_ni        (rst_n),
    	.operands_i    (fpu_operands),
    	.rnd_mode_i    (fpu_rnd_mode),
    	.op_i          (in_skid_operation_r.instr.fpu_opcode),
    	.op_mod_i      (in_skid_operation_r.instr.fpu_op_modifier),
    	.src_fmt_i     (fpu_src_fmt),
    	.dst_fmt_i     (fpu_dst_fmt),
    	.int_fmt_i     (fpu_int_fmt),
    	.vectorial_op_i(1'b1), // FIXME: This is probably safe to hardcode, right? Do check though.
    	.simd_mask_i   (fpu_simd_mask),
    	.tag_i         (in_tag_w),
    	.in_valid_i    (fpu_in_valid_w),
    	.in_ready_o    (fpu_in_ready_w),
    	.flush_i       (1'b0), // FIXME: This is probably safe to hardcode too, right? Do check though.
    	.result_o      (result_1d_w),
    	.status_o      (status_w),
    	.tag_o         (out_tag_w),
        .out_valid_o   (fpu_out_valid_w),
    	.out_ready_i   (fpu_out_ready_w),

     // slang lint_off empty-output-connection
    	.busy_o        ()
     // slang lint_on empty-output-connection
    );

    // - Result assembly

    simd_data_t result_2d_w;

    generate
        for (genvar i = 0; i < N_THREADS; i++) begin : gen_result
            assign result_2d_w[i] = out_skid_result_r[i*RLEN +: RLEN];
        end
    endgenerate

    assign out_result_o = '{
        seq: out_skid_tag_r.seq,
        warp_id: out_skid_tag_r.warp_id,
        pc: out_skid_tag_r.pc,
        mask: out_skid_tag_r.mask,
        instr: out_skid_tag_r.instr,
        fpu_status: out_skid_status_r,
        wb_result: result_2d_w,
        csrw_result: 'x,
        use_uwb: '0,
        uwb_result: 'x
    };

endmodule

`default_nettype wire
