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
| Specification | RISC-V standard + [`spec/`](spec/) (D9); `spec/` is **not written yet**. Choice points left to the implementation; RTL checked by replay (D12–D15) |
| Code | **model core, first slice** — `model/Dolunay.sln` (D8): `Dolunay.Model` (paths, the engine, policies with record and replay, termination, model-owned memory, the conflict check; open rules behind knobs, D16), `Dolunay.Renode` (`CPU.Dolunay`, one placeholder instruction), NUnit tests on a scripted stub ISA; `Dolunay.repl`, `run.resc` |
| Substrate | Renode 1.17; both assemblies build and load, and `CPU.Dolunay` extends `RiscV32` (D8). Probed: standard opcodes can be overridden, lanes can stop before an instruction, ≤32 cores per machine, ≈0.85 ms per lane rendezvous ([`SUBSTRATE.md`](SUBSTRATE.md#execution-control-probed-2026-11-06), [`PERFORMANCE.md`](PERFORMANCE.md)) |
| Kernel build | the two `generate.sh` scripts call `riscv32-unknown-elf-*`; each machine supplies shims (`CONTRACT.md` §5) |
| Geometry | **undecided** — a parameter, never a constant |

## Building and running

From this directory, so that `global.json` pins SDK 8. The solution is
`model/Dolunay.sln` (D8): `Dolunay.Model`, `Dolunay.Renode`, and
`Dolunay.Model.Tests`.

```sh
# Unit tests: the model only, no Renode needed.
dotnet test model

# The Renode adapter needs the unpacked Renode tree to build against.
RENODE_BIN=<unpacked renode tree> dotnet build model -c Release

# Renode registers types only from its own installation directory, at start-up.
cp build/plugin/Dolunay.Model.dll build/plugin/Dolunay.Renode.dll "$RENODE_BIN/"
timeout -k 5 60 renode --disable-xwt --console --plain run.resc
```

Expected: the PC (`0x1000`), then Renode quits. `Dolunay.repl` names
`CPU.Dolunay`, so this fails if the DLLs were not found. Always cap a Renode
run: a hung handler or a script error leaves it waiting silently.

A machine that ran the previous layout has a `Dolunay.Golden.dll` in its Renode
tree; delete it, or it is loaded alongside the new DLLs.

Each machine may keep a **gitignored** launcher that does those steps
(`run-renode.sh` here). Shell conventions differ between machines, so it is not
shared; nothing depends on it existing.

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

1. **The model core — first slice done.** It has paths, the engine, the D13
   `yield` rule, policies (first, seeded random, record and replay),
   `all-wdone`, `deadlock`, `timeout` and `illegal`, and the conflict check. On
   the stub ISA, the check catches the shapes of F4 and F5. The defaults are in
   D16. Still to do:
   - the observation writer (`CONTRACT.md` §4);
   - PCT and systematic exploration (methods 2–3);
   - the real `bsync` rule, once the memory redesign settles it.
2. **Write the first specification documents** in [`spec/`](spec/). Needs the
   maintainer. Real kernels need `yield`, the barrier pair, the warp-id and
   thread-id CSRs, and the order within one lockstep instruction (D14); the
   kernels' mutex also needs an answer on LR/SC.
3. **The adapter (D11):** one machine per lane, each with one `CPU.Dolunay` and
   a scratchpad device forwarding to the model; geometry as one parameter, with
   a generated `.resc`; branches, jumps and shared-memory accesses overridden.
4. **Later, in any order:** the output descriptor and replay log formats, and
   the request to the RTL owner; exploration (partial-order reduction, PCT);
   the [`PERFORMANCE.md`](PERFORMANCE.md) fixes.

Memory, barrier and DMA semantics are **not** on that list: they are being
redesigned, and they arrive as knobs once the variant settles.

## The one thing to get right

The RTL in `../src` implements the previous variant, and **nothing in it is part
of the contract unless `CONTRACT.md` says so**. When the model and the RTL
disagree, `CONTRACT.md` §3 says which side is authoritative; the disagreement
goes in [`FINDINGS.md`](FINDINGS.md), and the RTL is read-only from here.
