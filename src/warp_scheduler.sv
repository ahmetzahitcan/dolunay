`default_nettype none

module warp_scheduler
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,
    input wire logic [N_WARPS-1:0] ready_i,
    output logic [W_WARPS-1:0] warp_id_o,
    output logic warp_valid_o
);

    logic [N_WARPS-1:0] scheduled_warps_r;
    logic [N_WARPS-1:0] scheduled_warp_one_hot_w;
    logic [N_WARPS-1:0] scheduled_warps_next_w;

    always_comb begin
        scheduled_warps_next_w = scheduled_warps_r & ~scheduled_warp_one_hot_w;
    end

    priority_encoder #(
        .WIDTH   (N_WARPS)
     ) priority_encoder (
    	.input_i  (scheduled_warps_r),
    	.one_hot_o(scheduled_warp_one_hot_w),
    	.index_o  (warp_id_o),
    	.valid_o  (warp_valid_o)
    );

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            scheduled_warps_r <= '0;
        end else begin
            if (|scheduled_warps_next_w) begin
                scheduled_warps_r <= scheduled_warps_next_w;
            end else begin
`ifdef FORCE_WARP_COUNT
                localparam int WARP_COUNT = `FORCE_WARP_COUNT;
                localparam int WARP_MASK = (1 << WARP_COUNT) - 1;
                scheduled_warps_r <= ready_i & WARP_MASK;
`else
                scheduled_warps_r <= ready_i;
`endif
            end
        end
    end

endmodule

`default_nettype wire
