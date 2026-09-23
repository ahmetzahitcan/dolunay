// slang lint_off empty-output-connection

`default_nettype none

module fpnew_wrapper
    import params_pkg::*;
    import control_unit_pkg::*;
#(
    localparam FPU_WIDTH = N_THREADS * RLEN
) (
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,

    output logic out_valid_o,
    input wire logic out_ready_i,

    input wire op_tag_s op_tag_i,
    input wire instr_s instr_i,
    input wire logic [N_THREADS-1:0][RLEN-1:0] rs1_data_i,
    input wire logic [N_THREADS-1:0][RLEN-1:0] rs2_data_i,
    input wire logic [N_THREADS-1:0][RLEN-1:0] rs3_data_i,

    output op_tag_s op_tag_o,
    output logic [FPU_WIDTH-1:0] result_o,
    output fpnew_pkg::status_t[N_THREADS-1:0] status_o
);

    // - FPU


    logic [2:0][FPU_WIDTH-1:0] fpu_operands;
    always_comb begin
        for (integer I = 0; I < N_THREADS; I++) begin
            unique case(instr_i.fpu_op0_sel)
                FPU_OP0_SEL_RS1: fpu_operands[0][I*RLEN +: RLEN] = rs1_data_i[I];
                FPU_OP0_SEL_UNDEFINED: fpu_operands[0][I*RLEN +: RLEN] = 'x;
            endcase
            unique case(instr_i.fpu_op1_sel)
                FPU_OP1_SEL_RS1: fpu_operands[1][I*RLEN +: RLEN] = rs1_data_i[I];
                FPU_OP1_SEL_RS2: fpu_operands[1][I*RLEN +: RLEN] = rs2_data_i[I];
                FPU_OP1_SEL_UNDEFINED: fpu_operands[1][I*RLEN +: RLEN] = 'x;
            endcase
            unique case(instr_i.fpu_op2_sel)
                FPU_OP2_SEL_RS2: fpu_operands[2][I*RLEN +: RLEN] = rs2_data_i[I];
                FPU_OP2_SEL_RS3: fpu_operands[2][I*RLEN +: RLEN] = rs3_data_i[I];
                FPU_OP2_SEL_UNDEFINED: fpu_operands[2][I*RLEN +: RLEN] = 'x;
            endcase
        end
    end

    // FIXME: For simplicity, we hard code dynamic to RNE
    fpnew_pkg::roundmode_e fpu_rnd_mode;
    assign fpu_rnd_mode = instr_i.fpu_roundmode == 3'b111 ? fpnew_pkg::RNE : fpnew_pkg::roundmode_e'(instr_i.fpu_roundmode);

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

    fpnew_top #(
        .Features       (FPU_FEATURES),
        .Implementation (FPU_IMPLEMENTATION),
        .TagType        ( op_tag_s )
    ) fpu (
    	.clk_i         (clk),
    	.rst_ni        (rst_n),
    	.operands_i    (fpu_operands),
    	.rnd_mode_i    (fpu_rnd_mode),
    	.op_i          (instr_i.fpu_opcode),
    	.op_mod_i      (instr_i.fpu_op_modifier),
    	.src_fmt_i     (fpu_src_fmt),
    	.dst_fmt_i     (fpu_dst_fmt),
    	.int_fmt_i     (fpu_int_fmt),
    	.vectorial_op_i(1'b1), // FIXME: This is probably safe to hardcode, right? Do check though.
    	.simd_mask_i   (fpu_simd_mask),
    	.tag_i         (op_tag_i),
    	.in_valid_i    (in_valid_i),
    	.in_ready_o    (in_ready_o),
    	.flush_i       (1'b0), // FIXME: This is probably safe to hardcode too, right? Do check though.
    	.result_o      (result_o),
    	.status_o      (status_o),
    	.tag_o         (op_tag_o),
        .out_valid_o   (out_valid_o),
    	.out_ready_i   (out_ready_i),
    	.busy_o        ()
    );

endmodule

`default_nettype wire
