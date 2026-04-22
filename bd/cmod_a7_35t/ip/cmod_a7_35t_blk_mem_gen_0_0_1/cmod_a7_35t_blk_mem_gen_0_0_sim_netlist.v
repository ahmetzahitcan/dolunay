// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Wed Apr 22 18:07:19 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/azc/Belgeler/dolunay/bd/cmod_a7_35t/ip/cmod_a7_35t_blk_mem_gen_0_0_1/cmod_a7_35t_blk_mem_gen_0_0_sim_netlist.v
// Design      : cmod_a7_35t_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "cmod_a7_35t_blk_mem_gen_0_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module cmod_a7_35t_blk_mem_gen_0_0
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
  (* C_INIT_FILE_NAME = "cmod_a7_35t_blk_mem_gen_0_0.mif" *) 
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
  cmod_a7_35t_blk_mem_gen_0_0_blk_mem_gen_v8_4_12 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27328)
`pragma protect data_block
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
0w/o/CYPkgoyvSWleVbUyA5Kt9UY9VpQEQ==
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
