#!/usr/bin/env sh
# =============================================================================
# run_scoreboard.sh — build and run the scoreboard unit testbenches
#
#   sh tb/run_scoreboard.sh
#
# Runs two standalone, self-checking testbenches:
#   * tb_scoreboard      against src/scoreboard.sv      (per-register scoreboard)
#   * tb_scoreboard_mask against src/scoreboard_mask.sv (hazard mask scoreboard)
#
# Requires Verilator. Waveforms are not dumped; the TBs are self-checking.
# =============================================================================
set -e
cd "$(dirname "$0")/.."

echo
echo "==============================================================="
echo " scoreboard unit test (src/scoreboard.sv)"
echo "==============================================================="
verilator --binary --timing -Wall -Wno-fatal --top-module tb_scoreboard \
    --Mdir sim/obj_scoreboard -o tb_scoreboard_sim \
    src/params_pkg.sv tb/tb_config_pkg.sv src/scoreboard.sv tb/tb_scoreboard.sv
./sim/obj_scoreboard/tb_scoreboard_sim

echo
echo "==============================================================="
echo " scoreboard_mask unit test (src/scoreboard_mask.sv)"
echo "==============================================================="
verilator --binary --timing -Wall -Wno-fatal --top-module tb_scoreboard_mask \
    --Mdir sim/obj_scoreboard_mask -o tb_scoreboard_mask_sim \
    src/params_pkg.sv tb/tb_config_pkg.sv src/scoreboard_mask.sv tb/tb_scoreboard_mask.sv
./sim/obj_scoreboard_mask/tb_scoreboard_mask_sim

echo
echo "done."
