onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc"  -L xil_defaultlib -L xpm -L axi_lite_ipif_v3_0_4 -L axi_uartlite_v2_0_39 -L blk_mem_gen_v8_4_12 -L proc_sys_reset_v5_0_17 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.total_design xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {total_design.udo}

run 1000ns

quit -force
