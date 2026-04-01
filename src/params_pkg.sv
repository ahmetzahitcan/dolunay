package params_pkg;

    localparam int XLEN = 32;

    localparam int ADDR_WIDTH = 32;
    localparam int ADDR_ALIGN = 4;
    localparam int LOG_ADDR_ALIGN = $clog2(ADDR_ALIGN);

    localparam int PC_ALIGN = 4;
    localparam int LOG_PC_ALIGN = $clog2(PC_ALIGN);

    localparam int NUM_WARPS = 4;
    localparam int NUM_THREADS = 8;
    localparam int NUM_REGISTERS = 16; // RV32E
    localparam int NUM_BARRIERS = 2; // Max 8
    localparam int LOG_NUM_WARPS = $clog2(NUM_WARPS);
    localparam int LOG_NUM_THREADS = $clog2(NUM_THREADS);
    localparam int LOG_NUM_REGISTERS = $clog2(NUM_REGISTERS);
    localparam int LOG_NUM_BARRIERS = $clog2(NUM_BARRIERS);
    
endpackage