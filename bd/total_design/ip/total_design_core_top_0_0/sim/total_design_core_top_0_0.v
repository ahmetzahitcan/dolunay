// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2026 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:core_top:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module total_design_core_top_0_0 (
  clk,
  rst_n,
  start_i,
  ready_o,
  wram_clk_o,
  wram_addr_o,
  wram_wen_o,
  wram_wdata_o,
  wram_rdata_i,
  irom_clk_a_o,
  irom_addr_a_o,
  irom_data_a_i,
  irom_clk_b_o,
  irom_addr_b_o,
  irom_data_b_i
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, INSERT_VIP 0" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire rst_n;
input wire start_i;
output wire ready_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM CLK" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME WRAM, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *)
output wire wram_clk_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM ADDR" *)
output wire [11 : 2] wram_addr_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM WE" *)
output wire [3 : 0] wram_wen_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM DIN" *)
output wire [31 : 0] wram_wdata_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 WRAM DOUT" *)
input wire [31 : 0] wram_rdata_i;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_A CLK" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME IROM_A, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *)
output wire irom_clk_a_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_A ADDR" *)
output wire [11 : 2] irom_addr_a_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_A DOUT" *)
input wire [31 : 0] irom_data_a_i;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_B CLK" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME IROM_B, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *)
output wire irom_clk_b_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_B ADDR" *)
output wire [11 : 2] irom_addr_b_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 IROM_B DOUT" *)
input wire [31 : 0] irom_data_b_i;

  core_top #(
    .W_WRAM_ADDR(12),
    .W_IROM_ADDR(12)
  ) inst (
    .clk(clk),
    .rst_n(rst_n),
    .start_i(start_i),
    .ready_o(ready_o),
    .wram_clk_o(wram_clk_o),
    .wram_addr_o(wram_addr_o),
    .wram_wen_o(wram_wen_o),
    .wram_wdata_o(wram_wdata_o),
    .wram_rdata_i(wram_rdata_i),
    .irom_clk_a_o(irom_clk_a_o),
    .irom_addr_a_o(irom_addr_a_o),
    .irom_data_a_i(irom_data_a_i),
    .irom_clk_b_o(irom_clk_b_o),
    .irom_addr_b_o(irom_addr_b_o),
    .irom_data_b_i(irom_data_b_i)
  );
endmodule
