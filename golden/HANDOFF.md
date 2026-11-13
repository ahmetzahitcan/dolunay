# Handoff

**Status: where the work stood on 2026-11-13, on branch `renode`, on top of the
commit "golden: start on a redesign".** It is not authoritative. Read it after
[`CONTRACT.md`](CONTRACT.md) and [`DECISIONS.md`](DECISIONS.md), and delete it
once its content has been acted on or moved to its owning file
([`AGENTS.md`](AGENTS.md) §0). It replaces the handoff of 2026-11-08; what that
one said and is still true is carried forward below.

## Where the work stands

- **Design, not code.** The session was a design discussion. It produced
  [`REDESIGN.md`](REDESIGN.md), a draft proposal kept apart from the authoritative
  documents so they stay as they were. Nothing in it is decided; unifying it with
  them is a later step. **Read it before anything else.**
- **Code is unchanged** since the first slice. `dotnet test model` was run on
  2026-11-13: 39 tests, 39 passed, 0 failed, 0 skipped. `Dolunay.Renode` is still
  only the placeholder instruction and is not connected to the core.
- **Spec:** [`spec/EXECUTION-MODEL.md`](spec/EXECUTION-MODEL.md) is still the
  draft of 2026-11-08. The PC rule (below) is not in it yet. No custom
  instruction or CSR has an encoding.

## What the maintainer has said, and what is still open

Stated by the maintainer, so safe to build on once they confirm the wording:

- **Terminology.** *Thread* is Dolunay's unit of state, as in other SIMT
  architectures; *lane* is retired from the golden model. `CONTRACT.md` §6 still
  prefers *lane*, so the existing documents and the code still say *lane*.
- **The PC rule.** For every instruction in a thread's program order, the next PC
  does not depend on the immediate state of any other thread
  ([`REDESIGN.md`](REDESIGN.md) §3 has the checks and a proposed precise wording).
- **Async versus sync is a question of how an instruction is executed**, not of
  three instruction sets. Path IDs, reuse allowed, are a possible naming of
  paths.

Proposed by an assistant, and the maintainer was still weighing it when the
session ended:

- **Run the spec literally first**: one host thread, only the active path runs,
  one step is one instruction on every thread of the path. The asynchronous design
  becomes a deferred optimisation checked against it ([`REDESIGN.md`](REDESIGN.md)
  §4 and §6).
- **The instruction layer** is open between three options: stepped Renode, a custom
  RV32 interpreter, or the interpreter with Renode as a differential oracle
  ([`REDESIGN.md`](REDESIGN.md) §5). Nothing has been measured.

## What comes next

1. **The maintainer reads [`REDESIGN.md`](REDESIGN.md) and decides** §4 and §5, or
   asks for changes. Do not start code before that.
2. **A short, time-capped Renode probe** of the three unknowns in
   [`REDESIGN.md`](REDESIGN.md) §5: the direct step rate of a CPU, the cost of
   resetting machines, and support for Zicond, Zba, Zalrsc and Zihpm. Read
   [`AGENTS.md`](AGENTS.md) §7 first.
3. **Amend the authoritative documents** to match, through the decisions protocol
   ([`AGENTS.md`](AGENTS.md) §5): D3, D5, D8, D11, `CONTRACT.md` §6 and guarantee 2,
   and the PC rule and illegal `bsync` in `spec/`.
4. **Rename *lane* to *thread*** in code and tests, as its own change with nothing
   else in it.
5. **First code on the new seam**, on the stub ISA.

Still open from the previous handoff, and independent of the decision above: write
the first real `spec/` document with the maintainer (`yield`, `wdone`, the warp-id
and thread-id CSRs; `bsync` can have an encoding while its rule stays TBD); the
observation writer (`CONTRACT.md` §4, whose `barrier[<addr>] total parked` line
comes from the previous variant); and exploration (PCT, then partial-order
reduction), which can be built on the stub ISA now.

**Do not design `bsync`'s release rule on your own.** The maintainer is
rethinking it along with the memory redesign. `WholeWarpBarrier` is a
placeholder.

## Known gaps

- **The ISA seam is wrong and will change.** `IInstructionSet.Execute` returns a
  per-thread outcome and `Machine` checks that the kinds agree, but the kind is a
  property of the instruction and the decision is the path's
  ([`REDESIGN.md`](REDESIGN.md) §2). This replaces the seam gap of the previous
  handoff.
- **`WholeWarpBarrier` breaks the PC rule.** It combines at the active path's PC
  and never looks at the blocked paths' PCs, so it accepts a `bsync` on one barrier
  from different instructions, which the rule makes illegal.
- **The conflict check depends on an undecided order.** It treats the threads of
  one instruction as ordered (D14), so it never reports a conflict between them,
  but which order is open (`CONTRACT.md` §2, D16). A kernel whose result depends on
  it passes the check. Found by reading the code, not by a test.
- **Mutex-based kernels can't run yet.** `nearn` and `spmc` use a mutex, and
  whether LR/SC survives is open (`CONTRACT.md` §2). The model has no atomics.
- **The conflict check has no synchronisation between warps.** Every conflict
  between warps is reported, including accesses a mutex would protect. It also
  doesn't flag kernels that read the timing CSRs, whose output D12 says must not
  depend on them. So "no conflicts" isn't yet a full determinacy verdict for
  real kernels.
- **Memory is sequentially consistent only.** D16's argument for why this is
  enough depends on RVWMO with "warp" read as "hart", which is unconfirmed
  (`spec/EXECUTION-MODEL.md` §5.3).
- **`README.md`'s editor setup covers only Zed.** For VS Code's C# extension the
  Renode tree must reach the language server through its
  `dotnet.server.environmentVariables` user setting (`RENODE_BIN`); without it the
  Renode project reports `RENODE_BIN is not set`. Keep the value out of the
  repository (`CONTRACT.md` §5).

## Stale wording to fix

Found earlier and not changed. The first three are wording in authoritative files,
so check with the maintainer:

- **`CONTRACT.md` §1 and D13** list "a path finishing" as a switch point. Under
  the agreed direction only the whole warp finishes, so no path finishes on its
  own.
- **`CONTRACT.md` §2 and §6:** the "Termination condition" row looks answered by
  guarantee 2 and `wdone`, though the draft's §5 still treats finishing as a
  direction, not a decision. The *path* entry still says "merged by the
  reconvergence rule (open)", but D3 says only `bsync` combines paths.
- **`CONTRACT.md` §2** says `spec/` is "not written yet", and so do
  **`AGENTS.md` §0 and `README.md`**. A draft exists now, though nothing in it is
  authoritative.
- **`spec/EXECUTION-MODEL.md` §5.1** still calls whole-warp finishing a
  "direction"; it needs a decision entry before the draft can be approved.

## Things that are easy to get wrong

- **[`REDESIGN.md`](REDESIGN.md) is a proposal.** Don't cite it as a decision, and
  don't edit the authoritative documents to match it without the maintainer.
- **Design before code, in small steps.** The maintainer wants the structure
  discussed in prose and agreed first, then changed in small reviewable pieces, not
  large amounts of code at once.
- **Don't fix `nearn` or `spmc`.** The races are kept on purpose to test the
  check (F4, F5).
- **Don't change anything outside `golden/`.** Record problems in
  [`FINDINGS.md`](FINDINGS.md), including the GCC version note in
  `ENVIRONMENT.md` (F6).
- **Ask before committing, and before any architectural choice.** The
  maintainer gives approval per commit (`AGENTS.md` §5).
- **Toolchain:** the kernels need GCC 15 (F6). `CONTRACT.md` §5 says what the
  work needs. Each machine sets up its own, and those details stay out of the
  repository.
- **Renode runs:** read `AGENTS.md` §7 first, and cap every run.
