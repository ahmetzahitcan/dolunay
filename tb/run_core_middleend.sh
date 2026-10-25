#!/usr/bin/env sh
# =============================================================================
# run_core_middleend.sh — build and run tb_core_middleend
#
#   sh tb/run_core_middleend.sh            # plain run
#   sh tb/run_core_middleend.sh --wave     # also dump sim/tb_core_middleend.fst
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

# 1) File list: Bender dependencies, project packages, project RTL, testbench.
gen_filelist sim/middleend.f ../tb/tb_core_middleend.sv

# 2) Build and run.
verilator_build core_middleend tb_core_middleend sim/middleend.f $TRACE

if [ "$1" = "--wave" ]; then
    echo
    echo "waveform: sim/tb_core_middleend.fst"
fi
