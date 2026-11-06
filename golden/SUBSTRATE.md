# Renode substrate notes

**Status: informative.** Observed behaviour of the **host** (Renode 1.17.0),
not of the machine. Nothing here overrides [`CONTRACT.md`](CONTRACT.md) or
[`DECISIONS.md`](DECISIONS.md). Everything was verified by running it unless
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
  constructed when `[plugins] enabled-plugins` names it. Without that, the
  `Dolunay.Golden plugin loaded` log line is absent even though the CPU type
  works. `enabled-plugins` accepts both `Name` and `Name:Version:Vendor`.
- *Inferred from IL, not tested:* extension methods (monitor commands) are also
  registered by the scan and work without enabling the plugin.

To test the "no plugin" case, remove the DLL from the installation directory.

## The `--config` file

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

## Extending `RiscV32`

- Derive from `RiscV32` and call `InstallCustomInstruction` in the constructor;
  a `.repl` naming the subclass gets the instructions with no install command.
  The handler does not need to touch the PC: it advances by the instruction
  length automatically. The element-scoped `this.Log` prefixes the CPU's name
  (`cpu: Hello World`).
- Patterns are 16, 32 or 64 characters covering the whole instruction, MSB
  first; `0`/`1` are significant, any other character is a wildcard. A 32-bit
  pattern needs bits `[1:0] = 11` and bits `[4:2] != 111`.
- Constructor parameter types: `Endianess` is `ELFSharp.ELF.Endianess` (the
  project references `ELFSharp.dll`); `IRiscVTimeProvider` is in
  `Antmicro.Renode.Peripherals.Timers`; `PrivilegedArchitecture`,
  `InterruptMode` and `PrivilegeLevels` are nested in `BaseRiscV`.

## Execution control (probed 2026-11-06)

Throwaway probes; numbers are from one machine and are order-of-magnitude only.

- **At most 32 cores per machine.** The 33rd fails with `atomic: Maximum number
  of supported cores exceeded: 32` (a constant in Renode's native translation
  library). The limit is per machine, not per process: 64 machines × 1 CPU
  load and run (≈540 MB, ≈750 MIPS aggregate, same as 8 × 8).
- **Standard opcodes can be overridden.** `InstallCustomInstruction` with a
  pattern matching a standard instruction (e.g. all of `BRANCH`, or `LW`) takes
  precedence over the built-in decoder. The handler then *is* the instruction:
  - if it does not write `PC`, `PC` advances by 4 afterwards (a branch handler
    must write the target itself);
  - writing `PC` is honoured, including writing the instruction's own address;
  - **halt-before works:** set `IsHalted = true` and `PC` = the instruction's
    own address; the CPU stops before it, and re-executes it once on resume;
  - a load handler can perform the access with `sysbus.ReadDoubleWord(addr, cpu, null)`;
  - an aborted attempt still counts in `ExecutedInstructions` — count
    instructions in the model, not with Renode's counter.
- **Opcode hooks** (`AddPreOpcodeExecutionHook`) run before the instruction but
  cannot stop it: setting `IsHalted` there lets the instruction complete, and on
  a not-taken branch the CPU can run on past it (translation-block chaining) —
  observed executing one more instruction. `RequestTranslationBlockRestart`
  returns `false` from a hook.
- **Address hooks** (`AddHook(addr, …)`, the breakpoint mechanism) stop exactly
  before the instruction, also mid-block; on resume the hook does not fire again
  for that instruction. They need the addresses in advance.
- A restart requested from inside a peripheral access
  (`TryRestartTranslationBlockOnCurrentCpu`) reports success but does not
  re-execute the load.
- **Blocking a CPU thread inside a handler stops every CPU** of the emulation,
  in parallel and in serial (`SetGlobalSerialExecution`) mode alike. Lanes must
  wait by halting, never by blocking.
- **Halting and releasing is slow:** a rendezvous of 8 lanes (each halts, the
  last releases all) costs ≈0.85 ms of wall time, independent of
  `SetGlobalQuantum` (default, 10 µs, 1 µs) and `SetGlobalAdvanceImmediately`.
  See [`PERFORMANCE.md`](PERFORMANCE.md).
- `sysbus.TryGetCurrentCPU` inside a peripheral access identifies the CPU that
  made it.
- LR/SC and AMOs behave correctly within one machine, on RAM and on a peripheral
  (with a `Atomically accessing MMIO` warning on the latter), including a
  reservation broken by another CPU's store. Across machines: untested.

## Stepping throughput

On 2026-11-06, single-stepping a spin loop through the paused `Step` path took
4.42 s for 10 000 instructions and 42.37 s for 100 000 — linear, **≈2.4 k
instructions/s**. That is the path a per-instruction lane-switch model would
use, so it bears directly on D5's unverified "is `Step(1)` fast enough"
assumption and argues for running each lane until a sync point instead.

A stock `CPU.RiscV32` running a sum-of-1..10 loop gave the expected result
(`x5 = 0x37`, stored to memory) after 40 steps — standard execution needs
nothing from the model.

## Building the plugin

- Run `dotnet` from `golden/` or below; `global.json` pins SDK 8.0.x, while
  `dotnet` otherwise picks the newest installed SDK. A future tool that needs a
  newer SDK gets its own nested `global.json`.
- `dotnet build` emits ~60 `MSB3277` warnings: Renode's assemblies reference
  newer `System.*` versions than the `net8.0` reference pack. They are benign;
  `-nowarn:MSB3277` silences exactly those.

## The plugin targets Renode's own framework (`net8.0`)

Renode 1.17 ships .NET 8: its `Renode.runtimeconfig.json` declares `net8.0` and
the portable package bundles runtime 8.0.12. A plugin shares the host's
assemblies, so it is built against the same API surface (D8).

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

1. copy `model/Dolunay.cs` into a throwaway directory;
2. give that directory its own `global.json` pinning a newer SDK, because
   `golden/global.json` deliberately pins 8.0.x;
3. set `RENODE_BIN` and build it with `TargetFramework` changed;
4. copy the produced DLL into Renode's installation directory, name it in
   `[plugins] enabled-plugins`, run, then remove it again.

### If a later framework is ever needed

- Upgrade Renode first. The plugin's target framework follows the Renode
  runtime, not the other way round.
- A library that does not support `net8.0` is a **finding to report**, not a
  reason to raise the target silently. `AGENTS.md` §3 applies, and any change
  needs a decision.
- Do not treat "it loads anyway" as evidence of compatibility: it only shows
  that the APIs used so far exist in both frameworks.
