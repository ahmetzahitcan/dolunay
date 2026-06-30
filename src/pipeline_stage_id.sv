`default_nettype none

module pipeline_stage_id
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire logic [31:2] ifid_undec_instr32_w,
    input wire logic [XLEN-1:Z_PC] ifid_pc_r,
    input wire logic id_stage_valid_r,
    input wire logic bsync_1_i,
    
    output instr_s id_instr_w
);

    (* DONT_TOUCH = "true" *)
    control_unit_ext u_control_unit(
        .undec_instr32_i(ifid_undec_instr32_w),
        .pc_i(ifid_pc_r),
        .valid_i(id_stage_valid_r),
        .bsync_1_i(bsync_1_i),
        .instr_o(id_instr_w)
    );

endmodule

`default_nettype wire
