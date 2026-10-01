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
    output fu_result_s out_result_o
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
    	.comb_result_i   (result_w)
    );

    logic [RLEN-1:Z_PC] link_address_w;
    assign link_address_w = operation_w.pc + 1;

    logic [RLEN-1:0] link_address32_w;
    assign link_address32_w = {link_address_w, {(Z_PC){1'b0}}};

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
