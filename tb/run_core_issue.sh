#!/usr/bin/env sh
# =============================================================================
# run_core_issue.sh — build and run tb_core_issue
#
#   sh tb/run_core_issue.sh            # plain run
#   sh tb/run_core_issue.sh --wave     # also dump sim/tb_core_issue.fst
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
    --top-module tb_core_issue --Mdir sim/obj_core_issue -o tb_core_issue_sim \
    "$FPNEW" \
    src/params_pkg.sv src/control_unit_pkg.sv src/fu_pkg.sv \
    src/immediate_decoder.sv src/sim__instr_formatter.sv src/control_unit.sv \
    src/warp_scheduler.sv src/thread_scheduler.sv src/core_issue.sv \
    tb/tb_config_pkg.sv tb/tb_core_issue.sv

./sim/obj_core_issue/tb_core_issue_sim

if [ "$1" = "--wave" ]; then
    echo
    echo "waveform: sim/tb_core_issue.fst"
fi
