// =============================================================================
// tb_multialu.sv — Self-checking testbench for the multialu functional unit
// =============================================================================
//
// multialu evaluates one ALU operation per thread and buffers the resulting
// (result vector, tag) pairs in an elastic FIFO with a valid/ready interface on
// both sides. This testbench:
//
//   * drives the input valid/ready interface and drains the output interface,
//   * checks every emitted result vector against a golden ALU model fed with the
//     exact same operands/instr at push time,
//   * checks that the tag pushed with an operation is the tag popped with its
//     result and that ordering is preserved (in-order FIFO),
//   * checks in_ready_o/out_valid_o flag behaviour, back-pressure data stability,
//     and the full/empty transitions.
//
// The golden model reuses src/alu.sv (one instance per thread) so this testbench
// targets the multialu plumbing (FIFO, handshakes, flags) rather than the ALU
// datapath itself.
//
// Note: control_unit_pkg::instr_s embeds fpnew_pkg::operation_e, so fpnew_pkg.sv
// must be compiled alongside this testbench (Bender provides it).
//
// Example run (Verilator):
//   <fpnew>/src/fpnew_pkg.sv src/params_pkg.sv src/control_unit_pkg.sv
//   src/alu.sv src/multialu.sv tb/tb_config_pkg.sv tb/tb_multialu.sv
// =============================================================================

`timescale 1ns/1ps
`default_nettype none

module tb_multialu;
    import params_pkg::*;
    import control_unit_pkg::*;
    import tb_config_pkg::RST_CYCLES;

    // -----------------------------------------------------------------------
    // Configuration
    // -----------------------------------------------------------------------
    localparam int FIFO_DEPTH = N_WARPS;

    // -----------------------------------------------------------------------
    // Clock / reset
    // -----------------------------------------------------------------------
    logic clk = 0;
    always #5 clk = ~clk;
    logic rst_n = 0;

    // -----------------------------------------------------------------------
    // DUT interface
    // -----------------------------------------------------------------------
    logic in_valid;
    logic in_ready;
    logic out_valid;
    logic out_ready;

    op_tag_s op_tag_i;
    logic [N_THREADS-1:0][RLEN-1:0] rs1_val;
    logic [N_THREADS-1:0][RLEN-1:0] rs2_val;
    instr_s instr;
    logic [W_WARPS-1:0] warp_id;
    logic [RLEN-1:Z_PC] pc;
    logic [63:0] cycle_time;
    logic [N_THREADS-1:0][63:0] instret;
    logic [63:0] wuinstret;
    logic [63:0] wtinstret;

    op_tag_s op_tag_o;
    logic [N_THREADS-1:0][RLEN-1:0] result_o;

    multialu #(
        .FIFO_DEPTH(FIFO_DEPTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid_i(in_valid),
        .in_ready_o(in_ready),
        .out_valid_o(out_valid),
        .out_ready_i(out_ready),
        .op_tag_i(op_tag_i),
        .rs1_val_i(rs1_val),
        .rs2_val_i(rs2_val),
        .instr_i(instr),
        .warp_id_i(warp_id),
        .pc_i(pc),
        .cycle_time_i(cycle_time),
        .instret_i(instret),
        .wuinstret_i(wuinstret),
        .wtinstret_i(wtinstret),
        .op_tag_o(op_tag_o),
        .result_o(result_o)
    );

    // -----------------------------------------------------------------------
    // Golden ALU model: identical inputs, one instance per thread
    // -----------------------------------------------------------------------
    logic [N_THREADS*RLEN-1:0] ref_result;

    for (genvar I = 0; I < N_THREADS; I++) begin : gen_ref_alu
        alu #(
            .THREAD_ID(I)
        ) u_ref_alu (
            .rs1_val_i(rs1_val[I]),
            .rs2_val_i(rs2_val[I]),
            .instr_i(instr),
            .warp_id_i(warp_id),
            .pc_i(pc),
            .result_o(ref_result[I*RLEN+:RLEN]),
            .cycle_time_i(cycle_time),
            .instret_i(instret[I]),
            .wuinstret_i(wuinstret),
            .wtinstret_i(wtinstret)
        );
    end

    // -----------------------------------------------------------------------
    // Scoreboard
    // -----------------------------------------------------------------------
    logic [N_THREADS*RLEN-1:0] exp_res_q[$];
    op_tag_s exp_tag_q[$];

    int n_checks;
    int n_errors;
    int n_printed;

    task automatic report_error(input string msg);
        n_errors++;
        // Only surface the first few failures to avoid flooding the log. The
        // simulation is failed at the end of the run via $fatal so CI catches
        // the problem even when the log is truncated.
        if (n_printed < 12) begin
            $display("  [FAIL] t=%0t %s", $time, msg);
            n_printed++;
        end
    endtask

    function automatic string vec_to_str(input logic [N_THREADS*RLEN-1:0] v);
        return $sformatf("%h", v);
    endfunction

    // -----------------------------------------------------------------------
    // Operation descriptor + stimulus helpers
    // -----------------------------------------------------------------------
    typedef struct {
        op_tag_s tag;
        logic [N_THREADS-1:0][RLEN-1:0] rs1;
        logic [N_THREADS-1:0][RLEN-1:0] rs2;
        instr_s instr;
        logic [W_WARPS-1:0] warp_id;
        logic [RLEN-1:Z_PC] pc;
        logic [63:0] cycle_time;
    } op_desc_t;

    task automatic apply_op(input op_desc_t o);
        op_tag_i = o.tag;
        rs1_val = o.rs1;
        rs2_val = o.rs2;
        instr = o.instr;
        warp_id = o.warp_id;
        pc = o.pc;
        cycle_time = o.cycle_time;
    endtask

    function automatic instr_s make_instr(
        input alu_funct_e funct,
        input alu_op1_sel_e op1,
        input alu_op2_sel_e op2,
        input logic [RLEN-1:0] imm
    );
        instr_s i;
        i = '0;
        i.alu_funct = funct;
        i.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
        i.alu_op1_sel = op1;
        i.alu_op2_sel = op2;
        i.imm = imm;
        return i;
    endfunction

    // Build a deterministic pseudo-random operation.
    function automatic op_desc_t make_op(input int idx);
        op_desc_t o;
        int unsigned r;
        alu_funct_e funct;
        r = $urandom();

        o.tag = '0;
        o.tag.op_id = idx[W_OP_ID-1:0];
        o.instr = make_instr(ALU_FUNCT_ADDY, ALU_OP1_SEL_RS1, ALU_OP2_SEL_RS2,
                             $urandom());
        o.warp_id = idx[W_WARPS-1:0];
        o.pc = $urandom()[RLEN-1:Z_PC];
        o.cycle_time = {32'hDEAD_BEEF, $urandom()};

        case (r % 12)
            0:  funct = ALU_FUNCT_ADDY;
            1:  begin funct = ALU_FUNCT_ADDY; o.instr.alu_addy_funct = ALU_ADDY_FUNCT_SUB; end
            2:  funct = ALU_FUNCT_SLL;
            3:  funct = ALU_FUNCT_SLT;
            4:  funct = ALU_FUNCT_SLTU;
            5:  funct = ALU_FUNCT_XOR;
            6:  begin funct = ALU_FUNCT_ADDY; o.instr.imm = $urandom(); o.instr.alu_op2_sel = ALU_OP2_SEL_IMM; end
            7:  funct = ALU_FUNCT_SRL;
            8:  funct = ALU_FUNCT_SRA;
            9:  funct = ALU_FUNCT_OR;
            10: funct = ALU_FUNCT_AND;
            11: funct = ALU_FUNCT_CZERO_EQZ;
            default: funct = ALU_FUNCT_ADDY;
        endcase
        o.instr.alu_funct = funct;

        for (int t = 0; t < N_THREADS; t++) begin
            o.rs1[t] = $urandom();
            o.rs2[t] = $urandom();
        end
        o.tag.instr = o.instr;
        return o;
    endfunction

    // Present one operation on the input interface for a single cycle. If the
    // DUT accepts it (in_ready_o high just before the edge) the corresponding
    // reference result and tag are pushed onto the scoreboard.
    task automatic push_op(input op_desc_t o);
        @(negedge clk);
        in_valid = 1'b1;
        apply_op(o);
        #1;
        if (in_ready) begin
            exp_res_q.push_back(ref_result);
            exp_tag_q.push_back(o.tag);
        end
        @(posedge clk);
        #1;
    endtask

    task automatic idle_inputs;
        @(negedge clk);
        in_valid = 1'b0;
        @(posedge clk);
        #1;
    endtask

    // -----------------------------------------------------------------------
    // Output monitor: pops the scoreboard on every accepted output beat
    // -----------------------------------------------------------------------
    logic [N_THREADS*RLEN-1:0] result_flat;
    assign result_flat = result_o; // flatten the per-thread result vector

    logic [N_THREADS*RLEN-1:0] mon_got_res;
    op_tag_s mon_got_tag;
    logic [N_THREADS*RLEN-1:0] mon_want_res;
    op_tag_s mon_want_tag;

    always @(posedge clk) begin
        if (rst_n === 1'b1 && out_valid === 1'b1 && out_ready === 1'b1) begin
            mon_got_res = result_flat;
            mon_got_tag = op_tag_o;
            n_checks++;
            if (exp_res_q.size() == 0) begin
                report_error($sformatf(
                    "output beat with empty scoreboard: res=%s op_id=%0d",
                    vec_to_str(mon_got_res), mon_got_tag.op_id));
            end else begin
                mon_want_res = exp_res_q.pop_front();
                mon_want_tag = exp_tag_q.pop_front();
                if (mon_got_res !== mon_want_res) begin
                    report_error($sformatf(
                        "result mismatch on op_id=%0d: got %s want %s",
                        mon_want_tag.op_id, vec_to_str(mon_got_res),
                        vec_to_str(mon_want_res)));
                end
                if (mon_got_tag !== mon_want_tag) begin
                    report_error($sformatf(
                        "tag mismatch (expected op_id=%0d): got %h want %h",
                        mon_want_tag.op_id, mon_got_tag, mon_want_tag));
                end
            end
        end
    end

    // -----------------------------------------------------------------------
    // Back-pressure stability monitor: while valid && !ready, the payload must
    // stay stable and valid must not drop.
    // -----------------------------------------------------------------------
    logic bp_valid_r, bp_ready_r;
    logic [N_THREADS*RLEN-1:0] bp_res_r;
    op_tag_s bp_tag_r;

    always @(posedge clk) begin
        if (!rst_n) begin
            bp_valid_r <= 1'b0;
            bp_ready_r <= 1'b0;
            bp_res_r   <= '0;
            bp_tag_r   <= '0;
        end else begin
            if (bp_valid_r && !bp_ready_r) begin
                if (out_valid !== 1'b1)
                    report_error("out_valid_o dropped while stalled (out_ready_i low)");
                if (result_flat !== bp_res_r)
                    report_error("result_o changed while stalled (out_ready_i low)");
                if (op_tag_o !== bp_tag_r)
                    report_error("op_tag_o changed while stalled (out_ready_i low)");
            end
            bp_valid_r <= out_valid;
            bp_ready_r <= out_ready;
            bp_res_r   <= result_flat;
            bp_tag_r   <= op_tag_o;
        end
    end

    // -----------------------------------------------------------------------
    // Reference occupancy model + per-occupancy bookkeeping (used by TEST 10)
    //
    // The DUT flags must always agree with the true occupancy: out_valid_o is
    // exactly "non-empty" and in_ready_o is exactly "not full".
    // -----------------------------------------------------------------------
    int occ_ref;
    int occ_checks[FIFO_DEPTH+1];
    int occ_errors[FIFO_DEPTH+1];
    int burst;
    string failing_occs;

    task automatic check_occupancy_flags;
        if (occ_ref < 0 || occ_ref > FIFO_DEPTH) return;
        occ_checks[occ_ref]++;
        if (occ_ref == 0 && out_valid !== 1'b0) begin
            occ_errors[occ_ref]++;
            report_error($sformatf("occupancy %0d: out_valid_o high but FIFO is empty", occ_ref));
        end
        if (occ_ref > 0 && out_valid !== 1'b1) begin
            occ_errors[occ_ref]++;
            report_error($sformatf("occupancy %0d: out_valid_o low but FIFO is non-empty (spurious empty)", occ_ref));
        end
        if (occ_ref == FIFO_DEPTH && in_ready !== 1'b0) begin
            occ_errors[occ_ref]++;
            report_error($sformatf("occupancy %0d: in_ready_o high but FIFO is full", occ_ref));
        end
        if (occ_ref < FIFO_DEPTH && in_ready !== 1'b1) begin
            occ_errors[occ_ref]++;
            report_error($sformatf("occupancy %0d: in_ready_o low but FIFO has free space (spurious full)", occ_ref));
        end
    endtask

    // Drive one input/output cycle. Checks the flags against the reference
    // occupancy before the edge, then updates the reference from the handshakes
    // that actually occur at the edge.
    task automatic sweep_cycle(input bit din, input bit dout, input op_desc_t o);
        logic push, pop;
        check_occupancy_flags();
        in_valid  = din;
        out_ready = dout;
        apply_op(o);
        #1;
        push = din & in_ready;
        pop  = dout & out_valid;
        if (push) begin
            exp_res_q.push_back(ref_result);
            exp_tag_q.push_back(o.tag);
        end
        occ_ref = occ_ref + (push ? 1 : 0) - (pop ? 1 : 0);
        @(posedge clk);
        #1;
        @(negedge clk);
    endtask

    // -----------------------------------------------------------------------
    // Stimulus
    // -----------------------------------------------------------------------
    op_desc_t op;
    int accepted;
    int drain_count;

    initial begin
        // Defaults
        in_valid    = 1'b0;
        out_ready   = 1'b0;
        op_tag_i    = '0;
        rs1_val     = '0;
        rs2_val     = '0;
        instr       = '0;
        warp_id     = '0;
        pc          = '0;
        cycle_time  = '0;
        instret     = '0;
        wuinstret   = '0;
        wtinstret   = '0;
        n_checks    = 0;
        n_errors    = 0;
        n_printed   = 0;
        accepted    = 0;

        // Static CSR-like sources
        for (int t = 0; t < N_THREADS; t++)
            instret[t] = {32'h0000_0001, t[31:0]};
        wuinstret = 64'h1234_5678_9ABC_DEF0;
        wtinstret = 64'h0FED_CBA9_8765_4321;

        // -------------------------------------------------------------------
        // Reset
        // -------------------------------------------------------------------
        rst_n = 1'b0;
        repeat (RST_CYCLES) @(posedge clk);
        @(negedge clk);
        rst_n = 1'b1;

        // -------------------------------------------------------------------
        // TEST 1: idle state after reset
        // -------------------------------------------------------------------
        $display("[TEST 1] Reset/idle state");
        @(negedge clk);
        #1;
        if (in_ready !== 1'b1)
            report_error("in_ready_o should be high right after reset");
        if (out_valid !== 1'b0)
            report_error("out_valid_o should be low right after reset");

        // -------------------------------------------------------------------
        // TEST 2: single operation, then drain
        // -------------------------------------------------------------------
        $display("[TEST 2] Single operation round-trip");
        op = make_op(0);
        op.instr = make_instr(ALU_FUNCT_ADDY, ALU_OP1_SEL_RS1, ALU_OP2_SEL_RS2, '0);
        op.tag.instr = op.instr;
        for (int t = 0; t < N_THREADS; t++) begin
            op.rs1[t] = 32'h1000 + t[31:0];
            op.rs2[t] = 32'h0020 + t[31:0];
        end
        out_ready = 1'b1;
        push_op(op);
        idle_inputs();
        // Wait for the fifo to empty out.
        repeat (4) begin
            @(negedge clk);
            #1;
        end
        if (exp_res_q.size() != 0)
            report_error($sformatf("FIFO did not drain: %0d results still expected",
                                   exp_res_q.size()));
        if (out_valid !== 1'b0)
            report_error("out_valid_o should be low once the FIFO is empty");

        // -------------------------------------------------------------------
        // TEST 3: fill the FIFO with out_ready_i low
        // -------------------------------------------------------------------
        $display("[TEST 3] Fill to full with back-pressure");
        exp_res_q.delete();
        exp_tag_q.delete();
        out_ready = 1'b0;
        accepted = 0;
        for (int n = 0; n < FIFO_DEPTH; n++) begin
            @(negedge clk);
            in_valid = 1'b1;
            apply_op(make_op(100 + n));
            #1;
            if (in_ready) begin
                exp_res_q.push_back(ref_result);
                exp_tag_q.push_back(op_tag_i);
                accepted++;
            end
            @(posedge clk);
            #1;
        end
        @(negedge clk);
        #1;
        $display("  accepted %0d of %0d while filling", accepted, FIFO_DEPTH);
        if (accepted != FIFO_DEPTH)
            report_error($sformatf("FIFO accepted %0d ops before back-pressure, expected %0d",
                                   accepted, FIFO_DEPTH));
        if (in_ready !== 1'b0)
            report_error("in_ready_o should be low when the FIFO is full");
        if (out_valid !== 1'b1)
            report_error("out_valid_o should be high when the FIFO is non-empty");
        if (exp_res_q.size() != FIFO_DEPTH)
            report_error($sformatf("scoreboard holds %0d, expected %0d",
                                   exp_res_q.size(), FIFO_DEPTH));
        idle_inputs();

        // -------------------------------------------------------------------
        // TEST 4: drain the full FIFO, checking order/values via the monitor
        // -------------------------------------------------------------------
        $display("[TEST 4] Drain full FIFO (order + values)");
        out_ready = 1'b1;
        repeat (FIFO_DEPTH + 2) begin
            @(posedge clk);
            #1;
        end
        if (exp_res_q.size() != 0)
            report_error($sformatf("%0d results not drained", exp_res_q.size()));
        if (out_valid !== 1'b0)
            report_error("out_valid_o should be low after draining");

        // -------------------------------------------------------------------
        // TEST 5: streaming with full throughput (no gaps)
        // -------------------------------------------------------------------
        $display("[TEST 5] Streaming %0d operations at full rate", 4 * FIFO_DEPTH);
        for (int n = 0; n < 4 * FIFO_DEPTH; n++) begin
            @(negedge clk);
            in_valid = 1'b1;
            apply_op(make_op(1000 + n));
            #1;
            if (in_ready) begin
                exp_res_q.push_back(ref_result);
                exp_tag_q.push_back(op_tag_i);
            end
            @(posedge clk);
            #1;
        end
        idle_inputs();
        repeat (FIFO_DEPTH + 2) begin
            @(posedge clk);
            #1;
        end
        if (exp_res_q.size() != 0)
            report_error($sformatf("%0d results not drained after streaming",
                                   exp_res_q.size()));

        // -------------------------------------------------------------------
        // TEST 6: randomized input valid / output ready traffic
        // -------------------------------------------------------------------
        $display("[TEST 6] Randomized valid/ready traffic");
        out_ready = 1'b0;
        in_valid  = 1'b0;
        for (int n = 0; n < 10 * FIFO_DEPTH; n++) begin
            @(negedge clk);
            in_valid = ($urandom_range(0, 3) != 0);
            out_ready = ($urandom_range(0, 3) != 0);
            if (in_valid) apply_op(make_op(2000 + n));
            #1;
            if (in_valid && in_ready) begin
                exp_res_q.push_back(ref_result);
                exp_tag_q.push_back(op_tag_i);
            end
            @(posedge clk);
            #1;
        end
        out_ready = 1'b1;
        idle_inputs();
        repeat (2 * FIFO_DEPTH + 4) begin
            @(posedge clk);
            #1;
        end
        if (exp_res_q.size() != 0)
            report_error($sformatf("%0d results not drained after random traffic",
                                   exp_res_q.size()));

        // -------------------------------------------------------------------
        // TEST 7: explicit CSR / special ALU functions
        // -------------------------------------------------------------------
        $display("[TEST 7] CSR/special ALU functions");
        begin
            alu_funct_e csr_functs [6];
            csr_functs[0] = ALU_FUNCT_HARTID;
            csr_functs[1] = ALU_FUNCT_WARPID;
            csr_functs[2] = ALU_FUNCT_THRID;
            csr_functs[3] = ALU_FUNCT_CYCLETIME;
            csr_functs[4] = ALU_FUNCT_WUINSTRET;
            csr_functs[5] = ALU_FUNCT_WTINSTRETH;
            out_ready = 1'b1;
            for (int k = 0; k < 6; k++) begin
                op = make_op(3000 + k);
                op.instr = make_instr(csr_functs[k], ALU_OP1_SEL_RS1,
                                      ALU_OP2_SEL_RS2, '0);
                op.tag.instr = op.instr;
                op.warp_id = k[W_WARPS-1:0];
                op.cycle_time = 64'h0000_00AA_0000_0055;
                push_op(op);
            end
            idle_inputs();
            repeat (8) begin
                @(posedge clk);
                #1;
            end
            if (exp_res_q.size() != 0)
                report_error($sformatf("%0d CSR results not drained",
                                       exp_res_q.size()));
        end

        // -------------------------------------------------------------------
        // TEST 8: randomized simultaneous-handshake sweep over every occupancy
        //          level (1 .. FIFO_DEPTH-1)
        //
        // For each occupancy level the FIFO is filled to exactly that occupancy
        // and then hammered with simultaneous push+pop cycles. Keeping both
        // handshakes asserted holds the occupancy fixed, so every flag check is
        // attributable to the level under test. The operand/tag data and the
        // burst length are randomized. Failures are tallied per occupancy level
        // and reported at the end.
        // -------------------------------------------------------------------
        $display("[TEST 8] Simultaneous-handshake sweep across occupancy 1..%0d", FIFO_DEPTH - 1);
        for (int c = 0; c <= FIFO_DEPTH; c++) begin
            occ_checks[c] = 0;
            occ_errors[c] = 0;
        end

        for (int occ = 1; occ < FIFO_DEPTH; occ++) begin
            // Deterministic, empty FIFO for this occupancy level.
            in_valid  = 1'b0;
            out_ready = 1'b0;
            rst_n = 1'b0;
            repeat (RST_CYCLES) @(posedge clk);
            @(negedge clk);
            rst_n = 1'b1;
            exp_res_q.delete();
            exp_tag_q.delete();
            occ_ref = 0;

            // Fill to exactly `occ` entries.
            for (int n = 0; n < occ; n++)
                sweep_cycle(1'b1, 1'b0, make_op(7000 + 100 * occ + n));

            // Hammer simultaneous push+pop at this occupancy.
            burst = int'($urandom_range(6, 12));
            for (int n = 0; n < burst; n++)
                sweep_cycle(1'b1, 1'b1, make_op(8000 + 100 * occ + n));

            // Also validate the flags left behind by the final burst edge.
            check_occupancy_flags();
        end

        in_valid  = 1'b0;
        out_ready = 1'b0;

        // Report the sweep, calling out the failing occupancy levels.
        $display("  occupancy : checks : errors");
        failing_occs = "";
        for (int occ = 1; occ < FIFO_DEPTH; occ++) begin
            $display("      %0d     :   %0d    :   %0d%s",
                     occ, occ_checks[occ], occ_errors[occ],
                     (occ_errors[occ] != 0) ? "   <-- FAIL" : "");
            if (occ_errors[occ] != 0) begin
                if (failing_occs != "")
                    failing_occs = {failing_occs, ", "};
                failing_occs = {failing_occs, $sformatf("%0d", occ)};
            end
        end
        if (failing_occs == "")
            $display("  sweep result: PASS (all occupancy levels clean)");
        else
            $display("  sweep result: FAIL at occupancy level(s) %s", failing_occs);

        // -------------------------------------------------------------------
        // Summary
        // -------------------------------------------------------------------
        repeat (4) @(posedge clk);
        $display("");
        $display("=========================================");
        $display(" tb_multialu summary");
        $display("   output beats checked : %0d", n_checks);
        $display("   errors               : %0d", n_errors);
        if (n_errors == 0)
            $display("   RESULT               : PASS");
        else
            $display("   RESULT               : FAIL");
        $display("=========================================");
        if (n_errors != 0)
            $fatal(1, "tb_multialu: %0d error(s)", n_errors);
        $finish;
    end

endmodule

`default_nettype wire
