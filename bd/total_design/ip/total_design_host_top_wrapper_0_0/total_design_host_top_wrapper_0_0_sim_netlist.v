// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Sat May  9 15:58:36 2026
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM ADDR" *) output [9:0]mem_addr_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 MEM DOUT" *) input [31:0]mem_dout_i;
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
  wire [9:0]mem_addr_o;
  wire [31:0]mem_dout_i;
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
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  total_design_host_top_wrapper_0_0_host_top_wrapper inst
       (.D({simt_start_o,ready_o}),
        .Q(mem_addr_o),
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
        .mem_dout_i(mem_dout_i),
        .rst_n(rst_n),
        .simt_ready_i(simt_ready_i),
        .start_i(start_i));
endmodule

(* ORIG_REF_NAME = "host_top" *) 
module total_design_host_top_wrapper_0_0_host_top
   (D,
    m_axi_wdata,
    block_mem_addr_o,
    m_axi_bready,
    m_axi_arvalid,
    m_axi_rready,
    m_axi_wvalid,
    m_axi_awvalid,
    clk,
    mem_dout_i,
    rst_n,
    m_axi_arready,
    m_axi_rvalid,
    m_axi_bvalid,
    simt_ready_i,
    start_i,
    m_axi_rdata,
    m_axi_wready,
    m_axi_awready);
  output [1:0]D;
  output [6:0]m_axi_wdata;
  output [9:0]block_mem_addr_o;
  output m_axi_bready;
  output m_axi_arvalid;
  output m_axi_rready;
  output m_axi_wvalid;
  output m_axi_awvalid;
  input clk;
  input [31:0]mem_dout_i;
  input rst_n;
  input m_axi_arready;
  input m_axi_rvalid;
  input m_axi_bvalid;
  input simt_ready_i;
  input start_i;
  input [0:0]m_axi_rdata;
  input m_axi_wready;
  input m_axi_awready;

  wire [1:0]D;
  wire \FSM_onehot_state_r_reg_n_0_[3] ;
  wire \FSM_onehot_state_r_reg_n_0_[4] ;
  wire \FSM_onehot_state_r_reg_n_0_[5] ;
  wire \FSM_onehot_state_r_reg_n_0_[6] ;
  wire \FSM_onehot_state_r_reg_n_0_[7] ;
  wire \FSM_onehot_state_r_reg_n_0_[8] ;
  wire [9:0]block_mem_addr_o;
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
  wire [31:0]mem_dout_i;
  wire prints_ready_w;
  wire prints_start_w;
  wire rst_n;
  wire simt_ready_i;
  wire start_i;
  wire string_i0;
  wire u_memdump_n_11;
  wire u_prints_n_6;
  wire u_prints_n_7;
  wire u_prints_n_8;

  (* FSM_ENCODED_STATES = "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_r_reg[0] 
       (.C(clk),
        .CE(u_prints_n_6),
        .D(\FSM_onehot_state_r_reg_n_0_[8] ),
        .Q(D[0]),
        .S(u_prints_n_7));
  (* FSM_ENCODED_STATES = "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[1] 
       (.C(clk),
        .CE(u_prints_n_6),
        .D(D[0]),
        .Q(D[1]),
        .R(u_prints_n_7));
  (* FSM_ENCODED_STATES = "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[2] 
       (.C(clk),
        .CE(u_prints_n_6),
        .D(D[1]),
        .Q(string_i0),
        .R(u_prints_n_7));
  (* FSM_ENCODED_STATES = "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[3] 
       (.C(clk),
        .CE(u_prints_n_6),
        .D(string_i0),
        .Q(\FSM_onehot_state_r_reg_n_0_[3] ),
        .R(u_prints_n_7));
  (* FSM_ENCODED_STATES = "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[4] 
       (.C(clk),
        .CE(u_prints_n_6),
        .D(\FSM_onehot_state_r_reg_n_0_[3] ),
        .Q(\FSM_onehot_state_r_reg_n_0_[4] ),
        .R(u_prints_n_7));
  (* FSM_ENCODED_STATES = "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[5] 
       (.C(clk),
        .CE(u_prints_n_6),
        .D(\FSM_onehot_state_r_reg_n_0_[4] ),
        .Q(\FSM_onehot_state_r_reg_n_0_[5] ),
        .R(u_prints_n_7));
  (* FSM_ENCODED_STATES = "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[6] 
       (.C(clk),
        .CE(u_prints_n_6),
        .D(\FSM_onehot_state_r_reg_n_0_[5] ),
        .Q(\FSM_onehot_state_r_reg_n_0_[6] ),
        .R(u_prints_n_7));
  (* FSM_ENCODED_STATES = "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[7] 
       (.C(clk),
        .CE(u_prints_n_6),
        .D(\FSM_onehot_state_r_reg_n_0_[6] ),
        .Q(\FSM_onehot_state_r_reg_n_0_[7] ),
        .R(u_prints_n_7));
  (* FSM_ENCODED_STATES = "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_r_reg[8] 
       (.C(clk),
        .CE(u_prints_n_6),
        .D(\FSM_onehot_state_r_reg_n_0_[7] ),
        .Q(\FSM_onehot_state_r_reg_n_0_[8] ),
        .R(u_prints_n_7));
  total_design_host_top_wrapper_0_0_memdump u_memdump
       (.D(u_prints_n_8),
        .\FSM_sequential_state_r_reg[1]_0 (u_memdump_n_11),
        .Q({\FSM_onehot_state_r_reg_n_0_[7] ,\FSM_onehot_state_r_reg_n_0_[6] ,\FSM_onehot_state_r_reg_n_0_[5] ,string_i0}),
        .SR(u_prints_n_7),
        .\addr_r_reg[9]_0 (block_mem_addr_o),
        .clk(clk),
        .prints_ready_w(prints_ready_w),
        .prints_start_w(prints_start_w),
        .rst_n(rst_n));
  total_design_host_top_wrapper_0_0_prints u_prints
       (.D(u_prints_n_8),
        .E(u_prints_n_6),
        .\FSM_onehot_state_r_reg[0] (u_memdump_n_11),
        .Q({\FSM_onehot_state_r_reg_n_0_[8] ,\FSM_onehot_state_r_reg_n_0_[7] ,\FSM_onehot_state_r_reg_n_0_[6] ,\FSM_onehot_state_r_reg_n_0_[5] ,\FSM_onehot_state_r_reg_n_0_[4] ,\FSM_onehot_state_r_reg_n_0_[3] ,string_i0,D}),
        .SR(u_prints_n_7),
        .block_mem_addr_o(block_mem_addr_o),
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
        .mem_dout_i(mem_dout_i),
        .prints_ready_w(prints_ready_w),
        .prints_start_w(prints_start_w),
        .rst_n(rst_n),
        .simt_ready_i(simt_ready_i),
        .start_i(start_i));
endmodule

(* ORIG_REF_NAME = "host_top_wrapper" *) 
module total_design_host_top_wrapper_0_0_host_top_wrapper
   (D,
    m_axi_wdata,
    Q,
    m_axi_bready,
    m_axi_arvalid,
    m_axi_rready,
    m_axi_wvalid,
    m_axi_awvalid,
    clk,
    mem_dout_i,
    rst_n,
    m_axi_arready,
    m_axi_rvalid,
    m_axi_bvalid,
    simt_ready_i,
    start_i,
    m_axi_rdata,
    m_axi_wready,
    m_axi_awready);
  output [1:0]D;
  output [6:0]m_axi_wdata;
  output [9:0]Q;
  output m_axi_bready;
  output m_axi_arvalid;
  output m_axi_rready;
  output m_axi_wvalid;
  output m_axi_awvalid;
  input clk;
  input [31:0]mem_dout_i;
  input rst_n;
  input m_axi_arready;
  input m_axi_rvalid;
  input m_axi_bvalid;
  input simt_ready_i;
  input start_i;
  input [0:0]m_axi_rdata;
  input m_axi_wready;
  input m_axi_awready;

  wire [1:0]D;
  wire [9:0]Q;
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
  wire [31:0]mem_dout_i;
  wire rst_n;
  wire simt_ready_i;
  wire start_i;

  total_design_host_top_wrapper_0_0_host_top u_host_top
       (.D(D),
        .block_mem_addr_o(Q),
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
        .mem_dout_i(mem_dout_i),
        .rst_n(rst_n),
        .simt_ready_i(simt_ready_i),
        .start_i(start_i));
endmodule

(* ORIG_REF_NAME = "memdump" *) 
module total_design_host_top_wrapper_0_0_memdump
   (prints_start_w,
    \addr_r_reg[9]_0 ,
    \FSM_sequential_state_r_reg[1]_0 ,
    Q,
    rst_n,
    D,
    prints_ready_w,
    SR,
    clk);
  output prints_start_w;
  output [9:0]\addr_r_reg[9]_0 ;
  output \FSM_sequential_state_r_reg[1]_0 ;
  input [3:0]Q;
  input rst_n;
  input [0:0]D;
  input prints_ready_w;
  input [0:0]SR;
  input clk;

  wire [0:0]D;
  wire \FSM_sequential_state_r[0]_i_1__0_n_0 ;
  wire \FSM_sequential_state_r[1]_i_1__0_n_0 ;
  wire \FSM_sequential_state_r_reg[1]_0 ;
  wire [3:0]Q;
  wire [0:0]SR;
  wire [9:0]addr_r0_in;
  wire \addr_r[5]_i_2_n_0 ;
  wire \addr_r[9]_i_1_n_0 ;
  wire \addr_r[9]_i_3_n_0 ;
  wire [9:0]\addr_r_reg[9]_0 ;
  wire clk;
  wire prints_ready_w;
  wire prints_start_w;
  wire rst_n;
  wire [1:0]state_r;
  wire state_r1;
  wire state_r1_carry_i_1_n_0;
  wire state_r1_carry_i_2_n_0;
  wire state_r1_carry_i_3_n_0;
  wire state_r1_carry_i_4_n_0;
  wire state_r1_carry_n_1;
  wire state_r1_carry_n_2;
  wire state_r1_carry_n_3;
  wire wait_counter_fin_w;
  wire [1:1]wait_counter_next_w;
  wire \wait_counter_r[0]_i_1_n_0 ;
  wire \wait_counter_r[1]_i_1_n_0 ;
  wire [3:0]NLW_state_r1_carry_O_UNCONNECTED;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h1110)) 
    \FSM_onehot_state_r[0]_i_4 
       (.I0(state_r[1]),
        .I1(state_r[0]),
        .I2(Q[1]),
        .I3(Q[2]),
        .O(\FSM_sequential_state_r_reg[1]_0 ));
  LUT6 #(
    .INIT(64'h5050FC0C5F5FFC0C)) 
    \FSM_sequential_state_r[0]_i_1__0 
       (.I0(state_r1),
        .I1(Q[1]),
        .I2(state_r[1]),
        .I3(prints_ready_w),
        .I4(state_r[0]),
        .I5(wait_counter_fin_w),
        .O(\FSM_sequential_state_r[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h62)) 
    \FSM_sequential_state_r[1]_i_1__0 
       (.I0(state_r[1]),
        .I1(state_r[0]),
        .I2(wait_counter_fin_w),
        .O(\FSM_sequential_state_r[1]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'hFAFEFAFAFAFAFAFA)) 
    \FSM_sequential_state_r[1]_i_5 
       (.I0(Q[0]),
        .I1(D),
        .I2(Q[3]),
        .I3(state_r[1]),
        .I4(state_r[0]),
        .I5(wait_counter_fin_w),
        .O(prints_start_w));
  (* FSM_ENCODED_STATES = "S_PRINT:10,S_NEXT:11,S_IDLE:00,S_MEMREAD:01" *) 
  FDRE \FSM_sequential_state_r_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\FSM_sequential_state_r[0]_i_1__0_n_0 ),
        .Q(state_r[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "S_PRINT:10,S_NEXT:11,S_IDLE:00,S_MEMREAD:01" *) 
  FDRE \FSM_sequential_state_r_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\FSM_sequential_state_r[1]_i_1__0_n_0 ),
        .Q(state_r[1]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \addr_r[0]_i_1 
       (.I0(state_r[1]),
        .I1(\addr_r_reg[9]_0 [0]),
        .O(addr_r0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h48)) 
    \addr_r[1]_i_1 
       (.I0(\addr_r_reg[9]_0 [0]),
        .I1(state_r[1]),
        .I2(\addr_r_reg[9]_0 [1]),
        .O(addr_r0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7080)) 
    \addr_r[2]_i_1 
       (.I0(\addr_r_reg[9]_0 [1]),
        .I1(\addr_r_reg[9]_0 [0]),
        .I2(state_r[1]),
        .I3(\addr_r_reg[9]_0 [2]),
        .O(addr_r0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7F008000)) 
    \addr_r[3]_i_1 
       (.I0(\addr_r_reg[9]_0 [2]),
        .I1(\addr_r_reg[9]_0 [0]),
        .I2(\addr_r_reg[9]_0 [1]),
        .I3(state_r[1]),
        .I4(\addr_r_reg[9]_0 [3]),
        .O(addr_r0_in[3]));
  LUT6 #(
    .INIT(64'h7FFF000080000000)) 
    \addr_r[4]_i_1 
       (.I0(\addr_r_reg[9]_0 [3]),
        .I1(\addr_r_reg[9]_0 [1]),
        .I2(\addr_r_reg[9]_0 [0]),
        .I3(\addr_r_reg[9]_0 [2]),
        .I4(state_r[1]),
        .I5(\addr_r_reg[9]_0 [4]),
        .O(addr_r0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h48)) 
    \addr_r[5]_i_1 
       (.I0(\addr_r[5]_i_2_n_0 ),
        .I1(state_r[1]),
        .I2(\addr_r_reg[9]_0 [5]),
        .O(addr_r0_in[5]));
  LUT5 #(
    .INIT(32'h80000000)) 
    \addr_r[5]_i_2 
       (.I0(\addr_r_reg[9]_0 [4]),
        .I1(\addr_r_reg[9]_0 [2]),
        .I2(\addr_r_reg[9]_0 [0]),
        .I3(\addr_r_reg[9]_0 [1]),
        .I4(\addr_r_reg[9]_0 [3]),
        .O(\addr_r[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h48)) 
    \addr_r[6]_i_1 
       (.I0(\addr_r[9]_i_3_n_0 ),
        .I1(state_r[1]),
        .I2(\addr_r_reg[9]_0 [6]),
        .O(addr_r0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7080)) 
    \addr_r[7]_i_1 
       (.I0(\addr_r_reg[9]_0 [6]),
        .I1(\addr_r[9]_i_3_n_0 ),
        .I2(state_r[1]),
        .I3(\addr_r_reg[9]_0 [7]),
        .O(addr_r0_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7F008000)) 
    \addr_r[8]_i_1 
       (.I0(\addr_r_reg[9]_0 [7]),
        .I1(\addr_r[9]_i_3_n_0 ),
        .I2(\addr_r_reg[9]_0 [6]),
        .I3(state_r[1]),
        .I4(\addr_r_reg[9]_0 [8]),
        .O(addr_r0_in[8]));
  LUT4 #(
    .INIT(16'hA400)) 
    \addr_r[9]_i_1 
       (.I0(state_r[1]),
        .I1(Q[1]),
        .I2(state_r[0]),
        .I3(rst_n),
        .O(\addr_r[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFF000080000000)) 
    \addr_r[9]_i_2 
       (.I0(\addr_r_reg[9]_0 [8]),
        .I1(\addr_r_reg[9]_0 [6]),
        .I2(\addr_r[9]_i_3_n_0 ),
        .I3(\addr_r_reg[9]_0 [7]),
        .I4(state_r[1]),
        .I5(\addr_r_reg[9]_0 [9]),
        .O(addr_r0_in[9]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \addr_r[9]_i_3 
       (.I0(\addr_r_reg[9]_0 [5]),
        .I1(\addr_r_reg[9]_0 [3]),
        .I2(\addr_r_reg[9]_0 [1]),
        .I3(\addr_r_reg[9]_0 [0]),
        .I4(\addr_r_reg[9]_0 [2]),
        .I5(\addr_r_reg[9]_0 [4]),
        .O(\addr_r[9]_i_3_n_0 ));
  FDRE \addr_r_reg[0] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[0]),
        .Q(\addr_r_reg[9]_0 [0]),
        .R(1'b0));
  FDRE \addr_r_reg[1] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[1]),
        .Q(\addr_r_reg[9]_0 [1]),
        .R(1'b0));
  FDRE \addr_r_reg[2] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[2]),
        .Q(\addr_r_reg[9]_0 [2]),
        .R(1'b0));
  FDRE \addr_r_reg[3] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[3]),
        .Q(\addr_r_reg[9]_0 [3]),
        .R(1'b0));
  FDRE \addr_r_reg[4] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[4]),
        .Q(\addr_r_reg[9]_0 [4]),
        .R(1'b0));
  FDRE \addr_r_reg[5] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[5]),
        .Q(\addr_r_reg[9]_0 [5]),
        .R(1'b0));
  FDRE \addr_r_reg[6] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[6]),
        .Q(\addr_r_reg[9]_0 [6]),
        .R(1'b0));
  FDRE \addr_r_reg[7] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[7]),
        .Q(\addr_r_reg[9]_0 [7]),
        .R(1'b0));
  FDRE \addr_r_reg[8] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[8]),
        .Q(\addr_r_reg[9]_0 [8]),
        .R(1'b0));
  FDRE \addr_r_reg[9] 
       (.C(clk),
        .CE(\addr_r[9]_i_1_n_0 ),
        .D(addr_r0_in[9]),
        .Q(\addr_r_reg[9]_0 [9]),
        .R(1'b0));
  CARRY4 state_r1_carry
       (.CI(1'b0),
        .CO({state_r1,state_r1_carry_n_1,state_r1_carry_n_2,state_r1_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_state_r1_carry_O_UNCONNECTED[3:0]),
        .S({state_r1_carry_i_1_n_0,state_r1_carry_i_2_n_0,state_r1_carry_i_3_n_0,state_r1_carry_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    state_r1_carry_i_1
       (.I0(\addr_r_reg[9]_0 [9]),
        .O(state_r1_carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    state_r1_carry_i_2
       (.I0(\addr_r_reg[9]_0 [8]),
        .I1(\addr_r_reg[9]_0 [7]),
        .I2(\addr_r_reg[9]_0 [6]),
        .O(state_r1_carry_i_2_n_0));
  LUT3 #(
    .INIT(8'h10)) 
    state_r1_carry_i_3
       (.I0(\addr_r_reg[9]_0 [5]),
        .I1(\addr_r_reg[9]_0 [4]),
        .I2(\addr_r_reg[9]_0 [3]),
        .O(state_r1_carry_i_3_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    state_r1_carry_i_4
       (.I0(\addr_r_reg[9]_0 [2]),
        .I1(\addr_r_reg[9]_0 [1]),
        .I2(\addr_r_reg[9]_0 [0]),
        .O(state_r1_carry_i_4_n_0));
  LUT5 #(
    .INIT(32'h5BFF0A00)) 
    \wait_counter_r[0]_i_1 
       (.I0(state_r[0]),
        .I1(Q[1]),
        .I2(state_r[1]),
        .I3(rst_n),
        .I4(wait_counter_next_w),
        .O(\wait_counter_r[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h338BFFFF00880000)) 
    \wait_counter_r[1]_i_1 
       (.I0(wait_counter_next_w),
        .I1(state_r[0]),
        .I2(Q[1]),
        .I3(state_r[1]),
        .I4(rst_n),
        .I5(wait_counter_fin_w),
        .O(\wait_counter_r[1]_i_1_n_0 ));
  FDRE \wait_counter_r_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\wait_counter_r[0]_i_1_n_0 ),
        .Q(wait_counter_next_w),
        .R(1'b0));
  FDRE \wait_counter_r_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\wait_counter_r[1]_i_1_n_0 ),
        .Q(wait_counter_fin_w),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "printc" *) 
module total_design_host_top_wrapper_0_0_printc
   (m_axi_awvalid,
    m_axi_wvalid,
    m_axi_bready,
    m_axi_arvalid,
    m_axi_rready,
    \FSM_sequential_state_r_reg[0] ,
    E,
    rst_n_0,
    SS,
    \FSM_sequential_state_r_reg[0]_0 ,
    \FSM_sequential_state_r_reg[1] ,
    m_axi_wdata,
    clk,
    rst_n,
    state_r,
    m_axi_arready,
    m_axi_rvalid,
    m_axi_bvalid,
    prints_start_w,
    hex_digit_idx_c_w,
    \FSM_sequential_state_r_reg[1]_0 ,
    \char_idx_r_reg[0] ,
    \char_idx_r_reg[0]_0 ,
    \char_idx_r_reg[0]_1 ,
    \char_idx_r_reg[0]_2 ,
    m_axi_rdata,
    m_axi_wready,
    m_axi_awready,
    \FSM_sequential_state_r_reg[0]_1 ,
    Q);
  output m_axi_awvalid;
  output m_axi_wvalid;
  output m_axi_bready;
  output m_axi_arvalid;
  output m_axi_rready;
  output \FSM_sequential_state_r_reg[0] ;
  output [0:0]E;
  output [0:0]rst_n_0;
  output [0:0]SS;
  output \FSM_sequential_state_r_reg[0]_0 ;
  output \FSM_sequential_state_r_reg[1] ;
  output [6:0]m_axi_wdata;
  input clk;
  input rst_n;
  input [1:0]state_r;
  input m_axi_arready;
  input m_axi_rvalid;
  input m_axi_bvalid;
  input prints_start_w;
  input hex_digit_idx_c_w;
  input \FSM_sequential_state_r_reg[1]_0 ;
  input \char_idx_r_reg[0] ;
  input \char_idx_r_reg[0]_0 ;
  input \char_idx_r_reg[0]_1 ;
  input \char_idx_r_reg[0]_2 ;
  input [0:0]m_axi_rdata;
  input m_axi_wready;
  input m_axi_awready;
  input \FSM_sequential_state_r_reg[0]_1 ;
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
  wire \FSM_sequential_state_r_reg[1] ;
  wire \FSM_sequential_state_r_reg[1]_0 ;
  wire [6:0]Q;
  wire [0:0]SS;
  wire awready_recv_r_i_1_n_0;
  wire awready_recv_r_reg_n_0;
  wire c_ready_w;
  wire \char_idx_r[5]_i_4_n_0 ;
  wire \char_idx_r_reg[0] ;
  wire \char_idx_r_reg[0]_0 ;
  wire \char_idx_r_reg[0]_1 ;
  wire \char_idx_r_reg[0]_2 ;
  wire [6:0]char_r;
  wire \char_r[6]_i_1_n_0 ;
  wire clk;
  wire hex_digit_idx_c_w;
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
  wire prints_start_w;
  wire ready_o_i_1_n_0;
  wire rst_n;
  wire [0:0]rst_n_0;
  wire [1:0]state_r;
  wire wready_recv_r_i_1_n_0;
  wire wready_recv_r_reg_n_0;

  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_state_r[0]_i_1 
       (.I0(rst_n),
        .O(SS));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    \FSM_onehot_state_r[1]_i_1 
       (.I0(m_axi_rdata),
        .I1(\FSM_onehot_state_r_reg_n_0_[2] ),
        .I2(\FSM_onehot_state_r_reg_n_0_[0] ),
        .O(\FSM_onehot_state_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
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
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hF4FFFF00)) 
    \FSM_sequential_state_r[0]_i_1 
       (.I0(\FSM_sequential_state_r_reg[0]_1 ),
        .I1(\FSM_sequential_state_r_reg[1]_0 ),
        .I2(state_r[1]),
        .I3(\FSM_sequential_state_r[1]_i_3_n_0 ),
        .I4(state_r[0]),
        .O(\FSM_sequential_state_r_reg[1] ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h5F80)) 
    \FSM_sequential_state_r[1]_i_1 
       (.I0(state_r[0]),
        .I1(\FSM_sequential_state_r_reg[1]_0 ),
        .I2(\FSM_sequential_state_r[1]_i_3_n_0 ),
        .I3(state_r[1]),
        .O(\FSM_sequential_state_r_reg[0]_0 ));
  LUT5 #(
    .INIT(32'hF0FFC0AA)) 
    \FSM_sequential_state_r[1]_i_3 
       (.I0(prints_start_w),
        .I1(hex_digit_idx_c_w),
        .I2(c_ready_w),
        .I3(state_r[1]),
        .I4(state_r[0]),
        .O(\FSM_sequential_state_r[1]_i_3_n_0 ));
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
  LUT4 #(
    .INIT(16'hAA08)) 
    \char_idx_r[5]_i_1 
       (.I0(rst_n),
        .I1(\FSM_sequential_state_r_reg[1]_0 ),
        .I2(\char_idx_r_reg[0] ),
        .I3(\char_idx_r[5]_i_4_n_0 ),
        .O(rst_n_0));
  LUT6 #(
    .INIT(64'h000000000100FFFF)) 
    \char_idx_r[5]_i_4 
       (.I0(\char_idx_r_reg[0]_0 ),
        .I1(\char_idx_r_reg[0]_1 ),
        .I2(\char_idx_r_reg[0]_2 ),
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
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h00A0C000)) 
    \char_r[6]_i_1__0 
       (.I0(c_ready_w),
        .I1(\FSM_sequential_state_r_reg[1]_0 ),
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
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h4404)) 
    \hex_digit_idx_r[2]_i_4 
       (.I0(state_r[0]),
        .I1(rst_n),
        .I2(state_r[1]),
        .I3(c_ready_w),
        .O(\FSM_sequential_state_r_reg[0] ));
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
   (m_axi_awvalid,
    m_axi_wvalid,
    m_axi_bready,
    m_axi_arvalid,
    m_axi_rready,
    prints_ready_w,
    E,
    SR,
    D,
    m_axi_wdata,
    clk,
    rst_n,
    m_axi_arready,
    m_axi_rvalid,
    m_axi_bvalid,
    prints_start_w,
    \FSM_onehot_state_r_reg[0] ,
    Q,
    simt_ready_i,
    start_i,
    m_axi_rdata,
    m_axi_wready,
    m_axi_awready,
    block_mem_addr_o,
    mem_dout_i);
  output m_axi_awvalid;
  output m_axi_wvalid;
  output m_axi_bready;
  output m_axi_arvalid;
  output m_axi_rready;
  output prints_ready_w;
  output [0:0]E;
  output [0:0]SR;
  output [0:0]D;
  output [6:0]m_axi_wdata;
  input clk;
  input rst_n;
  input m_axi_arready;
  input m_axi_rvalid;
  input m_axi_bvalid;
  input prints_start_w;
  input \FSM_onehot_state_r_reg[0] ;
  input [8:0]Q;
  input simt_ready_i;
  input start_i;
  input [0:0]m_axi_rdata;
  input m_axi_wready;
  input m_axi_awready;
  input [9:0]block_mem_addr_o;
  input [31:0]mem_dout_i;

  wire [0:0]D;
  wire [0:0]E;
  wire \FSM_onehot_state_r[0]_i_3_n_0 ;
  wire \FSM_onehot_state_r_reg[0] ;
  wire \FSM_sequential_state_r[0]_i_2_n_0 ;
  wire \FSM_sequential_state_r[0]_i_3_n_0 ;
  wire \FSM_sequential_state_r[1]_i_2_n_0 ;
  wire \FSM_sequential_state_r[1]_i_4_n_0 ;
  wire [8:0]Q;
  wire [0:0]SR;
  wire [9:0]block_mem_addr_o;
  wire [5:0]char_idx_r;
  wire \char_idx_r[5]_i_3_n_0 ;
  wire \char_idx_r[5]_i_5_n_0 ;
  wire \char_idx_r_reg_n_0_[0] ;
  wire \char_idx_r_reg_n_0_[1] ;
  wire \char_idx_r_reg_n_0_[2] ;
  wire \char_idx_r_reg_n_0_[3] ;
  wire \char_idx_r_reg_n_0_[4] ;
  wire \char_idx_r_reg_n_0_[5] ;
  wire [6:0]char_r0_in;
  wire \char_r[0]_i_2_n_0 ;
  wire \char_r[0]_i_3_n_0 ;
  wire \char_r[0]_i_4_n_0 ;
  wire \char_r[0]_i_5_n_0 ;
  wire \char_r[0]_i_6_n_0 ;
  wire \char_r[0]_i_7_n_0 ;
  wire \char_r[0]_i_8_n_0 ;
  wire \char_r[1]_i_2_n_0 ;
  wire \char_r[1]_i_3_n_0 ;
  wire \char_r[1]_i_4_n_0 ;
  wire \char_r[1]_i_5_n_0 ;
  wire \char_r[2]_i_10_n_0 ;
  wire \char_r[2]_i_11_n_0 ;
  wire \char_r[2]_i_12_n_0 ;
  wire \char_r[2]_i_2_n_0 ;
  wire \char_r[2]_i_3_n_0 ;
  wire \char_r[2]_i_4_n_0 ;
  wire \char_r[2]_i_5_n_0 ;
  wire \char_r[2]_i_6_n_0 ;
  wire \char_r[2]_i_7_n_0 ;
  wire \char_r[2]_i_8_n_0 ;
  wire \char_r[2]_i_9_n_0 ;
  wire \char_r[3]_i_2_n_0 ;
  wire \char_r[3]_i_3_n_0 ;
  wire \char_r[3]_i_4_n_0 ;
  wire \char_r[3]_i_5_n_0 ;
  wire \char_r[3]_i_6_n_0 ;
  wire \char_r[3]_i_7_n_0 ;
  wire \char_r[4]_i_2_n_0 ;
  wire \char_r[4]_i_3_n_0 ;
  wire \char_r[4]_i_4_n_0 ;
  wire \char_r[4]_i_5_n_0 ;
  wire \char_r[4]_i_6_n_0 ;
  wire \char_r[5]_i_2_n_0 ;
  wire \char_r[5]_i_3_n_0 ;
  wire \char_r[5]_i_4_n_0 ;
  wire \char_r[5]_i_5_n_0 ;
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
  wire \char_r[6]_i_3_n_0 ;
  wire \char_r[6]_i_4_n_0 ;
  wire \char_r[6]_i_5_n_0 ;
  wire \char_r[6]_i_6_n_0 ;
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
  wire [0:0]data2;
  wire [0:0]data27;
  wire [0:0]data28;
  wire [0:0]data32;
  wire [1:1]data33;
  wire [3:3]data35;
  wire [0:0]data36;
  wire hex_digit_idx_c_w;
  wire [2:0]hex_digit_idx_r;
  wire \hex_digit_idx_r[0]_i_1_n_0 ;
  wire \hex_digit_idx_r[1]_i_1_n_0 ;
  wire \hex_digit_idx_r[2]_i_1_n_0 ;
  wire \hex_digit_idx_r[2]_i_3_n_0 ;
  wire \hex_digit_idx_r_reg_n_0_[0] ;
  wire \hex_digit_idx_r_reg_n_0_[1] ;
  wire \hex_digit_idx_r_reg_n_0_[2] ;
  wire [9:0]\hex_r_reg[1] ;
  wire [31:0]\hex_r_reg[2] ;
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
  wire [31:0]mem_dout_i;
  wire prints_ready_w;
  wire prints_start_w;
  wire rst_n;
  wire simt_ready_i;
  wire start_i;
  wire [1:0]state_r;
  wire \string_r[216]_i_1_n_0 ;
  wire \string_r[256]_i_1_n_0 ;
  wire \string_r[283]_i_1_n_0 ;
  wire \string_r[288]_i_1_n_0 ;
  wire \string_r[288]_i_2_n_0 ;
  wire u_printc_n_10;
  wire u_printc_n_5;
  wire u_printc_n_6;
  wire u_printc_n_7;
  wire u_printc_n_9;

  LUT6 #(
    .INIT(64'hFFFFFEEEFEEEFEEE)) 
    \FSM_onehot_state_r[0]_i_2 
       (.I0(\FSM_onehot_state_r[0]_i_3_n_0 ),
        .I1(\FSM_onehot_state_r_reg[0] ),
        .I2(Q[1]),
        .I3(simt_ready_i),
        .I4(Q[0]),
        .I5(start_i),
        .O(E));
  LUT6 #(
    .INIT(64'hFFFF8888FFF88888)) 
    \FSM_onehot_state_r[0]_i_3 
       (.I0(Q[4]),
        .I1(simt_ready_i),
        .I2(Q[8]),
        .I3(\string_r[216]_i_1_n_0 ),
        .I4(prints_ready_w),
        .I5(Q[3]),
        .O(\FSM_onehot_state_r[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h07)) 
    \FSM_sequential_state_r[0]_i_2 
       (.I0(\char_r[1]_i_2_n_0 ),
        .I1(\char_r[0]_i_2_n_0 ),
        .I2(\FSM_sequential_state_r[0]_i_3_n_0 ),
        .O(\FSM_sequential_state_r[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state_r[0]_i_2__0 
       (.I0(state_r[0]),
        .I1(state_r[1]),
        .O(prints_ready_w));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_state_r[0]_i_3 
       (.I0(\char_r[6]_i_6_n_0 ),
        .I1(\char_r[2]_i_3_n_0 ),
        .I2(\char_r[3]_i_2_n_0 ),
        .I3(\char_r[5]_i_2_n_0 ),
        .I4(\char_r[4]_i_2_n_0 ),
        .O(\FSM_sequential_state_r[0]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \FSM_sequential_state_r[1]_i_2 
       (.I0(\FSM_sequential_state_r[1]_i_4_n_0 ),
        .I1(\char_r[0]_i_2_n_0 ),
        .I2(\char_r[1]_i_2_n_0 ),
        .O(\FSM_sequential_state_r[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_state_r[1]_i_4 
       (.I0(\char_r[3]_i_2_n_0 ),
        .I1(\char_r[5]_i_2_n_0 ),
        .I2(\char_r[4]_i_2_n_0 ),
        .I3(\char_r[6]_i_6_n_0 ),
        .I4(\char_r[2]_i_3_n_0 ),
        .O(\FSM_sequential_state_r[1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \FSM_sequential_state_r[1]_i_6 
       (.I0(\hex_digit_idx_r_reg_n_0_[1] ),
        .I1(\hex_digit_idx_r_reg_n_0_[0] ),
        .I2(\hex_digit_idx_r_reg_n_0_[2] ),
        .O(hex_digit_idx_c_w));
  (* FSM_ENCODED_STATES = "S_READ_CHAR:01,S_IDLE:00,S_WRITE_CHAR:11,S_WRITE_HEX:10" *) 
  FDRE \FSM_sequential_state_r_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(u_printc_n_10),
        .Q(state_r[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "S_READ_CHAR:01,S_IDLE:00,S_WRITE_CHAR:11,S_WRITE_HEX:10" *) 
  FDRE \FSM_sequential_state_r_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(u_printc_n_9),
        .Q(state_r[1]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h54)) 
    \char_idx_r[0]_i_1 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(state_r[1]),
        .I2(state_r[0]),
        .O(char_idx_r[0]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hE00E)) 
    \char_idx_r[1]_i_1 
       (.I0(state_r[0]),
        .I1(state_r[1]),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .O(char_idx_r[1]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hA9A9A9FF)) 
    \char_idx_r[2]_i_1 
       (.I0(\char_idx_r_reg_n_0_[2] ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(state_r[1]),
        .I4(state_r[0]),
        .O(char_idx_r[2]));
  LUT6 #(
    .INIT(64'hFEFEFE0001010100)) 
    \char_idx_r[3]_i_1 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(state_r[1]),
        .I4(state_r[0]),
        .I5(\char_idx_r_reg_n_0_[3] ),
        .O(char_idx_r[3]));
  LUT6 #(
    .INIT(64'h0000FFFE00000001)) 
    \char_idx_r[4]_i_1 
       (.I0(\char_idx_r_reg_n_0_[2] ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(prints_ready_w),
        .I5(\char_idx_r_reg_n_0_[4] ),
        .O(char_idx_r[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFFAAAAAAA9)) 
    \char_idx_r[5]_i_2 
       (.I0(\char_idx_r_reg_n_0_[5] ),
        .I1(\char_idx_r_reg_n_0_[3] ),
        .I2(\char_idx_r[5]_i_5_n_0 ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_idx_r_reg_n_0_[4] ),
        .I5(prints_ready_w),
        .O(char_idx_r[5]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hFF15)) 
    \char_idx_r[5]_i_3 
       (.I0(\FSM_sequential_state_r[0]_i_3_n_0 ),
        .I1(\char_r[0]_i_2_n_0 ),
        .I2(\char_r[1]_i_2_n_0 ),
        .I3(state_r[1]),
        .O(\char_idx_r[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \char_idx_r[5]_i_5 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .O(\char_idx_r[5]_i_5_n_0 ));
  FDRE \char_idx_r_reg[0] 
       (.C(clk),
        .CE(u_printc_n_7),
        .D(char_idx_r[0]),
        .Q(\char_idx_r_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \char_idx_r_reg[1] 
       (.C(clk),
        .CE(u_printc_n_7),
        .D(char_idx_r[1]),
        .Q(\char_idx_r_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \char_idx_r_reg[2] 
       (.C(clk),
        .CE(u_printc_n_7),
        .D(char_idx_r[2]),
        .Q(\char_idx_r_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \char_idx_r_reg[3] 
       (.C(clk),
        .CE(u_printc_n_7),
        .D(char_idx_r[3]),
        .Q(\char_idx_r_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \char_idx_r_reg[4] 
       (.C(clk),
        .CE(u_printc_n_7),
        .D(char_idx_r[4]),
        .Q(\char_idx_r_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \char_idx_r_reg[5] 
       (.C(clk),
        .CE(u_printc_n_7),
        .D(char_idx_r[5]),
        .Q(\char_idx_r_reg_n_0_[5] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h56AAFFFF56AA0000)) 
    \char_r[0]_i_1 
       (.I0(\char_r[2]_i_2_n_0 ),
        .I1(\char_r[6]_i_3_n_0 ),
        .I2(\char_r[6]_i_4_n_0 ),
        .I3(\char_r[6]_i_5_n_0 ),
        .I4(\char_idx_r[5]_i_3_n_0 ),
        .I5(\char_r[0]_i_2_n_0 ),
        .O(char_r0_in[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFF62404040)) 
    \char_r[0]_i_2 
       (.I0(\char_idx_r_reg_n_0_[5] ),
        .I1(\char_idx_r_reg_n_0_[4] ),
        .I2(\char_r[0]_i_3_n_0 ),
        .I3(\char_r[0]_i_4_n_0 ),
        .I4(\char_r[4]_i_6_n_0 ),
        .I5(\char_r[0]_i_5_n_0 ),
        .O(\char_r[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFC0C40000C0C4)) 
    \char_r[0]_i_3 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(data2),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_r[0]_i_6_n_0 ),
        .O(\char_r[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \char_r[0]_i_4 
       (.I0(data36),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h000000000202FF00)) 
    \char_r[0]_i_5 
       (.I0(\char_r[0]_i_7_n_0 ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(\char_r[0]_i_8_n_0 ),
        .I4(\char_idx_r_reg_n_0_[5] ),
        .I5(\char_idx_r_reg_n_0_[4] ),
        .O(\char_r[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h00BB883000888830)) 
    \char_r[0]_i_6 
       (.I0(data27),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(data2),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[2] ),
        .I5(data28),
        .O(\char_r[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFACF0ACFFAC00AC0)) 
    \char_r[0]_i_7 
       (.I0(data2),
        .I1(data28),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(data27),
        .I5(data32),
        .O(\char_r[0]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h08228020)) 
    \char_r[0]_i_8 
       (.I0(data2),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .O(\char_r[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAF40FFFFAF400000)) 
    \char_r[1]_i_1 
       (.I0(\char_r[2]_i_2_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_5_n_0 ),
        .I3(\char_r[6]_i_3_n_0 ),
        .I4(\char_idx_r[5]_i_3_n_0 ),
        .I5(\char_r[1]_i_2_n_0 ),
        .O(char_r0_in[1]));
  LUT6 #(
    .INIT(64'h333030303030B8B8)) 
    \char_r[1]_i_2 
       (.I0(\char_r[1]_i_3_n_0 ),
        .I1(\char_idx_r_reg_n_0_[5] ),
        .I2(\char_r[1]_i_4_n_0 ),
        .I3(\char_r[1]_i_5_n_0 ),
        .I4(\char_idx_r_reg_n_0_[4] ),
        .I5(\char_idx_r_reg_n_0_[3] ),
        .O(\char_r[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0C0C0A0A0C0CFA0A)) 
    \char_r[1]_i_3 
       (.I0(data28),
        .I1(data33),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(data27),
        .I4(\char_idx_r_reg_n_0_[0] ),
        .I5(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h004040444040C8C0)) 
    \char_r[1]_i_4 
       (.I0(\char_idx_r_reg_n_0_[4] ),
        .I1(data2),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFC300000E2E2F0F0)) 
    \char_r[1]_i_5 
       (.I0(data27),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(data2),
        .I3(data36),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(\char_idx_r_reg_n_0_[0] ),
        .O(\char_r[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hEF00FFFFEF000000)) 
    \char_r[2]_i_1 
       (.I0(\char_r[2]_i_2_n_0 ),
        .I1(\char_r[6]_i_3_n_0 ),
        .I2(\char_r[6]_i_5_n_0 ),
        .I3(\char_r[6]_i_4_n_0 ),
        .I4(\char_idx_r[5]_i_3_n_0 ),
        .I5(\char_r[2]_i_3_n_0 ),
        .O(char_r0_in[2]));
  LUT6 #(
    .INIT(64'h20AA202220882000)) 
    \char_r[2]_i_10 
       (.I0(\char_r[6]_i_22_n_0 ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(data2),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data28),
        .I5(data33),
        .O(\char_r[2]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0A0A0A000C0C0C00)) 
    \char_r[2]_i_11 
       (.I0(\hex_r_reg[1] [4]),
        .I1(\hex_r_reg[1] [0]),
        .I2(\char_r[1]_i_2_n_0 ),
        .I3(\char_r[6]_i_34_n_0 ),
        .I4(\char_r[0]_i_5_n_0 ),
        .I5(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\char_r[2]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hAFF0C0A0A000C0A0)) 
    \char_r[2]_i_12 
       (.I0(data2),
        .I1(data28),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data27),
        .O(\char_r[2]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hFFE4FFE4FFE400E4)) 
    \char_r[2]_i_2 
       (.I0(\hex_digit_idx_r_reg_n_0_[1] ),
        .I1(\char_r[2]_i_4_n_0 ),
        .I2(\char_r[2]_i_5_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[2] ),
        .I4(\char_r[2]_i_6_n_0 ),
        .I5(\char_r[2]_i_7_n_0 ),
        .O(\char_r[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFCCEFCCEC)) 
    \char_r[2]_i_3 
       (.I0(\char_r[2]_i_8_n_0 ),
        .I1(\char_r[6]_i_20_n_0 ),
        .I2(\char_idx_r_reg_n_0_[4] ),
        .I3(\char_idx_r_reg_n_0_[5] ),
        .I4(\char_r[2]_i_9_n_0 ),
        .I5(\char_r[2]_i_10_n_0 ),
        .O(\char_r[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \char_r[2]_i_4 
       (.I0(\char_r[6]_i_23_n_0 ),
        .I1(\hex_r_reg[2] [0]),
        .I2(\char_r[6]_i_24_n_0 ),
        .I3(\hex_r_reg[2] [4]),
        .I4(\char_r[2]_i_11_n_0 ),
        .O(\char_r[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00F0000000CCAA00)) 
    \char_r[2]_i_5 
       (.I0(\hex_r_reg[1] [8]),
        .I1(\hex_r_reg[2] [8]),
        .I2(\hex_r_reg[2] [12]),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\char_r[1]_i_2_n_0 ),
        .I5(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\char_r[2]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hA0C0)) 
    \char_r[2]_i_6 
       (.I0(\hex_r_reg[2] [28]),
        .I1(\hex_r_reg[2] [20]),
        .I2(\char_r[6]_i_24_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[2]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hA0C0)) 
    \char_r[2]_i_7 
       (.I0(\hex_r_reg[2] [24]),
        .I1(\hex_r_reg[2] [16]),
        .I2(\char_r[6]_i_23_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF448400004484)) 
    \char_r[2]_i_8 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(data2),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_r[2]_i_12_n_0 ),
        .O(\char_r[2]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h2A288028)) 
    \char_r[2]_i_9 
       (.I0(data2),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(\char_idx_r_reg_n_0_[0] ),
        .O(\char_r[2]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h10FF1000)) 
    \char_r[3]_i_1 
       (.I0(\char_r[6]_i_3_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_5_n_0 ),
        .I3(\char_idx_r[5]_i_3_n_0 ),
        .I4(\char_r[3]_i_2_n_0 ),
        .O(char_r0_in[3]));
  LUT6 #(
    .INIT(64'h00003030FF00AAAA)) 
    \char_r[3]_i_2 
       (.I0(\char_r[3]_i_3_n_0 ),
        .I1(\char_r[3]_i_4_n_0 ),
        .I2(\char_r[3]_i_5_n_0 ),
        .I3(\char_r[3]_i_6_n_0 ),
        .I4(\char_idx_r_reg_n_0_[4] ),
        .I5(\char_idx_r_reg_n_0_[5] ),
        .O(\char_r[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h082A2AA8)) 
    \char_r[3]_i_3 
       (.I0(data2),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .O(\char_r[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \char_r[3]_i_4 
       (.I0(\char_idx_r_reg_n_0_[3] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hCCFFAAF0CC00AAF0)) 
    \char_r[3]_i_5 
       (.I0(data28),
        .I1(data35),
        .I2(data36),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data27),
        .O(\char_r[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFA0200000A020)) 
    \char_r[3]_i_6 
       (.I0(data2),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_r[3]_i_7_n_0 ),
        .O(\char_r[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCF0A0000C00A0000)) 
    \char_r[3]_i_7 
       (.I0(data28),
        .I1(data32),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(data27),
        .O(\char_r[3]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h57FF5700)) 
    \char_r[4]_i_1 
       (.I0(\char_r[6]_i_5_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_3_n_0 ),
        .I3(\char_idx_r[5]_i_3_n_0 ),
        .I4(\char_r[4]_i_2_n_0 ),
        .O(char_r0_in[4]));
  LUT6 #(
    .INIT(64'hCCFCEEEECCCCEEEE)) 
    \char_r[4]_i_2 
       (.I0(\char_r[4]_i_3_n_0 ),
        .I1(\char_r[4]_i_4_n_0 ),
        .I2(\char_r[4]_i_5_n_0 ),
        .I3(\char_idx_r_reg_n_0_[4] ),
        .I4(\char_idx_r_reg_n_0_[5] ),
        .I5(\char_r[4]_i_6_n_0 ),
        .O(\char_r[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h046000000A200000)) 
    \char_r[4]_i_3 
       (.I0(\char_idx_r_reg_n_0_[4] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(\char_idx_r_reg_n_0_[0] ),
        .I4(data2),
        .I5(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8A0A820288088000)) 
    \char_r[4]_i_4 
       (.I0(\char_r[6]_i_22_n_0 ),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(data33),
        .I4(data2),
        .I5(data28),
        .O(\char_r[4]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \char_r[4]_i_5 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(data2),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[4]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \char_r[4]_i_6 
       (.I0(\char_idx_r_reg_n_0_[2] ),
        .I1(\char_idx_r_reg_n_0_[3] ),
        .O(\char_r[4]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h57FF5700)) 
    \char_r[5]_i_1 
       (.I0(\char_r[6]_i_5_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_3_n_0 ),
        .I3(\char_idx_r[5]_i_3_n_0 ),
        .I4(\char_r[5]_i_2_n_0 ),
        .O(char_r0_in[5]));
  LUT6 #(
    .INIT(64'hFEFFFEFAFAFAFAFA)) 
    \char_r[5]_i_2 
       (.I0(\char_r[5]_i_3_n_0 ),
        .I1(data32),
        .I2(\char_r[5]_i_4_n_0 ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(data27),
        .I5(\char_r[6]_i_22_n_0 ),
        .O(\char_r[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \char_r[5]_i_3 
       (.I0(\char_idx_r_reg_n_0_[5] ),
        .I1(\char_idx_r_reg_n_0_[4] ),
        .I2(\char_r[5]_i_5_n_0 ),
        .O(\char_r[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h1100110010000000)) 
    \char_r[5]_i_4 
       (.I0(\char_idx_r_reg_n_0_[4] ),
        .I1(\char_idx_r_reg_n_0_[5] ),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(data2),
        .I4(\char_idx_r_reg_n_0_[1] ),
        .I5(\char_r[3]_i_4_n_0 ),
        .O(\char_r[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFE010F000E010F0)) 
    \char_r[5]_i_5 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(\char_idx_r_reg_n_0_[1] ),
        .I2(data2),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(data27),
        .O(\char_r[5]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hA0C0)) 
    \char_r[6]_i_10 
       (.I0(\hex_r_reg[2] [25]),
        .I1(\hex_r_reg[2] [17]),
        .I2(\char_r[6]_i_23_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hA0C0)) 
    \char_r[6]_i_11 
       (.I0(\hex_r_reg[2] [30]),
        .I1(\hex_r_reg[2] [22]),
        .I2(\char_r[6]_i_24_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hA0C0)) 
    \char_r[6]_i_12 
       (.I0(\hex_r_reg[2] [26]),
        .I1(\hex_r_reg[2] [18]),
        .I2(\char_r[6]_i_23_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hB3B3B3B3B3B3B080)) 
    \char_r[6]_i_13 
       (.I0(\hex_r_reg[2] [10]),
        .I1(\hex_digit_idx_r_reg_n_0_[1] ),
        .I2(\char_r[6]_i_23_n_0 ),
        .I3(\hex_r_reg[2] [2]),
        .I4(\char_r[6]_i_26_n_0 ),
        .I5(\char_r[6]_i_27_n_0 ),
        .O(\char_r[6]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \char_r[6]_i_14 
       (.I0(\hex_digit_idx_r_reg_n_0_[0] ),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_5_n_0 ),
        .I3(\char_r[6]_i_28_n_0 ),
        .I4(\char_r[6]_i_29_n_0 ),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_14_n_0 ));
  LUT4 #(
    .INIT(16'hA0C0)) 
    \char_r[6]_i_15 
       (.I0(\hex_r_reg[2] [31]),
        .I1(\hex_r_reg[2] [23]),
        .I2(\char_r[6]_i_24_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'hA0C0)) 
    \char_r[6]_i_16 
       (.I0(\hex_r_reg[2] [27]),
        .I1(\hex_r_reg[2] [19]),
        .I2(\char_r[6]_i_23_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_16_n_0 ));
  LUT6 #(
    .INIT(64'hB3B3B3B3B3B3B080)) 
    \char_r[6]_i_17 
       (.I0(\hex_r_reg[2] [11]),
        .I1(\hex_digit_idx_r_reg_n_0_[1] ),
        .I2(\char_r[6]_i_23_n_0 ),
        .I3(\hex_r_reg[2] [3]),
        .I4(\char_r[6]_i_30_n_0 ),
        .I5(\char_r[6]_i_31_n_0 ),
        .O(\char_r[6]_i_17_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \char_r[6]_i_18 
       (.I0(\char_idx_r_reg_n_0_[4] ),
        .I1(\char_idx_r_reg_n_0_[5] ),
        .O(\char_r[6]_i_18_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFAAA20000AAA2)) 
    \char_r[6]_i_19 
       (.I0(data2),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_idx_r_reg_n_0_[0] ),
        .I3(\char_idx_r_reg_n_0_[1] ),
        .I4(\char_idx_r_reg_n_0_[3] ),
        .I5(\char_r[6]_i_32_n_0 ),
        .O(\char_r[6]_i_19_n_0 ));
  LUT5 #(
    .INIT(32'hE0FFE000)) 
    \char_r[6]_i_2 
       (.I0(\char_r[6]_i_3_n_0 ),
        .I1(\char_r[6]_i_4_n_0 ),
        .I2(\char_r[6]_i_5_n_0 ),
        .I3(\char_idx_r[5]_i_3_n_0 ),
        .I4(\char_r[6]_i_6_n_0 ),
        .O(char_r0_in[6]));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \char_r[6]_i_20 
       (.I0(\char_idx_r_reg_n_0_[2] ),
        .I1(\char_idx_r_reg_n_0_[3] ),
        .I2(\char_idx_r_reg_n_0_[5] ),
        .I3(\char_idx_r_reg_n_0_[4] ),
        .I4(\char_idx_r[5]_i_5_n_0 ),
        .I5(data27),
        .O(\char_r[6]_i_20_n_0 ));
  LUT6 #(
    .INIT(64'h2800A800A0002000)) 
    \char_r[6]_i_21 
       (.I0(\char_r[6]_i_33_n_0 ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(data2),
        .I4(\char_idx_r_reg_n_0_[0] ),
        .I5(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_21_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \char_r[6]_i_22 
       (.I0(\char_idx_r_reg_n_0_[4] ),
        .I1(\char_idx_r_reg_n_0_[5] ),
        .I2(\char_idx_r_reg_n_0_[2] ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .O(\char_r[6]_i_22_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000070000)) 
    \char_r[6]_i_23 
       (.I0(\char_r[6]_i_18_n_0 ),
        .I1(\char_r[0]_i_3_n_0 ),
        .I2(\char_r[6]_i_28_n_0 ),
        .I3(\char_r[0]_i_5_n_0 ),
        .I4(\char_r[1]_i_2_n_0 ),
        .I5(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\char_r[6]_i_23_n_0 ));
  LUT6 #(
    .INIT(64'h0007000000000000)) 
    \char_r[6]_i_24 
       (.I0(\char_r[6]_i_18_n_0 ),
        .I1(\char_r[0]_i_3_n_0 ),
        .I2(\char_r[6]_i_28_n_0 ),
        .I3(\char_r[0]_i_5_n_0 ),
        .I4(\char_r[1]_i_2_n_0 ),
        .I5(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\char_r[6]_i_24_n_0 ));
  LUT6 #(
    .INIT(64'h0A0A0A000C0C0C00)) 
    \char_r[6]_i_25 
       (.I0(\hex_r_reg[1] [5]),
        .I1(\hex_r_reg[1] [1]),
        .I2(\char_r[1]_i_2_n_0 ),
        .I3(\char_r[6]_i_34_n_0 ),
        .I4(\char_r[0]_i_5_n_0 ),
        .I5(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\char_r[6]_i_25_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \char_r[6]_i_26 
       (.I0(\hex_digit_idx_r_reg_n_0_[0] ),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_5_n_0 ),
        .I3(\char_r[6]_i_28_n_0 ),
        .I4(\char_r[6]_i_29_n_0 ),
        .I5(\hex_r_reg[2] [6]),
        .O(\char_r[6]_i_26_n_0 ));
  LUT6 #(
    .INIT(64'h0A0A0A000C0C0C00)) 
    \char_r[6]_i_27 
       (.I0(\hex_r_reg[1] [6]),
        .I1(\hex_r_reg[1] [2]),
        .I2(\char_r[1]_i_2_n_0 ),
        .I3(\char_r[6]_i_34_n_0 ),
        .I4(\char_r[0]_i_5_n_0 ),
        .I5(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\char_r[6]_i_27_n_0 ));
  LUT6 #(
    .INIT(64'h0000000010000000)) 
    \char_r[6]_i_28 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(\char_idx_r_reg_n_0_[0] ),
        .I2(data36),
        .I3(\char_r[4]_i_6_n_0 ),
        .I4(\char_idx_r_reg_n_0_[5] ),
        .I5(\char_idx_r_reg_n_0_[4] ),
        .O(\char_r[6]_i_28_n_0 ));
  LUT6 #(
    .INIT(64'h8A8A808A8A8A8080)) 
    \char_r[6]_i_29 
       (.I0(\char_r[6]_i_18_n_0 ),
        .I1(\char_r[0]_i_6_n_0 ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(\char_r[6]_i_35_n_0 ),
        .I5(\char_r[4]_i_5_n_0 ),
        .O(\char_r[6]_i_29_n_0 ));
  LUT6 #(
    .INIT(64'hFFE4FFE4FFE400E4)) 
    \char_r[6]_i_3 
       (.I0(\hex_digit_idx_r_reg_n_0_[1] ),
        .I1(\char_r[6]_i_7_n_0 ),
        .I2(\char_r[6]_i_8_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[2] ),
        .I4(\char_r[6]_i_9_n_0 ),
        .I5(\char_r[6]_i_10_n_0 ),
        .O(\char_r[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \char_r[6]_i_30 
       (.I0(\hex_digit_idx_r_reg_n_0_[0] ),
        .I1(\char_r[1]_i_2_n_0 ),
        .I2(\char_r[0]_i_5_n_0 ),
        .I3(\char_r[6]_i_28_n_0 ),
        .I4(\char_r[6]_i_29_n_0 ),
        .I5(\hex_r_reg[2] [7]),
        .O(\char_r[6]_i_30_n_0 ));
  LUT6 #(
    .INIT(64'h0A0A0A000C0C0C00)) 
    \char_r[6]_i_31 
       (.I0(\hex_r_reg[1] [7]),
        .I1(\hex_r_reg[1] [3]),
        .I2(\char_r[1]_i_2_n_0 ),
        .I3(\char_r[6]_i_34_n_0 ),
        .I4(\char_r[0]_i_5_n_0 ),
        .I5(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\char_r[6]_i_31_n_0 ));
  LUT6 #(
    .INIT(64'hFFCC00CCE444E444)) 
    \char_r[6]_i_32 
       (.I0(\char_idx_r_reg_n_0_[0] ),
        .I1(data2),
        .I2(data28),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .I4(data27),
        .I5(\char_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_32_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \char_r[6]_i_33 
       (.I0(\char_idx_r_reg_n_0_[5] ),
        .I1(\char_idx_r_reg_n_0_[4] ),
        .O(\char_r[6]_i_33_n_0 ));
  LUT6 #(
    .INIT(64'hFFF8F8F888888888)) 
    \char_r[6]_i_34 
       (.I0(\char_r[6]_i_36_n_0 ),
        .I1(\char_r[0]_i_4_n_0 ),
        .I2(\char_r[6]_i_37_n_0 ),
        .I3(\char_idx_r_reg_n_0_[3] ),
        .I4(\char_r[0]_i_6_n_0 ),
        .I5(\char_r[6]_i_18_n_0 ),
        .O(\char_r[6]_i_34_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \char_r[6]_i_35 
       (.I0(\char_idx_r_reg_n_0_[1] ),
        .I1(data2),
        .O(\char_r[6]_i_35_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    \char_r[6]_i_36 
       (.I0(\char_idx_r_reg_n_0_[4] ),
        .I1(\char_idx_r_reg_n_0_[5] ),
        .I2(\char_idx_r_reg_n_0_[3] ),
        .I3(\char_idx_r_reg_n_0_[2] ),
        .O(\char_r[6]_i_36_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h50005100)) 
    \char_r[6]_i_37 
       (.I0(\char_idx_r_reg_n_0_[3] ),
        .I1(\char_idx_r_reg_n_0_[2] ),
        .I2(\char_idx_r_reg_n_0_[1] ),
        .I3(data2),
        .I4(\char_idx_r_reg_n_0_[0] ),
        .O(\char_r[6]_i_37_n_0 ));
  LUT6 #(
    .INIT(64'hEFEFEFE0EFE0EFE0)) 
    \char_r[6]_i_4 
       (.I0(\char_r[6]_i_11_n_0 ),
        .I1(\char_r[6]_i_12_n_0 ),
        .I2(\hex_digit_idx_r_reg_n_0_[2] ),
        .I3(\char_r[6]_i_13_n_0 ),
        .I4(\hex_r_reg[2] [14]),
        .I5(\char_r[6]_i_14_n_0 ),
        .O(\char_r[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hEFEFEFE0EFE0EFE0)) 
    \char_r[6]_i_5 
       (.I0(\char_r[6]_i_15_n_0 ),
        .I1(\char_r[6]_i_16_n_0 ),
        .I2(\hex_digit_idx_r_reg_n_0_[2] ),
        .I3(\char_r[6]_i_17_n_0 ),
        .I4(\hex_r_reg[2] [15]),
        .I5(\char_r[6]_i_14_n_0 ),
        .O(\char_r[6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFF8FFF8FFF8)) 
    \char_r[6]_i_6 
       (.I0(\char_r[6]_i_18_n_0 ),
        .I1(\char_r[6]_i_19_n_0 ),
        .I2(\char_r[6]_i_20_n_0 ),
        .I3(\char_r[6]_i_21_n_0 ),
        .I4(\char_r[6]_i_22_n_0 ),
        .I5(data27),
        .O(\char_r[6]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \char_r[6]_i_7 
       (.I0(\char_r[6]_i_23_n_0 ),
        .I1(\hex_r_reg[2] [1]),
        .I2(\char_r[6]_i_24_n_0 ),
        .I3(\hex_r_reg[2] [5]),
        .I4(\char_r[6]_i_25_n_0 ),
        .O(\char_r[6]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h00F0000000CCAA00)) 
    \char_r[6]_i_8 
       (.I0(\hex_r_reg[1] [9]),
        .I1(\hex_r_reg[2] [9]),
        .I2(\hex_r_reg[2] [13]),
        .I3(\char_r[0]_i_2_n_0 ),
        .I4(\char_r[1]_i_2_n_0 ),
        .I5(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\char_r[6]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hA0C0)) 
    \char_r[6]_i_9 
       (.I0(\hex_r_reg[2] [29]),
        .I1(\hex_r_reg[2] [21]),
        .I2(\char_r[6]_i_24_n_0 ),
        .I3(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\char_r[6]_i_9_n_0 ));
  FDRE \char_r_reg[0] 
       (.C(clk),
        .CE(u_printc_n_6),
        .D(char_r0_in[0]),
        .Q(\char_r_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \char_r_reg[1] 
       (.C(clk),
        .CE(u_printc_n_6),
        .D(char_r0_in[1]),
        .Q(\char_r_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \char_r_reg[2] 
       (.C(clk),
        .CE(u_printc_n_6),
        .D(char_r0_in[2]),
        .Q(\char_r_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \char_r_reg[3] 
       (.C(clk),
        .CE(u_printc_n_6),
        .D(char_r0_in[3]),
        .Q(\char_r_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \char_r_reg[4] 
       (.C(clk),
        .CE(u_printc_n_6),
        .D(char_r0_in[4]),
        .Q(\char_r_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \char_r_reg[5] 
       (.C(clk),
        .CE(u_printc_n_6),
        .D(char_r0_in[5]),
        .Q(\char_r_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \char_r_reg[6] 
       (.C(clk),
        .CE(u_printc_n_6),
        .D(char_r0_in[6]),
        .Q(\char_r_reg_n_0_[6] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAAAABFFFAAAA8000)) 
    \hex_digit_idx_r[0]_i_1 
       (.I0(hex_digit_idx_r[0]),
        .I1(\FSM_sequential_state_r[0]_i_2_n_0 ),
        .I2(\hex_digit_idx_r[2]_i_3_n_0 ),
        .I3(\FSM_sequential_state_r[1]_i_2_n_0 ),
        .I4(u_printc_n_5),
        .I5(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(\hex_digit_idx_r[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h15)) 
    \hex_digit_idx_r[0]_i_2 
       (.I0(state_r[0]),
        .I1(\hex_digit_idx_r_reg_n_0_[0] ),
        .I2(state_r[1]),
        .O(hex_digit_idx_r[0]));
  LUT6 #(
    .INIT(64'hAAAABFFFAAAA8000)) 
    \hex_digit_idx_r[1]_i_1 
       (.I0(hex_digit_idx_r[1]),
        .I1(\FSM_sequential_state_r[0]_i_2_n_0 ),
        .I2(\hex_digit_idx_r[2]_i_3_n_0 ),
        .I3(\FSM_sequential_state_r[1]_i_2_n_0 ),
        .I4(u_printc_n_5),
        .I5(\hex_digit_idx_r_reg_n_0_[1] ),
        .O(\hex_digit_idx_r[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hD7)) 
    \hex_digit_idx_r[1]_i_2 
       (.I0(state_r[1]),
        .I1(\hex_digit_idx_r_reg_n_0_[1] ),
        .I2(\hex_digit_idx_r_reg_n_0_[0] ),
        .O(hex_digit_idx_r[1]));
  LUT6 #(
    .INIT(64'hAAAABFFFAAAA8000)) 
    \hex_digit_idx_r[2]_i_1 
       (.I0(hex_digit_idx_r[2]),
        .I1(\FSM_sequential_state_r[0]_i_2_n_0 ),
        .I2(\hex_digit_idx_r[2]_i_3_n_0 ),
        .I3(\FSM_sequential_state_r[1]_i_2_n_0 ),
        .I4(u_printc_n_5),
        .I5(\hex_digit_idx_r_reg_n_0_[2] ),
        .O(\hex_digit_idx_r[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hFD57)) 
    \hex_digit_idx_r[2]_i_2 
       (.I0(state_r[1]),
        .I1(\hex_digit_idx_r_reg_n_0_[1] ),
        .I2(\hex_digit_idx_r_reg_n_0_[0] ),
        .I3(\hex_digit_idx_r_reg_n_0_[2] ),
        .O(hex_digit_idx_r[2]));
  LUT2 #(
    .INIT(4'h2)) 
    \hex_digit_idx_r[2]_i_3 
       (.I0(rst_n),
        .I1(state_r[1]),
        .O(\hex_digit_idx_r[2]_i_3_n_0 ));
  FDRE \hex_digit_idx_r_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\hex_digit_idx_r[0]_i_1_n_0 ),
        .Q(\hex_digit_idx_r_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \hex_digit_idx_r_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\hex_digit_idx_r[1]_i_1_n_0 ),
        .Q(\hex_digit_idx_r_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \hex_digit_idx_r_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\hex_digit_idx_r[2]_i_1_n_0 ),
        .Q(\hex_digit_idx_r_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \hex_r_reg[1][0] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[0]),
        .Q(\hex_r_reg[1] [0]),
        .R(1'b0));
  FDRE \hex_r_reg[1][1] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[1]),
        .Q(\hex_r_reg[1] [1]),
        .R(1'b0));
  FDRE \hex_r_reg[1][2] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[2]),
        .Q(\hex_r_reg[1] [2]),
        .R(1'b0));
  FDRE \hex_r_reg[1][3] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[3]),
        .Q(\hex_r_reg[1] [3]),
        .R(1'b0));
  FDRE \hex_r_reg[1][4] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[4]),
        .Q(\hex_r_reg[1] [4]),
        .R(1'b0));
  FDRE \hex_r_reg[1][5] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[5]),
        .Q(\hex_r_reg[1] [5]),
        .R(1'b0));
  FDRE \hex_r_reg[1][6] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[6]),
        .Q(\hex_r_reg[1] [6]),
        .R(1'b0));
  FDRE \hex_r_reg[1][7] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[7]),
        .Q(\hex_r_reg[1] [7]),
        .R(1'b0));
  FDRE \hex_r_reg[1][8] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[8]),
        .Q(\hex_r_reg[1] [8]),
        .R(1'b0));
  FDRE \hex_r_reg[1][9] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(block_mem_addr_o[9]),
        .Q(\hex_r_reg[1] [9]),
        .R(1'b0));
  FDRE \hex_r_reg[2][0] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[0]),
        .Q(\hex_r_reg[2] [0]),
        .R(1'b0));
  FDRE \hex_r_reg[2][10] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[10]),
        .Q(\hex_r_reg[2] [10]),
        .R(1'b0));
  FDRE \hex_r_reg[2][11] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[11]),
        .Q(\hex_r_reg[2] [11]),
        .R(1'b0));
  FDRE \hex_r_reg[2][12] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[12]),
        .Q(\hex_r_reg[2] [12]),
        .R(1'b0));
  FDRE \hex_r_reg[2][13] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[13]),
        .Q(\hex_r_reg[2] [13]),
        .R(1'b0));
  FDRE \hex_r_reg[2][14] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[14]),
        .Q(\hex_r_reg[2] [14]),
        .R(1'b0));
  FDRE \hex_r_reg[2][15] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[15]),
        .Q(\hex_r_reg[2] [15]),
        .R(1'b0));
  FDRE \hex_r_reg[2][16] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[16]),
        .Q(\hex_r_reg[2] [16]),
        .R(1'b0));
  FDRE \hex_r_reg[2][17] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[17]),
        .Q(\hex_r_reg[2] [17]),
        .R(1'b0));
  FDRE \hex_r_reg[2][18] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[18]),
        .Q(\hex_r_reg[2] [18]),
        .R(1'b0));
  FDRE \hex_r_reg[2][19] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[19]),
        .Q(\hex_r_reg[2] [19]),
        .R(1'b0));
  FDRE \hex_r_reg[2][1] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[1]),
        .Q(\hex_r_reg[2] [1]),
        .R(1'b0));
  FDRE \hex_r_reg[2][20] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[20]),
        .Q(\hex_r_reg[2] [20]),
        .R(1'b0));
  FDRE \hex_r_reg[2][21] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[21]),
        .Q(\hex_r_reg[2] [21]),
        .R(1'b0));
  FDRE \hex_r_reg[2][22] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[22]),
        .Q(\hex_r_reg[2] [22]),
        .R(1'b0));
  FDRE \hex_r_reg[2][23] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[23]),
        .Q(\hex_r_reg[2] [23]),
        .R(1'b0));
  FDRE \hex_r_reg[2][24] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[24]),
        .Q(\hex_r_reg[2] [24]),
        .R(1'b0));
  FDRE \hex_r_reg[2][25] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[25]),
        .Q(\hex_r_reg[2] [25]),
        .R(1'b0));
  FDRE \hex_r_reg[2][26] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[26]),
        .Q(\hex_r_reg[2] [26]),
        .R(1'b0));
  FDRE \hex_r_reg[2][27] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[27]),
        .Q(\hex_r_reg[2] [27]),
        .R(1'b0));
  FDRE \hex_r_reg[2][28] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[28]),
        .Q(\hex_r_reg[2] [28]),
        .R(1'b0));
  FDRE \hex_r_reg[2][29] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[29]),
        .Q(\hex_r_reg[2] [29]),
        .R(1'b0));
  FDRE \hex_r_reg[2][2] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[2]),
        .Q(\hex_r_reg[2] [2]),
        .R(1'b0));
  FDRE \hex_r_reg[2][30] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[30]),
        .Q(\hex_r_reg[2] [30]),
        .R(1'b0));
  FDRE \hex_r_reg[2][31] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[31]),
        .Q(\hex_r_reg[2] [31]),
        .R(1'b0));
  FDRE \hex_r_reg[2][3] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[3]),
        .Q(\hex_r_reg[2] [3]),
        .R(1'b0));
  FDRE \hex_r_reg[2][4] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[4]),
        .Q(\hex_r_reg[2] [4]),
        .R(1'b0));
  FDRE \hex_r_reg[2][5] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[5]),
        .Q(\hex_r_reg[2] [5]),
        .R(1'b0));
  FDRE \hex_r_reg[2][6] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[6]),
        .Q(\hex_r_reg[2] [6]),
        .R(1'b0));
  FDRE \hex_r_reg[2][7] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[7]),
        .Q(\hex_r_reg[2] [7]),
        .R(1'b0));
  FDRE \hex_r_reg[2][8] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[8]),
        .Q(\hex_r_reg[2] [8]),
        .R(1'b0));
  FDRE \hex_r_reg[2][9] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(mem_dout_i[9]),
        .Q(\hex_r_reg[2] [9]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'hE)) 
    \string_r[216]_i_1 
       (.I0(Q[7]),
        .I1(Q[2]),
        .O(\string_r[216]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \string_r[256]_i_1 
       (.I0(Q[2]),
        .I1(Q[7]),
        .I2(Q[5]),
        .I3(Q[6]),
        .O(\string_r[256]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \string_r[265]_i_1 
       (.I0(Q[6]),
        .I1(Q[5]),
        .O(D));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \string_r[283]_i_1 
       (.I0(Q[5]),
        .I1(Q[6]),
        .I2(Q[7]),
        .O(\string_r[283]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    \string_r[288]_i_1 
       (.I0(rst_n),
        .I1(state_r[1]),
        .I2(state_r[0]),
        .O(\string_r[288]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \string_r[288]_i_2 
       (.I0(Q[5]),
        .I1(Q[6]),
        .I2(Q[2]),
        .O(\string_r[288]_i_2_n_0 ));
  FDRE \string_r_reg[16] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(Q[2]),
        .Q(data2),
        .R(1'b0));
  FDRE \string_r_reg[216] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(\string_r[216]_i_1_n_0 ),
        .Q(data27),
        .R(1'b0));
  FDRE \string_r_reg[224] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(Q[7]),
        .Q(data28),
        .R(1'b0));
  FDRE \string_r_reg[256] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(\string_r[256]_i_1_n_0 ),
        .Q(data32),
        .R(1'b0));
  FDRE \string_r_reg[265] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(D),
        .Q(data33),
        .R(1'b0));
  FDRE \string_r_reg[283] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(\string_r[283]_i_1_n_0 ),
        .Q(data35),
        .R(1'b0));
  FDRE \string_r_reg[288] 
       (.C(clk),
        .CE(\string_r[288]_i_1_n_0 ),
        .D(\string_r[288]_i_2_n_0 ),
        .Q(data36),
        .R(1'b0));
  total_design_host_top_wrapper_0_0_printc u_printc
       (.E(u_printc_n_6),
        .\FSM_sequential_state_r_reg[0] (u_printc_n_5),
        .\FSM_sequential_state_r_reg[0]_0 (u_printc_n_9),
        .\FSM_sequential_state_r_reg[0]_1 (\FSM_sequential_state_r[0]_i_2_n_0 ),
        .\FSM_sequential_state_r_reg[1] (u_printc_n_10),
        .\FSM_sequential_state_r_reg[1]_0 (\FSM_sequential_state_r[1]_i_2_n_0 ),
        .Q({\char_r_reg_n_0_[6] ,\char_r_reg_n_0_[5] ,\char_r_reg_n_0_[4] ,\char_r_reg_n_0_[3] ,\char_r_reg_n_0_[2] ,\char_r_reg_n_0_[1] ,\char_r_reg_n_0_[0] }),
        .SS(SR),
        .\char_idx_r_reg[0] (\char_idx_r[5]_i_3_n_0 ),
        .\char_idx_r_reg[0]_0 (\hex_digit_idx_r_reg_n_0_[1] ),
        .\char_idx_r_reg[0]_1 (\hex_digit_idx_r_reg_n_0_[0] ),
        .\char_idx_r_reg[0]_2 (\hex_digit_idx_r_reg_n_0_[2] ),
        .clk(clk),
        .hex_digit_idx_c_w(hex_digit_idx_c_w),
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
        .prints_start_w(prints_start_w),
        .rst_n(rst_n),
        .rst_n_0(u_printc_n_7),
        .state_r(state_r));
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
