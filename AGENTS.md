# Agent instructions

Rules that apply to the whole repository. Everything more specific lives next to
the code it governs.

- **Working under `golden/`:** read [`golden/AGENTS.md`](golden/AGENTS.md),
  [`golden/CONTRACT.md`](golden/CONTRACT.md) and
  [`golden/DECISIONS.md`](golden/DECISIONS.md) before your first edit. The golden
  model is the reference for the machine; this repository's RTL is evidence about
  a previous variant, not a specification.
- **Working anywhere else:** `golden/` is read-only from there. Do not change the
  model to match RTL behaviour — report the disagreement instead.
- Keep build outputs, caches and simulator working directories **off** the
  OneDrive path: spaces break GNU Make, and sync daemons break relative-path
  resolution.
