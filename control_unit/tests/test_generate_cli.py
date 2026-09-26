"""End-to-end tests for the generate.py command-line entry point."""

import os
import subprocess
import sys
import unittest

from .helpers import GeneratorTestCase, csv_text

CONTROL_UNIT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GENERATE = os.path.join(CONTROL_UNIT_DIR, "generate.py")

SMALL = csv_text(
    ["instruction", "match_string", "sim__disasm_format", "imm_type", "alu_op", "flag"],
    [
        ["INVALID", "", "", "ALU_ADD", "ALU_ADD", "0"],
        ["ADD", "0" * 30, "add", "ALU_ADD", "ADD_OP", "1"],
        ["SUB", "0" * 29 + "1", "sub", "IMM_SUB", "SUB_OP", "0"],
    ],
)


class TestGenerateCli(GeneratorTestCase):
    def run_cli(self, *args):
        return subprocess.run(
            [sys.executable, GENERATE, *args],
            cwd=CONTROL_UNIT_DIR,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            check=False,
        )

    def test_generates_module_and_package(self):
        csv_path = self.write_csv(SMALL)
        module = self.path("cu.sv")
        package = self.path("cu_pkg.sv")

        result = self.run_cli(csv_path, module, package)

        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertIn("Successfully generated", result.stdout)
        with open(module, encoding="utf-8") as f:
            self.assertIn("module cu\n", f.read())
        with open(package, encoding="utf-8") as f:
            self.assertIn("package cu_pkg;\n", f.read())

    def test_default_package_name_is_derived_from_module(self):
        csv_path = self.write_csv(SMALL)
        module = self.path("cu.sv")

        result = self.run_cli(csv_path, module)

        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertTrue(os.path.exists(self.path("cu_pkg.sv")))

    def test_parse_error_is_reported_and_no_output_is_written(self):
        bad = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [["A", "0" * 30, "a", "IMM_A"],
             ["B", "0" * 30, "b", "IMM_B"]],
        )
        csv_path = self.write_csv(bad)
        module = self.path("cu.sv")
        package = self.path("cu_pkg.sv")

        result = self.run_cli(csv_path, module, package)

        self.assertEqual(result.returncode, 1)
        self.assertIn("identical patterns", result.stdout)
        self.assertFalse(os.path.exists(module))
        self.assertFalse(os.path.exists(package))

    def test_help_succeeds(self):
        result = self.run_cli("--help")
        self.assertEqual(result.returncode, 0)
        self.assertIn("usage: generate.py", result.stdout)


if __name__ == "__main__":
    unittest.main()
