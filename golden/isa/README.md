# Dolunay ISA documents

**Status: not written yet.** Authoritative once written (`../DECISIONS.md` D9).

The ISA is the ratified RISC-V specifications plus the documents in this
directory. They are to specify, each with exact encodings and semantics:

- the custom instructions,
- the custom CSRs,
- every exemption from, or restriction of, the standard (which extensions the
  core implements, what is unsupported, what traps).

Until they exist, no custom instruction or CSR is specified. The model's only
custom instruction (`../model/DolunayCpu.cs`) is a labelled placeholder.

`../../control_unit/control_unit.csv` is the RTL's decoder input and may be used
as a cheatsheet of what the previous variant decoded; it is not a source for
these documents. Writing or changing anything here is an ISA change and needs a
decision first (`../AGENTS.md` §5).
