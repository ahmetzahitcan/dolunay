// =============================================================================
// tb_shuffle_any.sv — Basic testbench for shuffle_any
// =============================================================================
`timescale 1ns/1ps

module tb_pipeline;
    import tb_config_pkg::RST_CYCLES;

    // RST_CYCLES is imported from tb_config_pkg — edit tb_config_pkg.sv

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic                 clk     = 0;
    logic                 rst_n   = 0;

    // -----------------------------------------------------------------------
    // Clock: 10 ns period
    // -----------------------------------------------------------------------
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // DUT
    // -----------------------------------------------------------------------
    pipeline dut(
        .clk(clk),
        .rst_n(rst_n)
    );

    initial begin
        // Hold reset low for at least RST_CYCLES clock cycles
        rst_n = 0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1;
    end


endmodule
