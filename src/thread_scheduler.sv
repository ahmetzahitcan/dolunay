// TODO: register-indexed jumps (can result in more than 2 pathes)

module thread_scheduler #(
    parameter int NUM_THREADS = 32,
    parameter int PC_WIDTH = 30,
    parameter int NUM_BARRIERS = 8,
    localparam int LOG_NUM_THREADS = $clog2(NUM_THREADS),
    localparam int LOG_NUM_BARRIERS = $clog2(NUM_BARRIERS)
) (
    input logic clk,
    input logic rst_n,

    input logic fetch_i,
    input logic yield_i,
    input logic binit_i,
    input logic bwait_i,
    input logic [LOG_NUM_BARRIERS-1:0] bsel_i,
    input logic branch_i,
    input logic [PC_WIDTH-1:0] pc_branch_i,
    input logic [NUM_THREADS-1:0] mask_branch_i,

    output logic [PC_WIDTH-1:0] pc_o,
    output logic [NUM_THREADS-1:0] mask_o
);

logic [NUM_THREADS-1:0][PC_WIDTH-1:0] pc_list_r;
logic [NUM_THREADS-1:0][NUM_THREADS-1:0] mask_list_r;
logic [LOG_NUM_THREADS-1:0] path_id_r;

logic [NUM_THREADS-1:0] path_valid_w;

always_comb begin
    for (int i = 0; i < NUM_THREADS; i++) begin
        path_valid_w[i] = |mask_list_r[i];
    end
end

logic [LOG_NUM_THREADS-1:0] path_id_next_w;
logic next_found_w;

always_comb begin
    // Round-Robin Arbiter: Scans all path slots to seamlessly route around parked or dead paths.
    path_id_next_w = '0;
    next_found_w   = 1'b0;

    // Pass 1: Scan for the next valid path ID strictly greater than the current path
    for (int i = 0; i < NUM_THREADS; i++) begin
        if (!next_found_w && (i > path_id_r) && path_valid_w[i]) begin
            path_id_next_w = i[LOG_NUM_THREADS-1:0];
            next_found_w   = 1'b1;
        end
    end

    if (!next_found_w) begin
        // Pass 2: Wrap around and scan from 0 up to the current path
        for (int i = 0; i < NUM_THREADS; i++) begin
            if (!next_found_w && (i <= path_id_r) && path_valid_w[i]) begin
                path_id_next_w = i[LOG_NUM_THREADS-1:0];
                next_found_w   = 1'b1;
            end
        end
    end

    assert (next_found_w) else $error("No ready path found. This is probably a hardware bug.");
end

logic [LOG_NUM_THREADS-1:0] path_id_empty_w;
logic empty_found_w;

always_comb begin
    path_id_empty_w = '0;
    empty_found_w   = 1'b0;

    for (int i = 0; i < NUM_THREADS; i++) begin
        if (!empty_found_w && !path_valid_w[i]) begin
            path_id_empty_w = i[LOG_NUM_THREADS-1:0];
            empty_found_w   = 1'b1;
        end
    end
end

logic [PC_WIDTH-1:0] pc_w;
assign pc_w = pc_list_r[path_id_r];

logic [PC_WIDTH-1:0] pc_p1_w;
assign pc_p1_w = pc_w + 1;

logic [NUM_THREADS-1:0] mask_w;
assign mask_w = mask_list_r[path_id_r];

always_comb begin
    if (branch_i) begin
        assert ((mask_branch_i & ~mask_w) == '0) else $error("Branch mask is not a subset of the active thread mask. This is probably a hardware bug.");
    end
end

logic [NUM_THREADS-1:0] mask_remain_w;
assign mask_remain_w = mask_w & ~mask_branch_i;

logic mask_remain_valid_w;
assign mask_remain_valid_w = |mask_remain_w;

logic [NUM_BARRIERS-1:0][NUM_THREADS-1:0] barrier_total_r;
logic [NUM_BARRIERS-1:0][NUM_THREADS-1:0] barrier_parked_r;

logic [NUM_THREADS-1:0] barrier_parked_next_w;
assign barrier_parked_next_w = barrier_parked_r[bsel_i] | mask_w;

logic barrier_release_w;
assign barrier_release_w = (barrier_total_r[bsel_i] == barrier_parked_next_w);

always_ff @(posedge clk) begin
    if (!rst_n) begin
        path_id_r <= '0;
        pc_list_r[0] <= '0;
        mask_list_r[0] <= '1;
        for (int i = 1; i < NUM_THREADS; i++) begin
            pc_list_r[i] <= '0;
            mask_list_r[i] <= '0;
        end
        for (int i = 0; i < NUM_BARRIERS; i++) begin
            barrier_total_r[i] <= '0;
            barrier_parked_r[i] <= '0;
        end
    end else begin
        unique0 if (fetch_i) begin
            pc_o <= pc_w;
            mask_o <= mask_w;
            pc_list_r[path_id_r] <= pc_p1_w;

            assert (mask_w != 0) else $error("Fetched from an inactive path. This is probably a hardware bug.");
        end else if (yield_i) begin
            path_id_r <= path_id_next_w;
        end else if (binit_i) begin
            barrier_total_r[bsel_i] <= mask_w;
            barrier_parked_r[bsel_i] <= 0;
        end else if (bwait_i) begin
            if (barrier_release_w) begin
                // Warp Reconvergence: The last arriving path absorbs the entire aggregate mask.
                mask_list_r[path_id_r] <= barrier_total_r[bsel_i];

                // NOTE: I'm putting this here for safety, but these values likely don't matter
                // since they're not used until the next binit_i
                barrier_total_r[bsel_i] <= '0;
                barrier_parked_r[bsel_i] <= '0;
            end else begin
                // Warp is yet to reconverge. Disable this path, and mark it as parked within the barrier.
                // The last arriving path will absorb the entire mask.

                barrier_parked_r[bsel_i] <= barrier_parked_next_w;
                mask_list_r[path_id_r] <= '0;
                path_id_r <= path_id_next_w; // auto-yield

                assert (path_id_next_w != path_id_r) else $error("Path ID did not change during barrier wait. This is probably a hardware bug.");
            end
        end else if (branch_i) begin
            if (mask_remain_valid_w) begin
                // Divergent Jump: Path splinters. Allocate an empty slot for the taken threads, keeping the fall-through threads here.
                // Mathematical Guarantee: Because NUM_THREADS == MAX_PATHS, we can never run out of empty slots during divergence.
                assert (empty_found_w) else $error("No empty path found during divergence. This is probably a hardware bug.");

                pc_list_r[path_id_empty_w] <= pc_branch_i;
                mask_list_r[path_id_empty_w] <= mask_branch_i;
                mask_list_r[path_id_r] <= mask_remain_w;
            end else begin
                // Uniform Jump: All threads took the branch. Overwrite the current slot to avoid wasting path capacity.
                pc_list_r[path_id_r] <= pc_branch_i;
                // mask_list_r[path_id_r] <= mask_branch_i; // Not needed since this only happens when mask_w = mask_branch_i
            end
        end
    end
end

endmodule