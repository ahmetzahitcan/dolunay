.section .text
.include "instructions.s"

# =============================================================================
# branch_test.s - exhaustive branch-type / branch-result test
# =============================================================================
#
# Exercises every RISC-V branch type (BEQ, BNE, BLT, BGE, BLTU, BGEU) against
# all three architectural branch results:
#
#     UNIFORM_ALL  - every active thread takes the branch
#     UNIFORM_NONE - no active thread takes the branch
#     DIVERGENT    - some active threads take the branch, others do not
#
# The program is warp-independent: every per-thread value is derived from the
# thread id, which the simulator leaves in every integer register as
# ((WARP_ID << 16) | THREAD_ID).  Consequently every active warp executes the
# exact same sequence of branches with the exact same results, which is what
# tb/tb_branch.sv checks.
#
# Branch result is observed by tb/tb_branch.sv on the branch unit outputs; the
# program itself only arranges for the operands / taken-thread set.
# =============================================================================

_start:
    andi x20, x20, 7            # x20 := thread id (0..7)

    # =========================================================================
    # UNIFORM_ALL / UNIFORM_NONE section.
    #
    # Before the first DIVERGENT branch the active mask is the full warp, so
    # every classification below is made against mask 0xFF and no thread is
    # ever removed.
    #
    # Layout per test:
    #     <branch> ok_label ; j .          -> uniform-all jumps over the trap
    #     ok_label: <branch> trap          -> uniform-none falls through
    #
    # A mis-classified uniform branch lands in a trap (an infinite loop), which
    # the testbench reports as a timeout / missing branch event.
    # =========================================================================

    # ---- BEQ ----
    li   x21, 0x10
    li   x22, 0x10
    beq  x21, x22, ok_beq_ua
    j    .
ok_beq_ua:
    li   x21, 0x10
    li   x22, 0x20
    beq  x21, x22, trap          # uniform none

    # ---- BNE ----
    li   x21, 1
    li   x22, 2
    bne  x21, x22, ok_bne_ua
    j    .
ok_bne_ua:
    li   x21, 3
    li   x22, 3
    bne  x21, x22, trap          # uniform none

    # ---- BLT (signed) ----
    li   x21, -1
    li   x22, 1
    blt  x21, x22, ok_blt_ua
    j    .
ok_blt_ua:
    li   x21, 1
    li   x22, -1
    blt  x21, x22, trap          # uniform none

    # ---- BGE (signed) ----
    li   x21, 1
    li   x22, -1
    bge  x21, x22, ok_bge_ua
    j    .
ok_bge_ua:
    li   x21, -1
    li   x22, 1
    bge  x21, x22, trap          # uniform none

    # ---- BLTU (unsigned) ----
    li   x21, 1
    li   x22, -1
    bltu x21, x22, ok_bltu_ua
    j    .
ok_bltu_ua:
    li   x21, -1
    li   x22, 1
    bltu x21, x22, trap          # uniform none

    # ---- BGEU (unsigned) ----
    li   x21, -1
    li   x22, 1
    bgeu x21, x22, ok_bgeu_ua
    j    .
ok_bgeu_ua:
    li   x21, 1
    li   x22, -1
    bgeu x21, x22, trap          # uniform none

    # =========================================================================
    # DIVERGENT section.
    #
    # Each branch takes exactly one more thread and parks it in `trap`; the
    # fall-through threads stay active and continue.  The taken set therefore
    # shrinks by one thread per branch:
    #
    #     active before    branch   taken   active after
    #     {0..7}           beq      {0}     {1..7}
    #     {1..7}           bne      {7}     {1..6}
    #     {1..6}           blt      {1}     {2..6}
    #     {2..6}           bge      {6}     {2..5}
    #     {2..5}           bltu     {2}     {3..5}
    #     {3..5}           bgeu     {5}     {3,4}
    # =========================================================================

    li   x23, 0
    beq  x20, x23, trap          # taken = {0}

    sltiu x24, x20, 7            # x24 = (thread id < 7)
    li   x25, 1
    bne  x24, x25, trap          # taken = {7}

    li   x23, 2
    blt  x20, x23, trap          # taken = {1}

    li   x23, 6
    bge  x20, x23, trap          # taken = {6}

    li   x23, 3
    bltu x20, x23, trap          # taken = {2}

    li   x23, 5
    bgeu x20, x23, trap          # taken = {5}

    # Remaining active threads ({3,4}) park here forever.
end:
    j    end

    # Parked / diverged threads (and any mis-classified branch) land here.
    # They are never re-scheduled: the front-end has no path-switching yet.
trap:
    j    trap
