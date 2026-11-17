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
4. [`FINDINGS.md`](FINDINGS.md) — problems found outside `golden/`, waiting to
   be reported.

## Status

| | |
|---|---|
| Machine modelled | the **next** variant: threads in lockstep per path, the PC rule, whole-warp finishing, scratchpad + DMA, barrier logic under revision |
| Specification | RISC-V standard + [`spec/`](spec/); only a draft of the execution model. ISA restrictions decided: F with static rounding, no A or Zalrsc, 32-bit instructions only |
| Design | the model executes the spec literally; a program of its own, in Zig |
| Code | **an empty skeleton** — the Zig package in `model/`, linked against Berkeley SoftFloat, no architectural code |
| Kernel build | the previous variant's kernels, to be rewritten; the build scripts call `riscv32-unknown-elf-*`, and each machine supplies shims (`CONTRACT.md` §5) |
| Geometry | **undecided** — a parameter, never a constant |

## Building and running

From `model/`, with the Zig version that `model/build.zig.zon` pins:

```sh
zig build test
```

The first build fetches Berkeley SoftFloat (network needed). There is nothing
to run yet: the model has no architectural code, and the only tests check that
SoftFloat is linked with its RISC-V specialization.

## Next steps

In order; each is a small step to discuss before it is coded.

1. **The step of one path, in the model, on a stub instruction set**: one
   instruction of the active path on each of its threads, splitting by
   next PC, with the PC rule checked at `bsync`. Its open rules (the
   order within one lockstep instruction, `bsync`'s release) stay knobs whose defaults the
   maintainer approves.
2. **The first ISA document in [`spec/`](spec/)**, with the maintainer: `yield`,
   `wdone`, the warp-id and thread-id CSRs, and the decided restrictions: F with static
   rounding, no A or Zalrsc, 32-bit instructions only.
3. **Later, in any order:** the observation writer (`CONTRACT.md` §4);
   exploration (PCT, partial-order reduction); SoftFloat behind an
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
