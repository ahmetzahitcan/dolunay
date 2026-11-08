// golden/CONTRACT.md §1 guarantee 2, and the barrier knob (D16).

using System.Linq;

using Dolunay.Model;
using Dolunay.Model.Tests.Stub;

using NUnit.Framework;

namespace Dolunay.Model.Tests
{
    public class TerminationTests
    {
        [Test]
        public void EveryWarpFinishing()
        {
            var isa = new ScriptedIsa().At(0x00, l => l.Wdone());
            var result = new Machine(new Geometry(3, 2), isa).Run();
            Assert.That((result.Termination, result.Instructions), Is.EqualTo((Termination.AllWdone, 3L)));
            Assert.That(result.Unfinished, Is.Empty);
        }

        [Test]
        public void TheBudgetRunningOut()
        {
            var isa = new ScriptedIsa().At(0x00, l => l.Goto(0x00));
            var result = new Machine(new Geometry(1, 2), isa, new MachineOptions { InstructionBudget = 100 }).Run();
            Assert.That((result.Termination, result.Instructions), Is.EqualTo((Termination.Timeout, 100L)));
            Assert.That(result.Unfinished.Single().ToString(), Is.EqualTo("warp 0 lanes=0x3 pc=0x0 active"));
        }

        [Test]
        public void TheWholeWarpBarrierCombinesOnceEveryLaneArrived()
        {
            var isa = new ScriptedIsa()
                .At(0x00, l => l.Goto(0x10 * (uint)(l.Id.Lane + 1)))
                .At(0x10, l => l.Bsync(7))
                .At(0x20, l => l.Bsync(7))
                .At(0x30, l => l.Bsync(7))
                .At(0x14, l => l.Wdone())
                .At(0x24, l => l.Wdone())
                .At(0x34, l => l.Wdone());
            var machine = new Machine(new Geometry(1, 3), isa);
            for (var i = 0; i < 4; i++)
                machine.Step();
            // The last lane to arrive releases the barrier; the combined path
            // continues after its bsync.
            var path = machine.Warps[0].Paths.Single();
            Assert.That((path.Lanes.ToString(), path.Pc, path.State), Is.EqualTo(("0x7", 0x34u, PathState.Active)));
            Assert.That(machine.Run().Termination, Is.EqualTo(Termination.AllWdone));
        }

        // Two paths that should meet use different barriers: each blocks, the warp
        // has no active path, and the run reports deadlock with the stuck lanes
        // (golden/spec/EXECUTION-MODEL.md §4.3).
        [Test]
        public void MisusedBarriersAreReportedAsDeadlock()
        {
            var isa = new ScriptedIsa()
                .At(0x00, l => l.Goto(l.Id.Lane == 0 ? 0x10u : 0x20u))
                .At(0x10, l => l.Bsync(1))
                .At(0x20, l => l.Bsync(2));
            var result = new Machine(new Geometry(1, 2), isa).Run();
            Assert.That(result.Termination, Is.EqualTo(Termination.Deadlock));
            Assert.That(result.Unfinished.Select(p => p.ToString()), Is.EqualTo(new[]
            {
                "warp 0 lanes=0x1 pc=0x14 blocked barrier=0x1",
                "warp 0 lanes=0x2 pc=0x24 blocked barrier=0x2",
            }));
        }

        [Test]
        public void AStuckWarpDoesNotStopTheOthers()
        {
            var isa = new ScriptedIsa()
                .At(0x00, l => l.Id.Warp == 0 ? l.Goto(l.Id.Lane == 0 ? 0x10u : 0x20u) : l.Goto(0x30))
                .At(0x10, l => l.Bsync(1))
                .At(0x20, l => l.Bsync(2))
                .At(0x30, l => l.Wdone());
            var result = new Machine(new Geometry(2, 2), isa).Run();
            Assert.That(result.Termination, Is.EqualTo(Termination.Deadlock));
            Assert.That(result.Unfinished.Select(p => p.Warp).Distinct(), Is.EqualTo(new[] { 0 }));
        }

        [Test]
        public void WdoneFromAPartialPathIsIllegal()
        {
            var isa = new ScriptedIsa()
                .At(0x00, l => l.Goto(l.Id.Lane == 0 ? 0x10u : 0x20u))
                .At(0x10, l => l.Wdone())
                .At(0x20, l => l.Wdone());
            var result = new Machine(new Geometry(1, 2), isa).Run();
            Assert.That(result.Termination, Is.EqualTo(Termination.Illegal));
            Assert.That(result.Illegal!.ToString(), Is.EqualTo("warp 0 lanes=0x1 pc=0x10: wdone from a path that does not hold every lane of the warp"));
            Assert.That(result.Instructions, Is.EqualTo(1), "the illegal instruction is not counted");
        }

        [Test]
        public void OnePathNamingTwoBarriersIsIllegal()
        {
            var isa = new ScriptedIsa().At(0x00, l => l.Bsync((ulong)l.Id.Lane));
            var result = new Machine(new Geometry(1, 2), isa).Run();
            Assert.That(result.Termination, Is.EqualTo(Termination.Illegal));
            Assert.That(result.Illegal!.Reason, Does.Contain("different barriers"));
        }

        [Test]
        public void TheEngineDoesNotDependOnTheBarrierRule()
        {
            // The alternative rule combines whatever is blocked as soon as nothing
            // is paused; YieldTests runs ping_pong under both rules as well.
            var isa = new ScriptedIsa()
                .At(0x00, l => l.Goto(0x10 * (uint)(l.Id.Lane + 1)))
                .At(0x10, l => l.Bsync(7))
                .At(0x20, l => l.Bsync(7))
                .At(0x14, l => l.Wdone())
                .At(0x24, l => l.Wdone());
            foreach (var rule in new IBarrierRule[] { new WholeWarpBarrier(), new CombineWhenNothingPaused() })
                Assert.That(new Machine(new Geometry(2, 2), isa, new MachineOptions { Barrier = rule }).Run().Termination,
                    Is.EqualTo(Termination.AllWdone), rule.GetType().Name);
        }
    }
}
