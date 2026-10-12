`default_nettype none

module scratchpad
    import params_pkg::*;
(
    input wire logic clk,
    input wire logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] addr_i,
    input wire logic [N_SPAD_BANKS-1:0][RLEN-1:0] wdata_i,
    input wire logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0] wen_i,
    output logic [N_SPAD_BANKS-1:0][RLEN-1:0] rdata_o
);

    for (genvar i = 0; i < N_SPAD_BANKS; i++) begin : gen_bank
        ram #(
        	.DEPTH(SPAD_BANK_DEPTH)
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
