#!/usr/bin/env sh
# =============================================================================
# common.sh — shared helpers for the tb/run_*.sh scripts.
#
# gen_filelist <list-path> <testbench> [rtl-file ...]
#     Writes a Verilator -F file list to <list-path>, containing:
#       1. the Bender-managed dependencies (fpnew, common_cells, ...) and
#          their defines,
#       2. the project's packages, in dependency order,
#       3. the project's RTL (all of src/*.sv by default, or the given files),
#       4. the testbench.
#
# verilator_build <name> <top-module> <filelist> [extra verilator flags...]
#     Builds <name> into the build directory, then runs it.
#
# Environment:
#   BENDER_FILTER   "all" (default) or "fpnew_pkg" — which parts of the
#                   fpnew checkout to include. "fpnew_pkg" keeps only the
#                   package, which is all a testbench needs if it never
#                   instantiates the FPU. It cuts the build time a lot.
#   DOLUNAY_BUILD_DIR
#                   Where to put the Verilator build trees (see BUILD_ROOT).
# =============================================================================

# GNU Make refuses to build in a directory whose path contains spaces
# (verilated.mk). The project itself may well live under such a path (e.g.
# under OneDrive), so the build tree is kept outside the project by default.
BUILD_ROOT="${DOLUNAY_BUILD_DIR:-$HOME/dolunay-sim}"

bender_files() {
    case "$1" in
        all)       cat ;;
        fpnew_pkg) grep -E '/fpnew_pkg\.sv$' ;;
        *)         echo "common.sh: unknown bender filter '$1'" >&2; exit 1 ;;
    esac
}

gen_filelist() {
    _list="$1"
    _tb="$2"
    shift 2

    mkdir -p "$(dirname "$_list")"

    # 1) Dependency checkouts (fpnew, common_cells, ...) + their defines,
    #    taken verbatim from Bender, but without the project's own src/tb
    #    entries (those are added below, in dependency order).
    #
    #    Bender emits absolute paths rooted at the project directory. They are
    #    rewritten to be relative to the list's own directory (sim/), because
    #    Verilator splits -F entries on whitespace: a checkout path containing
    #    a space would be torn into bogus options. This also keeps the list
    #    portable if the project is moved.
    bender script verilator \
        | bender_files "${BENDER_FILTER:-all}" \
        | sed -e "s|$(pwd)|..|g" -e "s|$(pwd -P)|..|g" \
        | awk '! /^\.\.\/(src|tb)\//' > "$_list"

    # 2) Project packages first, in dependency order.
    printf '%s\n' \
        ../src/params_pkg.sv \
        ../src/control_unit_pkg.sv \
        ../src/core_pkg.sv \
        ../tb/tb_config_pkg.sv >> "$_list"

    # 3) The project's RTL, then the testbench.
    if [ "$#" -gt 0 ]; then
        for _f in "$@"; do
            printf '%s\n' "../$_f" >> "$_list"
        done
    else
        ls src/*.sv | grep -vE '_pkg\.sv$' | sed 's|^|../|' >> "$_list"
    fi
    printf '%s\n' "$_tb" >> "$_list"
}

verilator_build() {
    _name="$1"
    _top="$2"
    _flist="$3"
    shift 3

    _mdir="$BUILD_ROOT/$_name"
    mkdir -p "$_mdir"

    verilator --binary --timing "$@" --assert -Wall -Wno-fatal \
        --top-module "$_top" --Mdir "$_mdir" -o "$_name" -F "$_flist"

    "$_mdir/$_name"
}
