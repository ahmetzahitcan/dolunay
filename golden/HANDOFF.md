# Handoff — golden model / Renode skeleton

Written 2026-11-06 by the previous agent session. This file is a starting point,
not an authority: [`AGENTS.md`](AGENTS.md), [`CONTRACT.md`](CONTRACT.md) and
[`DECISIONS.md`](DECISIONS.md) outrank it. Read those first.

## TL;DR

- `golden/` contains a **working Renode plugin skeleton with no machine
  behaviour**, by design. The ISA layer is Renode's RISC-V core; the model's
  CPU is now a `RiscV32` subclass (`CPU.Dolunay`) that installs custom
  instructions in its constructor.
- One mock instruction exists: executing `0x0000700B` logs `Hello World` to
  the monitor. Verified end to end. It is a placeholder, **not** an ISA decision.
- Nothing from this session is committed. See "Repository state".
- The toolchain is installed user-locally; SDK 8 is pinned for `golden/`, and
  Zed's C# language server is configured to find the .NET 10 runtime.

## Repository state

Last commit: `efe6642 set up renode skeleton` on branch `develop`.

Uncommitted at handoff:

```
 M golden/.gitignore                    # ignores build/, *.log, *.lock, bin/, obj/, /run-renode.sh
 M golden/README.md                     # "Running the skeleton" + SUBSTRATE.md link
 M golden/model/Dolunay.cs              # now only the [Plugin] marker
 M golden/model/Dolunay.Golden.csproj    # adds the ELFSharp reference
?? golden/model/DolunayCpu.cs           # NEW: CPU.Dolunay : RiscV32 + mock instruction
```

Tracked and relevant: `golden/Dolunay.repl`, `golden/renode.config`,
`golden/run.resc`, `golden/global.json`, `golden/SUBSTRATE.md`,
`ENVIRONMENT.md` at the repository root.

Build outputs live in `golden/build/` (gitignored), including a provisional
standard-only demo in `golden/build/std-only/`.

## What exists

| Path | Purpose |
|---|---|
| `golden/model/Dolunay.Golden.csproj` | `net8.0` Renode plugin. Requires `RENODE_BIN`; references `Infrastructure.dll` and `ELFSharp.dll`; output goes to `build/plugin/` |
| `golden/model/Dolunay.cs` | `[Plugin]` marker class; logs on construction, does nothing else. Only instantiated when enabled |
| `golden/model/DolunayCpu.cs` | `CPU.Dolunay : RiscV32`; installs the mock instruction in its constructor |
| `golden/global.json` | pins SDK 8.0.427 (Renode is `net8.0`); `dotnet` elsewhere defaults to SDK 10 |
| `golden/Dolunay.repl` | early skeleton platform: one `CPU.RiscV32`, no memory (superseded by the CPU subclass for experiments) |
| `golden/run.resc` | headless smoke script: create machine, load `.repl`, print PC, quit |
| `golden/renode.config` | enables the plugin for one run; **comments must use `;`** |
| `golden/run-renode.sh` | **gitignored**, machine-local launcher: build → copy DLL → run (interactive by default, `--headless` for the smoke test) |
| `golden/SUBSTRATE.md` | observed Renode host behaviour (one sentence there about discovery vs. enablement is too broad; see “Suggested next steps”) |
| `golden/build/std-only/` | gitignored experiments: `std.repl`, `prog.s` (sum 1..10), `hello.s`, `dolunay.repl`, scripts |
| `ENVIRONMENT.md` (root) | portable toolchain/setup notes; machine-local facts deliberately kept out where possible |

## Build and run

```sh
cd golden
RENODE_BIN=<unpacked renode tree> dotnet build model -c Release --nologo -nowarn:MSB3277
cp build/plugin/Dolunay.Golden.dll "$RENODE_BIN/"

# Renode rewrites the config file it is given -- keep the tracked one clean.
cp renode.config build/renode.run.config
renode --config "$PWD/build/renode.run.config" --disable-xwt --console --plain run.resc
```

Or use the machine-local launcher: `./run-renode.sh` (interactive) or
`./run-renode.sh --headless`. **Note:** the launcher currently passes the
tracked `renode.config` directly, so it gets rewritten in place (see
"Repository findings"); copy it to `build/` first when fixing that.

Notes:

- Renode finds plugin assemblies **in its own installation directory**, at
  start-up only. Copying the DLL there is mandatory; remove it to test the
  "no plugin" case.
- The `.resc`/`.repl`/`.config`/monitor syntax quirks are listed under
  "Gotchas" below.

## Verified results

**Mock instruction** (`CPU.Dolunay`, `hello.resc`, program = `.word 0x0000700B`
then `j .`):

```
[INFO] std: Machine started.
[INFO] cpu: Hello World
0x0000000080000004      # PC advanced by 4 automatically, no manual PC handling
```

No install command: the instruction is installed by the CPU constructor.
The `cpu:` prefix comes from the element-scoped `this.Log`.

**Standard-only demo** (stock `CPU.RiscV32`, `prog.s` sums 1..10): after 40
steps, `PC = 0x80000020`, `x5 = 0x37`, `[0x80000000] = 0x37`.

**Stepping throughput** (paused/`Step` path, spin loop): 10 000 instructions in
4.42 s, 100 000 in 42.37 s — linear, **≈2.4 k instructions/s**. This is the path
a per-instruction lane-switch model would use; it is relevant to D5's
unverified assumption and argues for revisiting "run until a sync point".

## Renode substrate facts

Verified on Renode 1.17 unless marked *inferred*:

- Scan root is the **installation directory**, non-recursive, at start-up
  (`TypeManager`'s static constructor). The working directory is not scanned in
  this installation.
- Only types under `Antmicro.Renode.*` are registered for short-name resolution:
  `Antmicro.Renode.Peripherals.CPU.Dolunay` → `CPU.Dolunay` in a `.repl`.
- **Types and extension methods are registered on scan; `[Plugin]` classes are
  instantiated only when `[plugins] enabled-plugins` names them.** This is why
  `CPU.Dolunay` works with no config while `GoldenPlugin`'s log line is absent.
  (*Inferred from IL:* extension methods, i.e. monitor commands, also work
  without enabling; not separately tested.)
- `enabled-plugins` accepts both `Name` and `Name:Version:Vendor`.
- Renode **rewrites the config file it is given** with `--config`: defaults are
  merged in and values normalized (`enabled-plugins` became
  `Dolunay Golden Model:0.0.0:Dolunay`), and machine-local values such as
  `history-path` are written. Never point `--config` at a tracked file; copy it
  to a gitignored path first. A *relative* `--config` path is resolved/created in
  the installation directory (observed as `$RENODE_BIN/renode.config`), and such
  a file is auto-loaded on later runs.
- In a `--config` file comments must start with `;`. Renode 1.17 **hangs** on `#`
  comment lines (no output, never reaches the banner).
- `.repl` comments are `//`; `.resc` comments are `#`.
- `InstallCustomInstruction` patterns are 16/32/64 characters over `instr[31:2]`
  plus the low bits; `0`/`1` are fixed, anything else is a wildcard. A 32-bit
  pattern needs bits `[1:0] = 11` and bits `[4:2] != 111`.
- The CPU constructor's `Endianess` is `ELFSharp.ELF.Endianess`; `IRiscVTimeProvider`
  is in `Antmicro.Renode.Peripherals.Timers`; `PrivilegedArchitecture` /
  `InterruptMode` / `PrivilegeLevels` are nested in `BaseRiscV`.
- A `net10.0` assembly **loads and runs** on Renode's .NET 8 host (framework
  assembly unification). It fails only at the first API missing from 8.0, so the
  target framework must stay `net8.0` (D8). See `SUBSTRATE.md`.
- Monitor: `<object>` alone dumps methods/properties; string arguments must be
  quoted (`cpu GetRegisterUlong "x5"`); `LoadBinary @file addr`, `ReadDoubleWord`,
  `cpu PC <value>`, `cpu Step N` work as used in the experiments.
- `cpu Step` on a CPU that has aborted (e.g. PC outside mapped memory) leaves
  the monitor blocking; ensure the PC matches where the image was loaded.

## Decisions in force

`DECISIONS.md` D1–D8. The ones that shape current work:

- **D2** model the next variant; the RTL in `../src` is evidence, not a spec.
- **D3** lane-based execution, warp-structured (provisional).
- **D5** C# on Renode's RISC-V core. Its "ad-hoc first, no SDK" clause is
  **superseded by D8**.
- **D8** the model ships as a pre-built `net8.0` plugin loaded from Renode's
  installation directory; `RENODE_BIN` supplies that tree at build time and is
  machine-local.

## Open questions (from `CONTRACT.md` §2 — do not answer silently)

Geometry; whether path structure is architecturally visible; barrier context
and release rule; memory ordering of `yield`/barrier; DMA interface; termination
condition; whether the model owns memory. Every one must become a named knob
with a declared default plus a test.

## Repository findings (report, do not fix from `golden/`)

- `DESIGN.md` is stale in its tree descriptions. Its header flags most of it;
  **not** flagged, and still misleading: §4.3 and §11 (memory ownership via
  leader selection — retired by the redesign), §9's M0 to-do list (mostly done),
  §10.2 ("can we even load C#?" — answered yes, both routes), §5.7/§5.8
  (ad-hoc first — superseded by D8), §7's `cugen` emitter file names.
  Current tree: ITS decoded, barrier + path bookkeeping present, LR/SC
  reservations in `pipeline.sv`, `hpms` instantiated, `ready_o` driven, `tb/`
  exists, geometry 8×8, 83 enabled CSV rows with only section headers commented.
- `irom.mem` / `irom.coe` are **tracked** but overwritten in the repo root by
  `ss/generate.sh` and `asm-kernels/generate.sh`; a kernel build dirties the tree.
  `irom.mem` is a hex text file: 1951 words ≈ **7.6 KiB** of image.
- `tb/tb_thread_scheduler.sv` uses `N_THREADS = 32`, while `params_pkg.sv` says 8.
- `ss/hdr/simt.h` is 4 warps × 8 lanes (stale software), RTL is 8 × 8.
- `golden/renode.config` as committed already contains the **rewritten** form:
  merged defaults plus `history-path = /home/azc/.config/renode/history`. That is
  a machine-local path recorded in the repository, contrary to
  `CONTRACT.md` §5. Regenerate a minimal version (comments + `[plugins]` only)
  and make the launcher pass a copy under `build/`.

## Environment (machine-local — verify, do not treat as contract)

- Fedora 44. `dotnet` at `~/.local/opt/dotnet` (SDKs 8.0.427 and 10.0.403;
  runtimes 8.0.x and 10.0.x), symlinked into `~/.local/bin` (on `PATH`).
- Renode 1.17.0 portable at `~/.local/opt/renode_1.17.0-portable`, symlinked from
  `~/.local/bin/renode`; it bundles .NET 8.0.12.
- `riscv32-unknown-elf-gcc` / `-objcopy` are shims in `~/.local/bin` forwarding
  to `riscv64-linux-gnu-*`. Verilator 5.046 and bender 0.32.1 present.
- Zed C#: `lsp.roslyn.binary.env` sets `DOTNET_ROOT` and `RENODE_BIN`, because
  the bundled Roslyn is a `net10.0` apphost. Backup at
  `~/.config/zed/settings.json.bak`.
- Renode's user directory `~/.config/renode` must be writable (it locks
  `config.lock`). A stray interactive Renode holds that lock and makes later
  runs hang — check `pgrep -af renode` and kill it.
- Agent commands in this session ran **unsandboxed** (the user allowed it after
  a deleted write-grant path). Filesystem writes outside the repo were limited
  to installing tools under `~/.local` and the Zed settings.

## Gotchas

- Do not pass a relative `--config` path (see above), and do not pass a tracked
  one either — Renode rewrites it. Use a copy under `build/`.
- The DLL must be present in the Renode install dir **before** start-up; the
  scan does not recurse, so `plugins/<name>/` is not enough.
- `.git` is read-only in the agent sandbox: `git checkout -- <file>` fails with
  `index.lock`; edit files directly instead.
- Builds of `golden/` must run with `golden/` (or below) as the working
  directory so `global.json` pins SDK 8.
- `dotnet build` prints ~60 lines of `MSB3277` (Renode references newer
  `System.*` than the `net8.0` pack); `-nowarn:MSB3277` silences exactly that.

## Suggested next steps

1. Write the ISA documents (custom instructions, custom CSRs, exemptions). ISA
   truth is the RISC-V standard plus those documents; `control_unit.csv` is RTL
   autogen input and a cheatsheet. Record this as a decision.
2. Replace the mock `0x0000700B` encoding with the documented encodings; add
   custom CSRs via `RegisterCSR` in the same `Dolunay` constructor.
3. Point `golden/Dolunay.repl` (and the smoke scripts) at `CPU.Dolunay`.
4. Decide memory ownership (`CONTRACT.md` §2) before any load/store
   interception; memory as a device is the composition-friendly option.
5. Run the M1 substrate probe (lane save/restore + `Step(1)`) with the measured
   2.4 k instr/s baseline in mind; consider "run until a sync point".
6. Fix the `SUBSTRATE.md` sentence about discovery/enablement to distinguish
   type registration from `[Plugin]` instantiation.
7. Ask the maintainer before committing anything.
