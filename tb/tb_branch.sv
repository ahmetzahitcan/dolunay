// =============================================================================
// tb_branch.sv — Full-core, self-checking branch test
// =============================================================================
//
// What is verified
// ----------------
//   * Every RISC-V branch type (BEQ, BNE, BLT, BGE, BLTU, BGEU) produces the
//     correct *taken thread mask*, for all three architectural branch results:
//         BR_UNIFORM_ALL  (taken mask == active mask)
//         BR_UNIFORM_NONE (taken mask == 0)
//         BR_DIVERGENT    (taken mask is a non-empty, proper subset)
//   * The taken mask never contains a thread that is not active for the
//     branch (i.e. the branch unit masks its comparison result).
//   * The branch unit's classification matches the mask relation, and the
//     front-end's split decision follows that classification.
//   * Per warp, the sequence of branches (pc, branch type, taken mask) is
//     exactly the sequence the program in asm-kernels/branch_test.s emits.
//   * Every active warp executes the same branch sequence (the program is
//     warp-independent), so the sequence is checked independently per warp.
//
// How it is run
// -------------
//   The DUT is core_top, run against the assembled program in irom.mem
//   (produced by asm-kernels/generate.sh branch_test.s).  Three warp modes are
//   exercised, each compiled with a different define:
//
//       SINGLE_WARP  -> 1 active warp   -> sim/tb_branch_single.fst
//       TWO_WARP     -> 2 active warps  -> sim/tb_branch_two.fst
//       FOUR_WARP    -> 4 active warps  -> sim/tb_branch_four.fst
//
//   See tb/run_branch.sh.
// =============================================================================

`timescale 1ns/1ps
`default_nettype none

module tb_branch;
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
    // Active warp count / waveform file, selected at compile time.
    // -----------------------------------------------------------------------
`ifdef SINGLE_WARP
    localparam int          ACTIVE_WARPS = 1;
    localparam string       WAVE_FILE    = "sim/tb_branch_single.fst";
`elsif TWO_WARP
    localparam int          ACTIVE_WARPS = 2;
    localparam string       WAVE_FILE    = "sim/tb_branch_two.fst";
`elsif FOUR_WARP
    localparam int          ACTIVE_WARPS = 4;
    localparam string       WAVE_FILE    = "sim/tb_branch_four.fst";
`else
    localparam int          ACTIVE_WARPS = N_WARPS;
    localparam string       WAVE_FILE    = "sim/tb_branch_full.fst";
`endif

    initial begin
        $dumpfile(WAVE_FILE);
        $dumpvars(0, tb_branch);
    end

    // -----------------------------------------------------------------------
    // DUT
    // -----------------------------------------------------------------------
    localparam int IROM_SIZE = 65536;
    localparam int WRAM_SIZE = 65536;

    localparam int W_WRAM_ADDR = $clog2(WRAM_SIZE);
    localparam int W_IROM_ADDR = $clog2(IROM_SIZE);

    logic [W_WRAM_ADDR-1:Z_ADDR] wram_addr_w;
    logic [RLEN-1:0]             wram_wdata_w;
    logic [ADDR_ALIGN-1:0]       wram_wen_w;
    logic [RLEN-1:0]             wram_rdata_w;

    logic [W_IROM_ADDR-1:Z_PC]   irom_addr_a_w;
    logic [RLEN-1:0]             irom_data_a_w;
    logic [W_IROM_ADDR-1:Z_PC]   irom_addr_b_w;
    logic [RLEN-1:0]             irom_data_b_w;

    core_top #(
        .WRAM_SIZE(WRAM_SIZE),
        .IROM_SIZE(IROM_SIZE)
    ) dut (
        .clk          (clk),
        .rst_n        (rst_n),
        .start_i      (1'b0),
        .ready_o      (),
        .wram_addr_o  (wram_addr_w),
        .wram_wdata_o (wram_wdata_w),
        .wram_wen_o   (wram_wen_w),
        .wram_rdata_i (wram_rdata_w),
        .irom_addr_a_o(irom_addr_a_w),
        .irom_data_a_i(irom_data_a_w),
        .irom_addr_b_o(irom_addr_b_w),
        .irom_data_b_i(irom_data_b_w)
    );

    ram #(.DEPTH(WRAM_SIZE / 4)) u_wram (
        .clk(clk),
        .addr_i(wram_addr_w),
        .wdata_i(wram_wdata_w),
        .wen_i(wram_wen_w),
        .rdata_o(wram_rdata_w)
    );

    irom #(.IROM_SIZE(IROM_SIZE)) u_irom (
        .clk(clk),
        .port_a_addr_i(irom_addr_a_w),
        .port_a_data_o(irom_data_a_w),
        .port_b_addr_i(irom_addr_b_w),
        .port_b_data_o(irom_data_b_w)
    );

    // -----------------------------------------------------------------------
    // Expected branch sequence, derived from asm-kernels/branch_test.s.
    // Program order (all warps are identical):
    //   #0 .. #11 : uniform-all / uniform-none for each of the 6 branch types
    //   #12 .. #17: divergent for each of the 6 branch types
    // pc is word-addressed (byte address / 4).
    // -----------------------------------------------------------------------
    localparam int N_BRANCHES = 18;

    branch_type_e exp_type [0:N_BRANCHES-1];
    logic   [7:0] exp_mask [0:N_BRANCHES-1];
    bj_type_e     exp_bj   [0:N_BRANCHES-1];
    int           exp_pc   [0:N_BRANCHES-1];

    task automatic set_exp(input int i, input branch_type_e t, input logic [7:0] m,
                           input bj_type_e bj, input int pc);
        exp_type[i] = t;
        exp_mask[i] = m;
        exp_bj[i]   = bj;
        exp_pc[i]   = pc;
    endtask

    // -----------------------------------------------------------------------
    // Bookkeeping / results
    // -----------------------------------------------------------------------
    int checks = 0;
    int errors = 0;

    int  prog_idx [0:N_WARPS-1];   // per-warp number of branches seen
    int  branch_count = 0;

    bit  all_done = 1'b0;

    task automatic fail(input string label);
        errors++;
        $display("  [FAIL] %s", label);
    endtask

    function automatic string bj_name(input bj_type_e bj);
        case (bj)
            BJ_TYPE_BEQ:  return "BEQ";
            BJ_TYPE_BNE:  return "BNE";
            BJ_TYPE_BLT:  return "BLT";
            BJ_TYPE_BGE:  return "BGE";
            BJ_TYPE_BLTU: return "BLTU";
            BJ_TYPE_BGEU: return "BGEU";
            BJ_TYPE_JAL:  return "JAL";
            default:      return "NONE";
        endcase
    endfunction

    function automatic string type_name(input branch_type_e t);
        case (t)
            BR_UNIFORM_ALL:  return "UNIFORM_ALL";
            BR_UNIFORM_NONE: return "UNIFORM_NONE";
            default:         return "DIVERGENT";
        endcase
    endfunction

    // -----------------------------------------------------------------------
    // Test body
    // -----------------------------------------------------------------------
    localparam int MAX_CYCLES = 200000;

    int cycle;
    bit done;
    bit timeout;

    // DUT observation points (hierarchical, simulation only).
    logic       bju_complete;
    simd_mask_t bju_mask;
    simd_mask_t bju_taken;
    branch_type_e bju_type;
    bj_type_e   bju_bj;
    int         bju_pc;
    int         bju_warp;

    initial begin
        // ---------------- Expected sequence ----------------
        // Uniform-all / uniform-none, in program order.
        set_exp( 0, BR_UNIFORM_ALL,  8'hFF, BJ_TYPE_BEQ,   3);
        set_exp( 1, BR_UNIFORM_NONE, 8'h00, BJ_TYPE_BEQ,   7);
        set_exp( 2, BR_UNIFORM_ALL,  8'hFF, BJ_TYPE_BNE,  10);
        set_exp( 3, BR_UNIFORM_NONE, 8'h00, BJ_TYPE_BNE,  14);
        set_exp( 4, BR_UNIFORM_ALL,  8'hFF, BJ_TYPE_BLT,  17);
        set_exp( 5, BR_UNIFORM_NONE, 8'h00, BJ_TYPE_BLT,  21);
        set_exp( 6, BR_UNIFORM_ALL,  8'hFF, BJ_TYPE_BGE,  24);
        set_exp( 7, BR_UNIFORM_NONE, 8'h00, BJ_TYPE_BGE,  28);
        set_exp( 8, BR_UNIFORM_ALL,  8'hFF, BJ_TYPE_BLTU, 31);
        set_exp( 9, BR_UNIFORM_NONE, 8'h00, BJ_TYPE_BLTU, 35);
        set_exp(10, BR_UNIFORM_ALL,  8'hFF, BJ_TYPE_BGEU, 38);
        set_exp(11, BR_UNIFORM_NONE, 8'h00, BJ_TYPE_BGEU, 42);
        // Divergent, taken thread set shrinks by one thread per branch.
        set_exp(12, BR_DIVERGENT, 8'h01, BJ_TYPE_BEQ,  44);   // taken {0}
        set_exp(13, BR_DIVERGENT, 8'h80, BJ_TYPE_BNE,  47);   // taken {7}
        set_exp(14, BR_DIVERGENT, 8'h02, BJ_TYPE_BLT,  49);   // taken {1}
        set_exp(15, BR_DIVERGENT, 8'h40, BJ_TYPE_BGE,  51);   // taken {6}
        set_exp(16, BR_DIVERGENT, 8'h04, BJ_TYPE_BLTU, 53);   // taken {2}
        set_exp(17, BR_DIVERGENT, 8'h20, BJ_TYPE_BGEU, 55);   // taken {5}

        for (int w = 0; w < N_WARPS; w++) prog_idx[w] = 0;

        // ---------------- Reset ----------------
        rst_n = 1'b0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1'b1;

        $display("\n== branch TB: %0d active warp(s) ==", ACTIVE_WARPS);

        // ---------------- Run and check every cycle ----------------
        done    = 1'b0;
        timeout = 1'b0;

        for (cycle = 0; cycle < MAX_CYCLES; cycle++) begin
            @(negedge clk);
            #1;

            // -------- Branch-unit observation --------
            bju_complete = dut.u_bju.branch_complete_o;
            bju_mask     = dut.u_bju.operation_w.mask;   // active mask of the branch
            bju_taken    = dut.u_bju.branch_mask_o;      // taken-thread mask (masked)
            bju_type     = dut.u_bju.branch_type_o;
            bju_bj       = dut.u_bju.out_result_o.instr.bj_type;
            bju_pc       = int'(dut.u_bju.out_result_o.pc);
            bju_warp     = int'(dut.u_bju.out_result_o.warp_id);

            if (bju_complete) begin
                branch_type_e want_type;
                int idx;

                branch_count++;

                // (1) taken mask must be a subset of the active mask.
                checks++;
                if ((bju_taken & ~bju_mask) !== '0)
                    fail($sformatf("warp%0d pc=%0d: taken mask %b is not a subset of active mask %b",
                                   bju_warp, bju_pc, bju_taken, bju_mask));

                // (2) classification must match the mask relation.
                if (bju_taken == bju_mask)      want_type = BR_UNIFORM_ALL;
                else if (bju_taken == '0)       want_type = BR_UNIFORM_NONE;
                else                            want_type = BR_DIVERGENT;
                checks++;
                if (bju_type !== want_type)
                    fail($sformatf("warp%0d pc=%0d %s: branch_type=%s but mask relation says %s",
                                   bju_warp, bju_pc, bj_name(bju_bj),
                                   type_name(bju_type), type_name(want_type)));

                // (3) front-end split follows the classification.
                checks++;
                if (dut.u_core_frontend.split_w !== (bju_type == BR_DIVERGENT))
                    fail($sformatf("warp%0d pc=%0d: split_w=%b for %s branch",
                                   bju_warp, bju_pc, dut.u_core_frontend.split_w,
                                   type_name(bju_type)));

                // (4) expected program sequence, per warp.
                idx = prog_idx[bju_warp];
                if (idx < N_BRANCHES) begin
                    $display("  [ ok ] warp%0d #%0d pc=%0d %-4s %-12s mask=%b",
                             bju_warp, idx, bju_pc, bj_name(bju_bj),
                             type_name(bju_type), bju_taken);
                    checks++;
                    if (bju_bj !== exp_bj[idx])
                        fail($sformatf("warp%0d #%0d: branch type %s, expected %s",
                                       bju_warp, idx, bj_name(bju_bj), bj_name(exp_bj[idx])));
                    checks++;
                    if (bju_pc !== exp_pc[idx])
                        fail($sformatf("warp%0d #%0d: pc=%0d, expected %0d",
                                       bju_warp, idx, bju_pc, exp_pc[idx]));
                    checks++;
                    if (bju_type !== exp_type[idx])
                        fail($sformatf("warp%0d #%0d: result %s, expected %s",
                                       bju_warp, idx, type_name(bju_type), type_name(exp_type[idx])));
                    checks++;
                    if (bju_taken !== exp_mask[idx])
                        fail($sformatf("warp%0d #%0d: taken mask %b, expected %b",
                                       bju_warp, idx, bju_taken, exp_mask[idx]));
                end else begin
                    fail($sformatf("warp%0d: unexpected extra branch #%0d at pc=%0d",
                                   bju_warp, idx, bju_pc));
                end
                prog_idx[bju_warp] = idx + 1;
            end

            // -------- Completion check --------
            all_done = 1'b1;
            for (int w = 0; w < ACTIVE_WARPS; w++)
                if (prog_idx[w] < N_BRANCHES) all_done = 1'b0;

`ifdef DEBUG
            if (cycle % 200 == 0) begin
                $write("  cyc=%0d progress:", cycle);
                for (int w = 0; w < ACTIVE_WARPS; w++)
                    $write(" w%0d=%0d/%0d", w, prog_idx[w], N_BRANCHES);
                $write("\n");
            end
`endif

            if (all_done) begin
                // Let the branch pipeline drain before declaring success.
                repeat (20) @(negedge clk);
                done = 1'b1;
                break;
            end
        end

        if (!done) begin
            timeout = 1'b1;
            for (int w = 0; w < ACTIVE_WARPS; w++)
                if (prog_idx[w] < N_BRANCHES)
                    fail($sformatf("warp%0d: only %0d/%0d branches observed (hang/timeout)",
                                   w, prog_idx[w], N_BRANCHES));
        end

        // ---------------- Summary ----------------
        $display("\n=================================================");
        $display(" branch TB (%0d warp%s): %0d branches, %0d checks, %0d failures",
                 ACTIVE_WARPS, (ACTIVE_WARPS == 1) ? "" : "s",
                 branch_count, checks, errors);
        if (errors == 0 && !timeout)
            $display(" RESULT: PASS");
        else
            $display(" RESULT: FAIL");
        $display(" waveform: %s", WAVE_FILE);
        $display("=================================================\n");

        $finish;
    end

    // Hard watchdog.
    initial begin
        #(MAX_CYCLES * 10 + 100000);
        $display("\n  [FAIL] global simulation timeout");
        $display(" RESULT: FAIL (timeout)\n");
        $finish;
    end

endmodule

`default_nettype wire
