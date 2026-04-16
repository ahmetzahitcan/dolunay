`default_nettype none

module warp_scheduler 
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,
    output logic [W_WARPS-1:0] warp_id_o
);

    logic [W_WARPS-1:0] current_warp_r;

    logic [W_WARPS-1:0] next_warp_w;
    assign next_warp_w = current_warp_r + 1'b1;

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