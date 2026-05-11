// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Sat May  9 15:58:40 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim -rename_top total_design_blk_mem_gen_1_0 -prefix
//               total_design_blk_mem_gen_1_0_ total_design_blk_mem_gen_1_0_sim_netlist.v
// Design      : total_design_blk_mem_gen_1_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "total_design_blk_mem_gen_1_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module total_design_blk_mem_gen_1_0
   (clka,
    wea,
    addra,
    dina,
    douta,
    clkb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [9:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire [3:0]wea;
  wire [3:0]web;
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
  (* C_BYTE_SIZE = "8" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.9299 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
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
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
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
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  total_design_blk_mem_gen_1_0_blk_mem_gen_v8_4_12 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
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
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 28080)
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
