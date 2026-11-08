// A set of lanes of one warp. Its width is the warp's lane count, read from
// Geometry, so there is no limit on it (golden/AGENTS.md §4).

using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;

namespace Dolunay.Model
{
    /// <summary>An immutable set of lane indices within one warp.</summary>
    public sealed class LaneSet : IEquatable<LaneSet>
    {
        private readonly ulong[] _bits;

        private LaneSet(int width, ulong[] bits)
        {
            Width = width;
            _bits = bits;
        }

        /// <summary>The number of lanes in the warp, not in the set.</summary>
        public int Width { get; }

        public static LaneSet Empty(int width)
        {
            if (width < 1)
                throw new ArgumentOutOfRangeException(nameof(width), width, "a warp has at least one lane");
            return new LaneSet(width, new ulong[(width + 63) / 64]);
        }

        public static LaneSet All(int width) => Of(width, Enumerable.Range(0, width));

        public static LaneSet Of(int width, params int[] lanes) => Of(width, (IEnumerable<int>)lanes);

        public static LaneSet Of(int width, IEnumerable<int> lanes)
        {
            var set = Empty(width);
            foreach (var lane in lanes)
            {
                if (lane < 0 || lane >= width)
                    throw new ArgumentOutOfRangeException(nameof(lanes), lane, $"lane outside a warp of {width}");
                set._bits[lane / 64] |= 1UL << (lane % 64);
            }
            return set;
        }

        public bool Contains(int lane) =>
            lane >= 0 && lane < Width && (_bits[lane / 64] & (1UL << (lane % 64))) != 0;

        public int Count => _bits.Sum(word => BitOperations.PopCount(word));

        public bool IsEmpty => _bits.All(word => word == 0);

        /// <summary>The lowest lane in the set; paths are ordered by it.</summary>
        public int Lowest
        {
            get
            {
                for (var i = 0; i < _bits.Length; i++)
                    if (_bits[i] != 0)
                        return i * 64 + BitOperations.TrailingZeroCount(_bits[i]);
                throw new InvalidOperationException("an empty lane set has no lowest lane");
            }
        }

        /// <summary>The lanes, in ascending order.</summary>
        public IEnumerable<int> Lanes
        {
            get
            {
                for (var lane = 0; lane < Width; lane++)
                    if (Contains(lane))
                        yield return lane;
            }
        }

        public LaneSet Union(LaneSet other) => Combine(other, (a, b) => a | b);

        public LaneSet Intersect(LaneSet other) => Combine(other, (a, b) => a & b);

        public LaneSet Except(LaneSet other) => Combine(other, (a, b) => a & ~b);

        public bool Overlaps(LaneSet other) => !Intersect(other).IsEmpty;

        public bool IsSubsetOf(LaneSet other) => Except(other).IsEmpty;

        private LaneSet Combine(LaneSet other, Func<ulong, ulong, ulong> op)
        {
            if (other.Width != Width)
                throw new ArgumentException($"lane sets of warps of {Width} and {other.Width} lanes", nameof(other));
            var bits = new ulong[_bits.Length];
            for (var i = 0; i < bits.Length; i++)
                bits[i] = op(_bits[i], other._bits[i]);
            return new LaneSet(Width, bits);
        }

        public bool Equals(LaneSet? other) =>
            other is not null && other.Width == Width && other._bits.AsSpan().SequenceEqual(_bits);

        public override bool Equals(object? obj) => Equals(obj as LaneSet);

        public override int GetHashCode()
        {
            var hash = new HashCode();
            hash.Add(Width);
            foreach (var word in _bits)
                hash.Add(word);
            return hash.ToHashCode();
        }

        /// <summary>
        /// A hexadecimal mask, lane 0 in the least significant bit, one digit per
        /// four lanes of the warp — the spelling the observation and the replay log
        /// use for a lane mask (golden/CONTRACT.md §4).
        /// </summary>
        public override string ToString()
        {
            var digits = (Width + 3) / 4;
            var text = new StringBuilder("0x", 2 + digits);
            for (var digit = digits - 1; digit >= 0; digit--)
            {
                var bit = digit * 4;
                var nibble = (int)((_bits[bit / 64] >> (bit % 64)) & 0xF);
                text.Append("0123456789abcdef"[nibble]);
            }
            return text.ToString();
        }
    }
}
