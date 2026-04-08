`default_nettype none

module thread_scheduler 
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic instr_completed_i,
    input wire logic [N_THREADS-1:0] instr_replay_mask_i,

    input wire logic yield_i,
    input wire logic binit_i,
    input wire logic bwait_i,
    input wire logic [W_BARRIERS-1:0] barr_idx_i,
    input wire logic branch_i,
    input wire logic [XLEN-1:Z_PC] pc_branch_i,
    input wire logic [N_THREADS-1:0] mask_branch_i,

    output logic [XLEN-1:Z_PC] pc_o,
    output logic [N_THREADS-1:0] mask_o
);
    logic [N_THREADS-1:0][XLEN-1:Z_PC] pc_list_r;
    logic [N_THREADS-1:0][N_THREADS-1:0] mask_list_r;
    logic [W_THREADS-1:0] path_id_r;

    logic [N_THREADS-1:0] path_valid_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            path_valid_w[i] = |mask_list_r[i];
        end
    end

    logic [W_THREADS-1:0] path_id_next_w;
    logic next_found_w;

    logic [N_THREADS-1:0] path_id_next_mask_w;
    assign path_id_next_mask_w = mask_list_r[path_id_next_w];

    always_comb begin
        // Round-Robin Arbiter: Scans all path slots to seamlessly route around parked or dead paths.
        path_id_next_w = '0;
        next_found_w   = 1'b0;

        // Pass 1: Scan for the next valid path ID strictly greater than the current path
        for (int i = 0; i < N_THREADS; i++) begin
            if (!next_found_w && (i > path_id_r) && path_valid_w[i]) begin
                path_id_next_w = i[W_THREADS-1:0];
                next_found_w   = 1'b1;
            end
        end

        if (!next_found_w) begin
            // Pass 2: Wrap around and scan from 0 up to the current path
            for (int i = 0; i < N_THREADS; i++) begin
                if (!next_found_w && (i <= path_id_r) && path_valid_w[i]) begin
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

    logic [XLEN-1:Z_PC] pc_w;
    assign pc_w = pc_list_r[path_id_r];

    logic [XLEN-1:Z_PC] pc_p1_w;
    assign pc_p1_w = pc_w + 1;

    logic [N_THREADS-1:0] mask_w;
    assign mask_w = mask_list_r[path_id_r];

    logic [N_BARRIERS-1:0][N_THREADS-1:0] barrier_total_r;
    logic [N_BARRIERS-1:0][N_THREADS-1:0] barrier_parked_r;

    logic [N_THREADS-1:0] barrier_parked_next_w;
    assign barrier_parked_next_w = barrier_parked_r[barr_idx_i] | mask_w;

    logic barrier_release_w;
    assign barrier_release_w = (barrier_total_r[barr_idx_i] == barrier_parked_next_w);

    logic replay_any_w;
    assign replay_any_w = |instr_replay_mask_i;

    logic [N_THREADS-1:0] play_mask_r;

    logic [N_THREADS-1:0] mask_active_and_playing_w;
    assign mask_active_and_playing_w = mask_w & play_mask_r;

    logic [N_THREADS-1:0] mask_remain_w;
    assign mask_remain_w = mask_w & ~mask_branch_i;

    logic mask_remain_valid_w;
    assign mask_remain_valid_w = |mask_remain_w;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            path_id_r <= '0;
            pc_list_r[0] <= '0;
            mask_list_r[0] <= '1;
            play_mask_r <= '1;
            for (int i = 1; i < N_THREADS; i++) begin
                pc_list_r[i] <= '0;
                mask_list_r[i] <= '0;
            end
            for (int i = 0; i < N_BARRIERS; i++) begin
                barrier_total_r[i] <= '0;
                barrier_parked_r[i] <= '0;
            end
        end else begin
            if (instr_completed_i) begin
                assert ((instr_replay_mask_i & ~mask_w) == '0) else $error("Instruction replay mask is not a subset of the active thread mask.");

                if (replay_any_w) begin
                    play_mask_r <= play_mask_r & instr_replay_mask_i;
                end else begin
                    pc_list_r[path_id_r] <= pc_p1_w;
                    play_mask_r <= mask_w;
                end
            end 
            
            unique0 if (yield_i) begin
                assert (mask_w == mask_active_and_playing_w) else $error("yield_i raised during replay.");
                path_id_r <= path_id_next_w;
                play_mask_r <= path_id_next_mask_w;
            end else if (binit_i) begin
                assert (mask_w == mask_active_and_playing_w) else $error("binit_i raised during replay.");
                assert (barrier_total_r[barr_idx_i] == '0) else $warning("binit_i called on a barrier that is already initialized.");

                barrier_total_r[barr_idx_i] <= mask_w;
                barrier_parked_r[barr_idx_i] <= 0;
            end else if (bwait_i) begin
                assert (mask_w == mask_active_and_playing_w) else $error("bwait_i raised during replay.");
                if (barrier_release_w) begin
                    // Warp Reconvergence: The last arriving path absorbs the entire aggregate mask.
                    mask_list_r[path_id_r] <= barrier_total_r[barr_idx_i];
                    play_mask_r <= barrier_total_r[barr_idx_i];

                    // FIXME: I'm putting this here for safety, but these values likely don't matter
                    // since they're not used until the next binit_i
                    barrier_total_r[barr_idx_i] <= '0;
                    barrier_parked_r[barr_idx_i] <= '0;
                end else begin
                    // Warp is yet to reconverge. Disable this path, and mark it as parked within the barrier.
                    // The last arriving path will absorb the entire mask.

                    barrier_parked_r[barr_idx_i] <= barrier_parked_next_w;
                    mask_list_r[path_id_r] <= '0;

                    // auto-yield
                    path_id_r <= path_id_next_w;
                    play_mask_r <= path_id_next_mask_w;

                    assert (path_id_next_w != path_id_r) else $error("Path ID did not change during barrier wait.");
                end
            end else if (branch_i) begin
                assert ((mask_branch_i & instr_replay_mask_i) == '0) else $error("Some threads are trying to replay and branch at the same time.");
                assert ((mask_branch_i & ~mask_w) == '0) else $error("Branch mask is not a subset of the active thread mask.");
                assert (mask_branch_i != '0) else $error("Branch fired with empty taken mask.");

                if (mask_remain_valid_w) begin
                    // Divergent Jump: Path splinters. Allocate an empty slot for the taken threads, keeping the fall-through threads here.
                    // Mathematical Guarantee: Because N_THREADS == MAX_PATHS, we can never run out of empty slots during divergence.
                    assert (empty_found_w) else $error("No empty path found during divergence.");

                    pc_list_r[path_id_empty_w] <= pc_branch_i;
                    mask_list_r[path_id_empty_w] <= mask_branch_i;
                    mask_list_r[path_id_r] <= mask_remain_w;
                end else begin
                    // Uniform Jump: All threads took the branch. Overwrite the current slot to avoid wasting path capacity.
                    pc_list_r[path_id_r] <= pc_branch_i;
                    // mask_list_r[path_id_r] <= mask_branch_i; // Not needed since this only happens when mask_w == mask_branch_i
                end
            end
        end
    end

    assign pc_o   = pc_w;
    assign mask_o = mask_active_and_playing_w;

endmodule

`default_nettype wire