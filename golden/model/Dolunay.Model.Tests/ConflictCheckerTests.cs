// golden/CONTRACT.md §1, method 1: one execution and a conflict check. The
// racy kernels F4 (nearn) and F5 (spmc) are kept on purpose so the check can be
// shown to catch them; these are their shapes on the stub ISA.

using System.Linq;

using Dolunay.Model;
using Dolunay.Model.Tests.Stub;

using NUnit.Framework;

namespace Dolunay.Model.Tests
{
    public class ConflictCheckerTests
    {
        private static ConflictChecker Check(Geometry geometry, ScriptedIsa isa, ISchedulePolicy? policy = null,
            Termination expected = Termination.AllWdone)
        {
            var checker = new ConflictChecker(geometry);
            var options = new MachineOptions { Observer = checker, Policy = policy ?? new FirstPolicy(), InstructionBudget = 10_000 };
            Assert.That(new Machine(geometry, isa, options).Run().Termination, Is.EqualTo(expected));
            return checker;
        }

        [Test]
        public void DisjointStoresDoNotConflict()
        {
            var isa = new ScriptedIsa()
                .At(0x00, l =>
                {
                    l.Store(0x100 + 4 * (uint)(l.Id.Warp * 4 + l.Id.Lane), 1);
                    return l.Next();
                })
                .At(0x04, l => l.Wdone());
            Assert.That(Check(new Geometry(2, 4), isa).Conflicts, Is.Empty);
        }

        [Test]
        public void LanesOfOneInstructionDoNotConflict()
        {
            // Their order is fixed by the spec (D14), not chosen.
            var isa = new ScriptedIsa()
                .At(0x00, l =>
                {
                    l.Store(0x100, (uint)l.Id.Lane);
                    return l.Next();
                })
                .At(0x04, l =>
                {
                    l.Load(0x100);
                    return l.Next();
                })
                .At(0x08, l => l.Wdone());
            Assert.That(Check(new Geometry(1, 4), isa).Conflicts, Is.Empty);
        }

        // Lane 0 writes on its own path, both paths meet at a bsync, then lane 1
        // reads: the combine orders them.
        [Test]
        public void ABarrierOrdersAccessesOfDifferentPaths()
        {
            var isa = new ScriptedIsa()
                .At(0x00, l => l.Goto(l.Id.Lane == 0 ? 0x10u : 0x20u))
                .At(0x10, l =>
                {
                    l.Store(0x100, 7);
                    return l.Goto(0x20);
                })
                .At(0x20, l => l.Bsync(1))
                .At(0x24, l =>
                {
                    l.R[1] = l.Load(0x100);
                    return l.Next();
                })
                .At(0x28, l => l.Wdone());
            foreach (var policy in new ISchedulePolicy[] { new FirstPolicy(), new LastPolicy() })
                Assert.That(Check(new Geometry(1, 2), isa, policy).Conflicts, Is.Empty);
        }

        [Test]
        public void TheSameAccessesWithoutTheBarrierConflict()
        {
            var isa = new ScriptedIsa()
                .At(0x00, l => l.Goto(l.Id.Lane == 0 ? 0x10u : 0x20u))
                .At(0x10, l =>
                {
                    l.Store(0x100, 7);
                    return l.Goto(0x30);
                })
                .At(0x20, l =>
                {
                    l.R[1] = l.Load(0x100);
                    return l.Goto(0x30);
                })
                .At(0x30, l => l.Bsync(1))
                .At(0x34, l => l.Wdone());
            var conflicts = Check(new Geometry(1, 2), isa).Conflicts;
            Assert.That(conflicts.Select(c => c.ToString()), Is.EqualTo(new[]
            {
                "0x100: store by lane 0.0 at pc=0x10, then load by lane 0.1 at pc=0x20",
            }));
        }

        // F4, ss/kernels/nearn.c:22: every lane stores the "no result yet" value,
        // unsynchronised, while another warp may already have stored its result.
        [Test]
        public void CatchesTheNearnRace()
        {
            const uint resultDist = 0x200;
            var isa = new ScriptedIsa()
                .At(0x00, l =>
                {
                    l.Store(resultDist, 0xFFFFFFFF);
                    return l.Goto(l.Id.Warp == 0 && l.Id.Lane == 0 ? 0x10u : 0x20u);
                })
                .At(0x10, l =>
                {
                    l.Store(resultDist, 5);
                    return l.Goto(0x20);
                })
                .At(0x20, l => l.Bsync(1))
                .At(0x24, l => l.Wdone());
            var conflicts = Check(new Geometry(2, 2), isa).Conflicts;
            Assert.That(conflicts.Any(c =>
                c.Earlier.Pc == 0x10 && c.Earlier.Lane == new LaneRef(0, 0) &&
                c.Later.Pc == 0x00 && c.Later.Lane.Warp == 1), Is.True, string.Join("\n", conflicts));
        }

        // F5, ss/kernels/spmc.c:51: every lane resets data_idx, unsynchronised,
        // while the producer on warp 0 may already have advanced it.
        [Test]
        public void CatchesTheSpmcRace()
        {
            const uint dataIdx = 0x300;
            var isa = new ScriptedIsa()
                .At(0x00, l =>
                {
                    l.Store(dataIdx, 0xFFFFFFFF);
                    return l.Goto(l.Id.Warp == 0 && l.Id.Lane == 0 ? 0x10u : 0x20u);
                })
                // producer
                .At(0x10, l =>
                {
                    l.Store(dataIdx, 0);
                    return l.Goto(0x30);
                })
                // consumers: wait until the producer has published
                .At(0x20, l => l.Load(dataIdx) == 0 ? l.Goto(0x30) : l.Next())
                .At(0x24, l => l.Yield(0x20))
                .At(0x30, l => l.Bsync(1))
                .At(0x34, l => l.Wdone());
            // Under FirstPolicy warp 0 finishes before warp 1 starts, so warp 1's reset
            // overwrites the published value and its consumers spin until the
            // budget runs out — F5's livelock. The check names the cause.
            var conflicts = Check(new Geometry(2, 2), isa, expected: Termination.Timeout).Conflicts;
            Assert.That(conflicts.Any(c =>
                c.Address == dataIdx && c.Earlier.Lane == new LaneRef(0, 0) && c.Earlier.Pc == 0x10 &&
                c.Later.Lane.Warp == 1 && c.Later.Pc == 0x00), Is.True, string.Join("\n", conflicts));
        }

        // ping_pong's flag handoff is a conflict by design: method 1 cannot clear
        // it, and the kernel goes on to systematic exploration (method 2).
        [Test]
        public void ReportsPingPongsHandoffForExploration()
        {
            var conflicts = Check(new Geometry(1, 2), Programs.PingPong(3)).Conflicts;
            Assert.That(conflicts, Is.Not.Empty);
            Assert.That(conflicts.All(c => c.Address == Programs.CounterOf(0)), Is.True);
            Assert.That(conflicts.All(c => c.Earlier.Lane.Lane != c.Later.Lane.Lane), Is.True);
        }

        [Test]
        public void ReportsConflictsInADeterministicOrder()
        {
            string Run() => string.Join("\n", Check(new Geometry(1, 2), Programs.PingPong(3), new SeededRandomPolicy(3)).Conflicts);
            var first = Run();
            Assert.That(Run(), Is.EqualTo(first));
        }
    }
}
