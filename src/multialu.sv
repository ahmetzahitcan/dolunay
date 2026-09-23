`default_nettype none

// TODO: Seperate scalar operations into a different FU

module multialu
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire logic [N_THREADS-1:0][RLEN-1:0] rs1_val_i,
    input wire logic [N_THREADS-1:0][RLEN-1:0] rs2_val_i,
    input wire instr_s instr_i,
    input wire logic [W_WARPS-1:0] warp_id_i,
    input wire logic [RLEN-1:Z_PC] pc_i,
    output logic [N_THREADS-1:0][RLEN-1:0] result_o,
    input wire logic [63:0] cycle_time_i,
    input wire logic [N_THREADS-1:0][63:0] instret_i,
    input wire logic [63:0] wuinstret_i,
    input wire logic [63:0] wtinstret_i
);

    // TODO: Implement handshake

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin : gen_alu
            alu #(
                .THREAD_ID(I)
            ) u_alu (
                .rs1_val_i(rs1_val_i[I]),
                .rs2_val_i(rs2_val_i[I]),
                .instr_i(instr_i),
                .warp_id_i(warp_id_i),
                .pc_i(pc_i),
                .result_o(result_o[I]),
                .cycle_time_i(cycle_time_i),
                .instret_i(instret_i[I]),
                .wuinstret_i(wuinstret_i),
                .wtinstret_i(wtinstret_i)
            );
        end
    endgenerate

endmodule

`default_nettype wire
