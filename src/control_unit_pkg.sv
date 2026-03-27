`ifndef CONTROL_UNIT_PKG_SV
`define CONTROL_UNIT_PKG_SV

package control_unit_pkg;

    typedef enum logic [1:0] {
        ALU_ADD,
        ALU_BEQ,
        ALU_NOP
    } alu_funct_t;

    typedef struct packed {
        alu_funct_t alu_funct;
        logic         writeback;
        logic         branch;
    } control_signals_t;

endpackage

`endif
