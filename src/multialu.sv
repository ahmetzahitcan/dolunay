`default_nettype none

// TODO: Seperate scalar operations into a different FU

module multialu
    import params_pkg::*;
    import control_unit_pkg::*;
#(
    parameter FIFO_DEPTH = N_WARPS
) (
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,

    output logic out_valid_o,
    input wire logic out_ready_i,

    input wire op_tag_s op_tag_i,
    input wire logic [N_THREADS-1:0][RLEN-1:0] rs1_val_i,
    input wire logic [N_THREADS-1:0][RLEN-1:0] rs2_val_i,
    input wire instr_s instr_i,
    input wire logic [W_WARPS-1:0] warp_id_i,
    input wire logic [RLEN-1:Z_PC] pc_i,
    input wire logic [63:0] cycle_time_i,
    input wire logic [N_THREADS-1:0][63:0] instret_i,
    input wire logic [63:0] wuinstret_i,
    input wire logic [63:0] wtinstret_i,

    output op_tag_s op_tag_o,
    output logic [N_THREADS-1:0][RLEN-1:0] result_o
);
    localparam W_FIFO = $clog2(FIFO_DEPTH);

    logic [N_THREADS-1:0][RLEN-1:0] alu_result_w;
    logic [FIFO_DEPTH-1:0][N_THREADS-1:0][RLEN-1:0] fifo_results_r;
    op_tag_s [FIFO_DEPTH-1:0] fifo_tags_r;

    logic [W_FIFO-1:0] fifo_head_r, fifo_head_p1_w;
    logic [W_FIFO-1:0] fifo_exctail_r, fifo_exctail_p1_w; // Exclusive tail, that is, the tail pointer plus 1.
    logic fifo_almost_empty_w, fifo_almost_full_w;
    logic fifo_empty_r, fifo_full_r;

    always_comb begin
        fifo_head_p1_w = fifo_head_r + 1;
        fifo_exctail_p1_w = fifo_exctail_r + 1;
        fifo_almost_empty_w = (fifo_head_p1_w == fifo_exctail_r);
        fifo_almost_full_w = (fifo_head_r == fifo_exctail_p1_w);
    end

    // Input handshake

    logic in_handshake_w;
    assign in_ready_o = ~fifo_full_r;
    assign in_handshake_w = in_valid_i & in_ready_o;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            fifo_exctail_r <= 0;
        end else begin
            if (in_handshake_w) begin
                fifo_results_r[fifo_exctail_r] <= alu_result_w;
                fifo_tags_r[fifo_exctail_r] <= op_tag_i;
                fifo_exctail_r <= fifo_exctail_p1_w;
            end
        end
    end

    // Output handshake
    logic out_handshake_w;
    assign out_valid_o = ~fifo_empty_r;
    assign out_handshake_w = out_valid_o & out_ready_i;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            fifo_head_r <= 0;
        end else begin
            if (out_handshake_w) begin
                fifo_head_r <= fifo_head_p1_w;
            end
        end
    end

    // FIFO empty/full flag

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            fifo_empty_r <= 1;
            fifo_full_r <= 0;
        end else begin
            if (out_handshake_w & in_handshake_w) begin
                // This can only happen when the FIFO is neither full nor empty
                // So keep both flags the same
                fifo_empty_r <= 0;
                fifo_full_r <= 0;
            end else if (out_handshake_w) begin
                fifo_empty_r <= fifo_almost_empty_w;
                fifo_full_r <= 0;
            end else if (in_handshake_w) begin
                fifo_empty_r <= 0;
                fifo_full_r <= fifo_almost_full_w;
            end
        end
    end

    generate
        for (genvar I = 0; I < N_THREADS; I++) begin : gen_alu
            alu #(
                .THREAD_ID(I)
            ) u_alu (
                .rs1_val_i(rs1_val_i[I]),
                .rs2_val_i(rs2_val_i[I]),
                .instr_i(instr_i),
                .warp_id_i(warp_id_i),
                .pc_i(pc_i),
                .result_o(alu_result_w[I]),
                .cycle_time_i(cycle_time_i),
                .instret_i(instret_i[I]),
                .wuinstret_i(wuinstret_i),
                .wtinstret_i(wtinstret_i)
            );
        end
    endgenerate

    assign result_o = fifo_results_r[fifo_head_r];
    assign op_tag_o = fifo_tags_r[fifo_head_r];

endmodule

`default_nettype wire
