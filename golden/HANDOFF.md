# Handoff

**Status: where the work stood on 2026-11-08, on branch `renode`, at the commit
that adds this file.** It is not authoritative. Read it after
[`CONTRACT.md`](CONTRACT.md) and [`DECISIONS.md`](DECISIONS.md), and delete it
once its content has been acted on or moved to its owning file
([`AGENTS.md`](AGENTS.md) §0).

## Where the work stands

- **Spec:** [`spec/EXECUTION-MODEL.md`](spec/EXECUTION-MODEL.md) is a draft. It
  has the warp program order, path states, splits and no implicit merging, with
  provisional RVWMO memory. Its §5 lists the open questions. The words *TBD*,
  *unspecified* and *illegal* are defined in
  [`spec/README.md`](spec/README.md#terminology). No custom instruction or CSR
  has an encoding yet.
- **Model core:** the first slice is in `model/Dolunay.Model`, with the defaults
  in D16. `dotnet test model` last ran 39 tests, and all 39 passed.
- **Only the stub ISA has run on it.** `Dolunay.Model.Tests/Stub/` encodes no
  real instruction. No real kernel has run on the model, so F4 and F5 have been
  caught only as small imitations of `nearn` and `spmc`.
- **Adapter:** `Dolunay.Renode` is untouched and is not connected to the core.
  It still has only the placeholder instruction.

## What comes next

The maintainer has not chosen yet. These were offered on 2026-11-08, with the
first recommended:

1. **Write the first real `spec/` document, with the maintainer.** Start with
   what doesn't depend on memory: `yield`, `wdone`, and the warp-id and
   thread-id CSRs. `bsync` can have an encoding while its rule stays TBD. Any
   change to `spec/` needs a decision first (`AGENTS.md` §5).
2. **The adapter (D11), once those encodings exist.** See the seam problem below.
3. **Observation writer (`CONTRACT.md` §4).** Small, but the format's
   `barrier[<addr>] total parked` line comes from the previous variant and needs
   rethinking.
4. **Exploration (PCT, then partial-order reduction).** This can be built and
   tested on the stub ISA now, and it is what can judge `ping_pong`-style
   kernels.

**Do not design `bsync`'s release rule on your own.** The maintainer is
rethinking it along with the memory redesign, because the old rule relied on the
old memory design. `WholeWarpBarrier` is a placeholder.

## Known gaps

- **The ISA seam will probably change.** `IInstructionSet.Execute` runs one lane
  at a time, in lockstep order. Under D11, lanes run freely and halt at events,
  and the last to arrive lets the model decide. The adapter also has to make a
  lockstep instruction's accesses take effect in the D14 order, even though the
  lanes reach them at different times. Probe this before building on the seam.
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

## Stale wording to fix

Found while finishing this work, and not changed. The first three are wording
in authoritative files, so check with the maintainer:

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
- **Renode runs:** read `AGENTS.md` §7 first.
