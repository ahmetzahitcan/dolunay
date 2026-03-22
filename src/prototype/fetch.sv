// =============================================================================
// fetch.sv — Fetch stage with thread scheduler (main prototype focus)
// =============================================================================
`default_nettype none

module fetch
    import proto_pkg::*;
#(
    parameter int NUM_THREADS = proto_pkg::NUM_THREADS,
    parameter int PC_WIDTH    = proto_pkg::PC_WIDTH
) (
    input  logic clk,
    input  logic rst_n,

    // Pipeline handshake
    input  logic                valid_i,
    output logic                done_o,

    // Branch feedback from execute
    input  logic                branch_taken_i,
    input  logic [PC_WIDTH-1:0] branch_target_i,

    // Output to instruction memory
    output logic [PC_WIDTH-1:0] pc_o,
    output logic [NUM_THREADS-1:0] active_mask_o
);

    localparam int LOG_NUM_THREADS = $clog2(NUM_THREADS);

    // -------------------------------------------------------------------------
    // Thread scheduler state
    // -------------------------------------------------------------------------
    logic [NUM_THREADS-1:0][PC_WIDTH-1:0]    pc_list_r;
    logic [NUM_THREADS-1:0][NUM_THREADS-1:0] mask_list_r;
    logic [LOG_NUM_THREADS-1:0]              curr_path_id_r;

    // -------------------------------------------------------------------------
    // Internal wires
    // -------------------------------------------------------------------------
    logic [LOG_NUM_THREADS-1:0] next_path_id_w;
    assign next_path_id_w = curr_path_id_r + 1'b1;

    logic next_path_valid_w;
    assign next_path_valid_w = |mask_list_r[next_path_id_w];

    logic [PC_WIDTH-1:0] selected_pc_w;
    assign selected_pc_w = pc_list_r[curr_path_id_r];

    logic [NUM_THREADS-1:0] selected_mask_w;
    assign selected_mask_w = mask_list_r[curr_path_id_r];

    // -------------------------------------------------------------------------
    // Done flag
    // -------------------------------------------------------------------------
    logic done_r;
    assign done_o = done_r;

    // -------------------------------------------------------------------------
    // Outputs
    // -------------------------------------------------------------------------
    assign pc_o          = selected_pc_w;
    assign active_mask_o = selected_mask_w;

    // -------------------------------------------------------------------------
    // Sequential logic
    // -------------------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            curr_path_id_r <= '0;
            done_r         <= 1'b0;

            // Thread 0 starts at PC=0 with mask=all-ones
            pc_list_r[0]   <= '0;
            mask_list_r[0] <= '1;
            for (int i = 1; i < NUM_THREADS; i++) begin
                pc_list_r[i]   <= '0;
                mask_list_r[i] <= '0;
            end

        end else begin
            done_r <= 1'b0;  // default: deassert

            if (valid_i) begin
                // Advance PC for the current path
                pc_list_r[curr_path_id_r] <= selected_pc_w + PC_WIDTH'(4);

                // TODO: thread scheduling policy (round-robin, priority, etc.)
                if (next_path_valid_w) begin
                    curr_path_id_r <= next_path_id_w;
                end else begin
                    curr_path_id_r <= '0;
                end

                done_r <= 1'b1;
            end

            // Branch override
            if (branch_taken_i) begin
                pc_list_r[curr_path_id_r] <= branch_target_i;
                // TODO: handle mask divergence on BEQ
            end
        end
    end

endmodule

`default_nettype wire
