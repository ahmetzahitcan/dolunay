`default_nettype none

// Convert combinatorial operations into real FUs.

module fuhelper_combinatorial
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

    output fu_operation_s comb_operation_o,
    input wire fu_result_s comb_result_i
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

    fu_operation_s operation_r;

    always_ff @(posedge clk) begin
        if (in_fire_w) begin
            operation_r <= in_operation_i;
        end
    end

    assign comb_operation_o = operation_r;
    assign out_result_o = comb_result_i;

endmodule

`default_nettype wire
