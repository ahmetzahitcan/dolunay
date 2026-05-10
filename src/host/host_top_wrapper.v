`default_nettype none

module host_top_wrapper 
#(
    parameter W_ADDR = 32,
    parameter MEM_DELAY = 2
) (
    // -------------------------------------------------------------------------
    // Clock - associated with M_AXI bus and rst_n reset
    // -------------------------------------------------------------------------
    (* X_INTERFACE_INFO      = "xilinx.com:signal:clock:1.0 clk CLK"             *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF M_AXI, ASSOCIATED_RESET rst_n" *)
    input  wire        clk,

    // -------------------------------------------------------------------------
    // Active-low reset
    // -------------------------------------------------------------------------
    (* X_INTERFACE_INFO      = "xilinx.com:signal:reset:1.0 rst_n RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW"                    *)
    input  wire        rst_n,

    // -------------------------------------------------------------------------
    // AXI-Lite Master - Vivado infers the full interface from these attributes
    // -------------------------------------------------------------------------

    // Write address channel
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWADDR"  *) output wire [6:0]  m_axi_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWPROT"  *) output wire [2:0]  m_axi_awprot,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWVALID" *) output wire        m_axi_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWREADY" *) input  wire        m_axi_awready,

    // Write data channel
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WDATA"   *) output wire [31:0] m_axi_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WSTRB"   *) output wire [3:0]  m_axi_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WVALID"  *) output wire        m_axi_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WREADY"  *) input  wire        m_axi_wready,

    // Write response channel
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BRESP"   *) input  wire [1:0]  m_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BVALID"  *) input  wire        m_axi_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BREADY"  *) output wire        m_axi_bready,

    // Read address channel
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARADDR"  *) output wire [6:0]  m_axi_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARPROT"  *) output wire [2:0]  m_axi_arprot,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARVALID" *) output wire        m_axi_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARREADY" *) input  wire        m_axi_arready,

    // Read data channel
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RDATA"   *) input  wire [31:0] m_axi_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RRESP"   *) input  wire [1:0]  m_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RVALID"  *) input  wire        m_axi_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RREADY"  *) output wire        m_axi_rready,
    
    // Memory interface
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM CLK" *)  output  wire        mem_clk,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM ADDR" *) output wire [W_ADDR-1:0] mem_addr_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM DOUT"  *) input  wire [31:0] mem_dout_i,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM DIN"   *) output wire [31:0] mem_din_o,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM WE"    *) output wire        mem_we_o,

    input wire start_i,
    output wire ready_o,

    output wire simt_start_o,
    input  wire simt_ready_i
);

    assign mem_clk = clk;

    // AWPROT and ARPROT are driven to 0 (unprivileged, non-secure, data access)
    assign m_axi_awprot = 3'b000;
    assign m_axi_arprot = 3'b000;

    host_top_new #(
        .W_ADDR(W_ADDR),
        .MEM_DELAY(MEM_DELAY)
    ) u_host_top (
        .clk(clk),
        .rst_n(rst_n),
        .simt_start_o(simt_start_o),
        .simt_ready_i(simt_ready_i),
        .m_axi_awaddr_o(m_axi_awaddr),
        .m_axi_awvalid_o(m_axi_awvalid),
        .m_axi_awready_i(m_axi_awready),
        .m_axi_wdata_o(m_axi_wdata),
        .m_axi_wstrb_o(m_axi_wstrb),
        .m_axi_wvalid_o(m_axi_wvalid),
        .m_axi_wready_i(m_axi_wready),
        .m_axi_bresp_i(m_axi_bresp),
        .m_axi_bvalid_i(m_axi_bvalid),
        .m_axi_bready_o(m_axi_bready),
        .m_axi_araddr_o(m_axi_araddr),
        .m_axi_arvalid_o(m_axi_arvalid),
        .m_axi_arready_i(m_axi_arready),
        .m_axi_rdata_i(m_axi_rdata),
        .m_axi_rresp_i(m_axi_rresp),
        .m_axi_rvalid_i(m_axi_rvalid),
        .m_axi_rready_o(m_axi_rready),
        .block_mem_addr_o(mem_addr_o),
        .block_mem_dout_i(mem_dout_i),
        .block_mem_din_o(mem_din_o),
        .block_mem_we_o(mem_we_o),
        .start_i(start_i),
        .ready_o(ready_o)
    );

    reg start_last;
    wire start;
    assign start = ~start_last & start_i;

    always @(posedge clk) begin
        if (~rst_n) begin
            start_last <= 1'b0;
        end else begin
            start_last <= start_i;
        end
    end

endmodule

`default_nettype wire