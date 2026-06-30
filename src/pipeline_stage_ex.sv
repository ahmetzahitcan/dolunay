`default_nettype none

module pipeline_stage_ex
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire logic [N_THREADS-1:0][XLEN-1:0] idex_rs1_data_w,
    input wire logic [N_THREADS-1:0][XLEN-1:0] idex_rs2_data_w,
    input wire instr_s idex_instr_r,
    input wire logic [W_WARPS-1:0] idex_warp_id_r,
    input wire logic [XLEN-1:Z_PC] idex_pc_r,
    
    input wire logic [63:0] cycletime_w,
    input wire logic [N_WARPS-1:0][N_THREADS-1:0][63:0] instret_w,
    input wire logic [N_WARPS-1:0][63:0] wuinstret_w,
    input wire logic [N_WARPS-1:0][63:0] wtinstret_w,

    output logic [N_THREADS-1:0][XLEN-1:0] ex_alu_result_w
);

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin : gen_alu
            (* DONT_TOUCH = "true" *)
            alu #(
                .THREAD_ID(I)
            ) u_alu (
                .rs1_val_i(idex_rs1_data_w[I]),
                .rs2_val_i(idex_rs2_data_w[I]),
                .instr_i(idex_instr_r),
                .warp_id_i(idex_warp_id_r),
                .pc_i(idex_pc_r),
                .result_o(ex_alu_result_w[I]),
                .cycle_time_i(cycletime_w),
                .instret_i(instret_w[idex_warp_id_r][I]),
                .wuinstret_i(wuinstret_w[idex_warp_id_r]),
                .wtinstret_i(wtinstret_w[idex_warp_id_r])
            );
        end
    endgenerate

endmodule

`default_nettype wire
