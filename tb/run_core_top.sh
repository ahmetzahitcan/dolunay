#!/usr/bin/env sh
# =============================================================================
# run_core_top.sh — build and run tb_core_top (core_top integration smoke test)
#
#   sh tb/run_core_top.sh            # plain run
#   sh tb/run_core_top.sh --wave     # also dump sim/tb_core_top.fst
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
gen_filelist sim/core_top.f ../tb/tb_core_top.sv

# 2) Build and run.
verilator_build core_top tb_core_top sim/core_top.f $TRACE

if [ "$1" = "--wave" ]; then
    echo
    echo "waveform: sim/tb_core_top.fst"
fi
