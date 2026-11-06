# `golden/` — the reference model of the Dolunay machine

This directory is the **reference** for the machine's architectural behaviour.
The RTL follows it, not the other way round.

New here? Read in this order:

1. [`CONTRACT.md`](CONTRACT.md) — what the model is, what it must guarantee,
   what is decided and what is still open, the inputs it may trust, the
   observation format, and the environment. **Authoritative.**
2. [`DECISIONS.md`](DECISIONS.md) — the choices made so far, with reasons.
3. [`AGENTS.md`](AGENTS.md) — working rules, if you are an agent or reviewing one.
4. [`DESIGN.md`](DESIGN.md) — the long design rationale. **Legacy-flavoured**:
   written for the previous variant, and in places against another branch.
5. [`ITS-SEMANTICS.md`](ITS-SEMANTICS.md) — the published variant's ITS semantics,
   kept as a reference point. **Legacy.**
6. [`SUBSTRATE.md`](SUBSTRATE.md) — observed Renode host behaviour: plugin
   discovery and enabling, configuration quirks, and why the target framework is
   pinned to the host's.

## Status

| | |
|---|---|
| Machine modelled | the **next** variant: per-lane execution, scratchpad + DMA, barrier logic under revision |
| Code | **skeleton only** — `Dolunay.repl`, `run.resc`, `renode.config`, `model/` plugin project; no machine behaviour |
| Substrate | Renode 1.17; the pre-built plugin builds, loads, and resolves `BaseRiscV` (D8). Lane-state swap and memory interception still unverified |
| Kernel build | the two `generate.sh` scripts call `riscv32-unknown-elf-*`; each machine supplies shims (`CONTRACT.md` §5) |
| Geometry | **undecided** — a parameter, never a constant |

## Running the skeleton

The plugin is built and then copied into Renode's installation directory, because
plugin discovery scans that directory rather than the repository
([`SUBSTRATE.md`](SUBSTRATE.md)). Each machine keeps its own launcher for this —
`run-renode.sh` here — which is **gitignored**, since shell conventions differ
between the machines this is used on. A launcher on any platform is expected to:

1. build `model/` with `RENODE_BIN` pointing at the Renode tree, from this
   directory so `global.json` pins the SDK Renode's runtime needs;
2. copy `build/plugin/Dolunay.Golden.dll` into `$RENODE_BIN`;
3. run `renode --config renode.config ... run.resc`.

Without one, those are the three commands documented at the top of `run.resc`.

The launcher is an aid, not a requirement: nothing in the model or the contract
depends on it existing.

## The one thing to get right

The RTL in `../src` implements the previous variant, and **nothing in it is part
of the contract unless `CONTRACT.md` says so**. You may read it to understand a
program image or the software build. When the model and the RTL disagree,
`CONTRACT.md` §3 says which side is authoritative; the disagreement is a finding
to report, and the RTL is read-only from here.

## Where the work starts

In order, each independently useful:

1. The concurrency core (lanes, warps, agent scheduler, policy interface, the
   interleaving-independence test) driven by a stub ISA — no tools required.
2. The ISA decode table / opcode patterns generated from
   `../control_unit/control_unit.csv` — pure Python, no tools required.
3. The Renode substrate spike: is whole-lane state swap cheap, and can memory
   be intercepted, or is a scratchpad device enough. The hook surface itself is
   proven — the plugin builds, loads, and names `BaseRiscV`, and an ad-hoc `.cs`
   file also compiles.

Memory, barrier and DMA semantics are **not** on that list: they are being
redesigned, and they arrive as knobs once the variant settles.
