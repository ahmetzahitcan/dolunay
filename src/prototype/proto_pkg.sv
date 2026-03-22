`default_nettype none

package proto_pkg;

    // -------------------------------------------------------------------------
    // Core parameters
    // -------------------------------------------------------------------------
    parameter int XLEN          = 32;
    parameter int NUM_REGS      = 8;    // small for prototyping
    parameter int NUM_LANES     = 4;    // SIMD width
    parameter int NUM_THREADS   = 4;    // thread scheduler paths
    parameter int PC_WIDTH      = 32;
    parameter int REG_ADDR_WIDTH = $clog2(NUM_REGS);

    // -------------------------------------------------------------------------
    // Opcode encoding
    // -------------------------------------------------------------------------
    typedef enum logic [1:0] {
        OP_ADD = 2'b00,
        OP_BEQ = 2'b01
    } opcode_t;

    // -------------------------------------------------------------------------
    // Decoded instruction
    // -------------------------------------------------------------------------
    typedef struct packed {
        opcode_t                    opcode;
        logic [REG_ADDR_WIDTH-1:0]  rd;
        logic [REG_ADDR_WIDTH-1:0]  rs1;
        logic [REG_ADDR_WIDTH-1:0]  rs2;
        logic [XLEN-1:0]           imm;
    } decoded_instr_t;

endpackage

`default_nettype wire
