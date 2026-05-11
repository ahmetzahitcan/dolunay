transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/axi_uartlite_v2_0_39
vlib riviera/blk_mem_gen_v8_4_12
vlib riviera/proc_sys_reset_v5_0_17

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap axi_uartlite_v2_0_39 riviera/axi_uartlite_v2_0_39
vmap blk_mem_gen_v8_4_12 riviera/blk_mem_gen_v8_4_12
vmap proc_sys_reset_v5_0_17 riviera/proc_sys_reset_v5_0_17

vlog -work xpm  -incr "+incdir+../../../../../bd/total_design/ipshared/a415" "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" -l xpm -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l axi_uartlite_v2_0_39 -l blk_mem_gen_v8_4_12 -l proc_sys_reset_v5_0_17 \
"/home/azc/Xilinx/2025.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/azc/Xilinx/2025.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/home/azc/Xilinx/2025.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../../bd/total_design/ipshared/a415" "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" -l xpm -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l axi_uartlite_v2_0_39 -l blk_mem_gen_v8_4_12 -l proc_sys_reset_v5_0_17 \
"../../../bd/total_design/ip/total_design_host_top_wrapper_0_0/sim/total_design_host_top_wrapper_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  -incr \
"../../../../../bd/total_design/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work axi_uartlite_v2_0_39 -93  -incr \
"../../../../../bd/total_design/ipshared/eab1/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/total_design/ip/total_design_axi_uartlite_0_0/sim/total_design_axi_uartlite_0_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../../bd/total_design/ipshared/a415" "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" -l xpm -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l axi_uartlite_v2_0_39 -l blk_mem_gen_v8_4_12 -l proc_sys_reset_v5_0_17 \
"../../../bd/total_design/ip/total_design_core_top_0_0/sim/total_design_core_top_0_0.v" \

vlog -work blk_mem_gen_v8_4_12  -incr -v2k5 "+incdir+../../../../../bd/total_design/ipshared/a415" "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" -l xpm -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l axi_uartlite_v2_0_39 -l blk_mem_gen_v8_4_12 -l proc_sys_reset_v5_0_17 \
"../../../../../bd/total_design/ipshared/42f3/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../../bd/total_design/ipshared/a415" "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" -l xpm -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l axi_uartlite_v2_0_39 -l blk_mem_gen_v8_4_12 -l proc_sys_reset_v5_0_17 \
"../../../bd/total_design/ip/total_design_blk_mem_gen_0_0/sim/total_design_blk_mem_gen_0_0.v" \
"../../../bd/total_design/ip/total_design_blk_mem_gen_1_0/sim/total_design_blk_mem_gen_1_0.v" \
"../../../bd/total_design/ip/total_design_clk_wiz_0/total_design_clk_wiz_0_clk_wiz.v" \
"../../../bd/total_design/ip/total_design_clk_wiz_0/total_design_clk_wiz_0.v" \

vcom -work proc_sys_reset_v5_0_17 -93  -incr \
"../../../../../bd/total_design/ipshared/9438/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/total_design/ip/total_design_rst_clk_wiz_100M_0/sim/total_design_rst_clk_wiz_100M_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../../bd/total_design/ipshared/a415" "+incdir+../../../../../../../Xilinx/2025.2/data/rsb/busdef" -l xpm -l xil_defaultlib -l axi_lite_ipif_v3_0_4 -l axi_uartlite_v2_0_39 -l blk_mem_gen_v8_4_12 -l proc_sys_reset_v5_0_17 \
"../../../bd/total_design/sim/total_design.v" \

vlog -work xil_defaultlib \
"glbl.v"

