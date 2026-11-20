# Agent rules for `golden/`

These rules apply to any agent doing work under `golden/`. The golden model is
the *reference*: its job is to say what the machine should do. An agent that
quietly widens it to fit whatever code it finds has destroyed the thing it was
built for.

**Before your first edit, read [`CONTRACT.md`](CONTRACT.md).** If it
contradicts `spec/` or the code, stop and report it.

**Do not make decisions.** The maintainer makes every one, and cannot audit
choices an agent made on the way. When something is not settled, ask (§5).

---

## 0. Documents in this directory

| File | What it is | Authority |
|---|---|---|
| [`AGENTS.md`](AGENTS.md) | these working rules | binding on agents |
| [`CONTRACT.md`](CONTRACT.md) | what the model is, guarantees, decided vs. open, inputs, observation format | **authoritative** |
| [`spec/`](spec/) | Dolunay's specification documents: the ISA and the execution model. Only a draft of the execution model exists | **authoritative** once approved; a draft is not |
| [`README.md`](README.md) | orientation, status, how to build and run, what to do next | informative |
| [`FINDINGS.md`](FINDINGS.md) | disagreements and defects found outside `golden/`, to be reported | informative; append to it |

The previous variant's design documents and the redesign's working papers are
in git history only. They are not inputs: nothing in them holds unless
`CONTRACT.md` says so.

Durable facts go in the file that owns them (table above); choices are the
maintainer's (§5); machine-local facts stay out of the repository
(`CONTRACT.md` §5). The one exception is **`HANDOFF.md`**, written only when
the maintainer asks for one at the end of a session: it says where the work
stands and what comes next, and points into the files above rather than
restating them. If you find one, read it after `CONTRACT.md`, and delete it once
its content has been acted on or moved into its owning file.

## 1. Authority, in order

1. `CONTRACT.md`
2. the ratified RISC-V specifications plus [`spec/`](spec/) — the ISA
3. `../ss/`, `../asm-kernels/` — the software contract and the workloads of the
   previous variant, to be rewritten (maintainer, 2026-11-14): a corpus, not a
   source of requirements for the next variant
4. anything generated from rank 2 — derived; regenerate it, never edit it
5. `../control_unit/control_unit.csv` — the RTL's decoder input; the model's
   decoder started from its decode columns (`CONTRACT.md` §3), and every other
   column **confers no requirements**
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
- Editing `../control_unit/` is RTL-side work: do it only when the maintainer
  asks, and regenerate the RTL's outputs.
- Changing `spec/` is a specification change: ask the maintainer first (§5).

## 4. Variant discipline

The next variant is in flux. Memory is being redesigned around scratchpad + DMA;
barrier logic is expected to change and may move into warp-level registers;
geometry is undecided. Therefore:

- **Every variant-dependent behaviour goes behind a named interface or policy**,
  with a test showing the rest of the model does not depend on it. Its default
  is a choice like any other: propose it, and use it once the maintainer has
  approved it (§5). No "temporarily inline".
- **Geometry is defined in one place.** Warps × threads is read from that one
  place; no other code assumes its value.
- **No uncited encodings.** Every opcode, funct field and CSR number cites the
  RISC-V specification or the `spec/` section it comes from. Until `spec/`
  specifies a custom instruction, any in the code is a placeholder labelled as
  such.
- Do not implement leader selection or TLS speculatively. They may not exist in
  the next variant. Paths *do* exist, but their open rules — the precise
  meaning of lockstep, `bsync` — go behind interfaces until `spec/` defines
  them.

## 5. Ask; do not decide

Only the maintainer decides, and there is no decision log: a choice an agent
makes is a choice the maintainer has to find and audit. When you find something
the contract or `spec/` does not settle, a contradiction between them, or a
disagreement between them and the model's code (`CONTRACT.md`, introduction):

1. **Stop and ask the maintainer**: what is unsettled, the options, what each
   costs and forecloses, and your recommendation if you have one.
2. **Do not implement an answer** in the meantime, not even as a default.
   Unfinished work — code that does not yet implement a settled rule — is the
   only thing that needs no question.
3. **When the maintainer answers, do what was asked and no more.** If the answer
   changes `CONTRACT.md` or `spec/`, show the maintainer the wording before
   writing it. Do not record the answer anywhere else.
4. **Never commit without asking the maintainer.** Approval is per commit.

## 6. Current state of the code

- `model/` is a Rust package, `dolunay`: one library crate, `src/lib.rs`,
  linked against Berkeley SoftFloat through `c/softfloat_shim.c`. Its code:
  - `src/control_unit.rs`: the enum `Instruction`, one variant per CSV row with
    its operands, and `decode`, maintained by hand (`CONTRACT.md` §3).
  - `src/float.rs` and `src/int_utils.rs`: instruction semantics as pure
    functions; `src/softfloat.rs`: the calls into SoftFloat.
  - `src/thread.rs`, `src/warp.rs`, `src/address_space.rs`: a skeleton of one
    warp fetching from a ROM and stepping its active path's threads. The
    address space is passed into `Warp::step`, not owned by the warp.

  The previous designs' code is in git history (the Zig one up to the commit
  that replaced it, the Renode-hosted one under the tag `archive/renode`); do
  not restore it.
- There is no custom instruction yet.
- How to build is in [`README.md`](README.md#building-and-running). The tests
  check that SoftFloat is linked with its RISC-V specialization and keeps its
  state per host thread, the F semantics, the decoder on hand-encoded words, a
  thread's registers and flags, and a short warp run. Say how many tests ran
  and passed; do not claim a run you did not see.

## 7. Building and running — the traps

- Run `cargo test` from `model/`, with at least the Rust version that
  `rust-version` in `model/Cargo.toml` names. It moves only on purpose, with
  the code updated in the same commit.
- SoftFloat is the git submodule `model/berkeley-softfloat-3`. After cloning,
  run `git submodule update --init`; `model/build.rs` stops with that
  instruction when the submodule is missing. Building it needs a C compiler.
- SoftFloat's file list and flags come from its own
  `build/Linux-x86_64-GCC/Makefile`, read by `model/build.rs`; the
  specialization is `RISCV`, not that Makefile's `8086-SSE`. Do not copy the
  list into the repository.
- SoftFloat keeps its rounding mode and flags in globals, built
  `_Thread_local` by `model/build.rs`. `cargo test` runs tests on several host
  threads, which would otherwise see each other's flags;
  `softfloat::tests::state_is_per_host_thread` checks it.
- Rust reaches SoftFloat only through `c/softfloat_shim.c`: Rust cannot name a
  C `_Thread_local` variable, and SoftFloat's `int_fast32_t` is 64 bits wide on
  Linux but 32 on Windows. The shim takes fixed-width integers. To use another
  SoftFloat function, add it to the shim; do not declare SoftFloat's own
  functions in Rust.

## 8. Style

- **Rust**: the edition and `rust-version` in `model/Cargo.toml`.
- **Python 3.12** for generators and tooling. Type hints, standard library
  preferred, no new dependency without a reason in the commit message.
- Comments explain *why*, or cite the spec section they encode. No comment that
  restates the code.
- Every generated file carries its generator and a "do not edit" line.
- Markdown here: one topic per file, a status line at the top of anything that
  is not authoritative, relative links, and no machine-local paths.
- Say *thread*, never *lane*, and *host thread* for an operating-system thread.

## 9. Verification, and honesty about it

- Never claim a build, test, or tool run happened unless you ran it and saw it
  pass. Quote the failing line when it fails.
- If a tool is missing (`CONTRACT.md` §5), say so plainly and leave the code
  reviewable without running it.
- **Do not invent commands or transcripts.** Run the check before claiming a
  tool exists.
- The strongest checks the contract names are the determinacy check
  (`CONTRACT.md` §1, guarantee 3) and replay against the RTL; neither
  exists yet. If your change has no test, say what a test would assert.

## 10. Housekeeping

- Build outputs, caches and working directories go in gitignored directories
  (`golden/.gitignore` is the list), never on a OneDrive or space-containing
  path (`CONTRACT.md` §5).
- Never commit generated binaries, logs, fetched packages, or
  `results.xml`-style artefacts.
- Do not create a second copy of the ISA or of the kernels. If a self-contained
  snapshot is ever needed, generate it and add a drift check.
