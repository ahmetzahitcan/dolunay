//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
//Date        : Sun May 10 22:40:25 2026
//Host        : fedora running 64-bit unknown
//Command     : generate_target total_design_wrapper.bd
//Design      : total_design_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module total_design_wrapper
   (btn,
    led,
    led2,
    reset,
    sys_clk,
    usb_uart_rxd,
    usb_uart_txd);
  input btn;
  output led;
  output led2;
  input reset;
  input sys_clk;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire btn;
  wire led;
  wire led2;
  wire reset;
  wire sys_clk;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  total_design total_design_i
       (.btn(btn),
        .led(led),
        .led2(led2),
        .reset(reset),
        .sys_clk(sys_clk),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
