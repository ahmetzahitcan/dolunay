# Dolunay specification documents

**Status: drafts only.** A document here is authoritative once it is approved
and its status line says so (`../DECISIONS.md` D9).

| Document | Status |
|---|---|
| [`EXECUTION-MODEL.md`](EXECUTION-MODEL.md) | draft — warp program order, paths, lockstep, memory axioms |

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

## Terminology

Every document here uses these words with these meanings only:

| Term | Meaning |
|---|---|
| **TBD** | Not written yet, but will be. A gap in the spec, never a freedom for the implementation. |
| **unspecified** | The implementation chooses among outcomes the spec lists, and may choose differently every time; nothing is documented. Every unspecified behaviour states its allowed set ("the next active path is one of the new paths"). As in the RISC-V specifications' UNSPECIFIED, and C's "unspecified behaviour". |
| **illegal** | Software must not do it, and a kernel that does is not valid. The spec promises nothing about what follows unless it says so explicitly. The model reports what it can detect (for example `deadlock`, `../CONTRACT.md` §1). |

Not used: *implementation-defined* (in C it means one documented choice, which
is too narrow), *undefined* (suggests anything may happen), *reserved* (in
RISC-V it suggests a future use, and Dolunay does not aim for forward
compatibility).

Until these documents exist, no custom instruction or CSR is specified. The
model's only custom instruction (`../model/Dolunay.Renode/DolunayCpu.cs`) is a labelled
placeholder.

`../../control_unit/control_unit.csv` is the RTL's decoder input and may be used
as a cheatsheet of what the previous variant decoded; it is not a source for
these documents. Writing or changing anything here is a specification change and
needs a decision first (`../AGENTS.md` §5).
