`default_nettype none

// =============================================================================
// demo.sv — the DUT of the example testbench.
//
// It is the smallest thing that shows the conventions the testbenches of this
// project use: a request channel and a response channel, both valid/ready,
// and a response that is held while the back-end is not ready.
//
// It answers every request with the data of the request, one cycle later.
// =============================================================================

module demo (
    input wire logic clk,
    input wire logic rst_n,

    // request channel
    input  wire logic       in_valid_i,
    output logic            in_ready_o,
    input  wire logic [7:0] in_data_i,

    // response channel
    output logic            out_valid_o,
    input  wire logic       out_ready_i,
    output logic [7:0]      out_data_o
);

    logic       res_valid_r;
    logic [7:0] res_data_r;

    // A request is accepted when there is no answer waiting for the
    // back-end, so there is one outstanding operation at a time.
    assign in_ready_o  = ~res_valid_r;
    assign out_valid_o = res_valid_r;
    assign out_data_o  = res_data_r;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            res_valid_r <= 1'b0;
            res_data_r  <= '0;
        end else begin
            // The back-end takes the answer.
            if (res_valid_r && out_ready_i)
                res_valid_r <= 1'b0;

            // A request is accepted, and its answer is presented in the next
            // cycle.
            if (in_valid_i && in_ready_o) begin
                res_valid_r <= 1'b1;
                res_data_r  <= in_data_i;
            end
        end
    end

endmodule

`default_nettype wire
