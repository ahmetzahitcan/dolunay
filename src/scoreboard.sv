`default_nettype none

/*
    Scoreboard module.

    Three check ports for the issue unit. Reports busy if the register is acquired. These are combinatorial.

    One acquire port for the issue unit. Acquiring an already acquired register causes the earlier acquire to drop.
    One release port for the commit unit. Outputs whether the release was successful, or if the acquire was dropped.
    Acquire and release ports operate with the clock.

    x0 register is special:
    - Check operations on x0 always report not busy.
    - Acquire operations on x0 are ignored.
    - Release operations on x0 always succeed.
*/

module scoreboard
    import params_pkg::*;
#(
    parameter type Tag
)(
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
    input wire  Tag   acq_tag_i,
    input wire  logic acq_en_i,

    // Commit-release port
    input wire  reg_id_t        rel_idx_i,
    input wire  regfile_sel_e rel_regfile_i,
    input wire  Tag   rel_tag_i,
    input wire  logic rel_en_i,
    output wire logic rel_success_o
);

    logic [N_WARPS-1:0][N_REGFILES-1:0][N_REGISTERS-1:0] busy_r;
    Tag tag_r [0:N_WARPS-1][0:N_REGFILES-1][0:N_REGISTERS-1];

    logic chk1_busy_w, chk2_busy_w, chk3_busy_w;
    logic rel_success_r;

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
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            busy_r <= '0;
            rel_success_r <= 0;
        end else begin
            assert (
                (!(acq_en_i && rel_en_i)) ||
                (issue_warp_id_i != commit_warp_id_i) ||
                (acq_idx_i != rel_idx_i) ||
                (acq_regfile_i != rel_regfile_i) ||
                (acq_idx_i == 0 && acq_regfile_i == REGFILE_SEL_I) // Acquire/release operations over x0 will be silently ignored.
            ) else $error("Cannot acquire and release the same entry! Entry: %d-%d", acq_regfile_i, acq_idx_i);

            if (acq_en_i && !(acq_idx_i == 0 && acq_regfile_i == REGFILE_SEL_I)) begin
                tag_r[issue_warp_id_i][acq_regfile_i][acq_idx_i] <= acq_tag_i;
                busy_r[issue_warp_id_i][acq_regfile_i][acq_idx_i] <= 1;
            end

            if (rel_en_i) begin
                if (rel_idx_i == 0 && rel_regfile_i == REGFILE_SEL_I) begin
                    rel_success_r <= 1;
                end else begin
                    assert (busy_r[commit_warp_id_i][rel_regfile_i][rel_idx_i])
                        else $warning("Release operation on non-busy entry! Entry: %d-%d", rel_regfile_i, rel_idx_i);
                    assert (!$isunknown(tag_r[commit_warp_id_i][rel_regfile_i][rel_idx_i]))
                        else $error("Release operation on unknown tag! Entry: %d-%d", rel_regfile_i, rel_idx_i);

                    if (rel_tag_i == tag_r[commit_warp_id_i][rel_regfile_i][rel_idx_i]) begin
                        rel_success_r <= busy_r[commit_warp_id_i][rel_regfile_i][rel_idx_i];
                        busy_r[commit_warp_id_i][rel_regfile_i][rel_idx_i] <= 0;
                    end else begin
                        rel_success_r <= 0;
                    end
                end
            end
        end
    end

    assign chk1_busy_o = chk1_busy_w;
    assign chk2_busy_o = chk2_busy_w;
    assign chk3_busy_o = chk3_busy_w;
    assign rel_success_o = rel_success_r;

endmodule

`default_nettype wire
