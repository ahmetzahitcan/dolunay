// TODO: divergence
// TODO: outputs
// TODO: variable-length latency
// TODO: consider how timing interacts with warp scheduler. this almost certainly shouldn't run every cycle

module thread_scheduler #(
    parameter int NUM_THREADS = 8,
    parameter int PC_WIDTH = 30,
    localparam int LOG_NUM_THREADS = $clog2(NUM_THREADS)
) (
    input logic clk,
    input logic rst_n
);

logic [NUM_THREADS-1:0][PC_WIDTH-1:0] pc_list_r;
logic [NUM_THREADS-1:0][NUM_THREADS-1:0] mask_list_r;
logic [LOG_NUM_THREADS-1:0] curr_path_id_r;

logic [LOG_NUM_THREADS-1:0] next_path_id_w;
assign next_path_id_w = curr_path_id_r + 1'b1;

logic [PC_WIDTH-1:0] curr_pc_w;
assign curr_pc_w = pc_list_r[curr_path_id_r];

logic [NUM_THREADS-1:0] curr_mask_w;
assign curr_mask_w = mask_list_r[curr_path_id_r];

logic next_path_valid_w;
assign next_path_valid_w = |mask_list_r[next_path_id_w];

always_ff @(posedge clk) begin
    if (!rst_n) begin
        curr_path_id_r <= '0;
        pc_list_r[0] <= '0;
        mask_list_r[0] <= '1;
        for (int i = 1; i < NUM_THREADS; i++) begin
            pc_list_r[i] <= '0;
            mask_list_r[i] <= '0;
        end
    end else begin
        if (next_path_valid_w) begin
            curr_path_id_r <= next_path_id_w;
        end else begin
            curr_path_id_r <= '0;
        end
    end
end

endmodule