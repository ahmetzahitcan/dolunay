# `golden/` — the reference model of the Dolunay machine

This directory is the **reference** for the machine's architectural behaviour.
The RTL follows it, not the other way round. Agents start at
[`AGENTS.md`](AGENTS.md).

New here? Read in this order:

1. [`CONTRACT.md`](CONTRACT.md) — what the model is, what it must guarantee,
   what is decided and what is open, the inputs it may trust, the observation
   format, and the environment. **Authoritative.**
2. [`AGENTS.md`](AGENTS.md) — working rules and a map of every document here.
3. [`spec/`](spec/) — Dolunay's specification documents; only a draft of the
   execution model exists.
4. [`SUBSTRATE.md`](SUBSTRATE.md) — verified Renode host behaviour.
5. [`FINDINGS.md`](FINDINGS.md) — problems found outside `golden/`, waiting to
   be reported.

## Status

| | |
|---|---|
| Machine modelled | the **next** variant: threads in lockstep per path, the PC rule, whole-warp finishing, scratchpad + DMA, barrier logic under revision |
| Specification | RISC-V standard + [`spec/`](spec/); only a draft of the execution model. ISA restrictions decided: F with static rounding, no A or Zalrsc, 32-bit instructions only |
| Design | the model executes the spec literally; one Renode CPU of Dolunay's own per warp |
| Code | **an empty skeleton** — `model/Dolunay.sln` with three projects, no architectural code |
| Substrate | Renode 1.17; a `BaseCPU` of our own probed twice ([`SUBSTRATE.md`](SUBSTRATE.md)) |
| Kernel build | the previous variant's kernels, to be rewritten; the build scripts call `riscv32-unknown-elf-*`, and each machine supplies shims (`CONTRACT.md` §5) |
| Geometry | **undecided** — a parameter, never a constant |

## Building and running

From this directory, so that `global.json` pins SDK 8. The solution is
`model/Dolunay.sln`.

```sh
# The model is built against the unpacked Renode tree.
RENODE_BIN=<unpacked renode tree> dotnet build model/Dolunay -c Release
```

There is nothing to run in Renode yet: the model has no CPU class. Once it has,
its DLLs go into the Renode installation directory before Renode starts, and
every run is capped (`AGENTS.md` §7).

A machine that ran an earlier layout may have `Dolunay.Golden.dll`,
`Dolunay.Model.dll` or `Dolunay.Renode.dll` in its Renode tree; delete them, or
they are loaded alongside the new ones.

### Editor setup

A C# language server must see the same `RENODE_BIN` as the build, or the
Renode project will not load.

- **Zed:** its C# extension ships a `net10.0` Roslyn, which needs a .NET 10
  **runtime** although the model targets 8, and it reads `DOTNET_ROOT` from its
  own environment, not the shell's:

  ```json
  "lsp": {
    "roslyn": {
      "binary": {
        "env": { "DOTNET_ROOT": "<dotnet root>", "RENODE_BIN": "<renode tree>" }
      }
    }
  }
  ```

- **VS Code:** the C# extension's `dotnet.server.environmentVariables` setting
  reaches the language server, but C# Dev Kit loads projects in a separate
  process that does not read it (observed 2026-11-16). `RENODE_BIN` probably
  has to be in the environment VS Code itself starts with, such as the desktop
  session's; this is not yet verified.

Keep these values out of the repository (`CONTRACT.md` §5).

## Next steps

In order; each is a small step to discuss before it is coded.

1. **The step of one path, in `Dolunay`, on a stub instruction set**: one
   instruction of the active path on each of its threads, splitting by
   next PC, with the PC rule checked at `bsync`. Its open rules (the
   order within one lockstep instruction, `bsync`'s release) stay knobs whose defaults the
   maintainer approves.
2. **The first ISA document in [`spec/`](spec/)**, with the maintainer: `yield`,
   `wdone`, the warp-id and thread-id CSRs, and the decided restrictions: F with static
   rounding, no A or Zalrsc, 32-bit instructions only.
3. **The first CPU class** in `Dolunay`, calling that step
   ([`SUBSTRATE.md`](SUBSTRATE.md)).
4. **Later, in any order:** the observation writer (`CONTRACT.md` §4);
   exploration (PCT, partial-order reduction); the softfloat behind an
   interface; the output descriptor and replay log formats, and the
   request to the RTL owner.

Open questions that the steps above will run into are listed in
`CONTRACT.md` §2; memory, barrier and DMA semantics arrive as the variant
settles.

## The one thing to get right

The RTL in `../src` implements the previous variant, and **nothing in it is part
of the contract unless `CONTRACT.md` says so**. When the model and the RTL
disagree, `CONTRACT.md` §3 says which side is authoritative; the disagreement
goes in [`FINDINGS.md`](FINDINGS.md), and the RTL is read-only from here.
