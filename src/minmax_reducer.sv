module minmax_reducer #(
    parameter int COUNT = 8,
    localparam int LOG_COUNT = $clog2(COUNT),
    parameter type TYPE = logic[31:0],
    parameter bit MAX = 0
) (
    input  TYPE [COUNT-1:0] vals_i,
    input  logic [COUNT-1:0] valid_i,
    output TYPE res_val_o,
    output logic [LOG_COUNT-1:0] res_idx_o,
    output logic res_valid_o
);

    if (COUNT != (1 << LOG_COUNT)) begin : gen_assert
        $error("COUNT (%0d) must be a power of 2", COUNT);
    end

    // Flat wire array per reduction level
    // tree_val_w[0] has N elements, tree_val_w[LEVELS] has 1 element
    genvar lvl, i;
    generate
        TYPE tree_val_w [LOG_COUNT:0][COUNT-1:0];
        logic tree_valid_w [LOG_COUNT:0][COUNT-1:0];
        logic [LOG_COUNT-1:0] tree_idx_w [LOG_COUNT:0][COUNT-1:0];

        // Base level
        for (i = 0; i < COUNT; i++) begin : gen_base
            assign tree_val_w[0][i] = vals_i[i];
            assign tree_valid_w[0][i] = valid_i[i];
            assign tree_idx_w[0][i] = LOG_COUNT'(unsigned'(i));
        end

        // tree_val_w reduction
        for (lvl = 0; lvl < LOG_COUNT; lvl++) begin : gen_levels
            localparam int PAIRS = COUNT >> (lvl + 1);
            for (i = 0; i < PAIRS; i++) begin : gen_nodes
                TYPE val_a_w, val_b_w;
                assign val_a_w = tree_val_w[lvl][2*i];
                assign val_b_w = tree_val_w[lvl][2*i+1];

                logic [LOG_COUNT-1:0] idx_a_w, idx_b_w;
                assign idx_a_w = tree_idx_w[lvl][2*i];
                assign idx_b_w = tree_idx_w[lvl][2*i+1];

                logic valid_a_w, valid_b_w;
                assign valid_a_w = tree_valid_w[lvl][2*i];
                assign valid_b_w = tree_valid_w[lvl][2*i+1];

                logic cmp_w;

                if (MAX) begin : gen_max
                    assign cmp_w = val_a_w > val_b_w;
                end else begin : gen_min
                    assign cmp_w = val_a_w < val_b_w;
                end

                logic sel_w;
                always_comb begin
                    if (valid_a_w && valid_b_w) sel_w = cmp_w;
                    else if (valid_a_w && !valid_b_w) sel_w = 1;
                    else if (valid_b_w && !valid_a_w) sel_w = 0;
                    else sel_w = 'x;
                end

                assign tree_val_w[lvl+1][i] = sel_w ? val_a_w : val_b_w;
                assign tree_idx_w[lvl+1][i] = sel_w ? idx_a_w : idx_b_w;
                assign tree_valid_w[lvl+1][i] = valid_a_w || valid_b_w;
            end
        end

        assign res_val_o = tree_val_w[LOG_COUNT][0];
        assign res_idx_o = tree_idx_w[LOG_COUNT][0];
        assign res_valid_o = tree_valid_w[LOG_COUNT][0];
    endgenerate

endmodule
