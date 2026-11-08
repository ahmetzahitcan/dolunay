// A test-only instruction set: each PC maps to a C# function run per lane. It
// encodes nothing of the real ISA — no opcodes, no encodings — only the outcomes
// the model consumes (golden/AGENTS.md §4).

using System;
using System.Collections.Generic;

using Dolunay.Model;

namespace Dolunay.Model.Tests.Stub
{
    internal sealed class ScriptedIsa : IInstructionSet
    {
        private readonly Dictionary<uint, Func<Lane, LaneOutcome>> _program = new();
        private readonly Dictionary<LaneRef, uint[]> _registers = new();
        private readonly List<(LaneRef Lane, uint Pc)> _trace = new();

        /// <summary>Every lane-instruction executed, in order.</summary>
        public IReadOnlyList<(LaneRef Lane, uint Pc)> Trace => _trace;

        public ScriptedIsa At(uint pc, Func<Lane, LaneOutcome> body)
        {
            _program.Add(pc, body);
            return this;
        }

        public uint[] Registers(LaneRef lane)
        {
            if (!_registers.TryGetValue(lane, out var registers))
                _registers[lane] = registers = new uint[8];
            return registers;
        }

        public LaneOutcome Execute(LaneRef lane, uint pc, IMemoryPort memory)
        {
            if (!_program.TryGetValue(pc, out var body))
                throw new InvalidOperationException($"no instruction at 0x{pc:x}");
            _trace.Add((lane, pc));
            return body(new Lane(lane, pc, memory, Registers(lane)));
        }
    }

    internal sealed class Lane
    {
        public Lane(LaneRef id, uint pc, IMemoryPort memory, uint[] r)
        {
            Id = id;
            Pc = pc;
            Memory = memory;
            R = r;
        }

        public LaneRef Id { get; }

        public uint Pc { get; }

        public IMemoryPort Memory { get; }

        /// <summary>Lane-local registers.</summary>
        public uint[] R { get; }

        public uint Load(uint address) => Memory.Load(address, 4);

        public void Store(uint address, uint value) => Memory.Store(address, 4, value);

        public LaneOutcome Next() => LaneOutcome.Next(Pc + 4);

        public LaneOutcome Goto(uint pc) => LaneOutcome.Next(pc);

        public LaneOutcome Yield(uint resume) => LaneOutcome.Yield(resume);

        public LaneOutcome Yield() => LaneOutcome.Yield(Pc + 4);

        public LaneOutcome Bsync(ulong barrier) => LaneOutcome.Bsync(new BarrierId(barrier), Pc + 4);

        public LaneOutcome Wdone() => LaneOutcome.Wdone();
    }

    /// <summary>Policies only the tests need.</summary>
    internal sealed class LastPolicy : ISchedulePolicy
    {
        public int ChooseWarp(IReadOnlyList<int> ready) => ready.Count - 1;

        public int ChoosePath(int warp, ChoiceKind kind, IReadOnlyList<WarpPath> candidates) => candidates.Count - 1;
    }

    /// <summary>
    /// The alternative barrier rule that proves the engine does not depend on the
    /// default (golden/CONTRACT.md §2): combine with every path blocked on the same
    /// barrier as soon as no path is paused.
    /// </summary>
    internal sealed class CombineWhenNothingPaused : IBarrierRule
    {
        public BarrierDecision Decide(WarpState warp, WarpPath active, BarrierId barrier)
        {
            foreach (var path in warp.Paths)
                if (path.State == PathState.Paused)
                    return BarrierDecision.Block;
            var waiting = new List<WarpPath>();
            foreach (var path in warp.Paths)
                if (path.State == PathState.Blocked && path.Barrier == barrier)
                    waiting.Add(path);
            return BarrierDecision.Combine(waiting, active.Pc);
        }
    }
}
