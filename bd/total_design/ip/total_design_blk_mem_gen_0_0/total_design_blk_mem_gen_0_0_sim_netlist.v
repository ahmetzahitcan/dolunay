// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Sun May 10 17:43:03 2026
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
Q9+I8lU=
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
