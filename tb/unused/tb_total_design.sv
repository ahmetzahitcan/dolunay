// =============================================================================
// tb_shuffle_any.sv — Basic testbench for shuffle_any
// =============================================================================
`timescale 1ns/1ps
`default_nettype none

module tb_total_design;
    import tb_config_pkg::RST_CYCLES;

    // RST_CYCLES is imported from tb_config_pkg — edit tb_config_pkg.sv

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic                 clk     = 0;
    logic                 rst_n   = 0;

    logic                 start_r;
    logic                 ready_w;

    // -----------------------------------------------------------------------
    // Clock: 10 ns period
    // -----------------------------------------------------------------------
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT
    // -----------------------------------------------------------------------

    total_design_wrapper dut(
        .sys_clk(clk),
        .reset(~rst_n),
        .usb_uart_rxd(1'b1), 
        .btn(start_r),
        .led(ready_w)
    );

    initial begin
        // Hold reset low for at least RST_CYCLES clock cycles
        start_r = 1'b0;
        rst_n = 0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1;

        repeat (5000) @(posedge clk);

        @(posedge clk);
        start_r = 1'b1;
        repeat (5000) @(posedge clk);
        start_r = 1'b0;

        wait (ready_w);
        $finish;
    end


endmodule

`default_nettype wire