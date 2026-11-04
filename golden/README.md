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

## Status

| | |
|---|---|
| Machine modelled | the **next** variant: per-lane execution, scratchpad + DMA, barrier logic under revision |
| Code | **none yet** — this directory is documents only |
| Substrate | Renode is the planned host; the ad-hoc C# hook surface is unverified |
| Kernel build | the two `generate.sh` scripts call `riscv32-unknown-elf-*`; each machine supplies shims (`CONTRACT.md` §5) |
| Geometry | **undecided** — a parameter, never a constant |

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
3. The Renode substrate spike: does ad-hoc C# see `BaseRiscV`, is whole-lane
   state swap cheap, can memory be intercepted or is a scratchpad device enough.

Memory, barrier and DMA semantics are **not** on that list: they are being
redesigned, and they arrive as knobs once the variant settles.
