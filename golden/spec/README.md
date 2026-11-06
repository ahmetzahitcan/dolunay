# Dolunay specification documents

**Status: not written yet.** Authoritative once written (`../DECISIONS.md` D9).

The machine is specified by the ratified RISC-V specifications plus the
documents in this directory. They cover more than the ISA, each with exact
encodings or rules:

- **ISA:** the custom instructions, the custom CSRs, and every exemption from,
  or restriction of, the standard (which extensions the core implements, what
  is unsupported, what traps).
- **Execution model:** paths and what lockstep means (D3), the choice points
  and their rules — cooperative switching within a warp and the `yield`
  guarantee (D13) — reconvergence, and the order of conflicting accesses within
  one lockstep instruction (D14).
- **Memory and synchronisation:** the scratchpad, DMA, barriers and their
  memory ordering, as the variant settles.
- **Valid kernels:** the determinacy rule and the output descriptor a kernel
  supplies (D12).

The spec states what software may rely on. Where software does not care, it
leaves a **choice point** open for the implementation; `../CONTRACT.md` §1
says what that means for correctness.

Until these documents exist, no custom instruction or CSR is specified. The
model's only custom instruction (`../model/DolunayCpu.cs`) is a labelled
placeholder.

`../../control_unit/control_unit.csv` is the RTL's decoder input and may be used
as a cheatsheet of what the previous variant decoded; it is not a source for
these documents. Writing or changing anything here is a specification change and
needs a decision first (`../AGENTS.md` §5).
