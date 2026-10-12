`default_nettype none

// Function Unit - Load-Store Unit

module fu_lsu
    import params_pkg::*;
    import core_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic in_valid_i,
    output logic in_ready_o,
    input wire fu_operation_s in_operation_i,

    output logic out_valid_o,
    input wire logic out_ready_i,
    output fu_result_s out_result_o,

    output logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] spad_addr_o,
    output logic [N_SPAD_BANKS-1:0][RLEN-1:0] spad_wdata_o,
    output logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0] spad_wen_o,
    input wire logic [N_SPAD_BANKS-1:0][RLEN-1:0] spad_rdata_i
);

endmodule

`default_nettype wire
