`default_nettype none

/*
    Front-end of the core. Responsible for instruction issuing.
    - In-order issue
    - No register renaming
    - Scoreboard to keep track of hazards
    - Can acquire scoreboard entries, but release must be done by the back-end.
*/

module core_frontend
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
# (
    parameter int OFQ_DEPTH = 2,
    localparam int W_OFQ = $clog2(OFQ_DEPTH)
)(
    input wire logic clk,
    input wire logic rst_n,

    // Input from front-end
    output logic [N_WARPS-1:0] me_ready_o,
    input wire logic [N_WARPS-1:0] me_valid_i,
    input wire me_operation_s me_op_i
);

    // Operand Fetch Queues
    me_operation_s [N_WARPS-1:0][OFQ_DEPTH-1:0] ofq_r;
    logic [N_WARPS-1:0][W_OFQ-1:0] ofq_wptr_r, ofq_rptr_r, ofq_wptr_p1_w, ofq_rptr_p1_w;

    always_comb begin
        for (int i = 0; i < N_WARPS; i++) begin
            ofq_wptr_p1_w[i] = ofq_wptr_r[i] + 1;
            ofq_rptr_p1_w[i] = ofq_rptr_r[i] + 1;
        end
    end

    logic [N_WARPS-1:0] ofq_full_r;

    assign me_ready_o = ~ofq_full_r;

    logic [N_WARPS-1:0] me_handshake_w;
    assign me_handshake_w = me_valid_i & me_ready_o;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ofq_r <= 'x;
            ofq_wptr_r <= '0;
            ofq_rptr_r <= '0;
            ofq_full_r <= '0;
        end else begin
            for (int i = 0; i < N_WARPS; i++) begin
                if (me_handshake_w[i]) begin
                    ofq_r[i][ofq_wptr_r[i]] <= me_op_i;
                    ofq_wptr_r[i] <= ofq_wptr_p1_w[i];
                    ofq_full_r[i] <= ofq_wptr_p1_w[i] == ofq_rptr_r[i];
                end
            end
        end
    end


endmodule

`default_nettype wire
