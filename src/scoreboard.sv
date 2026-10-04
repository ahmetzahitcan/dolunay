`default_nettype none

/*
    Scoreboard module.

    Any number of check ports. Reports busy if the entry is acquired. These are combinatorial.

    Any number of acquire ports.
    Acquiring an already acquired entry causes the earlier acquire to drop.
    Information on the dropped acquire (if any) will be given as output.
    It is possible to do an empty-acquire, which will drop any previous acquires, but not acquire anything.
    Acquire port operates with the clock.

    Any number of release ports.
    Outputs whether the release is valid, or if the acquire was dropped.
    Release port is half-synchronous half-combinatorial.
    Information on whether the release will be succesful is combinatorial,
    But no actual release happens until the clock edge.
*/

module scoreboard
    import params_pkg::*;
#(
    // FIXME: slang cannot generate proper warnings unless these are set to a default value.
    parameter int N_ENTRIES = 1,
    parameter int N_CHECK_PORTS = 3,
    parameter int N_ACQ_PORTS = 2,
    parameter int N_REL_PORTS = 1,

    localparam int W_ENTRIES = $clog2(N_ENTRIES),
    localparam type entry_id_t = logic[W_ENTRIES-1:0]
)(
    input wire logic clk,
    input wire logic rst_n,

    // Check ports
    input wire  entry_id_t chk_id_i [0:N_CHECK_PORTS-1],
    input wire  logic chk_en_i [0:N_CHECK_PORTS-1],
    output logic chk_busy_o [0:N_CHECK_PORTS-1],

    // Acquire ports
    input wire  entry_id_t acq_id_i [0:N_ACQ_PORTS-1],
    input wire  seq_t   acq_seq_i [0:N_ACQ_PORTS-1],
    input wire  logic acq_en_i [0:N_ACQ_PORTS-1],
    input wire  logic acq_empty_i [0:N_ACQ_PORTS-1],
    output seq_t acq_old_seq_o [0:N_ACQ_PORTS-1],
    output logic acq_old_busy_o [0:N_ACQ_PORTS-1],

    // Release ports
    input wire  entry_id_t rel_id_i [0:N_REL_PORTS-1],
    input wire  seq_t   rel_seq_i [0:N_REL_PORTS-1],
    input wire  logic rel_en_i [0:N_REL_PORTS-1],
    output logic rel_valid_o [0:N_REL_PORTS-1]
);

    logic [N_ENTRIES-1:0] busy_r;
    seq_t seq_r [0:N_ENTRIES-1];

    logic chk_busy_w [0:N_CHECK_PORTS-1];
    logic rel_valid_w [0:N_REL_PORTS-1];

    always_comb begin
        for (int i = 0; i < N_CHECK_PORTS; i++) begin
            chk_busy_w[i] = chk_en_i[i] &&
                busy_r[chk_id_i[i]];
        end

        for (int i = 0; i < N_REL_PORTS; i++) begin
            rel_valid_w[i] = rel_en_i[i] &&
                rel_seq_i[i] == seq_r[rel_id_i[i]];
        end
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            busy_r <= '0;
        end else begin
            for (int i = 0; i < N_REL_PORTS; i++) begin
                if (rel_en_i[i]) begin
                    assert (busy_r[rel_id_i[i]] || rel_seq_i[i] != seq_r[rel_id_i[i]])
                        else $warning("Release operation on non-busy entry! Entry: %d", rel_id_i[i]);
                    assert (!$isunknown(seq_r[rel_id_i[i]]))
                        else $error("Release operation on invalid seq! Entry: %d", rel_id_i[i]);

                    if (rel_seq_i[i] == seq_r[rel_id_i[i]]) begin
                        busy_r[rel_id_i[i]] <= 0;
                    end
                end
            end
            for (int i = 0; i < N_ACQ_PORTS; i++) begin
                if (acq_en_i[i]) begin
                    acq_old_seq_o[i] <= seq_r[acq_id_i[i]];
                    acq_old_busy_o[i] <= busy_r[acq_id_i[i]];

                    seq_r[acq_id_i[i]] <= acq_seq_i[i];
                    busy_r[acq_id_i[i]] <= !acq_empty_i[i];
                end
            end
        end
    end

    assign chk_busy_o = chk_busy_w;
    assign rel_valid_o = rel_valid_w;

endmodule

`default_nettype wire
