// =============================================================================
// tb_shuffle_any.sv — Basic testbench for shuffle_any
// =============================================================================
//

`timescale 1ns/1ps
`default_nettype none

module tb_core_top;
    import tb_config_pkg::RST_CYCLES;
    import params_pkg::*;

    // RST_CYCLES is imported from tb_config_pkg — edit tb_config_pkg.sv

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic                 clk     = 0;
    logic                 rst_n   = 0;

   // logic                 start_r;
   // logic                 ready_w;

    // -----------------------------------------------------------------------
    // Clock: 10 ns period
    // -----------------------------------------------------------------------
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT
    // -----------------------------------------------------------------------

    localparam int IROM_SIZE = 65536;
    localparam int WRAM_SIZE = 65536;

    localparam int W_WRAM_ADDR = $clog2(WRAM_SIZE);
    localparam int W_IROM_ADDR = $clog2(IROM_SIZE);

    // WRAM Interface
    logic [W_WRAM_ADDR-1:Z_ADDR] wram_addr_w;
    logic [RLEN-1:0] wram_wdata_w;
    logic [ADDR_ALIGN-1:0] wram_wen_w;
    logic [RLEN-1:0] wram_rdata_w;

    // IROM Interface A
    logic [W_IROM_ADDR-1:Z_PC] irom_addr_a_w;
    logic [RLEN-1:0] irom_data_a_w;

    // IROM Interface B
    logic [W_IROM_ADDR-1:Z_PC] irom_addr_b_w;
    logic [RLEN-1:0] irom_data_b_w;

    core_top #(
    	.WRAM_SIZE(WRAM_SIZE),
    	.IROM_SIZE(IROM_SIZE)
     ) dut (
	.clk          (clk),
	.rst_n        (rst_n),
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

    initial begin
        $dumpfile("tb_core_top.fst");
        $dumpvars(0, tb_core_top);

        // Hold reset low for at least RST_CYCLES clock cycles
        //start_r = 1'b1;
        rst_n = 0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1;

        /*
        @(posedge clk);
        start_r = 1'b1;
        @(posedge clk);
        start_r = 1'b0;
        */

        repeat (1000) @(posedge clk); //wait (ready_w);
        $finish;
    end


endmodule

`default_nettype wire
