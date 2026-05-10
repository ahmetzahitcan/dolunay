// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Sun May 10 16:13:09 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/azc/Belgeler/dolunay/bd/total_design/ip/total_design_core_top_0_0/total_design_core_top_0_0_stub.v
// Design      : total_design_core_top_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "total_design_core_top_0_0,core_top,{}" *) (* CORE_GENERATION_INFO = "total_design_core_top_0_0,core_top,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=core_top,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,W_WRAM_ADDR=15,W_IROM_ADDR=14}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "core_top,Vivado 2025.2" *) 
module total_design_core_top_0_0(clk, rst_n, start_i, ready_o, wram_clk_o, 
  wram_addr_o, wram_wen_o, wram_wdata_o, wram_rdata_i, irom_clk_a_o, irom_addr_a_o, 
  irom_data_a_i, irom_clk_b_o, irom_addr_b_o, irom_data_b_i)
/* synthesis syn_black_box black_box_pad_pin="rst_n,start_i,ready_o,wram_addr_o[14:2],wram_wen_o[3:0],wram_wdata_o[31:0],wram_rdata_i[31:0],irom_addr_a_o[13:2],irom_data_a_i[31:0],irom_addr_b_o[13:2],irom_data_b_i[31:0]" */
/* synthesis syn_force_seq_prim="clk" */
/* synthesis syn_force_seq_prim="wram_clk_o" */
/* synthesis syn_force_seq_prim="irom_clk_a_o" */
/* synthesis syn_force_seq_prim="irom_clk_b_o" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, INSERT_VIP 0" *) input clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst_n;
  input start_i;
  output ready_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME WRAM, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) output wram_clk_o /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM ADDR" *) output [14:2]wram_addr_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM WE" *) output [3:0]wram_wen_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM DIN" *) output [31:0]wram_wdata_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM DOUT" *) input [31:0]wram_rdata_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_A CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME IROM_A, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) output irom_clk_a_o /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_A ADDR" *) output [13:2]irom_addr_a_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_A DOUT" *) input [31:0]irom_data_a_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_B CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME IROM_B, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) output irom_clk_b_o /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_B ADDR" *) output [13:2]irom_addr_b_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_B DOUT" *) input [31:0]irom_data_b_i;
endmodule
