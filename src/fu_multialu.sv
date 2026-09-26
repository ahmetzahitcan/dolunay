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
    input wire fu_operation_s in_operation_i,

    output logic out_valid_o,
    input wire logic out_ready_i,
    output fu_result_s out_result_o
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
                .rs1_val_i(in_operation_i.rs1_data[I]),
                .rs2_val_i(in_operation_i.rs2_data[I]),
                .instr_i(in_operation_i.instr),
                .pc_i(in_operation_i.pc),
                .result_o(result_w[I])
            );
        end
    endgenerate

    assign out_valid_o = out_valid_r;
    assign in_ready_o = in_ready_w;

    fu_operation_s operation_r;

    always_ff @(posedge clk) begin
        if (in_fire_w) begin
            operation_r <= in_operation_i;
        end
    end

    assign out_result_o = '{
        result: result_r,
        fpu_status: 'x,

        seq: operation_r.seq,
        warp_id: operation_r.warp_id,
        mask: operation_r.mask,
        instr: operation_r.instr,
        pc: operation_r.pc
    };

endmodule

`default_nettype wire
