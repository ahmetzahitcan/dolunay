`default_nettype none

package params_pkg;

    //`define SINGLE_WARP_MODE

    `ifndef SYNTHESIS
        localparam int DISASM_LEN = 32;
        typedef logic [DISASM_LEN*8-1:0] sim__disasm_t;
    `endif

    localparam int XLEN = 32;

    localparam int ADDR_ALIGN = 4;
    localparam int Z_ADDR = $clog2(ADDR_ALIGN);

    localparam int PC_ALIGN = 4;
    localparam int Z_PC = $clog2(PC_ALIGN);

    localparam int N_WARPS = 4; // Min 4
    localparam int N_THREADS = 8;
    localparam int N_REGISTERS = 32; // RV32I
    localparam int W_WARPS = $clog2(N_WARPS);
    localparam int W_THREADS = $clog2(N_THREADS);
    localparam int W_REGISTERS = $clog2(N_REGISTERS);

    localparam int TLOCAL_SIZE_PT = 1024; // per thread
    localparam int TLOCAL_BANK_SIZE = TLOCAL_SIZE_PT * N_WARPS;
    localparam int TLOCAL_BANK_DEPTH = TLOCAL_BANK_SIZE / ADDR_ALIGN;
    localparam int W_TLOCAL_ADDR_PT = $clog2(TLOCAL_SIZE_PT);
    localparam int W_TLOCAL_BANK_ADDR = $clog2(TLOCAL_BANK_SIZE);

    localparam int SHARED_MEM_SIZE = 65536; // 64 KB
    localparam int SHARED_MEM_DEPTH = SHARED_MEM_SIZE / ADDR_ALIGN;
    localparam int W_SHARED_MEM_ADDR = $clog2(SHARED_MEM_SIZE);

    localparam int IROM_SIZE = 4096; // 4 KB
    localparam int IROM_DEPTH = IROM_SIZE / ADDR_ALIGN;
    localparam int W_IROM_ADDR = $clog2(IROM_SIZE);

endpackage

`default_nettype wire