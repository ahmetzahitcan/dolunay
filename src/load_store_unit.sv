`default_nettype none

module load_store_unit 
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input logic clk,
    input logic rst,
    
    input instr_s instr_i,
    input logic [N_THREADS-1:0] active_mask_i,
    input logic [N_THREADS-1:0][XLEN-1:Z_ADDR] addr_i,
    input logic [N_THREADS-1:0][XLEN-1:0] data_i,
    output logic [N_THREADS-1:0][XLEN-1:0] data_o,
    output logic [N_THREADS-1:0] valid_mask_o
);

    

endmodule

`default_nettype wire