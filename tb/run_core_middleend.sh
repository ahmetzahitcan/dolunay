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

TRACE=""
if [ "$1" = "--wave" ]; then
    TRACE="--trace-fst --trace-structs -DWAVE"
fi

# 1) Dependency checkouts (fpnew, common_cells, ...) + their defines, taken
#    verbatim from Bender, but without the project's own src/tb entries.
bender script verilator | grep -vE "/dolunay/(src|tb)/" > sim/middleend.f

# NOTE: paths in a -F list are resolved relative to the list's directory
# (sim/), hence the ../ prefixes.

# 2) Project packages first, in dependency order.
printf '%s\n' \
    ../src/params_pkg.sv \
    ../src/control_unit_pkg.sv \
    ../src/core_pkg.sv \
    ../tb/tb_config_pkg.sv >> sim/middleend.f

# 3) Remaining project RTL (order-independent), then the testbench.
ls src/*.sv | grep -vE '_pkg\.sv$' | sed 's|^|../|' >> sim/middleend.f
printf '%s\n' ../tb/tb_core_middleend.sv >> sim/middleend.f

verilator --binary --timing $TRACE -Wall -Wno-fatal \
    --top-module tb_core_middleend --Mdir sim/obj_core_middleend -o tb_core_middleend_sim \
    -F sim/middleend.f

./sim/obj_core_middleend/tb_core_middleend_sim

if [ "$1" = "--wave" ]; then
    echo
    echo "waveform: sim/tb_core_middleend.fst"
fi
