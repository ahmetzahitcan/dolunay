#!/usr/bin/env sh
# =============================================================================
# run_mock.sh — run the cocotb mock testbench.
#
#   sh cocotb/run_mock.sh            # run it
#   sh cocotb/run_mock.sh --wave     # also dump a VCD trace
#
# Any other argument is passed on to make, e.g.
#
#   sh cocotb/run_mock.sh COCOTB_LOG_LEVEL=DEBUG
# =============================================================================
set -e
cd "$(dirname "$0")"

. ./common.sh
setup_env

WAVE=""
if [ "$1" = "--wave" ]; then
    WAVE="WAVE=1"
    shift
fi

exec make -f "$(makefile Makefile)" $WAVE "$@"
