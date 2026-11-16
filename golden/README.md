# `golden/` — the reference model of the Dolunay machine

This directory is the **reference** for the machine's architectural behaviour.
The RTL follows it, not the other way round. Agents start at
[`AGENTS.md`](AGENTS.md).

New here? Read in this order:

1. [`CONTRACT.md`](CONTRACT.md) — what the model is, what it must guarantee,
   what is decided and what is open, the inputs it may trust, the observation
   format, and the environment. **Authoritative.**
2. [`DECISIONS.md`](DECISIONS.md) — the choices made so far, with reasons.
   **Authoritative.**
3. [`AGENTS.md`](AGENTS.md) — working rules and a map of every document here.
4. [`spec/`](spec/) — Dolunay's specification documents; only a draft of the
   execution model exists.
5. [`SUBSTRATE.md`](SUBSTRATE.md) — verified Renode host behaviour.
6. [`FINDINGS.md`](FINDINGS.md) — problems found outside `golden/`, waiting to
   be reported.

## Status

| | |
|---|---|
| Machine modelled | the **next** variant: threads in lockstep per path (D3), the PC rule (D21), whole-warp finishing (D24), scratchpad + DMA, barrier logic under revision |
| Specification | RISC-V standard + [`spec/`](spec/) (D9); only a draft of the execution model. ISA restrictions decided: F with static rounding (D17), no A or Zalrsc (D22), 32-bit instructions only (D25) |
| Design | the model executes the spec literally (D18); one Renode CPU of Dolunay's own per warp, with a headless runner for exploration and replay (D19) |
| Code | **an empty skeleton** — `model/Dolunay.sln` with the four projects of D8, no architectural code |
| Substrate | Renode 1.17; a `BaseCPU` of our own probed twice ([`SUBSTRATE.md`](SUBSTRATE.md)) |
| Kernel build | the previous variant's kernels, to be rewritten; the build scripts call `riscv32-unknown-elf-*`, and each machine supplies shims (`CONTRACT.md` §5) |
| Geometry | **undecided** — a parameter, never a constant |

## Building and running

From this directory, so that `global.json` pins SDK 8. The solution is
`model/Dolunay.sln` (D8).

```sh
# Unit tests: the model only, no Renode needed.
dotnet test model/Dolunay.Model.Tests

# The headless runner.
dotnet run --project model/Dolunay.Runner

# The Renode shell needs the unpacked Renode tree to build against.
RENODE_BIN=<unpacked renode tree> dotnet build model/Dolunay.Renode -c Release
```

There is nothing to run in Renode yet: the shell has no CPU class. Once it has,
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

1. **The step of one path, in `Dolunay.Model`, on a stub instruction set**: one
   instruction of the active path on each of its threads (D18), splitting by
   next PC, with the PC rule checked at `bsync` (D21). Its open rules (the
   lockstep order of D14, `bsync`'s release) stay knobs whose defaults the
   maintainer approves.
2. **The first ISA document in [`spec/`](spec/)**, with the maintainer: `yield`,
   `wdone`, the warp-id and thread-id CSRs, and the restrictions of D17, D22 and
   D25.
3. **The shell's first CPU class** in `Dolunay.Renode`, once the model has a
   step to call (D19, [`SUBSTRATE.md`](SUBSTRATE.md)).
4. **Later, in any order:** the observation writer (`CONTRACT.md` §4);
   exploration (PCT, partial-order reduction); the softfloat behind an
   interface (D17); the output descriptor and replay log formats, and the
   request to the RTL owner.

Open questions that the steps above will run into are listed in
`CONTRACT.md` §2; memory, barrier and DMA semantics arrive as the variant
settles.

## The one thing to get right

The RTL in `../src` implements the previous variant, and **nothing in it is part
of the contract unless `CONTRACT.md` says so**. When the model and the RTL
disagree, `CONTRACT.md` §3 says which side is authoritative; the disagreement
goes in [`FINDINGS.md`](FINDINGS.md), and the RTL is read-only from here.
