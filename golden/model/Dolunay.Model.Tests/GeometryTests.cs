using System;

using Dolunay.Model;

using NUnit.Framework;

namespace Dolunay.Model.Tests
{
    public class GeometryTests
    {
        [Test]
        public void SpellsItselfAsTheObservationDoes()
        {
            Assert.That(new Geometry(3, 5).ToString(), Is.EqualTo("3x5"));
        }

        [Test]
        public void CountsLanesAcrossWarps()
        {
            Assert.That(new Geometry(3, 5).Lanes, Is.EqualTo(15));
        }

        [TestCase(0, 1)]
        [TestCase(1, 0)]
        [TestCase(-1, 4)]
        public void RejectsAnEmptyMachine(int warps, int lanesPerWarp)
        {
            Assert.That(() => new Geometry(warps, lanesPerWarp), Throws.InstanceOf<ArgumentOutOfRangeException>());
        }
    }
}
