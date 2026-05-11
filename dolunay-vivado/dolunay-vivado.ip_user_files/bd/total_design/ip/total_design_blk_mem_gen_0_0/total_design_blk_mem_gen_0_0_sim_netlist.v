// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Sun May 10 22:12:47 2026
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_WRITE_MODE READ_ONLY, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
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
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     9.7422 mW" *) 
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
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
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
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 45776)
`pragma protect data_block
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
rJ4hI9w=
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
