// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Sat May  9 15:58:41 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/azc/Belgeler/dolunay/bd/total_design/ip/total_design_blk_mem_gen_1_0/total_design_blk_mem_gen_1_0_sim_netlist.v
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 28368)
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
