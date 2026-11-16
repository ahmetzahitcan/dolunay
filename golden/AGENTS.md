# Agent rules for `golden/`

These rules apply to any agent doing work under `golden/`. The golden model is
the *reference*: its job is to say what the machine should do. An agent that
quietly widens it to fit whatever code it finds has destroyed the thing it was
built for.

**Before your first edit, read [`CONTRACT.md`](CONTRACT.md) and
[`DECISIONS.md`](DECISIONS.md).** If they contradict each other, stop and report
it.

---

## 0. Documents in this directory

| File | What it is | Authority |
|---|---|---|
| [`AGENTS.md`](AGENTS.md) | these working rules | binding on agents |
| [`CONTRACT.md`](CONTRACT.md) | what the model is, guarantees, decided vs. open, inputs, observation format | **authoritative** |
| [`DECISIONS.md`](DECISIONS.md) | decision log (D1…); each entry is the current rule, history is in git | **authoritative** |
| [`spec/`](spec/) | Dolunay's specification documents: the ISA and the execution model (D9). Only a draft of the execution model exists | **authoritative** once approved; a draft is not |
| [`README.md`](README.md) | orientation, status, how to build and run, what to do next | informative |
| [`SUBSTRATE.md`](SUBSTRATE.md) | verified Renode host behaviour and quirks | informative; facts, not decisions |
| [`FINDINGS.md`](FINDINGS.md) | disagreements and defects found outside `golden/`, to be reported | informative; append to it |

The previous variant's design documents and the redesign's working papers are
in git history only. They are not inputs: nothing in them holds unless
`CONTRACT.md` or `DECISIONS.md` says so.

Durable facts go in the file that owns them (table above); a choice goes in
`DECISIONS.md`, once the maintainer has made it (§5); machine-local facts stay
out of the repository (`CONTRACT.md` §5). The one exception is **`HANDOFF.md`**,
written only when the maintainer asks for one at the end of a session: it says
where the work stands and what comes next, and points into the files above
rather than restating them. If you find one, read it after `CONTRACT.md` and
`DECISIONS.md`, and delete it once its content has been acted on or moved into
its owning file.

## 1. Authority, in order

1. `CONTRACT.md` and `DECISIONS.md`
2. the ratified RISC-V specifications plus [`spec/`](spec/) — the ISA (D9)
3. `../ss/`, `../asm-kernels/` — the software contract and the workloads of the
   previous variant, to be rewritten (maintainer, 2026-11-14): a corpus, not a
   source of requirements for the next variant
4. anything generated from rank 2 — derived; regenerate it, never edit it
5. `../control_unit/control_unit.csv` — the RTL's decoder input; a cheatsheet,
   **confers no requirements** (D9)
6. `../src/`, `../tb/`, `../sim/` — the previous variant's RTL; **read-only,
   confers no requirements**

The RTL is *not* a specification, and **nothing in it becomes part of the
contract unless `CONTRACT.md` says so** — not its parameters, memory map,
instruction behaviour, start-up, or termination. Reading it is allowed where it
is unavoidable (building the software, understanding a program image), but what
you learn there is not a requirement until it is written into the contract.

## 2. The five ways this work goes wrong

- **Anchoring on the previous variant.** The RTL and the previous variant's
  documents describe a machine we are replacing. Copying them produces a
  gold-plated model of the wrong machine.
- **Inventing the machine.** Guessing geometry, encodings, or the observation
  format produces something self-consistent and useless. Each has an
  authoritative source above, or is an open question (`CONTRACT.md` §2) you must
  not silently answer.
- **Answering an open question yourself.** A default, a placeholder rule or "the
  smallest choice" is still a choice. If code or text would settle something the
  contract or `spec/` leaves open or TBD, stop and report it (§5), even when the
  choice looks harmless.
- **Helpfully fixing the neighbourhood.** Repairing the stale `../ss/`, the RTL,
  or the CSV is out of scope and hides the drift we are trying to *measure*.
- **Reconciling with the RTL.** Editing the RTL so a disagreement goes away, or
  adopting an RTL behaviour because it is already there. Either way the
  reference stops being a reference. Record the difference in
  [`FINDINGS.md`](FINDINGS.md); the report *is* the output.

## 3. Write scope

- **Writable:** `golden/` only.
- **Read-only:** everything else, in particular `../src/`, `../tb/`, `../sim/`,
  `../ss/`, `../asm-kernels/`, `../control_unit/`.
- A genuine RTL bug, a stale `../ss/`, or a CSV row that disagrees with
  `spec/` is a finding for `FINDINGS.md`, not a fix to land from here.
- If a task seems to require editing outside `golden/`, say so and stop.
- Changing `spec/` is a specification change: it needs a decision first (§5).

## 4. Variant discipline

The next variant is in flux. Memory is being redesigned around scratchpad + DMA;
barrier logic is expected to change and may move into warp-level registers;
geometry is undecided. Therefore:

- **Every variant-dependent behaviour goes behind a named interface or policy**,
  with a test showing the rest of the model does not depend on it. Its default
  is a choice like any other: propose it, and use it once the maintainer has
  approved it (§5). No "temporarily inline".
- **No constants for geometry.** Warps × threads is a parameter with one place
  it is read from.
- **No uncited encodings.** Every opcode, funct field and CSR number cites the
  RISC-V specification or the `spec/` section it comes from. Until `spec/`
  specifies a custom instruction, any in the code is a placeholder labelled as
  such (D9).
- Do not implement leader selection or TLS speculatively. They may not exist in
  the next variant. Paths *do* exist (D3), but their open rules — the precise
  meaning of lockstep, `bsync` — go behind interfaces until `spec/` defines
  them.

## 5. Decisions protocol

Only the maintainer decides. When you find something the contract, the decision
log or `spec/` does not settle, or a contradiction between them, or a
disagreement between them and the model's code (`CONTRACT.md`, introduction):

1. **Stop and report it** to the maintainer: what is unsettled, the options, what
   each costs and forecloses, and your recommendation if you have one.
2. **Do not implement an answer** in the meantime, not even as a default.
   Unfinished work — code that does not yet implement a settled rule — is the
   only thing that needs no report.
3. **When the maintainer decides, record it** in `DECISIONS.md`, following the
   rules at the top of that file: entries describe the current decision and are
   edited in place; IDs are permanent. Show the maintainer the entry's wording.
4. **Never commit without asking the maintainer.** Approval is per commit.

## 6. Current state of the code

- `model/Dolunay.sln` holds the four `net8.0` projects of D8, as an empty
  skeleton: `Dolunay.Model` (the pure model), `Dolunay.Runner` (the headless
  runner, D19), `Dolunay.Renode` (the `BaseCPU` shell) and
  `Dolunay.Model.Tests` (NUnit, on the model only). None holds architectural
  code yet. The previous design's code is in git history; do not restore it.
- There is no custom instruction, no Renode CPU class, and no `.repl` or
  `.resc` yet.
- How to build and test is in [`README.md`](README.md#building-and-running).
  When you run the tests, say how many ran and passed; do not claim a run you
  did not see.

## 7. Building and running — the traps

Things that waste an hour if missed (details and evidence in
[`SUBSTRATE.md`](SUBSTRATE.md)):

- Run `dotnet` from `golden/` or below, so `global.json` pins SDK 8.
- The DLLs, and any native library they load, must be copied into Renode's
  installation directory **before** Renode starts; they are not found anywhere
  else.
- **Cap every Renode run** (`timeout -k 5 60 renode …`). A blocked handler or a
  failed script line leaves Renode waiting silently.
- **Never block a CPU thread in a handler**: it stops every CPU in the
  emulation.
- **A CPU of our own** runs on one host thread per CPU by default, and the order
  of their calls differs from run to run; use `emulation
  SetGlobalSerialExecution True`, or gate the CPUs through one policy, for
  anything that needs a reproducible result. A gated CPU that is not on turn
  must report its quantum as done: returning zero instructions stalls serial
  mode.
- Virtual time follows the host clock by default, and a CPU that reports few
  instructions per call is called very often; both make a Renode-hosted run
  slow.
- A probe DLL copied into the Renode tree is loaded on every later start; remove
  it when the probe is done.
- If a `--config` file is ever needed, never pass a tracked one: Renode rewrites
  it. Pass a copy under `build/`, by absolute path.
- A stray Renode process holds `~/.config/renode/config.lock` and makes later
  runs hang silently. Check `pgrep -af renode` first.
- `cpu Step` on an aborted `RiscV32` (PC outside mapped memory) blocks the
  monitor.

## 8. Style

- **C#**: target `net8.0`, `LangVersion 12` — Renode's own settings. No
  IronPython, ever (D5).
- **Python 3.12** for generators and tooling. Type hints, standard library
  preferred, no new dependency without a reason in the commit message.
- Comments explain *why*, or cite the spec section they encode. No comment that
  restates the code.
- Every generated file carries its generator and a "do not edit" line.
- Markdown here: one topic per file, a status line at the top of anything that
  is not authoritative, relative links, and no machine-local paths.
- Say *thread*, never *lane*, and *host thread* for an operating-system thread
  (D20).

## 9. Verification, and honesty about it

- Never claim a build, test, or tool run happened unless you ran it and saw it
  pass. Quote the failing line when it fails.
- If a tool is missing (`CONTRACT.md` §5), say so plainly and leave the code
  reviewable without running it.
- **Do not invent commands or transcripts.** Run the check before claiming a
  tool exists.
- The strongest checks the contract names are the determinacy check
  (`CONTRACT.md` §1, guarantee 3) and replay against the RTL (D15); neither
  exists yet. If your change has no test, say what a test would assert.

## 10. Housekeeping

- Build outputs, caches and Renode working directories go in the gitignored
  `build/`, never on a OneDrive or space-containing path (`CONTRACT.md` §5).
- Never commit generated binaries, logs, rewritten Renode configs, or
  `results.xml`-style artefacts.
- Do not create a second copy of the ISA or of the kernels. If a self-contained
  snapshot is ever needed, generate it and add a drift check.
