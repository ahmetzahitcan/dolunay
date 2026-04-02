`default_nettype none

package params_pkg;

    localparam int XLEN = 32;

    localparam int ADDR_ALIGN = 4;
    localparam int Z_ADDR = $clog2(ADDR_ALIGN);

    localparam int PC_ALIGN = 4;
    localparam int Z_PC = $clog2(PC_ALIGN);

    localparam int N_WARPS = 4;
    localparam int N_THREADS = 8;
    localparam int N_REGISTERS = 16; // RV32E
    localparam int N_BARRIERS = 2; // Max 8
    localparam int W_WARPS = $clog2(N_WARPS);
    localparam int W_THREADS = $clog2(N_THREADS);
    localparam int W_REGISTERS = $clog2(N_REGISTERS);
    localparam int W_BARRIERS = $clog2(N_BARRIERS);

    localparam int N_WRAM_BANKS = 16;
    localparam int W_WRAM_BANKS = $clog2(N_WRAM_BANKS);
    localparam int WRAM_BANK_SIZE = 4096;
    localparam int WRAM_BANK_DEPTH = WRAM_BANK_SIZE / ADDR_ALIGN;
    localparam int W_WRAM_BANK_ADDR = $clog2(WRAM_BANK_SIZE);
    localparam int W_WRAM_ADDR = W_WRAM_BANKS + W_WRAM_BANK_ADDR;

endpackage

`default_nettype wire