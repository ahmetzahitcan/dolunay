// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Sun May 10 22:40:55 2026
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
sUNEumA=
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
