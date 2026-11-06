# Dolunay ITS Semantics

> **STATUS: legacy reference — not the specification for the model.**
>
> §3 accurately records the *published* variant, and is kept because it is the
> baseline the next variant is compared against and because a concrete example
> beats an abstract rule. What is authoritative now is
> [`CONTRACT.md`](CONTRACT.md); the open questions in §6 and §8 are tracked
> there and in [`DECISIONS.md`](DECISIONS.md).
>
> In particular, **§4 ("the model must own its memory") is not a standing
> decision.** Its argument rests on leader selection being a path-level
> operation; with memory redesigned around a scratchpad and DMA, that
> justification no longer holds, and owning memory becomes one option among
> several. See `CONTRACT.md` §2.
>
> The encodings and CSR numbers in §3.1 and §3.4 are the **previous** variant's.
> They are not part of the ISA unless the ISA documents in [`isa/`](isa/) adopt
> them (D9).

The ITS (Independent Thread Scheduling) semantics of the **published** variant of
Dolunay: what they meant, what was undecided, and what that variant would have
required of the model.

This is the companion to [`DESIGN.md`](DESIGN.md), which covers the rest of the
golden model design. **Everything here is about the architecture; nothing here
is about Renode, the repository layout, or the milestones.**

---

## 1. Status, and how to read this

Two facts frame everything:

- The ITS semantics were **published** for a previous variant of Dolunay
  (DSD/SEAA 2026 WiP, branch `arch__dsd2026`). That variant is summarised in
  [§3](#3-legacy-reference-summary) — as a *reference*, not as a specification.
- The **current variant is a redesign** and need not be compatible with it.
  What the new design should do is [§6](#6-open-decision-path-visibility) and
  [§8](#8-open-questions) — still open.

So the legacy summary is here because it (a) shows concretely what an ITS
design looks like, (b) gives the model a starting point, and (c) is the thing
the new design will be compared against. It is deliberately kept short — the
paper is the authority, and the model does not need more than this to be
written.

**The software in `ss/` was written against the legacy semantics.** If the new
variant's semantics differ, those kernels need revisiting — and the golden
model is what will show that.

---

## Table of contents

1. [Status, and how to read this](#1-status-and-how-to-read-this)
2. [The ITS idea](#2-the-its-idea)
3. [Legacy reference summary](#3-legacy-reference-summary)
4. [The model must own its memory](#4-the-model-must-own-its-memory)
5. [Interleaving dependence](#5-interleaving-dependence)
6. [Open decision: path visibility](#6-open-decision-path-visibility)
7. [What the model must implement](#7-what-the-model-must-implement)
8. [Open questions](#8-open-questions)
9. [References](#9-references)

---

## 2. The ITS idea

Traditional stack-based SIMT (pre-Volta NVIDIA, Vortex, e-GPU) serialises
divergent paths under a shared warp execution context, with an IPDOM stack
tracking divergence and reconvergence. A thread holding a lock can be inactive
while another thread in the same warp spins waiting for it — deadlock.

ITS gives each thread independent execution state, including separate
program counters, and lets the scheduler make forward-progress decisions at
thread granularity. NVIDIA adopted it in Volta.

Dolunay's take is *architectural* rather than microarchitectural: **divergence
is implicit, reconvergence is explicit.** A non-uniform branch automatically
splits paths; but because threads can yield to one another, there is no notion
of path priority, so implicit reconvergence detection would require comparing
the active path's PC against every inactive path's — too much hardware. So all
reconvergence points must be annotated explicitly in software.

That is the entire point of the three custom instructions: **`yield`** lets a
thread give up the warp's execution slot so another thread can run, and
**`binit`/`bsync`** provide explicit barriers where threads must reconverge.

The concrete consequences the model has to honour:

- **Lanes of a warp are independent threads.** They have their own PCs and
  progress at their own rates.
- **A barrier is a warp-level rendezvous**, not a path-level one.
- **Forward progress is a design goal.** `ping_pong` and `spmc` are the
  stress cases; they must complete.

---

## 3. Legacy reference summary

> Condensed from *Dolunay: Architectural Support for Independent Thread
> Scheduling in a RISC-V SIMT Accelerator*, DSD/SEAA 2026 WiP, branch
> `arch__dsd2026`. **Legacy design — the current variant need not be
> compatible with it.** Section references are to the paper.

### 3.1 Instructions and encodings

Three instructions, opcode `0x0B` (the RISC-V "custom-1" space):

| Instruction | Encoding | Description |
|---|---|---|
| `BINIT imm(rs1)` | I-format, opcode `0xB`, funct3 = 1, rd = x0 | Initialises a barrier in an aligned 4-byte region of work RAM. |
| `BSYNC imm(rs1)` | I-format, opcode `0xB`, funct3 = 2, rd = x0 | Updates the barrier and either parks the calling threads or releases the barrier. |
| `YIELD` | Word `0x0000400B` | Yields control to another path. |

`YIELD` as a word is exactly `funct3=4`, `rd=x0`, `rs1=x0`, `imm=0` in
I-format.

**`YIELD`** switches the active path using a modified round-robin scheduler
that skips inactive paths.

**Divergence is implicit.** Dolunay "makes no assumption of uniformity for
branches and jumps and automatically splits paths when a non-uniform branch or
jump is detected". For a uniform branch, the current path's PC is simply
updated.

### 3.2 The barrier context, and the `BSYNC` algorithm

The barrier context lives **in memory** — a deliberate choice, to avoid
spilling and restoring warp-level state. It holds **two thread masks**, each
`T` bits wide (`T` = threads per warp):

- *participation* (`MEM[addr][2T-1:T]`): 1 = this thread participates and the
  others must wait for it; 0 = it does not participate.
- *parked* (`MEM[addr][T-1:0]`): 1 = this thread has parked and is waiting;
  0 = it has not yet parked (if participating) or does not participate.

`BINIT` sets the participation mask to the **active thread mask** — so
synchronisation applies to the threads that execute `BINIT` simultaneously —
and zeroes the parked mask.

`BSYNC` (Fig. 1 of the paper), with `mactive` the executing path's mask:

```
procedure BSYNC(addr)
    T              ← number of threads per warp
    mparked        ← MEM[addr][T - 1 : 0]
    mparticipation ← MEM[addr][2T - 1 : T]
    mparked_new    ← mparked ∨ mactive
    if mparked_new = mparticipation then
        mactive ← mparticipation          // release
    else
        mactive ← 0                      // park
        YIELD
    end if
    MEM[addr][T - 1 : 0] ← mparked_new
```

Four consequences worth carrying forward:

- **Release is by equality, not "all bits set".** A thread active at `BSYNC`
  whose bit is *not* in the participation mask makes `mparked_new` strictly
  greater than `mparticipation`, and the barrier never releases. `BINIT`
  setting participation to the active mask is what keeps this consistent.
- **The reconvergence point is not stored.** It is encoded implicitly by the
  location of `BSYNC` in the instruction stream. So if several `BSYNC`s share a
  barrier context, a thread may park at one and resume at another. The paper
  notes this is not exercised by the current software.
- **Barrier context addresses must be uniform.** "Dolunay assumes uniformity
  for barrier context addresses; violating this assumption results in undefined
  behavior."
- **`BSYNC` executes in two passes** in hardware, with a one-bit per-warp
  toggle register: the first pass loads the context into an internal register,
  the second uses it. This is why the control unit CSV has two rows for one
  architectural instruction — `BSYNC_0` (a load) and `BSYNC_1` (a store).

### 3.3 Legacy memory model

Three regions, selected by the top two bits of the address:

| Region | Start | End |
|---|---|---|
| IROM | `0x00000000` | `0x3FFFFFFF` |
| WRAM | `0x40000000` | `0x7FFFFFFF` |
| TLS | `0x80000000` | `0xFFFFFFFF` |

The configured sizes are far smaller than the ranges, so **the upper address
bits are ignored** and the memory is effectively shadowed.

**WRAM and IROM use leader selection.** For each access:

- a leader thread is selected to provide the address; the leader's operation
  always succeeds;
- a follower thread whose address **differs** from the leader's **replays** the
  operation;
- a follower thread whose address **matches** the leader's completes the
  operation simultaneously with the leader. For loads this means it reads the
  same value as the leader; for stores, writes from non-replayed follower
  threads are **ignored**.

(The paper argues this is architecturally valid because it is
indistinguishable from the leader being the last thread to perform its store.)

Only one of IROM or WRAM can be accessed per cycle, since both use the same
leader-selection logic. Stores to IROM are ignored.

**TLS is per-thread.** Each execution lane has an independent TLS; the warp ID
is appended to the address so that threads with the same thread ID in different
warps do not collide. TLS accesses always complete in one pass and are exempt
from leader selection.

**LR/SC are valid only on WRAM.** `LR` reserves the **entire** WRAM region;
`SC` invalidates the reservations held by other threads. When several threads
execute `SC` simultaneously, one leader performs the operation and the rest
report failure by storing 1 in `rd`. SC instructions never replay.

**The current tree has none of this.** It has a single bank-mapped scratchpad
(`spad_bank_of` in `params_pkg.sv`), no TLS port on `core_top`, and no region
decode — `src/fu_lsu.sv:109` still carries the comment *"TODO: check that this
is where the spad is mapped in memory"*.

### 3.4 CSRs

All three custom CSRs are read-only:

| CSR | Address | Description |
|---|---|---|
| `xwarpid` | `0xCC0` | Warp identifier. |
| `xthrid` | `0xCC1` | Thread identifier within the warp. Threads from different warps may share an `xthrid`. |
| `xrole` | `0xCC2` | Leader (0) or follower (1) of the **active path**. |

The standard `mhartid` is implemented: its lower bits are `xthrid` and its
remaining bits are `xwarpid`. All other CSRs read as zero.

**`xrole` is per-path, not per-warp.** "xrole can be used to determine whether
the current thread is the leader of the active path. The leader is the thread
with the lowest ID among those enabled in the active thread mask. Every path
has exactly one leader and zero or more follower threads."

So `xrole` is **not** a constant per thread: as paths split and merge, which
thread is the leader changes.

### 3.5 Where the path structure was architecturally visible

Two places, in the legacy design:

1. **`xrole`** — defined relative to the active path, as above.
2. **Fall-through ordering** — a divergent branch keeps the fall-through
   threads in the *current* path slot and allocates the taken threads a *new*
   path slot, so **the fall-through path executes before the branch-taken
   path**.

Neither has to hold in the new variant. See
[§6](#6-open-decision-path-visibility).

---

## 4. The model must own its memory

Renode provides memory, but the model should service memory accesses itself,
for two reasons:

1. **Leader selection is path-level behaviour.** Within a path, one leader
   thread provides the address and the other lanes' accesses are resolved
   against it ([§3.3](#33-legacy-memory-model)). That is a per-instruction,
   per-path operation — it cannot be expressed by giving each lane an
   independent view of Renode's shared memory.
2. **The address map is not Renode's.** The legacy design has three regions
   selected by the top two address bits, with per-thread TLS and LR/SC
   restricted to WRAM. The current tree has a bank-mapped scratchpad with no
   region decode at all. Either way the model needs to know the map.

**Implementation:** override the load/store instructions with custom handlers
and service them from the model's own memory:

| Overridden | Why |
|---|---|
| `lb`, `lh`, `lw`, `lbu`, `lhu` | Model-owned memory; leader selection; per-region behaviour. |
| `sb`, `sh`, `sw` | As above, including "writes from non-replayed follower threads are ignored". |
| `f` loads/stores (`flw`, `fsw`) | Same, for the float register file. |
| `lr.w`, `sc.w` | Reservation sets, per-region restrictions, "SC never replays". |

This also means the model's memory is a *definition* rather than an
inheritance — which is what a golden model should be.

---

## 5. Interleaving dependence

A kernel's result may depend on the order in which lanes run. This is the
whole point of ITS — it gives the programmer concurrency, with
synchronisation.

The model must therefore be able to answer: **is this kernel's result
independent of the interleaving?**

The test: run the same kernel under N different scheduler seeds and check that
the final memory contents are identical every time. If they are, the kernel is
interleaving-independent and the model and the RTL can be compared under any
policy. If they are not, the kernel has a latent race, and comparing model
against RTL requires *replaying the same interleaving* on both sides.

This is one of the most valuable things the golden model will do, and it is
why the scheduler policy must be a pluggable, seedable thing.

---

## 6. Open decision: path visibility

In the legacy design the path structure was visible in two places
([§3.5](#35-where-the-path-structure-was-architecturally-visible)): `xrole`,
and fall-through ordering.

**Neither has to hold in the new variant.** The question for the new design is
whether the path structure is visible *at all* — and if it is, in what
respects. This is the central open question of the redesign, and the golden
model is where it gets answered.

Two cases:

- **If the path structure stays invisible**, then `xrole` must be redefined
  (per-warp? per-thread-constant?) and the model can use the pure lane-based
  structure of [`README.md` §4.2](README.md#42-why-lane-based-rather-than-path-based)
  with no path bookkeeping at all.
- **If it stays visible**, the model needs a real path structure, and the
  scheduler has to reproduce the *ordering* guarantees, not just the grouping.

**This cannot be decided independently of the memory model** ([§8.2](#82-open-question-the-memory-model)):
leader selection is itself a path-level property, so keeping it keeps the path
structure visible whether or not that is intended.

---

## 7. What the model must implement

Whatever the open questions resolve to, the model needs:

| Component | Notes |
|---|---|
| **Per-lane state** | PC, 32 integer + 32 float registers, the custom CSRs. |
| **Per-warp state** | Lane membership, the path grouping, the barrier objects. |
| **The ITS instructions** | `binit`, `bsync`, `yield`, hooked as custom instructions. |
| **The custom CSRs** | `xwarpid`, `xthrid`, `xrole` — and `xrole` only if it stays path-dependent. |
| **Model-owned memory** | [§4](#4-the-model-must-own-its-memory). |
| **A scheduler policy** | Pluggable and seedable; drives [§5](#5-interleaving-dependence). |
| **A termination condition** | The model must decide when all lanes are done — the RTL has no `ready_o` and `WDONE` is disabled. |

Each open question in [§8](#8-open-questions) becomes a knob in the model, so
that the consequences of each choice are visible rather than implicit.

---

## 8. Open questions

| # | Question | Section |
|---|---|---|
| 1 | Is the path structure architecturally visible at all? If so, in what respects? | [§6](#6-open-decision-path-visibility) |
| 2 | What is the memory model? | [§8.2](#82-open-question-the-memory-model) |
| 3 | Is the barrier context still in memory? Still two masks? | [§8.3](#83-open-question-the-barrier-context) |
| 4 | What are the memory-ordering guarantees of `bsync` and `yield`? | [§8.4](#84-open-question-memory-ordering) |

### 8.1 Open question: path visibility

See [§6](#6-open-decision-path-visibility).

### 8.2 Open question: the memory model

The legacy model ([§3.3](#33-legacy-memory-model)) has three regions selected
by the top two address bits, per-thread TLS, leader selection with
same-address coalescing, and LR/SC restricted to WRAM.

The current tree has **none** of that: a single bank-mapped scratchpad, no
region decode, no TLS port, no LR/SC.

The new variant has to pick a memory model, and the choice interacts with the
ITS semantics — leader selection *is* a path-level property, so keeping it
keeps the path structure architecturally visible whether or not that is
intended.

### 8.3 Open question: the barrier context

If the barrier context stays in memory as two masks
([§3.2](#32-the-barrier-context-and-the-bsync-algorithm)), the model implements
the paper's `BSYNC` algorithm and the semantics are fully pinned down. If the
new design moves it to registers, or changes the release condition, the model
changes with it.

### 8.4 Open question: memory ordering

What are the memory-ordering guarantees? Does `bsync` act as a release fence
for the arriving lane and an acquire for the group? Does `yield`?

The legacy paper does not say. Without an answer, `spmc.c` and `nearn.c`
cannot be judged correct or incorrect — and they are the interesting kernels.

---

## 9. References

### The paper (legacy design)

> *Dolunay: Architectural Support for Independent Thread Scheduling in a RISC-V
> SIMT Accelerator*, Ahmet Zahit Can, Erkan Uslu. DSD/SEAA 2026 WiP Session,
> Kraków, Poland, Sept. 2026. The variant described is branch `arch__dsd2026`
> of <https://github.com/ahmetzahitcan/dolunay>.

| Section | Covers |
|---|---|
| III-A1 | The custom instructions, the barrier context, the `BSYNC` algorithm (Fig. 1), the custom CSRs |
| III-A3 | The hardware performance monitors |
| III-B2 | Thread schedulers, paths, `xrole` |
| III-B3 | Memory: regions, leader selection, TLS, LR/SC |
| IV-B | The ping-pong and spmc kernels |

### Dolunay (this repository)

| What | Where |
|---|---|
| ITS instruction macros, CSR numbers | `asm-kernels/instructions.s`, `ss/hdr/simt.h` |
| ITS runtime | `ss/src/simt.c`, `ss/src/mutex.c` |
| ISA specification (encodings for `binit`/`bsync`/`yield`) | `control_unit/control_unit.csv` |
| Path/split mechanism | `src/thread_scheduler.sv`, `src/core_frontend.sv` |
| LSU, bank mapping | `src/fu_lsu.sv`, `src/params_pkg.sv` |
| Kernels | `ss/kernels/`, `asm-kernels/` |
| Memory map (software view) | `ss/link.ld` |
