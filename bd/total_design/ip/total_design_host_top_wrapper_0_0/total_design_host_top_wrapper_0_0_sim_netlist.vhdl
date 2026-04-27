-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
-- Date        : Mon Apr 27 11:54:50 2026
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
entity total_design_host_top_wrapper_0_0_memdump is
  port (
    prints_start_w : out STD_LOGIC;
    \addr_r_reg[13]_0\ : out STD_LOGIC_VECTOR ( 13 downto 0 );
    \FSM_sequential_state_r_reg[1]_0\ : out STD_LOGIC;
    rst_n : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    D : in STD_LOGIC_VECTOR ( 0 to 0 );
    prints_ready_w : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of total_design_host_top_wrapper_0_0_memdump : entity is "memdump";
end total_design_host_top_wrapper_0_0_memdump;

architecture STRUCTURE of total_design_host_top_wrapper_0_0_memdump is
  signal \FSM_sequential_state_r[0]_i_1__0_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[1]_i_1__0_n_0\ : STD_LOGIC;
  signal \addr_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[13]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r[13]_i_2_n_0\ : STD_LOGIC;
  signal \addr_r_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \addr_r_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \addr_r_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \^addr_r_reg[13]_0\ : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal \addr_r_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \addr_r_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \addr_r_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \addr_r_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \addr_r_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \addr_r_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \addr_r_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal in6 : STD_LOGIC_VECTOR ( 13 downto 1 );
  signal state_r : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal state_r1 : STD_LOGIC;
  signal \state_r1_carry_i_1__0_n_0\ : STD_LOGIC;
  signal state_r1_carry_i_1_n_0 : STD_LOGIC;
  signal state_r1_carry_i_2_n_0 : STD_LOGIC;
  signal state_r1_carry_i_3_n_0 : STD_LOGIC;
  signal state_r1_carry_i_4_n_0 : STD_LOGIC;
  signal state_r1_carry_n_0 : STD_LOGIC;
  signal state_r1_carry_n_1 : STD_LOGIC;
  signal state_r1_carry_n_2 : STD_LOGIC;
  signal state_r1_carry_n_3 : STD_LOGIC;
  signal wait_counter_fin_w : STD_LOGIC;
  signal wait_counter_next_w : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \wait_counter_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \wait_counter_r[1]_i_1_n_0\ : STD_LOGIC;
  signal \NLW_addr_r_reg[13]_i_3_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_addr_r_reg[13]_i_3_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_state_r1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_state_r1_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_state_r1_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_state_r[0]_i_4\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[1]_i_1__0\ : label is "soft_lutpair0";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[0]\ : label is "S_PRINT:10,S_NEXT:11,S_IDLE:00,S_MEMREAD:01";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[1]\ : label is "S_PRINT:10,S_NEXT:11,S_IDLE:00,S_MEMREAD:01";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \addr_r_reg[12]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \addr_r_reg[13]_i_3\ : label is 35;
  attribute ADDER_THRESHOLD of \addr_r_reg[4]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \addr_r_reg[8]_i_1\ : label is 35;
begin
  \addr_r_reg[13]_0\(13 downto 0) <= \^addr_r_reg[13]_0\(13 downto 0);
\FSM_onehot_state_r[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1110"
    )
        port map (
      I0 => state_r(1),
      I1 => state_r(0),
      I2 => Q(1),
      I3 => Q(2),
      O => \FSM_sequential_state_r_reg[1]_0\
    );
\FSM_sequential_state_r[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5050FC0C5F5FFC0C"
    )
        port map (
      I0 => state_r1,
      I1 => Q(1),
      I2 => state_r(1),
      I3 => prints_ready_w,
      I4 => state_r(0),
      I5 => wait_counter_fin_w,
      O => \FSM_sequential_state_r[0]_i_1__0_n_0\
    );
\FSM_sequential_state_r[1]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"62"
    )
        port map (
      I0 => state_r(1),
      I1 => state_r(0),
      I2 => wait_counter_fin_w,
      O => \FSM_sequential_state_r[1]_i_1__0_n_0\
    );
\FSM_sequential_state_r[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAFEFAFAFAFAFAFA"
    )
        port map (
      I0 => Q(0),
      I1 => D(0),
      I2 => Q(3),
      I3 => state_r(1),
      I4 => state_r(0),
      I5 => wait_counter_fin_w,
      O => prints_start_w
    );
\FSM_sequential_state_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \FSM_sequential_state_r[0]_i_1__0_n_0\,
      Q => state_r(0),
      R => SR(0)
    );
\FSM_sequential_state_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \FSM_sequential_state_r[1]_i_1__0_n_0\,
      Q => state_r(1),
      R => SR(0)
    );
\addr_r[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^addr_r_reg[13]_0\(0),
      O => \addr_r[0]_i_1_n_0\
    );
\addr_r[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => rst_n,
      I1 => state_r(0),
      I2 => Q(1),
      I3 => state_r(1),
      O => \addr_r[13]_i_1_n_0\
    );
\addr_r[13]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A400"
    )
        port map (
      I0 => state_r(1),
      I1 => Q(1),
      I2 => state_r(0),
      I3 => rst_n,
      O => \addr_r[13]_i_2_n_0\
    );
\addr_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => \addr_r[0]_i_1_n_0\,
      Q => \^addr_r_reg[13]_0\(0),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(10),
      Q => \^addr_r_reg[13]_0\(10),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(11),
      Q => \^addr_r_reg[13]_0\(11),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(12),
      Q => \^addr_r_reg[13]_0\(12),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_r_reg[8]_i_1_n_0\,
      CO(3) => \addr_r_reg[12]_i_1_n_0\,
      CO(2) => \addr_r_reg[12]_i_1_n_1\,
      CO(1) => \addr_r_reg[12]_i_1_n_2\,
      CO(0) => \addr_r_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in6(12 downto 9),
      S(3 downto 0) => \^addr_r_reg[13]_0\(12 downto 9)
    );
\addr_r_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(13),
      Q => \^addr_r_reg[13]_0\(13),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[13]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_r_reg[12]_i_1_n_0\,
      CO(3 downto 0) => \NLW_addr_r_reg[13]_i_3_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_addr_r_reg[13]_i_3_O_UNCONNECTED\(3 downto 1),
      O(0) => in6(13),
      S(3 downto 1) => B"000",
      S(0) => \^addr_r_reg[13]_0\(13)
    );
\addr_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(1),
      Q => \^addr_r_reg[13]_0\(1),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(2),
      Q => \^addr_r_reg[13]_0\(2),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(3),
      Q => \^addr_r_reg[13]_0\(3),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(4),
      Q => \^addr_r_reg[13]_0\(4),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \addr_r_reg[4]_i_1_n_0\,
      CO(2) => \addr_r_reg[4]_i_1_n_1\,
      CO(1) => \addr_r_reg[4]_i_1_n_2\,
      CO(0) => \addr_r_reg[4]_i_1_n_3\,
      CYINIT => \^addr_r_reg[13]_0\(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in6(4 downto 1),
      S(3 downto 0) => \^addr_r_reg[13]_0\(4 downto 1)
    );
\addr_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(5),
      Q => \^addr_r_reg[13]_0\(5),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(6),
      Q => \^addr_r_reg[13]_0\(6),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(7),
      Q => \^addr_r_reg[13]_0\(7),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(8),
      Q => \^addr_r_reg[13]_0\(8),
      R => \addr_r[13]_i_1_n_0\
    );
\addr_r_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_r_reg[4]_i_1_n_0\,
      CO(3) => \addr_r_reg[8]_i_1_n_0\,
      CO(2) => \addr_r_reg[8]_i_1_n_1\,
      CO(1) => \addr_r_reg[8]_i_1_n_2\,
      CO(0) => \addr_r_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => in6(8 downto 5),
      S(3 downto 0) => \^addr_r_reg[13]_0\(8 downto 5)
    );
\addr_r_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \addr_r[13]_i_2_n_0\,
      D => in6(9),
      Q => \^addr_r_reg[13]_0\(9),
      R => \addr_r[13]_i_1_n_0\
    );
state_r1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => state_r1_carry_n_0,
      CO(2) => state_r1_carry_n_1,
      CO(1) => state_r1_carry_n_2,
      CO(0) => state_r1_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_state_r1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => state_r1_carry_i_1_n_0,
      S(2) => state_r1_carry_i_2_n_0,
      S(1) => state_r1_carry_i_3_n_0,
      S(0) => state_r1_carry_i_4_n_0
    );
\state_r1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => state_r1_carry_n_0,
      CO(3 downto 1) => \NLW_state_r1_carry__0_CO_UNCONNECTED\(3 downto 1),
      CO(0) => state_r1,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_state_r1_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3 downto 1) => B"000",
      S(0) => \state_r1_carry_i_1__0_n_0\
    );
state_r1_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \^addr_r_reg[13]_0\(11),
      I1 => \^addr_r_reg[13]_0\(10),
      I2 => \^addr_r_reg[13]_0\(9),
      O => state_r1_carry_i_1_n_0
    );
\state_r1_carry_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^addr_r_reg[13]_0\(13),
      I1 => \^addr_r_reg[13]_0\(12),
      O => \state_r1_carry_i_1__0_n_0\
    );
state_r1_carry_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \^addr_r_reg[13]_0\(8),
      I1 => \^addr_r_reg[13]_0\(7),
      I2 => \^addr_r_reg[13]_0\(6),
      O => state_r1_carry_i_2_n_0
    );
state_r1_carry_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
        port map (
      I0 => \^addr_r_reg[13]_0\(5),
      I1 => \^addr_r_reg[13]_0\(4),
      I2 => \^addr_r_reg[13]_0\(3),
      O => state_r1_carry_i_3_n_0
    );
state_r1_carry_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \^addr_r_reg[13]_0\(2),
      I1 => \^addr_r_reg[13]_0\(1),
      I2 => \^addr_r_reg[13]_0\(0),
      O => state_r1_carry_i_4_n_0
    );
\wait_counter_r[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"5BFF0A00"
    )
        port map (
      I0 => state_r(0),
      I1 => Q(1),
      I2 => state_r(1),
      I3 => rst_n,
      I4 => wait_counter_next_w(1),
      O => \wait_counter_r[0]_i_1_n_0\
    );
\wait_counter_r[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"338BFFFF00880000"
    )
        port map (
      I0 => wait_counter_next_w(1),
      I1 => state_r(0),
      I2 => Q(1),
      I3 => state_r(1),
      I4 => rst_n,
      I5 => wait_counter_fin_w,
      O => \wait_counter_r[1]_i_1_n_0\
    );
\wait_counter_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \wait_counter_r[0]_i_1_n_0\,
      Q => wait_counter_next_w(1),
      R => '0'
    );
\wait_counter_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \wait_counter_r[1]_i_1_n_0\,
      Q => wait_counter_fin_w,
      R => '0'
    );
end STRUCTURE;
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
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    rst_n_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    SS : out STD_LOGIC_VECTOR ( 0 to 0 );
    \FSM_sequential_state_r_reg[0]_0\ : out STD_LOGIC;
    \FSM_sequential_state_r_reg[1]\ : out STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    state_r : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    prints_start_w : in STD_LOGIC;
    hex_digit_idx_c_w : in STD_LOGIC;
    \FSM_sequential_state_r_reg[1]_0\ : in STD_LOGIC;
    \char_idx_r_reg[0]\ : in STD_LOGIC;
    \char_idx_r_reg[0]_0\ : in STD_LOGIC;
    \char_idx_r_reg[0]_1\ : in STD_LOGIC;
    \char_idx_r_reg[0]_2\ : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    \FSM_sequential_state_r_reg[0]_1\ : in STD_LOGIC;
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
  attribute SOFT_HLUTNM of \FSM_onehot_state_r[1]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \FSM_onehot_state_r[3]_i_1\ : label is "soft_lutpair3";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[0]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[1]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[2]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[3]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[4]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[5]\ : label is "S_IDLE:000001,S_CHECK_STAT:000100,S_WRITE_TX:010000,S_WAIT_BRESP:100000,S_SETUP_TX:001000,S_SETUP_STAT:000010";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \char_r[6]_i_1__0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \hex_digit_idx_r[2]_i_4\ : label is "soft_lutpair1";
begin
  SS(0) <= \^ss\(0);
  m_axi_arvalid <= \^m_axi_arvalid\;
  m_axi_awvalid <= \^m_axi_awvalid\;
  m_axi_bready <= \^m_axi_bready\;
  m_axi_rready <= \^m_axi_rready\;
  m_axi_wvalid <= \^m_axi_wvalid\;
\FSM_onehot_state_r[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst_n,
      O => \^ss\(0)
    );
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
      I1 => \FSM_sequential_state_r_reg[1]_0\,
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
      I1 => \FSM_sequential_state_r_reg[1]_0\,
      I2 => \FSM_sequential_state_r[1]_i_3_n_0\,
      I3 => state_r(1),
      O => \FSM_sequential_state_r_reg[0]_0\
    );
\FSM_sequential_state_r[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0FFC0AA"
    )
        port map (
      I0 => prints_start_w,
      I1 => hex_digit_idx_c_w,
      I2 => c_ready_w,
      I3 => state_r(1),
      I4 => state_r(0),
      O => \FSM_sequential_state_r[1]_i_3_n_0\
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
\char_idx_r[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA08"
    )
        port map (
      I0 => rst_n,
      I1 => \FSM_sequential_state_r_reg[1]_0\,
      I2 => \char_idx_r_reg[0]\,
      I3 => \char_idx_r[5]_i_4_n_0\,
      O => rst_n_0(0)
    );
\char_idx_r[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000100FFFF"
    )
        port map (
      I0 => \char_idx_r_reg[0]_0\,
      I1 => \char_idx_r_reg[0]_1\,
      I2 => \char_idx_r_reg[0]_2\,
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
      I1 => \FSM_sequential_state_r_reg[1]_0\,
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
\hex_digit_idx_r[2]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4404"
    )
        port map (
      I0 => state_r(0),
      I1 => rst_n,
      I2 => state_r(1),
      I3 => c_ready_w,
      O => \FSM_sequential_state_r_reg[0]\
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
    m_axi_awvalid : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    prints_ready_w : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    prints_start_w : in STD_LOGIC;
    \FSM_onehot_state_r_reg[0]\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 8 downto 0 );
    simt_ready_i : in STD_LOGIC;
    start_i : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    mem_addr_o : in STD_LOGIC_VECTOR ( 13 downto 0 );
    mem_dout_i : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of total_design_host_top_wrapper_0_0_prints : entity is "prints";
end total_design_host_top_wrapper_0_0_prints;

architecture STRUCTURE of total_design_host_top_wrapper_0_0_prints is
  signal \^d\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \FSM_onehot_state_r[0]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[0]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_r[1]_i_4_n_0\ : STD_LOGIC;
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal char_idx_r : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \char_idx_r[5]_i_3_n_0\ : STD_LOGIC;
  signal \char_idx_r[5]_i_5_n_0\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[0]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[1]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[2]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[3]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[4]\ : STD_LOGIC;
  signal \char_idx_r_reg_n_0_[5]\ : STD_LOGIC;
  signal char_r0_in : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \char_r[0]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[0]_i_8_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[1]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_10_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_11_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_12_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_13_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_8_n_0\ : STD_LOGIC;
  signal \char_r[2]_i_9_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[3]_i_7_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[4]_i_6_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_2_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[5]_i_5_n_0\ : STD_LOGIC;
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
  signal \char_r[6]_i_3_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_4_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_5_n_0\ : STD_LOGIC;
  signal \char_r[6]_i_6_n_0\ : STD_LOGIC;
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
  signal data2 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data27 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data28 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data32 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal data33 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal data35 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal data36 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal hex_digit_idx_c_w : STD_LOGIC;
  signal hex_digit_idx_r : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \hex_digit_idx_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \hex_digit_idx_r[1]_i_1_n_0\ : STD_LOGIC;
  signal \hex_digit_idx_r[2]_i_1_n_0\ : STD_LOGIC;
  signal \hex_digit_idx_r[2]_i_3_n_0\ : STD_LOGIC;
  signal \hex_digit_idx_r_reg_n_0_[0]\ : STD_LOGIC;
  signal \hex_digit_idx_r_reg_n_0_[1]\ : STD_LOGIC;
  signal \hex_digit_idx_r_reg_n_0_[2]\ : STD_LOGIC;
  signal \hex_r_reg[1]\ : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal \hex_r_reg[2]\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^prints_ready_w\ : STD_LOGIC;
  signal state_r : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \string_r[216]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[256]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[283]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[288]_i_1_n_0\ : STD_LOGIC;
  signal \string_r[288]_i_2_n_0\ : STD_LOGIC;
  signal u_printc_n_10 : STD_LOGIC;
  signal u_printc_n_5 : STD_LOGIC;
  signal u_printc_n_6 : STD_LOGIC;
  signal u_printc_n_7 : STD_LOGIC;
  signal u_printc_n_9 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[0]_i_2\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[0]_i_2__0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[0]_i_3\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[1]_i_4\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \FSM_sequential_state_r[1]_i_6\ : label is "soft_lutpair15";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[0]\ : label is "S_READ_CHAR:01,S_IDLE:00,S_WRITE_CHAR:11,S_WRITE_HEX:10";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_r_reg[1]\ : label is "S_READ_CHAR:01,S_IDLE:00,S_WRITE_CHAR:11,S_WRITE_HEX:10";
  attribute SOFT_HLUTNM of \char_idx_r[0]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \char_idx_r[1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \char_idx_r[2]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \char_idx_r[5]_i_3\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \char_r[0]_i_4\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \char_r[0]_i_8\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \char_r[2]_i_9\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \char_r[3]_i_3\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \char_r[3]_i_4\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \char_r[4]_i_5\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \char_r[4]_i_6\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \char_r[5]_i_3\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \char_r[6]_i_23\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \char_r[6]_i_31\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \char_r[6]_i_34\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \char_r[6]_i_35\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \hex_digit_idx_r[0]_i_2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \hex_digit_idx_r[1]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \hex_digit_idx_r[2]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \string_r[256]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \string_r[265]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \string_r[283]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \string_r[288]_i_2\ : label is "soft_lutpair11";
begin
  D(0) <= \^d\(0);
  SR(0) <= \^sr\(0);
  prints_ready_w <= \^prints_ready_w\;
\FSM_onehot_state_r[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEEEFEEEFEEE"
    )
        port map (
      I0 => \FSM_onehot_state_r[0]_i_3_n_0\,
      I1 => \FSM_onehot_state_r_reg[0]\,
      I2 => Q(1),
      I3 => simt_ready_i,
      I4 => Q(0),
      I5 => start_i,
      O => E(0)
    );
\FSM_onehot_state_r[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF8888FFF88888"
    )
        port map (
      I0 => Q(4),
      I1 => simt_ready_i,
      I2 => Q(8),
      I3 => \string_r[216]_i_1_n_0\,
      I4 => \^prints_ready_w\,
      I5 => Q(3),
      O => \FSM_onehot_state_r[0]_i_3_n_0\
    );
\FSM_sequential_state_r[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"07"
    )
        port map (
      I0 => \char_r[1]_i_2_n_0\,
      I1 => \char_r[0]_i_2_n_0\,
      I2 => \FSM_sequential_state_r[0]_i_3_n_0\,
      O => \FSM_sequential_state_r[0]_i_2_n_0\
    );
\FSM_sequential_state_r[0]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => state_r(0),
      I1 => state_r(1),
      O => \^prints_ready_w\
    );
\FSM_sequential_state_r[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \char_r[6]_i_6_n_0\,
      I1 => \char_r[2]_i_3_n_0\,
      I2 => \char_r[3]_i_2_n_0\,
      I3 => \char_r[5]_i_2_n_0\,
      I4 => \char_r[4]_i_2_n_0\,
      O => \FSM_sequential_state_r[0]_i_3_n_0\
    );
\FSM_sequential_state_r[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \FSM_sequential_state_r[1]_i_4_n_0\,
      I1 => \char_r[0]_i_2_n_0\,
      I2 => \char_r[1]_i_2_n_0\,
      O => \FSM_sequential_state_r[1]_i_2_n_0\
    );
\FSM_sequential_state_r[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \char_r[3]_i_2_n_0\,
      I1 => \char_r[5]_i_2_n_0\,
      I2 => \char_r[4]_i_2_n_0\,
      I3 => \char_r[6]_i_6_n_0\,
      I4 => \char_r[2]_i_3_n_0\,
      O => \FSM_sequential_state_r[1]_i_4_n_0\
    );
\FSM_sequential_state_r[1]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \hex_digit_idx_r_reg_n_0_[1]\,
      I1 => \hex_digit_idx_r_reg_n_0_[0]\,
      I2 => \hex_digit_idx_r_reg_n_0_[2]\,
      O => hex_digit_idx_c_w
    );
\FSM_sequential_state_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_printc_n_10,
      Q => state_r(0),
      R => \^sr\(0)
    );
\FSM_sequential_state_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => u_printc_n_9,
      Q => state_r(1),
      R => \^sr\(0)
    );
\char_idx_r[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => state_r(1),
      I2 => state_r(0),
      O => char_idx_r(0)
    );
\char_idx_r[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E00E"
    )
        port map (
      I0 => state_r(0),
      I1 => state_r(1),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      O => char_idx_r(1)
    );
\char_idx_r[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A9A9A9FF"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[2]\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => state_r(1),
      I4 => state_r(0),
      O => char_idx_r(2)
    );
\char_idx_r[3]_i_1\: unisim.vcomponents.LUT6
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
\char_idx_r[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFE00000001"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[2]\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \^prints_ready_w\,
      I5 => \char_idx_r_reg_n_0_[4]\,
      O => char_idx_r(4)
    );
\char_idx_r[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFAAAAAAA9"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[5]\,
      I1 => \char_idx_r_reg_n_0_[3]\,
      I2 => \char_idx_r[5]_i_5_n_0\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => \char_idx_r_reg_n_0_[4]\,
      I5 => \^prints_ready_w\,
      O => char_idx_r(5)
    );
\char_idx_r[5]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF15"
    )
        port map (
      I0 => \FSM_sequential_state_r[0]_i_3_n_0\,
      I1 => \char_r[0]_i_2_n_0\,
      I2 => \char_r[1]_i_2_n_0\,
      I3 => state_r(1),
      O => \char_idx_r[5]_i_3_n_0\
    );
\char_idx_r[5]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[1]\,
      I1 => \char_idx_r_reg_n_0_[0]\,
      O => \char_idx_r[5]_i_5_n_0\
    );
\char_idx_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_7,
      D => char_idx_r(0),
      Q => \char_idx_r_reg_n_0_[0]\,
      R => '0'
    );
\char_idx_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_7,
      D => char_idx_r(1),
      Q => \char_idx_r_reg_n_0_[1]\,
      R => '0'
    );
\char_idx_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_7,
      D => char_idx_r(2),
      Q => \char_idx_r_reg_n_0_[2]\,
      R => '0'
    );
\char_idx_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_7,
      D => char_idx_r(3),
      Q => \char_idx_r_reg_n_0_[3]\,
      R => '0'
    );
\char_idx_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_7,
      D => char_idx_r(4),
      Q => \char_idx_r_reg_n_0_[4]\,
      R => '0'
    );
\char_idx_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_7,
      D => char_idx_r(5),
      Q => \char_idx_r_reg_n_0_[5]\,
      R => '0'
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
      I4 => \char_idx_r[5]_i_3_n_0\,
      I5 => \char_r[0]_i_2_n_0\,
      O => char_r0_in(0)
    );
\char_r[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF62404040"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[5]\,
      I1 => \char_idx_r_reg_n_0_[4]\,
      I2 => \char_r[0]_i_3_n_0\,
      I3 => \char_r[0]_i_4_n_0\,
      I4 => \char_r[4]_i_6_n_0\,
      I5 => \char_r[0]_i_5_n_0\,
      O => \char_r[0]_i_2_n_0\
    );
\char_r[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFC0C40000C0C4"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => data2(0),
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_r[0]_i_6_n_0\,
      O => \char_r[0]_i_3_n_0\
    );
\char_r[0]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => data36(0),
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[0]_i_4_n_0\
    );
\char_r[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000202FF00"
    )
        port map (
      I0 => \char_r[0]_i_7_n_0\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_idx_r_reg_n_0_[3]\,
      I3 => \char_r[0]_i_8_n_0\,
      I4 => \char_idx_r_reg_n_0_[5]\,
      I5 => \char_idx_r_reg_n_0_[4]\,
      O => \char_r[0]_i_5_n_0\
    );
\char_r[0]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00BB883000888830"
    )
        port map (
      I0 => data27(0),
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => data2(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[2]\,
      I5 => data28(0),
      O => \char_r[0]_i_6_n_0\
    );
\char_r[0]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FACF0ACFFAC00AC0"
    )
        port map (
      I0 => data2(0),
      I1 => data28(0),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => data27(0),
      I5 => data32(0),
      O => \char_r[0]_i_7_n_0\
    );
\char_r[0]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08228020"
    )
        port map (
      I0 => data2(0),
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      O => \char_r[0]_i_8_n_0\
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
      I4 => \char_idx_r[5]_i_3_n_0\,
      I5 => \char_r[1]_i_2_n_0\,
      O => char_r0_in(1)
    );
\char_r[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"333030303030B8B8"
    )
        port map (
      I0 => \char_r[1]_i_3_n_0\,
      I1 => \char_idx_r_reg_n_0_[5]\,
      I2 => \char_r[1]_i_4_n_0\,
      I3 => \char_r[1]_i_5_n_0\,
      I4 => \char_idx_r_reg_n_0_[4]\,
      I5 => \char_idx_r_reg_n_0_[3]\,
      O => \char_r[1]_i_2_n_0\
    );
\char_r[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0C0C0A0A0C0CFA0A"
    )
        port map (
      I0 => data28(0),
      I1 => data33(1),
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => data27(0),
      I4 => \char_idx_r_reg_n_0_[0]\,
      I5 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[1]_i_3_n_0\
    );
\char_r[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"004040444040C8C0"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[4]\,
      I1 => data2(0),
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[1]_i_4_n_0\
    );
\char_r[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FC300000E2E2F0F0"
    )
        port map (
      I0 => data27(0),
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => data2(0),
      I3 => data36(0),
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => \char_idx_r_reg_n_0_[0]\,
      O => \char_r[1]_i_5_n_0\
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
      I4 => \char_idx_r[5]_i_3_n_0\,
      I5 => \char_r[2]_i_3_n_0\,
      O => char_r0_in(2)
    );
\char_r[2]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"20AA202220882000"
    )
        port map (
      I0 => \char_r[6]_i_23_n_0\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => data2(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data28(0),
      I5 => data33(1),
      O => \char_r[2]_i_10_n_0\
    );
\char_r[2]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A0A0A000C0C0C00"
    )
        port map (
      I0 => \hex_r_reg[1]\(4),
      I1 => \hex_r_reg[1]\(0),
      I2 => \char_r[1]_i_2_n_0\,
      I3 => \char_r[6]_i_33_n_0\,
      I4 => \char_r[0]_i_5_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[2]_i_11_n_0\
    );
\char_r[2]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A0A0A000C0C0C00"
    )
        port map (
      I0 => \hex_r_reg[1]\(12),
      I1 => \hex_r_reg[1]\(8),
      I2 => \char_r[1]_i_2_n_0\,
      I3 => \char_r[6]_i_33_n_0\,
      I4 => \char_r[0]_i_5_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[2]_i_12_n_0\
    );
\char_r[2]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFF0C0A0A000C0A0"
    )
        port map (
      I0 => data2(0),
      I1 => data28(0),
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data27(0),
      O => \char_r[2]_i_13_n_0\
    );
\char_r[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFE4FFE4FFE400E4"
    )
        port map (
      I0 => \hex_digit_idx_r_reg_n_0_[1]\,
      I1 => \char_r[2]_i_4_n_0\,
      I2 => \char_r[2]_i_5_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[2]\,
      I4 => \char_r[2]_i_6_n_0\,
      I5 => \char_r[2]_i_7_n_0\,
      O => \char_r[2]_i_2_n_0\
    );
\char_r[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFCCEFCCEC"
    )
        port map (
      I0 => \char_r[2]_i_8_n_0\,
      I1 => \char_r[6]_i_21_n_0\,
      I2 => \char_idx_r_reg_n_0_[4]\,
      I3 => \char_idx_r_reg_n_0_[5]\,
      I4 => \char_r[2]_i_9_n_0\,
      I5 => \char_r[2]_i_10_n_0\,
      O => \char_r[2]_i_3_n_0\
    );
\char_r[2]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF888"
    )
        port map (
      I0 => \char_r[6]_i_24_n_0\,
      I1 => \hex_r_reg[2]\(0),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_r_reg[2]\(4),
      I4 => \char_r[2]_i_11_n_0\,
      O => \char_r[2]_i_4_n_0\
    );
\char_r[2]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF888"
    )
        port map (
      I0 => \char_r[6]_i_24_n_0\,
      I1 => \hex_r_reg[2]\(8),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_r_reg[2]\(12),
      I4 => \char_r[2]_i_12_n_0\,
      O => \char_r[2]_i_5_n_0\
    );
\char_r[2]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => \hex_r_reg[2]\(28),
      I1 => \hex_r_reg[2]\(20),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[2]_i_6_n_0\
    );
\char_r[2]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => \hex_r_reg[2]\(24),
      I1 => \hex_r_reg[2]\(16),
      I2 => \char_r[6]_i_24_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[2]_i_7_n_0\
    );
\char_r[2]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF448400004484"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => data2(0),
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_r[2]_i_13_n_0\,
      O => \char_r[2]_i_8_n_0\
    );
\char_r[2]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2A288028"
    )
        port map (
      I0 => data2(0),
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \char_idx_r_reg_n_0_[0]\,
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
      I3 => \char_idx_r[5]_i_3_n_0\,
      I4 => \char_r[3]_i_2_n_0\,
      O => char_r0_in(3)
    );
\char_r[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00003030FF00AAAA"
    )
        port map (
      I0 => \char_r[3]_i_3_n_0\,
      I1 => \char_r[3]_i_4_n_0\,
      I2 => \char_r[3]_i_5_n_0\,
      I3 => \char_r[3]_i_6_n_0\,
      I4 => \char_idx_r_reg_n_0_[4]\,
      I5 => \char_idx_r_reg_n_0_[5]\,
      O => \char_r[3]_i_2_n_0\
    );
\char_r[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"082A2AA8"
    )
        port map (
      I0 => data2(0),
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      O => \char_r[3]_i_3_n_0\
    );
\char_r[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[3]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[3]_i_4_n_0\
    );
\char_r[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFFAAF0CC00AAF0"
    )
        port map (
      I0 => data28(0),
      I1 => data35(3),
      I2 => data36(0),
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data27(0),
      O => \char_r[3]_i_5_n_0\
    );
\char_r[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFA0200000A020"
    )
        port map (
      I0 => data2(0),
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_r[3]_i_7_n_0\,
      O => \char_r[3]_i_6_n_0\
    );
\char_r[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CF0A0000C00A0000"
    )
        port map (
      I0 => data28(0),
      I1 => data32(0),
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => data27(0),
      O => \char_r[3]_i_7_n_0\
    );
\char_r[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"57FF5700"
    )
        port map (
      I0 => \char_r[6]_i_5_n_0\,
      I1 => \char_r[6]_i_4_n_0\,
      I2 => \char_r[6]_i_3_n_0\,
      I3 => \char_idx_r[5]_i_3_n_0\,
      I4 => \char_r[4]_i_2_n_0\,
      O => char_r0_in(4)
    );
\char_r[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCFCEEEECCCCEEEE"
    )
        port map (
      I0 => \char_r[4]_i_3_n_0\,
      I1 => \char_r[4]_i_4_n_0\,
      I2 => \char_r[4]_i_5_n_0\,
      I3 => \char_idx_r_reg_n_0_[4]\,
      I4 => \char_idx_r_reg_n_0_[5]\,
      I5 => \char_r[4]_i_6_n_0\,
      O => \char_r[4]_i_2_n_0\
    );
\char_r[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"046000000A200000"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[4]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_idx_r_reg_n_0_[3]\,
      I3 => \char_idx_r_reg_n_0_[0]\,
      I4 => data2(0),
      I5 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[4]_i_3_n_0\
    );
\char_r[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8A0A820288088000"
    )
        port map (
      I0 => \char_r[6]_i_23_n_0\,
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => data33(1),
      I4 => data2(0),
      I5 => data28(0),
      O => \char_r[4]_i_4_n_0\
    );
\char_r[4]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => data2(0),
      I2 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[4]_i_5_n_0\
    );
\char_r[4]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[2]\,
      I1 => \char_idx_r_reg_n_0_[3]\,
      O => \char_r[4]_i_6_n_0\
    );
\char_r[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"57FF5700"
    )
        port map (
      I0 => \char_r[6]_i_5_n_0\,
      I1 => \char_r[6]_i_4_n_0\,
      I2 => \char_r[6]_i_3_n_0\,
      I3 => \char_idx_r[5]_i_3_n_0\,
      I4 => \char_r[5]_i_2_n_0\,
      O => char_r0_in(5)
    );
\char_r[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFEFAFAFAFAFA"
    )
        port map (
      I0 => \char_r[5]_i_3_n_0\,
      I1 => data32(0),
      I2 => \char_r[5]_i_4_n_0\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => data27(0),
      I5 => \char_r[6]_i_23_n_0\,
      O => \char_r[5]_i_2_n_0\
    );
\char_r[5]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[5]\,
      I1 => \char_idx_r_reg_n_0_[4]\,
      I2 => \char_r[5]_i_5_n_0\,
      O => \char_r[5]_i_3_n_0\
    );
\char_r[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1100110010000000"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[4]\,
      I1 => \char_idx_r_reg_n_0_[5]\,
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => data2(0),
      I4 => \char_idx_r_reg_n_0_[1]\,
      I5 => \char_r[3]_i_4_n_0\,
      O => \char_r[5]_i_4_n_0\
    );
\char_r[5]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFE010F000E010F0"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => \char_idx_r_reg_n_0_[1]\,
      I2 => data2(0),
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => data27(0),
      O => \char_r[5]_i_5_n_0\
    );
\char_r[6]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => \hex_r_reg[2]\(25),
      I1 => \hex_r_reg[2]\(17),
      I2 => \char_r[6]_i_24_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_10_n_0\
    );
\char_r[6]_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF888"
    )
        port map (
      I0 => \char_r[6]_i_24_n_0\,
      I1 => \hex_r_reg[2]\(2),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_r_reg[2]\(6),
      I4 => \char_r[6]_i_28_n_0\,
      O => \char_r[6]_i_11_n_0\
    );
\char_r[6]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F0000000CCAA00"
    )
        port map (
      I0 => \hex_r_reg[1]\(10),
      I1 => \hex_r_reg[2]\(10),
      I2 => \hex_r_reg[2]\(14),
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \char_r[1]_i_2_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_12_n_0\
    );
\char_r[6]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => \hex_r_reg[2]\(30),
      I1 => \hex_r_reg[2]\(22),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_13_n_0\
    );
\char_r[6]_i_14\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => \hex_r_reg[2]\(26),
      I1 => \hex_r_reg[2]\(18),
      I2 => \char_r[6]_i_24_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_14_n_0\
    );
\char_r[6]_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF888"
    )
        port map (
      I0 => \char_r[6]_i_24_n_0\,
      I1 => \hex_r_reg[2]\(3),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_r_reg[2]\(7),
      I4 => \char_r[6]_i_29_n_0\,
      O => \char_r[6]_i_15_n_0\
    );
\char_r[6]_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F0000000CCAA00"
    )
        port map (
      I0 => \hex_r_reg[1]\(11),
      I1 => \hex_r_reg[2]\(11),
      I2 => \hex_r_reg[2]\(15),
      I3 => \char_r[0]_i_2_n_0\,
      I4 => \char_r[1]_i_2_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_16_n_0\
    );
\char_r[6]_i_17\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => \hex_r_reg[2]\(31),
      I1 => \hex_r_reg[2]\(23),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_17_n_0\
    );
\char_r[6]_i_18\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => \hex_r_reg[2]\(27),
      I1 => \hex_r_reg[2]\(19),
      I2 => \char_r[6]_i_24_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_18_n_0\
    );
\char_r[6]_i_19\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[4]\,
      I1 => \char_idx_r_reg_n_0_[5]\,
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
      I3 => \char_idx_r[5]_i_3_n_0\,
      I4 => \char_r[6]_i_6_n_0\,
      O => char_r0_in(6)
    );
\char_r[6]_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAA20000AAA2"
    )
        port map (
      I0 => data2(0),
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_idx_r_reg_n_0_[0]\,
      I3 => \char_idx_r_reg_n_0_[1]\,
      I4 => \char_idx_r_reg_n_0_[3]\,
      I5 => \char_r[6]_i_30_n_0\,
      O => \char_r[6]_i_20_n_0\
    );
\char_r[6]_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000002000000000"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[2]\,
      I1 => \char_idx_r_reg_n_0_[3]\,
      I2 => \char_idx_r_reg_n_0_[5]\,
      I3 => \char_idx_r_reg_n_0_[4]\,
      I4 => \char_idx_r[5]_i_5_n_0\,
      I5 => data27(0),
      O => \char_r[6]_i_21_n_0\
    );
\char_r[6]_i_22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2800A800A0002000"
    )
        port map (
      I0 => \char_r[6]_i_31_n_0\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_idx_r_reg_n_0_[3]\,
      I3 => data2(0),
      I4 => \char_idx_r_reg_n_0_[0]\,
      I5 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_22_n_0\
    );
\char_r[6]_i_23\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[4]\,
      I1 => \char_idx_r_reg_n_0_[5]\,
      I2 => \char_idx_r_reg_n_0_[2]\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      O => \char_r[6]_i_23_n_0\
    );
\char_r[6]_i_24\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000070000"
    )
        port map (
      I0 => \char_r[6]_i_19_n_0\,
      I1 => \char_r[0]_i_3_n_0\,
      I2 => \char_r[6]_i_32_n_0\,
      I3 => \char_r[0]_i_5_n_0\,
      I4 => \char_r[1]_i_2_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_24_n_0\
    );
\char_r[6]_i_25\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0007000000000000"
    )
        port map (
      I0 => \char_r[6]_i_19_n_0\,
      I1 => \char_r[0]_i_3_n_0\,
      I2 => \char_r[6]_i_32_n_0\,
      I3 => \char_r[0]_i_5_n_0\,
      I4 => \char_r[1]_i_2_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_25_n_0\
    );
\char_r[6]_i_26\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A0A0A000C0C0C00"
    )
        port map (
      I0 => \hex_r_reg[1]\(5),
      I1 => \hex_r_reg[1]\(1),
      I2 => \char_r[1]_i_2_n_0\,
      I3 => \char_r[6]_i_33_n_0\,
      I4 => \char_r[0]_i_5_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_26_n_0\
    );
\char_r[6]_i_27\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A0A0A000C0C0C00"
    )
        port map (
      I0 => \hex_r_reg[1]\(13),
      I1 => \hex_r_reg[1]\(9),
      I2 => \char_r[1]_i_2_n_0\,
      I3 => \char_r[6]_i_33_n_0\,
      I4 => \char_r[0]_i_5_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_27_n_0\
    );
\char_r[6]_i_28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A0A0A000C0C0C00"
    )
        port map (
      I0 => \hex_r_reg[1]\(6),
      I1 => \hex_r_reg[1]\(2),
      I2 => \char_r[1]_i_2_n_0\,
      I3 => \char_r[6]_i_33_n_0\,
      I4 => \char_r[0]_i_5_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_28_n_0\
    );
\char_r[6]_i_29\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A0A0A000C0C0C00"
    )
        port map (
      I0 => \hex_r_reg[1]\(7),
      I1 => \hex_r_reg[1]\(3),
      I2 => \char_r[1]_i_2_n_0\,
      I3 => \char_r[6]_i_33_n_0\,
      I4 => \char_r[0]_i_5_n_0\,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_29_n_0\
    );
\char_r[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFE4FFE4FFE400E4"
    )
        port map (
      I0 => \hex_digit_idx_r_reg_n_0_[1]\,
      I1 => \char_r[6]_i_7_n_0\,
      I2 => \char_r[6]_i_8_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[2]\,
      I4 => \char_r[6]_i_9_n_0\,
      I5 => \char_r[6]_i_10_n_0\,
      O => \char_r[6]_i_3_n_0\
    );
\char_r[6]_i_30\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFCC00CCE444E444"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[0]\,
      I1 => data2(0),
      I2 => data28(0),
      I3 => \char_idx_r_reg_n_0_[2]\,
      I4 => data27(0),
      I5 => \char_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_30_n_0\
    );
\char_r[6]_i_31\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[5]\,
      I1 => \char_idx_r_reg_n_0_[4]\,
      O => \char_r[6]_i_31_n_0\
    );
\char_r[6]_i_32\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010000000"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[1]\,
      I1 => \char_idx_r_reg_n_0_[0]\,
      I2 => data36(0),
      I3 => \char_r[4]_i_6_n_0\,
      I4 => \char_idx_r_reg_n_0_[5]\,
      I5 => \char_idx_r_reg_n_0_[4]\,
      O => \char_r[6]_i_32_n_0\
    );
\char_r[6]_i_33\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF8F8F888888888"
    )
        port map (
      I0 => \char_r[6]_i_34_n_0\,
      I1 => \char_r[0]_i_4_n_0\,
      I2 => \char_r[6]_i_35_n_0\,
      I3 => \char_idx_r_reg_n_0_[3]\,
      I4 => \char_r[0]_i_6_n_0\,
      I5 => \char_r[6]_i_19_n_0\,
      O => \char_r[6]_i_33_n_0\
    );
\char_r[6]_i_34\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[4]\,
      I1 => \char_idx_r_reg_n_0_[5]\,
      I2 => \char_idx_r_reg_n_0_[3]\,
      I3 => \char_idx_r_reg_n_0_[2]\,
      O => \char_r[6]_i_34_n_0\
    );
\char_r[6]_i_35\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"50005100"
    )
        port map (
      I0 => \char_idx_r_reg_n_0_[3]\,
      I1 => \char_idx_r_reg_n_0_[2]\,
      I2 => \char_idx_r_reg_n_0_[1]\,
      I3 => data2(0),
      I4 => \char_idx_r_reg_n_0_[0]\,
      O => \char_r[6]_i_35_n_0\
    );
\char_r[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFE4FFE4FFE400E4"
    )
        port map (
      I0 => \hex_digit_idx_r_reg_n_0_[1]\,
      I1 => \char_r[6]_i_11_n_0\,
      I2 => \char_r[6]_i_12_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[2]\,
      I4 => \char_r[6]_i_13_n_0\,
      I5 => \char_r[6]_i_14_n_0\,
      O => \char_r[6]_i_4_n_0\
    );
\char_r[6]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFE4FFE4FFE400E4"
    )
        port map (
      I0 => \hex_digit_idx_r_reg_n_0_[1]\,
      I1 => \char_r[6]_i_15_n_0\,
      I2 => \char_r[6]_i_16_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[2]\,
      I4 => \char_r[6]_i_17_n_0\,
      I5 => \char_r[6]_i_18_n_0\,
      O => \char_r[6]_i_5_n_0\
    );
\char_r[6]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFF8FFF8FFF8"
    )
        port map (
      I0 => \char_r[6]_i_19_n_0\,
      I1 => \char_r[6]_i_20_n_0\,
      I2 => \char_r[6]_i_21_n_0\,
      I3 => \char_r[6]_i_22_n_0\,
      I4 => \char_r[6]_i_23_n_0\,
      I5 => data27(0),
      O => \char_r[6]_i_6_n_0\
    );
\char_r[6]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF888"
    )
        port map (
      I0 => \char_r[6]_i_24_n_0\,
      I1 => \hex_r_reg[2]\(1),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_r_reg[2]\(5),
      I4 => \char_r[6]_i_26_n_0\,
      O => \char_r[6]_i_7_n_0\
    );
\char_r[6]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF888"
    )
        port map (
      I0 => \char_r[6]_i_24_n_0\,
      I1 => \hex_r_reg[2]\(9),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_r_reg[2]\(13),
      I4 => \char_r[6]_i_27_n_0\,
      O => \char_r[6]_i_8_n_0\
    );
\char_r[6]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A0C0"
    )
        port map (
      I0 => \hex_r_reg[2]\(29),
      I1 => \hex_r_reg[2]\(21),
      I2 => \char_r[6]_i_25_n_0\,
      I3 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \char_r[6]_i_9_n_0\
    );
\char_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_6,
      D => char_r0_in(0),
      Q => \char_r_reg_n_0_[0]\,
      R => '0'
    );
\char_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_6,
      D => char_r0_in(1),
      Q => \char_r_reg_n_0_[1]\,
      R => '0'
    );
\char_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_6,
      D => char_r0_in(2),
      Q => \char_r_reg_n_0_[2]\,
      R => '0'
    );
\char_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_6,
      D => char_r0_in(3),
      Q => \char_r_reg_n_0_[3]\,
      R => '0'
    );
\char_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_6,
      D => char_r0_in(4),
      Q => \char_r_reg_n_0_[4]\,
      R => '0'
    );
\char_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_6,
      D => char_r0_in(5),
      Q => \char_r_reg_n_0_[5]\,
      R => '0'
    );
\char_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => u_printc_n_6,
      D => char_r0_in(6),
      Q => \char_r_reg_n_0_[6]\,
      R => '0'
    );
\hex_digit_idx_r[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAABFFFAAAA8000"
    )
        port map (
      I0 => hex_digit_idx_r(0),
      I1 => \FSM_sequential_state_r[0]_i_2_n_0\,
      I2 => \hex_digit_idx_r[2]_i_3_n_0\,
      I3 => \FSM_sequential_state_r[1]_i_2_n_0\,
      I4 => u_printc_n_5,
      I5 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => \hex_digit_idx_r[0]_i_1_n_0\
    );
\hex_digit_idx_r[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"15"
    )
        port map (
      I0 => state_r(0),
      I1 => \hex_digit_idx_r_reg_n_0_[0]\,
      I2 => state_r(1),
      O => hex_digit_idx_r(0)
    );
\hex_digit_idx_r[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAABFFFAAAA8000"
    )
        port map (
      I0 => hex_digit_idx_r(1),
      I1 => \FSM_sequential_state_r[0]_i_2_n_0\,
      I2 => \hex_digit_idx_r[2]_i_3_n_0\,
      I3 => \FSM_sequential_state_r[1]_i_2_n_0\,
      I4 => u_printc_n_5,
      I5 => \hex_digit_idx_r_reg_n_0_[1]\,
      O => \hex_digit_idx_r[1]_i_1_n_0\
    );
\hex_digit_idx_r[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D7"
    )
        port map (
      I0 => state_r(1),
      I1 => \hex_digit_idx_r_reg_n_0_[1]\,
      I2 => \hex_digit_idx_r_reg_n_0_[0]\,
      O => hex_digit_idx_r(1)
    );
\hex_digit_idx_r[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAABFFFAAAA8000"
    )
        port map (
      I0 => hex_digit_idx_r(2),
      I1 => \FSM_sequential_state_r[0]_i_2_n_0\,
      I2 => \hex_digit_idx_r[2]_i_3_n_0\,
      I3 => \FSM_sequential_state_r[1]_i_2_n_0\,
      I4 => u_printc_n_5,
      I5 => \hex_digit_idx_r_reg_n_0_[2]\,
      O => \hex_digit_idx_r[2]_i_1_n_0\
    );
\hex_digit_idx_r[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FD57"
    )
        port map (
      I0 => state_r(1),
      I1 => \hex_digit_idx_r_reg_n_0_[1]\,
      I2 => \hex_digit_idx_r_reg_n_0_[0]\,
      I3 => \hex_digit_idx_r_reg_n_0_[2]\,
      O => hex_digit_idx_r(2)
    );
\hex_digit_idx_r[2]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rst_n,
      I1 => state_r(1),
      O => \hex_digit_idx_r[2]_i_3_n_0\
    );
\hex_digit_idx_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \hex_digit_idx_r[0]_i_1_n_0\,
      Q => \hex_digit_idx_r_reg_n_0_[0]\,
      R => '0'
    );
\hex_digit_idx_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \hex_digit_idx_r[1]_i_1_n_0\,
      Q => \hex_digit_idx_r_reg_n_0_[1]\,
      R => '0'
    );
\hex_digit_idx_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \hex_digit_idx_r[2]_i_1_n_0\,
      Q => \hex_digit_idx_r_reg_n_0_[2]\,
      R => '0'
    );
\hex_r_reg[1][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(0),
      Q => \hex_r_reg[1]\(0),
      R => '0'
    );
\hex_r_reg[1][10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(10),
      Q => \hex_r_reg[1]\(10),
      R => '0'
    );
\hex_r_reg[1][11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(11),
      Q => \hex_r_reg[1]\(11),
      R => '0'
    );
\hex_r_reg[1][12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(12),
      Q => \hex_r_reg[1]\(12),
      R => '0'
    );
\hex_r_reg[1][13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(13),
      Q => \hex_r_reg[1]\(13),
      R => '0'
    );
\hex_r_reg[1][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(1),
      Q => \hex_r_reg[1]\(1),
      R => '0'
    );
\hex_r_reg[1][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(2),
      Q => \hex_r_reg[1]\(2),
      R => '0'
    );
\hex_r_reg[1][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(3),
      Q => \hex_r_reg[1]\(3),
      R => '0'
    );
\hex_r_reg[1][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(4),
      Q => \hex_r_reg[1]\(4),
      R => '0'
    );
\hex_r_reg[1][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(5),
      Q => \hex_r_reg[1]\(5),
      R => '0'
    );
\hex_r_reg[1][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(6),
      Q => \hex_r_reg[1]\(6),
      R => '0'
    );
\hex_r_reg[1][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(7),
      Q => \hex_r_reg[1]\(7),
      R => '0'
    );
\hex_r_reg[1][8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(8),
      Q => \hex_r_reg[1]\(8),
      R => '0'
    );
\hex_r_reg[1][9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_addr_o(9),
      Q => \hex_r_reg[1]\(9),
      R => '0'
    );
\hex_r_reg[2][0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(0),
      Q => \hex_r_reg[2]\(0),
      R => '0'
    );
\hex_r_reg[2][10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(10),
      Q => \hex_r_reg[2]\(10),
      R => '0'
    );
\hex_r_reg[2][11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(11),
      Q => \hex_r_reg[2]\(11),
      R => '0'
    );
\hex_r_reg[2][12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(12),
      Q => \hex_r_reg[2]\(12),
      R => '0'
    );
\hex_r_reg[2][13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(13),
      Q => \hex_r_reg[2]\(13),
      R => '0'
    );
\hex_r_reg[2][14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(14),
      Q => \hex_r_reg[2]\(14),
      R => '0'
    );
\hex_r_reg[2][15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(15),
      Q => \hex_r_reg[2]\(15),
      R => '0'
    );
\hex_r_reg[2][16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(16),
      Q => \hex_r_reg[2]\(16),
      R => '0'
    );
\hex_r_reg[2][17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(17),
      Q => \hex_r_reg[2]\(17),
      R => '0'
    );
\hex_r_reg[2][18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(18),
      Q => \hex_r_reg[2]\(18),
      R => '0'
    );
\hex_r_reg[2][19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(19),
      Q => \hex_r_reg[2]\(19),
      R => '0'
    );
\hex_r_reg[2][1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(1),
      Q => \hex_r_reg[2]\(1),
      R => '0'
    );
\hex_r_reg[2][20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(20),
      Q => \hex_r_reg[2]\(20),
      R => '0'
    );
\hex_r_reg[2][21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(21),
      Q => \hex_r_reg[2]\(21),
      R => '0'
    );
\hex_r_reg[2][22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(22),
      Q => \hex_r_reg[2]\(22),
      R => '0'
    );
\hex_r_reg[2][23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(23),
      Q => \hex_r_reg[2]\(23),
      R => '0'
    );
\hex_r_reg[2][24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(24),
      Q => \hex_r_reg[2]\(24),
      R => '0'
    );
\hex_r_reg[2][25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(25),
      Q => \hex_r_reg[2]\(25),
      R => '0'
    );
\hex_r_reg[2][26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(26),
      Q => \hex_r_reg[2]\(26),
      R => '0'
    );
\hex_r_reg[2][27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(27),
      Q => \hex_r_reg[2]\(27),
      R => '0'
    );
\hex_r_reg[2][28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(28),
      Q => \hex_r_reg[2]\(28),
      R => '0'
    );
\hex_r_reg[2][29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(29),
      Q => \hex_r_reg[2]\(29),
      R => '0'
    );
\hex_r_reg[2][2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(2),
      Q => \hex_r_reg[2]\(2),
      R => '0'
    );
\hex_r_reg[2][30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(30),
      Q => \hex_r_reg[2]\(30),
      R => '0'
    );
\hex_r_reg[2][31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(31),
      Q => \hex_r_reg[2]\(31),
      R => '0'
    );
\hex_r_reg[2][3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(3),
      Q => \hex_r_reg[2]\(3),
      R => '0'
    );
\hex_r_reg[2][4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(4),
      Q => \hex_r_reg[2]\(4),
      R => '0'
    );
\hex_r_reg[2][5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(5),
      Q => \hex_r_reg[2]\(5),
      R => '0'
    );
\hex_r_reg[2][6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(6),
      Q => \hex_r_reg[2]\(6),
      R => '0'
    );
\hex_r_reg[2][7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(7),
      Q => \hex_r_reg[2]\(7),
      R => '0'
    );
\hex_r_reg[2][8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(8),
      Q => \hex_r_reg[2]\(8),
      R => '0'
    );
\hex_r_reg[2][9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => mem_dout_i(9),
      Q => \hex_r_reg[2]\(9),
      R => '0'
    );
\string_r[216]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => Q(7),
      I1 => Q(2),
      O => \string_r[216]_i_1_n_0\
    );
\string_r[256]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => Q(2),
      I1 => Q(7),
      I2 => Q(5),
      I3 => Q(6),
      O => \string_r[256]_i_1_n_0\
    );
\string_r[265]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => Q(6),
      I1 => Q(5),
      O => \^d\(0)
    );
\string_r[283]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => Q(5),
      I1 => Q(6),
      I2 => Q(7),
      O => \string_r[283]_i_1_n_0\
    );
\string_r[288]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => rst_n,
      I1 => state_r(1),
      I2 => state_r(0),
      O => \string_r[288]_i_1_n_0\
    );
\string_r[288]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => Q(5),
      I1 => Q(6),
      I2 => Q(2),
      O => \string_r[288]_i_2_n_0\
    );
\string_r_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => Q(2),
      Q => data2(0),
      R => '0'
    );
\string_r_reg[216]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => \string_r[216]_i_1_n_0\,
      Q => data27(0),
      R => '0'
    );
\string_r_reg[224]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => Q(7),
      Q => data28(0),
      R => '0'
    );
\string_r_reg[256]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => \string_r[256]_i_1_n_0\,
      Q => data32(0),
      R => '0'
    );
\string_r_reg[265]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => \^d\(0),
      Q => data33(1),
      R => '0'
    );
\string_r_reg[283]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => \string_r[283]_i_1_n_0\,
      Q => data35(3),
      R => '0'
    );
\string_r_reg[288]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \string_r[288]_i_1_n_0\,
      D => \string_r[288]_i_2_n_0\,
      Q => data36(0),
      R => '0'
    );
u_printc: entity work.total_design_host_top_wrapper_0_0_printc
     port map (
      E(0) => u_printc_n_6,
      \FSM_sequential_state_r_reg[0]\ => u_printc_n_5,
      \FSM_sequential_state_r_reg[0]_0\ => u_printc_n_9,
      \FSM_sequential_state_r_reg[0]_1\ => \FSM_sequential_state_r[0]_i_2_n_0\,
      \FSM_sequential_state_r_reg[1]\ => u_printc_n_10,
      \FSM_sequential_state_r_reg[1]_0\ => \FSM_sequential_state_r[1]_i_2_n_0\,
      Q(6) => \char_r_reg_n_0_[6]\,
      Q(5) => \char_r_reg_n_0_[5]\,
      Q(4) => \char_r_reg_n_0_[4]\,
      Q(3) => \char_r_reg_n_0_[3]\,
      Q(2) => \char_r_reg_n_0_[2]\,
      Q(1) => \char_r_reg_n_0_[1]\,
      Q(0) => \char_r_reg_n_0_[0]\,
      SS(0) => \^sr\(0),
      \char_idx_r_reg[0]\ => \char_idx_r[5]_i_3_n_0\,
      \char_idx_r_reg[0]_0\ => \hex_digit_idx_r_reg_n_0_[1]\,
      \char_idx_r_reg[0]_1\ => \hex_digit_idx_r_reg_n_0_[0]\,
      \char_idx_r_reg[0]_2\ => \hex_digit_idx_r_reg_n_0_[2]\,
      clk => clk,
      hex_digit_idx_c_w => hex_digit_idx_c_w,
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
      prints_start_w => prints_start_w,
      rst_n => rst_n,
      rst_n_0(0) => u_printc_n_7,
      state_r(1 downto 0) => state_r(1 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity total_design_host_top_wrapper_0_0_host_top is
  port (
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 6 downto 0 );
    mem_addr_o : out STD_LOGIC_VECTOR ( 13 downto 0 );
    m_axi_bready : out STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    rst_n : in STD_LOGIC;
    clk : in STD_LOGIC;
    mem_dout_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    simt_ready_i : in STD_LOGIC;
    start_i : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of total_design_host_top_wrapper_0_0_host_top : entity is "host_top";
end total_design_host_top_wrapper_0_0_host_top;

architecture STRUCTURE of total_design_host_top_wrapper_0_0_host_top is
  signal \^d\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \FSM_onehot_state_r_reg_n_0_[3]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[4]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[5]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[6]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[7]\ : STD_LOGIC;
  signal \FSM_onehot_state_r_reg_n_0_[8]\ : STD_LOGIC;
  signal \^mem_addr_o\ : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal prints_ready_w : STD_LOGIC;
  signal prints_start_w : STD_LOGIC;
  signal string_i0 : STD_LOGIC;
  signal u_memdump_n_15 : STD_LOGIC;
  signal u_prints_n_6 : STD_LOGIC;
  signal u_prints_n_7 : STD_LOGIC;
  signal u_prints_n_8 : STD_LOGIC;
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[0]\ : label is "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[1]\ : label is "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[2]\ : label is "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[3]\ : label is "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[4]\ : label is "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[5]\ : label is "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[6]\ : label is "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[7]\ : label is "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_r_reg[8]\ : label is "S_WAIT_MSG_WAITING:000001000,S_WAIT_SIMT:000010000,S_INIT_MSG_WAITING:000000100,S_INIT_SIMT:000000010,S_IDLE:000000001,S_INIT_MSG_FINISHED:010000000,S_WAIT_MEMDUMP:001000000,S_WAIT_MSG_FINISHED:100000000,S_INIT_MEMDUMP:000100000";
begin
  D(1 downto 0) <= \^d\(1 downto 0);
  mem_addr_o(13 downto 0) <= \^mem_addr_o\(13 downto 0);
\FSM_onehot_state_r_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => u_prints_n_6,
      D => \FSM_onehot_state_r_reg_n_0_[8]\,
      Q => \^d\(0),
      S => u_prints_n_7
    );
\FSM_onehot_state_r_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => u_prints_n_6,
      D => \^d\(0),
      Q => \^d\(1),
      R => u_prints_n_7
    );
\FSM_onehot_state_r_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => u_prints_n_6,
      D => \^d\(1),
      Q => string_i0,
      R => u_prints_n_7
    );
\FSM_onehot_state_r_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => u_prints_n_6,
      D => string_i0,
      Q => \FSM_onehot_state_r_reg_n_0_[3]\,
      R => u_prints_n_7
    );
\FSM_onehot_state_r_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => u_prints_n_6,
      D => \FSM_onehot_state_r_reg_n_0_[3]\,
      Q => \FSM_onehot_state_r_reg_n_0_[4]\,
      R => u_prints_n_7
    );
\FSM_onehot_state_r_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => u_prints_n_6,
      D => \FSM_onehot_state_r_reg_n_0_[4]\,
      Q => \FSM_onehot_state_r_reg_n_0_[5]\,
      R => u_prints_n_7
    );
\FSM_onehot_state_r_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => u_prints_n_6,
      D => \FSM_onehot_state_r_reg_n_0_[5]\,
      Q => \FSM_onehot_state_r_reg_n_0_[6]\,
      R => u_prints_n_7
    );
\FSM_onehot_state_r_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => u_prints_n_6,
      D => \FSM_onehot_state_r_reg_n_0_[6]\,
      Q => \FSM_onehot_state_r_reg_n_0_[7]\,
      R => u_prints_n_7
    );
\FSM_onehot_state_r_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => u_prints_n_6,
      D => \FSM_onehot_state_r_reg_n_0_[7]\,
      Q => \FSM_onehot_state_r_reg_n_0_[8]\,
      R => u_prints_n_7
    );
u_memdump: entity work.total_design_host_top_wrapper_0_0_memdump
     port map (
      D(0) => u_prints_n_8,
      \FSM_sequential_state_r_reg[1]_0\ => u_memdump_n_15,
      Q(3) => \FSM_onehot_state_r_reg_n_0_[7]\,
      Q(2) => \FSM_onehot_state_r_reg_n_0_[6]\,
      Q(1) => \FSM_onehot_state_r_reg_n_0_[5]\,
      Q(0) => string_i0,
      SR(0) => u_prints_n_7,
      \addr_r_reg[13]_0\(13 downto 0) => \^mem_addr_o\(13 downto 0),
      clk => clk,
      prints_ready_w => prints_ready_w,
      prints_start_w => prints_start_w,
      rst_n => rst_n
    );
u_prints: entity work.total_design_host_top_wrapper_0_0_prints
     port map (
      D(0) => u_prints_n_8,
      E(0) => u_prints_n_6,
      \FSM_onehot_state_r_reg[0]\ => u_memdump_n_15,
      Q(8) => \FSM_onehot_state_r_reg_n_0_[8]\,
      Q(7) => \FSM_onehot_state_r_reg_n_0_[7]\,
      Q(6) => \FSM_onehot_state_r_reg_n_0_[6]\,
      Q(5) => \FSM_onehot_state_r_reg_n_0_[5]\,
      Q(4) => \FSM_onehot_state_r_reg_n_0_[4]\,
      Q(3) => \FSM_onehot_state_r_reg_n_0_[3]\,
      Q(2) => string_i0,
      Q(1 downto 0) => \^d\(1 downto 0),
      SR(0) => u_prints_n_7,
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
      mem_addr_o(13 downto 0) => \^mem_addr_o\(13 downto 0),
      mem_dout_i(31 downto 0) => mem_dout_i(31 downto 0),
      prints_ready_w => prints_ready_w,
      prints_start_w => prints_start_w,
      rst_n => rst_n,
      simt_ready_i => simt_ready_i,
      start_i => start_i
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity total_design_host_top_wrapper_0_0_host_top_wrapper is
  port (
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 6 downto 0 );
    mem_addr_o : out STD_LOGIC_VECTOR ( 13 downto 0 );
    m_axi_bready : out STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC;
    m_axi_rready : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    rst_n : in STD_LOGIC;
    clk : in STD_LOGIC;
    mem_dout_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    simt_ready_i : in STD_LOGIC;
    start_i : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of total_design_host_top_wrapper_0_0_host_top_wrapper : entity is "host_top_wrapper";
end total_design_host_top_wrapper_0_0_host_top_wrapper;

architecture STRUCTURE of total_design_host_top_wrapper_0_0_host_top_wrapper is
begin
u_host_top: entity work.total_design_host_top_wrapper_0_0_host_top
     port map (
      D(1 downto 0) => D(1 downto 0),
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
      mem_addr_o(13 downto 0) => mem_addr_o(13 downto 0),
      mem_dout_i(31 downto 0) => mem_dout_i(31 downto 0),
      rst_n => rst_n,
      simt_ready_i => simt_ready_i,
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
    mem_addr_o : out STD_LOGIC_VECTOR ( 13 downto 0 );
    mem_dout_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
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
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF M_AXI, ASSOCIATED_RESET rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, INSERT_VIP 0";
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
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_MODE of rst_n : signal is "slave";
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARADDR";
  attribute X_INTERFACE_INFO of m_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 M_AXI ARPROT";
  attribute X_INTERFACE_INFO of m_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWADDR";
  attribute X_INTERFACE_MODE of m_axi_awaddr : signal is "master";
  attribute X_INTERFACE_PARAMETER of m_axi_awaddr : signal is "XIL_INTERFACENAME M_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 7, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 M_AXI AWPROT";
  attribute X_INTERFACE_INFO of m_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 M_AXI BRESP";
  attribute X_INTERFACE_INFO of m_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 M_AXI RDATA";
  attribute X_INTERFACE_INFO of m_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 M_AXI RRESP";
  attribute X_INTERFACE_INFO of m_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 M_AXI WDATA";
  attribute X_INTERFACE_INFO of m_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 M_AXI WSTRB";
  attribute X_INTERFACE_INFO of mem_addr_o : signal is "xilinx.com:interface:bram:1.0 MEM ADDR";
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
      D(1) => simt_start_o,
      D(0) => ready_o,
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
      mem_addr_o(13 downto 0) => mem_addr_o(13 downto 0),
      mem_dout_i(31 downto 0) => mem_dout_i(31 downto 0),
      rst_n => rst_n,
      simt_ready_i => simt_ready_i,
      start_i => start_i
    );
end STRUCTURE;
