// The seam between the model and whatever executes instructions: the Renode
// adapter, or a scripted stub in the tests. The model decides what an
// instruction does to the path state (golden/spec/EXECUTION-MODEL.md §2); the
// instruction set only reports, per lane, where that lane goes next.

using System;
using System.Collections.Generic;
using System.Linq;

namespace Dolunay.Model
{
    /// <summary>One lane of the machine.</summary>
    public readonly record struct LaneRef(int Warp, int Lane)
    {
        public override string ToString() => $"{Warp}.{Lane}";
    }

    /// <summary>
    /// What identifies a barrier. What it is in the ISA (an address, a register
    /// name) is open (golden/CONTRACT.md §2), so the model treats it as opaque.
    /// </summary>
    public readonly record struct BarrierId(ulong Value)
    {
        public override string ToString() => $"0x{Value:x}";
    }

    public enum OutcomeKind
    {
        /// <summary>An ordinary instruction, branch or jump: the lane goes to <see cref="LaneOutcome.NextPc"/>.</summary>
        Next,
        Yield,
        Bsync,
        Wdone,
    }

    /// <summary>What one lane did when it executed one instruction.</summary>
    public readonly record struct LaneOutcome(OutcomeKind Kind, uint NextPc, BarrierId Barrier)
    {
        public static LaneOutcome Next(uint nextPc) => new(OutcomeKind.Next, nextPc, default);

        public static LaneOutcome Yield(uint nextPc) => new(OutcomeKind.Yield, nextPc, default);

        public static LaneOutcome Bsync(BarrierId barrier, uint nextPc) => new(OutcomeKind.Bsync, nextPc, barrier);

        public static LaneOutcome Wdone() => new(OutcomeKind.Wdone, 0, default);
    }

    /// <summary>Executes one instruction for one lane.</summary>
    public interface IInstructionSet
    {
        /// <summary>
        /// Execute the instruction at <paramref name="pc"/> for <paramref name="lane"/>.
        /// Shared memory is reached only through <paramref name="memory"/>, which
        /// the model owns (D11). Every lane of a path executes the same
        /// instruction, so every lane must report the same kind of outcome.
        /// </summary>
        LaneOutcome Execute(LaneRef lane, uint pc, IMemoryPort memory);
    }

    /// <summary>
    /// The order in which the lanes of one lockstep instruction take effect. The
    /// spec fixes one (D14); which one is open (golden/CONTRACT.md §2).
    /// </summary>
    public interface ILockstepOrder
    {
        IReadOnlyList<int> Order(LaneSet lanes);
    }

    /// <summary>Declared default: ascending lane index (D16).</summary>
    public sealed class AscendingLaneOrder : ILockstepOrder
    {
        public static AscendingLaneOrder Instance { get; } = new();

        private AscendingLaneOrder()
        {
        }

        public IReadOnlyList<int> Order(LaneSet lanes) => lanes.Lanes.ToList();
    }

    /// <summary>Thrown when an instruction set or a pluggable rule breaks the model's interface.</summary>
    public sealed class ModelInterfaceException : InvalidOperationException
    {
        public ModelInterfaceException(string message)
            : base(message)
        {
        }
    }
}
