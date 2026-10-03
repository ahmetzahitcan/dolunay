`default_nettype none

module warp_scheduler
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,
    input wire logic stall_i,
    output logic [W_WARPS-1:0] warp_id_o
);

    logic [W_WARPS-1:0] current_warp_r;

    logic [W_WARPS-1:0] next_warp_w;
    assign next_warp_w = current_warp_r + 1'b1;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            current_warp_r <= '0;
        end else if (!stall_i) begin
            current_warp_r <= next_warp_w;
        end
    end

`ifdef FORCE_WARP_COUNT
    // Only warps [0, FORCE_WARP_COUNT) are scheduled. The round-robin counter
    // still runs over the full range, so take it modulo the active count.
    localparam int unsigned FORCE_WARP_COUNT_VAL = `FORCE_WARP_COUNT;
    assign warp_id_o = warp_id_t'(current_warp_r % FORCE_WARP_COUNT_VAL);
`else
    assign warp_id_o = current_warp_r;
`endif

endmodule

`default_nettype wire
