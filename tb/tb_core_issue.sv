// =============================================================================
// tb_core_issue.sv — Self-checking testbench for src/core_issue.sv
// =============================================================================
//
// What is verified
// ----------------
//   * Fetch / decode / register-access / dispatch ordering: dispatched
//     operations arrive in program order, carrying the correct pc, warp id,
//     thread mask, decoded instruction and register-file operand data.
//   * Instruction decode: the word decoded for a given pc is the program word at
//     that pc, and it stays stable across stalls.
//   * Register-access / scoreboard interface: the register-file read addresses,
//     the scoreboard check ports and the acquire port mirror the instruction in
//     register access (index / regfile / enable), the acquire sequence number
//     walks in step with the program, and a busy register stalls the stage
//     without dropping or duplicating an instruction.
//   * Function-unit handshake: one-hot valid, operation held stable while the
//     FU is not ready, exactly one dispatch per instruction on resume.
//   * No unknown (`X`) values ever reach a dispatched operation.
//
// How it is modelled
// ------------------
//   * The DUT is driven only through its ports. The environment it talks to
//     (IROM, register file, scoreboard, FUs) is modelled in this file:
//       - IROM model: one-cycle synchronous read, same latency as src/irom.sv.
//       - RF model : one-cycle read, x0 reads as zero, operand payload encodes
//                    (regfile, warp, index, thread) so the datapath can be
//                    followed end-to-end.
//       - SB model : a per-(warp,regfile,idx) busy table the TB can poke; it
//                    also mirrors the real scoreboard's x0 special-casing.
//       - FU model : `fu_in_ready_i` is TB-controlled to inject back-pressure.
//   * A second `control_unit` instance per stage acts as a golden decoder. Each
//     is fed the program word at the pc the DUT itself claims to be working on,
//     so the checks validate that core_issue routes a correctly-decoded
//     instruction through its stages — independent of any given ISA behaviour.
//
// Notes
// -----
//   * `warp_scheduler` free-runs across all 64 warps and thread schedulers for
//     inactive warps still present pc 0, so a single-warp stream is obtained by
//     forcing the warp scheduler to warp 0. Comment out the `force` in
//     `initial` to watch the natural round-robin instead.
//
// slang lint_off unconnected-input-port
// slang lint_off unconnected-output-port

`timescale 1ns/1ps
`default_nettype none

module tb_core_issue;
    import params_pkg::*;
    import control_unit_pkg::*;
    import fu_pkg::*;
    import tb_config_pkg::RST_CYCLES;

    // -----------------------------------------------------------------------
    // Clock / reset
    // -----------------------------------------------------------------------
    logic clk   = 1'b0;
    logic rst_n = 1'b0;
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // Optional waveform dump
    //
    // Compile with tracing enabled to get a waveform: add
    //   --trace-fst --trace-structs -DWAVE
    // to the build. The dump is written to sim/tb_core_issue.fst
    // (sim/ is git-ignored).
    // -----------------------------------------------------------------------
`ifdef WAVE
    initial begin
        $dumpfile("sim/tb_core_issue.fst");
        $dumpvars(0, tb_core_issue);
    end
`endif

    // -----------------------------------------------------------------------
    // Instruction program (word addressed, 32-bit instructions)
    // -----------------------------------------------------------------------
    localparam int IROM_SIZE  = 256;                 // bytes
    localparam int W_IROM_ADDR = $clog2(IROM_SIZE);
    localparam int PROG_WORDS  = IROM_SIZE / ADDR_ALIGN;

    localparam logic [31:0] NOP = 32'h0000_0013;     // addi x0, x0, 0

    logic [31:0] prog_r [0:PROG_WORDS-1];

    // Defined fallback keeps X out of the decode path during pipeline fill.
    function automatic logic [31:0] prog_at(pc_t pc);
        if ($isunknown(pc) || (int'(pc) >= PROG_WORDS))
            return NOP;
        return prog_r[int'(pc)];
    endfunction

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic [N_FUNCTION_UNITS-1:0] fu_in_ready_i;
    logic [N_FUNCTION_UNITS-1:0] fu_in_valid_o;
    operation_s                  fu_in_operation_o;

    logic [W_IROM_ADDR-1:Z_PC] instr_addr_o;
    logic [RLEN-1:0]           undec_instr32_i;

    warp_id_t rf_read_warp_id_o;
    reg_id_t      rf_rs1_idx_o, rf_rs2_idx_o, rf_rs3_idx_o;
    regfile_sel_e rf_rs1_regfile_o, rf_rs2_regfile_o, rf_rs3_regfile_o;
    simd_data_t   rf_rs1_data_i, rf_rs2_data_i, rf_rs3_data_i;

    warp_id_t sb_warp_id_o;
    reg_id_t      sb_chk1_idx_o, sb_chk2_idx_o, sb_chk3_idx_o, sb_acq_idx_o;
    regfile_sel_e sb_chk1_regfile_o, sb_chk2_regfile_o, sb_chk3_regfile_o, sb_acq_regfile_o;
    logic         sb_chk1_en_o, sb_chk2_en_o, sb_chk3_en_o, sb_acq_en_o;
    seq_t         sb_acq_seq_o;
    logic         sb_chk1_busy_i, sb_chk2_busy_i, sb_chk3_busy_i;

    core_issue #(.IROM_SIZE(IROM_SIZE)) dut (
        .clk(clk),
        .rst_n(rst_n),

        .fu_in_ready_i(fu_in_ready_i),
        .fu_in_valid_o(fu_in_valid_o),
        .fu_in_operation_o(fu_in_operation_o),

        .instr_addr_o(instr_addr_o),
        .undec_instr32_i(undec_instr32_i),

        .rf_read_warp_id_o(rf_read_warp_id_o),
        .rf_rs1_idx_o(rf_rs1_idx_o), .rf_rs1_regfile_o(rf_rs1_regfile_o), .rf_rs1_data_i(rf_rs1_data_i),
        .rf_rs2_idx_o(rf_rs2_idx_o), .rf_rs2_regfile_o(rf_rs2_regfile_o), .rf_rs2_data_i(rf_rs2_data_i),
        .rf_rs3_idx_o(rf_rs3_idx_o), .rf_rs3_regfile_o(rf_rs3_regfile_o), .rf_rs3_data_i(rf_rs3_data_i),

        .sb_warp_id_o(sb_warp_id_o),
        .sb_chk1_idx_o(sb_chk1_idx_o), .sb_chk1_regfile_o(sb_chk1_regfile_o), .sb_chk1_en_o(sb_chk1_en_o), .sb_chk1_busy_i(sb_chk1_busy_i),
        .sb_chk2_idx_o(sb_chk2_idx_o), .sb_chk2_regfile_o(sb_chk2_regfile_o), .sb_chk2_en_o(sb_chk2_en_o), .sb_chk2_busy_i(sb_chk2_busy_i),
        .sb_chk3_idx_o(sb_chk3_idx_o), .sb_chk3_regfile_o(sb_chk3_regfile_o), .sb_chk3_en_o(sb_chk3_en_o), .sb_chk3_busy_i(sb_chk3_busy_i),
        .sb_acq_idx_o(sb_acq_idx_o), .sb_acq_regfile_o(sb_acq_regfile_o), .sb_acq_seq_o(sb_acq_seq_o), .sb_acq_en_o(sb_acq_en_o)
    );

    // -----------------------------------------------------------------------
    // IROM model — one-cycle synchronous read (matches src/irom.sv)
    // -----------------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (!rst_n) undec_instr32_i <= NOP;   // keep X out of the decode path
        else        undec_instr32_i <= $isunknown(instr_addr_o) ? NOP : prog_r[instr_addr_o];
    end

    // -----------------------------------------------------------------------
    // Register-file model — one-cycle read, x0 reads as zero.
    // Payload encodes (regfile, warp, index, thread) so operand routing is
    // observable.
    // -----------------------------------------------------------------------
    function automatic simd_data_t rf_data_of(reg_id_t idx, regfile_sel_e rf, warp_id_t w);
        simd_data_t d;
        if (idx == 0 && rf == REGFILE_SEL_I)
            return '0;
        for (int t = 0; t < N_THREADS; t++)
            d[t] = {9'b0, 8'(rf), 6'(w), 6'(idx), 3'(t)};
        return d;
    endfunction

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            rf_rs1_data_i <= '0;
            rf_rs2_data_i <= '0;
            rf_rs3_data_i <= '0;
        end else begin
            rf_rs1_data_i <= rf_data_of(rf_rs1_idx_o, rf_rs1_regfile_o, rf_read_warp_id_o);
            rf_rs2_data_i <= rf_data_of(rf_rs2_idx_o, rf_rs2_regfile_o, rf_read_warp_id_o);
            rf_rs3_data_i <= rf_data_of(rf_rs3_idx_o, rf_rs3_regfile_o, rf_read_warp_id_o);
        end
    end

    // -----------------------------------------------------------------------
    // Scoreboard model — a busy table the TB can poke, plus x0 special-casing.
    // -----------------------------------------------------------------------
    logic busy_r [0:N_WARPS-1][0:N_REGFILES-1][0:N_REGISTERS-1];

    always_comb begin
        sb_chk1_busy_i = sb_chk1_en_o
            && !(sb_chk1_idx_o == 0 && sb_chk1_regfile_o == REGFILE_SEL_I)
            && busy_r[sb_warp_id_o][sb_chk1_regfile_o][sb_chk1_idx_o];
        sb_chk2_busy_i = sb_chk2_en_o
            && !(sb_chk2_idx_o == 0 && sb_chk2_regfile_o == REGFILE_SEL_I)
            && busy_r[sb_warp_id_o][sb_chk2_regfile_o][sb_chk2_idx_o];
        sb_chk3_busy_i = sb_chk3_en_o
            && !(sb_chk3_idx_o == 0 && sb_chk3_regfile_o == REGFILE_SEL_I)
            && busy_r[sb_warp_id_o][sb_chk3_regfile_o][sb_chk3_idx_o];
    end

    // -----------------------------------------------------------------------
    // Golden decoders — decode the program word at the pc the DUT is using.
    // One per DUT pipeline stage that exposes a decoded instruction / pc.
    // -----------------------------------------------------------------------
    logic [31:2] id_ref_word_w;
    logic [31:2] ra_ref_word_w;
    logic [31:2] dp_ref_word_w;
    assign id_ref_word_w = prog_at(dut.id_pc_r)[31:2];
    assign ra_ref_word_w = prog_at(dut.ra_pc_r)[31:2];
    assign dp_ref_word_w = prog_at(fu_in_operation_o.pc)[31:2];

    instr_s id_ref_instr;
    instr_s ra_ref_instr;
    instr_s dp_ref_instr;

    control_unit u_ref_id (
`ifndef SYNTHESIS
        .sim__runasserts_i(1'b0),
`endif
        .undec_instr32_i(id_ref_word_w),
        .pc_i(dut.id_pc_r),
        .instr_o(id_ref_instr)
    );

    control_unit u_ref_ra (
`ifndef SYNTHESIS
        .sim__runasserts_i(1'b0),
`endif
        .undec_instr32_i(ra_ref_word_w),
        .pc_i(dut.ra_pc_r),
        .instr_o(ra_ref_instr)
    );

    control_unit u_ref_dp (
`ifndef SYNTHESIS
        .sim__runasserts_i(1'b0),
`endif
        .undec_instr32_i(dp_ref_word_w),
        .pc_i(fu_in_operation_o.pc),
        .instr_o(dp_ref_instr)
    );

    // -----------------------------------------------------------------------
    // Bookkeeping
    // -----------------------------------------------------------------------
    int checks    = 0;
    int errors    = 0;
    int dispatches = 0;

    int  exp_pc   = 0;   // next pc expected on a dispatch
    int  exp_seq  = 0;   // next sequence number expected on a dispatch
    bit  warp_forced = 1'b0;

    // Per-scenario bookkeeping (declared up front because the tasks below use
    // them).
    int  disp_base   = 0;
    int  disp_before = 0;
    operation_s held_op;
    bit  wait_ok;

    task automatic fail(input string label);
        errors++;
        $display("  [FAIL] %s", label);
    endtask

    // -----------------------------------------------------------------------
    // Per-cycle checker
    // -----------------------------------------------------------------------
    logic       prev_valid;
    logic       prev_stalled;
    operation_s prev_op;

    initial begin
        prev_valid   = 1'b0;
        prev_stalled = 1'b0;
        prev_op      = '0;
    end

    always @(negedge clk) begin
        operation_s opw;
        instr_s     raref;
        logic       handshake;

        if (!rst_n) begin
            prev_valid   <= 1'b0;
            prev_stalled <= 1'b0;
            prev_op      <= '0;
        end else begin
            // ---------------- Dispatch / function-unit interface ----------------
            opw = fu_in_operation_o;

            if (fu_in_valid_o !== '0) begin
                if (!$onehot(fu_in_valid_o))
                    fail($sformatf("fu_in_valid_o is not one-hot (%b)", fu_in_valid_o));

                if ($isunknown(opw))
                    fail("dispatched operation contains X");

                checks++;
                if (warp_forced && opw.warp_id !== '0)
                    fail($sformatf("dispatch warp_id=%0d (expected 0)", opw.warp_id));

                checks++;
                if (opw.mask !== '1)
                    fail($sformatf("dispatch mask=%b (expected all-ones)", opw.mask));

                checks++;
                if (int'(opw.pc) >= PROG_WORDS)
                    fail($sformatf("dispatch pc=%0d out of program range", opw.pc));

                // Decoded instruction must match the golden decoder for op.pc.
                checks++;
                if (opw.instr !== dp_ref_instr)
                    fail($sformatf("pc=%0d instruction mismatch (rd=%0d rs1=%0d rs2=%0d rs3=%0d fu=%0d)",
                                   opw.pc, opw.instr.rd_idx, opw.instr.rs1_idx, opw.instr.rs2_idx,
                                   opw.instr.rs3_idx, opw.instr.fu_sel));

                // Valid bit must target exactly the instruction's function unit.
                checks++;
                if (fu_in_valid_o[dp_ref_instr.fu_sel] !== 1'b1)
                    fail($sformatf("pc=%0d valid bit does not match fu_sel=%0d",
                                   opw.pc, dp_ref_instr.fu_sel));

                // Operand data must equal the register-file model's output for
                // this instruction's source registers. Unused operands are
                // don't-care and are not checked.
                if (dp_ref_instr.rs1_used) begin
                    checks++;
                    if (opw.rs1_data !== rf_data_of(dp_ref_instr.rs1_idx, dp_ref_instr.rs1_regfile, opw.warp_id))
                        fail($sformatf("pc=%0d rs1_data mismatch (%h != %h)", opw.pc, opw.rs1_data,
                                       rf_data_of(dp_ref_instr.rs1_idx, dp_ref_instr.rs1_regfile, opw.warp_id)));
                end
                if (dp_ref_instr.rs2_used) begin
                    checks++;
                    if (opw.rs2_data !== rf_data_of(dp_ref_instr.rs2_idx, dp_ref_instr.rs2_regfile, opw.warp_id))
                        fail($sformatf("pc=%0d rs2_data mismatch (%h != %h)", opw.pc, opw.rs2_data,
                                       rf_data_of(dp_ref_instr.rs2_idx, dp_ref_instr.rs2_regfile, opw.warp_id)));
                end
                if (dp_ref_instr.rs3_used) begin
                    checks++;
                    if (opw.rs3_data !== rf_data_of(dp_ref_instr.rs3_idx, dp_ref_instr.rs3_regfile, opw.warp_id))
                        fail($sformatf("pc=%0d rs3_data mismatch (%h != %h)", opw.pc, opw.rs3_data,
                                       rf_data_of(dp_ref_instr.rs3_idx, dp_ref_instr.rs3_regfile, opw.warp_id)));
                end

                handshake = fu_in_ready_i[dp_ref_instr.fu_sel];

                if (handshake) begin
                    checks++;
                    if (int'(opw.pc) !== exp_pc)
                        fail($sformatf("dispatch out of order: pc=%0d expected pc=%0d",
                                       opw.pc, exp_pc));
                    checks++;
                    if (int'(opw.seq) !== exp_seq)
                        fail($sformatf("sequence mismatch at pc=%0d: seq=%0d expected %0d",
                                       opw.pc, opw.seq, exp_seq));
                    exp_pc  = int'(opw.pc) + 1;
                    exp_seq = int'(opw.seq) + 1;
                    dispatches++;
                end
            end

            // ---------------- Instruction Decode ----------------
            // The decoded instruction presented to the register-access stage must
            // be the program word at the pc decode claims to hold. Decode must
            // keep this stable across stalls.
            if (dut.id_stage_valid_r) begin
                checks++;
                if (dut.id_instr_w !== id_ref_instr)
                    fail($sformatf("ID decode mismatch at pc=%0d: decoded %08x, expected %08x",
                                   dut.id_pc_r, {dut.id_undec_instr32_w, 2'b00},
                                   prog_at(dut.id_pc_r)));
            end

            // ---------------- Register Access / scoreboard interface ----------------
            if (dut.ra_stage_valid_r) begin
                raref = ra_ref_instr;

                // The instruction entering register access must match decode of
                // its own pc.
                checks++;
                if (dut.ra_instr_r !== raref)
                    fail($sformatf("RA instruction mismatch at pc=%0d", dut.ra_pc_r));

                // Register-file read addresses mirror the instruction.
                checks++;
                if (rf_rs1_idx_o !== raref.rs1_idx || rf_rs1_regfile_o !== raref.rs1_regfile)
                    fail($sformatf("rf_rs1 address mismatch at pc=%0d", dut.ra_pc_r));
                checks++;
                if (rf_rs2_idx_o !== raref.rs2_idx || rf_rs2_regfile_o !== raref.rs2_regfile)
                    fail($sformatf("rf_rs2 address mismatch at pc=%0d", dut.ra_pc_r));
                checks++;
                if (rf_rs3_idx_o !== raref.rs3_idx || rf_rs3_regfile_o !== raref.rs3_regfile)
                    fail($sformatf("rf_rs3 address mismatch at pc=%0d", dut.ra_pc_r));
                checks++;
                if (rf_read_warp_id_o !== dut.ra_warp_id_r)
                    fail($sformatf("rf_read_warp_id mismatch at pc=%0d", dut.ra_pc_r));

                // Scoreboard check ports mirror the instruction, gated by usage.
                checks++;
                if (sb_chk1_idx_o !== raref.rs1_idx || sb_chk1_regfile_o !== raref.rs1_regfile
                    || sb_chk1_en_o !== raref.rs1_used)
                    fail($sformatf("sb_chk1 mismatch at pc=%0d", dut.ra_pc_r));
                checks++;
                if (sb_chk2_idx_o !== raref.rs2_idx || sb_chk2_regfile_o !== raref.rs2_regfile
                    || sb_chk2_en_o !== raref.rs2_used)
                    fail($sformatf("sb_chk2 mismatch at pc=%0d", dut.ra_pc_r));
                checks++;
                if (sb_chk3_idx_o !== raref.rs3_idx || sb_chk3_regfile_o !== raref.rs3_regfile
                    || sb_chk3_en_o !== raref.rs3_used)
                    fail($sformatf("sb_chk3 mismatch at pc=%0d", dut.ra_pc_r));

                checks++;
                if (dut.ra_sb_busy_w !== (sb_chk1_busy_i | sb_chk2_busy_i | sb_chk3_busy_i))
                    fail("ra_sb_busy_w does not equal the OR of the check ports");

                // Acquire port mirrors the instruction, gated by hazard / rd usage.
                checks++;
                if (sb_acq_idx_o !== raref.rd_idx || sb_acq_regfile_o !== raref.rd_regfile
                    || sb_acq_en_o !== (!dut.ra_sb_busy_w && raref.rd_used))
                    fail($sformatf("sb_acq mismatch at pc=%0d", dut.ra_pc_r));
                // The acquire sequence tags the instruction in register access.
                // With no branches the pc advances by one per instruction, so for
                // warp 0 the tag must equal the pc.
                checks++;
                if (sb_acq_seq_o !== dut.ra_pc_r)
                    fail($sformatf("sb_acq_seq mismatch at pc=%0d: seq=%0d", dut.ra_pc_r, sb_acq_seq_o));
                checks++;
                if (sb_warp_id_o !== dut.ra_warp_id_r)
                    fail($sformatf("sb_warp_id mismatch at pc=%0d", dut.ra_pc_r));

                // A busy operand must stall register access.
                checks++;
                if (dut.ra_sb_busy_w && !dut.ra_stage_stall_w)
                    fail($sformatf("scoreboard busy did not stall register access at pc=%0d", dut.ra_pc_r));

                // Acquiring a busy register must not happen.
                checks++;
                if (dut.ra_sb_busy_w && sb_acq_en_o)
                    fail($sformatf("acquire asserted while scoreboard busy at pc=%0d", dut.ra_pc_r));
            end

            // ---------------- Back-pressure stability ----------------
            if (prev_valid && prev_stalled) begin
                checks++;
                if (fu_in_valid_o === '0)
                    fail("valid dropped while FU was not ready");
                checks++;
                if (fu_in_operation_o.instr !== prev_op.instr
                    || fu_in_operation_o.pc !== prev_op.pc
                    || fu_in_operation_o.seq !== prev_op.seq)
                    fail("operation changed while FU was not ready");
            end

            prev_valid   <= (fu_in_valid_o !== '0);
            prev_op      <= opw;
            prev_stalled <= (fu_in_valid_o !== '0) && !fu_in_ready_i[dp_ref_instr.fu_sel]
                            && (fu_in_valid_o[dp_ref_instr.fu_sel] === 1'b1);
        end
    end

    // -----------------------------------------------------------------------
    // Stimulus helpers
    // -----------------------------------------------------------------------
    task automatic do_reset();
        rst_n = 1'b0;
        repeat (RST_CYCLES) @(posedge clk);
        @(negedge clk);
        #1 rst_n = 1'b1;
        exp_pc  = 0;
        exp_seq = 0;
    endtask

    // Run until `n` more dispatches have happened since `disp_base`, with a
    // bounded watchdog.
    task automatic run_more(input int n, input int timeout, output bit ok);
        ok = 1'b0;
        for (int i = 0; i < timeout; i++) begin
            @(negedge clk);
            if (dispatches >= disp_base + n) begin
                ok = 1'b1;
                break;
            end
        end
        if (!ok)
            fail($sformatf("watchdog: only %0d/%0d dispatches observed",
                           dispatches - disp_base, n));
    endtask

    // -----------------------------------------------------------------------
    // Test body
    // -----------------------------------------------------------------------
    initial begin
        // ---------------- Program (instructions the simplified CU knows) ----------------
        for (int i = 0; i < PROG_WORDS; i++) prog_r[i] = NOP;
        prog_r[0]  = 32'h00100093;   // addi  x1,  x0, 1
        prog_r[1]  = 32'h00200113;   // addi  x2,  x0, 2
        prog_r[2]  = 32'h00408193;   // addi  x3,  x1, 4
        prog_r[3]  = 32'h00208233;   // add   x4,  x1, x2
        prog_r[4]  = 32'h403202b3;   // sub   x5,  x4, x3   (rs1 = x4)
        prog_r[5]  = 32'h00524333;   // xor   x6,  x4, x5
        prog_r[6]  = 32'h001363b3;   // or    x7,  x6, x1
        prog_r[7]  = 32'h0023f433;   // and   x8,  x7, x2
        prog_r[8]  = 32'h003414b3;   // sll   x9,  x8, x3
        prog_r[9]  = 32'h0014d533;   // srl   x10, x9, x1
        prog_r[10] = 32'h4024d5b3;   // sra   x11, x9, x2
        prog_r[11] = 32'h00000617;   // auipc x12, 0
        prog_r[12] = 32'h123456b7;   // lui   x13, 0x12345
        prog_r[13] = 32'h0020a733;   // slt   x14, x1, x2
        prog_r[14] = 32'h0020b7b3;   // sltu  x15, x1, x2
        prog_r[15] = 32'hfff00813;   // addi  x16, x0, -1
        prog_r[16] = 32'h00399a13;   // slli  x20, x19, 3
        prog_r[17] = 32'h001a5a93;   // srli  x21, x20, 1
        prog_r[18] = 32'h402adb13;   // srai  x22, x21, 2
        prog_r[19] = 32'h2020ac33;   // sh1add x24, x1, x2

        // ---------------- Initial conditions ----------------
        fu_in_ready_i = '1;
        for (int w = 0; w < N_WARPS; w++)
            for (int f = 0; f < N_REGFILES; f++)
                for (int r = 0; r < N_REGISTERS; r++)
                    busy_r[w][f][r] = 1'b0;

        // Pin the warp scheduler to warp 0 for a deterministic single stream.
        #1 force dut.u_warp_scheduler.current_warp_r = '0;
        warp_forced = 1'b1;

        // ===================================================================
        $display("\n== A. Reset — no issue while rst_n is low ==");
        // ===================================================================
        rst_n = 1'b0;
        repeat (RST_CYCLES) begin
            @(negedge clk);
            #1;
            checks++;
            if (fu_in_valid_o !== '0)
                fail("fu_in_valid_o asserted during reset");
            checks++;
            if (sb_acq_en_o !== 1'b0)
                fail("sb_acq_en_o asserted during reset");
        end
        @(negedge clk);
        #1 rst_n = 1'b1;
        exp_pc = 0; exp_seq = 0;
        disp_base = dispatches;

        // ===================================================================
        $display("\n== B. Streaming issue (FU always ready, no hazards) ==");
        // ===================================================================
        run_more(12, 200, wait_ok);
        $display("  dispatched %0d instructions, exp_pc=%0d", dispatches - disp_base, exp_pc);

        // ===================================================================
        $display("\n== C. Scoreboard hazard stalls register access, then resumes ==");
        // ===================================================================
        do_reset();
        disp_base   = dispatches;
        disp_before = dispatches;
        busy_r[0][REGFILE_SEL_I][4] = 1'b1;   // x4 is busy (backend has not released it)

        // Wait until register access actually reports the hazard.
        wait_ok = 1'b0;
        for (int i = 0; i < 200; i++) begin
            @(negedge clk);
            if (dut.ra_sb_busy_w) begin wait_ok = 1'b1; break; end
        end
        checks++;
        if (!wait_ok) begin
            fail("never observed a scoreboard-busy stall");
        end else begin
            checks++;
            if (!dut.ra_stage_stall_w)
                fail("register-access stall not asserted while scoreboard busy");
            // Let the dispatch stage drain, then confirm issue has stopped.
            repeat (3) @(negedge clk);
            disp_before = dispatches;
            repeat (3) @(negedge clk);
            checks++;
            if (dispatches != disp_before)
                fail($sformatf("dispatch advanced while scoreboard busy (%0d -> %0d)",
                               disp_before, dispatches));
        end

        // Release the hazard; the stalled instruction must complete exactly once.
        busy_r[0][REGFILE_SEL_I][4] = 1'b0;
        run_more(8, 200, wait_ok);

        // ===================================================================
        $display("\n== D. FU back-pressure holds the operation ==");
        // ===================================================================
        do_reset();
        disp_base = dispatches;
        run_more(4, 200, wait_ok);

        // Change `fu_in_ready_i` at the start of a cycle so it is stable for the
        // whole cycle. Changing it on a negedge can race the negedge monitor.
        @(posedge clk);
        #1 held_op = fu_in_operation_o;
        fu_in_ready_i = '0;
        disp_before = dispatches;
        repeat (4) @(negedge clk);
        checks++;
        if (dispatches != disp_before)
            fail($sformatf("dispatch occurred while FU not ready (%0d -> %0d)",
                           disp_before, dispatches));
        checks++;
        if (fu_in_valid_o === '0)
            fail("valid deasserted while waiting for FU");
        checks++;
        if (fu_in_operation_o.pc !== held_op.pc || fu_in_operation_o.seq !== held_op.seq)
            fail("held operation changed while FU not ready");

        fu_in_ready_i = '1;
        run_more(6, 200, wait_ok);

        // ===================================================================
        // Summary
        // ===================================================================
        $display("\n=================================================");
        $display(" core_issue TB: %0d checks, %0d failures, %0d dispatches",
                 checks, errors, dispatches);
        if (errors == 0)
            $display(" RESULT: PASS");
        else
            $display(" RESULT: FAIL (%0d checks failed)", errors);
        $display("=================================================\n");

        $finish;
    end

    // Watchdog: never let the simulation run forever.
    initial begin
        #200000;
        $display("\n  [FAIL] global simulation timeout");
        $display(" core_issue TB: %0d checks, %0d failures, %0d dispatches",
                 checks, errors + 1, dispatches);
        $display(" RESULT: FAIL (timeout)\n");
        $finish;
    end

endmodule

`default_nettype wire
