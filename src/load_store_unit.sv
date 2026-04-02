`default_nettype none

module load_store_unit 
    import params_pkg::*;
(
    input logic clk,
    input logic rst,
    
    input instr_s instr_i,
    input logic [NUM_THREADS-1:0][XLEN-1:LOG_ADDR_ALIGN] addr_i,
    input logic [NUM_THREADS-1:0][XLEN-1:0] data_i,
    output logic [NUM_THREADS-1:0][XLEN-1:0] data_o,
    
);

endmodule

`default_nettype wire