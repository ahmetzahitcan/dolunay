#!/usr/bin/env sh
# =============================================================================
# run_register_file.sh — build and run the register-file unit testbench
#
#   sh tb/run_register_file.sh
#
# Runs one standalone, self-checking testbench:
#   * tb_register_file_2port against src/register_file_2port.sv
#
# Requires Verilator. Waveforms are not dumped; the TB is self-checking.
# =============================================================================
set -e
cd "$(dirname "$0")/.."

echo
echo "==============================================================="
echo " register_file_2port unit test (src/register_file_2port.sv)"
echo "==============================================================="
verilator --binary --timing -Wall -Wno-fatal --top-module tb_register_file_2port \
    --Mdir sim/obj_register_file_2port -o tb_register_file_2port_sim \
    src/params_pkg.sv src/register_file_2port.sv tb/tb_register_file_2port.sv
./sim/obj_register_file_2port/tb_register_file_2port_sim

echo
echo "done."
