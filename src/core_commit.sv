`default_nettype none

module core_commit
    import params_pkg::*;
    import fu_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic [N_FUNCTION_UNITS-1:0] fu_out_valid_i,
    output logic [N_FUNCTION_UNITS-1:0] fu_out_ready_o,
    input wire fu_result_s [N_FUNCTION_UNITS-1:0] fu_out_result_i
);
    // Writeback signals

    // Reorder

    fu_result_s rob_r [0:N_WARPS-1][0:ROB_SIZE-1];
    logic rob_valid_r [0:N_WARPS-1][0:ROB_SIZE-1];
    logic [W_ROB_ADDR-1:0] rob_head_r [0:N_WARPS-1];

    logic fu_handshake_w;
    logic [W_FUNCTION_UNITS-1:0] fu_index_w;
    fu_result_s fu_result_w;
    assign fu_result_w = fu_out_result_i[fu_index_w];

    priority_encoder #(
        .WIDTH   (N_FUNCTION_UNITS)
     ) u_handshake_unit (
    	.input_i  (fu_out_valid_i),
    	.one_hot_o(fu_out_ready_o),
    	.index_o  (fu_index_w),
       	.valid_o  (fu_handshake_w)
    );

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            rob_valid_r <= '{default: 0};
            rob_head_r <= '{default: 0};
        end else begin
            if (fu_handshake_w) begin
                rob_r[fu_result_w.warp_id][fu_result_w.seq] <= fu_result_w;
                rob_valid_r[fu_result_w.warp_id][fu_result_w.seq] <= 1;
            end

            for (int i = 0; i < N_WARPS; i++) begin
                if (rob_valid_r[i][rob_head_r[i]]) begin
                    // TODO: Writeback!
                    rob_valid_r[i][rob_head_r[i]] <= 0;
                    rob_head_r[i] <= rob_head_r[i] + 1;
                    break;
                end
            end
        end
    end

    // Writeback

endmodule

`default_nettype wire
