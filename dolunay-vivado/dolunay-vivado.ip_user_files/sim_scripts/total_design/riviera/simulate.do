transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+total_design  -L xil_defaultlib -L xpm -L axi_lite_ipif_v3_0_4 -L axi_uartlite_v2_0_39 -L blk_mem_gen_v8_4_12 -L proc_sys_reset_v5_0_17 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.total_design xil_defaultlib.glbl

do {total_design.udo}

run 1000ns

endsim

quit -force
