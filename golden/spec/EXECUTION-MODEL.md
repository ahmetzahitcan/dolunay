# Execution model: warp program order, paths, lockstep

**Status: draft — not authoritative.** Started from the maintainer's proposal of
2026-11-07. §1–§3 are the rules as agreed so far; §4 is analysis behind them and
§5 the open questions. Nothing here binds the model or the RTL until the
maintainer approves the document and a decision records it (`../AGENTS.md` §5).
Points already recorded as decisions cite them. *TBD*, *unspecified* and
*illegal* have the meanings in [`README.md`](README.md#terminology).

---

## 1. Warp program order and warp state

RVWMO (RISC-V unprivileged specification, chapter "RVWMO Memory Consistency
Model") defines **program order** informally as the architectural order in
which a hart executes its instructions. Dolunay defines the **warp program
order** (WPO) of a warp the same way: the architectural order in which the warp
executes its instructions. Each element of the WPO is one instruction executed
by the warp's active path, on all of that path's lanes.

At every point of the WPO, the warp's **path state** is:

- a set of **paths**; each path is a set of lanes with one PC, and every lane of
  the warp belongs to exactly one path;
- each path in exactly one of three states:
  - **active** — exactly one path; it executes the next instruction;
  - **paused** — zero or more paths; ready to run, waiting for control;
  - **blocked** — zero or more paths; waiting in `bsync`, and not eligible to
    receive control from `yield`.

The path state is architectural state, carried through the WPO like any other.

## 2. How an instruction changes the path state

**Every instruction generates a set of next PCs.** It maps each lane of the
active path to one next PC — an N → 1 mapping from lanes to PCs. For most
instructions the set has one element, `pc + 4` (`pc + 2` for a compressed
instruction), so nothing changes; a branch or jump whose lanes all agree is the
same case. When the set has more than one element:

- the active path is split by the mapping, one new path per PC;
- the next active path is **one of the new paths** — which one is
  *unspecified* (a choice point, `../CONTRACT.md` §1);
- the other new paths are paused;
- every other path keeps its state.

Further rules:

- **`yield`** makes the active path paused and one paused path active — which
  one is *unspecified*, subject to the progress guarantee of D13. The
  set of paths does not change. With no paused path, `yield` does nothing.
- **`bsync`** is the only way paths combine. Its details are to be decided
  (§5); it does one of two things:
  - makes the active path blocked, and passes control to a paused path as
    `yield` does; or
  - combines the active path with a set of blocked paths into one active path.

  Which of the two happens is decided by a release condition still to be
  written, not left to the implementation. A `bsync` whose release condition
  does not hold while no path is paused is **illegal**: it would leave the warp
  without an active path. A correctly used barrier never gets there, because
  once every other path is blocked, the condition holds.
- **No implicit merging.** Two paths are never combined except by `bsync`, even
  when they reach the same PC. An implementation must not merge them, for
  example at a post-dominator (§4.2). Dolunay keeps a hardware path list, not a
  reconvergence stack.

## 3. Memory

**Provisionally, the memory model is RVWMO with "hart" read as "warp" and
"program order" read as "WPO".** Whether that holds up is to be analysed. In
particular, RVWMO's Load Value Axiom then says that a load returns the latest
store, to each byte, among those before it in the WPO and those before it in the
global memory order. So within a warp, a load sees the latest earlier store of
*any* lane, unless a store from another warp intervenes.

Exceptions to the substitution:

- **Dependencies are per lane.** Address, data and control dependencies flow
  through registers, which are per lane, so they relate only instructions of
  the same lane.
- **Standard LR/SC is per lane.** A reservation belongs to a lane, and a store
  by another lane of the same warp invalidates it, as a store by another hart
  would. (The expectation is that LR/SC is removed and replaced by a custom
  extension that works per warp; `../CONTRACT.md` §2.)
- **One WPO element holds the accesses of several lanes.** Their order is the
  one the spec fixes for a lockstep instruction (D14), which RVWMO does not
  have.

---

## 4. Analysis

### 4.1 Two sanity properties

- **A warp of one lane is a RISC-V hart.** It has one path, the WPO is its
  program order, and every rule above must reduce to the standard. This is a
  cheap test for every later rule.
- **Each lane's program order is the WPO restricted to the instructions its
  path executed.** Per-lane RISC-V semantics (registers, dependencies) are
  untouched; the WPO only adds an order between lanes.

### 4.2 Why implicit merging is observable

Take path A = lanes {0, 2} and path B = lanes {1, 3} at the same store
instruction; lanes 1 and 2 store to `x`, lanes 0 and 3 store to `y`. As two
paths, the stores take effect A then B (lanes 0, 2, 1, 3: `x` from lane 1, `y`
from lane 3) or B then A (1, 3, 0, 2: `x` from lane 2, `y` from lane 0). Merged
into one path, they take effect in the lane order of D14 — if that is ascending,
0, 1, 2, 3: `x` from lane 2, `y` from lane 3, which neither order produces. So a
merge is not a hidden optimisation; it changes the result, hence §2 forbids it.

### 4.3 Finishing, and misused barriers

Finishing is per warp (agreed direction, §5.1): `wdone` stops a warp. Apart
from that, the only way a warp could be left without an active path is the
illegal `bsync` of §2 — a split always activates one of its new paths, and
`yield` with no paused path does nothing. The spec does not define "deadlock";
it only makes the misuse illegal.

The model still has to notice it. A warp with no active path that has not
executed `wdone` holds only blocked paths, and since only the warp's own active
path can release them, it will never run again. The model reports that as the
`deadlock` termination (`../CONTRACT.md` §1, guarantee 2, and §4): exact, and
local to the warp. A typical cause is two paths that should meet calling
`bsync` on different barriers.

### 4.4 Traps (provisional)

The previous variant had no traps, and this one may not either. If traps are
added, a trapping instruction fits §2 as a split: the lanes that pass go to
`pc + 4`, the lanes that trap go to the trap vector, and the path splits like
any divergent branch. Where the trapped lanes go, and what they may observe, is
open.

### 4.5 Consequences

- **Kernels:** communication between the paths of one warp needs no fences;
  `ping_pong`'s two paths see each other's increments after a `yield`. That is
  what the kernel already assumes.
- **Hardware:** a warp's later loads must see its earlier stores from any lane,
  which means a per-warp store queue with forwarding across lanes rather than a
  per-lane one.

---

## 5. Open questions

1. **Finishing.** Direction agreed: only the whole warp finishes (option B
   below). `wdone` executed by a path that does not hold every lane of the warp
   is *illegal*.
2. **`bsync`:** what identifies a barrier; the expected set of lanes and who sets
   it (does `binit` survive?); the release condition, and which blocked paths a
   combination takes in; and the PC of a combined path when the blocked paths wait at
   different `bsync` instructions for the same barrier.
3. **RVWMO with "warp" for "hart":** confirm by analysis that it holds, in
   particular fences across lanes and the interaction with D14.
4. **The lockstep order of D14:** which order (ascending lane index is the
   obvious default).
5. **Traps:** whether there are any, and the semantics of §4.4.

### Options for finishing (B agreed as the direction, 2026-11-07)

The previous variant ends a kernel in `crt0.s`: the whole warp reconverges with
`bsync`, then executes `wdone`, then spins (`j .`). That suggests two models:

- **Lanes finish individually.** An instruction maps the active path's lanes to
  *finished* instead of to a PC, so finishing is one more case of §2's split.
  Finished lanes leave the path state; the next active path is a choice among
  the paused paths. A barrier must then stop waiting for finished lanes, or wait
  forever.
- **Only the warp finishes.** `wdone` is legal only when the active path holds
  every lane of the warp, as after `crt0.s`'s `bsync`; executing it otherwise is
  an error to be specified. Simpler, and nothing waits for a finished lane,
  but a kernel cannot let some lanes stop early except by spinning or blocking.

In both, the observation's `termination` (`../CONTRACT.md` §4) needs a defined
end: every warp finished, as opposed to every warp stuck in `j .`.
