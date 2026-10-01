`default_nettype none

// Function Unit - Branch/Jump Unit

module fu_bju
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

    // FIXME: If I ever switch to true OoO, these have to be moved to the commit stage.
    output logic branch_complete_o,
    output simd_mask_t branch_mask_o
);

    fu_operation_s operation_w;
    fu_result_s result_w;

    logic operation_strobe_w;

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
        .operation_strobe_o(operation_strobe_w)
    );

    logic [RLEN-1:Z_PC] link_address_w;
    assign link_address_w = operation_w.pc + 1;

    logic [RLEN-1:0] link_address32_w;
    assign link_address32_w = {link_address_w, {(Z_PC){1'b0}}};

    simd_mask_t branch_mask_w;
    always_comb begin
        branch_mask_w = 'x;
        for (int i = 0; i < N_THREADS; i++) begin
            unique case (operation_w.instr.bj_type)
                BJ_TYPE_NONE: branch_mask_w[i] = 'x;
                BJ_TYPE_JAL: branch_mask_w[i] = 'x;
                BJ_TYPE_BEQ: branch_mask_w[i] = operation_w.rs1_data[i] == operation_w.rs2_data[i];
            endcase
        end
    end

    logic branch_w;
    always_comb begin
        branch_w = 'x;
        unique case (operation_w.instr.bj_type)
            BJ_TYPE_NONE: branch_w = 0;
            BJ_TYPE_JAL: branch_w = 0;
            BJ_TYPE_BEQ: branch_w = 1;
        endcase
    end

    assign branch_complete_o = operation_strobe_w && branch_w;
    assign branch_mask_o = branch_mask_w;

    assign result_w = '{
        seq: operation_w.seq,
        warp_id: operation_w.warp_id,
        instr: operation_w.instr,
        pc: operation_w.pc,
        mask: operation_w.mask,
        use_uwb: '1,
        uwb_result: link_address32_w,
        wb_result: 'x,
        csrw_result: 'x,
        fpu_status: 'x
    };

endmodule

`default_nettype wire
