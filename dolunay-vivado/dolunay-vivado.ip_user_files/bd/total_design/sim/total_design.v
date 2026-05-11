//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
//Date        : Sun May 10 22:12:21 2026
//Host        : fedora running 64-bit unknown
//Command     : generate_target total_design.bd
//Design      : total_design
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "total_design,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=total_design,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,da_board_cnt=6,da_clkrst_cnt=2,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "total_design.hwdef" *) 
module total_design
   (btn,
    led,
    led2,
    reset,
    sys_clk,
    usb_uart_rxd,
    usb_uart_txd);
  input btn;
  output led;
  output led2;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input reset;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLK, CLK_DOMAIN total_design_sys_clk, FREQ_HZ 12000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input sys_clk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 usb_uart RxD" *) (* X_INTERFACE_MODE = "Master" *) input usb_uart_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 usb_uart TxD" *) output usb_uart_txd;

  wire clk_wiz_clk_out1;
  wire clk_wiz_locked;
  wire [13:2]core_top_0_IROM_A_ADDR;
  wire core_top_0_IROM_A_CLK;
  wire [31:0]core_top_0_IROM_A_DOUT;
  wire [13:2]core_top_0_IROM_B_ADDR;
  wire core_top_0_IROM_B_CLK;
  wire [31:0]core_top_0_IROM_B_DOUT;
  wire [14:2]core_top_0_WRAM_ADDR;
  wire core_top_0_WRAM_CLK;
  wire [31:0]core_top_0_WRAM_DIN;
  wire [31:0]core_top_0_WRAM_DOUT;
  wire [3:0]core_top_0_WRAM_WE;
  wire core_top_0_ready_o;
  wire [12:0]host_top_wrapper_0_MEM_ADDR;
  wire host_top_wrapper_0_MEM_CLK;
  wire [31:0]host_top_wrapper_0_MEM_DIN;
  wire [31:0]host_top_wrapper_0_MEM_DOUT;
  wire host_top_wrapper_0_MEM_WE;
  wire [6:0]host_top_wrapper_0_M_AXI_ARADDR;
  wire host_top_wrapper_0_M_AXI_ARREADY;
  wire host_top_wrapper_0_M_AXI_ARVALID;
  wire [6:0]host_top_wrapper_0_M_AXI_AWADDR;
  wire host_top_wrapper_0_M_AXI_AWREADY;
  wire host_top_wrapper_0_M_AXI_AWVALID;
  wire host_top_wrapper_0_M_AXI_BREADY;
  wire [1:0]host_top_wrapper_0_M_AXI_BRESP;
  wire host_top_wrapper_0_M_AXI_BVALID;
  wire [31:0]host_top_wrapper_0_M_AXI_RDATA;
  wire host_top_wrapper_0_M_AXI_RREADY;
  wire [1:0]host_top_wrapper_0_M_AXI_RRESP;
  wire host_top_wrapper_0_M_AXI_RVALID;
  wire [31:0]host_top_wrapper_0_M_AXI_WDATA;
  wire host_top_wrapper_0_M_AXI_WREADY;
  wire [3:0]host_top_wrapper_0_M_AXI_WSTRB;
  wire host_top_wrapper_0_M_AXI_WVALID;
  wire host_top_wrapper_0_simt_start_o;
  wire led;
  wire led2;
  wire reset;
  wire [0:0]rst_clk_wiz_100M_peripheral_aresetn;
  wire sys_clk;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  assign led2 = btn;
  total_design_axi_uartlite_0_0 axi_uartlite_0
       (.rx(usb_uart_rxd),
        .s_axi_aclk(clk_wiz_clk_out1),
        .s_axi_araddr(host_top_wrapper_0_M_AXI_ARADDR[3:0]),
        .s_axi_aresetn(rst_clk_wiz_100M_peripheral_aresetn),
        .s_axi_arready(host_top_wrapper_0_M_AXI_ARREADY),
        .s_axi_arvalid(host_top_wrapper_0_M_AXI_ARVALID),
        .s_axi_awaddr(host_top_wrapper_0_M_AXI_AWADDR[3:0]),
        .s_axi_awready(host_top_wrapper_0_M_AXI_AWREADY),
        .s_axi_awvalid(host_top_wrapper_0_M_AXI_AWVALID),
        .s_axi_bready(host_top_wrapper_0_M_AXI_BREADY),
        .s_axi_bresp(host_top_wrapper_0_M_AXI_BRESP),
        .s_axi_bvalid(host_top_wrapper_0_M_AXI_BVALID),
        .s_axi_rdata(host_top_wrapper_0_M_AXI_RDATA),
        .s_axi_rready(host_top_wrapper_0_M_AXI_RREADY),
        .s_axi_rresp(host_top_wrapper_0_M_AXI_RRESP),
        .s_axi_rvalid(host_top_wrapper_0_M_AXI_RVALID),
        .s_axi_wdata(host_top_wrapper_0_M_AXI_WDATA),
        .s_axi_wready(host_top_wrapper_0_M_AXI_WREADY),
        .s_axi_wstrb(host_top_wrapper_0_M_AXI_WSTRB),
        .s_axi_wvalid(host_top_wrapper_0_M_AXI_WVALID),
        .tx(usb_uart_txd));
  total_design_clk_wiz_0 clk_wiz
       (.clk_in1(sys_clk),
        .clk_out1(clk_wiz_clk_out1),
        .locked(clk_wiz_locked),
        .reset(reset));
  total_design_core_top_0_0 core_top_0
       (.clk(clk_wiz_clk_out1),
        .irom_addr_a_o(core_top_0_IROM_A_ADDR),
        .irom_addr_b_o(core_top_0_IROM_B_ADDR),
        .irom_clk_a_o(core_top_0_IROM_A_CLK),
        .irom_clk_b_o(core_top_0_IROM_B_CLK),
        .irom_data_a_i(core_top_0_IROM_A_DOUT),
        .irom_data_b_i(core_top_0_IROM_B_DOUT),
        .ready_o(core_top_0_ready_o),
        .rst_n(rst_clk_wiz_100M_peripheral_aresetn),
        .start_i(host_top_wrapper_0_simt_start_o),
        .wram_addr_o(core_top_0_WRAM_ADDR),
        .wram_clk_o(core_top_0_WRAM_CLK),
        .wram_rdata_i(core_top_0_WRAM_DOUT),
        .wram_wdata_o(core_top_0_WRAM_DIN),
        .wram_wen_o(core_top_0_WRAM_WE));
  total_design_host_top_wrapper_0_0 host_top_wrapper_0
       (.clk(clk_wiz_clk_out1),
        .m_axi_araddr(host_top_wrapper_0_M_AXI_ARADDR),
        .m_axi_arready(host_top_wrapper_0_M_AXI_ARREADY),
        .m_axi_arvalid(host_top_wrapper_0_M_AXI_ARVALID),
        .m_axi_awaddr(host_top_wrapper_0_M_AXI_AWADDR),
        .m_axi_awready(host_top_wrapper_0_M_AXI_AWREADY),
        .m_axi_awvalid(host_top_wrapper_0_M_AXI_AWVALID),
        .m_axi_bready(host_top_wrapper_0_M_AXI_BREADY),
        .m_axi_bresp(host_top_wrapper_0_M_AXI_BRESP),
        .m_axi_bvalid(host_top_wrapper_0_M_AXI_BVALID),
        .m_axi_rdata(host_top_wrapper_0_M_AXI_RDATA),
        .m_axi_rready(host_top_wrapper_0_M_AXI_RREADY),
        .m_axi_rresp(host_top_wrapper_0_M_AXI_RRESP),
        .m_axi_rvalid(host_top_wrapper_0_M_AXI_RVALID),
        .m_axi_wdata(host_top_wrapper_0_M_AXI_WDATA),
        .m_axi_wready(host_top_wrapper_0_M_AXI_WREADY),
        .m_axi_wstrb(host_top_wrapper_0_M_AXI_WSTRB),
        .m_axi_wvalid(host_top_wrapper_0_M_AXI_WVALID),
        .mem_addr_o(host_top_wrapper_0_MEM_ADDR),
        .mem_clk(host_top_wrapper_0_MEM_CLK),
        .mem_din_o(host_top_wrapper_0_MEM_DIN),
        .mem_dout_i(host_top_wrapper_0_MEM_DOUT),
        .mem_we_o(host_top_wrapper_0_MEM_WE),
        .ready_o(led),
        .rst_n(rst_clk_wiz_100M_peripheral_aresetn),
        .simt_ready_i(core_top_0_ready_o),
        .simt_start_o(host_top_wrapper_0_simt_start_o),
        .start_i(led2));
  total_design_blk_mem_gen_0_0 irom
       (.addra(core_top_0_IROM_A_ADDR[12:2]),
        .addrb(core_top_0_IROM_B_ADDR[12:2]),
        .clka(core_top_0_IROM_A_CLK),
        .clkb(core_top_0_IROM_B_CLK),
        .douta(core_top_0_IROM_A_DOUT),
        .doutb(core_top_0_IROM_B_DOUT));
  total_design_rst_clk_wiz_100M_0 rst_clk_wiz
       (.aux_reset_in(1'b1),
        .dcm_locked(clk_wiz_locked),
        .ext_reset_in(reset),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(rst_clk_wiz_100M_peripheral_aresetn),
        .slowest_sync_clk(clk_wiz_clk_out1));
  total_design_blk_mem_gen_1_0 wram
       (.addra(core_top_0_WRAM_ADDR),
        .addrb(host_top_wrapper_0_MEM_ADDR),
        .clka(core_top_0_WRAM_CLK),
        .clkb(host_top_wrapper_0_MEM_CLK),
        .dina(core_top_0_WRAM_DIN),
        .dinb(host_top_wrapper_0_MEM_DIN),
        .douta(core_top_0_WRAM_DOUT),
        .doutb(host_top_wrapper_0_MEM_DOUT),
        .wea(core_top_0_WRAM_WE),
        .web({host_top_wrapper_0_MEM_WE,host_top_wrapper_0_MEM_WE,host_top_wrapper_0_MEM_WE,host_top_wrapper_0_MEM_WE}));
endmodule
