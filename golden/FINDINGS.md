# Findings outside `golden/`

**Status: informative.** Problems noticed while working on the model, in files
`golden/` must not edit (`AGENTS.md` §3). Each is something to report to the
owner of that file, not to fix from here.

Append new findings at the bottom. When one is resolved, mark it
`resolved <date>: <how>` instead of deleting it. Each entry says how it was
checked, so a later reader can re-verify it.

---

## F1 — Kernel builds dirty tracked files at the repository root

Found 2026-11-06. Checked: `git ls-files`, `ss/generate.sh:22-23`,
`asm-kernels/generate.sh:22-23`.

`irom.mem` and `irom.coe` are tracked, and both `generate.sh` scripts overwrite
them in the repository root, so every kernel build shows up as a change.
`irom.mem` is a hex text file of 1951 words (7804 bytes).

## F2 — Thread-scheduler testbench disagrees with the parameters package

Found 2026-11-06. Checked: `tb/tb_thread_scheduler.sv:7`,
`src/params_pkg.sv:26`.

The testbench sets `N_THREADS = 32`; `params_pkg.sv` sets `N_THREADS = 8`.

## F3 — Software headers assume a different geometry from the RTL

Found 2026-11-06. Checked: `ss/hdr/simt.h:10-11`, `src/params_pkg.sv:25-26`.

`simt.h` says 4 warps × 8 lanes; the RTL says 8 × 8. (Geometry for the model is
undecided either way — `CONTRACT.md` §2.)

## F4 — `nearn` resets its result without synchronisation

Found 2026-11-06. Checked: `ss/kernels/nearn.c:22`, `ss/kernels/nearn.c:46-55`.
Status: **kept on purpose** — the maintainer left it, with a comment, as a test
the model's determinacy check must catch (`CONTRACT.md` §1). Do not fix it.

Every lane executes `*result_dist = 0xFFFFFFFF;` at the start, with no barrier
between that store and the final update under `mutex`. If one warp finishes and
publishes its best result before a lane of another warp has executed the reset,
the reset discards it, and the final result depends on the schedule.
`*result_idx` is not reset at all.

## F5 — `spmc` initialises its handoff flag without synchronisation

Found 2026-11-06. Checked: `ss/kernels/spmc.c:51`, `ss/kernels/spmc.c:17-24`,
`ss/kernels/spmc.c:31-33`.
Status: **kept on purpose** — like F4, a test the model's determinacy check must
catch. Do not fix it.

Every lane executes `data_idx = -1;` before calling `producer()` or
`consumer()`, with no barrier. If a lane executes that store after the producer
has published an item, it erases the publication: consumers that have not read
it yet, including that lane, spin on `data_idx < i` forever, and the producer
spins on `read_cnt` waiting for them. The run never ends, and since the lanes
spin with `yield` it ends as `timeout`, not `deadlock`. The previous variant
probably never exposed this, because all warps start together; under the new
spec, a schedule that starts one warp late is valid (`CONTRACT.md` §1).
