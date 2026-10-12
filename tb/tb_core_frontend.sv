// =============================================================================
// tb_core_frontend.sv — Self-checking testbench for src/core_frontend.sv
// =============================================================================
//
// What is verified
// ----------------
//   * Fetch / decode / register-access / dispatch ordering: dispatched
//     operations arrive in program order, carrying the correct pc, warp id,
//     thread mask, decoded instruction and register-file operand data.
//   * Instruction decode: the word decoded for a given pc is the program word at
//     that pc, including after the instruction is replayed.
//   * Register-access / scoreboard interface: the register-file read addresses,
//     the scoreboard check ports and the acquire port mirror the instruction in
//     register access, the acquire sequence number walks in step with the
//     program, and a busy register flushes the stage so the instruction is
//     replayed, without dropping or duplicating a dispatch.
//   * Function-unit handshake (stall-less): one-hot valid, exactly one dispatch
//     per instruction. Back-pressure is handled by replay, not by holding: an
//     operation whose FU is not ready is abandoned (flushed) and replayed later.
//   * Acquire rollback: when a register-access / dispatch instruction is flushed
//     it must drop the scoreboard entry it acquired, restoring the busy/seq
//     state captured at acquire time. This is what stops a replayed instruction
//     that reads and writes the same resource (rd == rs, or a CKAQ hazard) from
//     waiting on its own acquire forever.
//   * No unknown (`X`) values ever reach a dispatched operation.
//
// How it is modelled
// ------------------
//   * The DUT is driven only through its ports. The environment it talks to
//     (IROM, register file, scoreboards) is modelled in this file:
//       - IROM model: one-cycle synchronous read, same latency as src/irom.sv.
//       - RF model : one-cycle read, x0 reads as zero, operand payload encodes
//                    (regfile, warp, index, thread) so the datapath can be
//                    followed end-to-end.
//       - SB model : the *real* src/scoreboard.sv and src/scoreboard_mask.sv
//                    modules are instantiated and wired to the DUT, so the
//                    acquire/rollback/release protocol is exercised for real.
//                    The register scoreboard gets an extra TB-driven acquire
//                    port (to poke a busy entry) and a TB-driven release port
//                    (the front-end has no release; the back-end does).
//       - FU model : `fu_in_ready_i` is TB-controlled to inject back-pressure.
//   * A second `control_unit` instance per stage acts as a golden decoder. Each
//     is fed the program word at the pc the DUT itself claims to be working on,
//     so the checks validate that core_frontend routes a correctly-decoded
//     instruction through its stages — independent of any given ISA behaviour.
//   * The front-end pipeline is stall-less: a stage never holds an instruction.
//     When a stage cannot proceed — register access sees a busy scoreboard
//     operand, or the dispatch stage's FU is not ready — the offending
//     instruction (and any younger instructions of the same warp behind it)
//     fail, and the per-warp pc/sequence are rolled back so exactly those
//     instructions are replayed on later cycles. This TB therefore checks for
//     flush-and-replay, not for operations held across a stall.
//
// Notes
// -----
//   * `warp_scheduler` free-runs across all 64 warps, so a single-warp stream is
//     obtained by forcing the scheduler's round-robin state to warp 0.
//   * Branching is currently disabled in the RTL, so the branch interface is
//     tied off.

// slang lint_off unconnected-input-port
// slang lint_off unconnected-output-port

`timescale 1ns/1ps
`default_nettype none

module tb_core_frontend;
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
    import tb_config_pkg::RST_CYCLES;

    // -----------------------------------------------------------------------
    // Clock / reset
    // -----------------------------------------------------------------------
    logic clk   = 1'b0;
    logic rst_n = 1'b0;
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // Optional waveform dump
    // -----------------------------------------------------------------------
`ifdef WAVE
    initial begin
        $dumpfile("sim/tb_core_frontend.fst");
        $dumpvars(0, tb_core_frontend);
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

    // `addi rd, x0, imm` — independent of all other registers.
    function automatic logic [31:0] enc_addi_x0(input logic [4:0] rd, input logic [11:0] imm);
        return {imm, 5'b0, 3'b0, rd, 7'b001_0011};
    endfunction

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic [N_FUNCTION_UNITS-1:0] fu_in_ready_i;
    logic [N_FUNCTION_UNITS-1:0] fu_in_valid_o;
    fu_operation_s                  fu_in_operation_o;

    logic [W_IROM_ADDR-1:Z_PC] instr_addr_o;
    logic [RLEN-1:0]           undec_instr32_i;

    warp_id_t rf_read_warp_id_o;
    reg_id_t      rf_rs1_idx_o, rf_rs2_idx_o, rf_rs3_idx_o;
    regfile_sel_e rf_rs1_regfile_o, rf_rs2_regfile_o, rf_rs3_regfile_o;
    simd_data_t   rf_rs1_data_i, rf_rs2_data_i, rf_rs3_data_i;

    // Register scoreboard interface
    warp_id_t     sb_warp_id_o;
    reg_id_t      sb_chk1_idx_o, sb_chk2_idx_o, sb_chk3_idx_o, sb_acq_idx_o;
    regfile_sel_e sb_chk1_regfile_o, sb_chk2_regfile_o, sb_chk3_regfile_o, sb_acq_regfile_o;
    logic         sb_chk1_en_o, sb_chk2_en_o, sb_chk3_en_o, sb_acq_en_o;
    seq_t         sb_acq_seq_o;
    logic         sb_chk1_busy_i, sb_chk2_busy_i, sb_chk3_busy_i;
    seq_t         sb_acq_old_seq_i;
    logic         sb_acq_old_busy_i;
    warp_id_t     sb_dacq_warp_id_o;
    reg_id_t      sb_dacq_idx_o;
    regfile_sel_e sb_dacq_regfile_o;
    seq_t         sb_dacq_seq_o;
    logic         sb_dacq_en_o, sb_dacq_empty_o;

    // Hazard scoreboard interface
    warp_id_t     hsb_warp_id_o;
    hazard_mask_t hsb_busy_i;
    hazard_mask_t hsb_acq_mask_o;
    seq_t         hsb_acq_seq_o;
    hazard_mask_t hsb_acq_old_busy_i;
    seq_t         hsb_acq_old_seq_i [0:N_HAZARDS-1];
    warp_id_t     hsb_dacq_warp_id_o;
    hazard_mask_t hsb_dacq_mask_o;
    seq_t         hsb_dacq_seq_o [0:N_HAZARDS-1];
    hazard_mask_t hsb_dacq_empty_o;

    // Branch interface (disabled)
    logic         branch_complete_i;
    simd_mask_t   branch_mask_i;
    branch_type_e branch_type_i;
    warp_id_t     branch_warp_id_i;
    pc_t          branch_pc_i, branch_target_i;

    core_frontend #(.IROM_SIZE(IROM_SIZE)) dut (
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

        .sb_acq_idx_o(sb_acq_idx_o), .sb_acq_regfile_o(sb_acq_regfile_o),
        .sb_acq_seq_o(sb_acq_seq_o), .sb_acq_en_o(sb_acq_en_o),
        .sb_acq_old_seq_i(sb_acq_old_seq_i), .sb_acq_old_busy_i(sb_acq_old_busy_i),

        .sb_dacq_warp_id_o(sb_dacq_warp_id_o),
        .sb_dacq_idx_o(sb_dacq_idx_o), .sb_dacq_regfile_o(sb_dacq_regfile_o),
        .sb_dacq_seq_o(sb_dacq_seq_o), .sb_dacq_en_o(sb_dacq_en_o), .sb_dacq_empty_o(sb_dacq_empty_o),

        .hsb_warp_id_o(hsb_warp_id_o),
        .hsb_busy_i(hsb_busy_i),
        .hsb_acq_mask_o(hsb_acq_mask_o), .hsb_acq_seq_o(hsb_acq_seq_o),
        .hsb_acq_old_busy_i(hsb_acq_old_busy_i), .hsb_acq_old_seq_i(hsb_acq_old_seq_i),

        .hsb_dacq_warp_id_o(hsb_dacq_warp_id_o),
        .hsb_dacq_mask_o(hsb_dacq_mask_o), .hsb_dacq_seq_o(hsb_dacq_seq_o), .hsb_dacq_empty_o(hsb_dacq_empty_o),

        .branch_complete_i(branch_complete_i), .branch_mask_i(branch_mask_i),
        .branch_type_i(branch_type_i), .branch_warp_id_i(branch_warp_id_i),
        .branch_pc_i(branch_pc_i), .branch_target_i(branch_target_i)
    );

    // -----------------------------------------------------------------------
    // Register scoreboard (real DUT) + TB poke / release ports
    // -----------------------------------------------------------------------
    localparam int RSB_N_CHK = 3;
    localparam int RSB_N_ACQ = 3;   // 0: DUT acquire, 1: DUT drop, 2: TB poke
    localparam int RSB_N_REL = 1;   // front-end never releases; the back-end does

    seq_t  rsb_acq_old_seq  [0:RSB_N_ACQ-1];
    logic  rsb_acq_old_busy [0:RSB_N_ACQ-1];
    logic  rsb_chk_busy     [0:RSB_N_CHK-1];
    logic  rsb_rel_valid    [0:RSB_N_REL-1];

    // TB poke acquire (busy a register without any instruction writing it)
    warp_id_t     rsb_poke_warp;
    reg_id_t      rsb_poke_idx;
    regfile_sel_e rsb_poke_regfile;
    seq_t         rsb_poke_seq;
    logic         rsb_poke_en, rsb_poke_empty;

    // TB release (models the back-end releasing a committed instruction)
    warp_id_t     rsb_rel_warp;
    reg_id_t      rsb_rel_idx;
    regfile_sel_e rsb_rel_regfile;
    seq_t         rsb_rel_seq;
    logic         rsb_rel_en;

    scoreboard #(
        .N_ENTRIES(N_WARPS * N_REGISTERS * N_REGFILES),
        .N_CHK_PORTS(RSB_N_CHK),
        .N_ACQ_PORTS(RSB_N_ACQ),
        .N_REL_PORTS(RSB_N_REL)
    ) u_rsb (
        .clk(clk),
        .rst_n(rst_n),

        .chk_id_i({
            {sb_warp_id_o, sb_chk1_idx_o, sb_chk1_regfile_o},
            {sb_warp_id_o, sb_chk2_idx_o, sb_chk2_regfile_o},
            {sb_warp_id_o, sb_chk3_idx_o, sb_chk3_regfile_o}
        }),
        .chk_en_i({sb_chk1_en_o, sb_chk2_en_o, sb_chk3_en_o}),
        .chk_busy_o(rsb_chk_busy),

        .acq_id_i({
            {sb_warp_id_o, sb_acq_idx_o, sb_acq_regfile_o},
            {sb_dacq_warp_id_o, sb_dacq_idx_o, sb_dacq_regfile_o},
            {rsb_poke_warp, rsb_poke_idx, rsb_poke_regfile}
        }),
        .acq_seq_i({sb_acq_seq_o, sb_dacq_seq_o, rsb_poke_seq}),
        .acq_en_i({sb_acq_en_o, sb_dacq_en_o, rsb_poke_en}),
        .acq_empty_i({1'b0, sb_dacq_empty_o, rsb_poke_empty}),
        .acq_old_seq_o(rsb_acq_old_seq),
        .acq_old_busy_o(rsb_acq_old_busy),

        .rel_id_i({{rsb_rel_warp, rsb_rel_idx, rsb_rel_regfile}}),
        .rel_seq_i({rsb_rel_seq}),
        .rel_en_i({rsb_rel_en}),
        .rel_valid_o(rsb_rel_valid)
    );

    assign sb_chk1_busy_i    = rsb_chk_busy[0];
    assign sb_chk2_busy_i    = rsb_chk_busy[1];
    assign sb_chk3_busy_i    = rsb_chk_busy[2];
    assign sb_acq_old_seq_i  = rsb_acq_old_seq[0];
    assign sb_acq_old_busy_i = rsb_acq_old_busy[0];

    // -----------------------------------------------------------------------
    // Hazard scoreboard (real DUT) + TB release port
    // -----------------------------------------------------------------------
    warp_id_t     hsb_rel_warp;
    hazard_mask_t hsb_rel_mask;
    seq_t         hsb_rel_seq;
    hazard_mask_t hsb_rel_valid;

    scoreboard_mask #(
        .N_GROUPS(N_WARPS),
        .N_ENTRIES(N_HAZARDS)
    ) u_hsb (
        .clk(clk),
        .rst_n(rst_n),

        .busy_group_id_i(hsb_warp_id_o),
        .busy_o(hsb_busy_i),

        .acq_group_id_i(hsb_warp_id_o),
        .acq_mask_i(hsb_acq_mask_o),
        .acq_seq_i(hsb_acq_seq_o),
        .acq_old_busy_o(hsb_acq_old_busy_i),
        .acq_old_seq_o(hsb_acq_old_seq_i),

        .dacq_group_id_i(hsb_dacq_warp_id_o),
        .dacq_mask_i(hsb_dacq_mask_o),
        .dacq_seq_i(hsb_dacq_seq_o),
        .dacq_empty_i(hsb_dacq_empty_o),

        .rel_group_id_i(hsb_rel_warp),
        .rel_mask_i(hsb_rel_mask),
        .rel_seq_i(hsb_rel_seq),
        .rel_valid_o(hsb_rel_valid)
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

    // Expected scoreboard check/acquire enable for an operand: the operand must
    // be used and must not be integer x0 (which is never busy / never acquired).
    function automatic logic sb_operand_en(input logic used, input reg_id_t idx, input regfile_sel_e rf);
        return used && !(idx == 0 && rf == REGFILE_SEL_I);
    endfunction

    // -----------------------------------------------------------------------
    // Golden decoders — decode the program word at the pc the DUT is using.
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

    int  sb_dacq_seen  = 0;   // cycles a register drop was issued
    int  hsb_dacq_seen = 0;   // cycles a hazard drop was issued

    int  exp_pc   = 0;   // next pc expected on a dispatch
    int  exp_seq  = 0;   // next sequence number expected on a dispatch
    bit  warp_forced = 1'b0;

    int  disp_base   = 0;
    int  disp_before = 0;
    int  replay_pc   = 0;
    bit  wait_ok;

    task automatic fail(input string label);
        errors++;
        $display("  [FAIL] %s", label);
    endtask

    // -----------------------------------------------------------------------
    // Per-cycle checker
    // -----------------------------------------------------------------------
    always @(negedge clk) begin
        fu_operation_s opw;
        instr_s     raref;
        logic       handshake;
        logic       exp_sb_dacq;
        hazard_mask_t exp_haz_dacq;

        if (rst_n) begin
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

                checks++;
                if (dut.ra_instr_r !== raref)
                    fail($sformatf("RA instruction mismatch at pc=%0d", dut.ra_pc_r));

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

                checks++;
                if (sb_chk1_idx_o !== raref.rs1_idx || sb_chk1_regfile_o !== raref.rs1_regfile
                    || sb_chk1_en_o !== sb_operand_en(raref.rs1_used, raref.rs1_idx, raref.rs1_regfile))
                    fail($sformatf("sb_chk1 mismatch at pc=%0d", dut.ra_pc_r));
                checks++;
                if (sb_chk2_idx_o !== raref.rs2_idx || sb_chk2_regfile_o !== raref.rs2_regfile
                    || sb_chk2_en_o !== sb_operand_en(raref.rs2_used, raref.rs2_idx, raref.rs2_regfile))
                    fail($sformatf("sb_chk2 mismatch at pc=%0d", dut.ra_pc_r));
                checks++;
                if (sb_chk3_idx_o !== raref.rs3_idx || sb_chk3_regfile_o !== raref.rs3_regfile
                    || sb_chk3_en_o !== sb_operand_en(raref.rs3_used, raref.rs3_idx, raref.rs3_regfile))
                    fail($sformatf("sb_chk3 mismatch at pc=%0d", dut.ra_pc_r));

                checks++;
                if (dut.ra_sb_busy_w !== (sb_chk1_busy_i | sb_chk2_busy_i | sb_chk3_busy_i))
                    fail("ra_sb_busy_w does not equal the OR of the check ports");

                checks++;
                if (sb_acq_idx_o !== raref.rd_idx || sb_acq_regfile_o !== raref.rd_regfile
                    || sb_acq_en_o !== (!dut.ra_sb_busy_w && sb_operand_en(raref.rd_used, raref.rd_idx, raref.rd_regfile)))
                    fail($sformatf("sb_acq mismatch at pc=%0d", dut.ra_pc_r));
                checks++;
                if (sb_acq_seq_o !== seq_t'(dut.ra_pc_r))
                    fail($sformatf("sb_acq_seq mismatch at pc=%0d: seq=%0d", dut.ra_pc_r, sb_acq_seq_o));
                checks++;
                if (sb_warp_id_o !== dut.ra_warp_id_r)
                    fail($sformatf("sb_warp_id mismatch at pc=%0d", dut.ra_pc_r));

                checks++;
                if (dut.ra_sb_busy_w && !dut.ra_stage_flush_w)
                    fail($sformatf("scoreboard busy did not flush register access at pc=%0d", dut.ra_pc_r));
                checks++;
                if (dut.ra_sb_busy_w && !dut.ra_stage_fail_w[dut.ra_warp_id_r])
                    fail($sformatf("scoreboard-busy instruction did not fail register access at pc=%0d", dut.ra_pc_r));
                checks++;
                if (dut.ra_sb_busy_w && sb_acq_en_o)
                    fail($sformatf("acquire asserted while scoreboard busy at pc=%0d", dut.ra_pc_r));
            end

            // ---------------- Acquire rollback wiring ----------------
            // The dispatch stage must drop the register it acquired exactly when
            // a valid instruction that used rd is flushed, restoring the state
            // captured at acquire time.
            exp_sb_dacq = dut.dp_stage_valid_r && dut.dp_stage_flush_w
                && dut.dp_instr_r.rd_used
                && !(dut.dp_instr_r.rd_idx == 0 && dut.dp_instr_r.rd_regfile == REGFILE_SEL_I);

            checks++;
            if (sb_dacq_en_o !== exp_sb_dacq)
                fail("sb_dacq_en_o does not match dispatch-stage flush with rd_used");

            if (sb_dacq_en_o) begin
                sb_dacq_seen++;
                checks++;
                if (sb_dacq_warp_id_o !== dut.dp_warp_id_r
                    || sb_dacq_idx_o !== dut.dp_instr_r.rd_idx
                    || sb_dacq_regfile_o !== dut.dp_instr_r.rd_regfile)
                    fail("sb_dacq target does not match the flushed dispatch instruction");
                checks++;
                if (sb_dacq_seq_o !== sb_acq_old_seq_i || sb_dacq_empty_o !== !sb_acq_old_busy_i)
                    fail("sb_dacq does not restore the captured old register state");
            end

            // Same for the hazard mask scoreboard: the drop mask must be the
            // AQ/CKAQ entries of the flushed dispatch instruction, restoring the
            // per-entry captured state.
            exp_haz_dacq = '0;
            if (dut.dp_stage_valid_r && dut.dp_stage_flush_w) begin
                for (int i = 0; i < N_HAZARDS; i++) begin
                    case (dut.dp_instr_r.hazards[i])
                        HAZARDS_AQ, HAZARDS_CKAQ: exp_haz_dacq[i] = 1'b1;
                        default: exp_haz_dacq[i] = 1'b0;
                    endcase
                end
            end

            checks++;
            if (hsb_dacq_mask_o !== exp_haz_dacq)
                fail("hsb_dacq_mask_o does not match the flushed instruction's AQ/CKAQ hazards");

            if (|hsb_dacq_mask_o) begin
                hsb_dacq_seen++;
                checks++;
                if (hsb_dacq_warp_id_o !== dut.dp_warp_id_r)
                    fail("hsb_dacq warp does not match the flushed dispatch instruction");
                for (int i = 0; i < N_HAZARDS; i++) begin
                    if (hsb_dacq_mask_o[i]) begin
                        checks++;
                        if (hsb_dacq_seq_o[i] !== hsb_acq_old_seq_i[i]
                            || hsb_dacq_empty_o[i] !== !hsb_acq_old_busy_i[i])
                            fail($sformatf("hsb_dacq[%0d] does not restore the captured old hazard state", i));
                    end
                end
            end

            // ---------------- Stall-less back-pressure ----------------
            checks++;
            if (|hsb_rel_valid)
                fail("hazard release reported valid while none is driven");

            if (fu_in_valid_o !== '0) begin
                checks++;
                if (fu_in_valid_o[dp_ref_instr.fu_sel] === 1'b1
                    && !fu_in_ready_i[dp_ref_instr.fu_sel]
                    && !dut.dp_stage_flush_w)
                    fail("dispatch stage not flushed while its FU was not ready");
            end
        end
    end

    // -----------------------------------------------------------------------
    // Stimulus helpers
    // -----------------------------------------------------------------------
    task automatic do_reset();
        rst_n = 1'b0;
        fu_in_ready_i = '1;
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

    // Poke a register busy on the real register scoreboard (TB-only acquire).
    task automatic poke_reg(input warp_id_t w, input reg_id_t idx,
                            input regfile_sel_e rf, input seq_t seq);
        @(negedge clk);
        rsb_poke_warp = w; rsb_poke_idx = idx; rsb_poke_regfile = rf;
        rsb_poke_seq = seq; rsb_poke_empty = 1'b0; rsb_poke_en = 1'b1;
        @(posedge clk);
        @(negedge clk) rsb_poke_en = 1'b0;
    endtask

    // Release a register (models the back-end committing an instruction).
    task automatic release_reg(input warp_id_t w, input reg_id_t idx,
                               input regfile_sel_e rf, input seq_t seq,
                               output logic valid);
        @(negedge clk);
        rsb_rel_warp = w; rsb_rel_idx = idx; rsb_rel_regfile = rf;
        rsb_rel_seq = seq; rsb_rel_en = 1'b1;
        #1 valid = rsb_rel_valid[0];
        @(posedge clk);
        @(negedge clk) rsb_rel_en = 1'b0;
    endtask

    // Program loaders --------------------------------------------------------

    // Independent stream: every instruction writes a distinct register and reads
    // only x0, so no acquire ever blocks a later instruction.
    task automatic load_prog_indep();
        for (int i = 0; i < PROG_WORDS; i++) prog_r[i] = NOP;
        for (int i = 0; i < 24; i++) prog_r[i] = enc_addi_x0(5'(i + 1), 12'(i));
    endtask

    // Self-dependent register instruction at pc 0: addi x1, x1, 1 (rd == rs1).
    task automatic load_prog_selfreg();
        load_prog_indep();
        prog_r[0] = 32'h0010_8093;
    endtask

    // Self-dependent hazard instruction at pc 0: csrrw x0, fflags, x0, which
    // carries HAZARDS_CKAQ on fflags (it both checks and acquires it).
    task automatic load_prog_selfhaz();
        load_prog_indep();
        prog_r[0] = 32'h0010_1073;
    endtask

    // pc 2 reads x20, which the TB pokes busy to force a register-access flush.
    task automatic load_prog_poke();
        load_prog_indep();
        prog_r[2] = 32'h004A_0193;   // addi x3, x20, 4
    endtask

    // -----------------------------------------------------------------------
    // Test body
    // -----------------------------------------------------------------------
    initial begin
        // ---------------- Initial conditions ----------------
        fu_in_ready_i = '1;
        branch_complete_i = 1'b0;
        branch_mask_i = '0;
        branch_type_i = branch_type_e'('0);
        branch_warp_id_i = '0;
        branch_pc_i = '0;
        branch_target_i = '0;
        rsb_poke_en = 1'b0;
        rsb_poke_empty = 1'b0;
        rsb_rel_en = 1'b0;
        hsb_rel_warp = '0;
        hsb_rel_mask = '0;
        hsb_rel_seq = '0;
        load_prog_indep();

        // Pin the warp scheduler to warp 0 for a deterministic single stream.
        #1 force dut.u_warp_scheduler.scheduled_warps_r = {{(N_WARPS-1){1'b0}}, 1'b1};
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
        $display("\n== B. Streaming issue (FU always ready, independent stream) ==");
        // ===================================================================
        load_prog_indep();
        disp_base = dispatches;
        run_more(12, 200, wait_ok);
        $display("  dispatched %0d instructions, exp_pc=%0d", dispatches - disp_base, exp_pc);

        // ===================================================================
        $display("\n== C. Scoreboard hazard flushes register access, then replays ==");
        // ===================================================================
        do_reset();
        load_prog_poke();
        poke_reg(0, 20, REGFILE_SEL_I, 12'h123);   // x20 busy, seq 0x123
        disp_base   = dispatches;
        disp_before = dispatches;

        // Wait until register access actually reports the hazard.
        wait_ok = 1'b0;
        for (int i = 0; i < 200; i++) begin
            @(negedge clk);
            if (dut.ra_sb_busy_w) begin wait_ok = 1'b1; break; end
        end
        checks++;
        if (!wait_ok) begin
            fail("never observed a scoreboard-busy flush");
        end else begin
            checks++;
            if (!dut.ra_stage_flush_w)
                fail("register-access flush not asserted while scoreboard busy");
            repeat (3) @(negedge clk);
            disp_before = dispatches;
            repeat (3) @(negedge clk);
            checks++;
            if (dispatches != disp_before)
                fail($sformatf("dispatch advanced while scoreboard busy (%0d -> %0d)",
                               disp_before, dispatches));
        end

        // Release the poked register; the flushed instruction must replay.
        release_reg(0, 20, REGFILE_SEL_I, 12'h123, wait_ok);
        checks++;
        if (!wait_ok)
            fail("release of the poked register did not validate");
        disp_base = dispatches;
        run_more(8, 200, wait_ok);

        // ===================================================================
        $display("\n== D. FU back-pressure replays the operation (stall-less) ==");
        // ===================================================================
        do_reset();
        load_prog_indep();
        disp_base = dispatches;
        run_more(4, 200, wait_ok);

        // Change `fu_in_ready_i` at the start of a cycle so it is stable for the
        // whole cycle.
        @(posedge clk);
        #1 fu_in_ready_i = '0;
        replay_pc   = exp_pc;
        disp_before = dispatches;
        for (int i = 0; i < 6; i++) begin
            @(negedge clk);
            checks++;
            if (dispatches != disp_before)
                fail($sformatf("dispatch occurred while FU not ready (%0d -> %0d)",
                               disp_before, dispatches));
            checks++;
            if (exp_pc != replay_pc)
                fail($sformatf("exp_pc advanced while FU not ready (%0d -> %0d)",
                               replay_pc, exp_pc));
            checks++;
            if (dut.dp_stage_valid_r && !dut.dp_stage_flush_w)
                fail("dispatch stage not flushed while FU not ready");
        end

        fu_in_ready_i = '1;
        wait_ok = 1'b0;
        for (int i = 0; i < 200; i++) begin
            @(negedge clk);
            if (dispatches > disp_before) begin wait_ok = 1'b1; break; end
        end
        checks++;
        if (!wait_ok)
            fail("flushed operation was not replayed after FU became ready");
        run_more(6, 200, wait_ok);

        // ===================================================================
        $display("\n== E. Register self-dependency (rd == rs) survives replay ==");
        // ===================================================================
        // `addi x1, x1, 1` both checks and acquires x1. It is flushed in the
        // dispatch stage (ALU not ready), so its acquire must be rolled back.
        // Otherwise the replayed instruction sees its own acquire and deadlocks
        // on itself.
        do_reset();
        load_prog_selfreg();
        disp_base = dispatches;

        @(posedge clk);
        #1 fu_in_ready_i = '1; fu_in_ready_i[FUNCTION_UNIT_ALU] = 1'b0;
        sb_dacq_seen = 0;
        disp_before  = dispatches;
        for (int i = 0; i < 24; i++) begin
            @(negedge clk);
            checks++;
            if (dispatches != disp_before)
                fail("dispatch occurred while ALU not ready");
        end
        checks++;
        if (sb_dacq_seen == 0)
            fail("no register rollback observed while the self-dependent instruction replays");
        $display("  register rollback issued %0d times during replay", sb_dacq_seen);

        // Release the FU: the instruction must now dispatch (no self-deadlock).
        fu_in_ready_i = '1;
        run_more(6, 200, wait_ok);
        checks++;
        if (!wait_ok)
            fail("self-dependent register instruction deadlocked (never dispatched)");

        // ===================================================================
        $display("\n== F. Hazard self-dependency (csrr fflags, CKAQ) survives replay ==");
        // ===================================================================
        // `csrrw x0, fflags, x0` both checks and acquires the fflags hazard. It
        // is flushed in the dispatch stage (CSRR FU not ready); its hazard
        // acquire must be rolled back or it deadlocks.
        do_reset();
        load_prog_selfhaz();
        disp_base = dispatches;

        @(posedge clk);
        #1 fu_in_ready_i = '1; fu_in_ready_i[FUNCTION_UNIT_CSRR] = 1'b0;
        hsb_dacq_seen = 0;
        disp_before   = dispatches;
        for (int i = 0; i < 24; i++) begin
            @(negedge clk);
            checks++;
            if (dispatches != disp_before)
                fail("dispatch occurred while CSRR not ready");
        end
        checks++;
        if (hsb_dacq_seen == 0)
            fail("no hazard rollback observed while the self-dependent instruction replays");
        $display("  hazard rollback issued %0d times during replay", hsb_dacq_seen);

        fu_in_ready_i = '1;
        run_more(6, 200, wait_ok);
        checks++;
        if (!wait_ok)
            fail("self-dependent hazard instruction deadlocked (never dispatched)");

        // ===================================================================
        // Summary
        // ===================================================================
        $display("\n=================================================");
        $display(" core_frontend TB: %0d checks, %0d failures, %0d dispatches",
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
        $display(" core_frontend TB: %0d checks, %0d failures, %0d dispatches",
                 checks, errors + 1, dispatches);
        $display(" RESULT: FAIL (timeout)\n");
        $finish;
    end

endmodule

`default_nettype wire
