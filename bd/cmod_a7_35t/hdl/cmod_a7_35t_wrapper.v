//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
//Date        : Wed Apr 22 18:10:22 2026
//Host        : fedora running 64-bit unknown
//Command     : generate_target cmod_a7_35t_wrapper.bd
//Design      : cmod_a7_35t_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module cmod_a7_35t_wrapper
   (sys_clk,
    uart_rxd,
    uart_txd);
  input sys_clk;
  input uart_rxd;
  output uart_txd;

  wire sys_clk;
  wire uart_rxd;
  wire uart_txd;

  cmod_a7_35t cmod_a7_35t_i
       (.sys_clk(sys_clk),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd));
endmodule
