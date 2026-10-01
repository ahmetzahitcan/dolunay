`default_nettype none

module thread_scheduler
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,
    input wire logic en,

    input wire pc_t pc_next_i,
    input wire logic yield_i,
/*
    input wire logic barr_load_i,
    input wire simd_mask_t barr_load_total_i,
    input wire simd_mask_t barr_load_parked_i,

    input wire logic barr_sync_i,
    output simd_mask_t barr_sync_total_o,
    output simd_mask_t barr_sync_parked_next_o,
    output logic barr_sync_release_o,
*/
    input wire logic split_i,
    input wire pc_t split_pc_i,
    input wire simd_mask_t split_mask_i,

    output pc_t pc_o,
    output simd_mask_t mask_o
);
    pc_t [N_THREADS-1:0] pc_list_r;
    simd_mask_t [N_THREADS-1:0] mask_list_r;
    logic [W_THREADS-1:0] path_id_r;

    logic [N_THREADS-1:0] path_valid_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            path_valid_w[i] = |mask_list_r[i];
        end
    end

    logic [W_THREADS-1:0] path_id_next_w;
    logic next_found_w;

    always_comb begin
        // Round-Robin Arbiter: Scans all path slots to seamlessly route around parked or dead paths.
        path_id_next_w = '0;
        next_found_w   = 1'b0;

        // Pass 1: Scan for the next valid path ID strictly greater than the current path
        for (int i = 0; i < N_THREADS; i++) begin
            if (!next_found_w && (i > int'(path_id_r)) && path_valid_w[i]) begin
                path_id_next_w = i[W_THREADS-1:0];
                next_found_w   = 1'b1;
            end
        end

        if (!next_found_w) begin
            // Pass 2: Wrap around and scan from 0 up to the current path
            for (int i = 0; i < N_THREADS; i++) begin
                if (!next_found_w && (i <= int'(path_id_r)) && path_valid_w[i]) begin
                    path_id_next_w = i[W_THREADS-1:0];
                    next_found_w   = 1'b1;
                end
            end
        end

    `ifndef SYNTHESIS
        if (rst_n && !$isunknown(path_valid_w)) begin
            assert #0 (next_found_w) else $error("No ready path found. This is probably a hardware bug.");
        end
    `endif
    end

    // INFO: Don't hastily delete. This is used by the currently disabled branching logic.
    logic [W_THREADS-1:0] path_id_empty_w;
    logic empty_found_w;

    always_comb begin
        path_id_empty_w = '0;
        empty_found_w   = 1'b0;

        for (int i = 0; i < N_THREADS; i++) begin
            if (!empty_found_w && !path_valid_w[i]) begin
                path_id_empty_w = i[W_THREADS-1:0];
                empty_found_w   = 1'b1;
            end
        end
    end

    pc_t pc_w;
    assign pc_w = pc_list_r[path_id_r];

    simd_mask_t mask_w;
    assign mask_w = mask_list_r[path_id_r];
/*
    logic [N_THREADS-1:0] barr_total_r;
    logic [N_THREADS-1:0] barr_parked_r;

    logic [N_THREADS-1:0] barr_parked_next_w;
    assign barr_parked_next_w = barr_parked_r | mask_w;

    logic barr_release_w;
    assign barr_release_w = (barr_total_r == barr_parked_next_w);
*/

    simd_mask_t split_mask_remain_w;
    assign split_mask_remain_w = mask_w & ~split_mask_i;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            path_id_r <= '0;
            pc_list_r[0] <= '0;
            mask_list_r[0] <= '1;
            for (int i = 1; i < N_THREADS; i++) begin
                pc_list_r[i] <= '0;
                mask_list_r[i] <= '0;
            end
            // barr_total_r <= '0;
            // barr_parked_r <= '0;
        end else if (en) begin
            pc_list_r[path_id_r] <= pc_next_i;

            unique0 if (yield_i) begin
                path_id_r <= path_id_next_w;
                /*
            end else if (barr_load_i) begin
                barr_total_r <= barr_load_total_i;
                barr_parked_r <= barr_load_parked_i;
            end else if (barr_sync_i) begin
                if (barr_release_w) begin
                    // Warp Reconvergence: The last arriving path absorbs the entire aggregate mask.

                    mask_list_r[path_id_r] <= barr_total_r;
                end else begin
                    // Warp is yet to reconverge. Disable this path.
                    // The last arriving path will absorb the entire mask.

                    mask_list_r[path_id_r] <= '0;

                    // auto-yield
                    path_id_r <= path_id_next_w;

                    assert (path_id_next_w != path_id_r) else $error("Path ID did not change during barrier sync park.");
                end
                */
            end else if (split_i) begin
                assert (split_mask_i != mask_w) else $error("Split mask is equal to the active thread mask.");
                assert ((split_mask_i & ~mask_w) == '0) else $error("Split mask is not a subset of the active thread mask.");
                assert (split_mask_i != '0) else $error("Split fired with empty taken mask.");

                // Divergent Jump: Path splinters. Allocate an empty slot for the taken threads, keeping the fall-through threads here.
                // Mathematical Guarantee: Because N_THREADS == MAX_PATHS, we can never run out of empty slots during divergence.
                assert (empty_found_w) else $error("No empty path found during divergence.");

                pc_list_r[path_id_empty_w] <= split_pc_i;
                mask_list_r[path_id_empty_w] <= split_mask_i;
                mask_list_r[path_id_r] <= split_mask_remain_w;
            end
        end
    end

    assign pc_o   = pc_w;
    assign mask_o = mask_w;

    /*
    assign barr_sync_total_o = barr_total_r;
    assign barr_sync_parked_next_o = barr_parked_next_w;
    assign barr_sync_release_o = barr_release_w;
    */
endmodule

`default_nettype wire
