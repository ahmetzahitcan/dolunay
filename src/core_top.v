`default_nettype none

module core_top
#(
    parameter W_WRAM_ADDR = 16,
    parameter W_IROM_ADDR = 12
) (
    input wire clk,
    input wire rst_n,

    // WRAM Interface
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM CLK" *) output wire wram_clk_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM ADDR" *) output wire [W_WRAM_ADDR-1:2] wram_addr_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM WE" *)   output wire [3:0] wram_wen_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM DIN" *)  output wire [31:0] wram_wdata_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM DOUT" *) input  wire [31:0] wram_rdata_i,

    // IROM Interface A
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_A CLK" *) output wire irom_clk_a_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_A ADDR" *) output wire [W_IROM_ADDR-1:2] irom_addr_a_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_A DOUT" *) input  wire [31:0] irom_data_a_i,

    // IROM Interface B
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_B CLK" *) output wire irom_clk_b_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_B ADDR" *) output wire [W_IROM_ADDR-1:2] irom_addr_b_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_B DOUT" *) input  wire [31:0] irom_data_b_i
);
    assign wram_clk_o = clk;
    assign irom_clk_a_o = clk;
    assign irom_clk_b_o = clk;

    pipeline #(
        .WRAM_SIZE(1 << W_WRAM_ADDR),
        .IROM_SIZE(1 << W_IROM_ADDR)
    ) u_pipeline (
        .clk(clk),
        .rst_n(rst_n),
        
        // WRAM Interface
        .wram_addr_o(wram_addr_o),
        .wram_wdata_o(wram_wdata_o),
        .wram_wen_o(wram_wen_o),
        .wram_rdata_i(wram_rdata_i),

        // IROM Interface A
        .irom_addr_a_o(irom_addr_a_o),
        .irom_data_a_i(irom_data_a_i),

        // IROM Interface B
        .irom_addr_b_o(irom_addr_b_o),
        .irom_data_b_i(irom_data_b_i)
    );

endmodule

`default_nettype wire