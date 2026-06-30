`default_nettype none

module pipeline_stage_if
    import params_pkg::*;
    import control_unit_pkg::*;
#(
    parameter int W_IROM_ADDR = 32
) (
    input wire logic [W_WARPS-1:0] wsif_warp_id_r,
    input wire logic [N_WARPS-1:0][XLEN-1:Z_PC] u_thread_scheduler_pc_w,
    input wire logic [N_WARPS-1:0][N_THREADS-1:0] u_thread_scheduler_mask_w,
    input wire logic [XLEN-1:0] irom_data_a_i,

    output logic [XLEN-1:Z_PC] if_pc_w,
    output logic [N_THREADS-1:0] if_mask_w,
    output logic [W_IROM_ADDR-1:Z_PC] irom_addr_a_o,
    output logic [31:2] ifid_undec_instr32_w
);

    assign if_pc_w = u_thread_scheduler_pc_w[wsif_warp_id_r];   
    assign if_mask_w = u_thread_scheduler_mask_w[wsif_warp_id_r];

    assign irom_addr_a_o = if_pc_w[W_IROM_ADDR-1:Z_PC];

    logic [XLEN-1:0] if_irom_data_w;
    assign if_irom_data_w = irom_data_a_i;
    assign ifid_undec_instr32_w = if_irom_data_w[31:2];

endmodule

`default_nettype wire
