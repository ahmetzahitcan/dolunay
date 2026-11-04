# Agent rules for `golden/`

These rules apply to any agent — human-directed or autonomous — doing work under
`golden/`. They exist because the golden model is the *reference*: its job is to
say what the machine should do, and an agent that quietly widens it to fit
whatever code it finds has destroyed the thing it was built for.

**Read [`CONTRACT.md`](CONTRACT.md) and [`DECISIONS.md`](DECISIONS.md) before
your first edit.** If they contradict each other, stop and report it.

---

## 1. Authority, in order

1. `CONTRACT.md` and `DECISIONS.md`
2. `../control_unit/control_unit.csv` — the ISA, and the only source of encodings
3. `../ss/`, `../asm-kernels/` — the software contract and the workloads
4. the generated ISA table — derived; regenerate it, never edit it
5. `../src/`, `../tb/`, `../sim/` — **read-only; confers no requirements**
   (the previous variant's RTL)

The RTL in this repository is *not* a specification, and **nothing in it becomes
part of the contract unless `CONTRACT.md` says so** — not its parameters, memory
map, instruction behaviour, start-up, or termination. Reading it is allowed where
it is unavoidable (building the software, understanding a program image), but
what you learn there is not a requirement, and it does not become one until it is
written into the contract. `CONTRACT.md` §2 lists what has changed and what is
undecided.

## 2. The four ways this work goes wrong

- **Anchoring on the previous variant.** `DESIGN.md` and `ITS-SEMANTICS.md`
  describe a machine we are replacing, and the RTL implements it. Copying either
  produces a gold-plated model of the wrong machine. They are marked with
  `STATUS: legacy` for this reason.
- **Inventing the machine.** Guessing geometry, encodings, or the observation
  format produces something self-consistent and useless. Every one of those has
  an authoritative source above, or is an open question you must not silently
  answer.
- **Helpfully fixing the neighbourhood.** Repairing the stale `../ss/`, the RTL,
  or the CSV is out of scope and hides the drift we are trying to *measure*.
- **Reconciling with the RTL.** Editing the RTL so a disagreement goes away, or
  adopting an RTL behaviour because it is already there. Either way the reference
  stops being a reference. Report the difference; the report *is* the output.

## 3. Write scope

- **Writable:** `golden/` only.
- **Read-only:** `../src/`, `../tb/`, `../sim/`, `../ss/`, `../asm-kernels/`,
  `../control_unit/`.
- Read-only means exactly that. A genuine RTL bug found while working on the model
  is a finding to report, not a fix to land from here — and the same goes for a
  stale `../ss/` or a confusing CSV row.
- If a task seems to require editing outside `golden/`, say so and stop. A
  change to the ISA CSV is an ISA change and needs a decision first.

## 4. Variant discipline

The next variant is in flux. Memory is being redesigned around scratchpad + DMA;
barrier logic is expected to change and may move into warp-level registers;
geometry and path visibility are undecided.

Therefore:

- **Every variant-dependent behaviour goes behind a named interface or policy**,
  with a declared default and a test showing the rest of the model does not
  depend on it. No exceptions, no "temporarily inline".
- **No constants for geometry.** Warps × lanes is a parameter with one place it
  is read from.
- **No hand-written encodings.** Not for the ISA, not for the ITS instructions,
  not for CSRs.
- Do not implement `leader selection`, `TLS`, or path splitting speculatively.
  They may not exist in the next variant.

## 5. Decisions protocol

When you must choose something the contract does not settle, or when you find a
contradiction:

1. Prefer the smallest choice that leaves the rest of the model unchanged.
2. Append an entry to `DECISIONS.md` — append-only, never rewrite history; to
   reverse a decision, add a new one and mark the old one `superseded by D<n>`.
3. If the choice is architectural (affects observable state, the ISA, or the
   observation format), ask before implementing it.

## 6. Style

- **C#** when the model exists as C#: target `net8.0`, `LangVersion 12` — Renode's
  own settings. No IronPython, ever. A Python 2 island is not acceptable.
- **Python 3.12** for generators and tooling. Type hints, standard library
  preferred, no new dependency without a reason in the commit message. If a
  linter or type-checker config appears in the tree, follow it.
- Comments explain *why*, or cite the spec/RTL line they encode. No comment that
  restates the code.
- Every generated file carries its generator and a "do not edit" line.

## 7. Verification, and honesty about it

- Never claim a build, test, or tool run happened unless you ran it and saw it
  pass. Quote the failing line when it fails.
- If a tool is missing (see `CONTRACT.md` §5), say so plainly and leave the code in
  a state that is reviewable without running it. That section lists requirements,
  not an inventory of what is installed here.
- **Do not invent commands or transcripts.** Run the check before claiming a tool
  exists. The build scripts need `riscv32-unknown-elf-*` on `PATH`, which each
  machine provides as shims; a machine without them cannot build kernels.
- There is currently no model code, project file, or test runner in `golden/`.
  Do not assume one exists, and do not silently create one that the contract does
  not describe.
- The strongest available check today is the property test over scheduler seeds
  (`CONTRACT.md` §1, guarantee 3). If your change does not have a test, say what
  a test would assert.

## 8. Housekeeping

- Keep build outputs, caches, and Renode working directories **off** the OneDrive
  path; use a `DOLUNAY_BUILD_DIR`-style location outside the repository.
- Never commit generated binaries, logs, or `results.xml`-style artefacts.
- Do not create a second copy of the ISA table or of the kernels. If a
  self-contained snapshot is ever needed, generate it and add a drift check.
