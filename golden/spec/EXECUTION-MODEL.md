# Execution model: warp program order, paths, lockstep

**Status: draft — not authoritative.** Started from the maintainer's proposal of
2026-11-07; revised 2026-11-16 for the redesign. §1–§3 are the rules as
agreed so far; §4 is analysis behind them and §5 the open questions. Nothing
here binds the model or the RTL until the maintainer approves the document
(`../AGENTS.md` §5). *TBD*, *unspecified* and *illegal* have the meanings in
[`README.md`](README.md#terminology).

---

## 1. Warp program order and warp state

RVWMO (RISC-V unprivileged specification, chapter "RVWMO Memory Consistency
Model") defines **program order** informally as the architectural order in
which a hart executes its instructions. Dolunay defines the **warp program
order** (WPO) of a warp the same way: the architectural order in which the warp
executes its instructions. Each element of the WPO is one instruction executed
by the warp's active path, on all of that path's threads. **Each element is
atomic:** to any observer outside the warp, either every thread of the path has
executed it or none has.

At every point of the WPO, the warp's **path state** is:

- a set of **paths**; each path is a set of threads with one PC, and every
  thread of the warp belongs to exactly one path;
- each path in exactly one of three states:
  - **active** — exactly one path; it executes the next instruction;
  - **paused** — zero or more paths; ready to run, waiting for control;
  - **blocked** — zero or more paths; waiting in `bsync`, and not eligible to
    receive control from `yield`.

The path state is architectural state, carried through the WPO like any other.

## 2. How an instruction changes the path state

**Every instruction generates a set of next PCs.** It maps each thread of the
active path to one next PC — an N → 1 mapping from threads to PCs. For most
instructions the set has one element, `pc + 4`, so nothing changes; a branch or jump whose threads all agree is
the same case. When the set has more than one element:

- the active path is split by the mapping, one new path per PC;
- the next active path is **one of the new paths** — which one is
  *unspecified* (a choice point, `../CONTRACT.md` §1);
- the other new paths are paused;
- every other path keeps its state.

**The PC rule.** A thread's next PC is a function of its own PC and
registers, and of memory and warp registers as the spec orders them at that
instruction. It never depends on another thread's PC or registers, in its own
path or any other. The rule constrains only the PC: an instruction may move
data between threads. Warp registers are written only by instructions that take
effect for the whole path at once. So where a path splits is a fact about each
thread alone.

Further rules:

- **`yield`** makes the active path paused and one paused path active — which
  one is *unspecified*, subject to `yield`'s progress guarantee
  (`../CONTRACT.md` §2, Scheduling). The
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

  The paths a `bsync` combines must be blocked at the same `bsync` instruction
  as the active path. Combining threads at different instructions is
  **illegal**. The combined path continues after that instruction.
- **No implicit merging.** Two paths are never combined except by `bsync`, even
  when they reach the same PC. An implementation must not merge them, for
  example at a post-dominator (§4.2). Dolunay keeps a hardware path list, not a
  reconvergence stack.
- **Finishing.** Only the whole warp finishes. `wdone` is legal only when
  the active path holds every thread of the warp; executed by any other path it
  is **illegal**.

## 3. Memory

**Provisionally, the memory model is RVWMO with "hart" read as "warp" and
"program order" read as "WPO".** Whether that holds up is to be analysed. In
particular, RVWMO's Load Value Axiom then says that a load returns the latest
store, to each byte, among those before it in the WPO and those before it in the
global memory order. So within a warp, a load sees the latest earlier store of
*any* thread, unless a store from another warp intervenes.

Exceptions to the substitution:

- **Dependencies are per thread.** Address, data and control dependencies flow
  through registers, which are per thread, so they relate only instructions of
  the same thread.
- **No standard atomics.** Dolunay implements neither A nor Zalrsc.
  Atomics between warps are warp-level and execute once for the active path;
  how they enter the axioms is to be written with them (§5).
- **One WPO element holds the accesses of several threads**, all loads or all
  stores, and is one event in the global memory order (§1). Stores by two of
  its threads to overlapping bytes are **illegal**. So no order among an
  element's accesses is observable.
- **No memory-mapped I/O.** Every mapped address is memory.

---

## 4. Analysis

### 4.1 Two sanity properties

- **A warp of one thread is a RISC-V hart**, with Dolunay's exemptions from the
  standard: no `frm`, no A or Zalrsc, and no C. It has one path, the WPO
  is its program order, and every rule above must reduce to the standard. This
  is a cheap test for every later rule, and what lets a stock RISC-V hart serve
  as an oracle for single-thread programs.
- **Each thread's program order is the WPO restricted to the instructions its
  path executed.** Per-thread RISC-V semantics (registers, dependencies) are
  untouched; the WPO only adds an order between threads.

### 4.2 Why implicit merging is observable

Take path A = threads {0, 2} and path B = threads {1, 3} at the same store
instruction; threads 1 and 2 store to `x`, threads 0 and 3 store to `y`. As two
paths, the stores take effect A then B (threads 0, 2, 1, 3: `x` from thread 1,
`y` from thread 3) or B then A (1, 3, 0, 2: `x` from thread 2, `y` from thread
0). Merged into one path, threads 1 and 2 store to `x` in one lockstep
instruction, which is an illegal store conflict the program as written does not
contain. So a merge is not a hidden optimisation; it changes the meaning, hence
§2 forbids it.

### 4.3 Finishing, and misused barriers

Finishing is per warp: `wdone` stops a warp. Apart from that, the only
way a warp could be left without an active path is the illegal `bsync` of §2 —
a split always activates one of its new paths, and `yield` with no paused path
does nothing. The spec does not define "deadlock"; it only makes the misuse
illegal.

The model still has to notice it. A warp with no active path that has not
executed `wdone` holds only blocked paths, and since only the warp's own active
path can release them, it will never run again. The model reports that as the
`deadlock` termination (`../CONTRACT.md` §1, guarantee 2, and §4): exact, and
local to the warp. A typical cause is two paths that should meet calling
`bsync` on different barriers. An illegal `wdone` or an illegal `bsync` is
detected when it is executed, and the model reports it as the `illegal`
termination.

### 4.4 Traps (provisional)

The previous variant had no traps, and this one may not either. If traps are
added, a trapping instruction fits §2 as a split: the threads that pass go to
`pc + 4`, the threads that trap go to the trap vector, and the path splits like
any divergent branch. This respects the PC rule, since whether a thread traps
depends on its own state. Where the trapped threads go, and what they may
observe, is open.

### 4.5 Consequences

- **Kernels:** communication between the paths of one warp needs no fences; two
  paths that hand off through `yield` see each other's stores. Mutual exclusion
  between the paths of one warp needs no atomics either, because paths switch
  only at explicit points.
- **Hardware:** a warp's later loads must see its earlier stores from any
  thread, which means a per-warp store queue with forwarding across threads
  rather than a per-thread one. Each instruction is atomic to other warps, so a
  lockstep access that a banked scratchpad serialises over several cycles must
  keep other warps' conflicting accesses out until it completes.

---

## 5. Open questions

1. **`bsync`:** what identifies a barrier; the expected set of threads and who
   sets it (does `binit` survive?); the release condition, and which blocked
   paths a combination takes in. (The PC of a combined path is settled by the PC rule of §1:
   all its threads are at the same `bsync`.)
2. **RVWMO with "warp" for "hart":** confirm by analysis that it holds, in
   particular fences across threads and elements that hold several accesses.
3. **Synchronisation:** the data instructions within a warp, and whether
   they may read threads outside the active path; the warp-level atomics, and
   how both enter the WPO and the axioms of §3.
4. **Traps:** whether there are any, and the semantics of §4.4.
