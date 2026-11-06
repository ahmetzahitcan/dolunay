# Environment setup

What a machine needs to work on this repository, and the two conventions every
machine must follow. Machine-local paths and versions do not belong here (or
anywhere in the checkout).

Each area documents its own tool quirks: the golden model in
[`golden/SUBSTRATE.md`](golden/SUBSTRATE.md) (Renode, .NET) and
[`golden/README.md`](golden/README.md) (building, editor setup); the kernel build
in the headers of `ss/generate.sh` and `asm-kernels/generate.sh`.

## What each area needs

| Tool | Needed for | Check |
|---|---|---|
| RISC-V GCC 14+, as `riscv32-unknown-elf-*` (below) | kernels: `ss/`, `asm-kernels/` | `riscv32-unknown-elf-gcc -dumpfullversion` |
| make, hexdump, Python 3 | kernels (the scripts' last steps) | `make --version`, `hexdump --version`, `python3 --version` |
| bender | RTL: dependency fetch | `bender --version` |
| Verilator **or** Icarus Verilog | RTL simulation | `verilator --version` / `iverilog -V` |
| .NET SDK 8 | golden model: building the plugin | `dotnet --list-sdks` |
| Renode | golden model: the host | `renode --version` |

Report a missing tool as missing; do not substitute another silently.

## RISC-V compiler names are shims

The kernel scripts call `riscv32-unknown-elf-gcc` and
`riscv32-unknown-elf-objcopy` (`golden/DECISIONS.md` D7). Distributions use other
names:

| Distribution | Real name |
|---|---|
| Fedora | `riscv64-linux-gnu-gcc` / `-objcopy` (multilib provides rv32imafc/ilp32) |
| Debian/Ubuntu | `riscv64-unknown-elf-*` or `riscv64-linux-gnu-*` |
| xPack | `riscv-none-elf-*` |

So each machine puts two thin shims on `PATH`:

```sh
#!/bin/sh
exec <real-toolchain>-gcc "$@"
```

```sh
#!/bin/sh
exec <real-toolchain>-objcopy "$@"
```

- Do not add flags in a shim: the scripts pass `-march`/`-mabi` themselves, and
  an extra flag silently changes the image they claim to produce.
- On Windows the GCC shim must also put the toolchain's `bin` on `PATH` (the LTO
  plugin's DLLs are resolved through it), and the scripts need a `hexdump`
  stand-in.
- The `-march` strings use `zicond` and `zalrsc`; GCC older than 14 rejects
  them. Check the compiler before blaming the shim.
- Use **one** RISC-V toolchain per machine: the golden model fingerprints the
  program image, so two toolchains produce two different "same" programs.

## Paths

- Keep the checkout, or at least every build output, off OneDrive and off any
  path containing spaces: spaces break GNU Make and Renode's relative paths, and
  sync daemons race the build.
- Build outputs are gitignored (`.gitignore` is the list) and never committed.
- Renode needs a writable user directory (`$HOME/.config/renode`, or
  `%APPDATA%\renode` on Windows) even for headless runs.
