// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Sun May 10 22:27:51 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/azc/Belgeler/dolunay/bd/total_design/ip/total_design_host_top_wrapper_0_0/total_design_host_top_wrapper_0_0_sim_netlist.v
// Design      : total_design_host_top_wrapper_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "total_design_host_top_wrapper_0_0,host_top_wrapper,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "host_top_wrapper,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module total_design_host_top_wrapper_0_0
   (clk,
    rst_n,
    m_axi_awaddr,
    m_axi_awprot,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bresp,
    m_axi_bvalid,
    m_axi_bready,
    m_axi_araddr,
    m_axi_arprot,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rvalid,
    m_axi_rready,
    mem_clk,
    mem_addr_o,
    mem_dout_i,
    mem_din_o,
    mem_we_o,
    start_i,
    ready_o,
    simt_start_o,
    simt_ready_i);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF M_AXI, ASSOCIATED_RESET rst_n, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 7, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [6:0]m_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWPROT" *) output [2:0]m_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWVALID" *) output m_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI AWREADY" *) input m_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WDATA" *) output [31:0]m_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WSTRB" *) output [3:0]m_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WVALID" *) output m_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI WREADY" *) input m_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BRESP" *) input [1:0]m_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BVALID" *) input m_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI BREADY" *) output m_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARADDR" *) output [6:0]m_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARPROT" *) output [2:0]m_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARVALID" *) output m_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARREADY" *) input m_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RDATA" *) input [31:0]m_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RRESP" *) input [1:0]m_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RVALID" *) input m_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RREADY" *) output m_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME MEM, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) output mem_clk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM ADDR" *) output [12:0]mem_addr_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM DOUT" *) input [31:0]mem_dout_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM DIN" *) output [31:0]mem_din_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM WE" *) output mem_we_o;
  input start_i;
  output ready_o;
  output simt_start_o;
  input simt_ready_i;

  wire \<const0> ;
  wire \<const1> ;
  wire clk;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire m_axi_awready;
  wire m_axi_awvalid;
  wire m_axi_bready;
  wire m_axi_bvalid;
  wire [31:0]m_axi_rdata;
  wire m_axi_rready;
  wire m_axi_rvalid;
  wire [6:0]\^m_axi_wdata ;
  wire m_axi_wready;
  wire m_axi_wvalid;
  wire [12:0]mem_addr_o;
  wire [7:0]\^mem_din_o ;
  wire [31:0]mem_dout_i;
  wire mem_we_o;
  wire ready_o;
  wire rst_n;
  wire simt_ready_i;
  wire simt_start_o;
  wire start_i;

  assign m_axi_araddr[6] = \<const0> ;
  assign m_axi_araddr[5] = \<const0> ;
  assign m_axi_araddr[4] = \<const0> ;
  assign m_axi_araddr[3] = \<const1> ;
  assign m_axi_araddr[2] = \<const0> ;
  assign m_axi_araddr[1] = \<const0> ;
  assign m_axi_araddr[0] = \<const0> ;
  assign m_axi_arprot[2] = \<const0> ;
  assign m_axi_arprot[1] = \<const0> ;
  assign m_axi_arprot[0] = \<const0> ;
  assign m_axi_awaddr[6] = \<const0> ;
  assign m_axi_awaddr[5] = \<const0> ;
  assign m_axi_awaddr[4] = \<const0> ;
  assign m_axi_awaddr[3] = \<const0> ;
  assign m_axi_awaddr[2] = \<const1> ;
  assign m_axi_awaddr[1] = \<const0> ;
  assign m_axi_awaddr[0] = \<const0> ;
  assign m_axi_awprot[2] = \<const0> ;
  assign m_axi_awprot[1] = \<const0> ;
  assign m_axi_awprot[0] = \<const0> ;
  assign m_axi_wdata[31] = \<const0> ;
  assign m_axi_wdata[30] = \<const0> ;
  assign m_axi_wdata[29] = \<const0> ;
  assign m_axi_wdata[28] = \<const0> ;
  assign m_axi_wdata[27] = \<const0> ;
  assign m_axi_wdata[26] = \<const0> ;
  assign m_axi_wdata[25] = \<const0> ;
  assign m_axi_wdata[24] = \<const0> ;
  assign m_axi_wdata[23] = \<const0> ;
  assign m_axi_wdata[22] = \<const0> ;
  assign m_axi_wdata[21] = \<const0> ;
  assign m_axi_wdata[20] = \<const0> ;
  assign m_axi_wdata[19] = \<const0> ;
  assign m_axi_wdata[18] = \<const0> ;
  assign m_axi_wdata[17] = \<const0> ;
  assign m_axi_wdata[16] = \<const0> ;
  assign m_axi_wdata[15] = \<const0> ;
  assign m_axi_wdata[14] = \<const0> ;
  assign m_axi_wdata[13] = \<const0> ;
  assign m_axi_wdata[12] = \<const0> ;
  assign m_axi_wdata[11] = \<const0> ;
  assign m_axi_wdata[10] = \<const0> ;
  assign m_axi_wdata[9] = \<const0> ;
  assign m_axi_wdata[8] = \<const0> ;
  assign m_axi_wdata[7] = \<const0> ;
  assign m_axi_wdata[6:0] = \^m_axi_wdata [6:0];
  assign m_axi_wstrb[3] = \<const1> ;
  assign m_axi_wstrb[2] = \<const1> ;
  assign m_axi_wstrb[1] = \<const1> ;
  assign m_axi_wstrb[0] = \<const1> ;
  assign mem_clk = clk;
  assign mem_din_o[31] = \^mem_din_o [7];
  assign mem_din_o[30] = \^mem_din_o [7];
  assign mem_din_o[29] = \^mem_din_o [7];
  assign mem_din_o[28] = \^mem_din_o [7];
  assign mem_din_o[27] = \^mem_din_o [7];
  assign mem_din_o[26] = \^mem_din_o [7];
  assign mem_din_o[25] = \^mem_din_o [7];
  assign mem_din_o[24] = \^mem_din_o [7];
  assign mem_din_o[23] = \^mem_din_o [7];
  assign mem_din_o[22] = \^mem_din_o [7];
  assign mem_din_o[21] = \^mem_din_o [7];
  assign mem_din_o[20] = \^mem_din_o [7];
  assign mem_din_o[19] = \^mem_din_o [7];
  assign mem_din_o[18] = \^mem_din_o [7];
  assign mem_din_o[17] = \^mem_din_o [7];
  assign mem_din_o[16] = \^mem_din_o [7];
  assign mem_din_o[15] = \^mem_din_o [7];
  assign mem_din_o[14] = \^mem_din_o [7];
  assign mem_din_o[13] = \^mem_din_o [7];
  assign mem_din_o[12] = \^mem_din_o [7];
  assign mem_din_o[11] = \^mem_din_o [7];
  assign mem_din_o[10] = \^mem_din_o [7];
  assign mem_din_o[9] = \^mem_din_o [7];
  assign mem_din_o[8] = \^mem_din_o [7];
  assign mem_din_o[7:0] = \^mem_din_o [7:0];
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  total_design_host_top_wrapper_0_0_host_top_wrapper inst
       (.\FSM_sequential_state_r_reg[3] (mem_we_o),
        .block_mem_addr_o(mem_addr_o),
        .clk(clk),
        .m_axi_arready(m_axi_arready),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_awready(m_axi_awready),
        .m_axi_awvalid(m_axi_awvalid),
        .m_axi_bready(m_axi_bready),
        .m_axi_bvalid(m_axi_bvalid),
        .m_axi_rdata(m_axi_rdata[3]),
        .m_axi_rready(m_axi_rready),
        .m_axi_rvalid(m_axi_rvalid),
        .m_axi_wdata(\^m_axi_wdata ),
        .m_axi_wready(m_axi_wready),
        .m_axi_wvalid(m_axi_wvalid),
        .mem_din_o(\^mem_din_o ),
        .mem_dout_i(mem_dout_i),
        .ready_o(ready_o),
        .rst_n(rst_n),
        .simt_ready_i(simt_ready_i),
        .simt_start_o(simt_start_o),
        .start_i(start_i));
endmodule

(* ORIG_REF_NAME = "host_top_new" *) 
module total_design_host_top_wrapper_0_0_host_top_new
   (Q,
    m_axi_wdata,
    m_axi_bready,
    m_axi_arvalid,
    m_axi_rready,
    m_axi_wvalid,
    m_axi_awvalid,
    \FSM_sequential_state_r_reg[3]_0 ,
    ready_o,
    mem_din_o,
    simt_start_o,
    rst_n,
    mem_dout_i,
    clk,
    m_axi_arready,
    m_axi_rvalid,
    m_axi_bvalid,
    m_axi_rdata,
    m_axi_wready,
    m_axi_awready,
    start_i,
    simt_ready_i);
  output [12:0]Q;
  output [6:0]m_axi_wdata;
  output m_axi_bready;
  output m_axi_arvalid;
  output m_axi_rready;
  output m_axi_wvalid;
  output m_axi_awvalid;
  output \FSM_sequential_state_r_reg[3]_0 ;
  output ready_o;
  output [7:0]mem_din_o;
  output simt_start_o;
  input rst_n;
  input [31:0]mem_dout_i;
  input clk;
  input m_axi_arready;
  input m_axi_rvalid;
  input m_axi_bvalid;
  input [0:0]m_axi_rdata;
  input m_axi_wready;
  input m_axi_awready;
  input start_i;
  input simt_ready_i;

  wire \FSM_sequential_state_r[2]_i_2_n_0 ;
  wire \FSM_sequential_state_r[2]_i_3_n_0 ;
  wire \FSM_sequential_state_r[2]_i_4_n_0 ;
  wire \FSM_sequential_state_r[3]_i_2_n_0 ;
  wire \FSM_sequential_state_r[3]_i_3_n_0 ;
  wire \FSM_sequential_state_r[3]_i_4_n_0 ;
  wire \FSM_sequential_state_r[4]_i_10_n_0 ;
  wire \FSM_sequential_state_r[4]_i_5_n_0 ;
  wire \FSM_sequential_state_r[4]_i_8_n_0 ;
  wire \FSM_sequential_state_r[4]_i_9_n_0 ;
  wire \FSM_sequential_state_r_reg[3]_0 ;
  wire [12:0]Q;
  wire [0:0]addr_r;
  wire \addr_r[0]_i_1_n_0 ;
  wire \addr_r[10]_i_1_n_0 ;
  wire \addr_r[11]_i_1_n_0 ;
  wire \addr_r[12]_i_10_n_0 ;
  wire \addr_r[12]_i_11_n_0 ;
  wire \addr_r[12]_i_12_n_0 ;
  wire \addr_r[12]_i_13_n_0 ;
  wire \addr_r[12]_i_14_n_0 ;
  wire \addr_r[12]_i_15_n_0 ;
  wire \addr_r[12]_i_16_n_0 ;
  wire \addr_r[12]_i_3_n_0 ;
  wire \addr_r[12]_i_4_n_0 ;
  wire \addr_r[12]_i_6_n_0 ;
  wire \addr_r[12]_i_7_n_0 ;
  wire \addr_r[12]_i_8_n_0 ;
  wire \addr_r[1]_i_1_n_0 ;
  wire \addr_r[2]_i_1_n_0 ;
  wire \addr_r[3]_i_1_n_0 ;
  wire \addr_r[4]_i_1_n_0 ;
  wire \addr_r[5]_i_1_n_0 ;
  wire \addr_r[6]_i_1_n_0 ;
  wire \addr_r[7]_i_1_n_0 ;
  wire \addr_r[8]_i_1_n_0 ;
  wire \addr_r[9]_i_1_n_0 ;
  wire \addr_r_reg[12]_i_9_n_1 ;
  wire \addr_r_reg[12]_i_9_n_2 ;
  wire \addr_r_reg[12]_i_9_n_3 ;
  wire \addr_r_reg[4]_i_2_n_0 ;
  wire \addr_r_reg[4]_i_2_n_1 ;
  wire \addr_r_reg[4]_i_2_n_2 ;
  wire \addr_r_reg[4]_i_2_n_3 ;
  wire \addr_r_reg[8]_i_2_n_0 ;
  wire \addr_r_reg[8]_i_2_n_1 ;
  wire \addr_r_reg[8]_i_2_n_2 ;
  wire \addr_r_reg[8]_i_2_n_3 ;
  wire clk;
  wire \cycle_r[0]_i_1_n_0 ;
  wire \cycle_r[0]_i_4_n_0 ;
  wire [31:0]cycle_r_reg;
  wire \cycle_r_reg[0]_i_3_n_0 ;
  wire \cycle_r_reg[0]_i_3_n_1 ;
  wire \cycle_r_reg[0]_i_3_n_2 ;
  wire \cycle_r_reg[0]_i_3_n_3 ;
  wire \cycle_r_reg[0]_i_3_n_4 ;
  wire \cycle_r_reg[0]_i_3_n_5 ;
  wire \cycle_r_reg[0]_i_3_n_6 ;
  wire \cycle_r_reg[0]_i_3_n_7 ;
  wire \cycle_r_reg[12]_i_1_n_0 ;
  wire \cycle_r_reg[12]_i_1_n_1 ;
  wire \cycle_r_reg[12]_i_1_n_2 ;
  wire \cycle_r_reg[12]_i_1_n_3 ;
  wire \cycle_r_reg[12]_i_1_n_4 ;
  wire \cycle_r_reg[12]_i_1_n_5 ;
  wire \cycle_r_reg[12]_i_1_n_6 ;
  wire \cycle_r_reg[12]_i_1_n_7 ;
  wire \cycle_r_reg[16]_i_1_n_0 ;
  wire \cycle_r_reg[16]_i_1_n_1 ;
  wire \cycle_r_reg[16]_i_1_n_2 ;
  wire \cycle_r_reg[16]_i_1_n_3 ;
  wire \cycle_r_reg[16]_i_1_n_4 ;
  wire \cycle_r_reg[16]_i_1_n_5 ;
  wire \cycle_r_reg[16]_i_1_n_6 ;
  wire \cycle_r_reg[16]_i_1_n_7 ;
  wire \cycle_r_reg[20]_i_1_n_0 ;
  wire \cycle_r_reg[20]_i_1_n_1 ;
  wire \cycle_r_reg[20]_i_1_n_2 ;
  wire \cycle_r_reg[20]_i_1_n_3 ;
  wire \cycle_r_reg[20]_i_1_n_4 ;
  wire \cycle_r_reg[20]_i_1_n_5 ;
  wire \cycle_r_reg[20]_i_1_n_6 ;
  wire \cycle_r_reg[20]_i_1_n_7 ;
  wire \cycle_r_reg[24]_i_1_n_0 ;
  wire \cycle_r_reg[24]_i_1_n_1 ;
  wire \cycle_r_reg[24]_i_1_n_2 ;
  wire \cycle_r_reg[24]_i_1_n_3 ;
  wire \cycle_r_reg[24]_i_1_n_4 ;
  wire \cycle_r_reg[24]_i_1_n_5 ;
  wire \cycle_r_reg[24]_i_1_n_6 ;
  wire \cycle_r_reg[24]_i_1_n_7 ;
  wire \cycle_r_reg[28]_i_1_n_1 ;
  wire \cycle_r_reg[28]_i_1_n_2 ;
  wire \cycle_r_reg[28]_i_1_n_3 ;
  wire \cycle_r_reg[28]_i_1_n_4 ;
  wire \cycle_r_reg[28]_i_1_n_5 ;
  wire \cycle_r_reg[28]_i_1_n_6 ;
  wire \cycle_r_reg[28]_i_1_n_7 ;
  wire \cycle_r_reg[4]_i_1_n_0 ;
  wire \cycle_r_reg[4]_i_1_n_1 ;
  wire \cycle_r_reg[4]_i_1_n_2 ;
  wire \cycle_r_reg[4]_i_1_n_3 ;
  wire \cycle_r_reg[4]_i_1_n_4 ;
  wire \cycle_r_reg[4]_i_1_n_5 ;
  wire \cycle_r_reg[4]_i_1_n_6 ;
  wire \cycle_r_reg[4]_i_1_n_7 ;
  wire \cycle_r_reg[8]_i_1_n_0 ;
  wire \cycle_r_reg[8]_i_1_n_1 ;
  wire \cycle_r_reg[8]_i_1_n_2 ;
  wire \cycle_r_reg[8]_i_1_n_3 ;
  wire \cycle_r_reg[8]_i_1_n_4 ;
  wire \cycle_r_reg[8]_i_1_n_5 ;
  wire \cycle_r_reg[8]_i_1_n_6 ;
  wire \cycle_r_reg[8]_i_1_n_7 ;
  wire [0:0]err_count_r;
  wire \err_count_r[0]_i_1_n_0 ;
  wire \err_count_r[10]_i_1_n_0 ;
  wire \err_count_r[11]_i_1_n_0 ;
  wire \err_count_r[12]_i_1_n_0 ;
  wire \err_count_r[13]_i_1_n_0 ;
  wire \err_count_r[14]_i_1_n_0 ;
  wire \err_count_r[15]_i_1_n_0 ;
  wire \err_count_r[16]_i_1_n_0 ;
  wire \err_count_r[17]_i_1_n_0 ;
  wire \err_count_r[18]_i_1_n_0 ;
  wire \err_count_r[19]_i_1_n_0 ;
  wire \err_count_r[1]_i_1_n_0 ;
  wire \err_count_r[20]_i_1_n_0 ;
  wire \err_count_r[21]_i_1_n_0 ;
  wire \err_count_r[22]_i_1_n_0 ;
  wire \err_count_r[23]_i_1_n_0 ;
  wire \err_count_r[24]_i_1_n_0 ;
  wire \err_count_r[25]_i_1_n_0 ;
  wire \err_count_r[26]_i_1_n_0 ;
  wire \err_count_r[27]_i_1_n_0 ;
  wire \err_count_r[28]_i_1_n_0 ;
  wire \err_count_r[29]_i_1_n_0 ;
  wire \err_count_r[2]_i_1_n_0 ;
  wire \err_count_r[30]_i_1_n_0 ;
  wire \err_count_r[31]_i_11_n_0 ;
  wire \err_count_r[31]_i_12_n_0 ;
  wire \err_count_r[31]_i_13_n_0 ;
  wire \err_count_r[31]_i_14_n_0 ;
  wire \err_count_r[31]_i_15_n_0 ;
  wire \err_count_r[31]_i_16_n_0 ;
  wire \err_count_r[31]_i_17_n_0 ;
  wire \err_count_r[31]_i_18_n_0 ;
  wire \err_count_r[31]_i_2_n_0 ;
  wire \err_count_r[31]_i_4_n_0 ;
  wire \err_count_r[31]_i_7_n_0 ;
  wire \err_count_r[31]_i_8_n_0 ;
  wire \err_count_r[31]_i_9_n_0 ;
  wire \err_count_r[3]_i_1_n_0 ;
  wire \err_count_r[4]_i_1_n_0 ;
  wire \err_count_r[5]_i_1_n_0 ;
  wire \err_count_r[6]_i_1_n_0 ;
  wire \err_count_r[7]_i_1_n_0 ;
  wire \err_count_r[8]_i_1_n_0 ;
  wire \err_count_r[9]_i_1_n_0 ;
  wire \err_count_r_reg[12]_i_2_n_0 ;
  wire \err_count_r_reg[12]_i_2_n_1 ;
  wire \err_count_r_reg[12]_i_2_n_2 ;
  wire \err_count_r_reg[12]_i_2_n_3 ;
  wire \err_count_r_reg[16]_i_2_n_0 ;
  wire \err_count_r_reg[16]_i_2_n_1 ;
  wire \err_count_r_reg[16]_i_2_n_2 ;
  wire \err_count_r_reg[16]_i_2_n_3 ;
  wire \err_count_r_reg[20]_i_2_n_0 ;
  wire \err_count_r_reg[20]_i_2_n_1 ;
  wire \err_count_r_reg[20]_i_2_n_2 ;
  wire \err_count_r_reg[20]_i_2_n_3 ;
  wire \err_count_r_reg[24]_i_2_n_0 ;
  wire \err_count_r_reg[24]_i_2_n_1 ;
  wire \err_count_r_reg[24]_i_2_n_2 ;
  wire \err_count_r_reg[24]_i_2_n_3 ;
  wire \err_count_r_reg[28]_i_2_n_0 ;
  wire \err_count_r_reg[28]_i_2_n_1 ;
  wire \err_count_r_reg[28]_i_2_n_2 ;
  wire \err_count_r_reg[28]_i_2_n_3 ;
  wire \err_count_r_reg[31]_i_10_n_0 ;
  wire \err_count_r_reg[31]_i_10_n_1 ;
  wire \err_count_r_reg[31]_i_10_n_2 ;
  wire \err_count_r_reg[31]_i_10_n_3 ;
  wire \err_count_r_reg[31]_i_3_n_1 ;
  wire \err_count_r_reg[31]_i_3_n_2 ;
  wire \err_count_r_reg[31]_i_3_n_3 ;
  wire \err_count_r_reg[31]_i_5_n_2 ;
  wire \err_count_r_reg[31]_i_5_n_3 ;
  wire \err_count_r_reg[31]_i_6_n_0 ;
  wire \err_count_r_reg[31]_i_6_n_1 ;
  wire \err_count_r_reg[31]_i_6_n_2 ;
  wire \err_count_r_reg[31]_i_6_n_3 ;
  wire \err_count_r_reg[4]_i_2_n_0 ;
  wire \err_count_r_reg[4]_i_2_n_1 ;
  wire \err_count_r_reg[4]_i_2_n_2 ;
  wire \err_count_r_reg[4]_i_2_n_3 ;
  wire \err_count_r_reg[8]_i_2_n_0 ;
  wire \err_count_r_reg[8]_i_2_n_1 ;
  wire \err_count_r_reg[8]_i_2_n_2 ;
  wire \err_count_r_reg[8]_i_2_n_3 ;
  wire \err_count_r_reg_n_0_[0] ;
  wire \err_count_r_reg_n_0_[10] ;
  wire \err_count_r_reg_n_0_[11] ;
  wire \err_count_r_reg_n_0_[12] ;
  wire \err_count_r_reg_n_0_[13] ;
  wire \err_count_r_reg_n_0_[14] ;
  wire \err_count_r_reg_n_0_[15] ;
  wire \err_count_r_reg_n_0_[16] ;
  wire \err_count_r_reg_n_0_[17] ;
  wire \err_count_r_reg_n_0_[18] ;
  wire \err_count_r_reg_n_0_[19] ;
  wire \err_count_r_reg_n_0_[1] ;
  wire \err_count_r_reg_n_0_[20] ;
  wire \err_count_r_reg_n_0_[21] ;
  wire \err_count_r_reg_n_0_[22] ;
  wire \err_count_r_reg_n_0_[23] ;
  wire \err_count_r_reg_n_0_[24] ;
  wire \err_count_r_reg_n_0_[25] ;
  wire \err_count_r_reg_n_0_[26] ;
  wire \err_count_r_reg_n_0_[27] ;
  wire \err_count_r_reg_n_0_[28] ;
  wire \err_count_r_reg_n_0_[29] ;
  wire \err_count_r_reg_n_0_[2] ;
  wire \err_count_r_reg_n_0_[30] ;
  wire \err_count_r_reg_n_0_[31] ;
  wire \err_count_r_reg_n_0_[3] ;
  wire \err_count_r_reg_n_0_[4] ;
  wire \err_count_r_reg_n_0_[5] ;
  wire \err_count_r_reg_n_0_[6] ;
  wire \err_count_r_reg_n_0_[7] ;
  wire \err_count_r_reg_n_0_[8] ;
  wire \err_count_r_reg_n_0_[9] ;
  wire [31:1]in20;
  wire [12:1]in23;
  wire [31:31]in7;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire m_axi_awready;
  wire m_axi_awvalid;
  wire m_axi_bready;
  wire m_axi_bvalid;
  wire [0:0]m_axi_rdata;
  wire m_axi_rready;
  wire m_axi_rvalid;
  wire [6:0]m_axi_wdata;
  wire m_axi_wready;
  wire m_axi_wvalid;
  wire \mem_actual_r[31]_i_1_n_0 ;
  wire [31:0]mem_actual_r__0;
  wire [7:0]mem_din_o;
  wire [31:0]mem_dout_i;
  wire ready_o;
  wire rst_n;
  wire sel;
  wire simt_ready_i;
  wire simt_start_o;
  wire start_i;
  wire [4:0]state_r;
  wire [4:0]state_r__0;
  wire u_prints_n_0;
  wire u_prints_n_1;
  wire u_prints_n_10;
  wire u_prints_n_11;
  wire u_prints_n_13;
  wire u_prints_n_2;
  wire u_prints_n_4;
  wire u_prints_n_5;
  wire u_prints_n_6;
  wire u_prints_n_7;
  wire u_prints_n_9;
  wire wait_counter_fin_w;
  wire [1:1]wait_counter_next_w;
  wire \wait_counter_r[1]_i_2_n_0 ;
  wire \wait_counter_r[1]_i_5_n_0 ;
  wire \wtinstret_r[31]_i_1_n_0 ;
  wire [31:0]wtinstret_r__0;
  wire \wtinstreth_r[31]_i_1_n_0 ;
  wire [31:0]wtinstreth_r__0;
  wire \wuinstret_r[31]_i_1_n_0 ;
  wire [31:0]wuinstret_r__0;
  wire \wuinstreth_r[31]_i_1_n_0 ;
  wire \wuinstreth_r_reg_n_0_[0] ;
  wire \wuinstreth_r_reg_n_0_[10] ;
  wire \wuinstreth_r_reg_n_0_[11] ;
  wire \wuinstreth_r_reg_n_0_[12] ;
  wire \wuinstreth_r_reg_n_0_[13] ;
  wire \wuinstreth_r_reg_n_0_[14] ;
  wire \wuinstreth_r_reg_n_0_[15] ;
  wire \wuinstreth_r_reg_n_0_[16] ;
  wire \wuinstreth_r_reg_n_0_[17] ;
  wire \wuinstreth_r_reg_n_0_[18] ;
  wire \wuinstreth_r_reg_n_0_[19] ;
  wire \wuinstreth_r_reg_n_0_[1] ;
  wire \wuinstreth_r_reg_n_0_[20] ;
  wire \wuinstreth_r_reg_n_0_[21] ;
  wire \wuinstreth_r_reg_n_0_[22] ;
  wire \wuinstreth_r_reg_n_0_[23] ;
  wire \wuinstreth_r_reg_n_0_[24] ;
  wire \wuinstreth_r_reg_n_0_[25] ;
  wire \wuinstreth_r_reg_n_0_[26] ;
  wire \wuinstreth_r_reg_n_0_[27] ;
  wire \wuinstreth_r_reg_n_0_[28] ;
  wire \wuinstreth_r_reg_n_0_[29] ;
  wire \wuinstreth_r_reg_n_0_[2] ;
  wire \wuinstreth_r_reg_n_0_[30] ;
  wire \wuinstreth_r_reg_n_0_[31] ;
  wire \wuinstreth_r_reg_n_0_[3] ;
  wire \wuinstreth_r_reg_n_0_[4] ;
  wire \wuinstreth_r_reg_n_0_[5] ;
  wire \wuinstreth_r_reg_n_0_[6] ;
  wire \wuinstreth_r_reg_n_0_[7] ;
  wire \wuinstreth_r_reg_n_0_[8] ;
  wire \wuinstreth_r_reg_n_0_[9] ;
  wire [3:3]\NLW_addr_r_reg[12]_i_9_CO_UNCONNECTED ;
  wire [3:3]\NLW_cycle_r_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_err_count_r_reg[31]_i_10_O_UNCONNECTED ;
  wire [3:3]\NLW_err_count_r_reg[31]_i_3_CO_UNCONNECTED ;
  wire [3:0]\NLW_err_count_r_reg[31]_i_3_O_UNCONNECTED ;
  wire [3:2]\NLW_err_count_r_reg[31]_i_5_CO_UNCONNECTED ;
  wire [3:3]\NLW_err_count_r_reg[31]_i_5_O_UNCONNECTED ;
  wire [3:0]\NLW_err_count_r_reg[31]_i_6_O_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT4 #(
    .INIT(16'h0F70)) 
    \FSM_sequential_state_r[1]_i_1__0 
       (.I0(state_r[4]),
        .I1(\FSM_sequential_state_r[4]_i_5_n_0 ),
        .I2(state_r[0]),
        .I3(state_r[1]),
        .O(state_r__0[1]));
  LUT6 #(
    .INIT(64'hAAAAAFFAEEAAFAFA)) 
    \FSM_sequential_state_r[2]_i_1 
       (.I0(\FSM_sequential_state_r[2]_i_2_n_0 ),
        .I1(\FSM_sequential_state_r[4]_i_5_n_0 ),
        .I2(state_r[2]),
        .I3(state_r[0]),
        .I4(state_r[4]),
        .I5(state_r[1]),
        .O(state_r__0[2]));
  LUT6 #(
    .INIT(64'h0808080808080008)) 
    \FSM_sequential_state_r[2]_i_2 
       (.I0(\addr_r[12]_i_4_n_0 ),
        .I1(state_r[3]),
        .I2(state_r[4]),
        .I3(\FSM_sequential_state_r[2]_i_3_n_0 ),
        .I4(\FSM_sequential_state_r[4]_i_10_n_0 ),
        .I5(\FSM_sequential_state_r[2]_i_4_n_0 ),
        .O(\FSM_sequential_state_r[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \FSM_sequential_state_r[2]_i_3 
       (.I0(Q[6]),
        .I1(Q[3]),
        .I2(Q[2]),
        .I3(Q[0]),
        .O(\FSM_sequential_state_r[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF7FFFFFFF)) 
    \FSM_sequential_state_r[2]_i_4 
       (.I0(Q[7]),
        .I1(Q[1]),
        .I2(Q[4]),
        .I3(Q[8]),
        .I4(Q[5]),
        .I5(Q[10]),
        .O(\FSM_sequential_state_r[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF8888888)) 
    \FSM_sequential_state_r[3]_i_1 
       (.I0(\FSM_sequential_state_r[3]_i_2_n_0 ),
        .I1(state_r[3]),
        .I2(state_r[0]),
        .I3(u_prints_n_11),
        .I4(\FSM_sequential_state_r[4]_i_5_n_0 ),
        .I5(\FSM_sequential_state_r[3]_i_3_n_0 ),
        .O(state_r__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT4 #(
    .INIT(16'h0070)) 
    \FSM_sequential_state_r[3]_i_2 
       (.I0(state_r[1]),
        .I1(state_r[0]),
        .I2(state_r[2]),
        .I3(state_r[4]),
        .O(\FSM_sequential_state_r[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000000EF00C00000)) 
    \FSM_sequential_state_r[3]_i_3 
       (.I0(\FSM_sequential_state_r[3]_i_4_n_0 ),
        .I1(state_r[1]),
        .I2(state_r[0]),
        .I3(state_r[4]),
        .I4(state_r[2]),
        .I5(state_r[3]),
        .O(\FSM_sequential_state_r[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000040000000)) 
    \FSM_sequential_state_r[3]_i_4 
       (.I0(\FSM_sequential_state_r[4]_i_10_n_0 ),
        .I1(Q[6]),
        .I2(Q[3]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(\FSM_sequential_state_r[2]_i_4_n_0 ),
        .O(\FSM_sequential_state_r[3]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \FSM_sequential_state_r[4]_i_10 
       (.I0(Q[11]),
        .I1(Q[12]),
        .I2(Q[9]),
        .O(\FSM_sequential_state_r[4]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h3333808033FF0000)) 
    \FSM_sequential_state_r[4]_i_2 
       (.I0(state_r[3]),
        .I1(state_r[0]),
        .I2(state_r[2]),
        .I3(\FSM_sequential_state_r[4]_i_5_n_0 ),
        .I4(state_r[4]),
        .I5(state_r[1]),
        .O(state_r__0[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFEF)) 
    \FSM_sequential_state_r[4]_i_5 
       (.I0(Q[3]),
        .I1(Q[7]),
        .I2(Q[10]),
        .I3(\FSM_sequential_state_r[4]_i_8_n_0 ),
        .I4(\FSM_sequential_state_r[4]_i_9_n_0 ),
        .I5(\FSM_sequential_state_r[4]_i_10_n_0 ),
        .O(\FSM_sequential_state_r[4]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_state_r[4]_i_8 
       (.I0(Q[4]),
        .I1(Q[5]),
        .I2(Q[6]),
        .I3(Q[8]),
        .O(\FSM_sequential_state_r[4]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \FSM_sequential_state_r[4]_i_9 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\FSM_sequential_state_r[4]_i_9_n_0 ));
  (* FSM_ENCODED_STATES = "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100" *) 
  FDRE \FSM_sequential_state_r_reg[0] 
       (.C(clk),
        .CE(u_prints_n_4),
        .D(state_r__0[0]),
        .Q(state_r[0]),
        .R(u_prints_n_13));
  (* FSM_ENCODED_STATES = "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100" *) 
  FDRE \FSM_sequential_state_r_reg[1] 
       (.C(clk),
        .CE(u_prints_n_4),
        .D(state_r__0[1]),
        .Q(state_r[1]),
        .R(u_prints_n_13));
  (* FSM_ENCODED_STATES = "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100" *) 
  FDRE \FSM_sequential_state_r_reg[2] 
       (.C(clk),
        .CE(u_prints_n_4),
        .D(state_r__0[2]),
        .Q(state_r[2]),
        .R(u_prints_n_13));
  (* FSM_ENCODED_STATES = "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100" *) 
  FDRE \FSM_sequential_state_r_reg[3] 
       (.C(clk),
        .CE(u_prints_n_4),
        .D(state_r__0[3]),
        .Q(state_r[3]),
        .R(u_prints_n_13));
  (* FSM_ENCODED_STATES = "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100" *) 
  FDRE \FSM_sequential_state_r_reg[4] 
       (.C(clk),
        .CE(u_prints_n_4),
        .D(state_r__0[4]),
        .Q(state_r[4]),
        .R(u_prints_n_13));
  LUT6 #(
    .INIT(64'h0000000044440500)) 
    \addr_r[0]_i_1 
       (.I0(state_r[4]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[0]),
        .I4(state_r[2]),
        .I5(Q[0]),
        .O(\addr_r[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h4444050000000000)) 
    \addr_r[10]_i_1 
       (.I0(state_r[4]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[0]),
        .I4(state_r[2]),
        .I5(in23[10]),
        .O(\addr_r[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h4444050000000000)) 
    \addr_r[11]_i_1 
       (.I0(state_r[4]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[0]),
        .I4(state_r[2]),
        .I5(in23[11]),
        .O(\addr_r[11]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \addr_r[12]_i_10 
       (.I0(\addr_r[12]_i_15_n_0 ),
        .I1(\addr_r[12]_i_16_n_0 ),
        .I2(\FSM_sequential_state_r[2]_i_4_n_0 ),
        .O(\addr_r[12]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000080)) 
    \addr_r[12]_i_11 
       (.I0(simt_ready_i),
        .I1(state_r[2]),
        .I2(state_r[0]),
        .I3(state_r[3]),
        .I4(state_r[1]),
        .I5(state_r[4]),
        .O(\addr_r[12]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \addr_r[12]_i_12 
       (.I0(state_r[3]),
        .I1(state_r[1]),
        .O(\addr_r[12]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \addr_r[12]_i_13 
       (.I0(state_r[2]),
        .I1(state_r[4]),
        .O(\addr_r[12]_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    \addr_r[12]_i_14 
       (.I0(Q[10]),
        .I1(Q[9]),
        .I2(Q[11]),
        .O(\addr_r[12]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'h2A2AFF2AFF2AFF2A)) 
    \addr_r[12]_i_15 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[5]),
        .I4(Q[3]),
        .I5(Q[4]),
        .O(\addr_r[12]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF7F55)) 
    \addr_r[12]_i_16 
       (.I0(Q[2]),
        .I1(Q[7]),
        .I2(Q[6]),
        .I3(Q[8]),
        .I4(Q[11]),
        .I5(Q[12]),
        .O(\addr_r[12]_i_16_n_0 ));
  LUT6 #(
    .INIT(64'h4444050000000000)) 
    \addr_r[12]_i_3 
       (.I0(state_r[4]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[0]),
        .I4(state_r[2]),
        .I5(in23[12]),
        .O(\addr_r[12]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \addr_r[12]_i_4 
       (.I0(state_r[0]),
        .I1(state_r[2]),
        .O(\addr_r[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFF0000EEFE)) 
    \addr_r[12]_i_6 
       (.I0(\addr_r[12]_i_10_n_0 ),
        .I1(Q[11]),
        .I2(Q[9]),
        .I3(Q[10]),
        .I4(state_r[4]),
        .I5(state_r[1]),
        .O(\addr_r[12]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAEAA)) 
    \addr_r[12]_i_7 
       (.I0(\addr_r[12]_i_11_n_0 ),
        .I1(\addr_r[12]_i_12_n_0 ),
        .I2(state_r[4]),
        .I3(start_i),
        .I4(state_r[0]),
        .I5(state_r[2]),
        .O(\addr_r[12]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFF80FFFF80808080)) 
    \addr_r[12]_i_8 
       (.I0(\addr_r[12]_i_13_n_0 ),
        .I1(state_r[3]),
        .I2(wait_counter_fin_w),
        .I3(\addr_r[12]_i_10_n_0 ),
        .I4(\addr_r[12]_i_14_n_0 ),
        .I5(\FSM_sequential_state_r_reg[3]_0 ),
        .O(\addr_r[12]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h4444050000000000)) 
    \addr_r[1]_i_1 
       (.I0(state_r[4]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[0]),
        .I4(state_r[2]),
        .I5(in23[1]),
        .O(\addr_r[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h4444050000000000)) 
    \addr_r[2]_i_1 
       (.I0(state_r[4]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[0]),
        .I4(state_r[2]),
        .I5(in23[2]),
        .O(\addr_r[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h4444050000000000)) 
    \addr_r[3]_i_1 
       (.I0(state_r[4]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[0]),
        .I4(state_r[2]),
        .I5(in23[3]),
        .O(\addr_r[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3333333011301130)) 
    \addr_r[4]_i_1 
       (.I0(state_r[3]),
        .I1(state_r[4]),
        .I2(state_r[1]),
        .I3(state_r[2]),
        .I4(state_r[0]),
        .I5(in23[4]),
        .O(\addr_r[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0088008822FA0088)) 
    \addr_r[5]_i_1 
       (.I0(in23[5]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[4]),
        .I4(state_r[0]),
        .I5(state_r[2]),
        .O(\addr_r[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0088008822FA0088)) 
    \addr_r[6]_i_1 
       (.I0(in23[6]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[4]),
        .I4(state_r[0]),
        .I5(state_r[2]),
        .O(\addr_r[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0088008822FA0088)) 
    \addr_r[7]_i_1 
       (.I0(in23[7]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[4]),
        .I4(state_r[0]),
        .I5(state_r[2]),
        .O(\addr_r[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0088008822FA0088)) 
    \addr_r[8]_i_1 
       (.I0(in23[8]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[4]),
        .I4(state_r[0]),
        .I5(state_r[2]),
        .O(\addr_r[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0088008822FA0088)) 
    \addr_r[9]_i_1 
       (.I0(in23[9]),
        .I1(state_r[3]),
        .I2(state_r[1]),
        .I3(state_r[4]),
        .I4(state_r[0]),
        .I5(state_r[2]),
        .O(\addr_r[9]_i_1_n_0 ));
  FDRE \addr_r_reg[0] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[0]_i_1_n_0 ),
        .Q(Q[0]),
        .R(u_prints_n_13));
  FDRE \addr_r_reg[10] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[10]_i_1_n_0 ),
        .Q(Q[10]),
        .R(u_prints_n_13));
  FDRE \addr_r_reg[11] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[11]_i_1_n_0 ),
        .Q(Q[11]),
        .R(u_prints_n_13));
  FDRE \addr_r_reg[12] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[12]_i_3_n_0 ),
        .Q(Q[12]),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addr_r_reg[12]_i_9 
       (.CI(\addr_r_reg[8]_i_2_n_0 ),
        .CO({\NLW_addr_r_reg[12]_i_9_CO_UNCONNECTED [3],\addr_r_reg[12]_i_9_n_1 ,\addr_r_reg[12]_i_9_n_2 ,\addr_r_reg[12]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in23[12:9]),
        .S(Q[12:9]));
  FDRE \addr_r_reg[1] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[1]_i_1_n_0 ),
        .Q(Q[1]),
        .R(u_prints_n_13));
  FDRE \addr_r_reg[2] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[2]_i_1_n_0 ),
        .Q(Q[2]),
        .R(u_prints_n_13));
  FDRE \addr_r_reg[3] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[3]_i_1_n_0 ),
        .Q(Q[3]),
        .R(u_prints_n_13));
  FDRE \addr_r_reg[4] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[4]_i_1_n_0 ),
        .Q(Q[4]),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addr_r_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\addr_r_reg[4]_i_2_n_0 ,\addr_r_reg[4]_i_2_n_1 ,\addr_r_reg[4]_i_2_n_2 ,\addr_r_reg[4]_i_2_n_3 }),
        .CYINIT(Q[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in23[4:1]),
        .S(Q[4:1]));
  FDRE \addr_r_reg[5] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[5]_i_1_n_0 ),
        .Q(Q[5]),
        .R(u_prints_n_13));
  FDRE \addr_r_reg[6] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[6]_i_1_n_0 ),
        .Q(Q[6]),
        .R(u_prints_n_13));
  FDRE \addr_r_reg[7] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[7]_i_1_n_0 ),
        .Q(Q[7]),
        .R(u_prints_n_13));
  FDRE \addr_r_reg[8] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[8]_i_1_n_0 ),
        .Q(Q[8]),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addr_r_reg[8]_i_2 
       (.CI(\addr_r_reg[4]_i_2_n_0 ),
        .CO({\addr_r_reg[8]_i_2_n_0 ,\addr_r_reg[8]_i_2_n_1 ,\addr_r_reg[8]_i_2_n_2 ,\addr_r_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in23[8:5]),
        .S(Q[8:5]));
  FDRE \addr_r_reg[9] 
       (.C(clk),
        .CE(addr_r),
        .D(\addr_r[9]_i_1_n_0 ),
        .Q(Q[9]),
        .R(u_prints_n_13));
  LUT6 #(
    .INIT(64'h0000000000020000)) 
    \cycle_r[0]_i_1 
       (.I0(simt_ready_i),
        .I1(state_r[2]),
        .I2(state_r[0]),
        .I3(state_r[3]),
        .I4(state_r[1]),
        .I5(state_r[4]),
        .O(\cycle_r[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \cycle_r[0]_i_2 
       (.I0(simt_ready_i),
        .O(sel));
  LUT1 #(
    .INIT(2'h1)) 
    \cycle_r[0]_i_4 
       (.I0(cycle_r_reg[0]),
        .O(\cycle_r[0]_i_4_n_0 ));
  FDRE \cycle_r_reg[0] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[0]_i_3_n_7 ),
        .Q(cycle_r_reg[0]),
        .R(\cycle_r[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cycle_r_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\cycle_r_reg[0]_i_3_n_0 ,\cycle_r_reg[0]_i_3_n_1 ,\cycle_r_reg[0]_i_3_n_2 ,\cycle_r_reg[0]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\cycle_r_reg[0]_i_3_n_4 ,\cycle_r_reg[0]_i_3_n_5 ,\cycle_r_reg[0]_i_3_n_6 ,\cycle_r_reg[0]_i_3_n_7 }),
        .S({cycle_r_reg[3:1],\cycle_r[0]_i_4_n_0 }));
  FDRE \cycle_r_reg[10] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[8]_i_1_n_5 ),
        .Q(cycle_r_reg[10]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[11] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[8]_i_1_n_4 ),
        .Q(cycle_r_reg[11]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[12] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[12]_i_1_n_7 ),
        .Q(cycle_r_reg[12]),
        .R(\cycle_r[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cycle_r_reg[12]_i_1 
       (.CI(\cycle_r_reg[8]_i_1_n_0 ),
        .CO({\cycle_r_reg[12]_i_1_n_0 ,\cycle_r_reg[12]_i_1_n_1 ,\cycle_r_reg[12]_i_1_n_2 ,\cycle_r_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cycle_r_reg[12]_i_1_n_4 ,\cycle_r_reg[12]_i_1_n_5 ,\cycle_r_reg[12]_i_1_n_6 ,\cycle_r_reg[12]_i_1_n_7 }),
        .S(cycle_r_reg[15:12]));
  FDRE \cycle_r_reg[13] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[12]_i_1_n_6 ),
        .Q(cycle_r_reg[13]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[14] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[12]_i_1_n_5 ),
        .Q(cycle_r_reg[14]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[15] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[12]_i_1_n_4 ),
        .Q(cycle_r_reg[15]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[16] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[16]_i_1_n_7 ),
        .Q(cycle_r_reg[16]),
        .R(\cycle_r[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cycle_r_reg[16]_i_1 
       (.CI(\cycle_r_reg[12]_i_1_n_0 ),
        .CO({\cycle_r_reg[16]_i_1_n_0 ,\cycle_r_reg[16]_i_1_n_1 ,\cycle_r_reg[16]_i_1_n_2 ,\cycle_r_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cycle_r_reg[16]_i_1_n_4 ,\cycle_r_reg[16]_i_1_n_5 ,\cycle_r_reg[16]_i_1_n_6 ,\cycle_r_reg[16]_i_1_n_7 }),
        .S(cycle_r_reg[19:16]));
  FDRE \cycle_r_reg[17] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[16]_i_1_n_6 ),
        .Q(cycle_r_reg[17]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[18] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[16]_i_1_n_5 ),
        .Q(cycle_r_reg[18]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[19] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[16]_i_1_n_4 ),
        .Q(cycle_r_reg[19]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[1] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[0]_i_3_n_6 ),
        .Q(cycle_r_reg[1]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[20] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[20]_i_1_n_7 ),
        .Q(cycle_r_reg[20]),
        .R(\cycle_r[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cycle_r_reg[20]_i_1 
       (.CI(\cycle_r_reg[16]_i_1_n_0 ),
        .CO({\cycle_r_reg[20]_i_1_n_0 ,\cycle_r_reg[20]_i_1_n_1 ,\cycle_r_reg[20]_i_1_n_2 ,\cycle_r_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cycle_r_reg[20]_i_1_n_4 ,\cycle_r_reg[20]_i_1_n_5 ,\cycle_r_reg[20]_i_1_n_6 ,\cycle_r_reg[20]_i_1_n_7 }),
        .S(cycle_r_reg[23:20]));
  FDRE \cycle_r_reg[21] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[20]_i_1_n_6 ),
        .Q(cycle_r_reg[21]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[22] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[20]_i_1_n_5 ),
        .Q(cycle_r_reg[22]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[23] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[20]_i_1_n_4 ),
        .Q(cycle_r_reg[23]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[24] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[24]_i_1_n_7 ),
        .Q(cycle_r_reg[24]),
        .R(\cycle_r[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cycle_r_reg[24]_i_1 
       (.CI(\cycle_r_reg[20]_i_1_n_0 ),
        .CO({\cycle_r_reg[24]_i_1_n_0 ,\cycle_r_reg[24]_i_1_n_1 ,\cycle_r_reg[24]_i_1_n_2 ,\cycle_r_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cycle_r_reg[24]_i_1_n_4 ,\cycle_r_reg[24]_i_1_n_5 ,\cycle_r_reg[24]_i_1_n_6 ,\cycle_r_reg[24]_i_1_n_7 }),
        .S(cycle_r_reg[27:24]));
  FDRE \cycle_r_reg[25] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[24]_i_1_n_6 ),
        .Q(cycle_r_reg[25]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[26] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[24]_i_1_n_5 ),
        .Q(cycle_r_reg[26]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[27] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[24]_i_1_n_4 ),
        .Q(cycle_r_reg[27]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[28] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[28]_i_1_n_7 ),
        .Q(cycle_r_reg[28]),
        .R(\cycle_r[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cycle_r_reg[28]_i_1 
       (.CI(\cycle_r_reg[24]_i_1_n_0 ),
        .CO({\NLW_cycle_r_reg[28]_i_1_CO_UNCONNECTED [3],\cycle_r_reg[28]_i_1_n_1 ,\cycle_r_reg[28]_i_1_n_2 ,\cycle_r_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cycle_r_reg[28]_i_1_n_4 ,\cycle_r_reg[28]_i_1_n_5 ,\cycle_r_reg[28]_i_1_n_6 ,\cycle_r_reg[28]_i_1_n_7 }),
        .S(cycle_r_reg[31:28]));
  FDRE \cycle_r_reg[29] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[28]_i_1_n_6 ),
        .Q(cycle_r_reg[29]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[2] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[0]_i_3_n_5 ),
        .Q(cycle_r_reg[2]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[30] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[28]_i_1_n_5 ),
        .Q(cycle_r_reg[30]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[31] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[28]_i_1_n_4 ),
        .Q(cycle_r_reg[31]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[3] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[0]_i_3_n_4 ),
        .Q(cycle_r_reg[3]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[4] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[4]_i_1_n_7 ),
        .Q(cycle_r_reg[4]),
        .R(\cycle_r[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cycle_r_reg[4]_i_1 
       (.CI(\cycle_r_reg[0]_i_3_n_0 ),
        .CO({\cycle_r_reg[4]_i_1_n_0 ,\cycle_r_reg[4]_i_1_n_1 ,\cycle_r_reg[4]_i_1_n_2 ,\cycle_r_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cycle_r_reg[4]_i_1_n_4 ,\cycle_r_reg[4]_i_1_n_5 ,\cycle_r_reg[4]_i_1_n_6 ,\cycle_r_reg[4]_i_1_n_7 }),
        .S(cycle_r_reg[7:4]));
  FDRE \cycle_r_reg[5] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[4]_i_1_n_6 ),
        .Q(cycle_r_reg[5]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[6] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[4]_i_1_n_5 ),
        .Q(cycle_r_reg[6]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[7] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[4]_i_1_n_4 ),
        .Q(cycle_r_reg[7]),
        .R(\cycle_r[0]_i_1_n_0 ));
  FDRE \cycle_r_reg[8] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[8]_i_1_n_7 ),
        .Q(cycle_r_reg[8]),
        .R(\cycle_r[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \cycle_r_reg[8]_i_1 
       (.CI(\cycle_r_reg[4]_i_1_n_0 ),
        .CO({\cycle_r_reg[8]_i_1_n_0 ,\cycle_r_reg[8]_i_1_n_1 ,\cycle_r_reg[8]_i_1_n_2 ,\cycle_r_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cycle_r_reg[8]_i_1_n_4 ,\cycle_r_reg[8]_i_1_n_5 ,\cycle_r_reg[8]_i_1_n_6 ,\cycle_r_reg[8]_i_1_n_7 }),
        .S(cycle_r_reg[11:8]));
  FDRE \cycle_r_reg[9] 
       (.C(clk),
        .CE(sel),
        .D(\cycle_r_reg[8]_i_1_n_6 ),
        .Q(cycle_r_reg[9]),
        .R(\cycle_r[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \err_count_r[0]_i_1 
       (.I0(state_r[1]),
        .I1(\err_count_r_reg_n_0_[0] ),
        .O(\err_count_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[10]_i_1 
       (.I0(state_r[1]),
        .I1(in20[10]),
        .O(\err_count_r[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[11]_i_1 
       (.I0(state_r[1]),
        .I1(in20[11]),
        .O(\err_count_r[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[12]_i_1 
       (.I0(state_r[1]),
        .I1(in20[12]),
        .O(\err_count_r[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[13]_i_1 
       (.I0(state_r[1]),
        .I1(in20[13]),
        .O(\err_count_r[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[14]_i_1 
       (.I0(state_r[1]),
        .I1(in20[14]),
        .O(\err_count_r[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[15]_i_1 
       (.I0(state_r[1]),
        .I1(in20[15]),
        .O(\err_count_r[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[16]_i_1 
       (.I0(state_r[1]),
        .I1(in20[16]),
        .O(\err_count_r[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[17]_i_1 
       (.I0(state_r[1]),
        .I1(in20[17]),
        .O(\err_count_r[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[18]_i_1 
       (.I0(state_r[1]),
        .I1(in20[18]),
        .O(\err_count_r[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[19]_i_1 
       (.I0(state_r[1]),
        .I1(in20[19]),
        .O(\err_count_r[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[1]_i_1 
       (.I0(state_r[1]),
        .I1(in20[1]),
        .O(\err_count_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[20]_i_1 
       (.I0(state_r[1]),
        .I1(in20[20]),
        .O(\err_count_r[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[21]_i_1 
       (.I0(state_r[1]),
        .I1(in20[21]),
        .O(\err_count_r[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[22]_i_1 
       (.I0(state_r[1]),
        .I1(in20[22]),
        .O(\err_count_r[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[23]_i_1 
       (.I0(state_r[1]),
        .I1(in20[23]),
        .O(\err_count_r[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[24]_i_1 
       (.I0(state_r[1]),
        .I1(in20[24]),
        .O(\err_count_r[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[25]_i_1 
       (.I0(state_r[1]),
        .I1(in20[25]),
        .O(\err_count_r[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[26]_i_1 
       (.I0(state_r[1]),
        .I1(in20[26]),
        .O(\err_count_r[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[27]_i_1 
       (.I0(state_r[1]),
        .I1(in20[27]),
        .O(\err_count_r[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[28]_i_1 
       (.I0(state_r[1]),
        .I1(in20[28]),
        .O(\err_count_r[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[29]_i_1 
       (.I0(state_r[1]),
        .I1(in20[29]),
        .O(\err_count_r[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[2]_i_1 
       (.I0(state_r[1]),
        .I1(in20[2]),
        .O(\err_count_r[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[30]_i_1 
       (.I0(state_r[1]),
        .I1(in20[30]),
        .O(\err_count_r[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0023000000200000)) 
    \err_count_r[31]_i_1 
       (.I0(\err_count_r_reg[31]_i_3_n_1 ),
        .I1(state_r[4]),
        .I2(state_r[1]),
        .I3(state_r[3]),
        .I4(\err_count_r[31]_i_4_n_0 ),
        .I5(simt_ready_i),
        .O(err_count_r));
  LUT4 #(
    .INIT(16'h8001)) 
    \err_count_r[31]_i_11 
       (.I0(in7),
        .I1(mem_dout_i[23]),
        .I2(mem_dout_i[22]),
        .I3(mem_dout_i[21]),
        .O(\err_count_r[31]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'h8001)) 
    \err_count_r[31]_i_12 
       (.I0(in7),
        .I1(mem_dout_i[20]),
        .I2(mem_dout_i[19]),
        .I3(mem_dout_i[18]),
        .O(\err_count_r[31]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'h8001)) 
    \err_count_r[31]_i_13 
       (.I0(in7),
        .I1(mem_dout_i[17]),
        .I2(mem_dout_i[16]),
        .I3(mem_dout_i[15]),
        .O(\err_count_r[31]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'h8001)) 
    \err_count_r[31]_i_14 
       (.I0(in7),
        .I1(mem_dout_i[14]),
        .I2(mem_dout_i[13]),
        .I3(mem_dout_i[12]),
        .O(\err_count_r[31]_i_14_n_0 ));
  LUT4 #(
    .INIT(16'h8001)) 
    \err_count_r[31]_i_15 
       (.I0(in7),
        .I1(mem_dout_i[11]),
        .I2(mem_dout_i[10]),
        .I3(mem_dout_i[9]),
        .O(\err_count_r[31]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'h10000001E000000E)) 
    \err_count_r[31]_i_16 
       (.I0(Q[2]),
        .I1(Q[3]),
        .I2(in7),
        .I3(mem_dout_i[7]),
        .I4(mem_dout_i[8]),
        .I5(mem_dout_i[6]),
        .O(\err_count_r[31]_i_16_n_0 ));
  LUT6 #(
    .INIT(64'h0000066006600000)) 
    \err_count_r[31]_i_17 
       (.I0(u_prints_n_10),
        .I1(mem_dout_i[4]),
        .I2(u_prints_n_5),
        .I3(mem_dout_i[3]),
        .I4(mem_dout_i[5]),
        .I5(u_prints_n_9),
        .O(\err_count_r[31]_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h0000128412840000)) 
    \err_count_r[31]_i_18 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(mem_dout_i[1]),
        .I3(mem_dout_i[0]),
        .I4(mem_dout_i[2]),
        .I5(u_prints_n_6),
        .O(\err_count_r[31]_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[31]_i_2 
       (.I0(state_r[1]),
        .I1(in20[31]),
        .O(\err_count_r[31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[31]_i_4 
       (.I0(state_r[2]),
        .I1(state_r[0]),
        .O(\err_count_r[31]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h100E)) 
    \err_count_r[31]_i_7 
       (.I0(Q[3]),
        .I1(Q[2]),
        .I2(mem_dout_i[30]),
        .I3(mem_dout_i[31]),
        .O(\err_count_r[31]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h8001)) 
    \err_count_r[31]_i_8 
       (.I0(in7),
        .I1(mem_dout_i[29]),
        .I2(mem_dout_i[28]),
        .I3(mem_dout_i[27]),
        .O(\err_count_r[31]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'h8001)) 
    \err_count_r[31]_i_9 
       (.I0(in7),
        .I1(mem_dout_i[26]),
        .I2(mem_dout_i[25]),
        .I3(mem_dout_i[24]),
        .O(\err_count_r[31]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[3]_i_1 
       (.I0(state_r[1]),
        .I1(in20[3]),
        .O(\err_count_r[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[4]_i_1 
       (.I0(state_r[1]),
        .I1(in20[4]),
        .O(\err_count_r[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[5]_i_1 
       (.I0(state_r[1]),
        .I1(in20[5]),
        .O(\err_count_r[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[6]_i_1 
       (.I0(state_r[1]),
        .I1(in20[6]),
        .O(\err_count_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[7]_i_1 
       (.I0(state_r[1]),
        .I1(in20[7]),
        .O(\err_count_r[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[8]_i_1 
       (.I0(state_r[1]),
        .I1(in20[8]),
        .O(\err_count_r[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \err_count_r[9]_i_1 
       (.I0(state_r[1]),
        .I1(in20[9]),
        .O(\err_count_r[9]_i_1_n_0 ));
  FDRE \err_count_r_reg[0] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[0]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[0] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[10] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[10]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[10] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[11] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[11]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[11] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[12] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[12]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[12] ),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \err_count_r_reg[12]_i_2 
       (.CI(\err_count_r_reg[8]_i_2_n_0 ),
        .CO({\err_count_r_reg[12]_i_2_n_0 ,\err_count_r_reg[12]_i_2_n_1 ,\err_count_r_reg[12]_i_2_n_2 ,\err_count_r_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in20[12:9]),
        .S({\err_count_r_reg_n_0_[12] ,\err_count_r_reg_n_0_[11] ,\err_count_r_reg_n_0_[10] ,\err_count_r_reg_n_0_[9] }));
  FDRE \err_count_r_reg[13] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[13]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[13] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[14] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[14]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[14] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[15] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[15]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[15] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[16] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[16]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[16] ),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \err_count_r_reg[16]_i_2 
       (.CI(\err_count_r_reg[12]_i_2_n_0 ),
        .CO({\err_count_r_reg[16]_i_2_n_0 ,\err_count_r_reg[16]_i_2_n_1 ,\err_count_r_reg[16]_i_2_n_2 ,\err_count_r_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in20[16:13]),
        .S({\err_count_r_reg_n_0_[16] ,\err_count_r_reg_n_0_[15] ,\err_count_r_reg_n_0_[14] ,\err_count_r_reg_n_0_[13] }));
  FDRE \err_count_r_reg[17] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[17]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[17] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[18] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[18]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[18] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[19] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[19]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[19] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[1] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[1]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[1] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[20] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[20]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[20] ),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \err_count_r_reg[20]_i_2 
       (.CI(\err_count_r_reg[16]_i_2_n_0 ),
        .CO({\err_count_r_reg[20]_i_2_n_0 ,\err_count_r_reg[20]_i_2_n_1 ,\err_count_r_reg[20]_i_2_n_2 ,\err_count_r_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in20[20:17]),
        .S({\err_count_r_reg_n_0_[20] ,\err_count_r_reg_n_0_[19] ,\err_count_r_reg_n_0_[18] ,\err_count_r_reg_n_0_[17] }));
  FDRE \err_count_r_reg[21] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[21]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[21] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[22] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[22]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[22] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[23] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[23]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[23] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[24] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[24]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[24] ),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \err_count_r_reg[24]_i_2 
       (.CI(\err_count_r_reg[20]_i_2_n_0 ),
        .CO({\err_count_r_reg[24]_i_2_n_0 ,\err_count_r_reg[24]_i_2_n_1 ,\err_count_r_reg[24]_i_2_n_2 ,\err_count_r_reg[24]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in20[24:21]),
        .S({\err_count_r_reg_n_0_[24] ,\err_count_r_reg_n_0_[23] ,\err_count_r_reg_n_0_[22] ,\err_count_r_reg_n_0_[21] }));
  FDRE \err_count_r_reg[25] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[25]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[25] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[26] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[26]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[26] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[27] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[27]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[27] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[28] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[28]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[28] ),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \err_count_r_reg[28]_i_2 
       (.CI(\err_count_r_reg[24]_i_2_n_0 ),
        .CO({\err_count_r_reg[28]_i_2_n_0 ,\err_count_r_reg[28]_i_2_n_1 ,\err_count_r_reg[28]_i_2_n_2 ,\err_count_r_reg[28]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in20[28:25]),
        .S({\err_count_r_reg_n_0_[28] ,\err_count_r_reg_n_0_[27] ,\err_count_r_reg_n_0_[26] ,\err_count_r_reg_n_0_[25] }));
  FDRE \err_count_r_reg[29] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[29]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[29] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[2] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[2]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[2] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[30] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[30]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[30] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[31] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[31]_i_2_n_0 ),
        .Q(\err_count_r_reg_n_0_[31] ),
        .R(u_prints_n_13));
  CARRY4 \err_count_r_reg[31]_i_10 
       (.CI(1'b0),
        .CO({\err_count_r_reg[31]_i_10_n_0 ,\err_count_r_reg[31]_i_10_n_1 ,\err_count_r_reg[31]_i_10_n_2 ,\err_count_r_reg[31]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O(\NLW_err_count_r_reg[31]_i_10_O_UNCONNECTED [3:0]),
        .S({\err_count_r[31]_i_15_n_0 ,\err_count_r[31]_i_16_n_0 ,\err_count_r[31]_i_17_n_0 ,\err_count_r[31]_i_18_n_0 }));
  CARRY4 \err_count_r_reg[31]_i_3 
       (.CI(\err_count_r_reg[31]_i_6_n_0 ),
        .CO({\NLW_err_count_r_reg[31]_i_3_CO_UNCONNECTED [3],\err_count_r_reg[31]_i_3_n_1 ,\err_count_r_reg[31]_i_3_n_2 ,\err_count_r_reg[31]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b1,1'b1,1'b1}),
        .O(\NLW_err_count_r_reg[31]_i_3_O_UNCONNECTED [3:0]),
        .S({1'b0,\err_count_r[31]_i_7_n_0 ,\err_count_r[31]_i_8_n_0 ,\err_count_r[31]_i_9_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \err_count_r_reg[31]_i_5 
       (.CI(\err_count_r_reg[28]_i_2_n_0 ),
        .CO({\NLW_err_count_r_reg[31]_i_5_CO_UNCONNECTED [3:2],\err_count_r_reg[31]_i_5_n_2 ,\err_count_r_reg[31]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_err_count_r_reg[31]_i_5_O_UNCONNECTED [3],in20[31:29]}),
        .S({1'b0,\err_count_r_reg_n_0_[31] ,\err_count_r_reg_n_0_[30] ,\err_count_r_reg_n_0_[29] }));
  CARRY4 \err_count_r_reg[31]_i_6 
       (.CI(\err_count_r_reg[31]_i_10_n_0 ),
        .CO({\err_count_r_reg[31]_i_6_n_0 ,\err_count_r_reg[31]_i_6_n_1 ,\err_count_r_reg[31]_i_6_n_2 ,\err_count_r_reg[31]_i_6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O(\NLW_err_count_r_reg[31]_i_6_O_UNCONNECTED [3:0]),
        .S({\err_count_r[31]_i_11_n_0 ,\err_count_r[31]_i_12_n_0 ,\err_count_r[31]_i_13_n_0 ,\err_count_r[31]_i_14_n_0 }));
  FDRE \err_count_r_reg[3] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[3]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[3] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[4] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[4]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[4] ),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \err_count_r_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\err_count_r_reg[4]_i_2_n_0 ,\err_count_r_reg[4]_i_2_n_1 ,\err_count_r_reg[4]_i_2_n_2 ,\err_count_r_reg[4]_i_2_n_3 }),
        .CYINIT(\err_count_r_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in20[4:1]),
        .S({\err_count_r_reg_n_0_[4] ,\err_count_r_reg_n_0_[3] ,\err_count_r_reg_n_0_[2] ,\err_count_r_reg_n_0_[1] }));
  FDRE \err_count_r_reg[5] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[5]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[5] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[6] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[6]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[6] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[7] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[7]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[7] ),
        .R(u_prints_n_13));
  FDRE \err_count_r_reg[8] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[8]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[8] ),
        .R(u_prints_n_13));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \err_count_r_reg[8]_i_2 
       (.CI(\err_count_r_reg[4]_i_2_n_0 ),
        .CO({\err_count_r_reg[8]_i_2_n_0 ,\err_count_r_reg[8]_i_2_n_1 ,\err_count_r_reg[8]_i_2_n_2 ,\err_count_r_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in20[8:5]),
        .S({\err_count_r_reg_n_0_[8] ,\err_count_r_reg_n_0_[7] ,\err_count_r_reg_n_0_[6] ,\err_count_r_reg_n_0_[5] }));
  FDRE \err_count_r_reg[9] 
       (.C(clk),
        .CE(err_count_r),
        .D(\err_count_r[9]_i_1_n_0 ),
        .Q(\err_count_r_reg_n_0_[9] ),
        .R(u_prints_n_13));
  LUT6 #(
    .INIT(64'h0000000000800000)) 
    \mem_actual_r[31]_i_1 
       (.I0(rst_n),
        .I1(state_r[2]),
        .I2(state_r[0]),
        .I3(state_r[3]),
        .I4(state_r[1]),
        .I5(state_r[4]),
        .O(\mem_actual_r[31]_i_1_n_0 ));
  FDRE \mem_actual_r_reg[0] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[0]),
        .Q(mem_actual_r__0[0]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[10] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[10]),
        .Q(mem_actual_r__0[10]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[11] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[11]),
        .Q(mem_actual_r__0[11]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[12] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[12]),
        .Q(mem_actual_r__0[12]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[13] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[13]),
        .Q(mem_actual_r__0[13]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[14] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[14]),
        .Q(mem_actual_r__0[14]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[15] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[15]),
        .Q(mem_actual_r__0[15]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[16] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[16]),
        .Q(mem_actual_r__0[16]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[17] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[17]),
        .Q(mem_actual_r__0[17]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[18] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[18]),
        .Q(mem_actual_r__0[18]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[19] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[19]),
        .Q(mem_actual_r__0[19]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[1] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[1]),
        .Q(mem_actual_r__0[1]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[20] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[20]),
        .Q(mem_actual_r__0[20]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[21] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[21]),
        .Q(mem_actual_r__0[21]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[22] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[22]),
        .Q(mem_actual_r__0[22]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[23] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[23]),
        .Q(mem_actual_r__0[23]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[24] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[24]),
        .Q(mem_actual_r__0[24]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[25] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[25]),
        .Q(mem_actual_r__0[25]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[26] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[26]),
        .Q(mem_actual_r__0[26]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[27] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[27]),
        .Q(mem_actual_r__0[27]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[28] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[28]),
        .Q(mem_actual_r__0[28]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[29] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[29]),
        .Q(mem_actual_r__0[29]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[2] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[2]),
        .Q(mem_actual_r__0[2]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[30] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[30]),
        .Q(mem_actual_r__0[30]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[31] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[31]),
        .Q(mem_actual_r__0[31]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[3] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[3]),
        .Q(mem_actual_r__0[3]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[4] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[4]),
        .Q(mem_actual_r__0[4]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[5] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[5]),
        .Q(mem_actual_r__0[5]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[6] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[6]),
        .Q(mem_actual_r__0[6]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[7] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[7]),
        .Q(mem_actual_r__0[7]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[8] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[8]),
        .Q(mem_actual_r__0[8]),
        .R(1'b0));
  FDRE \mem_actual_r_reg[9] 
       (.C(clk),
        .CE(\mem_actual_r[31]_i_1_n_0 ),
        .D(mem_dout_i[9]),
        .Q(mem_actual_r__0[9]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    \mem_din_o[0]_INST_0 
       (.I0(\FSM_sequential_state_r_reg[3]_0 ),
        .I1(Q[0]),
        .O(mem_din_o[0]));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'h82)) 
    \mem_din_o[1]_INST_0 
       (.I0(\FSM_sequential_state_r_reg[3]_0 ),
        .I1(Q[0]),
        .I2(Q[1]),
        .O(mem_din_o[1]));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT4 #(
    .INIT(16'h08A2)) 
    \mem_din_o[2]_INST_0 
       (.I0(\FSM_sequential_state_r_reg[3]_0 ),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .O(mem_din_o[2]));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT5 #(
    .INIT(32'h802A2882)) 
    \mem_din_o[3]_INST_0 
       (.I0(\FSM_sequential_state_r_reg[3]_0 ),
        .I1(Q[2]),
        .I2(Q[0]),
        .I3(Q[3]),
        .I4(Q[1]),
        .O(mem_din_o[3]));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT5 #(
    .INIT(32'hA8802A28)) 
    \mem_din_o[4]_INST_0 
       (.I0(\FSM_sequential_state_r_reg[3]_0 ),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(Q[0]),
        .I4(Q[2]),
        .O(mem_din_o[4]));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT4 #(
    .INIT(16'h88A2)) 
    \mem_din_o[5]_INST_0 
       (.I0(\FSM_sequential_state_r_reg[3]_0 ),
        .I1(Q[3]),
        .I2(Q[1]),
        .I3(Q[2]),
        .O(mem_din_o[5]));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \mem_din_o[6]_INST_0 
       (.I0(\FSM_sequential_state_r_reg[3]_0 ),
        .I1(Q[3]),
        .I2(Q[2]),
        .O(mem_din_o[6]));
  LUT6 #(
    .INIT(64'h0000000000000400)) 
    \mem_din_o[7]_INST_0 
       (.I0(state_r[3]),
        .I1(state_r[0]),
        .I2(state_r[2]),
        .I3(in7),
        .I4(state_r[1]),
        .I5(state_r[4]),
        .O(mem_din_o[7]));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT5 #(
    .INIT(32'h00010000)) 
    mem_we_o_INST_0
       (.I0(state_r[3]),
        .I1(state_r[1]),
        .I2(state_r[4]),
        .I3(state_r[2]),
        .I4(state_r[0]),
        .O(\FSM_sequential_state_r_reg[3]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    ready_o_INST_0
       (.I0(state_r[0]),
        .I1(state_r[2]),
        .I2(state_r[3]),
        .I3(state_r[1]),
        .I4(state_r[4]),
        .O(ready_o));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT5 #(
    .INIT(32'h00000100)) 
    simt_start_o_INST_0
       (.I0(state_r[0]),
        .I1(state_r[2]),
        .I2(state_r[3]),
        .I3(state_r[1]),
        .I4(state_r[4]),
        .O(simt_start_o));
  total_design_host_top_wrapper_0_0_prints u_prints
       (.E(addr_r),
        .\FSM_sequential_state_r_reg[0]_0 (\addr_r[12]_i_10_n_0 ),
        .\FSM_sequential_state_r_reg[0]_1 (\addr_r[12]_i_14_n_0 ),
        .\FSM_sequential_state_r_reg[0]_2 (\addr_r[12]_i_13_n_0 ),
        .\FSM_sequential_state_r_reg[1]_0 (u_prints_n_0),
        .\FSM_sequential_state_r_reg[1]_1 (u_prints_n_7),
        .\FSM_sequential_state_r_reg[4] (u_prints_n_4),
        .Q(state_r),
        .SR(u_prints_n_13),
        .\addr_r_reg[0] (\addr_r[12]_i_6_n_0 ),
        .\addr_r_reg[0]_0 (\addr_r[12]_i_4_n_0 ),
        .\addr_r_reg[0]_1 (\addr_r[12]_i_7_n_0 ),
        .\addr_r_reg[0]_2 (\addr_r[12]_i_8_n_0 ),
        .\addr_r_reg[1] (u_prints_n_5),
        .\addr_r_reg[2] (u_prints_n_6),
        .\addr_r_reg[2]_0 (u_prints_n_9),
        .\addr_r_reg[2]_1 (u_prints_n_10),
        .clk(clk),
        .cycle_r_reg(cycle_r_reg),
        .\hex_r_reg[1][12]_0 (Q),
        .\hex_r_reg[1][31]_0 ({\err_count_r_reg_n_0_[31] ,\err_count_r_reg_n_0_[30] ,\err_count_r_reg_n_0_[29] ,\err_count_r_reg_n_0_[28] ,\err_count_r_reg_n_0_[27] ,\err_count_r_reg_n_0_[26] ,\err_count_r_reg_n_0_[25] ,\err_count_r_reg_n_0_[24] ,\err_count_r_reg_n_0_[23] ,\err_count_r_reg_n_0_[22] ,\err_count_r_reg_n_0_[21] ,\err_count_r_reg_n_0_[20] ,\err_count_r_reg_n_0_[19] ,\err_count_r_reg_n_0_[18] ,\err_count_r_reg_n_0_[17] ,\err_count_r_reg_n_0_[16] ,\err_count_r_reg_n_0_[15] ,\err_count_r_reg_n_0_[14] ,\err_count_r_reg_n_0_[13] ,\err_count_r_reg_n_0_[12] ,\err_count_r_reg_n_0_[11] ,\err_count_r_reg_n_0_[10] ,\err_count_r_reg_n_0_[9] ,\err_count_r_reg_n_0_[8] ,\err_count_r_reg_n_0_[7] ,\err_count_r_reg_n_0_[6] ,\err_count_r_reg_n_0_[5] ,\err_count_r_reg_n_0_[4] ,\err_count_r_reg_n_0_[3] ,\err_count_r_reg_n_0_[2] ,\err_count_r_reg_n_0_[1] ,\err_count_r_reg_n_0_[0] }),
        .\hex_r_reg[1][31]_1 (wtinstret_r__0),
        .\hex_r_reg[2][31]_0 (wtinstreth_r__0),
        .\hex_r_reg[3][31]_0 (wuinstret_r__0),
        .\hex_r_reg[3][31]_1 (mem_actual_r__0),
        .\hex_r_reg[4][31]_0 ({\wuinstreth_r_reg_n_0_[31] ,\wuinstreth_r_reg_n_0_[30] ,\wuinstreth_r_reg_n_0_[29] ,\wuinstreth_r_reg_n_0_[28] ,\wuinstreth_r_reg_n_0_[27] ,\wuinstreth_r_reg_n_0_[26] ,\wuinstreth_r_reg_n_0_[25] ,\wuinstreth_r_reg_n_0_[24] ,\wuinstreth_r_reg_n_0_[23] ,\wuinstreth_r_reg_n_0_[22] ,\wuinstreth_r_reg_n_0_[21] ,\wuinstreth_r_reg_n_0_[20] ,\wuinstreth_r_reg_n_0_[19] ,\wuinstreth_r_reg_n_0_[18] ,\wuinstreth_r_reg_n_0_[17] ,\wuinstreth_r_reg_n_0_[16] ,\wuinstreth_r_reg_n_0_[15] ,\wuinstreth_r_reg_n_0_[14] ,\wuinstreth_r_reg_n_0_[13] ,\wuinstreth_r_reg_n_0_[12] ,\wuinstreth_r_reg_n_0_[11] ,\wuinstreth_r_reg_n_0_[10] ,\wuinstreth_r_reg_n_0_[9] ,\wuinstreth_r_reg_n_0_[8] ,\wuinstreth_r_reg_n_0_[7] ,\wuinstreth_r_reg_n_0_[6] ,\wuinstreth_r_reg_n_0_[5] ,\wuinstreth_r_reg_n_0_[4] ,\wuinstreth_r_reg_n_0_[3] ,\wuinstreth_r_reg_n_0_[2] ,\wuinstreth_r_reg_n_0_[1] ,\wuinstreth_r_reg_n_0_[0] }),
        .in7(in7),
        .m_axi_arready(m_axi_arready),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_awready(m_axi_awready),
        .m_axi_awvalid(m_axi_awvalid),
        .m_axi_bready(m_axi_bready),
        .m_axi_bvalid(m_axi_bvalid),
        .m_axi_rdata(m_axi_rdata),
        .m_axi_rready(m_axi_rready),
        .m_axi_rvalid(m_axi_rvalid),
        .m_axi_wdata(m_axi_wdata),
        .m_axi_wready(m_axi_wready),
        .m_axi_wvalid(m_axi_wvalid),
        .rst_n(rst_n),
        .simt_ready_i(simt_ready_i),
        .start_i(start_i),
        .string_i({u_prints_n_11,state_r__0[0]}),
        .wait_counter_fin_w(wait_counter_fin_w),
        .wait_counter_next_w(wait_counter_next_w),
        .\wait_counter_r[1]_i_3_0 (\FSM_sequential_state_r[4]_i_5_n_0 ),
        .\wait_counter_r_reg[0] (u_prints_n_1),
        .\wait_counter_r_reg[0]_0 (u_prints_n_2),
        .\wait_counter_r_reg[0]_1 (\wait_counter_r[1]_i_2_n_0 ),
        .\wait_counter_r_reg[1] (\wait_counter_r[1]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT5 #(
    .INIT(32'h04040C00)) 
    \wait_counter_r[1]_i_2 
       (.I0(wait_counter_fin_w),
        .I1(state_r[2]),
        .I2(state_r[4]),
        .I3(state_r[1]),
        .I4(state_r[3]),
        .O(\wait_counter_r[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h008C00C8008C0088)) 
    \wait_counter_r[1]_i_5 
       (.I0(state_r[3]),
        .I1(state_r[2]),
        .I2(state_r[0]),
        .I3(state_r[4]),
        .I4(state_r[1]),
        .I5(simt_ready_i),
        .O(\wait_counter_r[1]_i_5_n_0 ));
  FDRE \wait_counter_r_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(u_prints_n_1),
        .Q(wait_counter_next_w),
        .R(u_prints_n_13));
  FDRE \wait_counter_r_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(u_prints_n_2),
        .Q(wait_counter_fin_w),
        .R(u_prints_n_13));
  LUT6 #(
    .INIT(64'h0800000000000000)) 
    \wtinstret_r[31]_i_1 
       (.I0(u_prints_n_0),
        .I1(state_r[2]),
        .I2(state_r[0]),
        .I3(rst_n),
        .I4(state_r[3]),
        .I5(wait_counter_fin_w),
        .O(\wtinstret_r[31]_i_1_n_0 ));
  FDRE \wtinstret_r_reg[0] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[0]),
        .Q(wtinstret_r__0[0]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[10] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[10]),
        .Q(wtinstret_r__0[10]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[11] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[11]),
        .Q(wtinstret_r__0[11]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[12] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[12]),
        .Q(wtinstret_r__0[12]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[13] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[13]),
        .Q(wtinstret_r__0[13]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[14] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[14]),
        .Q(wtinstret_r__0[14]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[15] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[15]),
        .Q(wtinstret_r__0[15]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[16] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[16]),
        .Q(wtinstret_r__0[16]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[17] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[17]),
        .Q(wtinstret_r__0[17]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[18] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[18]),
        .Q(wtinstret_r__0[18]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[19] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[19]),
        .Q(wtinstret_r__0[19]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[1] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[1]),
        .Q(wtinstret_r__0[1]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[20] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[20]),
        .Q(wtinstret_r__0[20]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[21] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[21]),
        .Q(wtinstret_r__0[21]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[22] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[22]),
        .Q(wtinstret_r__0[22]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[23] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[23]),
        .Q(wtinstret_r__0[23]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[24] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[24]),
        .Q(wtinstret_r__0[24]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[25] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[25]),
        .Q(wtinstret_r__0[25]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[26] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[26]),
        .Q(wtinstret_r__0[26]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[27] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[27]),
        .Q(wtinstret_r__0[27]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[28] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[28]),
        .Q(wtinstret_r__0[28]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[29] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[29]),
        .Q(wtinstret_r__0[29]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[2] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[2]),
        .Q(wtinstret_r__0[2]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[30] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[30]),
        .Q(wtinstret_r__0[30]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[31] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[31]),
        .Q(wtinstret_r__0[31]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[3] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[3]),
        .Q(wtinstret_r__0[3]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[4] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[4]),
        .Q(wtinstret_r__0[4]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[5] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[5]),
        .Q(wtinstret_r__0[5]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[6] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[6]),
        .Q(wtinstret_r__0[6]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[7] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[7]),
        .Q(wtinstret_r__0[7]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[8] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[8]),
        .Q(wtinstret_r__0[8]),
        .R(1'b0));
  FDRE \wtinstret_r_reg[9] 
       (.C(clk),
        .CE(\wtinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[9]),
        .Q(wtinstret_r__0[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \wtinstreth_r[31]_i_1 
       (.I0(u_prints_n_0),
        .I1(state_r[2]),
        .I2(state_r[0]),
        .I3(rst_n),
        .I4(state_r[3]),
        .I5(wait_counter_fin_w),
        .O(\wtinstreth_r[31]_i_1_n_0 ));
  FDRE \wtinstreth_r_reg[0] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[0]),
        .Q(wtinstreth_r__0[0]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[10] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[10]),
        .Q(wtinstreth_r__0[10]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[11] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[11]),
        .Q(wtinstreth_r__0[11]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[12] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[12]),
        .Q(wtinstreth_r__0[12]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[13] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[13]),
        .Q(wtinstreth_r__0[13]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[14] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[14]),
        .Q(wtinstreth_r__0[14]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[15] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[15]),
        .Q(wtinstreth_r__0[15]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[16] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[16]),
        .Q(wtinstreth_r__0[16]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[17] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[17]),
        .Q(wtinstreth_r__0[17]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[18] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[18]),
        .Q(wtinstreth_r__0[18]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[19] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[19]),
        .Q(wtinstreth_r__0[19]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[1] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[1]),
        .Q(wtinstreth_r__0[1]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[20] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[20]),
        .Q(wtinstreth_r__0[20]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[21] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[21]),
        .Q(wtinstreth_r__0[21]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[22] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[22]),
        .Q(wtinstreth_r__0[22]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[23] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[23]),
        .Q(wtinstreth_r__0[23]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[24] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[24]),
        .Q(wtinstreth_r__0[24]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[25] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[25]),
        .Q(wtinstreth_r__0[25]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[26] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[26]),
        .Q(wtinstreth_r__0[26]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[27] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[27]),
        .Q(wtinstreth_r__0[27]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[28] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[28]),
        .Q(wtinstreth_r__0[28]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[29] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[29]),
        .Q(wtinstreth_r__0[29]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[2] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[2]),
        .Q(wtinstreth_r__0[2]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[30] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[30]),
        .Q(wtinstreth_r__0[30]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[31] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[31]),
        .Q(wtinstreth_r__0[31]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[3] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[3]),
        .Q(wtinstreth_r__0[3]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[4] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[4]),
        .Q(wtinstreth_r__0[4]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[5] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[5]),
        .Q(wtinstreth_r__0[5]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[6] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[6]),
        .Q(wtinstreth_r__0[6]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[7] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[7]),
        .Q(wtinstreth_r__0[7]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[8] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[8]),
        .Q(wtinstreth_r__0[8]),
        .R(1'b0));
  FDRE \wtinstreth_r_reg[9] 
       (.C(clk),
        .CE(\wtinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[9]),
        .Q(wtinstreth_r__0[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0800000000000000)) 
    \wuinstret_r[31]_i_1 
       (.I0(u_prints_n_7),
        .I1(state_r[2]),
        .I2(state_r[0]),
        .I3(rst_n),
        .I4(state_r[3]),
        .I5(wait_counter_fin_w),
        .O(\wuinstret_r[31]_i_1_n_0 ));
  FDRE \wuinstret_r_reg[0] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[0]),
        .Q(wuinstret_r__0[0]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[10] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[10]),
        .Q(wuinstret_r__0[10]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[11] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[11]),
        .Q(wuinstret_r__0[11]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[12] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[12]),
        .Q(wuinstret_r__0[12]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[13] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[13]),
        .Q(wuinstret_r__0[13]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[14] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[14]),
        .Q(wuinstret_r__0[14]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[15] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[15]),
        .Q(wuinstret_r__0[15]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[16] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[16]),
        .Q(wuinstret_r__0[16]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[17] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[17]),
        .Q(wuinstret_r__0[17]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[18] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[18]),
        .Q(wuinstret_r__0[18]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[19] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[19]),
        .Q(wuinstret_r__0[19]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[1] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[1]),
        .Q(wuinstret_r__0[1]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[20] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[20]),
        .Q(wuinstret_r__0[20]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[21] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[21]),
        .Q(wuinstret_r__0[21]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[22] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[22]),
        .Q(wuinstret_r__0[22]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[23] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[23]),
        .Q(wuinstret_r__0[23]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[24] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[24]),
        .Q(wuinstret_r__0[24]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[25] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[25]),
        .Q(wuinstret_r__0[25]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[26] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[26]),
        .Q(wuinstret_r__0[26]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[27] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[27]),
        .Q(wuinstret_r__0[27]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[28] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[28]),
        .Q(wuinstret_r__0[28]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[29] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[29]),
        .Q(wuinstret_r__0[29]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[2] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[2]),
        .Q(wuinstret_r__0[2]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[30] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[30]),
        .Q(wuinstret_r__0[30]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[31] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[31]),
        .Q(wuinstret_r__0[31]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[3] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[3]),
        .Q(wuinstret_r__0[3]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[4] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[4]),
        .Q(wuinstret_r__0[4]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[5] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[5]),
        .Q(wuinstret_r__0[5]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[6] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[6]),
        .Q(wuinstret_r__0[6]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[7] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[7]),
        .Q(wuinstret_r__0[7]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[8] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[8]),
        .Q(wuinstret_r__0[8]),
        .R(1'b0));
  FDRE \wuinstret_r_reg[9] 
       (.C(clk),
        .CE(\wuinstret_r[31]_i_1_n_0 ),
        .D(mem_dout_i[9]),
        .Q(wuinstret_r__0[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \wuinstreth_r[31]_i_1 
       (.I0(u_prints_n_7),
        .I1(state_r[2]),
        .I2(state_r[0]),
        .I3(rst_n),
        .I4(state_r[3]),
        .I5(wait_counter_fin_w),
        .O(\wuinstreth_r[31]_i_1_n_0 ));
  FDRE \wuinstreth_r_reg[0] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[0]),
        .Q(\wuinstreth_r_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[10] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[10]),
        .Q(\wuinstreth_r_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[11] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[11]),
        .Q(\wuinstreth_r_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[12] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[12]),
        .Q(\wuinstreth_r_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[13] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[13]),
        .Q(\wuinstreth_r_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[14] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[14]),
        .Q(\wuinstreth_r_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[15] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[15]),
        .Q(\wuinstreth_r_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[16] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[16]),
        .Q(\wuinstreth_r_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[17] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[17]),
        .Q(\wuinstreth_r_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[18] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[18]),
        .Q(\wuinstreth_r_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[19] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[19]),
        .Q(\wuinstreth_r_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[1] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[1]),
        .Q(\wuinstreth_r_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[20] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[20]),
        .Q(\wuinstreth_r_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[21] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[21]),
        .Q(\wuinstreth_r_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[22] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[22]),
        .Q(\wuinstreth_r_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[23] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[23]),
        .Q(\wuinstreth_r_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[24] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[24]),
        .Q(\wuinstreth_r_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[25] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[25]),
        .Q(\wuinstreth_r_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[26] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[26]),
        .Q(\wuinstreth_r_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[27] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[27]),
        .Q(\wuinstreth_r_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[28] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[28]),
        .Q(\wuinstreth_r_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[29] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[29]),
        .Q(\wuinstreth_r_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[2] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[2]),
        .Q(\wuinstreth_r_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[30] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[30]),
        .Q(\wuinstreth_r_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[31] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[31]),
        .Q(\wuinstreth_r_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[3] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[3]),
        .Q(\wuinstreth_r_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[4] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[4]),
        .Q(\wuinstreth_r_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[5] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[5]),
        .Q(\wuinstreth_r_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[6] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[6]),
        .Q(\wuinstreth_r_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[7] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[7]),
        .Q(\wuinstreth_r_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[8] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[8]),
        .Q(\wuinstreth_r_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \wuinstreth_r_reg[9] 
       (.C(clk),
        .CE(\wuinstreth_r[31]_i_1_n_0 ),
        .D(mem_dout_i[9]),
        .Q(\wuinstreth_r_reg_n_0_[9] ),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "host_top_wrapper" *) 
module total_design_host_top_wrapper_0_0_host_top_wrapper
   (block_mem_addr_o,
    m_axi_wdata,
    m_axi_bready,
    m_axi_arvalid,
    m_axi_rready,
    m_axi_wvalid,
    m_axi_awvalid,
    \FSM_sequential_state_r_reg[3] ,
    ready_o,
    mem_din_o,
    simt_start_o,
    rst_n,
    mem_dout_i,
    clk,
    m_axi_arready,
    m_axi_rvalid,
    m_axi_bvalid,
    m_axi_rdata,
    m_axi_wready,
    m_axi_awready,
    start_i,
    simt_ready_i);
  output [12:0]block_mem_addr_o;
  output [6:0]m_axi_wdata;
  output m_axi_bready;
  output m_axi_arvalid;
  output m_axi_rready;
  output m_axi_wvalid;
  output m_axi_awvalid;
  output \FSM_sequential_state_r_reg[3] ;
  output ready_o;
  output [7:0]mem_din_o;
  output simt_start_o;
  input rst_n;
  input [31:0]mem_dout_i;
  input clk;
  input m_axi_arready;
  input m_axi_rvalid;
  input m_axi_bvalid;
  input [0:0]m_axi_rdata;
  input m_axi_wready;
  input m_axi_awready;
  input start_i;
  input simt_ready_i;

  wire \FSM_sequential_state_r_reg[3] ;
  wire [12:0]block_mem_addr_o;
  wire clk;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire m_axi_awready;
  wire m_axi_awvalid;
  wire m_axi_bready;
  wire m_axi_bvalid;
  wire [0:0]m_axi_rdata;
  wire m_axi_rready;
  wire m_axi_rvalid;
  wire [6:0]m_axi_wdata;
  wire m_axi_wready;
  wire m_axi_wvalid;
  wire [7:0]mem_din_o;
  wire [31:0]mem_dout_i;
  wire ready_o;
  wire rst_n;
  wire simt_ready_i;
  wire simt_start_o;
  wire start_i;

  total_design_host_top_wrapper_0_0_host_top_new u_host_top
       (.\FSM_sequential_state_r_reg[3]_0 (\FSM_sequential_state_r_reg[3] ),
        .Q(block_mem_addr_o),
        .clk(clk),
        .m_axi_arready(m_axi_arready),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_awready(m_axi_awready),
        .m_axi_awvalid(m_axi_awvalid),
        .m_axi_bready(m_axi_bready),
        .m_axi_bvalid(m_axi_bvalid),
        .m_axi_rdata(m_axi_rdata),
        .m_axi_rready(m_axi_rready),
        .m_axi_rvalid(m_axi_rvalid),
        .m_axi_wdata(m_axi_wdata),
        .m_axi_wready(m_axi_wready),
        .m_axi_wvalid(m_axi_wvalid),
        .mem_din_o(mem_din_o),
        .mem_dout_i(mem_dout_i),
        .ready_o(ready_o),
        .rst_n(rst_n),
        .simt_ready_i(simt_ready_i),
        .simt_start_o(simt_start_o),
        .start_i(start_i));
endmodule

(* ORIG_REF_NAME = "printc" *) 
module total_design_host_top_wrapper_0_0_printc
   (m_axi_awvalid,
    m_axi_wvalid,
    m_axi_bready,
    m_axi_arvalid,
    m_axi_rready,
    \FSM_sequential_state_r_reg[0] ,
    \FSM_sequential_state_r_reg[1] ,
    \FSM_sequential_state_r_reg[1]_0 ,
    rst_n_0,
    rst_n_1,
    \FSM_sequential_state_r_reg[1]_1 ,
    \hex_digit_idx_r_reg[0] ,
    \FSM_sequential_state_r_reg[0]_0 ,
    E,
    rst_n_2,
    SS,
    m_axi_wdata,
    clk,
    state_r,
    \FSM_sequential_state_r_reg[1]_2 ,
    \FSM_sequential_state_r_reg[0]_1 ,
    \char_idx_r_reg[0] ,
    rst_n,
    char_idx_r,
    \char_idx_r_reg[4] ,
    \char_idx_r_reg[3] ,
    \hex_digit_idx_r_reg[2] ,
    \hex_digit_idx_r_reg[2]_0 ,
    \hex_digit_idx_r_reg[2]_1 ,
    \hex_digit_idx_r_reg[1] ,
    \hex_digit_idx_r_reg[1]_0 ,
    \hex_digit_idx_r_reg[1]_1 ,
    m_axi_arready,
    m_axi_rvalid,
    m_axi_bvalid,
    \FSM_sequential_state_r_reg[0]_2 ,
    m_axi_rdata,
    m_axi_wready,
    m_axi_awready,
    Q);
  output m_axi_awvalid;
  output m_axi_wvalid;
  output m_axi_bready;
  output m_axi_arvalid;
  output m_axi_rready;
  output \FSM_sequential_state_r_reg[0] ;
  output \FSM_sequential_state_r_reg[1] ;
  output \FSM_sequential_state_r_reg[1]_0 ;
  output rst_n_0;
  output rst_n_1;
  output \FSM_sequential_state_r_reg[1]_1 ;
  output \hex_digit_idx_r_reg[0] ;
  output \FSM_sequential_state_r_reg[0]_0 ;
  output [0:0]E;
  output rst_n_2;
  output [0:0]SS;
  output [6:0]m_axi_wdata;
  input clk;
  input [1:0]state_r;
  input \FSM_sequential_state_r_reg[1]_2 ;
  input \FSM_sequential_state_r_reg[0]_1 ;
  input \char_idx_r_reg[0] ;
  input rst_n;
  input [1:0]char_idx_r;
  input \char_idx_r_reg[4] ;
  input \char_idx_r_reg[3] ;
  input \hex_digit_idx_r_reg[2] ;
  input \hex_digit_idx_r_reg[2]_0 ;
  input \hex_digit_idx_r_reg[2]_1 ;
  input \hex_digit_idx_r_reg[1] ;
  input \hex_digit_idx_r_reg[1]_0 ;
  input \hex_digit_idx_r_reg[1]_1 ;
  input m_axi_arready;
  input m_axi_rvalid;
  input m_axi_bvalid;
  input \FSM_sequential_state_r_reg[0]_2 ;
  input [0:0]m_axi_rdata;
  input m_axi_wready;
  input m_axi_awready;
  input [6:0]Q;

  wire [0:0]E;
  wire \FSM_onehot_state_r[1]_i_1_n_0 ;
  wire \FSM_onehot_state_r[3]_i_1_n_0 ;
  wire \FSM_onehot_state_r[5]_i_1_n_0 ;
  wire \FSM_onehot_state_r[5]_i_2_n_0 ;
  wire \FSM_onehot_state_r_reg_n_0_[0] ;
  wire \FSM_onehot_state_r_reg_n_0_[1] ;
  wire \FSM_onehot_state_r_reg_n_0_[2] ;
  wire \FSM_onehot_state_r_reg_n_0_[3] ;
  wire \FSM_onehot_state_r_reg_n_0_[4] ;
  wire \FSM_onehot_state_r_reg_n_0_[5] ;
  wire \FSM_sequential_state_r[1]_i_3_n_0 ;
  wire \FSM_sequential_state_r_reg[0] ;
  wire \FSM_sequential_state_r_reg[0]_0 ;
  wire \FSM_sequential_state_r_reg[0]_1 ;
  wire \FSM_sequential_state_r_reg[0]_2 ;
  wire \FSM_sequential_state_r_reg[1] ;
  wire \FSM_sequential_state_r_reg[1]_0 ;
  wire \FSM_sequential_state_r_reg[1]_1 ;
  wire \FSM_sequential_state_r_reg[1]_2 ;
  wire [6:0]Q;
  wire [0:0]SS;
  wire awready_recv_r_i_1_n_0;
  wire awready_recv_r_reg_n_0;
  wire c_ready_w;
  wire [1:0]char_idx_r;
  wire \char_idx_r[5]_i_4_n_0 ;
  wire \char_idx_r_reg[0] ;
  wire \char_idx_r_reg[3] ;
  wire \char_idx_r_reg[4] ;
  wire [6:0]char_r;
  wire \char_r[6]_i_1_n_0 ;
  wire clk;
  wire \hex_digit_idx_r[2]_i_4_n_0 ;
  wire \hex_digit_idx_r_reg[0] ;
  wire \hex_digit_idx_r_reg[1] ;
  wire \hex_digit_idx_r_reg[1]_0 ;
  wire \hex_digit_idx_r_reg[1]_1 ;
  wire \hex_digit_idx_r_reg[2] ;
  wire \hex_digit_idx_r_reg[2]_0 ;
  wire \hex_digit_idx_r_reg[2]_1 ;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire m_axi_arvalid_o_i_1_n_0;
  wire m_axi_awready;
  wire m_axi_awvalid;
  wire m_axi_awvalid_o_i_1_n_0;
  wire m_axi_bready;
  wire m_axi_bready_o_i_1_n_0;
  wire m_axi_bready_o_i_2_n_0;
  wire m_axi_bvalid;
  wire [0:0]m_axi_rdata;
  wire m_axi_rready;
  wire m_axi_rready_o_i_1_n_0;
  wire m_axi_rvalid;
  wire [6:0]m_axi_wdata;
  wire \m_axi_wdata_o[6]_i_1_n_0 ;
  wire m_axi_wready;
  wire m_axi_wvalid;
  wire m_axi_wvalid_o_i_1_n_0;
  wire ready_o_i_1_n_0;
  wire rst_n;
  wire rst_n_0;
  wire rst_n_1;
  wire rst_n_2;
  wire [1:0]state_r;
  wire wready_recv_r_i_1_n_0;
  wire wready_recv_r_reg_n_0;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    \FSM_onehot_state_r[1]_i_1 
       (.I0(m_axi_rdata),
        .I1(\FSM_onehot_state_r_reg_n_0_[2] ),
        .I2(\FSM_onehot_state_r_reg_n_0_[0] ),
        .O(\FSM_onehot_state_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_onehot_state_r[3]_i_1 
       (.I0(\FSM_onehot_state_r_reg_n_0_[2] ),
        .I1(m_axi_rdata),
        .O(\FSM_onehot_state_r[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF40)) 
    \FSM_onehot_state_r[5]_i_1 
       (.I0(m_axi_arready),
        .I1(m_axi_rvalid),
        .I2(\FSM_onehot_state_r_reg_n_0_[2] ),
        .I3(\FSM_onehot_state_r_reg_n_0_[3] ),
        .I4(\FSM_onehot_state_r_reg_n_0_[1] ),
        .I5(\FSM_onehot_state_r[5]_i_2_n_0 ),
        .O(\FSM_onehot_state_r[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8F8F8F8F8F8F8)) 
    \FSM_onehot_state_r[5]_i_2 
       (.I0(state_r[1]),
        .I1(\FSM_onehot_state_r_reg_n_0_[0] ),
        .I2(m_axi_bready_o_i_2_n_0),
        .I3(wready_recv_r_reg_n_0),
        .I4(awready_recv_r_reg_n_0),
        .I5(\FSM_onehot_state_r_reg_n_0_[4] ),
        .O(\FSM_onehot_state_r[5]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_r_reg[0] 
       (.C(clk),
        .CE(\FSM_onehot_state_r[5]_i_1_n_0 ),
        .D(\FSM_onehot_state_r_reg_n_0_[5] ),
        .Q(\FSM_onehot_state_r_reg_n_0_[0] ),
        .S(SS));
  (* FSM_ENCODED_STATES = "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[1] 
       (.C(clk),
        .CE(\FSM_onehot_state_r[5]_i_1_n_0 ),
        .D(\FSM_onehot_state_r[1]_i_1_n_0 ),
        .Q(\FSM_onehot_state_r_reg_n_0_[1] ),
        .R(SS));
  (* FSM_ENCODED_STATES = "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[2] 
       (.C(clk),
        .CE(\FSM_onehot_state_r[5]_i_1_n_0 ),
        .D(\FSM_onehot_state_r_reg_n_0_[1] ),
        .Q(\FSM_onehot_state_r_reg_n_0_[2] ),
        .R(SS));
  (* FSM_ENCODED_STATES = "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[3] 
       (.C(clk),
        .CE(\FSM_onehot_state_r[5]_i_1_n_0 ),
        .D(\FSM_onehot_state_r[3]_i_1_n_0 ),
        .Q(\FSM_onehot_state_r_reg_n_0_[3] ),
        .R(SS));
  (* FSM_ENCODED_STATES = "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[4] 
       (.C(clk),
        .CE(\FSM_onehot_state_r[5]_i_1_n_0 ),
        .D(\FSM_onehot_state_r_reg_n_0_[3] ),
        .Q(\FSM_onehot_state_r_reg_n_0_[4] ),
        .R(SS));
  (* FSM_ENCODED_STATES = "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[5] 
       (.C(clk),
        .CE(\FSM_onehot_state_r[5]_i_1_n_0 ),
        .D(\FSM_onehot_state_r_reg_n_0_[4] ),
        .Q(\FSM_onehot_state_r_reg_n_0_[5] ),
        .R(SS));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hF4FFFF00)) 
    \FSM_sequential_state_r[0]_i_1 
       (.I0(\FSM_sequential_state_r_reg[0]_1 ),
        .I1(\FSM_sequential_state_r_reg[1]_2 ),
        .I2(state_r[1]),
        .I3(\FSM_sequential_state_r[1]_i_3_n_0 ),
        .I4(state_r[0]),
        .O(\FSM_sequential_state_r_reg[1] ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h5F80)) 
    \FSM_sequential_state_r[1]_i_1 
       (.I0(state_r[0]),
        .I1(\FSM_sequential_state_r_reg[1]_2 ),
        .I2(\FSM_sequential_state_r[1]_i_3_n_0 ),
        .I3(state_r[1]),
        .O(\FSM_sequential_state_r_reg[0] ));
  LUT6 #(
    .INIT(64'hFFAAFFFFABAAAAAA)) 
    \FSM_sequential_state_r[1]_i_3 
       (.I0(\FSM_sequential_state_r_reg[0]_2 ),
        .I1(\hex_digit_idx_r_reg[2] ),
        .I2(\hex_digit_idx_r_reg[2]_1 ),
        .I3(c_ready_w),
        .I4(state_r[1]),
        .I5(state_r[0]),
        .O(\FSM_sequential_state_r[1]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \addr_r[12]_i_1 
       (.I0(rst_n),
        .O(SS));
  LUT5 #(
    .INIT(32'h8FFF8800)) 
    awready_recv_r_i_1
       (.I0(m_axi_awready),
        .I1(\FSM_onehot_state_r_reg_n_0_[4] ),
        .I2(\FSM_onehot_state_r_reg_n_0_[3] ),
        .I3(rst_n),
        .I4(awready_recv_r_reg_n_0),
        .O(awready_recv_r_i_1_n_0));
  FDRE awready_recv_r_reg
       (.C(clk),
        .CE(1'b1),
        .D(awready_recv_r_i_1_n_0),
        .Q(awready_recv_r_reg_n_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hBBBBFFBF88880080)) 
    \char_idx_r[3]_i_1 
       (.I0(char_idx_r[0]),
        .I1(rst_n),
        .I2(\FSM_sequential_state_r_reg[1]_2 ),
        .I3(\char_idx_r_reg[0] ),
        .I4(\char_idx_r[5]_i_4_n_0 ),
        .I5(\char_idx_r_reg[3] ),
        .O(rst_n_1));
  LUT6 #(
    .INIT(64'hBBBBFFBF88880080)) 
    \char_idx_r[4]_i_1 
       (.I0(char_idx_r[1]),
        .I1(rst_n),
        .I2(\FSM_sequential_state_r_reg[1]_2 ),
        .I3(\char_idx_r_reg[0] ),
        .I4(\char_idx_r[5]_i_4_n_0 ),
        .I5(\char_idx_r_reg[4] ),
        .O(rst_n_0));
  LUT6 #(
    .INIT(64'h1011101000000000)) 
    \char_idx_r[5]_i_1 
       (.I0(state_r[1]),
        .I1(state_r[0]),
        .I2(\char_idx_r[5]_i_4_n_0 ),
        .I3(\char_idx_r_reg[0] ),
        .I4(\FSM_sequential_state_r_reg[1]_2 ),
        .I5(rst_n),
        .O(\FSM_sequential_state_r_reg[1]_0 ));
  LUT4 #(
    .INIT(16'hAA08)) 
    \char_idx_r[5]_i_2 
       (.I0(rst_n),
        .I1(\FSM_sequential_state_r_reg[1]_2 ),
        .I2(\char_idx_r_reg[0] ),
        .I3(\char_idx_r[5]_i_4_n_0 ),
        .O(rst_n_2));
  LUT6 #(
    .INIT(64'h000000000100FFFF)) 
    \char_idx_r[5]_i_4 
       (.I0(\hex_digit_idx_r_reg[1]_1 ),
        .I1(\hex_digit_idx_r_reg[1] ),
        .I2(\hex_digit_idx_r_reg[2]_1 ),
        .I3(c_ready_w),
        .I4(state_r[1]),
        .I5(state_r[0]),
        .O(\char_idx_r[5]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \char_r[6]_i_1 
       (.I0(rst_n),
        .I1(\FSM_onehot_state_r_reg_n_0_[0] ),
        .I2(state_r[1]),
        .O(\char_r[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00A0C000)) 
    \char_r[6]_i_1__0 
       (.I0(c_ready_w),
        .I1(\FSM_sequential_state_r_reg[1]_2 ),
        .I2(rst_n),
        .I3(state_r[0]),
        .I4(state_r[1]),
        .O(E));
  FDRE \char_r_reg[0] 
       (.C(clk),
        .CE(\char_r[6]_i_1_n_0 ),
        .D(Q[0]),
        .Q(char_r[0]),
        .R(1'b0));
  FDRE \char_r_reg[1] 
       (.C(clk),
        .CE(\char_r[6]_i_1_n_0 ),
        .D(Q[1]),
        .Q(char_r[1]),
        .R(1'b0));
  FDRE \char_r_reg[2] 
       (.C(clk),
        .CE(\char_r[6]_i_1_n_0 ),
        .D(Q[2]),
        .Q(char_r[2]),
        .R(1'b0));
  FDRE \char_r_reg[3] 
       (.C(clk),
        .CE(\char_r[6]_i_1_n_0 ),
        .D(Q[3]),
        .Q(char_r[3]),
        .R(1'b0));
  FDRE \char_r_reg[4] 
       (.C(clk),
        .CE(\char_r[6]_i_1_n_0 ),
        .D(Q[4]),
        .Q(char_r[4]),
        .R(1'b0));
  FDRE \char_r_reg[5] 
       (.C(clk),
        .CE(\char_r[6]_i_1_n_0 ),
        .D(Q[5]),
        .Q(char_r[5]),
        .R(1'b0));
  FDRE \char_r_reg[6] 
       (.C(clk),
        .CE(\char_r[6]_i_1_n_0 ),
        .D(Q[6]),
        .Q(char_r[6]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h44444FFF55555000)) 
    \hex_digit_idx_r[0]_i_1 
       (.I0(state_r[0]),
        .I1(\hex_digit_idx_r_reg[1]_0 ),
        .I2(\FSM_sequential_state_r_reg[0]_1 ),
        .I3(\hex_digit_idx_r_reg[2]_0 ),
        .I4(\hex_digit_idx_r[2]_i_4_n_0 ),
        .I5(\hex_digit_idx_r_reg[1] ),
        .O(\FSM_sequential_state_r_reg[0]_0 ));
  LUT6 #(
    .INIT(64'hEEEEEFFFDDDDD000)) 
    \hex_digit_idx_r[1]_i_1 
       (.I0(\hex_digit_idx_r_reg[1] ),
        .I1(\hex_digit_idx_r_reg[1]_0 ),
        .I2(\FSM_sequential_state_r_reg[0]_1 ),
        .I3(\hex_digit_idx_r_reg[2]_0 ),
        .I4(\hex_digit_idx_r[2]_i_4_n_0 ),
        .I5(\hex_digit_idx_r_reg[1]_1 ),
        .O(\hex_digit_idx_r_reg[0] ));
  LUT6 #(
    .INIT(64'hDDDDDFFF77777000)) 
    \hex_digit_idx_r[2]_i_1 
       (.I0(state_r[1]),
        .I1(\hex_digit_idx_r_reg[2] ),
        .I2(\FSM_sequential_state_r_reg[0]_1 ),
        .I3(\hex_digit_idx_r_reg[2]_0 ),
        .I4(\hex_digit_idx_r[2]_i_4_n_0 ),
        .I5(\hex_digit_idx_r_reg[2]_1 ),
        .O(\FSM_sequential_state_r_reg[1]_1 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h4404)) 
    \hex_digit_idx_r[2]_i_4 
       (.I0(state_r[0]),
        .I1(rst_n),
        .I2(state_r[1]),
        .I3(c_ready_w),
        .O(\hex_digit_idx_r[2]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hF7FFF000)) 
    m_axi_arvalid_o_i_1
       (.I0(\FSM_onehot_state_r_reg_n_0_[2] ),
        .I1(m_axi_arready),
        .I2(\FSM_onehot_state_r_reg_n_0_[1] ),
        .I3(rst_n),
        .I4(m_axi_arvalid),
        .O(m_axi_arvalid_o_i_1_n_0));
  FDRE m_axi_arvalid_o_reg
       (.C(clk),
        .CE(1'b1),
        .D(m_axi_arvalid_o_i_1_n_0),
        .Q(m_axi_arvalid),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hF7FFF000)) 
    m_axi_awvalid_o_i_1
       (.I0(m_axi_awready),
        .I1(\FSM_onehot_state_r_reg_n_0_[4] ),
        .I2(\FSM_onehot_state_r_reg_n_0_[3] ),
        .I3(rst_n),
        .I4(m_axi_awvalid),
        .O(m_axi_awvalid_o_i_1_n_0));
  FDRE m_axi_awvalid_o_reg
       (.C(clk),
        .CE(1'b1),
        .D(m_axi_awvalid_o_i_1_n_0),
        .Q(m_axi_awvalid),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hD555FFFFC0000000)) 
    m_axi_bready_o_i_1
       (.I0(m_axi_bready_o_i_2_n_0),
        .I1(wready_recv_r_reg_n_0),
        .I2(awready_recv_r_reg_n_0),
        .I3(\FSM_onehot_state_r_reg_n_0_[4] ),
        .I4(rst_n),
        .I5(m_axi_bready),
        .O(m_axi_bready_o_i_1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    m_axi_bready_o_i_2
       (.I0(\FSM_onehot_state_r_reg_n_0_[5] ),
        .I1(m_axi_bvalid),
        .O(m_axi_bready_o_i_2_n_0));
  FDRE m_axi_bready_o_reg
       (.C(clk),
        .CE(1'b1),
        .D(m_axi_bready_o_i_1_n_0),
        .Q(m_axi_bready),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hF7FF8080)) 
    m_axi_rready_o_i_1
       (.I0(rst_n),
        .I1(\FSM_onehot_state_r_reg_n_0_[2] ),
        .I2(m_axi_arready),
        .I3(m_axi_rvalid),
        .I4(m_axi_rready),
        .O(m_axi_rready_o_i_1_n_0));
  FDRE m_axi_rready_o_reg
       (.C(clk),
        .CE(1'b1),
        .D(m_axi_rready_o_i_1_n_0),
        .Q(m_axi_rready),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    \m_axi_wdata_o[6]_i_1 
       (.I0(rst_n),
        .I1(\FSM_onehot_state_r_reg_n_0_[3] ),
        .O(\m_axi_wdata_o[6]_i_1_n_0 ));
  FDRE \m_axi_wdata_o_reg[0] 
       (.C(clk),
        .CE(\m_axi_wdata_o[6]_i_1_n_0 ),
        .D(char_r[0]),
        .Q(m_axi_wdata[0]),
        .R(1'b0));
  FDRE \m_axi_wdata_o_reg[1] 
       (.C(clk),
        .CE(\m_axi_wdata_o[6]_i_1_n_0 ),
        .D(char_r[1]),
        .Q(m_axi_wdata[1]),
        .R(1'b0));
  FDRE \m_axi_wdata_o_reg[2] 
       (.C(clk),
        .CE(\m_axi_wdata_o[6]_i_1_n_0 ),
        .D(char_r[2]),
        .Q(m_axi_wdata[2]),
        .R(1'b0));
  FDRE \m_axi_wdata_o_reg[3] 
       (.C(clk),
        .CE(\m_axi_wdata_o[6]_i_1_n_0 ),
        .D(char_r[3]),
        .Q(m_axi_wdata[3]),
        .R(1'b0));
  FDRE \m_axi_wdata_o_reg[4] 
       (.C(clk),
        .CE(\m_axi_wdata_o[6]_i_1_n_0 ),
        .D(char_r[4]),
        .Q(m_axi_wdata[4]),
        .R(1'b0));
  FDRE \m_axi_wdata_o_reg[5] 
       (.C(clk),
        .CE(\m_axi_wdata_o[6]_i_1_n_0 ),
        .D(char_r[5]),
        .Q(m_axi_wdata[5]),
        .R(1'b0));
  FDRE \m_axi_wdata_o_reg[6] 
       (.C(clk),
        .CE(\m_axi_wdata_o[6]_i_1_n_0 ),
        .D(char_r[6]),
        .Q(m_axi_wdata[6]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hF7FFF000)) 
    m_axi_wvalid_o_i_1
       (.I0(m_axi_wready),
        .I1(\FSM_onehot_state_r_reg_n_0_[4] ),
        .I2(\FSM_onehot_state_r_reg_n_0_[3] ),
        .I3(rst_n),
        .I4(m_axi_wvalid),
        .O(m_axi_wvalid_o_i_1_n_0));
  FDRE m_axi_wvalid_o_reg
       (.C(clk),
        .CE(1'b1),
        .D(m_axi_wvalid_o_i_1_n_0),
        .Q(m_axi_wvalid),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hC0EAFFEAFFFFFFFF)) 
    ready_o_i_1
       (.I0(c_ready_w),
        .I1(\FSM_onehot_state_r_reg_n_0_[5] ),
        .I2(m_axi_bvalid),
        .I3(\FSM_onehot_state_r_reg_n_0_[0] ),
        .I4(state_r[1]),
        .I5(rst_n),
        .O(ready_o_i_1_n_0));
  FDRE ready_o_reg
       (.C(clk),
        .CE(1'b1),
        .D(ready_o_i_1_n_0),
        .Q(c_ready_w),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h8FFF8800)) 
    wready_recv_r_i_1
       (.I0(m_axi_wready),
        .I1(\FSM_onehot_state_r_reg_n_0_[4] ),
        .I2(\FSM_onehot_state_r_reg_n_0_[3] ),
        .I3(rst_n),
        .I4(wready_recv_r_reg_n_0),
        .O(wready_recv_r_i_1_n_0));
  FDRE wready_recv_r_reg
       (.C(clk),
        .CE(1'b1),
        .D(wready_recv_r_i_1_n_0),
        .Q(wready_recv_r_reg_n_0),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "prints" *) 
module total_design_host_top_wrapper_0_0_prints
   (\FSM_sequential_state_r_reg[1]_0 ,
    \wait_counter_r_reg[0] ,
    \wait_counter_r_reg[0]_0 ,
    E,
    \FSM_sequential_state_r_reg[4] ,
    \addr_r_reg[1] ,
    \addr_r_reg[2] ,
    \FSM_sequential_state_r_reg[1]_1 ,
    in7,
    \addr_r_reg[2]_0 ,
    \addr_r_reg[2]_1 ,
    string_i,
    SR,
    m_axi_wdata,
    m_axi_bready,
    m_axi_arvalid,
    m_axi_rready,
    m_axi_wvalid,
    m_axi_awvalid,
    Q,
    rst_n,
    \hex_r_reg[1][12]_0 ,
    \hex_r_reg[1][31]_0 ,
    \hex_r_reg[2][31]_0 ,
    \wait_counter_r_reg[0]_1 ,
    wait_counter_next_w,
    wait_counter_fin_w,
    \addr_r_reg[0] ,
    \wait_counter_r_reg[1] ,
    \addr_r_reg[0]_0 ,
    \wait_counter_r[1]_i_3_0 ,
    \addr_r_reg[0]_1 ,
    \addr_r_reg[0]_2 ,
    \FSM_sequential_state_r_reg[0]_0 ,
    \FSM_sequential_state_r_reg[0]_1 ,
    start_i,
    simt_ready_i,
    \FSM_sequential_state_r_reg[0]_2 ,
    \hex_r_reg[1][31]_1 ,
    cycle_r_reg,
    \hex_r_reg[3][31]_0 ,
    \hex_r_reg[3][31]_1 ,
    clk,
    \hex_r_reg[4][31]_0 ,
    m_axi_arready,
    m_axi_rvalid,
    m_axi_bvalid,
    m_axi_rdata,
    m_axi_wready,
    m_axi_awready);
  output \FSM_sequential_state_r_reg[1]_0 ;
  output \wait_counter_r_reg[0] ;
  output \wait_counter_r_reg[0]_0 ;
  output [0:0]E;
  output [0:0]\FSM_sequential_state_r_reg[4] ;
  output \addr_r_reg[1] ;
  output \addr_r_reg[2] ;
  output \FSM_sequential_state_r_reg[1]_1 ;
  output [0:0]in7;
  output \addr_r_reg[2]_0 ;
  output \addr_r_reg[2]_1 ;
  output [1:0]string_i;
  output [0:0]SR;
  output [6:0]m_axi_wdata;
  output m_axi_bready;
  output m_axi_arvalid;
  output m_axi_rready;
  output m_axi_wvalid;
  output m_axi_awvalid;
  input [4:0]Q;
  input rst_n;
  input [12:0]\hex_r_reg[1][12]_0 ;
  input [31:0]\hex_r_reg[1][31]_0 ;
  input [31:0]\hex_r_reg[2][31]_0 ;
  input \wait_counter_r_reg[0]_1 ;
  input [0:0]wait_counter_next_w;
  input wait_counter_fin_w;
  input \addr_r_reg[0] ;
  input \wait_counter_r_reg[1] ;
  input \addr_r_reg[0]_0 ;
  input \wait_counter_r[1]_i_3_0 ;
  input \addr_r_reg[0]_1 ;
  input \addr_r_reg[0]_2 ;
  input \FSM_sequential_state_r_reg[0]_0 ;
  input \FSM_sequential_state_r_reg[0]_1 ;
  input start_i;
  input simt_ready_i;
  input \FSM_sequential_state_r_reg[0]_2 ;
  input [31:0]\hex_r_reg[1][31]_1 ;
  input [31:0]cycle_r_reg;
  input [31:0]\hex_r_reg[3][31]_0 ;
  input [31:0]\hex_r_reg[3][31]_1 ;
  input clk;
  input [31:0]\hex_r_reg[4][31]_0 ;
  input m_axi_arready;
  input m_axi_rvalid;
  input m_axi_bvalid;
  input [0:0]m_axi_rdata;
  input m_axi_wready;
  input m_axi_awready;

  wire [0:0]E;
  wire \FSM_sequential_state_r[0]_i_2_n_0 ;
  wire \FSM_sequential_state_r[0]_i_3_n_0 ;
  wire \FSM_sequential_state_r[1]_i_2_n_0 ;
  wire \FSM_sequential_state_r[1]_i_4_n_0 ;
  wire \FSM_sequential_state_r[1]_i_5_n_0 ;
  wire \FSM_sequential_state_r[4]_i_3_n_0 ;
  wire \FSM_sequential_state_r[4]_i_4_n_0 ;
  wire \FSM_sequential_state_r[4]_i_6_n_0 ;
  wire \FSM_sequential_state_r[4]_i_7_n_0 ;
  wire \FSM_sequential_state_r_reg[0]_0 ;
  wire \FSM_sequential_state_r_reg[0]_1 ;
  wire \FSM_sequential_state_r_reg[0]_2 ;
  wire \FSM_sequential_state_r_reg[1]_0 ;
  wire \FSM_sequential_state_r_reg[1]_1 ;
  wire [0:0]\FSM_sequential_state_r_reg[4] ;
  wire [4:0]Q;
  wire [0:0]SR;
  wire \addr_r_reg[0] ;
  wire \addr_r_reg[0]_0 ;
  wire \addr_r_reg[0]_1 ;
  wire \addr_r_reg[0]_2 ;
  wire \addr_r_reg[1] ;
  wire \addr_r_reg[2] ;
  wire \addr_r_reg[2]_0 ;
  wire \addr_r_reg[2]_1 ;
  wire [4:3]char_idx_r;
  wire \char_idx_r[0]_i_1_n_0 ;
  wire \char_idx_r[1]_i_1_n_0 ;
  wire \char_idx_r[2]_i_1_n_0 ;
  wire \char_idx_r[4]_i_3_n_0 ;
  wire \char_idx_r[5]_i_3_n_0 ;
  wire \char_idx_r[5]_i_5_n_0 ;
  wire \char_idx_r_reg_n_0_[0] ;
  wire \char_idx_r_reg_n_0_[1] ;
  wire \char_idx_r_reg_n_0_[2] ;
  wire \char_idx_r_reg_n_0_[3] ;
  wire \char_idx_r_reg_n_0_[4] ;
  wire \char_idx_r_reg_n_0_[5] ;
  wire [6:0]char_r0_in;
  wire \char_r[0]_i_10_n_0 ;
  wire \char_r[0]_i_11_n_0 ;
  wire \char_r[0]_i_12_n_0 ;
  wire \char_r[0]_i_13_n_0 ;
  wire \char_r[0]_i_14_n_0 ;
  wire \char_r[0]_i_2_n_0 ;
  wire \char_r[0]_i_3_n_0 ;
  wire \char_r[0]_i_4_n_0 ;
  wire \char_r[0]_i_5_n_0 ;
  wire \char_r[0]_i_6_n_0 ;
  wire \char_r[0]_i_7_n_0 ;
  wire \char_r[0]_i_8_n_0 ;
  wire \char_r[0]_i_9_n_0 ;
  wire \char_r[1]_i_10_n_0 ;
  wire \char_r[1]_i_11_n_0 ;
  wire \char_r[1]_i_12_n_0 ;
  wire \char_r[1]_i_13_n_0 ;
  wire \char_r[1]_i_14_n_0 ;
  wire \char_r[1]_i_2_n_0 ;
  wire \char_r[1]_i_3_n_0 ;
  wire \char_r[1]_i_4_n_0 ;
  wire \char_r[1]_i_5_n_0 ;
  wire \char_r[1]_i_6_n_0 ;
  wire \char_r[1]_i_7_n_0 ;
  wire \char_r[1]_i_8_n_0 ;
  wire \char_r[1]_i_9_n_0 ;
  wire \char_r[2]_i_10_n_0 ;
  wire \char_r[2]_i_11_n_0 ;
  wire \char_r[2]_i_12_n_0 ;
  wire \char_r[2]_i_13_n_0 ;
  wire \char_r[2]_i_14_n_0 ;
  wire \char_r[2]_i_15_n_0 ;
  wire \char_r[2]_i_16_n_0 ;
  wire \char_r[2]_i_17_n_0 ;
  wire \char_r[2]_i_18_n_0 ;
  wire \char_r[2]_i_19_n_0 ;
  wire \char_r[2]_i_20_n_0 ;
  wire \char_r[2]_i_21_n_0 ;
  wire \char_r[2]_i_22_n_0 ;
  wire \char_r[2]_i_23_n_0 ;
  wire \char_r[2]_i_24_n_0 ;
  wire \char_r[2]_i_25_n_0 ;
  wire \char_r[2]_i_26_n_0 ;
  wire \char_r[2]_i_27_n_0 ;
  wire \char_r[2]_i_28_n_0 ;
  wire \char_r[2]_i_29_n_0 ;
  wire \char_r[2]_i_2_n_0 ;
  wire \char_r[2]_i_30_n_0 ;
  wire \char_r[2]_i_31_n_0 ;
  wire \char_r[2]_i_32_n_0 ;
  wire \char_r[2]_i_33_n_0 ;
  wire \char_r[2]_i_34_n_0 ;
  wire \char_r[2]_i_35_n_0 ;
  wire \char_r[2]_i_36_n_0 ;
  wire \char_r[2]_i_3_n_0 ;
  wire \char_r[2]_i_4_n_0 ;
  wire \char_r[2]_i_5_n_0 ;
  wire \char_r[2]_i_6_n_0 ;
  wire \char_r[2]_i_7_n_0 ;
  wire \char_r[2]_i_8_n_0 ;
  wire \char_r[2]_i_9_n_0 ;
  wire \char_r[3]_i_10_n_0 ;
  wire \char_r[3]_i_11_n_0 ;
  wire \char_r[3]_i_12_n_0 ;
  wire \char_r[3]_i_2_n_0 ;
  wire \char_r[3]_i_3_n_0 ;
  wire \char_r[3]_i_4_n_0 ;
  wire \char_r[3]_i_5_n_0 ;
  wire \char_r[3]_i_6_n_0 ;
  wire \char_r[3]_i_7_n_0 ;
  wire \char_r[3]_i_8_n_0 ;
  wire \char_r[3]_i_9_n_0 ;
  wire \char_r[4]_i_10_n_0 ;
  wire \char_r[4]_i_11_n_0 ;
  wire \char_r[4]_i_12_n_0 ;
  wire \char_r[4]_i_2_n_0 ;
  wire \char_r[4]_i_3_n_0 ;
  wire \char_r[4]_i_4_n_0 ;
  wire \char_r[4]_i_5_n_0 ;
  wire \char_r[4]_i_6_n_0 ;
  wire \char_r[4]_i_7_n_0 ;
  wire \char_r[4]_i_8_n_0 ;
  wire \char_r[4]_i_9_n_0 ;
  wire \char_r[5]_i_10_n_0 ;
  wire \char_r[5]_i_11_n_0 ;
  wire \char_r[5]_i_12_n_0 ;
  wire \char_r[5]_i_13_n_0 ;
  wire \char_r[5]_i_14_n_0 ;
  wire \char_r[5]_i_15_n_0 ;
  wire \char_r[5]_i_16_n_0 ;
  wire \char_r[5]_i_2_n_0 ;
  wire \char_r[5]_i_3_n_0 ;
  wire \char_r[5]_i_4_n_0 ;
  wire \char_r[5]_i_5_n_0 ;
  wire \char_r[5]_i_6_n_0 ;
  wire \char_r[5]_i_7_n_0 ;
  wire \char_r[5]_i_8_n_0 ;
  wire \char_r[5]_i_9_n_0 ;
  wire \char_r[6]_i_10_n_0 ;
  wire \char_r[6]_i_11_n_0 ;
  wire \char_r[6]_i_12_n_0 ;
  wire \char_r[6]_i_13_n_0 ;
  wire \char_r[6]_i_14_n_0 ;
  wire \char_r[6]_i_15_n_0 ;
  wire \char_r[6]_i_16_n_0 ;
  wire \char_r[6]_i_17_n_0 ;
  wire \char_r[6]_i_18_n_0 ;
  wire \char_r[6]_i_19_n_0 ;
  wire \char_r[6]_i_20_n_0 ;
  wire \char_r[6]_i_21_n_0 ;
  wire \char_r[6]_i_22_n_0 ;
  wire \char_r[6]_i_23_n_0 ;
  wire \char_r[6]_i_24_n_0 ;
  wire \char_r[6]_i_25_n_0 ;
  wire \char_r[6]_i_26_n_0 ;
  wire \char_r[6]_i_27_n_0 ;
  wire \char_r[6]_i_28_n_0 ;
  wire \char_r[6]_i_29_n_0 ;
  wire \char_r[6]_i_30_n_0 ;
  wire \char_r[6]_i_31_n_0 ;
  wire \char_r[6]_i_32_n_0 ;
  wire \char_r[6]_i_33_n_0 ;
  wire \char_r[6]_i_34_n_0 ;
  wire \char_r[6]_i_35_n_0 ;
  wire \char_r[6]_i_36_n_0 ;
  wire \char_r[6]_i_37_n_0 ;
  wire \char_r[6]_i_38_n_0 ;
  wire \char_r[6]_i_39_n_0 ;
  wire \char_r[6]_i_3_n_0 ;
  wire \char_r[6]_i_40_n_0 ;
  wire \char_r[6]_i_41_n_0 ;
  wire \char_r[6]_i_42_n_0 ;
  wire \char_r[6]_i_43_n_0 ;
  wire \char_r[6]_i_44_n_0 ;
  wire \char_r[6]_i_45_n_0 ;
  wire \char_r[6]_i_46_n_0 ;
  wire \char_r[6]_i_47_n_0 ;
  wire \char_r[6]_i_48_n_0 ;
  wire \char_r[6]_i_49_n_0 ;
  wire \char_r[6]_i_4_n_0 ;
  wire \char_r[6]_i_50_n_0 ;
  wire \char_r[6]_i_51_n_0 ;
  wire \char_r[6]_i_52_n_0 ;
  wire \char_r[6]_i_53_n_0 ;
  wire \char_r[6]_i_54_n_0 ;
  wire \char_r[6]_i_55_n_0 ;
  wire \char_r[6]_i_56_n_0 ;
  wire \char_r[6]_i_57_n_0 ;
  wire \char_r[6]_i_58_n_0 ;
  wire \char_r[6]_i_59_n_0 ;
  wire \char_r[6]_i_5_n_0 ;
  wire \char_r[6]_i_60_n_0 ;
  wire \char_r[6]_i_61_n_0 ;
  wire \char_r[6]_i_62_n_0 ;
  wire \char_r[6]_i_63_n_0 ;
  wire \char_r[6]_i_64_n_0 ;
  wire \char_r[6]_i_65_n_0 ;
  wire \char_r[6]_i_66_n_0 ;
  wire \char_r[6]_i_67_n_0 ;
  wire \char_r[6]_i_68_n_0 ;
  wire \char_r[6]_i_69_n_0 ;
  wire \char_r[6]_i_6_n_0 ;
  wire \char_r[6]_i_70_n_0 ;
  wire \char_r[6]_i_71_n_0 ;
  wire \char_r[6]_i_72_n_0 ;
  wire \char_r[6]_i_73_n_0 ;
  wire \char_r[6]_i_74_n_0 ;
  wire \char_r[6]_i_7_n_0 ;
  wire \char_r[6]_i_8_n_0 ;
  wire \char_r[6]_i_9_n_0 ;
  wire \char_r_reg_n_0_[0] ;
  wire \char_r_reg_n_0_[1] ;
  wire \char_r_reg_n_0_[2] ;
  wire \char_r_reg_n_0_[3] ;
  wire \char_r_reg_n_0_[4] ;
  wire \char_r_reg_n_0_[5] ;
  wire \char_r_reg_n_0_[6] ;
  wire clk;
  wire [31:0]cycle_r_reg;
  wire [0:0]data10;
  wire [0:0]data11;
  wire [0:0]data12;
  wire [0:0]data13;
  wire [1:0]data15;
  wire [6:1]data16;
  wire [1:1]data18;
  wire [2:0]data20;
  wire [6:6]data21;
  wire [4:0]data22;
  wire [5:5]data23;
  wire [5:0]data24;
  wire [2:0]data25;
  wire [1:1]data27;
  wire [1:0]data28;
  wire [0:0]data29;
  wire [5:0]data30;
  wire [3:0]data31;
  wire [1:0]data33;
  wire [2:0]data34;
  wire [2:1]data35;
  wire [5:0]data36;
  wire [3:1]data37;
  wire [2:0]data38;
  wire [4:0]data39;
  wire [0:0]data5;
  wire [0:0]data9;
  wire \hex_digit_idx_r[1]_i_2_n_0 ;
  wire \hex_digit_idx_r[2]_i_2_n_0 ;
  wire \hex_digit_idx_r[2]_i_3_n_0 ;
  wire \hex_digit_idx_r_reg_n_0_[0] ;
  wire \hex_digit_idx_r_reg_n_0_[1] ;
  wire \hex_digit_idx_r_reg_n_0_[2] ;
  wire \hex_r[1][0]_i_2_n_0 ;
  wire \hex_r[1][10]_i_2_n_0 ;
  wire \hex_r[1][11]_i_2_n_0 ;
  wire \hex_r[1][12]_i_2_n_0 ;
  wire \hex_r[1][13]_i_2_n_0 ;
  wire \hex_r[1][14]_i_2_n_0 ;
  wire \hex_r[1][15]_i_2_n_0 ;
  wire \hex_r[1][16]_i_2_n_0 ;
  wire \hex_r[1][17]_i_2_n_0 ;
  wire \hex_r[1][18]_i_2_n_0 ;
  wire \hex_r[1][19]_i_2_n_0 ;
  wire \hex_r[1][1]_i_2_n_0 ;
  wire \hex_r[1][20]_i_2_n_0 ;
  wire \hex_r[1][21]_i_2_n_0 ;
  wire \hex_r[1][22]_i_2_n_0 ;
  wire \hex_r[1][23]_i_2_n_0 ;
  wire \hex_r[1][24]_i_2_n_0 ;
  wire \hex_r[1][25]_i_2_n_0 ;
  wire \hex_r[1][26]_i_2_n_0 ;
  wire \hex_r[1][27]_i_2_n_0 ;
  wire \hex_r[1][28]_i_2_n_0 ;
  wire \hex_r[1][29]_i_10_n_0 ;
  wire \hex_r[1][29]_i_11_n_0 ;
  wire \hex_r[1][29]_i_12_n_0 ;
  wire \hex_r[1][29]_i_13_n_0 ;
  wire \hex_r[1][29]_i_2_n_0 ;
  wire \hex_r[1][29]_i_3_n_0 ;
  wire \hex_r[1][29]_i_4_n_0 ;
  wire \hex_r[1][29]_i_5_n_0 ;
  wire \hex_r[1][29]_i_6_n_0 ;
  wire \hex_r[1][29]_i_7_n_0 ;
  wire \hex_r[1][29]_i_8_n_0 ;
  wire \hex_r[1][29]_i_9_n_0 ;
  wire \hex_r[1][2]_i_2_n_0 ;
  wire \hex_r[1][30]_i_2_n_0 ;
  wire \hex_r[1][31]_i_2_n_0 ;
  wire \hex_r[1][31]_i_3_n_0 ;
  wire \hex_r[1][31]_i_4_n_0 ;
  wire \hex_r[1][3]_i_2_n_0 ;
  wire \hex_r[1][4]_i_2_n_0 ;
  wire \hex_r[1][5]_i_2_n_0 ;
  wire \hex_r[1][6]_i_2_n_0 ;
  wire \hex_r[1][7]_i_2_n_0 ;
  wire \hex_r[1][8]_i_2_n_0 ;
  wire \hex_r[1][9]_i_2_n_0 ;
  wire \hex_r[2][0]_i_1_n_0 ;
  wire \hex_r[2][10]_i_1_n_0 ;
  wire \hex_r[2][11]_i_1_n_0 ;
  wire \hex_r[2][12]_i_1_n_0 ;
  wire \hex_r[2][13]_i_1_n_0 ;
  wire \hex_r[2][14]_i_1_n_0 ;
  wire \hex_r[2][15]_i_1_n_0 ;
  wire \hex_r[2][16]_i_1_n_0 ;
  wire \hex_r[2][17]_i_1_n_0 ;
  wire \hex_r[2][18]_i_1_n_0 ;
  wire \hex_r[2][19]_i_1_n_0 ;
  wire \hex_r[2][1]_i_1_n_0 ;
  wire \hex_r[2][20]_i_1_n_0 ;
  wire \hex_r[2][21]_i_1_n_0 ;
  wire \hex_r[2][22]_i_1_n_0 ;
  wire \hex_r[2][23]_i_1_n_0 ;
  wire \hex_r[2][24]_i_1_n_0 ;
  wire \hex_r[2][25]_i_1_n_0 ;
  wire \hex_r[2][26]_i_1_n_0 ;
  wire \hex_r[2][27]_i_1_n_0 ;
  wire \hex_r[2][28]_i_1_n_0 ;
  wire \hex_r[2][29]_i_1_n_0 ;
  wire \hex_r[2][2]_i_1_n_0 ;
  wire \hex_r[2][30]_i_1_n_0 ;
  wire \hex_r[2][31]_i_1_n_0 ;
  wire \hex_r[2][31]_i_2_n_0 ;
  wire \hex_r[2][3]_i_1_n_0 ;
  wire \hex_r[2][4]_i_1_n_0 ;
  wire \hex_r[2][5]_i_1_n_0 ;
  wire \hex_r[2][6]_i_1_n_0 ;
  wire \hex_r[2][7]_i_1_n_0 ;
  wire \hex_r[2][8]_i_1_n_0 ;
  wire \hex_r[2][9]_i_1_n_0 ;
  wire \hex_r[3][0]_i_1_n_0 ;
  wire \hex_r[3][10]_i_1_n_0 ;
  wire \hex_r[3][11]_i_1_n_0 ;
  wire \hex_r[3][12]_i_1_n_0 ;
  wire \hex_r[3][13]_i_1_n_0 ;
  wire \hex_r[3][14]_i_1_n_0 ;
  wire \hex_r[3][15]_i_1_n_0 ;
  wire \hex_r[3][16]_i_1_n_0 ;
  wire \hex_r[3][17]_i_1_n_0 ;
  wire \hex_r[3][18]_i_1_n_0 ;
  wire \hex_r[3][19]_i_1_n_0 ;
  wire \hex_r[3][1]_i_1_n_0 ;
  wire \hex_r[3][20]_i_1_n_0 ;
  wire \hex_r[3][21]_i_1_n_0 ;
  wire \hex_r[3][22]_i_1_n_0 ;
  wire \hex_r[3][23]_i_1_n_0 ;
  wire \hex_r[3][24]_i_1_n_0 ;
  wire \hex_r[3][25]_i_1_n_0 ;
  wire \hex_r[3][26]_i_1_n_0 ;
  wire \hex_r[3][27]_i_1_n_0 ;
  wire \hex_r[3][28]_i_1_n_0 ;
  wire \hex_r[3][29]_i_1_n_0 ;
  wire \hex_r[3][2]_i_1_n_0 ;
  wire \hex_r[3][30]_i_1_n_0 ;
  wire \hex_r[3][31]_i_1_n_0 ;
  wire \hex_r[3][3]_i_1_n_0 ;
  wire \hex_r[3][4]_i_1_n_0 ;
  wire \hex_r[3][5]_i_1_n_0 ;
  wire \hex_r[3][6]_i_1_n_0 ;
  wire \hex_r[3][7]_i_1_n_0 ;
  wire \hex_r[3][8]_i_1_n_0 ;
  wire \hex_r[3][9]_i_1_n_0 ;
  wire [12:0]\hex_r_reg[1][12]_0 ;
  wire [31:0]\hex_r_reg[1][31]_0 ;
  wire [31:0]\hex_r_reg[1][31]_1 ;
  wire [31:0]\hex_r_reg[1]_3 ;
  wire [31:0]\hex_r_reg[2][31]_0 ;
  wire [31:0]\hex_r_reg[2]_2 ;
  wire [31:0]\hex_r_reg[3][31]_0 ;
  wire [31:0]\hex_r_reg[3][31]_1 ;
  wire [31:0]\hex_r_reg[3]_1 ;
  wire [31:0]\hex_r_reg[4][31]_0 ;
  wire [31:0]\hex_r_reg[4]_0 ;
  wire [0:0]in7;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire m_axi_awready;
  wire m_axi_awvalid;
  wire m_axi_bready;
  wire m_axi_bvalid;
  wire [0:0]m_axi_rdata;
  wire m_axi_rready;
  wire m_axi_rvalid;
  wire [6:0]m_axi_wdata;
  wire m_axi_wready;
  wire m_axi_wvalid;
  wire [31:0]prints_hex_w;
  wire prints_ready_w;
  wire [120:120]prints_string_w;
  wire rst_n;
  wire simt_ready_i;
  wire start_i;
  wire [1:0]state_r;
  wire [1:0]string_i;
  wire \string_r[120]_i_1_n_0 ;
  wire \string_r[121]_i_1_n_0 ;
  wire \string_r[129]_i_1_n_0 ;
  wire \string_r[130]_i_1_n_0 ;
  wire \string_r[131]_i_1_n_0 ;
  wire \string_r[134]_i_1_n_0 ;
  wire \string_r[145]_i_1_n_0 ;
  wire \string_r[162]_i_1_n_0 ;
  wire \string_r[174]_i_1_n_0 ;
  wire \string_r[176]_i_1_n_0 ;
  wire \string_r[178]_i_1_n_0 ;
  wire \string_r[180]_i_1_n_0 ;
  wire \string_r[189]_i_1_n_0 ;
  wire \string_r[192]_i_1_n_0 ;
  wire \string_r[194]_i_1_n_0 ;
  wire \string_r[197]_i_1_n_0 ;
  wire \string_r[200]_i_1_n_0 ;
  wire \string_r[201]_i_1_n_0 ;
  wire \string_r[202]_i_1_n_0 ;
  wire \string_r[217]_i_1_n_0 ;
  wire \string_r[224]_i_1_n_0 ;
  wire \string_r[225]_i_1_n_0 ;
  wire \string_r[232]_i_1_n_0 ;
  wire \string_r[240]_i_1_n_0 ;
  wire \string_r[245]_i_1_n_0 ;
  wire \string_r[248]_i_1_n_0 ;
  wire \string_r[251]_i_1_n_0 ;
  wire \string_r[265]_i_1_n_0 ;
  wire \string_r[273]_i_1_n_0 ;
  wire \string_r[274]_i_1_n_0 ;
  wire \string_r[281]_i_1_n_0 ;
  wire \string_r[282]_i_1_n_0 ;
  wire \string_r[288]_i_1_n_0 ;
  wire \string_r[291]_i_1_n_0 ;
  wire \string_r[293]_i_1_n_0 ;
  wire \string_r[297]_i_1_n_0 ;
  wire \string_r[299]_i_1_n_0 ;
  wire \string_r[304]_i_1_n_0 ;
  wire \string_r[312]_i_1_n_0 ;
  wire \string_r[313]_i_1_n_0 ;
  wire \string_r[314]_i_1_n_0 ;
  wire \string_r[316]_i_10_n_0 ;
  wire \string_r[316]_i_1_n_0 ;
  wire \string_r[316]_i_2_n_0 ;
  wire \string_r[316]_i_4_n_0 ;
  wire \string_r[316]_i_5_n_0 ;
  wire \string_r[316]_i_6_n_0 ;
  wire \string_r[316]_i_7_n_0 ;
  wire \string_r[316]_i_8_n_0 ;
  wire \string_r[316]_i_9_n_0 ;
  wire \string_r[40]_i_1_n_0 ;
  wire \string_r[88]_i_1_n_0 ;
  wire u_printc_n_10;
  wire u_printc_n_11;
  wire u_printc_n_12;
  wire u_printc_n_13;
  wire u_printc_n_14;
  wire u_printc_n_5;
  wire u_printc_n_6;
  wire u_printc_n_7;
  wire u_printc_n_8;
  wire u_printc_n_9;
  wire wait_counter_fin_w;
  wire [0:0]wait_counter_next_w;
  wire [0:0]wait_counter_r;
  wire \wait_counter_r[1]_i_3_0 ;
  wire \wait_counter_r[1]_i_4_n_0 ;
  wire \wait_counter_r_reg[0] ;
  wire \wait_counter_r_reg[0]_0 ;
  wire \wait_counter_r_reg[0]_1 ;
  wire \wait_counter_r_reg[1] ;

  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h001F)) 
    \FSM_sequential_state_r[0]_i_2 
       (.I0(\char_r[1]_i_2_n_0 ),
        .I1(\char_r[0]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\FSM_sequential_state_r[0]_i_3_n_0 ),
        .O(\FSM_sequential_state_r[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_state_r[0]_i_3 
       (.I0(\char_r[4]_i_2_n_0 ),
        .I1(\char_r[3]_i_2_n_0 ),
        .I2(\char_r[5]_i_2_n_0 ),
        .I3(\char_r[6]_i_6_n_0 ),
        .O(\FSM_sequential_state_r[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_state_r[1]_i_2 
       (.I0(\char_r[5]_i_2_n_0 ),
        .I1(\char_r[4]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\FSM_sequential_state_r[1]_i_4_n_0 ),
        .O(\FSM_sequential_state_r[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \FSM_sequential_state_r[1]_i_4 
       (.I0(\char_r[6]_i_6_n_0 ),
        .I1(\char_r[3]_i_2_n_0 ),
        .I2(\char_r[1]_i_2_n_0 ),
        .O(\FSM_sequential_state_r[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000160006)) 
    \FSM_sequential_state_r[1]_i_5 
       (.I0(Q[3]),
        .I1(Q[4]),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(Q[1]),
        .I5(state_r[1]),
        .O(\FSM_sequential_state_r[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hABAAAFAEABAAABAA)) 
    \FSM_sequential_state_r[4]_i_1 
       (.I0(\FSM_sequential_state_r[4]_i_3_n_0 ),
        .I1(Q[4]),
        .I2(Q[2]),
        .I3(\FSM_sequential_state_r[4]_i_4_n_0 ),
        .I4(Q[3]),
        .I5(prints_ready_w),
        .O(\FSM_sequential_state_r_reg[4] ));
  LUT6 #(
    .INIT(64'hEAAAEAAAAAAAEAAA)) 
    \FSM_sequential_state_r[4]_i_3 
       (.I0(\FSM_sequential_state_r[4]_i_6_n_0 ),
        .I1(\FSM_sequential_state_r_reg[0]_2 ),
        .I2(simt_ready_i),
        .I3(Q[0]),
        .I4(Q[3]),
        .I5(wait_counter_fin_w),
        .O(\FSM_sequential_state_r[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAABAAAAAAAAAAAA)) 
    \FSM_sequential_state_r[4]_i_4 
       (.I0(\FSM_sequential_state_r[4]_i_7_n_0 ),
        .I1(\FSM_sequential_state_r_reg[0]_0 ),
        .I2(Q[3]),
        .I3(Q[1]),
        .I4(Q[0]),
        .I5(\FSM_sequential_state_r_reg[0]_1 ),
        .O(\FSM_sequential_state_r[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h88888888C8C80C00)) 
    \FSM_sequential_state_r[4]_i_6 
       (.I0(wait_counter_fin_w),
        .I1(\FSM_sequential_state_r_reg[0]_2 ),
        .I2(Q[0]),
        .I3(prints_ready_w),
        .I4(Q[1]),
        .I5(Q[3]),
        .O(\FSM_sequential_state_r[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFC000CFF0A000A)) 
    \FSM_sequential_state_r[4]_i_7 
       (.I0(start_i),
        .I1(simt_ready_i),
        .I2(Q[0]),
        .I3(Q[3]),
        .I4(prints_ready_w),
        .I5(Q[1]),
        .O(\FSM_sequential_state_r[4]_i_7_n_0 ));
  (* FSM_ENCODED_STATES = "S_READ_CHAR:01,S_IDLE:00,S_WRITE_CHAR:11,S_WRITE_HEX:10" *) 
  FDRE \FSM_sequential_state_r_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(u_printc_n_6),
        .Q(state_r[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "S_READ_CHAR:01,S_IDLE:00,S_WRITE_CHAR:11,S_WRITE_HEX:10" *) 
  FDRE \FSM_sequential_state_r_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(u_printc_n_5),
        .Q(state_r[1]),
        .R(SR));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8000)) 
    \addr_r[12]_i_2 
       (.I0(\addr_r_reg[0]_0 ),
        .I1(Q[3]),
        .I2(prints_ready_w),
        .I3(\addr_r_reg[0] ),
        .I4(\addr_r_reg[0]_1 ),
        .I5(\addr_r_reg[0]_2 ),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \addr_r[12]_i_5 
       (.I0(state_r[0]),
        .I1(state_r[1]),
        .O(prints_ready_w));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \char_idx_r[0]_i_1 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .O(\char_idx_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \char_idx_r[1]_i_1 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .O(\char_idx_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hE1)) 
    \char_idx_r[2]_i_1 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .O(\char_idx_r[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFEFEFE0001010100)) 
    \char_idx_r[3]_i_2 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(state_r[1]),
        .I4(state_r[0]),
        .I5(\char_idx_r_reg_n_0_[3] ),
        .O(char_idx_r[3]));
  LUT6 #(
    .INIT(64'hFEFEFE0001010100)) 
    \char_idx_r[4]_i_2 
       (.I0(\char_idx_r_reg_n_0_[2] ),
        .I1(\char_idx_r[4]_i_3_n_0 ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(state_r[1]),
        .I4(state_r[0]),
        .I5(\char_idx_r_reg_n_0_[4] ),
        .O(char_idx_r[4]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \char_idx_r[4]_i_3 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .O(\char_idx_r[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000001)) 
    \char_idx_r[5]_i_3 
       (.I0(\char_idx_r_reg_n_0_[4] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_idx_r_reg_n_0_[5] ),
        .O(\char_idx_r[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hFFFF1115)) 
    \char_idx_r[5]_i_5 
       (.I0(\FSM_sequential_state_r[0]_i_3_n_0 ),
        .I1(\char_r[2]_i_3_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[1]_i_2_n_0 ),
        .I4(state_r[1]),
        .O(\char_idx_r[5]_i_5_n_0 ));
  FDSE \char_idx_r_reg[0] 
       (.C(clk),
        .CE(u_printc_n_14),
        .D(\char_idx_r[0]_i_1_n_0 ),
        .Q(\char_idx_r_reg_n_0_[0] ),
        .S(u_printc_n_7));
  FDSE \char_idx_r_reg[1] 
       (.C(clk),
        .CE(u_printc_n_14),
        .D(\char_idx_r[1]_i_1_n_0 ),
        .Q(\char_idx_r_reg_n_0_[1] ),
        .S(u_printc_n_7));
  FDSE \char_idx_r_reg[2] 
       (.C(clk),
        .CE(u_printc_n_14),
        .D(\char_idx_r[2]_i_1_n_0 ),
        .Q(\char_idx_r_reg_n_0_[2] ),
        .S(u_printc_n_7));
  FDRE \char_idx_r_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(u_printc_n_9),
        .Q(\char_idx_r_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \char_idx_r_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(u_printc_n_8),
        .Q(\char_idx_r_reg_n_0_[4] ),
        .R(1'b0));
  FDSE \char_idx_r_reg[5] 
       (.C(clk),
        .CE(u_printc_n_14),
        .D(\char_idx_r[5]_i_3_n_0 ),
        .Q(\char_idx_r_reg_n_0_[5] ),
        .S(u_printc_n_7));
  LUT6 #(
    .INIT(64'h56AAFFFF56AA0000)) 
    \char_r[0]_i_1 
       (.I0(\char_r[2]_i_2_n_0 ),
        .I1(\char_r[6]_i_3_n_0 ),
        .I2(\char_r[6]_i_4_n_0 ),
        .I3(\char_r[6]_i_5_n_0 ),
        .I4(\char_idx_r[5]_i_5_n_0 ),
        .I5(\char_r[0]_i_2_n_0 ),
        .O(char_r0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'hFC0A0C0A)) 
    \char_r[0]_i_10 
       (.I0(data12),
        .I1(data13),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data15[0]),
        .O(\char_r[0]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hF0AACCFFF0AACC00)) 
    \char_r[0]_i_11 
       (.I0(data22[0]),
        .I1(data5),
        .I2(data12),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data20[0]),
        .O(\char_r[0]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[0]_i_12 
       (.I0(data29),
        .I1(data31[0]),
        .I2(data28[0]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data30[0]),
        .O(\char_r[0]_i_12_n_0 ));
  LUT5 #(
    .INIT(32'hF0AACCF0)) 
    \char_r[0]_i_13 
       (.I0(data15[0]),
        .I1(data12),
        .I2(data11),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[0]_i_13_n_0 ));
  LUT5 #(
    .INIT(32'hFCFAFC0A)) 
    \char_r[0]_i_14 
       (.I0(data24[0]),
        .I1(data25[0]),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data11),
        .O(\char_r[0]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'hAFAEABAA)) 
    \char_r[0]_i_2 
       (.I0(\char_r[0]_i_3_n_0 ),
        .I1(\char_idx_r_reg_n_0_[4] ),
        .I2(\char_idx_r_reg_n_0_[5] ),
        .I3(\char_r[0]_i_4_n_0 ),
        .I4(\char_r[0]_i_5_n_0 ),
        .O(\char_r[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000000AC00000000)) 
    \char_r[0]_i_3 
       (.I0(\char_r[0]_i_6_n_0 ),
        .I1(\char_r[0]_i_7_n_0 ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(\char_idx_r_reg_n_0_[4] ),
        .I5(\char_idx_r_reg_n_0_[5] ),
        .O(\char_r[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF00C0C0AAAA0000)) 
    \char_r[0]_i_4 
       (.I0(\char_r[0]_i_8_n_0 ),
        .I1(data5),
        .I2(\char_r[0]_i_9_n_0 ),
        .I3(\char_r[0]_i_10_n_0 ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \char_r[0]_i_5 
       (.I0(\char_r[0]_i_11_n_0 ),
        .I1(\char_r[0]_i_12_n_0 ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(\char_r[0]_i_13_n_0 ),
        .I5(\char_r[0]_i_14_n_0 ),
        .O(\char_r[0]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hCAFFCAF0)) 
    \char_r[0]_i_6 
       (.I0(data38[0]),
        .I1(data39[0]),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(data36[0]),
        .O(\char_r[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[0]_i_7 
       (.I0(data33[0]),
        .I1(data5),
        .I2(data9),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data34[0]),
        .O(\char_r[0]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'hFAC00AC0)) 
    \char_r[0]_i_8 
       (.I0(data9),
        .I1(data10),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data11),
        .O(\char_r[0]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \char_r[0]_i_9 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[0]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAF40FFFFAF400000)) 
    \char_r[1]_i_1 
       (.I0(\char_r[2]_i_2_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_5_n_0 ),
        .I3(\char_r[6]_i_3_n_0 ),
        .I4(\char_idx_r[5]_i_5_n_0 ),
        .I5(\char_r[1]_i_2_n_0 ),
        .O(char_r0_in[1]));
  LUT6 #(
    .INIT(64'hBFB38C8000000000)) 
    \char_r[1]_i_10 
       (.I0(data15[1]),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(data9),
        .I4(data11),
        .I5(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[1]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0444004404400040)) 
    \char_r[1]_i_11 
       (.I0(\char_idx_r_reg_n_0_[3] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data11),
        .I5(data13),
        .O(\char_r[1]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[1]_i_12 
       (.I0(data30[0]),
        .I1(data11),
        .I2(data28[1]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data39[0]),
        .O(\char_r[1]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'hF0CA00CA)) 
    \char_r[1]_i_13 
       (.I0(data16[1]),
        .I1(data18),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data9),
        .O(\char_r[1]_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'hFC0A0C0A)) 
    \char_r[1]_i_14 
       (.I0(data34[0]),
        .I1(data25[1]),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data27),
        .O(\char_r[1]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hEEFFEEFEEEEFEEEE)) 
    \char_r[1]_i_2 
       (.I0(\char_r[1]_i_3_n_0 ),
        .I1(\char_r[1]_i_4_n_0 ),
        .I2(\char_idx_r_reg_n_0_[4] ),
        .I3(\char_idx_r_reg_n_0_[5] ),
        .I4(\char_r[1]_i_5_n_0 ),
        .I5(\char_r[1]_i_6_n_0 ),
        .O(\char_r[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8AA08A0080A08000)) 
    \char_r[1]_i_3 
       (.I0(\char_r[1]_i_7_n_0 ),
        .I1(data35[1]),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(data33[1]),
        .I5(data34[1]),
        .O(\char_r[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h80AA800A80A08000)) 
    \char_r[1]_i_4 
       (.I0(\char_r[5]_i_12_n_0 ),
        .I1(data39[1]),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(data37[1]),
        .I5(data15[0]),
        .O(\char_r[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFAEFFAEFFAEAEAE)) 
    \char_r[1]_i_5 
       (.I0(\char_r[5]_i_14_n_0 ),
        .I1(\char_r[1]_i_8_n_0 ),
        .I2(\char_idx_r[4]_i_3_n_0 ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(\char_r[1]_i_9_n_0 ),
        .I5(\char_r[1]_i_10_n_0 ),
        .O(\char_r[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hEFAFEFAAEAAFEAAA)) 
    \char_r[1]_i_6 
       (.I0(\char_r[1]_i_11_n_0 ),
        .I1(\char_r[1]_i_12_n_0 ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(\char_r[1]_i_13_n_0 ),
        .I5(\char_r[1]_i_14_n_0 ),
        .O(\char_r[1]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h0100)) 
    \char_r[1]_i_7 
       (.I0(\char_idx_r_reg_n_0_[2] ),
        .I1(\char_idx_r_reg_n_0_[3] ),
        .I2(\char_idx_r_reg_n_0_[4] ),
        .I3(\char_idx_r_reg_n_0_[5] ),
        .O(\char_r[1]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \char_r[1]_i_8 
       (.I0(\char_idx_r_reg_n_0_[3] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(data5),
        .O(\char_r[1]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h08080F00)) 
    \char_r[1]_i_9 
       (.I0(data12),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(data10),
        .I4(\char_idx_r_reg_n_0_[0] ),
        .O(\char_r[1]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hEF00FFFFEF000000)) 
    \char_r[2]_i_1 
       (.I0(\char_r[2]_i_2_n_0 ),
        .I1(\char_r[6]_i_3_n_0 ),
        .I2(\char_r[6]_i_5_n_0 ),
        .I3(\char_r[6]_i_4_n_0 ),
        .I4(\char_idx_r[5]_i_5_n_0 ),
        .I5(\char_r[2]_i_3_n_0 ),
        .O(char_r0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT4 #(
    .INIT(16'h0A0C)) 
    \char_r[2]_i_10 
       (.I0(\char_r[2]_i_30_n_0 ),
        .I1(\char_r[2]_i_31_n_0 ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[2]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h00200000)) 
    \char_r[2]_i_11 
       (.I0(\char_idx_r_reg_n_0_[2] ),
        .I1(\char_idx_r_reg_n_0_[3] ),
        .I2(\char_idx_r_reg_n_0_[5] ),
        .I3(\char_idx_r_reg_n_0_[4] ),
        .I4(\char_r[2]_i_32_n_0 ),
        .O(\char_r[2]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAA800)) 
    \char_r[2]_i_12 
       (.I0(\char_r[5]_i_16_n_0 ),
        .I1(\char_r[2]_i_33_n_0 ),
        .I2(\char_r[2]_i_34_n_0 ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(\char_r[2]_i_35_n_0 ),
        .I5(\char_r[5]_i_14_n_0 ),
        .O(\char_r[2]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h00020000)) 
    \char_r[2]_i_13 
       (.I0(\char_idx_r_reg_n_0_[5] ),
        .I1(\char_idx_r_reg_n_0_[4] ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_r[2]_i_36_n_0 ),
        .O(\char_r[2]_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[2]_i_14 
       (.I0(\hex_r_reg[1]_3 [28]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [28]),
        .O(\char_r[2]_i_14_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[2]_i_15 
       (.I0(\hex_r_reg[3]_1 [28]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [28]),
        .O(\char_r[2]_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[2]_i_16 
       (.I0(\hex_r_reg[1]_3 [20]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [20]),
        .O(\char_r[2]_i_16_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[2]_i_17 
       (.I0(\hex_r_reg[3]_1 [20]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [20]),
        .O(\char_r[2]_i_17_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[2]_i_18 
       (.I0(\hex_r_reg[3]_1 [16]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [16]),
        .O(\char_r[2]_i_18_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[2]_i_19 
       (.I0(\hex_r_reg[3]_1 [24]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [24]),
        .O(\char_r[2]_i_19_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFEFFFEFFFE00)) 
    \char_r[2]_i_2 
       (.I0(\char_r[2]_i_4_n_0 ),
        .I1(\char_r[2]_i_5_n_0 ),
        .I2(\char_r[2]_i_6_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[2] ),
        .I4(\char_r[2]_i_7_n_0 ),
        .I5(\char_r[2]_i_8_n_0 ),
        .O(\char_r[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[2]_i_20 
       (.I0(\hex_r_reg[1]_3 [12]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [12]),
        .O(\char_r[2]_i_20_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[2]_i_21 
       (.I0(\hex_r_reg[3]_1 [12]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [12]),
        .O(\char_r[2]_i_21_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[2]_i_22 
       (.I0(\hex_r_reg[1]_3 [4]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [4]),
        .O(\char_r[2]_i_22_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[2]_i_23 
       (.I0(\hex_r_reg[3]_1 [4]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [4]),
        .O(\char_r[2]_i_23_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[2]_i_24 
       (.I0(\hex_r_reg[1]_3 [8]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [8]),
        .O(\char_r[2]_i_24_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[2]_i_25 
       (.I0(\hex_r_reg[3]_1 [8]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [8]),
        .O(\char_r[2]_i_25_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[2]_i_26 
       (.I0(\hex_r_reg[1]_3 [0]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [0]),
        .O(\char_r[2]_i_26_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[2]_i_27 
       (.I0(\hex_r_reg[3]_1 [0]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [0]),
        .O(\char_r[2]_i_27_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'h8880)) 
    \char_r[2]_i_28 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(data11),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .O(\char_r[2]_i_28_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[2]_i_29 
       (.I0(data25[2]),
        .I1(data24[0]),
        .I2(data24[2]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data12),
        .O(\char_r[2]_i_29_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFA8)) 
    \char_r[2]_i_3 
       (.I0(\char_r[5]_i_3_n_0 ),
        .I1(\char_r[2]_i_9_n_0 ),
        .I2(\char_r[2]_i_10_n_0 ),
        .I3(\char_r[2]_i_11_n_0 ),
        .I4(\char_r[2]_i_12_n_0 ),
        .I5(\char_r[2]_i_13_n_0 ),
        .O(\char_r[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hF0AACCFFF0AACC00)) 
    \char_r[2]_i_30 
       (.I0(data22[2]),
        .I1(data21),
        .I2(data12),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data20[2]),
        .O(\char_r[2]_i_30_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[2]_i_31 
       (.I0(data16[1]),
        .I1(data10),
        .I2(data16[2]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data15[1]),
        .O(\char_r[2]_i_31_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[2]_i_32 
       (.I0(data34[0]),
        .I1(data39[2]),
        .I2(data22[0]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data38[2]),
        .O(\char_r[2]_i_32_n_0 ));
  LUT6 #(
    .INIT(64'hB383B08000000000)) 
    \char_r[2]_i_33 
       (.I0(data9),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(data10),
        .I4(data13),
        .I5(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[2]_i_33_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'h008800B8)) 
    \char_r[2]_i_34 
       (.I0(data9),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(data11),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[2]_i_34_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT5 #(
    .INIT(32'h00080000)) 
    \char_r[2]_i_35 
       (.I0(data5),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(\char_idx_r_reg_n_0_[0] ),
        .O(\char_r[2]_i_35_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[2]_i_36 
       (.I0(data11),
        .I1(data35[2]),
        .I2(data22[2]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data34[2]),
        .O(\char_r[2]_i_36_n_0 ));
  LUT6 #(
    .INIT(64'hEEEE0000FFF00000)) 
    \char_r[2]_i_4 
       (.I0(\char_r[2]_i_14_n_0 ),
        .I1(\char_r[2]_i_15_n_0 ),
        .I2(\char_r[2]_i_16_n_0 ),
        .I3(\char_r[2]_i_17_n_0 ),
        .I4(\hex_digit_idx_r_reg_n_0_[0] ),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFEAEAEA)) 
    \char_r[2]_i_5 
       (.I0(\char_r[2]_i_18_n_0 ),
        .I1(\char_r[6]_i_30_n_0 ),
        .I2(\hex_r_reg[1]_3 [16]),
        .I3(\char_r[6]_i_31_n_0 ),
        .I4(\hex_r_reg[2]_2 [16]),
        .I5(\hex_digit_idx_r[2]_i_2_n_0 ),
        .O(\char_r[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAA888A888A888)) 
    \char_r[2]_i_6 
       (.I0(\char_r[6]_i_32_n_0 ),
        .I1(\char_r[2]_i_19_n_0 ),
        .I2(\char_r[6]_i_30_n_0 ),
        .I3(\hex_r_reg[1]_3 [24]),
        .I4(\char_r[6]_i_31_n_0 ),
        .I5(\hex_r_reg[2]_2 [24]),
        .O(\char_r[2]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEEEE0000FFF00000)) 
    \char_r[2]_i_7 
       (.I0(\char_r[2]_i_20_n_0 ),
        .I1(\char_r[2]_i_21_n_0 ),
        .I2(\char_r[2]_i_22_n_0 ),
        .I3(\char_r[2]_i_23_n_0 ),
        .I4(\hex_digit_idx_r_reg_n_0_[0] ),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0E0F0E0F0E0F0E00)) 
    \char_r[2]_i_8 
       (.I0(\char_r[2]_i_24_n_0 ),
        .I1(\char_r[2]_i_25_n_0 ),
        .I2(\hex_digit_idx_r_reg_n_0_[0] ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .I4(\char_r[2]_i_26_n_0 ),
        .I5(\char_r[2]_i_27_n_0 ),
        .O(\char_r[2]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hBAFFBAAA00000000)) 
    \char_r[2]_i_9 
       (.I0(\char_r[2]_i_28_n_0 ),
        .I1(\char_idx_r[4]_i_3_n_0 ),
        .I2(data28[0]),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_r[2]_i_29_n_0 ),
        .I5(\char_idx_r_reg_n_0_[3] ),
        .O(\char_r[2]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h10FF1000)) 
    \char_r[3]_i_1 
       (.I0(\char_r[6]_i_3_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_5_n_0 ),
        .I3(\char_idx_r[5]_i_5_n_0 ),
        .I4(\char_r[3]_i_2_n_0 ),
        .O(char_r0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'hF0CA00CA)) 
    \char_r[3]_i_10 
       (.I0(data25[1]),
        .I1(data22[0]),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data31[3]),
        .O(\char_r[3]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[3]_i_11 
       (.I0(data20[2]),
        .I1(data9),
        .I2(data16[3]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data15[1]),
        .O(\char_r[3]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[3]_i_12 
       (.I0(data27),
        .I1(data34[0]),
        .I2(data29),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data24[2]),
        .O(\char_r[3]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'hAFAEABAA)) 
    \char_r[3]_i_2 
       (.I0(\char_r[3]_i_3_n_0 ),
        .I1(\char_idx_r_reg_n_0_[4] ),
        .I2(\char_idx_r_reg_n_0_[5] ),
        .I3(\char_r[3]_i_4_n_0 ),
        .I4(\char_r[3]_i_5_n_0 ),
        .O(\char_r[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000000AC00000000)) 
    \char_r[3]_i_3 
       (.I0(\char_r[3]_i_6_n_0 ),
        .I1(\char_r[3]_i_7_n_0 ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(\char_idx_r_reg_n_0_[4] ),
        .I5(\char_idx_r_reg_n_0_[5] ),
        .O(\char_r[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAEAAAAAAAEA)) 
    \char_r[3]_i_4 
       (.I0(\char_r[5]_i_14_n_0 ),
        .I1(data5),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_r[3]_i_8_n_0 ),
        .O(\char_r[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFCFA0C0AFC0A0)) 
    \char_r[3]_i_5 
       (.I0(\char_r[3]_i_9_n_0 ),
        .I1(\char_r[3]_i_10_n_0 ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(\char_r[3]_i_11_n_0 ),
        .I5(\char_r[3]_i_12_n_0 ),
        .O(\char_r[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[3]_i_6 
       (.I0(data37[3]),
        .I1(data34[0]),
        .I2(data36[3]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data35[2]),
        .O(\char_r[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[3]_i_7 
       (.I0(data34[0]),
        .I1(data33[0]),
        .I2(data36[0]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data34[1]),
        .O(\char_r[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h4444A0A0FF00DD88)) 
    \char_r[3]_i_8 
       (.I0(\char_idx_r_reg_n_0_[2] ),
        .I1(data13),
        .I2(data12),
        .I3(data10),
        .I4(\char_idx_r_reg_n_0_[0] ),
        .I5(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[3]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[3]_i_9 
       (.I0(data11),
        .I1(data34[0]),
        .I2(data18),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data24[0]),
        .O(\char_r[3]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h57FF5700)) 
    \char_r[4]_i_1 
       (.I0(\char_r[6]_i_5_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_3_n_0 ),
        .I3(\char_idx_r[5]_i_5_n_0 ),
        .I4(\char_r[4]_i_2_n_0 ),
        .O(char_r0_in[4]));
  LUT5 #(
    .INIT(32'hFCA00CA0)) 
    \char_r[4]_i_10 
       (.I0(data38[2]),
        .I1(data30[0]),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data28[1]),
        .O(\char_r[4]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFC0AFCFA0C0A0)) 
    \char_r[4]_i_11 
       (.I0(data28[1]),
        .I1(data35[1]),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(data9),
        .I5(data34[0]),
        .O(\char_r[4]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'h0EC00200)) 
    \char_r[4]_i_12 
       (.I0(data11),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(data9),
        .O(\char_r[4]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF62404040)) 
    \char_r[4]_i_2 
       (.I0(\char_idx_r_reg_n_0_[5] ),
        .I1(\char_idx_r_reg_n_0_[4] ),
        .I2(\char_r[4]_i_3_n_0 ),
        .I3(\char_r[4]_i_4_n_0 ),
        .I4(\char_r[4]_i_5_n_0 ),
        .I5(\char_r[4]_i_6_n_0 ),
        .O(\char_r[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF00EEEEF0F0EEEE)) 
    \char_r[4]_i_3 
       (.I0(\char_r[4]_i_7_n_0 ),
        .I1(\char_r[4]_i_8_n_0 ),
        .I2(\char_r[4]_i_9_n_0 ),
        .I3(\char_r[4]_i_10_n_0 ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \char_r[4]_i_4 
       (.I0(\char_idx_r_reg_n_0_[2] ),
        .I1(\char_idx_r_reg_n_0_[3] ),
        .O(\char_r[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCFAFC0AFCFA0C0A0)) 
    \char_r[4]_i_5 
       (.I0(data24[0]),
        .I1(data39[4]),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(data9),
        .I5(data36[4]),
        .O(\char_r[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h000000F000220000)) 
    \char_r[4]_i_6 
       (.I0(\char_r[4]_i_11_n_0 ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_r[4]_i_12_n_0 ),
        .I3(\char_idx_r_reg_n_0_[4] ),
        .I4(\char_idx_r_reg_n_0_[5] ),
        .I5(\char_idx_r_reg_n_0_[3] ),
        .O(\char_r[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h7351624000000000)) 
    \char_r[4]_i_7 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(data22[2]),
        .I3(data22[4]),
        .I4(data16[2]),
        .I5(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[4]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h00000A0A0000CFC0)) 
    \char_r[4]_i_8 
       (.I0(data9),
        .I1(data10),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(data15[0]),
        .I4(\char_idx_r_reg_n_0_[2] ),
        .I5(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[4]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hF0AACCF0)) 
    \char_r[4]_i_9 
       (.I0(data28[0]),
        .I1(data34[0]),
        .I2(data11),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[4]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h57FF5700)) 
    \char_r[5]_i_1 
       (.I0(\char_r[6]_i_5_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_3_n_0 ),
        .I3(\char_idx_r[5]_i_5_n_0 ),
        .I4(\char_r[5]_i_2_n_0 ),
        .O(char_r0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \char_r[5]_i_10 
       (.I0(\char_idx_r_reg_n_0_[3] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[5]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \char_r[5]_i_11 
       (.I0(\char_idx_r_reg_n_0_[3] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[5]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    \char_r[5]_i_12 
       (.I0(\char_idx_r_reg_n_0_[4] ),
        .I1(\char_idx_r_reg_n_0_[5] ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[5]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hAA288A08A2208200)) 
    \char_r[5]_i_13 
       (.I0(\char_r[1]_i_7_n_0 ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(data25[0]),
        .I4(data25[2]),
        .I5(data38[0]),
        .O(\char_r[5]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h00008A8000000000)) 
    \char_r[5]_i_14 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(data11),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(data5),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[5]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hAAA80AA8AA080A08)) 
    \char_r[5]_i_15 
       (.I0(\char_r[5]_i_10_n_0 ),
        .I1(data10),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data16[2]),
        .I5(data13),
        .O(\char_r[5]_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \char_r[5]_i_16 
       (.I0(\char_idx_r_reg_n_0_[5] ),
        .I1(\char_idx_r_reg_n_0_[4] ),
        .O(\char_r[5]_i_16_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFAAA8)) 
    \char_r[5]_i_2 
       (.I0(\char_r[5]_i_3_n_0 ),
        .I1(\char_r[5]_i_4_n_0 ),
        .I2(\char_r[5]_i_5_n_0 ),
        .I3(\char_r[5]_i_6_n_0 ),
        .I4(\char_r[5]_i_7_n_0 ),
        .I5(\char_r[5]_i_8_n_0 ),
        .O(\char_r[5]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \char_r[5]_i_3 
       (.I0(\char_idx_r_reg_n_0_[4] ),
        .I1(\char_idx_r_reg_n_0_[5] ),
        .O(\char_r[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FA0A0000CFC0)) 
    \char_r[5]_i_4 
       (.I0(data23),
        .I1(data16[2]),
        .I2(\char_r[5]_i_9_n_0 ),
        .I3(data13),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAA288A08A2208200)) 
    \char_r[5]_i_5 
       (.I0(\char_r[5]_i_10_n_0 ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(data25[0]),
        .I4(data37[3]),
        .I5(data30[5]),
        .O(\char_r[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAA82A8802A022800)) 
    \char_r[5]_i_6 
       (.I0(\char_r[5]_i_11_n_0 ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(data20[0]),
        .I4(data24[5]),
        .I5(data12),
        .O(\char_r[5]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h0AA80008)) 
    \char_r[5]_i_7 
       (.I0(\char_r[5]_i_12_n_0 ),
        .I1(data36[5]),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(data11),
        .O(\char_r[5]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFEEEAAAAAAAA)) 
    \char_r[5]_i_8 
       (.I0(\char_r[5]_i_13_n_0 ),
        .I1(\char_r[5]_i_14_n_0 ),
        .I2(\char_r[5]_i_11_n_0 ),
        .I3(data11),
        .I4(\char_r[5]_i_15_n_0 ),
        .I5(\char_r[5]_i_16_n_0 ),
        .O(\char_r[5]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \char_r[5]_i_9 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .O(\char_r[5]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hEEEE0000FFF00000)) 
    \char_r[6]_i_10 
       (.I0(\char_r[6]_i_34_n_0 ),
        .I1(\char_r[6]_i_35_n_0 ),
        .I2(\char_r[6]_i_36_n_0 ),
        .I3(\char_r[6]_i_37_n_0 ),
        .I4(\hex_digit_idx_r_reg_n_0_[0] ),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0E0F0E0F0E0F0E00)) 
    \char_r[6]_i_11 
       (.I0(\char_r[6]_i_38_n_0 ),
        .I1(\char_r[6]_i_39_n_0 ),
        .I2(\hex_digit_idx_r_reg_n_0_[0] ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .I4(\char_r[6]_i_40_n_0 ),
        .I5(\char_r[6]_i_41_n_0 ),
        .O(\char_r[6]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hEEEE0000FFF00000)) 
    \char_r[6]_i_12 
       (.I0(\char_r[6]_i_42_n_0 ),
        .I1(\char_r[6]_i_43_n_0 ),
        .I2(\char_r[6]_i_44_n_0 ),
        .I3(\char_r[6]_i_45_n_0 ),
        .I4(\hex_digit_idx_r_reg_n_0_[0] ),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFEAEAEA)) 
    \char_r[6]_i_13 
       (.I0(\char_r[6]_i_46_n_0 ),
        .I1(\char_r[6]_i_30_n_0 ),
        .I2(\hex_r_reg[1]_3 [18]),
        .I3(\char_r[6]_i_31_n_0 ),
        .I4(\hex_r_reg[2]_2 [18]),
        .I5(\hex_digit_idx_r[2]_i_2_n_0 ),
        .O(\char_r[6]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAA888A888A888)) 
    \char_r[6]_i_14 
       (.I0(\char_r[6]_i_32_n_0 ),
        .I1(\char_r[6]_i_47_n_0 ),
        .I2(\char_r[6]_i_30_n_0 ),
        .I3(\hex_r_reg[1]_3 [26]),
        .I4(\char_r[6]_i_31_n_0 ),
        .I5(\hex_r_reg[2]_2 [26]),
        .O(\char_r[6]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hEEEE0000FFF00000)) 
    \char_r[6]_i_15 
       (.I0(\char_r[6]_i_48_n_0 ),
        .I1(\char_r[6]_i_49_n_0 ),
        .I2(\char_r[6]_i_50_n_0 ),
        .I3(\char_r[6]_i_51_n_0 ),
        .I4(\hex_digit_idx_r_reg_n_0_[0] ),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'h0E0F0E0F0E0F0E00)) 
    \char_r[6]_i_16 
       (.I0(\char_r[6]_i_52_n_0 ),
        .I1(\char_r[6]_i_53_n_0 ),
        .I2(\hex_digit_idx_r_reg_n_0_[0] ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .I4(\char_r[6]_i_54_n_0 ),
        .I5(\char_r[6]_i_55_n_0 ),
        .O(\char_r[6]_i_16_n_0 ));
  LUT6 #(
    .INIT(64'hEEEE0000FFF00000)) 
    \char_r[6]_i_17 
       (.I0(\char_r[6]_i_56_n_0 ),
        .I1(\char_r[6]_i_57_n_0 ),
        .I2(\char_r[6]_i_58_n_0 ),
        .I3(\char_r[6]_i_59_n_0 ),
        .I4(\hex_digit_idx_r_reg_n_0_[0] ),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFEAEAEA)) 
    \char_r[6]_i_18 
       (.I0(\char_r[6]_i_60_n_0 ),
        .I1(\char_r[6]_i_30_n_0 ),
        .I2(\hex_r_reg[1]_3 [19]),
        .I3(\char_r[6]_i_31_n_0 ),
        .I4(\hex_r_reg[2]_2 [19]),
        .I5(\hex_digit_idx_r[2]_i_2_n_0 ),
        .O(\char_r[6]_i_18_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAA888A888A888)) 
    \char_r[6]_i_19 
       (.I0(\char_r[6]_i_32_n_0 ),
        .I1(\char_r[6]_i_61_n_0 ),
        .I2(\char_r[6]_i_30_n_0 ),
        .I3(\hex_r_reg[1]_3 [27]),
        .I4(\char_r[6]_i_31_n_0 ),
        .I5(\hex_r_reg[2]_2 [27]),
        .O(\char_r[6]_i_19_n_0 ));
  LUT5 #(
    .INIT(32'hE0FFE000)) 
    \char_r[6]_i_2 
       (.I0(\char_r[6]_i_3_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_5_n_0 ),
        .I3(\char_idx_r[5]_i_5_n_0 ),
        .I4(\char_r[6]_i_6_n_0 ),
        .O(char_r0_in[6]));
  LUT6 #(
    .INIT(64'hEEEE0000FFF00000)) 
    \char_r[6]_i_20 
       (.I0(\char_r[6]_i_62_n_0 ),
        .I1(\char_r[6]_i_63_n_0 ),
        .I2(\char_r[6]_i_64_n_0 ),
        .I3(\char_r[6]_i_65_n_0 ),
        .I4(\hex_digit_idx_r_reg_n_0_[0] ),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_20_n_0 ));
  LUT6 #(
    .INIT(64'h0E0F0E0F0E0F0E00)) 
    \char_r[6]_i_21 
       (.I0(\char_r[6]_i_66_n_0 ),
        .I1(\char_r[6]_i_67_n_0 ),
        .I2(\hex_digit_idx_r_reg_n_0_[0] ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .I4(\char_r[6]_i_68_n_0 ),
        .I5(\char_r[6]_i_69_n_0 ),
        .O(\char_r[6]_i_21_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT4 #(
    .INIT(16'hFCAA)) 
    \char_r[6]_i_22 
       (.I0(\char_r[6]_i_70_n_0 ),
        .I1(data23),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[6]_i_22_n_0 ));
  LUT6 #(
    .INIT(64'h0000AAAAFCCC0000)) 
    \char_r[6]_i_23 
       (.I0(\char_r[6]_i_71_n_0 ),
        .I1(\char_r[6]_i_72_n_0 ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_r[6]_i_73_n_0 ),
        .I4(\char_idx_r_reg_n_0_[4] ),
        .I5(\char_idx_r_reg_n_0_[3] ),
        .O(\char_r[6]_i_23_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF3210)) 
    \char_r[6]_i_24 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(data13),
        .I3(data25[0]),
        .I4(\char_r[6]_i_74_n_0 ),
        .O(\char_r[6]_i_24_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_25 
       (.I0(\hex_r_reg[1]_3 [29]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [29]),
        .O(\char_r[6]_i_25_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_26 
       (.I0(\hex_r_reg[3]_1 [29]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [29]),
        .O(\char_r[6]_i_26_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_27 
       (.I0(\hex_r_reg[1]_3 [21]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [21]),
        .O(\char_r[6]_i_27_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_28 
       (.I0(\hex_r_reg[3]_1 [21]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [21]),
        .O(\char_r[6]_i_28_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_29 
       (.I0(\hex_r_reg[3]_1 [17]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [17]),
        .O(\char_r[6]_i_29_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFEFFFEFFFE00)) 
    \char_r[6]_i_3 
       (.I0(\char_r[6]_i_7_n_0 ),
        .I1(\char_r[6]_i_8_n_0 ),
        .I2(\char_r[6]_i_9_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[2] ),
        .I4(\char_r[6]_i_10_n_0 ),
        .I5(\char_r[6]_i_11_n_0 ),
        .O(\char_r[6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \char_r[6]_i_30 
       (.I0(\char_r[1]_i_2_n_0 ),
        .I1(\char_r[0]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .O(\char_r[6]_i_30_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \char_r[6]_i_31 
       (.I0(\char_r[1]_i_2_n_0 ),
        .I1(\char_r[2]_i_3_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .O(\char_r[6]_i_31_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \char_r[6]_i_32 
       (.I0(\hex_digit_idx_r_reg_n_0_[1] ),
        .I1(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\char_r[6]_i_32_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_33 
       (.I0(\hex_r_reg[3]_1 [25]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [25]),
        .O(\char_r[6]_i_33_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_34 
       (.I0(\hex_r_reg[1]_3 [13]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [13]),
        .O(\char_r[6]_i_34_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_35 
       (.I0(\hex_r_reg[3]_1 [13]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [13]),
        .O(\char_r[6]_i_35_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_36 
       (.I0(\hex_r_reg[1]_3 [5]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [5]),
        .O(\char_r[6]_i_36_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_37 
       (.I0(\hex_r_reg[3]_1 [5]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [5]),
        .O(\char_r[6]_i_37_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_38 
       (.I0(\hex_r_reg[1]_3 [9]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [9]),
        .O(\char_r[6]_i_38_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_39 
       (.I0(\hex_r_reg[3]_1 [9]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [9]),
        .O(\char_r[6]_i_39_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFEFFFEFFFE00)) 
    \char_r[6]_i_4 
       (.I0(\char_r[6]_i_12_n_0 ),
        .I1(\char_r[6]_i_13_n_0 ),
        .I2(\char_r[6]_i_14_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[2] ),
        .I4(\char_r[6]_i_15_n_0 ),
        .I5(\char_r[6]_i_16_n_0 ),
        .O(\char_r[6]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_40 
       (.I0(\hex_r_reg[1]_3 [1]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [1]),
        .O(\char_r[6]_i_40_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_41 
       (.I0(\hex_r_reg[3]_1 [1]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [1]),
        .O(\char_r[6]_i_41_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_42 
       (.I0(\hex_r_reg[1]_3 [30]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [30]),
        .O(\char_r[6]_i_42_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_43 
       (.I0(\hex_r_reg[3]_1 [30]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [30]),
        .O(\char_r[6]_i_43_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_44 
       (.I0(\hex_r_reg[1]_3 [22]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [22]),
        .O(\char_r[6]_i_44_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_45 
       (.I0(\hex_r_reg[3]_1 [22]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [22]),
        .O(\char_r[6]_i_45_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_46 
       (.I0(\hex_r_reg[3]_1 [18]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [18]),
        .O(\char_r[6]_i_46_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_47 
       (.I0(\hex_r_reg[3]_1 [26]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [26]),
        .O(\char_r[6]_i_47_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_48 
       (.I0(\hex_r_reg[1]_3 [14]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [14]),
        .O(\char_r[6]_i_48_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_49 
       (.I0(\hex_r_reg[3]_1 [14]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [14]),
        .O(\char_r[6]_i_49_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFEFFFEFFFE00)) 
    \char_r[6]_i_5 
       (.I0(\char_r[6]_i_17_n_0 ),
        .I1(\char_r[6]_i_18_n_0 ),
        .I2(\char_r[6]_i_19_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[2] ),
        .I4(\char_r[6]_i_20_n_0 ),
        .I5(\char_r[6]_i_21_n_0 ),
        .O(\char_r[6]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_50 
       (.I0(\hex_r_reg[1]_3 [6]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [6]),
        .O(\char_r[6]_i_50_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_51 
       (.I0(\hex_r_reg[3]_1 [6]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [6]),
        .O(\char_r[6]_i_51_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_52 
       (.I0(\hex_r_reg[1]_3 [10]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [10]),
        .O(\char_r[6]_i_52_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_53 
       (.I0(\hex_r_reg[3]_1 [10]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [10]),
        .O(\char_r[6]_i_53_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_54 
       (.I0(\hex_r_reg[1]_3 [2]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [2]),
        .O(\char_r[6]_i_54_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_55 
       (.I0(\hex_r_reg[3]_1 [2]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [2]),
        .O(\char_r[6]_i_55_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_56 
       (.I0(\hex_r_reg[1]_3 [31]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [31]),
        .O(\char_r[6]_i_56_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_57 
       (.I0(\hex_r_reg[3]_1 [31]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [31]),
        .O(\char_r[6]_i_57_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_58 
       (.I0(\hex_r_reg[1]_3 [23]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [23]),
        .O(\char_r[6]_i_58_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_59 
       (.I0(\hex_r_reg[3]_1 [23]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [23]),
        .O(\char_r[6]_i_59_n_0 ));
  LUT6 #(
    .INIT(64'h333030303030B8B8)) 
    \char_r[6]_i_6 
       (.I0(\char_r[6]_i_22_n_0 ),
        .I1(\char_idx_r_reg_n_0_[5] ),
        .I2(\char_r[6]_i_23_n_0 ),
        .I3(\char_r[6]_i_24_n_0 ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_idx_r_reg_n_0_[4] ),
        .O(\char_r[6]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_60 
       (.I0(\hex_r_reg[3]_1 [19]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [19]),
        .O(\char_r[6]_i_60_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_61 
       (.I0(\hex_r_reg[3]_1 [27]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [27]),
        .O(\char_r[6]_i_61_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_62 
       (.I0(\hex_r_reg[1]_3 [15]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [15]),
        .O(\char_r[6]_i_62_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_63 
       (.I0(\hex_r_reg[3]_1 [15]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [15]),
        .O(\char_r[6]_i_63_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_64 
       (.I0(\hex_r_reg[1]_3 [7]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [7]),
        .O(\char_r[6]_i_64_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_65 
       (.I0(\hex_r_reg[3]_1 [7]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [7]),
        .O(\char_r[6]_i_65_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_66 
       (.I0(\hex_r_reg[1]_3 [11]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [11]),
        .O(\char_r[6]_i_66_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_67 
       (.I0(\hex_r_reg[3]_1 [11]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [11]),
        .O(\char_r[6]_i_67_n_0 ));
  LUT5 #(
    .INIT(32'h020C0200)) 
    \char_r[6]_i_68 
       (.I0(\hex_r_reg[1]_3 [3]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[2]_i_3_n_0 ),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\hex_r_reg[2]_2 [3]),
        .O(\char_r[6]_i_68_n_0 ));
  LUT5 #(
    .INIT(32'hFF830080)) 
    \char_r[6]_i_69 
       (.I0(\hex_r_reg[3]_1 [3]),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_2_n_0 ),
        .I3(\char_r[2]_i_3_n_0 ),
        .I4(\hex_r_reg[4]_0 [3]),
        .O(\char_r[6]_i_69_n_0 ));
  LUT6 #(
    .INIT(64'hEEEE0000FFF00000)) 
    \char_r[6]_i_7 
       (.I0(\char_r[6]_i_25_n_0 ),
        .I1(\char_r[6]_i_26_n_0 ),
        .I2(\char_r[6]_i_27_n_0 ),
        .I3(\char_r[6]_i_28_n_0 ),
        .I4(\hex_digit_idx_r_reg_n_0_[0] ),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[6]_i_70 
       (.I0(data39[4]),
        .I1(data5),
        .I2(data15[0]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data34[2]),
        .O(\char_r[6]_i_70_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'hBF8CFC00)) 
    \char_r[6]_i_71 
       (.I0(data15[0]),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(data11),
        .I4(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[6]_i_71_n_0 ));
  LUT6 #(
    .INIT(64'h0000B8B80000FF00)) 
    \char_r[6]_i_72 
       (.I0(data10),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(data15[0]),
        .I3(data16[6]),
        .I4(\char_idx_r_reg_n_0_[2] ),
        .I5(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_72_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[6]_i_73 
       (.I0(data21),
        .I1(data29),
        .I2(data16[6]),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data23),
        .O(\char_r[6]_i_73_n_0 ));
  LUT6 #(
    .INIT(64'hF971E86000000000)) 
    \char_r[6]_i_74 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(data30[0]),
        .I3(data30[5]),
        .I4(data28[0]),
        .I5(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[6]_i_74_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FFEAEAEA)) 
    \char_r[6]_i_8 
       (.I0(\char_r[6]_i_29_n_0 ),
        .I1(\char_r[6]_i_30_n_0 ),
        .I2(\hex_r_reg[1]_3 [17]),
        .I3(\char_r[6]_i_31_n_0 ),
        .I4(\hex_r_reg[2]_2 [17]),
        .I5(\hex_digit_idx_r[2]_i_2_n_0 ),
        .O(\char_r[6]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAA888A888A888)) 
    \char_r[6]_i_9 
       (.I0(\char_r[6]_i_32_n_0 ),
        .I1(\char_r[6]_i_33_n_0 ),
        .I2(\char_r[6]_i_30_n_0 ),
        .I3(\hex_r_reg[1]_3 [25]),
        .I4(\char_r[6]_i_31_n_0 ),
        .I5(\hex_r_reg[2]_2 [25]),
        .O(\char_r[6]_i_9_n_0 ));
  FDRE \char_r_reg[0] 
       (.C(clk),
        .CE(u_printc_n_13),
        .D(char_r0_in[0]),
        .Q(\char_r_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \char_r_reg[1] 
       (.C(clk),
        .CE(u_printc_n_13),
        .D(char_r0_in[1]),
        .Q(\char_r_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \char_r_reg[2] 
       (.C(clk),
        .CE(u_printc_n_13),
        .D(char_r0_in[2]),
        .Q(\char_r_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \char_r_reg[3] 
       (.C(clk),
        .CE(u_printc_n_13),
        .D(char_r0_in[3]),
        .Q(\char_r_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \char_r_reg[4] 
       (.C(clk),
        .CE(u_printc_n_13),
        .D(char_r0_in[4]),
        .Q(\char_r_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \char_r_reg[5] 
       (.C(clk),
        .CE(u_printc_n_13),
        .D(char_r0_in[5]),
        .Q(\char_r_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \char_r_reg[6] 
       (.C(clk),
        .CE(u_printc_n_13),
        .D(char_r0_in[6]),
        .Q(\char_r_reg_n_0_[6] ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT4 #(
    .INIT(16'h01FF)) 
    \hex_digit_idx_r[1]_i_2 
       (.I0(\hex_digit_idx_r_reg_n_0_[2] ),
        .I1(\hex_digit_idx_r_reg_n_0_[0] ),
        .I2(\hex_digit_idx_r_reg_n_0_[1] ),
        .I3(state_r[1]),
        .O(\hex_digit_idx_r[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \hex_digit_idx_r[2]_i_2 
       (.I0(\hex_digit_idx_r_reg_n_0_[0] ),
        .I1(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\hex_digit_idx_r[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \hex_digit_idx_r[2]_i_3 
       (.I0(state_r[1]),
        .I1(rst_n),
        .I2(\FSM_sequential_state_r[1]_i_2_n_0 ),
        .O(\hex_digit_idx_r[2]_i_3_n_0 ));
  FDRE \hex_digit_idx_r_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(u_printc_n_12),
        .Q(\hex_digit_idx_r_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \hex_digit_idx_r_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(u_printc_n_11),
        .Q(\hex_digit_idx_r_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \hex_digit_idx_r_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(u_printc_n_10),
        .Q(\hex_digit_idx_r_reg_n_0_[2] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][0]_i_1 
       (.I0(\hex_r[1][0]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [0]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[0]));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][0]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [0]),
        .I1(\hex_r_reg[1][31]_1 [0]),
        .I2(cycle_r_reg[0]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][10]_i_1 
       (.I0(\hex_r[1][10]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [10]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[10]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][10]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [10]),
        .I1(\hex_r_reg[1][31]_1 [10]),
        .I2(cycle_r_reg[10]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][11]_i_1 
       (.I0(\hex_r[1][11]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [11]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[11]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][11]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [11]),
        .I1(\hex_r_reg[1][31]_1 [11]),
        .I2(cycle_r_reg[11]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][12]_i_1 
       (.I0(\hex_r[1][12]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [12]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[12]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][12]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [12]),
        .I1(\hex_r_reg[1][31]_1 [12]),
        .I2(cycle_r_reg[12]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][13]_i_1 
       (.I0(\hex_r[1][13]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [13]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[13]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][13]_i_2 
       (.I0(cycle_r_reg[13]),
        .I1(\hex_r_reg[1][31]_1 [13]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][14]_i_1 
       (.I0(\hex_r[1][14]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [14]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[14]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][14]_i_2 
       (.I0(cycle_r_reg[14]),
        .I1(\hex_r_reg[1][31]_1 [14]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][15]_i_1 
       (.I0(\hex_r[1][15]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [15]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[15]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][15]_i_2 
       (.I0(cycle_r_reg[15]),
        .I1(\hex_r_reg[1][31]_1 [15]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][16]_i_1 
       (.I0(\hex_r[1][16]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [16]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[16]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][16]_i_2 
       (.I0(cycle_r_reg[16]),
        .I1(\hex_r_reg[1][31]_1 [16]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][17]_i_1 
       (.I0(\hex_r[1][17]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [17]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[17]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][17]_i_2 
       (.I0(cycle_r_reg[17]),
        .I1(\hex_r_reg[1][31]_1 [17]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][18]_i_1 
       (.I0(\hex_r[1][18]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [18]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[18]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][18]_i_2 
       (.I0(cycle_r_reg[18]),
        .I1(\hex_r_reg[1][31]_1 [18]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][19]_i_1 
       (.I0(\hex_r[1][19]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [19]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[19]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][19]_i_2 
       (.I0(cycle_r_reg[19]),
        .I1(\hex_r_reg[1][31]_1 [19]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][1]_i_1 
       (.I0(\hex_r[1][1]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [1]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[1]));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][1]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [1]),
        .I1(\hex_r_reg[1][31]_1 [1]),
        .I2(cycle_r_reg[1]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][20]_i_1 
       (.I0(\hex_r[1][20]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [20]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[20]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][20]_i_2 
       (.I0(cycle_r_reg[20]),
        .I1(\hex_r_reg[1][31]_1 [20]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][21]_i_1 
       (.I0(\hex_r[1][21]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [21]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[21]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][21]_i_2 
       (.I0(cycle_r_reg[21]),
        .I1(\hex_r_reg[1][31]_1 [21]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][22]_i_1 
       (.I0(\hex_r[1][22]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [22]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[22]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][22]_i_2 
       (.I0(cycle_r_reg[22]),
        .I1(\hex_r_reg[1][31]_1 [22]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][23]_i_1 
       (.I0(\hex_r[1][23]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [23]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[23]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][23]_i_2 
       (.I0(cycle_r_reg[23]),
        .I1(\hex_r_reg[1][31]_1 [23]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][24]_i_1 
       (.I0(\hex_r[1][24]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [24]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[24]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][24]_i_2 
       (.I0(cycle_r_reg[24]),
        .I1(\hex_r_reg[1][31]_1 [24]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][25]_i_1 
       (.I0(\hex_r[1][25]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [25]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[25]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][25]_i_2 
       (.I0(cycle_r_reg[25]),
        .I1(\hex_r_reg[1][31]_1 [25]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][26]_i_1 
       (.I0(\hex_r[1][26]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [26]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[26]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][26]_i_2 
       (.I0(cycle_r_reg[26]),
        .I1(\hex_r_reg[1][31]_1 [26]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][27]_i_1 
       (.I0(\hex_r[1][27]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [27]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[27]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][27]_i_2 
       (.I0(cycle_r_reg[27]),
        .I1(\hex_r_reg[1][31]_1 [27]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][28]_i_1 
       (.I0(\hex_r[1][28]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [28]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[28]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][28]_i_2 
       (.I0(cycle_r_reg[28]),
        .I1(\hex_r_reg[1][31]_1 [28]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][29]_i_1 
       (.I0(\hex_r[1][29]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [29]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[29]));
  LUT5 #(
    .INIT(32'hFFFFFFAE)) 
    \hex_r[1][29]_i_10 
       (.I0(\hex_r_reg[1][31]_0 [23]),
        .I1(\hex_r_reg[1][31]_0 [21]),
        .I2(\hex_r_reg[1][31]_0 [22]),
        .I3(\hex_r_reg[1][31]_0 [20]),
        .I4(\hex_r_reg[1][31]_0 [19]),
        .O(\hex_r[1][29]_i_10_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFAE)) 
    \hex_r[1][29]_i_11 
       (.I0(\hex_r_reg[1][31]_0 [26]),
        .I1(\hex_r_reg[1][31]_0 [24]),
        .I2(\hex_r_reg[1][31]_0 [25]),
        .I3(\hex_r_reg[1][31]_0 [23]),
        .I4(\hex_r_reg[1][31]_0 [22]),
        .O(\hex_r[1][29]_i_11_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFAE)) 
    \hex_r[1][29]_i_12 
       (.I0(\hex_r_reg[1][31]_0 [17]),
        .I1(\hex_r_reg[1][31]_0 [15]),
        .I2(\hex_r_reg[1][31]_0 [16]),
        .I3(\hex_r_reg[1][31]_0 [14]),
        .I4(\hex_r_reg[1][31]_0 [13]),
        .O(\hex_r[1][29]_i_12_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFAE)) 
    \hex_r[1][29]_i_13 
       (.I0(\hex_r_reg[1][31]_0 [20]),
        .I1(\hex_r_reg[1][31]_0 [18]),
        .I2(\hex_r_reg[1][31]_0 [19]),
        .I3(\hex_r_reg[1][31]_0 [17]),
        .I4(\hex_r_reg[1][31]_0 [16]),
        .O(\hex_r[1][29]_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'hA0C0)) 
    \hex_r[1][29]_i_2 
       (.I0(cycle_r_reg[29]),
        .I1(\hex_r_reg[1][31]_1 [29]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\hex_r[1][29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    \hex_r[1][29]_i_3 
       (.I0(\FSM_sequential_state_r_reg[1]_1 ),
        .I1(\hex_r_reg[1][31]_0 [30]),
        .I2(\hex_r_reg[1][31]_0 [31]),
        .I3(\hex_r[1][29]_i_7_n_0 ),
        .I4(\hex_r_reg[1][31]_0 [29]),
        .I5(\hex_r_reg[1][31]_0 [28]),
        .O(\hex_r[1][29]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \hex_r[1][29]_i_4 
       (.I0(\hex_r_reg[1][31]_0 [9]),
        .I1(\hex_r_reg[1][31]_0 [11]),
        .I2(\hex_r_reg[1][31]_0 [10]),
        .I3(\hex_r[1][29]_i_8_n_0 ),
        .I4(\hex_r[1][29]_i_9_n_0 ),
        .O(\hex_r[1][29]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \hex_r[1][29]_i_5 
       (.I0(\hex_r[1][29]_i_10_n_0 ),
        .I1(\hex_r[1][29]_i_11_n_0 ),
        .I2(\hex_r[1][29]_i_12_n_0 ),
        .I3(\hex_r[1][29]_i_13_n_0 ),
        .O(\hex_r[1][29]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \hex_r[1][29]_i_6 
       (.I0(\hex_r_reg[1][31]_0 [30]),
        .I1(\hex_r_reg[1][31]_0 [31]),
        .I2(\hex_r[1][29]_i_7_n_0 ),
        .I3(\hex_r_reg[1][31]_0 [29]),
        .I4(\hex_r_reg[1][31]_0 [28]),
        .I5(\FSM_sequential_state_r_reg[1]_1 ),
        .O(\hex_r[1][29]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'hFFFFFFAE)) 
    \hex_r[1][29]_i_7 
       (.I0(\hex_r_reg[1][31]_0 [29]),
        .I1(\hex_r_reg[1][31]_0 [27]),
        .I2(\hex_r_reg[1][31]_0 [28]),
        .I3(\hex_r_reg[1][31]_0 [26]),
        .I4(\hex_r_reg[1][31]_0 [25]),
        .O(\hex_r[1][29]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFEFFFEFFFFFFFE)) 
    \hex_r[1][29]_i_8 
       (.I0(\hex_r_reg[1][31]_0 [1]),
        .I1(\hex_r_reg[1][31]_0 [0]),
        .I2(\hex_r_reg[1][31]_0 [2]),
        .I3(\hex_r_reg[1][31]_0 [14]),
        .I4(\hex_r_reg[1][31]_0 [12]),
        .I5(\hex_r_reg[1][31]_0 [13]),
        .O(\hex_r[1][29]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \hex_r[1][29]_i_9 
       (.I0(\hex_r_reg[1][31]_0 [7]),
        .I1(\hex_r_reg[1][31]_0 [6]),
        .I2(\hex_r_reg[1][31]_0 [8]),
        .I3(\hex_r_reg[1][31]_0 [4]),
        .I4(\hex_r_reg[1][31]_0 [5]),
        .I5(\hex_r_reg[1][31]_0 [3]),
        .O(\hex_r[1][29]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][2]_i_1 
       (.I0(\hex_r[1][2]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [2]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[2]));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][2]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [2]),
        .I1(\hex_r_reg[1][31]_1 [2]),
        .I2(cycle_r_reg[2]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFFAEAFAEFAAEAAA)) 
    \hex_r[1][30]_i_1 
       (.I0(\hex_r[1][30]_i_2_n_0 ),
        .I1(cycle_r_reg[30]),
        .I2(Q[4]),
        .I3(Q[1]),
        .I4(\hex_r_reg[1][31]_0 [30]),
        .I5(\hex_r_reg[1][31]_1 [30]),
        .O(prints_hex_w[30]));
  LUT6 #(
    .INIT(64'h0200020002000000)) 
    \hex_r[1][30]_i_2 
       (.I0(\FSM_sequential_state_r_reg[1]_1 ),
        .I1(\hex_r[1][31]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [31]),
        .I3(\hex_r_reg[1][31]_0 [30]),
        .I4(\hex_r[1][29]_i_4_n_0 ),
        .I5(\hex_r[1][31]_i_4_n_0 ),
        .O(\hex_r[1][30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFFAEAFAEFAAEAAA)) 
    \hex_r[1][31]_i_1 
       (.I0(\hex_r[1][31]_i_2_n_0 ),
        .I1(cycle_r_reg[31]),
        .I2(Q[4]),
        .I3(Q[1]),
        .I4(\hex_r_reg[1][31]_0 [31]),
        .I5(\hex_r_reg[1][31]_1 [31]),
        .O(prints_hex_w[31]));
  LUT6 #(
    .INIT(64'h0200020002000000)) 
    \hex_r[1][31]_i_2 
       (.I0(\FSM_sequential_state_r_reg[1]_1 ),
        .I1(\hex_r[1][31]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [30]),
        .I3(\hex_r_reg[1][31]_0 [31]),
        .I4(\hex_r[1][29]_i_4_n_0 ),
        .I5(\hex_r[1][31]_i_4_n_0 ),
        .O(\hex_r[1][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \hex_r[1][31]_i_3 
       (.I0(\hex_r_reg[1][31]_0 [28]),
        .I1(\hex_r_reg[1][31]_0 [29]),
        .O(\hex_r[1][31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFFFEFE)) 
    \hex_r[1][31]_i_4 
       (.I0(\hex_r[1][29]_i_5_n_0 ),
        .I1(\hex_r_reg[1][31]_0 [25]),
        .I2(\hex_r_reg[1][31]_0 [26]),
        .I3(\hex_r_reg[1][31]_0 [28]),
        .I4(\hex_r_reg[1][31]_0 [27]),
        .I5(\hex_r_reg[1][31]_0 [29]),
        .O(\hex_r[1][31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][3]_i_1 
       (.I0(\hex_r[1][3]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [3]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[3]));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][3]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [3]),
        .I1(\hex_r_reg[1][31]_1 [3]),
        .I2(cycle_r_reg[3]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF1F0FFF0F1F0)) 
    \hex_r[1][4]_i_1 
       (.I0(\hex_r[1][29]_i_4_n_0 ),
        .I1(\hex_r[1][29]_i_5_n_0 ),
        .I2(\hex_r[1][4]_i_2_n_0 ),
        .I3(\hex_r[1][29]_i_3_n_0 ),
        .I4(\hex_r_reg[1][31]_0 [4]),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[4]));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][4]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [4]),
        .I1(\hex_r_reg[1][31]_1 [4]),
        .I2(cycle_r_reg[4]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF1F0FFF0F1F0)) 
    \hex_r[1][5]_i_1 
       (.I0(\hex_r[1][29]_i_4_n_0 ),
        .I1(\hex_r[1][29]_i_5_n_0 ),
        .I2(\hex_r[1][5]_i_2_n_0 ),
        .I3(\hex_r[1][29]_i_3_n_0 ),
        .I4(\hex_r_reg[1][31]_0 [5]),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[5]));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][5]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [5]),
        .I1(\hex_r_reg[1][31]_1 [5]),
        .I2(cycle_r_reg[5]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF1F0FFF0F1F0)) 
    \hex_r[1][6]_i_1 
       (.I0(\hex_r[1][29]_i_4_n_0 ),
        .I1(\hex_r[1][29]_i_5_n_0 ),
        .I2(\hex_r[1][6]_i_2_n_0 ),
        .I3(\hex_r[1][29]_i_3_n_0 ),
        .I4(\hex_r_reg[1][31]_0 [6]),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[6]));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][6]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [6]),
        .I1(\hex_r_reg[1][31]_1 [6]),
        .I2(cycle_r_reg[6]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF1F0FFF0F1F0)) 
    \hex_r[1][7]_i_1 
       (.I0(\hex_r[1][29]_i_4_n_0 ),
        .I1(\hex_r[1][29]_i_5_n_0 ),
        .I2(\hex_r[1][7]_i_2_n_0 ),
        .I3(\hex_r[1][29]_i_3_n_0 ),
        .I4(\hex_r_reg[1][31]_0 [7]),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[7]));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][7]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [7]),
        .I1(\hex_r_reg[1][31]_1 [7]),
        .I2(cycle_r_reg[7]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF1F0FFF0F1F0)) 
    \hex_r[1][8]_i_1 
       (.I0(\hex_r[1][29]_i_4_n_0 ),
        .I1(\hex_r[1][29]_i_5_n_0 ),
        .I2(\hex_r[1][8]_i_2_n_0 ),
        .I3(\hex_r[1][29]_i_3_n_0 ),
        .I4(\hex_r_reg[1][31]_0 [8]),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[8]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][8]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [8]),
        .I1(\hex_r_reg[1][31]_1 [8]),
        .I2(cycle_r_reg[8]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFAFAFAFAEAEAEAAA)) 
    \hex_r[1][9]_i_1 
       (.I0(\hex_r[1][9]_i_2_n_0 ),
        .I1(\hex_r[1][29]_i_3_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [9]),
        .I3(\hex_r[1][29]_i_4_n_0 ),
        .I4(\hex_r[1][29]_i_5_n_0 ),
        .I5(\hex_r[1][29]_i_6_n_0 ),
        .O(prints_hex_w[9]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \hex_r[1][9]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [9]),
        .I1(\hex_r_reg[1][31]_1 [9]),
        .I2(cycle_r_reg[9]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[1][9]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT4 #(
    .INIT(16'hAA03)) 
    \hex_r[2][0]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [0]),
        .I1(\hex_r_reg[1][12]_0 [0]),
        .I2(Q[1]),
        .I3(Q[4]),
        .O(\hex_r[2][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][10]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [10]),
        .I1(Q[4]),
        .O(\hex_r[2][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][11]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [11]),
        .I1(Q[4]),
        .O(\hex_r[2][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][12]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [12]),
        .I1(Q[4]),
        .O(\hex_r[2][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][13]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [13]),
        .I1(Q[4]),
        .O(\hex_r[2][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][14]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [14]),
        .I1(Q[4]),
        .O(\hex_r[2][14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][15]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [15]),
        .I1(Q[4]),
        .O(\hex_r[2][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][16]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [16]),
        .I1(Q[4]),
        .O(\hex_r[2][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][17]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [17]),
        .I1(Q[4]),
        .O(\hex_r[2][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][18]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [18]),
        .I1(Q[4]),
        .O(\hex_r[2][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][19]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [19]),
        .I1(Q[4]),
        .O(\hex_r[2][19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAAAA00C3)) 
    \hex_r[2][1]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [1]),
        .I1(\hex_r_reg[1][12]_0 [1]),
        .I2(\hex_r_reg[1][12]_0 [0]),
        .I3(Q[1]),
        .I4(Q[4]),
        .O(\hex_r[2][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][20]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [20]),
        .I1(Q[4]),
        .O(\hex_r[2][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][21]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [21]),
        .I1(Q[4]),
        .O(\hex_r[2][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][22]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [22]),
        .I1(Q[4]),
        .O(\hex_r[2][22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][23]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [23]),
        .I1(Q[4]),
        .O(\hex_r[2][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][24]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [24]),
        .I1(Q[4]),
        .O(\hex_r[2][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][25]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [25]),
        .I1(Q[4]),
        .O(\hex_r[2][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][26]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [26]),
        .I1(Q[4]),
        .O(\hex_r[2][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][27]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [27]),
        .I1(Q[4]),
        .O(\hex_r[2][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][28]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [28]),
        .I1(Q[4]),
        .O(\hex_r[2][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][29]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [29]),
        .I1(Q[4]),
        .O(\hex_r[2][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'hAA03)) 
    \hex_r[2][2]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [2]),
        .I1(\addr_r_reg[2] ),
        .I2(Q[1]),
        .I3(Q[4]),
        .O(\hex_r[2][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \hex_r[2][2]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [2]),
        .I1(\hex_r_reg[1][12]_0 [0]),
        .I2(\hex_r_reg[1][12]_0 [1]),
        .O(\addr_r_reg[2] ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][30]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [30]),
        .I1(Q[4]),
        .O(\hex_r[2][30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \hex_r[2][31]_i_1 
       (.I0(rst_n),
        .I1(state_r[1]),
        .I2(state_r[0]),
        .I3(\hex_r_reg[1][12]_0 [3]),
        .I4(\hex_r_reg[1][12]_0 [2]),
        .I5(\FSM_sequential_state_r_reg[1]_0 ),
        .O(\hex_r[2][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][31]_i_2 
       (.I0(\hex_r_reg[2][31]_0 [31]),
        .I1(Q[4]),
        .O(\hex_r[2][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'hAA03)) 
    \hex_r[2][3]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [3]),
        .I1(\addr_r_reg[1] ),
        .I2(Q[1]),
        .I3(Q[4]),
        .O(\hex_r[2][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'h699C)) 
    \hex_r[2][3]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [1]),
        .I1(\hex_r_reg[1][12]_0 [3]),
        .I2(\hex_r_reg[1][12]_0 [0]),
        .I3(\hex_r_reg[1][12]_0 [2]),
        .O(\addr_r_reg[1] ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'hCACF)) 
    \hex_r[2][4]_i_1 
       (.I0(Q[1]),
        .I1(\hex_r_reg[2][31]_0 [4]),
        .I2(Q[4]),
        .I3(\addr_r_reg[2]_1 ),
        .O(\hex_r[2][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'h522B)) 
    \hex_r[2][4]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [2]),
        .I1(\hex_r_reg[1][12]_0 [0]),
        .I2(\hex_r_reg[1][12]_0 [3]),
        .I3(\hex_r_reg[1][12]_0 [1]),
        .O(\addr_r_reg[2]_1 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'hCACF)) 
    \hex_r[2][5]_i_1 
       (.I0(Q[1]),
        .I1(\hex_r_reg[2][31]_0 [5]),
        .I2(Q[4]),
        .I3(\addr_r_reg[2]_0 ),
        .O(\hex_r[2][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'h1A)) 
    \hex_r[2][5]_i_2 
       (.I0(\hex_r_reg[1][12]_0 [2]),
        .I1(\hex_r_reg[1][12]_0 [1]),
        .I2(\hex_r_reg[1][12]_0 [3]),
        .O(\addr_r_reg[2]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFF00F1F1)) 
    \hex_r[2][6]_i_1 
       (.I0(\hex_r_reg[1][12]_0 [2]),
        .I1(\hex_r_reg[1][12]_0 [3]),
        .I2(Q[1]),
        .I3(\hex_r_reg[2][31]_0 [6]),
        .I4(Q[4]),
        .O(\hex_r[2][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'hAFAC)) 
    \hex_r[2][7]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [7]),
        .I1(Q[1]),
        .I2(Q[4]),
        .I3(in7),
        .O(\hex_r[2][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'hAFAC)) 
    \hex_r[2][8]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [8]),
        .I1(Q[1]),
        .I2(Q[4]),
        .I3(in7),
        .O(\hex_r[2][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \hex_r[2][9]_i_1 
       (.I0(\hex_r_reg[2][31]_0 [9]),
        .I1(Q[4]),
        .O(\hex_r[2][9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][0]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [0]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [0]),
        .O(\hex_r[3][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][10]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [10]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [10]),
        .O(\hex_r[3][10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][11]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [11]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [11]),
        .O(\hex_r[3][11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][12]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [12]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [12]),
        .O(\hex_r[3][12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][13]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [13]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [13]),
        .O(\hex_r[3][13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][14]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [14]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [14]),
        .O(\hex_r[3][14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][15]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [15]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [15]),
        .O(\hex_r[3][15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][16]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [16]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [16]),
        .O(\hex_r[3][16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][17]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [17]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [17]),
        .O(\hex_r[3][17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][18]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [18]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [18]),
        .O(\hex_r[3][18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][19]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [19]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [19]),
        .O(\hex_r[3][19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][1]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [1]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [1]),
        .O(\hex_r[3][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][20]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [20]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [20]),
        .O(\hex_r[3][20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][21]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [21]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [21]),
        .O(\hex_r[3][21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][22]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [22]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [22]),
        .O(\hex_r[3][22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][23]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [23]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [23]),
        .O(\hex_r[3][23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][24]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [24]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [24]),
        .O(\hex_r[3][24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][25]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [25]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [25]),
        .O(\hex_r[3][25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][26]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [26]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [26]),
        .O(\hex_r[3][26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][27]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [27]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [27]),
        .O(\hex_r[3][27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][28]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [28]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [28]),
        .O(\hex_r[3][28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][29]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [29]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [29]),
        .O(\hex_r[3][29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][2]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [2]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [2]),
        .O(\hex_r[3][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][30]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [30]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [30]),
        .O(\hex_r[3][30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][31]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [31]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [31]),
        .O(\hex_r[3][31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][3]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [3]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [3]),
        .O(\hex_r[3][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][4]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [4]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [4]),
        .O(\hex_r[3][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][5]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [5]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [5]),
        .O(\hex_r[3][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][6]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [6]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [6]),
        .O(\hex_r[3][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][7]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [7]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [7]),
        .O(\hex_r[3][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][8]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [8]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [8]),
        .O(\hex_r[3][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \hex_r[3][9]_i_1 
       (.I0(\hex_r_reg[3][31]_0 [9]),
        .I1(Q[4]),
        .I2(\hex_r_reg[3][31]_1 [9]),
        .O(\hex_r[3][9]_i_1_n_0 ));
  FDRE \hex_r_reg[1][0] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[0]),
        .Q(\hex_r_reg[1]_3 [0]),
        .R(1'b0));
  FDRE \hex_r_reg[1][10] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[10]),
        .Q(\hex_r_reg[1]_3 [10]),
        .R(1'b0));
  FDRE \hex_r_reg[1][11] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[11]),
        .Q(\hex_r_reg[1]_3 [11]),
        .R(1'b0));
  FDRE \hex_r_reg[1][12] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[12]),
        .Q(\hex_r_reg[1]_3 [12]),
        .R(1'b0));
  FDRE \hex_r_reg[1][13] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[13]),
        .Q(\hex_r_reg[1]_3 [13]),
        .R(1'b0));
  FDRE \hex_r_reg[1][14] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[14]),
        .Q(\hex_r_reg[1]_3 [14]),
        .R(1'b0));
  FDRE \hex_r_reg[1][15] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[15]),
        .Q(\hex_r_reg[1]_3 [15]),
        .R(1'b0));
  FDRE \hex_r_reg[1][16] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[16]),
        .Q(\hex_r_reg[1]_3 [16]),
        .R(1'b0));
  FDRE \hex_r_reg[1][17] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[17]),
        .Q(\hex_r_reg[1]_3 [17]),
        .R(1'b0));
  FDRE \hex_r_reg[1][18] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[18]),
        .Q(\hex_r_reg[1]_3 [18]),
        .R(1'b0));
  FDRE \hex_r_reg[1][19] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[19]),
        .Q(\hex_r_reg[1]_3 [19]),
        .R(1'b0));
  FDRE \hex_r_reg[1][1] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[1]),
        .Q(\hex_r_reg[1]_3 [1]),
        .R(1'b0));
  FDRE \hex_r_reg[1][20] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[20]),
        .Q(\hex_r_reg[1]_3 [20]),
        .R(1'b0));
  FDRE \hex_r_reg[1][21] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[21]),
        .Q(\hex_r_reg[1]_3 [21]),
        .R(1'b0));
  FDRE \hex_r_reg[1][22] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[22]),
        .Q(\hex_r_reg[1]_3 [22]),
        .R(1'b0));
  FDRE \hex_r_reg[1][23] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[23]),
        .Q(\hex_r_reg[1]_3 [23]),
        .R(1'b0));
  FDRE \hex_r_reg[1][24] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[24]),
        .Q(\hex_r_reg[1]_3 [24]),
        .R(1'b0));
  FDRE \hex_r_reg[1][25] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[25]),
        .Q(\hex_r_reg[1]_3 [25]),
        .R(1'b0));
  FDRE \hex_r_reg[1][26] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[26]),
        .Q(\hex_r_reg[1]_3 [26]),
        .R(1'b0));
  FDRE \hex_r_reg[1][27] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[27]),
        .Q(\hex_r_reg[1]_3 [27]),
        .R(1'b0));
  FDRE \hex_r_reg[1][28] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[28]),
        .Q(\hex_r_reg[1]_3 [28]),
        .R(1'b0));
  FDRE \hex_r_reg[1][29] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[29]),
        .Q(\hex_r_reg[1]_3 [29]),
        .R(1'b0));
  FDRE \hex_r_reg[1][2] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[2]),
        .Q(\hex_r_reg[1]_3 [2]),
        .R(1'b0));
  FDRE \hex_r_reg[1][30] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[30]),
        .Q(\hex_r_reg[1]_3 [30]),
        .R(1'b0));
  FDRE \hex_r_reg[1][31] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[31]),
        .Q(\hex_r_reg[1]_3 [31]),
        .R(1'b0));
  FDRE \hex_r_reg[1][3] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[3]),
        .Q(\hex_r_reg[1]_3 [3]),
        .R(1'b0));
  FDRE \hex_r_reg[1][4] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[4]),
        .Q(\hex_r_reg[1]_3 [4]),
        .R(1'b0));
  FDRE \hex_r_reg[1][5] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[5]),
        .Q(\hex_r_reg[1]_3 [5]),
        .R(1'b0));
  FDRE \hex_r_reg[1][6] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[6]),
        .Q(\hex_r_reg[1]_3 [6]),
        .R(1'b0));
  FDRE \hex_r_reg[1][7] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[7]),
        .Q(\hex_r_reg[1]_3 [7]),
        .R(1'b0));
  FDRE \hex_r_reg[1][8] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[8]),
        .Q(\hex_r_reg[1]_3 [8]),
        .R(1'b0));
  FDRE \hex_r_reg[1][9] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(prints_hex_w[9]),
        .Q(\hex_r_reg[1]_3 [9]),
        .R(1'b0));
  FDRE \hex_r_reg[2][0] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][0]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [0]),
        .R(1'b0));
  FDSE \hex_r_reg[2][10] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][10]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [10]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][11] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][11]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [11]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][12] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][12]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [12]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][13] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][13]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [13]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][14] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][14]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [14]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][15] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][15]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [15]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][16] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][16]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [16]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][17] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][17]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [17]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][18] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][18]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [18]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][19] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][19]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [19]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDRE \hex_r_reg[2][1] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][1]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [1]),
        .R(1'b0));
  FDSE \hex_r_reg[2][20] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][20]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [20]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][21] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][21]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [21]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][22] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][22]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [22]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][23] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][23]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [23]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][24] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][24]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [24]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][25] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][25]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [25]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][26] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][26]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [26]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][27] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][27]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [27]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][28] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][28]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [28]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][29] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][29]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [29]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDRE \hex_r_reg[2][2] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][2]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [2]),
        .R(1'b0));
  FDSE \hex_r_reg[2][30] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][30]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [30]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDSE \hex_r_reg[2][31] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][31]_i_2_n_0 ),
        .Q(\hex_r_reg[2]_2 [31]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDRE \hex_r_reg[2][3] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][3]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [3]),
        .R(1'b0));
  FDRE \hex_r_reg[2][4] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][4]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [4]),
        .R(1'b0));
  FDRE \hex_r_reg[2][5] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][5]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [5]),
        .R(1'b0));
  FDRE \hex_r_reg[2][6] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][6]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [6]),
        .R(1'b0));
  FDRE \hex_r_reg[2][7] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][7]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [7]),
        .R(1'b0));
  FDRE \hex_r_reg[2][8] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][8]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [8]),
        .R(1'b0));
  FDSE \hex_r_reg[2][9] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[2][9]_i_1_n_0 ),
        .Q(\hex_r_reg[2]_2 [9]),
        .S(\hex_r[2][31]_i_1_n_0 ));
  FDRE \hex_r_reg[3][0] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][0]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [0]),
        .R(1'b0));
  FDRE \hex_r_reg[3][10] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][10]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [10]),
        .R(1'b0));
  FDRE \hex_r_reg[3][11] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][11]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [11]),
        .R(1'b0));
  FDRE \hex_r_reg[3][12] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][12]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [12]),
        .R(1'b0));
  FDRE \hex_r_reg[3][13] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][13]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [13]),
        .R(1'b0));
  FDRE \hex_r_reg[3][14] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][14]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [14]),
        .R(1'b0));
  FDRE \hex_r_reg[3][15] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][15]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [15]),
        .R(1'b0));
  FDRE \hex_r_reg[3][16] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][16]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [16]),
        .R(1'b0));
  FDRE \hex_r_reg[3][17] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][17]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [17]),
        .R(1'b0));
  FDRE \hex_r_reg[3][18] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][18]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [18]),
        .R(1'b0));
  FDRE \hex_r_reg[3][19] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][19]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [19]),
        .R(1'b0));
  FDRE \hex_r_reg[3][1] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][1]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [1]),
        .R(1'b0));
  FDRE \hex_r_reg[3][20] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][20]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [20]),
        .R(1'b0));
  FDRE \hex_r_reg[3][21] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][21]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [21]),
        .R(1'b0));
  FDRE \hex_r_reg[3][22] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][22]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [22]),
        .R(1'b0));
  FDRE \hex_r_reg[3][23] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][23]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [23]),
        .R(1'b0));
  FDRE \hex_r_reg[3][24] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][24]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [24]),
        .R(1'b0));
  FDRE \hex_r_reg[3][25] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][25]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [25]),
        .R(1'b0));
  FDRE \hex_r_reg[3][26] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][26]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [26]),
        .R(1'b0));
  FDRE \hex_r_reg[3][27] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][27]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [27]),
        .R(1'b0));
  FDRE \hex_r_reg[3][28] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][28]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [28]),
        .R(1'b0));
  FDRE \hex_r_reg[3][29] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][29]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [29]),
        .R(1'b0));
  FDRE \hex_r_reg[3][2] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][2]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [2]),
        .R(1'b0));
  FDRE \hex_r_reg[3][30] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][30]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [30]),
        .R(1'b0));
  FDRE \hex_r_reg[3][31] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][31]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [31]),
        .R(1'b0));
  FDRE \hex_r_reg[3][3] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][3]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [3]),
        .R(1'b0));
  FDRE \hex_r_reg[3][4] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][4]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [4]),
        .R(1'b0));
  FDRE \hex_r_reg[3][5] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][5]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [5]),
        .R(1'b0));
  FDRE \hex_r_reg[3][6] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][6]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [6]),
        .R(1'b0));
  FDRE \hex_r_reg[3][7] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][7]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [7]),
        .R(1'b0));
  FDRE \hex_r_reg[3][8] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][8]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [8]),
        .R(1'b0));
  FDRE \hex_r_reg[3][9] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r[3][9]_i_1_n_0 ),
        .Q(\hex_r_reg[3]_1 [9]),
        .R(1'b0));
  FDRE \hex_r_reg[4][0] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [0]),
        .Q(\hex_r_reg[4]_0 [0]),
        .R(1'b0));
  FDRE \hex_r_reg[4][10] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [10]),
        .Q(\hex_r_reg[4]_0 [10]),
        .R(1'b0));
  FDRE \hex_r_reg[4][11] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [11]),
        .Q(\hex_r_reg[4]_0 [11]),
        .R(1'b0));
  FDRE \hex_r_reg[4][12] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [12]),
        .Q(\hex_r_reg[4]_0 [12]),
        .R(1'b0));
  FDRE \hex_r_reg[4][13] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [13]),
        .Q(\hex_r_reg[4]_0 [13]),
        .R(1'b0));
  FDRE \hex_r_reg[4][14] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [14]),
        .Q(\hex_r_reg[4]_0 [14]),
        .R(1'b0));
  FDRE \hex_r_reg[4][15] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [15]),
        .Q(\hex_r_reg[4]_0 [15]),
        .R(1'b0));
  FDRE \hex_r_reg[4][16] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [16]),
        .Q(\hex_r_reg[4]_0 [16]),
        .R(1'b0));
  FDRE \hex_r_reg[4][17] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [17]),
        .Q(\hex_r_reg[4]_0 [17]),
        .R(1'b0));
  FDRE \hex_r_reg[4][18] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [18]),
        .Q(\hex_r_reg[4]_0 [18]),
        .R(1'b0));
  FDRE \hex_r_reg[4][19] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [19]),
        .Q(\hex_r_reg[4]_0 [19]),
        .R(1'b0));
  FDRE \hex_r_reg[4][1] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [1]),
        .Q(\hex_r_reg[4]_0 [1]),
        .R(1'b0));
  FDRE \hex_r_reg[4][20] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [20]),
        .Q(\hex_r_reg[4]_0 [20]),
        .R(1'b0));
  FDRE \hex_r_reg[4][21] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [21]),
        .Q(\hex_r_reg[4]_0 [21]),
        .R(1'b0));
  FDRE \hex_r_reg[4][22] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [22]),
        .Q(\hex_r_reg[4]_0 [22]),
        .R(1'b0));
  FDRE \hex_r_reg[4][23] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [23]),
        .Q(\hex_r_reg[4]_0 [23]),
        .R(1'b0));
  FDRE \hex_r_reg[4][24] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [24]),
        .Q(\hex_r_reg[4]_0 [24]),
        .R(1'b0));
  FDRE \hex_r_reg[4][25] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [25]),
        .Q(\hex_r_reg[4]_0 [25]),
        .R(1'b0));
  FDRE \hex_r_reg[4][26] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [26]),
        .Q(\hex_r_reg[4]_0 [26]),
        .R(1'b0));
  FDRE \hex_r_reg[4][27] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [27]),
        .Q(\hex_r_reg[4]_0 [27]),
        .R(1'b0));
  FDRE \hex_r_reg[4][28] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [28]),
        .Q(\hex_r_reg[4]_0 [28]),
        .R(1'b0));
  FDRE \hex_r_reg[4][29] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [29]),
        .Q(\hex_r_reg[4]_0 [29]),
        .R(1'b0));
  FDRE \hex_r_reg[4][2] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [2]),
        .Q(\hex_r_reg[4]_0 [2]),
        .R(1'b0));
  FDRE \hex_r_reg[4][30] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [30]),
        .Q(\hex_r_reg[4]_0 [30]),
        .R(1'b0));
  FDRE \hex_r_reg[4][31] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [31]),
        .Q(\hex_r_reg[4]_0 [31]),
        .R(1'b0));
  FDRE \hex_r_reg[4][3] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [3]),
        .Q(\hex_r_reg[4]_0 [3]),
        .R(1'b0));
  FDRE \hex_r_reg[4][4] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [4]),
        .Q(\hex_r_reg[4]_0 [4]),
        .R(1'b0));
  FDRE \hex_r_reg[4][5] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [5]),
        .Q(\hex_r_reg[4]_0 [5]),
        .R(1'b0));
  FDRE \hex_r_reg[4][6] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [6]),
        .Q(\hex_r_reg[4]_0 [6]),
        .R(1'b0));
  FDRE \hex_r_reg[4][7] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [7]),
        .Q(\hex_r_reg[4]_0 [7]),
        .R(1'b0));
  FDRE \hex_r_reg[4][8] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [8]),
        .Q(\hex_r_reg[4]_0 [8]),
        .R(1'b0));
  FDRE \hex_r_reg[4][9] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\hex_r_reg[4][31]_0 [9]),
        .Q(\hex_r_reg[4]_0 [9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \mem_din_o[7]_INST_0_i_1 
       (.I0(\hex_r_reg[1][12]_0 [3]),
        .I1(\hex_r_reg[1][12]_0 [2]),
        .O(in7));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'h8F)) 
    \string_r[120]_i_1 
       (.I0(prints_string_w),
        .I1(Q[3]),
        .I2(Q[1]),
        .O(\string_r[120]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \string_r[121]_i_1 
       (.I0(Q[3]),
        .I1(prints_string_w),
        .O(\string_r[121]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \string_r[129]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .O(\string_r[129]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \string_r[130]_i_1 
       (.I0(prints_string_w),
        .I1(Q[4]),
        .O(\string_r[130]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \string_r[131]_i_1 
       (.I0(Q[4]),
        .I1(prints_string_w),
        .O(\string_r[131]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \string_r[134]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .O(\string_r[134]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h2F)) 
    \string_r[145]_i_1 
       (.I0(Q[3]),
        .I1(prints_string_w),
        .I2(Q[1]),
        .O(\string_r[145]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \string_r[160]_i_1 
       (.I0(Q[0]),
        .O(string_i[0]));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \string_r[162]_i_1 
       (.I0(Q[3]),
        .I1(prints_string_w),
        .O(\string_r[162]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'h8F)) 
    \string_r[174]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[174]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \string_r[176]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[176]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'hB380)) 
    \string_r[178]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(Q[4]),
        .O(\string_r[178]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'h7340)) 
    \string_r[180]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(Q[4]),
        .O(\string_r[180]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \string_r[189]_i_1 
       (.I0(Q[1]),
        .I1(Q[3]),
        .O(\string_r[189]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hB0)) 
    \string_r[192]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[192]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \string_r[194]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .O(\string_r[194]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'h0D)) 
    \string_r[197]_i_1 
       (.I0(Q[3]),
        .I1(Q[1]),
        .I2(Q[0]),
        .O(\string_r[197]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \string_r[200]_i_1 
       (.I0(Q[0]),
        .I1(Q[4]),
        .O(\string_r[200]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \string_r[201]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[201]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hBC)) 
    \string_r[202]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[202]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \string_r[217]_i_1 
       (.I0(Q[1]),
        .I1(Q[3]),
        .O(\string_r[217]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'h70)) 
    \string_r[224]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[224]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \string_r[225]_i_1 
       (.I0(Q[1]),
        .O(\string_r[225]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \string_r[232]_i_1 
       (.I0(Q[1]),
        .I1(Q[3]),
        .O(\string_r[232]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \string_r[240]_i_1 
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(prints_string_w),
        .O(\string_r[240]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hBE)) 
    \string_r[245]_i_1 
       (.I0(Q[0]),
        .I1(Q[4]),
        .I2(Q[1]),
        .O(\string_r[245]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'h007C)) 
    \string_r[248]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(Q[0]),
        .O(\string_r[248]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'h54)) 
    \string_r[251]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[251]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \string_r[264]_i_1 
       (.I0(Q[1]),
        .I1(Q[4]),
        .O(\FSM_sequential_state_r_reg[1]_1 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    \string_r[265]_i_1 
       (.I0(Q[1]),
        .I1(Q[4]),
        .I2(Q[0]),
        .O(\string_r[265]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \string_r[272]_i_1 
       (.I0(Q[1]),
        .I1(Q[4]),
        .O(\FSM_sequential_state_r_reg[1]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \string_r[273]_i_1 
       (.I0(Q[1]),
        .I1(Q[3]),
        .O(\string_r[273]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \string_r[274]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\string_r[274]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hE2)) 
    \string_r[281]_i_1 
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[281]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \string_r[282]_i_1 
       (.I0(Q[1]),
        .I1(Q[4]),
        .O(\string_r[282]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \string_r[288]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[288]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h007F)) 
    \string_r[291]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(Q[0]),
        .O(\string_r[291]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0200)) 
    \string_r[293]_i_1 
       (.I0(rst_n),
        .I1(state_r[1]),
        .I2(state_r[0]),
        .I3(Q[0]),
        .O(\string_r[293]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hCC80)) 
    \string_r[297]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(Q[4]),
        .O(\string_r[297]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'hFF2F)) 
    \string_r[299]_i_1 
       (.I0(Q[3]),
        .I1(prints_string_w),
        .I2(Q[1]),
        .I3(Q[0]),
        .O(\string_r[299]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \string_r[304]_i_1 
       (.I0(Q[1]),
        .I1(Q[3]),
        .O(\string_r[304]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \string_r[306]_i_1 
       (.I0(Q[4]),
        .I1(Q[1]),
        .O(string_i[1]));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \string_r[312]_i_1 
       (.I0(Q[3]),
        .I1(Q[1]),
        .O(\string_r[312]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \string_r[313]_i_1 
       (.I0(prints_string_w),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(\string_r[313]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'hCDFC)) 
    \string_r[314]_i_1 
       (.I0(prints_string_w),
        .I1(Q[0]),
        .I2(Q[4]),
        .I3(Q[1]),
        .O(\string_r[314]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    \string_r[316]_i_1 
       (.I0(rst_n),
        .I1(state_r[1]),
        .I2(state_r[0]),
        .O(\string_r[316]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \string_r[316]_i_10 
       (.I0(\hex_r_reg[1][31]_0 [11]),
        .I1(\hex_r_reg[1][31]_0 [10]),
        .I2(\hex_r_reg[1][31]_0 [9]),
        .I3(\hex_r_reg[1][31]_0 [8]),
        .O(\string_r[316]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'hFF8F)) 
    \string_r[316]_i_2 
       (.I0(Q[3]),
        .I1(prints_string_w),
        .I2(Q[1]),
        .I3(Q[0]),
        .O(\string_r[316]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    \string_r[316]_i_3 
       (.I0(\string_r[316]_i_4_n_0 ),
        .I1(\string_r[316]_i_5_n_0 ),
        .I2(\hex_r_reg[1][31]_0 [17]),
        .I3(\hex_r_reg[1][31]_0 [26]),
        .I4(\hex_r_reg[1][31]_0 [29]),
        .I5(\string_r[316]_i_6_n_0 ),
        .O(prints_string_w));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \string_r[316]_i_4 
       (.I0(\string_r[316]_i_7_n_0 ),
        .I1(\hex_r_reg[1][31]_0 [1]),
        .I2(\hex_r_reg[1][31]_0 [0]),
        .I3(\hex_r_reg[1][31]_0 [3]),
        .I4(\hex_r_reg[1][31]_0 [2]),
        .I5(\string_r[316]_i_8_n_0 ),
        .O(\string_r[316]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \string_r[316]_i_5 
       (.I0(\hex_r_reg[1][31]_0 [23]),
        .I1(\hex_r_reg[1][31]_0 [20]),
        .I2(\hex_r_reg[1][31]_0 [25]),
        .I3(\hex_r_reg[1][31]_0 [22]),
        .O(\string_r[316]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \string_r[316]_i_6 
       (.I0(\hex_r_reg[1][31]_0 [18]),
        .I1(\hex_r_reg[1][31]_0 [21]),
        .I2(\hex_r_reg[1][31]_0 [16]),
        .I3(\hex_r_reg[1][31]_0 [19]),
        .I4(\string_r[316]_i_9_n_0 ),
        .O(\string_r[316]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \string_r[316]_i_7 
       (.I0(\hex_r_reg[1][31]_0 [7]),
        .I1(\hex_r_reg[1][31]_0 [6]),
        .I2(\hex_r_reg[1][31]_0 [5]),
        .I3(\hex_r_reg[1][31]_0 [4]),
        .O(\string_r[316]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \string_r[316]_i_8 
       (.I0(\hex_r_reg[1][31]_0 [12]),
        .I1(\hex_r_reg[1][31]_0 [13]),
        .I2(\hex_r_reg[1][31]_0 [14]),
        .I3(\hex_r_reg[1][31]_0 [15]),
        .I4(\string_r[316]_i_10_n_0 ),
        .O(\string_r[316]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \string_r[316]_i_9 
       (.I0(\hex_r_reg[1][31]_0 [27]),
        .I1(\hex_r_reg[1][31]_0 [24]),
        .I2(\hex_r_reg[1][31]_0 [30]),
        .I3(\hex_r_reg[1][31]_0 [31]),
        .I4(\hex_r_reg[1][31]_0 [28]),
        .O(\string_r[316]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \string_r[40]_i_1 
       (.I0(Q[3]),
        .O(\string_r[40]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \string_r[88]_i_1 
       (.I0(Q[3]),
        .I1(Q[4]),
        .O(\string_r[88]_i_1_n_0 ));
  FDRE \string_r_reg[104] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(Q[1]),
        .Q(data13),
        .R(1'b0));
  FDRE \string_r_reg[120] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[120]_i_1_n_0 ),
        .Q(data15[0]),
        .R(1'b0));
  FDRE \string_r_reg[121] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[121]_i_1_n_0 ),
        .Q(data15[1]),
        .R(1'b0));
  FDSE \string_r_reg[129] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[129]_i_1_n_0 ),
        .Q(data16[1]),
        .S(\string_r[293]_i_1_n_0 ));
  FDSE \string_r_reg[130] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[130]_i_1_n_0 ),
        .Q(data16[2]),
        .S(\string_r[293]_i_1_n_0 ));
  FDSE \string_r_reg[131] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[131]_i_1_n_0 ),
        .Q(data16[3]),
        .S(\string_r[293]_i_1_n_0 ));
  FDSE \string_r_reg[134] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[134]_i_1_n_0 ),
        .Q(data16[6]),
        .S(\string_r[293]_i_1_n_0 ));
  FDRE \string_r_reg[145] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[145]_i_1_n_0 ),
        .Q(data18),
        .R(1'b0));
  FDRE \string_r_reg[160] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(string_i[0]),
        .Q(data20[0]),
        .R(1'b0));
  FDRE \string_r_reg[162] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[162]_i_1_n_0 ),
        .Q(data20[2]),
        .R(1'b0));
  FDRE \string_r_reg[174] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[174]_i_1_n_0 ),
        .Q(data21),
        .R(1'b0));
  FDRE \string_r_reg[176] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[176]_i_1_n_0 ),
        .Q(data22[0]),
        .R(1'b0));
  FDRE \string_r_reg[178] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[178]_i_1_n_0 ),
        .Q(data22[2]),
        .R(1'b0));
  FDRE \string_r_reg[180] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[180]_i_1_n_0 ),
        .Q(data22[4]),
        .R(1'b0));
  FDRE \string_r_reg[189] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[189]_i_1_n_0 ),
        .Q(data23),
        .R(1'b0));
  FDRE \string_r_reg[192] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[192]_i_1_n_0 ),
        .Q(data24[0]),
        .R(1'b0));
  FDSE \string_r_reg[194] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[194]_i_1_n_0 ),
        .Q(data24[2]),
        .S(\string_r[293]_i_1_n_0 ));
  FDRE \string_r_reg[197] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[197]_i_1_n_0 ),
        .Q(data24[5]),
        .R(1'b0));
  FDRE \string_r_reg[200] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[200]_i_1_n_0 ),
        .Q(data25[0]),
        .R(1'b0));
  FDRE \string_r_reg[201] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[201]_i_1_n_0 ),
        .Q(data25[1]),
        .R(1'b0));
  FDRE \string_r_reg[202] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[202]_i_1_n_0 ),
        .Q(data25[2]),
        .R(1'b0));
  FDRE \string_r_reg[217] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[217]_i_1_n_0 ),
        .Q(data27),
        .R(1'b0));
  FDRE \string_r_reg[224] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[224]_i_1_n_0 ),
        .Q(data28[0]),
        .R(1'b0));
  FDRE \string_r_reg[225] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[225]_i_1_n_0 ),
        .Q(data28[1]),
        .R(1'b0));
  FDRE \string_r_reg[232] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[232]_i_1_n_0 ),
        .Q(data29),
        .R(1'b0));
  FDSE \string_r_reg[240] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[240]_i_1_n_0 ),
        .Q(data30[0]),
        .S(\string_r[293]_i_1_n_0 ));
  FDRE \string_r_reg[245] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[245]_i_1_n_0 ),
        .Q(data30[5]),
        .R(1'b0));
  FDRE \string_r_reg[248] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[248]_i_1_n_0 ),
        .Q(data31[0]),
        .R(1'b0));
  FDRE \string_r_reg[251] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[251]_i_1_n_0 ),
        .Q(data31[3]),
        .R(1'b0));
  FDRE \string_r_reg[264] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\FSM_sequential_state_r_reg[1]_1 ),
        .Q(data33[0]),
        .R(1'b0));
  FDRE \string_r_reg[265] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[265]_i_1_n_0 ),
        .Q(data33[1]),
        .R(1'b0));
  FDRE \string_r_reg[272] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\FSM_sequential_state_r_reg[1]_0 ),
        .Q(data34[0]),
        .R(1'b0));
  FDRE \string_r_reg[273] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[273]_i_1_n_0 ),
        .Q(data34[1]),
        .R(1'b0));
  FDRE \string_r_reg[274] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[274]_i_1_n_0 ),
        .Q(data34[2]),
        .R(1'b0));
  FDRE \string_r_reg[281] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[281]_i_1_n_0 ),
        .Q(data35[1]),
        .R(1'b0));
  FDRE \string_r_reg[282] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[282]_i_1_n_0 ),
        .Q(data35[2]),
        .R(1'b0));
  FDRE \string_r_reg[288] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[288]_i_1_n_0 ),
        .Q(data36[0]),
        .R(1'b0));
  FDRE \string_r_reg[291] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[291]_i_1_n_0 ),
        .Q(data36[3]),
        .R(1'b0));
  FDSE \string_r_reg[292] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[192]_i_1_n_0 ),
        .Q(data36[4]),
        .S(\string_r[293]_i_1_n_0 ));
  FDSE \string_r_reg[293] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\FSM_sequential_state_r_reg[1]_0 ),
        .Q(data36[5]),
        .S(\string_r[293]_i_1_n_0 ));
  FDRE \string_r_reg[297] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[297]_i_1_n_0 ),
        .Q(data37[1]),
        .R(1'b0));
  FDRE \string_r_reg[299] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[299]_i_1_n_0 ),
        .Q(data37[3]),
        .R(1'b0));
  FDRE \string_r_reg[304] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[304]_i_1_n_0 ),
        .Q(data38[0]),
        .R(1'b0));
  FDRE \string_r_reg[306] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(string_i[1]),
        .Q(data38[2]),
        .R(1'b0));
  FDRE \string_r_reg[312] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[312]_i_1_n_0 ),
        .Q(data39[0]),
        .R(1'b0));
  FDRE \string_r_reg[313] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[313]_i_1_n_0 ),
        .Q(data39[1]),
        .R(1'b0));
  FDRE \string_r_reg[314] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[314]_i_1_n_0 ),
        .Q(data39[2]),
        .R(1'b0));
  FDRE \string_r_reg[316] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[316]_i_2_n_0 ),
        .Q(data39[4]),
        .R(1'b0));
  FDRE \string_r_reg[40] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[40]_i_1_n_0 ),
        .Q(data5),
        .R(1'b0));
  FDRE \string_r_reg[72] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(Q[4]),
        .Q(data9),
        .R(1'b0));
  FDSE \string_r_reg[80] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(Q[4]),
        .Q(data10),
        .S(\string_r[293]_i_1_n_0 ));
  FDRE \string_r_reg[88] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(\string_r[88]_i_1_n_0 ),
        .Q(data11),
        .R(1'b0));
  FDRE \string_r_reg[96] 
       (.C(clk),
        .CE(\string_r[316]_i_1_n_0 ),
        .D(Q[3]),
        .Q(data12),
        .R(1'b0));
  total_design_host_top_wrapper_0_0_printc u_printc
       (.E(u_printc_n_13),
        .\FSM_sequential_state_r_reg[0] (u_printc_n_5),
        .\FSM_sequential_state_r_reg[0]_0 (u_printc_n_12),
        .\FSM_sequential_state_r_reg[0]_1 (\FSM_sequential_state_r[0]_i_2_n_0 ),
        .\FSM_sequential_state_r_reg[0]_2 (\FSM_sequential_state_r[1]_i_5_n_0 ),
        .\FSM_sequential_state_r_reg[1] (u_printc_n_6),
        .\FSM_sequential_state_r_reg[1]_0 (u_printc_n_7),
        .\FSM_sequential_state_r_reg[1]_1 (u_printc_n_10),
        .\FSM_sequential_state_r_reg[1]_2 (\FSM_sequential_state_r[1]_i_2_n_0 ),
        .Q({\char_r_reg_n_0_[6] ,\char_r_reg_n_0_[5] ,\char_r_reg_n_0_[4] ,\char_r_reg_n_0_[3] ,\char_r_reg_n_0_[2] ,\char_r_reg_n_0_[1] ,\char_r_reg_n_0_[0] }),
        .SS(SR),
        .char_idx_r(char_idx_r),
        .\char_idx_r_reg[0] (\char_idx_r[5]_i_5_n_0 ),
        .\char_idx_r_reg[3] (\char_idx_r_reg_n_0_[3] ),
        .\char_idx_r_reg[4] (\char_idx_r_reg_n_0_[4] ),
        .clk(clk),
        .\hex_digit_idx_r_reg[0] (u_printc_n_11),
        .\hex_digit_idx_r_reg[1] (\hex_digit_idx_r_reg_n_0_[0] ),
        .\hex_digit_idx_r_reg[1]_0 (\hex_digit_idx_r[1]_i_2_n_0 ),
        .\hex_digit_idx_r_reg[1]_1 (\hex_digit_idx_r_reg_n_0_[1] ),
        .\hex_digit_idx_r_reg[2] (\hex_digit_idx_r[2]_i_2_n_0 ),
        .\hex_digit_idx_r_reg[2]_0 (\hex_digit_idx_r[2]_i_3_n_0 ),
        .\hex_digit_idx_r_reg[2]_1 (\hex_digit_idx_r_reg_n_0_[2] ),
        .m_axi_arready(m_axi_arready),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_awready(m_axi_awready),
        .m_axi_awvalid(m_axi_awvalid),
        .m_axi_bready(m_axi_bready),
        .m_axi_bvalid(m_axi_bvalid),
        .m_axi_rdata(m_axi_rdata),
        .m_axi_rready(m_axi_rready),
        .m_axi_rvalid(m_axi_rvalid),
        .m_axi_wdata(m_axi_wdata),
        .m_axi_wready(m_axi_wready),
        .m_axi_wvalid(m_axi_wvalid),
        .rst_n(rst_n),
        .rst_n_0(u_printc_n_8),
        .rst_n_1(u_printc_n_9),
        .rst_n_2(u_printc_n_14),
        .state_r(state_r));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \wait_counter_r[0]_i_1 
       (.I0(\wait_counter_r_reg[0]_1 ),
        .I1(wait_counter_r),
        .I2(wait_counter_next_w),
        .O(\wait_counter_r_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h8F80)) 
    \wait_counter_r[1]_i_1 
       (.I0(\wait_counter_r_reg[0]_1 ),
        .I1(wait_counter_next_w),
        .I2(wait_counter_r),
        .I3(wait_counter_fin_w),
        .O(\wait_counter_r_reg[0]_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8000)) 
    \wait_counter_r[1]_i_3 
       (.I0(Q[0]),
        .I1(Q[3]),
        .I2(prints_ready_w),
        .I3(\addr_r_reg[0] ),
        .I4(\wait_counter_r[1]_i_4_n_0 ),
        .I5(\wait_counter_r_reg[1] ),
        .O(wait_counter_r));
  LUT6 #(
    .INIT(64'h0000008000000000)) 
    \wait_counter_r[1]_i_4 
       (.I0(\addr_r_reg[0]_0 ),
        .I1(Q[4]),
        .I2(prints_ready_w),
        .I3(Q[1]),
        .I4(Q[3]),
        .I5(\wait_counter_r[1]_i_3_0 ),
        .O(\wait_counter_r[1]_i_4_n_0 ));
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
