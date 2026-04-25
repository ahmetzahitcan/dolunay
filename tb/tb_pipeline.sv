// =============================================================================
// tb_shuffle_any.sv — Basic testbench for shuffle_any
// =============================================================================
`timescale 1ns/1ps
`default_nettype none

module tb_pipeline;
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

    localparam int IROM_SIZE = 4096;
    localparam int WRAM_SIZE = 65536;

    pipeline #(.IROM_SIZE(IROM_SIZE), .WRAM_SIZE(WRAM_SIZE)) dut(
        .clk(clk),
        .rst_n(rst_n),

        .start_i(start_r),
        .ready_o(ready_w)
    );

    ram #(.DEPTH(WRAM_SIZE / 4)) u_wram (
        .clk(clk),
        .addr_i(dut.wram_addr_o),
        .wdata_i(dut.wram_wdata_o),
        .wen_i(dut.wram_wen_o),
        .rdata_o(dut.wram_rdata_i)
    );

    irom #(.IROM_SIZE(IROM_SIZE)) u_irom (
        .clk(clk),
        .port_a_addr_i(dut.irom_addr_a_o),
        .port_a_data_o(dut.irom_data_a_i),
        .port_b_addr_i(dut.irom_addr_b_o),
        .port_b_data_o(dut.irom_data_b_i)
    );

    initial begin
        // Hold reset low for at least RST_CYCLES clock cycles
        start_r = 1'b1;
        rst_n = 0;
        repeat (RST_CYCLES) @(posedge clk);
        rst_n = 1;

        @(posedge clk);
        start_r = 1'b1;
        @(posedge clk);
        start_r = 1'b0;

        wait (ready_w);
        $finish;
    end


endmodule

`default_nettype wire