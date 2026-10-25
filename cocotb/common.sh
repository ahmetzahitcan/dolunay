#!/usr/bin/env sh
# =============================================================================
# common.sh — shared helpers for the cocotb testbenches.
#
# setup_env
#     Puts the cocotb virtualenv and a new enough Verilator on the PATH, and
#     fails with a helpful message if either is missing.
#
# makefile
#     Echoes the path of a copy of the cocotb Makefile with LF line endings.
#     The project lives on a Windows filesystem where the line endings are
#     CRLF, and GNU Make does not strip the CR: a recipe line would end up
#     being "make sim\r", which fails. The copy is made outside the project,
#     so the tracked file is never touched.
#
# Environment:
#   DOLUNAY_COCOTB_VENV  the virtualenv cocotb is installed in
#                        (default: ~/venvs/dolunay-cocotb)
#   DOLUNAY_VERILATOR    the unpacked Verilator
#                        (default: ~/tools/verilator-5.048)
#   DOLUNAY_BUILD_DIR    where the Verilator build trees go
#                        (default: ~/dolunay-sim, same as tb/common.sh)
# =============================================================================

VENV="${DOLUNAY_COCOTB_VENV:-$HOME/venvs/dolunay-cocotb}"
VERILATOR_HOME="${DOLUNAY_VERILATOR:-$HOME/tools/verilator-5.048}"
BUILD_ROOT="${DOLUNAY_BUILD_DIR:-$HOME/dolunay-sim}"

# The oldest Verilator cocotb 2.x works with.
VERILATOR_MIN_VERSION=5.036

setup_env() {
    if [ ! -x "$VENV/bin/cocotb-config" ]; then
        echo "ERROR: cocotb is not installed in $VENV" >&2
        echo "       python3 -m venv $VENV && $VENV/bin/pip install cocotb" >&2
        exit 1
    fi
    PATH="$VENV/bin:$PATH"

    # cocotb 2.x needs Verilator 5.036 or later. The distribution package is
    # 5.020, which is too old, so a newer one is unpacked under ~/tools and
    # used from there. The distribution Verilator is left alone, because the
    # SystemVerilog testbenches in tb/ are verified against it.
    if [ -x "$VERILATOR_HOME/usr/bin/verilator" ]; then
        PATH="$VERILATOR_HOME/usr/bin:$PATH"
    fi
    export PATH

    if ! command -v verilator > /dev/null 2>&1; then
        echo "ERROR: verilator not found." >&2
        echo "       Unpack one into $VERILATOR_HOME, or point" >&2
        echo "       DOLUNAY_VERILATOR at it." >&2
        exit 1
    fi

    _verilator_version=$(verilator --version | cut -d " " -f 2)
    if [ "$(printf '%s\n%s\n' "$VERILATOR_MIN_VERSION" "$_verilator_version" \
            | sort -V | head -1)" != "$VERILATOR_MIN_VERSION" ]; then
        echo "ERROR: Verilator $_verilator_version is too old for cocotb," >&2
        echo "       $VERILATOR_MIN_VERSION or later is needed." >&2
        echo "       Unpack one into $VERILATOR_HOME, or point" >&2
        echo "       DOLUNAY_VERILATOR at it." >&2
        exit 1
    fi
}

# Echoes the path of the LF-normalised copy of the Makefile.
makefile() {
    _src="$1"
    _name=$(basename "$_src")
    _dir=$(dirname "$_src")
    if [ "$_dir" != "." ]; then
        _name="$(printf '%s' "$_dir" | tr '/' '_')_$_name"
    fi
    _dst="$BUILD_ROOT/cocotb/makefiles/$_name"
    mkdir -p "$(dirname "$_dst")"
    sed 's/\r$//' "$_src" > "$_dst"
    echo "$_dst"
}
