// golden/spec/EXECUTION-MODEL.md §1–§2: splitting, the active path after a
// split, no implicit merging, and the order within a lockstep instruction.

using System.Collections.Generic;
using System.Linq;

using Dolunay.Model;
using Dolunay.Model.Tests.Stub;

using NUnit.Framework;

namespace Dolunay.Model.Tests
{
    public class PathTests
    {
        private static readonly Geometry OneWarpOfFour = new(1, 4);

        [Test]
        public void AUniformBranchDoesNotSplit()
        {
            var isa = new ScriptedIsa().At(0x00, l => l.Goto(0x20)).At(0x20, l => l.Wdone());
            var machine = new Machine(OneWarpOfFour, isa);
            machine.Step();
            Assert.That(machine.Warps[0].Paths, Has.Count.EqualTo(1));
            Assert.That(machine.Warps[0].Active!.Pc, Is.EqualTo(0x20u));
            Assert.That(machine.Run().Termination, Is.EqualTo(Termination.AllWdone));
        }

        // Lanes 0..3 go to three PCs: {0,3}, {1}, {2}.
        private static ScriptedIsa ThreeWay() => new ScriptedIsa()
            .At(0x00, l => l.Goto(l.Id.Lane switch { 0 or 3 => 0x10u, 1 => 0x20u, _ => 0x30u }))
            .At(0x10, l => l.Goto(0x40))
            .At(0x20, l => l.Goto(0x40))
            .At(0x30, l => l.Goto(0x40))
            .At(0x40, l => l.Bsync(1))
            .At(0x44, l => l.Wdone());

        [TestCase(0)]
        [TestCase(1)]
        [TestCase(2)]
        public void ADivergentBranchSplitsAndActivatesOneOfTheNewPaths(int pick)
        {
            var machine = new Machine(OneWarpOfFour, ThreeWay(), new MachineOptions { Policy = new Pick(pick) });
            machine.Step();
            var warp = machine.Warps[0];
            Assert.Multiple(() =>
            {
                Assert.That(warp.Paths.Select(p => (p.Lanes.ToString(), p.Pc)),
                    Is.EqualTo(new[] { ("0x9", 0x10u), ("0x2", 0x20u), ("0x4", 0x30u) }));
                Assert.That(warp.Active, Is.SameAs(warp.Paths[pick]));
                Assert.That(warp.Paths.Count(p => p.State == PathState.Paused), Is.EqualTo(2));
            });
            Assert.That(machine.Run().Termination, Is.EqualTo(Termination.AllWdone));
        }

        [Test]
        public void TwoPathsAtTheSamePcStaySeparate()
        {
            var isa = new ScriptedIsa()
                .At(0x00, l => l.Goto(l.Id.Lane % 2 == 0 ? 0x10u : 0x20u))
                .At(0x10, l => l.Goto(0x30))
                .At(0x20, l => l.Goto(0x30))
                .At(0x30, l => l.Yield())
                .At(0x34, l => l.Bsync(1))
                .At(0x38, l => l.Wdone());
            var machine = new Machine(OneWarpOfFour, isa);
            for (var i = 0; i < 4; i++)
                machine.Step();
            // split; {0,2} to 0x30; {0,2} yields; {1,3} to 0x30.
            var warp = machine.Warps[0];
            Assert.That(warp.Paths.Select(p => (p.Lanes.ToString(), p.Pc, p.State)),
                Is.EqualTo(new[] { ("0x5", 0x34u, PathState.Paused), ("0xa", 0x30u, PathState.Active) }));
            machine.Step();
            // {1,3} yields too: both paths are now at 0x34, and must stay two paths.
            Assert.That(warp.Paths.Select(p => (p.Lanes.ToString(), p.Pc, p.State)),
                Is.EqualTo(new[] { ("0x5", 0x34u, PathState.Active), ("0xa", 0x34u, PathState.Paused) }),
                "two paths at one PC are never merged implicitly");
            Assert.That(machine.Run().Termination, Is.EqualTo(Termination.AllWdone));
        }

        // golden/spec/EXECUTION-MODEL.md §4.2: lanes {0,2} and {1,3} store to x
        // (lanes 1, 2) and y (lanes 0, 3) as two paths. A merge would give x from
        // lane 2 and y from lane 3, which neither path order produces.
        [Test]
        public void SeparatePathsGiveOnlyThePathOrders()
        {
            const uint X = 0x200, Y = 0x204;
            ScriptedIsa Program() => new ScriptedIsa()
                .At(0x00, l => l.Goto(l.Id.Lane % 2 == 0 ? 0x08u : 0x04u))
                .At(0x04, l => l.Next())
                .At(0x08, l =>
                {
                    l.Store(l.Id.Lane is 1 or 2 ? X : Y, (uint)l.Id.Lane);
                    return l.Next();
                })
                .At(0x0C, l => l.Bsync(1))
                .At(0x10, l => l.Wdone());

            var seen = new HashSet<(uint, uint)>();
            var policies = new List<ISchedulePolicy> { new FirstPolicy(), new LastPolicy() };
            policies.AddRange(Enumerable.Range(0, 20).Select(s => (ISchedulePolicy)new SeededRandomPolicy((ulong)s)));
            foreach (var policy in policies)
            {
                var machine = Programs.Run(OneWarpOfFour, Program(), new MachineOptions { Policy = policy }, out var result);
                Assert.That(result.Termination, Is.EqualTo(Termination.AllWdone));
                seen.Add((machine.Memory.Read(X, 4), machine.Memory.Read(Y, 4)));
            }
            Assert.That(seen, Is.EquivalentTo(new[] { (1u, 3u), (2u, 0u) }));
        }

        [Test]
        public void LanesOfOneInstructionTakeEffectInLockstepOrder()
        {
            const uint X = 0x200;
            ScriptedIsa Program() => new ScriptedIsa()
                .At(0x00, l =>
                {
                    l.Store(X, (uint)l.Id.Lane);
                    return l.Next();
                })
                .At(0x04, l => l.Wdone());

            var ascending = Programs.Run(OneWarpOfFour, Program(), null, out _);
            var descending = Programs.Run(OneWarpOfFour, Program(), new MachineOptions { LockstepOrder = new Descending() }, out _);
            Assert.That(ascending.Memory.Read(X, 4), Is.EqualTo(3u), "the declared default is ascending lane order (D16)");
            Assert.That(descending.Memory.Read(X, 4), Is.EqualTo(0u));
        }

        private sealed class Pick : ISchedulePolicy
        {
            private readonly int _index;

            public Pick(int index) => _index = index;

            public int ChooseWarp(IReadOnlyList<int> ready) => 0;

            public int ChoosePath(int warp, ChoiceKind kind, IReadOnlyList<WarpPath> candidates) =>
                kind == ChoiceKind.AfterSplit ? _index : 0;
        }

        private sealed class Descending : ILockstepOrder
        {
            public IReadOnlyList<int> Order(LaneSet lanes) => lanes.Lanes.Reverse().ToList();
        }
    }
}
