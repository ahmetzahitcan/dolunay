package params_pkg;
// TODO: use localparam instead of parameter
    parameter int XLEN = 32;

    parameter int ADDR_WIDTH = 32;
    parameter int ADDR_ALIGN = 4;
    parameter int LOG_ADDR_ALIGN = $clog2(ADDR_ALIGN);

    parameter int PC_ALIGN = 4;
    parameter int LOG_PC_ALIGN = $clog2(PC_ALIGN);

    parameter int NUM_WARPS = 4;
    parameter int NUM_THREADS = 8;
    parameter int NUM_REGISTERS = 16; // RV32E
    parameter int NUM_BARRIERS = 2; // Max 8
    parameter int LOG_NUM_WARPS = $clog2(NUM_WARPS);
    parameter int LOG_NUM_THREADS = $clog2(NUM_THREADS);
    parameter int LOG_NUM_REGISTERS = $clog2(NUM_REGISTERS);
    parameter int LOG_NUM_BARRIERS = $clog2(NUM_BARRIERS);
    
endpackage