`default_nettype none

/*
    Mask scoreboard module.

    Combinatorially outputs whether each entry is busy.

    One acquire port for the issue unit. Takes a mask of entries to acquire.
    Acquiring an already acquired entry causes the earlier acquire to drop.
    Acquire port operates with the clock.

    One release port for the commit unit. Takes a mask of entries to release.
    Outputs whether the release is valid, or if the acquire was dropped.
    Release port is half-synchronous half-combinatorial.
    Information on whether the release will be succesful is combinatorial,
    But no actual release happens until the clock edge.
*/

module scoreboard_mask
    import params_pkg::*;
#(
    // FIXME: slang cannot generate proper warnings unless this is set to a default value.
    parameter int N_ENTRIES = 1,
    parameter int N_GROUPS = N_WARPS,
    localparam int W_GROUPS = $clog2(N_GROUPS),

    localparam type group_id_t = logic[W_GROUPS-1:0],
    localparam type entry_mask_t = logic[N_ENTRIES-1:0]
)(
    input wire logic clk,
    input wire logic rst_n,

    // Busy output
    input wire group_id_t busy_group_id_i,
    output entry_mask_t busy_o,

    // Acquire port
    input wire group_id_t acq_group_id_i,
    input wire  entry_mask_t acq_mask_i,
    input wire  seq_t acq_seq_i,

    // Release port
    input wire group_id_t rel_group_id_i,
    input wire  entry_mask_t rel_mask_i,
    input wire  seq_t   rel_seq_i,
    output entry_mask_t rel_valid_o
);

    entry_mask_t [N_GROUPS-1:0] busy_r;
    seq_t seq_r [0:N_GROUPS-1][0:N_ENTRIES-1];

    entry_mask_t rel_valid_w;

    always_comb begin
        for (int i = 0; i < N_ENTRIES; i++) begin
            rel_valid_w[i] = rel_mask_i[i] &&
                busy_r[rel_group_id_i][i] &&
                rel_seq_i == seq_r[rel_group_id_i][i];
        end
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            busy_r <= '0;
        end else begin
            for (int i = 0; i < N_ENTRIES; i++) begin
                if (rel_mask_i[i]) begin
                    assert (busy_r[rel_group_id_i][i])
                        else $warning("Release operation on non-busy entry! Entry: %d-%d", rel_group_id_i, i);
                    assert (!$isunknown(seq_r[rel_group_id_i][i]))
                        else $error("Release operation on invalid seq! Entry: %d-%d", rel_group_id_i, i);

                    if (rel_seq_i == seq_r[rel_group_id_i][i]) begin
                        busy_r[rel_group_id_i][i] <= 0;
                    end
                end

                if (acq_mask_i[i]) begin
                    seq_r[acq_group_id_i][i] <= acq_seq_i;
                    busy_r[acq_group_id_i][i] <= 1;
                end
            end
        end
    end

    assign busy_o = busy_r[busy_group_id_i];
    assign rel_valid_o = rel_valid_w;

endmodule

`default_nettype wire
