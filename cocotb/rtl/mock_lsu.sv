`default_nettype none

// =============================================================================
// mock_lsu.sv — a toy stand-in for fu_lsu, used to prove out the cocotb flow.
//
// It has the same handshake shape as the real LSU (a request channel and a
// response channel, both valid/ready) but none of the real complexity: one
// small memory, one outstanding operation, one cycle of latency.
//
// Semantics
//   write : mem[addr] <= wdata, the response carries wdata
//   read  : the response carries mem[addr]
//
// The memory is zeroed at time zero so that the simulation is deterministic.
// =============================================================================

module mock_lsu #(
    parameter int unsigned ADDR_BITS = 4,
    parameter int unsigned DATA_BITS = 32,
    parameter int unsigned DEPTH     = 1 << ADDR_BITS
) (
    input wire logic clk,
    input wire logic rst_n,

    // request channel
    input wire logic in_valid_i,
    output logic in_ready_o,
    input wire logic [ADDR_BITS-1:0] in_addr_i,
    input wire logic [DATA_BITS-1:0] in_wdata_i,
    input wire logic in_we_i,

    // response channel
    output logic out_valid_o,
    input wire logic out_ready_i,
    output logic [DATA_BITS-1:0] out_rdata_o
);

    logic [DATA_BITS-1:0] mem [DEPTH];

    logic                 res_valid_r;
    logic [DATA_BITS-1:0] res_data_r;

    // The result register is the only thing that can block a request: a new
    // request is accepted when the previous result has been taken, or is being
    // taken in the very same cycle.
    assign in_ready_o  = ~res_valid_r | out_ready_i;
    assign out_valid_o = res_valid_r;
    assign out_rdata_o = res_data_r;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            res_valid_r <= 1'b0;
            res_data_r  <= '0;
        end else begin
            if (res_valid_r && out_ready_i) begin
                res_valid_r <= 1'b0;
            end

            if (in_valid_i && in_ready_o) begin
                res_valid_r <= 1'b1;
                if (in_we_i) begin
                    mem[in_addr_i] <= in_wdata_i;
                    res_data_r     <= in_wdata_i;
                end else begin
                    res_data_r     <= mem[in_addr_i];
                end
            end
        end
    end

`ifndef SYNTHESIS
    initial begin
        for (int unsigned i = 0; i < DEPTH; i++) begin
            mem[i] = '0;
        end
    end
`endif

endmodule
