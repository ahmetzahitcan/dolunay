// golden/CONTRACT.md §1 guarantee 1, and replay (D15) of the model's own
// schedules. The RTL's replay-log format is not drafted yet.

using System.Collections.Generic;
using System.Linq;

using Dolunay.Model;
using Dolunay.Model.Tests.Stub;

using NUnit.Framework;

namespace Dolunay.Model.Tests
{
    public class ReproducibilityTests
    {
        private static readonly Geometry TwoWarps = new(2, 2);

        private static (string Outcome, IReadOnlyList<Choice> Schedule) Recorded(ISchedulePolicy policy)
        {
            var recording = new RecordingPolicy(policy);
            var machine = Programs.Run(TwoWarps, Programs.PingPong(4), new MachineOptions { Policy = recording }, out var result);
            return (Describe(machine, result), recording.Schedule);
        }

        private static string Describe(Machine machine, RunResult result) =>
            result + string.Join("\n", machine.Memory.Contents().Select(b => $"0x{b.Key:x}={b.Value:x2}"));

        [Test]
        public void TheSameSeedGivesTheSameExecution()
        {
            var first = Recorded(new SeededRandomPolicy(42));
            var second = Recorded(new SeededRandomPolicy(42));
            Assert.That(second.Outcome, Is.EqualTo(first.Outcome));
            Assert.That(second.Schedule, Is.EqualTo(first.Schedule));
            Assert.That(first.Schedule.Count(c => c.Kind == ChoiceKind.Warp), Is.GreaterThan(0));
        }

        [Test]
        public void DifferentSeedsGiveDifferentSchedules()
        {
            var schedules = Enumerable.Range(0, 10).Select(s => string.Join(";", Recorded(new SeededRandomPolicy((ulong)s)).Schedule)).Distinct();
            Assert.That(schedules.Count(), Is.GreaterThan(1));
        }

        [Test]
        public void ARecordedScheduleReplaysToTheSameExecution()
        {
            var original = Recorded(new SeededRandomPolicy(7));
            var replay = new ReplayPolicy(original.Schedule);
            var replayed = Recorded(replay);
            Assert.That(replayed.Outcome, Is.EqualTo(original.Outcome));
            Assert.That(replay.Exhausted, Is.True);
        }

        [Test]
        public void ReplayStopsAtTheFirstChoiceItCannotMake()
        {
            var original = Recorded(new SeededRandomPolicy(7)).Schedule.ToList();
            var index = original.FindIndex(c => c.Kind == ChoiceKind.AfterSplit);
            Assume.That(index, Is.GreaterThanOrEqualTo(0));
            original[index] = original[index] with { Pc = 0xdead };

            var replay = new ReplayPolicy(original);
            var error = Assert.Throws<ReplayMismatchException>(() => Recorded(replay));
            Assert.That(error!.Position, Is.EqualTo(index));
        }
    }
}
