module warp_scheduler #(
    parameter int NUM_WARPS = 8,
    parameter int ADDR_WIDTH = 32,
    localparam int LOG_NUM_WARPS = $clog2(NUM_WARPS)
) (
    input logic clk,
    input logic rst_n,
    output logic [ADDR_WIDTH-1:2] pc,
    output logic [LOG_NUM_WARPS-1:0] warp_id
);

logic [NUM_WARPS-1:0][ADDR_WIDTH-1:2] pc_list;
logic [LOG_NUM_WARPS-1:0] current_warp;

logic [ADDR_WIDTH-1:2] current_pc;
logic [ADDR_WIDTH-1:2] current_pc_p1;
logic [LOG_NUM_WARPS-1:0] next_warp;

assign current_pc   = pc_list[current_warp];
assign current_pc_p1 = pc_list[current_warp] + 1'b1;
assign next_warp    = current_warp + 1'b1;

always_ff @(posedge clk) begin
    if (!rst_n) begin
        current_warp <= '0;
        for (int i = 0; i < NUM_WARPS; i++) begin
            pc_list[i] <= '0;
        end
    end else begin
        pc_list[current_warp] <= current_pc_p1;
        current_warp          <= next_warp;
    end
    
    pc      <= current_pc;
    warp_id <= current_warp;
end

endmodule