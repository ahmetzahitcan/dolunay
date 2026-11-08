// Shared memory, owned by the model (D11). What the scratchpad, DMA and global
// memory look like is being redesigned, so this is one flat byte store.
//
// Declared default (D16): accesses take effect in the order the model executes
// them, which is sequentially consistent. That is one valid execution under the
// provisional RVWMO-with-warps model (golden/spec/EXECUTION-MODEL.md §3); the
// model does not explore weaker ones. A kernel the conflict check passes has no
// unordered conflicting accesses, and such a kernel gets sequentially consistent
// results under RVWMO anyway.

using System;
using System.Collections.Generic;
using System.Linq;

namespace Dolunay.Model
{
    public enum AccessKind
    {
        Load,
        Store,
    }

    /// <summary>One lane's access to shared memory.</summary>
    public readonly record struct MemoryAccess(LaneRef Lane, uint Pc, AccessKind Kind, uint Address, int Size);

    /// <summary>One lane's view of shared memory while it executes one instruction.</summary>
    public interface IMemoryPort
    {
        uint Load(uint address, int size);

        void Store(uint address, int size, uint value);
    }

    /// <summary>A sparse, little-endian byte store. Bytes never written read as zero.</summary>
    public sealed class SharedMemory
    {
        private readonly Dictionary<uint, byte> _bytes = new();

        public uint Read(uint address, int size)
        {
            CheckSize(size);
            uint value = 0;
            for (var i = 0; i < size; i++)
                if (_bytes.TryGetValue(unchecked(address + (uint)i), out var b))
                    value |= (uint)b << (8 * i);
            return value;
        }

        public void Write(uint address, int size, uint value)
        {
            CheckSize(size);
            for (var i = 0; i < size; i++)
                _bytes[unchecked(address + (uint)i)] = (byte)(value >> (8 * i));
        }

        /// <summary>Every byte ever written, in ascending address order.</summary>
        public IReadOnlyList<KeyValuePair<uint, byte>> Contents() =>
            _bytes.OrderBy(entry => entry.Key).ToList();

        private static void CheckSize(int size)
        {
            if (size is not (1 or 2 or 4))
                throw new ArgumentOutOfRangeException(nameof(size), size, "an access is 1, 2 or 4 bytes");
        }
    }

    /// <summary>
    /// Sees what the model executes, for analyses such as the conflict check.
    /// Never changes the execution.
    /// </summary>
    public interface IExecutionObserver
    {
        /// <summary>The lanes of one path are about to execute one lockstep instruction.</summary>
        void OnInstruction(int warp, LaneSet lanes);

        void OnAccess(in MemoryAccess access);

        /// <summary>A <c>bsync</c> combined these lanes into one path.</summary>
        void OnCombine(int warp, LaneSet lanes);
    }

    internal sealed class LanePort : IMemoryPort
    {
        private readonly SharedMemory _memory;
        private readonly IExecutionObserver? _observer;
        private readonly LaneRef _lane;
        private readonly uint _pc;

        public LanePort(SharedMemory memory, IExecutionObserver? observer, LaneRef lane, uint pc)
        {
            _memory = memory;
            _observer = observer;
            _lane = lane;
            _pc = pc;
        }

        public uint Load(uint address, int size)
        {
            _observer?.OnAccess(new MemoryAccess(_lane, _pc, AccessKind.Load, address, size));
            return _memory.Read(address, size);
        }

        public void Store(uint address, int size, uint value)
        {
            _observer?.OnAccess(new MemoryAccess(_lane, _pc, AccessKind.Store, address, size));
            _memory.Write(address, size, value);
        }
    }
}
