//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
//Date        : Thu Apr 23 14:49:17 2026
//Host        : fedora running 64-bit unknown
//Command     : generate_target cmod_a7_35t_wrapper.bd
//Design      : cmod_a7_35t_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module cmod_a7_35t_wrapper
   (btn,
    led,
    led2,
    sys_clk,
    uart_rxd,
    uart_txd);
  input btn;
  output led;
  output led2;
  input sys_clk;
  input uart_rxd;
  output uart_txd;

  wire btn;
  wire led;
  wire led2;
  wire sys_clk;
  wire uart_rxd;
  wire uart_txd;

  cmod_a7_35t cmod_a7_35t_i
       (.btn(btn),
        .led(led),
        .led2(led2),
        .sys_clk(sys_clk),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd));
endmodule
