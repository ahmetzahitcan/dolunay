# Decision log

Append-only. One entry per decision, newest at the bottom. To reverse a decision,
add a new entry and mark the old one `superseded by D<n>` — never rewrite or
delete an entry.

Entry format:

```
## D<n> — <short title>
Date: YYYY-MM-DD
Status: accepted | provisional | superseded by D<m>
Decision: <one or two sentences, in the imperative or present tense>
Because: <the reason that would still hold if the code changed>
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
Status: accepted

Decision: `golden/` stays in the Dolunay repository, next to the ISA
specification, the software and the RTL.

Because: The ISA table is a single source of truth shared by the RTL, the model,
and the profiler; splitting repositories would turn an in-tree inconsistency into
cross-repository version skew.

Consequences: One tree hosts Bender, Python and .NET build systems. Revisit if
the ISA stabilises and independent release cadence becomes valuable.

## D5 — C# model on Renode, ad-hoc first

Date: 2026-11-04
Status: provisional — the integration route is superseded by D8 (the choice of C# on Renode stands)

Decision: The ISA layer is Renode's RISC-V core; the model and its hooks are C#.
The first integration attempt uses the ad-hoc `i @file.cs` route, which needs no
.NET SDK.

Because: RV32 + F + A semantics are commodity, and Renode's embedded scripting is
IronPython 2.7, which is unacceptable in this repository.

Consequences: The model cannot be unit-tested outside Renode until the plugin
route is proven. **Unverified:** that ad-hoc C# can see `BaseRiscV`; that whole-lane
state save/restore plus `Step(1)` is fast enough; that load/store interception is
possible without a hook per instruction. Each is a load-bearing assumption and
each is tested by the substrate spike, not by argument.

## D6 — Agent working rules for `golden/`

Date: 2026-11-04
Status: accepted

Decision: Agents work from the repository root with the whole tree readable, but
`golden/` is the only write scope, and authority is explicit: contract and
decisions first, ISA CSV second, software corpus third, RTL as evidence only.
Enforced by `AGENTS.md` and `CONTRACT.md`, not by hiding directories.

Because: Scoping an agent to `golden/` would hide the ISA table and the kernels
and invite an invented machine — a silent, expensive failure. Contamination with
the previous variant is better prevented by a stated authority order and by
tests than by a directory boundary.

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

Consequences: A new machine needs two shims before it can build kernels, and
Windows additionally needs a `hexdump` shim for the scripts' last step; the script
headers say so. On Windows the compiler shim must put the toolchain's `bin` on
`PATH`, otherwise `-flto` cannot load the linker's LTO plugin. clang was
considered and is rejected unless `-mbranch-cost` turns out not to matter.

## D8 — The model is a pre-built Renode plugin

Date: 2026-11-05
Status: accepted

Decision: The model and its Renode glue ship as a `net8.0` assembly built from
`golden/model/Dolunay.Golden.csproj` and loaded from Renode's installation
directory. The ad-hoc `i @file.cs` route is no longer the integration route:
the part of D5 that chose it to avoid needing the .NET SDK is superseded. The
rest of D5 — C# on Renode's RISC-V core — stands.

Because: The SDK is installed on every machine this work runs on, so avoiding it
buys nothing, and only the plugin route gives unit tests outside Renode, several
source files and ordinary project tooling.

Consequences: Building needs `dotnet` and Renode's assemblies, so the build is
coupled to the Renode version and must be rebuilt after an upgrade. Renode
discovers plugins by scanning its own installation directory, non-recursively,
and only considers types under `Antmicro.Renode.*`; a plugin is loaded only when
`[plugins] enabled-plugins` names it, which `golden/renode.config` does for a
single run. Therefore the built DLL has to be copied into the Renode tree:
`build/plugin` is the source of truth, not the loaded copy. `RENODE_BIN` supplies
that tree at build time and is machine-local, so it is never recorded here.
