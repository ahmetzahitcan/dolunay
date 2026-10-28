# Dolunay Golden Model — Design and Decisions

This document records the design of the **golden model**: an executable reference
model of the Dolunay SIMT/ITS machine, used to

1. **verify the kernels** — check that the software produces the right answers,
2. **verify the GPU** — check that the RTL behaves like the reference, and
3. **profile the kernels** — find out which instructions and extensions they
   actually use, so we can decide what is worth implementing in hardware.

It is written to be self-contained: a reader with no memory of the design
discussion should be able to work from this document alone.

**Status: design agreed, not yet implemented.** Open questions are listed in
[§11](#11-open-questions).

---

## Table of contents

1. [The machine being modelled](#1-the-machine-being-modelled)
2. [Goals and non-goals](#2-goals-and-non-goals)
3. [Layering](#3-layering)
4. [The lane model](#4-the-lane-model)
5. [ITS semantics](#5-its-semantics)
6. [Renode integration](#6-renode-integration)
7. [Toolchain](#7-toolchain)
8. [Kernel profiling](#8-kernel-profiling)
9. [Repository layout](#9-repository-layout)
10. [Milestones](#10-milestones)
11. [Open questions](#11-open-questions)
12. [Rejected alternatives](#12-rejected-alternatives)
13. [Source references](#13-source-references)

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

This matters because it determines what the golden model can be compared
against. Verified by reading the tree:

- **The ITS features are not implemented in hardware yet.**
  - `src/core_frontend.sv` ties `yield_i` to `0`.
  - The barrier logic in `src/thread_scheduler.sv` is commented out
    (`barr_load_*`, `barr_sync_*` ports).
  - The divergent-branch path splitting in `src/core_frontend.sv` is commented
    out (the `BR_DIVERGENT` case and `split_w`).
  - Consequence: the RTL currently behaves like a **legacy SIMT** machine with
    no independent thread scheduling.
- **Many instructions are disabled** in `control_unit/control_unit.csv` (rows
  whose instruction name is prefixed with `'` are commented out and are not
  generated into `src/control_unit.sv`). Disabled: `JALR`, `LR`, `SC`, `BINIT`,
  `BSYNC_0` (and its `BSYNC_1` half), `YIELD`, all the custom CSRs
  (`CSR_MHARTID`, `CSR_XWARPID`, `CSR_XTHRID`, `CSR_XROLE`, the cycle/instret
  counters, `CSR_OTHER`), `FENCE`, `WDONE`, `CSRRW_FRM`, `CSRRW_FCSR`.
  63 instructions are enabled.
- **There is no completion signal.** `core_top.ready_o` is declared but never
  driven, and `WDONE` is disabled. Nothing tells a testbench that the kernel
  finished.
- **The LSU has no LR/SC support.** `src/fu_lsu.sv` distinguishes only load
  from store; there is no reservation set. So `ss/src/mutex.c`, which uses
  `lr.w`/`sc.w.aq`/`fence`, cannot work on the RTL as it stands.
- **`hpms.sv` is written but not instantiated** — the instance in
  `src/core_top.sv` is commented out, and the HPM CSRs are disabled.
- **`Bender.yml` still lists `tb/*.sv`**, but `tb/` was deleted in the cocotb
  migration and does not exist.
- **The geometry is inconsistent.** `src/params_pkg.sv` says
  `N_WARPS = 8`, `N_THREADS = 32`; `ss/hdr/simt.h` says `WARP_COUNT 4`,
  `WARP_SIZE 8`. See [§11.1](#111-open-decision-1-the-geometry).

### 1.2 The kernels are concurrent algorithms

This is the single most important fact about the software, and it rules out
several designs. From `ss/kernels/`:

- `ping_pong.c` — threads 0 and 1 of a warp share an accumulator. `ping`
  increments it when even and yields when odd; `pong` does the opposite.
  They hand off to each other via `yield`.
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
- **Not modelling unimplemented hardware.** The model defines the *intended*
  semantics of ITS; the RTL does not implement it yet.

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
them (see [§6](#6-renode-integration) for why that is forced).

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
that treated 256 threads as one flat pool with no warp structure would be
wrong: it would make `bsync` a global barrier or a no-op, and `xrole`
meaningless.

### 4.2 Why lane-based rather than path-based

Initially the question was whether the model should be **path-based** (the
lanes of a path execute in lockstep, exactly as in the RTL) or **lane-based**
(each lane has its own PC and executes independently).

**Decision: lane-based.**

Reasons, in order of weight:

1. **Divergence is free.** In a lane-based model, when lanes take different
   branches their PCs simply differ. There is nothing to implement and nothing
   to get wrong. In a path-based model, path splitting is a central mechanism
   that must be exactly right, and it is precisely the thing the RTL has not
   implemented yet.
2. **The ITS semantics are stated per-lane.** `binit`/`bsync`/`yield` are
   defined in terms of threads arriving and waiting, not in terms of path
   bookkeeping. The lane-based model expresses them directly.
3. **Independence from the RTL's scheduling.** A golden model that mirrors the
   RTL's path machinery cannot catch a bug *in* that machinery — it would
   reproduce it. Lane-based models the same *architectural* semantics while
   making different scheduling choices, so agreement is meaningful.
4. **It is what the kernels actually require.** See
   [§1.2](#12-the-kernels-are-concurrent-algorithms): the kernels are written
   to be correct under *any* fair interleaving.

**But paths are not discarded.** They reappear as a *scheduler constraint*
rather than as machine state:

- The scheduler maintains, per warp, a grouping of lanes that currently share
  a PC.
- The policy for advancing that grouping — how lanes are grouped into
  co-scheduled sets, how the sets are rotated — is a pluggable **policy**, not
  a hard-coded mechanism.

### 4.3 The co-scheduling caveat (important)

In the RTL, all lanes of a path execute the same instruction in the same
cycle, so **their memory accesses are ordered with respect to each other**.

A lane-based model that runs lanes sequentially does *not* preserve that
ordering. Concretely: lane 0 writes address X at instruction 5, lane 1 reads
address X at instruction 3. In the RTL, lane 1's read is at an earlier cycle
than lane 0's write, so lane 1 sees the **old** value. In a sequential model,
lane 0's segment runs first, so lane 1 sees the **new** value.

This is a real semantic difference and it is handled explicitly:

- **The model asserts the property it relies on**, rather than assuming it:
  lanes of a path are expected not to touch the same address. This is exactly
  what the `A ^ B ^ L` bank swizzle in `params_pkg.sv` is designed to achieve
  for the three access patterns it documents (shared vector/matrix row, matrix
  column, thread-private data). The golden model checks the property on the
  traces it produces; violations are reported.
- Where the property is violated (deliberately racy kernels such as
  `ping_pong` and `spmc`), the *interleaving* is what determines the answer,
  and the model is required to produce the same answer as the RTL for the
  *same* interleaving. See [§5.4](#54-interleaving-dependence).

---

## 5. ITS semantics

### 5.1 The instructions

Defined in `control_unit/control_unit.csv` (currently disabled) and used by
`asm-kernels/instructions.s` and `ss/src/simt.c`:

| Instruction | Encoding | Meaning |
|---|---|---|
| `binit $i($1)` | `custom-1`, funct3=001 | Initialise the barrier object at `rs1+imm`; this thread joins it. |
| `bsync $i($1)` | `custom-1`, funct3=010 | Synchronise on the barrier object at `rs1+imm`; block until the whole group has arrived. |
| `yield` | `custom-1`, funct3=100 | Give up the warp's execution slot so another path can run. |

`custom-1` is opcode `0x0B`, i.e. `0b0001011` — the RISC-V "custom-1"
opcode space, which is the correct place for these.

The CSRs used by the software (`ss/hdr/simt.h`):

| CSR | Address | Meaning |
|---|---|---|
| `xrole` | `0xCC2` | 0 = leader, non-zero = follower. `simt_thread_is_leader()` is `!xrole`. |
| `xwarpid` | `0xCC0` | The warp this thread belongs to. |
| `xthrid` | `0xCC1` | This thread's id within the warp. |
| `mhartid` | (standard) | Global thread id; `simt_global_id()` reads it. |

`0xCC0`–`0xCC2` are in the RISC-V **custom read/write** CSR range
(`0xC80`–`0xCFF`), so these addresses are legal.

### 5.2 The model implements the semantics, not the encoding

The model hooks the three instructions and the CSRs; the *encodings* come from
the CSV and are shared with the RTL.

- `binit` — the lane joins the barrier object named by `rs1+imm`. The barrier
  records the set of lanes that must participate.
- `bsync` — the lane blocks until every lane in the barrier's group has
  arrived. All lanes are then released.
- `yield` — the lane is preempted; the scheduler picks a different lane.

The tricky parts, and the decisions they need, are in
[§11](#11-open-questions). In short:

- **What is the group for a given barrier?** All lanes of the warp? Only the
  lanes of the current path? The `binit`/`bsync` addressing in
  `ss/kernels/*.c` suggests a per-warp barrier object
  (`barriers[simt_warp_id()]`), which suggests *warp-wide*.
- **Does `binit` also block?** Or only `bsync`? The names suggest `binit`
  registers and `bsync` waits, but the CSV shows `BSYNC_0` is a load and
  `BSYNC_1` a store, i.e. a two-phase handshake.
- **What are the memory-ordering guarantees?** Does `bsync` act as a release
  fence for the issuing lane, and an acquire for the whole group? Does
  `yield`? This is the question that determines whether `spmc.c` and
  `nearn.c` are correct at all.

### 5.3 Scheduling policy

The scheduler decides which lane runs next. Pluggable policies:

- **Round-robin over lanes** — the simplest fair policy.
- **Random with a seed** — for the interleaving-robustness test
  ([§5.4](#54-interleaving-dependence)).
- **Path-aware** — group lanes that share a PC and rotate between groups, the
  closest analogue to the RTL's behaviour. Useful for comparing against the
  RTL.

A policy is an interface, not a constant. That is what makes the
interleaving-robustness test possible.

### 5.4 Interleaving dependence

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

## 6. Renode integration

### 6.1 What Renode gives us

Renode (<https://github.com/renode/renode>) is a full-system emulator. We use
it as:

- a **RISC-V CPU** (its `RiscV32` core) — the L1 ISA layer,
- a **host** for our model (L2 + L3), as a plugin,
- a **testbench** — Renode's Robot Framework framework and its
  `renode-test` runner, and its execution tracer / metrics analyser.

### 6.2 Writing the model in C#, not Python

Renode's embedded scripting is **IronPython 2.7** (`src/Emulator/Main/Core/PythonEngine.cs` uses `IronPython.Hosting`). Its custom-instruction and custom-CSR handlers are Python scripts.

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

### 6.3 The pattern language

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

### 6.4 Generating the patterns from the CSV — one source of truth

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
- the Renode opcode-counter patterns for profiling ([§8](#8-kernel-profiling)).

**One specification, three consumers.** This is the main reason the golden
model lives in this repository rather than a separate one.

### 6.5 Which instructions to hook

| Hook | Why |
|---|---|
| `binit`, `bsync`, `yield` | The ITS semantics live here. These are the custom-1 opcodes; hook all three with one pattern each. |
| `xwarpid`, `xthrid`, `xrole` | Custom CSRs; `RegisterCSR` with our own read/write functions. |
| Branches (`beq`, `bne`, …) | **Only if** we need path grouping or divergence accounting. In a lane-based model, divergence is free — see [§4.2](#42-why-lane-based-rather-than-path-based). |

### 6.6 The PC, and the stepping model

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

### 6.7 Running the model

Two ways to get the C# into Renode:

| Route | How | When |
|---|---|---|
| **Ad-hoc** | `i @Dolunay.cs` in the Renode monitor. Renode's `AdHocCompiler` compiles the file at runtime with the bundled Roslyn (`Microsoft.CodeAnalysis.CSharp`), referencing the assemblies already loaded in the AppDomain. | Prototyping. **No .NET SDK needed.** |
| **Pre-built plugin** | A `.csproj` → `.dll` dropped into Renode's `plugins/` directory; `TypeManager` finds it by the `[Plugin]` attribute. | When we want unit tests, NuGet packages, multiple files. Needs the .NET SDK. |

Note the ad-hoc path compiles against *already-loaded* assemblies, so it can
see `BaseRiscV` — but this is **unverified** and is the single most important
assumption in the plan (see [§11.3](#113-open-decision-3-can-we-even-load-c)).

### 6.8 Target framework

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

## 7. Toolchain

### 7.1 What is needed

| Tool | Needed for | Status on the dev machine |
|---|---|---|
| Renode (Linux) | the model | to install — the portable tarball needs no .NET install |
| .NET **SDK** | building a pre-built plugin, unit tests | **not installed** — runtimes 8.0.22 / 9.0.11 / 10.0.1 are present, but `dotnet --info` reports *"No SDKs were found."* |
| RISC-V toolchain | building the kernels (`asm-kernels/generate.sh`, `ss/generate.sh` use `riscv64-linux-gnu-gcc`) | not on the Windows PATH |
| Verilator ≥ 5.036 | the existing `pytb/` cocotb flow | not on the Windows PATH |

The RISC-V toolchain and Verilator are needed by the *existing* RTL
verification flow, not by the golden model. This suggests putting everything
in **one Linux environment** (WSL2 Ubuntu or a Docker container) containing
Renode, the .NET SDK, the RISC-V toolchain and Verilator.

### 7.2 Where things will run

Renode is Linux-first; the project's `pytb/` flow already assumes a POSIX-ish
host (it notes that GNU Make misbehaves on paths with spaces, i.e. Windows).
Docker is already installed on the dev machine, and Renode publishes official
images (`antmicro/renode`, `antmicro/renode:nightly-dotnet`).

---

## 8. Kernel profiling

Goal G3: answer *"if adding extension X only helps one kernel a little, is it
worth the effort?"*

### 8.1 Renode's native opcode counters

`TranslationCPU_OpcodesCounting.cs` provides exactly this, at native speed:

```csharp
public void InstallOpcodeCounterPattern(string name, string pattern)  // 16 or 32 bits
public ulong GetOpcodeCounter(string name)
public string[,] GetAllOpcodesCounters()
```

The patterns use the same wildcard format as custom instructions, so they can
be generated from `control_unit/control_unit.csv` by the same `cugen` emitter
([§6.4](#64-generating-the-patterns-from-the-csv--one-source-of-truth)).

One counter per extension (or per instruction) gives a dynamic instruction
histogram with **no per-instruction Python or C# overhead**.

### 8.2 What we want out of it

Per kernel:

- **instruction histogram** — counts per instruction, and per extension.
- **share** — what fraction of executed instructions come from each extension.
  This is the number that answers "is extension X worth it?".
- **memory access trace** — addresses, sizes, load/store, per lane. Feeds the
  bank-conflict analysis (using `spad_bank_of` from `params_pkg.sv`) and the
  co-scheduling property check ([§4.3](#43-the-co-scheduling-caveat-important)).
- **control-flow statistics** — divergent vs. uniform branches, barrier waits,
  yields.

### 8.3 The `cugen` note

`control_unit/cugen` already has a clean model → emitter structure
(`csv_parser.py` → `model.py` → `sv_emitter.py`). Adding a `pattern_emitter.py`
and, if needed, a `py_emitter.py` is a natural extension. If the model needs
a Python decode table at all, it should be generated the same way.

---

## 9. Repository layout

### 9.1 Decision

**The golden model lives in this repository**, in a new top-level `golden/`
directory. The kernels stay where they are.

Rationale:

1. **The shared contract.** `control_unit/control_unit.csv` is the
   specification that both the RTL and the model implement. Splitting the
   repositories means either duplicating it (drift — exactly what we are
   trying to avoid) or adding a submodule.
2. **The differential test wants both sides at once.** "Model and RTL produce
   the same result for this kernel" is the central workflow (G2). One checkout,
   one CI run, one commit.
3. **The geometry already disagrees across files** (see
   [§11.1](#111-open-decision-1-the-geometry)). Splitting the repositories
   turns a within-repo inconsistency into a cross-repo version-skew problem,
   which is much harder to spot.
4. There is **no CI configured yet**, so there is no immediate pressure to
   separate build systems. SystemVerilog + Python + C# in one repository is
   fine; `Bender.yml` handles the SV dependencies, `pytb/` handles the Python,
   and `golden/` handles the C#.

### 9.2 Layout

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
    Dolunay.Golden.cs     the whole model + Renode glue, as one plugin
    Dolunay.Golden.repl   Renode platform description
    README.md             this document
```

### 9.3 Why the model is one file, not a library plus a plugin

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

### 9.4 If we later split

If a split is ever wanted, the sensible cut is **not** "model vs. everything
else" but:

| Repository | Contents | Why |
|---|---|---|
| `dolunay-isa` | the ISA specification: `control_unit.csv`, CSR assignments, memory map, ITS semantics, `cugen` | The contract. Versioned, referenced by both. |
| `dolunay` (this one) | the RTL, `pytb/`, `golden/` | The machine and both implementations. |

The kernels are *not* a good split candidate: they depend on the ISA
(`ss/hdr/simt.h` hard-codes the CSR numbers and the geometry), they are the
stimulus for both implementations, and `asm-kernels/generate.sh` writes
`../irom.mem`, which the RTL's `src/irom.sv` reads with `$readmemh`.

---

## 10. Milestones

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
- resolve the geometry conflict.

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
a day of work and it settles [§11.3](#113-open-decision-3-can-we-even-load-c).

### M2 — The lane model

- per-lane state (PC, registers, CSRs),
- lane switching with save/restore,
- the scheduler policy interface,
- run a *non-concurrent* kernel (`vecadd`, `saxpy`, `gemm`) and check the
  result against the C reference.

### M3 — The ITS semantics

- `binit`/`bsync`/`yield` handlers,
- the barrier rendezvous,
- `xwarpid`/`xthrid`/`xrole`,
- run `ping_pong`, `spmc`, `nearn`.

### M4 — The property test

Run each kernel under N scheduler seeds; assert the final memory is identical
every time. This is the interleaving-independence check
([§5.4](#54-interleaving-dependence)), and it is what makes the model a
*golden* model rather than just another implementation.

### M5 — Differential testing against the RTL

Run the same kernel on the model and on the RTL (via `pytb/`), compare
architectural state. Requires M0.

### M6 — Profiling

Install opcode counters from the CSV-derived patterns; produce the
instruction histogram and the memory access trace; report per-extension
share. This is goal G3 and it is independent of M1–M5.

### M7 — Co-scheduling and bank-conflict analysis

Use the memory access trace with `spad_bank_of` from `params_pkg.sv` to
report bank conflicts, and to check the co-scheduling property
([§4.3](#43-the-co-scheduling-caveat-important)).

---

## 11. Open questions

### 11.1 Open decision 1: the geometry

`src/params_pkg.sv` says `N_WARPS = 8`, `N_THREADS = 32`.
`ss/hdr/simt.h` says `WARP_COUNT 4`, `WARP_SIZE 8`.

These cannot both be right, and the whole model depends on which is
authoritative. Options:

- the RTL is right → the software's `#define`s are wrong;
- the software is right → the RTL's parameters are wrong;
- or they are deliberately different (e.g. the RTL is configured at build time
  and the software is compiled per configuration) — in which case the
  relationship must be made explicit and the golden model parameterised.

**Needs deciding before M1**, because it determines the number of lanes the
model has to carry.

### 11.2 Open decision 2: the ITS semantics

Three sub-questions, all of which the golden model has to answer, and which
the RTL does not currently implement:

1. **What is the barrier group?** All lanes of the warp, or only the lanes of
   the current path? The per-warp barrier objects in `ss/kernels/*.c` suggest
   warp-wide; the RTL's commented-out `barr_total_r`/`barr_parked_r` masks
   suggest something path-dependent.
2. **Memory ordering.** Does `bsync` act as a release fence for the arriving
   lane and an acquire for the group? Does `yield`? Without an answer,
   `spmc.c` and `nearn.c` cannot be judged correct or incorrect — and they
   are the interesting kernels.
3. **What does `xrole` mean exactly, and which lane is the leader?** Is the
   leader lane 0 of the warp? Does the leader have different behaviour?

### 11.3 Open decision 3: can we even load C#?

The ad-hoc route (`i @file.cs`) compiles against the assemblies already loaded
in the AppDomain. We *believe* `Infrastructure.dll` is among them (the CPU
class lives there), but this is **unverified**, and it is load-bearing for
the whole plan.

Fallback if it fails: build a plugin against an installed Renode's DLLs
(version-coupled, but workable).

Either way, the one-hour experiment in M1 settles it.

### 11.4 Open question: how does the model *end*?

There is no `wdone` in hardware yet and `core_top.ready_o` is undriven. The
model needs its own termination condition — presumably all lanes have
finished (e.g. all PCs are in a trap loop, or a `wdone` was executed by every
lane). This is M0's problem as much as the model's.

### 11.5 Open question: is the "one file" model going to get too big?

The model will contain: the lane and warp state, the scheduler policies, the
ITS semantics, the trace/profiling output, and the Renode glue. That is a lot
for one file. If it grows past a few thousand lines, the natural split is
*within* the plugin (several `.cs` files in one assembly) rather than across
assemblies — which is possible with the pre-built plugin route but **not**
with `i @file.cs`, which takes one file at a time.

---

## 12. Rejected alternatives

Recorded so they are not re-litigated.

| Alternative | Why rejected |
|---|---|
| **Write the ISA layer ourselves** (a Python or C# RISC-V interpreter) | The RV32 + F + A semantics — rounding modes, `fflags`, canonical NaNs, LR/SC — would dominate the effort and the bug count, and are pure commodity. Renode provides them. |
| **Fork Spike** | Spike is the reference implementation and would be a fine ISA layer, but it has no support for custom instructions in Python, no SIMT/lane concept, and none of the system-level apparatus (platform descriptions, peripherals, tracing) that we need. Spike remains the natural **differential oracle for the ISA layer** if we want a second opinion. |
| **Renode's embedded Python (IronPython 2.7)** for the hooks and model | Python 2; violates the repo's Python 3 conventions; hostile to agents. See [§6.2](#62-writing-the-model-in-c-not-python). |
| **QEMU user-mode + GDB stub** as the substrate | Cannot suspend a hart at an arbitrary point and resume it with a different PC; the multi-hart stepping model is awkward; no SIMT support; no custom-instruction story. |
| **A native/host-compiled "shim" for the kernels** (compile the C kernels natively with `simt_*` replaced by host implementations) | The kernels are *concurrent algorithms* — `ping_pong` and `spmc` deadlock when run single-threaded, and the whole point of ITS is lost. Also does not apply to `asm-kernels/`, which are hand-written assembly. |
| **A source-to-source transpiler** expanding SIMD into per-lane loops with masks | Cannot express a warp-wide rendezvous: a sequential lane loop deadlocks on the first `bsync`. It also does not cover `asm-kernels/` at all, which need an interpreter regardless. |
| **"Run until the lane hits a branch or custom instruction", then switch lanes** | Interception does not provide a cheap "run until X" primitive; the complexity is not worth it when the hot path is C#. See [§6.6](#66-the-pc-and-the-stepping-model). |
| **Path-based model** (lanes of a path in lockstep, as in the RTL) | Cannot catch a bug in the RTL's path machinery, because it reproduces it. See [§4.2](#42-why-lane-based-rather-than-path-based). |
| **Separate repository for the golden model** | Splits the shared ISA specification away from its two consumers. See [§9](#9-repository-layout). |

---

## 13. Source references

Renode (`renode/renode` + `renode/renode-infrastructure`):

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

Dolunay (this repository):

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
| Hardware performance counters (written, not instantiated) | `src/hpms.sv` |
| Cocotb testbenches | `pytb/` |
