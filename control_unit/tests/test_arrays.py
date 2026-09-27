"""Tests for packed-array support in the control-unit generator."""

import unittest
from pathlib import Path

from cugen.sv_emitter import emit_sv_module, emit_sv_package

from .helpers import GeneratorTestCase, csv_text

# One integer-indexed array with an automatic enum (arr), one identifier-indexed
# array with an external enum type declared on its first column (flags), and one
# plain logic array carrying a bit range on its first column (cnt).
BASE_HEADER = [
    "instruction", "match_string", "sim__disasm_format", "imm_type",
    "arr(0)", "arr(1)", "arr(2)",
    "flags(FOO){ext_pkg::flag_e|FLAG_}", "flags(BAR)",
    "cnt(0)[3:0]", "cnt(1)",
]
BASE_ROWS = [
    ["INVALID", "", "", "IMM_NONE", "A", "B", "C", "ADD", "SUB", "4", "8"],
    ["ADD", "0" * 30, "add", "IMM_ADD", "A", "B", "C", "ADD", "SUB", "4", "8"],
    ["SUB", "0" * 29 + "1", "sub", "IMM_SUB", "B", "C", "A", "SUB", "ADD", "15", "0"],
]
BASE = csv_text(BASE_HEADER, BASE_ROWS)


class ArrayTestCase(GeneratorTestCase):
    """Shared helper for building one-instruction sheets with extra columns."""

    def array_csv(self, extra_header, extra_values):
        header = ["instruction", "match_string", "sim__disasm_format",
                  "imm_type", *extra_header]
        row = ["ADD", "0" * 30, "add", "IMM_A", *extra_values]
        return csv_text(header, [row])


class TestArrayParsing(ArrayTestCase):
    def test_signal_indices_are_recorded(self):
        data, _ = self.parse(BASE)
        self.assertEqual(
            [s.index for s in data.control_signals],
            [None, "0", "1", "2", "FOO", "BAR", "0", "1"],
        )

    def test_integer_array_is_grouped(self):
        data, _ = self.parse(BASE)
        info = data.arrays["arr"]
        self.assertTrue(info.integer_indexed)
        self.assertEqual([s.name for s in info.signals], ["arr", "arr", "arr"])
        self.assertEqual([s.index for s in info.signals], ["0", "1", "2"])

    def test_identifier_array_is_grouped(self):
        data, _ = self.parse(BASE)
        info = data.arrays["flags"]
        self.assertFalse(info.integer_indexed)
        self.assertEqual([s.index for s in info.signals], ["FOO", "BAR"])
        self.assertEqual(info.external_enum.type_ref, "ext_pkg::flag_e")
        self.assertEqual(info.external_enum.member("ADD"), "ext_pkg::FLAG_ADD")

    def test_array_values_are_combined_into_one_enum(self):
        data, _ = self.parse(BASE)
        self.assertEqual(data.enums["arr"], ["A", "B", "C"])
        self.assertNotIn("arr", data.external_enums)

    def test_external_and_plain_arrays_are_not_auto_enums(self):
        data, _ = self.parse(BASE)
        self.assertEqual(data.external_enums["flags"].type_ref, "ext_pkg::flag_e")
        self.assertNotIn("flags", data.enums)
        self.assertNotIn("cnt", data.enums)

    def test_plain_array_inherits_the_first_element_range(self):
        data, _ = self.parse(BASE)
        self.assertEqual([s.rng for s in data.arrays["cnt"].signals], ["3:0", "3:0"])

    def test_different_arrays_may_share_identifiers(self):
        data, _ = self.parse(self.array_csv(
            ["a(FOO)", "b(FOO)"], ["x", "x"]))
        self.assertEqual(set(data.arrays), {"a", "b"})
        self.assertFalse(data.arrays["a"].integer_indexed)
        self.assertFalse(data.arrays["b"].integer_indexed)

    def test_name_used_as_scalar_and_array_exits(self):
        code, out = self.parse_exit(self.array_csv(["a", "a(0)"], ["x", "x"]))
        self.assertEqual(code, 1)
        self.assertIn("both as a scalar signal and as an array", out)

    def test_imm_type_cannot_be_an_array(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format",
             "imm_type(0)", "imm_type(1)"],
            [["ADD", "0" * 30, "add", "IMM_A", "IMM_B"]],
        )
        code, out = self.parse_exit(text)
        self.assertEqual(code, 1)
        self.assertIn("cannot be an array", out)


class TestArrayValidation(ArrayTestCase):
    def assert_array_error(self, extra_header, extra_values, message):
        code, out = self.parse_exit(self.array_csv(extra_header, extra_values))
        self.assertEqual(code, 1)
        self.assertIn(message, out)

    def test_elements_must_be_adjacent(self):
        self.assert_array_error(
            ["a(0)", "a(1)", "mid", "a(2)"], ["x", "x", "x", "x"],
            "must occupy adjacent columns")

    def test_integer_indices_must_start_at_zero(self):
        self.assert_array_error(["a(1)", "a(2)"], ["x", "x"], "must start at 0")

    def test_integer_indices_must_increment_by_one(self):
        self.assert_array_error(["a(0)", "a(1)", "a(3)"], ["x", "x", "x"],
                                "increase by 1")

    def test_duplicate_identifier_index_exits(self):
        self.assert_array_error(["a(FOO)", "a(FOO)"], ["x", "x"], "duplicate index")

    def test_identifier_index_must_be_upper_case(self):
        self.assert_array_error(["a(foo)"], ["x"], "must be UPPER_CASE")

    def test_mixed_index_kinds_exit(self):
        self.assert_array_error(["a(0)", "a(FOO)"], ["x", "x"],
                                "mixes integer and identifier indices")

    def test_conflicting_external_annotations_exit(self):
        self.assert_array_error(
            ["a(0){pkg::t}", "a(1){other::u}"], ["x", "x"],
            "conflicting external enum annotations")

    def test_conflicting_bit_ranges_exit(self):
        self.assert_array_error(
            ["a(0)[3:0]", "a(1)[1:0]"], ["x", "x"], "conflicting bit ranges")

    def test_malformed_array_index_exits(self):
        self.assert_array_error(["a(0"], ["x"], "malformed array index")


class TestArrayEmission(GeneratorTestCase):
    def _emit(self, data):
        module = self.path("cu.sv")
        package = self.path("cu_pkg.sv")
        with self.capture():
            emit_sv_module(data, module, "cu", "cu_pkg", "input.csv")
            emit_sv_package(data, package, "cu_pkg", "input.csv")
        return (Path(module).read_text(encoding="utf-8"),
                Path(package).read_text(encoding="utf-8"))

    def test_package_emits_length_and_identifier_localparams(self):
        data, _ = self.parse(BASE)
        _, package = self._emit(data)
        self.assertIn("\tlocalparam int LEN_ARR = 3;\n", package)
        self.assertIn("\tlocalparam int LEN_FLAGS = 2;\n", package)
        self.assertIn("\tlocalparam int FLAGS_FOO = 0;\n", package)
        self.assertIn("\tlocalparam int FLAGS_BAR = 1;\n", package)
        self.assertIn("\tlocalparam int LEN_CNT = 2;\n", package)

    def test_package_emits_array_fields(self):
        data, _ = self.parse(BASE)
        _, package = self._emit(data)
        self.assertIn("\t\tarr_e [LEN_ARR-1:0] arr;\n", package)
        self.assertIn("\t\text_pkg::flag_e [LEN_FLAGS-1:0] flags;\n", package)
        self.assertIn("\t\tlogic [LEN_CNT-1:0][3:0] cnt;\n", package)

    def test_module_emits_element_assignments(self):
        data, _ = self.parse(BASE)
        module, _ = self._emit(data)
        self.assertIn("                instr_o.arr[0] = ARR_A;\n", module)
        self.assertIn("                instr_o.arr[1] = ARR_B;\n", module)
        self.assertIn("                instr_o.arr[2] = ARR_C;\n", module)
        self.assertIn("                instr_o.flags[FLAGS_FOO] = ext_pkg::FLAG_ADD;\n", module)
        self.assertIn("                instr_o.flags[FLAGS_BAR] = ext_pkg::FLAG_SUB;\n", module)
        self.assertIn("                instr_o.cnt[0] = 4;\n", module)
        self.assertIn("                instr_o.cnt[1] = 8;\n", module)

    def test_package_layout_with_arrays_and_no_enums(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format",
             "imm_type", "br(0)", "br(1)"],
            [["ADD", "0" * 30, "add", "1", "4", "8"]],
        )
        data, _ = self.parse(text)
        _, package = self._emit(data)
        self.assertIn(
            "\n\n\tlocalparam int LEN_BR = 2;\n\n\ttypedef struct packed {\n",
            package)
        self.assertIn("\t\tlogic [LEN_BR-1:0] br;\n", package)


if __name__ == "__main__":
    unittest.main()
