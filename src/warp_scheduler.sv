`default_nettype none

module warp_scheduler 
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,
    input wire logic skip_i,
    input wire logic [W_WARPS-1:0] skip_warp_id_i,
    output logic [W_WARPS-1:0] warp_id_o
);

    logic [W_WARPS-1:0] current_warp_r;
    logic [W_WARPS-1:0] current_warp_p1_w;
    logic [W_WARPS-1:0] current_warp_p2_w;

    assign current_warp_p1_w = current_warp_r + 1'b1;
    assign current_warp_p2_w = current_warp_r + 2'b10;

    logic skip_w;
    assign skip_w = skip_i && (skip_warp_id_i == current_warp_p1_w);

    logic [W_WARPS-1:0] next_warp_w;
    assign next_warp_w = skip_w ? current_warp_p2_w : current_warp_p1_w;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            current_warp_r <= '0;
        end else begin
            current_warp_r <= next_warp_w;
        end
    end

    assign warp_id_o = current_warp_r;

endmodule

`default_nettype wire