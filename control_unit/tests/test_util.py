"""Tests for cugen.util."""

import unittest

from cugen.util import extract_base_name


class TestExtractBaseName(unittest.TestCase):
    def test_strips_directory_and_extension(self):
        self.assertEqual(extract_base_name("some/dir/control_unit.sv"), "control_unit")

    def test_keeps_directory_when_requested(self):
        self.assertEqual(
            extract_base_name("some/dir/control_unit.sv", remove_path=False),
            "some/dir/control_unit",
        )

    def test_no_extension(self):
        self.assertEqual(extract_base_name("control_unit"), "control_unit")

    def test_only_last_extension_is_removed(self):
        self.assertEqual(extract_base_name("a/b/c.tar.gz"), "c.tar")


if __name__ == "__main__":
    unittest.main()
