# Reproducibility: what the guarantee is for

**Status: informative analysis, not authoritative.** Written 2026-11-14 from a
discussion with the maintainer, who asked why guarantee 1 of
[`CONTRACT.md`](CONTRACT.md) §1 exists, and doubted that reproducibility alone
delivers what it is meant for. It decides nothing. Where it disagrees with
`CONTRACT.md` or [`DECISIONS.md`](DECISIONS.md), they win until the maintainer says
otherwise. [`REDESIGN.md`](REDESIGN.md) is the companion proposal; the Renode
facts below come from its §5 probe.

## 1. The question

Guarantee 1 says: same program, same initial state, same policy and seed, or the
same replayed schedule, give a byte-identical observation, and nothing observable
may depend on wall-clock time, host-thread scheduling, hash order or file order.

The spec is not deterministic (D12), so this is not a claim about the spec. It is
a claim about the model: that it is a deterministic function of its inputs, and the
schedule is one of the inputs. The maintainer's doubts, which this file takes in
turn: is that *necessary* for the jobs the model has, and is it *sufficient*?

## 2. Four properties that get conflated

| Property | Meaning |
|---|---|
| **Deterministic given choices** | Fix the sequence of choices and the model's run is fixed. Nothing but the choices varies. |
| **Recordable** | Every choice the model makes is written to a log. |
| **Controllable** | A policy can force the choice it wants at every choice point. |
| **Enumerable** | At every choice point the model can say what the alternatives are. |

Guarantee 1 as written is the first, plus "policies are functions of their seed".
The jobs of [`CONTRACT.md`](CONTRACT.md) §1 need different subsets:

| Job | Needs |
|---|---|
| Re-run a failure | Recordable, and deterministic given choices. A seed is a convenience, a log is enough. |
| PCT sampling | Controllable (priorities steer the choices); recordable. |
| Systematic exploration, partial-order reduction | Controllable and enumerable, and deterministic given choices, because exploration re-executes a prefix of choices to reach a state. |
| A determinacy verdict (G1) | Deterministic given choices. Without it, two outputs that differ may differ because of the schedule or because of the model, and the verdict says nothing. |
| RTL replay (G2) | Controllable (feed the RTL's choices) and deterministic given choices. A mismatch must be the RTL's, not the model's noise. |
| Fast mode | None, once the kernel is validated. |
| Unit tests of the model | Deterministic, or the tests are flaky. |

So the maintainer's reading is right. **Reproducibility in the sense of "same seed,
same run" is neither sufficient nor, by itself, the thing needed.** What is needed
is that the model is a function of its choices, and that the choices can be
steered and listed. "Same seed, same run" then follows when policies are functions
of seeds. Deterministic-given-choices is the necessary part: without it the
determinacy verdict and the replay have no meaning. Control and enumeration are
separate requirements that guarantee 1 does not mention.

## 3. Where hidden nondeterminism would come from

Everything not routed through a policy is a hidden choice:

- the readable timing CSRs (`cycle`, `time`, `instret`, HPM counters), which D12
  leaves unconstrained; they must come from a policy, not from the host clock;
- host threads: any model state touched from two host threads in an order the
  host picks;
- hash-set and dictionary iteration order, file enumeration order;
- anything a host framework schedules for us, which is the Renode question below.

A single host thread removes the second item at no cost for a literal engine
([`REDESIGN.md`](REDESIGN.md) §4). It is the asynchronous design of
[`REDESIGN.md`](REDESIGN.md) §6, with CPUs running ahead on host threads, that pays
for the property.

## 4. How much of Renode's scheduler can we control

The question is sharp for [`REDESIGN.md`](REDESIGN.md) §5's option C′, where each
warp is a Renode CPU and Renode calls `ExecuteInstructions` on it. Measured on
2026-11-14, Renode 1.17.0, with a throwaway CPU that executed no real
instructions; one machine, orders of magnitude only.

| Setting | What happened |
|---|---|
| Parallel (the default), two CPUs | The order of calls differed on every run: three runs, three different hashes. |
| Serial (`emulation SetGlobalSerialExecution True`) | The order of calls was identical in three runs, also with partial and zero-instruction returns. |
| Serial, policy-gated, a CPU that is not on turn **returns zero** instructions | No result in five runs; each reached the 60 s cap. Not diagnosed. Probably virtual time does not advance on a zero return. |
| Serial, policy-gated, a CPU that is not on turn **reports its whole quantum as done** and executes nothing | The policy's order was followed in 2000 of 2000 steps, for 2 and 8 warps and two seeds. Wasted-call counts were identical on repeated runs (1024 and 6934). About 40 to 90 ms per 2000 steps. |
| Parallel, policy-gated, under a lock | The order was followed, but this is serial execution by another name, and the order of calls still differed from run to run. |

What follows:

- **We do not control Renode's scheduler.** We control what our CPU does when
  Renode calls it. By doing nothing when it is not a warp's turn, a shared policy
  decides which warp's work happens, and in serial mode the result is
  reproducible. That is *control of who executes*, at the price of wasted calls
  that grow with the number of warps.
- **It does not extend to what Renode schedules itself:** timers, peripherals,
  interrupts, DMA if it becomes a Renode device, and the values of its time
  source. Those are choice points too (D12), and nothing in the probe shows they
  can be steered. The timing CSRs must therefore come from the model's policy and
  never from Renode's time.
- **Not tested:** real shared state, a real model, more than two or eight warps,
  and any Renode behaviour that depends on the instruction count we report
  (burning the quantum reports instructions that did not execute).

So Renode can host a run that is reproducible and, with gating, steerable among
the warps. Whether it should *carry* the guarantees is another matter. Systematic
exploration and replay need the model to own the loop, with no wasted calls and no
other scheduler behind it. That is the headless runner of
[`REDESIGN.md`](REDESIGN.md) §5, and it argues for carrying G1 and G2 there and
treating a Renode-hosted run as one valid execution, good for bring-up and
debugging.

## 5. Options for the wording of the contract

These are options, not recommendations to act on without the maintainer.

1. **Keep guarantee 1 as it is.** It is true of a single-threaded model, and
   costs nothing there. It says nothing about control or enumeration.
2. **Reword it** to what the jobs need: *every source of nondeterminism is a
   choice point; every choice is made by a policy and written to the log; given
   the sequence of choices the model's run is fixed; and policies can be forced to
   any choice the model reports as available.* Seeds then follow. This also gives
   control and enumeration a place in the contract, which today they lack.
3. **Drop it as a guarantee** and keep only what the jobs need, without the
   host-level list (wall clock, hash order). Cheaper to state, but loses the
   engineering rule the list gives.

Option 2 is where this analysis leans, because it states what is checked by the
determinacy test and the replay, and it makes the Renode question a question
about the shell and not about the guarantee.

## 6. Open

- Whether the timing CSRs are choice points the model *serves* from a policy, or
  something else; D12 only says the spec leaves them unconstrained.
- Whether Renode's burn-the-quantum trick survives a real model, and what it does
  to Renode's own accounting of time.
- Whether replay needs the shell at all. If not, Renode's scheduler never touches
  a guarantee.
