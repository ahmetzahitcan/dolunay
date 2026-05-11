// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Mon May 11 09:47:33 2026
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
