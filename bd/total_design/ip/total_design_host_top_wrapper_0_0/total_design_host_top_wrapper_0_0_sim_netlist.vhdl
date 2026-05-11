-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
-- Date        : Sun May 10 22:27:51 2026
-- Host        : fedora running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/azc/Belgeler/dolunay/bd/total_design/ip/total_design_host_top_wrapper_0_0/total_design_host_top_wrapper_0_0_sim_netlist.vhdl
-- Design      : total_design_host_top_wrapper_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity total_design_host_top_wrapper_0_0_printc is
  port (
    m_axi_awvalid : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    \FSM_sequential_state_r_reg[0]\ : out STD_LOGIC;
    \FSM_sequential_state_r_reg[1]\ : out STD_LOGIC;
    \FSM_sequential_state_r_reg[1]_0\ : out STD_LOGIC;
    rst_n_0 : out STD_LOGIC;
    rst_n_1 : out STD_LOGIC;
    \FSM_sequential_state_r_reg[1]_1\ : out STD_LOGIC;
    \hex_digit_idx_r_reg[0]\ : out STD_LOGIC;
    \FSM_sequential_state_r_reg[0]_0\ : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    rst_n_2 : out STD_LOGIC;
    SS : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    state_r : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \FSM_sequential_state_r_reg[1]_2\ : in STD_LOGIC;
    \FSM_sequential_state_r_reg[0]_1\ : in STD_LOGIC;
    \char_idx_r_reg[0]\ : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    char_idx_r : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \char_idx_r_reg[4]\ : in STD_LOGIC;
    \char_idx_r_reg[3]\ : in STD_LOGIC;
    \hex_digit_idx_r_reg[2]\ : in STD_LOGIC;
    \hex_digit_idx_r_reg[2]_0\ : in STD_LOGIC;
    \hex_digit_idx_r_reg[2]_1\ : in STD_LOGIC;
    \hex_digit_idx_r_reg[1]\ : in STD_LOGIC;
    \hex_digit_idx_r_reg[1]_0\ : in STD_LOGIC;
    \hex_digit_idx_r_reg[1]_1\ : in STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    \FSM_sequential_state_r_reg[0]_2\ : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of total_design_host_top_wrapper_0_0_printc : entity is "printc";
end total_design_host_top_wrapper_0_0_printc;

architecture STRUCTURE of total_design_host_top_wrapper_0_0_printc is
  signal \FSM_onehot_state_r[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_r[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_r[5]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_r[5]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[0]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[1]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[2]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[3]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[4]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[5]\ : STD_LOGIC;
  signal \FSM_sequential_state_r[1]_i_3_n_0\ : STD_LOGIC;
  signal \^ss\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal awready_recv_r_i_1_n_0 : STD_LOGIC;
  signal awready_recv_r_reg_n_0 : STD_LOGIC;
  signal c_ready_w : STD_LOGIC;
  signal \char_idx_r[5]_i_4_n_0\ : STD_LOGIC;
  signal char_r : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \char_r[6]_i_1_n_0\ : STD_LOGIC;
  signal \hex_digit_idx_r[2]_i_4_n_0\ : STD_LOGIC;
  signal \^m_axi_arvalid\ : STD_LOGIC;
  signal m_axi_arvalid_o_i_1_n_0 : STD_LOGIC;
  signal \^m_axi_awvalid\ : STD_LOGIC;
  signal m_axi_awvalid_o_i_1_n_0 : STD_LOGIC;
  signal \^m_axi_bready\ : STD_LOGIC;
  signal m_axi_bready_o_i_1_n_0 : STD_LOGIC;
  signal m_axi_bready_o_i_2_n_0 : STD_LOGIC;
  signal \^m_axi_rready\ : STD_LOGIC;
  signal m_axi_rready_o_i_1_n_0 : STD_LOGIC;
  signal \m_axi_wdata_o[6]_i_1_n_0\ : STD_LOGIC;
  signal \^m_axi_wvalid\ : STD_LOGIC;
  signal m_axi_wvalid_o_i_1_n_0 : STD_LOGIC;
  signal ready_o_i_1_n_0 : STD_LOGIC;
  signal wready_recv_r_i_1_n_0 : STD_LOGIC;
  signal wready_recv_r_reg_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_state_r[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \FSM_onehot_state_r[3]_i_1\ : label is "soft_lutpair2";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[0]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[1]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[2]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[3]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[4]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[5]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \char_r[6]_i_1__0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \hex_digit_idx_r[2]_i_4\ : label is "soft_lutpair1";
begin
  SS(0) <= \^ss\(0);
  m_axi_arvalid <= \^m_axi_arvalid\;
  m_axi_awvalid <= \^m_axi_awvalid\;
  m_axi_bready <= \^m_axi_bready\;
  m_axi_rready <= \^m_axi_rready\;
  m_axi_wvalid <= \^m_axi_wvalid\;
\FSM_onehot_state_r[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
        port map (
      I0 => m_axi_rdata(0),
      I1 => \FSM_onehot_state_r_reg_n_0_[2]\,
      I2 => \FSM_onehot_state_r_reg_n_0_[0]\,
      O => \FSM_onehot_state_r[1]_i_1_n_0\
    );
\FSM_onehot_state_r[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \FSM_onehot_state_r_reg_n_0_[2]\,
      I1 => m_axi_rdata(0),
      O => \FSM_onehot_state_r[3]_i_1_n_0\
    );
\FSM_onehot_state_r[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFF40"
    )
        port map (
      I0 => m_axi_arready,
      I1 => m_axi_rvalid,
      I2 => \FSM_onehot_state_r_reg_n_0_[2]\,
      I3 => \FSM_onehot_state_r_reg_n_0_[3]\,
      I4 => \FSM_onehot_state_r_reg_n_0_[1]\,
      I5 => \FSM_onehot_state_r[5]_i_2_n_0\,
      O => \FSM_onehot_state_r[5]_i_1_n_0\
    );
\FSM_onehot_state_r[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF8F8F8F8F8F8F8"
    )
        port map (
      I0 => state_r(1),
      I1 => \FSM_onehot_state_r_reg_n_0_[0]\,
      I2 => m_axi_bready_o_i_2_n_0,
      I3 => wready_recv_r_reg_n_0,
      I4 => awready_recv_r_reg_n_0,
      I5 => \FSM_onehot_state_r_reg_n_0_[4]\,
      O => \FSM_onehot_state_r[5]_i_2_n_0\
    );
\FSM_onehot_state_r_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state_r[5]_i_1_n_0\,
      D => \FSM_onehot_state_r_reg_n_0_[5]\,
      Q => \FSM_onehot_state_r_reg_n_0_[0]\,
      S => \^ss\(0)
    );
\FSM_onehot_state_r_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state_r[5]_i_1_n_0\,
      D => \FSM_onehot_state_r[1]_i_1_n_0\,
      Q => \FSM_onehot_state_r_reg_n_0_[1]\,
      R => \^ss\(0)
    );
\FSM_onehot_state_r_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state_r[5]_i_1_n_0\,
      D => \FSM_onehot_state_r_reg_n_0_[1]\,
      Q => \FSM_onehot_state_r_reg_n_0_[2]\,
      R => \^ss\(0)
    );
\FSM_onehot_state_r_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state_r[5]_i_1_n_0\,
      D => \FSM_onehot_state_r[3]_i_1_n_0\,
      Q => \FSM_onehot_state_r_reg_n_0_[3]\,
      R => \^ss\(0)
    );
\FSM_onehot_state_r_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state_r[5]_i_1_n_0\,
      D => \FSM_onehot_state_r_reg_n_0_[3]\,
      Q => \FSM_onehot_state_r_reg_n_0_[4]\,
      R => \^ss\(0)
    );
\FSM_onehot_state_r_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state_r[5]_i_1_n_0\,
      D => \FSM_onehot_state_r_reg_n_0_[4]\,
      Q => \FSM_onehot_state_r_reg_n_0_[5]\,
      R => \^ss\(0)
    );
\FSM_sequential_state_r[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4FFFF00"
    )
        port map (
      I0 => \FSM_sequential_state_r_reg[0]_1\,
      I1 => \FSM_sequential_state_r_reg[1]_2\,
      I2 => state_r(1),
      I3 => \FSM_sequential_state_r[1]_i_3_n_0\,
      I4 => state_r(0),
      O => \FSM_sequential_state_r_reg[1]\
    );
\FSM_sequential_state_r[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5F80"
    )
        port map (
      I0 => state_r(0),
      I1 => \FSM_sequential_state_r_reg[1]_2\,
      I2 => \FSM_sequential_state_r[1]_i_3_n_0\,
      I3 => state_r(1),
      O => \FSM_sequential_state_r_reg[0]\
    );
\FSM_sequential_state_r[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFAAFFFFABAAAAAA"
    )
        port map (
      I0 => \FSM_sequential_state_r_reg[0]_2\,
      I1 => \hex_digit_idx_r_reg[2]\,
      I2 => \hex_digit_idx_r_reg[2]_1\,
      I3 => c_ready_w,
      I4 => state_r(1),
      I5 => state_r(0),
      O => \FSM_sequential_state_r[1]_i_3_n_0\
    );
\addr_r[12]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst_n,
      O => \^ss\(0)
    );
awready_recv_r_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8FFF8800"
    )
        port map (
      I0 => m_axi_awready,
      I1 => \FSM_onehot_state_r_reg_n_0_[4]\,
      I2 => \FSM_onehot_state_r_reg_n_0_[3]\,
      I3 => rst_n,
      I4 => awready_recv_r_reg_n_0,
      O => awready_recv_r_i_1_n_0
    );
awready_recv_r_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => awready_recv_r_i_1_n_0,
      Q => awready_recv_r_reg_n_0,
      R => '0'
    );
\char_idx_r[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBFFBF88880080"
    )
        port map (
      I0 => char_idx_r(0),
      I1 => rst_n,
      I2 => \FSM_sequential_state_r_reg[1]_2\,
      I3 => \char_idx_r_reg[0]\,
      I4 => \char_idx_r[5]_i_4_n_0\,
      I5 => \char_idx_r_reg[3]\,
      O => rst_n_1
    );
\char_idx_r[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBFFBF88880080"
    )
        port map (
      I0 => char_idx_r(1),
      I1 => rst_n,
      I2 => \FSM_sequential_state_r_reg[1]_2\,
      I3 => \char_idx_r_reg[0]\,
      I4 => \char_idx_r[5]_i_4_n_0\,
      I5 => \char_idx_r_reg[4]\,
      O => rst_n_0
    );
\char_idx_r[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1011101000000000"
    )
        port map (
      I0 => state_r(1),
      I1 => state_r(0),
      I2 => \char_idx_r[5]_i_4_n_0\,
      I3 => \char_idx_r_reg[0]\,
      I4 => \FSM_sequential_state_r_reg[1]_2\,
      I5 => rst_n,
      O => \FSM_sequential_state_r_reg[1]_0\
    );
\char_idx_r[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA08"
    )
        port map (
      I0 => rst_n,
      I1 => \FSM_sequential_state_r_reg[1]_2\,
      I2 => \char_idx_r_reg[0]\,
      I3 => \char_idx_r[5]_i_4_n_0\,
      O => rst_n_2
    );
\char_idx_r[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000100FFFF"
    )
        port map (
      I0 => \hex_digit_idx_r_reg[1]_1\,
      I1 => \hex_digit_idx_r_reg[1]\,
      I2 => \hex_digit_idx_r_reg[2]_1\,
      I3 => c_ready_w,
      I4 => state_r(1),
      I5 => state_r(0),
      O => \char_idx_r[5]_i_4_n_0\
    );
\char_r[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => rst_n,
      I1 => \FSM_onehot_state_r_reg_n_0_[0]\,
      I2 => state_r(1),
      O => \char_r[6]_i_1_n_0\
    );
\char_r[6]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00A0C000"
    )
        port map (
      I0 => c_ready_w,
      I1 => \FSM_sequential_state_r_reg[1]_2\,
      I2 => rst_n,
      I3 => state_r(0),
      I4 => state_r(1),
      O => E(0)
    );
\char_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \char_r[6]_i_1_n_0\,
      D => Q(0),
      Q => char_r(0),
      R => '0'
    );
\char_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \char_r[6]_i_1_n_0\,
      D => Q(1),
      Q => char_r(1),
      R => '0'
    );
\char_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \char_r[6]_i_1_n_0\,
      D => Q(2),
      Q => char_r(2),
      R => '0'
    );
\char_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \char_r[6]_i_1_n_0\,
      D => Q(3),
      Q => char_r(3),
      R => '0'
    );
\char_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \char_r[6]_i_1_n_0\,
      D => Q(4),
      Q => char_r(4),
      R => '0'
    );
\char_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \char_r[6]_i_1_n_0\,
      D => Q(5),
      Q => char_r(5),
      R => '0'
    );
\char_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \char_r[6]_i_1_n_0\,
      D => Q(6),
      Q => char_r(6),
      R => '0'
    );
\hex_digit_idx_r[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44444FFF55555000"
    )
        port map (
      I0 => state_r(0),
      I1 => \hex_digit_idx_r_reg[1]_0\,
      I2 => \FSM_sequential_state_r_reg[0]_1\,
      I3 => \hex_digit_idx_r_reg[2]_0\,
      I4 => \hex_digit_idx_r[2]_i_4_n_0\,
      I5 => \hex_digit_idx_r_reg[1]\,
      O => \FSM_sequential_state_r_reg[0]_0\
    );
\hex_digit_idx_r[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEEFFFDDDDD000"
    )
        port map (
      I0 => \hex_digit_idx_r_reg[1]\,
      I1 => \hex_digit_idx_r_reg[1]_0\,
      I2 => \FSM_sequential_state_r_reg[0]_1\,
      I3 => \hex_digit_idx_r_reg[2]_0\,
      I4 => \hex_digit_idx_r[2]_i_4_n_0\,
      I5 => \hex_digit_idx_r_reg[1]_1\,
      O => \hex_digit_idx_r_reg[0]\
    );
\hex_digit_idx_r[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DDDDDFFF77777000"
    )
        port map (
      I0 => state_r(1),
      I1 => \hex_digit_idx_r_reg[2]\,
      I2 => \FSM_sequential_state_r_reg[0]_1\,
      I3 => \hex_digit_idx_r_reg[2]_0\,
      I4 => \hex_digit_idx_r[2]_i_4_n_0\,
      I5 => \hex_digit_idx_r_reg[2]_1\,
      O => \FSM_sequential_state_r_reg[1]_1\
    );
\hex_digit_idx_r[2]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4404"
    )
        port map (
      I0 => state_r(0),
      I1 => rst_n,
      I2 => state_r(1),
      I3 => c_ready_w,
      O => \hex_digit_idx_r[2]_i_4_n_0\
    );
m_axi_arvalid_o_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FFF000"
    )
        port map (
      I0 => \FSM_onehot_state_r_reg_n_0_[2]\,
      I1 => m_axi_arready,
      I2 => \FSM_onehot_state_r_reg_n_0_[1]\,
      I3 => rst_n,
      I4 => \^m_axi_arvalid\,
      O => m_axi_arvalid_o_i_1_n_0
    );
m_axi_arvalid_o_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => m_axi_arvalid_o_i_1_n_0,
      Q => \^m_axi_arvalid\,
      R => '0'
    );
m_axi_awvalid_o_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FFF000"
    )
        port map (
      I0 => m_axi_awready,
      I1 => \FSM_onehot_state_r_reg_n_0_[4]\,
      I2 => \FSM_onehot_state_r_reg_n_0_[3]\,
      I3 => rst_n,
      I4 => \^m_axi_awvalid\,
      O => m_axi_awvalid_o_i_1_n_0
    );
m_axi_awvalid_o_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => m_axi_awvalid_o_i_1_n_0,
      Q => \^m_axi_awvalid\,
      R => '0'
    );
m_axi_bready_o_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D555FFFFC0000000"
    )
        port map (
      I0 => m_axi_bready_o_i_2_n_0,
      I1 => wready_recv_r_reg_n_0,
      I2 => awready_recv_r_reg_n_0,
      I3 => \FSM_onehot_state_r_reg_n_0_[4]\,
      I4 => rst_n,
      I5 => \^m_axi_bready\,
      O => m_axi_bready_o_i_1_n_0
    );
m_axi_bready_o_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_onehot_state_r_reg_n_0_[5]\,
      I1 => m_axi_bvalid,
      O => m_axi_bready_o_i_2_n_0
    );
m_axi_bready_o_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => m_axi_bready_o_i_1_n_0,
      Q => \^m_axi_bready\,
      R => '0'
    );
m_axi_rready_o_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FF8080"
    )
        port map (
      I0 => rst_n,
      I1 => \FSM_onehot_state_r_reg_n_0_[2]\,
      I2 => m_axi_arready,
      I3 => m_axi_rvalid,
      I4 => \^m_axi_rready\,
      O => m_axi_rready_o_i_1_n_0
    );
m_axi_rready_o_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => m_axi_rready_o_i_1_n_0,
      Q => \^m_axi_rready\,
      R => '0'
    );
\m_axi_wdata_o[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => rst_n,
      I1 => \FSM_onehot_state_r_reg_n_0_[3]\,
      O => \m_axi_wdata_o[6]_i_1_n_0\
    );
\m_axi_wdata_o_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \m_axi_wdata_o[6]_i_1_n_0\,
      D => char_r(0),
      Q => m_axi_wdata(0),
      R => '0'
    );
\m_axi_wdata_o_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \m_axi_wdata_o[6]_i_1_n_0\,
      D => char_r(1),
      Q => m_axi_wdata(1),
      R => '0'
    );
\m_axi_wdata_o_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \m_axi_wdata_o[6]_i_1_n_0\,
      D => char_r(2),
      Q => m_axi_wdata(2),
      R => '0'
    );
\m_axi_wdata_o_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \m_axi_wdata_o[6]_i_1_n_0\,
      D => char_r(3),
      Q => m_axi_wdata(3),
      R => '0'
    );
\m_axi_wdata_o_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \m_axi_wdata_o[6]_i_1_n_0\,
      D => char_r(4),
      Q => m_axi_wdata(4),
      R => '0'
    );
\m_axi_wdata_o_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \m_axi_wdata_o[6]_i_1_n_0\,
      D => char_r(5),
      Q => m_axi_wdata(5),
      R => '0'
    );
\m_axi_wdata_o_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \m_axi_wdata_o[6]_i_1_n_0\,
      D => char_r(6),
      Q => m_axi_wdata(6),
      R => '0'
    );
m_axi_wvalid_o_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FFF000"
    )
        port map (
      I0 => m_axi_wready,
      I1 => \FSM_onehot_state_r_reg_n_0_[4]\,
      I2 => \FSM_onehot_state_r_reg_n_0_[3]\,
      I3 => rst_n,
      I4 => \^m_axi_wvalid\,
      O => m_axi_wvalid_o_i_1_n_0
    );
m_axi_wvalid_o_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => m_axi_wvalid_o_i_1_n_0,
      Q => \^m_axi_wvalid\,
      R => '0'
    );
ready_o_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0EAFFEAFFFFFFFF"
    )
        port map (
      I0 => c_ready_w,
      I1 => \FSM_onehot_state_r_reg_n_0_[5]\,
      I2 => m_axi_bvalid,
      I3 => \FSM_onehot_state_r_reg_n_0_[0]\,
      I4 => state_r(1),
      I5 => rst_n,
      O => ready_o_i_1_n_0
    );
ready_o_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => ready_o_i_1_n_0,
      Q => c_ready_w,
      R => '0'
    );
wready_recv_r_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8FFF8800"
    )
        port map (
      I0 => m_axi_wready,
      I1 => \FSM_onehot_state_r_reg_n_0_[4]\,
      I2 => \FSM_onehot_state_r_reg_n_0_[3]\,
      I3 => rst_n,
      I4 => wready_recv_r_reg_n_0,
      O => wready_recv_r_i_1_n_0
    );
wready_recv_r_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => wready_recv_r_i_1_n_0,
      Q => wready_recv_r_reg_n_0,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity total_design_host_top_wrapper_0_0_prints is
  port (
    \FSM_sequential_state_r_reg[1]_0\ : out STD_LOGIC;
    \wait_counter_r_reg[0]\ : out STD_LOGIC;
    \wait_counter_r_reg[0]_0\ : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \FSM_sequential_state_r_reg[4]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \addr_r_reg[1]\ : out STD_LOGIC;
    \addr_r_reg[2]\ : out STD_LOGIC;
    \FSM_sequential_state_r_reg[1]_1\ : out STD_LOGIC;
    in7 : out STD_LOGIC_VECTOR ( 0 to 0 );
    \addr_r_reg[2]_0\ : out STD_LOGIC;
    \addr_r_reg[2]_1\ : out STD_LOGIC;
    string_i : out STD_LOGIC_VECTOR ( 1 downto 0 );
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 6 downto 0 );
    m_axi_bready : out STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 4 downto 0 );
    rst_n : in STD_LOGIC;
    \hex_r_reg[1][12]_0\ : in STD_LOGIC_VECTOR ( 12 downto 0 );
    \hex_r_reg[1][31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \hex_r_reg[2][31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \wait_counter_r_reg[0]_1\ : in STD_LOGIC;
    wait_counter_next_w : in STD_LOGIC_VECTOR ( 0 to 0 );
    wait_counter_fin_w : in STD_LOGIC;
    \addr_r_reg[0]\ : in STD_LOGIC;
    \wait_counter_r_reg[1]\ : in STD_LOGIC;
    \addr_r_reg[0]_0\ : in STD_LOGIC;
    \wait_counter_r[1]_i_3_0\ : in STD_LOGIC;
    \addr_r_reg[0]_1\ : in STD_LOGIC;
    \addr_r_reg[0]_2\ : in STD_LOGIC;
    \FSM_sequential_state_r_reg[0]_0\ : in STD_LOGIC;
    \FSM_sequential_state_r_reg[0]_1\ : in STD_LOGIC;
    start_i : in STD_LOGIC;
    simt_ready_i : in STD_LOGIC;
    \FSM_sequential_state_r_reg[0]_2\ : in STD_LOGIC;
    \hex_r_reg[1][31]_1\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    cycle_r_reg : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \hex_r_reg[3][31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \hex_r_reg[3][31]_1\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clk : in STD_LOGIC;
    \hex_r_reg[4][31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of total_design_host_top_wrapper_0_0_prints : entity is "prints";
end total_design_host_top_wrapper_0_0_prints;

architecture STRUCTURE of total_design_host_top_wrapper_0_0_prints is
  signal \FSM_sequential_state_r[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[0]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[1]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[1]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[4]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[4]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[4]_i_6_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[4]_i_7_n_0\ : STD_LOGIC;
  signal \^fsm_sequential_state_r_reg[1]_0\ : STD_LOGIC;
  signal \^fsm_sequential_state_r_reg[1]_1\ : STD_LOGIC;
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^addr_r_reg[1]\ : STD_LOGIC;
  signal \^addr_r_reg[2]\ : STD_LOGIC;
  signal \^addr_r_reg[2]_0\ : STD_LOGIC;
  signal \^addr_r_reg[2]_1\ : STD_LOGIC;
  signal char_idx_r : STD_LOGIC_VECTOR ( 4 downto 3 );
  signal \char_idx_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \char_idx_r[1]_i_1_n_0\ : STD_LOGIC;
  signal \char_idx_r[2]_i_1_n_0\ : STD_LOGIC;
  signal \char_idx_r[4]_i_3_n_0\ : STD_LOGIC;
  signal \char_idx_r[5]_i_3_n_0\ : STD_LOGIC;
  signal \char_idx_r[5]_i_5_n_0\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[0]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[1]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[2]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[3]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[4]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[5]\ : STD_LOGIC;
  signal char_r0_in : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \char_r[0]_i_10_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_11_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_12_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_13_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_14_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_8_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_9_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_10_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_11_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_12_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_13_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_14_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_8_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_9_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_10_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_11_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_12_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_13_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_14_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_15_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_16_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_17_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_18_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_19_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_20_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_21_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_22_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_23_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_24_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_25_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_26_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_27_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_28_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_29_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_30_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_31_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_32_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_33_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_34_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_35_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_36_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_8_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_9_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_10_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_11_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_12_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_8_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_9_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_10_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_11_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_12_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_8_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_9_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_10_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_11_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_12_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_13_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_14_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_15_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_16_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_8_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_9_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_10_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_11_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_12_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_13_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_14_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_15_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_16_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_17_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_18_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_19_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_20_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_21_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_22_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_23_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_24_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_25_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_26_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_27_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_28_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_29_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_30_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_31_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_32_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_33_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_34_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_35_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_36_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_37_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_38_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_39_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_40_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_41_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_42_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_43_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_44_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_45_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_46_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_47_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_48_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_49_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_50_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_51_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_52_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_53_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_54_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_55_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_56_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_57_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_58_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_59_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_60_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_61_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_62_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_63_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_64_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_65_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_66_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_67_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_68_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_69_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_70_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_71_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_72_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_73_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_74_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_8_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_9_n_0\ : STD_LOGIC;
  signal \char_r_reg_n_0_[0]\ : STD_LOGIC;
  signal \char_r_reg_n_0_[1]\ : STD_LOGIC;
  signal \char_r_reg_n_0_[2]\ : STD_LOGIC;
  signal \char_r_reg_n_0_[3]\ : STD_LOGIC;
  signal \char_r_reg_n_0_[4]\ : STD_LOGIC;
  signal \char_r_reg_n_0_[5]\ : STD_LOGIC;
  signal \char_r_reg_n_0_[6]\ : STD_LOGIC;
  signal data10 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data11 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data12 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data13 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data15 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal data16 : STD_LOGIC_VECTOR ( 6 downto 1 );
  signal data18 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal data20 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal data21 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal data22 : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal data23 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal data24 : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal data25 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal data27 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal data28 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal data29 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data30 : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal data31 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal data33 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal data34 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal data35 : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal data36 : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal data37 : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal data38 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal data39 : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal data5 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data9 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \hex_digit_idx_r[1]_i_2_n_0\ : STD_LOGIC;
  signal \hex_digit_idx_r[2]_i_2_n_0\ : STD_LOGIC;
  signal \hex_digit_idx_r[2]_i_3_n_0\ : STD_LOGIC;
  signal \hex_digit_idx_r_reg_n_0_[0]\ : STD_LOGIC;
  signal \hex_digit_idx_r_reg_n_0_[1]\ : STD_LOGIC;
  signal \hex_digit_idx_r_reg_n_0_[2]\ : STD_LOGIC;
  signal \hex_r[1][0]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][10]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][11]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][12]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][13]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][14]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][15]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][16]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][17]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][18]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][19]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][1]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][20]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][21]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][22]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][23]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][24]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][25]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][26]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][27]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][28]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_10_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_11_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_12_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_13_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_3_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_4_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_5_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_6_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_7_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_8_n_0\ : STD_LOGIC;
  signal \hex_r[1][29]_i_9_n_0\ : STD_LOGIC;
  signal \hex_r[1][2]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][30]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][31]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][31]_i_3_n_0\ : STD_LOGIC;
  signal \hex_r[1][31]_i_4_n_0\ : STD_LOGIC;
  signal \hex_r[1][3]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][4]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][5]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][6]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][7]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][8]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[1][9]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[2][0]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][10]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][11]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][12]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][13]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][14]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][15]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][16]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][17]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][18]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][19]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][1]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][20]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][21]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][22]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][23]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][24]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][25]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][26]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][27]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][28]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][29]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][2]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][30]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][31]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][31]_i_2_n_0\ : STD_LOGIC;
  signal \hex_r[2][3]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][4]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][5]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][6]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][7]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][8]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[2][9]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][0]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][10]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][11]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][12]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][13]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][14]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][15]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][16]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][17]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][18]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][19]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][1]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][20]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][21]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][22]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][23]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][24]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][25]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][26]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][27]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][28]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][29]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][2]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][30]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][31]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][3]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][4]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][5]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][6]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][7]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][8]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r[3][9]_i_1_n_0\ : STD_LOGIC;
  signal \hex_r_reg[1]_3\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \hex_r_reg[2]_2\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \hex_r_reg[3]_1\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \hex_r_reg[4]_0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^in7\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal prints_hex_w : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal prints_ready_w : STD_LOGIC;
  signal prints_string_w : STD_LOGIC_VECTOR ( 120 to 120 );
  signal state_r : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^string_i\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \string_r[120]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[121]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[129]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[130]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[131]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[134]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[145]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[162]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[174]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[176]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[178]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[180]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[189]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[192]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[194]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[197]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[200]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[201]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[202]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[217]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[224]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[225]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[232]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[240]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[245]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[248]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[251]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[265]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[273]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[274]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[281]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[282]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[288]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[291]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[293]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[297]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[299]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[304]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[312]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[313]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[314]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[316]_i_10_n_0\ : STD_LOGIC;
  signal \string_r[316]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[316]_i_2_n_0\ : STD_LOGIC;
  signal \string_r[316]_i_4_n_0\ : STD_LOGIC;
  signal \string_r[316]_i_5_n_0\ : STD_LOGIC;
  signal \string_r[316]_i_6_n_0\ : STD_LOGIC;
  signal \string_r[316]_i_7_n_0\ : STD_LOGIC;
  signal \string_r[316]_i_8_n_0\ : STD_LOGIC;
  signal \string_r[316]_i_9_n_0\ : STD_LOGIC;
  signal \string_r[40]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[88]_i_1_n_0\ : STD_LOGIC;
  signal u_printc_n_10 : STD_LOGIC;
  signal u_printc_n_11 : STD_LOGIC;
  signal u_printc_n_12 : STD_LOGIC;
  signal u_printc_n_13 : STD_LOGIC;
  signal u_printc_n_14 : STD_LOGIC;
  signal u_printc_n_5 : STD_LOGIC;
  signal u_printc_n_6 : STD_LOGIC;
  signal u_printc_n_7 : STD_LOGIC;
  signal u_printc_n_8 : STD_LOGIC;
  signal u_printc_n_9 : STD_LOGIC;
  signal wait_counter_r : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \wait_counter_r[1]_i_4_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[0]_i_2\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[0]_i_3\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[1]_i_4\ : label is "soft_lutpair55";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[0]\ : label is "S_READ_CHAR:01,S_IDLE:00,S_WRITE_CHAR:11,S_WRITE_HEX:10";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[1]\ : label is "S_READ_CHAR:01,S_IDLE:00,S_WRITE_CHAR:11,S_WRITE_HEX:10";
  attribute SOFT_HLUTNM of \addr_r[12]_i_5\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \char_idx_r[0]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \char_idx_r[1]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \char_idx_r[2]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \char_idx_r[4]_i_3\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \char_idx_r[5]_i_5\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \char_r[0]_i_10\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \char_r[0]_i_8\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \char_r[0]_i_9\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \char_r[1]_i_13\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \char_r[1]_i_14\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \char_r[1]_i_7\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \char_r[1]_i_8\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \char_r[1]_i_9\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \char_r[2]_i_10\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \char_r[2]_i_11\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \char_r[2]_i_13\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \char_r[2]_i_14\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \char_r[2]_i_16\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \char_r[2]_i_28\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \char_r[2]_i_34\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \char_r[2]_i_35\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \char_r[3]_i_10\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \char_r[3]_i_2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \char_r[4]_i_12\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \char_r[4]_i_4\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \char_r[5]_i_10\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \char_r[5]_i_12\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \char_r[5]_i_16\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \char_r[5]_i_9\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \char_r[6]_i_22\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \char_r[6]_i_30\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \char_r[6]_i_31\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \char_r[6]_i_71\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \hex_digit_idx_r[1]_i_2\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \hex_digit_idx_r[2]_i_2\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \hex_digit_idx_r[2]_i_3\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \hex_r[1][10]_i_2\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \hex_r[1][11]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \hex_r[1][12]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \hex_r[1][13]_i_2\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \hex_r[1][14]_i_2\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \hex_r[1][15]_i_2\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \hex_r[1][16]_i_2\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \hex_r[1][17]_i_2\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \hex_r[1][18]_i_2\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \hex_r[1][19]_i_2\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \hex_r[1][20]_i_2\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \hex_r[1][21]_i_2\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \hex_r[1][22]_i_2\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \hex_r[1][23]_i_2\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \hex_r[1][24]_i_2\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \hex_r[1][25]_i_2\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \hex_r[1][26]_i_2\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \hex_r[1][27]_i_2\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \hex_r[1][28]_i_2\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \hex_r[1][29]_i_2\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \hex_r[1][29]_i_7\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \hex_r[1][31]_i_3\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \hex_r[1][8]_i_2\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \hex_r[1][9]_i_2\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \hex_r[2][0]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \hex_r[2][10]_i_1\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \hex_r[2][11]_i_1\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \hex_r[2][12]_i_1\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \hex_r[2][13]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \hex_r[2][14]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \hex_r[2][15]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \hex_r[2][16]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \hex_r[2][17]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \hex_r[2][18]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \hex_r[2][19]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \hex_r[2][20]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \hex_r[2][21]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \hex_r[2][22]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \hex_r[2][23]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \hex_r[2][24]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \hex_r[2][25]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \hex_r[2][26]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \hex_r[2][27]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \hex_r[2][28]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \hex_r[2][29]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \hex_r[2][2]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \hex_r[2][2]_i_2\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \hex_r[2][30]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \hex_r[2][31]_i_2\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \hex_r[2][3]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \hex_r[2][3]_i_2\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \hex_r[2][4]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \hex_r[2][4]_i_2\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \hex_r[2][5]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \hex_r[2][5]_i_2\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \hex_r[2][6]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \hex_r[2][7]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \hex_r[2][8]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \hex_r[2][9]_i_1\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \hex_r[3][0]_i_1\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \hex_r[3][10]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \hex_r[3][11]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \hex_r[3][12]_i_1\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \hex_r[3][13]_i_1\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \hex_r[3][14]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \hex_r[3][15]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \hex_r[3][16]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \hex_r[3][17]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \hex_r[3][18]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \hex_r[3][19]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \hex_r[3][1]_i_1\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \hex_r[3][20]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \hex_r[3][21]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \hex_r[3][22]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \hex_r[3][23]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \hex_r[3][24]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \hex_r[3][25]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \hex_r[3][26]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \hex_r[3][27]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \hex_r[3][28]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \hex_r[3][29]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \hex_r[3][2]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \hex_r[3][30]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \hex_r[3][31]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \hex_r[3][3]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \hex_r[3][4]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \hex_r[3][5]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \hex_r[3][6]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \hex_r[3][7]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \hex_r[3][8]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \hex_r[3][9]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \mem_din_o[7]_INST_0_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \string_r[120]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \string_r[121]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \string_r[130]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \string_r[131]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \string_r[134]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \string_r[145]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \string_r[162]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \string_r[174]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \string_r[176]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \string_r[178]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \string_r[180]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \string_r[189]_i_1\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \string_r[192]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \string_r[194]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \string_r[197]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \string_r[200]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \string_r[201]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \string_r[202]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \string_r[217]_i_1\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \string_r[224]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \string_r[225]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \string_r[232]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \string_r[240]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \string_r[245]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \string_r[248]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \string_r[251]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \string_r[264]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \string_r[265]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \string_r[272]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \string_r[273]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \string_r[274]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \string_r[281]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \string_r[282]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \string_r[288]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \string_r[291]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \string_r[297]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \string_r[299]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \string_r[304]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \string_r[306]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \string_r[312]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \string_r[313]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \string_r[314]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \string_r[316]_i_2\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \string_r[88]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \wait_counter_r[0]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \wait_counter_r[1]_i_1\ : label is "soft_lutpair29";
begin
  \FSM_sequential_state_r_reg[1]_0\ <= \^fsm_sequential_state_r_reg[1]_0\;
  \FSM_sequential_state_r_reg[1]_1\ <= \^fsm_sequential_state_r_reg[1]_1\;
  SR(0) <= \^sr\(0);
  \addr_r_reg[1]\ <= \^addr_r_reg[1]\;
  \addr_r_reg[2]\ <= \^addr_r_reg[2]\;
  \addr_r_reg[2]_0\ <= \^addr_r_reg[2]_0\;
  \addr_r_reg[2]_1\ <= \^addr_r_reg[2]_1\;
  in7(0) <= \^in7\(0);
  string_i(1 downto 0) <= \^string_i\(1 downto 0);
\FSM_sequential_state_r[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"001F"
    )
        port map (
      I0 => \char_r[1]_i_2_n_0\,
      I1 => \char_r[0]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \FSM_sequential_state_r[0]_i_3_n_0\,
      O => \FSM_sequential_state_r[0]_i_2_n_0\
    );
\FSM_sequential_state_r[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \char_r[4]_i_2_n_0\,
      I1 => \char_r[3]_i_2_n_0\,
      I2 => \char_r[5]_i_2_n_0\,
      I3 => \char_r[6]_i_6_n_0\,
      O => \FSM_sequential_state_r[0]_i_3_n_0\
    );
\FSM_sequential_state_r[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \char_r[5]_i_2_n_0\,
      I1 => \char_r[4]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \FSM_sequential_state_r[1]_i_4_n_0\,
      O => \FSM_sequential_state_r[1]_i_2_n_0\
    );
\FSM_sequential_state_r[1]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \char_r[6]_i_6_n_0\,
      I1 => \char_r[3]_i_2_n_0\,
      I2 => \char_r[1]_i_2_n_0\,
      O => \FSM_sequential_state_r[1]_i_4_n_0\
    );
\FSM_sequential_state_r[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000160006"
    )
        port map (
      I0 => Q(3),
      I1 => Q(4),
      I2 => Q(0),
      I3 => Q(2),
      I4 => Q(1),
      I5 => state_r(1),
      O => \FSM_sequential_state_r[1]_i_5_n_0\
    );
\FSM_sequential_state_r[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAAFAEABAAABAA"
    )
        port map (
      I0 => \FSM_sequential_state_r[4]_i_3_n_0\,
      I1 => Q(4),
      I2 => Q(2),
      I3 => \FSM_sequential_state_r[4]_i_4_n_0\,
      I4 => Q(3),
      I5 => prints_ready_w,
      O => \FSM_sequential_state_r_reg[4]\(0)
    );
\FSM_sequential_state_r[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EAAAEAAAAAAAEAAA"
    )
        port map (
      I0 => \FSM_sequential_state_r[4]_i_6_n_0\,
      I1 => \FSM_sequential_state_r_reg[0]_2\,
      I2 => simt_ready_i,
      I3 => Q(0),
      I4 => Q(3),
      I5 => wait_counter_fin_w,
      O => \FSM_sequential_state_r[4]_i_3_n_0\
    );
\FSM_sequential_state_r[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAAAAAAA"
    )
        port map (
      I0 => \FSM_sequential_state_r[4]_i_7_n_0\,
      I1 => \FSM_sequential_state_r_reg[0]_0\,
      I2 => Q(3),
      I3 => Q(1),
      I4 => Q(0),
      I5 => \FSM_sequential_state_r_reg[0]_1\,
      O => \FSM_sequential_state_r[4]_i_4_n_0\
    );
\FSM_sequential_state_r[4]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888C8C80C00"
    )
        port map (
      I0 => wait_counter_fin_w,
      I1 => \FSM_sequential_state_r_reg[0]_2\,
      I2 => Q(0),
      I3 => prints_ready_w,
      I4 => Q(1),
      I5 => Q(3),
      O => \FSM_sequential_state_r[4]_i_6_n_0\
    );
\FSM_sequential_state_r[4]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFC000CFF0A000A"
    )
        port map (
      I0 => start_i,
      I1 => simt_ready_i,
      I2 => Q(0),
      I3 => Q(3),
      I4 => prints_ready_w,
      I5 => Q(1),
      O => \FSM_sequential_state_r[4]_i_7_n_0\
    );
\FSM_sequential_state_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_printc_n_6,
      Q => state_r(0),
      R => \^sr\(0)
    );
\FSM_sequential_state_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_printc_n_5,
      Q => state_r(1),
      R => \^sr\(0)
    );
\addr_r[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8000"
    )
        port map (
      I0 => \addr_r_reg[0]_0\,
      I1 => Q(3),
      I2 => prints_ready_w,
      I3 => \addr_r_reg[0]\,
      I4 => \addr_r_reg[0]_1\,
      I5 => \addr_r_reg[0]_2\,
      O => E(0)
    );
\addr_r[12]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => state_r(0),
      I1 => state_r(1),
      O => prints_ready_w
    );
\char_idx_r[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      O => \char_idx_r[0]_i_1_n_0\
    );
\char_idx_r[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      O => \char_idx_r[1]_i_1_n_0\
    );
\char_idx_r[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E1"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      O => \char_idx_r[2]_i_1_n_0\
    );
\char_idx_r[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFEFE0001010100"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => state_r(1),
      I4 => state_r(0),
      I5 => \char_idx_r_reg_n_0_[3]\,
      O => char_idx_r(3)
    );
\char_idx_r[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFEFE0001010100"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[2]\,
      I1 => \char_idx_r[4]_i_3_n_0\,
      I2 => \char_idx_r_reg_n_0_[3]\,
      I3 => state_r(1),
      I4 => state_r(0),
      I5 => \char_idx_r_reg_n_0_[4]\,
      O => char_idx_r(4)
    );
\char_idx_r[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[1]\,
      I1 => \char_idx_r_reg_n_0_[0]\,
      O => \char_idx_r[4]_i_3_n_0\
    );
\char_idx_r[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000001"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[4]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_idx_r_reg_n_0_[5]\,
      O => \char_idx_r[5]_i_3_n_0\
    );
\char_idx_r[5]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF1115"
    )
        port map (
      I0 => \FSM_sequential_state_r[0]_i_3_n_0\,
      I1 => \char_r[2]_i_3_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[1]_i_2_n_0\,
      I4 => state_r(1),
      O => \char_idx_r[5]_i_5_n_0\
    );
\char_idx_r_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => u_printc_n_14,
      D => \char_idx_r[0]_i_1_n_0\,
      Q => \char_idx_r_reg_n_0_[0]\,
      S => u_printc_n_7
    );
\char_idx_r_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => u_printc_n_14,
      D => \char_idx_r[1]_i_1_n_0\,
      Q => \char_idx_r_reg_n_0_[1]\,
      S => u_printc_n_7
    );
\char_idx_r_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => u_printc_n_14,
      D => \char_idx_r[2]_i_1_n_0\,
      Q => \char_idx_r_reg_n_0_[2]\,
      S => u_printc_n_7
    );
\char_idx_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_printc_n_9,
      Q => \char_idx_r_reg_n_0_[3]\,
      R => '0'
    );
\char_idx_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_printc_n_8,
      Q => \char_idx_r_reg_n_0_[4]\,
      R => '0'
    );
\char_idx_r_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => u_printc_n_14,
      D => \char_idx_r[5]_i_3_n_0\,
      Q => \char_idx_r_reg_n_0_[5]\,
      S => u_printc_n_7
    );
\char_r[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"56AAFFFF56AA0000"
    )
        port map (
      I0 => \char_r[2]_i_2_n_0\,
      I1 => \char_r[6]_i_3_n_0\,
      I2 => \char_r[6]_i_4_n_0\,
      I3 => \char_r[6]_i_5_n_0\,
      I4 => \char_idx_r[5]_i_5_n_0\,
      I5 => \char_r[0]_i_2_n_0\,
      O => char_r0_in(0)
    );
\char_r[0]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FC0A0C0A"
    )
        port map (
      I0 => data12(0),
      I1 => data13(0),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data15(0),
      O => \char_r[0]_i_10_n_0\
    );
\char_r[0]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AACCFFF0AACC00"
    )
        port map (
      I0 => data22(0),
      I1 => data5(0),
      I2 => data12(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data20(0),
      O => \char_r[0]_i_11_n_0\
    );
\char_r[0]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data29(0),
      I1 => data31(0),
      I2 => data28(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data30(0),
      O => \char_r[0]_i_12_n_0\
    );
\char_r[0]_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0AACCF0"
    )
        port map (
      I0 => data15(0),
      I1 => data12(0),
      I2 => data11(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[0]_i_13_n_0\
    );
\char_r[0]_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCFAFC0A"
    )
        port map (
      I0 => data24(0),
      I1 => data25(0),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data11(0),
      O => \char_r[0]_i_14_n_0\
    );
\char_r[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFAEABAA"
    )
        port map (
      I0 => \char_r[0]_i_3_n_0\,
      I1 => \char_idx_r_reg_n_0_[4]\,
      I2 => \char_idx_r_reg_n_0_[5]\,
      I3 => \char_r[0]_i_4_n_0\,
      I4 => \char_r[0]_i_5_n_0\,
      O => \char_r[0]_i_2_n_0\
    );
\char_r[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000AC00000000"
    )
        port map (
      I0 => \char_r[0]_i_6_n_0\,
      I1 => \char_r[0]_i_7_n_0\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \char_idx_r_reg_n_0_[4]\,
      I5 => \char_idx_r_reg_n_0_[5]\,
      O => \char_r[0]_i_3_n_0\
    );
\char_r[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00C0C0AAAA0000"
    )
        port map (
      I0 => \char_r[0]_i_8_n_0\,
      I1 => data5(0),
      I2 => \char_r[0]_i_9_n_0\,
      I3 => \char_r[0]_i_10_n_0\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[0]_i_4_n_0\
    );
\char_r[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => \char_r[0]_i_11_n_0\,
      I1 => \char_r[0]_i_12_n_0\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \char_r[0]_i_13_n_0\,
      I5 => \char_r[0]_i_14_n_0\,
      O => \char_r[0]_i_5_n_0\
    );
\char_r[0]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CAFFCAF0"
    )
        port map (
      I0 => data38(0),
      I1 => data39(0),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => data36(0),
      O => \char_r[0]_i_6_n_0\
    );
\char_r[0]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data33(0),
      I1 => data5(0),
      I2 => data9(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data34(0),
      O => \char_r[0]_i_7_n_0\
    );
\char_r[0]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FAC00AC0"
    )
        port map (
      I0 => data9(0),
      I1 => data10(0),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data11(0),
      O => \char_r[0]_i_8_n_0\
    );
\char_r[0]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[0]_i_9_n_0\
    );
\char_r[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AF40FFFFAF400000"
    )
        port map (
      I0 => \char_r[2]_i_2_n_0\,
      I1 => \char_r[6]_i_4_n_0\,
      I2 => \char_r[6]_i_5_n_0\,
      I3 => \char_r[6]_i_3_n_0\,
      I4 => \char_idx_r[5]_i_5_n_0\,
      I5 => \char_r[1]_i_2_n_0\,
      O => char_r0_in(1)
    );
\char_r[1]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFB38C8000000000"
    )
        port map (
      I0 => data15(1),
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => data9(0),
      I4 => data11(0),
      I5 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[1]_i_10_n_0\
    );
\char_r[1]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0444004404400040"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[3]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data11(0),
      I5 => data13(0),
      O => \char_r[1]_i_11_n_0\
    );
\char_r[1]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data30(0),
      I1 => data11(0),
      I2 => data28(1),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data39(0),
      O => \char_r[1]_i_12_n_0\
    );
\char_r[1]_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CA00CA"
    )
        port map (
      I0 => data16(1),
      I1 => data18(1),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data9(0),
      O => \char_r[1]_i_13_n_0\
    );
\char_r[1]_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FC0A0C0A"
    )
        port map (
      I0 => data34(0),
      I1 => data25(1),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data27(1),
      O => \char_r[1]_i_14_n_0\
    );
\char_r[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEFFEEFEEEEFEEEE"
    )
        port map (
      I0 => \char_r[1]_i_3_n_0\,
      I1 => \char_r[1]_i_4_n_0\,
      I2 => \char_idx_r_reg_n_0_[4]\,
      I3 => \char_idx_r_reg_n_0_[5]\,
      I4 => \char_r[1]_i_5_n_0\,
      I5 => \char_r[1]_i_6_n_0\,
      O => \char_r[1]_i_2_n_0\
    );
\char_r[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8AA08A0080A08000"
    )
        port map (
      I0 => \char_r[1]_i_7_n_0\,
      I1 => data35(1),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => data33(1),
      I5 => data34(1),
      O => \char_r[1]_i_3_n_0\
    );
\char_r[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"80AA800A80A08000"
    )
        port map (
      I0 => \char_r[5]_i_12_n_0\,
      I1 => data39(1),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => data37(1),
      I5 => data15(0),
      O => \char_r[1]_i_4_n_0\
    );
\char_r[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFAEFFAEFFAEAEAE"
    )
        port map (
      I0 => \char_r[5]_i_14_n_0\,
      I1 => \char_r[1]_i_8_n_0\,
      I2 => \char_idx_r[4]_i_3_n_0\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \char_r[1]_i_9_n_0\,
      I5 => \char_r[1]_i_10_n_0\,
      O => \char_r[1]_i_5_n_0\
    );
\char_r[1]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAFEFAAEAAFEAAA"
    )
        port map (
      I0 => \char_r[1]_i_11_n_0\,
      I1 => \char_r[1]_i_12_n_0\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \char_r[1]_i_13_n_0\,
      I5 => \char_r[1]_i_14_n_0\,
      O => \char_r[1]_i_6_n_0\
    );
\char_r[1]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[2]\,
      I1 => \char_idx_r_reg_n_0_[3]\,
      I2 => \char_idx_r_reg_n_0_[4]\,
      I3 => \char_idx_r_reg_n_0_[5]\,
      O => \char_r[1]_i_7_n_0\
    );
\char_r[1]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[3]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => data5(0),
      O => \char_r[1]_i_8_n_0\
    );
\char_r[1]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08080F00"
    )
        port map (
      I0 => data12(0),
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => data10(0),
      I4 => \char_idx_r_reg_n_0_[0]\,
      O => \char_r[1]_i_9_n_0\
    );
\char_r[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EF00FFFFEF000000"
    )
        port map (
      I0 => \char_r[2]_i_2_n_0\,
      I1 => \char_r[6]_i_3_n_0\,
      I2 => \char_r[6]_i_5_n_0\,
      I3 => \char_r[6]_i_4_n_0\,
      I4 => \char_idx_r[5]_i_5_n_0\,
      I5 => \char_r[2]_i_3_n_0\,
      O => char_r0_in(2)
    );
\char_r[2]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0A0C"
    )
        port map (
      I0 => \char_r[2]_i_30_n_0\,
      I1 => \char_r[2]_i_31_n_0\,
      I2 => \char_idx_r_reg_n_0_[3]\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[2]_i_10_n_0\
    );
\char_r[2]_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00200000"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[2]\,
      I1 => \char_idx_r_reg_n_0_[3]\,
      I2 => \char_idx_r_reg_n_0_[5]\,
      I3 => \char_idx_r_reg_n_0_[4]\,
      I4 => \char_r[2]_i_32_n_0\,
      O => \char_r[2]_i_11_n_0\
    );
\char_r[2]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAA800"
    )
        port map (
      I0 => \char_r[5]_i_16_n_0\,
      I1 => \char_r[2]_i_33_n_0\,
      I2 => \char_r[2]_i_34_n_0\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \char_r[2]_i_35_n_0\,
      I5 => \char_r[5]_i_14_n_0\,
      O => \char_r[2]_i_12_n_0\
    );
\char_r[2]_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00020000"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[5]\,
      I1 => \char_idx_r_reg_n_0_[4]\,
      I2 => \char_idx_r_reg_n_0_[3]\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => \char_r[2]_i_36_n_0\,
      O => \char_r[2]_i_13_n_0\
    );
\char_r[2]_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(28),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(28),
      O => \char_r[2]_i_14_n_0\
    );
\char_r[2]_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(28),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(28),
      O => \char_r[2]_i_15_n_0\
    );
\char_r[2]_i_16\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(20),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(20),
      O => \char_r[2]_i_16_n_0\
    );
\char_r[2]_i_17\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(20),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(20),
      O => \char_r[2]_i_17_n_0\
    );
\char_r[2]_i_18\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(16),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(16),
      O => \char_r[2]_i_18_n_0\
    );
\char_r[2]_i_19\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(24),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(24),
      O => \char_r[2]_i_19_n_0\
    );
\char_r[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFEFFFEFFFE00"
    )
        port map (
      I0 => \char_r[2]_i_4_n_0\,
      I1 => \char_r[2]_i_5_n_0\,
      I2 => \char_r[2]_i_6_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[2]\,
      I4 => \char_r[2]_i_7_n_0\,
      I5 => \char_r[2]_i_8_n_0\,
      O => \char_r[2]_i_2_n_0\
    );
\char_r[2]_i_20\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(12),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(12),
      O => \char_r[2]_i_20_n_0\
    );
\char_r[2]_i_21\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(12),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(12),
      O => \char_r[2]_i_21_n_0\
    );
\char_r[2]_i_22\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(4),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(4),
      O => \char_r[2]_i_22_n_0\
    );
\char_r[2]_i_23\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(4),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(4),
      O => \char_r[2]_i_23_n_0\
    );
\char_r[2]_i_24\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(8),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(8),
      O => \char_r[2]_i_24_n_0\
    );
\char_r[2]_i_25\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(8),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(8),
      O => \char_r[2]_i_25_n_0\
    );
\char_r[2]_i_26\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(0),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(0),
      O => \char_r[2]_i_26_n_0\
    );
\char_r[2]_i_27\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(0),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(0),
      O => \char_r[2]_i_27_n_0\
    );
\char_r[2]_i_28\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8880"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[1]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => data11(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      O => \char_r[2]_i_28_n_0\
    );
\char_r[2]_i_29\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data25(2),
      I1 => data24(0),
      I2 => data24(2),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data12(0),
      O => \char_r[2]_i_29_n_0\
    );
\char_r[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFA8"
    )
        port map (
      I0 => \char_r[5]_i_3_n_0\,
      I1 => \char_r[2]_i_9_n_0\,
      I2 => \char_r[2]_i_10_n_0\,
      I3 => \char_r[2]_i_11_n_0\,
      I4 => \char_r[2]_i_12_n_0\,
      I5 => \char_r[2]_i_13_n_0\,
      O => \char_r[2]_i_3_n_0\
    );
\char_r[2]_i_30\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AACCFFF0AACC00"
    )
        port map (
      I0 => data22(2),
      I1 => data21(6),
      I2 => data12(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data20(2),
      O => \char_r[2]_i_30_n_0\
    );
\char_r[2]_i_31\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data16(1),
      I1 => data10(0),
      I2 => data16(2),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data15(1),
      O => \char_r[2]_i_31_n_0\
    );
\char_r[2]_i_32\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data34(0),
      I1 => data39(2),
      I2 => data22(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data38(2),
      O => \char_r[2]_i_32_n_0\
    );
\char_r[2]_i_33\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B383B08000000000"
    )
        port map (
      I0 => data9(0),
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => data10(0),
      I4 => data13(0),
      I5 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[2]_i_33_n_0\
    );
\char_r[2]_i_34\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"008800B8"
    )
        port map (
      I0 => data9(0),
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => data11(0),
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[2]_i_34_n_0\
    );
\char_r[2]_i_35\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00080000"
    )
        port map (
      I0 => data5(0),
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_idx_r_reg_n_0_[3]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => \char_idx_r_reg_n_0_[0]\,
      O => \char_r[2]_i_35_n_0\
    );
\char_r[2]_i_36\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data11(0),
      I1 => data35(2),
      I2 => data22(2),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data34(2),
      O => \char_r[2]_i_36_n_0\
    );
\char_r[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEE0000FFF00000"
    )
        port map (
      I0 => \char_r[2]_i_14_n_0\,
      I1 => \char_r[2]_i_15_n_0\,
      I2 => \char_r[2]_i_16_n_0\,
      I3 => \char_r[2]_i_17_n_0\,
      I4 => \hex_digit_idx_r_reg_n_0_[0]\,
      I5 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[2]_i_4_n_0\
    );
\char_r[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFEAEAEA"
    )
        port map (
      I0 => \char_r[2]_i_18_n_0\,
      I1 => \char_r[6]_i_30_n_0\,
      I2 => \hex_r_reg[1]_3\(16),
      I3 => \char_r[6]_i_31_n_0\,
      I4 => \hex_r_reg[2]_2\(16),
      I5 => \hex_digit_idx_r[2]_i_2_n_0\,
      O => \char_r[2]_i_5_n_0\
    );
\char_r[2]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAA888A888A888"
    )
        port map (
      I0 => \char_r[6]_i_32_n_0\,
      I1 => \char_r[2]_i_19_n_0\,
      I2 => \char_r[6]_i_30_n_0\,
      I3 => \hex_r_reg[1]_3\(24),
      I4 => \char_r[6]_i_31_n_0\,
      I5 => \hex_r_reg[2]_2\(24),
      O => \char_r[2]_i_6_n_0\
    );
\char_r[2]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEE0000FFF00000"
    )
        port map (
      I0 => \char_r[2]_i_20_n_0\,
      I1 => \char_r[2]_i_21_n_0\,
      I2 => \char_r[2]_i_22_n_0\,
      I3 => \char_r[2]_i_23_n_0\,
      I4 => \hex_digit_idx_r_reg_n_0_[0]\,
      I5 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[2]_i_7_n_0\
    );
\char_r[2]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0E0F0E0F0E0F0E00"
    )
        port map (
      I0 => \char_r[2]_i_24_n_0\,
      I1 => \char_r[2]_i_25_n_0\,
      I2 => \hex_digit_idx_r_reg_n_0_[0]\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      I4 => \char_r[2]_i_26_n_0\,
      I5 => \char_r[2]_i_27_n_0\,
      O => \char_r[2]_i_8_n_0\
    );
\char_r[2]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BAFFBAAA00000000"
    )
        port map (
      I0 => \char_r[2]_i_28_n_0\,
      I1 => \char_idx_r[4]_i_3_n_0\,
      I2 => data28(0),
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => \char_r[2]_i_29_n_0\,
      I5 => \char_idx_r_reg_n_0_[3]\,
      O => \char_r[2]_i_9_n_0\
    );
\char_r[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10FF1000"
    )
        port map (
      I0 => \char_r[6]_i_3_n_0\,
      I1 => \char_r[6]_i_4_n_0\,
      I2 => \char_r[6]_i_5_n_0\,
      I3 => \char_idx_r[5]_i_5_n_0\,
      I4 => \char_r[3]_i_2_n_0\,
      O => char_r0_in(3)
    );
\char_r[3]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CA00CA"
    )
        port map (
      I0 => data25(1),
      I1 => data22(0),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data31(3),
      O => \char_r[3]_i_10_n_0\
    );
\char_r[3]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data20(2),
      I1 => data9(0),
      I2 => data16(3),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data15(1),
      O => \char_r[3]_i_11_n_0\
    );
\char_r[3]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data27(1),
      I1 => data34(0),
      I2 => data29(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data24(2),
      O => \char_r[3]_i_12_n_0\
    );
\char_r[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFAEABAA"
    )
        port map (
      I0 => \char_r[3]_i_3_n_0\,
      I1 => \char_idx_r_reg_n_0_[4]\,
      I2 => \char_idx_r_reg_n_0_[5]\,
      I3 => \char_r[3]_i_4_n_0\,
      I4 => \char_r[3]_i_5_n_0\,
      O => \char_r[3]_i_2_n_0\
    );
\char_r[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000AC00000000"
    )
        port map (
      I0 => \char_r[3]_i_6_n_0\,
      I1 => \char_r[3]_i_7_n_0\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \char_idx_r_reg_n_0_[4]\,
      I5 => \char_idx_r_reg_n_0_[5]\,
      O => \char_r[3]_i_3_n_0\
    );
\char_r[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAEAAAAAAAEA"
    )
        port map (
      I0 => \char_r[5]_i_14_n_0\,
      I1 => data5(0),
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_r[3]_i_8_n_0\,
      O => \char_r[3]_i_4_n_0\
    );
\char_r[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFCFA0C0AFC0A0"
    )
        port map (
      I0 => \char_r[3]_i_9_n_0\,
      I1 => \char_r[3]_i_10_n_0\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \char_r[3]_i_11_n_0\,
      I5 => \char_r[3]_i_12_n_0\,
      O => \char_r[3]_i_5_n_0\
    );
\char_r[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data37(3),
      I1 => data34(0),
      I2 => data36(3),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data35(2),
      O => \char_r[3]_i_6_n_0\
    );
\char_r[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data34(0),
      I1 => data33(0),
      I2 => data36(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data34(1),
      O => \char_r[3]_i_7_n_0\
    );
\char_r[3]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444A0A0FF00DD88"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[2]\,
      I1 => data13(0),
      I2 => data12(0),
      I3 => data10(0),
      I4 => \char_idx_r_reg_n_0_[0]\,
      I5 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[3]_i_8_n_0\
    );
\char_r[3]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data11(0),
      I1 => data34(0),
      I2 => data18(1),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data24(0),
      O => \char_r[3]_i_9_n_0\
    );
\char_r[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"57FF5700"
    )
        port map (
      I0 => \char_r[6]_i_5_n_0\,
      I1 => \char_r[6]_i_4_n_0\,
      I2 => \char_r[6]_i_3_n_0\,
      I3 => \char_idx_r[5]_i_5_n_0\,
      I4 => \char_r[4]_i_2_n_0\,
      O => char_r0_in(4)
    );
\char_r[4]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCA00CA0"
    )
        port map (
      I0 => data38(2),
      I1 => data30(0),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data28(1),
      O => \char_r[4]_i_10_n_0\
    );
\char_r[4]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFC0AFCFA0C0A0"
    )
        port map (
      I0 => data28(1),
      I1 => data35(1),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => data9(0),
      I5 => data34(0),
      O => \char_r[4]_i_11_n_0\
    );
\char_r[4]_i_12\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0EC00200"
    )
        port map (
      I0 => data11(0),
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => data9(0),
      O => \char_r[4]_i_12_n_0\
    );
\char_r[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF62404040"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[5]\,
      I1 => \char_idx_r_reg_n_0_[4]\,
      I2 => \char_r[4]_i_3_n_0\,
      I3 => \char_r[4]_i_4_n_0\,
      I4 => \char_r[4]_i_5_n_0\,
      I5 => \char_r[4]_i_6_n_0\,
      O => \char_r[4]_i_2_n_0\
    );
\char_r[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00EEEEF0F0EEEE"
    )
        port map (
      I0 => \char_r[4]_i_7_n_0\,
      I1 => \char_r[4]_i_8_n_0\,
      I2 => \char_r[4]_i_9_n_0\,
      I3 => \char_r[4]_i_10_n_0\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[4]_i_3_n_0\
    );
\char_r[4]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[2]\,
      I1 => \char_idx_r_reg_n_0_[3]\,
      O => \char_r[4]_i_4_n_0\
    );
\char_r[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAFC0AFCFA0C0A0"
    )
        port map (
      I0 => data24(0),
      I1 => data39(4),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => data9(0),
      I5 => data36(4),
      O => \char_r[4]_i_5_n_0\
    );
\char_r[4]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000F000220000"
    )
        port map (
      I0 => \char_r[4]_i_11_n_0\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_r[4]_i_12_n_0\,
      I3 => \char_idx_r_reg_n_0_[4]\,
      I4 => \char_idx_r_reg_n_0_[5]\,
      I5 => \char_idx_r_reg_n_0_[3]\,
      O => \char_r[4]_i_6_n_0\
    );
\char_r[4]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7351624000000000"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[1]\,
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => data22(2),
      I3 => data22(4),
      I4 => data16(2),
      I5 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[4]_i_7_n_0\
    );
\char_r[4]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000A0A0000CFC0"
    )
        port map (
      I0 => data9(0),
      I1 => data10(0),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => data15(0),
      I4 => \char_idx_r_reg_n_0_[2]\,
      I5 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[4]_i_8_n_0\
    );
\char_r[4]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0AACCF0"
    )
        port map (
      I0 => data28(0),
      I1 => data34(0),
      I2 => data11(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[4]_i_9_n_0\
    );
\char_r[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"57FF5700"
    )
        port map (
      I0 => \char_r[6]_i_5_n_0\,
      I1 => \char_r[6]_i_4_n_0\,
      I2 => \char_r[6]_i_3_n_0\,
      I3 => \char_idx_r[5]_i_5_n_0\,
      I4 => \char_r[5]_i_2_n_0\,
      O => char_r0_in(5)
    );
\char_r[5]_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[3]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[5]_i_10_n_0\
    );
\char_r[5]_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[3]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[5]_i_11_n_0\
    );
\char_r[5]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[4]\,
      I1 => \char_idx_r_reg_n_0_[5]\,
      I2 => \char_idx_r_reg_n_0_[3]\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[5]_i_12_n_0\
    );
\char_r[5]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA288A08A2208200"
    )
        port map (
      I0 => \char_r[1]_i_7_n_0\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => data25(0),
      I4 => data25(2),
      I5 => data38(0),
      O => \char_r[5]_i_13_n_0\
    );
\char_r[5]_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00008A8000000000"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[1]\,
      I1 => data11(0),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => data5(0),
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[5]_i_14_n_0\
    );
\char_r[5]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA80AA8AA080A08"
    )
        port map (
      I0 => \char_r[5]_i_10_n_0\,
      I1 => data10(0),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data16(2),
      I5 => data13(0),
      O => \char_r[5]_i_15_n_0\
    );
\char_r[5]_i_16\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[5]\,
      I1 => \char_idx_r_reg_n_0_[4]\,
      O => \char_r[5]_i_16_n_0\
    );
\char_r[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFAAA8"
    )
        port map (
      I0 => \char_r[5]_i_3_n_0\,
      I1 => \char_r[5]_i_4_n_0\,
      I2 => \char_r[5]_i_5_n_0\,
      I3 => \char_r[5]_i_6_n_0\,
      I4 => \char_r[5]_i_7_n_0\,
      I5 => \char_r[5]_i_8_n_0\,
      O => \char_r[5]_i_2_n_0\
    );
\char_r[5]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[4]\,
      I1 => \char_idx_r_reg_n_0_[5]\,
      O => \char_r[5]_i_3_n_0\
    );
\char_r[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FA0A0000CFC0"
    )
        port map (
      I0 => data23(5),
      I1 => data16(2),
      I2 => \char_r[5]_i_9_n_0\,
      I3 => data13(0),
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[5]_i_4_n_0\
    );
\char_r[5]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA288A08A2208200"
    )
        port map (
      I0 => \char_r[5]_i_10_n_0\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => data25(0),
      I4 => data37(3),
      I5 => data30(5),
      O => \char_r[5]_i_5_n_0\
    );
\char_r[5]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA82A8802A022800"
    )
        port map (
      I0 => \char_r[5]_i_11_n_0\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => data20(0),
      I4 => data24(5),
      I5 => data12(0),
      O => \char_r[5]_i_6_n_0\
    );
\char_r[5]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0AA80008"
    )
        port map (
      I0 => \char_r[5]_i_12_n_0\,
      I1 => data36(5),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => data11(0),
      O => \char_r[5]_i_7_n_0\
    );
\char_r[5]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEEEAAAAAAAA"
    )
        port map (
      I0 => \char_r[5]_i_13_n_0\,
      I1 => \char_r[5]_i_14_n_0\,
      I2 => \char_r[5]_i_11_n_0\,
      I3 => data11(0),
      I4 => \char_r[5]_i_15_n_0\,
      I5 => \char_r[5]_i_16_n_0\,
      O => \char_r[5]_i_8_n_0\
    );
\char_r[5]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[1]\,
      I1 => \char_idx_r_reg_n_0_[0]\,
      O => \char_r[5]_i_9_n_0\
    );
\char_r[6]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEE0000FFF00000"
    )
        port map (
      I0 => \char_r[6]_i_34_n_0\,
      I1 => \char_r[6]_i_35_n_0\,
      I2 => \char_r[6]_i_36_n_0\,
      I3 => \char_r[6]_i_37_n_0\,
      I4 => \hex_digit_idx_r_reg_n_0_[0]\,
      I5 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_10_n_0\
    );
\char_r[6]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0E0F0E0F0E0F0E00"
    )
        port map (
      I0 => \char_r[6]_i_38_n_0\,
      I1 => \char_r[6]_i_39_n_0\,
      I2 => \hex_digit_idx_r_reg_n_0_[0]\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      I4 => \char_r[6]_i_40_n_0\,
      I5 => \char_r[6]_i_41_n_0\,
      O => \char_r[6]_i_11_n_0\
    );
\char_r[6]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEE0000FFF00000"
    )
        port map (
      I0 => \char_r[6]_i_42_n_0\,
      I1 => \char_r[6]_i_43_n_0\,
      I2 => \char_r[6]_i_44_n_0\,
      I3 => \char_r[6]_i_45_n_0\,
      I4 => \hex_digit_idx_r_reg_n_0_[0]\,
      I5 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_12_n_0\
    );
\char_r[6]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFEAEAEA"
    )
        port map (
      I0 => \char_r[6]_i_46_n_0\,
      I1 => \char_r[6]_i_30_n_0\,
      I2 => \hex_r_reg[1]_3\(18),
      I3 => \char_r[6]_i_31_n_0\,
      I4 => \hex_r_reg[2]_2\(18),
      I5 => \hex_digit_idx_r[2]_i_2_n_0\,
      O => \char_r[6]_i_13_n_0\
    );
\char_r[6]_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAA888A888A888"
    )
        port map (
      I0 => \char_r[6]_i_32_n_0\,
      I1 => \char_r[6]_i_47_n_0\,
      I2 => \char_r[6]_i_30_n_0\,
      I3 => \hex_r_reg[1]_3\(26),
      I4 => \char_r[6]_i_31_n_0\,
      I5 => \hex_r_reg[2]_2\(26),
      O => \char_r[6]_i_14_n_0\
    );
\char_r[6]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEE0000FFF00000"
    )
        port map (
      I0 => \char_r[6]_i_48_n_0\,
      I1 => \char_r[6]_i_49_n_0\,
      I2 => \char_r[6]_i_50_n_0\,
      I3 => \char_r[6]_i_51_n_0\,
      I4 => \hex_digit_idx_r_reg_n_0_[0]\,
      I5 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_15_n_0\
    );
\char_r[6]_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0E0F0E0F0E0F0E00"
    )
        port map (
      I0 => \char_r[6]_i_52_n_0\,
      I1 => \char_r[6]_i_53_n_0\,
      I2 => \hex_digit_idx_r_reg_n_0_[0]\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      I4 => \char_r[6]_i_54_n_0\,
      I5 => \char_r[6]_i_55_n_0\,
      O => \char_r[6]_i_16_n_0\
    );
\char_r[6]_i_17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEE0000FFF00000"
    )
        port map (
      I0 => \char_r[6]_i_56_n_0\,
      I1 => \char_r[6]_i_57_n_0\,
      I2 => \char_r[6]_i_58_n_0\,
      I3 => \char_r[6]_i_59_n_0\,
      I4 => \hex_digit_idx_r_reg_n_0_[0]\,
      I5 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_17_n_0\
    );
\char_r[6]_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFEAEAEA"
    )
        port map (
      I0 => \char_r[6]_i_60_n_0\,
      I1 => \char_r[6]_i_30_n_0\,
      I2 => \hex_r_reg[1]_3\(19),
      I3 => \char_r[6]_i_31_n_0\,
      I4 => \hex_r_reg[2]_2\(19),
      I5 => \hex_digit_idx_r[2]_i_2_n_0\,
      O => \char_r[6]_i_18_n_0\
    );
\char_r[6]_i_19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAA888A888A888"
    )
        port map (
      I0 => \char_r[6]_i_32_n_0\,
      I1 => \char_r[6]_i_61_n_0\,
      I2 => \char_r[6]_i_30_n_0\,
      I3 => \hex_r_reg[1]_3\(27),
      I4 => \char_r[6]_i_31_n_0\,
      I5 => \hex_r_reg[2]_2\(27),
      O => \char_r[6]_i_19_n_0\
    );
\char_r[6]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E0FFE000"
    )
        port map (
      I0 => \char_r[6]_i_3_n_0\,
      I1 => \char_r[6]_i_4_n_0\,
      I2 => \char_r[6]_i_5_n_0\,
      I3 => \char_idx_r[5]_i_5_n_0\,
      I4 => \char_r[6]_i_6_n_0\,
      O => char_r0_in(6)
    );
\char_r[6]_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEE0000FFF00000"
    )
        port map (
      I0 => \char_r[6]_i_62_n_0\,
      I1 => \char_r[6]_i_63_n_0\,
      I2 => \char_r[6]_i_64_n_0\,
      I3 => \char_r[6]_i_65_n_0\,
      I4 => \hex_digit_idx_r_reg_n_0_[0]\,
      I5 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_20_n_0\
    );
\char_r[6]_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0E0F0E0F0E0F0E00"
    )
        port map (
      I0 => \char_r[6]_i_66_n_0\,
      I1 => \char_r[6]_i_67_n_0\,
      I2 => \hex_digit_idx_r_reg_n_0_[0]\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      I4 => \char_r[6]_i_68_n_0\,
      I5 => \char_r[6]_i_69_n_0\,
      O => \char_r[6]_i_21_n_0\
    );
\char_r[6]_i_22\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FCAA"
    )
        port map (
      I0 => \char_r[6]_i_70_n_0\,
      I1 => data23(5),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[6]_i_22_n_0\
    );
\char_r[6]_i_23\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AAAAFCCC0000"
    )
        port map (
      I0 => \char_r[6]_i_71_n_0\,
      I1 => \char_r[6]_i_72_n_0\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_r[6]_i_73_n_0\,
      I4 => \char_idx_r_reg_n_0_[4]\,
      I5 => \char_idx_r_reg_n_0_[3]\,
      O => \char_r[6]_i_23_n_0\
    );
\char_r[6]_i_24\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF3210"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[1]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => data13(0),
      I3 => data25(0),
      I4 => \char_r[6]_i_74_n_0\,
      O => \char_r[6]_i_24_n_0\
    );
\char_r[6]_i_25\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(29),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(29),
      O => \char_r[6]_i_25_n_0\
    );
\char_r[6]_i_26\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(29),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(29),
      O => \char_r[6]_i_26_n_0\
    );
\char_r[6]_i_27\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(21),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(21),
      O => \char_r[6]_i_27_n_0\
    );
\char_r[6]_i_28\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(21),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(21),
      O => \char_r[6]_i_28_n_0\
    );
\char_r[6]_i_29\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(17),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(17),
      O => \char_r[6]_i_29_n_0\
    );
\char_r[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFEFFFEFFFE00"
    )
        port map (
      I0 => \char_r[6]_i_7_n_0\,
      I1 => \char_r[6]_i_8_n_0\,
      I2 => \char_r[6]_i_9_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[2]\,
      I4 => \char_r[6]_i_10_n_0\,
      I5 => \char_r[6]_i_11_n_0\,
      O => \char_r[6]_i_3_n_0\
    );
\char_r[6]_i_30\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \char_r[1]_i_2_n_0\,
      I1 => \char_r[0]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      O => \char_r[6]_i_30_n_0\
    );
\char_r[6]_i_31\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \char_r[1]_i_2_n_0\,
      I1 => \char_r[2]_i_3_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      O => \char_r[6]_i_31_n_0\
    );
\char_r[6]_i_32\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \hex_digit_idx_r_reg_n_0_[1]\,
      I1 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_32_n_0\
    );
\char_r[6]_i_33\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(25),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(25),
      O => \char_r[6]_i_33_n_0\
    );
\char_r[6]_i_34\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(13),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(13),
      O => \char_r[6]_i_34_n_0\
    );
\char_r[6]_i_35\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(13),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(13),
      O => \char_r[6]_i_35_n_0\
    );
\char_r[6]_i_36\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(5),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(5),
      O => \char_r[6]_i_36_n_0\
    );
\char_r[6]_i_37\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(5),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(5),
      O => \char_r[6]_i_37_n_0\
    );
\char_r[6]_i_38\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(9),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(9),
      O => \char_r[6]_i_38_n_0\
    );
\char_r[6]_i_39\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(9),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(9),
      O => \char_r[6]_i_39_n_0\
    );
\char_r[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFEFFFEFFFE00"
    )
        port map (
      I0 => \char_r[6]_i_12_n_0\,
      I1 => \char_r[6]_i_13_n_0\,
      I2 => \char_r[6]_i_14_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[2]\,
      I4 => \char_r[6]_i_15_n_0\,
      I5 => \char_r[6]_i_16_n_0\,
      O => \char_r[6]_i_4_n_0\
    );
\char_r[6]_i_40\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(1),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(1),
      O => \char_r[6]_i_40_n_0\
    );
\char_r[6]_i_41\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(1),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(1),
      O => \char_r[6]_i_41_n_0\
    );
\char_r[6]_i_42\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(30),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(30),
      O => \char_r[6]_i_42_n_0\
    );
\char_r[6]_i_43\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(30),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(30),
      O => \char_r[6]_i_43_n_0\
    );
\char_r[6]_i_44\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(22),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(22),
      O => \char_r[6]_i_44_n_0\
    );
\char_r[6]_i_45\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(22),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(22),
      O => \char_r[6]_i_45_n_0\
    );
\char_r[6]_i_46\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(18),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(18),
      O => \char_r[6]_i_46_n_0\
    );
\char_r[6]_i_47\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(26),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(26),
      O => \char_r[6]_i_47_n_0\
    );
\char_r[6]_i_48\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(14),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(14),
      O => \char_r[6]_i_48_n_0\
    );
\char_r[6]_i_49\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(14),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(14),
      O => \char_r[6]_i_49_n_0\
    );
\char_r[6]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFEFFFEFFFE00"
    )
        port map (
      I0 => \char_r[6]_i_17_n_0\,
      I1 => \char_r[6]_i_18_n_0\,
      I2 => \char_r[6]_i_19_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[2]\,
      I4 => \char_r[6]_i_20_n_0\,
      I5 => \char_r[6]_i_21_n_0\,
      O => \char_r[6]_i_5_n_0\
    );
\char_r[6]_i_50\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(6),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(6),
      O => \char_r[6]_i_50_n_0\
    );
\char_r[6]_i_51\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(6),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(6),
      O => \char_r[6]_i_51_n_0\
    );
\char_r[6]_i_52\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(10),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(10),
      O => \char_r[6]_i_52_n_0\
    );
\char_r[6]_i_53\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(10),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(10),
      O => \char_r[6]_i_53_n_0\
    );
\char_r[6]_i_54\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(2),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(2),
      O => \char_r[6]_i_54_n_0\
    );
\char_r[6]_i_55\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(2),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(2),
      O => \char_r[6]_i_55_n_0\
    );
\char_r[6]_i_56\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(31),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(31),
      O => \char_r[6]_i_56_n_0\
    );
\char_r[6]_i_57\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(31),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(31),
      O => \char_r[6]_i_57_n_0\
    );
\char_r[6]_i_58\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(23),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(23),
      O => \char_r[6]_i_58_n_0\
    );
\char_r[6]_i_59\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(23),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(23),
      O => \char_r[6]_i_59_n_0\
    );
\char_r[6]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"333030303030B8B8"
    )
        port map (
      I0 => \char_r[6]_i_22_n_0\,
      I1 => \char_idx_r_reg_n_0_[5]\,
      I2 => \char_r[6]_i_23_n_0\,
      I3 => \char_r[6]_i_24_n_0\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_idx_r_reg_n_0_[4]\,
      O => \char_r[6]_i_6_n_0\
    );
\char_r[6]_i_60\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(19),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(19),
      O => \char_r[6]_i_60_n_0\
    );
\char_r[6]_i_61\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(27),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(27),
      O => \char_r[6]_i_61_n_0\
    );
\char_r[6]_i_62\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(15),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(15),
      O => \char_r[6]_i_62_n_0\
    );
\char_r[6]_i_63\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(15),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(15),
      O => \char_r[6]_i_63_n_0\
    );
\char_r[6]_i_64\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(7),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(7),
      O => \char_r[6]_i_64_n_0\
    );
\char_r[6]_i_65\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(7),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(7),
      O => \char_r[6]_i_65_n_0\
    );
\char_r[6]_i_66\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(11),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(11),
      O => \char_r[6]_i_66_n_0\
    );
\char_r[6]_i_67\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(11),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(11),
      O => \char_r[6]_i_67_n_0\
    );
\char_r[6]_i_68\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"020C0200"
    )
        port map (
      I0 => \hex_r_reg[1]_3\(3),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[2]_i_3_n_0\,
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \hex_r_reg[2]_2\(3),
      O => \char_r[6]_i_68_n_0\
    );
\char_r[6]_i_69\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF830080"
    )
        port map (
      I0 => \hex_r_reg[3]_1\(3),
      I1 => \char_r[1]_i_2_n_0\,
      I2 => \char_r[0]_i_2_n_0\,
      I3 => \char_r[2]_i_3_n_0\,
      I4 => \hex_r_reg[4]_0\(3),
      O => \char_r[6]_i_69_n_0\
    );
\char_r[6]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEE0000FFF00000"
    )
        port map (
      I0 => \char_r[6]_i_25_n_0\,
      I1 => \char_r[6]_i_26_n_0\,
      I2 => \char_r[6]_i_27_n_0\,
      I3 => \char_r[6]_i_28_n_0\,
      I4 => \hex_digit_idx_r_reg_n_0_[0]\,
      I5 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_7_n_0\
    );
\char_r[6]_i_70\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data39(4),
      I1 => data5(0),
      I2 => data15(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data34(2),
      O => \char_r[6]_i_70_n_0\
    );
\char_r[6]_i_71\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BF8CFC00"
    )
        port map (
      I0 => data15(0),
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => data11(0),
      I4 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[6]_i_71_n_0\
    );
\char_r[6]_i_72\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000B8B80000FF00"
    )
        port map (
      I0 => data10(0),
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => data15(0),
      I3 => data16(6),
      I4 => \char_idx_r_reg_n_0_[2]\,
      I5 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_72_n_0\
    );
\char_r[6]_i_73\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data21(6),
      I1 => data29(0),
      I2 => data16(6),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data23(5),
      O => \char_r[6]_i_73_n_0\
    );
\char_r[6]_i_74\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F971E86000000000"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[1]\,
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => data30(0),
      I3 => data30(5),
      I4 => data28(0),
      I5 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[6]_i_74_n_0\
    );
\char_r[6]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFEAEAEA"
    )
        port map (
      I0 => \char_r[6]_i_29_n_0\,
      I1 => \char_r[6]_i_30_n_0\,
      I2 => \hex_r_reg[1]_3\(17),
      I3 => \char_r[6]_i_31_n_0\,
      I4 => \hex_r_reg[2]_2\(17),
      I5 => \hex_digit_idx_r[2]_i_2_n_0\,
      O => \char_r[6]_i_8_n_0\
    );
\char_r[6]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAA888A888A888"
    )
        port map (
      I0 => \char_r[6]_i_32_n_0\,
      I1 => \char_r[6]_i_33_n_0\,
      I2 => \char_r[6]_i_30_n_0\,
      I3 => \hex_r_reg[1]_3\(25),
      I4 => \char_r[6]_i_31_n_0\,
      I5 => \hex_r_reg[2]_2\(25),
      O => \char_r[6]_i_9_n_0\
    );
\char_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_13,
      D => char_r0_in(0),
      Q => \char_r_reg_n_0_[0]\,
      R => '0'
    );
\char_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_13,
      D => char_r0_in(1),
      Q => \char_r_reg_n_0_[1]\,
      R => '0'
    );
\char_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_13,
      D => char_r0_in(2),
      Q => \char_r_reg_n_0_[2]\,
      R => '0'
    );
\char_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_13,
      D => char_r0_in(3),
      Q => \char_r_reg_n_0_[3]\,
      R => '0'
    );
\char_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_13,
      D => char_r0_in(4),
      Q => \char_r_reg_n_0_[4]\,
      R => '0'
    );
\char_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_13,
      D => char_r0_in(5),
      Q => \char_r_reg_n_0_[5]\,
      R => '0'
    );
\char_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_13,
      D => char_r0_in(6),
      Q => \char_r_reg_n_0_[6]\,
      R => '0'
    );
\hex_digit_idx_r[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"01FF"
    )
        port map (
      I0 => \hex_digit_idx_r_reg_n_0_[2]\,
      I1 => \hex_digit_idx_r_reg_n_0_[0]\,
      I2 => \hex_digit_idx_r_reg_n_0_[1]\,
      I3 => state_r(1),
      O => \hex_digit_idx_r[1]_i_2_n_0\
    );
\hex_digit_idx_r[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \hex_digit_idx_r_reg_n_0_[0]\,
      I1 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \hex_digit_idx_r[2]_i_2_n_0\
    );
\hex_digit_idx_r[2]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => state_r(1),
      I1 => rst_n,
      I2 => \FSM_sequential_state_r[1]_i_2_n_0\,
      O => \hex_digit_idx_r[2]_i_3_n_0\
    );
\hex_digit_idx_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_printc_n_12,
      Q => \hex_digit_idx_r_reg_n_0_[0]\,
      R => '0'
    );
\hex_digit_idx_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_printc_n_11,
      Q => \hex_digit_idx_r_reg_n_0_[1]\,
      R => '0'
    );
\hex_digit_idx_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_printc_n_10,
      Q => \hex_digit_idx_r_reg_n_0_[2]\,
      R => '0'
    );
\hex_r[1][0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][0]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(0),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(0)
    );
\hex_r[1][0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(0),
      I1 => \hex_r_reg[1][31]_1\(0),
      I2 => cycle_r_reg(0),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][0]_i_2_n_0\
    );
\hex_r[1][10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][10]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(10),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(10)
    );
\hex_r[1][10]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(10),
      I1 => \hex_r_reg[1][31]_1\(10),
      I2 => cycle_r_reg(10),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][10]_i_2_n_0\
    );
\hex_r[1][11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][11]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(11),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(11)
    );
\hex_r[1][11]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(11),
      I1 => \hex_r_reg[1][31]_1\(11),
      I2 => cycle_r_reg(11),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][11]_i_2_n_0\
    );
\hex_r[1][12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][12]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(12),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(12)
    );
\hex_r[1][12]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(12),
      I1 => \hex_r_reg[1][31]_1\(12),
      I2 => cycle_r_reg(12),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][12]_i_2_n_0\
    );
\hex_r[1][13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][13]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(13),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(13)
    );
\hex_r[1][13]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(13),
      I1 => \hex_r_reg[1][31]_1\(13),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][13]_i_2_n_0\
    );
\hex_r[1][14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][14]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(14),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(14)
    );
\hex_r[1][14]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(14),
      I1 => \hex_r_reg[1][31]_1\(14),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][14]_i_2_n_0\
    );
\hex_r[1][15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][15]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(15),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(15)
    );
\hex_r[1][15]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(15),
      I1 => \hex_r_reg[1][31]_1\(15),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][15]_i_2_n_0\
    );
\hex_r[1][16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][16]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(16),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(16)
    );
\hex_r[1][16]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(16),
      I1 => \hex_r_reg[1][31]_1\(16),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][16]_i_2_n_0\
    );
\hex_r[1][17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][17]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(17),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(17)
    );
\hex_r[1][17]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(17),
      I1 => \hex_r_reg[1][31]_1\(17),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][17]_i_2_n_0\
    );
\hex_r[1][18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][18]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(18),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(18)
    );
\hex_r[1][18]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(18),
      I1 => \hex_r_reg[1][31]_1\(18),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][18]_i_2_n_0\
    );
\hex_r[1][19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][19]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(19),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(19)
    );
\hex_r[1][19]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(19),
      I1 => \hex_r_reg[1][31]_1\(19),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][19]_i_2_n_0\
    );
\hex_r[1][1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][1]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(1),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(1)
    );
\hex_r[1][1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(1),
      I1 => \hex_r_reg[1][31]_1\(1),
      I2 => cycle_r_reg(1),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][1]_i_2_n_0\
    );
\hex_r[1][20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][20]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(20),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(20)
    );
\hex_r[1][20]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(20),
      I1 => \hex_r_reg[1][31]_1\(20),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][20]_i_2_n_0\
    );
\hex_r[1][21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][21]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(21),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(21)
    );
\hex_r[1][21]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(21),
      I1 => \hex_r_reg[1][31]_1\(21),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][21]_i_2_n_0\
    );
\hex_r[1][22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][22]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(22),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(22)
    );
\hex_r[1][22]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(22),
      I1 => \hex_r_reg[1][31]_1\(22),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][22]_i_2_n_0\
    );
\hex_r[1][23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][23]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(23),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(23)
    );
\hex_r[1][23]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(23),
      I1 => \hex_r_reg[1][31]_1\(23),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][23]_i_2_n_0\
    );
\hex_r[1][24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][24]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(24),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(24)
    );
\hex_r[1][24]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(24),
      I1 => \hex_r_reg[1][31]_1\(24),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][24]_i_2_n_0\
    );
\hex_r[1][25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][25]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(25),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(25)
    );
\hex_r[1][25]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(25),
      I1 => \hex_r_reg[1][31]_1\(25),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][25]_i_2_n_0\
    );
\hex_r[1][26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][26]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(26),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(26)
    );
\hex_r[1][26]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(26),
      I1 => \hex_r_reg[1][31]_1\(26),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][26]_i_2_n_0\
    );
\hex_r[1][27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][27]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(27),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(27)
    );
\hex_r[1][27]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(27),
      I1 => \hex_r_reg[1][31]_1\(27),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][27]_i_2_n_0\
    );
\hex_r[1][28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][28]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(28),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(28)
    );
\hex_r[1][28]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(28),
      I1 => \hex_r_reg[1][31]_1\(28),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][28]_i_2_n_0\
    );
\hex_r[1][29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][29]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(29),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(29)
    );
\hex_r[1][29]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFAE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(23),
      I1 => \hex_r_reg[1][31]_0\(21),
      I2 => \hex_r_reg[1][31]_0\(22),
      I3 => \hex_r_reg[1][31]_0\(20),
      I4 => \hex_r_reg[1][31]_0\(19),
      O => \hex_r[1][29]_i_10_n_0\
    );
\hex_r[1][29]_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFAE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(26),
      I1 => \hex_r_reg[1][31]_0\(24),
      I2 => \hex_r_reg[1][31]_0\(25),
      I3 => \hex_r_reg[1][31]_0\(23),
      I4 => \hex_r_reg[1][31]_0\(22),
      O => \hex_r[1][29]_i_11_n_0\
    );
\hex_r[1][29]_i_12\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFAE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(17),
      I1 => \hex_r_reg[1][31]_0\(15),
      I2 => \hex_r_reg[1][31]_0\(16),
      I3 => \hex_r_reg[1][31]_0\(14),
      I4 => \hex_r_reg[1][31]_0\(13),
      O => \hex_r[1][29]_i_12_n_0\
    );
\hex_r[1][29]_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFAE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(20),
      I1 => \hex_r_reg[1][31]_0\(18),
      I2 => \hex_r_reg[1][31]_0\(19),
      I3 => \hex_r_reg[1][31]_0\(17),
      I4 => \hex_r_reg[1][31]_0\(16),
      O => \hex_r[1][29]_i_13_n_0\
    );
\hex_r[1][29]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => cycle_r_reg(29),
      I1 => \hex_r_reg[1][31]_1\(29),
      I2 => Q(4),
      I3 => Q(1),
      O => \hex_r[1][29]_i_2_n_0\
    );
\hex_r[1][29]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[1]_1\,
      I1 => \hex_r_reg[1][31]_0\(30),
      I2 => \hex_r_reg[1][31]_0\(31),
      I3 => \hex_r[1][29]_i_7_n_0\,
      I4 => \hex_r_reg[1][31]_0\(29),
      I5 => \hex_r_reg[1][31]_0\(28),
      O => \hex_r[1][29]_i_3_n_0\
    );
\hex_r[1][29]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(9),
      I1 => \hex_r_reg[1][31]_0\(11),
      I2 => \hex_r_reg[1][31]_0\(10),
      I3 => \hex_r[1][29]_i_8_n_0\,
      I4 => \hex_r[1][29]_i_9_n_0\,
      O => \hex_r[1][29]_i_4_n_0\
    );
\hex_r[1][29]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \hex_r[1][29]_i_10_n_0\,
      I1 => \hex_r[1][29]_i_11_n_0\,
      I2 => \hex_r[1][29]_i_12_n_0\,
      I3 => \hex_r[1][29]_i_13_n_0\,
      O => \hex_r[1][29]_i_5_n_0\
    );
\hex_r[1][29]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(30),
      I1 => \hex_r_reg[1][31]_0\(31),
      I2 => \hex_r[1][29]_i_7_n_0\,
      I3 => \hex_r_reg[1][31]_0\(29),
      I4 => \hex_r_reg[1][31]_0\(28),
      I5 => \^fsm_sequential_state_r_reg[1]_1\,
      O => \hex_r[1][29]_i_6_n_0\
    );
\hex_r[1][29]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFAE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(29),
      I1 => \hex_r_reg[1][31]_0\(27),
      I2 => \hex_r_reg[1][31]_0\(28),
      I3 => \hex_r_reg[1][31]_0\(26),
      I4 => \hex_r_reg[1][31]_0\(25),
      O => \hex_r[1][29]_i_7_n_0\
    );
\hex_r[1][29]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFFFEFFFFFFFE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(1),
      I1 => \hex_r_reg[1][31]_0\(0),
      I2 => \hex_r_reg[1][31]_0\(2),
      I3 => \hex_r_reg[1][31]_0\(14),
      I4 => \hex_r_reg[1][31]_0\(12),
      I5 => \hex_r_reg[1][31]_0\(13),
      O => \hex_r[1][29]_i_8_n_0\
    );
\hex_r[1][29]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(7),
      I1 => \hex_r_reg[1][31]_0\(6),
      I2 => \hex_r_reg[1][31]_0\(8),
      I3 => \hex_r_reg[1][31]_0\(4),
      I4 => \hex_r_reg[1][31]_0\(5),
      I5 => \hex_r_reg[1][31]_0\(3),
      O => \hex_r[1][29]_i_9_n_0\
    );
\hex_r[1][2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][2]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(2),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(2)
    );
\hex_r[1][2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(2),
      I1 => \hex_r_reg[1][31]_1\(2),
      I2 => cycle_r_reg(2),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][2]_i_2_n_0\
    );
\hex_r[1][30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFAEAFAEFAAEAAA"
    )
        port map (
      I0 => \hex_r[1][30]_i_2_n_0\,
      I1 => cycle_r_reg(30),
      I2 => Q(4),
      I3 => Q(1),
      I4 => \hex_r_reg[1][31]_0\(30),
      I5 => \hex_r_reg[1][31]_1\(30),
      O => prints_hex_w(30)
    );
\hex_r[1][30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0200020002000000"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[1]_1\,
      I1 => \hex_r[1][31]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(31),
      I3 => \hex_r_reg[1][31]_0\(30),
      I4 => \hex_r[1][29]_i_4_n_0\,
      I5 => \hex_r[1][31]_i_4_n_0\,
      O => \hex_r[1][30]_i_2_n_0\
    );
\hex_r[1][31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFAEAFAEFAAEAAA"
    )
        port map (
      I0 => \hex_r[1][31]_i_2_n_0\,
      I1 => cycle_r_reg(31),
      I2 => Q(4),
      I3 => Q(1),
      I4 => \hex_r_reg[1][31]_0\(31),
      I5 => \hex_r_reg[1][31]_1\(31),
      O => prints_hex_w(31)
    );
\hex_r[1][31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0200020002000000"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[1]_1\,
      I1 => \hex_r[1][31]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(30),
      I3 => \hex_r_reg[1][31]_0\(31),
      I4 => \hex_r[1][29]_i_4_n_0\,
      I5 => \hex_r[1][31]_i_4_n_0\,
      O => \hex_r[1][31]_i_2_n_0\
    );
\hex_r[1][31]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(28),
      I1 => \hex_r_reg[1][31]_0\(29),
      O => \hex_r[1][31]_i_3_n_0\
    );
\hex_r[1][31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFEFFFEFE"
    )
        port map (
      I0 => \hex_r[1][29]_i_5_n_0\,
      I1 => \hex_r_reg[1][31]_0\(25),
      I2 => \hex_r_reg[1][31]_0\(26),
      I3 => \hex_r_reg[1][31]_0\(28),
      I4 => \hex_r_reg[1][31]_0\(27),
      I5 => \hex_r_reg[1][31]_0\(29),
      O => \hex_r[1][31]_i_4_n_0\
    );
\hex_r[1][3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][3]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(3),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(3)
    );
\hex_r[1][3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(3),
      I1 => \hex_r_reg[1][31]_1\(3),
      I2 => cycle_r_reg(3),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][3]_i_2_n_0\
    );
\hex_r[1][4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF1F0FFF0F1F0"
    )
        port map (
      I0 => \hex_r[1][29]_i_4_n_0\,
      I1 => \hex_r[1][29]_i_5_n_0\,
      I2 => \hex_r[1][4]_i_2_n_0\,
      I3 => \hex_r[1][29]_i_3_n_0\,
      I4 => \hex_r_reg[1][31]_0\(4),
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(4)
    );
\hex_r[1][4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(4),
      I1 => \hex_r_reg[1][31]_1\(4),
      I2 => cycle_r_reg(4),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][4]_i_2_n_0\
    );
\hex_r[1][5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF1F0FFF0F1F0"
    )
        port map (
      I0 => \hex_r[1][29]_i_4_n_0\,
      I1 => \hex_r[1][29]_i_5_n_0\,
      I2 => \hex_r[1][5]_i_2_n_0\,
      I3 => \hex_r[1][29]_i_3_n_0\,
      I4 => \hex_r_reg[1][31]_0\(5),
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(5)
    );
\hex_r[1][5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(5),
      I1 => \hex_r_reg[1][31]_1\(5),
      I2 => cycle_r_reg(5),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][5]_i_2_n_0\
    );
\hex_r[1][6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF1F0FFF0F1F0"
    )
        port map (
      I0 => \hex_r[1][29]_i_4_n_0\,
      I1 => \hex_r[1][29]_i_5_n_0\,
      I2 => \hex_r[1][6]_i_2_n_0\,
      I3 => \hex_r[1][29]_i_3_n_0\,
      I4 => \hex_r_reg[1][31]_0\(6),
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(6)
    );
\hex_r[1][6]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(6),
      I1 => \hex_r_reg[1][31]_1\(6),
      I2 => cycle_r_reg(6),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][6]_i_2_n_0\
    );
\hex_r[1][7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF1F0FFF0F1F0"
    )
        port map (
      I0 => \hex_r[1][29]_i_4_n_0\,
      I1 => \hex_r[1][29]_i_5_n_0\,
      I2 => \hex_r[1][7]_i_2_n_0\,
      I3 => \hex_r[1][29]_i_3_n_0\,
      I4 => \hex_r_reg[1][31]_0\(7),
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(7)
    );
\hex_r[1][7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(7),
      I1 => \hex_r_reg[1][31]_1\(7),
      I2 => cycle_r_reg(7),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][7]_i_2_n_0\
    );
\hex_r[1][8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF1F0FFF0F1F0"
    )
        port map (
      I0 => \hex_r[1][29]_i_4_n_0\,
      I1 => \hex_r[1][29]_i_5_n_0\,
      I2 => \hex_r[1][8]_i_2_n_0\,
      I3 => \hex_r[1][29]_i_3_n_0\,
      I4 => \hex_r_reg[1][31]_0\(8),
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(8)
    );
\hex_r[1][8]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(8),
      I1 => \hex_r_reg[1][31]_1\(8),
      I2 => cycle_r_reg(8),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][8]_i_2_n_0\
    );
\hex_r[1][9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFAFAFAEAEAEAAA"
    )
        port map (
      I0 => \hex_r[1][9]_i_2_n_0\,
      I1 => \hex_r[1][29]_i_3_n_0\,
      I2 => \hex_r_reg[1][31]_0\(9),
      I3 => \hex_r[1][29]_i_4_n_0\,
      I4 => \hex_r[1][29]_i_5_n_0\,
      I5 => \hex_r[1][29]_i_6_n_0\,
      O => prints_hex_w(9)
    );
\hex_r[1][9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(9),
      I1 => \hex_r_reg[1][31]_1\(9),
      I2 => cycle_r_reg(9),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[1][9]_i_2_n_0\
    );
\hex_r[2][0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA03"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(0),
      I1 => \hex_r_reg[1][12]_0\(0),
      I2 => Q(1),
      I3 => Q(4),
      O => \hex_r[2][0]_i_1_n_0\
    );
\hex_r[2][10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(10),
      I1 => Q(4),
      O => \hex_r[2][10]_i_1_n_0\
    );
\hex_r[2][11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(11),
      I1 => Q(4),
      O => \hex_r[2][11]_i_1_n_0\
    );
\hex_r[2][12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(12),
      I1 => Q(4),
      O => \hex_r[2][12]_i_1_n_0\
    );
\hex_r[2][13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(13),
      I1 => Q(4),
      O => \hex_r[2][13]_i_1_n_0\
    );
\hex_r[2][14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(14),
      I1 => Q(4),
      O => \hex_r[2][14]_i_1_n_0\
    );
\hex_r[2][15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(15),
      I1 => Q(4),
      O => \hex_r[2][15]_i_1_n_0\
    );
\hex_r[2][16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(16),
      I1 => Q(4),
      O => \hex_r[2][16]_i_1_n_0\
    );
\hex_r[2][17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(17),
      I1 => Q(4),
      O => \hex_r[2][17]_i_1_n_0\
    );
\hex_r[2][18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(18),
      I1 => Q(4),
      O => \hex_r[2][18]_i_1_n_0\
    );
\hex_r[2][19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(19),
      I1 => Q(4),
      O => \hex_r[2][19]_i_1_n_0\
    );
\hex_r[2][1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAA00C3"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(1),
      I1 => \hex_r_reg[1][12]_0\(1),
      I2 => \hex_r_reg[1][12]_0\(0),
      I3 => Q(1),
      I4 => Q(4),
      O => \hex_r[2][1]_i_1_n_0\
    );
\hex_r[2][20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(20),
      I1 => Q(4),
      O => \hex_r[2][20]_i_1_n_0\
    );
\hex_r[2][21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(21),
      I1 => Q(4),
      O => \hex_r[2][21]_i_1_n_0\
    );
\hex_r[2][22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(22),
      I1 => Q(4),
      O => \hex_r[2][22]_i_1_n_0\
    );
\hex_r[2][23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(23),
      I1 => Q(4),
      O => \hex_r[2][23]_i_1_n_0\
    );
\hex_r[2][24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(24),
      I1 => Q(4),
      O => \hex_r[2][24]_i_1_n_0\
    );
\hex_r[2][25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(25),
      I1 => Q(4),
      O => \hex_r[2][25]_i_1_n_0\
    );
\hex_r[2][26]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(26),
      I1 => Q(4),
      O => \hex_r[2][26]_i_1_n_0\
    );
\hex_r[2][27]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(27),
      I1 => Q(4),
      O => \hex_r[2][27]_i_1_n_0\
    );
\hex_r[2][28]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(28),
      I1 => Q(4),
      O => \hex_r[2][28]_i_1_n_0\
    );
\hex_r[2][29]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(29),
      I1 => Q(4),
      O => \hex_r[2][29]_i_1_n_0\
    );
\hex_r[2][2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA03"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(2),
      I1 => \^addr_r_reg[2]\,
      I2 => Q(1),
      I3 => Q(4),
      O => \hex_r[2][2]_i_1_n_0\
    );
\hex_r[2][2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9A"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(2),
      I1 => \hex_r_reg[1][12]_0\(0),
      I2 => \hex_r_reg[1][12]_0\(1),
      O => \^addr_r_reg[2]\
    );
\hex_r[2][30]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(30),
      I1 => Q(4),
      O => \hex_r[2][30]_i_1_n_0\
    );
\hex_r[2][31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
        port map (
      I0 => rst_n,
      I1 => state_r(1),
      I2 => state_r(0),
      I3 => \hex_r_reg[1][12]_0\(3),
      I4 => \hex_r_reg[1][12]_0\(2),
      I5 => \^fsm_sequential_state_r_reg[1]_0\,
      O => \hex_r[2][31]_i_1_n_0\
    );
\hex_r[2][31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(31),
      I1 => Q(4),
      O => \hex_r[2][31]_i_2_n_0\
    );
\hex_r[2][3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA03"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(3),
      I1 => \^addr_r_reg[1]\,
      I2 => Q(1),
      I3 => Q(4),
      O => \hex_r[2][3]_i_1_n_0\
    );
\hex_r[2][3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"699C"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(1),
      I1 => \hex_r_reg[1][12]_0\(3),
      I2 => \hex_r_reg[1][12]_0\(0),
      I3 => \hex_r_reg[1][12]_0\(2),
      O => \^addr_r_reg[1]\
    );
\hex_r[2][4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CACF"
    )
        port map (
      I0 => Q(1),
      I1 => \hex_r_reg[2][31]_0\(4),
      I2 => Q(4),
      I3 => \^addr_r_reg[2]_1\,
      O => \hex_r[2][4]_i_1_n_0\
    );
\hex_r[2][4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"522B"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(2),
      I1 => \hex_r_reg[1][12]_0\(0),
      I2 => \hex_r_reg[1][12]_0\(3),
      I3 => \hex_r_reg[1][12]_0\(1),
      O => \^addr_r_reg[2]_1\
    );
\hex_r[2][5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CACF"
    )
        port map (
      I0 => Q(1),
      I1 => \hex_r_reg[2][31]_0\(5),
      I2 => Q(4),
      I3 => \^addr_r_reg[2]_0\,
      O => \hex_r[2][5]_i_1_n_0\
    );
\hex_r[2][5]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"1A"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(2),
      I1 => \hex_r_reg[1][12]_0\(1),
      I2 => \hex_r_reg[1][12]_0\(3),
      O => \^addr_r_reg[2]_0\
    );
\hex_r[2][6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00F1F1"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(2),
      I1 => \hex_r_reg[1][12]_0\(3),
      I2 => Q(1),
      I3 => \hex_r_reg[2][31]_0\(6),
      I4 => Q(4),
      O => \hex_r[2][6]_i_1_n_0\
    );
\hex_r[2][7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AFAC"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(7),
      I1 => Q(1),
      I2 => Q(4),
      I3 => \^in7\(0),
      O => \hex_r[2][7]_i_1_n_0\
    );
\hex_r[2][8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AFAC"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(8),
      I1 => Q(1),
      I2 => Q(4),
      I3 => \^in7\(0),
      O => \hex_r[2][8]_i_1_n_0\
    );
\hex_r[2][9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \hex_r_reg[2][31]_0\(9),
      I1 => Q(4),
      O => \hex_r[2][9]_i_1_n_0\
    );
\hex_r[3][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(0),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(0),
      O => \hex_r[3][0]_i_1_n_0\
    );
\hex_r[3][10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(10),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(10),
      O => \hex_r[3][10]_i_1_n_0\
    );
\hex_r[3][11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(11),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(11),
      O => \hex_r[3][11]_i_1_n_0\
    );
\hex_r[3][12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(12),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(12),
      O => \hex_r[3][12]_i_1_n_0\
    );
\hex_r[3][13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(13),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(13),
      O => \hex_r[3][13]_i_1_n_0\
    );
\hex_r[3][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(14),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(14),
      O => \hex_r[3][14]_i_1_n_0\
    );
\hex_r[3][15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(15),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(15),
      O => \hex_r[3][15]_i_1_n_0\
    );
\hex_r[3][16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(16),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(16),
      O => \hex_r[3][16]_i_1_n_0\
    );
\hex_r[3][17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(17),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(17),
      O => \hex_r[3][17]_i_1_n_0\
    );
\hex_r[3][18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(18),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(18),
      O => \hex_r[3][18]_i_1_n_0\
    );
\hex_r[3][19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(19),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(19),
      O => \hex_r[3][19]_i_1_n_0\
    );
\hex_r[3][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(1),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(1),
      O => \hex_r[3][1]_i_1_n_0\
    );
\hex_r[3][20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(20),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(20),
      O => \hex_r[3][20]_i_1_n_0\
    );
\hex_r[3][21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(21),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(21),
      O => \hex_r[3][21]_i_1_n_0\
    );
\hex_r[3][22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(22),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(22),
      O => \hex_r[3][22]_i_1_n_0\
    );
\hex_r[3][23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(23),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(23),
      O => \hex_r[3][23]_i_1_n_0\
    );
\hex_r[3][24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(24),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(24),
      O => \hex_r[3][24]_i_1_n_0\
    );
\hex_r[3][25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(25),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(25),
      O => \hex_r[3][25]_i_1_n_0\
    );
\hex_r[3][26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(26),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(26),
      O => \hex_r[3][26]_i_1_n_0\
    );
\hex_r[3][27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(27),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(27),
      O => \hex_r[3][27]_i_1_n_0\
    );
\hex_r[3][28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(28),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(28),
      O => \hex_r[3][28]_i_1_n_0\
    );
\hex_r[3][29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(29),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(29),
      O => \hex_r[3][29]_i_1_n_0\
    );
\hex_r[3][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(2),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(2),
      O => \hex_r[3][2]_i_1_n_0\
    );
\hex_r[3][30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(30),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(30),
      O => \hex_r[3][30]_i_1_n_0\
    );
\hex_r[3][31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(31),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(31),
      O => \hex_r[3][31]_i_1_n_0\
    );
\hex_r[3][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(3),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(3),
      O => \hex_r[3][3]_i_1_n_0\
    );
\hex_r[3][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(4),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(4),
      O => \hex_r[3][4]_i_1_n_0\
    );
\hex_r[3][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(5),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(5),
      O => \hex_r[3][5]_i_1_n_0\
    );
\hex_r[3][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(6),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(6),
      O => \hex_r[3][6]_i_1_n_0\
    );
\hex_r[3][7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(7),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(7),
      O => \hex_r[3][7]_i_1_n_0\
    );
\hex_r[3][8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(8),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(8),
      O => \hex_r[3][8]_i_1_n_0\
    );
\hex_r[3][9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \hex_r_reg[3][31]_0\(9),
      I1 => Q(4),
      I2 => \hex_r_reg[3][31]_1\(9),
      O => \hex_r[3][9]_i_1_n_0\
    );
\hex_r_reg[1][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(0),
      Q => \hex_r_reg[1]_3\(0),
      R => '0'
    );
\hex_r_reg[1][10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(10),
      Q => \hex_r_reg[1]_3\(10),
      R => '0'
    );
\hex_r_reg[1][11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(11),
      Q => \hex_r_reg[1]_3\(11),
      R => '0'
    );
\hex_r_reg[1][12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(12),
      Q => \hex_r_reg[1]_3\(12),
      R => '0'
    );
\hex_r_reg[1][13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(13),
      Q => \hex_r_reg[1]_3\(13),
      R => '0'
    );
\hex_r_reg[1][14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(14),
      Q => \hex_r_reg[1]_3\(14),
      R => '0'
    );
\hex_r_reg[1][15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(15),
      Q => \hex_r_reg[1]_3\(15),
      R => '0'
    );
\hex_r_reg[1][16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(16),
      Q => \hex_r_reg[1]_3\(16),
      R => '0'
    );
\hex_r_reg[1][17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(17),
      Q => \hex_r_reg[1]_3\(17),
      R => '0'
    );
\hex_r_reg[1][18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(18),
      Q => \hex_r_reg[1]_3\(18),
      R => '0'
    );
\hex_r_reg[1][19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(19),
      Q => \hex_r_reg[1]_3\(19),
      R => '0'
    );
\hex_r_reg[1][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(1),
      Q => \hex_r_reg[1]_3\(1),
      R => '0'
    );
\hex_r_reg[1][20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(20),
      Q => \hex_r_reg[1]_3\(20),
      R => '0'
    );
\hex_r_reg[1][21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(21),
      Q => \hex_r_reg[1]_3\(21),
      R => '0'
    );
\hex_r_reg[1][22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(22),
      Q => \hex_r_reg[1]_3\(22),
      R => '0'
    );
\hex_r_reg[1][23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(23),
      Q => \hex_r_reg[1]_3\(23),
      R => '0'
    );
\hex_r_reg[1][24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(24),
      Q => \hex_r_reg[1]_3\(24),
      R => '0'
    );
\hex_r_reg[1][25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(25),
      Q => \hex_r_reg[1]_3\(25),
      R => '0'
    );
\hex_r_reg[1][26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(26),
      Q => \hex_r_reg[1]_3\(26),
      R => '0'
    );
\hex_r_reg[1][27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(27),
      Q => \hex_r_reg[1]_3\(27),
      R => '0'
    );
\hex_r_reg[1][28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(28),
      Q => \hex_r_reg[1]_3\(28),
      R => '0'
    );
\hex_r_reg[1][29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(29),
      Q => \hex_r_reg[1]_3\(29),
      R => '0'
    );
\hex_r_reg[1][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(2),
      Q => \hex_r_reg[1]_3\(2),
      R => '0'
    );
\hex_r_reg[1][30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(30),
      Q => \hex_r_reg[1]_3\(30),
      R => '0'
    );
\hex_r_reg[1][31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(31),
      Q => \hex_r_reg[1]_3\(31),
      R => '0'
    );
\hex_r_reg[1][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(3),
      Q => \hex_r_reg[1]_3\(3),
      R => '0'
    );
\hex_r_reg[1][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(4),
      Q => \hex_r_reg[1]_3\(4),
      R => '0'
    );
\hex_r_reg[1][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(5),
      Q => \hex_r_reg[1]_3\(5),
      R => '0'
    );
\hex_r_reg[1][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(6),
      Q => \hex_r_reg[1]_3\(6),
      R => '0'
    );
\hex_r_reg[1][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(7),
      Q => \hex_r_reg[1]_3\(7),
      R => '0'
    );
\hex_r_reg[1][8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(8),
      Q => \hex_r_reg[1]_3\(8),
      R => '0'
    );
\hex_r_reg[1][9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => prints_hex_w(9),
      Q => \hex_r_reg[1]_3\(9),
      R => '0'
    );
\hex_r_reg[2][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][0]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(0),
      R => '0'
    );
\hex_r_reg[2][10]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][10]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(10),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][11]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][11]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(11),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][12]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][12]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(12),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][13]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][13]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(13),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][14]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][14]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(14),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][15]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][15]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(15),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][16]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][16]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(16),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][17]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][17]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(17),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][18]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][18]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(18),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][19]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][19]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(19),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][1]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(1),
      R => '0'
    );
\hex_r_reg[2][20]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][20]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(20),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][21]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][21]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(21),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][22]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][22]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(22),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][23]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][23]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(23),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][24]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][24]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(24),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][25]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][25]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(25),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][26]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][26]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(26),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][27]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][27]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(27),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][28]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][28]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(28),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][29]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][29]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(29),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][2]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(2),
      R => '0'
    );
\hex_r_reg[2][30]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][30]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(30),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][31]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][31]_i_2_n_0\,
      Q => \hex_r_reg[2]_2\(31),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[2][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][3]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(3),
      R => '0'
    );
\hex_r_reg[2][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][4]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(4),
      R => '0'
    );
\hex_r_reg[2][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][5]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(5),
      R => '0'
    );
\hex_r_reg[2][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][6]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(6),
      R => '0'
    );
\hex_r_reg[2][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][7]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(7),
      R => '0'
    );
\hex_r_reg[2][8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][8]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(8),
      R => '0'
    );
\hex_r_reg[2][9]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[2][9]_i_1_n_0\,
      Q => \hex_r_reg[2]_2\(9),
      S => \hex_r[2][31]_i_1_n_0\
    );
\hex_r_reg[3][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][0]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(0),
      R => '0'
    );
\hex_r_reg[3][10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][10]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(10),
      R => '0'
    );
\hex_r_reg[3][11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][11]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(11),
      R => '0'
    );
\hex_r_reg[3][12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][12]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(12),
      R => '0'
    );
\hex_r_reg[3][13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][13]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(13),
      R => '0'
    );
\hex_r_reg[3][14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][14]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(14),
      R => '0'
    );
\hex_r_reg[3][15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][15]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(15),
      R => '0'
    );
\hex_r_reg[3][16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][16]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(16),
      R => '0'
    );
\hex_r_reg[3][17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][17]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(17),
      R => '0'
    );
\hex_r_reg[3][18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][18]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(18),
      R => '0'
    );
\hex_r_reg[3][19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][19]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(19),
      R => '0'
    );
\hex_r_reg[3][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][1]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(1),
      R => '0'
    );
\hex_r_reg[3][20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][20]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(20),
      R => '0'
    );
\hex_r_reg[3][21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][21]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(21),
      R => '0'
    );
\hex_r_reg[3][22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][22]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(22),
      R => '0'
    );
\hex_r_reg[3][23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][23]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(23),
      R => '0'
    );
\hex_r_reg[3][24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][24]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(24),
      R => '0'
    );
\hex_r_reg[3][25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][25]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(25),
      R => '0'
    );
\hex_r_reg[3][26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][26]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(26),
      R => '0'
    );
\hex_r_reg[3][27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][27]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(27),
      R => '0'
    );
\hex_r_reg[3][28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][28]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(28),
      R => '0'
    );
\hex_r_reg[3][29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][29]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(29),
      R => '0'
    );
\hex_r_reg[3][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][2]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(2),
      R => '0'
    );
\hex_r_reg[3][30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][30]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(30),
      R => '0'
    );
\hex_r_reg[3][31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][31]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(31),
      R => '0'
    );
\hex_r_reg[3][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][3]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(3),
      R => '0'
    );
\hex_r_reg[3][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][4]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(4),
      R => '0'
    );
\hex_r_reg[3][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][5]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(5),
      R => '0'
    );
\hex_r_reg[3][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][6]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(6),
      R => '0'
    );
\hex_r_reg[3][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][7]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(7),
      R => '0'
    );
\hex_r_reg[3][8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][8]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(8),
      R => '0'
    );
\hex_r_reg[3][9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r[3][9]_i_1_n_0\,
      Q => \hex_r_reg[3]_1\(9),
      R => '0'
    );
\hex_r_reg[4][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(0),
      Q => \hex_r_reg[4]_0\(0),
      R => '0'
    );
\hex_r_reg[4][10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(10),
      Q => \hex_r_reg[4]_0\(10),
      R => '0'
    );
\hex_r_reg[4][11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(11),
      Q => \hex_r_reg[4]_0\(11),
      R => '0'
    );
\hex_r_reg[4][12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(12),
      Q => \hex_r_reg[4]_0\(12),
      R => '0'
    );
\hex_r_reg[4][13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(13),
      Q => \hex_r_reg[4]_0\(13),
      R => '0'
    );
\hex_r_reg[4][14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(14),
      Q => \hex_r_reg[4]_0\(14),
      R => '0'
    );
\hex_r_reg[4][15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(15),
      Q => \hex_r_reg[4]_0\(15),
      R => '0'
    );
\hex_r_reg[4][16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(16),
      Q => \hex_r_reg[4]_0\(16),
      R => '0'
    );
\hex_r_reg[4][17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(17),
      Q => \hex_r_reg[4]_0\(17),
      R => '0'
    );
\hex_r_reg[4][18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(18),
      Q => \hex_r_reg[4]_0\(18),
      R => '0'
    );
\hex_r_reg[4][19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(19),
      Q => \hex_r_reg[4]_0\(19),
      R => '0'
    );
\hex_r_reg[4][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(1),
      Q => \hex_r_reg[4]_0\(1),
      R => '0'
    );
\hex_r_reg[4][20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(20),
      Q => \hex_r_reg[4]_0\(20),
      R => '0'
    );
\hex_r_reg[4][21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(21),
      Q => \hex_r_reg[4]_0\(21),
      R => '0'
    );
\hex_r_reg[4][22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(22),
      Q => \hex_r_reg[4]_0\(22),
      R => '0'
    );
\hex_r_reg[4][23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(23),
      Q => \hex_r_reg[4]_0\(23),
      R => '0'
    );
\hex_r_reg[4][24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(24),
      Q => \hex_r_reg[4]_0\(24),
      R => '0'
    );
\hex_r_reg[4][25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(25),
      Q => \hex_r_reg[4]_0\(25),
      R => '0'
    );
\hex_r_reg[4][26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(26),
      Q => \hex_r_reg[4]_0\(26),
      R => '0'
    );
\hex_r_reg[4][27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(27),
      Q => \hex_r_reg[4]_0\(27),
      R => '0'
    );
\hex_r_reg[4][28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(28),
      Q => \hex_r_reg[4]_0\(28),
      R => '0'
    );
\hex_r_reg[4][29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(29),
      Q => \hex_r_reg[4]_0\(29),
      R => '0'
    );
\hex_r_reg[4][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(2),
      Q => \hex_r_reg[4]_0\(2),
      R => '0'
    );
\hex_r_reg[4][30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(30),
      Q => \hex_r_reg[4]_0\(30),
      R => '0'
    );
\hex_r_reg[4][31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(31),
      Q => \hex_r_reg[4]_0\(31),
      R => '0'
    );
\hex_r_reg[4][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(3),
      Q => \hex_r_reg[4]_0\(3),
      R => '0'
    );
\hex_r_reg[4][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(4),
      Q => \hex_r_reg[4]_0\(4),
      R => '0'
    );
\hex_r_reg[4][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(5),
      Q => \hex_r_reg[4]_0\(5),
      R => '0'
    );
\hex_r_reg[4][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(6),
      Q => \hex_r_reg[4]_0\(6),
      R => '0'
    );
\hex_r_reg[4][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(7),
      Q => \hex_r_reg[4]_0\(7),
      R => '0'
    );
\hex_r_reg[4][8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(8),
      Q => \hex_r_reg[4]_0\(8),
      R => '0'
    );
\hex_r_reg[4][9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \hex_r_reg[4][31]_0\(9),
      Q => \hex_r_reg[4]_0\(9),
      R => '0'
    );
\mem_din_o[7]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \hex_r_reg[1][12]_0\(3),
      I1 => \hex_r_reg[1][12]_0\(2),
      O => \^in7\(0)
    );
\string_r[120]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8F"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(3),
      I2 => Q(1),
      O => \string_r[120]_i_1_n_0\
    );
\string_r[121]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Q(3),
      I1 => prints_string_w(120),
      O => \string_r[121]_i_1_n_0\
    );
\string_r[129]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      O => \string_r[129]_i_1_n_0\
    );
\string_r[130]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(4),
      O => \string_r[130]_i_1_n_0\
    );
\string_r[131]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(4),
      I1 => prints_string_w(120),
      O => \string_r[131]_i_1_n_0\
    );
\string_r[134]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      O => \string_r[134]_i_1_n_0\
    );
\string_r[145]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2F"
    )
        port map (
      I0 => Q(3),
      I1 => prints_string_w(120),
      I2 => Q(1),
      O => \string_r[145]_i_1_n_0\
    );
\string_r[160]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(0),
      O => \^string_i\(0)
    );
\string_r[162]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Q(3),
      I1 => prints_string_w(120),
      O => \string_r[162]_i_1_n_0\
    );
\string_r[174]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8F"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[174]_i_1_n_0\
    );
\string_r[176]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"4F"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[176]_i_1_n_0\
    );
\string_r[178]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B380"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      I3 => Q(4),
      O => \string_r[178]_i_1_n_0\
    );
\string_r[180]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7340"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      I3 => Q(4),
      O => \string_r[180]_i_1_n_0\
    );
\string_r[189]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => Q(1),
      I1 => Q(3),
      O => \string_r[189]_i_1_n_0\
    );
\string_r[192]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B0"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[192]_i_1_n_0\
    );
\string_r[194]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      O => \string_r[194]_i_1_n_0\
    );
\string_r[197]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0D"
    )
        port map (
      I0 => Q(3),
      I1 => Q(1),
      I2 => Q(0),
      O => \string_r[197]_i_1_n_0\
    );
\string_r[200]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => Q(0),
      I1 => Q(4),
      O => \string_r[200]_i_1_n_0\
    );
\string_r[201]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[201]_i_1_n_0\
    );
\string_r[202]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BC"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[202]_i_1_n_0\
    );
\string_r[217]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => Q(1),
      I1 => Q(3),
      O => \string_r[217]_i_1_n_0\
    );
\string_r[224]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"70"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[224]_i_1_n_0\
    );
\string_r[225]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(1),
      O => \string_r[225]_i_1_n_0\
    );
\string_r[232]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Q(1),
      I1 => Q(3),
      O => \string_r[232]_i_1_n_0\
    );
\string_r[240]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => Q(4),
      I1 => Q(1),
      I2 => prints_string_w(120),
      O => \string_r[240]_i_1_n_0\
    );
\string_r[245]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BE"
    )
        port map (
      I0 => Q(0),
      I1 => Q(4),
      I2 => Q(1),
      O => \string_r[245]_i_1_n_0\
    );
\string_r[248]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"007C"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      I3 => Q(0),
      O => \string_r[248]_i_1_n_0\
    );
\string_r[251]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
        port map (
      I0 => Q(0),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[251]_i_1_n_0\
    );
\string_r[264]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Q(1),
      I1 => Q(4),
      O => \^fsm_sequential_state_r_reg[1]_1\
    );
\string_r[265]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F4"
    )
        port map (
      I0 => Q(1),
      I1 => Q(4),
      I2 => Q(0),
      O => \string_r[265]_i_1_n_0\
    );
\string_r[272]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(1),
      I1 => Q(4),
      O => \^fsm_sequential_state_r_reg[1]_0\
    );
\string_r[273]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Q(1),
      I1 => Q(3),
      O => \string_r[273]_i_1_n_0\
    );
\string_r[274]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => Q(0),
      I1 => Q(1),
      O => \string_r[274]_i_1_n_0\
    );
\string_r[281]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E2"
    )
        port map (
      I0 => Q(4),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[281]_i_1_n_0\
    );
\string_r[282]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Q(1),
      I1 => Q(4),
      O => \string_r[282]_i_1_n_0\
    );
\string_r[288]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[288]_i_1_n_0\
    );
\string_r[291]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"007F"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      I3 => Q(0),
      O => \string_r[291]_i_1_n_0\
    );
\string_r[293]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0200"
    )
        port map (
      I0 => rst_n,
      I1 => state_r(1),
      I2 => state_r(0),
      I3 => Q(0),
      O => \string_r[293]_i_1_n_0\
    );
\string_r[297]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CC80"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      I3 => Q(4),
      O => \string_r[297]_i_1_n_0\
    );
\string_r[299]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF2F"
    )
        port map (
      I0 => Q(3),
      I1 => prints_string_w(120),
      I2 => Q(1),
      I3 => Q(0),
      O => \string_r[299]_i_1_n_0\
    );
\string_r[304]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => Q(1),
      I1 => Q(3),
      O => \string_r[304]_i_1_n_0\
    );
\string_r[306]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Q(4),
      I1 => Q(1),
      O => \^string_i\(1)
    );
\string_r[312]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => Q(3),
      I1 => Q(1),
      O => \string_r[312]_i_1_n_0\
    );
\string_r[313]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(1),
      I2 => Q(3),
      O => \string_r[313]_i_1_n_0\
    );
\string_r[314]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CDFC"
    )
        port map (
      I0 => prints_string_w(120),
      I1 => Q(0),
      I2 => Q(4),
      I3 => Q(1),
      O => \string_r[314]_i_1_n_0\
    );
\string_r[316]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => rst_n,
      I1 => state_r(1),
      I2 => state_r(0),
      O => \string_r[316]_i_1_n_0\
    );
\string_r[316]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(11),
      I1 => \hex_r_reg[1][31]_0\(10),
      I2 => \hex_r_reg[1][31]_0\(9),
      I3 => \hex_r_reg[1][31]_0\(8),
      O => \string_r[316]_i_10_n_0\
    );
\string_r[316]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF8F"
    )
        port map (
      I0 => Q(3),
      I1 => prints_string_w(120),
      I2 => Q(1),
      I3 => Q(0),
      O => \string_r[316]_i_2_n_0\
    );
\string_r[316]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
        port map (
      I0 => \string_r[316]_i_4_n_0\,
      I1 => \string_r[316]_i_5_n_0\,
      I2 => \hex_r_reg[1][31]_0\(17),
      I3 => \hex_r_reg[1][31]_0\(26),
      I4 => \hex_r_reg[1][31]_0\(29),
      I5 => \string_r[316]_i_6_n_0\,
      O => prints_string_w(120)
    );
\string_r[316]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
        port map (
      I0 => \string_r[316]_i_7_n_0\,
      I1 => \hex_r_reg[1][31]_0\(1),
      I2 => \hex_r_reg[1][31]_0\(0),
      I3 => \hex_r_reg[1][31]_0\(3),
      I4 => \hex_r_reg[1][31]_0\(2),
      I5 => \string_r[316]_i_8_n_0\,
      O => \string_r[316]_i_4_n_0\
    );
\string_r[316]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(23),
      I1 => \hex_r_reg[1][31]_0\(20),
      I2 => \hex_r_reg[1][31]_0\(25),
      I3 => \hex_r_reg[1][31]_0\(22),
      O => \string_r[316]_i_5_n_0\
    );
\string_r[316]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(18),
      I1 => \hex_r_reg[1][31]_0\(21),
      I2 => \hex_r_reg[1][31]_0\(16),
      I3 => \hex_r_reg[1][31]_0\(19),
      I4 => \string_r[316]_i_9_n_0\,
      O => \string_r[316]_i_6_n_0\
    );
\string_r[316]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(7),
      I1 => \hex_r_reg[1][31]_0\(6),
      I2 => \hex_r_reg[1][31]_0\(5),
      I3 => \hex_r_reg[1][31]_0\(4),
      O => \string_r[316]_i_7_n_0\
    );
\string_r[316]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(12),
      I1 => \hex_r_reg[1][31]_0\(13),
      I2 => \hex_r_reg[1][31]_0\(14),
      I3 => \hex_r_reg[1][31]_0\(15),
      I4 => \string_r[316]_i_10_n_0\,
      O => \string_r[316]_i_8_n_0\
    );
\string_r[316]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \hex_r_reg[1][31]_0\(27),
      I1 => \hex_r_reg[1][31]_0\(24),
      I2 => \hex_r_reg[1][31]_0\(30),
      I3 => \hex_r_reg[1][31]_0\(31),
      I4 => \hex_r_reg[1][31]_0\(28),
      O => \string_r[316]_i_9_n_0\
    );
\string_r[40]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(3),
      O => \string_r[40]_i_1_n_0\
    );
\string_r[88]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q(3),
      I1 => Q(4),
      O => \string_r[88]_i_1_n_0\
    );
\string_r_reg[104]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => Q(1),
      Q => data13(0),
      R => '0'
    );
\string_r_reg[120]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[120]_i_1_n_0\,
      Q => data15(0),
      R => '0'
    );
\string_r_reg[121]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[121]_i_1_n_0\,
      Q => data15(1),
      R => '0'
    );
\string_r_reg[129]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[129]_i_1_n_0\,
      Q => data16(1),
      S => \string_r[293]_i_1_n_0\
    );
\string_r_reg[130]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[130]_i_1_n_0\,
      Q => data16(2),
      S => \string_r[293]_i_1_n_0\
    );
\string_r_reg[131]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[131]_i_1_n_0\,
      Q => data16(3),
      S => \string_r[293]_i_1_n_0\
    );
\string_r_reg[134]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[134]_i_1_n_0\,
      Q => data16(6),
      S => \string_r[293]_i_1_n_0\
    );
\string_r_reg[145]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[145]_i_1_n_0\,
      Q => data18(1),
      R => '0'
    );
\string_r_reg[160]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \^string_i\(0),
      Q => data20(0),
      R => '0'
    );
\string_r_reg[162]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[162]_i_1_n_0\,
      Q => data20(2),
      R => '0'
    );
\string_r_reg[174]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[174]_i_1_n_0\,
      Q => data21(6),
      R => '0'
    );
\string_r_reg[176]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[176]_i_1_n_0\,
      Q => data22(0),
      R => '0'
    );
\string_r_reg[178]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[178]_i_1_n_0\,
      Q => data22(2),
      R => '0'
    );
\string_r_reg[180]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[180]_i_1_n_0\,
      Q => data22(4),
      R => '0'
    );
\string_r_reg[189]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[189]_i_1_n_0\,
      Q => data23(5),
      R => '0'
    );
\string_r_reg[192]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[192]_i_1_n_0\,
      Q => data24(0),
      R => '0'
    );
\string_r_reg[194]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[194]_i_1_n_0\,
      Q => data24(2),
      S => \string_r[293]_i_1_n_0\
    );
\string_r_reg[197]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[197]_i_1_n_0\,
      Q => data24(5),
      R => '0'
    );
\string_r_reg[200]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[200]_i_1_n_0\,
      Q => data25(0),
      R => '0'
    );
\string_r_reg[201]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[201]_i_1_n_0\,
      Q => data25(1),
      R => '0'
    );
\string_r_reg[202]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[202]_i_1_n_0\,
      Q => data25(2),
      R => '0'
    );
\string_r_reg[217]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[217]_i_1_n_0\,
      Q => data27(1),
      R => '0'
    );
\string_r_reg[224]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[224]_i_1_n_0\,
      Q => data28(0),
      R => '0'
    );
\string_r_reg[225]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[225]_i_1_n_0\,
      Q => data28(1),
      R => '0'
    );
\string_r_reg[232]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[232]_i_1_n_0\,
      Q => data29(0),
      R => '0'
    );
\string_r_reg[240]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[240]_i_1_n_0\,
      Q => data30(0),
      S => \string_r[293]_i_1_n_0\
    );
\string_r_reg[245]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[245]_i_1_n_0\,
      Q => data30(5),
      R => '0'
    );
\string_r_reg[248]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[248]_i_1_n_0\,
      Q => data31(0),
      R => '0'
    );
\string_r_reg[251]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[251]_i_1_n_0\,
      Q => data31(3),
      R => '0'
    );
\string_r_reg[264]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \^fsm_sequential_state_r_reg[1]_1\,
      Q => data33(0),
      R => '0'
    );
\string_r_reg[265]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[265]_i_1_n_0\,
      Q => data33(1),
      R => '0'
    );
\string_r_reg[272]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \^fsm_sequential_state_r_reg[1]_0\,
      Q => data34(0),
      R => '0'
    );
\string_r_reg[273]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[273]_i_1_n_0\,
      Q => data34(1),
      R => '0'
    );
\string_r_reg[274]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[274]_i_1_n_0\,
      Q => data34(2),
      R => '0'
    );
\string_r_reg[281]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[281]_i_1_n_0\,
      Q => data35(1),
      R => '0'
    );
\string_r_reg[282]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[282]_i_1_n_0\,
      Q => data35(2),
      R => '0'
    );
\string_r_reg[288]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[288]_i_1_n_0\,
      Q => data36(0),
      R => '0'
    );
\string_r_reg[291]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[291]_i_1_n_0\,
      Q => data36(3),
      R => '0'
    );
\string_r_reg[292]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[192]_i_1_n_0\,
      Q => data36(4),
      S => \string_r[293]_i_1_n_0\
    );
\string_r_reg[293]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \^fsm_sequential_state_r_reg[1]_0\,
      Q => data36(5),
      S => \string_r[293]_i_1_n_0\
    );
\string_r_reg[297]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[297]_i_1_n_0\,
      Q => data37(1),
      R => '0'
    );
\string_r_reg[299]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[299]_i_1_n_0\,
      Q => data37(3),
      R => '0'
    );
\string_r_reg[304]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[304]_i_1_n_0\,
      Q => data38(0),
      R => '0'
    );
\string_r_reg[306]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \^string_i\(1),
      Q => data38(2),
      R => '0'
    );
\string_r_reg[312]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[312]_i_1_n_0\,
      Q => data39(0),
      R => '0'
    );
\string_r_reg[313]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[313]_i_1_n_0\,
      Q => data39(1),
      R => '0'
    );
\string_r_reg[314]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[314]_i_1_n_0\,
      Q => data39(2),
      R => '0'
    );
\string_r_reg[316]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[316]_i_2_n_0\,
      Q => data39(4),
      R => '0'
    );
\string_r_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[40]_i_1_n_0\,
      Q => data5(0),
      R => '0'
    );
\string_r_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => Q(4),
      Q => data9(0),
      R => '0'
    );
\string_r_reg[80]\: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => Q(4),
      Q => data10(0),
      S => \string_r[293]_i_1_n_0\
    );
\string_r_reg[88]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => \string_r[88]_i_1_n_0\,
      Q => data11(0),
      R => '0'
    );
\string_r_reg[96]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[316]_i_1_n_0\,
      D => Q(3),
      Q => data12(0),
      R => '0'
    );
u_printc: entity work.total_design_host_top_wrapper_0_0_printc
     port map (
      E(0) => u_printc_n_13,
      \FSM_sequential_state_r_reg[0]\ => u_printc_n_5,
      \FSM_sequential_state_r_reg[0]_0\ => u_printc_n_12,
      \FSM_sequential_state_r_reg[0]_1\ => \FSM_sequential_state_r[0]_i_2_n_0\,
      \FSM_sequential_state_r_reg[0]_2\ => \FSM_sequential_state_r[1]_i_5_n_0\,
      \FSM_sequential_state_r_reg[1]\ => u_printc_n_6,
      \FSM_sequential_state_r_reg[1]_0\ => u_printc_n_7,
      \FSM_sequential_state_r_reg[1]_1\ => u_printc_n_10,
      \FSM_sequential_state_r_reg[1]_2\ => \FSM_sequential_state_r[1]_i_2_n_0\,
      Q(6) => \char_r_reg_n_0_[6]\,
      Q(5) => \char_r_reg_n_0_[5]\,
      Q(4) => \char_r_reg_n_0_[4]\,
      Q(3) => \char_r_reg_n_0_[3]\,
      Q(2) => \char_r_reg_n_0_[2]\,
      Q(1) => \char_r_reg_n_0_[1]\,
      Q(0) => \char_r_reg_n_0_[0]\,
      SS(0) => \^sr\(0),
      char_idx_r(1 downto 0) => char_idx_r(4 downto 3),
      \char_idx_r_reg[0]\ => \char_idx_r[5]_i_5_n_0\,
      \char_idx_r_reg[3]\ => \char_idx_r_reg_n_0_[3]\,
      \char_idx_r_reg[4]\ => \char_idx_r_reg_n_0_[4]\,
      clk => clk,
      \hex_digit_idx_r_reg[0]\ => u_printc_n_11,
      \hex_digit_idx_r_reg[1]\ => \hex_digit_idx_r_reg_n_0_[0]\,
      \hex_digit_idx_r_reg[1]_0\ => \hex_digit_idx_r[1]_i_2_n_0\,
      \hex_digit_idx_r_reg[1]_1\ => \hex_digit_idx_r_reg_n_0_[1]\,
      \hex_digit_idx_r_reg[2]\ => \hex_digit_idx_r[2]_i_2_n_0\,
      \hex_digit_idx_r_reg[2]_0\ => \hex_digit_idx_r[2]_i_3_n_0\,
      \hex_digit_idx_r_reg[2]_1\ => \hex_digit_idx_r_reg_n_0_[2]\,
      m_axi_arready => m_axi_arready,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      m_axi_bready => m_axi_bready,
      m_axi_bvalid => m_axi_bvalid,
      m_axi_rdata(0) => m_axi_rdata(0),
      m_axi_rready => m_axi_rready,
      m_axi_rvalid => m_axi_rvalid,
      m_axi_wdata(6 downto 0) => m_axi_wdata(6 downto 0),
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid,
      rst_n => rst_n,
      rst_n_0 => u_printc_n_8,
      rst_n_1 => u_printc_n_9,
      rst_n_2 => u_printc_n_14,
      state_r(1 downto 0) => state_r(1 downto 0)
    );
\wait_counter_r[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \wait_counter_r_reg[0]_1\,
      I1 => wait_counter_r(0),
      I2 => wait_counter_next_w(0),
      O => \wait_counter_r_reg[0]\
    );
\wait_counter_r[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F80"
    )
        port map (
      I0 => \wait_counter_r_reg[0]_1\,
      I1 => wait_counter_next_w(0),
      I2 => wait_counter_r(0),
      I3 => wait_counter_fin_w,
      O => \wait_counter_r_reg[0]_0\
    );
\wait_counter_r[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8000"
    )
        port map (
      I0 => Q(0),
      I1 => Q(3),
      I2 => prints_ready_w,
      I3 => \addr_r_reg[0]\,
      I4 => \wait_counter_r[1]_i_4_n_0\,
      I5 => \wait_counter_r_reg[1]\,
      O => wait_counter_r(0)
    );
\wait_counter_r[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000008000000000"
    )
        port map (
      I0 => \addr_r_reg[0]_0\,
      I1 => Q(4),
      I2 => prints_ready_w,
      I3 => Q(1),
      I4 => Q(3),
      I5 => \wait_counter_r[1]_i_3_0\,
      O => \wait_counter_r[1]_i_4_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity total_design_host_top_wrapper_0_0_host_top_new is
  port (
    Q : out STD_LOGIC_VECTOR ( 12 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 6 downto 0 );
    m_axi_bready : out STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    \FSM_sequential_state_r_reg[3]_0\ : out STD_LOGIC;
    ready_o : out STD_LOGIC;
    mem_din_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    simt_start_o : out STD_LOGIC;
    rst_n : in STD_LOGIC;
    mem_dout_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clk : in STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    start_i : in STD_LOGIC;
    simt_ready_i : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of total_design_host_top_wrapper_0_0_host_top_new : entity is "host_top_new";
end total_design_host_top_wrapper_0_0_host_top_new;

architecture STRUCTURE of total_design_host_top_wrapper_0_0_host_top_new is
  signal \FSM_sequential_state_r[2]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[2]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[2]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[3]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[3]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[3]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[4]_i_10_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[4]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[4]_i_8_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[4]_i_9_n_0\ : STD_LOGIC;
  signal \^fsm_sequential_state_r_reg[3]_0\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal addr_r : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \addr_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[10]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[11]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_10_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_11_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_12_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_13_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_14_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_15_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_16_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_3_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_4_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_6_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_7_n_0\ : STD_LOGIC;
  signal \addr_r[12]_i_8_n_0\ : STD_LOGIC;
  signal \addr_r[1]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[2]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[3]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[4]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[5]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[6]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[7]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[8]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[9]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r_reg[12]_i_9_n_1\ : STD_LOGIC;
  signal \addr_r_reg[12]_i_9_n_2\ : STD_LOGIC;
  signal \addr_r_reg[12]_i_9_n_3\ : STD_LOGIC;
  signal \addr_r_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \addr_r_reg[4]_i_2_n_1\ : STD_LOGIC;
  signal \addr_r_reg[4]_i_2_n_2\ : STD_LOGIC;
  signal \addr_r_reg[4]_i_2_n_3\ : STD_LOGIC;
  signal \addr_r_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \addr_r_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \addr_r_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \addr_r_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \cycle_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \cycle_r[0]_i_4_n_0\ : STD_LOGIC;
  signal cycle_r_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \cycle_r_reg[0]_i_3_n_0\ : STD_LOGIC;
  signal \cycle_r_reg[0]_i_3_n_1\ : STD_LOGIC;
  signal \cycle_r_reg[0]_i_3_n_2\ : STD_LOGIC;
  signal \cycle_r_reg[0]_i_3_n_3\ : STD_LOGIC;
  signal \cycle_r_reg[0]_i_3_n_4\ : STD_LOGIC;
  signal \cycle_r_reg[0]_i_3_n_5\ : STD_LOGIC;
  signal \cycle_r_reg[0]_i_3_n_6\ : STD_LOGIC;
  signal \cycle_r_reg[0]_i_3_n_7\ : STD_LOGIC;
  signal \cycle_r_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \cycle_r_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \cycle_r_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \cycle_r_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \cycle_r_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \cycle_r_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \cycle_r_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \cycle_r_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \cycle_r_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \cycle_r_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \cycle_r_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \cycle_r_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \cycle_r_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \cycle_r_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \cycle_r_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \cycle_r_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \cycle_r_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \cycle_r_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \cycle_r_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \cycle_r_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \cycle_r_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \cycle_r_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \cycle_r_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \cycle_r_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \cycle_r_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \cycle_r_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \cycle_r_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \cycle_r_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \cycle_r_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \cycle_r_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \cycle_r_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \cycle_r_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \cycle_r_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \cycle_r_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \cycle_r_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \cycle_r_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \cycle_r_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \cycle_r_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \cycle_r_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \cycle_r_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \cycle_r_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \cycle_r_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \cycle_r_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \cycle_r_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \cycle_r_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \cycle_r_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \cycle_r_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \cycle_r_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \cycle_r_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \cycle_r_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \cycle_r_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \cycle_r_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \cycle_r_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \cycle_r_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \cycle_r_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal err_count_r : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \err_count_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[10]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[11]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[12]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[13]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[14]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[15]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[16]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[17]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[18]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[19]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[1]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[20]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[21]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[22]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[23]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[24]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[25]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[26]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[27]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[28]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[29]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[2]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[30]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_11_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_12_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_13_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_14_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_15_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_16_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_17_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_18_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_2_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_4_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_7_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_8_n_0\ : STD_LOGIC;
  signal \err_count_r[31]_i_9_n_0\ : STD_LOGIC;
  signal \err_count_r[3]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[4]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[5]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[6]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[7]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[8]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r[9]_i_1_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[12]_i_2_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[12]_i_2_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[12]_i_2_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[16]_i_2_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[16]_i_2_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[16]_i_2_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[16]_i_2_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[20]_i_2_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[20]_i_2_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[20]_i_2_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[20]_i_2_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[24]_i_2_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[24]_i_2_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[24]_i_2_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[24]_i_2_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[28]_i_2_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[28]_i_2_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[28]_i_2_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[28]_i_2_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_10_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_10_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_10_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_10_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_3_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_3_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_3_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_5_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_5_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_6_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_6_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_6_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[31]_i_6_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[4]_i_2_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[4]_i_2_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[4]_i_2_n_3\ : STD_LOGIC;
  signal \err_count_r_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \err_count_r_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \err_count_r_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \err_count_r_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[0]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[10]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[11]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[12]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[13]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[14]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[15]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[16]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[17]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[18]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[19]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[1]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[20]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[21]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[22]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[23]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[24]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[25]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[26]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[27]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[28]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[29]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[2]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[30]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[31]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[3]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[4]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[5]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[6]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[7]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[8]\ : STD_LOGIC;
  signal \err_count_r_reg_n_0_[9]\ : STD_LOGIC;
  signal in20 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal in23 : STD_LOGIC_VECTOR ( 12 downto 1 );
  signal in7 : STD_LOGIC_VECTOR ( 31 to 31 );
  signal \mem_actual_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \mem_actual_r__0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal sel : STD_LOGIC;
  signal state_r : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \state_r__0\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal u_prints_n_0 : STD_LOGIC;
  signal u_prints_n_1 : STD_LOGIC;
  signal u_prints_n_10 : STD_LOGIC;
  signal u_prints_n_11 : STD_LOGIC;
  signal u_prints_n_13 : STD_LOGIC;
  signal u_prints_n_2 : STD_LOGIC;
  signal u_prints_n_4 : STD_LOGIC;
  signal u_prints_n_5 : STD_LOGIC;
  signal u_prints_n_6 : STD_LOGIC;
  signal u_prints_n_7 : STD_LOGIC;
  signal u_prints_n_9 : STD_LOGIC;
  signal wait_counter_fin_w : STD_LOGIC;
  signal wait_counter_next_w : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \wait_counter_r[1]_i_2_n_0\ : STD_LOGIC;
  signal \wait_counter_r[1]_i_5_n_0\ : STD_LOGIC;
  signal \wtinstret_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \wtinstret_r__0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \wtinstreth_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \wtinstreth_r__0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \wuinstret_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \wuinstret_r__0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \wuinstreth_r[31]_i_1_n_0\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[0]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[10]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[11]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[12]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[13]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[14]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[15]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[16]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[17]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[18]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[19]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[1]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[20]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[21]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[22]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[23]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[24]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[25]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[26]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[27]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[28]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[29]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[2]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[30]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[31]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[3]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[4]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[5]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[6]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[7]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[8]\ : STD_LOGIC;
  signal \wuinstreth_r_reg_n_0_[9]\ : STD_LOGIC;
  signal \NLW_addr_r_reg[12]_i_9_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_cycle_r_reg[28]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_err_count_r_reg[31]_i_10_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_err_count_r_reg[31]_i_3_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_err_count_r_reg[31]_i_3_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_err_count_r_reg[31]_i_5_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_err_count_r_reg[31]_i_5_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_err_count_r_reg[31]_i_6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[1]_i_1__0\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[2]_i_3\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[3]_i_2\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[4]_i_10\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[4]_i_9\ : label is "soft_lutpair99";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[0]\ : label is "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[1]\ : label is "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[2]\ : label is "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[3]\ : label is "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[4]\ : label is "S_LOAD_WUINSTRET:01110,S_LOAD_WTINSTRETH:01101,S_LOAD_WTINSTRET:01100,S_WAIT_MSG_CYCLE:10011,S_INIT_MSG_CYCLE:10010,S_INIT_MSG_WAITING:00011,S_WAIT_MSG_HPM:10001,S_INIT_SIMT:00010,S_INIT_MSG_HPM:10000,S_MEM_WRITE:00001,S_WAIT_MSG_RESULT:01011,S_IDLE:00000,S_INIT_MSG_RESULT:01010,S_CHECK_COMPARE:00111,S_CHECK_READ:00110,S_CHECK_PRINT_WAIT:01001,S_CHECK_PRINT_INIT:01000,S_WAIT_SIMT:00101,S_LOAD_WUINSTRETH:01111,S_WAIT_MSG_WAITING:00100";
  attribute SOFT_HLUTNM of \addr_r[12]_i_12\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \addr_r[12]_i_13\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \addr_r[12]_i_14\ : label is "soft_lutpair100";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \addr_r_reg[12]_i_9\ : label is 35;
  attribute ADDER_THRESHOLD of \addr_r_reg[4]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \addr_r_reg[8]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \cycle_r_reg[0]_i_3\ : label is 35;
  attribute ADDER_THRESHOLD of \cycle_r_reg[12]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \cycle_r_reg[16]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \cycle_r_reg[20]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \cycle_r_reg[24]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \cycle_r_reg[28]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \cycle_r_reg[4]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \cycle_r_reg[8]_i_1\ : label is 35;
  attribute SOFT_HLUTNM of \err_count_r[10]_i_1\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \err_count_r[11]_i_1\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \err_count_r[12]_i_1\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \err_count_r[13]_i_1\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \err_count_r[14]_i_1\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \err_count_r[15]_i_1\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \err_count_r[16]_i_1\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \err_count_r[17]_i_1\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \err_count_r[18]_i_1\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \err_count_r[19]_i_1\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \err_count_r[1]_i_1\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of \err_count_r[20]_i_1\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \err_count_r[21]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \err_count_r[22]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \err_count_r[23]_i_1\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \err_count_r[24]_i_1\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \err_count_r[25]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \err_count_r[26]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \err_count_r[27]_i_1\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \err_count_r[28]_i_1\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \err_count_r[29]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \err_count_r[2]_i_1\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of \err_count_r[30]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \err_count_r[31]_i_2\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \err_count_r[31]_i_4\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \err_count_r[3]_i_1\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \err_count_r[4]_i_1\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \err_count_r[5]_i_1\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \err_count_r[6]_i_1\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \err_count_r[7]_i_1\ : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \err_count_r[8]_i_1\ : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \err_count_r[9]_i_1\ : label is "soft_lutpair112";
  attribute ADDER_THRESHOLD of \err_count_r_reg[12]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \err_count_r_reg[16]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \err_count_r_reg[20]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \err_count_r_reg[24]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \err_count_r_reg[28]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \err_count_r_reg[31]_i_5\ : label is 35;
  attribute ADDER_THRESHOLD of \err_count_r_reg[4]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \err_count_r_reg[8]_i_2\ : label is 35;
  attribute SOFT_HLUTNM of \mem_din_o[1]_INST_0\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \mem_din_o[2]_INST_0\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \mem_din_o[3]_INST_0\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \mem_din_o[4]_INST_0\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \mem_din_o[5]_INST_0\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \mem_din_o[6]_INST_0\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of mem_we_o_INST_0 : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of ready_o_INST_0 : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of simt_start_o_INST_0 : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \wait_counter_r[1]_i_2\ : label is "soft_lutpair94";
begin
  \FSM_sequential_state_r_reg[3]_0\ <= \^fsm_sequential_state_r_reg[3]_0\;
  Q(12 downto 0) <= \^q\(12 downto 0);
\FSM_sequential_state_r[1]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0F70"
    )
        port map (
      I0 => state_r(4),
      I1 => \FSM_sequential_state_r[4]_i_5_n_0\,
      I2 => state_r(0),
      I3 => state_r(1),
      O => \state_r__0\(1)
    );
\FSM_sequential_state_r[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAFFAEEAAFAFA"
    )
        port map (
      I0 => \FSM_sequential_state_r[2]_i_2_n_0\,
      I1 => \FSM_sequential_state_r[4]_i_5_n_0\,
      I2 => state_r(2),
      I3 => state_r(0),
      I4 => state_r(4),
      I5 => state_r(1),
      O => \state_r__0\(2)
    );
\FSM_sequential_state_r[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0808080808080008"
    )
        port map (
      I0 => \addr_r[12]_i_4_n_0\,
      I1 => state_r(3),
      I2 => state_r(4),
      I3 => \FSM_sequential_state_r[2]_i_3_n_0\,
      I4 => \FSM_sequential_state_r[4]_i_10_n_0\,
      I5 => \FSM_sequential_state_r[2]_i_4_n_0\,
      O => \FSM_sequential_state_r[2]_i_2_n_0\
    );
\FSM_sequential_state_r[2]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \^q\(6),
      I1 => \^q\(3),
      I2 => \^q\(2),
      I3 => \^q\(0),
      O => \FSM_sequential_state_r[2]_i_3_n_0\
    );
\FSM_sequential_state_r[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF7FFFFFFF"
    )
        port map (
      I0 => \^q\(7),
      I1 => \^q\(1),
      I2 => \^q\(4),
      I3 => \^q\(8),
      I4 => \^q\(5),
      I5 => \^q\(10),
      O => \FSM_sequential_state_r[2]_i_4_n_0\
    );
\FSM_sequential_state_r[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF8888888"
    )
        port map (
      I0 => \FSM_sequential_state_r[3]_i_2_n_0\,
      I1 => state_r(3),
      I2 => state_r(0),
      I3 => u_prints_n_11,
      I4 => \FSM_sequential_state_r[4]_i_5_n_0\,
      I5 => \FSM_sequential_state_r[3]_i_3_n_0\,
      O => \state_r__0\(3)
    );
\FSM_sequential_state_r[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0070"
    )
        port map (
      I0 => state_r(1),
      I1 => state_r(0),
      I2 => state_r(2),
      I3 => state_r(4),
      O => \FSM_sequential_state_r[3]_i_2_n_0\
    );
\FSM_sequential_state_r[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000EF00C00000"
    )
        port map (
      I0 => \FSM_sequential_state_r[3]_i_4_n_0\,
      I1 => state_r(1),
      I2 => state_r(0),
      I3 => state_r(4),
      I4 => state_r(2),
      I5 => state_r(3),
      O => \FSM_sequential_state_r[3]_i_3_n_0\
    );
\FSM_sequential_state_r[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040000000"
    )
        port map (
      I0 => \FSM_sequential_state_r[4]_i_10_n_0\,
      I1 => \^q\(6),
      I2 => \^q\(3),
      I3 => \^q\(2),
      I4 => \^q\(0),
      I5 => \FSM_sequential_state_r[2]_i_4_n_0\,
      O => \FSM_sequential_state_r[3]_i_4_n_0\
    );
\FSM_sequential_state_r[4]_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \^q\(11),
      I1 => \^q\(12),
      I2 => \^q\(9),
      O => \FSM_sequential_state_r[4]_i_10_n_0\
    );
\FSM_sequential_state_r[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3333808033FF0000"
    )
        port map (
      I0 => state_r(3),
      I1 => state_r(0),
      I2 => state_r(2),
      I3 => \FSM_sequential_state_r[4]_i_5_n_0\,
      I4 => state_r(4),
      I5 => state_r(1),
      O => \state_r__0\(4)
    );
\FSM_sequential_state_r[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFEF"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(7),
      I2 => \^q\(10),
      I3 => \FSM_sequential_state_r[4]_i_8_n_0\,
      I4 => \FSM_sequential_state_r[4]_i_9_n_0\,
      I5 => \FSM_sequential_state_r[4]_i_10_n_0\,
      O => \FSM_sequential_state_r[4]_i_5_n_0\
    );
\FSM_sequential_state_r[4]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^q\(4),
      I1 => \^q\(5),
      I2 => \^q\(6),
      I3 => \^q\(8),
      O => \FSM_sequential_state_r[4]_i_8_n_0\
    );
\FSM_sequential_state_r[4]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \FSM_sequential_state_r[4]_i_9_n_0\
    );
\FSM_sequential_state_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_prints_n_4,
      D => \state_r__0\(0),
      Q => state_r(0),
      R => u_prints_n_13
    );
\FSM_sequential_state_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_prints_n_4,
      D => \state_r__0\(1),
      Q => state_r(1),
      R => u_prints_n_13
    );
\FSM_sequential_state_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_prints_n_4,
      D => \state_r__0\(2),
      Q => state_r(2),
      R => u_prints_n_13
    );
\FSM_sequential_state_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_prints_n_4,
      D => \state_r__0\(3),
      Q => state_r(3),
      R => u_prints_n_13
    );
\FSM_sequential_state_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_prints_n_4,
      D => \state_r__0\(4),
      Q => state_r(4),
      R => u_prints_n_13
    );
\addr_r[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000044440500"
    )
        port map (
      I0 => state_r(4),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(0),
      I4 => state_r(2),
      I5 => \^q\(0),
      O => \addr_r[0]_i_1_n_0\
    );
\addr_r[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444050000000000"
    )
        port map (
      I0 => state_r(4),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(0),
      I4 => state_r(2),
      I5 => in23(10),
      O => \addr_r[10]_i_1_n_0\
    );
\addr_r[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444050000000000"
    )
        port map (
      I0 => state_r(4),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(0),
      I4 => state_r(2),
      I5 => in23(11),
      O => \addr_r[11]_i_1_n_0\
    );
\addr_r[12]_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \addr_r[12]_i_15_n_0\,
      I1 => \addr_r[12]_i_16_n_0\,
      I2 => \FSM_sequential_state_r[2]_i_4_n_0\,
      O => \addr_r[12]_i_10_n_0\
    );
\addr_r[12]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000080"
    )
        port map (
      I0 => simt_ready_i,
      I1 => state_r(2),
      I2 => state_r(0),
      I3 => state_r(3),
      I4 => state_r(1),
      I5 => state_r(4),
      O => \addr_r[12]_i_11_n_0\
    );
\addr_r[12]_i_12\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => state_r(3),
      I1 => state_r(1),
      O => \addr_r[12]_i_12_n_0\
    );
\addr_r[12]_i_13\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => state_r(2),
      I1 => state_r(4),
      O => \addr_r[12]_i_13_n_0\
    );
\addr_r[12]_i_14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F4"
    )
        port map (
      I0 => \^q\(10),
      I1 => \^q\(9),
      I2 => \^q\(11),
      O => \addr_r[12]_i_14_n_0\
    );
\addr_r[12]_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2A2AFF2AFF2AFF2A"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(0),
      I2 => \^q\(1),
      I3 => \^q\(5),
      I4 => \^q\(3),
      I5 => \^q\(4),
      O => \addr_r[12]_i_15_n_0\
    );
\addr_r[12]_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF7F55"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(7),
      I2 => \^q\(6),
      I3 => \^q\(8),
      I4 => \^q\(11),
      I5 => \^q\(12),
      O => \addr_r[12]_i_16_n_0\
    );
\addr_r[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444050000000000"
    )
        port map (
      I0 => state_r(4),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(0),
      I4 => state_r(2),
      I5 => in23(12),
      O => \addr_r[12]_i_3_n_0\
    );
\addr_r[12]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => state_r(0),
      I1 => state_r(2),
      O => \addr_r[12]_i_4_n_0\
    );
\addr_r[12]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFF0000EEFE"
    )
        port map (
      I0 => \addr_r[12]_i_10_n_0\,
      I1 => \^q\(11),
      I2 => \^q\(9),
      I3 => \^q\(10),
      I4 => state_r(4),
      I5 => state_r(1),
      O => \addr_r[12]_i_6_n_0\
    );
\addr_r[12]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAAEAA"
    )
        port map (
      I0 => \addr_r[12]_i_11_n_0\,
      I1 => \addr_r[12]_i_12_n_0\,
      I2 => state_r(4),
      I3 => start_i,
      I4 => state_r(0),
      I5 => state_r(2),
      O => \addr_r[12]_i_7_n_0\
    );
\addr_r[12]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF80FFFF80808080"
    )
        port map (
      I0 => \addr_r[12]_i_13_n_0\,
      I1 => state_r(3),
      I2 => wait_counter_fin_w,
      I3 => \addr_r[12]_i_10_n_0\,
      I4 => \addr_r[12]_i_14_n_0\,
      I5 => \^fsm_sequential_state_r_reg[3]_0\,
      O => \addr_r[12]_i_8_n_0\
    );
\addr_r[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444050000000000"
    )
        port map (
      I0 => state_r(4),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(0),
      I4 => state_r(2),
      I5 => in23(1),
      O => \addr_r[1]_i_1_n_0\
    );
\addr_r[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444050000000000"
    )
        port map (
      I0 => state_r(4),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(0),
      I4 => state_r(2),
      I5 => in23(2),
      O => \addr_r[2]_i_1_n_0\
    );
\addr_r[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444050000000000"
    )
        port map (
      I0 => state_r(4),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(0),
      I4 => state_r(2),
      I5 => in23(3),
      O => \addr_r[3]_i_1_n_0\
    );
\addr_r[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3333333011301130"
    )
        port map (
      I0 => state_r(3),
      I1 => state_r(4),
      I2 => state_r(1),
      I3 => state_r(2),
      I4 => state_r(0),
      I5 => in23(4),
      O => \addr_r[4]_i_1_n_0\
    );
\addr_r[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0088008822FA0088"
    )
        port map (
      I0 => in23(5),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(4),
      I4 => state_r(0),
      I5 => state_r(2),
      O => \addr_r[5]_i_1_n_0\
    );
\addr_r[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0088008822FA0088"
    )
        port map (
      I0 => in23(6),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(4),
      I4 => state_r(0),
      I5 => state_r(2),
      O => \addr_r[6]_i_1_n_0\
    );
\addr_r[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0088008822FA0088"
    )
        port map (
      I0 => in23(7),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(4),
      I4 => state_r(0),
      I5 => state_r(2),
      O => \addr_r[7]_i_1_n_0\
    );
\addr_r[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0088008822FA0088"
    )
        port map (
      I0 => in23(8),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(4),
      I4 => state_r(0),
      I5 => state_r(2),
      O => \addr_r[8]_i_1_n_0\
    );
\addr_r[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0088008822FA0088"
    )
        port map (
      I0 => in23(9),
      I1 => state_r(3),
      I2 => state_r(1),
      I3 => state_r(4),
      I4 => state_r(0),
      I5 => state_r(2),
      O => \addr_r[9]_i_1_n_0\
    );
\addr_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[0]_i_1_n_0\,
      Q => \^q\(0),
      R => u_prints_n_13
    );
\addr_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[10]_i_1_n_0\,
      Q => \^q\(10),
      R => u_prints_n_13
    );
\addr_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[11]_i_1_n_0\,
      Q => \^q\(11),
      R => u_prints_n_13
    );
\addr_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[12]_i_3_n_0\,
      Q => \^q\(12),
      R => u_prints_n_13
    );
\addr_r_reg[12]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_r_reg[8]_i_2_n_0\,
      CO(3) => \NLW_addr_r_reg[12]_i_9_CO_UNCONNECTED\(3),
      CO(2) => \addr_r_reg[12]_i_9_n_1\,
      CO(1) => \addr_r_reg[12]_i_9_n_2\,
      CO(0) => \addr_r_reg[12]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in23(12 downto 9),
      S(3 downto 0) => \^q\(12 downto 9)
    );
\addr_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[1]_i_1_n_0\,
      Q => \^q\(1),
      R => u_prints_n_13
    );
\addr_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[2]_i_1_n_0\,
      Q => \^q\(2),
      R => u_prints_n_13
    );
\addr_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[3]_i_1_n_0\,
      Q => \^q\(3),
      R => u_prints_n_13
    );
\addr_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[4]_i_1_n_0\,
      Q => \^q\(4),
      R => u_prints_n_13
    );
\addr_r_reg[4]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \addr_r_reg[4]_i_2_n_0\,
      CO(2) => \addr_r_reg[4]_i_2_n_1\,
      CO(1) => \addr_r_reg[4]_i_2_n_2\,
      CO(0) => \addr_r_reg[4]_i_2_n_3\,
      CYINIT => \^q\(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in23(4 downto 1),
      S(3 downto 0) => \^q\(4 downto 1)
    );
\addr_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[5]_i_1_n_0\,
      Q => \^q\(5),
      R => u_prints_n_13
    );
\addr_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[6]_i_1_n_0\,
      Q => \^q\(6),
      R => u_prints_n_13
    );
\addr_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[7]_i_1_n_0\,
      Q => \^q\(7),
      R => u_prints_n_13
    );
\addr_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[8]_i_1_n_0\,
      Q => \^q\(8),
      R => u_prints_n_13
    );
\addr_r_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_r_reg[4]_i_2_n_0\,
      CO(3) => \addr_r_reg[8]_i_2_n_0\,
      CO(2) => \addr_r_reg[8]_i_2_n_1\,
      CO(1) => \addr_r_reg[8]_i_2_n_2\,
      CO(0) => \addr_r_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in23(8 downto 5),
      S(3 downto 0) => \^q\(8 downto 5)
    );
\addr_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => addr_r(0),
      D => \addr_r[9]_i_1_n_0\,
      Q => \^q\(9),
      R => u_prints_n_13
    );
\cycle_r[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000020000"
    )
        port map (
      I0 => simt_ready_i,
      I1 => state_r(2),
      I2 => state_r(0),
      I3 => state_r(3),
      I4 => state_r(1),
      I5 => state_r(4),
      O => \cycle_r[0]_i_1_n_0\
    );
\cycle_r[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => simt_ready_i,
      O => sel
    );
\cycle_r[0]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => cycle_r_reg(0),
      O => \cycle_r[0]_i_4_n_0\
    );
\cycle_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[0]_i_3_n_7\,
      Q => cycle_r_reg(0),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[0]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \cycle_r_reg[0]_i_3_n_0\,
      CO(2) => \cycle_r_reg[0]_i_3_n_1\,
      CO(1) => \cycle_r_reg[0]_i_3_n_2\,
      CO(0) => \cycle_r_reg[0]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \cycle_r_reg[0]_i_3_n_4\,
      O(2) => \cycle_r_reg[0]_i_3_n_5\,
      O(1) => \cycle_r_reg[0]_i_3_n_6\,
      O(0) => \cycle_r_reg[0]_i_3_n_7\,
      S(3 downto 1) => cycle_r_reg(3 downto 1),
      S(0) => \cycle_r[0]_i_4_n_0\
    );
\cycle_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[8]_i_1_n_5\,
      Q => cycle_r_reg(10),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[8]_i_1_n_4\,
      Q => cycle_r_reg(11),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[12]_i_1_n_7\,
      Q => cycle_r_reg(12),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cycle_r_reg[8]_i_1_n_0\,
      CO(3) => \cycle_r_reg[12]_i_1_n_0\,
      CO(2) => \cycle_r_reg[12]_i_1_n_1\,
      CO(1) => \cycle_r_reg[12]_i_1_n_2\,
      CO(0) => \cycle_r_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cycle_r_reg[12]_i_1_n_4\,
      O(2) => \cycle_r_reg[12]_i_1_n_5\,
      O(1) => \cycle_r_reg[12]_i_1_n_6\,
      O(0) => \cycle_r_reg[12]_i_1_n_7\,
      S(3 downto 0) => cycle_r_reg(15 downto 12)
    );
\cycle_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[12]_i_1_n_6\,
      Q => cycle_r_reg(13),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[12]_i_1_n_5\,
      Q => cycle_r_reg(14),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[12]_i_1_n_4\,
      Q => cycle_r_reg(15),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[16]_i_1_n_7\,
      Q => cycle_r_reg(16),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cycle_r_reg[12]_i_1_n_0\,
      CO(3) => \cycle_r_reg[16]_i_1_n_0\,
      CO(2) => \cycle_r_reg[16]_i_1_n_1\,
      CO(1) => \cycle_r_reg[16]_i_1_n_2\,
      CO(0) => \cycle_r_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cycle_r_reg[16]_i_1_n_4\,
      O(2) => \cycle_r_reg[16]_i_1_n_5\,
      O(1) => \cycle_r_reg[16]_i_1_n_6\,
      O(0) => \cycle_r_reg[16]_i_1_n_7\,
      S(3 downto 0) => cycle_r_reg(19 downto 16)
    );
\cycle_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[16]_i_1_n_6\,
      Q => cycle_r_reg(17),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[16]_i_1_n_5\,
      Q => cycle_r_reg(18),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[16]_i_1_n_4\,
      Q => cycle_r_reg(19),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[0]_i_3_n_6\,
      Q => cycle_r_reg(1),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[20]_i_1_n_7\,
      Q => cycle_r_reg(20),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cycle_r_reg[16]_i_1_n_0\,
      CO(3) => \cycle_r_reg[20]_i_1_n_0\,
      CO(2) => \cycle_r_reg[20]_i_1_n_1\,
      CO(1) => \cycle_r_reg[20]_i_1_n_2\,
      CO(0) => \cycle_r_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cycle_r_reg[20]_i_1_n_4\,
      O(2) => \cycle_r_reg[20]_i_1_n_5\,
      O(1) => \cycle_r_reg[20]_i_1_n_6\,
      O(0) => \cycle_r_reg[20]_i_1_n_7\,
      S(3 downto 0) => cycle_r_reg(23 downto 20)
    );
\cycle_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[20]_i_1_n_6\,
      Q => cycle_r_reg(21),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[20]_i_1_n_5\,
      Q => cycle_r_reg(22),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[20]_i_1_n_4\,
      Q => cycle_r_reg(23),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[24]_i_1_n_7\,
      Q => cycle_r_reg(24),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cycle_r_reg[20]_i_1_n_0\,
      CO(3) => \cycle_r_reg[24]_i_1_n_0\,
      CO(2) => \cycle_r_reg[24]_i_1_n_1\,
      CO(1) => \cycle_r_reg[24]_i_1_n_2\,
      CO(0) => \cycle_r_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cycle_r_reg[24]_i_1_n_4\,
      O(2) => \cycle_r_reg[24]_i_1_n_5\,
      O(1) => \cycle_r_reg[24]_i_1_n_6\,
      O(0) => \cycle_r_reg[24]_i_1_n_7\,
      S(3 downto 0) => cycle_r_reg(27 downto 24)
    );
\cycle_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[24]_i_1_n_6\,
      Q => cycle_r_reg(25),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[24]_i_1_n_5\,
      Q => cycle_r_reg(26),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[24]_i_1_n_4\,
      Q => cycle_r_reg(27),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[28]_i_1_n_7\,
      Q => cycle_r_reg(28),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cycle_r_reg[24]_i_1_n_0\,
      CO(3) => \NLW_cycle_r_reg[28]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \cycle_r_reg[28]_i_1_n_1\,
      CO(1) => \cycle_r_reg[28]_i_1_n_2\,
      CO(0) => \cycle_r_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cycle_r_reg[28]_i_1_n_4\,
      O(2) => \cycle_r_reg[28]_i_1_n_5\,
      O(1) => \cycle_r_reg[28]_i_1_n_6\,
      O(0) => \cycle_r_reg[28]_i_1_n_7\,
      S(3 downto 0) => cycle_r_reg(31 downto 28)
    );
\cycle_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[28]_i_1_n_6\,
      Q => cycle_r_reg(29),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[0]_i_3_n_5\,
      Q => cycle_r_reg(2),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[28]_i_1_n_5\,
      Q => cycle_r_reg(30),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[28]_i_1_n_4\,
      Q => cycle_r_reg(31),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[0]_i_3_n_4\,
      Q => cycle_r_reg(3),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[4]_i_1_n_7\,
      Q => cycle_r_reg(4),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cycle_r_reg[0]_i_3_n_0\,
      CO(3) => \cycle_r_reg[4]_i_1_n_0\,
      CO(2) => \cycle_r_reg[4]_i_1_n_1\,
      CO(1) => \cycle_r_reg[4]_i_1_n_2\,
      CO(0) => \cycle_r_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cycle_r_reg[4]_i_1_n_4\,
      O(2) => \cycle_r_reg[4]_i_1_n_5\,
      O(1) => \cycle_r_reg[4]_i_1_n_6\,
      O(0) => \cycle_r_reg[4]_i_1_n_7\,
      S(3 downto 0) => cycle_r_reg(7 downto 4)
    );
\cycle_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[4]_i_1_n_6\,
      Q => cycle_r_reg(5),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[4]_i_1_n_5\,
      Q => cycle_r_reg(6),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[4]_i_1_n_4\,
      Q => cycle_r_reg(7),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[8]_i_1_n_7\,
      Q => cycle_r_reg(8),
      R => \cycle_r[0]_i_1_n_0\
    );
\cycle_r_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cycle_r_reg[4]_i_1_n_0\,
      CO(3) => \cycle_r_reg[8]_i_1_n_0\,
      CO(2) => \cycle_r_reg[8]_i_1_n_1\,
      CO(1) => \cycle_r_reg[8]_i_1_n_2\,
      CO(0) => \cycle_r_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cycle_r_reg[8]_i_1_n_4\,
      O(2) => \cycle_r_reg[8]_i_1_n_5\,
      O(1) => \cycle_r_reg[8]_i_1_n_6\,
      O(0) => \cycle_r_reg[8]_i_1_n_7\,
      S(3 downto 0) => cycle_r_reg(11 downto 8)
    );
\cycle_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => sel,
      D => \cycle_r_reg[8]_i_1_n_6\,
      Q => cycle_r_reg(9),
      R => \cycle_r[0]_i_1_n_0\
    );
\err_count_r[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => state_r(1),
      I1 => \err_count_r_reg_n_0_[0]\,
      O => \err_count_r[0]_i_1_n_0\
    );
\err_count_r[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(10),
      O => \err_count_r[10]_i_1_n_0\
    );
\err_count_r[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(11),
      O => \err_count_r[11]_i_1_n_0\
    );
\err_count_r[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(12),
      O => \err_count_r[12]_i_1_n_0\
    );
\err_count_r[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(13),
      O => \err_count_r[13]_i_1_n_0\
    );
\err_count_r[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(14),
      O => \err_count_r[14]_i_1_n_0\
    );
\err_count_r[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(15),
      O => \err_count_r[15]_i_1_n_0\
    );
\err_count_r[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(16),
      O => \err_count_r[16]_i_1_n_0\
    );
\err_count_r[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(17),
      O => \err_count_r[17]_i_1_n_0\
    );
\err_count_r[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(18),
      O => \err_count_r[18]_i_1_n_0\
    );
\err_count_r[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(19),
      O => \err_count_r[19]_i_1_n_0\
    );
\err_count_r[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(1),
      O => \err_count_r[1]_i_1_n_0\
    );
\err_count_r[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(20),
      O => \err_count_r[20]_i_1_n_0\
    );
\err_count_r[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(21),
      O => \err_count_r[21]_i_1_n_0\
    );
\err_count_r[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(22),
      O => \err_count_r[22]_i_1_n_0\
    );
\err_count_r[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(23),
      O => \err_count_r[23]_i_1_n_0\
    );
\err_count_r[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(24),
      O => \err_count_r[24]_i_1_n_0\
    );
\err_count_r[25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(25),
      O => \err_count_r[25]_i_1_n_0\
    );
\err_count_r[26]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(26),
      O => \err_count_r[26]_i_1_n_0\
    );
\err_count_r[27]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(27),
      O => \err_count_r[27]_i_1_n_0\
    );
\err_count_r[28]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(28),
      O => \err_count_r[28]_i_1_n_0\
    );
\err_count_r[29]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(29),
      O => \err_count_r[29]_i_1_n_0\
    );
\err_count_r[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(2),
      O => \err_count_r[2]_i_1_n_0\
    );
\err_count_r[30]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(30),
      O => \err_count_r[30]_i_1_n_0\
    );
\err_count_r[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0023000000200000"
    )
        port map (
      I0 => \err_count_r_reg[31]_i_3_n_1\,
      I1 => state_r(4),
      I2 => state_r(1),
      I3 => state_r(3),
      I4 => \err_count_r[31]_i_4_n_0\,
      I5 => simt_ready_i,
      O => err_count_r(0)
    );
\err_count_r[31]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8001"
    )
        port map (
      I0 => in7(31),
      I1 => mem_dout_i(23),
      I2 => mem_dout_i(22),
      I3 => mem_dout_i(21),
      O => \err_count_r[31]_i_11_n_0\
    );
\err_count_r[31]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8001"
    )
        port map (
      I0 => in7(31),
      I1 => mem_dout_i(20),
      I2 => mem_dout_i(19),
      I3 => mem_dout_i(18),
      O => \err_count_r[31]_i_12_n_0\
    );
\err_count_r[31]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8001"
    )
        port map (
      I0 => in7(31),
      I1 => mem_dout_i(17),
      I2 => mem_dout_i(16),
      I3 => mem_dout_i(15),
      O => \err_count_r[31]_i_13_n_0\
    );
\err_count_r[31]_i_14\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8001"
    )
        port map (
      I0 => in7(31),
      I1 => mem_dout_i(14),
      I2 => mem_dout_i(13),
      I3 => mem_dout_i(12),
      O => \err_count_r[31]_i_14_n_0\
    );
\err_count_r[31]_i_15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8001"
    )
        port map (
      I0 => in7(31),
      I1 => mem_dout_i(11),
      I2 => mem_dout_i(10),
      I3 => mem_dout_i(9),
      O => \err_count_r[31]_i_15_n_0\
    );
\err_count_r[31]_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"10000001E000000E"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(3),
      I2 => in7(31),
      I3 => mem_dout_i(7),
      I4 => mem_dout_i(8),
      I5 => mem_dout_i(6),
      O => \err_count_r[31]_i_16_n_0\
    );
\err_count_r[31]_i_17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000066006600000"
    )
        port map (
      I0 => u_prints_n_10,
      I1 => mem_dout_i(4),
      I2 => u_prints_n_5,
      I3 => mem_dout_i(3),
      I4 => mem_dout_i(5),
      I5 => u_prints_n_9,
      O => \err_count_r[31]_i_17_n_0\
    );
\err_count_r[31]_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000128412840000"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => mem_dout_i(1),
      I3 => mem_dout_i(0),
      I4 => mem_dout_i(2),
      I5 => u_prints_n_6,
      O => \err_count_r[31]_i_18_n_0\
    );
\err_count_r[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(31),
      O => \err_count_r[31]_i_2_n_0\
    );
\err_count_r[31]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(2),
      I1 => state_r(0),
      O => \err_count_r[31]_i_4_n_0\
    );
\err_count_r[31]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"100E"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(2),
      I2 => mem_dout_i(30),
      I3 => mem_dout_i(31),
      O => \err_count_r[31]_i_7_n_0\
    );
\err_count_r[31]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8001"
    )
        port map (
      I0 => in7(31),
      I1 => mem_dout_i(29),
      I2 => mem_dout_i(28),
      I3 => mem_dout_i(27),
      O => \err_count_r[31]_i_8_n_0\
    );
\err_count_r[31]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8001"
    )
        port map (
      I0 => in7(31),
      I1 => mem_dout_i(26),
      I2 => mem_dout_i(25),
      I3 => mem_dout_i(24),
      O => \err_count_r[31]_i_9_n_0\
    );
\err_count_r[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(3),
      O => \err_count_r[3]_i_1_n_0\
    );
\err_count_r[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(4),
      O => \err_count_r[4]_i_1_n_0\
    );
\err_count_r[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(5),
      O => \err_count_r[5]_i_1_n_0\
    );
\err_count_r[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(6),
      O => \err_count_r[6]_i_1_n_0\
    );
\err_count_r[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(7),
      O => \err_count_r[7]_i_1_n_0\
    );
\err_count_r[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(8),
      O => \err_count_r[8]_i_1_n_0\
    );
\err_count_r[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state_r(1),
      I1 => in20(9),
      O => \err_count_r[9]_i_1_n_0\
    );
\err_count_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[0]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[0]\,
      R => u_prints_n_13
    );
\err_count_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[10]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[10]\,
      R => u_prints_n_13
    );
\err_count_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[11]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[11]\,
      R => u_prints_n_13
    );
\err_count_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[12]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[12]\,
      R => u_prints_n_13
    );
\err_count_r_reg[12]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \err_count_r_reg[8]_i_2_n_0\,
      CO(3) => \err_count_r_reg[12]_i_2_n_0\,
      CO(2) => \err_count_r_reg[12]_i_2_n_1\,
      CO(1) => \err_count_r_reg[12]_i_2_n_2\,
      CO(0) => \err_count_r_reg[12]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in20(12 downto 9),
      S(3) => \err_count_r_reg_n_0_[12]\,
      S(2) => \err_count_r_reg_n_0_[11]\,
      S(1) => \err_count_r_reg_n_0_[10]\,
      S(0) => \err_count_r_reg_n_0_[9]\
    );
\err_count_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[13]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[13]\,
      R => u_prints_n_13
    );
\err_count_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[14]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[14]\,
      R => u_prints_n_13
    );
\err_count_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[15]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[15]\,
      R => u_prints_n_13
    );
\err_count_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[16]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[16]\,
      R => u_prints_n_13
    );
\err_count_r_reg[16]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \err_count_r_reg[12]_i_2_n_0\,
      CO(3) => \err_count_r_reg[16]_i_2_n_0\,
      CO(2) => \err_count_r_reg[16]_i_2_n_1\,
      CO(1) => \err_count_r_reg[16]_i_2_n_2\,
      CO(0) => \err_count_r_reg[16]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in20(16 downto 13),
      S(3) => \err_count_r_reg_n_0_[16]\,
      S(2) => \err_count_r_reg_n_0_[15]\,
      S(1) => \err_count_r_reg_n_0_[14]\,
      S(0) => \err_count_r_reg_n_0_[13]\
    );
\err_count_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[17]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[17]\,
      R => u_prints_n_13
    );
\err_count_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[18]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[18]\,
      R => u_prints_n_13
    );
\err_count_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[19]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[19]\,
      R => u_prints_n_13
    );
\err_count_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[1]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[1]\,
      R => u_prints_n_13
    );
\err_count_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[20]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[20]\,
      R => u_prints_n_13
    );
\err_count_r_reg[20]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \err_count_r_reg[16]_i_2_n_0\,
      CO(3) => \err_count_r_reg[20]_i_2_n_0\,
      CO(2) => \err_count_r_reg[20]_i_2_n_1\,
      CO(1) => \err_count_r_reg[20]_i_2_n_2\,
      CO(0) => \err_count_r_reg[20]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in20(20 downto 17),
      S(3) => \err_count_r_reg_n_0_[20]\,
      S(2) => \err_count_r_reg_n_0_[19]\,
      S(1) => \err_count_r_reg_n_0_[18]\,
      S(0) => \err_count_r_reg_n_0_[17]\
    );
\err_count_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[21]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[21]\,
      R => u_prints_n_13
    );
\err_count_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[22]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[22]\,
      R => u_prints_n_13
    );
\err_count_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[23]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[23]\,
      R => u_prints_n_13
    );
\err_count_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[24]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[24]\,
      R => u_prints_n_13
    );
\err_count_r_reg[24]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \err_count_r_reg[20]_i_2_n_0\,
      CO(3) => \err_count_r_reg[24]_i_2_n_0\,
      CO(2) => \err_count_r_reg[24]_i_2_n_1\,
      CO(1) => \err_count_r_reg[24]_i_2_n_2\,
      CO(0) => \err_count_r_reg[24]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in20(24 downto 21),
      S(3) => \err_count_r_reg_n_0_[24]\,
      S(2) => \err_count_r_reg_n_0_[23]\,
      S(1) => \err_count_r_reg_n_0_[22]\,
      S(0) => \err_count_r_reg_n_0_[21]\
    );
\err_count_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[25]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[25]\,
      R => u_prints_n_13
    );
\err_count_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[26]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[26]\,
      R => u_prints_n_13
    );
\err_count_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[27]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[27]\,
      R => u_prints_n_13
    );
\err_count_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[28]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[28]\,
      R => u_prints_n_13
    );
\err_count_r_reg[28]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \err_count_r_reg[24]_i_2_n_0\,
      CO(3) => \err_count_r_reg[28]_i_2_n_0\,
      CO(2) => \err_count_r_reg[28]_i_2_n_1\,
      CO(1) => \err_count_r_reg[28]_i_2_n_2\,
      CO(0) => \err_count_r_reg[28]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in20(28 downto 25),
      S(3) => \err_count_r_reg_n_0_[28]\,
      S(2) => \err_count_r_reg_n_0_[27]\,
      S(1) => \err_count_r_reg_n_0_[26]\,
      S(0) => \err_count_r_reg_n_0_[25]\
    );
\err_count_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[29]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[29]\,
      R => u_prints_n_13
    );
\err_count_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[2]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[2]\,
      R => u_prints_n_13
    );
\err_count_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[30]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[30]\,
      R => u_prints_n_13
    );
\err_count_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[31]_i_2_n_0\,
      Q => \err_count_r_reg_n_0_[31]\,
      R => u_prints_n_13
    );
\err_count_r_reg[31]_i_10\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \err_count_r_reg[31]_i_10_n_0\,
      CO(2) => \err_count_r_reg[31]_i_10_n_1\,
      CO(1) => \err_count_r_reg[31]_i_10_n_2\,
      CO(0) => \err_count_r_reg[31]_i_10_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"1111",
      O(3 downto 0) => \NLW_err_count_r_reg[31]_i_10_O_UNCONNECTED\(3 downto 0),
      S(3) => \err_count_r[31]_i_15_n_0\,
      S(2) => \err_count_r[31]_i_16_n_0\,
      S(1) => \err_count_r[31]_i_17_n_0\,
      S(0) => \err_count_r[31]_i_18_n_0\
    );
\err_count_r_reg[31]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \err_count_r_reg[31]_i_6_n_0\,
      CO(3) => \NLW_err_count_r_reg[31]_i_3_CO_UNCONNECTED\(3),
      CO(2) => \err_count_r_reg[31]_i_3_n_1\,
      CO(1) => \err_count_r_reg[31]_i_3_n_2\,
      CO(0) => \err_count_r_reg[31]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0111",
      O(3 downto 0) => \NLW_err_count_r_reg[31]_i_3_O_UNCONNECTED\(3 downto 0),
      S(3) => '0',
      S(2) => \err_count_r[31]_i_7_n_0\,
      S(1) => \err_count_r[31]_i_8_n_0\,
      S(0) => \err_count_r[31]_i_9_n_0\
    );
\err_count_r_reg[31]_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \err_count_r_reg[28]_i_2_n_0\,
      CO(3 downto 2) => \NLW_err_count_r_reg[31]_i_5_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \err_count_r_reg[31]_i_5_n_2\,
      CO(0) => \err_count_r_reg[31]_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_err_count_r_reg[31]_i_5_O_UNCONNECTED\(3),
      O(2 downto 0) => in20(31 downto 29),
      S(3) => '0',
      S(2) => \err_count_r_reg_n_0_[31]\,
      S(1) => \err_count_r_reg_n_0_[30]\,
      S(0) => \err_count_r_reg_n_0_[29]\
    );
\err_count_r_reg[31]_i_6\: unisim.vcomponents.CARRY4
     port map (
      CI => \err_count_r_reg[31]_i_10_n_0\,
      CO(3) => \err_count_r_reg[31]_i_6_n_0\,
      CO(2) => \err_count_r_reg[31]_i_6_n_1\,
      CO(1) => \err_count_r_reg[31]_i_6_n_2\,
      CO(0) => \err_count_r_reg[31]_i_6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"1111",
      O(3 downto 0) => \NLW_err_count_r_reg[31]_i_6_O_UNCONNECTED\(3 downto 0),
      S(3) => \err_count_r[31]_i_11_n_0\,
      S(2) => \err_count_r[31]_i_12_n_0\,
      S(1) => \err_count_r[31]_i_13_n_0\,
      S(0) => \err_count_r[31]_i_14_n_0\
    );
\err_count_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[3]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[3]\,
      R => u_prints_n_13
    );
\err_count_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[4]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[4]\,
      R => u_prints_n_13
    );
\err_count_r_reg[4]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \err_count_r_reg[4]_i_2_n_0\,
      CO(2) => \err_count_r_reg[4]_i_2_n_1\,
      CO(1) => \err_count_r_reg[4]_i_2_n_2\,
      CO(0) => \err_count_r_reg[4]_i_2_n_3\,
      CYINIT => \err_count_r_reg_n_0_[0]\,
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in20(4 downto 1),
      S(3) => \err_count_r_reg_n_0_[4]\,
      S(2) => \err_count_r_reg_n_0_[3]\,
      S(1) => \err_count_r_reg_n_0_[2]\,
      S(0) => \err_count_r_reg_n_0_[1]\
    );
\err_count_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[5]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[5]\,
      R => u_prints_n_13
    );
\err_count_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[6]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[6]\,
      R => u_prints_n_13
    );
\err_count_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[7]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[7]\,
      R => u_prints_n_13
    );
\err_count_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[8]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[8]\,
      R => u_prints_n_13
    );
\err_count_r_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \err_count_r_reg[4]_i_2_n_0\,
      CO(3) => \err_count_r_reg[8]_i_2_n_0\,
      CO(2) => \err_count_r_reg[8]_i_2_n_1\,
      CO(1) => \err_count_r_reg[8]_i_2_n_2\,
      CO(0) => \err_count_r_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in20(8 downto 5),
      S(3) => \err_count_r_reg_n_0_[8]\,
      S(2) => \err_count_r_reg_n_0_[7]\,
      S(1) => \err_count_r_reg_n_0_[6]\,
      S(0) => \err_count_r_reg_n_0_[5]\
    );
\err_count_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => err_count_r(0),
      D => \err_count_r[9]_i_1_n_0\,
      Q => \err_count_r_reg_n_0_[9]\,
      R => u_prints_n_13
    );
\mem_actual_r[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000800000"
    )
        port map (
      I0 => rst_n,
      I1 => state_r(2),
      I2 => state_r(0),
      I3 => state_r(3),
      I4 => state_r(1),
      I5 => state_r(4),
      O => \mem_actual_r[31]_i_1_n_0\
    );
\mem_actual_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(0),
      Q => \mem_actual_r__0\(0),
      R => '0'
    );
\mem_actual_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(10),
      Q => \mem_actual_r__0\(10),
      R => '0'
    );
\mem_actual_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(11),
      Q => \mem_actual_r__0\(11),
      R => '0'
    );
\mem_actual_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(12),
      Q => \mem_actual_r__0\(12),
      R => '0'
    );
\mem_actual_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(13),
      Q => \mem_actual_r__0\(13),
      R => '0'
    );
\mem_actual_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(14),
      Q => \mem_actual_r__0\(14),
      R => '0'
    );
\mem_actual_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(15),
      Q => \mem_actual_r__0\(15),
      R => '0'
    );
\mem_actual_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(16),
      Q => \mem_actual_r__0\(16),
      R => '0'
    );
\mem_actual_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(17),
      Q => \mem_actual_r__0\(17),
      R => '0'
    );
\mem_actual_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(18),
      Q => \mem_actual_r__0\(18),
      R => '0'
    );
\mem_actual_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(19),
      Q => \mem_actual_r__0\(19),
      R => '0'
    );
\mem_actual_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(1),
      Q => \mem_actual_r__0\(1),
      R => '0'
    );
\mem_actual_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(20),
      Q => \mem_actual_r__0\(20),
      R => '0'
    );
\mem_actual_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(21),
      Q => \mem_actual_r__0\(21),
      R => '0'
    );
\mem_actual_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(22),
      Q => \mem_actual_r__0\(22),
      R => '0'
    );
\mem_actual_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(23),
      Q => \mem_actual_r__0\(23),
      R => '0'
    );
\mem_actual_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(24),
      Q => \mem_actual_r__0\(24),
      R => '0'
    );
\mem_actual_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(25),
      Q => \mem_actual_r__0\(25),
      R => '0'
    );
\mem_actual_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(26),
      Q => \mem_actual_r__0\(26),
      R => '0'
    );
\mem_actual_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(27),
      Q => \mem_actual_r__0\(27),
      R => '0'
    );
\mem_actual_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(28),
      Q => \mem_actual_r__0\(28),
      R => '0'
    );
\mem_actual_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(29),
      Q => \mem_actual_r__0\(29),
      R => '0'
    );
\mem_actual_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(2),
      Q => \mem_actual_r__0\(2),
      R => '0'
    );
\mem_actual_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(30),
      Q => \mem_actual_r__0\(30),
      R => '0'
    );
\mem_actual_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(31),
      Q => \mem_actual_r__0\(31),
      R => '0'
    );
\mem_actual_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(3),
      Q => \mem_actual_r__0\(3),
      R => '0'
    );
\mem_actual_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(4),
      Q => \mem_actual_r__0\(4),
      R => '0'
    );
\mem_actual_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(5),
      Q => \mem_actual_r__0\(5),
      R => '0'
    );
\mem_actual_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(6),
      Q => \mem_actual_r__0\(6),
      R => '0'
    );
\mem_actual_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(7),
      Q => \mem_actual_r__0\(7),
      R => '0'
    );
\mem_actual_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(8),
      Q => \mem_actual_r__0\(8),
      R => '0'
    );
\mem_actual_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \mem_actual_r[31]_i_1_n_0\,
      D => mem_dout_i(9),
      Q => \mem_actual_r__0\(9),
      R => '0'
    );
\mem_din_o[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[3]_0\,
      I1 => \^q\(0),
      O => mem_din_o(0)
    );
\mem_din_o[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"82"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[3]_0\,
      I1 => \^q\(0),
      I2 => \^q\(1),
      O => mem_din_o(1)
    );
\mem_din_o[2]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08A2"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[3]_0\,
      I1 => \^q\(1),
      I2 => \^q\(0),
      I3 => \^q\(2),
      O => mem_din_o(2)
    );
\mem_din_o[3]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"802A2882"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[3]_0\,
      I1 => \^q\(2),
      I2 => \^q\(0),
      I3 => \^q\(3),
      I4 => \^q\(1),
      O => mem_din_o(3)
    );
\mem_din_o[4]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A8802A28"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[3]_0\,
      I1 => \^q\(1),
      I2 => \^q\(3),
      I3 => \^q\(0),
      I4 => \^q\(2),
      O => mem_din_o(4)
    );
\mem_din_o[5]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88A2"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[3]_0\,
      I1 => \^q\(3),
      I2 => \^q\(1),
      I3 => \^q\(2),
      O => mem_din_o(5)
    );
\mem_din_o[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \^fsm_sequential_state_r_reg[3]_0\,
      I1 => \^q\(3),
      I2 => \^q\(2),
      O => mem_din_o(6)
    );
\mem_din_o[7]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000400"
    )
        port map (
      I0 => state_r(3),
      I1 => state_r(0),
      I2 => state_r(2),
      I3 => in7(31),
      I4 => state_r(1),
      I5 => state_r(4),
      O => mem_din_o(7)
    );
mem_we_o_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => state_r(3),
      I1 => state_r(1),
      I2 => state_r(4),
      I3 => state_r(2),
      I4 => state_r(0),
      O => \^fsm_sequential_state_r_reg[3]_0\
    );
ready_o_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => state_r(0),
      I1 => state_r(2),
      I2 => state_r(3),
      I3 => state_r(1),
      I4 => state_r(4),
      O => ready_o
    );
simt_start_o_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000100"
    )
        port map (
      I0 => state_r(0),
      I1 => state_r(2),
      I2 => state_r(3),
      I3 => state_r(1),
      I4 => state_r(4),
      O => simt_start_o
    );
u_prints: entity work.total_design_host_top_wrapper_0_0_prints
     port map (
      E(0) => addr_r(0),
      \FSM_sequential_state_r_reg[0]_0\ => \addr_r[12]_i_10_n_0\,
      \FSM_sequential_state_r_reg[0]_1\ => \addr_r[12]_i_14_n_0\,
      \FSM_sequential_state_r_reg[0]_2\ => \addr_r[12]_i_13_n_0\,
      \FSM_sequential_state_r_reg[1]_0\ => u_prints_n_0,
      \FSM_sequential_state_r_reg[1]_1\ => u_prints_n_7,
      \FSM_sequential_state_r_reg[4]\(0) => u_prints_n_4,
      Q(4 downto 0) => state_r(4 downto 0),
      SR(0) => u_prints_n_13,
      \addr_r_reg[0]\ => \addr_r[12]_i_6_n_0\,
      \addr_r_reg[0]_0\ => \addr_r[12]_i_4_n_0\,
      \addr_r_reg[0]_1\ => \addr_r[12]_i_7_n_0\,
      \addr_r_reg[0]_2\ => \addr_r[12]_i_8_n_0\,
      \addr_r_reg[1]\ => u_prints_n_5,
      \addr_r_reg[2]\ => u_prints_n_6,
      \addr_r_reg[2]_0\ => u_prints_n_9,
      \addr_r_reg[2]_1\ => u_prints_n_10,
      clk => clk,
      cycle_r_reg(31 downto 0) => cycle_r_reg(31 downto 0),
      \hex_r_reg[1][12]_0\(12 downto 0) => \^q\(12 downto 0),
      \hex_r_reg[1][31]_0\(31) => \err_count_r_reg_n_0_[31]\,
      \hex_r_reg[1][31]_0\(30) => \err_count_r_reg_n_0_[30]\,
      \hex_r_reg[1][31]_0\(29) => \err_count_r_reg_n_0_[29]\,
      \hex_r_reg[1][31]_0\(28) => \err_count_r_reg_n_0_[28]\,
      \hex_r_reg[1][31]_0\(27) => \err_count_r_reg_n_0_[27]\,
      \hex_r_reg[1][31]_0\(26) => \err_count_r_reg_n_0_[26]\,
      \hex_r_reg[1][31]_0\(25) => \err_count_r_reg_n_0_[25]\,
      \hex_r_reg[1][31]_0\(24) => \err_count_r_reg_n_0_[24]\,
      \hex_r_reg[1][31]_0\(23) => \err_count_r_reg_n_0_[23]\,
      \hex_r_reg[1][31]_0\(22) => \err_count_r_reg_n_0_[22]\,
      \hex_r_reg[1][31]_0\(21) => \err_count_r_reg_n_0_[21]\,
      \hex_r_reg[1][31]_0\(20) => \err_count_r_reg_n_0_[20]\,
      \hex_r_reg[1][31]_0\(19) => \err_count_r_reg_n_0_[19]\,
      \hex_r_reg[1][31]_0\(18) => \err_count_r_reg_n_0_[18]\,
      \hex_r_reg[1][31]_0\(17) => \err_count_r_reg_n_0_[17]\,
      \hex_r_reg[1][31]_0\(16) => \err_count_r_reg_n_0_[16]\,
      \hex_r_reg[1][31]_0\(15) => \err_count_r_reg_n_0_[15]\,
      \hex_r_reg[1][31]_0\(14) => \err_count_r_reg_n_0_[14]\,
      \hex_r_reg[1][31]_0\(13) => \err_count_r_reg_n_0_[13]\,
      \hex_r_reg[1][31]_0\(12) => \err_count_r_reg_n_0_[12]\,
      \hex_r_reg[1][31]_0\(11) => \err_count_r_reg_n_0_[11]\,
      \hex_r_reg[1][31]_0\(10) => \err_count_r_reg_n_0_[10]\,
      \hex_r_reg[1][31]_0\(9) => \err_count_r_reg_n_0_[9]\,
      \hex_r_reg[1][31]_0\(8) => \err_count_r_reg_n_0_[8]\,
      \hex_r_reg[1][31]_0\(7) => \err_count_r_reg_n_0_[7]\,
      \hex_r_reg[1][31]_0\(6) => \err_count_r_reg_n_0_[6]\,
      \hex_r_reg[1][31]_0\(5) => \err_count_r_reg_n_0_[5]\,
      \hex_r_reg[1][31]_0\(4) => \err_count_r_reg_n_0_[4]\,
      \hex_r_reg[1][31]_0\(3) => \err_count_r_reg_n_0_[3]\,
      \hex_r_reg[1][31]_0\(2) => \err_count_r_reg_n_0_[2]\,
      \hex_r_reg[1][31]_0\(1) => \err_count_r_reg_n_0_[1]\,
      \hex_r_reg[1][31]_0\(0) => \err_count_r_reg_n_0_[0]\,
      \hex_r_reg[1][31]_1\(31 downto 0) => \wtinstret_r__0\(31 downto 0),
      \hex_r_reg[2][31]_0\(31 downto 0) => \wtinstreth_r__0\(31 downto 0),
      \hex_r_reg[3][31]_0\(31 downto 0) => \wuinstret_r__0\(31 downto 0),
      \hex_r_reg[3][31]_1\(31 downto 0) => \mem_actual_r__0\(31 downto 0),
      \hex_r_reg[4][31]_0\(31) => \wuinstreth_r_reg_n_0_[31]\,
      \hex_r_reg[4][31]_0\(30) => \wuinstreth_r_reg_n_0_[30]\,
      \hex_r_reg[4][31]_0\(29) => \wuinstreth_r_reg_n_0_[29]\,
      \hex_r_reg[4][31]_0\(28) => \wuinstreth_r_reg_n_0_[28]\,
      \hex_r_reg[4][31]_0\(27) => \wuinstreth_r_reg_n_0_[27]\,
      \hex_r_reg[4][31]_0\(26) => \wuinstreth_r_reg_n_0_[26]\,
      \hex_r_reg[4][31]_0\(25) => \wuinstreth_r_reg_n_0_[25]\,
      \hex_r_reg[4][31]_0\(24) => \wuinstreth_r_reg_n_0_[24]\,
      \hex_r_reg[4][31]_0\(23) => \wuinstreth_r_reg_n_0_[23]\,
      \hex_r_reg[4][31]_0\(22) => \wuinstreth_r_reg_n_0_[22]\,
      \hex_r_reg[4][31]_0\(21) => \wuinstreth_r_reg_n_0_[21]\,
      \hex_r_reg[4][31]_0\(20) => \wuinstreth_r_reg_n_0_[20]\,
      \hex_r_reg[4][31]_0\(19) => \wuinstreth_r_reg_n_0_[19]\,
      \hex_r_reg[4][31]_0\(18) => \wuinstreth_r_reg_n_0_[18]\,
      \hex_r_reg[4][31]_0\(17) => \wuinstreth_r_reg_n_0_[17]\,
      \hex_r_reg[4][31]_0\(16) => \wuinstreth_r_reg_n_0_[16]\,
      \hex_r_reg[4][31]_0\(15) => \wuinstreth_r_reg_n_0_[15]\,
      \hex_r_reg[4][31]_0\(14) => \wuinstreth_r_reg_n_0_[14]\,
      \hex_r_reg[4][31]_0\(13) => \wuinstreth_r_reg_n_0_[13]\,
      \hex_r_reg[4][31]_0\(12) => \wuinstreth_r_reg_n_0_[12]\,
      \hex_r_reg[4][31]_0\(11) => \wuinstreth_r_reg_n_0_[11]\,
      \hex_r_reg[4][31]_0\(10) => \wuinstreth_r_reg_n_0_[10]\,
      \hex_r_reg[4][31]_0\(9) => \wuinstreth_r_reg_n_0_[9]\,
      \hex_r_reg[4][31]_0\(8) => \wuinstreth_r_reg_n_0_[8]\,
      \hex_r_reg[4][31]_0\(7) => \wuinstreth_r_reg_n_0_[7]\,
      \hex_r_reg[4][31]_0\(6) => \wuinstreth_r_reg_n_0_[6]\,
      \hex_r_reg[4][31]_0\(5) => \wuinstreth_r_reg_n_0_[5]\,
      \hex_r_reg[4][31]_0\(4) => \wuinstreth_r_reg_n_0_[4]\,
      \hex_r_reg[4][31]_0\(3) => \wuinstreth_r_reg_n_0_[3]\,
      \hex_r_reg[4][31]_0\(2) => \wuinstreth_r_reg_n_0_[2]\,
      \hex_r_reg[4][31]_0\(1) => \wuinstreth_r_reg_n_0_[1]\,
      \hex_r_reg[4][31]_0\(0) => \wuinstreth_r_reg_n_0_[0]\,
      in7(0) => in7(31),
      m_axi_arready => m_axi_arready,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      m_axi_bready => m_axi_bready,
      m_axi_bvalid => m_axi_bvalid,
      m_axi_rdata(0) => m_axi_rdata(0),
      m_axi_rready => m_axi_rready,
      m_axi_rvalid => m_axi_rvalid,
      m_axi_wdata(6 downto 0) => m_axi_wdata(6 downto 0),
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid,
      rst_n => rst_n,
      simt_ready_i => simt_ready_i,
      start_i => start_i,
      string_i(1) => u_prints_n_11,
      string_i(0) => \state_r__0\(0),
      wait_counter_fin_w => wait_counter_fin_w,
      wait_counter_next_w(0) => wait_counter_next_w(1),
      \wait_counter_r[1]_i_3_0\ => \FSM_sequential_state_r[4]_i_5_n_0\,
      \wait_counter_r_reg[0]\ => u_prints_n_1,
      \wait_counter_r_reg[0]_0\ => u_prints_n_2,
      \wait_counter_r_reg[0]_1\ => \wait_counter_r[1]_i_2_n_0\,
      \wait_counter_r_reg[1]\ => \wait_counter_r[1]_i_5_n_0\
    );
\wait_counter_r[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04040C00"
    )
        port map (
      I0 => wait_counter_fin_w,
      I1 => state_r(2),
      I2 => state_r(4),
      I3 => state_r(1),
      I4 => state_r(3),
      O => \wait_counter_r[1]_i_2_n_0\
    );
\wait_counter_r[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008C00C8008C0088"
    )
        port map (
      I0 => state_r(3),
      I1 => state_r(2),
      I2 => state_r(0),
      I3 => state_r(4),
      I4 => state_r(1),
      I5 => simt_ready_i,
      O => \wait_counter_r[1]_i_5_n_0\
    );
\wait_counter_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_prints_n_1,
      Q => wait_counter_next_w(1),
      R => u_prints_n_13
    );
\wait_counter_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_prints_n_2,
      Q => wait_counter_fin_w,
      R => u_prints_n_13
    );
\wtinstret_r[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0800000000000000"
    )
        port map (
      I0 => u_prints_n_0,
      I1 => state_r(2),
      I2 => state_r(0),
      I3 => rst_n,
      I4 => state_r(3),
      I5 => wait_counter_fin_w,
      O => \wtinstret_r[31]_i_1_n_0\
    );
\wtinstret_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(0),
      Q => \wtinstret_r__0\(0),
      R => '0'
    );
\wtinstret_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(10),
      Q => \wtinstret_r__0\(10),
      R => '0'
    );
\wtinstret_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(11),
      Q => \wtinstret_r__0\(11),
      R => '0'
    );
\wtinstret_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(12),
      Q => \wtinstret_r__0\(12),
      R => '0'
    );
\wtinstret_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(13),
      Q => \wtinstret_r__0\(13),
      R => '0'
    );
\wtinstret_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(14),
      Q => \wtinstret_r__0\(14),
      R => '0'
    );
\wtinstret_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(15),
      Q => \wtinstret_r__0\(15),
      R => '0'
    );
\wtinstret_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(16),
      Q => \wtinstret_r__0\(16),
      R => '0'
    );
\wtinstret_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(17),
      Q => \wtinstret_r__0\(17),
      R => '0'
    );
\wtinstret_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(18),
      Q => \wtinstret_r__0\(18),
      R => '0'
    );
\wtinstret_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(19),
      Q => \wtinstret_r__0\(19),
      R => '0'
    );
\wtinstret_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(1),
      Q => \wtinstret_r__0\(1),
      R => '0'
    );
\wtinstret_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(20),
      Q => \wtinstret_r__0\(20),
      R => '0'
    );
\wtinstret_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(21),
      Q => \wtinstret_r__0\(21),
      R => '0'
    );
\wtinstret_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(22),
      Q => \wtinstret_r__0\(22),
      R => '0'
    );
\wtinstret_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(23),
      Q => \wtinstret_r__0\(23),
      R => '0'
    );
\wtinstret_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(24),
      Q => \wtinstret_r__0\(24),
      R => '0'
    );
\wtinstret_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(25),
      Q => \wtinstret_r__0\(25),
      R => '0'
    );
\wtinstret_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(26),
      Q => \wtinstret_r__0\(26),
      R => '0'
    );
\wtinstret_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(27),
      Q => \wtinstret_r__0\(27),
      R => '0'
    );
\wtinstret_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(28),
      Q => \wtinstret_r__0\(28),
      R => '0'
    );
\wtinstret_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(29),
      Q => \wtinstret_r__0\(29),
      R => '0'
    );
\wtinstret_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(2),
      Q => \wtinstret_r__0\(2),
      R => '0'
    );
\wtinstret_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(30),
      Q => \wtinstret_r__0\(30),
      R => '0'
    );
\wtinstret_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(31),
      Q => \wtinstret_r__0\(31),
      R => '0'
    );
\wtinstret_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(3),
      Q => \wtinstret_r__0\(3),
      R => '0'
    );
\wtinstret_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(4),
      Q => \wtinstret_r__0\(4),
      R => '0'
    );
\wtinstret_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(5),
      Q => \wtinstret_r__0\(5),
      R => '0'
    );
\wtinstret_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(6),
      Q => \wtinstret_r__0\(6),
      R => '0'
    );
\wtinstret_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(7),
      Q => \wtinstret_r__0\(7),
      R => '0'
    );
\wtinstret_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(8),
      Q => \wtinstret_r__0\(8),
      R => '0'
    );
\wtinstret_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(9),
      Q => \wtinstret_r__0\(9),
      R => '0'
    );
\wtinstreth_r[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => u_prints_n_0,
      I1 => state_r(2),
      I2 => state_r(0),
      I3 => rst_n,
      I4 => state_r(3),
      I5 => wait_counter_fin_w,
      O => \wtinstreth_r[31]_i_1_n_0\
    );
\wtinstreth_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(0),
      Q => \wtinstreth_r__0\(0),
      R => '0'
    );
\wtinstreth_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(10),
      Q => \wtinstreth_r__0\(10),
      R => '0'
    );
\wtinstreth_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(11),
      Q => \wtinstreth_r__0\(11),
      R => '0'
    );
\wtinstreth_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(12),
      Q => \wtinstreth_r__0\(12),
      R => '0'
    );
\wtinstreth_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(13),
      Q => \wtinstreth_r__0\(13),
      R => '0'
    );
\wtinstreth_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(14),
      Q => \wtinstreth_r__0\(14),
      R => '0'
    );
\wtinstreth_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(15),
      Q => \wtinstreth_r__0\(15),
      R => '0'
    );
\wtinstreth_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(16),
      Q => \wtinstreth_r__0\(16),
      R => '0'
    );
\wtinstreth_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(17),
      Q => \wtinstreth_r__0\(17),
      R => '0'
    );
\wtinstreth_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(18),
      Q => \wtinstreth_r__0\(18),
      R => '0'
    );
\wtinstreth_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(19),
      Q => \wtinstreth_r__0\(19),
      R => '0'
    );
\wtinstreth_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(1),
      Q => \wtinstreth_r__0\(1),
      R => '0'
    );
\wtinstreth_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(20),
      Q => \wtinstreth_r__0\(20),
      R => '0'
    );
\wtinstreth_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(21),
      Q => \wtinstreth_r__0\(21),
      R => '0'
    );
\wtinstreth_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(22),
      Q => \wtinstreth_r__0\(22),
      R => '0'
    );
\wtinstreth_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(23),
      Q => \wtinstreth_r__0\(23),
      R => '0'
    );
\wtinstreth_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(24),
      Q => \wtinstreth_r__0\(24),
      R => '0'
    );
\wtinstreth_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(25),
      Q => \wtinstreth_r__0\(25),
      R => '0'
    );
\wtinstreth_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(26),
      Q => \wtinstreth_r__0\(26),
      R => '0'
    );
\wtinstreth_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(27),
      Q => \wtinstreth_r__0\(27),
      R => '0'
    );
\wtinstreth_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(28),
      Q => \wtinstreth_r__0\(28),
      R => '0'
    );
\wtinstreth_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(29),
      Q => \wtinstreth_r__0\(29),
      R => '0'
    );
\wtinstreth_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(2),
      Q => \wtinstreth_r__0\(2),
      R => '0'
    );
\wtinstreth_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(30),
      Q => \wtinstreth_r__0\(30),
      R => '0'
    );
\wtinstreth_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(31),
      Q => \wtinstreth_r__0\(31),
      R => '0'
    );
\wtinstreth_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(3),
      Q => \wtinstreth_r__0\(3),
      R => '0'
    );
\wtinstreth_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(4),
      Q => \wtinstreth_r__0\(4),
      R => '0'
    );
\wtinstreth_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(5),
      Q => \wtinstreth_r__0\(5),
      R => '0'
    );
\wtinstreth_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(6),
      Q => \wtinstreth_r__0\(6),
      R => '0'
    );
\wtinstreth_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(7),
      Q => \wtinstreth_r__0\(7),
      R => '0'
    );
\wtinstreth_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(8),
      Q => \wtinstreth_r__0\(8),
      R => '0'
    );
\wtinstreth_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wtinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(9),
      Q => \wtinstreth_r__0\(9),
      R => '0'
    );
\wuinstret_r[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0800000000000000"
    )
        port map (
      I0 => u_prints_n_7,
      I1 => state_r(2),
      I2 => state_r(0),
      I3 => rst_n,
      I4 => state_r(3),
      I5 => wait_counter_fin_w,
      O => \wuinstret_r[31]_i_1_n_0\
    );
\wuinstret_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(0),
      Q => \wuinstret_r__0\(0),
      R => '0'
    );
\wuinstret_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(10),
      Q => \wuinstret_r__0\(10),
      R => '0'
    );
\wuinstret_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(11),
      Q => \wuinstret_r__0\(11),
      R => '0'
    );
\wuinstret_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(12),
      Q => \wuinstret_r__0\(12),
      R => '0'
    );
\wuinstret_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(13),
      Q => \wuinstret_r__0\(13),
      R => '0'
    );
\wuinstret_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(14),
      Q => \wuinstret_r__0\(14),
      R => '0'
    );
\wuinstret_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(15),
      Q => \wuinstret_r__0\(15),
      R => '0'
    );
\wuinstret_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(16),
      Q => \wuinstret_r__0\(16),
      R => '0'
    );
\wuinstret_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(17),
      Q => \wuinstret_r__0\(17),
      R => '0'
    );
\wuinstret_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(18),
      Q => \wuinstret_r__0\(18),
      R => '0'
    );
\wuinstret_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(19),
      Q => \wuinstret_r__0\(19),
      R => '0'
    );
\wuinstret_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(1),
      Q => \wuinstret_r__0\(1),
      R => '0'
    );
\wuinstret_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(20),
      Q => \wuinstret_r__0\(20),
      R => '0'
    );
\wuinstret_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(21),
      Q => \wuinstret_r__0\(21),
      R => '0'
    );
\wuinstret_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(22),
      Q => \wuinstret_r__0\(22),
      R => '0'
    );
\wuinstret_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(23),
      Q => \wuinstret_r__0\(23),
      R => '0'
    );
\wuinstret_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(24),
      Q => \wuinstret_r__0\(24),
      R => '0'
    );
\wuinstret_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(25),
      Q => \wuinstret_r__0\(25),
      R => '0'
    );
\wuinstret_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(26),
      Q => \wuinstret_r__0\(26),
      R => '0'
    );
\wuinstret_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(27),
      Q => \wuinstret_r__0\(27),
      R => '0'
    );
\wuinstret_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(28),
      Q => \wuinstret_r__0\(28),
      R => '0'
    );
\wuinstret_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(29),
      Q => \wuinstret_r__0\(29),
      R => '0'
    );
\wuinstret_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(2),
      Q => \wuinstret_r__0\(2),
      R => '0'
    );
\wuinstret_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(30),
      Q => \wuinstret_r__0\(30),
      R => '0'
    );
\wuinstret_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(31),
      Q => \wuinstret_r__0\(31),
      R => '0'
    );
\wuinstret_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(3),
      Q => \wuinstret_r__0\(3),
      R => '0'
    );
\wuinstret_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(4),
      Q => \wuinstret_r__0\(4),
      R => '0'
    );
\wuinstret_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(5),
      Q => \wuinstret_r__0\(5),
      R => '0'
    );
\wuinstret_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(6),
      Q => \wuinstret_r__0\(6),
      R => '0'
    );
\wuinstret_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(7),
      Q => \wuinstret_r__0\(7),
      R => '0'
    );
\wuinstret_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(8),
      Q => \wuinstret_r__0\(8),
      R => '0'
    );
\wuinstret_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstret_r[31]_i_1_n_0\,
      D => mem_dout_i(9),
      Q => \wuinstret_r__0\(9),
      R => '0'
    );
\wuinstreth_r[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => u_prints_n_7,
      I1 => state_r(2),
      I2 => state_r(0),
      I3 => rst_n,
      I4 => state_r(3),
      I5 => wait_counter_fin_w,
      O => \wuinstreth_r[31]_i_1_n_0\
    );
\wuinstreth_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(0),
      Q => \wuinstreth_r_reg_n_0_[0]\,
      R => '0'
    );
\wuinstreth_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(10),
      Q => \wuinstreth_r_reg_n_0_[10]\,
      R => '0'
    );
\wuinstreth_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(11),
      Q => \wuinstreth_r_reg_n_0_[11]\,
      R => '0'
    );
\wuinstreth_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(12),
      Q => \wuinstreth_r_reg_n_0_[12]\,
      R => '0'
    );
\wuinstreth_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(13),
      Q => \wuinstreth_r_reg_n_0_[13]\,
      R => '0'
    );
\wuinstreth_r_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(14),
      Q => \wuinstreth_r_reg_n_0_[14]\,
      R => '0'
    );
\wuinstreth_r_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(15),
      Q => \wuinstreth_r_reg_n_0_[15]\,
      R => '0'
    );
\wuinstreth_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(16),
      Q => \wuinstreth_r_reg_n_0_[16]\,
      R => '0'
    );
\wuinstreth_r_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(17),
      Q => \wuinstreth_r_reg_n_0_[17]\,
      R => '0'
    );
\wuinstreth_r_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(18),
      Q => \wuinstreth_r_reg_n_0_[18]\,
      R => '0'
    );
\wuinstreth_r_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(19),
      Q => \wuinstreth_r_reg_n_0_[19]\,
      R => '0'
    );
\wuinstreth_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(1),
      Q => \wuinstreth_r_reg_n_0_[1]\,
      R => '0'
    );
\wuinstreth_r_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(20),
      Q => \wuinstreth_r_reg_n_0_[20]\,
      R => '0'
    );
\wuinstreth_r_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(21),
      Q => \wuinstreth_r_reg_n_0_[21]\,
      R => '0'
    );
\wuinstreth_r_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(22),
      Q => \wuinstreth_r_reg_n_0_[22]\,
      R => '0'
    );
\wuinstreth_r_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(23),
      Q => \wuinstreth_r_reg_n_0_[23]\,
      R => '0'
    );
\wuinstreth_r_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(24),
      Q => \wuinstreth_r_reg_n_0_[24]\,
      R => '0'
    );
\wuinstreth_r_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(25),
      Q => \wuinstreth_r_reg_n_0_[25]\,
      R => '0'
    );
\wuinstreth_r_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(26),
      Q => \wuinstreth_r_reg_n_0_[26]\,
      R => '0'
    );
\wuinstreth_r_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(27),
      Q => \wuinstreth_r_reg_n_0_[27]\,
      R => '0'
    );
\wuinstreth_r_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(28),
      Q => \wuinstreth_r_reg_n_0_[28]\,
      R => '0'
    );
\wuinstreth_r_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(29),
      Q => \wuinstreth_r_reg_n_0_[29]\,
      R => '0'
    );
\wuinstreth_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(2),
      Q => \wuinstreth_r_reg_n_0_[2]\,
      R => '0'
    );
\wuinstreth_r_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(30),
      Q => \wuinstreth_r_reg_n_0_[30]\,
      R => '0'
    );
\wuinstreth_r_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(31),
      Q => \wuinstreth_r_reg_n_0_[31]\,
      R => '0'
    );
\wuinstreth_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(3),
      Q => \wuinstreth_r_reg_n_0_[3]\,
      R => '0'
    );
\wuinstreth_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(4),
      Q => \wuinstreth_r_reg_n_0_[4]\,
      R => '0'
    );
\wuinstreth_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(5),
      Q => \wuinstreth_r_reg_n_0_[5]\,
      R => '0'
    );
\wuinstreth_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(6),
      Q => \wuinstreth_r_reg_n_0_[6]\,
      R => '0'
    );
\wuinstreth_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(7),
      Q => \wuinstreth_r_reg_n_0_[7]\,
      R => '0'
    );
\wuinstreth_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(8),
      Q => \wuinstreth_r_reg_n_0_[8]\,
      R => '0'
    );
\wuinstreth_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \wuinstreth_r[31]_i_1_n_0\,
      D => mem_dout_i(9),
      Q => \wuinstreth_r_reg_n_0_[9]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity total_design_host_top_wrapper_0_0_host_top_wrapper is
  port (
    block_mem_addr_o : out STD_LOGIC_VECTOR ( 12 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 6 downto 0 );
    m_axi_bready : out STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    \FSM_sequential_state_r_reg[3]\ : out STD_LOGIC;
    ready_o : out STD_LOGIC;
    mem_din_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    simt_start_o : out STD_LOGIC;
    rst_n : in STD_LOGIC;
    mem_dout_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clk : in STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    start_i : in STD_LOGIC;
    simt_ready_i : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of total_design_host_top_wrapper_0_0_host_top_wrapper : entity is "host_top_wrapper";
end total_design_host_top_wrapper_0_0_host_top_wrapper;

architecture STRUCTURE of total_design_host_top_wrapper_0_0_host_top_wrapper is
begin
u_host_top: entity work.total_design_host_top_wrapper_0_0_host_top_new
     port map (
      \FSM_sequential_state_r_reg[3]_0\ => \FSM_sequential_state_r_reg[3]\,
      Q(12 downto 0) => block_mem_addr_o(12 downto 0),
      clk => clk,
      m_axi_arready => m_axi_arready,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      m_axi_bready => m_axi_bready,
      m_axi_bvalid => m_axi_bvalid,
      m_axi_rdata(0) => m_axi_rdata(0),
      m_axi_rready => m_axi_rready,
      m_axi_rvalid => m_axi_rvalid,
      m_axi_wdata(6 downto 0) => m_axi_wdata(6 downto 0),
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid,
      mem_din_o(7 downto 0) => mem_din_o(7 downto 0),
      mem_dout_i(31 downto 0) => mem_dout_i(31 downto 0),
      ready_o => ready_o,
      rst_n => rst_n,
      simt_ready_i => simt_ready_i,
      simt_start_o => simt_start_o,
      start_i => start_i
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity total_design_host_top_wrapper_0_0 is
  port (
    clk : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 6 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 6 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    mem_clk : out STD_LOGIC;
    mem_addr_o : out STD_LOGIC_VECTOR ( 12 downto 0 );
    mem_dout_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    mem_din_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    mem_we_o : out STD_LOGIC;
    start_i : in STD_LOGIC;
    ready_o : out STD_LOGIC;
    simt_start_o : out STD_LOGIC;
    simt_ready_i : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of total_design_host_top_wrapper_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of total_design_host_top_wrapper_0_0 : entity is "total_design_host_top_wrapper_0_0,host_top_wrapper,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of total_design_host_top_wrapper_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of total_design_host_top_wrapper_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of total_design_host_top_wrapper_0_0 : entity is "host_top_wrapper,Vivado 2025.2";
end total_design_host_top_wrapper_0_0;

architecture STRUCTURE of total_design_host_top_wrapper_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^clk\ : STD_LOGIC;
  signal \^m_axi_wdata\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \^mem_din_o\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF M_AXI, ASSOCIATED_RESET rst_n, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_arready : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARREADY";
  attribute X_INTERFACE_INFO of m_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARVALID";
  attribute X_INTERFACE_INFO of m_axi_awready : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWREADY";
  attribute X_INTERFACE_INFO of m_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWVALID";
  attribute X_INTERFACE_INFO of m_axi_bready : signal is "xilinx.com:interface:aximm:1.0 M_AXI BREADY";
  attribute X_INTERFACE_INFO of m_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 M_AXI BVALID";
  attribute X_INTERFACE_INFO of m_axi_rready : signal is "xilinx.com:interface:aximm:1.0 M_AXI RREADY";
  attribute X_INTERFACE_INFO of m_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 M_AXI RVALID";
  attribute X_INTERFACE_INFO of m_axi_wready : signal is "xilinx.com:interface:aximm:1.0 M_AXI WREADY";
  attribute X_INTERFACE_INFO of m_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 M_AXI WVALID";
  attribute X_INTERFACE_INFO of mem_clk : signal is "xilinx.com:interface:bram:1.0 MEM CLK";
  attribute X_INTERFACE_MODE of mem_clk : signal is "master";
  attribute X_INTERFACE_PARAMETER of mem_clk : signal is "XIL_INTERFACENAME MEM, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1";
  attribute X_INTERFACE_INFO of mem_we_o : signal is "xilinx.com:interface:bram:1.0 MEM WE";
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_MODE of rst_n : signal is "slave";
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARADDR";
  attribute X_INTERFACE_INFO of m_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARPROT";
  attribute X_INTERFACE_INFO of m_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWADDR";
  attribute X_INTERFACE_MODE of m_axi_awaddr : signal is "master";
  attribute X_INTERFACE_PARAMETER of m_axi_awaddr : signal is "XIL_INTERFACENAME M_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 7, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWPROT";
  attribute X_INTERFACE_INFO of m_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 M_AXI BRESP";
  attribute X_INTERFACE_INFO of m_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 M_AXI RDATA";
  attribute X_INTERFACE_INFO of m_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 M_AXI RRESP";
  attribute X_INTERFACE_INFO of m_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 M_AXI WDATA";
  attribute X_INTERFACE_INFO of m_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 M_AXI WSTRB";
  attribute X_INTERFACE_INFO of mem_addr_o : signal is "xilinx.com:interface:bram:1.0 MEM ADDR";
  attribute X_INTERFACE_INFO of mem_din_o : signal is "xilinx.com:interface:bram:1.0 MEM DIN";
  attribute X_INTERFACE_INFO of mem_dout_i : signal is "xilinx.com:interface:bram:1.0 MEM DOUT";
begin
  \^clk\ <= clk;
  m_axi_araddr(6) <= \<const0>\;
  m_axi_araddr(5) <= \<const0>\;
  m_axi_araddr(4) <= \<const0>\;
  m_axi_araddr(3) <= \<const1>\;
  m_axi_araddr(2) <= \<const0>\;
  m_axi_araddr(1) <= \<const0>\;
  m_axi_araddr(0) <= \<const0>\;
  m_axi_arprot(2) <= \<const0>\;
  m_axi_arprot(1) <= \<const0>\;
  m_axi_arprot(0) <= \<const0>\;
  m_axi_awaddr(6) <= \<const0>\;
  m_axi_awaddr(5) <= \<const0>\;
  m_axi_awaddr(4) <= \<const0>\;
  m_axi_awaddr(3) <= \<const0>\;
  m_axi_awaddr(2) <= \<const1>\;
  m_axi_awaddr(1) <= \<const0>\;
  m_axi_awaddr(0) <= \<const0>\;
  m_axi_awprot(2) <= \<const0>\;
  m_axi_awprot(1) <= \<const0>\;
  m_axi_awprot(0) <= \<const0>\;
  m_axi_wdata(31) <= \<const0>\;
  m_axi_wdata(30) <= \<const0>\;
  m_axi_wdata(29) <= \<const0>\;
  m_axi_wdata(28) <= \<const0>\;
  m_axi_wdata(27) <= \<const0>\;
  m_axi_wdata(26) <= \<const0>\;
  m_axi_wdata(25) <= \<const0>\;
  m_axi_wdata(24) <= \<const0>\;
  m_axi_wdata(23) <= \<const0>\;
  m_axi_wdata(22) <= \<const0>\;
  m_axi_wdata(21) <= \<const0>\;
  m_axi_wdata(20) <= \<const0>\;
  m_axi_wdata(19) <= \<const0>\;
  m_axi_wdata(18) <= \<const0>\;
  m_axi_wdata(17) <= \<const0>\;
  m_axi_wdata(16) <= \<const0>\;
  m_axi_wdata(15) <= \<const0>\;
  m_axi_wdata(14) <= \<const0>\;
  m_axi_wdata(13) <= \<const0>\;
  m_axi_wdata(12) <= \<const0>\;
  m_axi_wdata(11) <= \<const0>\;
  m_axi_wdata(10) <= \<const0>\;
  m_axi_wdata(9) <= \<const0>\;
  m_axi_wdata(8) <= \<const0>\;
  m_axi_wdata(7) <= \<const0>\;
  m_axi_wdata(6 downto 0) <= \^m_axi_wdata\(6 downto 0);
  m_axi_wstrb(3) <= \<const1>\;
  m_axi_wstrb(2) <= \<const1>\;
  m_axi_wstrb(1) <= \<const1>\;
  m_axi_wstrb(0) <= \<const1>\;
  mem_clk <= \^clk\;
  mem_din_o(31) <= \^mem_din_o\(7);
  mem_din_o(30) <= \^mem_din_o\(7);
  mem_din_o(29) <= \^mem_din_o\(7);
  mem_din_o(28) <= \^mem_din_o\(7);
  mem_din_o(27) <= \^mem_din_o\(7);
  mem_din_o(26) <= \^mem_din_o\(7);
  mem_din_o(25) <= \^mem_din_o\(7);
  mem_din_o(24) <= \^mem_din_o\(7);
  mem_din_o(23) <= \^mem_din_o\(7);
  mem_din_o(22) <= \^mem_din_o\(7);
  mem_din_o(21) <= \^mem_din_o\(7);
  mem_din_o(20) <= \^mem_din_o\(7);
  mem_din_o(19) <= \^mem_din_o\(7);
  mem_din_o(18) <= \^mem_din_o\(7);
  mem_din_o(17) <= \^mem_din_o\(7);
  mem_din_o(16) <= \^mem_din_o\(7);
  mem_din_o(15) <= \^mem_din_o\(7);
  mem_din_o(14) <= \^mem_din_o\(7);
  mem_din_o(13) <= \^mem_din_o\(7);
  mem_din_o(12) <= \^mem_din_o\(7);
  mem_din_o(11) <= \^mem_din_o\(7);
  mem_din_o(10) <= \^mem_din_o\(7);
  mem_din_o(9) <= \^mem_din_o\(7);
  mem_din_o(8) <= \^mem_din_o\(7);
  mem_din_o(7 downto 0) <= \^mem_din_o\(7 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.total_design_host_top_wrapper_0_0_host_top_wrapper
     port map (
      \FSM_sequential_state_r_reg[3]\ => mem_we_o,
      block_mem_addr_o(12 downto 0) => mem_addr_o(12 downto 0),
      clk => \^clk\,
      m_axi_arready => m_axi_arready,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      m_axi_bready => m_axi_bready,
      m_axi_bvalid => m_axi_bvalid,
      m_axi_rdata(0) => m_axi_rdata(3),
      m_axi_rready => m_axi_rready,
      m_axi_rvalid => m_axi_rvalid,
      m_axi_wdata(6 downto 0) => \^m_axi_wdata\(6 downto 0),
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid,
      mem_din_o(7 downto 0) => \^mem_din_o\(7 downto 0),
      mem_dout_i(31 downto 0) => mem_dout_i(31 downto 0),
      ready_o => ready_o,
      rst_n => rst_n,
      simt_ready_i => simt_ready_i,
      simt_start_o => simt_start_o,
      start_i => start_i
    );
end STRUCTURE;
