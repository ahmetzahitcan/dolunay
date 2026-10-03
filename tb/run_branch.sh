#!/usr/bin/env sh
# =============================================================================
# run_branch.sh — build and run the full-core branch testbench
#
#   sh tb/run_branch.sh
#
# Assembles asm-kernels/branch_test.s, then runs tb/tb_branch.sv with
# FORCE_WARP_COUNT set to 1, 2 and 4 active warps:
#
#   FORCE_WARP_COUNT=1  -> sim/tb_branch_1warp.fst
#   FORCE_WARP_COUNT=2  -> sim/tb_branch_2warp.fst
#   FORCE_WARP_COUNT=4  -> sim/tb_branch_4warp.fst
#
# Requires Verilator, a riscv64 toolchain and the Bender checkouts under
# .bender/.  The waveform dumps live in sim/ (git-ignored).
# =============================================================================
set -e
cd "$(dirname "$0")/.."

# ---------------------------------------------------------------------------
# Assemble the branch test program into irom.mem (read by src/irom.sv).
# ---------------------------------------------------------------------------
sh asm-kernels/generate.sh branch_test.s

# ---------------------------------------------------------------------------
# Build + run one warp mode.
# ---------------------------------------------------------------------------
run_mode() {
    label="$1"
    count="$2"

    echo
    echo "==============================================================="
    echo " branch test: ${label} (FORCE_WARP_COUNT=${count})"
    echo "==============================================================="

    verilator -F bender.verilator -O0 --top tb_branch \
        --trace-fst --trace-structs --binary -Wno-fatal \
        -Mdir "sim/obj_branch_${label}" -o "tb_branch_${label}_sim" \
        "+define+FORCE_WARP_COUNT=${count}" tb/tb_branch.sv

    # Don't let a failing DUT abort the remaining modes.
    "./sim/obj_branch_${label}/tb_branch_${label}_sim" || true
}

run_mode one  1
run_mode two  2
run_mode four 4

echo
echo "waveforms:"
echo "  sim/tb_branch_1warp.fst"
echo "  sim/tb_branch_2warp.fst"
echo "  sim/tb_branch_4warp.fst"
