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
4. [`SUBSTRATE.md`](SUBSTRATE.md) — verified Renode host behaviour.
   [`PERFORMANCE.md`](PERFORMANCE.md) — the known execution-cost problem and
   the fixes deferred until later.
5. [`FINDINGS.md`](FINDINGS.md) — problems found outside `golden/`, waiting to
   be reported.
6. [`DESIGN.md`](DESIGN.md) and [`ITS-SEMANTICS.md`](ITS-SEMANTICS.md) —
   **legacy** rationale for the previous variant. Read their status headers.

## Status

| | |
|---|---|
| Machine modelled | the **next** variant: lanes in lockstep per path (D3), scratchpad + DMA, barrier logic under revision |
| ISA | RISC-V standard + [`isa/`](isa/) (D9); `isa/` is **not written yet** |
| Code | **skeleton** — `model/` plugin with `CPU.Dolunay` (one placeholder instruction), `Dolunay.repl`, `run.resc`, `renode.config` |
| Substrate | Renode 1.17; the plugin builds, loads, and extends `RiscV32` (D8). Probed: standard opcodes can be overridden, lanes can stop before an instruction, ≤32 cores per machine, ≈0.85 ms per lane rendezvous ([`SUBSTRATE.md`](SUBSTRATE.md#execution-control-probed-2026-11-06), [`PERFORMANCE.md`](PERFORMANCE.md)) |
| Kernel build | the two `generate.sh` scripts call `riscv32-unknown-elf-*`; each machine supplies shims (`CONTRACT.md` §5) |
| Geometry | **undecided** — a parameter, never a constant |

## Building and running

The plugin is copied into Renode's installation directory because plugin
discovery scans only that directory, at start-up ([`SUBSTRATE.md`](SUBSTRATE.md)).
From this directory, so that `global.json` pins SDK 8:

```sh
RENODE_BIN=<unpacked renode tree> dotnet build model -c Release --nologo -nowarn:MSB3277
cp build/plugin/Dolunay.Golden.dll "$RENODE_BIN/"

# Renode rewrites the file given to --config; give it a copy, by absolute path.
cp renode.config build/renode.run.config
renode --config "$PWD/build/renode.run.config" --disable-xwt --console --plain run.resc
```

Expected: `Dolunay.Golden plugin loaded (skeleton)`, then the PC (`0x1000`),
then Renode quits.

Each machine may keep a **gitignored** launcher that does those steps
(`run-renode.sh` here: `--headless` runs `run.resc`; no flag opens an
interactive monitor with the machine created). Shell conventions differ between
machines, so it is not shared; nothing depends on it existing.

### Editor setup

A C# language server must see the same `RENODE_BIN` as the build, or the
project will not load. Zed's C# extension needs more: it ships a `net10.0`
Roslyn, which needs a .NET 10 **runtime** although the model targets 8, and it
reads `DOTNET_ROOT` from its own environment, not the shell's:

```json
"lsp": {
  "roslyn": {
    "binary": {
      "env": { "DOTNET_ROOT": "<dotnet root>", "RENODE_BIN": "<renode tree>" }
    }
  }
}
```

## Next steps

In order; each is independently useful.

1. **Write the ISA documents** in [`isa/`](isa/): custom instructions, custom
   CSRs, exemptions. Needs the maintainer — it is an ISA change.
2. **Implement them** in `CPU.Dolunay`: replace the placeholder `0x0000700B`
   with the documented encodings, register custom CSRs in the same constructor,
   and point `Dolunay.repl` and `run.resc` at `CPU.Dolunay`.
3. **Decide memory ownership** (`CONTRACT.md` §2) before any load/store
   interception. Memory as a device is the composition-friendly option.
4. **The concurrency core** — lanes, warps, paths, the path scheduler and
   policy interface, the interleaving-independence test — driven by a stub ISA.
   Needs a unit-test project outside Renode (possible since D8).
5. **The slow execution design** (D11): one machine per lane, overridden
   opcodes, a rendezvous at every branch. Its
   speed-ups wait until it is correct and a workload needs them.

Memory, barrier and DMA semantics are **not** on that list: they are being
redesigned, and they arrive as knobs once the variant settles.

## The one thing to get right

The RTL in `../src` implements the previous variant, and **nothing in it is part
of the contract unless `CONTRACT.md` says so**. When the model and the RTL
disagree, `CONTRACT.md` §3 says which side is authoritative; the disagreement
goes in [`FINDINGS.md`](FINDINGS.md), and the RTL is read-only from here.
