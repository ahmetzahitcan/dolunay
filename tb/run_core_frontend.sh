#!/usr/bin/env sh
# =============================================================================
# run_core_frontend.sh — build and run tb_core_frontend
#
#   sh tb/run_core_frontend.sh            # plain run
#   sh tb/run_core_frontend.sh --wave     # also dump sim/tb_core_frontend.fst
#
# Requires Verilator and the Bender checkouts under .bender/.
# =============================================================================
set -e
cd "$(dirname "$0")/.."

FPNEW="$(ls -d .bender/git/checkouts/fpnew-*/src/fpnew_pkg.sv | head -n1)"

TRACE=""
if [ "$1" = "--wave" ]; then
    TRACE="--trace-fst --trace-structs -DWAVE"
fi

verilator --binary --timing $TRACE -Wall -Wno-fatal \
    --top-module tb_core_frontend --Mdir sim/obj_core_frontend -o tb_core_frontend_sim \
    "$FPNEW" \
    src/params_pkg.sv src/control_unit_pkg.sv src/core_pkg.sv \
    src/immediate_decoder.sv src/sim__instr_formatter.sv src/control_unit.sv \
    src/warp_scheduler.sv src/thread_scheduler.sv src/core_frontend.sv \
    tb/tb_config_pkg.sv tb/tb_core_frontend.sv

./sim/obj_core_frontend/tb_core_frontend_sim

if [ "$1" = "--wave" ]; then
    echo
    echo "waveform: sim/tb_core_frontend.fst"
fi
