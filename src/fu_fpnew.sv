`default_nettype none

module fu_fpnew
    import params_pkg::*;
    import control_unit_pkg::*;
    import fu_pkg::*;
#(
    localparam FPU_WIDTH = N_THREADS * RLEN
) (
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,

    output logic out_valid_o,
    input wire logic out_ready_i,

    input wire operation_s operation_i
);

    // - FPU

    logic [2:0][FPU_WIDTH-1:0] fpu_operands;
    always_comb begin
        fpu_operands = 'x;
        for (integer I = 0; I < N_THREADS; I++) begin
            unique case(operation_i.instr.fpu_op0_sel)
                FPU_OP0_SEL_RS1: fpu_operands[0][I*RLEN +: RLEN] = operation_i.rs1_data[I];
            endcase
            unique case(operation_i.instr.fpu_op1_sel)
                FPU_OP1_SEL_RS1: fpu_operands[1][I*RLEN +: RLEN] = operation_i.rs1_data[I];
                FPU_OP1_SEL_RS2: fpu_operands[1][I*RLEN +: RLEN] = operation_i.rs2_data[I];
            endcase
            unique case(operation_i.instr.fpu_op2_sel)
                FPU_OP2_SEL_RS2: fpu_operands[2][I*RLEN +: RLEN] = operation_i.rs2_data[I];
                FPU_OP2_SEL_RS3: fpu_operands[2][I*RLEN +: RLEN] = operation_i.rs3_data[I];
            endcase
        end
    end

    // FIXME: For simplicity, we hard code dynamic to RNE
    fpnew_pkg::roundmode_e fpu_rnd_mode;
    assign fpu_rnd_mode = operation_i.instr.fpu_roundmode == 3'b111 ? fpnew_pkg::RNE : fpnew_pkg::roundmode_e'(operation_i.instr.fpu_roundmode);

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

    // -- FPU declaration

    localparam fpnew_pkg::fpu_features_t FPU_FEATURES = '{
        Width:           FPU_WIDTH,
        EnableVectors:   1'b1,
        EnableNanBox:    1'b1,
        FpFmtMask:       5'b10000,
        IntFmtMask:      4'b0010
    };

    localparam fpnew_pkg::fpu_implementation_t FPU_IMPLEMENTATION = '{
        PipeRegs: '{fpnew_pkg::DIVSQRT: 0, default: 32'd1},
        UnitTypes: '{
            '{default: fpnew_pkg::PARALLEL}, // ADDMUL - Merged or Parallel
            '{default: fpnew_pkg::MERGED},   // DIVSQRT - Merged
            '{default: fpnew_pkg::PARALLEL}, // NONCOMP - Parallel
            '{default: fpnew_pkg::MERGED}    // CONV - Merged
        },
        PipeConfig: fpnew_pkg::INSIDE
    };

    logic [FPU_WIDTH-1:0] result_1d_w;
    simd_data_t result_2d_w;

    generate
        for (genvar i = 0; i < N_THREADS; i++) begin : gen_result
            assign result_2d_w[i] = result_1d_w[i*RLEN +: RLEN];
        end
    endgenerate

    fpnew_top #(
        .Features       (FPU_FEATURES),
        .Implementation (FPU_IMPLEMENTATION),
        .TagType        ( logic ) // FIXME
    ) fpu (
    	.clk_i         (clk),
    	.rst_ni        (rst_n),
    	.operands_i    (fpu_operands),
    	.rnd_mode_i    (fpu_rnd_mode),
    	.op_i          (operation_i.instr.fpu_opcode),
    	.op_mod_i      (operation_i.instr.fpu_op_modifier),
    	.src_fmt_i     (fpu_src_fmt),
    	.dst_fmt_i     (fpu_dst_fmt),
    	.int_fmt_i     (fpu_int_fmt),
    	.vectorial_op_i(1'b1), // FIXME: This is probably safe to hardcode, right? Do check though.
    	.simd_mask_i   (fpu_simd_mask),
    	.tag_i         (),
    	.in_valid_i    (in_valid_i),
    	.in_ready_o    (in_ready_o),
    	.flush_i       (1'b0), // FIXME: This is probably safe to hardcode too, right? Do check though.
    	.result_o      (),
    	.status_o      (),
    	.tag_o         (),
        .out_valid_o   (out_valid_o),
    	.out_ready_i   (out_ready_i),
    	.busy_o        ()
    );

endmodule

`default_nettype wire
