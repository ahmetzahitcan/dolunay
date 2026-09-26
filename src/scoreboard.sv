`default_nettype none

/*
    Scoreboard module.

    N check ports for the issue unit. Reports busy if the entry is acquired. These are combinatorial.

    One acquire port for the issue unit.
    Acquiring an already acquired entry causes the earlier acquire to drop.
    Acquire port operates with the clock.

    One release port for the commit unit.
    Outputs whether the release is valid, or if the acquire was dropped.
    Release port is half-synchronous half-combinatorial.
    Information on whether the release will be succesful is combinatorial,
    But no actual release happens until the clock edge.
*/

module scoreboard
    import params_pkg::*;
#(
    parameter int N_ENTRIES,
    parameter int N_CHECK_PORTS,
    localparam int W_ENTRIES = $clog2(N_ENTRIES),
    localparam type entry_id_t = logic[W_ENTRIES-1:0]
)(
    input wire logic clk,
    input wire logic rst_n,

    // Warp IDs
    input wire warp_id_t issue_warp_id_i,
    input wire warp_id_t commit_warp_id_i,

    // Issue-check ports
    input wire  entry_id_t chk_id_i [0:N_CHECK_PORTS-1],
    input wire  logic chk_en_i [0:N_CHECK_PORTS-1],
    output logic chk_busy_o [0:N_CHECK_PORTS-1],

    // Issue-acquire port
    input wire  entry_id_t        acq_id_i,
    input wire  seq_t   acq_seq_i,
    input wire  logic acq_en_i,

    // Commit-release port
    input wire  entry_id_t        rel_id_i,
    input wire  seq_t   rel_seq_i,
    input wire  logic rel_en_i,
    output logic rel_valid_o
);

    logic [N_WARPS-1:0][N_ENTRIES-1:0] busy_r;
    seq_t seq_r [0:N_WARPS-1][0:N_ENTRIES-1];

    logic chk_busy_w [0:N_CHECK_PORTS-1];
    logic rel_valid_w;

    always_comb begin
        for (int i = 0; i < N_CHECK_PORTS; i++) begin
            chk_busy_w[i] = chk_en_i[i] &&
                busy_r[issue_warp_id_i][chk_id_i[i]];
        end

        rel_valid_w = rel_en_i &&
            busy_r[commit_warp_id_i][rel_id_i] &&
            rel_seq_i == seq_r[commit_warp_id_i][rel_id_i];
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            busy_r <= '0;
        end else begin
            assert (
                (!(acq_en_i && rel_en_i)) ||
                (issue_warp_id_i != commit_warp_id_i) ||
                (acq_id_i != rel_id_i)
            ) else $error("Cannot acquire and release the same entry! Entry: %d-%d", issue_warp_id_i, acq_id_i);

            if (acq_en_i) begin
                seq_r[issue_warp_id_i][acq_id_i] <= acq_seq_i;
                busy_r[issue_warp_id_i][acq_id_i] <= 1;
            end

            if (rel_en_i) begin
                assert (busy_r[commit_warp_id_i][rel_id_i])
                    else $warning("Release operation on non-busy entry! Entry: %d-%d", commit_warp_id_i, rel_id_i);
                assert (!$isunknown(seq_r[commit_warp_id_i][rel_id_i]))
                    else $error("Release operation on invalid seq! Entry: %d-%d", commit_warp_id_i, rel_id_i);

                if (rel_seq_i == seq_r[commit_warp_id_i][rel_id_i]) begin
                    busy_r[commit_warp_id_i][rel_id_i] <= 0;
                end
            end
        end
    end

    assign chk_busy_o = chk_busy_w;
    assign rel_valid_o = rel_valid_w;

endmodule

`default_nettype wire
