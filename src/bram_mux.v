`default_nettype none

module bram_mux 
#(
    parameter ADDR_WIDTH = 32
) (
    input  wire sel,

    // Port 0
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_0 CLK" *)   input  wire        clk0,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_0 EN" *)    input  wire        en0,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_0 WE" *)    input  wire [3:0]  we0,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_0 ADDR" *)  input  wire [ADDR_WIDTH-1:0] addr0,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_0 DIN" *)   input  wire [31:0] din0,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_0 DOUT" *)  output wire [31:0] dout0,

    // Port 1
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_1 CLK" *)   input  wire        clk1,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_1 EN" *)    input  wire        en1,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_1 WE" *)    input  wire [3:0]  we1,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_1 ADDR" *)  input  wire [ADDR_WIDTH-1:0] addr1,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_1 DIN" *)   input  wire [31:0] din1,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_1 DOUT" *)  output wire [31:0] dout1,

    // Output Interface
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_OUT CLK" *)  output wire clk_out,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_OUT EN" *)   output wire en_out,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_OUT WE" *)   output wire [3:0]  we_out,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_OUT ADDR" *) output wire [ADDR_WIDTH-1:0] addr_out,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_OUT DIN" *)  output wire [31:0] din_out,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_OUT DOUT" *) input  wire [31:0] dout_out
);

    assign clk_out  = sel ? clk1  : clk0;
    assign en_out   = sel ? en1   : en0;
    assign we_out   = sel ? we1   : we0;
    assign addr_out = sel ? addr1 : addr0;
    assign din_out  = sel ? din1  : din0;

    assign dout0    = dout_out;
    assign dout1    = dout_out;

endmodule

`default_nettype wire