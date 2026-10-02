#!/usr/bin/env sh
# =============================================================================
# run_branch.sh — build and run the full-core branch testbench
#
#   sh tb/run_branch.sh
#
# Assembles asm-kernels/branch_test.s, then runs tb/tb_branch.sv three times:
#
#   single-warp mode  -> sim/tb_branch_single.fst
#   two-warp mode     -> sim/tb_branch_two.fst
#   four-warp mode    -> sim/tb_branch_four.fst
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
    mode="$1"
    define="$2"

    echo
    echo "==============================================================="
    echo " branch test: ${mode}-warp mode (define ${define})"
    echo "==============================================================="

    verilator -F bender.verilator -O0 --top tb_branch \
        --trace-fst --trace-structs --binary -Wno-fatal \
        -Mdir "sim/obj_branch_${mode}" -o "tb_branch_${mode}_sim" \
        "+define+${define}" tb/tb_branch.sv

    # Don't let a failing DUT abort the remaining modes.
    "./sim/obj_branch_${mode}/tb_branch_${mode}_sim" || true
}

run_mode single SINGLE_WARP
run_mode two   TWO_WARP
run_mode four  FOUR_WARP

echo
echo "waveforms:"
echo "  sim/tb_branch_single.fst"
echo "  sim/tb_branch_two.fst"
echo "  sim/tb_branch_four.fst"
