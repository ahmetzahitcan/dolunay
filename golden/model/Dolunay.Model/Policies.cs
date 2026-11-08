// Policies resolve choice points (golden/CONTRACT.md §1, D12). A policy is not
// machine state. Candidates always arrive sorted (warps by index, paths by
// lowest lane), so a policy and a seed fix the execution (guarantee 1). A choice
// with a single candidate is not a choice and never reaches the policy.

using System;
using System.Collections.Generic;
using System.Linq;

namespace Dolunay.Model
{
    public enum ChoiceKind
    {
        /// <summary>Which warp executes the next instruction.</summary>
        Warp,

        /// <summary>Which of the paths a divergent instruction created becomes active (D13).</summary>
        AfterSplit,

        /// <summary>Which paused path receives control from a <c>yield</c>.</summary>
        AfterYield,

        /// <summary>Which paused path receives control from a path that blocked in <c>bsync</c>.</summary>
        AfterBlock,
    }

    public interface ISchedulePolicy
    {
        /// <returns>An index into <paramref name="ready"/>.</returns>
        int ChooseWarp(IReadOnlyList<int> ready);

        /// <returns>An index into <paramref name="candidates"/>.</returns>
        int ChoosePath(int warp, ChoiceKind kind, IReadOnlyList<WarpPath> candidates);
    }

    /// <summary>Always the first candidate. The default.</summary>
    public sealed class FirstPolicy : ISchedulePolicy
    {
        public int ChooseWarp(IReadOnlyList<int> ready) => 0;

        public int ChoosePath(int warp, ChoiceKind kind, IReadOnlyList<WarpPath> candidates) => 0;
    }

    /// <summary>
    /// Uniformly random choices from a seed. Uses SplitMix64 rather than
    /// <see cref="Random"/>, whose algorithm .NET does not promise to keep, so a
    /// seed means the same execution on every runtime (D16).
    /// </summary>
    public sealed class SeededRandomPolicy : ISchedulePolicy
    {
        private ulong _state;

        public SeededRandomPolicy(ulong seed)
        {
            Seed = seed;
            _state = seed;
        }

        public ulong Seed { get; }

        public int ChooseWarp(IReadOnlyList<int> ready) => Next(ready.Count);

        public int ChoosePath(int warp, ChoiceKind kind, IReadOnlyList<WarpPath> candidates) => Next(candidates.Count);

        private int Next(int count)
        {
            // SplitMix64 (Steele, Lea, Flood, "Fast splittable pseudorandom number
            // generators", OOPSLA 2014).
            var z = _state += 0x9E3779B97F4A7C15UL;
            z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9UL;
            z = (z ^ (z >> 27)) * 0x94D049BB133111EBUL;
            z ^= z >> 31;
            return (int)(z % (ulong)count);
        }
    }

    /// <summary>
    /// One resolved choice, in the spec's terms (D15): a warp, or a path as warp,
    /// lane mask and PC.
    /// </summary>
    public sealed record Choice(ChoiceKind Kind, int Warp, LaneSet? Lanes = null, uint Pc = 0)
    {
        public override string ToString() =>
            Kind == ChoiceKind.Warp
                ? $"warp {Warp}"
                : $"{Kind} warp {Warp} lanes={Lanes} pc=0x{Pc:x}";
    }

    /// <summary>Delegates to another policy and records every choice it makes.</summary>
    public sealed class RecordingPolicy : ISchedulePolicy
    {
        private readonly ISchedulePolicy _inner;
        private readonly List<Choice> _schedule = new();

        public RecordingPolicy(ISchedulePolicy inner)
        {
            _inner = inner ?? throw new ArgumentNullException(nameof(inner));
        }

        public IReadOnlyList<Choice> Schedule => _schedule;

        public int ChooseWarp(IReadOnlyList<int> ready)
        {
            var index = _inner.ChooseWarp(ready);
            _schedule.Add(new Choice(ChoiceKind.Warp, ready[index]));
            return index;
        }

        public int ChoosePath(int warp, ChoiceKind kind, IReadOnlyList<WarpPath> candidates)
        {
            var index = _inner.ChoosePath(warp, kind, candidates);
            _schedule.Add(new Choice(kind, warp, candidates[index].Lanes, candidates[index].Pc));
            return index;
        }
    }

    /// <summary>
    /// Replays a recorded schedule, and stops at the first choice it cannot make:
    /// a warp or path that is not a candidate in the model's own state (D15).
    /// </summary>
    public sealed class ReplayPolicy : ISchedulePolicy
    {
        private readonly IReadOnlyList<Choice> _schedule;

        public ReplayPolicy(IReadOnlyList<Choice> schedule)
        {
            _schedule = schedule ?? throw new ArgumentNullException(nameof(schedule));
        }

        public int Position { get; private set; }

        public bool Exhausted => Position == _schedule.Count;

        public int ChooseWarp(IReadOnlyList<int> ready)
        {
            var offered = ready.Select(w => $"warp {w}").ToList();
            var choice = Peek(ChoiceKind.Warp, -1, offered);
            var index = ready.ToList().IndexOf(choice.Warp);
            if (index < 0)
                throw Mismatch(choice, offered);
            Position++;
            return index;
        }

        public int ChoosePath(int warp, ChoiceKind kind, IReadOnlyList<WarpPath> candidates)
        {
            var offered = candidates.Select(p => new Choice(kind, warp, p.Lanes, p.Pc).ToString()).ToList();
            var choice = Peek(kind, warp, offered);
            for (var i = 0; i < candidates.Count; i++)
            {
                if (candidates[i].Lanes.Equals(choice.Lanes) && candidates[i].Pc == choice.Pc)
                {
                    Position++;
                    return i;
                }
            }
            throw Mismatch(choice, offered);
        }

        private Choice Peek(ChoiceKind kind, int warp, IEnumerable<string> offered)
        {
            if (Exhausted)
                throw new ReplayMismatchException(Position, null, $"the schedule ended, but a {kind} choice was needed among: {string.Join("; ", offered)}");
            var choice = _schedule[Position];
            if (choice.Kind != kind || (warp >= 0 && choice.Warp != warp))
                throw Mismatch(choice, offered);
            return choice;
        }

        private ReplayMismatchException Mismatch(Choice expected, IEnumerable<string> offered) =>
            new(Position, expected, $"choice {Position} is \"{expected}\", but the candidates are: {string.Join("; ", offered)}");
    }

    /// <summary>The replayed execution and the model's own state disagree.</summary>
    public sealed class ReplayMismatchException : Exception
    {
        public ReplayMismatchException(int position, Choice? expected, string message)
            : base(message)
        {
            Position = position;
            Expected = expected;
        }

        public int Position { get; }

        public Choice? Expected { get; }
    }
}
