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
| [`isa/`](isa/) | Dolunay's ISA documents (D9) — **not written yet** | **authoritative** once written |
| [`README.md`](README.md) | orientation, status, how to build and run, what to do next | informative |
| [`SUBSTRATE.md`](SUBSTRATE.md) | verified Renode host behaviour and quirks | informative; facts, not decisions |
| [`PERFORMANCE.md`](PERFORMANCE.md) | known performance problem and the deferred fixes, in order | informative |
| [`FINDINGS.md`](FINDINGS.md) | disagreements and defects found outside `golden/`, to be reported | informative; append to it |
| [`DESIGN.md`](DESIGN.md) | long design rationale | **legacy** — read its status header first |
| [`ITS-SEMANTICS.md`](ITS-SEMANTICS.md) | the published variant's ITS semantics | **legacy** — baseline, not spec |

Durable facts go in the file that owns them (table above); a choice goes in
`DECISIONS.md`; machine-local facts stay out of the repository (`CONTRACT.md`
§5). The one exception is **`HANDOFF.md`**, written only when the maintainer
asks for one at the end of a session: it says where the work stands and what
comes next, and points into the files above rather than restating them. If you
find one, read it after `CONTRACT.md` and `DECISIONS.md`, and delete it once its
content has been acted on or moved into its owning file.

## 1. Authority, in order

1. `CONTRACT.md` and `DECISIONS.md`
2. the ratified RISC-V specifications plus [`isa/`](isa/) — the ISA (D9)
3. `../ss/`, `../asm-kernels/` — the software contract and the workloads
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

## 2. The four ways this work goes wrong

- **Anchoring on the previous variant.** `DESIGN.md` and `ITS-SEMANTICS.md`
  describe a machine we are replacing, and the RTL implements it. Copying either
  produces a gold-plated model of the wrong machine.
- **Inventing the machine.** Guessing geometry, encodings, or the observation
  format produces something self-consistent and useless. Each has an
  authoritative source above, or is an open question (`CONTRACT.md` §2) you must
  not silently answer.
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
  `isa/` is a finding for `FINDINGS.md`, not a fix to land from here.
- If a task seems to require editing outside `golden/`, say so and stop.
- Changing `isa/` is an ISA change: it needs a decision first (§5).

## 4. Variant discipline

The next variant is in flux. Memory is being redesigned around scratchpad + DMA;
barrier logic is expected to change and may move into warp-level registers;
geometry and path visibility are undecided. Therefore:

- **Every variant-dependent behaviour goes behind a named interface or policy**,
  with a declared default and a test showing the rest of the model does not
  depend on it. No exceptions, no "temporarily inline".
- **No constants for geometry.** Warps × lanes is a parameter with one place it
  is read from.
- **No uncited encodings.** Every opcode, funct field and CSR number cites the
  RISC-V specification or the `isa/` section it comes from. The one exception
  today is the labelled placeholder in `model/DolunayCpu.cs`.
- Do not implement leader selection or TLS speculatively. They may not exist in
  the next variant. Paths *do* exist (D3), but their open rules — the precise
  meaning of lockstep, reconvergence — go behind interfaces until `isa/`
  defines them.

## 5. Decisions protocol

When you must choose something the contract does not settle, or find a
contradiction:

1. Prefer the smallest choice that leaves the rest of the model unchanged.
2. Record it in `DECISIONS.md`, following the rules at the top of that file:
   entries describe the current decision and are edited in place; substance
   changes need the maintainer; IDs are permanent.
3. If the choice is architectural (affects observable state, the ISA, or the
   observation format), ask the maintainer before implementing it.
4. Never commit without asking the maintainer.

## 6. Current state of the code

- `model/` is a `net8.0` Renode plugin (D8): `Dolunay.cs` is the `[Plugin]`
  marker (logs once, nothing else); `DolunayCpu.cs` defines `CPU.Dolunay`, a
  `RiscV32` subclass that installs custom instructions in its constructor.
- The only custom instruction is a **placeholder**: `0x0000700B` logs
  `Hello World`. It is not an ISA decision and will be replaced from `isa/`.
- `Dolunay.repl` still instantiates the stock `CPU.RiscV32` with no memory;
  `run.resc` is a smoke test that prints the PC.
- There is no unit-test project and no test runner yet. Do not claim tests ran.

## 7. Building and running — the traps

How to build and run is in [`README.md`](README.md#building-and-running). Things
that waste an hour if missed (details and evidence in
[`SUBSTRATE.md`](SUBSTRATE.md)):

- Run `dotnet` from `golden/` or below, so `global.json` pins SDK 8.
- The DLL must be copied into Renode's installation directory **before** Renode
  starts; it is not found anywhere else.
- **Never pass the tracked `renode.config` to `--config`**: Renode rewrites it.
  Pass a copy under `build/`, by absolute path.
- A stray Renode process holds `~/.config/renode/config.lock` and makes later
  runs hang silently. Check `pgrep -af renode` first.
- `cpu Step` on an aborted CPU (PC outside mapped memory) blocks the monitor.

## 8. Style

- **C#**: target `net8.0`, `LangVersion 12` — Renode's own settings. No
  IronPython, ever.
- **Python 3.12** for generators and tooling. Type hints, standard library
  preferred, no new dependency without a reason in the commit message.
- Comments explain *why*, or cite the spec section they encode. No comment that
  restates the code.
- Every generated file carries its generator and a "do not edit" line.
- Markdown here: one topic per file, a status line at the top of anything that
  is not authoritative, relative links, and no machine-local paths.

## 9. Verification, and honesty about it

- Never claim a build, test, or tool run happened unless you ran it and saw it
  pass. Quote the failing line when it fails.
- If a tool is missing (`CONTRACT.md` §5), say so plainly and leave the code
  reviewable without running it.
- **Do not invent commands or transcripts.** Run the check before claiming a
  tool exists.
- The strongest check the contract names is the property test over scheduler
  seeds (`CONTRACT.md` §1, guarantee 3); it does not exist yet. If your change
  has no test, say what a test would assert.

## 10. Housekeeping

- Build outputs, caches and Renode working directories go in the gitignored
  `build/`, never on a OneDrive or space-containing path (`CONTRACT.md` §5).
- Never commit generated binaries, logs, rewritten Renode configs, or
  `results.xml`-style artefacts.
- Do not create a second copy of the ISA or of the kernels. If a self-contained
  snapshot is ever needed, generate it and add a drift check.
