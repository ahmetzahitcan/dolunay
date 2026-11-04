# Dolunay Golden Model — Design and Decisions

> **STATUS: legacy — design rationale, not current semantics.**
>
> This document was written for a previous variant and, in places, against the
> `ooo-lite` branch rather than this one. For what the model must currently do,
> and what is still open, read [`CONTRACT.md`](CONTRACT.md); for the choices
> already made, [`DECISIONS.md`](DECISIONS.md); for the agent rules,
> [`AGENTS.md`](AGENTS.md).
>
> Specifically stale: **§1.1** (it describes the `ooo-lite` tree — on this branch
> ITS *is* implemented and no instruction rows are disabled), **§5.4** and
> **§8.2** (there is no `control_unit/cugen/` package; the generator is the
> single-file `control_unit/generate.py`), **§10.1** (the geometry numbers),
> **§6.1** (the build scripts no longer name `riscv64-linux-gnu-gcc`), **§6.3**
> (the repository path quoted there is specific to one machine), and every
> reference to `pytb/` cocotb testbenches (they do not exist on this branch; the
> SystemVerilog testbenches in `tb/` do).
>
> Still valid, and worth reading: the layering argument (§3), the lane-based
> model and its costs (§4), the C#-rather-than-Python decision (§5.2), the
> pattern language (§5.3), the stepping model (§5.6), the profiling plan (§7),
> the repository argument (§8.1), and the rejected alternatives (§11).

This document records the design of the **golden model**: an executable reference
model of the Dolunay SIMT/ITS machine, used to

1. **verify the kernels** — check that the software produces the right answers,
2. **verify the GPU** — check that the RTL behaves like the reference, and
3. **profile the kernels** — find out which instructions and extensions they
   actually use, so we can decide what is worth implementing in hardware.

It is written to be self-contained: a reader with no memory of the design
discussion should be able to work from this document alone.

---

## Design decisions at a glance

| # | Decision | Why | Detail |
|---|----------|-----|--------|
| 1 | Renode supplies the **ISA layer** (its `RiscV32` core) | RV32 + F + A semantics are commodity; writing them would dominate the effort and the bug count | [§3](#3-layering) |
| 2 | The model and hooks are **C#**, not Renode's embedded Python | Renode's scripting is IronPython 2.7 — violates the repo's Python 3 conventions and is hostile to agents | [§5.2](#52-writing-the-model-in-c-not-python) |
| 3 | **Lane-based** model (each lane has its own PC), warp-structured | Divergence becomes free; a path-based model would reproduce the RTL's path machinery, bugs included | [§4](#4-the-lane-model) |
| 4 | The model **owns its memory** | The legacy memory model has path-level leader selection, which independent per-lane views of shared memory cannot express | [`ITS-SEMANTICS.md` §4](ITS-SEMANTICS.md#4-the-model-must-own-its-memory) |
| 5 | **One instruction at a time**, lane switching between steps | "Run until the next branch" needs a primitive Renode does not have, and is not worth it when the hot path is C# | [§5.6](#56-the-pc-and-the-stepping-model) |
| 6 | **Target framework `net8.0`** | It is what Renode actually ships as; matching it avoids version skew | [§5.8](#58-target-framework) |
| 7 | **Golden model lives in this repository** — but this is *open*, not settled | The ISA spec is shared with the RTL; the differential test wants both sides at once | [§8.1](#81-current-decision-and-what-is-still-open) |
| 8 | The golden model needs **no Linux**; only the RTL comparison does (Verilator) | Renode, .NET and a RISC-V cross toolchain all run on Windows | [§6](#6-toolchain-and-environments) |
| 9 | The **ISA spec stays the single source of truth** (`control_unit.csv`), feeding the RTL, the model's decode table, and Renode's opcode counters | Avoids the drift the whole exercise is meant to catch | [§5.4](#54-generating-the-patterns-from-the-csv--one-source-of-truth) |
| 10 | The scheduler policy is a **pluggable interface** | It is what makes the interleaving-independence property test possible | [§4.4](#44-scheduling-policy) |

**Read this first if you are new.** Two things are easy to get wrong:

- The ITS semantics described in [`ITS-SEMANTICS.md`](ITS-SEMANTICS.md) are from
  the **published** variant of Dolunay (DSD/SEAA 2026 WiP, branch
  `arch__dsd2026`). The **current variant is a redesign and need not be
  compatible with it.** The software in `ss/` is written against the legacy
  semantics and is, for that reason, itself suspect.
- The path structure was **architecturally visible** in the legacy variant, in
  two specific places. Neither has to hold in the new one, and whether the
  path structure is visible at all is **an open question**
  ([`ITS-SEMANTICS.md` §6](ITS-SEMANTICS.md#6-open-decision-path-visibility)).

---

## Table of contents

1. [The machine being modelled](#1-the-machine-being-modelled)
2. [Goals and non-goals](#2-goals-and-non-goals)
3. [Layering](#3-layering)
4. [The lane model](#4-the-lane-model)
5. [Renode integration](#5-renode-integration)
6. [Toolchain and environments](#6-toolchain-and-environments)
7. [Kernel profiling](#7-kernel-profiling)
8. [Repository layout](#8-repository-layout)
9. [Milestones](#9-milestones)
10. [Open questions](#10-open-questions)
11. [Rejected alternatives](#11-rejected-alternatives)
12. [References](#12-references)

---

## 1. The machine being modelled

Dolunay is a RISC-V SIMT accelerator with **Independent Thread Scheduling (ITS)**.

- `N_WARPS = 8` warps, `N_THREADS = 32` lanes per warp (`src/params_pkg.sv`).
- A **warp** is a group of lanes; a **path** is a subset of a warp's lanes that
  are executing the same instruction at the same PC, i.e. that share a PC.
- The front end (`src/core_frontend.sv`) fetches one instruction per cycle and
  dispatches it to the currently selected path's mask.
- The thread scheduler (`src/thread_scheduler.sv`) holds, per warp, a list of
  paths (`pc_list_r`, `mask_list_r`) and round-robins between them. A divergent
  branch splits one path into two; `yield` rotates to the next path.
- The register file is SIMD-wide: `simd_data_t` is
  `logic [N_THREADS-1:0][RLEN-1:0]`, i.e. one 32-bit value per lane per
  architectural register.

### 1.1 The state of the RTL today

This determines what the golden model can be compared against. Verified by
reading the tree:

- **The ITS features are not implemented in hardware yet.** `src/core_frontend.sv`
  ties `yield_i` to `0`; the barrier logic in `src/thread_scheduler.sv` and the
  divergent-branch path splitting in `src/core_frontend.sv` are commented out.
  The RTL currently behaves like a **legacy SIMT** machine with no independent
  thread scheduling.
- **Many instructions are disabled** in `control_unit/control_unit.csv` (rows
  whose instruction name is prefixed with `'` are not generated into
  `src/control_unit.sv`): `JALR`, `LR`, `SC`, `BINIT`, `BSYNC_0`/`BSYNC_1`,
  `YIELD`, all the custom CSRs, `FENCE`, `WDONE`, `CSRRW_FRM`, `CSRRW_FCSR`.
  63 instructions are enabled.
- **There is no completion signal.** `core_top.ready_o` is declared but never
  driven, and `WDONE` is disabled.
- **The LSU has no LR/SC support.** `src/fu_lsu.sv` distinguishes only load
  from store; there is no reservation set. `ss/src/mutex.c` uses
  `lr.w`/`sc.w.aq`/`fence`, so it cannot work on the RTL as it stands.
- **`hpms.sv` is written but not instantiated** — the instance in
  `src/core_top.sv` is commented out, and the HPM CSRs are disabled.
- **The memory architecture has been redesigned** and no longer matches the
  paper: the current tree has a single bank-mapped scratchpad
  (`spad_bank_of` in `params_pkg.sv`), no TLS port on `core_top`, and no region
  decode anywhere — `src/fu_lsu.sv:109` still carries the comment *"TODO: check
  that this is where the spad is mapped in memory"*.
- **`Bender.yml` still lists `tb/*.sv`**, but `tb/` was deleted in the cocotb
  migration and does not exist.
- **The geometry is inconsistent, and the inconsistency is now explained.**
  `ss/hdr/simt.h` says `WARP_COUNT 4`, `WARP_SIZE 8` — exactly the
  **published** configuration from the paper. `src/params_pkg.sv` says
  `N_WARPS = 8`, `N_THREADS = 32`, the **new** variant's larger configuration.
  The software is stale, not contradictory. See
  [§10.1](#101-open-decision-the-geometry).

### 1.2 The kernels are concurrent algorithms

From `ss/kernels/`:

- `ping_pong.c` — threads 0 and 1 of a warp share an accumulator. `ping`
  increments it when even and yields when odd; `pong` does the opposite. They
  hand off to each other via `yield`.
- `spmc.c` — a producer/consumer. The producer publishes under a mutex, then
  spins on `read_cnt` with `yield`; consumers spin on `data_idx` with `yield`,
  then use a barrier to count readers.
- `nearn.c` — a per-warp barrier reduction (`binit`/`bsync`) followed by a
  mutex-protected global update.

**Running any of these single-threaded does not merely give a less accurate
answer — it deadlocks.** `ping_pong`'s `ping` waits for the accumulator to
become odd, and only `pong` can make it odd; `spmc`'s producer waits for
`read_cnt`, which only consumers increment.

So a golden model that runs kernels one thread at a time is useless. The model
must run lanes concurrently, and the ITS instructions are the only places where
lanes interact.

**Caveat.** These kernels were written against the *legacy* ITS semantics. If
the new variant's semantics differ, the kernels need revisiting — and the
golden model is the thing that will show that.

---

## 2. Goals and non-goals

### Goals

| # | Goal | Means |
|---|------|-------|
| G1 | Verify the kernels | Run each kernel under the model and check the architectural result (memory contents, final register state) is correct. |
| G2 | Verify the GPU | Run the same kernel on the model and on the RTL and compare. |
| G3 | Profile the kernels | Produce a dynamic instruction histogram, so we can answer "is adding extension X worth it?". |

### Non-goals

- **Not a cycle-accurate model of the RTL's microarchitecture.** Renode's
  `ElapsedCycles` are Renode's notion of time, *not* Dolunay's cycle count. The
  RTL's real cycle counts come from the RTL (or from `hpms.sv` once it is
  enabled). The golden model is a *functional* reference; timing analysis is
  the RTL's job.
- **Not a replacement for the RTL's own testbenches.** `pytb/` stays as the
  unit-level RTL verification.
- **Not modelling the legacy design as-is.** The legacy semantics are the
  *reference* for what ITS means; the model implements whatever the new
  variant decides.

---

## 3. Layering

Three layers, bottom-up. Each is independently testable.

```
┌──────────────────────────────────────────────────────────────┐
│ L3  ITS semantics                                             │
│     binit / bsync / yield semantics, warp rendezvous,         │
│     path grouping, scheduler policy, lane states              │
│     → written by us, in C#                                    │
├──────────────────────────────────────────────────────────────┤
│ L2  Machine                                                   │
│     lanes, warps, paths, masks, the interleaving policy       │
│     → written by us, in C#                                    │
├──────────────────────────────────────────────────────────────┤
│ L1  ISA                                                       │
│     decode + execute one instruction on one lane's state      │
│     → Renode's RiscV32 CPU, with our hooks bolted on          │
└──────────────────────────────────────────────────────────────┘
```

**L1 is Renode's job.** We do not write a RISC-V interpreter. This is the
main reason Renode was chosen: it gives us a correct RV32 + F + A
implementation, including the awkward parts (rounding modes, `fflags`,
canonical NaNs, LR/SC) that would otherwise dominate the effort and the bug
count.

**L2 and L3 are ours**, and they are where the actual research contribution
lives. They are written in **C#**, inside the same Renode plugin that hosts
them (see [§5](#5-renode-integration) for why that is forced).

**L2 also owns the memory** — see
[`ITS-SEMANTICS.md` §4](ITS-SEMANTICS.md#4-the-model-must-own-its-memory),
which is the one place where the layering needs care.

The ITS semantics themselves — what `binit`/`bsync`/`yield` *mean*, and what
is still undecided — are in [`ITS-SEMANTICS.md`](ITS-SEMANTICS.md).

---

## 4. The lane model

### 4.1 Lane-based, warp-structured

The model keeps, per **lane**:

- a program counter,
- the architectural register file (32 integer + 32 float registers),
- the CSR values that matter (`xwarpid`, `xthrid`, `xrole`, `mhartid`).

And per **warp**:

- the set of lanes belonging to it,
- the path structure (which lanes share a PC),
- the barrier objects and their arrival state.

The warp is the unit of *rendezvous* (`binit`/`bsync` are warp-wide) and of
*scheduling contention*. The lane is the unit of *execution state*. A model
that treated all threads as one flat pool with no warp structure would be
wrong: it would make `bsync` a global barrier or a no-op, and `xrole`
meaningless.

### 4.2 Why lane-based rather than path-based

The question was whether the model should be **path-based** (the lanes of a path
execute in lockstep, exactly as in the RTL) or **lane-based** (each lane has
its own PC and executes independently).

**Decision: lane-based.**

Reasons, in order of weight:

1. **Divergence is free.** In a lane-based model, when lanes take different
   branches their PCs simply differ. There is nothing to implement and nothing
   to get wrong. In a path-based model, path splitting is a central mechanism
   that must be exactly right.
2. **The paper says the distinction is not architecturally visible.** "At the
   microarchitectural level, Dolunay does not assign a unique PC to each
   thread, but rather to each path. However, because Dolunay correctly handles
   the worst-case scenario of one thread per path, this distinction is not
   architecturally visible." (Sec. III-B2) A path-based golden model would
   therefore be modelling an implementation detail — and would inherit the
   RTL's bugs in it. (The two *architecturally visible* consequences of the
   path structure are handled separately; see
   [`ITS-SEMANTICS.md` §6](ITS-SEMANTICS.md#6-open-decision-path-visibility).)
3. **The ITS semantics are stated per-lane.** `binit`/`bsync`/`yield` are
   defined in terms of threads arriving and waiting, not in terms of path
   bookkeeping. The lane-based model expresses them directly.
4. **Independence from the RTL's scheduling.** A golden model that mirrors the
   RTL's path machinery cannot catch a bug *in* that machinery — it would
   reproduce it. Lane-based models the same *architectural* semantics while
   making different scheduling choices, so agreement is meaningful.
5. **It is what the kernels actually require.** See
   [§1.2](#12-the-kernels-are-concurrent-algorithms): the kernels are written
   to be correct under *any* fair interleaving.

**But paths are not discarded.** They reappear as a *scheduler constraint*
rather than as machine state:

- The scheduler maintains, per warp, a grouping of lanes that currently share
  a PC.
- The policy for advancing that grouping — how lanes are grouped into
  co-scheduled sets, how the sets are rotated — is a pluggable **policy**, not
  a hard-coded mechanism.

### 4.3 What lane-based execution costs

In the RTL, all lanes of a path execute the same instruction in the same
cycle, so their memory accesses are ordered with respect to each other. A
lane-based model that runs lanes sequentially does *not* preserve that
ordering: lane 0 writing X at instruction 5 and lane 1 reading X at
instruction 3 would see the new value in the model and the old value in the
RTL.

The legacy design *defines* this behaviour rather than leaving it undefined —
see [`ITS-SEMANTICS.md` §3.3](ITS-SEMANTICS.md#33-legacy-memory-model). The
resolution is therefore **not** to assert that lanes never share an address,
but to **implement the leader-selection semantics** in the model's memory
layer. That is why the model owns memory.

### 4.4 Scheduling policy

The scheduler decides which lane runs next. Pluggable policies:

- **Round-robin over lanes** — the simplest fair policy.
- **Random with a seed** — for the interleaving-robustness test.
- **Path-aware** — group lanes that share a PC and rotate between groups, the
  closest analogue to the RTL's behaviour.

A policy is an interface, not a constant. That is what makes the
interleaving-robustness test possible: run the same kernel under N different
seeds and check the final memory is identical every time. If it is, the kernel
is interleaving-independent and the model and the RTL can be compared under
any policy; if not, the kernel has a latent race and comparing them requires
*replaying the same interleaving* on both sides.

---

## 5. Renode integration

### 5.1 What Renode gives us

Renode (<https://github.com/renode/renode>) is a full-system emulator. We use
it as:

- a **RISC-V CPU** (its `RiscV32` core) — the L1 ISA layer;
- a **host** for our model (L2 + L3), as a plugin;
- a **testbench** — Renode's Robot Framework framework and its
  `renode-test` runner, and its execution tracer / metrics analyser.

### 5.2 Writing the model in C#, not Python

Renode's embedded scripting is **IronPython 2.7**
(`src/Emulator/Main/Core/PythonEngine.cs` uses `IronPython.Hosting`). Its
custom-instruction and custom-CSR handlers are Python scripts.

That was rejected:

- Python 2 syntax, and `print` as a statement — unfamiliar and error-prone.
- `AGENTS.md` assumes Python 3 throughout (`from __future__ import
  annotations`, `pyrightconfig.json` with `typeCheckingMode: standard`, ruff).
  A Python 2 island in the repo violates those conventions.
- Agents are much more effective on modern Python than on IronPython 2.

**Decision: the model and all Renode hooks are C#.**

This turns out to be *better* than the Python route, not merely a workaround.
`BaseRiscV` exposes the needed API as ordinary C#:

```csharp
// src/Emulator/Cores/RiscV/BaseRiscV.cs
public bool InstallCustomInstruction(string pattern, Action<UInt64> handler, string name = null)
public void RegisterCSR(ushort csr, Func<ulong> readOperation,
                        Action<ulong> writeOperation, string name = null)
public void RegisterCustomCSR(string name, ushort number, PrivilegeLevel mode)
```

`InstallCustomInstruction` installs the pattern into the **native** decoder
(`TlibInstallCustomInstruction`), so the handler fully replaces the built-in
behaviour — including overriding a *standard* instruction. Renode's own test
`tests/unit-tests/riscv-custom-instructions.robot` has a case named *"Should
Override An Existing 32-bit Instruction"*, which overrides `addi` and confirms
the register is not written.

### 5.3 The pattern language

Patterns are parsed by `Misc.TryParseBitPattern`:

```csharp
case '0': mask |= ...; break;                 // fixed zero
case '1': mask |= ...; value |= ...; break;    // fixed one
default: break;   // ALL other characters are 'any-value'
```

So **`0` and `1` are the only significant characters** — `x`, `?`, `b`, `a`
are all wildcards. Patterns must be 16, 32 or 64 characters, and for 32-bit
patterns `CheckCustomInstructionLengthPattern` requires the low two bits to be
`11` and bits `[4:2]` to not be `111` (the RISC-V instruction-length encoding
rule).

### 5.4 Generating the patterns from the CSV — one source of truth

`control_unit/control_unit.csv` is the ISA specification. Its `match_string`
column already has exactly the right shape: a bit pattern with `?` for
wildcards, over `instr[31:2]` (30 bits), with `_` as a visual separator.

To turn a CSV row into a Renode pattern:

1. **strip the `_` separators** — every character, including `_`, advances the
   bit position in `TryParseBitPattern`, so separators must be removed;
2. **append `11`** for the low two bits, which are always `11` in a 32-bit
   RISC-V instruction;
3. the result is a 32-character pattern in which `?` is already a valid
   wildcard.

This belongs in `control_unit/cugen` as a new emitter, alongside the existing
SystemVerilog one. The same CSV then produces:

- `src/control_unit.sv` — the RTL's control unit,
- the golden model's decode table,
- the Renode opcode-counter patterns for profiling ([§7](#7-kernel-profiling)).

**One specification, three consumers.** This is the main reason the golden
model lives in this repository rather than a separate one.

### 5.5 Which instructions to hook

| Hook | Why |
|---|---|
| `binit`, `bsync`, `yield` | The ITS semantics live here. |
| `xwarpid`, `xthrid`, `xrole` | Custom CSRs; `RegisterCSR` with our own read/write functions. |
| Loads and stores | The model owns memory — see [`ITS-SEMANTICS.md` §4](ITS-SEMANTICS.md#4-the-model-must-own-its-memory). |
| `lr.w`, `sc.w` | Reservation sets and the SC-never-replays rule. |
| Branches (`beq`, `bne`, …) | **Only if** the path structure stays architecturally visible — see [`ITS-SEMANTICS.md` §6](ITS-SEMANTICS.md#6-open-decision-path-visibility). |

### 5.6 The PC, and the stepping model

Renode's `ICPU` exposes:

```csharp
ulong Step(int count = 1);       // returns instructions executed
ulong ElapsedCycles { get; }
ulong ExecutedInstructions { get; }
RegisterValue PC { get; set; }
```

and `ICPUWithRegisters` gives `GetRegister(int)` / `SetRegister(int,
RegisterValue)` for the register file, with string-alias helpers
(`GetRegisterUlong(cpu, "x5")`, and `"PC"`) in
`ICPUWithRegistersExtensions`.

**Stepping model: one instruction at a time, with lane switching between
steps.** The model saves the current lane's state, restores the next lane's
state, calls `Step(1)`, and repeats.

An earlier design considered a faster scheme: let a lane run until it hit a
branch or a custom instruction, then switch lanes. This was **rejected**:
interception does not give a cheap "run until X" primitive, the added
complexity was not worth it, and the hot path is in C# anyway, where the
per-instruction overhead is small.

### 5.7 Running the model

Two ways to get the C# into Renode:

| Route | How | When |
|---|---|---|
| **Ad-hoc** | `i @Dolunay.cs` in the Renode monitor. Renode's `AdHocCompiler` compiles the file at runtime with the bundled Roslyn (`Microsoft.CodeAnalysis.CSharp`), referencing the assemblies already loaded in the AppDomain. | Prototyping. **No .NET SDK needed.** |
| **Pre-built plugin** | A `.csproj` → `.dll` dropped into Renode's `plugins/` directory; `TypeManager` finds it by the `[Plugin]` attribute. | When we want unit tests, NuGet packages, multiple files. Needs the .NET SDK. |

Note the ad-hoc path compiles against *already-loaded* assemblies, so it can
see `BaseRiscV` — but this is **unverified** and is the single most important
assumption in the plan (see [§10.2](#102-open-decision-can-we-even-load-c)).

### 5.8 Target framework

**`net8.0`.**

Renode's `Renode.csproj` says `net6.0`, but that is stale and not what
ships:

- `build.sh` sets `TFM="net8.0"` and generates a root `Directory.Build.targets`
  containing `<TargetFrameworks>net8.0</TargetFrameworks>`. That file is
  **gitignored** — it is a build artifact — and it is imported via
  `src/Directory.Build.targets`. `Directory.Build.targets` is imported *after*
  the project body, so it **overrides** the csproj value.
- The Debian and RPM packages declare `dotnet-runtime-8.0` as a dependency.
- `Renode.csproj` sets `<RollForward>Major</RollForward>`, so Renode also runs
  on newer runtimes.

net8.0 is the current LTS. The plugin must target the same BCL surface as the
Renode it plugs into, to avoid version skew when Renode's internals call into
our code.

`LangVersion 12.0` (C# 12) is Renode's setting; that is the language level,
independent of the target framework.

---

## 6. Toolchain and environments

### 6.1 The golden model does not need Linux

| Tool | Needed for | Runs on Windows? |
|---|---|---|
| Renode | the model | **Yes** — official Windows installer (`.msi`, `.setup.exe`) and a Windows portable zip. |
| .NET **SDK** | building a pre-built plugin, unit tests | **Yes** — native Windows installer. *Not currently installed* on the dev machine: runtimes 8.0.22 / 9.0.11 / 10.0.1 are present, but `dotnet --info` reports *"No SDKs were found."* |
| RISC-V cross toolchain | building the kernels | **Yes**, with a Windows-hosted toolchain. The scripts currently name `riscv64-linux-gnu-gcc`; a host-side `riscv32-unknown-elf-gcc` is the natural equivalent for this freestanding, `-mabi=ilp32` build. |
| Verilator | the existing `pytb/` cocotb flow, and **M5** (differential test vs. the RTL) | **No** — Verilator is a POSIX tool with no supported native Windows build. |

**So: everything except the RTL comparison can be done on the Windows
machine.** The Linux requirement comes from exactly one thing — Verilator — and
that is needed only for M5.

### 6.2 Where the RTL comparison runs

Verilator has no supported native Windows build, so M5 needs Linux. Two
options:

- **The separate Linux machine.** Cheapest: the RTL side runs there, the model
  side runs wherever it is convenient, and the two communicate over the network
  or over a shared checkout.
- **WSL2 on the Windows machine.** Keeps everything on one box, but adds a
  layer between the editor and the toolchain.

**WSL2 and Docker are not required for the golden model.** They are two ways
of *manufacturing* a Linux environment on a Windows host, and the golden model
does not need one. Docker on Windows additionally requires WSL2 (or Hyper-V)
anyway, so it is not a lighter option than WSL2 — it is a heavier one.

### 6.3 A Windows-hosting gotcha worth knowing

The repository path contains spaces and is on OneDrive:
`C:\Users\azc\OneDrive - Yildiz Technical University\Belgeler\dolunay`.

`pytb/README.md` already records the consequence: *"GNU Make misbehaves when
the directory it builds in has a space in its path — and the project may well
live under such a path."* That is why `pytb/run.py` puts its build trees in
`DOLUNAY_BUILD_DIR` (default `~/dolunay-sim`), outside the project.

The same applies to the golden model: **keep build outputs and Renode's
working directory off the OneDrive path.** Renode resolves relative paths
against its working directory, and a synced folder is a poor place for a build
tree.

### 6.4 Summary

| Phase | Where |
|---|---|
| Golden model development (M1–M4, M6–M7) | **Windows**, natively. Renode + .NET SDK. |
| RTL differential test (M5) | **Linux** — the separate machine, or WSL2. Needs Verilator. |

---

## 7. Kernel profiling

Goal G3: answer *"if adding extension X only helps one kernel a little, is it
worth the effort?"*

Renode's `TranslationCPU_OpcodesCounting.cs` provides this at native speed:

```csharp
public void InstallOpcodeCounterPattern(string name, string pattern)  // 16 or 32 bits
public ulong GetOpcodeCounter(string name)
public string[,] GetAllOpcodesCounters()
```

The patterns use the same wildcard format as custom instructions, so they can
be generated from `control_unit/control_unit.csv` by the same `cugen` emitter
([§5.4](#54-generating-the-patterns-from-the-csv--one-source-of-truth)).

One counter per extension (or per instruction) gives a dynamic instruction
histogram with **no per-instruction Python or C# overhead**.

Per kernel we want:

- **instruction histogram** — counts per instruction, and per extension.
- **share** — what fraction of executed instructions come from each extension.
  This is the number that answers "is extension X worth it?".
- **memory access trace** — addresses, sizes, load/store, per lane. Feeds the
  bank-conflict analysis (using `spad_bank_of` from `params_pkg.sv`).
- **control-flow statistics** — divergent vs. uniform branches, barrier waits,
  yields.

`control_unit/cugen` already has a clean model → emitter structure
(`csv_parser.py` → `model.py` → `sv_emitter.py`). Adding a `pattern_emitter.py`
and, if needed, a `py_emitter.py` is a natural extension. If the model needs
a Python decode table at all, it should be generated the same way.

---

## 8. Repository layout

### 8.1 Current decision, and what is still open

**Current decision: the golden model lives in this repository**, in a new
top-level `golden/` directory. The kernels stay where they are.

**This is not settled.** A separate repository remains a live option, and the
argument for it is a real one: the golden model is a substantial project with
its own toolchain (C#, .NET, Renode) and its own lifecycle, and a repository
that hosts RTL, a Python testbench framework, a C generator and a C# emulator
is a lot of things at once.

What the decision turns on:

| | Same repository | Separate repository |
|---|---|---|
| The ISA specification (`control_unit/control_unit.csv`) | One copy, one commit | Duplicated (drift) or a submodule (friction) |
| The differential test | One checkout, one CI run | Two checkouts at matched versions |
| Build systems in one tree | Bender (SV), pip (Python), dotnet (C#) | One build system each |
| The geometry inconsistency | Visible in one tree | Becomes cross-repo version skew — much harder to spot |
| Independence of the model | Tied to the RTL's cadence | Free to evolve independently |

**The geometry point is the strongest argument for keeping them together
today**: `ss/hdr/simt.h` and `src/params_pkg.sv` already disagree
([§1.1](#11-the-state-of-the-rtl-today)), and splitting the repositories
would turn a within-repo inconsistency into a cross-repo version-skew problem.

There is also **no CI configured yet**, so there is no immediate pressure to
separate build systems.

**Recommendation: keep it together for now, and revisit when the ISA
stabilises.** If it does split, the sensible cut is not "model vs. everything
else" but:

| Repository | Contents | Why |
|---|---|---|
| `dolunay-isa` | the ISA specification: `control_unit.csv`, CSR assignments, memory map, ITS semantics, `cugen` | The contract. Versioned, referenced by both. |
| `dolunay` (this one) | the RTL, `pytb/`, `golden/` | The machine and both implementations. |

The kernels are a poor split candidate either way: they depend on the ISA
(`ss/hdr/simt.h` hard-codes the CSR numbers and the geometry), they are the
stimulus for both implementations, and `asm-kernels/generate.sh` writes
`../irom.mem`, which the RTL's `src/irom.sv` reads with `$readmemh`.

### 8.2 Layout

```
dolunay/
  src/                 RTL
  control_unit/        ISA spec (CSV) + cugen generator
    cugen/
      pattern_emitter.py   (new) → Renode opcode patterns + counters
      py_emitter.py        (new, if needed) → Python decode table
  pytb/                cocotb testbenches for the RTL
  asm-kernels/         hand-written assembly tests (stimulus)
  ss/                  bare-metal runtime + C kernels (stimulus)
  golden/              (new) the golden model
    README.md             index: what is here, and what to read in what order
    DESIGN.md             this document: design and decisions (legacy-flavoured)
    ITS-SEMANTICS.md      ITS semantics: what is open, what the legacy design did
    Dolunay.Golden.cs     the whole model + Renode glue, as one plugin
    Dolunay.Golden.repl   Renode platform description
```

### 8.3 Why the model is one file, not a library plus a plugin

An earlier sketch had the model as a separate .NET library with a thin plugin
wrapper. **That does not survive contact with Renode.** The model needs
`BaseRiscV` — from Renode's `Infrastructure` assembly, which is **not
published on NuGet** (there is no `renode.infrastructure` package; the
`renode` package on NuGet is an unrelated, ancient 2.9.6). So:

- referencing it from a separate library means building against Renode's
  source checkout (heavy) or against the DLLs of an installed Renode
  (version-coupled);
- the ad-hoc `i @file.cs` route sidesteps compile-time references entirely,
  because the compiler resolves against what is already loaded.

Hence: one plugin containing both the model and the Renode glue. The
consequence is that the model **cannot be unit-tested in isolation** outside
Renode, which is the main cost of this decision. If that turns out to hurt,
the escape hatch is the `Monitor`/`SystemBus` external-control socket API
(`tools/external_control_client`), which lets an out-of-process component
drive Renode.

---

## 9. Milestones

Ordered so that each one is independently useful and de-risks the next.

### M0 — Unblock the RTL

Before anything can be compared against the RTL, the RTL must be able to run
the kernels at all. Currently it cannot:

- enable the disabled instructions in `control_unit/control_unit.csv`
  (`LR`, `SC`, `FENCE`, `BINIT`, `BSYNC_0`/`BSYNC_1`, `YIELD`, `WDONE`, and
  the CSRs the software reads);
- implement LR/SC and `fence` in `src/fu_lsu.sv` — there is no reservation
  set today;
- drive `core_top.ready_o`, so something can tell that the kernel finished;
- resolve the geometry conflict ([§10.1](#101-open-decision-the-geometry)).

Note that `WDONE` in the CSV is a *specialisation of `slti x0, x0, 0`* — the
same encoding `asm-kernels/instructions.s` produces — so enabling it is a
pattern-specificity question for the generator, not a new opcode.

### M1 — A working probe (validates the whole chain)

The smallest thing that proves the approach:

- a Renode platform (`.repl`) with one `CPU.RiscV32`,
- the kernel loaded into it,
- a C# plugin that installs one custom instruction handler and one custom
  CSR, steps the CPU, and reads back the final memory.

This validates: plugin loading, `InstallCustomInstruction`, `RegisterCSR`,
`Step`, and memory access. **Do this before building anything else.** It is
a day of work and it settles
[§10.2](#102-open-decision-can-we-even-load-c).

### M2 — The lane model

- per-lane state (PC, registers, CSRs),
- lane switching with save/restore,
- the scheduler policy interface,
- model-owned memory,
- run a *non-concurrent* kernel (`vecadd`, `saxpy`, `gemm`) and check the
  result against the C reference.

### M3 — The ITS semantics

This is the milestone where the open questions get answered, one at a time. See
[`ITS-SEMANTICS.md` §7](ITS-SEMANTICS.md#7-what-the-model-must-implement).

### M4 — The property test

Run each kernel under N scheduler seeds; assert the final memory is identical
every time. This is the interleaving-independence check
([§4.4](#44-scheduling-policy)), and it is what makes the model a *golden*
model rather than just another implementation.

### M5 — Differential testing against the RTL

Run the same kernel on the model and on the RTL (via `pytb/`), compare
architectural state. Requires M0, and a Linux environment
([§6.2](#62-where-the-rtl-comparison-runs)).

### M6 — Profiling

Install opcode counters from the CSV-derived patterns; produce the
instruction histogram and the memory access trace; report per-extension
share. This is goal G3 and it is independent of M1–M5.

### M7 — Co-scheduling and bank-conflict analysis

Use the memory access trace with `spad_bank_of` from `params_pkg.sv` to
report bank conflicts, and to check the co-scheduling property
([§4.3](#43-what-lane-based-execution-costs)).

---

## 10. Open questions

The semantics questions live in
[`ITS-SEMANTICS.md` §8](ITS-SEMANTICS.md#8-open-questions). The ones here are
about the project rather than the architecture.

### 10.1 Open decision: the geometry

`src/params_pkg.sv` says `N_WARPS = 8`, `N_THREADS = 32`.
`ss/hdr/simt.h` says `WARP_COUNT 4`, `WARP_SIZE 8`.

**The inconsistency is now explained:** `simt.h` matches the *published*
configuration from the paper (4 warps, 8 threads per warp, 2 KiB TLS), and
`params_pkg.sv` is the *new* variant's larger configuration. The software is
stale, not contradictory.

**The decision is which way to bring them together:**

- update `ss/` to the new geometry (8 × 32) — but `WARP_COUNT`/`WARP_SIZE`
  are used to compute `GLOBAL_SIZE`, which the kernels index with, so this is a
  real change to the software, not just a `#define`;
- or bring `params_pkg.sv` back to 4 × 8 — but the RTL has clearly been
  scaled up deliberately;
- or make the geometry a build-time parameter, with the software compiled per
  configuration, and the golden model parameterised the same way.

**Needs deciding before M1**, because it determines the number of lanes the
model has to carry.

### 10.2 Open decision: can we even load C#?

The ad-hoc route (`i @file.cs`) compiles against the assemblies already loaded
in the AppDomain. We *believe* `Infrastructure.dll` is among them (the CPU
class lives there), but this is **unverified**, and it is load-bearing for
the whole plan.

Fallback if it fails: build a plugin against an installed Renode's DLLs
(version-coupled, but workable).

Either way, the one-hour experiment in M1 settles it.

### 10.3 Open decision: how does the model *end*?

There is no `wdone` in hardware yet and `core_top.ready_o` is undriven. The
model needs its own termination condition — presumably all lanes have
finished (e.g. all PCs are in a trap loop, or a `wdone` was executed by every
lane). This is M0's problem as much as the model's.

### 10.4 Open decision: is the "one file" model going to get too big?

The model will contain: the lane and warp state, the scheduler policies, the
ITS semantics, the model-owned memory, the trace/profiling output, and the
Renode glue. That is a lot for one file. If it grows past a few thousand
lines, the natural split is *within* the plugin (several `.cs` files in one
assembly) rather than across assemblies — which is possible with the
pre-built plugin route but **not** with `i @file.cs`, which takes one file at
a time.

### 10.5 Open decision: separate repository?

See [§8.1](#81-current-decision-and-what-is-still-open). Currently: same
repository, revisit when the ISA stabilises.

---

## 11. Rejected alternatives

Recorded so they are not re-litigated. **Note that "separate repository" is
not in this list** — it remains open
([§10.5](#105-open-decision-separate-repository)).

| Alternative | Why rejected |
|---|---|
| **Write the ISA layer ourselves** (a Python or C# RISC-V interpreter) | The RV32 + F + A semantics — rounding modes, `fflags`, canonical NaNs, LR/SC — would dominate the effort and the bug count, and are pure commodity. Renode provides them. |
| **Fork Spike** | Spike is the reference implementation and would be a fine ISA layer, but it has no support for custom instructions in Python, no SIMT/lane concept, and none of the system-level apparatus (platform descriptions, peripherals, tracing) that we need. Spike remains the natural **differential oracle for the ISA layer** if we want a second opinion. |
| **Renode's embedded Python (IronPython 2.7)** for the hooks and model | Python 2; violates the repo's Python 3 conventions; hostile to agents. See [§5.2](#52-writing-the-model-in-c-not-python). |
| **QEMU user-mode + GDB stub** as the substrate | Cannot suspend a hart at an arbitrary point and resume it with a different PC; the multi-hart stepping model is awkward; no SIMT support; no custom-instruction story. |
| **A native/host-compiled "shim" for the kernels** (compile the C kernels natively with `simt_*` replaced by host implementations) | The kernels are *concurrent algorithms* — `ping_pong` and `spmc` deadlock when run single-threaded, and the whole point of ITS is lost. Also does not apply to `asm-kernels/`, which are hand-written assembly. |
| **A source-to-source transpiler** expanding SIMD into per-lane loops with masks | Cannot express a warp-wide rendezvous: a sequential lane loop deadlocks on the first `bsync`. It also does not cover `asm-kernels/` at all, which need an interpreter regardless. |
| **"Run until the lane hits a branch or custom instruction", then switch lanes** | Interception does not provide a cheap "run until X" primitive; the complexity is not worth it when the hot path is C#. See [§5.6](#56-the-pc-and-the-stepping-model). |
| **Path-based model** (lanes of a path in lockstep, as in the RTL) | Cannot catch a bug in the RTL's path machinery, because it reproduces it; and the paper says the per-path-PC distinction is not architecturally visible. See [§4.2](#42-why-lane-based-rather-than-path-based). |
| **Borrowing Renode's memory instead of modelling it** | The legacy memory model has path-level leader selection, which independent per-lane views of a shared memory cannot express. See [`ITS-SEMANTICS.md` §4](ITS-SEMANTICS.md#4-the-model-must-own-its-memory). |

---

## 12. References

### In this directory

| File | What |
|---|---|
| [`ITS-SEMANTICS.md`](ITS-SEMANTICS.md) | The ITS semantics: what is still open, what the legacy design did, and what the model must implement. |

### The paper (legacy design)

> *Dolunay: Architectural Support for Independent Thread Scheduling in a RISC-V
> SIMT Accelerator*, Ahmet Zahit Can, Erkan Uslu. DSD/SEAA 2026 WiP Session,
> Kraków, Poland, Sept. 2026. The variant described is branch `arch__dsd2026`
> of <https://github.com/ahmetzahitcan/dolunay>.

Relevant sections: III-A1 (custom instructions, the barrier context, the
`BSYNC` algorithm in Fig. 1, the custom CSRs), III-A3 (the HPMs), III-B2
(thread schedulers, paths, `xrole`), III-B3 (memory: regions, leader selection,
TLS, LR/SC), IV-B (the ping-pong and spmc kernels).

### Renode (`renode/renode` + `renode/renode-infrastructure`)

| What | Where |
|---|---|
| Custom instruction installation (C#) | `src/Emulator/Cores/RiscV/BaseRiscV.cs` — `InstallCustomInstruction` |
| Custom instruction dispatch, PC control | same file — `HandleCustomInstruction`, `PCWritten`, `pcWrittenFlag` |
| Custom CSR registration (C#) | same file — `RegisterCSR`, `RegisterCustomCSR` |
| Pattern parsing | `src/Emulator/Main/Utilities/Misc.cs` — `TryParseBitPattern` |
| Pattern length rules | `src/Emulator/Cores/RiscV/BaseRiscV.cs` — `CheckCustomInstructionLengthPattern` |
| CPU stepping, PC, register access | `src/Emulator/Main/Peripherals/CPU/ICPU.cs`, `.../ICPUWithRegisters.cs` |
| RISC-V CPU, PC register | `src/Emulator/Cores/RiscV/RiscV32.cs`, `RiscV32Registers.cs` |
| Opcode counters | `src/Emulator/Peripherals/Peripherals/CPU/TranslationCPU_OpcodesCounting.cs` |
| Ad-hoc C# compilation | `src/Emulator/Main/Utilities/AdHocCompiler.cs`, `src/Emulator/Extensions/UserInterface/Commands/IncludeFileCommand.cs` |
| Plugin mechanism | `src/Emulator/Main/Plugins/PluginAttribute.cs`, `PluginManager.cs`, `src/Emulator/Main/Utilities/TypeManager.cs` |
| Target framework | `build.sh` (`TFM="net8.0"`), generated `Directory.Build.targets` (gitignored), `src/Renode/Renode.csproj` (`RollForward=Major`) |
| Custom instruction test | `tests/unit-tests/riscv-custom-instructions.robot` |
| External control (socket) API | `tools/external_control_client/` |
| Windows packaging | `README.md` — `.msi`, `.setup.exe`, Windows portable zip |

### Dolunay (this repository)

| What | Where |
|---|---|
| Machine parameters, geometry, bank mapping | `src/params_pkg.sv` |
| Path/split mechanism | `src/thread_scheduler.sv`, `src/core_frontend.sv` |
| LSU | `src/fu_lsu.sv` |
| ISA specification | `control_unit/control_unit.csv` |
| Generator | `control_unit/cugen/` (`csv_parser.py`, `model.py`, `sv_emitter.py`) |
| ITS instruction macros, CSR numbers | `asm-kernels/instructions.s`, `ss/hdr/simt.h` |
| ITS runtime | `ss/src/simt.c`, `ss/src/mutex.c` |
| Kernels | `ss/kernels/`, `asm-kernels/` |
| Memory map (software view) | `ss/link.ld` |
| Hardware performance counters (written, not instantiated) | `src/hpms.sv` |
| Cocotb testbenches | `pytb/` |
