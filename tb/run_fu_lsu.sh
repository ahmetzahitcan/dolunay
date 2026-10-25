#!/usr/bin/env sh
# =============================================================================
# run_fu_lsu.sh — build and run tb_fu_lsu (load/store unit testbench)
#
#   sh tb/run_fu_lsu.sh            # plain run
#   sh tb/run_fu_lsu.sh --wave     # also dump sim/tb_fu_lsu.fst
#
# Requires Verilator and Bender (the checkouts live under .bender/).
# =============================================================================
set -e
cd "$(dirname "$0")/.."

. ./tb/common.sh

TRACE=""
if [ "$1" = "--wave" ]; then
    TRACE="--trace-fst --trace-structs -DWAVE"
fi

# The testbench does not instantiate the FPU, so only the fpnew package is
# needed from the Bender checkout. That keeps the build fast.
BENDER_FILTER=fpnew_pkg

# 1) File list: Bender dependencies, project packages, the LSU and the blocks
#    it needs, and the testbench.
gen_filelist sim/fu_lsu.f ../tb/tb_fu_lsu.sv \
    src/fu_lsu.sv \
    src/mem_read_formatter.sv \
    src/mem_write_formatter.sv \
    src/ram.sv \
    src/scratchpad.sv

# 2) Build and run.
verilator_build fu_lsu tb_fu_lsu sim/fu_lsu.f $TRACE

if [ "$1" = "--wave" ]; then
    echo
    echo "waveform: sim/tb_fu_lsu.fst"
fi
