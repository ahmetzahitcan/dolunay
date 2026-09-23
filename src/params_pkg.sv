`default_nettype none

package params_pkg;

    `ifndef SYNTHESIS
        localparam int DISASM_LEN = 64;
        typedef logic [DISASM_LEN*8-1:0] sim__disasm_t;
    `endif

    localparam int RLEN = 32; // INFO: Forced XLEN = FLEN
    localparam int N_REGFILES = 2;
    localparam int W_REGFILES = $clog2(N_REGFILES);
    typedef enum logic [W_REGFILES-1:0] {
        REGFILE_SEL_I, // I'm using I instead of X, because X looks like x in control_unit.csv
        REGFILE_SEL_F,
        REGFILE_SEL_UNDEFINED = 'x
    } regfile_sel_e;

    localparam int ADDR_ALIGN = 4;
    localparam int Z_ADDR = $clog2(ADDR_ALIGN);

    localparam int PC_ALIGN = 4;
    localparam int Z_PC = $clog2(PC_ALIGN);

    localparam int N_WARPS = 8; // Min 8?
    localparam int N_THREADS = 8;
    localparam int N_REGISTERS = 32; // RV32I
    localparam int W_WARPS = $clog2(N_WARPS);
    localparam int W_THREADS = $clog2(N_THREADS);
    localparam int W_REGISTERS = $clog2(N_REGISTERS);

    localparam int TLOCAL_SIZE_PT = 2048; // per thread
    localparam int TLOCAL_BANK_SIZE = TLOCAL_SIZE_PT * N_WARPS;
    localparam int TLOCAL_BANK_DEPTH = TLOCAL_BANK_SIZE / ADDR_ALIGN;
    localparam int W_TLOCAL_ADDR_PT = $clog2(TLOCAL_SIZE_PT);
    localparam int W_TLOCAL_BANK_ADDR = $clog2(TLOCAL_BANK_SIZE);

    localparam int W_OP_ID = 32; // FIXME: This is a very high number for testing. Something around 3 to 5 should be enough in real use.
    typedef struct packed {
        logic [W_OP_ID-1:0] op_id;
        logic [W_WARPS-1:0] warp_id;
        control_unit_pkg::instr_s instr;
    } op_tag_s;

endpackage

`default_nettype wire
