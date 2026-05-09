// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Sat May  9 11:26:23 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim -rename_top total_design_blk_mem_gen_0_0 -prefix
//               total_design_blk_mem_gen_0_0_ total_design_blk_mem_gen_0_0_sim_netlist.v
// Design      : total_design_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "total_design_blk_mem_gen_0_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module total_design_blk_mem_gen_0_0
   (clka,
    addra,
    douta,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_WRITE_MODE READ_ONLY, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_WRITE_MODE READ_ONLY, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [9:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.244 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "total_design_blk_mem_gen_0_0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "4" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  total_design_blk_mem_gen_0_0_blk_mem_gen_v8_4_12 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YqH9kwIC39+qbZg4PSfFsXuB9k9wnuxNryS/CfnEri6Ci9fSC6fsrQ/T/hnt3u/yolbJ8DJa1Qu6
Qnm24A9jLbA+fu3Nsmm6/rM6a4vU6OfVl/gTFd/CiWDutv6Dhn6Lim4uUNPahoOR/A2Yc4Zo2tdI
kMLO9gn9WlH2l3O2oXs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XJYO2VHd/cnMxQd3i7/2qRhl57dl+doEKuhAunQyv3vpGRG/jlNxj8PqrgLoF0HMdqE3qJUVE/oq
kBSapqjVjLDMOrNGQ+Tc6VGsKMZH8FE/TXHQJ/IM5Iuiu2eozEwwVUomF+7cfqn+9OsVsqCONQ1M
g0oRlangiqasJDhhMfnlGGqwAwmgWRGQA6dmhTuua1s8zdvIv540zY6p5au8cAKVhqyyKK7wbxEE
SGuFqX+NYoyRV+rfWCcWM+hJEmnWS8LNAKkd13YE2+17sPYzUdZ23DmTxXK6KlAxKFW27CBySUfg
qdNXp2DSs2KAQYih27pBNMuHfGbM/ATFPWFvxg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lYoEi/e8HsDTz6N11EDe/B/iitERmeYndlCklmCluwgb0N4W80JUGVlkd7NlRZHRNhxaNBJPkcjC
n61nO0tb17NwsMwjbY5TF8JWRYTNw1JXCFacvQYrdKv4/7QNQEtwVGiCLxFhOA8aHlWMZIrc2fri
VRMVWaEBcPwCGorlVIM=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QEw9fEsWFbdX0OQLvYs/gl+zyEOW3ak9TdQVaq+0AXXOT3LIqF7wDxJ6ZBnlf9mNbdsUVH5tAz1o
H8u7ihJl1L3THEvugW+TS8hkvVbEA9rKO2vV15KAj4Lla7UdFT/xDfe79RFarlLI7yGrubjgdoRi
QWy//UKsffG7IWNwmoSuppWiWB4ZHJtkunNyIkm70JPGyZF62VxJg1MTT+5LUbZG5vZjjuHZud9w
xJaKv1tFP/x8RVqLU5gPOqGqTW7/nKO2S+450Vo4D9vAmBVVcXpaL1EbSmCvQ+qJmcQKtf9qYFRV
Zko08hbpHjPxstqvTDro01jRzB8592m4xU2TWA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TC7q853CWBPPJgbRfgDV1lmjUwSAtliljShAyNFg8sfRfwDzchthzoSPH1UCHV++E2JXacEKq1lB
UWsNP92U4Xh0/Gu+6esOI0pJb8I+TRTxyBN1I4cRQEfQHcwfhbSdeH3yX9OV3opLEqYmT37hWU+J
zCawYnxVESI0FtRzEXve9gdEWlrKKckrT/hp4mvxxOjvOkOSQBvy0elgUOqh6mEOZl+JnUbsR+Wm
CoZLE1eefMZy3FnVmyDNPv3JPXi88aLXMyimal0MYFkTiS4XJiGT3eAIMIbksehXY+eYi/KFpZWQ
GHpX+lG3UmiWWLwyPakFwKEHbrBc70AlJ2eV9g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j9nmCKgjPWNChPbpSW6EWLrMA6oCG2JGPoum8px09v0PEAh0DRXZi0J8HPzXUsZgOEMcKpA7X54u
YFcDDCLAQ+urha/eSPbQYHQh4yGCursxAQ1C6LEyNQ2wJ0eLlO2bJeAl/gof06zqsYVM2lLJVNv5
wao1k2bmgPdfpfY3c9vPD0fSMuZPS41EoRS0cQhO5GTZnKdjxm6tEUL3GnTjB8ynSCIbCJUsMtAX
4FRHNa52gudx5B5fagR+lXgFhE7e++rWTJELr7SYB+r5Es8qZLTpCH8TrQxEkV0rY/+e4sAjNE2D
gHw8GD7VcUtc15B8y1BbVmh29qc8Nd3V2i/miA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UkCD6I/Vye4qNoNoa3hIexBXG3xyKUJPAHAjIo7UcNVCDXpMQiYEtPDqExZMfiPlJn2nswCYIfIJ
FYWqMCloKSQyyI/7yZ2EtbyWEklb/P5IyZyvGi6hhFUo/JFTb12b4bK0gZPr+bCDdlVQKTx5GVHz
wptdUJO2omSj8axVMPbLRRtVzlJIZ29dTJ2ATXVXAcBxPnFfHRAMnYYKLeeLExX61vQvpqrkLQHm
XG7hpVzJi56gYKAzxa2BLq072OCVpVS70bfWlhlSTVcSlCrUf+EcarEk4FD8+Ih2NCvrqremG6yn
TtcBn8Xr8M/6zhOYvLi6AD6eArDMKA8n+Ccv8A==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
A5y5QVZU8yjPexRVPioSiAGohCHD5DX5FVobuMyhcgQRExLUhPvnnS8HOtxTj/2IapEcz68gFMGG
Hpi+m725u85/om/Vze9pGIW9Mn328Kz2FIg3W5EvGstfGwY+48LiAGAmTR269JS4lJGVYWYOz7Xk
S8cEsFd2m7j8iyKtARJzD90+UdXq/cIIh725jC9i8nbgxB364zddvm1Z/DF3JRw1qFp6GGcuRai1
KNcJ1j8c9wtIgktpsteU3e5+bxHEw8NT3gWXUFYjm00NDq97Jals8Jjktmum2nQxoF7ivPacfEey
gnSF6jRMkTsZObzc30hAhs0CEtc33hZLhPLHSn8pQ0WyvKJLHdd5s2yckgTZtqxC1Sbwe7WEgNXe
ZMX3pIkz+aoXsAL7GBLyVBMVQcyMoF0w8QGAaTe8sqatABwPqXidYRqNROTf62IYcMpV89XYgaTv
EwIn/oni9KOFd2BFVxRZbFGGC4IjvigsTBUijI+Dk6kVnDh240clGcc4

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Omtp+lCaqUx7Z4qdFj2zrN8LpCkit2eX4hlMtig+ielGm/x4FSZkpjoFmiqdKFPi2eg0pg09MSai
XyGH68UzAR7Xrj8f1jlIoUmMKp4GcxfdqfTeuu7kWGOJEP6cvgTjSJFj2gawDv7f4yZcltnK2x0L
e4GW/rBTmGvZtKWb2ahjINLxPuh3dDaSaWdb+zVgbtyrI5FrjxBkq+aOxSjyNsqnCx1L0uWbxnkl
88NbXN3dTaECXHNm/fsleayM5hKis7kTv9BFajJMGy+BhQlmIYpE+F5zchnTTFUFJZCz1sX9Fc8e
HcY7irB8mR3ajdzjUZLBQEMktp096Nheq3U75A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hpeBLwN9x2ZFDwroYLlUe5GjjDepHik2l0c2s3/6S7JPCRkzQSyt2V1Ad/JewAs/QNp5SXSbYYB4
rQl0My1LDMF3xw43r0g2IbcyHVpPhGp0W5msuQdF67afnsRv90iJYWLMI3QkYGCTWAzl4HrLxFSg
3z8XZRK670IcxznOrlvgHmIKsvubZrBkuc1EynrVb9Nw16QnIx2rc4WgcEXeFf+4i1RoYLDd3gXK
NFCNMdtaRYUThunFP6Z4ViZ5UnDmKq+IMhd31jTaqIlWOBDxPI1+v5RJYxIyTbn4rxlKR2fNbl5/
z4OUjBTd+1GH3I2OXlqmAOvIhpe2Z2HH7nZu/A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Mt2RhTSUwEIEWeNARbyL+EdfS1UF6nPaL/fKl/7oO2gina93egwCWDLl1fbBtkfaPco0cu4MJ9K3
OraAsyHRlY+MNShmJ1LzAIA1LjZx4y55lu9dlQqSUXR7AW7wVbkg1864mK+hM/1XygU0jvebKNW9
B7xSER+asLO6pxi0mt7uC2PHxLPAYEszFhmnap82TtbDGdQ2qtyekY+ngs+N2fAdsblxVwJruiMl
e6XJ127M8N1mYwhWU2HtRpBOSnnKoHgD9fG51XK/rhk8DxT66QnX9uLPB+H25eDupBJGi1Y5o6x8
hOwZiSUVlBLh7brfzevh7+eRn+7es6wBas0+3w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27056)
`pragma protect data_block
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
`pragma protect end_protected
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
