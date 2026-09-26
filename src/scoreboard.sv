`default_nettype none

/*
    Scoreboard module.

    Three check ports for the issue unit. Reports busy if the register is acquired. These are combinatorial.

    One acquire port for the issue unit.
    Acquiring an already acquired register causes the earlier acquire to drop.
    Acquire port operates with the clock.

    One release port for the commit unit.
    Outputs whether the release is valid, or if the acquire was dropped.
    Release port is half-synchronous half-combinatorial.
    Information on whether the release will be succesful is combinatorial,
    But no actual release happens until the clock edge.

    x0 register is special:
    - Check operations on x0 always report not busy.
    - Acquire operations on x0 are ignored.
    - Release operations on x0 always succeed.
*/

module scoreboard
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    // Warp IDs
    input wire warp_id_t issue_warp_id_i,
    input wire warp_id_t commit_warp_id_i,

    // Issue-check port 1
    input wire  reg_id_t       chk1_idx_i,
    input wire  regfile_sel_e chk1_regfile_i,
    input wire  logic chk1_en_i,
    output logic  chk1_busy_o,

    // Issue-check port 2
    input wire  reg_id_t       chk2_idx_i,
    input wire  regfile_sel_e chk2_regfile_i,
    input wire  logic chk2_en_i,
    output logic  chk2_busy_o,

    // Issue-check port 3
    input wire  reg_id_t       chk3_idx_i,
    input wire  regfile_sel_e chk3_regfile_i,
    input wire  logic chk3_en_i,
    output logic  chk3_busy_o,

    // Issue-acquire port
    input wire  reg_id_t        acq_idx_i,
    input wire  regfile_sel_e acq_regfile_i,
    input wire  seq_t   acq_seq_i,
    input wire  logic acq_en_i,

    // Commit-release port
    input wire  reg_id_t        rel_idx_i,
    input wire  regfile_sel_e rel_regfile_i,
    input wire  seq_t   rel_seq_i,
    input wire  logic rel_en_i,
    output logic rel_valid_o
);

    logic [N_WARPS-1:0][N_REGFILES-1:0][N_REGISTERS-1:0] busy_r;
    seq_t seq_r [0:N_WARPS-1][0:N_REGFILES-1][0:N_REGISTERS-1];

    logic chk1_busy_w, chk2_busy_w, chk3_busy_w;
    logic rel_valid_w;

    always_comb begin
        chk1_busy_w = chk1_en_i &&
            !(chk1_idx_i == 0 && chk1_regfile_i == REGFILE_SEL_I) &&
            busy_r[issue_warp_id_i][chk1_regfile_i][chk1_idx_i];

        chk2_busy_w = chk2_en_i &&
            !(chk2_idx_i == 0 && chk2_regfile_i == REGFILE_SEL_I) &&
            busy_r[issue_warp_id_i][chk2_regfile_i][chk2_idx_i];

        chk3_busy_w = chk3_en_i &&
            !(chk3_idx_i == 0 && chk3_regfile_i == REGFILE_SEL_I) &&
            busy_r[issue_warp_id_i][chk3_regfile_i][chk3_idx_i];

        rel_valid_w = (rel_idx_i == 0 && rel_regfile_i == REGFILE_SEL_I) ||
            (
                busy_r[commit_warp_id_i][rel_regfile_i][rel_idx_i] &&
                rel_seq_i == seq_r[commit_warp_id_i][rel_regfile_i][rel_idx_i]
            );
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            busy_r <= '0;
        end else begin
            assert (
                (!(acq_en_i && rel_en_i)) ||
                (issue_warp_id_i != commit_warp_id_i) ||
                (acq_idx_i != rel_idx_i) ||
                (acq_regfile_i != rel_regfile_i) ||
                (acq_idx_i == 0 && acq_regfile_i == REGFILE_SEL_I) // Acquire/release operations over x0 will be silently ignored.
            ) else $error("Cannot acquire and release the same entry! Entry: %d-%d", acq_regfile_i, acq_idx_i);

            if (acq_en_i && !(acq_idx_i == 0 && acq_regfile_i == REGFILE_SEL_I)) begin
                seq_r[issue_warp_id_i][acq_regfile_i][acq_idx_i] <= acq_seq_i;
                busy_r[issue_warp_id_i][acq_regfile_i][acq_idx_i] <= 1;
            end

            if (rel_en_i) begin
                if (!(rel_idx_i == 0 && rel_regfile_i == REGFILE_SEL_I)) begin
                    assert (busy_r[commit_warp_id_i][rel_regfile_i][rel_idx_i])
                        else $warning("Release operation on non-busy entry! Entry: %d-%d", rel_regfile_i, rel_idx_i);
                    assert (!$isunknown(seq_r[commit_warp_id_i][rel_regfile_i][rel_idx_i]))
                        else $error("Release operation on invalid seq! Entry: %d-%d", rel_regfile_i, rel_idx_i);

                    if (rel_seq_i == seq_r[commit_warp_id_i][rel_regfile_i][rel_idx_i]) begin
                        busy_r[commit_warp_id_i][rel_regfile_i][rel_idx_i] <= 0;
                    end
                end
            end
        end
    end

    assign chk1_busy_o = chk1_busy_w;
    assign chk2_busy_o = chk2_busy_w;
    assign chk3_busy_o = chk3_busy_w;
    assign rel_valid_o = rel_valid_w;

endmodule

`default_nettype wire
