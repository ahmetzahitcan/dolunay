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

Consequences: `DESIGN.md` and `ITS-SEMANTICS.md` are downgraded to legacy
rationale. Anything read from `../src` must be labelled as evidence.

## D3 — Paths are the scheduling unit; lanes of a path are in lockstep

Date: 2026-11-04
Revised: 2026-11-06 — reversed by the maintainer: the original said "no implicit
lockstep within a warp" and scheduled lanes. Paths are architecturally visible.
Revised: 2026-11-07 — paths combine only through `bsync`; implicit merging is
forbidden.
Status: provisional — what "lockstep" means precisely is to be defined in `spec/`

Decision: Each lane carries its own PC and architectural state, but the ISA
treats the lanes of a warp as executing in lockstep until they diverge. A
**path** is a set of lanes of one warp that are in lockstep; the scheduler
chooses the next *path*, never an individual lane. Divergence is detected
explicitly, at every branch and jump, and splits a path.

Because: This is the ISA's execution model. Lockstep is a *semantic*
statement — it does not require SIMD execution, in the model or in the RTL — so
the model states it as rules about observable order, not as the RTL's masks and
stacks, and can still catch bugs in that machinery.

Considered: lane-based scheduling without lockstep (the original D3) — wrong
model of the ISA. Detecting divergence lazily by comparing PCs at sync events —
rejected: it does not correspond to anything the RTL does (the RTL implements
lockstep as SIMD), comparing the active path's PC with every other path is
costly and not meaningful, and a lane may never reach a sync event (an infinite
loop), so divergence must be caught at the branch itself.

Consequences: The model keeps path bookkeeping: split at divergence, combine
only through `bsync`. Two paths that reach the same PC stay separate; an
implementation must not merge them implicitly, because a merge changes the
order in which their accesses take effect (`spec/EXECUTION-MODEL.md` §4.2) —
Dolunay keeps a hardware path list, not a reconvergence stack. Every branch and
jump of the active path is an event the model sees (D11). Which path runs next
is a choice point (D12), switched cooperatively (D13); the order of conflicting
accesses within one lockstep instruction is fixed by the spec (D14). The rules
themselves are being drafted in `spec/EXECUTION-MODEL.md`; open in
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

## D5 — C# on Renode's RISC-V core

Date: 2026-11-04
Revised: 2026-11-06 — the integration route moved to D8; assumptions settled by
the 2026-11-06 probes (D11).
Status: provisional

Decision: The ISA layer is Renode's RISC-V core; the model and its hooks are
written in C#. How the C# reaches Renode is D8.

Because: RV32 + F + A semantics are commodity, and Renode's embedded scripting is
IronPython 2.7, which is unacceptable in this repository.

Considered: IronPython hooks (Python 2); writing our own ISA layer; Spike; QEMU
user-mode. See `DESIGN.md` §11.

Consequences: The model is tied to Renode's CPU API. Load-bearing assumptions,
each to be settled by a probe rather than by argument:

- the model can extend the core — **verified**: `CPU.Dolunay` subclasses
  `RiscV32` and installs custom instructions;
- lanes can be run and stopped fast enough — **answered by D11**: no state
  swapping (one CPU per lane), and a measured cost of ≈0.85 ms per rendezvous,
  accepted for now (`PERFORMANCE.md`);
- loads and stores can be intercepted — **verified**: standard opcodes can be
  overridden by custom-instruction handlers (`SUBSTRATE.md`).

Overturned if the slow design of D11 proves unusable even for correctness work.

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

## D8 — The model is two pre-built assemblies: a pure model and a Renode adapter

Date: 2026-11-05
Revised: 2026-11-06 — split into `Dolunay.Model` and `Dolunay.Renode` with NUnit
tests on the model; the `[Plugin]` class and `golden/renode.config` were
removed.
Status: accepted

Decision: The code is a `net8.0` solution, `golden/model/Dolunay.sln`, of
three projects:

- `Dolunay.Model` — pure C# with no Renode reference: geometry, lanes, warps,
  paths, the scheduler and its policies, the sync and scratchpad rules behind
  interfaces, the observation writer. It receives events such as "the whole
  path stopped at instruction X" and returns decisions.
- `Dolunay.Renode` — the glue: `CPU.Dolunay`, the opcode overrides (each citing
  `spec/`), the coordinator that maps lanes to machines and halts or releases
  them, the scratchpad bus device, monitor commands.
- `Dolunay.Model.Tests` — NUnit tests of `Dolunay.Model` only.

A signature that mentions a Renode type belongs in the adapter; a branch that
encodes an architectural rule belongs in the model. Both DLLs are copied into
Renode's installation directory.

Because: Only a model that does not reference Renode can be tested without
Renode, and the architectural rules are what most needs testing. The SDK is
installed on every machine this work runs on, and pre-built assemblies give
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
`[Plugin]` class would again need `[plugins] enabled-plugins`.

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
RTL finding, not a model bug. `DESIGN.md` §5.4 (generate the model's patterns
from the CSV) is void. Until `golden/spec/` exists, no custom instruction or CSR
may be implemented except as a placeholder labelled as such.

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

## D11 — Execution on Renode: one machine per lane, overridden opcodes, slow first

Date: 2026-11-06
Status: provisional

Decision: Each lane is one RISC-V CPU in its own Renode machine. The model owns
every shared resource (scratchpad, and later global memory and DMA) and each
machine reaches it through a bus device. Branches, jumps, shared-memory
accesses and the custom instructions are installed as custom-instruction
handlers that override the standard decoder. Lanes wait by halting themselves
with `PC` left on the instruction; the last lane of a path to arrive lets the
model decide (split, release, switch path). Start with a rendezvous at every
branch and accept the cost; speed-ups are deferred (`PERFORMANCE.md`).

Because: Renode executes each lane at full speed between events, so the model
never saves or restores lane state. Overriding opcodes gives the model every
event without scanning the program, and halting before an instruction is
precise (`SUBSTRATE.md`). A Renode machine holds at most 32 cores, and machines
of one CPU cost no more than packed ones, so one per lane is the simplest layout
with no geometry limit. Correctness comes first.

Considered: one CPU swapped between lanes (state save/restore plus `Step`) —
re-implements Renode's CPU state, ≈2.4 k instructions/s. One machine per warp —
works, but adds a packing rule and a 32-lane limit for no gain. Waiting by
blocking a CPU thread — stops every CPU of the emulation. Opcode pre-hooks —
cannot stop before the instruction. Address hooks — precise, but need the
addresses in advance.

Consequences: Each rendezvous costs ≈0.85 ms, so a path advances at about 1 200
branches/s until a `PERFORMANCE.md` fix lands. Renode's own instruction counter
also counts aborted attempts; the model counts instructions itself. Atomics on
shared memory are the model's job (whether LR/SC and AMOs survive at all is open,
`CONTRACT.md` §2). Overturned if a probe of the coordinator-driven execution in
`PERFORMANCE.md` shows a simpler design that is also correct.

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
Status: accepted

Decision: A warp switches from one path to another only at points explicit in
the code: a branch or jump that diverges, `yield`, waiting at a barrier, and a
path finishing. After a divergent instruction, the next active path is one of
the paths it created; the warp's other paths keep waiting. `yield` guarantees that before the yielding path executes its
next instruction, every other lane of its warp that can execute — not finished,
not waiting at a barrier — executes at least one instruction. Warps execute
concurrently with each other.

Because: Switching paths to cover a memory stall would help the hardware, but
another warp can cover it instead; explicit switching keeps the schedules within
a warp few and visible in the code. The guarantee is stated over lanes, not
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

Decision: When the lanes of one path execute an instruction whose accesses
conflict, the spec defines the order in which they take effect; it is not a
choice point.

Because: A lockstep instruction is one SIMD instruction fed to every lane of the
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
a warp, which path (warp, lane mask, PC) runs next; between warps, the order in
which conflicting accesses to each address took effect. The second is the
requirement that reaches into the memory system's design.

## D16 — The model core's defaults for the open questions

Date: 2026-11-07
Status: provisional — each default stands until `spec/` settles its question

Decision: `Dolunay.Model` puts every open rule behind a knob, with these
defaults:

- **`bsync`** (`IBarrierRule`): `WholeWarpBarrier`, a placeholder. It combines
  once every lane of the warp is in the active path or blocked on the same
  barrier, and the combined path continues after the active path's `bsync`;
  otherwise it blocks. Lanes of one path that name different barriers are
  reported as `illegal`.
- **Order within a lockstep instruction** (`ILockstepOrder`, D14): ascending
  lane index.
- **Memory:** accesses take effect in the order the model executes them, which
  is sequentially consistent and so one valid execution under
  `spec/EXECUTION-MODEL.md` §3. Weaker orders are not explored.
- **Seeded policies** use their own SplitMix64, not `System.Random`.
- **Termination:** an illegal act the model can detect, such as `wdone` from a
  path that does not hold the whole warp, ends the run as `illegal`, with the
  warp, lanes, PC and rule.

The conflict check (`CONTRACT.md` §1, method 1) orders accesses only by each
lane's program order, the warp program order within one path, the order within
one lockstep instruction, splits, and `bsync` combines.

Because: Every open question needs a declared default so the model can run
(`CONTRACT.md` §2), and each of these is the smallest choice that leaves the
rest unchanged. The barrier rule is a placeholder because the release model is
being rethought with the memory redesign. The previous variant's rule relied
on its memory design. The whole-warp rule matches the `bsync` before `wdone` in
the previous variant's `crt0.s`. A sequentially consistent memory is enough for
kernels the conflict check passes, since they have no unordered conflicting
accesses. `System.Random`'s algorithm is not promised to stay the same across
runtimes, which would break reproducibility (guarantee 1). An `illegal` class
reports a detectable kernel bug as the kernel's fault, not the model's.

Considered: for `bsync`, combining with every path blocked on the same barrier
as soon as no path is paused. It is kept in the tests as the second rule that
proves the engine does not depend on the default. For an illegal `wdone`,
aborting the run without an observation, which would treat a kernel bug as a
model failure.

Consequences: Kernels that need a partial-warp barrier deadlock under the
default. Weak-memory behaviour is invisible until the memory model is settled
and explored. No synchronisation between warps is specified, so every
conflicting access between warps is reported. Changing a default is a change
to this entry, and a test must show that the rest of the model still does not
depend on it.
