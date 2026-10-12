// =============================================================================
// tb_core_top.sv — integration smoke test for src/core_top.sv
// =============================================================================
//
// Drives core_top (front-end + middle-end + back-end + register file + the real
// scoreboards) with a program preloaded into the IROM model, and checks that the
// integrated pipeline makes forward progress and does not trip any RTL
// assertion. Detailed functional checking of a program's results lives in the
// host/kernel flow; this TB is the "does it elaborate and run without wedging"
// harness.
//
// Progress is observed through hierarchical probes:
//   * u_core_middleend.of_dispatch_w   — ops dispatched to the FUs
//   * core_top.me_out_valid_w          — results handed to the back-end
//   * u_core_backend.cm_stage_valid_r  — committed entries
//
// Pass criterion: at least one op is dispatched, collected and committed.
//
// =============================================================================

`timescale 1ns/1ps
`default_nettype none

module tb_core_top;
    import tb_config_pkg::RST_CYCLES;
    import params_pkg::*;

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic clk   = 1'b0;
    logic rst_n = 1'b0;
    logic start_i = 1'b0;
    logic ready_o;

    always #5 clk = ~clk;

`ifdef WAVE
    initial begin
        $dumpfile("sim/tb_core_top.fst");
        $dumpvars(0, tb_core_top);
    end
`endif

    localparam int IROM_SIZE = 65536;
    localparam int WRAM_SIZE = 65536;

    localparam int W_WRAM_ADDR = $clog2(WRAM_SIZE);
    localparam int W_IROM_ADDR = $clog2(IROM_SIZE);

    // WRAM Interface
    logic [W_WRAM_ADDR-1:Z_ADDR] wram_addr_w;
    logic [RLEN-1:0]             wram_wdata_w;
    logic [ADDR_ALIGN-1:0]       wram_wen_w;
    logic [RLEN-1:0]             wram_rdata_w;

    // IROM Interface A
    logic [W_IROM_ADDR-1:Z_PC] irom_addr_a_w;
    logic [RLEN-1:0]           irom_data_a_w;

    // IROM Interface B
    logic [W_IROM_ADDR-1:Z_PC] irom_addr_b_w;
    logic [RLEN-1:0]           irom_data_b_w;

    core_top #(
    	.WRAM_SIZE(WRAM_SIZE),
    	.IROM_SIZE(IROM_SIZE)
     ) dut (
	.clk          (clk),
	.rst_n        (rst_n),
	.start_i      (start_i),
	.ready_o      (ready_o),
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
    // Progress probes
    // -----------------------------------------------------------------------
    int dispatches = 0;
    int collects   = 0;
    int commits    = 0;

    always @(posedge clk) begin
        if (rst_n) begin
            if (dut.u_core_middleend.of_dispatch_w)          dispatches++;
            if (dut.me_out_valid_w)                          collects++;
            if (dut.u_core_backend.cm_stage_valid_r)         commits++;
        end
    end

    initial begin
        rst_n = 1'b0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1'b1;

        repeat (20000) @(posedge clk);

        $display("\n=================================================");
        $display(" core_top smoke: dispatched=%0d collected=%0d committed=%0d",
                 dispatches, collects, commits);
        if (dispatches > 0 && collects > 0 && commits > 0)
            $display(" RESULT: PASS");
        else
            $display(" RESULT: FAIL (no forward progress)");
        $display("=================================================\n");
        $finish;
    end

endmodule

`default_nettype wire
