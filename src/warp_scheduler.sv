module warp_scheduler 
    import params_pkg::*;
(
    input logic clk,
    input logic rst_n,
    output logic [LOG_NUM_WARPS-1:0] warp_id_p0_o,
    output logic [LOG_NUM_WARPS-1:0] warp_id_p1_o
);

logic [LOG_NUM_WARPS-1:0] current_warp_r;
logic [LOG_NUM_WARPS-1:0] next_warp_w;

assign next_warp_w = current_warp_r + 1'b1;

always_ff @(posedge clk) begin
    if (!rst_n) begin
        current_warp_r <= '0;
    end else begin
        current_warp_r <= next_warp_w;
    end
    
    warp_id_p0_o <= current_warp_r;
    warp_id_p1_o <= next_warp_w;
end

endmodule