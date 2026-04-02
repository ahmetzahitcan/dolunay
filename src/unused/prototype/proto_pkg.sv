// `default_nettype none

package proto_pkg;
import control_unit_pkg::*;
    // -------------------------------------------------------------------------
    // Core parameters
    // -------------------------------------------------------------------------
    parameter int XLEN          = 32;
    parameter int N_REGS      = 3;    // small for prototyping
    parameter int N_LANES     = 8;    // SIMD width
    parameter int N_THREADS   = 8;    // thread scheduler paths
    parameter int PC_WIDTH      = 30;
    parameter int REG_ADDR_WIDTH = $clog2(N_REGS);

    // -------------------------------------------------------------------------
    // Decoded instruction
    // -------------------------------------------------------------------------
    typedef struct packed {
        control_signals_s control_signals;
        logic [REG_ADDR_WIDTH-1:0]  rd;
        logic [REG_ADDR_WIDTH-1:0]  rs1;
        logic [REG_ADDR_WIDTH-1:0]  rs2;
        logic [XLEN-1:0]           imm;
    } decoded_instr_s;

endpackage

// `default_nettype wire
