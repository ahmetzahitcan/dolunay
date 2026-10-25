#!/usr/bin/env sh
# =============================================================================
# common.sh — shared helpers for the tb/run_*.sh scripts.
#
# gen_filelist <list-path> <testbench>
#
# Writes a Verilator -F file list to <list-path>, containing:
#   1. the Bender-managed dependencies (fpnew, common_cells, ...) and their
#      defines,
#   2. the project's packages, in dependency order,
#   3. the rest of the project's RTL,
#   4. the testbench.
#
# The caller's <list-path> is expected to live in sim/.
# =============================================================================

gen_filelist() {
    _list="$1"
    _tb="$2"

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
        | sed -e "s|$(pwd)|..|g" -e "s|$(pwd -P)|..|g" \
        | awk '! /^\.\.\/(src|tb)\//' > "$_list"

    # 2) Project packages first, in dependency order.
    printf '%s\n' \
        ../src/params_pkg.sv \
        ../src/control_unit_pkg.sv \
        ../src/core_pkg.sv \
        ../tb/tb_config_pkg.sv >> "$_list"

    # 3) Remaining project RTL (order-independent), then the testbench.
    ls src/*.sv | grep -vE '_pkg\.sv$' | sed 's|^|../|' >> "$_list"
    printf '%s\n' "$_tb" >> "$_list"
}
