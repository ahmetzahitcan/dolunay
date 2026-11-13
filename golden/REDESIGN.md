# Redesign: three ISAs and a warp module

**Status: draft proposal, not authoritative.** Written 2026-11-13 from a
discussion with the maintainer. It decides nothing: every choice is marked
*proposed* or listed as open. It is a separate file so that
[`CONTRACT.md`](CONTRACT.md), [`DECISIONS.md`](DECISIONS.md) and the other
documents stay untouched; unifying them is a later step (§9). Where this file
disagrees with them, they win until the maintainer says otherwise. It uses the
word *thread* where they say *lane* (§1).

## 1. Terminology

Dolunay borrows its vocabulary from other SIMT architectures, NVIDIA's in
particular: a **thread** is what a SIMT machine runs one lane's worth of state
for, and a **warp** is a group of threads. This is not the general meaning of
"thread" (an independent stream of execution), which is closer to a Dolunay
warp. The RTL says *thread*, not *lane*, and the golden model should agree with
it. [`CONTRACT.md`](CONTRACT.md) §6 currently prefers *lane*; this file
proposes flipping that.

| Term | Meaning here | Was |
|---|---|---|
| **thread** | One unit of architectural state: its own PC and registers. | *lane* |
| **warp** | A set of threads. | same |
| **path** | The threads of one warp that are in lockstep. Exactly one path of a warp is active. | same |
| **host thread** | An operating-system thread of the process running the model or Renode. | *CPU thread*, *OS thread* |
| **thread executor** | The component that runs one thread's instructions. It is Renode. | new |

The identifiers follow: `LaneRef` becomes `ThreadRef`, `LaneSet` becomes
`ThreadSet`, and "lane mask" in the observation and replay log becomes "thread
mask". That rename is mechanical, and it should be its own step (§9), not
mixed into any other change.

## 2. Why the seam has to change

Today `Machine` calls `IInstructionSet.Execute` once per thread of the active
path, collects a `LaneOutcome` from each, and throws if they disagree. Two
things are wrong with that.

First, the outcome of a lockstep instruction is a fact about the *path*,
computed from all of its threads' data: the groups a branch splits the path
into, the order several threads' stores take effect in (D14), whether a
barrier releases. Asking each thread for an outcome and then checking that they
agree gets the direction backwards. Some instructions guarantee agreement,
some guarantee disagreement, and for those a per-thread outcome means nothing.

Second, D11 does not run threads that way. Each thread is a Renode CPU that
runs freely and halts before an instruction that needs the model, and the model
decides once the whole path has arrived. The per-thread call came from the test
stub, not from Renode. [`HANDOFF.md`](HANDOFF.md) already lists this as a known
gap.

## 3. What decides an instruction: three levels

Threads need to be in lockstep only for the instructions where lockstep is
observable. For every other instruction a thread may run ahead of its
path-mates, because nothing but that thread can see the difference. So the
question to ask of an instruction is not what it does, but **which is the
narrowest group that can decide its outcome**: one thread, one path, or the warp
as a whole.

Two properties of an instruction answer it.

**What state it touches.** Thread-local state (registers, the thread's own PC,
memory private to the thread) is invisible to everyone else. Shared state
(shared memory and the scratchpad) and warp-level state (the path list, the
barrier context, warp registers) is not.

**Whether its next PC is guaranteed uniform across the path.** This is a
property of the instruction's definition, not of the data. It is *not* the same
as the next PC being statically predictable. Two hypothetical instructions,
named here only as examples and not in any specification, show why:

- `JTID`, a jump to a target computed from the thread id. Its next PCs are
  statically predictable, but it guarantees they are *not* uniform: the path
  always splits. That is a decision about the whole path.
- `BEQ.W.W`, a branch comparing two warp-level registers. Its next PC cannot be
  predicted without knowing the register values, but every thread of the path
  reads the same values, so it guarantees the next PC is uniform and the path
  can never split on it. A thread can execute it alone.

The proposed levels, each an ISA of its own:

- **Thread ISA.** Instructions a thread executes by itself: they write nothing
  beyond the thread's own state, they may read shared or warp-level state
  (§7), and their next PC is guaranteed uniform (`pc + 4`, a direct jump,
  `BEQ.W.W`). Executed in Renode, and free to run ahead.
- **Path ISA.** Instructions whose outcome needs the path's threads together: a
  next PC that is not guaranteed uniform (`JTID`, a branch on thread registers,
  an indirect jump), and any write to shared state, which must take effect in
  the order D14 fixes. A rendezvous: every thread stops before the instruction,
  then the outcome is computed once for the path.
- **Warp ISA.** Instructions that change warp-level state or need to know about
  the other paths: `yield`, `bsync`, `wdone`, and writes to warp registers.
  Also a rendezvous.

A rule for placing an instruction, in order: if it changes warp-level state or
depends on other paths, it is a warp instruction; otherwise, if it writes
shared state, its next PC is not guaranteed uniform, or it needs data from
several threads at once, it is a path instruction; otherwise it is a thread
instruction.

Splitting a path is not an instruction's business at any level. A path
instruction produces per-thread next PCs, and the warp module groups the
threads by PC and splits the path (D13).

This refines D3, which says divergence is detected "at every branch and jump".
The proposed wording is "at every instruction whose next PC is not guaranteed
uniform".

## 4. Modules and dependencies

- **Thread executor.** Renode: a `RiscV32` subclass, as `DolunayCpu.cs` is
  today. It implements the thread ISA, runs one thread until it reaches an
  instruction that is not a thread instruction (it stops *before* it), and
  reports what it stopped at. This is the only part that depends on Renode.
- **Path ISA.** A pure function from "the threads of one path stopped before
  this instruction, with these operand values" to a path outcome plus effects.
  Depends on nothing.
- **Warp ISA.** A pure function from the warp's state and a warp instruction to
  the warp's new state plus effects. Depends on nothing.
- **Shared state.** Shared memory and the scratchpad. A leaf. The thread
  executor reads it (for shared reads, if they run ahead, §7), and the warp
  module applies effects to it.
- **Warp module.** Unites the rest. It owns the warp's state (the paths and
  their states, what each owes, the barrier context), asks the thread executor
  to run the active path's threads, gathers their reports, calls the path or
  warp ISA, applies the result, and chooses the next path through the schedule
  policy. Most of today's `WarpState`, `WarpPath`, the barrier rule and the
  policies are expected to carry over into it.
- **Machine.** Above the warp modules: warp scheduling, termination, the
  observation.

The path and warp ISAs return **effects as values** (a store to apply, a
register to write, a path to create) and never perform them. That keeps them
pure and independently testable, and it is the natural place for D14's order:
the path ISA sorts the effects, the warp module applies them. If purity pays
off, they could be written in a functional language. That would be a second
language and so a decision (§8).

The warp module reaches the thread executor through a small interface that it
defines itself, so that tests can substitute a scripted executor and need no
Renode. The interface shape depends on what Renode can do (§5), so it is
defined last.

This leaves the project split of D8 workable as it is: what changes is what
crosses it. The boundary is drawn by purity, not by whether Renode is
involved: everything that does not need Renode is pure, and the thread executor
is the one asymmetric piece. Whether to merge the assemblies is a separate
question that this plan does not need to answer.

## 5. The conversation between thread executor and warp module

Only a sketch; the shapes are open.

From the thread executor up: "thread T has stopped before the instruction with
this identity at this PC, and these are its operands" (already extracted, so
the pure modules never see encodings), or "thread T used up its run budget"
(§8).

From the warp module down: "resume T at this PC, having written these
registers", or "do not resume T".

Whether the thread executor runs one thread at a time, driven from the warp
module on a single host thread, or halts and releases free-running CPUs as in
D11, is the executor's business and invisible through this interface. The
first is `PERFORMANCE.md` fix 1, whose API is described there as lightly
documented. Neither has been verified against this seam, and two things need a
time-capped probe before any code depends on it: driving a thread with
`ExecuteInstructions`, and writing a thread's registers back at a rendezvous.

## 6. The instruction table (open, and tricky)

For the model to scale, adding an instruction should be one table entry plus
its semantics at its level, and nothing else. So the level is data attached to
each instruction. The table would hold, per instruction, its encoding (citing
the specification, per D9), its level, and how its operands are extracted; the
path and warp semantics are keyed by the instruction's identity, not by bits.
It covers the standard RISC-V instructions too, including the ones Renode runs
untouched.

Things this has to get right, not yet worked out:

- **The level is a claim, and the model should check it.** If a thread
  instruction ends up with non-uniform next PCs, or writes shared state, the
  table is wrong. The model should report that as an interface violation, as it
  does today for lanes that disagree, and not carry on.
- **The level can depend on the execution.** A store to thread-private memory is
  a thread instruction; to shared memory, a path instruction. Which one is only
  known once the address is computed, so such an entry is a dispatcher: it
  completes locally or stops before the instruction and escalates. This assumes
  a private/shared split exists, which the open memory map has not settled
  ([`CONTRACT.md`](CONTRACT.md) §2).
- **An instruction may need two levels.** Whether that is one instruction with
  two parts or a rule against it is open.
- **The conflict check.** [`CONTRACT.md`](CONTRACT.md) §1's method 1 builds its
  clocks by seeing every lockstep instruction. With threads running ahead, it
  sees only events. The order it builds should be equivalent, but that needs
  checking.

## 7. Shared reads (open)

Does a read of shared state need a rendezvous? The reasoning so far, not tested:
because every write to shared state is a rendezvous, no thread can pass a store
before its path-mates reach it, so a thread running ahead cannot miss an
earlier store by a path-mate. Two hazards remain. The model must still see each
read, through the bus device, or the conflict check goes blind. And other warps
can then change shared memory only between events, which narrows the
interleavings explored.

**Proposed default: a shared read is a path instruction.** Correctness first,
as D11 does; running ahead is an optimisation to take once the slow design
works, and `PERFORMANCE.md` fix 3 is its natural form.

## 8. Runaway threads, `j .`, termination, and the language (open)

**A thread must have a bound.** A thread that executes `j .` (a jump to its own
address) is a thread instruction: static target, no state touched. Alone, it
never gives control back. So every run of a thread needs an instruction
budget, and reaching it is an event. Counting instructions the model does not
see is open: Renode's own counter includes aborted attempts
([`SUBSTRATE.md`](SUBSTRATE.md)), so the executor needs a count of its own.

**What `j .` should end as.** The maintainer's view is that a warp stuck in a
loop that can change no state is, for the golden model, a deadlock, and the run
should still produce its observation. [`CONTRACT.md`](CONTRACT.md)'s guarantee 2
defines `deadlock` as "no lane can execute", which a spinning thread does not
satisfy, and allows a stronger class than `timeout` only with a proof from the
run. The self-jump is a case where a proof exists: the next PC is this PC, and
the instruction has no effect. General loops that change no state cannot be
recognised. Open: widen the definition of `deadlock` or add a class, how narrow
the recognised cases are, and whether it is per warp or per machine.

**The language of the pure modules.** The path and warp ISAs could be written
in F# for the sake of purity. D5 and `AGENTS.md` §8 say C#, so this would be a
decision. It also costs a second language in the toolchain, and, unverified, a
runtime library that would have to sit in Renode's installation directory
beside the other DLLs, since that is where plugin dependencies are resolved
([`SUBSTRATE.md`](SUBSTRATE.md)).

## 9. Unification and small steps

When this is unified with the existing documents, these will need to change:
D3 (the wording in §3), D8 (what each project contains), D11 (an event protocol
instead of a rendezvous at every branch), `CONTRACT.md` §6 (the vocabulary),
guarantee 2 (`deadlock`), `PERFORMANCE.md` (fix 2 becomes a refinement of the
levels), and `HANDOFF.md`'s known gap. In code, `IInstructionSet` and
`LaneOutcome` go away.

Suggested order, each a small step on its own, none started:

1. Review and amend this file until it reads right.
2. Rename *lane* to *thread* across code and tests, with no other change; the
   39 tests of the last handoff are the check.
3. Time-capped Renode probes of the two unknowns in §5.
4. The first code: the types for events and effects, and the path ISA over
   them, tested on scripted events. Nothing else moves yet.
