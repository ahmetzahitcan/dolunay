# Decision log

**Status: authoritative.** Each entry states a decision **as it currently
stands**; read an entry on its own and you have the rule. History lives in git
(`git log -p golden/DECISIONS.md`), not in this file (D10).

Rules:

- **Changing the substance** of an entry needs the maintainer's approval. Edit
  the entry in place and add a `Revised:` line saying when and what changed.
- **Factual corrections** (a wrong fact, a stale cross-reference) may be made
  directly; say so in the commit message.
- **IDs are permanent.** Never renumber or reuse one; other documents and code
  comments cite them.
- A decision that is **wholly reversed** shrinks to a stub: its title, `Status:
  superseded by D<n>`, and one line on why. Citations to it still resolve.
- Alternatives that were tried or rejected go in the entry's `Considered:` line,
  so the question is not re-litigated.

Entry format (`Revised:` and `Considered:` are optional):

```
## D<n> — <short title>
Date: YYYY-MM-DD
Revised: YYYY-MM-DD — <what changed>
Status: accepted | provisional | superseded by D<m>
Decision: <one or two sentences, in the imperative or present tense>
Because: <the reason that would still hold if the code changed>
Considered: <alternatives, and why not>
Consequences: <what becomes hard or impossible, and what would overturn this>
```

An entry is only worth writing if a future reader would otherwise re-litigate it.

---

## D1 — The golden model is the reference, not a second opinion

Date: 2026-11-04
Status: accepted

Decision: The golden model defines the machine's architectural behaviour. The RTL
is expected to converge on it; disagreement is an RTL defect unless the model is
shown to be wrong.

Because: A reference model that follows the implementation cannot detect defects
in that implementation.

Consequences: RTL changes that alter architectural state must cite a decision
here. The corollary is procedural: `golden/` never edits the RTL, not even to fix
a genuine defect — it reports the finding, and the decision that makes the RTL
wrong. This is only meaningful once the observation format (`CONTRACT.md` §4) is
implemented on both sides.

## D2 — Model the next variant; the RTL is evidence, not a specification

Date: 2026-11-04
Status: accepted

Decision: The model targets the next Dolunay variant. The RTL currently in
`../src` implements the previous variant and may be read for interface shapes
only.

Because: The next variant changes memory (scratchpad + DMA), barrier logic, and
possibly the path model; deriving semantics from the previous RTL would encode
the wrong machine in the thing meant to judge the right one.

Consequences: The previous variant's design documents (`DESIGN.md`,
`ITS-SEMANTICS.md`, in git history) are rationale for that variant only.
Anything read from `../src` must be labelled as evidence.

## D3 — Paths are the scheduling unit; threads of a path are in lockstep

Date: 2026-11-04
Revised: 2026-11-06 — reversed by the maintainer: the original said "no implicit
lockstep within a warp" and scheduled threads. Paths are architecturally visible.
Revised: 2026-11-07 — paths combine only through `bsync`; implicit merging is
forbidden.
Revised: 2026-11-16 — a path splits wherever its threads' next PCs differ
(D21); the model sees every instruction (D18).
Status: provisional — what "lockstep" means precisely is to be defined in `spec/`

Decision: Each thread carries its own PC and architectural state, but the ISA
treats the threads of a warp as executing in lockstep until they diverge. A
**path** is a set of threads of one warp that are in lockstep; the scheduler
chooses the next *path*, never an individual thread. A path splits at the
instruction after which its threads' next PCs differ (D21).

Because: This is the ISA's execution model. Lockstep is a *semantic*
statement — it does not require SIMD execution, in the model or in the RTL — so
the model states it as rules about observable order, not as the RTL's masks and
stacks, and can still catch bugs in that machinery.

Considered: thread-based scheduling without lockstep (the original D3) — wrong
model of the ISA. Detecting divergence lazily by comparing PCs at sync events —
rejected: two paths can reach the same PC and still be separate, and a thread
may never reach a sync event (an infinite loop), so divergence must be caught at
the instruction itself.

Consequences: The model keeps path bookkeeping: split at divergence, combine
only through `bsync`. Two paths that reach the same PC stay separate; an
implementation must not merge them implicitly, because a merge changes the
order in which their accesses take effect (`spec/EXECUTION-MODEL.md` §4.2) —
Dolunay keeps a hardware path list, not a reconvergence stack. Which path runs
next is a choice point (D12), switched cooperatively (D13); the order of
conflicting accesses within one lockstep instruction is fixed by the spec (D14).
The rules themselves are being drafted in `spec/EXECUTION-MODEL.md`; open in
`CONTRACT.md` §2: the details of `bsync`.

## D4 — The model lives in this repository

Date: 2026-11-04
Revised: 2026-11-06 — the shared ISA source is now the ISA documents (D9), not
the CSV.
Status: accepted

Decision: `golden/` stays in the Dolunay repository, next to the ISA
documents, the software and the RTL.

Because: The ISA definition is shared by the RTL, the model and the profiler;
splitting repositories would turn an in-tree inconsistency into
cross-repository version skew.

Considered: a separate repository — rejected for the reason above.

Consequences: One tree hosts Bender, Python and .NET build systems. Revisit if
the ISA stabilises and independent release cadence becomes valuable.

## D5 — C#, not IronPython

Date: 2026-11-04
Revised: 2026-11-06 — the integration route moved to D8.
Revised: 2026-11-16 — reduced to the language choice; the entry also chose
Renode's RISC-V core as the ISA layer, which D19 replaces.
Status: accepted

Decision: The model, its tools and its Renode shell are written in C#.

Because: Renode's embedded scripting is IronPython 2.7, which is unacceptable in
this repository, and C# is Renode's own language, so the shell needs no bridge.

Considered: IronPython hooks (Python 2).

Consequences: The code targets Renode's framework and language version
(`net8.0`, C# 12; `AGENTS.md` §8). Python stays for generators and tooling.

## D6 — Agent working rules for `golden/`

Date: 2026-11-04
Revised: 2026-11-06 — authority order updated for D9.
Status: accepted

Decision: Agents work from the repository root with the whole tree readable, but
`golden/` is the only write scope, and authority is explicit: contract and
decisions first, the ISA (RISC-V + `spec/`) second, software corpus third, the
CSV and the RTL as evidence only. Enforced by `AGENTS.md` and `CONTRACT.md`, not
by hiding directories.

Because: Scoping an agent to `golden/` would hide the ISA and the kernels and
invite an invented machine — a silent, expensive failure. Contamination with the
previous variant is better prevented by a stated authority order and by tests
than by a directory boundary.

Consequences: The rules must be maintained as the first thing an agent reads; a
root-level pointer is required so agents started at the repository root find
them. Information starvation is handled by explicit input lists, not by walls.

## D7 — GCC, bare-metal names, per-machine shims

Date: 2026-11-04
Status: accepted

Decision: The build scripts call `riscv32-unknown-elf-gcc` and
`riscv32-unknown-elf-objcopy`. Each machine provides those two names as shims to
whatever its own toolchain is called. The compiler stays GCC.

Because: A name should describe the target — 32-bit, bare metal — rather than a
distribution's packaging, and one shim per machine is cheaper than detection logic
that lives in the scripts forever. GCC keeps `-mbranch-cost`, which has no LLVM
equivalent and matters for a SIMT machine, and it avoids the extension-version
risk (`zicond`, `zalrsc`) that older Ubuntu LLVM packages carry.

Considered: clang — rejected unless `-mbranch-cost` turns out not to matter;
toolchain detection inside the scripts — rejected as permanent complexity.

Consequences: A new machine needs two shims before it can build kernels, and
Windows additionally needs a `hexdump` shim for the scripts' last step; the script
headers say so. On Windows the compiler shim must put the toolchain's `bin` on
`PATH`, otherwise `-flto` cannot load the linker's LTO plugin.

## D8 — The model is pre-built assemblies: pure projects and a Renode shell

Date: 2026-11-05
Revised: 2026-11-06 — split into `Dolunay.Model` and `Dolunay.Renode` with NUnit
tests on the model; the `[Plugin]` class and `golden/renode.config` were
removed.
Revised: 2026-11-16 — the projects follow D19: a headless runner is added, and a
`BaseCPU` shell replaces the `RiscV32` subclass, the opcode overrides and the
lane coordinator.
Status: accepted

Decision: The code is a `net8.0` solution, `golden/model/Dolunay.sln`, of four
projects:

- `Dolunay.Model` — pure C# with no Renode reference: geometry, threads, warps,
  paths, the step of one warp (D18), the world the warps share (D23), the
  interpreter and the decoder, the policies, the conflict check, the observation
  writer.
- `Dolunay.Runner` — a headless program over `Dolunay.Model` that owns the loop
  for exploration, sampling and replay (D19). No Renode reference.
- `Dolunay.Renode` — the shell: the `BaseCPU` subclass, one per warp, which calls
  the model's step of one warp and forwards bus accesses to devices; monitor
  commands. Nothing architectural.
- `Dolunay.Model.Tests` — NUnit tests of `Dolunay.Model` only.

A signature that mentions a Renode type belongs in the shell; a branch that
encodes an architectural rule belongs in the model. `Dolunay.Model.dll` and
`Dolunay.Renode.dll` are copied into Renode's installation directory.

Because: Only a model that does not reference Renode can be tested and run
without Renode, and the architectural rules are what most needs testing. The SDK
is installed on every machine this work runs on, and pre-built assemblies give
several source files and ordinary project tooling.

Considered: one assembly holding both — its tests would still need Renode's
assemblies, and nothing would stop architectural rules leaking into the glue.
The ad-hoc `i @file.cs` route — it works and needs no SDK, but gives one file,
no project, and no tests outside Renode. A `[Plugin]` class enabled through a
tracked `renode.config` — it only logged a line, while the types it shipped
with register without it, and the config file needed a copy-before-use ritual
because Renode rewrites it.

Consequences: Only `Dolunay.Renode` is coupled to the Renode version and must be
rebuilt after an upgrade; `RENODE_BIN` supplies the Renode tree at build time
and is machine-local, so it is never recorded here. Renode registers types by
scanning its own installation directory, non-recursively, at start-up, so
`build/plugin` is the source of truth and the copies in the Renode tree are not;
`Dolunay.Model.dll` resolves from there at run time (`SUBSTRATE.md`). A future
`[Plugin]` class would again need `[plugins] enabled-plugins`. A native library
(the softfloat, D17) would be a further build output to copy.

## D9 — The machine is the RISC-V standard plus Dolunay's own specification documents

Date: 2026-11-06
Revised: 2026-11-06 — the directory was renamed from `isa/` to `spec/`,
because it specifies the execution model and the rules for valid kernels as
well as the ISA.
Status: accepted

Decision: The machine is defined by the ratified RISC-V specifications plus
Dolunay's specification documents in `golden/spec/`, which specify the custom
instructions, the custom CSRs, every exemption from the standard, and the
execution model (`spec/README.md` lists the scope).
`../control_unit/control_unit.csv` is the RTL's code-generation input and a
cheatsheet; it confers no requirements on the model.

Because: The CSV is shaped by what the RTL's generator needs — decode columns,
control signals, commented-out rows — not by what an architecture document must
say, and it says nothing about standard instructions the core inherits. A
reference whose ISA is an implementation's input table cannot judge that
implementation.

Considered: the CSV as the sole ISA source (the original rule) — rejected for
the reason above.

Consequences: Encodings in the model must trace to a section of the RISC-V
specifications or of `golden/spec/`; a hand-written constant without that
citation is forbidden. A disagreement between the CSV and `golden/spec/` is an
RTL finding, not a model bug. Until `golden/spec/` specifies a custom
instruction or CSR, it may be implemented only as a placeholder labelled as
such.

## D10 — This log records current decisions; git records history

Date: 2026-11-06
Status: accepted

Decision: Entries are edited in place to stay current, under the rules at the
top of this file.

Because: The log is the rulebook agents act on, so every entry must be readable
on its own; git already preserves every past version, so an append-only file
added no audit trail and left superseded rules in the reading path.

Considered: append-only entries with `superseded by` links (the original rule) —
it split live rules across entries (D5/D8), and made a one-sentence factual
correction (D8) cost a new decision.

Consequences: Review of a change to this file happens in the diff, so substance
changes must not be bundled silently with unrelated work. Overturned if the log
grows enough authors that in-place edits become contested.

## D11 — Execution on Renode: one machine per thread, overridden opcodes, slow first

Date: 2026-11-06
Status: superseded by D18, D19 and D23

Each thread was a RISC-V CPU in its own Renode machine, with opcode overrides
and halting to give the model its events; the literal engine (D18) and one CPU
of Dolunay's own per warp (D19) replace it, and its rule that the model owns
every shared resource is now D23.

## D12 — The spec leaves choices open; implementations refine it; valid kernels are determinate

Date: 2026-11-06
Status: accepted

Decision: Where software does not care, the spec leaves a **choice point** open
to the implementation (which path runs first after a split, how warps
interleave). An implementation is correct when each of its executions is a
valid execution of the spec. A **valid kernel is determinate**: for each of its
test inputs, every valid execution produces the same output, as defined by an
**output descriptor** the kernel supplies — memory regions, compared bitwise for
integers and within a tolerance for floats, with fields that only count when a
condition on other fields holds. The model checks determinacy when a kernel is
validated; afterwards it runs any one execution (fast mode).

Because: Fixing every choice in the spec would make the reference depend on one
implementation's choices, and constrain faster hardware for no benefit to
software. A kernel whose output depends on the schedule is almost certainly
buggy. Kernels change far less often than the RTL, so the expensive check runs
rarely.

Considered: a fully deterministic spec — the reason above. Bitwise comparison
of floats — forbids floating-point reductions, which are too common to forbid.
Requiring kernels to zero unused output fields — simpler to check, but pushes
work onto software that does not otherwise need it.

Consequences: A choice motivated by the implementation may enter the spec only
when it is high-level enough that going against it would mean a significant
redesign (D13 is one). Determinacy is per input, so fast mode is trustworthy
only on validated inputs. The readable timing CSRs (`cycle`, `time`, `instret`,
the HPM counters) are unconstrained; a kernel whose output depends on them is
not valid. How a run ends is part of the output, so a kernel that deadlocks
under some executions only is not determinate. Checking determinacy needs
schedule exploration (`CONTRACT.md` §1). The descriptor's format and its
tolerance metrics are open (`CONTRACT.md` §2).

## D13 — Paths of a warp switch cooperatively

Date: 2026-11-06
Revised: 2026-11-07 — after a divergent instruction, the next active path is one
of the paths it created.
Revised: 2026-11-16 — "a path finishing" is no longer a switch point: only the
whole warp finishes (D24).
Status: accepted

Decision: A warp switches from one path to another only at points explicit in
the code: an instruction after which the path diverges, `yield`, and waiting at
a barrier. After a divergent instruction, the next active path is one of the
paths it created; the warp's other paths keep waiting. `yield` guarantees that
before the yielding path executes its next instruction, every other thread of
its warp that can execute — not waiting at a barrier — executes at least one
instruction. Warps execute concurrently with each other.

Because: Switching paths to cover a memory stall would help the hardware, but
another warp can cover it instead; explicit switching keeps the schedules within
a warp few and visible in the code. The guarantee is stated over threads, not
paths: `yield` neither diverges nor reconverges, so the yielding path is
unchanged until it runs again, while the other paths may split or merge in the
meantime — "every other path" has no stable meaning.

Considered: switching at any instruction — multiplies the schedules for little
gain. Stating the guarantee over paths — the reason above. Switching to any path
after a divergent instruction — a wider choice point with no use: running one of
the new paths is what an implementation does anyway.

Consequences: Two paths of one warp never execute concurrently. An
implementation that switches paths on a stall violates the spec. A path that
spins with `yield` cannot starve the rest of its warp. Whether warps have a
progress guarantee towards each other is open (`CONTRACT.md` §2).

## D14 — The order within one lockstep instruction is specified

Date: 2026-11-06
Status: accepted

Decision: When the threads of one path execute an instruction whose accesses
conflict, the spec defines the order in which they take effect; it is not a
choice point.

Because: A lockstep instruction is one SIMD instruction fed to every thread of the
path; there is no hardware reason for the order to vary, and fixing it removes a
source of nondeterminism.

Consequences: `spec/` states the order. The scratchpad may reorder internally,
provided the result is as if the accesses took effect in that order.

## D15 — The RTL is checked by replaying its choices

Date: 2026-11-06
Status: accepted

Decision: An RTL simulation logs its choice at every choice point to standard
output, in code guarded by `` `ifndef SYNTHESIS ``. The model replays that log
as its policy and compares the full architectural state bitwise. Comparing the
RTL's output with any one model execution through the output descriptor (fast
mode, D12) is the fallback for runs without a log.

Because: Under replay a mismatch is a definite defect in the RTL or in the
model, and the run stops where the two first diverge. It works for kernels that
are not determinate, and because both sides perform the same operations in the
same order, floats need no tolerance. The model stays independent of the RTL: it
takes a schedule as input and decides nothing on the RTL's behalf.

Considered: searching the valid executions for one that matches the RTL — slow,
and on failure it can only say that none matched.

Consequences: `golden/` defines the log format (`CONTRACT.md` §4); producing it
is RTL work. Every choice point must be identifiable in the spec's terms: within
a warp, which path (warp, thread mask, PC) runs next; between warps, the order in
which conflicting accesses to each address took effect. The second is the
requirement that reaches into the memory system's design.

## D16 — The model core's defaults for the open questions

Date: 2026-11-07
Status: superseded by D18

The code whose knobs and defaults this entry listed (`WholeWarpBarrier`, the
ascending lockstep order, sequentially consistent memory, SplitMix64) was
removed with the redesign; each new knob declares its default in the entry or
document that needs it (`AGENTS.md` §4).

## D17 — Floating point: F with static rounding only

Date: 2026-11-16
Status: accepted

Decision: Dolunay implements RV32F as the RISC-V specification defines it,
subnormals included, except for dynamic rounding. There is no `frm` CSR, and
accessing it is illegal. `fcsr` exists: its `frm` field (bits 7:5) reads as
zero and writes to it are ignored. `fflags` is kept, as per-thread state. All
five static rounding modes are supported, and `rm = 111` selects RNE instead
of reading `frm`. There is no D extension.

Because: A dynamic rounding mode is per-thread state that the threads of a path
could disagree on, for no use worth that. `rm = 111` is what GCC emits by
default, so allowing it keeps the standard toolchain usable without a fork.
Reading `frm` as zero in `fcsr` keeps start-up code that clears `fcsr`
working.

Considered: making `rm = 111` illegal (needs a patched GCC or binutils, or
rewriting binaries after the build, which changes the image's hash); making a
write of nonzero `frm` bits to `fcsr` illegal; dropping `fcsr`.

Consequences: A warp of one thread is no longer exactly a plain RISC-V hart, so
`spec/EXECUTION-MODEL.md` §4.1 needs this exemption, and the exemption is to be
written into `spec/` when its first ISA document exists. A stock hart whose
`frm` was never written behaves the same on valid programs, so a single-thread
program can still be compared with one. The RTL's FPU follows the standard, so
D15's bitwise comparison of floats under replay stands. The model needs a
softfloat for the directed modes and `fflags`. Per-thread `fflags` belongs in
the observation (`CONTRACT.md` §4).

## D18 — The model executes the spec literally

Date: 2026-11-16
Status: accepted

Decision: Only the active path of a warp executes. One step executes one
instruction of the active path on each of its threads, one after another in the
order D14 fixes, and the path-level decision (split, barrier, switch) is made
after the last thread has stepped. Nothing runs ahead of the warp program order,
and the model's state is touched from one host thread at a time. Asynchronous
execution, with threads running ahead of their path, is allowed later only as an
optimisation that is checked against this engine; the deferred design is in git
history (`golden/REDESIGN.md` §6 at commit `4958b34`).

Because: A reference model should be obviously the spec. A model that runs
threads ahead and reconstructs the warp program order afterwards is an optimised
implementation, and would need an equivalence argument and a reference of its
own. The literal engine also makes guarantee 1 hold for free, makes the
instruction budget and the histogram (G3) exact, lets the model prove some
stuck runs, and gives the conflict check every lockstep instruction.

Considered: threads running freely in Renode and halting before the instructions
the model must see (D11) — the model is then the optimised implementation
above.

Consequences: It is slow, and determinacy checking multiplies runs; speed is to
be measured, not argued. D11's rendezvous and opcode overrides go away. The
step of a thread returns data, such as its next PC, and the kind of instruction
is decoded once per path, because every thread of a path is at the same PC.

## D19 — The instruction layer: one Renode CPU of Dolunay's own per warp

Date: 2026-11-16
Status: accepted

Decision: Each warp is one Renode CPU of Dolunay's own, a subclass of
`BaseCPU` and not of `RiscV32`, as a `RiscV32` is one hart. The interpreter, the
decoder and every architectural rule live in pure projects with no Renode
reference (D8's rule). `Dolunay.Renode` is a thin shell: it calls the model's
step of one warp and forwards bus accesses to devices; one unit of
`ExecuteInstructions` is one path step. Renode runs it in serial execution
mode. Systematic exploration, sampling and RTL replay run on a headless runner
over the same pure model, where the model's policy chooses which warp steps; a
run hosted in Renode is one valid execution, for bring-up and debugging. The
model loads program images itself.

Because: A warp is the spec's hart (`spec/EXECUTION-MODEL.md` §5.3), so a CPU
per warp gives the warp id, warp-private devices and the geometry a natural
home in Renode's machine description. Renode supplies the bus, peripherals,
image loading, the monitor and logging, and a stock `RiscV32` in the same
machine is the oracle for single-thread programs (D17). Renode's scheduler can
only be gated, by having a warp that is not on turn report its quantum as done,
and it schedules timers and peripherals itself, so the guarantees are carried
where the model owns the loop (`SUBSTRATE.md`).

Considered: A, Renode's `RiscV32` stepped, one CPU per thread — keeps D11's
override load, and Renode's F implements the dynamic rounding mode D17 removes.
B, our own interpreter with no Renode — gives up the machine description, the
peripherals and the oracle in one machine. C, B with Renode only as an oracle —
the fallback.

Consequences: Renode is no longer an independent implementation of the ISA,
except as the single-thread oracle; the model's interpreter is ours to verify.
`BaseCPU` is a larger coupling than a `RiscV32` subclass, and Renode's debugging
features for translated cores (address hooks, tracing, GDB, disassembly) do not
come for free. The model is organised as a step of one warp over a world shared
by the warps. Speed is unmeasured. Overturned in favour of C if a second probe
fails: real shared state under serial execution, more than 32 CPUs, registers
by name, quantum burning with a real model, and loading the native softfloat
library from Renode's tree.

## D20 — The unit of state is a thread; *lane* is retired

Date: 2026-11-16
Status: accepted

Decision: Dolunay's unit of architectural state, with its own PC and registers,
is a **thread**, as in the SIMT architectures whose vocabulary Dolunay borrows.
*Lane* is retired. Identifiers follow: "thread mask", not "lane mask", in the
observation and the replay log. An operating-system thread is always called a
*host thread*.

Because: One word for one thing. *Thread* is what the RTL and the SIMT
literature say; two synonyms invite readers to look for a difference.

Considered: keeping *lane* as the preferred synonym (`CONTRACT.md` §6 as it
was) — the previous design's choice, which the redesign drops.

Consequences: The documents under `golden/` were rewritten with *thread* for the
redesign, and the code that said *lane* was removed, so there is no separate
rename. Text outside `golden/` that says *lane* means *thread*. In prose,
*thread* in the general sense of an independent stream of execution is closer to
a warp, so do not use it that way.

## D21 — The PC rule: a thread's next PC is its own

Date: 2026-11-16
Status: accepted

Decision: For every instruction, a thread's next PC is a function of that thread's
own PC and registers, and of memory and warp registers as the spec orders them
at that instruction. It never depends on another thread's PC or registers, in its
own path or any other. The rule constrains only the PC: an instruction may
move data between threads (a shuffle, a vote into a register). Warp registers are
written only by instructions that take effect for the whole path at once. A
`bsync` whose converging threads are at different instructions is illegal.

Because: Every thread can then compute where it goes on its own, so divergence is
a fact about each thread, and an implementation may execute a path's threads at
different times (a datapath narrower than the warp, re-running threads after a
bank conflict, running threads ahead in a faster emulator) without changing
control flow. It costs at most one instruction: a branch that would depend on
other threads becomes a data instruction followed by an ordinary branch.

Considered: no rule — the literal engine (D18) does not need it, but every
implementation that does not execute a path's threads together would.

Consequences: Instructions whose next PC reads other threads, such as a fused
vote-and-branch, cannot be added; `spec/` states the rule when its first ISA
document is written, and every custom instruction is checked against it.
The model's `bsync` must check the blocked paths' PCs and report `illegal`
when they differ; this also answers the PC of a combined path
(`spec/EXECUTION-MODEL.md` §5.2). The model cannot check the rule at run time;
it is a rule for whoever defines an instruction.

## D22 — Synchronisation: no A extension; within a warp by custom instructions, between warps by warp-level atomics

Date: 2026-11-16
Status: accepted

Decision: Dolunay implements neither A nor Zalrsc, and no standard atomic
encoding. Synchronisation is split in two. Within a warp, custom instructions
pass data between the threads of the active path. Between warps, warp-level
atomics with semantics modelled on A's execute once for the active path, under
encodings of their own. The details are TBD: the instruction set of both kinds,
where a warp-level atomic's operands come from and where its old value goes,
whether a compare-and-swap or a warp-level LR/SC is provided, and which memory
the atomics apply to.

Because: Within a warp no atomics are needed across paths, because paths switch
only at explicit points (D13); the problem is threads of one path updating the
same word in one instruction, which a reduction across the path replaces.
Between warps, one atomic per warp is a single memory access, so its order is a
plain per-address choice point (D15) with no conflict inside the instruction,
and its `aq`/`rl` ordering is the hart's, with the warp as the hart. New
encodings keep a compiler from emitting them for per-thread C atomics.

Considered: keeping per-thread A with Zalrsc, the previous variant's approach —
an AMO or a reservation per thread linearises memory and was a problem for the
new RTL. A warp-level LR/SC — needs a forward-progress guarantee defined for
SIMT; open, against a warp-level compare-and-swap.

Consequences: `-march` carries no `a`, so C atomics become library calls, and
kernels reach the new instructions through intrinsics or `.insn`. Answers in
part the open `CONTRACT.md` §2 row on LR/SC and AMOs, which is to be amended.
Lock and flag handoffs between warps spin, so they terminate only if every warp
that can run eventually runs, which makes that open question (`CONTRACT.md` §2)
pressing. The conflict check gets its synchronisation between warps from these
atomics once they are specified.

## D23 — The model owns every shared resource

Date: 2026-11-16 — the rule was part of D11 from 2026-11-06
Status: accepted

Decision: Every resource shared between threads or warps — the scratchpad, and
later global memory and DMA — is state of the model, and threads reach it only
through the model.

Because: The conflict check, the choice points between warps (D12) and replay
(D15) need every access to shared state, in order. An access the model does not
see can be neither checked nor replayed.

Considered: Renode's memory as the shared store — the model would then have to
intercept every access to see it, which is what D11's opcode overrides did.

Consequences: Shared memory lives in the world the warps share (D18) inside
`Dolunay.Model`; in a run hosted in Renode it is not a Renode memory peripheral.
Atomics between warps (D22) are the model's.

## D24 — Only the whole warp finishes

Date: 2026-11-16 — agreed as the direction on 2026-11-07
Status: accepted

Decision: A warp finishes by executing `wdone`, which is legal only when the
active path holds every thread of the warp; executing it otherwise is illegal.
Threads do not finish individually.

Because: Nothing ever waits for a finished thread, so barriers need no rule for
finished threads, and the end of a run (`all-wdone`) is defined per warp.

Considered: threads finishing individually (`spec/EXECUTION-MODEL.md` §5.1) —
finishing becomes one more case of a split, and a barrier must then stop
waiting for finished threads, or wait forever.

Consequences: A kernel cannot let some threads stop early, except by having them
spin or block until the warp reconverges for `wdone`. Finishing is not a path
switch point (D13). The model reports an illegal `wdone` as `illegal`
termination (`CONTRACT.md` §1, guarantee 2).
