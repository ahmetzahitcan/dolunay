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

    localparam int N_WARPS = 8;
    localparam int N_THREADS = 32;
    localparam int N_REGISTERS = 32; // RV32I
    localparam int W_WARPS = $clog2(N_WARPS);
    localparam int W_THREADS = $clog2(N_THREADS);
    localparam int W_REGISTERS = $clog2(N_REGISTERS);

    typedef logic [N_THREADS-1:0] simd_mask_t;
    typedef logic [W_WARPS-1:0] warp_id_t;
    typedef logic [W_REGISTERS-1:0] reg_id_t;
    typedef logic [RLEN-1:0] uniform_data_t;
    typedef logic [N_THREADS-1:0][RLEN-1:0] simd_data_t;
    typedef logic [RLEN-1:Z_PC] pc_t;

    // Physical register file: a flat pool of N_PHYS_REGS registers per thread,
    // indexed by phys_reg_id_t. This is the single source of truth for the
    // register file size; the register file itself knows nothing about how an
    // architectural register number maps onto the pool.
    localparam int N_PHYS_REGS = N_WARPS * N_REGFILES * N_REGISTERS;
    localparam int W_PHYS_REGS = $clog2(N_PHYS_REGS);
    typedef logic [W_PHYS_REGS-1:0] phys_reg_id_t;

    function phys_reg_id_t get_phys_reg_id(warp_id_t warp_id, regfile_sel_e regfile_sel, reg_id_t reg_id);
        return {warp_id, regfile_sel, reg_id};
    endfunction

    localparam int ROB_SIZE = (1 << 3); // FIXME: An absurdly large value for safety. Check how long this should be later.
    localparam int W_ROB_ADDR = $clog2(ROB_SIZE);

    typedef logic [W_ROB_ADDR-1:0] seq_t;

    // FIXME: I had to move these here, because Verilator
    localparam int N_FUNCTION_UNITS = 5;
    localparam int W_FUNCTION_UNITS = $clog2(N_FUNCTION_UNITS);
    // INFO: The order of enum elements actually matters, the lower values are considered "faster".
    typedef enum logic [W_FUNCTION_UNITS-1:0] {
        FUNCTION_UNIT_BJU,
        FUNCTION_UNIT_CSRR,
        FUNCTION_UNIT_ALU,

        FUNCTION_UNIT_FPU,

        FUNCTION_UNIT_LSU
    } function_unit_e;

    parameter int SPAD_BANK_DEPTH = 1024;
    parameter int W_SPAD_BANK_ADDR = $clog2(SPAD_BANK_DEPTH) + Z_ADDR;
    parameter int N_SPAD_BANKS = N_THREADS;
    parameter int W_SPAD_BANKS = $clog2(N_SPAD_BANKS);
    parameter int Z_SPAD_BANK_SEL = W_SPAD_BANK_ADDR;
    parameter int W_SPAD_BANK_SEL = W_SPAD_BANKS + Z_SPAD_BANK_SEL;

    // ---------------------------------------------------------------------------
    // Scratchpad bank mapping
    //
    // The scratchpad is split into N_SPAD_BANKS banks of SPAD_BANK_DEPTH words.
    // A byte address selects a word, and the word selects a bank; the word's
    // position inside its bank is the offset.
    //
    // The word address w = addr >> 2 is split into three equal fields:
    //
    //     w = [ A : 5 | B : 5 | L : 5 ]
    //         w[14:10]  w[9:5]   w[4:0]
    //       addr[16:12] addr[11:7] addr[6:2]
    //
    //   A = region: which 4 KB block the word is in
    //   B = the middle field
    //   L = lane: which word of a 32-word group
    //
    // The bank is A ^ B ^ L, and the offset inside the bank is {B, L}. The
    // offset therefore holds B and L, and A is recoverable from the bank
    // (A = bank ^ B ^ L), so every word has its own place in the scratchpad.
    //
    // The mapping is a permutation of the address space, so it is invisible to
    // the program. It was picked because it is conflict free for the three
    // access patterns that matter:
    //
    //   * a shared vector or matrix row (32 consecutive words): the lane field
    //     separates the threads;
    //   * a matrix column: for a row of NCOLS words the row index lands in B
    //     and the column index in L, so B ^ L is the classic column-XOR-row
    //     swizzle;
    //   * thread private data, one region per thread: the region field
    //     separates the threads.
    //
    // See LSU_ROADMAP.md section 9 for the derivation and the measurements.
    // ---------------------------------------------------------------------------

    // The three address fields the bank mapping is built from.
    function automatic logic [W_SPAD_BANKS-1:0] spad_field_a(input logic [RLEN-1:0] addr);
        spad_field_a = addr[W_SPAD_BANK_SEL-1 : W_SPAD_BANK_SEL-W_SPAD_BANKS];
    endfunction

    function automatic logic [W_SPAD_BANKS-1:0] spad_field_b(input logic [RLEN-1:0] addr);
        spad_field_b = addr[W_SPAD_BANK_ADDR-1 : W_SPAD_BANK_ADDR-W_SPAD_BANKS];
    endfunction

    function automatic logic [W_SPAD_BANKS-1:0] spad_field_l(input logic [RLEN-1:0] addr);
        spad_field_l = addr[Z_ADDR+W_SPAD_BANKS-1 : Z_ADDR];
    endfunction

    // The bank a byte address belongs to.
    function automatic logic [W_SPAD_BANKS-1:0] spad_bank_of(input logic [RLEN-1:0] addr);
        spad_bank_of = spad_field_a(addr) ^ spad_field_b(addr) ^ spad_field_l(addr);
    endfunction

    // The position of a byte address inside its bank.
    function automatic logic [W_SPAD_BANK_ADDR-1:Z_ADDR] spad_offset_of(input logic [RLEN-1:0] addr);
        spad_offset_of = addr[W_SPAD_BANK_ADDR-1 : Z_ADDR];
    endfunction

endpackage

`default_nettype wire
