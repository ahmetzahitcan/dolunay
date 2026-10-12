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

TRACE=""
if [ "$1" = "--wave" ]; then
    TRACE="--trace-fst --trace-structs -DWAVE"
fi

# 1) Dependency checkouts (fpnew, common_cells, ...) + their defines.
bender script verilator | grep -vE "/dolunay/(src|tb)/" > sim/core_top.f

# 2) Project packages first, in dependency order.
printf '%s\n' \
    ../src/params_pkg.sv \
    ../src/control_unit_pkg.sv \
    ../src/core_pkg.sv \
    ../tb/tb_config_pkg.sv >> sim/core_top.f

# 3) Remaining project RTL, then the testbench.
ls src/*.sv | grep -vE '_pkg\.sv$' | sed 's|^|../|' >> sim/core_top.f
printf '%s\n' ../tb/tb_core_top.sv >> sim/core_top.f

verilator --binary --timing $TRACE --assert -Wall -Wno-fatal \
    --top-module tb_core_top --Mdir sim/obj_core_top -o tb_core_top_sim \
    -F sim/core_top.f

./sim/obj_core_top/tb_core_top_sim

if [ "$1" = "--wave" ]; then
    echo
    echo "waveform: sim/tb_core_top.fst"
fi
