// D13: cooperative switching and the yield guarantee, stated over lanes.

using System.Collections.Generic;
using System.Linq;

using Dolunay.Model;
using Dolunay.Model.Tests.Stub;

using NUnit.Framework;

namespace Dolunay.Model.Tests
{
    public class YieldTests
    {
        private static IEnumerable<ISchedulePolicy> Policies()
        {
            yield return new FirstPolicy();
            yield return new LastPolicy();
            for (ulong seed = 0; seed < 200; seed++)
                yield return new SeededRandomPolicy(seed);
        }

        private static IEnumerable<IBarrierRule> Rules()
        {
            yield return new WholeWarpBarrier();
            yield return new CombineWhenNothingPaused();
        }

        [Test]
        public void YieldWithNoPausedPathDoesNothing()
        {
            var isa = new ScriptedIsa().At(0x00, l => l.Yield()).At(0x04, l => l.Wdone());
            var machine = new Machine(new Geometry(1, 4), isa);
            machine.Step();
            var path = machine.Warps[0].Paths.Single();
            Assert.That((path.State, path.Pc), Is.EqualTo((PathState.Active, 0x04u)));
        }

        // ss/kernels/ping_pong hands off through yield and must complete under
        // every valid execution (golden/CONTRACT.md §1, guarantee 2).
        [Test]
        public void PingPongCompletesUnderEveryPolicyAndBarrierRule()
        {
            const int rounds = 5;
            foreach (var rule in Rules())
            {
                foreach (var policy in Policies())
                {
                    var options = new MachineOptions { Policy = policy, Barrier = rule, InstructionBudget = 10_000 };
                    var machine = Programs.Run(new Geometry(2, 2), Programs.PingPong(rounds), options, out var result);
                    Assert.That(result.Termination, Is.EqualTo(Termination.AllWdone), $"{rule.GetType().Name}, {policy.GetType().Name}");
                    Assert.That(machine.Memory.Read(Programs.CounterOf(0), 4), Is.EqualTo((uint)(2 * rounds)));
                    Assert.That(machine.Memory.Read(Programs.CounterOf(1), 4), Is.EqualTo((uint)(2 * rounds)));
                }
            }
        }

        // Before a yielding lane executes its next instruction, every other lane of
        // its warp that can execute — not waiting at a barrier — executes at least
        // one instruction.
        [Test]
        public void EveryOtherLaneRunsBeforeTheYielderRunsAgain()
        {
            const int lanes = 4, spins = 6;
            const uint bsync = 0x40;
            foreach (var policy in Policies())
            {
                var isa = Programs.YieldSpin(lanes, spins);
                Programs.Run(new Geometry(1, lanes), isa, new MachineOptions { Policy = policy }, out var result);
                Assert.That(result.Termination, Is.EqualTo(Termination.AllWdone));

                var trace = isa.Trace;
                for (var t = 0; t < trace.Count; t++)
                {
                    var (yielder, pc) = trace[t];
                    if (pc != 0x100 * (uint)(yielder.Lane + 1) + 4)
                        continue;
                    var next = Enumerable.Range(t + 1, trace.Count - t - 1).First(i => trace[i].Lane == yielder);
                    for (var other = 0; other < lanes; other++)
                    {
                        if (other == yielder.Lane)
                            continue;
                        var last = Enumerable.Range(0, t).LastOrDefault(i => trace[i].Lane.Lane == other, -1);
                        var blocked = last >= 0 && trace[last].Pc == bsync;
                        var ran = Enumerable.Range(t + 1, next - t - 1).Any(i => trace[i].Lane.Lane == other);
                        Assert.That(blocked || ran, Is.True, $"lane {other} did not run between lane {yielder.Lane}'s yield at step {t} and its next instruction");
                    }
                }
            }
        }
    }
}
