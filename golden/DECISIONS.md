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

## D3 — Lane-based execution, warp-structured

Date: 2026-11-04
Status: provisional

Decision: Each lane carries its own PC and architectural state; a warp is the
unit of rendezvous and of scheduling contention. There is no implicit lockstep
within a warp.

Because: Divergence then costs nothing to implement, the ITS primitives are stated
per-lane, and a model that mirrors the RTL's path machinery cannot catch bugs in
that machinery.

Consequences: The model must supply its own grouping/ordering policy when a test
needs RTL-like behaviour. Overturned if the path structure turns out to be
architecturally visible (e.g. `xrole`) — then a path structure has to reappear as
schedulable state, not as an implementation detail.

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
Revised: 2026-11-06 — the integration route moved to D8; unverified assumptions
updated with what has since been measured.
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
- whole-lane state save/restore plus stepping is fast enough — **open**:
  single-stepping measured at ≈2.4 k instructions/s (`SUBSTRATE.md`), which
  argues for running each lane until a sync point;
- loads and stores can be intercepted without a hook per instruction —
  **unverified**, and possibly moot (memory ownership is open, `CONTRACT.md` §2).

Overturned if the stepping or interception probe fails.

## D6 — Agent working rules for `golden/`

Date: 2026-11-04
Revised: 2026-11-06 — authority order updated for D9.
Status: accepted

Decision: Agents work from the repository root with the whole tree readable, but
`golden/` is the only write scope, and authority is explicit: contract and
decisions first, the ISA (RISC-V + `isa/`) second, software corpus third, the
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

## D8 — The model is a pre-built Renode plugin

Date: 2026-11-05
Revised: 2026-11-06 — corrected what enabling the plugin controls; recorded the
ad-hoc route under Considered.
Status: accepted

Decision: The model and its Renode glue ship as a `net8.0` assembly built from
`golden/model/Dolunay.Golden.csproj` and loaded from Renode's installation
directory.

Because: The SDK is installed on every machine this work runs on, and only the
plugin route gives unit tests outside Renode, several source files and ordinary
project tooling.

Considered: the ad-hoc `i @file.cs` route — it works and needs no SDK, but gives
one file, no project, and no tests outside Renode.

Consequences: Building needs `dotnet` and Renode's assemblies, so the build is
coupled to the Renode version and must be rebuilt after an upgrade. Renode
registers types by scanning its own installation directory, non-recursively, at
start-up, so the built DLL has to be copied into the Renode tree: `build/plugin`
is the source of truth, not the loaded copy. Types such as `CPU.Dolunay` work as
soon as the DLL is there; only the `[Plugin]` class additionally needs
`[plugins] enabled-plugins`, which `golden/renode.config` sets for one run
(`SUBSTRATE.md`). `RENODE_BIN` supplies the Renode tree at build time and is
machine-local, so it is never recorded here.

## D9 — The ISA is the RISC-V standard plus Dolunay's own ISA documents

Date: 2026-11-06
Status: accepted

Decision: The ISA is defined by the ratified RISC-V specifications plus
Dolunay's ISA documents in `golden/isa/`, which specify the custom
instructions, the custom CSRs, and every exemption from the standard.
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
specifications or of `golden/isa/`; a hand-written constant without that
citation is forbidden. A disagreement between the CSV and `golden/isa/` is an
RTL finding, not a model bug. `DESIGN.md` §5.4 (generate the model's patterns
from the CSV) is void. Until `golden/isa/` exists, no custom instruction or CSR
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
