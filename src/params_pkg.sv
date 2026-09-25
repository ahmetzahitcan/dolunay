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
        REGFILE_SEL_F
    } regfile_sel_e;

    localparam int ADDR_ALIGN = 4;
    localparam int Z_ADDR = $clog2(ADDR_ALIGN);

    localparam int PC_ALIGN = 4;
    localparam int Z_PC = $clog2(PC_ALIGN);

    localparam int N_WARPS = 64; // FIXME: An absurdly large number of warps for safety.
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

    typedef logic [N_THREADS-1:0] simd_mask_t;
    typedef logic [W_WARPS-1:0] warp_id_t;
    typedef logic [W_REGISTERS-1:0] reg_id_t;
    typedef logic [N_THREADS-1:0][RLEN-1:0] simd_data_t;
    typedef logic [RLEN-1:Z_PC] pc_t;

    localparam int ROB_SIZE = 65536; // FIXME: An absurdly large value for safety. Check how long this should be later.
    localparam int W_ROB_ADDR = $clog2(ROB_SIZE);

    typedef logic [W_ROB_ADDR-1:0] seq_t;

endpackage

`default_nettype wire
