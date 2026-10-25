#!/usr/bin/env sh
# =============================================================================
# setup.sh — prepare the cocotb environment in WSL.
#
#   sh cocotb/setup.sh
#
# It does two things:
#
#   1. creates the virtualenv cocotb is installed in
#      (~/venvs/dolunay-cocotb by default),
#
#   2. unpacks a Verilator that is new enough for cocotb into ~/tools.
#      cocotb 2.x needs Verilator 5.036 or later; Ubuntu 24.04 ships 5.020,
#      which is too old. The distribution Verilator is left alone, because the
#      SystemVerilog testbenches in tb/ are verified against it.
#
# The environment variables are the same as in cocotb/common.sh.
# =============================================================================
set -e

VENV="${DOLUNAY_COCOTB_VENV:-$HOME/venvs/dolunay-cocotb}"
TOOLS="${DOLUNAY_TOOLS:-$HOME/tools}"
VERILATOR_VERSION="${DOLUNAY_VERILATOR_VERSION:-5.048-1}"
VERILATOR_HOME="${DOLUNAY_VERILATOR:-$TOOLS/verilator-${VERILATOR_VERSION%-1}}"

# 1) The cocotb virtualenv.
#
# The virtualenv lives outside the repository: it is per-machine state and is
# never version controlled. What the repository pins is the list of packages
# that goes into it, in requirements.txt.
#
if [ ! -x "$VENV/bin/cocotb-config" ]; then
    echo "creating the virtualenv in $VENV"
    python3 -m venv "$VENV"
    "$VENV/bin/pip" install --upgrade pip
fi

if [ -f requirements.txt ]; then
    "$VENV/bin/pip" install -r requirements.txt
else
    "$VENV/bin/pip" install cocotb
fi

# 2) A Verilator that is new enough.
#
# The Debian package is unpacked rather than installed, because installing it
# would need root and would replace the distribution Verilator.
if [ -x "$VERILATOR_HOME/usr/bin/verilator" ]; then
    echo "Verilator is already unpacked in $VERILATOR_HOME"
else
    echo "unpacking Verilator $VERILATOR_VERSION into $VERILATOR_HOME"
    mkdir -p "$VERILATOR_HOME"
    cd "$VERILATOR_HOME"
    curl -sL -O "https://deb.debian.org/debian/pool/main/v/verilator/verilator_${VERILATOR_VERSION}_amd64.deb"
    ar x "verilator_${VERILATOR_VERSION}_amd64.deb"
    tar xf data.tar.xz
    rm -f data.tar.xz control.tar.xz debian-binary
    "$VERILATOR_HOME/usr/bin/verilator" --version
fi

echo
echo "done. Run the testbench with:"
echo "    sh cocotb/run_mock.sh"
