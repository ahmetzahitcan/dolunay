#!/usr/bin/env sh
# =============================================================================
# run_register_file.sh — build and run the register-file unit testbench
#
#   sh tb/run_register_file.sh
#
# Runs one standalone, self-checking testbench:
#   * tb_register_file against src/register_file.sv
#
# Requires Verilator. Waveforms are not dumped; the TB is self-checking.
# =============================================================================
set -e
cd "$(dirname "$0")/.."

echo
echo "==============================================================="
echo " register_file unit test (src/register_file.sv)"
echo "==============================================================="
verilator --binary --timing -Wall -Wno-fatal --top-module tb_register_file \
    --Mdir sim/obj_register_file -o tb_register_file_sim \
    src/params_pkg.sv src/register_file.sv tb/tb_register_file.sv
./sim/obj_register_file/tb_register_file_sim

echo
echo "done."
