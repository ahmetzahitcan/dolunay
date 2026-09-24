`default_nettype none

// TODO: Seperate scalar operations into a different FU

module fu_multialu
    import params_pkg::*;
    import fu_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,

    output logic out_valid_o,
    input wire logic out_ready_i,

    input wire operation_s operation_i
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

    simd_data_t result_w, result_r;

    always_ff @(posedge clk) begin
        if (in_fire_w) begin
            result_r <= result_w;
        end
    end

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin : gen_alu
            alu u_alu (
                .rs1_val_i(operation_i.rs1_data[I]),
                .rs2_val_i(operation_i.rs2_data[I]),
                .instr_i(operation_i.instr),
                .pc_i(operation_i.pc),
                .result_o(result_w[I])
            );
        end
    endgenerate

    assign out_valid_o = out_valid_r;
    assign in_ready_o = in_ready_w;

endmodule

`default_nettype wire
