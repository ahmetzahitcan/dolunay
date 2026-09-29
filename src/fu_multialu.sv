`default_nettype none

// TODO: Seperate scalar operations into a different FU

module fu_multialu
    import params_pkg::*;
    import core_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,
    input wire fu_operation_s in_operation_i,

    output logic out_valid_o,
    input wire logic out_ready_i,
    output fu_result_s out_result_o
);
    fu_operation_s operation_w;
    fu_result_s result_w;

    simd_data_t simd_result_w;

    assign result_w = '{
        seq: operation_w.seq,
        warp_id: operation_w.warp_id,
        instr: operation_w.instr,
        pc: operation_w.pc,
        mask: operation_w.mask,
        wb_result: simd_result_w,
        fpu_status: 'x,
        csrw_result: 'x
    };

    generate
        for (genvar i = 0; i < N_THREADS; i++) begin : gen_alu
            alu alu (
               	.rs1_val_i(operation_w.rs1_data[i]),
               	.rs2_val_i(operation_w.rs2_data[i]),
               	.instr_i  (operation_w.instr),
               	.pc_i     (operation_w.pc),
               	.result_o (simd_result_w[i])
            );
        end
    endgenerate

    fuhelper_combinatorial u_fuhelper_combinatorial (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid_i(in_valid_i),
        .in_ready_o(in_ready_o),
        .in_operation_i(in_operation_i),
        .out_valid_o(out_valid_o),
        .out_ready_i(out_ready_i),
        .out_result_o(out_result_o),
        .comb_operation_o(operation_w),
        .comb_result_i(result_w)
    );

endmodule

`default_nettype wire
