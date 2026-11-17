# Renode substrate notes

**Status: informative.** Observed behaviour of the **host** (Renode 1.17.0),
not of the machine. Nothing here overrides [`CONTRACT.md`](CONTRACT.md). Everything was verified by running it unless
marked *inferred*. Re-verify after a Renode upgrade.

Machine setup (which tools, toolchain shims) lives in `../ENVIRONMENT.md`; editor
setup is in [`README.md`](README.md#editor-setup).

## Plugin discovery vs. plugin enablement

Two different things happen, and confusing them costs time:

- **Type registration — automatic.** At start-up (`TypeManager`'s static
  constructor) Renode scans its **installation directory**, non-recursively,
  and registers the types it finds. The working directory is not scanned, and
  `plugins/<name>/` subdirectories are not either. Only types under an
  `Antmicro.Renode.*` namespace get short names: `Antmicro.Renode.Peripherals.CPU.Dolunay`
  becomes `CPU.Dolunay` in a `.repl`. So `CPU.Dolunay` works **with no config at
  all**, as long as the DLL is in the installation directory before start-up.
- **`[Plugin]` instantiation — opt-in.** A class marked `[Plugin]` is only
  constructed when `[plugins] enabled-plugins` names it; the types work without
  it. `enabled-plugins` accepts both `Name` and `Name:Version:Vendor`. The
  model has no `[Plugin]` class, so it needs no config file.
- **Dependencies resolve from the same directory.** A plugin DLL that references
  a second assembly of ours works when both are in the installation directory
  (probed 2026-11-06 with a throwaway CPU type calling into a second assembly).
- *Inferred from IL, not tested:* extension methods (monitor commands) are also
  registered by the scan and work without enabling the plugin.

To test the "no plugin" case, remove the DLL from the installation directory.

## The `--config` file

The model does not use one. These facts matter if a `[Plugin]` class or
another setting ever needs it.

- Renode **rewrites the file given to `--config`**: it merges in its defaults,
  normalises values (`Dolunay Golden Model` became
  `Dolunay Golden Model:0.0.0:Dolunay`), and writes machine-local values such as
  `history-path`. Never point it at a tracked file; copy to `build/` first.
- A **relative** `--config` path is resolved in the installation directory
  (observed as `$RENODE_BIN/renode.config`), and a file there is auto-loaded on
  later runs. Always pass an absolute path.
- Comments must start with `;`. Renode 1.17 **hangs** on a `#` comment line: no
  output, never reaches the banner.
- Renode's user directory must be writable, and its location is not
  configurable: `$HOME/.config/renode` on Linux, `%APPDATA%\renode` on Windows.
  Renode creates and locks `config.lock` there before anything else, so a
  read-only home fails with `config.lock not locked` or `Read-only file system`.
  A stray interactive Renode holding the lock makes later runs hang silently.

## The simulation working directory

It is simply the process's current directory: relative `@file` paths and
generated logs resolve against it. A gitignored directory in the checkout is
fine, as long as its path has no spaces and is not on a sync service such as
OneDrive.

## Script and monitor syntax

- `.repl` comments are `//`; `.resc` comments are `#`.
- String arguments must be quoted: `cpu GetRegisterUlong "x5"`.
- `<object>` alone lists its methods and properties.
- Used successfully: `LoadBinary @file addr`, `sysbus ReadDoubleWord addr`,
  `cpu PC <value>`, `cpu Step N`.
- `cpu Step` on a CPU that has aborted (e.g. PC outside mapped memory) leaves the
  monitor blocked. Make sure the PC is where the image was loaded.

## Renode execution facts (probed 2026-11-06)

Throwaway probes; numbers are from one machine and are order-of-magnitude only.
The probes of the previous design (one `RiscV32` per thread, opcode overrides, halting and releasing, stepping
throughput) are in git history; that design is superseded.

- **At most 32 translated cores per machine.** The 33rd `RiscV32` fails with
  `atomic: Maximum number of supported cores exceeded: 32`, a constant in
  Renode's native translation library. The limit is per machine, not per
  process: 64 machines × 1 CPU load and run. Whether it applies to a CPU that
  is not translated (`BaseCPU`, below) is untested.
- **Blocking a CPU thread inside a handler stops every CPU** of the emulation,
  in parallel and in serial (`SetGlobalSerialExecution`) mode alike. Never wait
  by blocking.
- `sysbus.TryGetCurrentCPU` inside a peripheral access identifies the CPU that
  made it.
- A stock `CPU.RiscV32` running a sum-of-1..10 loop gave the expected result
  (`x5 = 0x37`, stored to memory) after 40 steps.

## A CPU of our own: `BaseCPU` (probed 2026-11-14)

A throwaway `BaseCPU` subclass, built outside the repository against Renode
1.17.0 and removed from the Renode tree afterwards; its source was not kept.
It executed no real instructions and had no shared state, so these facts are
about Renode's scheduling, not about a model. Numbers are from one machine and
are orders of magnitude.

- **It loads.** Implementing only the four abstract members
  (`ExecuteInstructions`, `ExecutedInstructions`, `PC`, `Architecture`) was
  enough for a `.repl` to instantiate it. `sysbus LoadELF` set the PC of every
  CPU on the bus, `cpu Step N` made N calls of `ExecuteInstructions(1)`, and
  `PC`, `ExecutedInstructions` and registers by number (through
  `ICPUWithRegisters`) read back. Registers by *name*
  (`GetRegisterUlong "x5"`) failed without a name mapping, which was not
  investigated.
- **Calls under `RunFor`.** Renode asked for `ExecuteInstructions(10000)` per
  call, on one host thread per CPU. A trivial body ran tens of thousands of
  calls per second.
- **The order of calls:**

  | Setting | What happened |
  |---|---|
  | Parallel (the default), two CPUs | The order of calls differed on every run: three runs, three different hashes. |
  | Serial (`emulation SetGlobalSerialExecution True`) | Identical in three runs, also with partial returns (219 distinct counts over 20 000 calls) and zero-instruction returns. |
  | Serial, a policy picks the warp on turn, the others **return zero** instructions | No result in five runs; each reached the 60 s cap. Not diagnosed; probably virtual time does not advance. |
  | Serial, the others **report their whole quantum as done** and execute nothing | The policy's order was followed in 2000 of 2000 steps, for 2 and 8 CPUs and two seeds, with identical wasted-call counts on repeated runs (1024 and 6934); about 40 to 90 ms per 2000 steps. |
  | Parallel, policy-gated, under a lock | The order was followed, but this is serial execution by another name, and the order of calls still differed between runs. |

  So Renode's scheduler is not controlled, only gated: by doing nothing when
  it is not its turn, a CPU lets a shared policy decide whose work happens.
  This does not extend to what Renode schedules itself (timers, peripherals,
  its time source), and what reporting instructions that did not execute does
  to Renode's own accounting of time is untested.
- **Early returns are accepted.** Returning fewer instructions than asked hung
  nothing outside the gated case above.
- **Bus cost.** Reading an instruction word through `Bus.ReadDoubleWord` cost
  about 0.5 µs (10 million reads in 5.7 s).
- **Reset.** 200 `machine Reset` commands on a two-CPU machine took 23 ms, with
  a harmless warning.
- **The stock oracle fits.** A `RiscV32` shared a machine with the probe CPU and
  took the same ELF. It accepted the `cpuType` strings `rv32i`, `rv32ia` and
  `rv32if`, with `zicsr`, `zicond` and `zba`, and rejected `zalrsc`, `zicntr`
  and `zihpm` with `Undefined instructions set extension`. Whether its F
  implementation matches Dolunay's static-rounding F (`CONTRACT.md` §2) with `frm` left at zero was not tested.
- **Not tested here, answered by the second probe below:** real shared state,
  more than 32 such CPUs, registers by name, and a native library.

## `BaseCPU`, second probe (2026-11-16)

The same kind of throwaway CPU, built in a scratch directory outside the
repository against Renode 1.17.0; its DLL and a one-function C library were
copied into the Renode tree for the runs only and removed afterwards. Each step
did some arithmetic and then a read-modify-write of a counter shared by every
CPU, appending (CPU, value read) to a hash; "gated" means a shared SplitMix64
policy chose the CPU on turn, and the others reported their whole quantum as
done without executing. Three runs per row unless noted; one machine.

| Configuration | Trace hash over the runs |
|---|---|
| 2 CPUs, parallel, ungated | three different hashes |
| 2 CPUs, serial, ungated | identical |
| 2 CPUs, serial, gated, seed 1 / seed 2 | identical per seed, different between seeds |
| 2 CPUs, **parallel**, gated | identical, and equal to the serial gated hash |
| 8, 33, 64, 128 CPUs, serial, gated (64 and 128: two runs) | identical per size |
| 128 CPUs, parallel, gated | equal to the serial hash |

- **Shared state is reproducible in serial mode**, and under gating also in
  parallel mode: when the policy decides who steps, under one lock, the order of
  Renode's calls no longer matters to the result.
- **More than 32 CPUs work.** 33, 64 and 128 `BaseCPU`s loaded and ran in one
  machine with no error; the 32-core limit belongs to translated cores.
- **Gating costs one call per CPU per quantum.** With the default quantum of
  100 µs, Renode called every CPU 10 000 times per virtual second, and only the
  CPU on turn stepped, so a gated machine makes at most about one step per
  quantum. 128 CPUs took about 10 s of wall time per virtual second in serial
  mode and 4 s in parallel; 2 CPUs about 1 s.
- **Virtual time follows host time.** With the defaults (advance immediately
  off), 10 s of virtual time took about 10 s of wall time (cumulative load 1.0),
  so a Renode-hosted run is paced by the host clock unless that is changed.
  Over 50 000 gated steps on 8 CPUs, Renode's time accounting stayed consistent
  and logged no warning.
- **Reported counts set the call rate.** Virtual time advances by the
  instructions a CPU reports, so a CPU that reports 1 to 10 instructions per
  call is called far more often: 2 ungated CPUs took 23 to 36 s of wall time for
  1 s of virtual time, against about 1 s when they reported the whole quantum.
- **Registers by name work through aliases.** `GetRegisters()` returning
  `CPURegister`s with aliases `x0`…`x31` and `pc` was enough for
  `GetRegisterUlong "x5"`, `SetRegisterUlong "x7" 0x1234` and
  `GetRegisterUlong "pc"` from the monitor. Renode does not mask a value to the
  register's declared width; the CPU must.
- **A native library next to the DLL loads.** A `[DllImport("probenative")]`
  call from the CPU's constructor resolved `libprobenative.so` placed in the
  Renode installation directory, with no further setup.

## Building the plugin

- Run `dotnet` from `golden/` or below; `global.json` pins SDK 8.0.x, while
  `dotnet` otherwise picks the newest installed SDK. A future tool that needs a
  newer SDK gets its own nested `global.json`.
- `dotnet build` emits ~60 `MSB3277` warnings: Renode's assemblies reference
  newer `System.*` versions than the `net8.0` reference pack. They are benign;
  `Dolunay.csproj` silences exactly those.
- **Name clash:** `CPU.Dolunay` is the class
  `Antmicro.Renode.Peripherals.CPU.Dolunay`. Inside that namespace, `Dolunay`
  means the class, so a namespace `Dolunay.X` cannot be written as `Dolunay.X`
  there; put `using Dolunay.X;` at the top of the file, or write
  `global::Dolunay.X`.

## The plugin targets Renode's own framework (`net8.0`)

Renode 1.17 ships .NET 8: its `Renode.runtimeconfig.json` declares `net8.0` and
the portable package bundles runtime 8.0.12. A plugin shares the host's
assemblies, so it is built against the same API surface.

### Tested: a newer target framework is not rejected at load time

On 2026-11-05 the model source was built as a throwaway `net10.0` assembly
against Renode's `net8.0` `Infrastructure.dll`, then loaded into Renode 1.17:

- **build**: succeeded; the assembly reports `.NETCoreApp,Version=v10.0`.
- **load**: succeeded; the plugin's constructor ran.
- **executing runtime**, as reported by `RuntimeInformation.FrameworkDescription`
  from inside the plugin: `.NET 8.0.12`.

The experimental copy logged a distinct message, so this was demonstrably the
`net10.0` build and not a leftover `net8.0` one.

**Why:** .NET unifies framework assemblies. A reference to
`System.Runtime, Version=10.0.0.0` binds to whatever framework is running, so
for a *library* the target framework in metadata is not a load gate (it is for
an application host).

**Why this is still a trap:** the mismatch is deferred, not prevented. The first
call to an API that does not exist in 8.0 raises `MissingMethodException` or
`TypeLoadException` at execution time — possibly long after start-up and only on
one code path. Compiling against 10 also silences the compiler, because the
newer reference assemblies advertise those APIs. A wrong target framework
therefore converts a start-up failure into a latent one, which is worse.

### Reproducing the experiment

Do it in `build/` (gitignored), never on the real project:

1. put a minimal type that logs a distinct message (a `RiscV32` subclass will
   do) into a throwaway project;
2. give that directory its own `global.json` pinning a newer SDK, because
   `golden/global.json` deliberately pins 8.0.x;
3. set `RENODE_BIN` and build it with `TargetFramework` changed;
4. copy the produced DLL into Renode's installation directory, instantiate the
   type from a `.repl`, run, then remove the DLL again.

### If a later framework is ever needed

- Upgrade Renode first. The plugin's target framework follows the Renode
  runtime, not the other way round.
- A library that does not support `net8.0` is a **finding to report**, not a
  reason to raise the target silently. `AGENTS.md` §3 applies, and any change
  needs the maintainer's approval.
- Do not treat "it loads anyway" as evidence of compatibility: it only shows
  that the APIs used so far exist in both frameworks.
