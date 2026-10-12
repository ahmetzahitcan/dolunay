`default_nettype none

module scratchpad
    import params_pkg::*;
#(
    parameter int BANK_DEPTH = 1024,
    parameter int BANK_COUNT = N_THREADS,
    localparam int W_ADDR = $clog2(BANK_DEPTH) + Z_ADDR
)(
    input wire logic clk,
    input wire logic [BANK_COUNT-1:0][W_ADDR-1:Z_ADDR] addr_i,
    input wire logic [BANK_COUNT-1:0][RLEN-1:0] wdata_i,
    input wire logic [BANK_COUNT-1:0][ADDR_ALIGN-1:0] wen_i,
    output logic [BANK_COUNT-1:0][RLEN-1:0] rdata_o
);

    for (genvar i = 0; i < BANK_COUNT; i++) begin : gen_bank
        ram #(
        	.DEPTH(BANK_DEPTH)
        ) ram (
        	.clk    (clk),
        	.addr_i (addr_i[i]),
        	.wdata_i(wdata_i[i]),
        	.wen_i  (wen_i[i]),
        	.rdata_o(rdata_o[i])
        );
    end

endmodule

`default_nettype wire
