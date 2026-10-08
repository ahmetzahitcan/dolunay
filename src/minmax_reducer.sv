`default_nettype none

/*
    Min-Max Reducer. Takes a list of values and finds the minimum or maximum.
                     Returns the value and its tag.
*/

module minmax_reducer #(
    parameter int COUNT = 8,
    localparam int LOG_COUNT = $clog2(COUNT),
    parameter int WIDTH = 32,
    parameter type TAG_TYPE = logic,
    parameter bit MAX = 0
) (
    input wire logic [COUNT-1:0][WIDTH-1:0] vals_i,
    input wire TAG_TYPE [COUNT-1:0] tags_i,
    output logic [WIDTH-1:0] res_val_o,
    output TAG_TYPE res_tag_o
);
    `ifndef SYNTHESIS
        always_comb begin
            assert (!$isunknown(vals_i)) else $warning("Unknown values in minmax_reducer, comparison won't simulate correctly!");
        end
    `endif

    // Flat wire array per reduction level
    // tree_val_w[0] has N elements, tree_val_w[LEVELS] has 1 element
    genvar lvl, i;
    generate
        if (COUNT != (1 << LOG_COUNT)) begin : gen_assert
            $error("COUNT (%0d) must be a power of 2", COUNT);
        end

        logic [WIDTH-1:0] tree_val_w [LOG_COUNT:0][COUNT-1:0];
        TAG_TYPE tree_tag_w [LOG_COUNT:0][COUNT-1:0];

        // Base level
        for (i = 0; i < COUNT; i++) begin : gen_base
            assign tree_val_w[0][i] = vals_i[i];
            assign tree_tag_w[0][i] = tags_i[i];
        end

        // tree_val_w reduction
        for (lvl = 0; lvl < LOG_COUNT; lvl++) begin : gen_levels
            localparam int PAIRS = COUNT >> (lvl + 1);
            for (i = 0; i < PAIRS; i++) begin : gen_nodes
                logic [WIDTH-1:0] val_a_w, val_b_w;
                assign val_a_w = tree_val_w[lvl][2*i];
                assign val_b_w = tree_val_w[lvl][2*i+1];

                TAG_TYPE tag_a_w, tag_b_w;
                assign tag_a_w = tree_tag_w[lvl][2*i];
                assign tag_b_w = tree_tag_w[lvl][2*i+1];

                logic cmp_w;

                if (MAX) begin : gen_max
                    assign cmp_w = val_a_w > val_b_w;
                end else begin : gen_min
                    assign cmp_w = val_a_w < val_b_w;
                end

                assign tree_val_w[lvl+1][i] = cmp_w ? val_a_w : val_b_w;
                assign tree_tag_w[lvl+1][i] = cmp_w ? tag_a_w : tag_b_w;
            end
        end

        assign res_val_o = tree_val_w[LOG_COUNT][0];
        assign res_tag_o = tree_tag_w[LOG_COUNT][0];
    endgenerate

endmodule

`default_nettype wire
