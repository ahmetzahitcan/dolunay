-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
-- Date        : Sun May 10 16:13:09 2026
-- Host        : fedora running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/azc/Belgeler/dolunay/bd/total_design/ip/total_design_core_top_0_0/total_design_core_top_0_0_stub.vhdl
-- Design      : total_design_core_top_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity total_design_core_top_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    start_i : in STD_LOGIC;
    ready_o : out STD_LOGIC;
    wram_clk_o : out STD_LOGIC;
    wram_addr_o : out STD_LOGIC_VECTOR ( 14 downto 2 );
    wram_wen_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    wram_wdata_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    wram_rdata_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    irom_clk_a_o : out STD_LOGIC;
    irom_addr_a_o : out STD_LOGIC_VECTOR ( 13 downto 2 );
    irom_data_a_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    irom_clk_b_o : out STD_LOGIC;
    irom_addr_b_o : out STD_LOGIC_VECTOR ( 13 downto 2 );
    irom_data_b_i : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of total_design_core_top_0_0 : entity is "total_design_core_top_0_0,core_top,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of total_design_core_top_0_0 : entity is "total_design_core_top_0_0,core_top,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=core_top,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,W_WRAM_ADDR=15,W_IROM_ADDR=14}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of total_design_core_top_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of total_design_core_top_0_0 : entity is "module_ref";
end total_design_core_top_0_0;

architecture stub of total_design_core_top_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "clk,rst_n,start_i,ready_o,wram_clk_o,wram_addr_o[14:2],wram_wen_o[3:0],wram_wdata_o[31:0],wram_rdata_i[31:0],irom_clk_a_o,irom_addr_a_o[13:2],irom_data_a_i[31:0],irom_clk_b_o,irom_addr_b_o[13:2],irom_data_b_i[31:0]";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_MODE of rst_n : signal is "slave";
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of wram_clk_o : signal is "xilinx.com:interface:bram:1.0 WRAM CLK";
  attribute X_INTERFACE_MODE of wram_clk_o : signal is "master";
  attribute X_INTERFACE_PARAMETER of wram_clk_o : signal is "XIL_INTERFACENAME WRAM, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  attribute X_INTERFACE_INFO of wram_addr_o : signal is "xilinx.com:interface:bram:1.0 WRAM ADDR";
  attribute X_INTERFACE_INFO of wram_wen_o : signal is "xilinx.com:interface:bram:1.0 WRAM WE";
  attribute X_INTERFACE_INFO of wram_wdata_o : signal is "xilinx.com:interface:bram:1.0 WRAM DIN";
  attribute X_INTERFACE_INFO of wram_rdata_i : signal is "xilinx.com:interface:bram:1.0 WRAM DOUT";
  attribute X_INTERFACE_INFO of irom_clk_a_o : signal is "xilinx.com:interface:bram:1.0 IROM_A CLK";
  attribute X_INTERFACE_MODE of irom_clk_a_o : signal is "master";
  attribute X_INTERFACE_PARAMETER of irom_clk_a_o : signal is "XIL_INTERFACENAME IROM_A, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  attribute X_INTERFACE_INFO of irom_addr_a_o : signal is "xilinx.com:interface:bram:1.0 IROM_A ADDR";
  attribute X_INTERFACE_INFO of irom_data_a_i : signal is "xilinx.com:interface:bram:1.0 IROM_A DOUT";
  attribute X_INTERFACE_INFO of irom_clk_b_o : signal is "xilinx.com:interface:bram:1.0 IROM_B CLK";
  attribute X_INTERFACE_MODE of irom_clk_b_o : signal is "master";
  attribute X_INTERFACE_PARAMETER of irom_clk_b_o : signal is "XIL_INTERFACENAME IROM_B, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  attribute X_INTERFACE_INFO of irom_addr_b_o : signal is "xilinx.com:interface:bram:1.0 IROM_B ADDR";
  attribute X_INTERFACE_INFO of irom_data_b_i : signal is "xilinx.com:interface:bram:1.0 IROM_B DOUT";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "core_top,Vivado 2025.2";
begin
end;
