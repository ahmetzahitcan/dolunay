// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Wed Apr 22 17:59:06 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/azc/Belgeler/dolunay/bd/cmod_a7_35t/ip/cmod_a7_35t_axi_bram_ctrl_0_0/cmod_a7_35t_axi_bram_ctrl_0_0_sim_netlist.v
// Design      : cmod_a7_35t_axi_bram_ctrl_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "cmod_a7_35t_axi_bram_ctrl_0_0,axi_bram_ctrl,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "axi_bram_ctrl,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module cmod_a7_35t_axi_bram_ctrl_0_0
   (s_axi_aclk,
    s_axi_aresetn,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    bram_rst_a,
    bram_clk_a,
    bram_en_a,
    bram_we_a,
    bram_addr_a,
    bram_wrdata_a,
    bram_rddata_a);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLKIF CLK" *) (* x_interface_mode = "slave CLKIF" *) (* x_interface_parameter = "XIL_INTERFACENAME CLKIF, ASSOCIATED_BUSIF S_AXI:S_AXI_CTRL, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 12000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input s_axi_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RSTIF RST" *) (* x_interface_mode = "slave RSTIF" *) (* x_interface_parameter = "XIL_INTERFACENAME RSTIF, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_aresetn;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *) (* x_interface_mode = "slave S_AXI" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 12000000, ID_WIDTH 0, ADDR_WIDTH 13, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [12:0]s_axi_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWLEN" *) input [7:0]s_axi_awlen;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWSIZE" *) input [2:0]s_axi_awsize;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWBURST" *) input [1:0]s_axi_awburst;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWLOCK" *) input s_axi_awlock;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWCACHE" *) input [3:0]s_axi_awcache;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWPROT" *) input [2:0]s_axi_awprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *) input s_axi_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *) output s_axi_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *) input [31:0]s_axi_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *) input [3:0]s_axi_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WLAST" *) input s_axi_wlast;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *) input s_axi_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *) output s_axi_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *) output [1:0]s_axi_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *) output s_axi_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *) input s_axi_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *) input [12:0]s_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARLEN" *) input [7:0]s_axi_arlen;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARSIZE" *) input [2:0]s_axi_arsize;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARBURST" *) input [1:0]s_axi_arburst;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARLOCK" *) input s_axi_arlock;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARCACHE" *) input [3:0]s_axi_arcache;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARPROT" *) input [2:0]s_axi_arprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *) input s_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *) output s_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *) output [31:0]s_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *) output [1:0]s_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RLAST" *) output s_axi_rlast;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *) output s_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *) input s_axi_rready;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) (* x_interface_mode = "master BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MASTER_TYPE BRAM_CTRL, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, READ_WRITE_MODE READ_WRITE, READ_LATENCY 2" *) output bram_rst_a;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) output bram_clk_a;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) output bram_en_a;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) output [3:0]bram_we_a;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) output [12:0]bram_addr_a;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) output [31:0]bram_wrdata_a;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) input [31:0]bram_rddata_a;

  wire \<const0> ;
  wire [12:2]\^bram_addr_a ;
  wire bram_clk_a;
  wire bram_en_a;
  wire [31:0]bram_rddata_a;
  wire bram_rst_a;
  wire [3:0]bram_we_a;
  wire [31:0]bram_wrdata_a;
  wire s_axi_aclk;
  wire [12:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire s_axi_aresetn;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [12:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire NLW_U0_bram_clk_b_UNCONNECTED;
  wire NLW_U0_bram_en_b_UNCONNECTED;
  wire NLW_U0_bram_rst_b_UNCONNECTED;
  wire NLW_U0_ecc_interrupt_UNCONNECTED;
  wire NLW_U0_ecc_ue_UNCONNECTED;
  wire NLW_U0_s_axi_ctrl_arready_UNCONNECTED;
  wire NLW_U0_s_axi_ctrl_awready_UNCONNECTED;
  wire NLW_U0_s_axi_ctrl_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_ctrl_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_ctrl_wready_UNCONNECTED;
  wire [1:0]NLW_U0_bram_addr_a_UNCONNECTED;
  wire [12:0]NLW_U0_bram_addr_b_UNCONNECTED;
  wire [3:0]NLW_U0_bram_we_b_UNCONNECTED;
  wire [31:0]NLW_U0_bram_wrdata_b_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_ctrl_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_ctrl_rdata_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_ctrl_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  assign bram_addr_a[12:2] = \^bram_addr_a [12:2];
  assign bram_addr_a[1] = \<const0> ;
  assign bram_addr_a[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_BRAM_ADDR_WIDTH = "11" *) 
  (* C_BRAM_INST_MODE = "EXTERNAL" *) 
  (* C_ECC = "0" *) 
  (* C_ECC_ONOFF_RESET_VALUE = "0" *) 
  (* C_ECC_TYPE = "0" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_FAULT_INJECT = "0" *) 
  (* C_MEMORY_DEPTH = "2048" *) 
  (* C_RD_CMD_OPTIMIZATION = "0" *) 
  (* C_READ_LATENCY = "2" *) 
  (* C_SINGLE_PORT_BRAM = "1" *) 
  (* C_S_AXI_ADDR_WIDTH = "13" *) 
  (* C_S_AXI_CTRL_ADDR_WIDTH = "32" *) 
  (* C_S_AXI_CTRL_DATA_WIDTH = "32" *) 
  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_S_AXI_ID_WIDTH = "1" *) 
  (* C_S_AXI_PROTOCOL = "AXI4" *) 
  (* C_S_AXI_SUPPORTS_NARROW_BURST = "0" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  cmod_a7_35t_axi_bram_ctrl_0_0_axi_bram_ctrl U0
       (.bram_addr_a({\^bram_addr_a ,NLW_U0_bram_addr_a_UNCONNECTED[1:0]}),
        .bram_addr_b(NLW_U0_bram_addr_b_UNCONNECTED[12:0]),
        .bram_clk_a(bram_clk_a),
        .bram_clk_b(NLW_U0_bram_clk_b_UNCONNECTED),
        .bram_en_a(bram_en_a),
        .bram_en_b(NLW_U0_bram_en_b_UNCONNECTED),
        .bram_rddata_a(bram_rddata_a),
        .bram_rddata_b({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .bram_rst_a(bram_rst_a),
        .bram_rst_b(NLW_U0_bram_rst_b_UNCONNECTED),
        .bram_we_a(bram_we_a),
        .bram_we_b(NLW_U0_bram_we_b_UNCONNECTED[3:0]),
        .bram_wrdata_a(bram_wrdata_a),
        .bram_wrdata_b(NLW_U0_bram_wrdata_b_UNCONNECTED[31:0]),
        .ecc_interrupt(NLW_U0_ecc_interrupt_UNCONNECTED),
        .ecc_ue(NLW_U0_ecc_ue_UNCONNECTED),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr({s_axi_araddr[12:2],1'b0,1'b0}),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_arcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arid(1'b0),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arlock(1'b0),
        .s_axi_arprot({1'b0,1'b0,1'b0}),
        .s_axi_arready(s_axi_arready),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr({s_axi_awaddr[12:2],1'b0,1'b0}),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awid(1'b0),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,s_axi_awlen[3:0]}),
        .s_axi_awlock(1'b0),
        .s_axi_awprot({1'b0,1'b0,1'b0}),
        .s_axi_awready(s_axi_awready),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[0]),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_ctrl_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_ctrl_arready(NLW_U0_s_axi_ctrl_arready_UNCONNECTED),
        .s_axi_ctrl_arvalid(1'b0),
        .s_axi_ctrl_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_ctrl_awready(NLW_U0_s_axi_ctrl_awready_UNCONNECTED),
        .s_axi_ctrl_awvalid(1'b0),
        .s_axi_ctrl_bready(1'b0),
        .s_axi_ctrl_bresp(NLW_U0_s_axi_ctrl_bresp_UNCONNECTED[1:0]),
        .s_axi_ctrl_bvalid(NLW_U0_s_axi_ctrl_bvalid_UNCONNECTED),
        .s_axi_ctrl_rdata(NLW_U0_s_axi_ctrl_rdata_UNCONNECTED[31:0]),
        .s_axi_ctrl_rready(1'b0),
        .s_axi_ctrl_rresp(NLW_U0_s_axi_ctrl_rresp_UNCONNECTED[1:0]),
        .s_axi_ctrl_rvalid(NLW_U0_s_axi_ctrl_rvalid_UNCONNECTED),
        .s_axi_ctrl_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_ctrl_wready(NLW_U0_s_axi_ctrl_wready_UNCONNECTED),
        .s_axi_ctrl_wvalid(1'b0),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[0]),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* C_BRAM_ADDR_WIDTH = "11" *) (* C_BRAM_INST_MODE = "EXTERNAL" *) (* C_ECC = "0" *) 
(* C_ECC_ONOFF_RESET_VALUE = "0" *) (* C_ECC_TYPE = "0" *) (* C_FAMILY = "artix7" *) 
(* C_FAULT_INJECT = "0" *) (* C_MEMORY_DEPTH = "2048" *) (* C_RD_CMD_OPTIMIZATION = "0" *) 
(* C_READ_LATENCY = "2" *) (* C_SINGLE_PORT_BRAM = "1" *) (* C_S_AXI_ADDR_WIDTH = "13" *) 
(* C_S_AXI_CTRL_ADDR_WIDTH = "32" *) (* C_S_AXI_CTRL_DATA_WIDTH = "32" *) (* C_S_AXI_DATA_WIDTH = "32" *) 
(* C_S_AXI_ID_WIDTH = "1" *) (* C_S_AXI_PROTOCOL = "AXI4" *) (* C_S_AXI_SUPPORTS_NARROW_BURST = "0" *) 
(* ORIG_REF_NAME = "axi_bram_ctrl" *) (* downgradeipidentifiedwarnings = "yes" *) 
module cmod_a7_35t_axi_bram_ctrl_0_0_axi_bram_ctrl
   (s_axi_aclk,
    s_axi_aresetn,
    ecc_interrupt,
    ecc_ue,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_ctrl_awvalid,
    s_axi_ctrl_awready,
    s_axi_ctrl_awaddr,
    s_axi_ctrl_wdata,
    s_axi_ctrl_wvalid,
    s_axi_ctrl_wready,
    s_axi_ctrl_bresp,
    s_axi_ctrl_bvalid,
    s_axi_ctrl_bready,
    s_axi_ctrl_araddr,
    s_axi_ctrl_arvalid,
    s_axi_ctrl_arready,
    s_axi_ctrl_rdata,
    s_axi_ctrl_rresp,
    s_axi_ctrl_rvalid,
    s_axi_ctrl_rready,
    bram_rst_a,
    bram_clk_a,
    bram_en_a,
    bram_we_a,
    bram_addr_a,
    bram_wrdata_a,
    bram_rddata_a,
    bram_rst_b,
    bram_clk_b,
    bram_en_b,
    bram_we_b,
    bram_addr_b,
    bram_wrdata_b,
    bram_rddata_b);
  input s_axi_aclk;
  input s_axi_aresetn;
  output ecc_interrupt;
  output ecc_ue;
  input [0:0]s_axi_awid;
  input [12:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awlock;
  input [3:0]s_axi_awcache;
  input [2:0]s_axi_awprot;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [0:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [0:0]s_axi_arid;
  input [12:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arlock;
  input [3:0]s_axi_arcache;
  input [2:0]s_axi_arprot;
  input s_axi_arvalid;
  output s_axi_arready;
  output [0:0]s_axi_rid;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_ctrl_awvalid;
  output s_axi_ctrl_awready;
  input [31:0]s_axi_ctrl_awaddr;
  input [31:0]s_axi_ctrl_wdata;
  input s_axi_ctrl_wvalid;
  output s_axi_ctrl_wready;
  output [1:0]s_axi_ctrl_bresp;
  output s_axi_ctrl_bvalid;
  input s_axi_ctrl_bready;
  input [31:0]s_axi_ctrl_araddr;
  input s_axi_ctrl_arvalid;
  output s_axi_ctrl_arready;
  output [31:0]s_axi_ctrl_rdata;
  output [1:0]s_axi_ctrl_rresp;
  output s_axi_ctrl_rvalid;
  input s_axi_ctrl_rready;
  output bram_rst_a;
  output bram_clk_a;
  output bram_en_a;
  output [3:0]bram_we_a;
  output [12:0]bram_addr_a;
  output [31:0]bram_wrdata_a;
  input [31:0]bram_rddata_a;
  output bram_rst_b;
  output bram_clk_b;
  output bram_en_b;
  output [3:0]bram_we_b;
  output [12:0]bram_addr_b;
  output [31:0]bram_wrdata_b;
  input [31:0]bram_rddata_b;

  wire \<const0> ;
  wire [12:2]\^bram_addr_a ;
  wire bram_en_a;
  wire [31:0]bram_rddata_a;
  wire bram_rst_a;
  wire [3:0]bram_we_a;
  wire [31:0]bram_wrdata_a;
  wire s_axi_aclk;
  wire [12:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire s_axi_aresetn;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [12:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;

  assign bram_addr_a[12:2] = \^bram_addr_a [12:2];
  assign bram_addr_a[1] = \<const0> ;
  assign bram_addr_a[0] = \<const0> ;
  assign bram_addr_b[12] = \<const0> ;
  assign bram_addr_b[11] = \<const0> ;
  assign bram_addr_b[10] = \<const0> ;
  assign bram_addr_b[9] = \<const0> ;
  assign bram_addr_b[8] = \<const0> ;
  assign bram_addr_b[7] = \<const0> ;
  assign bram_addr_b[6] = \<const0> ;
  assign bram_addr_b[5] = \<const0> ;
  assign bram_addr_b[4] = \<const0> ;
  assign bram_addr_b[3] = \<const0> ;
  assign bram_addr_b[2] = \<const0> ;
  assign bram_addr_b[1] = \<const0> ;
  assign bram_addr_b[0] = \<const0> ;
  assign bram_clk_a = s_axi_aclk;
  assign bram_clk_b = \<const0> ;
  assign bram_en_b = \<const0> ;
  assign bram_rst_b = \<const0> ;
  assign bram_we_b[3] = \<const0> ;
  assign bram_we_b[2] = \<const0> ;
  assign bram_we_b[1] = \<const0> ;
  assign bram_we_b[0] = \<const0> ;
  assign bram_wrdata_b[31] = \<const0> ;
  assign bram_wrdata_b[30] = \<const0> ;
  assign bram_wrdata_b[29] = \<const0> ;
  assign bram_wrdata_b[28] = \<const0> ;
  assign bram_wrdata_b[27] = \<const0> ;
  assign bram_wrdata_b[26] = \<const0> ;
  assign bram_wrdata_b[25] = \<const0> ;
  assign bram_wrdata_b[24] = \<const0> ;
  assign bram_wrdata_b[23] = \<const0> ;
  assign bram_wrdata_b[22] = \<const0> ;
  assign bram_wrdata_b[21] = \<const0> ;
  assign bram_wrdata_b[20] = \<const0> ;
  assign bram_wrdata_b[19] = \<const0> ;
  assign bram_wrdata_b[18] = \<const0> ;
  assign bram_wrdata_b[17] = \<const0> ;
  assign bram_wrdata_b[16] = \<const0> ;
  assign bram_wrdata_b[15] = \<const0> ;
  assign bram_wrdata_b[14] = \<const0> ;
  assign bram_wrdata_b[13] = \<const0> ;
  assign bram_wrdata_b[12] = \<const0> ;
  assign bram_wrdata_b[11] = \<const0> ;
  assign bram_wrdata_b[10] = \<const0> ;
  assign bram_wrdata_b[9] = \<const0> ;
  assign bram_wrdata_b[8] = \<const0> ;
  assign bram_wrdata_b[7] = \<const0> ;
  assign bram_wrdata_b[6] = \<const0> ;
  assign bram_wrdata_b[5] = \<const0> ;
  assign bram_wrdata_b[4] = \<const0> ;
  assign bram_wrdata_b[3] = \<const0> ;
  assign bram_wrdata_b[2] = \<const0> ;
  assign bram_wrdata_b[1] = \<const0> ;
  assign bram_wrdata_b[0] = \<const0> ;
  assign ecc_interrupt = \<const0> ;
  assign ecc_ue = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_ctrl_arready = \<const0> ;
  assign s_axi_ctrl_awready = \<const0> ;
  assign s_axi_ctrl_bresp[1] = \<const0> ;
  assign s_axi_ctrl_bresp[0] = \<const0> ;
  assign s_axi_ctrl_bvalid = \<const0> ;
  assign s_axi_ctrl_rdata[31] = \<const0> ;
  assign s_axi_ctrl_rdata[30] = \<const0> ;
  assign s_axi_ctrl_rdata[29] = \<const0> ;
  assign s_axi_ctrl_rdata[28] = \<const0> ;
  assign s_axi_ctrl_rdata[27] = \<const0> ;
  assign s_axi_ctrl_rdata[26] = \<const0> ;
  assign s_axi_ctrl_rdata[25] = \<const0> ;
  assign s_axi_ctrl_rdata[24] = \<const0> ;
  assign s_axi_ctrl_rdata[23] = \<const0> ;
  assign s_axi_ctrl_rdata[22] = \<const0> ;
  assign s_axi_ctrl_rdata[21] = \<const0> ;
  assign s_axi_ctrl_rdata[20] = \<const0> ;
  assign s_axi_ctrl_rdata[19] = \<const0> ;
  assign s_axi_ctrl_rdata[18] = \<const0> ;
  assign s_axi_ctrl_rdata[17] = \<const0> ;
  assign s_axi_ctrl_rdata[16] = \<const0> ;
  assign s_axi_ctrl_rdata[15] = \<const0> ;
  assign s_axi_ctrl_rdata[14] = \<const0> ;
  assign s_axi_ctrl_rdata[13] = \<const0> ;
  assign s_axi_ctrl_rdata[12] = \<const0> ;
  assign s_axi_ctrl_rdata[11] = \<const0> ;
  assign s_axi_ctrl_rdata[10] = \<const0> ;
  assign s_axi_ctrl_rdata[9] = \<const0> ;
  assign s_axi_ctrl_rdata[8] = \<const0> ;
  assign s_axi_ctrl_rdata[7] = \<const0> ;
  assign s_axi_ctrl_rdata[6] = \<const0> ;
  assign s_axi_ctrl_rdata[5] = \<const0> ;
  assign s_axi_ctrl_rdata[4] = \<const0> ;
  assign s_axi_ctrl_rdata[3] = \<const0> ;
  assign s_axi_ctrl_rdata[2] = \<const0> ;
  assign s_axi_ctrl_rdata[1] = \<const0> ;
  assign s_axi_ctrl_rdata[0] = \<const0> ;
  assign s_axi_ctrl_rresp[1] = \<const0> ;
  assign s_axi_ctrl_rresp[0] = \<const0> ;
  assign s_axi_ctrl_rvalid = \<const0> ;
  assign s_axi_ctrl_wready = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  cmod_a7_35t_axi_bram_ctrl_0_0_axi_bram_ctrl_top \gext_inst.abcv4_0_ext_inst 
       (.\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg (s_axi_rlast),
        .\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg (s_axi_rvalid),
        .axi_bvalid_int_reg(s_axi_bvalid),
        .bram_addr_a(\^bram_addr_a ),
        .bram_en_a(bram_en_a),
        .bram_rddata_a(bram_rddata_a),
        .bram_we_a(bram_we_a),
        .bram_wrdata_a(bram_wrdata_a),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr[12:2]),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_aresetn_0(bram_rst_a),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr[12:2]),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awlen(s_axi_awlen[3:0]),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "axi_bram_ctrl_top" *) 
module cmod_a7_35t_axi_bram_ctrl_0_0_axi_bram_ctrl_top
   (\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg ,
    \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg ,
    s_axi_aresetn_0,
    s_axi_awready,
    s_axi_arready,
    bram_addr_a,
    axi_bvalid_int_reg,
    bram_wrdata_a,
    s_axi_rdata,
    bram_en_a,
    bram_we_a,
    s_axi_wready,
    s_axi_aresetn,
    s_axi_wvalid,
    s_axi_rready,
    s_axi_arburst,
    s_axi_awvalid,
    s_axi_arvalid,
    s_axi_aclk,
    s_axi_wlast,
    s_axi_bready,
    s_axi_wstrb,
    s_axi_wdata,
    bram_rddata_a,
    s_axi_araddr,
    s_axi_awaddr,
    s_axi_arlen,
    s_axi_awlen,
    s_axi_awburst);
  output \GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg ;
  output \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg ;
  output s_axi_aresetn_0;
  output s_axi_awready;
  output s_axi_arready;
  output [10:0]bram_addr_a;
  output axi_bvalid_int_reg;
  output [31:0]bram_wrdata_a;
  output [31:0]s_axi_rdata;
  output bram_en_a;
  output [3:0]bram_we_a;
  output s_axi_wready;
  input s_axi_aresetn;
  input s_axi_wvalid;
  input s_axi_rready;
  input [1:0]s_axi_arburst;
  input s_axi_awvalid;
  input s_axi_arvalid;
  input s_axi_aclk;
  input s_axi_wlast;
  input s_axi_bready;
  input [3:0]s_axi_wstrb;
  input [31:0]s_axi_wdata;
  input [31:0]bram_rddata_a;
  input [10:0]s_axi_araddr;
  input [10:0]s_axi_awaddr;
  input [7:0]s_axi_arlen;
  input [3:0]s_axi_awlen;
  input [1:0]s_axi_awburst;

  wire \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg ;
  wire \GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg ;
  wire axi_bvalid_int_reg;
  wire [10:0]bram_addr_a;
  wire bram_en_a;
  wire [31:0]bram_rddata_a;
  wire [3:0]bram_we_a;
  wire [31:0]bram_wrdata_a;
  wire s_axi_aclk;
  wire [10:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire s_axi_aresetn;
  wire s_axi_aresetn_0;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [10:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awlen;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [31:0]s_axi_wdata;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;

  cmod_a7_35t_axi_bram_ctrl_0_0_full_axi \GEN_AXI4.I_FULL_AXI 
       (.\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg (\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg ),
        .\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg (\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg ),
        .SR(s_axi_aresetn_0),
        .axi_bvalid_int_reg(axi_bvalid_int_reg),
        .bram_addr_a(bram_addr_a),
        .bram_en_a(bram_en_a),
        .bram_rddata_a(bram_rddata_a),
        .bram_we_a(bram_we_a),
        .bram_wrdata_a(bram_wrdata_a),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "full_axi" *) 
module cmod_a7_35t_axi_bram_ctrl_0_0_full_axi
   (\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg ,
    \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg ,
    SR,
    s_axi_awready,
    s_axi_arready,
    bram_addr_a,
    axi_bvalid_int_reg,
    bram_wrdata_a,
    s_axi_rdata,
    bram_en_a,
    bram_we_a,
    s_axi_wready,
    s_axi_aresetn,
    s_axi_wvalid,
    s_axi_rready,
    s_axi_arburst,
    s_axi_awvalid,
    s_axi_arvalid,
    s_axi_aclk,
    s_axi_wlast,
    s_axi_bready,
    s_axi_wstrb,
    s_axi_wdata,
    bram_rddata_a,
    s_axi_araddr,
    s_axi_awaddr,
    s_axi_arlen,
    s_axi_awlen,
    s_axi_awburst);
  output \GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg ;
  output \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg ;
  output [0:0]SR;
  output s_axi_awready;
  output s_axi_arready;
  output [10:0]bram_addr_a;
  output axi_bvalid_int_reg;
  output [31:0]bram_wrdata_a;
  output [31:0]s_axi_rdata;
  output bram_en_a;
  output [3:0]bram_we_a;
  output s_axi_wready;
  input s_axi_aresetn;
  input s_axi_wvalid;
  input s_axi_rready;
  input [1:0]s_axi_arburst;
  input s_axi_awvalid;
  input s_axi_arvalid;
  input s_axi_aclk;
  input s_axi_wlast;
  input s_axi_bready;
  input [3:0]s_axi_wstrb;
  input [31:0]s_axi_wdata;
  input [31:0]bram_rddata_a;
  input [10:0]s_axi_araddr;
  input [10:0]s_axi_awaddr;
  input [7:0]s_axi_arlen;
  input [3:0]s_axi_awlen;
  input [1:0]s_axi_awburst;

  wire \ADDR_SNG_PORT.bram_addr_int[10]_i_2_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[11]_i_7_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[12]_i_1_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[4]_i_2_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[5]_i_2_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[7]_i_2_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[8]_i_2_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[9]_i_2_n_0 ;
  wire \ADDR_SNG_PORT.sng_bram_addr_ld_en ;
  wire AW2Arb_Active_Clr;
  wire Arb2AR_Active;
  wire Arb2AW_Active;
  wire BRAM_En_A_i;
  wire [3:0]BRAM_WE_A_i;
  wire \GEN_ARB.I_SNG_PORT_n_10 ;
  wire \GEN_ARB.I_SNG_PORT_n_11 ;
  wire \GEN_ARB.I_SNG_PORT_n_12 ;
  wire \GEN_ARB.I_SNG_PORT_n_16 ;
  wire \GEN_ARB.I_SNG_PORT_n_5 ;
  wire \GEN_ARB.I_SNG_PORT_n_6 ;
  wire \GEN_ARB.I_SNG_PORT_n_7 ;
  wire \GEN_ARB.I_SNG_PORT_n_8 ;
  wire \GEN_ARB.I_SNG_PORT_n_9 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg ;
  wire \GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg ;
  wire I_RD_CHNL_n_10;
  wire I_RD_CHNL_n_11;
  wire I_RD_CHNL_n_12;
  wire I_RD_CHNL_n_13;
  wire I_RD_CHNL_n_14;
  wire I_RD_CHNL_n_15;
  wire I_RD_CHNL_n_18;
  wire I_RD_CHNL_n_6;
  wire I_RD_CHNL_n_7;
  wire I_RD_CHNL_n_8;
  wire I_RD_CHNL_n_9;
  wire I_WR_CHNL_n_37;
  wire I_WR_CHNL_n_39;
  wire I_WR_CHNL_n_40;
  wire I_WR_CHNL_n_41;
  wire I_WR_CHNL_n_52;
  wire I_WR_CHNL_n_53;
  wire I_WR_CHNL_n_54;
  wire [10:10]RdChnl_BRAM_Addr_Ld;
  wire [0:0]SR;
  wire ar_active_d1;
  wire ar_active_re29_out;
  wire [1:0]arb_sm_cs;
  wire aw_active_d1;
  wire aw_active_re;
  wire axi_bvalid_int_reg;
  wire [10:0]bram_addr_a;
  wire bram_en_a;
  wire [31:0]bram_rddata_a;
  wire [3:0]bram_we_a;
  wire [31:0]bram_wrdata_a;
  wire curr_fixed_burst_reg;
  wire [9:9]p_0_in;
  wire [9:0]p_1_in;
  wire s_axi_aclk;
  wire [10:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire s_axi_aresetn;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [10:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awlen;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [31:0]s_axi_wdata;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;

  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT5 #(
    .INIT(32'h08000000)) 
    \ADDR_SNG_PORT.bram_addr_int[10]_i_2 
       (.I0(bram_addr_a[7]),
        .I1(bram_addr_a[4]),
        .I2(I_WR_CHNL_n_40),
        .I3(bram_addr_a[5]),
        .I4(bram_addr_a[6]),
        .O(\ADDR_SNG_PORT.bram_addr_int[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_7 
       (.I0(bram_addr_a[8]),
        .I1(bram_addr_a[6]),
        .I2(bram_addr_a[5]),
        .I3(I_WR_CHNL_n_40),
        .I4(bram_addr_a[4]),
        .I5(bram_addr_a[7]),
        .O(\ADDR_SNG_PORT.bram_addr_int[11]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \ADDR_SNG_PORT.bram_addr_int[12]_i_1 
       (.I0(bram_addr_a[10]),
        .I1(\ADDR_SNG_PORT.sng_bram_addr_ld_en ),
        .I2(p_1_in[9]),
        .I3(Arb2AR_Active),
        .I4(RdChnl_BRAM_Addr_Ld),
        .I5(I_WR_CHNL_n_37),
        .O(\ADDR_SNG_PORT.bram_addr_int[12]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \ADDR_SNG_PORT.bram_addr_int[4]_i_2 
       (.I0(bram_addr_a[0]),
        .I1(bram_addr_a[1]),
        .O(\ADDR_SNG_PORT.bram_addr_int[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \ADDR_SNG_PORT.bram_addr_int[5]_i_2 
       (.I0(bram_addr_a[2]),
        .I1(bram_addr_a[1]),
        .I2(bram_addr_a[0]),
        .O(\ADDR_SNG_PORT.bram_addr_int[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \ADDR_SNG_PORT.bram_addr_int[7]_i_2 
       (.I0(bram_addr_a[3]),
        .I1(bram_addr_a[2]),
        .I2(bram_addr_a[1]),
        .I3(bram_addr_a[0]),
        .I4(bram_addr_a[4]),
        .O(\ADDR_SNG_PORT.bram_addr_int[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \ADDR_SNG_PORT.bram_addr_int[8]_i_2 
       (.I0(bram_addr_a[4]),
        .I1(bram_addr_a[0]),
        .I2(bram_addr_a[1]),
        .I3(bram_addr_a[2]),
        .I4(bram_addr_a[3]),
        .I5(bram_addr_a[5]),
        .O(\ADDR_SNG_PORT.bram_addr_int[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \ADDR_SNG_PORT.bram_addr_int[9]_i_2 
       (.I0(bram_addr_a[6]),
        .I1(bram_addr_a[5]),
        .I2(I_WR_CHNL_n_40),
        .I3(bram_addr_a[4]),
        .O(\ADDR_SNG_PORT.bram_addr_int[9]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[10] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_7),
        .Q(bram_addr_a[8]),
        .R(I_WR_CHNL_n_37));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[11] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_6),
        .Q(bram_addr_a[9]),
        .R(I_WR_CHNL_n_37));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[12] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\ADDR_SNG_PORT.bram_addr_int[12]_i_1_n_0 ),
        .Q(bram_addr_a[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[2] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_15),
        .Q(bram_addr_a[0]),
        .R(I_WR_CHNL_n_37));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[3] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_14),
        .Q(bram_addr_a[1]),
        .R(I_WR_CHNL_n_37));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[4] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_13),
        .Q(bram_addr_a[2]),
        .R(I_WR_CHNL_n_37));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[5] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_12),
        .Q(bram_addr_a[3]),
        .R(I_WR_CHNL_n_37));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[6] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_11),
        .Q(bram_addr_a[4]),
        .R(I_WR_CHNL_n_37));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[7] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_10),
        .Q(bram_addr_a[5]),
        .R(I_WR_CHNL_n_37));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[8] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_9),
        .Q(bram_addr_a[6]),
        .R(I_WR_CHNL_n_37));
  FDRE #(
    .INIT(1'b0)) 
    \ADDR_SNG_PORT.bram_addr_int_reg[9] 
       (.C(s_axi_aclk),
        .CE(p_0_in),
        .D(I_RD_CHNL_n_8),
        .Q(bram_addr_a[7]),
        .R(I_WR_CHNL_n_37));
  cmod_a7_35t_axi_bram_ctrl_0_0_sng_port_arb \GEN_ARB.I_SNG_PORT 
       (.AW2Arb_Active_Clr(AW2Arb_Active_Clr),
        .Arb2AR_Active(Arb2AR_Active),
        .Arb2AW_Active(Arb2AW_Active),
        .D({\GEN_ARB.I_SNG_PORT_n_5 ,\GEN_ARB.I_SNG_PORT_n_6 ,\GEN_ARB.I_SNG_PORT_n_7 ,\GEN_ARB.I_SNG_PORT_n_8 ,\GEN_ARB.I_SNG_PORT_n_9 ,\GEN_ARB.I_SNG_PORT_n_10 ,\GEN_ARB.I_SNG_PORT_n_11 ,\GEN_ARB.I_SNG_PORT_n_12 }),
        .E(aw_active_re),
        .\FSM_sequential_arb_sm_cs_reg[0]_0 (I_RD_CHNL_n_18),
        .\FSM_sequential_arb_sm_cs_reg[0]_1 (I_WR_CHNL_n_54),
        .\GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg (\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg ),
        .Q(BRAM_WE_A_i),
        .ar_active_d1(ar_active_d1),
        .ar_active_re29_out(ar_active_re29_out),
        .ar_active_reg_0(SR),
        .arb_sm_cs(arb_sm_cs),
        .aw_active_d1(aw_active_d1),
        .bram_we_a(bram_we_a),
        .last_arb_won_reg_0(I_WR_CHNL_n_53),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_aresetn_0(\GEN_ARB.I_SNG_PORT_n_16 ),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_rready(s_axi_rready));
  cmod_a7_35t_axi_bram_ctrl_0_0_rd_chnl I_RD_CHNL
       (.\ADDR_SNG_PORT.bram_addr_int_reg[10] (\ADDR_SNG_PORT.bram_addr_int[10]_i_2_n_0 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[11] (p_1_in[8:0]),
        .\ADDR_SNG_PORT.bram_addr_int_reg[11]_0 (\ADDR_SNG_PORT.bram_addr_int[11]_i_7_n_0 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[2] (I_WR_CHNL_n_41),
        .\ADDR_SNG_PORT.bram_addr_int_reg[2]_0 (I_WR_CHNL_n_52),
        .\ADDR_SNG_PORT.bram_addr_int_reg[2]_1 (I_WR_CHNL_n_39),
        .\ADDR_SNG_PORT.bram_addr_int_reg[4] (\ADDR_SNG_PORT.bram_addr_int[4]_i_2_n_0 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[5] (\ADDR_SNG_PORT.bram_addr_int[5]_i_2_n_0 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[6] (I_WR_CHNL_n_40),
        .\ADDR_SNG_PORT.bram_addr_int_reg[7] (\ADDR_SNG_PORT.bram_addr_int[7]_i_2_n_0 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[8] (\ADDR_SNG_PORT.bram_addr_int[8]_i_2_n_0 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[9] (\ADDR_SNG_PORT.bram_addr_int[9]_i_2_n_0 ),
        .\ADDR_SNG_PORT.sng_bram_addr_ld_en (\ADDR_SNG_PORT.sng_bram_addr_ld_en ),
        .Arb2AR_Active(Arb2AR_Active),
        .BRAM_En_A_i(BRAM_En_A_i),
        .D({I_RD_CHNL_n_6,I_RD_CHNL_n_7,I_RD_CHNL_n_8,I_RD_CHNL_n_9,I_RD_CHNL_n_10,I_RD_CHNL_n_11,I_RD_CHNL_n_12,I_RD_CHNL_n_13,I_RD_CHNL_n_14,I_RD_CHNL_n_15}),
        .E(p_0_in),
        .\GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg_0 (\GEN_ARB.I_SNG_PORT_n_16 ),
        .\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 ({\GEN_ARB.I_SNG_PORT_n_5 ,\GEN_ARB.I_SNG_PORT_n_6 ,\GEN_ARB.I_SNG_PORT_n_7 ,\GEN_ARB.I_SNG_PORT_n_8 ,\GEN_ARB.I_SNG_PORT_n_9 ,\GEN_ARB.I_SNG_PORT_n_10 ,\GEN_ARB.I_SNG_PORT_n_11 ,\GEN_ARB.I_SNG_PORT_n_12 }),
        .\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 (\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg ),
        .\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_1 (I_RD_CHNL_n_18),
        .\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 (\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg ),
        .ar_active_d1(ar_active_d1),
        .ar_active_re29_out(ar_active_re29_out),
        .bram_addr_a(bram_addr_a[9:0]),
        .bram_en_a(bram_en_a),
        .bram_rddata_a(bram_rddata_a),
        .curr_fixed_burst_reg(curr_fixed_burst_reg),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_aresetn_0(SR),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .\save_init_bram_addr_ld_reg[12] (RdChnl_BRAM_Addr_Ld));
  cmod_a7_35t_axi_bram_ctrl_0_0_wr_chnl I_WR_CHNL
       (.\ADDR_SNG_PORT.bram_addr_int_reg[2] (I_WR_CHNL_n_40),
        .AW2Arb_Active_Clr(AW2Arb_Active_Clr),
        .Arb2AW_Active(Arb2AW_Active),
        .BRAM_En_A_i(BRAM_En_A_i),
        .D(p_1_in),
        .E(aw_active_re),
        .\GEN_WR_NO_ECC.bram_we_int_reg[3]_0 (BRAM_WE_A_i),
        .Q(bram_addr_a[3:0]),
        .arb_sm_cs(arb_sm_cs),
        .aw_active_d1(aw_active_d1),
        .axi_bvalid_int_reg_0(axi_bvalid_int_reg),
        .bram_wrdata_a(bram_wrdata_a),
        .\bvalid_cnt_reg[1]_0 (I_WR_CHNL_n_53),
        .curr_fixed_burst_reg(curr_fixed_burst_reg),
        .curr_fixed_burst_reg_reg_0(I_WR_CHNL_n_37),
        .curr_wrap_burst_reg_reg_0(I_WR_CHNL_n_39),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awaddr_2_sp_1(I_WR_CHNL_n_52),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_awvalid_0(I_WR_CHNL_n_54),
        .s_axi_bready(s_axi_bready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axi_wvalid_0(I_WR_CHNL_n_41),
        .\save_init_bram_addr_ld_reg[3] (SR));
endmodule

(* ORIG_REF_NAME = "rd_chnl" *) 
module cmod_a7_35t_axi_bram_ctrl_0_0_rd_chnl
   (s_axi_aresetn_0,
    ar_active_d1,
    \GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ,
    \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ,
    E,
    \ADDR_SNG_PORT.sng_bram_addr_ld_en ,
    D,
    \save_init_bram_addr_ld_reg[12] ,
    bram_en_a,
    \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_1 ,
    s_axi_rdata,
    ar_active_re29_out,
    s_axi_aclk,
    \GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg_0 ,
    Arb2AR_Active,
    s_axi_rready,
    s_axi_aresetn,
    s_axi_arburst,
    curr_fixed_burst_reg,
    \ADDR_SNG_PORT.bram_addr_int_reg[2] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[11] ,
    bram_addr_a,
    \ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ,
    \ADDR_SNG_PORT.bram_addr_int_reg[10] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[9] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[8] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[7] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[6] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[5] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[4] ,
    s_axi_araddr,
    \ADDR_SNG_PORT.bram_addr_int_reg[2]_0 ,
    \ADDR_SNG_PORT.bram_addr_int_reg[2]_1 ,
    s_axi_arvalid,
    s_axi_arlen,
    BRAM_En_A_i,
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 ,
    bram_rddata_a);
  output s_axi_aresetn_0;
  output ar_active_d1;
  output \GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ;
  output \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ;
  output [0:0]E;
  output \ADDR_SNG_PORT.sng_bram_addr_ld_en ;
  output [9:0]D;
  output [0:0]\save_init_bram_addr_ld_reg[12] ;
  output bram_en_a;
  output \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_1 ;
  output [31:0]s_axi_rdata;
  input ar_active_re29_out;
  input s_axi_aclk;
  input \GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg_0 ;
  input Arb2AR_Active;
  input s_axi_rready;
  input s_axi_aresetn;
  input [1:0]s_axi_arburst;
  input curr_fixed_burst_reg;
  input \ADDR_SNG_PORT.bram_addr_int_reg[2] ;
  input [8:0]\ADDR_SNG_PORT.bram_addr_int_reg[11] ;
  input [9:0]bram_addr_a;
  input \ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[10] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[9] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[8] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[7] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[6] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[5] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[4] ;
  input [10:0]s_axi_araddr;
  input \ADDR_SNG_PORT.bram_addr_int_reg[2]_0 ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[2]_1 ;
  input s_axi_arvalid;
  input [7:0]s_axi_arlen;
  input BRAM_En_A_i;
  input [7:0]\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 ;
  input [31:0]bram_rddata_a;

  wire \ADDR_SNG_PORT.bram_addr_int_reg[10] ;
  wire [8:0]\ADDR_SNG_PORT.bram_addr_int_reg[11] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[2] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[2]_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[2]_1 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[4] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[5] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[6] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[7] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[8] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[9] ;
  wire \ADDR_SNG_PORT.sng_bram_addr_ld_en ;
  wire Arb2AR_Active;
  wire BRAM_En_A_i;
  wire BRAM_En_B_i;
  wire [9:0]D;
  wire [0:0]E;
  wire \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_1_n_0 ;
  wire \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ;
  wire \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_1_n_0 ;
  wire \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_2_n_0 ;
  wire \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_BRST_MAX_WO_NARROW.brst_cnt_max_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ;
  wire [7:0]\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[0] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[1] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[2] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[3] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[4] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[5] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[6] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[7] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[0]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[9] ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[2]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[3]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[4]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_4_n_0 ;
  wire [9:0]\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg ;
  wire [8:6]\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_cnt_en_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_6_n_0 ;
  wire [10:0]\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_n_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_3_n_0 ;
  wire [10:0]\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg ;
  wire \GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_14 ;
  wire \GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_15 ;
  wire \GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_2 ;
  wire \GEN_NO_RD_CMD_OPT.act_rd_burst_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.act_rd_burst_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.act_rd_burst_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.act_rd_burst_i_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.act_rd_burst_two_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rlast_int_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rlast_int_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rlast_int_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_1 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rvalid_clr_ok_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rvalid_clr_ok_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rvalid_int_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_10_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_11_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_12_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_6_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_7_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_8_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.bram_en_int_i_9_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_3_n_0 ;
  wire [7:0]\GEN_NO_RD_CMD_OPT.brst_cnt_reg ;
  wire \GEN_NO_RD_CMD_OPT.brst_one_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.brst_one_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.brst_zero_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.curr_wrap_burst_reg_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.disable_b2b_brst_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.disable_b2b_brst_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.end_brst_rd_clr_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.end_brst_rd_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.last_bram_addr_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.last_bram_addr_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.last_bram_addr_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.last_bram_addr_i_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.last_bram_addr_i_6_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.pend_rd_op_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.pend_rd_op_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.pend_rd_op_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.pend_rd_op_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.pend_rd_op_i_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_6_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_7_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_8_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_5_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_6_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[2]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_1_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_2_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_3_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_4_n_0 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_5_n_0 ;
  wire act_rd_burst;
  wire act_rd_burst_set;
  wire act_rd_burst_two;
  wire [0:0]addr_rl_rd_buf_in;
  wire addr_rl_rd_buf_in0_carry__0_i_1_n_0;
  wire addr_rl_rd_buf_in0_carry__0_n_3;
  wire addr_rl_rd_buf_in0_carry_i_1_n_0;
  wire addr_rl_rd_buf_in0_carry_i_2_n_0;
  wire addr_rl_rd_buf_in0_carry_i_3_n_0;
  wire addr_rl_rd_buf_in0_carry_i_4_n_0;
  wire addr_rl_rd_buf_in0_carry_i_5_n_0;
  wire addr_rl_rd_buf_in0_carry_i_6_n_0;
  wire addr_rl_rd_buf_in0_carry_i_7_n_0;
  wire addr_rl_rd_buf_in0_carry_i_8_n_0;
  wire addr_rl_rd_buf_in0_carry_n_0;
  wire addr_rl_rd_buf_in0_carry_n_1;
  wire addr_rl_rd_buf_in0_carry_n_2;
  wire addr_rl_rd_buf_in0_carry_n_3;
  wire ar_active_d1;
  wire ar_active_re29_out;
  wire axi_rd_burst;
  wire axi_rd_burst0;
  wire axi_rd_burst_two0;
  wire axi_rvalid_clr_ok;
  wire axi_rvalid_set;
  wire axi_rvalid_set_cmb;
  wire [9:0]bram_addr_a;
  wire bram_en_a;
  wire [31:0]bram_rddata_a;
  wire brst_cnt_max;
  wire brst_cnt_max_d1;
  wire brst_one;
  wire brst_one0;
  wire brst_zero;
  wire curr_fixed_burst;
  wire curr_fixed_burst_reg;
  wire curr_fixed_burst_reg_0;
  wire curr_wrap_burst_reg;
  wire data_out_comp;
  wire data_out_comp0_carry_i_1_n_0;
  wire data_out_comp0_carry_i_2_n_0;
  wire data_out_comp0_carry_i_3_n_0;
  wire data_out_comp0_carry_i_4_n_0;
  wire data_out_comp0_carry_i_5_n_0;
  wire data_out_comp0_carry_i_6_n_0;
  wire data_out_comp0_carry_i_7_n_0;
  wire data_out_comp0_carry_n_1;
  wire data_out_comp0_carry_n_2;
  wire data_out_comp0_carry_n_3;
  wire disable_b2b_brst;
  wire disable_b2b_brst_cmb;
  wire end_brst_rd;
  wire end_brst_rd_clr;
  wire last_bram_addr;
  wire last_bram_addr0;
  wire [10:0]p_0_in__0;
  wire [7:0]p_0_in__1;
  wire [10:0]p_0_in__2;
  wire pend_rd_op;
  wire [9:9]plusOp;
  wire [8:0]plusOp_1;
  wire [9:1]plusOp__0;
  wire rd_adv_buf28_out;
  wire [3:0]rd_data_sm_cs;
  wire rl_cnt_en;
  wire rl_count0;
  wire [1:0]rlast_sm_cs;
  wire s_axi_aclk;
  wire [10:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire s_axi_aresetn;
  wire s_axi_aresetn_0;
  wire [7:0]s_axi_arlen;
  wire s_axi_arvalid;
  wire [31:0]s_axi_rdata;
  wire \s_axi_rdata[0]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[10]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[11]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[12]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[13]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[14]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[15]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[16]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[17]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[18]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[19]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[1]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[20]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[21]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[22]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[23]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[24]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[25]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[26]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[27]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[28]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[29]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[2]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[30]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[31]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[3]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[4]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[5]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[6]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[7]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[8]_INST_0_i_1_n_0 ;
  wire \s_axi_rdata[9]_INST_0_i_1_n_0 ;
  wire s_axi_rready;
  wire [0:0]\save_init_bram_addr_ld_reg[12] ;
  wire sel;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_DOC_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_DOC_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_DOC_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_DOC_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_DOC_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_DOD_UNCONNECTED ;
  wire \NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_DOD_UNCONNECTED ;
  wire [3:0]NLW_addr_rl_rd_buf_in0_carry_O_UNCONNECTED;
  wire [3:1]NLW_addr_rl_rd_buf_in0_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_addr_rl_rd_buf_in0_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_data_out_comp0_carry_O_UNCONNECTED;

  LUT6 #(
    .INIT(64'h00DDFFFFFF0F0000)) 
    \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_1 
       (.I0(data_out_comp),
        .I1(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .I2(sel),
        .I3(rlast_sm_cs[1]),
        .I4(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_3_n_0 ),
        .I5(rlast_sm_cs[0]),
        .O(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2 
       (.I0(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .I1(s_axi_rready),
        .O(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h3333FFFFB8BB0000)) 
    \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_1 
       (.I0(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_2_n_0 ),
        .I1(rlast_sm_cs[0]),
        .I2(sel),
        .I3(axi_rd_burst),
        .I4(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_3_n_0 ),
        .I5(rlast_sm_cs[1]),
        .O(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_2 
       (.I0(data_out_comp),
        .I1(s_axi_rready),
        .I2(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .O(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF000000F4F4F4F4)) 
    \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_4_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .I2(rlast_sm_cs[0]),
        .I3(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .I4(s_axi_rready),
        .I5(rlast_sm_cs[1]),
        .O(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_3_n_0 ));
  (* FSM_ENCODED_STATES = "idle:00,w8_throttle:010,w8_throttle_b2:101,w8_last_data:11,rd_latency_rlast:01,w8_2nd_last_data:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_1_n_0 ),
        .Q(rlast_sm_cs[0]),
        .R(s_axi_aresetn_0));
  (* FSM_ENCODED_STATES = "idle:00,w8_throttle:010,w8_throttle_b2:101,w8_last_data:11,rd_latency_rlast:01,w8_2nd_last_data:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[1]_i_1_n_0 ),
        .Q(rlast_sm_cs[1]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg_0 ),
        .Q(ar_active_d1),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hF4000000F000F000)) 
    \GEN_NO_RD_CMD_OPT.GEN_BRST_MAX_WO_NARROW.brst_cnt_max_i_1 
       (.I0(pend_rd_op),
        .I1(brst_zero),
        .I2(brst_cnt_max),
        .I3(s_axi_aresetn),
        .I4(ar_active_d1),
        .I5(Arb2AR_Active),
        .O(\GEN_NO_RD_CMD_OPT.GEN_BRST_MAX_WO_NARROW.brst_cnt_max_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_BRST_MAX_WO_NARROW.brst_cnt_max_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.GEN_BRST_MAX_WO_NARROW.brst_cnt_max_i_1_n_0 ),
        .Q(brst_cnt_max),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hAEAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(s_axi_arvalid),
        .O(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 [0]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[0] ),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 [1]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[1] ),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 [2]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[2] ),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 [3]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[3] ),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 [4]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[4] ),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 [5]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[5] ),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 [6]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[6] ),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg[7]_0 [7]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[7] ),
        .R(s_axi_aresetn_0));
  LUT1 #(
    .INIT(2'h1)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[0]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[1]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ),
        .O(plusOp__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[2]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ),
        .O(plusOp__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[3]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ),
        .O(plusOp__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[4]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ),
        .O(plusOp__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[5]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ),
        .O(plusOp__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[6]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_4_n_0 ),
        .O(plusOp__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[7]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_4_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .O(plusOp__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[8]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_4_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ),
        .O(plusOp__0[8]));
  LUT2 #(
    .INIT(4'hB)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .I1(s_axi_aresetn),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hA8)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_2 
       (.I0(addr_rl_rd_buf_in0_carry__0_n_3),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_4_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .O(addr_rl_rd_buf_in));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[9] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_4_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ),
        .O(plusOp__0[9]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_4 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[0] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[0]_i_1_n_0 ),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[1] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(plusOp__0[1]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[2] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(plusOp__0[2]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[3] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(plusOp__0[3]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[4] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(plusOp__0[4]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[5] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(plusOp__0[5]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[6] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(plusOp__0[6]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[7] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(plusOp__0[7]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[8] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(plusOp__0[8]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg[9] 
       (.C(s_axi_aclk),
        .CE(addr_rl_rd_buf_in),
        .D(plusOp__0[9]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[9] ),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in[9]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[0]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [0]),
        .O(plusOp_1[0]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[1]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [1]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [0]),
        .O(plusOp_1[1]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[2]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [2]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [0]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [1]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[3]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [3]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [2]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [1]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [0]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[4]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [4]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [3]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [0]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [1]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [2]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[5]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [3]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [0]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [1]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [2]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [4]),
        .O(plusOp_1[5]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[6]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_4_n_0 ),
        .O(plusOp_1[6]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[7]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_4_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .O(plusOp_1[7]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[8]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_4_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .O(plusOp_1[8]));
  LUT4 #(
    .INIT(16'h80FF)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .I1(s_axi_rready),
        .I2(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .I3(s_axi_aresetn),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_2 
       (.I0(s_axi_rready),
        .I1(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .O(rd_adv_buf28_out));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [9]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_4_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .O(plusOp));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_4 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [4]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [2]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [1]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [0]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [3]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[0] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(plusOp_1[0]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [0]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[1] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(plusOp_1[1]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [1]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[2] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[2]_i_1_n_0 ),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [2]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[3] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[3]_i_1_n_0 ),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [3]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[4] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[4]_i_1_n_0 ),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [4]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[5] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(plusOp_1[5]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[6] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(plusOp_1[6]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[7] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(plusOp_1[7]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[8] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(plusOp_1[8]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg[9] 
       (.C(s_axi_aclk),
        .CE(rd_adv_buf28_out),
        .D(plusOp),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [9]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hDC)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_cnt_en_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .I1(BRAM_En_B_i),
        .I2(rl_cnt_en),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_cnt_en_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_cnt_en_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_cnt_en_i_1_n_0 ),
        .Q(rl_cnt_en),
        .R(s_axi_aresetn_0));
  LUT1 #(
    .INIT(2'h1)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[0]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .O(p_0_in__0[0]));
  LUT4 #(
    .INIT(16'hD0FF)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1 
       (.I0(rl_cnt_en),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_4_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .I3(s_axi_aresetn),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_2 
       (.I0(rl_cnt_en),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_4_n_0 ),
        .O(rl_count0));
  LUT6 #(
    .INIT(64'hAA6AAAAAAAAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [10]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [8]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_5_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [9]),
        .O(p_0_in__0[10]));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_4 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [2]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [4]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [5]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_6_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_5 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [4]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [2]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [1]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [3]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [5]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_6 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [7]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [3]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [8]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [1]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [10]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [9]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[1]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [1]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[2]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [2]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [1]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[3]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [3]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [1]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [2]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[4]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [4]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [2]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [1]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [3]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[5]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [5]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [3]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [1]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [2]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [4]),
        .O(p_0_in__0[5]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[6]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_5_n_0 ),
        .O(p_0_in__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[7]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [7]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_5_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [6]),
        .O(p_0_in__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[8]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_5_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [8]),
        .O(p_0_in__0[8]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[9]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [9]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [6]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_5_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [7]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [8]),
        .O(p_0_in__0[9]));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[0] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[0]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[10] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[10]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [10]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[1] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[1]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [1]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[2] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[2]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [2]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[3] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[3]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [3]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[4] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[4]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [4]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[5] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[5]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [5]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[6] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[6]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [6]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[7] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[7]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [7]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[8] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[8]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [8]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg[9] 
       (.C(s_axi_aclk),
        .CE(rl_count0),
        .D(p_0_in__0[9]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [9]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[0]),
        .DIB(bram_rddata_a[1]),
        .DIC(bram_rddata_a[2]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "14" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[12]),
        .DIB(bram_rddata_a[13]),
        .DIC(bram_rddata_a[14]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "17" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[15]),
        .DIB(bram_rddata_a[16]),
        .DIC(bram_rddata_a[17]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "20" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[18]),
        .DIB(bram_rddata_a[19]),
        .DIC(bram_rddata_a[20]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "23" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[21]),
        .DIB(bram_rddata_a[22]),
        .DIC(bram_rddata_a[23]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "26" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[24]),
        .DIB(bram_rddata_a[25]),
        .DIC(bram_rddata_a[26]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "29" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[27]),
        .DIB(bram_rddata_a[28]),
        .DIC(bram_rddata_a[29]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[30]),
        .DIB(bram_rddata_a[31]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_n_1 ),
        .DOC(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_DOC_UNCONNECTED ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[3]),
        .DIB(bram_rddata_a[4]),
        .DIC(bram_rddata_a[5]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "8" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[6]),
        .DIB(bram_rddata_a[7]),
        .DIC(bram_rddata_a[8]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "11" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[9]),
        .DIB(bram_rddata_a[10]),
        .DIC(bram_rddata_a[11]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[0]),
        .DIB(bram_rddata_a[1]),
        .DIC(bram_rddata_a[2]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "14" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[12]),
        .DIB(bram_rddata_a[13]),
        .DIC(bram_rddata_a[14]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "17" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[15]),
        .DIB(bram_rddata_a[16]),
        .DIC(bram_rddata_a[17]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "20" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[18]),
        .DIB(bram_rddata_a[19]),
        .DIC(bram_rddata_a[20]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "23" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[21]),
        .DIB(bram_rddata_a[22]),
        .DIC(bram_rddata_a[23]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "26" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[24]),
        .DIB(bram_rddata_a[25]),
        .DIC(bram_rddata_a[26]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "29" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[27]),
        .DIB(bram_rddata_a[28]),
        .DIC(bram_rddata_a[29]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[30]),
        .DIB(bram_rddata_a[31]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_n_1 ),
        .DOC(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_DOC_UNCONNECTED ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[3]),
        .DIB(bram_rddata_a[4]),
        .DIC(bram_rddata_a[5]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "8" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[6]),
        .DIB(bram_rddata_a[7]),
        .DIC(bram_rddata_a[8]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "128" *) 
  (* ram_addr_end = "191" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "11" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[9]),
        .DIB(bram_rddata_a[10]),
        .DIC(bram_rddata_a[11]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[0]),
        .DIB(bram_rddata_a[1]),
        .DIC(bram_rddata_a[2]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h40)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "14" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[12]),
        .DIB(bram_rddata_a[13]),
        .DIC(bram_rddata_a[14]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "17" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[15]),
        .DIB(bram_rddata_a[16]),
        .DIC(bram_rddata_a[17]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "20" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[18]),
        .DIB(bram_rddata_a[19]),
        .DIC(bram_rddata_a[20]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "23" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[21]),
        .DIB(bram_rddata_a[22]),
        .DIC(bram_rddata_a[23]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "26" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[24]),
        .DIB(bram_rddata_a[25]),
        .DIC(bram_rddata_a[26]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "29" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[27]),
        .DIB(bram_rddata_a[28]),
        .DIC(bram_rddata_a[29]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[30]),
        .DIB(bram_rddata_a[31]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_n_1 ),
        .DOC(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_DOC_UNCONNECTED ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[3]),
        .DIB(bram_rddata_a[4]),
        .DIC(bram_rddata_a[5]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "8" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[6]),
        .DIB(bram_rddata_a[7]),
        .DIC(bram_rddata_a[8]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "192" *) 
  (* ram_addr_end = "255" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "11" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[9]),
        .DIB(bram_rddata_a[10]),
        .DIC(bram_rddata_a[11]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[0]),
        .DIB(bram_rddata_a[1]),
        .DIC(bram_rddata_a[2]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "14" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[12]),
        .DIB(bram_rddata_a[13]),
        .DIC(bram_rddata_a[14]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "17" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[15]),
        .DIB(bram_rddata_a[16]),
        .DIC(bram_rddata_a[17]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "20" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[18]),
        .DIB(bram_rddata_a[19]),
        .DIC(bram_rddata_a[20]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "23" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[21]),
        .DIB(bram_rddata_a[22]),
        .DIC(bram_rddata_a[23]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "26" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[24]),
        .DIB(bram_rddata_a[25]),
        .DIC(bram_rddata_a[26]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "29" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[27]),
        .DIB(bram_rddata_a[28]),
        .DIC(bram_rddata_a[29]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[30]),
        .DIB(bram_rddata_a[31]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_n_1 ),
        .DOC(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_DOC_UNCONNECTED ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[3]),
        .DIB(bram_rddata_a[4]),
        .DIC(bram_rddata_a[5]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "8" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[6]),
        .DIB(bram_rddata_a[7]),
        .DIC(bram_rddata_a[8]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "256" *) 
  (* ram_addr_end = "256" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "11" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[9]),
        .DIB(bram_rddata_a[10]),
        .DIC(bram_rddata_a[11]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[0]),
        .DIB(bram_rddata_a[1]),
        .DIC(bram_rddata_a[2]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "14" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[12]),
        .DIB(bram_rddata_a[13]),
        .DIC(bram_rddata_a[14]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "17" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[15]),
        .DIB(bram_rddata_a[16]),
        .DIC(bram_rddata_a[17]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "20" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[18]),
        .DIB(bram_rddata_a[19]),
        .DIC(bram_rddata_a[20]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "23" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[21]),
        .DIB(bram_rddata_a[22]),
        .DIC(bram_rddata_a[23]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "26" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[24]),
        .DIB(bram_rddata_a[25]),
        .DIC(bram_rddata_a[26]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "29" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[27]),
        .DIB(bram_rddata_a[28]),
        .DIC(bram_rddata_a[29]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "30" *) 
  (* ram_slice_end = "31" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[30]),
        .DIB(bram_rddata_a[31]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_n_1 ),
        .DOC(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_DOC_UNCONNECTED ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[3]),
        .DIB(bram_rddata_a[4]),
        .DIC(bram_rddata_a[5]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "8" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[6]),
        .DIB(bram_rddata_a[7]),
        .DIC(bram_rddata_a[8]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "8224" *) 
  (* RTL_RAM_NAME = "axi_bram_ctrl/gext_inst.abcv4_0_ext_inst/GEN_AXI4.I_FULL_AXI/I_RD_CHNL/GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg" *) 
  (* RTL_RAM_STYLE = "block" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "64" *) 
  (* ram_addr_end = "127" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "11" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    \GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11 
       (.ADDRA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5:0]),
        .ADDRD({\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ,\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] }),
        .DIA(bram_rddata_a[9]),
        .DIB(bram_rddata_a[10]),
        .DIC(bram_rddata_a[11]),
        .DID(1'b0),
        .DOA(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_n_0 ),
        .DOB(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_n_1 ),
        .DOC(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_n_2 ),
        .DOD(\NLW_GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_DOD_UNCONNECTED ),
        .WCLK(s_axi_aclk),
        .WE(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_i_1 
       (.I0(s_axi_arlen[2]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_i_2_n_0 ),
        .I2(s_axi_arlen[3]),
        .I3(s_axi_arlen[1]),
        .O(axi_rd_burst0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_i_2 
       (.I0(s_axi_arlen[6]),
        .I1(s_axi_arlen[5]),
        .I2(s_axi_arlen[7]),
        .I3(s_axi_arlen[4]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_reg 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(axi_rd_burst0),
        .Q(axi_rd_burst),
        .R(s_axi_aresetn_0));
  LUT3 #(
    .INIT(8'hEA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_2_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_3_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[0] ),
        .O(axi_rd_burst_two0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h00000010)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_2 
       (.I0(s_axi_arlen[1]),
        .I1(s_axi_arlen[3]),
        .I2(s_axi_arlen[0]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_i_2_n_0 ),
        .I4(s_axi_arlen[2]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_4_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[7] ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_4 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[6] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[4] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[1] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[2] ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[3] ),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[5] ),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_reg 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(axi_rd_burst_two0),
        .Q(sel),
        .R(s_axi_aresetn_0));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[0]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [0]),
        .O(p_0_in__2[0]));
  LUT4 #(
    .INIT(16'hFEFF)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1 
       (.I0(rd_data_sm_cs[3]),
        .I1(rd_data_sm_cs[2]),
        .I2(rd_data_sm_cs[0]),
        .I3(rd_data_sm_cs[1]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAA6AAAAAAAAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_2 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [10]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [8]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_3_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [9]),
        .O(p_0_in__2[10]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [4]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [2]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [1]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [0]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [3]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [5]),
        .O(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[1]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [1]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [0]),
        .O(p_0_in__2[1]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[2]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [2]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [1]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [0]),
        .O(p_0_in__2[2]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[3]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [3]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [0]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [1]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [2]),
        .O(p_0_in__2[3]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[4]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [4]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [2]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [1]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [0]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [3]),
        .O(p_0_in__2[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[5]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [5]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [3]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [0]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [1]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [2]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [4]),
        .O(p_0_in__2[5]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[6]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_3_n_0 ),
        .O(p_0_in__2[6]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[7]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [7]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_3_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [6]),
        .O(p_0_in__2[7]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[8]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_3_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [8]),
        .O(p_0_in__2[8]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[9]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [9]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [6]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_3_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [7]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [8]),
        .O(p_0_in__2[9]));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[0]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [0]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[10] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[10]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [10]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[1]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [1]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[2]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [2]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[3]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [3]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[4]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [4]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[5]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [5]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[6]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [6]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[7]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [7]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[8] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[8]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [8]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg[9] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in__2[9]),
        .Q(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [9]),
        .R(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ));
  cmod_a7_35t_axi_bram_ctrl_0_0_wrap_brst_0 \GEN_NO_RD_CMD_OPT.I_WRAP_BRST 
       (.\ADDR_SNG_PORT.bram_addr_int[11]_i_6_0 (\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[10] (\ADDR_SNG_PORT.bram_addr_int_reg[10] ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[11] (\ADDR_SNG_PORT.bram_addr_int_reg[11] ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[11]_0 (\ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[2] (\ADDR_SNG_PORT.bram_addr_int_reg[2] ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[2]_0 (\ADDR_SNG_PORT.bram_addr_int_reg[2]_0 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[2]_1 (ar_active_d1),
        .\ADDR_SNG_PORT.bram_addr_int_reg[2]_2 (\ADDR_SNG_PORT.bram_addr_int_reg[2]_1 ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[4] (\ADDR_SNG_PORT.bram_addr_int_reg[4] ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[5] (\ADDR_SNG_PORT.bram_addr_int_reg[5] ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[6] (\ADDR_SNG_PORT.bram_addr_int_reg[6] ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[7] (\ADDR_SNG_PORT.bram_addr_int_reg[7] ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[8] (\ADDR_SNG_PORT.bram_addr_int_reg[8] ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[9] (\ADDR_SNG_PORT.bram_addr_int_reg[9] ),
        .Arb2AR_Active(Arb2AR_Active),
        .D(D),
        .E(E),
        .\GEN_NO_RD_CMD_OPT.brst_cnt_reg[1] (\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_14 ),
        .\GEN_NO_RD_CMD_OPT.brst_cnt_reg[4] (\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_15 ),
        .\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 (\GEN_NO_RD_CMD_OPT.brst_cnt_reg ),
        .\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] (\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_2 ),
        .Q(rd_data_sm_cs),
        .SR(s_axi_aresetn_0),
        .ar_active_re29_out(ar_active_re29_out),
        .ar_active_reg(\ADDR_SNG_PORT.sng_bram_addr_ld_en ),
        .axi_rd_burst(axi_rd_burst),
        .bram_addr_a(bram_addr_a),
        .brst_zero(brst_zero),
        .curr_fixed_burst_reg(curr_fixed_burst_reg),
        .curr_fixed_burst_reg_0(curr_fixed_burst_reg_0),
        .curr_wrap_burst_reg(curr_wrap_burst_reg),
        .end_brst_rd(end_brst_rd),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arlen(s_axi_arlen[3:0]),
        .s_axi_rready(s_axi_rready),
        .\save_init_bram_addr_ld_reg[12]_0 (\save_init_bram_addr_ld_reg[12] ),
        .sel(sel));
  LUT6 #(
    .INIT(64'h000000002EEE22E2)) 
    \GEN_NO_RD_CMD_OPT.act_rd_burst_i_1 
       (.I0(act_rd_burst),
        .I1(act_rd_burst_set),
        .I2(ar_active_re29_out),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_2_n_0 ),
        .I4(axi_rd_burst),
        .I5(\GEN_NO_RD_CMD_OPT.act_rd_burst_i_3_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.act_rd_burst_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000040F0F00040)) 
    \GEN_NO_RD_CMD_OPT.act_rd_burst_i_2 
       (.I0(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_5_n_0 ),
        .I1(ar_active_re29_out),
        .I2(\GEN_NO_RD_CMD_OPT.act_rd_burst_i_4_n_0 ),
        .I3(rd_data_sm_cs[0]),
        .I4(rd_data_sm_cs[1]),
        .I5(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_4_n_0 ),
        .O(act_rd_burst_set));
  LUT6 #(
    .INIT(64'h40404000FFFFFFFF)) 
    \GEN_NO_RD_CMD_OPT.act_rd_burst_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.act_rd_burst_i_5_n_0 ),
        .I1(s_axi_rready),
        .I2(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .I3(act_rd_burst_two),
        .I4(act_rd_burst),
        .I5(s_axi_aresetn),
        .O(\GEN_NO_RD_CMD_OPT.act_rd_burst_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \GEN_NO_RD_CMD_OPT.act_rd_burst_i_4 
       (.I0(rd_data_sm_cs[2]),
        .I1(rd_data_sm_cs[3]),
        .O(\GEN_NO_RD_CMD_OPT.act_rd_burst_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'hF9FF)) 
    \GEN_NO_RD_CMD_OPT.act_rd_burst_i_5 
       (.I0(rd_data_sm_cs[0]),
        .I1(rd_data_sm_cs[1]),
        .I2(rd_data_sm_cs[2]),
        .I3(rd_data_sm_cs[3]),
        .O(\GEN_NO_RD_CMD_OPT.act_rd_burst_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.act_rd_burst_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.act_rd_burst_i_1_n_0 ),
        .Q(act_rd_burst),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
    \GEN_NO_RD_CMD_OPT.act_rd_burst_two_i_1 
       (.I0(act_rd_burst_two),
        .I1(act_rd_burst_set),
        .I2(sel),
        .I3(ar_active_re29_out),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_2_n_0 ),
        .I5(\GEN_NO_RD_CMD_OPT.act_rd_burst_i_3_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.act_rd_burst_two_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.act_rd_burst_two_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.act_rd_burst_two_i_1_n_0 ),
        .Q(act_rd_burst_two),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFF55FFC000000000)) 
    \GEN_NO_RD_CMD_OPT.axi_rlast_int_i_1 
       (.I0(s_axi_rready),
        .I1(rlast_sm_cs[0]),
        .I2(rlast_sm_cs[1]),
        .I3(\GEN_NO_RD_CMD_OPT.axi_rlast_int_i_2_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .I5(s_axi_aresetn),
        .O(\GEN_NO_RD_CMD_OPT.axi_rlast_int_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000000002FF02)) 
    \GEN_NO_RD_CMD_OPT.axi_rlast_int_i_2 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_3_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.axi_rlast_int_i_3_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[0] ),
        .I3(rlast_sm_cs[1]),
        .I4(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .I5(rlast_sm_cs[0]),
        .O(\GEN_NO_RD_CMD_OPT.axi_rlast_int_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFEFFFFFFFF)) 
    \GEN_NO_RD_CMD_OPT.axi_rlast_int_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count[10]_i_6_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [5]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [4]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [2]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_count_reg [0]),
        .O(\GEN_NO_RD_CMD_OPT.axi_rlast_int_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.axi_rlast_int_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.axi_rlast_int_i_1_n_0 ),
        .Q(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEEEEE)) 
    \GEN_NO_RD_CMD_OPT.axi_rvalid_clr_ok_i_1 
       (.I0(ar_active_re29_out),
        .I1(\GEN_NO_RD_CMD_OPT.axi_rvalid_clr_ok_i_2_n_0 ),
        .I2(disable_b2b_brst_cmb),
        .I3(disable_b2b_brst),
        .I4(last_bram_addr),
        .I5(axi_rvalid_clr_ok),
        .O(\GEN_NO_RD_CMD_OPT.axi_rvalid_clr_ok_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \GEN_NO_RD_CMD_OPT.axi_rvalid_clr_ok_i_2 
       (.I0(rd_data_sm_cs[3]),
        .I1(rd_data_sm_cs[2]),
        .I2(rd_data_sm_cs[0]),
        .I3(rd_data_sm_cs[1]),
        .O(\GEN_NO_RD_CMD_OPT.axi_rvalid_clr_ok_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.axi_rvalid_clr_ok_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.axi_rvalid_clr_ok_i_1_n_0 ),
        .Q(axi_rvalid_clr_ok),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'h7F7F7F0000000000)) 
    \GEN_NO_RD_CMD_OPT.axi_rvalid_int_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .I1(s_axi_rready),
        .I2(axi_rvalid_clr_ok),
        .I3(axi_rvalid_set),
        .I4(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .I5(s_axi_aresetn),
        .O(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_i_1_n_0 ),
        .Q(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    \GEN_NO_RD_CMD_OPT.axi_rvalid_set_i_1 
       (.I0(rd_data_sm_cs[3]),
        .I1(rd_data_sm_cs[2]),
        .I2(rd_data_sm_cs[0]),
        .I3(rd_data_sm_cs[1]),
        .O(axi_rvalid_set_cmb));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.axi_rvalid_set_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_rvalid_set_cmb),
        .Q(axi_rvalid_set),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hEFEFEFAA202020AA)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.bram_en_int_i_2_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.bram_en_int_i_3_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.bram_en_int_i_4_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.bram_en_int_i_5_n_0 ),
        .I4(rd_data_sm_cs[3]),
        .I5(BRAM_En_B_i),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFCFFFF55FFFFFF55)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_10 
       (.I0(ar_active_re29_out),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_4_n_0 ),
        .I2(rd_data_sm_cs[3]),
        .I3(rd_data_sm_cs[2]),
        .I4(rd_data_sm_cs[0]),
        .I5(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h03CCCFCCDFDDDFDD)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_11 
       (.I0(rd_data_sm_cs[2]),
        .I1(rd_data_sm_cs[0]),
        .I2(\GEN_NO_RD_CMD_OPT.bram_en_int_i_12_n_0 ),
        .I3(rd_data_sm_cs[1]),
        .I4(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_5_n_0 ),
        .I5(ar_active_re29_out),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'hFEEE)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_12 
       (.I0(end_brst_rd),
        .I1(brst_zero),
        .I2(s_axi_rready),
        .I3(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hFF10FF10FF10FFFF)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_2 
       (.I0(\GEN_NO_RD_CMD_OPT.bram_en_int_i_6_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.bram_en_int_i_7_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.bram_en_int_i_8_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.bram_en_int_i_9_n_0 ),
        .I4(rd_data_sm_cs[1]),
        .I5(\GEN_NO_RD_CMD_OPT.bram_en_int_i_10_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h0BBBBBBB)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_3 
       (.I0(ar_active_d1),
        .I1(Arb2AR_Active),
        .I2(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .I3(s_axi_rready),
        .I4(pend_rd_op),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h0040)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_4 
       (.I0(rd_data_sm_cs[2]),
        .I1(rd_data_sm_cs[3]),
        .I2(rd_data_sm_cs[0]),
        .I3(rd_data_sm_cs[1]),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA00000080AAAA)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_5 
       (.I0(\GEN_NO_RD_CMD_OPT.bram_en_int_i_11_n_0 ),
        .I1(brst_one),
        .I2(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_4_n_0 ),
        .I4(rd_data_sm_cs[2]),
        .I5(rd_data_sm_cs[1]),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_6 
       (.I0(\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_14 ),
        .I1(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [7]),
        .I2(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [6]),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [5]),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [4]),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAABABABFF)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_7 
       (.I0(rd_data_sm_cs[3]),
        .I1(rd_data_sm_cs[0]),
        .I2(rd_data_sm_cs[1]),
        .I3(axi_rd_burst),
        .I4(sel),
        .I5(rd_data_sm_cs[2]),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0F0F1F1F1F1F0FFF)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_8 
       (.I0(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_4_n_0 ),
        .I2(rd_data_sm_cs[2]),
        .I3(sel),
        .I4(rd_data_sm_cs[0]),
        .I5(rd_data_sm_cs[1]),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hF444444444444444)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_i_9 
       (.I0(\GEN_NO_RD_CMD_OPT.bram_en_int_i_3_n_0 ),
        .I1(rd_data_sm_cs[3]),
        .I2(rd_data_sm_cs[2]),
        .I3(rd_data_sm_cs[1]),
        .I4(ar_active_re29_out),
        .I5(rd_data_sm_cs[0]),
        .O(\GEN_NO_RD_CMD_OPT.bram_en_int_i_9_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.bram_en_int_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.bram_en_int_i_1_n_0 ),
        .Q(BRAM_En_B_i),
        .R(s_axi_aresetn_0));
  LUT4 #(
    .INIT(16'h08FB)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[0]_i_1 
       (.I0(s_axi_arlen[0]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [0]),
        .O(p_0_in__1[0]));
  LUT5 #(
    .INIT(32'hFB0808FB)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[1]_i_1 
       (.I0(s_axi_arlen[1]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [0]),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [1]),
        .O(p_0_in__1[1]));
  LUT6 #(
    .INIT(64'hFBFBFB08080808FB)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[2]_i_1 
       (.I0(s_axi_arlen[2]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [0]),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [1]),
        .I5(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [2]),
        .O(p_0_in__1[2]));
  LUT6 #(
    .INIT(64'hBBBBBBB88888888B)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[3]_i_1 
       (.I0(s_axi_arlen[3]),
        .I1(ar_active_re29_out),
        .I2(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [2]),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [1]),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [0]),
        .I5(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [3]),
        .O(p_0_in__1[3]));
  LUT5 #(
    .INIT(32'h08FBFB08)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[4]_i_1 
       (.I0(s_axi_arlen[4]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [4]),
        .I4(\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_14 ),
        .O(p_0_in__1[4]));
  LUT6 #(
    .INIT(64'hFB0808FBFB08FB08)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[5]_i_1 
       (.I0(s_axi_arlen[5]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [5]),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [4]),
        .I5(\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_14 ),
        .O(p_0_in__1[5]));
  LUT6 #(
    .INIT(64'hB8B8B88BB8B8B8B8)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[6]_i_1 
       (.I0(s_axi_arlen[6]),
        .I1(ar_active_re29_out),
        .I2(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [6]),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [5]),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [4]),
        .I5(\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_14 ),
        .O(p_0_in__1[6]));
  LUT3 #(
    .INIT(8'hF4)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1 
       (.I0(ar_active_d1),
        .I1(Arb2AR_Active),
        .I2(\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_2 ),
        .O(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFB0808FBFB08FB08)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_2 
       (.I0(s_axi_arlen[7]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [7]),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [6]),
        .I5(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_3_n_0 ),
        .O(p_0_in__1[7]));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [3]),
        .I1(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [2]),
        .I2(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [0]),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [1]),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [4]),
        .I5(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [5]),
        .O(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt_max_d1_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(brst_cnt_max),
        .Q(brst_cnt_max_d1),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[0] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ),
        .D(p_0_in__1[0]),
        .Q(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [0]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[1] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ),
        .D(p_0_in__1[1]),
        .Q(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [1]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[2] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ),
        .D(p_0_in__1[2]),
        .Q(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [2]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[3] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ),
        .D(p_0_in__1[3]),
        .Q(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [3]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[4] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ),
        .D(p_0_in__1[4]),
        .Q(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [4]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[5] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ),
        .D(p_0_in__1[5]),
        .Q(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [5]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[6] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ),
        .D(p_0_in__1[6]),
        .Q(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [6]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[7] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.brst_cnt[7]_i_1_n_0 ),
        .D(p_0_in__1[7]),
        .Q(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [7]),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'h00000000A8A800A8)) 
    \GEN_NO_RD_CMD_OPT.brst_one_i_1 
       (.I0(s_axi_aresetn),
        .I1(brst_one),
        .I2(brst_one0),
        .I3(ar_active_re29_out),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_2_n_0 ),
        .I5(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.brst_one_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888F888888)) 
    \GEN_NO_RD_CMD_OPT.brst_one_i_2 
       (.I0(ar_active_re29_out),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_2_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [0]),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [1]),
        .I4(\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_2 ),
        .I5(\GEN_NO_RD_CMD_OPT.brst_one_i_3_n_0 ),
        .O(brst_one0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \GEN_NO_RD_CMD_OPT.brst_one_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [2]),
        .I1(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [3]),
        .I2(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [7]),
        .I3(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [6]),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [5]),
        .I5(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [4]),
        .O(\GEN_NO_RD_CMD_OPT.brst_one_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_one_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.brst_one_i_1_n_0 ),
        .Q(brst_one),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hEFEFEF0000000000)) 
    \GEN_NO_RD_CMD_OPT.brst_zero_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_5_n_0 ),
        .I1(ar_active_d1),
        .I2(Arb2AR_Active),
        .I3(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2_n_0 ),
        .I4(brst_zero),
        .I5(s_axi_aresetn),
        .O(\GEN_NO_RD_CMD_OPT.brst_zero_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.brst_zero_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.brst_zero_i_1_n_0 ),
        .Q(brst_zero),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \GEN_NO_RD_CMD_OPT.curr_fixed_burst_reg_i_1 
       (.I0(s_axi_arburst[0]),
        .I1(s_axi_arburst[1]),
        .O(curr_fixed_burst));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.curr_fixed_burst_reg_reg 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(curr_fixed_burst),
        .Q(curr_fixed_burst_reg_0),
        .R(s_axi_aresetn_0));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \GEN_NO_RD_CMD_OPT.curr_wrap_burst_reg_i_1 
       (.I0(s_axi_arburst[1]),
        .I1(s_axi_arburst[0]),
        .O(\GEN_NO_RD_CMD_OPT.curr_wrap_burst_reg_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.curr_wrap_burst_reg_reg 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(\GEN_NO_RD_CMD_OPT.curr_wrap_burst_reg_i_1_n_0 ),
        .Q(curr_wrap_burst_reg),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hD0FFD0FFD0FFD0D0)) 
    \GEN_NO_RD_CMD_OPT.disable_b2b_brst_i_1 
       (.I0(axi_rd_burst),
        .I1(sel),
        .I2(axi_rvalid_set_cmb),
        .I3(\GEN_NO_RD_CMD_OPT.disable_b2b_brst_i_2_n_0 ),
        .I4(disable_b2b_brst),
        .I5(\GEN_NO_RD_CMD_OPT.disable_b2b_brst_i_3_n_0 ),
        .O(disable_b2b_brst_cmb));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h0F006F8F)) 
    \GEN_NO_RD_CMD_OPT.disable_b2b_brst_i_2 
       (.I0(rd_data_sm_cs[0]),
        .I1(rd_data_sm_cs[1]),
        .I2(disable_b2b_brst),
        .I3(rd_data_sm_cs[3]),
        .I4(rd_data_sm_cs[2]),
        .O(\GEN_NO_RD_CMD_OPT.disable_b2b_brst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0000000000)) 
    \GEN_NO_RD_CMD_OPT.disable_b2b_brst_i_3 
       (.I0(brst_zero),
        .I1(end_brst_rd),
        .I2(brst_one),
        .I3(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .I4(rd_data_sm_cs[1]),
        .I5(rd_data_sm_cs[0]),
        .O(\GEN_NO_RD_CMD_OPT.disable_b2b_brst_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.disable_b2b_brst_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(disable_b2b_brst_cmb),
        .Q(disable_b2b_brst),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hFFFFAFFB0000A000)) 
    \GEN_NO_RD_CMD_OPT.end_brst_rd_clr_i_1 
       (.I0(rd_data_sm_cs[2]),
        .I1(ar_active_re29_out),
        .I2(rd_data_sm_cs[1]),
        .I3(rd_data_sm_cs[0]),
        .I4(rd_data_sm_cs[3]),
        .I5(end_brst_rd_clr),
        .O(\GEN_NO_RD_CMD_OPT.end_brst_rd_clr_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.end_brst_rd_clr_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.end_brst_rd_clr_i_1_n_0 ),
        .Q(end_brst_rd_clr),
        .R(s_axi_aresetn_0));
  LUT5 #(
    .INIT(32'h55300000)) 
    \GEN_NO_RD_CMD_OPT.end_brst_rd_i_1 
       (.I0(end_brst_rd_clr),
        .I1(brst_cnt_max_d1),
        .I2(brst_cnt_max),
        .I3(end_brst_rd),
        .I4(s_axi_aresetn),
        .O(\GEN_NO_RD_CMD_OPT.end_brst_rd_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.end_brst_rd_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.end_brst_rd_i_1_n_0 ),
        .Q(end_brst_rd),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFBABBBABBBABB)) 
    \GEN_NO_RD_CMD_OPT.last_bram_addr_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2_n_0 ),
        .I1(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_3_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_4_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_5_n_0 ),
        .I5(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_6_n_0 ),
        .O(last_bram_addr0));
  LUT6 #(
    .INIT(64'h0000000001000000)) 
    \GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 
       (.I0(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [2]),
        .I1(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [3]),
        .I2(\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_15 ),
        .I3(\GEN_NO_RD_CMD_OPT.I_WRAP_BRST_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [0]),
        .I5(\GEN_NO_RD_CMD_OPT.brst_cnt_reg [1]),
        .O(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8080808080808C80)) 
    \GEN_NO_RD_CMD_OPT.last_bram_addr_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_5_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.bram_en_int_i_4_n_0 ),
        .I2(ar_active_re29_out),
        .I3(pend_rd_op),
        .I4(sel),
        .I5(axi_rd_burst),
        .O(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFBFF)) 
    \GEN_NO_RD_CMD_OPT.last_bram_addr_i_4 
       (.I0(rd_data_sm_cs[0]),
        .I1(rd_data_sm_cs[3]),
        .I2(rd_data_sm_cs[2]),
        .I3(rd_data_sm_cs[1]),
        .I4(sel),
        .I5(axi_rd_burst),
        .O(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \GEN_NO_RD_CMD_OPT.last_bram_addr_i_5 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_i_2_n_0 ),
        .I1(s_axi_arlen[3]),
        .I2(s_axi_arlen[2]),
        .I3(s_axi_arlen[1]),
        .I4(s_axi_arlen[0]),
        .O(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \GEN_NO_RD_CMD_OPT.last_bram_addr_i_6 
       (.I0(rd_data_sm_cs[0]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(rd_data_sm_cs[2]),
        .I4(rd_data_sm_cs[3]),
        .I5(rd_data_sm_cs[1]),
        .O(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.last_bram_addr_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(last_bram_addr0),
        .Q(last_bram_addr),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hBBAABBAABBA0F0F0)) 
    \GEN_NO_RD_CMD_OPT.pend_rd_op_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_2_n_0 ),
        .I1(rd_data_sm_cs[3]),
        .I2(pend_rd_op),
        .I3(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_3_n_0 ),
        .I4(axi_rvalid_set_cmb),
        .I5(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_4_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \GEN_NO_RD_CMD_OPT.pend_rd_op_i_2 
       (.I0(ar_active_d1),
        .I1(Arb2AR_Active),
        .I2(rd_data_sm_cs[0]),
        .O(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \GEN_NO_RD_CMD_OPT.pend_rd_op_i_3 
       (.I0(ar_active_d1),
        .I1(Arb2AR_Active),
        .I2(axi_rd_burst),
        .I3(sel),
        .O(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF04040404040)) 
    \GEN_NO_RD_CMD_OPT.pend_rd_op_i_4 
       (.I0(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.bram_en_int_i_4_n_0 ),
        .I2(pend_rd_op),
        .I3(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .I4(ar_active_re29_out),
        .I5(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_5_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    \GEN_NO_RD_CMD_OPT.pend_rd_op_i_5 
       (.I0(rd_data_sm_cs[0]),
        .I1(rd_data_sm_cs[1]),
        .I2(rd_data_sm_cs[3]),
        .I3(rd_data_sm_cs[2]),
        .O(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.pend_rd_op_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_NO_RD_CMD_OPT.pend_rd_op_i_1_n_0 ),
        .Q(pend_rd_op),
        .R(s_axi_aresetn_0));
  LUT6 #(
    .INIT(64'hCCCCCCCCDDDDCCFC)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_2_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_3_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_4_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_5_n_0 ),
        .I4(rd_data_sm_cs[2]),
        .I5(rd_data_sm_cs[3]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hA888A888A8880088)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_2 
       (.I0(rd_data_sm_cs[0]),
        .I1(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .I2(ar_active_re29_out),
        .I3(rd_data_sm_cs[1]),
        .I4(act_rd_burst),
        .I5(act_rd_burst_two),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAABA)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_3 
       (.I0(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_6_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_7_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_8_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [6]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [9]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [5]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_4 
       (.I0(sel),
        .I1(axi_rd_burst),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_5 
       (.I0(rd_data_sm_cs[1]),
        .I1(rd_data_sm_cs[0]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_6 
       (.I0(rd_data_sm_cs[2]),
        .I1(rd_data_sm_cs[3]),
        .I2(rd_data_sm_cs[0]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_7 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count[10]_i_1_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [3]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [2]),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [8]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_8 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [0]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [1]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [10]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RD_DATA_SM_RL.rd_latency_count_reg [4]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF13101313)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_2_n_0 ),
        .I1(rd_data_sm_cs[3]),
        .I2(rd_data_sm_cs[2]),
        .I3(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_3_n_0 ),
        .I4(rd_data_sm_cs[0]),
        .I5(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_4_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7070000F7070F0FF)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_2 
       (.I0(ar_active_re29_out),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_5_n_0 ),
        .I2(rd_data_sm_cs[1]),
        .I3(sel),
        .I4(rd_data_sm_cs[0]),
        .I5(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_4_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_3 
       (.I0(axi_rd_burst),
        .I1(sel),
        .I2(rd_data_sm_cs[1]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE00FF000000)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_4 
       (.I0(ar_active_re29_out),
        .I1(pend_rd_op),
        .I2(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_6_n_0 ),
        .I4(rd_data_sm_cs[1]),
        .I5(rd_data_sm_cs[0]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'h8880)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_5 
       (.I0(s_axi_rready),
        .I1(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .I2(act_rd_burst_two),
        .I3(act_rd_burst),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_6 
       (.I0(rd_data_sm_cs[3]),
        .I1(rd_data_sm_cs[2]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h0078)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[2]_i_1 
       (.I0(rd_data_sm_cs[1]),
        .I1(rd_data_sm_cs[0]),
        .I2(rd_data_sm_cs[2]),
        .I3(rd_data_sm_cs[3]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEEEE0000EAEEEAEE)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_3_n_0 ),
        .I1(rd_data_sm_cs[0]),
        .I2(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_4_n_0 ),
        .I3(rd_data_sm_cs[2]),
        .I4(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_5_n_0 ),
        .I5(\FSM_sequential_GEN_NO_RD_CMD_OPT.rlast_sm_cs[0]_i_2_n_0 ),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000AA00007F0000)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_2 
       (.I0(rd_data_sm_cs[0]),
        .I1(s_axi_rready),
        .I2(\GEN_NO_RD_CMD_OPT.axi_rvalid_int_reg_0 ),
        .I3(rd_data_sm_cs[2]),
        .I4(rd_data_sm_cs[3]),
        .I5(rd_data_sm_cs[1]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEEEEEEEEFEFFFEFE)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_3 
       (.I0(rd_data_sm_cs[1]),
        .I1(rd_data_sm_cs[3]),
        .I2(rd_data_sm_cs[2]),
        .I3(ar_active_d1),
        .I4(Arb2AR_Active),
        .I5(rd_data_sm_cs[0]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_4 
       (.I0(brst_zero),
        .I1(end_brst_rd),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0FFF040FFFF)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_5 
       (.I0(ar_active_d1),
        .I1(Arb2AR_Active),
        .I2(rd_data_sm_cs[0]),
        .I3(rd_data_sm_cs[1]),
        .I4(rd_data_sm_cs[3]),
        .I5(rd_data_sm_cs[2]),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[0] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[0]_i_1_n_0 ),
        .Q(rd_data_sm_cs[0]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[1]_i_1_n_0 ),
        .Q(rd_data_sm_cs[1]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[2] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[2]_i_1_n_0 ),
        .Q(rd_data_sm_cs[2]),
        .R(s_axi_aresetn_0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[3] 
       (.C(s_axi_aclk),
        .CE(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_1_n_0 ),
        .D(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs[3]_i_2_n_0 ),
        .Q(rd_data_sm_cs[3]),
        .R(s_axi_aresetn_0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 addr_rl_rd_buf_in0_carry
       (.CI(1'b0),
        .CO({addr_rl_rd_buf_in0_carry_n_0,addr_rl_rd_buf_in0_carry_n_1,addr_rl_rd_buf_in0_carry_n_2,addr_rl_rd_buf_in0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({addr_rl_rd_buf_in0_carry_i_1_n_0,addr_rl_rd_buf_in0_carry_i_2_n_0,addr_rl_rd_buf_in0_carry_i_3_n_0,addr_rl_rd_buf_in0_carry_i_4_n_0}),
        .O(NLW_addr_rl_rd_buf_in0_carry_O_UNCONNECTED[3:0]),
        .S({addr_rl_rd_buf_in0_carry_i_5_n_0,addr_rl_rd_buf_in0_carry_i_6_n_0,addr_rl_rd_buf_in0_carry_i_7_n_0,addr_rl_rd_buf_in0_carry_i_8_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 addr_rl_rd_buf_in0_carry__0
       (.CI(addr_rl_rd_buf_in0_carry_n_0),
        .CO({NLW_addr_rl_rd_buf_in0_carry__0_CO_UNCONNECTED[3:1],addr_rl_rd_buf_in0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_addr_rl_rd_buf_in0_carry__0_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,1'b0,addr_rl_rd_buf_in0_carry__0_i_1_n_0}));
  LUT2 #(
    .INIT(4'h1)) 
    addr_rl_rd_buf_in0_carry__0_i_1
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[8] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[9] ),
        .O(addr_rl_rd_buf_in0_carry__0_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    addr_rl_rd_buf_in0_carry_i_1
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[7] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[6] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .O(addr_rl_rd_buf_in0_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    addr_rl_rd_buf_in0_carry_i_2
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[5] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[4] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ),
        .O(addr_rl_rd_buf_in0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    addr_rl_rd_buf_in0_carry_i_3
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[3] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[2] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ),
        .O(addr_rl_rd_buf_in0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    addr_rl_rd_buf_in0_carry_i_4
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[1] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[0] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .O(addr_rl_rd_buf_in0_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    addr_rl_rd_buf_in0_carry_i_5
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[7] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[7] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[6] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[6] ),
        .O(addr_rl_rd_buf_in0_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    addr_rl_rd_buf_in0_carry_i_6
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[5] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[5] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[4] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[4] ),
        .O(addr_rl_rd_buf_in0_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    addr_rl_rd_buf_in0_carry_i_7
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[3] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[3] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[2] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[2] ),
        .O(addr_rl_rd_buf_in0_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    addr_rl_rd_buf_in0_carry_i_8
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[1] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[1] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_in_reg_n_0_[0] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[0] ),
        .O(addr_rl_rd_buf_in0_carry_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT2 #(
    .INIT(4'h8)) 
    axi_awready_int_i_2
       (.I0(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_0 ),
        .I1(s_axi_rready),
        .O(\GEN_NO_RD_CMD_OPT.axi_rlast_int_reg_1 ));
  LUT2 #(
    .INIT(4'hE)) 
    bram_en_a_INST_0
       (.I0(BRAM_En_B_i),
        .I1(BRAM_En_A_i),
        .O(bram_en_a));
  CARRY4 data_out_comp0_carry
       (.CI(1'b0),
        .CO({data_out_comp,data_out_comp0_carry_n_1,data_out_comp0_carry_n_2,data_out_comp0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_data_out_comp0_carry_O_UNCONNECTED[3:0]),
        .S({data_out_comp0_carry_i_1_n_0,data_out_comp0_carry_i_2_n_0,data_out_comp0_carry_i_3_n_0,data_out_comp0_carry_i_4_n_0}));
  LUT2 #(
    .INIT(4'h1)) 
    data_out_comp0_carry_i_1
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [9]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RD_BURST_RL.axi_rd_burst_two_i_3_n_0 ),
        .O(data_out_comp0_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h2010100802010120)) 
    data_out_comp0_carry_i_2
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[7] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[6] ),
        .I4(data_out_comp0_carry_i_5_n_0),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .O(data_out_comp0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h0096)) 
    data_out_comp0_carry_i_3
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[5] ),
        .I1(data_out_comp0_carry_i_6_n_0),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [5]),
        .I3(data_out_comp0_carry_i_7_n_0),
        .O(data_out_comp0_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h0000099090090000)) 
    data_out_comp0_carry_i_4
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[0] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [0]),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [2]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[2] ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[1] ),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [1]),
        .O(data_out_comp0_carry_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    data_out_comp0_carry_i_5
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[5] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[3] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[2] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[1] ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[4] ),
        .O(data_out_comp0_carry_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    data_out_comp0_carry_i_6
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[4] ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[1] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[2] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[3] ),
        .O(data_out_comp0_carry_i_6_n_0));
  LUT6 #(
    .INIT(64'h777BBBBDDDDEEEE7)) 
    data_out_comp0_carry_i_7
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [3]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[4] ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[1] ),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[2] ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg_reg_n_0_[3] ),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg [4]),
        .O(data_out_comp0_carry_i_7_n_0));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[0]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[0]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[0]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[0]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_n_0 ),
        .O(\s_axi_rdata[0]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[10]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[10]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[10]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[10]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_n_1 ),
        .O(\s_axi_rdata[10]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[11]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[11]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[11]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[11]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_n_2 ),
        .O(\s_axi_rdata[11]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[12]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[12]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[12]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[12]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_n_0 ),
        .O(\s_axi_rdata[12]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[13]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[13]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[13]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[13]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_n_1 ),
        .O(\s_axi_rdata[13]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[14]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_12_14_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[14]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[14]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[14]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_12_14_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_12_14_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_12_14_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_12_14_n_2 ),
        .O(\s_axi_rdata[14]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[15]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[15]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[15]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[15]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_n_0 ),
        .O(\s_axi_rdata[15]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[16]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[16]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[16]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[16]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_n_1 ),
        .O(\s_axi_rdata[16]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[17]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_15_17_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[17]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[17]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[17]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_15_17_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_15_17_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_15_17_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_15_17_n_2 ),
        .O(\s_axi_rdata[17]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[18]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[18]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[18]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[18]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_n_0 ),
        .O(\s_axi_rdata[18]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[19]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[19]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[19]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[19]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_n_1 ),
        .O(\s_axi_rdata[19]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[1]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[1]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[1]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[1]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_n_1 ),
        .O(\s_axi_rdata[1]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[20]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_18_20_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[20]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[20]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[20]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_18_20_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_18_20_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_18_20_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_18_20_n_2 ),
        .O(\s_axi_rdata[20]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[21]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[21]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[21]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[21]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_n_0 ),
        .O(\s_axi_rdata[21]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[22]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[22]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[22]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[22]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_n_1 ),
        .O(\s_axi_rdata[22]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[23]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_21_23_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[23]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[23]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[23]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_21_23_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_21_23_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_21_23_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_21_23_n_2 ),
        .O(\s_axi_rdata[23]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[24]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[24]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[24]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[24]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_n_0 ),
        .O(\s_axi_rdata[24]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[25]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[25]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[25]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[25]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_n_1 ),
        .O(\s_axi_rdata[25]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[26]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_24_26_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[26]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[26]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[26]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_24_26_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_24_26_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_24_26_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_24_26_n_2 ),
        .O(\s_axi_rdata[26]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[27]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[27]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[27]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[27]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_n_0 ),
        .O(\s_axi_rdata[27]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[28]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[28]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[28]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[28]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_n_1 ),
        .O(\s_axi_rdata[28]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[29]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_27_29_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[29]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[29]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[29]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_27_29_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_27_29_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_27_29_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_27_29_n_2 ),
        .O(\s_axi_rdata[29]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[2]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_0_2_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[2]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[2]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_0_2_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_0_2_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_0_2_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_0_2_n_2 ),
        .O(\s_axi_rdata[2]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[30]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[30]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[30]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[30]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_n_0 ),
        .O(\s_axi_rdata[30]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[31]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_30_31_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[31]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[31]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[31]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_30_31_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_30_31_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_30_31_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_30_31_n_1 ),
        .O(\s_axi_rdata[31]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[3]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[3]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[3]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_n_0 ),
        .O(\s_axi_rdata[3]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[4]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[4]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[4]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[4]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_n_1 ),
        .O(\s_axi_rdata[4]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[5]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_3_5_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[5]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[5]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[5]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_3_5_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_3_5_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_3_5_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_3_5_n_2 ),
        .O(\s_axi_rdata[5]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[6]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[6]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[6]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_n_0 ),
        .O(\s_axi_rdata[6]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[7]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[7]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[7]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[7]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_n_1 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_n_1 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_n_1 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_n_1 ),
        .O(\s_axi_rdata[7]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[8]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_6_8_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[8]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[8]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_6_8_n_2 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_6_8_n_2 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_6_8_n_2 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_6_8_n_2 ),
        .O(\s_axi_rdata[8]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \s_axi_rdata[9]_INST_0 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_256_319_9_11_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [8]),
        .I4(\s_axi_rdata[9]_INST_0_i_1_n_0 ),
        .O(s_axi_rdata[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[9]_INST_0_i_1 
       (.I0(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_192_255_9_11_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_128_191_9_11_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [7]),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_64_127_9_11_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.addr_rl_rd_buf_out_reg_rep [6]),
        .I5(\GEN_NO_RD_CMD_OPT.GEN_RDATA_NO_ECC.GEN_RDATA_RL_NO_ECC.rl_rd_buf_reg_0_63_9_11_n_0 ),
        .O(\s_axi_rdata[9]_INST_0_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "sng_port_arb" *) 
module cmod_a7_35t_axi_bram_ctrl_0_0_sng_port_arb
   (s_axi_awready,
    s_axi_arready,
    Arb2AW_Active,
    Arb2AR_Active,
    E,
    D,
    ar_active_re29_out,
    arb_sm_cs,
    s_axi_aresetn_0,
    bram_we_a,
    ar_active_reg_0,
    s_axi_aclk,
    aw_active_d1,
    s_axi_arlen,
    ar_active_d1,
    s_axi_arvalid,
    s_axi_awvalid,
    \FSM_sequential_arb_sm_cs_reg[0]_0 ,
    \FSM_sequential_arb_sm_cs_reg[0]_1 ,
    AW2Arb_Active_Clr,
    s_axi_rready,
    \GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg ,
    s_axi_aresetn,
    Q,
    last_arb_won_reg_0);
  output s_axi_awready;
  output s_axi_arready;
  output Arb2AW_Active;
  output Arb2AR_Active;
  output [0:0]E;
  output [7:0]D;
  output ar_active_re29_out;
  output [1:0]arb_sm_cs;
  output s_axi_aresetn_0;
  output [3:0]bram_we_a;
  input ar_active_reg_0;
  input s_axi_aclk;
  input aw_active_d1;
  input [7:0]s_axi_arlen;
  input ar_active_d1;
  input s_axi_arvalid;
  input s_axi_awvalid;
  input \FSM_sequential_arb_sm_cs_reg[0]_0 ;
  input \FSM_sequential_arb_sm_cs_reg[0]_1 ;
  input AW2Arb_Active_Clr;
  input s_axi_rready;
  input \GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg ;
  input s_axi_aresetn;
  input [3:0]Q;
  input last_arb_won_reg_0;

  wire AW2Arb_Active_Clr;
  wire Arb2AR_Active;
  wire Arb2AW_Active;
  wire [7:0]D;
  wire [0:0]E;
  wire \FSM_sequential_arb_sm_cs[0]_i_1_n_0 ;
  wire \FSM_sequential_arb_sm_cs[0]_i_2_n_0 ;
  wire \FSM_sequential_arb_sm_cs[1]_i_1_n_0 ;
  wire \FSM_sequential_arb_sm_cs[1]_i_2_n_0 ;
  wire \FSM_sequential_arb_sm_cs_reg[0]_0 ;
  wire \FSM_sequential_arb_sm_cs_reg[0]_1 ;
  wire \GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg ;
  wire [3:0]Q;
  wire ar_active_d1;
  wire ar_active_i_1_n_0;
  wire ar_active_i_2_n_0;
  wire ar_active_re29_out;
  wire ar_active_reg_0;
  wire [1:0]arb_sm_cs;
  wire [1:1]arb_sm_ns;
  wire aw_active_d1;
  wire aw_active_i_1_n_0;
  wire axi_arready_cmb;
  wire axi_arready_int_i_2_n_0;
  wire axi_arready_int_i_3_n_0;
  wire axi_arready_int_i_4_n_0;
  wire axi_awready_cmb;
  wire [3:0]bram_we_a;
  wire last_arb_won;
  wire last_arb_won_i_1_n_0;
  wire last_arb_won_reg_0;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire s_axi_aresetn_0;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_rready;

  LUT6 #(
    .INIT(64'hFA08F008FAF8F0F8)) 
    \FSM_sequential_arb_sm_cs[0]_i_1 
       (.I0(\FSM_sequential_arb_sm_cs_reg[0]_1 ),
        .I1(\FSM_sequential_arb_sm_cs[0]_i_2_n_0 ),
        .I2(arb_sm_cs[0]),
        .I3(arb_sm_cs[1]),
        .I4(\FSM_sequential_arb_sm_cs_reg[0]_0 ),
        .I5(AW2Arb_Active_Clr),
        .O(\FSM_sequential_arb_sm_cs[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h8F)) 
    \FSM_sequential_arb_sm_cs[0]_i_2 
       (.I0(last_arb_won),
        .I1(s_axi_awvalid),
        .I2(s_axi_arvalid),
        .O(\FSM_sequential_arb_sm_cs[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0030FFFFF0700000)) 
    \FSM_sequential_arb_sm_cs[1]_i_1 
       (.I0(last_arb_won),
        .I1(s_axi_awvalid),
        .I2(s_axi_arvalid),
        .I3(arb_sm_cs[0]),
        .I4(\FSM_sequential_arb_sm_cs[1]_i_2_n_0 ),
        .I5(arb_sm_cs[1]),
        .O(\FSM_sequential_arb_sm_cs[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFFECCFECFCECCCE)) 
    \FSM_sequential_arb_sm_cs[1]_i_2 
       (.I0(\FSM_sequential_arb_sm_cs_reg[0]_1 ),
        .I1(axi_arready_int_i_4_n_0),
        .I2(arb_sm_cs[0]),
        .I3(arb_sm_cs[1]),
        .I4(\FSM_sequential_arb_sm_cs_reg[0]_0 ),
        .I5(AW2Arb_Active_Clr),
        .O(\FSM_sequential_arb_sm_cs[1]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "wr_data:01,idle:00,rd_data:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_arb_sm_cs_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_arb_sm_cs[0]_i_1_n_0 ),
        .Q(arb_sm_cs[0]),
        .R(ar_active_reg_0));
  (* FSM_ENCODED_STATES = "wr_data:01,idle:00,rd_data:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_arb_sm_cs_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_arb_sm_cs[1]_i_1_n_0 ),
        .Q(arb_sm_cs[1]),
        .R(ar_active_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h0888)) 
    \GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_i_1 
       (.I0(s_axi_aresetn),
        .I1(Arb2AR_Active),
        .I2(s_axi_rready),
        .I3(\GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg ),
        .O(s_axi_aresetn_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[0]_i_1 
       (.I0(s_axi_arlen[0]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(s_axi_arvalid),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[1]_i_1 
       (.I0(s_axi_arlen[1]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(s_axi_arvalid),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[2]_i_1 
       (.I0(s_axi_arlen[2]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(s_axi_arvalid),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[3]_i_1 
       (.I0(s_axi_arlen[3]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(s_axi_arvalid),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[4]_i_1 
       (.I0(s_axi_arlen[4]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(s_axi_arvalid),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[5]_i_1 
       (.I0(s_axi_arlen[5]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(s_axi_arvalid),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[6]_i_1 
       (.I0(s_axi_arlen[6]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(s_axi_arvalid),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \GEN_NO_RD_CMD_OPT.GEN_CURR_ARLEN_RL.GEN_CURR_ARLEN_SNG.curr_arlen_reg[7]_i_2 
       (.I0(s_axi_arlen[7]),
        .I1(Arb2AR_Active),
        .I2(ar_active_d1),
        .I3(s_axi_arvalid),
        .O(D[7]));
  LUT5 #(
    .INIT(32'hABBBA888)) 
    ar_active_i_1
       (.I0(arb_sm_ns),
        .I1(ar_active_i_2_n_0),
        .I2(axi_arready_int_i_3_n_0),
        .I3(s_axi_arvalid),
        .I4(Arb2AR_Active),
        .O(ar_active_i_1_n_0));
  LUT6 #(
    .INIT(64'h00FF007000000070)) 
    ar_active_i_2
       (.I0(last_arb_won),
        .I1(s_axi_awvalid),
        .I2(s_axi_arvalid),
        .I3(arb_sm_cs[0]),
        .I4(arb_sm_cs[1]),
        .I5(\FSM_sequential_arb_sm_cs_reg[0]_0 ),
        .O(ar_active_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    ar_active_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ar_active_i_1_n_0),
        .Q(Arb2AR_Active),
        .R(ar_active_reg_0));
  LUT6 #(
    .INIT(64'h0A0ACFFF0A0A0000)) 
    aw_active_i_1
       (.I0(\FSM_sequential_arb_sm_cs_reg[0]_1 ),
        .I1(arb_sm_cs[1]),
        .I2(arb_sm_cs[0]),
        .I3(AW2Arb_Active_Clr),
        .I4(axi_awready_cmb),
        .I5(Arb2AW_Active),
        .O(aw_active_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    aw_active_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(aw_active_i_1_n_0),
        .Q(Arb2AW_Active),
        .R(ar_active_reg_0));
  LUT5 #(
    .INIT(32'hFFFFF020)) 
    axi_arready_int_i_1
       (.I0(axi_arready_int_i_2_n_0),
        .I1(s_axi_awvalid),
        .I2(s_axi_arvalid),
        .I3(axi_arready_int_i_3_n_0),
        .I4(axi_arready_int_i_4_n_0),
        .O(axi_arready_cmb));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0080)) 
    axi_arready_int_i_2
       (.I0(s_axi_rready),
        .I1(\GEN_NO_RD_CMD_OPT.GEN_AR_SNG.ar_active_d1_reg ),
        .I2(arb_sm_cs[1]),
        .I3(arb_sm_cs[0]),
        .O(axi_arready_int_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h08)) 
    axi_arready_int_i_3
       (.I0(AW2Arb_Active_Clr),
        .I1(arb_sm_cs[0]),
        .I2(arb_sm_cs[1]),
        .O(axi_arready_int_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00101010)) 
    axi_arready_int_i_4
       (.I0(arb_sm_cs[0]),
        .I1(arb_sm_cs[1]),
        .I2(s_axi_arvalid),
        .I3(s_axi_awvalid),
        .I4(last_arb_won),
        .O(axi_arready_int_i_4_n_0));
  FDRE #(
    .INIT(1'b0)) 
    axi_arready_int_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_arready_cmb),
        .Q(s_axi_arready),
        .R(ar_active_reg_0));
  LUT6 #(
    .INIT(64'h0000AA000000F300)) 
    axi_awready_int_i_1
       (.I0(\FSM_sequential_arb_sm_cs_reg[0]_0 ),
        .I1(s_axi_arvalid),
        .I2(last_arb_won),
        .I3(\FSM_sequential_arb_sm_cs_reg[0]_1 ),
        .I4(arb_sm_cs[0]),
        .I5(arb_sm_cs[1]),
        .O(axi_awready_cmb));
  FDRE #(
    .INIT(1'b0)) 
    axi_awready_int_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_awready_cmb),
        .Q(s_axi_awready),
        .R(ar_active_reg_0));
  LUT2 #(
    .INIT(4'h8)) 
    \bram_we_a[0]_INST_0 
       (.I0(Arb2AW_Active),
        .I1(Q[0]),
        .O(bram_we_a[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \bram_we_a[1]_INST_0 
       (.I0(Arb2AW_Active),
        .I1(Q[1]),
        .O(bram_we_a[1]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \bram_we_a[2]_INST_0 
       (.I0(Arb2AW_Active),
        .I1(Q[2]),
        .O(bram_we_a[2]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \bram_we_a[3]_INST_0 
       (.I0(Arb2AW_Active),
        .I1(Q[3]),
        .O(bram_we_a[3]));
  LUT6 #(
    .INIT(64'hAAAAABBBAAAAA888)) 
    last_arb_won_i_1
       (.I0(arb_sm_ns),
        .I1(axi_arready_cmb),
        .I2(\FSM_sequential_arb_sm_cs_reg[0]_1 ),
        .I3(axi_arready_int_i_2_n_0),
        .I4(last_arb_won_reg_0),
        .I5(last_arb_won),
        .O(last_arb_won_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00F03070)) 
    last_arb_won_i_2
       (.I0(last_arb_won),
        .I1(s_axi_awvalid),
        .I2(s_axi_arvalid),
        .I3(arb_sm_cs[1]),
        .I4(arb_sm_cs[0]),
        .O(arb_sm_ns));
  FDRE #(
    .INIT(1'b0)) 
    last_arb_won_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(last_arb_won_i_1_n_0),
        .Q(last_arb_won),
        .R(ar_active_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \save_init_bram_addr_ld[12]_i_1 
       (.I0(Arb2AW_Active),
        .I1(aw_active_d1),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \save_init_bram_addr_ld[12]_i_1__0 
       (.I0(Arb2AR_Active),
        .I1(ar_active_d1),
        .O(ar_active_re29_out));
endmodule

(* ORIG_REF_NAME = "wr_chnl" *) 
module cmod_a7_35t_axi_bram_ctrl_0_0_wr_chnl
   (aw_active_d1,
    BRAM_En_A_i,
    bram_wrdata_a,
    s_axi_wready,
    axi_bvalid_int_reg_0,
    curr_fixed_burst_reg,
    curr_fixed_burst_reg_reg_0,
    AW2Arb_Active_Clr,
    curr_wrap_burst_reg_reg_0,
    \ADDR_SNG_PORT.bram_addr_int_reg[2] ,
    s_axi_wvalid_0,
    D,
    s_axi_awaddr_2_sp_1,
    \bvalid_cnt_reg[1]_0 ,
    s_axi_awvalid_0,
    \GEN_WR_NO_ECC.bram_we_int_reg[3]_0 ,
    \save_init_bram_addr_ld_reg[3] ,
    s_axi_aclk,
    Arb2AW_Active,
    s_axi_wdata,
    s_axi_aresetn,
    s_axi_wvalid,
    s_axi_wlast,
    E,
    s_axi_bready,
    s_axi_awaddr,
    Q,
    s_axi_awvalid,
    arb_sm_cs,
    s_axi_awlen,
    s_axi_awburst,
    s_axi_wstrb);
  output aw_active_d1;
  output BRAM_En_A_i;
  output [31:0]bram_wrdata_a;
  output s_axi_wready;
  output axi_bvalid_int_reg_0;
  output curr_fixed_burst_reg;
  output curr_fixed_burst_reg_reg_0;
  output AW2Arb_Active_Clr;
  output curr_wrap_burst_reg_reg_0;
  output \ADDR_SNG_PORT.bram_addr_int_reg[2] ;
  output s_axi_wvalid_0;
  output [9:0]D;
  output s_axi_awaddr_2_sp_1;
  output \bvalid_cnt_reg[1]_0 ;
  output s_axi_awvalid_0;
  output [3:0]\GEN_WR_NO_ECC.bram_we_int_reg[3]_0 ;
  input \save_init_bram_addr_ld_reg[3] ;
  input s_axi_aclk;
  input Arb2AW_Active;
  input [31:0]s_axi_wdata;
  input s_axi_aresetn;
  input s_axi_wvalid;
  input s_axi_wlast;
  input [0:0]E;
  input s_axi_bready;
  input [10:0]s_axi_awaddr;
  input [3:0]Q;
  input s_axi_awvalid;
  input [1:0]arb_sm_cs;
  input [3:0]s_axi_awlen;
  input [1:0]s_axi_awburst;
  input [3:0]s_axi_wstrb;

  wire \ADDR_SNG_PORT.bram_addr_int_reg[2] ;
  wire AW2Arb_Active_Clr;
  wire [2:0]AW2Arb_BVALID_Cnt;
  wire Arb2AW_Active;
  wire BRAM_En_A_i;
  wire [9:0]D;
  wire [0:0]E;
  wire \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[0]_i_1_n_0 ;
  wire \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_1_n_0 ;
  wire \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_2_n_0 ;
  wire \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_1_n_0 ;
  wire \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_2_n_0 ;
  wire \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_3_n_0 ;
  wire \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ;
  wire \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ;
  wire \GEN_WR_NO_ECC.bram_we_int[3]_i_1_n_0 ;
  wire [3:0]\GEN_WR_NO_ECC.bram_we_int_reg[3]_0 ;
  wire I_WRAP_BRST_n_14;
  wire I_WRAP_BRST_n_15;
  wire [3:0]Q;
  wire [1:0]arb_sm_cs;
  wire aw_active_d1;
  wire axi_bvalid_int_i_1_n_0;
  wire axi_bvalid_int_i_2_n_0;
  wire axi_bvalid_int_reg_0;
  wire axi_wdata_full_cmb;
  wire axi_wdata_full_reg;
  wire axi_wr_burst;
  wire axi_wr_burst_i_1_n_0;
  wire axi_wr_burst_i_2_n_0;
  wire axi_wready_int_mod_i_1_n_0;
  wire bram_en_cmb;
  wire [31:0]bram_wrdata_a;
  wire \bvalid_cnt[0]_i_1_n_0 ;
  wire \bvalid_cnt[1]_i_1_n_0 ;
  wire \bvalid_cnt[2]_i_1_n_0 ;
  wire bvalid_cnt_inc;
  wire \bvalid_cnt_reg[1]_0 ;
  wire clr_bram_we;
  wire curr_fixed_burst_reg;
  wire curr_fixed_burst_reg_reg_0;
  wire curr_wrap_burst_reg;
  wire curr_wrap_burst_reg_reg_0;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire [10:0]s_axi_awaddr;
  wire s_axi_awaddr_2_sn_1;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awlen;
  wire s_axi_awvalid;
  wire s_axi_awvalid_0;
  wire s_axi_bready;
  wire [31:0]s_axi_wdata;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire s_axi_wvalid_0;
  wire \save_init_bram_addr_ld_reg[3] ;
  wire wrdata_reg_ld;

  assign s_axi_awaddr_2_sp_1 = s_axi_awaddr_2_sn_1;
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_5 
       (.I0(s_axi_wvalid),
        .I1(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .O(s_axi_wvalid_0));
  LUT6 #(
    .INIT(64'hFFFF1555FFFF0000)) 
    \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[0]_i_1 
       (.I0(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_3_n_0 ),
        .I1(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .I2(s_axi_wvalid),
        .I3(s_axi_wlast),
        .I4(AW2Arb_Active_Clr),
        .I5(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ),
        .O(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hA202FFFFA2020000)) 
    \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_1 
       (.I0(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ),
        .I1(s_axi_wlast),
        .I2(axi_wdata_full_reg),
        .I3(axi_wr_burst),
        .I4(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_2_n_0 ),
        .I5(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .O(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT5 #(
    .INIT(32'hFFFFEAAA)) 
    \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_2 
       (.I0(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_3_n_0 ),
        .I1(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .I2(s_axi_wvalid),
        .I3(s_axi_wlast),
        .I4(AW2Arb_Active_Clr),
        .O(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAF8C8C8C8)) 
    \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_1 
       (.I0(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_2_n_0 ),
        .I1(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_3_n_0 ),
        .I2(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .I3(s_axi_wvalid),
        .I4(s_axi_wlast),
        .I5(AW2Arb_Active_Clr),
        .O(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h08A8)) 
    \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_2 
       (.I0(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ),
        .I1(s_axi_wlast),
        .I2(axi_wdata_full_reg),
        .I3(axi_wr_burst),
        .O(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT4 #(
    .INIT(16'h8880)) 
    \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_3 
       (.I0(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ),
        .I1(Arb2AW_Active),
        .I2(axi_wdata_full_reg),
        .I3(s_axi_wvalid),
        .O(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_3_n_0 ));
  (* FSM_ENCODED_STATES = "idle:001,brst_wr_data:010,sng_wr_data:100" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[0]_i_1_n_0 ),
        .Q(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ),
        .S(\save_init_bram_addr_ld_reg[3] ));
  (* FSM_ENCODED_STATES = "idle:001,brst_wr_data:010,sng_wr_data:100" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[1]_i_1_n_0 ),
        .Q(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .R(\save_init_bram_addr_ld_reg[3] ));
  (* FSM_ENCODED_STATES = "idle:001,brst_wr_data:010,sng_wr_data:100" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_1_n_0 ),
        .Q(AW2Arb_Active_Clr),
        .R(\save_init_bram_addr_ld_reg[3] ));
  LUT6 #(
    .INIT(64'hFFFFF020F222F020)) 
    \GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.axi_wdata_full_reg_i_1 
       (.I0(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ),
        .I1(Arb2AW_Active),
        .I2(axi_wdata_full_reg),
        .I3(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .I4(s_axi_wvalid),
        .I5(AW2Arb_Active_Clr),
        .O(axi_wdata_full_cmb));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.axi_wdata_full_reg_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_wdata_full_cmb),
        .Q(axi_wdata_full_reg),
        .R(\save_init_bram_addr_ld_reg[3] ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT5 #(
    .INIT(32'hFC888888)) 
    \GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.bram_en_int_i_1 
       (.I0(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .I1(s_axi_wvalid),
        .I2(axi_wdata_full_reg),
        .I3(Arb2AW_Active),
        .I4(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ),
        .O(bram_en_cmb));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.bram_en_int_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bram_en_cmb),
        .Q(BRAM_En_A_i),
        .R(\save_init_bram_addr_ld_reg[3] ));
  LUT6 #(
    .INIT(64'hFFF0808080808080)) 
    \GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.clr_bram_we_i_1 
       (.I0(s_axi_wlast),
        .I1(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .I2(s_axi_wvalid),
        .I3(axi_wdata_full_reg),
        .I4(Arb2AW_Active),
        .I5(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_2_n_0 ),
        .O(bvalid_cnt_inc));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.clr_bram_we_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bvalid_cnt_inc),
        .Q(clr_bram_we),
        .R(\save_init_bram_addr_ld_reg[3] ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[0].bram_wrdata_int_reg[0] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[0]),
        .Q(bram_wrdata_a[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[10].bram_wrdata_int_reg[10] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[10]),
        .Q(bram_wrdata_a[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[11].bram_wrdata_int_reg[11] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[11]),
        .Q(bram_wrdata_a[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[12].bram_wrdata_int_reg[12] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[12]),
        .Q(bram_wrdata_a[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[13].bram_wrdata_int_reg[13] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[13]),
        .Q(bram_wrdata_a[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[14].bram_wrdata_int_reg[14] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[14]),
        .Q(bram_wrdata_a[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[15].bram_wrdata_int_reg[15] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[15]),
        .Q(bram_wrdata_a[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[16].bram_wrdata_int_reg[16] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[16]),
        .Q(bram_wrdata_a[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[17].bram_wrdata_int_reg[17] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[17]),
        .Q(bram_wrdata_a[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[18].bram_wrdata_int_reg[18] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[18]),
        .Q(bram_wrdata_a[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[19].bram_wrdata_int_reg[19] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[19]),
        .Q(bram_wrdata_a[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[1].bram_wrdata_int_reg[1] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[1]),
        .Q(bram_wrdata_a[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[20].bram_wrdata_int_reg[20] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[20]),
        .Q(bram_wrdata_a[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[21].bram_wrdata_int_reg[21] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[21]),
        .Q(bram_wrdata_a[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[22].bram_wrdata_int_reg[22] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[22]),
        .Q(bram_wrdata_a[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[23].bram_wrdata_int_reg[23] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[23]),
        .Q(bram_wrdata_a[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[24].bram_wrdata_int_reg[24] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[24]),
        .Q(bram_wrdata_a[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[25].bram_wrdata_int_reg[25] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[25]),
        .Q(bram_wrdata_a[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[26].bram_wrdata_int_reg[26] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[26]),
        .Q(bram_wrdata_a[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[27].bram_wrdata_int_reg[27] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[27]),
        .Q(bram_wrdata_a[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[28].bram_wrdata_int_reg[28] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[28]),
        .Q(bram_wrdata_a[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[29].bram_wrdata_int_reg[29] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[29]),
        .Q(bram_wrdata_a[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[2].bram_wrdata_int_reg[2] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[2]),
        .Q(bram_wrdata_a[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[30].bram_wrdata_int_reg[30] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[30]),
        .Q(bram_wrdata_a[30]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hF0F0B0A0)) 
    \GEN_WRDATA[31].bram_wrdata_int[31]_i_1 
       (.I0(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .I1(axi_wdata_full_reg),
        .I2(s_axi_wvalid),
        .I3(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ),
        .I4(AW2Arb_Active_Clr),
        .O(wrdata_reg_ld));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[31].bram_wrdata_int_reg[31] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[31]),
        .Q(bram_wrdata_a[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[3].bram_wrdata_int_reg[3] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[3]),
        .Q(bram_wrdata_a[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[4].bram_wrdata_int_reg[4] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[4]),
        .Q(bram_wrdata_a[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[5].bram_wrdata_int_reg[5] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[5]),
        .Q(bram_wrdata_a[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[6].bram_wrdata_int_reg[6] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[6]),
        .Q(bram_wrdata_a[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[7].bram_wrdata_int_reg[7] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[7]),
        .Q(bram_wrdata_a[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[8].bram_wrdata_int_reg[8] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[8]),
        .Q(bram_wrdata_a[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WRDATA[9].bram_wrdata_int_reg[9] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wdata[9]),
        .Q(bram_wrdata_a[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h4F)) 
    \GEN_WR_NO_ECC.bram_we_int[3]_i_1 
       (.I0(wrdata_reg_ld),
        .I1(clr_bram_we),
        .I2(s_axi_aresetn),
        .O(\GEN_WR_NO_ECC.bram_we_int[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WR_NO_ECC.bram_we_int_reg[0] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wstrb[0]),
        .Q(\GEN_WR_NO_ECC.bram_we_int_reg[3]_0 [0]),
        .R(\GEN_WR_NO_ECC.bram_we_int[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WR_NO_ECC.bram_we_int_reg[1] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wstrb[1]),
        .Q(\GEN_WR_NO_ECC.bram_we_int_reg[3]_0 [1]),
        .R(\GEN_WR_NO_ECC.bram_we_int[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WR_NO_ECC.bram_we_int_reg[2] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wstrb[2]),
        .Q(\GEN_WR_NO_ECC.bram_we_int_reg[3]_0 [2]),
        .R(\GEN_WR_NO_ECC.bram_we_int[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \GEN_WR_NO_ECC.bram_we_int_reg[3] 
       (.C(s_axi_aclk),
        .CE(wrdata_reg_ld),
        .D(s_axi_wstrb[3]),
        .Q(\GEN_WR_NO_ECC.bram_we_int_reg[3]_0 [3]),
        .R(\GEN_WR_NO_ECC.bram_we_int[3]_i_1_n_0 ));
  cmod_a7_35t_axi_bram_ctrl_0_0_wrap_brst I_WRAP_BRST
       (.\ADDR_SNG_PORT.bram_addr_int_reg[11] (\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[1] ),
        .\ADDR_SNG_PORT.bram_addr_int_reg[11]_0 (AW2Arb_Active_Clr),
        .\ADDR_SNG_PORT.bram_addr_int_reg[11]_1 (s_axi_wvalid_0),
        .\ADDR_SNG_PORT.bram_addr_int_reg[2] (\ADDR_SNG_PORT.bram_addr_int_reg[2] ),
        .Arb2AW_Active(Arb2AW_Active),
        .D(D),
        .E(E),
        .Q(Q),
        .curr_fixed_burst_reg(curr_fixed_burst_reg),
        .curr_fixed_burst_reg_reg(curr_fixed_burst_reg_reg_0),
        .curr_fixed_burst_reg_reg_0(I_WRAP_BRST_n_15),
        .curr_fixed_burst_reg_reg_1(aw_active_d1),
        .curr_wrap_burst_reg(curr_wrap_burst_reg),
        .curr_wrap_burst_reg_reg(curr_wrap_burst_reg_reg_0),
        .curr_wrap_burst_reg_reg_0(I_WRAP_BRST_n_14),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awaddr_2_sp_1(s_axi_awaddr_2_sn_1),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_wvalid(s_axi_wvalid),
        .\save_init_bram_addr_ld_reg[3]_0 (\save_init_bram_addr_ld_reg[3] ));
  FDRE #(
    .INIT(1'b0)) 
    aw_active_d1_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Arb2AW_Active),
        .Q(aw_active_d1),
        .R(\save_init_bram_addr_ld_reg[3] ));
  LUT4 #(
    .INIT(16'h2AAA)) 
    axi_awready_int_i_3
       (.I0(s_axi_awvalid),
        .I1(AW2Arb_BVALID_Cnt[2]),
        .I2(AW2Arb_BVALID_Cnt[0]),
        .I3(AW2Arb_BVALID_Cnt[1]),
        .O(s_axi_awvalid_0));
  LUT6 #(
    .INIT(64'hAAAAAAAAA8AAA8A8)) 
    axi_bvalid_int_i_1
       (.I0(s_axi_aresetn),
        .I1(AW2Arb_BVALID_Cnt[2]),
        .I2(AW2Arb_BVALID_Cnt[1]),
        .I3(axi_bvalid_int_i_2_n_0),
        .I4(AW2Arb_BVALID_Cnt[0]),
        .I5(bvalid_cnt_inc),
        .O(axi_bvalid_int_i_1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    axi_bvalid_int_i_2
       (.I0(s_axi_bready),
        .I1(axi_bvalid_int_reg_0),
        .O(axi_bvalid_int_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    axi_bvalid_int_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_bvalid_int_i_1_n_0),
        .Q(axi_bvalid_int_reg_0),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h5754)) 
    axi_wr_burst_i_1
       (.I0(s_axi_wlast),
        .I1(axi_wr_burst_i_2_n_0),
        .I2(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs[2]_i_3_n_0 ),
        .I3(axi_wr_burst),
        .O(axi_wr_burst_i_1_n_0));
  LUT4 #(
    .INIT(16'hA0E0)) 
    axi_wr_burst_i_2
       (.I0(AW2Arb_Active_Clr),
        .I1(\FSM_onehot_GEN_WDATA_SM_NO_ECC_SNG_REG_WREADY.wr_data_sng_sm_cs_reg_n_0_[0] ),
        .I2(s_axi_wvalid),
        .I3(axi_wdata_full_reg),
        .O(axi_wr_burst_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    axi_wr_burst_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_wr_burst_i_1_n_0),
        .Q(axi_wr_burst),
        .R(\save_init_bram_addr_ld_reg[3] ));
  LUT2 #(
    .INIT(4'h2)) 
    axi_wready_int_mod_i_1
       (.I0(s_axi_aresetn),
        .I1(axi_wdata_full_cmb),
        .O(axi_wready_int_mod_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    axi_wready_int_mod_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_wready_int_mod_i_1_n_0),
        .Q(s_axi_wready),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h88887777777F8880)) 
    \bvalid_cnt[0]_i_1 
       (.I0(axi_bvalid_int_reg_0),
        .I1(s_axi_bready),
        .I2(AW2Arb_BVALID_Cnt[1]),
        .I3(AW2Arb_BVALID_Cnt[2]),
        .I4(bvalid_cnt_inc),
        .I5(AW2Arb_BVALID_Cnt[0]),
        .O(\bvalid_cnt[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEE10778877887788)) 
    \bvalid_cnt[1]_i_1 
       (.I0(bvalid_cnt_inc),
        .I1(AW2Arb_BVALID_Cnt[0]),
        .I2(AW2Arb_BVALID_Cnt[2]),
        .I3(AW2Arb_BVALID_Cnt[1]),
        .I4(s_axi_bready),
        .I5(axi_bvalid_int_reg_0),
        .O(\bvalid_cnt[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0E078F078F078F0)) 
    \bvalid_cnt[2]_i_1 
       (.I0(bvalid_cnt_inc),
        .I1(AW2Arb_BVALID_Cnt[0]),
        .I2(AW2Arb_BVALID_Cnt[2]),
        .I3(AW2Arb_BVALID_Cnt[1]),
        .I4(s_axi_bready),
        .I5(axi_bvalid_int_reg_0),
        .O(\bvalid_cnt[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \bvalid_cnt_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\bvalid_cnt[0]_i_1_n_0 ),
        .Q(AW2Arb_BVALID_Cnt[0]),
        .R(\save_init_bram_addr_ld_reg[3] ));
  FDRE #(
    .INIT(1'b0)) 
    \bvalid_cnt_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\bvalid_cnt[1]_i_1_n_0 ),
        .Q(AW2Arb_BVALID_Cnt[1]),
        .R(\save_init_bram_addr_ld_reg[3] ));
  FDRE #(
    .INIT(1'b0)) 
    \bvalid_cnt_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\bvalid_cnt[2]_i_1_n_0 ),
        .Q(AW2Arb_BVALID_Cnt[2]),
        .R(\save_init_bram_addr_ld_reg[3] ));
  FDRE #(
    .INIT(1'b0)) 
    curr_fixed_burst_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(I_WRAP_BRST_n_15),
        .Q(curr_fixed_burst_reg),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    curr_wrap_burst_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(I_WRAP_BRST_n_14),
        .Q(curr_wrap_burst_reg),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000007F00)) 
    last_arb_won_i_3
       (.I0(AW2Arb_BVALID_Cnt[1]),
        .I1(AW2Arb_BVALID_Cnt[0]),
        .I2(AW2Arb_BVALID_Cnt[2]),
        .I3(s_axi_awvalid),
        .I4(arb_sm_cs[0]),
        .I5(arb_sm_cs[1]),
        .O(\bvalid_cnt_reg[1]_0 ));
endmodule

(* ORIG_REF_NAME = "wrap_brst" *) 
module cmod_a7_35t_axi_bram_ctrl_0_0_wrap_brst
   (curr_fixed_burst_reg_reg,
    curr_wrap_burst_reg_reg,
    \ADDR_SNG_PORT.bram_addr_int_reg[2] ,
    D,
    s_axi_awaddr_2_sp_1,
    curr_wrap_burst_reg_reg_0,
    curr_fixed_burst_reg_reg_0,
    curr_fixed_burst_reg,
    s_axi_wvalid,
    \ADDR_SNG_PORT.bram_addr_int_reg[11] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ,
    s_axi_aresetn,
    E,
    curr_wrap_burst_reg,
    \ADDR_SNG_PORT.bram_addr_int_reg[11]_1 ,
    s_axi_awaddr,
    curr_fixed_burst_reg_reg_1,
    Arb2AW_Active,
    Q,
    s_axi_awlen,
    s_axi_awvalid,
    s_axi_awburst,
    \save_init_bram_addr_ld_reg[3]_0 ,
    s_axi_aclk);
  output curr_fixed_burst_reg_reg;
  output curr_wrap_burst_reg_reg;
  output \ADDR_SNG_PORT.bram_addr_int_reg[2] ;
  output [9:0]D;
  output s_axi_awaddr_2_sp_1;
  output curr_wrap_burst_reg_reg_0;
  output curr_fixed_burst_reg_reg_0;
  input curr_fixed_burst_reg;
  input s_axi_wvalid;
  input \ADDR_SNG_PORT.bram_addr_int_reg[11] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ;
  input s_axi_aresetn;
  input [0:0]E;
  input curr_wrap_burst_reg;
  input \ADDR_SNG_PORT.bram_addr_int_reg[11]_1 ;
  input [10:0]s_axi_awaddr;
  input curr_fixed_burst_reg_reg_1;
  input Arb2AW_Active;
  input [3:0]Q;
  input [3:0]s_axi_awlen;
  input s_axi_awvalid;
  input [1:0]s_axi_awburst;
  input \save_init_bram_addr_ld_reg[3]_0 ;
  input s_axi_aclk;

  wire \ADDR_SNG_PORT.bram_addr_int[11]_i_8_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[11]_i_9_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[11] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[11]_1 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[2] ;
  wire Arb2AW_Active;
  wire [9:0]D;
  wire [0:0]E;
  wire [3:0]Q;
  wire curr_fixed_burst_reg;
  wire curr_fixed_burst_reg_reg;
  wire curr_fixed_burst_reg_reg_0;
  wire curr_fixed_burst_reg_reg_1;
  wire curr_wrap_burst_reg;
  wire curr_wrap_burst_reg_reg;
  wire curr_wrap_burst_reg_reg_0;
  wire [10:1]data0;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire [10:0]s_axi_awaddr;
  wire s_axi_awaddr_2_sn_1;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awlen;
  wire s_axi_awvalid;
  wire s_axi_wvalid;
  wire \save_init_bram_addr_ld[12]_i_3_n_0 ;
  wire \save_init_bram_addr_ld_reg[3]_0 ;
  wire [2:0]wrap_burst_total;
  wire \wrap_burst_total[0]_i_1__0_n_0 ;
  wire \wrap_burst_total[1]_i_1__0_n_0 ;
  wire \wrap_burst_total[2]_i_1_n_0 ;

  assign s_axi_awaddr_2_sp_1 = s_axi_awaddr_2_sn_1;
  LUT6 #(
    .INIT(64'hBF000000FFFFFFFF)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_1 
       (.I0(curr_fixed_burst_reg),
        .I1(s_axi_wvalid),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] ),
        .I3(\ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ),
        .I4(curr_wrap_burst_reg_reg),
        .I5(s_axi_aresetn),
        .O(curr_fixed_burst_reg_reg));
  LUT6 #(
    .INIT(64'h1111515555555555)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_4 
       (.I0(E),
        .I1(curr_wrap_burst_reg),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[2] ),
        .I3(\ADDR_SNG_PORT.bram_addr_int[11]_i_8_n_0 ),
        .I4(\ADDR_SNG_PORT.bram_addr_int[11]_i_9_n_0 ),
        .I5(\ADDR_SNG_PORT.bram_addr_int_reg[11]_1 ),
        .O(curr_wrap_burst_reg_reg));
  LUT3 #(
    .INIT(8'h04)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_8 
       (.I0(wrap_burst_total[1]),
        .I1(wrap_burst_total[2]),
        .I2(wrap_burst_total[0]),
        .O(\ADDR_SNG_PORT.bram_addr_int[11]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h000000008FA00000)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_9 
       (.I0(Q[1]),
        .I1(Q[2]),
        .I2(wrap_burst_total[1]),
        .I3(wrap_burst_total[0]),
        .I4(Q[0]),
        .I5(wrap_burst_total[2]),
        .O(\ADDR_SNG_PORT.bram_addr_int[11]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \ADDR_SNG_PORT.bram_addr_int[2]_i_3 
       (.I0(s_axi_awaddr[0]),
        .I1(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .O(s_axi_awaddr_2_sn_1));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \ADDR_SNG_PORT.bram_addr_int[6]_i_2 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\ADDR_SNG_PORT.bram_addr_int_reg[2] ));
  LUT6 #(
    .INIT(64'h000000008A8A8ABA)) 
    curr_fixed_burst_reg_i_1
       (.I0(curr_fixed_burst_reg),
        .I1(curr_fixed_burst_reg_reg_1),
        .I2(Arb2AW_Active),
        .I3(s_axi_awburst[1]),
        .I4(s_axi_awburst[0]),
        .I5(curr_fixed_burst_reg_reg),
        .O(curr_fixed_burst_reg_reg_0));
  LUT6 #(
    .INIT(64'h000000008ABA8A8A)) 
    curr_wrap_burst_reg_i_1
       (.I0(curr_wrap_burst_reg),
        .I1(curr_fixed_burst_reg_reg_1),
        .I2(Arb2AW_Active),
        .I3(s_axi_awburst[0]),
        .I4(s_axi_awburst[1]),
        .I5(curr_fixed_burst_reg_reg),
        .O(curr_wrap_burst_reg_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \save_init_bram_addr_ld[10]_i_1 
       (.I0(data0[8]),
        .I1(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I2(s_axi_awaddr[8]),
        .O(D[7]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \save_init_bram_addr_ld[11]_i_1 
       (.I0(data0[9]),
        .I1(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I2(s_axi_awaddr[9]),
        .O(D[8]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \save_init_bram_addr_ld[12]_i_2 
       (.I0(data0[10]),
        .I1(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I2(s_axi_awaddr[10]),
        .O(D[9]));
  LUT6 #(
    .INIT(64'hB0B0BBB000000000)) 
    \save_init_bram_addr_ld[12]_i_3 
       (.I0(curr_fixed_burst_reg_reg_1),
        .I1(Arb2AW_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int[11]_i_9_n_0 ),
        .I3(\ADDR_SNG_PORT.bram_addr_int[11]_i_8_n_0 ),
        .I4(\ADDR_SNG_PORT.bram_addr_int_reg[2] ),
        .I5(curr_wrap_burst_reg),
        .O(\save_init_bram_addr_ld[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hA08AFFFFA08A0000)) 
    \save_init_bram_addr_ld[3]_i_1 
       (.I0(data0[1]),
        .I1(wrap_burst_total[0]),
        .I2(wrap_burst_total[2]),
        .I3(wrap_burst_total[1]),
        .I4(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I5(s_axi_awaddr[1]),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hA82AFFFFA82A0000)) 
    \save_init_bram_addr_ld[4]_i_1 
       (.I0(data0[2]),
        .I1(wrap_burst_total[0]),
        .I2(wrap_burst_total[1]),
        .I3(wrap_burst_total[2]),
        .I4(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I5(s_axi_awaddr[2]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hAA8AFFFFAA8A0000)) 
    \save_init_bram_addr_ld[5]_i_1 
       (.I0(data0[3]),
        .I1(wrap_burst_total[0]),
        .I2(wrap_burst_total[2]),
        .I3(wrap_burst_total[1]),
        .I4(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I5(s_axi_awaddr[3]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \save_init_bram_addr_ld[6]_i_1 
       (.I0(data0[4]),
        .I1(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I2(s_axi_awaddr[4]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \save_init_bram_addr_ld[7]_i_1 
       (.I0(data0[5]),
        .I1(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I2(s_axi_awaddr[5]),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \save_init_bram_addr_ld[8]_i_1 
       (.I0(data0[6]),
        .I1(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I2(s_axi_awaddr[6]),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \save_init_bram_addr_ld[9]_i_1 
       (.I0(data0[7]),
        .I1(\save_init_bram_addr_ld[12]_i_3_n_0 ),
        .I2(s_axi_awaddr[7]),
        .O(D[6]));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[10] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[7]),
        .Q(data0[8]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[11] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[8]),
        .Q(data0[9]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[12] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[9]),
        .Q(data0[10]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[3] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[0]),
        .Q(data0[1]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[4] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[1]),
        .Q(data0[2]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[5] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[2]),
        .Q(data0[3]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[6] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[3]),
        .Q(data0[4]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[7] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[4]),
        .Q(data0[5]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[8] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[5]),
        .Q(data0[6]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[9] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(D[6]),
        .Q(data0[7]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT5 #(
    .INIT(32'h40000040)) 
    \wrap_burst_total[0]_i_1__0 
       (.I0(s_axi_awlen[3]),
        .I1(s_axi_awvalid),
        .I2(s_axi_awlen[0]),
        .I3(s_axi_awlen[1]),
        .I4(s_axi_awlen[2]),
        .O(\wrap_burst_total[0]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'h2000)) 
    \wrap_burst_total[1]_i_1__0 
       (.I0(s_axi_awlen[1]),
        .I1(s_axi_awlen[3]),
        .I2(s_axi_awvalid),
        .I3(s_axi_awlen[0]),
        .O(\wrap_burst_total[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \wrap_burst_total[2]_i_1 
       (.I0(s_axi_awlen[0]),
        .I1(s_axi_awvalid),
        .I2(s_axi_awlen[2]),
        .I3(s_axi_awlen[1]),
        .I4(s_axi_awlen[3]),
        .O(\wrap_burst_total[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \wrap_burst_total_reg[0] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\wrap_burst_total[0]_i_1__0_n_0 ),
        .Q(wrap_burst_total[0]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \wrap_burst_total_reg[1] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\wrap_burst_total[1]_i_1__0_n_0 ),
        .Q(wrap_burst_total[1]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \wrap_burst_total_reg[2] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\wrap_burst_total[2]_i_1_n_0 ),
        .Q(wrap_burst_total[2]),
        .R(\save_init_bram_addr_ld_reg[3]_0 ));
endmodule

(* ORIG_REF_NAME = "wrap_brst" *) 
module cmod_a7_35t_axi_bram_ctrl_0_0_wrap_brst_0
   (E,
    ar_active_reg,
    \GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ,
    D,
    \save_init_bram_addr_ld_reg[12]_0 ,
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[1] ,
    \GEN_NO_RD_CMD_OPT.brst_cnt_reg[4] ,
    SR,
    Q,
    s_axi_rready,
    \ADDR_SNG_PORT.bram_addr_int[11]_i_6_0 ,
    brst_zero,
    end_brst_rd,
    curr_fixed_burst_reg,
    \ADDR_SNG_PORT.bram_addr_int_reg[2] ,
    Arb2AR_Active,
    curr_fixed_burst_reg_0,
    \ADDR_SNG_PORT.bram_addr_int_reg[11] ,
    bram_addr_a,
    \ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ,
    \ADDR_SNG_PORT.bram_addr_int_reg[10] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[9] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[8] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[7] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[6] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[5] ,
    \ADDR_SNG_PORT.bram_addr_int_reg[4] ,
    s_axi_araddr,
    \ADDR_SNG_PORT.bram_addr_int_reg[2]_0 ,
    \ADDR_SNG_PORT.bram_addr_int_reg[2]_1 ,
    \ADDR_SNG_PORT.bram_addr_int_reg[2]_2 ,
    s_axi_arlen,
    curr_wrap_burst_reg,
    axi_rd_burst,
    sel,
    \GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 ,
    s_axi_aresetn,
    ar_active_re29_out,
    s_axi_aclk);
  output [0:0]E;
  output ar_active_reg;
  output \GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ;
  output [9:0]D;
  output [0:0]\save_init_bram_addr_ld_reg[12]_0 ;
  output \GEN_NO_RD_CMD_OPT.brst_cnt_reg[1] ;
  output \GEN_NO_RD_CMD_OPT.brst_cnt_reg[4] ;
  output [0:0]SR;
  input [3:0]Q;
  input s_axi_rready;
  input \ADDR_SNG_PORT.bram_addr_int[11]_i_6_0 ;
  input brst_zero;
  input end_brst_rd;
  input curr_fixed_burst_reg;
  input \ADDR_SNG_PORT.bram_addr_int_reg[2] ;
  input Arb2AR_Active;
  input curr_fixed_burst_reg_0;
  input [8:0]\ADDR_SNG_PORT.bram_addr_int_reg[11] ;
  input [9:0]bram_addr_a;
  input \ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[10] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[9] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[8] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[7] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[6] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[5] ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[4] ;
  input [10:0]s_axi_araddr;
  input \ADDR_SNG_PORT.bram_addr_int_reg[2]_0 ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[2]_1 ;
  input \ADDR_SNG_PORT.bram_addr_int_reg[2]_2 ;
  input [3:0]s_axi_arlen;
  input curr_wrap_burst_reg;
  input axi_rd_burst;
  input sel;
  input [7:0]\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 ;
  input s_axi_aresetn;
  input ar_active_re29_out;
  input s_axi_aclk;

  wire \ADDR_SNG_PORT.bram_addr_int[11]_i_10_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[11]_i_11_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[11]_i_12_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[11]_i_13_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[11]_i_6_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[2]_i_2_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int[2]_i_4_n_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[10] ;
  wire [8:0]\ADDR_SNG_PORT.bram_addr_int_reg[11] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[2] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[2]_0 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[2]_1 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[2]_2 ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[4] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[5] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[6] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[7] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[8] ;
  wire \ADDR_SNG_PORT.bram_addr_int_reg[9] ;
  wire Arb2AR_Active;
  wire [9:0]D;
  wire [0:0]E;
  wire \GEN_NO_RD_CMD_OPT.brst_cnt_reg[1] ;
  wire \GEN_NO_RD_CMD_OPT.brst_cnt_reg[4] ;
  wire [7:0]\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 ;
  wire \GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ;
  wire [3:0]Q;
  wire [9:1]RdChnl_BRAM_Addr_Ld;
  wire [0:0]SR;
  wire ar_active_re29_out;
  wire ar_active_reg;
  wire axi_rd_burst;
  wire [9:0]bram_addr_a;
  wire brst_zero;
  wire curr_fixed_burst_reg;
  wire curr_fixed_burst_reg_0;
  wire curr_wrap_burst_reg;
  wire end_brst_rd;
  wire s_axi_aclk;
  wire [10:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire [3:0]s_axi_arlen;
  wire s_axi_rready;
  wire \save_init_bram_addr_ld[12]_i_3__0_n_0 ;
  wire \save_init_bram_addr_ld[3]_i_2_n_0 ;
  wire \save_init_bram_addr_ld[4]_i_2_n_0 ;
  wire \save_init_bram_addr_ld[5]_i_2_n_0 ;
  wire [0:0]\save_init_bram_addr_ld_reg[12]_0 ;
  wire \save_init_bram_addr_ld_reg_n_0_[10] ;
  wire \save_init_bram_addr_ld_reg_n_0_[11] ;
  wire \save_init_bram_addr_ld_reg_n_0_[12] ;
  wire \save_init_bram_addr_ld_reg_n_0_[3] ;
  wire \save_init_bram_addr_ld_reg_n_0_[4] ;
  wire \save_init_bram_addr_ld_reg_n_0_[5] ;
  wire \save_init_bram_addr_ld_reg_n_0_[6] ;
  wire \save_init_bram_addr_ld_reg_n_0_[7] ;
  wire \save_init_bram_addr_ld_reg_n_0_[8] ;
  wire \save_init_bram_addr_ld_reg_n_0_[9] ;
  wire sel;
  wire \wrap_burst_total[0]_i_1_n_0 ;
  wire \wrap_burst_total[1]_i_1_n_0 ;
  wire \wrap_burst_total[2]_i_1__0_n_0 ;
  wire \wrap_burst_total_reg_n_0_[0] ;
  wire \wrap_burst_total_reg_n_0_[1] ;
  wire \wrap_burst_total_reg_n_0_[2] ;

  LUT6 #(
    .INIT(64'hB800B8FFB8FFB800)) 
    \ADDR_SNG_PORT.bram_addr_int[10]_i_1 
       (.I0(RdChnl_BRAM_Addr_Ld[8]),
        .I1(Arb2AR_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] [7]),
        .I3(ar_active_reg),
        .I4(bram_addr_a[8]),
        .I5(\ADDR_SNG_PORT.bram_addr_int_reg[10] ),
        .O(D[8]));
  LUT2 #(
    .INIT(4'hE)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_10 
       (.I0(Q[1]),
        .I1(Q[0]),
        .O(\ADDR_SNG_PORT.bram_addr_int[11]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h1555155515555555)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_11 
       (.I0(Q[3]),
        .I1(s_axi_rready),
        .I2(\ADDR_SNG_PORT.bram_addr_int[11]_i_6_0 ),
        .I3(Q[2]),
        .I4(brst_zero),
        .I5(end_brst_rd),
        .O(\ADDR_SNG_PORT.bram_addr_int[11]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hA888)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_12 
       (.I0(Q[3]),
        .I1(Q[2]),
        .I2(\ADDR_SNG_PORT.bram_addr_int[11]_i_6_0 ),
        .I3(s_axi_rready),
        .O(\ADDR_SNG_PORT.bram_addr_int[11]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h998800009988333F)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_13 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(axi_rd_burst),
        .I3(sel),
        .I4(Q[2]),
        .I5(Q[3]),
        .O(\ADDR_SNG_PORT.bram_addr_int[11]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_14 
       (.I0(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 [4]),
        .I1(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 [5]),
        .I2(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 [6]),
        .I3(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 [7]),
        .O(\GEN_NO_RD_CMD_OPT.brst_cnt_reg[4] ));
  LUT6 #(
    .INIT(64'hAABAFFBAAABAAABA)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_2 
       (.I0(ar_active_reg),
        .I1(curr_fixed_burst_reg),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[2] ),
        .I3(Arb2AR_Active),
        .I4(curr_fixed_burst_reg_0),
        .I5(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .O(E));
  LUT6 #(
    .INIT(64'hB800B8FFB8FFB800)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_3 
       (.I0(RdChnl_BRAM_Addr_Ld[9]),
        .I1(Arb2AR_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] [8]),
        .I3(ar_active_reg),
        .I4(bram_addr_a[9]),
        .I5(\ADDR_SNG_PORT.bram_addr_int_reg[11]_0 ),
        .O(D[9]));
  LUT6 #(
    .INIT(64'h000D000D0000000D)) 
    \ADDR_SNG_PORT.bram_addr_int[11]_i_6 
       (.I0(\ADDR_SNG_PORT.bram_addr_int[11]_i_10_n_0 ),
        .I1(\ADDR_SNG_PORT.bram_addr_int[11]_i_11_n_0 ),
        .I2(\ADDR_SNG_PORT.bram_addr_int[11]_i_12_n_0 ),
        .I3(\ADDR_SNG_PORT.bram_addr_int[11]_i_13_n_0 ),
        .I4(\GEN_NO_RD_CMD_OPT.brst_cnt_reg[1] ),
        .I5(\GEN_NO_RD_CMD_OPT.brst_cnt_reg[4] ),
        .O(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ));
  LUT5 #(
    .INIT(32'h22F2FFFF)) 
    \ADDR_SNG_PORT.bram_addr_int[12]_i_2 
       (.I0(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I1(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I2(Arb2AR_Active),
        .I3(\ADDR_SNG_PORT.bram_addr_int_reg[2]_1 ),
        .I4(\ADDR_SNG_PORT.bram_addr_int_reg[2]_2 ),
        .O(ar_active_reg));
  LUT6 #(
    .INIT(64'h2F2000002F20FFFF)) 
    \ADDR_SNG_PORT.bram_addr_int[2]_i_1 
       (.I0(s_axi_araddr[0]),
        .I1(\ADDR_SNG_PORT.bram_addr_int[2]_i_2_n_0 ),
        .I2(Arb2AR_Active),
        .I3(\ADDR_SNG_PORT.bram_addr_int_reg[2]_0 ),
        .I4(ar_active_reg),
        .I5(bram_addr_a[0]),
        .O(D[0]));
  LUT5 #(
    .INIT(32'h88A80000)) 
    \ADDR_SNG_PORT.bram_addr_int[2]_i_2 
       (.I0(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I1(\ADDR_SNG_PORT.bram_addr_int[2]_i_4_n_0 ),
        .I2(\save_init_bram_addr_ld[5]_i_2_n_0 ),
        .I3(\ADDR_SNG_PORT.bram_addr_int_reg[6] ),
        .I4(curr_wrap_burst_reg),
        .O(\ADDR_SNG_PORT.bram_addr_int[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h4440044000400040)) 
    \ADDR_SNG_PORT.bram_addr_int[2]_i_4 
       (.I0(\wrap_burst_total_reg_n_0_[2] ),
        .I1(bram_addr_a[0]),
        .I2(\wrap_burst_total_reg_n_0_[0] ),
        .I3(\wrap_burst_total_reg_n_0_[1] ),
        .I4(bram_addr_a[2]),
        .I5(bram_addr_a[1]),
        .O(\ADDR_SNG_PORT.bram_addr_int[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hB800B8FFB8FFB800)) 
    \ADDR_SNG_PORT.bram_addr_int[3]_i_1 
       (.I0(RdChnl_BRAM_Addr_Ld[1]),
        .I1(Arb2AR_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] [0]),
        .I3(ar_active_reg),
        .I4(bram_addr_a[0]),
        .I5(bram_addr_a[1]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hB800B8FFB8FFB800)) 
    \ADDR_SNG_PORT.bram_addr_int[4]_i_1 
       (.I0(RdChnl_BRAM_Addr_Ld[2]),
        .I1(Arb2AR_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] [1]),
        .I3(ar_active_reg),
        .I4(bram_addr_a[2]),
        .I5(\ADDR_SNG_PORT.bram_addr_int_reg[4] ),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B8FF)) 
    \ADDR_SNG_PORT.bram_addr_int[5]_i_1 
       (.I0(RdChnl_BRAM_Addr_Ld[3]),
        .I1(Arb2AR_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] [2]),
        .I3(ar_active_reg),
        .I4(bram_addr_a[3]),
        .I5(\ADDR_SNG_PORT.bram_addr_int_reg[5] ),
        .O(D[3]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B8FF)) 
    \ADDR_SNG_PORT.bram_addr_int[6]_i_1 
       (.I0(RdChnl_BRAM_Addr_Ld[4]),
        .I1(Arb2AR_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] [3]),
        .I3(ar_active_reg),
        .I4(bram_addr_a[4]),
        .I5(\ADDR_SNG_PORT.bram_addr_int_reg[6] ),
        .O(D[4]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B8FF)) 
    \ADDR_SNG_PORT.bram_addr_int[7]_i_1 
       (.I0(RdChnl_BRAM_Addr_Ld[5]),
        .I1(Arb2AR_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] [4]),
        .I3(ar_active_reg),
        .I4(bram_addr_a[5]),
        .I5(\ADDR_SNG_PORT.bram_addr_int_reg[7] ),
        .O(D[5]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B8FF)) 
    \ADDR_SNG_PORT.bram_addr_int[8]_i_1 
       (.I0(RdChnl_BRAM_Addr_Ld[6]),
        .I1(Arb2AR_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] [5]),
        .I3(ar_active_reg),
        .I4(\ADDR_SNG_PORT.bram_addr_int_reg[8] ),
        .I5(bram_addr_a[6]),
        .O(D[6]));
  LUT6 #(
    .INIT(64'hB800B8FFB8FFB800)) 
    \ADDR_SNG_PORT.bram_addr_int[9]_i_1 
       (.I0(RdChnl_BRAM_Addr_Ld[7]),
        .I1(Arb2AR_Active),
        .I2(\ADDR_SNG_PORT.bram_addr_int_reg[11] [6]),
        .I3(ar_active_reg),
        .I4(bram_addr_a[7]),
        .I5(\ADDR_SNG_PORT.bram_addr_int_reg[9] ),
        .O(D[7]));
  LUT4 #(
    .INIT(16'h0001)) 
    \GEN_NO_RD_CMD_OPT.brst_cnt[6]_i_2 
       (.I0(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 [1]),
        .I1(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 [0]),
        .I2(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 [2]),
        .I3(\GEN_NO_RD_CMD_OPT.last_bram_addr_i_2 [3]),
        .O(\GEN_NO_RD_CMD_OPT.brst_cnt_reg[1] ));
  LUT1 #(
    .INIT(2'h1)) 
    bram_rst_a_INST_0
       (.I0(s_axi_aresetn),
        .O(SR));
  LUT4 #(
    .INIT(16'hFB08)) 
    \save_init_bram_addr_ld[10]_i_1__0 
       (.I0(\save_init_bram_addr_ld_reg_n_0_[10] ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I2(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I3(s_axi_araddr[8]),
        .O(RdChnl_BRAM_Addr_Ld[8]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \save_init_bram_addr_ld[11]_i_1__0 
       (.I0(\save_init_bram_addr_ld_reg_n_0_[11] ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I2(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I3(s_axi_araddr[9]),
        .O(RdChnl_BRAM_Addr_Ld[9]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \save_init_bram_addr_ld[12]_i_2__0 
       (.I0(\save_init_bram_addr_ld_reg_n_0_[12] ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I2(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I3(s_axi_araddr[10]),
        .O(\save_init_bram_addr_ld_reg[12]_0 ));
  LUT6 #(
    .INIT(64'h55555555FFFFFDFF)) 
    \save_init_bram_addr_ld[12]_i_3__0 
       (.I0(curr_wrap_burst_reg),
        .I1(\ADDR_SNG_PORT.bram_addr_int_reg[6] ),
        .I2(\wrap_burst_total_reg_n_0_[0] ),
        .I3(\wrap_burst_total_reg_n_0_[2] ),
        .I4(\wrap_burst_total_reg_n_0_[1] ),
        .I5(\ADDR_SNG_PORT.bram_addr_int[2]_i_4_n_0 ),
        .O(\save_init_bram_addr_ld[12]_i_3__0_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF08FF00000800)) 
    \save_init_bram_addr_ld[3]_i_1__0 
       (.I0(\save_init_bram_addr_ld[3]_i_2_n_0 ),
        .I1(\save_init_bram_addr_ld_reg_n_0_[3] ),
        .I2(\save_init_bram_addr_ld[5]_i_2_n_0 ),
        .I3(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I4(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I5(s_axi_araddr[1]),
        .O(RdChnl_BRAM_Addr_Ld[1]));
  LUT2 #(
    .INIT(4'hB)) 
    \save_init_bram_addr_ld[3]_i_2 
       (.I0(\wrap_burst_total_reg_n_0_[2] ),
        .I1(\wrap_burst_total_reg_n_0_[1] ),
        .O(\save_init_bram_addr_ld[3]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \save_init_bram_addr_ld[4]_i_1__0 
       (.I0(\save_init_bram_addr_ld[4]_i_2_n_0 ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I2(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I3(s_axi_araddr[2]),
        .O(RdChnl_BRAM_Addr_Ld[2]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hA82A)) 
    \save_init_bram_addr_ld[4]_i_2 
       (.I0(\save_init_bram_addr_ld_reg_n_0_[4] ),
        .I1(\wrap_burst_total_reg_n_0_[0] ),
        .I2(\wrap_burst_total_reg_n_0_[1] ),
        .I3(\wrap_burst_total_reg_n_0_[2] ),
        .O(\save_init_bram_addr_ld[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFF2F0020)) 
    \save_init_bram_addr_ld[5]_i_1__0 
       (.I0(\save_init_bram_addr_ld_reg_n_0_[5] ),
        .I1(\save_init_bram_addr_ld[5]_i_2_n_0 ),
        .I2(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I3(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I4(s_axi_araddr[3]),
        .O(RdChnl_BRAM_Addr_Ld[3]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \save_init_bram_addr_ld[5]_i_2 
       (.I0(\wrap_burst_total_reg_n_0_[1] ),
        .I1(\wrap_burst_total_reg_n_0_[2] ),
        .I2(\wrap_burst_total_reg_n_0_[0] ),
        .O(\save_init_bram_addr_ld[5]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \save_init_bram_addr_ld[6]_i_1__0 
       (.I0(\save_init_bram_addr_ld_reg_n_0_[6] ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I2(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I3(s_axi_araddr[4]),
        .O(RdChnl_BRAM_Addr_Ld[4]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \save_init_bram_addr_ld[7]_i_1__0 
       (.I0(\save_init_bram_addr_ld_reg_n_0_[7] ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I2(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I3(s_axi_araddr[5]),
        .O(RdChnl_BRAM_Addr_Ld[5]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \save_init_bram_addr_ld[8]_i_1__0 
       (.I0(\save_init_bram_addr_ld_reg_n_0_[8] ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I2(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I3(s_axi_araddr[6]),
        .O(RdChnl_BRAM_Addr_Ld[6]));
  LUT4 #(
    .INIT(16'hFB08)) 
    \save_init_bram_addr_ld[9]_i_1__0 
       (.I0(\save_init_bram_addr_ld_reg_n_0_[9] ),
        .I1(\GEN_NO_RD_CMD_OPT.rd_data_sm_cs_reg[1] ),
        .I2(\save_init_bram_addr_ld[12]_i_3__0_n_0 ),
        .I3(s_axi_araddr[7]),
        .O(RdChnl_BRAM_Addr_Ld[7]));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[10] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(RdChnl_BRAM_Addr_Ld[8]),
        .Q(\save_init_bram_addr_ld_reg_n_0_[10] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[11] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(RdChnl_BRAM_Addr_Ld[9]),
        .Q(\save_init_bram_addr_ld_reg_n_0_[11] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[12] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(\save_init_bram_addr_ld_reg[12]_0 ),
        .Q(\save_init_bram_addr_ld_reg_n_0_[12] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[3] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(RdChnl_BRAM_Addr_Ld[1]),
        .Q(\save_init_bram_addr_ld_reg_n_0_[3] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[4] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(RdChnl_BRAM_Addr_Ld[2]),
        .Q(\save_init_bram_addr_ld_reg_n_0_[4] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[5] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(RdChnl_BRAM_Addr_Ld[3]),
        .Q(\save_init_bram_addr_ld_reg_n_0_[5] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[6] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(RdChnl_BRAM_Addr_Ld[4]),
        .Q(\save_init_bram_addr_ld_reg_n_0_[6] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[7] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(RdChnl_BRAM_Addr_Ld[5]),
        .Q(\save_init_bram_addr_ld_reg_n_0_[7] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[8] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(RdChnl_BRAM_Addr_Ld[6]),
        .Q(\save_init_bram_addr_ld_reg_n_0_[8] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \save_init_bram_addr_ld_reg[9] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(RdChnl_BRAM_Addr_Ld[7]),
        .Q(\save_init_bram_addr_ld_reg_n_0_[9] ),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h4004)) 
    \wrap_burst_total[0]_i_1 
       (.I0(s_axi_arlen[3]),
        .I1(s_axi_arlen[0]),
        .I2(s_axi_arlen[2]),
        .I3(s_axi_arlen[1]),
        .O(\wrap_burst_total[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h20)) 
    \wrap_burst_total[1]_i_1 
       (.I0(s_axi_arlen[1]),
        .I1(s_axi_arlen[3]),
        .I2(s_axi_arlen[0]),
        .O(\wrap_burst_total[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \wrap_burst_total[2]_i_1__0 
       (.I0(s_axi_arlen[2]),
        .I1(s_axi_arlen[1]),
        .I2(s_axi_arlen[3]),
        .I3(s_axi_arlen[0]),
        .O(\wrap_burst_total[2]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \wrap_burst_total_reg[0] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(\wrap_burst_total[0]_i_1_n_0 ),
        .Q(\wrap_burst_total_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \wrap_burst_total_reg[1] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(\wrap_burst_total[1]_i_1_n_0 ),
        .Q(\wrap_burst_total_reg_n_0_[1] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \wrap_burst_total_reg[2] 
       (.C(s_axi_aclk),
        .CE(ar_active_re29_out),
        .D(\wrap_burst_total[2]_i_1__0_n_0 ),
        .Q(\wrap_burst_total_reg_n_0_[2] ),
        .R(SR));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
