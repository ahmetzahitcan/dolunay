# Environment setup

A portable recipe for reproducing the toolchain and the build conventions on a
new machine (Fedora, Ubuntu/Debian, Windows). It records the *procedure*, not a
transcript: machine-local paths, versions and "it works here" notes belong
outside the checkout, per `golden/CONTRACT.md` §5.

## What the work needs

| Need | For | Check |
|---|---|---|
| Python 3 | generators, small helpers | `python3 --version` |
| .NET SDK | a pre-built Renode plugin, unit tests | `dotnet --version`, `dotnet --list-sdks` |
| Renode | the ISA layer and the model's host | `renode --version` |
| RISC-V bare-metal GCC | building kernels | `riscv32-unknown-elf-gcc -dumpfullversion` |
| Icarus Verilog **or** Verilator | the RTL side of the differential test | `iverilog -V` / `verilator --version` |
| bender | RTL dependency fetch | `bender --version` |
| make, hexdump | the build scripts' last steps | `make --version`, `hexdump --version` |

Anything not present should be reported as absent, not substituted silently.

## The RISC-V compiler names are shims

Both `ss/generate.sh` and `asm-kernels/generate.sh` call
`riscv32-unknown-elf-gcc` and `riscv32-unknown-elf-objcopy`, because that name
describes the target: 32-bit, bare metal. Distributions do not use it:

| Distribution | Real name |
|---|---|
| Fedora | `riscv64-linux-gnu-gcc` / `-objcopy` (multilib provides rv32imafc/ilp32) |
| Debian/Ubuntu | `riscv64-unknown-elf-*` or `riscv64-linux-gnu-*` |
| xPack | `riscv-none-elf-*` |

Each machine provides the two names as thin shims on `PATH`:

```sh
#!/bin/sh
exec <real-toolchain>-gcc "$@"
```

```sh
#!/bin/sh
exec <real-toolchain>-objcopy "$@"
```

Do not inject flags in the shim: the build passes `-march`/`-mabi` itself, and
silently adding flags makes the produced image differ from what the scripts say
they produce. On Windows the GCC shim must also put the toolchain's `bin` on
`PATH`, because with `-flto` the linker loads its LTO plugin from `libexec` and
resolves that plugin's runtime DLLs through `PATH`; Windows additionally needs a
`hexdump` stand-in for the scripts' last step.

**One kernel builder per machine.** The observation embeds the program image's
sha256, so two RISC-V toolchains would produce two "same" programs. Do not add a
second one without recording why in `golden/DECISIONS.md`.

The `-march` strings use `zicond` and `zalrsc`; a GCC older than 14 rejects them,
so check the compiler before concluding a shim is wrong.

## Renode

- The portable package is self-contained (it bundles the .NET runtime), so
  *running* Renode needs no SDK. The SDK is only for building the plugin and for
  unit tests; an ad-hoc `i @file.cs` still works for quick experiments.
- **Plugins** are discovered by scanning Renode's own installation directory,
  non-recursively, and only types under an `Antmicro.Renode.*` namespace are
  considered. A discovered plugin is still loaded only when
  `[plugins] enabled-plugins` names it; `--config <file>` applies a configuration
  to one run without editing the machine-local user config. The build output is
  therefore copied into the Renode tree before a run.
- In a file passed to `--config`, comments must start with `;`. Renode 1.17 hangs
  on `#` lines in that file (monitor scripts still use `#`).
- Renode always needs a **writable user directory**, and it is not configurable:
  `$HOME/.config/renode` on Linux and `%APPDATA%\renode` on Windows. It creates
  and locks `config.lock` there before doing anything else, so a read-only home
  fails with `config.lock not locked` or `Read-only file system`. This is the
  user directory, not the simulation directory.
- The **simulation working directory** is simply the process's cwd; relative
  `@file` paths and generated logs resolve against it. An in-repo, gitignored
  directory is therefore fine — on a local checkout whose path has no spaces.
- If the checkout is on OneDrive or any path containing spaces, keep the working
  directory and build outputs outside the repository instead: spaces break GNU
  Make and Renode's relative-path resolution, and sync daemons race the build.
- Headless invocation:

  ```
  renode --disable-xwt --console --plain -e "mach create" -e "quit"
  ```

## SDK selection

- `dotnet` uses the newest installed SDK by default.
- `golden/global.json` pins an 8.0.x SDK for everything under `golden/`, because
  the plugin has to target the `net8.0` runtime Renode ships. A nested
  `global.json` overrides the pin for a future tool that needs a newer SDK.
- Zed's Roslyn is a `net10.0` application and therefore needs a .NET 10
  *runtime* even though the model targets 8 — see "Editor tooling" below.

## Editor tooling

- Zed's C# extension ships a `net10.0` Roslyn language server, which needs a
  .NET 10 **runtime** even when the build only needs the SDK. The apphost looks
  for it in `DOTNET_ROOT` (then `/usr/share/dotnet`), and the language server's
  own environment is what counts, not the shell's:

  ```json
  "lsp": {
    "roslyn": {
      "binary": {
        "env": { "DOTNET_ROOT": "<dotnet root>" }
      }
    }
  }
  ```

- Pass `RENODE_BIN` through the same `env` block, so the model project loads in
  the editor exactly as it builds on the command line.

## Build artifacts

- Outputs land in gitignored in-repo directories: `build/`, `sim/`, `obj_dir/`,
  `tmp/`, `*.fst`, `xvlog.pb`, `.Xil/`. They are never committed.
- Kernel images must be built with the working directory set to `ss/` or
  `asm-kernels/`: `ss/crt0.s` includes `../asm-kernels/instructions.s`, so the
  same command run from the repository root fails to assemble.
- `irom.mem` and `irom.coe` are **tracked** and are overwritten in the
  repository root by both `generate.sh` scripts, so every kernel build dirties
  the working tree with generated binaries. This is a known inconsistency with
  `AGENTS.md` §8 and needs a decision; do not paper over it by hand.
