# Redesign: run the spec literally first

**Status: draft proposal, not authoritative.** Started 2026-11-13 from
discussions with the maintainer and revised several times the same day. It
decides nothing: every choice is marked *proposed*, or listed as open. It is a
separate file so that [`CONTRACT.md`](CONTRACT.md),
[`DECISIONS.md`](DECISIONS.md) and the other documents stay untouched;
unifying them is a later step (§9). Where this file disagrees with them, they
win until the maintainer says otherwise. It uses the word *thread* where they
say *lane* (§1).

What the maintainer has stated, as opposed to what an assistant proposed, is
marked where it matters: the terminology (§1), the PC rule (§3) and the
observation that async-versus-sync is a question of execution and not of three
instruction sets (§6) are the maintainer's. The conclusion of §4, to run the
spec literally first, and the options of §5 are proposals the maintainer is still
weighing.

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

The identifiers follow: `LaneRef` becomes `ThreadRef`, `LaneSet` becomes
`ThreadSet`, and "lane mask" in the observation and replay log becomes "thread
mask". That rename is mechanical, and it should be its own step (§9), not
mixed into any other change.

## 2. Why the seam has to change

Today `Machine` calls `IInstructionSet.Execute` once per thread of the active
path, collects a `LaneOutcome` from each, and throws if the kinds disagree. The
engine around that call is sound; the call is the problem. The *kind* of
instruction (a branch, `yield`, `bsync`, `wdone`) is a property of the
instruction at the path's PC, and every thread of a path is at the same PC, so
it is decoded once per path and there is nothing to agree on. What a thread
returns is data (its next PC, an operand such as a barrier id), and what the
path does with it is decided afterwards, for the path as a whole: the groups a
branch splits it into, the order several threads' stores take effect in (D14),
whether a barrier releases.

Separately, D11 does not run threads that way: each thread is a Renode CPU that
runs freely and halts before an instruction that needs the model. The per-thread
call came from the test stub, not from Renode. [`HANDOFF.md`](HANDOFF.md)
records this as a known gap.

## 3. The PC rule: where a thread's order meets the warp's

A thread has a PC, and a path is a set of threads that follow the same one. The
PC is where a thread's own program order (PO) meets the warp program order
(WPO, [`spec/EXECUTION-MODEL.md`](spec/EXECUTION-MODEL.md) §1): the WPO needs
every thread of a path to follow the same instruction stream, whatever order
the threads are executed in. Proposed rule:

> For every instruction in a thread's program order, the thread's next PC does
> not depend on the immediate state of any other thread.

My attempt at making "immediate state" precise, for the maintainer to confirm:
the next PC is a function of the thread's own architectural state and of state
the WPO orders (memory, warp registers), never of what the other threads of its
path hold at that moment. The rule constrains *where* a thread goes, not
*when*: a thread blocked in `bsync` resumes only when the warp releases it, but
it resumes at its own next PC.

### Checked against

- **Standard RISC-V.** Branches, `JAL` and `JALR` depend on the thread's own PC
  and registers; every other instruction goes to `pc + 4`, with loads, stores,
  `LR`/`SC` and AMOs affecting only `rd` and memory. I checked this by
  reasoning about the instruction set, not by reading the specification text.
  Traps are not specified for Dolunay yet, so they are not checked.
- **The hypothetical `JTID` and `BEQ.W.W`** (examples only, in no
  specification). `JTID` reads the thread's own id. `BEQ.W.W` reads warp
  registers, which are state the WPO orders, not another thread's state. That
  holds only if warp registers are written exclusively by instructions that
  take effect for the whole path at once.
- **The previous variant's custom instructions** (evidence only, per
  [`AGENTS.md`](AGENTS.md) §1). The CSV gives all three a branch condition of
  `NEVER`, and in `thread_scheduler.sv` the path's PC advances by one word when
  `BINIT`, `BSYNC` or `YIELD` completes, so a yielding or parked path resumes
  at its own next instruction. They follow the rule, with one case for
  `BSYNC`: on release, the last path to arrive absorbs every thread of the
  barrier and continues at *its own* PC, and the parked paths' PCs are
  discarded. If threads had parked at different `BSYNC` instructions of one
  barrier, some would resume somewhere other than their own next instruction,
  which breaks the rule. [`ITS-SEMANTICS.md`](ITS-SEMANTICS.md) §3.2 records
  this case as "not exercised by the current software", and records undefined
  behaviour only for non-uniform barrier *addresses*. I did not find a
  definition of different `BSYNC` instructions as undefined in the repository;
  it may be in the paper. Under the rule the case is *illegal*, and that is what
  makes the rule hold for `BSYNC`.
- **`JALR` in the previous variant.** The RTL jumps with the leader's target and
  replays the other threads, so each thread ends at its own target. Leader
  selection decides *when* a thread goes, not *where*.

### Two consequences

1. **Divergence.** Each thread can compute its own next PC, so where threads
   diverge is a fact about each thread alone. What the warp has to do is only
   decide how the path splits: group its threads by next PC.
2. **Convergence.** The threads that converge already have the same PC.
   `bsync` does not tie them together; it tells the warp that they are tied, so
   the paths can be unified. A `bsync` whose converging threads are at
   different instructions is illegal.

The model today does not follow the rule at this point. `WholeWarpBarrier`
combines at the active path's PC and does not look at the blocked paths' PCs.
The rule also answers the last open item of
[`spec/EXECUTION-MODEL.md`](spec/EXECUTION-MODEL.md) §5.2, the PC of a combined
path whose blocked paths waited at different `bsync` instructions.

The rule forbids instructions whose next PC depends on peers' values at that
moment: a vote branch, "branch if any thread of the path has this condition".
That is a design limit on future instructions, and worth stating in `spec/` when
it is written.

## 4. Run the spec literally first

**Proposed.** A reference model should be obviously the spec. If threads run
past a branch and the model reconstructs the WPO afterwards, the model is an
optimised implementation of the spec, and it needs an equivalence argument and,
in practice, a reference of its own to be checked against: a golden model for
the golden model. So the first engine should be literal: one host thread, only
the active path ever runs, and one *step* is one instruction of the active path
executed on every one of its threads, one after another in the order D14 fixes.
After the step the model looks at the threads' results. A split happens at the
branch, because the model sees every thread's next PC immediately; nothing runs
ahead of the WPO, so nothing has to be reconstructed.

The existing `Machine` already works this way. What changes is the seam to the
instruction layer (§2): a thread's step returns data, and the path-level
decision is made after the last thread has stepped.

A literal engine also makes several things easy that the optimised design makes
hard:

- **Reproducibility** (guarantee 1) is trivial with one host thread.
- **The instruction budget** and the dynamic instruction histogram (job G3) are
  exact, because the model sees every instruction.
- **A stuck run can be proved.** A thread that executes `j .` leaves its whole
  state, the PC included, unchanged and reads nothing outside itself, so nothing
  can ever unstick it. [`CONTRACT.md`](CONTRACT.md)'s guarantee 2 allows a class
  stronger than `timeout` only with a proof from the run, and here the model
  holds one (§8).
- **The conflict check** sees every lockstep instruction, which is what its
  clocks assume.

The cost is speed, and D11 already accepts "correctness first, slow first".
Checking determinacy (`CONTRACT.md` §1, methods 2 and 3) multiplies the number
of runs, so how slow matters; it is a measurement to take (§5), not an argument.

The asynchronous design that this file's earlier drafts built (§6) is not wrong.
It is an optimisation of this engine, and the literal engine is its oracle: run
a kernel on both and compare.

## 5. The instruction layer: Renode or a custom interpreter (open)

The literal engine needs something that executes one instruction of one thread.
Three ways to get it, none chosen.

- **A. Renode, stepped.** The model drives one Renode CPU per thread, one
  instruction at a time, on one host thread. This is the closest to what exists:
  the seam is already per-thread stepping. Opcode overrides are still needed
  wherever the model must intercept an instruction (shared memory, the custom
  instructions), so the integration cost of D8 and D11 stays: DLLs copied into
  the Renode tree, one machine per thread, a Renode on every machine.
- **B. A custom interpreter** in C#. The model becomes plain C# with no seam to
  Renode, and `dotnet test` covers all of it. It costs writing, and verifying,
  an RV32 interpreter, and it gives up D5's main argument: Renode is an
  *independent* implementation of the ISA, while an interpreter written by the
  RTL's author could share the author's misreadings.
- **C. B, with Renode kept as a differential oracle.**
  [`spec/EXECUTION-MODEL.md`](spec/EXECUTION-MODEL.md) §4.1 says a warp of one
  thread must be a plain RISC-V hart, so any single-thread program can run on
  both and be compared. That keeps the independent check without the
  integration cost.

What the repository says about the size of B: the `ss` kernels are built for
`rv32i_zicsr_zicond_zalrsc_zba_zicntr_zihpm`, with no M, C or F, and only
`asm-kernels/fpu_test.s` uses F (single-precision arithmetic, fused
multiply-add, `fsqrt`, conversions, `fclass`). So an interpreter would be RV32I
plus Zicsr, Zicond, Zba, Zalrsc and the counters, and F is the large and risky
part, since a replay compares floats bitwise (D15). Whether a softfloat library
could be reused is unchecked.

What is not known, and needs a short time-capped probe
([`AGENTS.md`](AGENTS.md) §7 applies) before the choice is made:

1. **The direct step rate of a Renode CPU.** The 2.4 k instructions/s of
   [`SUBSTRATE.md`](SUBSTRATE.md) went through the monitor, and
   [`PERFORMANCE.md`](PERFORMANCE.md) fix 1 says a direct `ExecuteInstructions`
   call should be far cheaper; nobody has measured it.
2. **The cost of resetting machines between runs.** Determinacy checking may need
   thousands of runs.
3. **Whether Renode 1.17 supports Zicond, Zba, Zalrsc and Zihpm.** The platform
   description uses `rv32imac`.

My lean, for the maintainer to overrule: **C**. The integration load of A has
been most of the project's difficulty so far, and the reason to keep Renode, an
independent check, survives as the oracle. A would win if the probe shows
stepping is fast, reset is cheap and the extensions are supported, since it is
the cheapest to build. D11 already says it is "overturned if a probe of the
coordinator-driven execution ... shows a simpler design that is also correct".
No number here has been measured.

## 6. Deferred: asynchronous execution

**Only if the literal engine proves too slow.** Everything below is the first
drafts' design, kept because the reasoning is not cheap to redo. It would be
checked against the literal engine. Where it says "proposed", the maintainer has
not yet agreed.

### Async and sync

There is one instruction set and one specification; an instruction is a
transition on state. What differs between instructions is how they are executed,
and the PC rule (§3) reduces that to one question: does the instruction touch
state outside its thread? If not it is **async**: any next PC is allowed, so
branches, jumps, `JTID` and `BEQ.W.W` are all async, and a thread may run them
ahead of its path-mates, since nothing but that thread can see the difference. If
it touches the path, the warp or shared state (a write to shared memory, `yield`,
`bsync`, `binit`, `wdone`, a write to a warp register) it is **sync**: every
thread of the path stops before it, and it executes once for the path, in D14's
order. Whether a next PC is guaranteed uniform no longer decides anything; it
only saves a record (below). This replaced an earlier idea of three ISAs, one per
thread, path and warp, which forced a functional shape on a stateful
specification.

Three modules follow. The **async executor** runs threads (Renode) and depends on
nothing of ours. The **sync executor** holds the paths, the warp state and shared
memory, executes the sync instructions, and does not reference Renode; it is an
ordinary stateful object, not a pure function. The **glue** joins them, carries
operands and results between them, and keeps the PC rule; neither executor depends
on the other.

### Records, path IDs and reconciliation

A path is not "the threads that happen to share a PC": two paths at the same PC
stay separate (D3). So divergence cannot be found by comparing PCs at a later
rendezvous, because threads that split at a branch can meet again at the same PC
first. A path is better defined as a class of threads with identical
control-flow history since they last converged, and a **path ID** names the
class. IDs may be reused once a path is gone.

- **Records.** A thread appends one record, (source PC, next PC), for every
  executed instruction whose next PC may differ from its path-mates' (not
  `pc + 4`, not `JAL`, not `BEQ.W.W`), taken or not. Then record *k* of every
  thread of a path refers to the same instruction, the first position at which
  two threads differ is the split, each group's PC after it is explicit, and a
  comparison on a common prefix is valid even when threads are stopped at
  different points, so equal prefixes can be dropped and records stay bounded.
  Recording only taken transfers does not have these properties.
- **No local formula gives collision-free IDs.** An ID computed from only the
  current ID and the next PC cannot be injective in general, by a counting
  argument: histories are unbounded and a fixed-width ID is not. The exact
  structure is a trie whose nodes are (parent, source PC, next PC). Building it
  eagerly, in a table shared by the threads while they run, needs a lock on every
  such instruction. Building it lazily, from the threads' records at the next
  rendezvous, needs no shared state in the async region. They are the same
  structure built at different times. **Proposed: build it lazily.**
- **Canonical IDs.** Let a path's ID be the lowest thread index in the path.
  Live paths are disjoint and non-empty, so their IDs are distinct, with no
  allocator and no collision by construction. A split leaves the old ID with the
  child that holds the old minimum; a convergence takes the minimum of the union.
  Only the glue can compute it, since a thread cannot know its own group.
- **The tree is a requirement.** D15 replays the RTL's choices as "which path
  (warp, thread mask, PC) runs next" after each split. If a path split twice
  before a rendezvous and the glue showed only the final groups, the intermediate
  path the RTL chose would not exist in the model. So the glue must unroll the
  trie top-down, one choice per divergence in WPO order, and report each path's
  architectural PC as of that position, not where Renode has run ahead to.
- **Still to prove:** that divergence is always detectable from the records, even
  when a thread never reaches a sync instruction (a conditional-branch loop would
  be the test); and that collapsing several divergences into one reconciliation
  cannot change what a policy or a replay can observe.
- **Convergence.** `bsync` gives the converging threads one ID and clears their
  records, after checking that they are at the same PC.

### Parallel host threads, shared reads, bounds

- If every thread is also a host thread, nothing in the async region may touch
  shared mutable state, or numbering becomes dependent on host-thread timing
  (guarantee 1). [`SUBSTRATE.md`](SUBSTRATE.md) records that blocking a CPU thread
  in a handler stops every CPU; a short lock is not the same as waiting on
  another CPU, but it has not been probed.
- **Shared reads.** Because every write to shared state is a rendezvous, a thread
  running ahead cannot miss an earlier store by a path-mate. The model must still
  see each read, and other warps could then change memory only between events.
  **Proposed default: a shared read is sync**, with running ahead as a later
  optimisation (`PERFORMANCE.md` fix 3).
- **Bounds.** A thread running ahead needs an instruction budget, and reaching it
  is an event, so that a spinning thread returns control and the glue can
  reconcile.
- **Profiling** needs a source for instructions the model does not see one by
  one; Renode's counter includes aborted attempts (`SUBSTRATE.md`).

## 7. The instruction table (open, and tricky)

For the model to scale, adding an instruction should be one table entry plus its
semantics, and nothing else. The table would hold, per instruction, its encoding
(citing the specification, per D9) and how its operands are extracted; the
path-level semantics are keyed by the instruction's identity, not by bits. It
covers the standard RISC-V instructions too. If the asynchronous design of §6 is
ever built, each entry also says whether it is async or sync.

Things this has to get right, not yet worked out:

- **Claims should be checked where the model can.** If the table says an
  instruction's next PC is uniform, the model can check that it was.
- **The class can depend on the execution.** A store to thread-private memory is
  thread-local; to shared memory it is not. Which one is only known once the
  address is computed. This assumes a private/shared split, which the open memory
  map has not settled ([`CONTRACT.md`](CONTRACT.md) §2).
- **The conflict check and the lockstep order.** The conflict check treats the
  threads of one instruction as ordered by D14, so it never reports a conflict
  between them, but the order itself is still open (`CONTRACT.md` §2, spec §5): a
  kernel whose result depends on it would pass the check.

## 8. Termination and the instruction budget (open)

Every run of a thread needs a bound, and the literal engine has one: the
instruction budget of `MachineOptions`. A spinning `j .` is the maintainer's
example of a case that is not obvious. The maintainer's view is that a warp stuck
in a loop that can change no state is, for the golden model, a deadlock, and the
run should still produce its observation. [`CONTRACT.md`](CONTRACT.md)'s
guarantee 2 defines `deadlock` as "no lane can execute", which a spinning thread
does not satisfy, and allows a stronger class than `timeout` only with a proof
from the run. The literal engine can supply a proof for the self-jump and similar
cases (an instruction that leaves the thread's state unchanged and reads nothing
outside it). A loop that reads shared memory is different: another warp may
change what it reads, so no proof is available. Open: widen the definition of
`deadlock` or add a class, how narrow the recognised cases are, and whether it is
per warp or per machine.

## 9. Unification and small steps

When this is unified with the existing documents, these will need to change: D3
(the PC rule; divergence is found where threads' next PCs differ), D5, D8 and D11
(whatever §5 decides), `CONTRACT.md` §6 (the vocabulary), guarantee 2
(`deadlock`), `PERFORMANCE.md` (whether the deferred design of §6 is kept),
[`spec/EXECUTION-MODEL.md`](spec/EXECUTION-MODEL.md) §5.2 (the PC rule and
illegal `bsync`) and `HANDOFF.md`. In code, `IInstructionSet` and `LaneOutcome`
change shape, and `WholeWarpBarrier` has to start checking PCs.

Suggested order, each a small step on its own, none started:

1. The maintainer reviews this file and decides §4.
2. A short, time-capped probe of the three unknowns in §5; then decide §5.
3. Rename *lane* to *thread* across code and tests, with no other change; it can
   be done at any point, and the 39 tests that passed on 2026-11-13 are the
   check.
4. The first code after the decision: the new seam of §2 on the stub ISA, with the
   PC rule checked in `WholeWarpBarrier`. Nothing else moves yet.
