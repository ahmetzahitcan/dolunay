using System.Linq;

using Dolunay.Model;

using NUnit.Framework;

namespace Dolunay.Model.Tests
{
    public class LaneSetTests
    {
        [Test]
        public void CombinesLikeASet()
        {
            var a = LaneSet.Of(8, 0, 1, 2);
            var b = LaneSet.Of(8, 2, 3);
            Assert.Multiple(() =>
            {
                Assert.That(a.Union(b), Is.EqualTo(LaneSet.Of(8, 0, 1, 2, 3)));
                Assert.That(a.Intersect(b), Is.EqualTo(LaneSet.Of(8, 2)));
                Assert.That(a.Except(b), Is.EqualTo(LaneSet.Of(8, 0, 1)));
                Assert.That(a.Overlaps(b), Is.True);
                Assert.That(LaneSet.Of(8, 1).IsSubsetOf(a), Is.True);
                Assert.That(b.Lowest, Is.EqualTo(2));
                Assert.That(a.Count, Is.EqualTo(3));
                Assert.That(LaneSet.Empty(8).IsEmpty, Is.True);
            });
        }

        [Test]
        public void SpellsAMaskWithLaneZeroLowest()
        {
            Assert.Multiple(() =>
            {
                Assert.That(LaneSet.Of(4, 0, 2).ToString(), Is.EqualTo("0x5"));
                Assert.That(LaneSet.All(8).ToString(), Is.EqualTo("0xff"));
                Assert.That(LaneSet.Empty(5).ToString(), Is.EqualTo("0x00"));
            });
        }

        [Test]
        public void HasNoWidthLimit()
        {
            var lanes = LaneSet.Of(70, 0, 65, 69);
            Assert.Multiple(() =>
            {
                Assert.That(lanes.ToString(), Is.EqualTo("0x220000000000000001"));
                Assert.That(lanes.Lanes.ToArray(), Is.EqualTo(new[] { 0, 65, 69 }));
                Assert.That(LaneSet.All(70).Count, Is.EqualTo(70));
                Assert.That(LaneSet.All(70).Except(lanes).Lowest, Is.EqualTo(1));
            });
        }

        [Test]
        public void EqualityIsByValue()
        {
            Assert.That(LaneSet.Of(8, 3, 1), Is.EqualTo(LaneSet.Of(8, 1, 3)));
            Assert.That(LaneSet.Of(8, 1, 1).GetHashCode(), Is.EqualTo(LaneSet.Of(8, 1).GetHashCode()));
            Assert.That(LaneSet.Of(8, 1), Is.Not.EqualTo(LaneSet.Of(9, 1)));
        }
    }
}
