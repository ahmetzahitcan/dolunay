`default_nettype none

// =============================================================================
// tb_fu_lsu — testbench for the load/store unit.
//
// The LSU and the real scratchpad are instantiated together, so the
// scratchpad's registered read is part of what is being tested rather than
// something the testbench assumes.
//
// A behavioural model of the whole LSU memory path runs alongside: it
// replicates the arbitration as a loop (every bank serves its lowest
// numbered pending thread, the losers are retried), applies the stores to a
// shadow copy of the scratchpad, and predicts the loaded values and the
// number of cycles the operation takes.
//
// The model does not reuse any of the LSU's RTL, including the read and write
// formatters, so a mistake in those is caught as well.
// =============================================================================

module tb_fu_lsu;
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;

    // ---------------------------------------------------------------------------
    // Clock and reset
    // ---------------------------------------------------------------------------

    logic clk = 1'b0;
    logic rst_n = 1'b0;

    always #5 clk = ~clk;

    // ---------------------------------------------------------------------------
    // DUT
    // ---------------------------------------------------------------------------

    logic                    in_valid;
    logic                    in_ready;
    fu_operation_s           in_operation;
    logic                    out_valid;
    logic                    out_ready = 1'b1;
    fu_result_s              out_result;

    logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] spad_addr;
    logic [N_SPAD_BANKS-1:0][RLEN-1:0]                spad_wdata;
    logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0]          spad_wen;
    logic [N_SPAD_BANKS-1:0][RLEN-1:0]                spad_rdata;


    // The scratchpad is written by the LSU, except while the testbench fills
    // it with the initial pattern.
    logic                    init_mode;
    logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] init_addr;
    logic [N_SPAD_BANKS-1:0][RLEN-1:0]                init_wdata;
    logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0]          init_wen;

    logic [N_SPAD_BANKS-1:0][W_SPAD_BANK_ADDR-1:Z_ADDR] spad_addr_o;
    logic [N_SPAD_BANKS-1:0][RLEN-1:0]                spad_wdata_o;
    logic [N_SPAD_BANKS-1:0][ADDR_ALIGN-1:0]          spad_wen_o;

    assign spad_addr   = init_mode ? init_addr   : spad_addr_o;
    assign spad_wdata  = init_mode ? init_wdata  : spad_wdata_o;
    assign spad_wen    = init_mode ? init_wen    : spad_wen_o;

    fu_lsu u_dut (
        .clk            (clk),
        .rst_n          (rst_n),
        .in_valid_i     (in_valid),
        .in_ready_o     (in_ready),
        .in_operation_i (in_operation),
        .out_valid_o    (out_valid),
        .out_ready_i    (out_ready),
        .out_result_o   (out_result),
        .spad_addr_o    (spad_addr_o),
        .spad_wdata_o   (spad_wdata_o),
        .spad_wen_o     (spad_wen_o),
        .spad_rdata_i   (spad_rdata)
    );

    scratchpad u_spad (
        .clk    (clk),
        .addr_i (spad_addr),
        .wdata_i(spad_wdata),
        .wen_i  (spad_wen),
        .rdata_o(spad_rdata)
    );

    // ---------------------------------------------------------------------------
    // The model
    // ---------------------------------------------------------------------------

    // A shadow copy of the scratchpad.
    logic [RLEN-1:0] mem_model [N_SPAD_BANKS][SPAD_BANK_DEPTH];

    // The pattern the scratchpad is filled with. Every byte depends on both
    // the bank and the offset, so a routing mistake shows up.
    function automatic logic [RLEN-1:0] spad_pattern(input int unsigned b, input int unsigned o);
        spad_pattern = (b << 24) | (o << 8) | ((b + o) & 32'hFF);
    endfunction

    // The byte enables a store of the given size and alignment writes. This
    // mirrors mem_write_formatter, but is written out again here so that a
    // mistake in the formatter is caught.
    function automatic logic [ADDR_ALIGN-1:0] model_store_wen(
        input mem_opsize_e opsize,
        input logic [1:0]  align
    );
        case (opsize)
            MEM_OPSIZE_BYTE: unique case (align)
                2'b00: model_store_wen = 4'b0001;
                2'b01: model_store_wen = 4'b0010;
                2'b10: model_store_wen = 4'b0100;
                2'b11: model_store_wen = 4'b1000;
            endcase
            MEM_OPSIZE_HALF: case (align)
                2'b00: model_store_wen = 4'b0011;
                2'b10: model_store_wen = 4'b1100;
                default: $fatal(1, "Unaligned access in the golden model!");
            endcase
            MEM_OPSIZE_WORD: begin
                assert (align==2'b00) else $fatal(1, "Unaligned access in the golden model!");
                model_store_wen = 4'b1111;
            end
            default: $fatal(1, "Unknown opsize in the golden model!");
        endcase
    endfunction

    // The byte a store of the given size writes into the given lane. A byte
    // store replicates the byte into every lane. A half store puts the half
    // into the two lanes, and the formatter replicates the half into both
    // halves of the word, so lane 2 gets the same byte as lane 0. A word
    // store keeps the word as it is.
    function automatic logic [7:0] model_store_byte(
        input mem_opsize_e      opsize,
        input logic [RLEN-1:0]  data,
        input int               lane
    );
        case (opsize)
            MEM_OPSIZE_BYTE: model_store_byte = data[7:0];
            MEM_OPSIZE_HALF: model_store_byte = data[(lane%2)*8 +: 8];
            MEM_OPSIZE_WORD: model_store_byte = data[lane*8 +: 8];
            default: $fatal(1, "Unknown opsize in the golden model!");
        endcase
    endfunction

    // The value a load of the given size and alignment produces out of a
    // scratchpad word. This mirrors mem_read_formatter.
    function automatic logic [RLEN-1:0] model_load_value(
        input logic [RLEN-1:0]   word,
        input logic [1:0]        align,
        input mem_opsize_e       opsize,
        input mem_extendmode_e   extmode
    );
        logic [7:0]  byte_v;
        logic [15:0] half_v;
        logic [31:0] word_v;
        logic [RLEN-1:0] result_v;

        unique case (align)
            2'b00: byte_v = word[7:0];
            2'b01: byte_v = word[15:8];
            2'b10: byte_v = word[23:16];
            2'b11: byte_v = word[31:24];
        endcase

        case (align)
            2'b00: half_v = word[15:0];
            2'b10: half_v = word[31:16];
            default: half_v = 'x;
        endcase

        case (align)
            2'b00: word_v = word[31:0];
            default: word_v = 'x;
        endcase

        case (opsize)
            MEM_OPSIZE_BYTE: begin
                if (extmode == MEM_EXTENDMODE_SIGN) result_v = {{RLEN-8{byte_v[7]}}, byte_v};
                else                            result_v = {{RLEN-8{1'b0}}, byte_v};
            end
            MEM_OPSIZE_HALF: begin
                if (extmode == MEM_EXTENDMODE_SIGN) result_v = {{RLEN-16{half_v[15]}}, half_v};
                else                            result_v = {{RLEN-16{1'b0}}, half_v};
            end
            MEM_OPSIZE_WORD: result_v = word_v;
            default: $fatal(1, "Unknown opsize in the golden model!");
        endcase

        model_load_value = result_v;
    endfunction

    // The arbitration, written as a loop: in every cycle each bank serves its
    // lowest numbered pending thread, and the threads that lost are retried.
    // Returns the number of cycles the operation takes and, for a store,
    // applies the writes to the shadow scratchpad.
    task automatic model_arbitrate(
        input  logic [N_THREADS-1:0]         mask,
        input  logic [N_THREADS-1:0][RLEN-1:0] rs1,
        input  logic [N_THREADS-1:0][RLEN-1:0] rs2,
        input  mem_opsize_e                   opsize,
        input  logic [RLEN-1:0]               imm,
        input  bit                            is_store,
        output int                            cycles
    );
        logic [N_THREADS-1:0] pending;
        logic [N_THREADS-1:0] served;
        logic [RLEN-1:0]       addr;
        logic [ADDR_ALIGN-1:0] wen;
        int                   off;

        pending = mask;
        cycles  = 0;

        while (pending != '0) begin
            cycles++;
            served = '0;
            for (int b = 0; b < N_SPAD_BANKS; b++) begin
                for (int i = 0; i < N_THREADS; i++) begin
                    addr = rs1[i] + imm;
                    if (pending[i] && (spad_bank_of(addr) == b)) begin
                        served[i] = 1'b1;
                        if (is_store) begin
                            off = spad_offset_of(addr);
                            wen = model_store_wen(opsize, addr[Z_ADDR-1:0]);
                            for (int j = 0; j < ADDR_ALIGN; j++) begin
                                if (wen[j]) begin
                                    mem_model[b][off][j*8 +: 8] =
                                        model_store_byte(opsize, rs2[i], j);
                                end
                            end
                        end
                        break; // the lowest numbered thread of this bank wins
                    end
                end
            end
            pending = pending & ~served;
        end
    endtask

    // The address of a given (bank, offset) in the scratchpad. The bank
    // mapping is a permutation, so it can be inverted.
    function automatic logic [RLEN-1:0] addr_of(input int b, input int o);
        logic [W_SPAD_BANKS-1:0] a_f;
        logic [W_SPAD_BANKS-1:0] b_f;
        logic [W_SPAD_BANKS-1:0] l_f;
        b_f = o[9:5];
        l_f = o[4:0];
        a_f = b[4:0] ^ b_f ^ l_f;
        addr_of = {a_f, b_f, l_f, 2'b00};
    endfunction

    // Reads one word of the scratchpad back through the LSU and compares it
    // with the model. Used to find out which store went where.
    task automatic check_word(input int b, input int o, input string name);
        simd_mask_t              saved_mask;
        logic [N_THREADS-1:0][RLEN-1:0] saved_rs1;
        logic [N_THREADS-1:0][RLEN-1:0] saved_rs2;
        mem_loadstore_e          saved_ls;
        mem_opsize_e             saved_os;
        mem_extendmode_e         saved_em;
        logic [RLEN-1:0]         saved_imm;

        saved_mask = op_mask;
        saved_rs1  = op_rs1;
        saved_rs2  = op_rs2;
        saved_ls   = op_loadstore;
        saved_os   = op_opsize;
        saved_em   = op_extmode;
        saved_imm  = op_imm;

        op_mask      = '0;
        op_mask[0]   = 1'b1;
        op_rs1       = '0;
        op_rs1[0]    = addr_of(b, o);
        op_rs2       = '0;
        op_loadstore = MEM_LOADSTORE_LOAD;
        op_opsize    = MEM_OPSIZE_WORD;
        op_extmode   = MEM_EXTENDMODE_SIGN;
        op_imm       = 32'h0;

        run_op($sformatf("%s readback bank %0d offset %0d", name, b, o));

        op_mask      = saved_mask;
        op_rs1       = saved_rs1;
        op_rs2       = saved_rs2;
        op_loadstore = saved_ls;
        op_opsize    = saved_os;
        op_extmode   = saved_em;
        op_imm       = saved_imm;
    endtask

    // ---------------------------------------------------------------------------
    // Test bookkeeping
    // ---------------------------------------------------------------------------

    int unsigned checks = 0;
    int unsigned errors = 0;
    int unsigned seq_no = 0;

    // Which operations the randomised test generates:
    //   0 = loads and stores, 1 = loads only, 2 = stores only
    int random_mode = 0;
    int readback = 0;
    int stall_cycles = 0;
    int seed = 0;

    task automatic check(input bit ok, input string what);
        checks++;
        if (!ok) begin
            errors++;
            $display("  FAIL: %s", what);
        end
    endtask

    // ---------------------------------------------------------------------------
    // Driving one operation
    // ---------------------------------------------------------------------------

    logic [N_THREADS-1:0]         op_mask;
    logic [N_THREADS-1:0][RLEN-1:0] op_rs1;
    logic [N_THREADS-1:0][RLEN-1:0] op_rs2;
    mem_loadstore_e               op_loadstore;
    mem_opsize_e                  op_opsize;
    mem_extendmode_e              op_extmode;
    logic [RLEN-1:0]              op_imm;
    logic                         op_random_backpressure;

    // Runs one operation and compares the result against the model. Returns
    // the number of cycles the operation took.
    task automatic run_op(input string name);
        int                   model_cycles;
        int                   latency;
        logic [RLEN-1:0]      expected;
        logic [RLEN-1:0]      addr;
        instr_s               instr;

        // What the model says the result is.
        model_arbitrate(op_mask, op_rs1, op_rs2, op_opsize, op_imm,
                        op_loadstore == MEM_LOADSTORE_STORE, model_cycles);

        // The enum members of the instruction need an explicit value: a '0
        // default is not an implicit conversion to an enum.
        instr = '{
            rd_regfile:     REGFILE_SEL_I,
            rs1_regfile:    REGFILE_SEL_I,
            rs2_regfile:    REGFILE_SEL_I,
            rs3_regfile:    REGFILE_SEL_I,
            fu_sel:         FUNCTION_UNIT_LSU,
            csrr_src:       CSRR_SRC_FFLAGS,
            csrw_method:    CSRW_METHOD_WRITE,
            fflags_update:  FFLAGS_UPDATE_NONE,
            alu_funct:      ALU_FUNCT_ADDY,
            alu_addy_funct: ALU_ADDY_FUNCT_ADD,
            alu_op1_sel:    ALU_OP1_SEL_RS1,
            alu_op2_sel:    ALU_OP2_SEL_RS2,
            fpu_opcode:     fpnew_pkg::ADD,
            fpu_op0_sel:    FPU_OP0_SEL_RS1,
            fpu_op1_sel:    FPU_OP1_SEL_RS1,
            fpu_op2_sel:    FPU_OP2_SEL_RS2,
            bj_type:        BJ_TYPE_NONE,
            mem_loadstore:  op_loadstore,
            mem_opsize:     op_opsize,
            mem_extendmode: op_extmode,
            default:        '0
        };
        instr.imm            = op_imm;
        instr.rd_used        = (op_loadstore == MEM_LOADSTORE_LOAD);
        instr.mem_active     = 1'b1;

        in_operation = '{
            seq:      seq_no,
            warp_id:  '0,
            instr:    instr,
            pc:       '0,
            mask:     op_mask,
            rs1_data: op_rs1,
            rs2_data: op_rs2,
            rs3_data: '0
        };
        seq_no++;

        // Present the operation. It is accepted at the clock edge between the
        // two negedges.
        @(negedge clk);
        check(in_ready, "the LSU was not ready for the operation");
        in_valid = 1'b1;
        @(negedge clk);
        in_valid = 1'b0;

        // Wait for the result. The first negedge above is the first cycle
        // after the operation was accepted.
        latency = 1;
        forever begin
            @(negedge clk);
            latency++;
            if (out_valid) break;
            if (latency > 1000) begin
                check(0, "the operation never completed");
                return;
            end
        end

        check(latency == model_cycles + 2,
              $sformatf("%s: latency %0d, expected %0d", name, latency, model_cycles + 2));

        check(out_result.mask == op_mask, $sformatf("%s: result mask", name));
        check(!$isunknown(out_result.mask), $sformatf("%s: result mask has an unknown", name));

        // If the back-end is not ready, the result must be held.
        if (stall_cycles > 0) begin
            fu_result_s held;
            out_ready = 1'b0;
            held = out_result;
            for (int s = 0; s < stall_cycles; s++) begin
                @(negedge clk);
                check(out_valid, $sformatf("%s: out_valid dropped while stalled", name));
                check(out_result == held, $sformatf("%s: result changed while stalled", name));
            end
            out_ready = 1'b1;
        end

        // The LSU must have latched the instruction of this operation.
        check(u_dut.op_instr_r.mem_opsize == op_opsize,
              $sformatf("%s: latched opsize %0d, expected %0d",
                        name, u_dut.op_instr_r.mem_opsize, op_opsize));
        check(u_dut.op_instr_r.mem_loadstore == op_loadstore,
              $sformatf("%s: latched loadstore", name));

        for (int i = 0; i < N_THREADS; i++) begin
            if (op_mask[i]) begin
                addr = op_rs1[i] + op_imm;
                if (op_loadstore == MEM_LOADSTORE_LOAD) begin
                    expected = model_load_value(mem_model[spad_bank_of(addr)][spad_offset_of(addr)],
                                                addr[Z_ADDR-1:0], op_opsize, op_extmode);
                    check(out_result.wb_result[i] === expected,
                          $sformatf("%s: thread %0d loaded %h, expected %h (addr %h bank %0d off %0d align %0d word %h)",
                                    name, i, out_result.wb_result[i], expected, addr,
                                    spad_bank_of(addr), spad_offset_of(addr), addr[Z_ADDR-1:0],
                                    mem_model[spad_bank_of(addr)][spad_offset_of(addr)]));
                end
            end
        end

        // Take the result.
        @(negedge clk);
        out_ready = 1'b1;
        @(negedge clk);
    endtask

    // ---------------------------------------------------------------------------
    // Address generation
    // ---------------------------------------------------------------------------

    // A random address inside the scratchpad window.
    function automatic logic [RLEN-1:0] random_spad_addr();
        // The scratchpad covers 128 KB, and the addresses have to be aligned
        // for the access size.
        int align_bytes;
        case (op_opsize)
            MEM_OPSIZE_BYTE: align_bytes = 1;
            MEM_OPSIZE_HALF: align_bytes = 2;
            default:         align_bytes = 4;
        endcase
        random_spad_addr = $urandom_range(32767, 0) * 4;
        random_spad_addr[1:0] = '0;
        if (align_bytes == 2) random_spad_addr[1] = 1'b0;
    endfunction

    // The alignment a random access of the current size uses.
    function automatic logic [1:0] random_align();
        unique case (op_opsize)
            MEM_OPSIZE_BYTE: random_align = 2'($urandom_range(3, 0));
            MEM_OPSIZE_HALF: random_align = 2'($urandom_range(1, 0)) << 1;
            default:         random_align = 2'b00;
        endcase
    endfunction

    // ---------------------------------------------------------------------------
    // Tests
    // ---------------------------------------------------------------------------

    int                   model_cycles;
    logic [RLEN-1:0]      addr;

    initial begin
        in_valid  = 1'b0;
        out_ready = 1'b1;
        init_mode = 1'b1;
        in_operation = '0;

        // Reset.
        repeat (4) @(posedge clk);
        rst_n = 1'b1;
        repeat (2) @(posedge clk);

        // Fill the scratchpad with the pattern.
        for (int o = 0; o < SPAD_BANK_DEPTH; o++) begin
            for (int b = 0; b < N_SPAD_BANKS; b++) begin
                init_addr[b]  = o;
                init_wdata[b] = spad_pattern(b, o);
                init_wen[b]   = '1;
                mem_model[b][o] = spad_pattern(b, o);
            end
            @(posedge clk);
        end
        init_mode = 1'b0;
        @(posedge clk);

        $display("");

        // -- 1: a load with no bank conflicts ---------------------------------
        $display("[TEST 1] load, one thread per bank");
        op_loadstore = MEM_LOADSTORE_LOAD;
        op_opsize    = MEM_OPSIZE_WORD;
        op_extmode   = MEM_EXTENDMODE_SIGN;
        op_imm       = 32'h0;
        op_mask      = '1;
        for (int i = 0; i < N_THREADS; i++) begin
            // One word per bank: bank = A^B^L, so take the address from the
            // bank number directly.
            op_rs1[i] = {7'h0, 5'(i), 12'h0};
            op_rs2[i] = '0;
        end
        run_op("test 1");

        // -- 2: the same load, but with a byte and a half ---------------------
        $display("[TEST 2] load of bytes and halves");
        op_opsize  = MEM_OPSIZE_BYTE;
        op_extmode = MEM_EXTENDMODE_ZERO;
        for (int i = 0; i < N_THREADS; i++) begin
            op_rs1[i] = {7'h0, 5'(i), 12'h0};
            op_rs1[i][1:0] = 2'(i % 4);
        end
        run_op("test 2");

        op_opsize  = MEM_OPSIZE_HALF;
        op_extmode = MEM_EXTENDMODE_SIGN;
        for (int i = 0; i < N_THREADS; i++) begin
            op_rs1[i] = {7'h0, 5'(i), 12'h0};
            op_rs1[i][1:0] = 2'(2 * (i % 2));
        end
        run_op("test 2b");

        // -- 3: all threads on one bank ---------------------------------------
        $display("[TEST 3] all 32 threads on one bank");
        op_opsize  = MEM_OPSIZE_WORD;
        op_extmode = MEM_EXTENDMODE_SIGN;
        op_mask    = '1;
        for (int i = 0; i < N_THREADS; i++) begin
            op_rs1[i] = 32'h0;
            op_rs2[i] = '0;
        end
        // All threads read word 0 of bank 0.
        run_op("test 3");

        // -- 4: a store, then read it back ------------------------------------
        $display("[TEST 4] store, then read back");
        op_loadstore = MEM_LOADSTORE_STORE;
        op_opsize    = MEM_OPSIZE_WORD;
        op_extmode   = MEM_EXTENDMODE_SIGN;
        op_mask      = '1;
        for (int i = 0; i < N_THREADS; i++) begin
            op_rs1[i] = {7'h0, 5'(i), 12'h0};
            op_rs2[i] = 32'h1000_0000 + 32'(i);
        end
        run_op("test 4a");

        op_loadstore = MEM_LOADSTORE_LOAD;
        run_op("test 4b");

        // -- 5: a byte store into the pattern --------------------------------
        $display("[TEST 5] byte store");
        op_loadstore = MEM_LOADSTORE_STORE;
        op_opsize    = MEM_OPSIZE_BYTE;
        for (int i = 0; i < N_THREADS; i++) begin
            op_rs1[i] = {7'h0, 5'(i), 12'h0};
            op_rs1[i][1:0] = 2'(i % 4);
            op_rs2[i] = 32'h0000_00A0 + 32'(i);
        end
        run_op("test 5a");

        op_loadstore = MEM_LOADSTORE_LOAD;
        run_op("test 5b");

        // -- 6: randomised operations ------------------------------------------
        // The mode selects which operations are generated, which is useful to
        // tell a load problem from a store problem.
        void'($value$plusargs("mode=%d", random_mode));
        void'($value$plusargs("readback=%d", readback));
        // A seed makes a failure reproducible.
        if ($value$plusargs("seed=%d", seed)) begin
            void'($urandom(seed));
        end
        $display("[TEST 6] randomised operations (mode %0d)", random_mode);
        for (int iter = 0; iter < 2000; iter++) begin
            if (random_mode == 1) begin
                op_loadstore = MEM_LOADSTORE_LOAD;
            end else if (random_mode == 2) begin
                op_loadstore = MEM_LOADSTORE_STORE;
            end else if (random_mode == 3) begin
                op_loadstore = (($urandom_range(1, 0) == 0) ? MEM_LOADSTORE_LOAD : MEM_LOADSTORE_STORE);
            end else begin
                op_loadstore = (($urandom_range(1, 0) == 0) ? MEM_LOADSTORE_LOAD : MEM_LOADSTORE_STORE);
            end
            op_opsize    = mem_opsize_e'($urandom_range(2, 0));
            if (random_mode == 4) op_opsize = MEM_OPSIZE_WORD;
            op_extmode   = mem_extendmode_e'($urandom_range(1, 0));
            op_imm       = 32'h0;

            // A random mask.
            op_mask = '0;
            for (int i = 0; i < N_THREADS; i++) begin
                if ($urandom_range(3, 0) != 0) op_mask[i] = 1'b1;
            end
            if (op_mask == '0) op_mask[0] = 1'b1;
            if (random_mode == 3) begin
                op_mask = '0;
                op_mask[$urandom_range(N_THREADS-1, 0)] = 1'b1;
            end

            // The addresses: sometimes spread out, sometimes on one bank.
            case ($urandom_range(3, 0))
                0: begin // one thread per bank
                    for (int i = 0; i < N_THREADS; i++) begin
                        op_rs1[i] = {7'h0, 5'(i), 12'h0};
                        op_rs1[i][1:0] = random_align();
                    end
                end
                1: begin // all on one bank
                    for (int i = 0; i < N_THREADS; i++) begin
                        op_rs1[i] = 32'h0;
                        op_rs1[i][1:0] = random_align();
                    end
                end
                2: begin // all on the same address
                    for (int i = 0; i < N_THREADS; i++) begin
                        op_rs1[i] = 32'h0;
                        op_rs1[i][1:0] = random_align();
                    end
                end
                default: begin // spread out
                    for (int i = 0; i < N_THREADS; i++) begin
                        op_rs1[i] = random_spad_addr();
                        op_rs1[i][1:0] = random_align();
                    end
                end
            endcase

            for (int i = 0; i < N_THREADS; i++) begin
                op_rs2[i] = $urandom();
            end

            run_op($sformatf("random %0d", iter));

            // Read back the words the operation touched, so that a store
            // that went to the wrong place is caught right away.
            if (readback) begin
                for (int i = 0; i < N_THREADS; i++) begin
                    if (op_mask[i]) begin
                        addr = op_rs1[i] + op_imm;
                        check_word(spad_bank_of(addr), spad_offset_of(addr),
                                  $sformatf("random %0d", iter));
                    end
                end
            end
        end

        // -- 7: byte and half stores across offsets and alignments ------------
        $display("[TEST 7] byte and half stores across offsets and alignments");
        op_loadstore = MEM_LOADSTORE_STORE;
        op_extmode   = MEM_EXTENDMODE_ZERO;
        op_imm       = 32'h0;
        op_mask      = '1;
        for (int o = 0; o < 8; o++) begin
            for (int a = 0; a < 4; a++) begin
                // One thread per bank, each storing at the same offset but a
                // different alignment.
                for (int i = 0; i < N_THREADS; i++) begin
                    op_rs1[i] = addr_of(i, o) | 32'(a);
                    op_rs2[i] = 32'hA0 + 32'(i);
                end
                // The size follows the alignment: a half may only be
                // stored at alignment 0 or 2, and a word only at alignment
                // 0. Anything else is not an access the design has.
                if (a % 2 == 0) begin
                    op_opsize = MEM_OPSIZE_HALF;
                end else begin
                    op_opsize = MEM_OPSIZE_BYTE;
                end
                run_op($sformatf("test 7 o%0d a%0d", o, a));
                for (int i = 0; i < N_THREADS; i++) begin
                    check_word(i, o, $sformatf("test 7 o%0d a%0d", o, a));
                end
            end
        end

        // -- 8: back pressure on the result ------------------------------------
        $display("[TEST 8] back pressure");
        op_loadstore = MEM_LOADSTORE_LOAD;
        op_opsize    = MEM_OPSIZE_WORD;
        op_extmode   = MEM_EXTENDMODE_SIGN;
        op_mask      = '1;
        for (int i = 0; i < N_THREADS; i++) begin
            op_rs1[i] = {7'h0, 5'(i), 12'h0};
            op_rs2[i] = '0;
        end
        stall_cycles = 5;
        run_op("test 8");
        stall_cycles = 0;

        $display("");
        $display("=================================================");
        $display(" tb_fu_lsu: %0d checks, %0d failures", checks, errors);
        if (errors == 0) begin
            $display(" RESULT: PASS");
        end else begin
            $display(" RESULT: FAIL");
        end
        $display("=================================================");
        $finish;
    end

    // A timeout, so a hang does not look like a pass.
    initial begin
        #200_000_000;
        $display("");
        $display(" tb_fu_lsu: TIMEOUT");
        $display("=================================================");
        $display(" tb_fu_lsu: %0d checks, %0d failures", checks, errors);
        $display(" RESULT: FAIL");
        $finish;
    end

endmodule

`default_nettype wire
