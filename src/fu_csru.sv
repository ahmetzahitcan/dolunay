`default_nettype none

// Function Unit - CSR Unit

module fu_csru
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,
    input wire fu_operation_s in_operation_i,

    output logic out_valid_o,
    input wire logic out_ready_i,
    output fu_result_s out_result_o,

    input wire fpnew_pkg::status_t [N_WARPS-1:0][N_THREADS-1:0] fflags_i
);

    fu_operation_s operation_w;
    fu_result_s result_w;

    fuhelper_combinatorial u_fuhelper_combinatorial (
    	.clk             (clk),
    	.rst_n           (rst_n),
    	.in_valid_i      (in_valid_i),
    	.in_ready_o      (in_ready_o),
    	.in_operation_i  (in_operation_i),
    	.out_valid_o     (out_valid_o),
    	.out_ready_i     (out_ready_i),
    	.out_result_o    (out_result_o),
    	.comb_operation_o(operation_w),
    	.comb_result_i   (result_w),

        // slang lint_off empty-output-connection
        .operation_strobe_o()
        // slang lint_on empty-output-connection
    );

    simd_data_t wb_result_w;
    always_comb begin
        wb_result_w = 'x;
        for(int i = 0; i < N_THREADS; i++) begin
            unique case (operation_w.instr.csrr_src)
                CSRR_SRC_FFLAGS: wb_result_w[i] = {{(RLEN-$bits(fpnew_pkg::status_t)){1'b0}}, fflags_i[operation_w.warp_id][i]};
            endcase
        end
    end

    simd_data_t csrw_result_w;
    always_comb begin
        csrw_result_w = 'x;
        for(int i = 0; i < N_THREADS; i++) begin
            unique case (operation_w.instr.csrw_method)
                CSRW_METHOD_WRITE: csrw_result_w[i] = operation_w.rs1_data[i]; // TODO: uimm[5:0]
            endcase
        end
    end

    assign result_w = '{
        seq: operation_w.seq,
        warp_id: operation_w.warp_id,
        instr: operation_w.instr,
        pc: operation_w.pc,
        mask: operation_w.mask,
        wb_result: wb_result_w,
        csrw_result: csrw_result_w,
        fpu_status: 'x,
        use_uwb: '0,
        uwb_result: 'x
    };

endmodule

`default_nettype wire
