`default_nettype none

// TODO: Seperate scalar operations into a different FU

module multialu
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,

    output logic out_valid_o,
    input wire logic out_ready_i,

    input wire op_tag_s op_tag_i,
    input wire logic [N_THREADS-1:0][RLEN-1:0] rs1_val_i,
    input wire logic [N_THREADS-1:0][RLEN-1:0] rs2_val_i,
    input wire instr_s instr_i,
    input wire logic [W_WARPS-1:0] warp_id_i,
    input wire logic [RLEN-1:Z_PC] pc_i,
    input wire logic [63:0] cycle_time_i,
    input wire logic [N_THREADS-1:0][63:0] instret_i,
    input wire logic [63:0] wuinstret_i,
    input wire logic [63:0] wtinstret_i,

    output op_tag_s op_tag_o,
    output logic [N_THREADS-1:0][RLEN-1:0] result_o
);
    logic out_valid_r, out_valid_next_w, out_hold_w;
    logic in_ready_w, in_fire_w;

    assign in_fire_w = in_valid_i & in_ready_w;
    assign out_hold_w = out_valid_r & !out_ready_i;
    assign out_valid_next_w = in_fire_w || out_hold_w;
    assign in_ready_w = !out_hold_w;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            out_valid_r <= 0;
        end else begin
            out_valid_r <= out_valid_next_w;
        end
    end

    assign out_valid_o = out_valid_r;
    assign in_ready_o = in_ready_w;

    logic [N_THREADS-1:0][RLEN-1:0] result_w, result_r;
    op_tag_s op_tag_r;

    always_ff @(posedge clk) begin
        if (in_fire_w) begin
            result_r <= result_w;
            op_tag_r <= op_tag_i;
        end
    end
    assign result_o = result_r;
    assign op_tag_o = op_tag_r;

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
                .result_o(result_w[I]),
                .cycle_time_i(cycle_time_i),
                .instret_i(instret_i[I]),
                .wuinstret_i(wuinstret_i),
                .wtinstret_i(wtinstret_i)
            );
        end
    endgenerate

endmodule

`default_nettype wire
