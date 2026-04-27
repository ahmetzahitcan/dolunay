// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Mon Apr 27 11:45:54 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/azc/Belgeler/dolunay/bd/total_design/ip/total_design_blk_mem_gen_0_0/total_design_blk_mem_gen_0_0_sim_netlist.v
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27344)
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
