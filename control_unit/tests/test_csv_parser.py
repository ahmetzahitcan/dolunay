"""Tests for cugen.csv_parser."""

import unittest

from cugen.csv_parser import field_base_name, parse_csv

from .helpers import GeneratorTestCase, csv_text

# A small but complete sheet: an INVALID row, two instructions and a mix of
# enum and plain columns.
BASE_HEADER = ["instruction", "match_string", "sim__disasm_format",
               "imm_type", "alu_op", "flag"]
BASE_ROWS = [
    ["INVALID", "", "", "ALU_ADD", "ALU_ADD", "0"],
    ["ADD", "0" * 30, "add", "ALU_ADD", "ADD_OP", "1"],
    ["SUB", "0" * 29 + "1", "sub", "IMM_SUB", "SUB_OP", "0"],
]
BASE = csv_text(BASE_HEADER, BASE_ROWS)


class TestFieldBaseName(unittest.TestCase):
    def test_plain_name(self):
        self.assertEqual(field_base_name("alu_op"), "alu_op")

    def test_bit_range(self):
        self.assertEqual(field_base_name("alu_op[2:0]"), "alu_op")

    def test_external_enum(self):
        self.assertEqual(field_base_name("fpu_op{fpnew_pkg::operation_e}"), "fpu_op")

    def test_range_and_external_enum(self):
        self.assertEqual(field_base_name("fpu_op[1:0]{pkg::t}"), "fpu_op")

    def test_surrounding_whitespace_is_stripped(self):
        self.assertEqual(field_base_name("  imm_type  "), "imm_type")


class TestParseCsv(GeneratorTestCase):
    # -- happy path -------------------------------------------------------

    def test_control_signals_are_collected_in_order(self):
        data, _ = self.parse(BASE)
        self.assertEqual(
            [(name, rng) for _, name, rng in data.control_signals],
            [("imm_type", ""), ("alu_op", ""), ("flag", "")],
        )

    def test_metadata_columns_are_not_control_signals(self):
        data, _ = self.parse(BASE)
        names = [name for _, name, _ in data.control_signals]
        for column in ("instruction", "match_string", "sim__disasm_format"):
            self.assertNotIn(column, names)

    def test_invalid_row_supplies_default_values(self):
        data, _ = self.parse(BASE)
        self.assertEqual(data.default_values["imm_type"], "ALU_ADD")
        self.assertEqual(data.default_values["flag"], "0")

    def test_missing_invalid_row_defaults_to_x_and_warns(self):
        data, out = self.parse(csv_text(BASE_HEADER, BASE_ROWS[1:]))
        self.assertIn("No INVALID row found", out)
        self.assertEqual(set(data.default_values.values()), {"x"})
        self.assertEqual(data.default_values["alu_op"], "x")

    # -- match-string cleanup --------------------------------------------

    def test_match_string_is_cleaned_and_scored(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [["ADD", "0000 x_X_", "add", "IMM_A"]],
        )
        data, _ = self.parse(text)
        row = data.instructions[0]
        self.assertEqual(row["CleanMatchString"], "0000??")
        self.assertEqual(row["SpecificBits"], 4)

    def test_blank_rows_are_dropped(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [
                ["", "", "", "IMM_A"],
                ["ADD", "0" * 30, "add", "IMM_A"],
            ],
        )
        data, _ = self.parse(text)
        self.assertEqual([r["instruction"] for r in data.instructions], ["ADD"])

    def test_most_specific_patterns_are_sorted_first(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [
                ["ANY", "?" * 30, "any", "IMM_A"],
                ["EXACT", "0" * 30, "exact", "IMM_B"],
            ],
        )
        data, _ = self.parse(text)
        self.assertEqual(
            [r["instruction"] for r in data.instructions], ["EXACT", "ANY"])

    # -- pattern validation ----------------------------------------------

    def test_subset_patterns_are_allowed(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [
                ["ANY", "?" * 30, "any", "IMM_A"],
                ["EXACT", "0" * 30, "exact", "IMM_B"],
            ],
        )
        data, _ = self.parse(text)
        self.assertEqual(len(data.instructions), 2)

    def test_duplicate_patterns_exit(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [["A", "0" * 30, "a", "IMM_A"],
             ["B", "0" * 30, "b", "IMM_B"]],
        )
        code, out = self.parse_exit(text)
        self.assertEqual(code, 1)
        self.assertIn("identical patterns", out)

    def test_ambiguous_overlap_exits(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [["A", "0" + "?" * 29, "a", "IMM_A"],
             ["B", "?" * 29 + "1", "b", "IMM_B"]],
        )
        code, out = self.parse_exit(text)
        self.assertEqual(code, 1)
        self.assertIn("Ambiguous overlap", out)

    # -- control-signal columns ------------------------------------------

    def test_bit_range_is_parsed(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type", "br[3:0]"],
            [["ADD", "0" * 30, "add", "IMM_A", "4"]],
        )
        data, _ = self.parse(text)
        ranges = {name: rng for _, name, rng in data.control_signals}
        self.assertEqual(ranges["br"], "3:0")

    def test_external_enum_annotation_is_parsed(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "fpu_op{fpnew_pkg::operation_e|OP_}"],
            [["ADD", "0" * 30, "add", "IMM_A", "ADD"]],
        )
        data, _ = self.parse(text)
        ext = data.external_enums["fpu_op"]
        self.assertEqual(ext.type_ref, "fpnew_pkg::operation_e")
        self.assertEqual(ext.scope, "fpnew_pkg::")
        self.assertEqual(ext.member("ADD"), "fpnew_pkg::OP_ADD")
        self.assertEqual(ext.undefined(), "fpnew_pkg::operation_e'('x)")

    def test_external_enum_explicit_default_member(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "fu{params_pkg::fu_e|FU_|NONE}"],
            [["ADD", "0" * 30, "add", "IMM_A", "x"]],
        )
        data, _ = self.parse(text)
        ext = data.external_enums["fu"]
        self.assertEqual(ext.undefined(), "params_pkg::FU_NONE")
        self.assertEqual(ext.member("ADD"), "params_pkg::FU_ADD")

    def test_unqualified_external_enum_warns(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "x{op_e}"],
            [["ADD", "0" * 30, "add", "IMM_A", "OP_ADD"]],
        )
        data, out = self.parse(text)
        self.assertIn("not package-qualified", out)
        self.assertEqual(data.external_enums["x"].undefined(), "op_e'('x)")

    def test_bit_range_and_external_enum_warns(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "fpu[1:0]{pkg::t}"],
            [["ADD", "0" * 30, "add", "IMM_A", "OP_ADD"]],
        )
        data, out = self.parse(text)
        self.assertIn("declares both a bit range and an external enum", out)
        self.assertIn("fpu", data.external_enums)

    def test_too_many_annotation_fields_exits(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "x{pkg::t|P_|pkg::NONE|extra}"],
            [["ADD", "0" * 30, "add", "IMM_A", "P_ADD"]],
        )
        code, out = self.parse_exit(text)
        self.assertEqual(code, 1)
        self.assertIn("too many", out)

    def test_missing_annotation_type_exits(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "x{|P_}"],
            [["ADD", "0" * 30, "add", "IMM_A", "P_ADD"]],
        )
        code, out = self.parse_exit(text)
        self.assertEqual(code, 1)
        self.assertIn("missing a type", out)

    def test_malformed_annotation_exits(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "bad{foo"],
            [["ADD", "0" * 30, "add", "IMM_A", "1"]],
        )
        code, out = self.parse_exit(text)
        self.assertEqual(code, 1)
        self.assertIn("malformed external enum annotation", out)

    def test_commented_out_column_is_skipped(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "'old_sig"],
            [["ADD", "0" * 30, "add", "IMM_A", "IMM_OLD"]],
        )
        data, _ = self.parse(text)
        self.assertNotIn("old_sig", [name for _, name, _ in data.control_signals])

    def test_commented_out_row_is_skipped(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [["'COMMENTED", "0" * 30, "c", "IMM_C"],
             ["ADD", "0" * 29 + "1", "add", "IMM_A"]],
        )
        data, _ = self.parse(text)
        self.assertEqual([r["instruction"] for r in data.instructions], ["ADD"])
        self.assertEqual(data.enums["imm_type"], ["IMM_A"])

    def test_non_snake_case_column_warns(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type", "BadName"],
            [["ADD", "0" * 30, "add", "IMM_A", "V"]],
        )
        _, out = self.parse(text)
        self.assertIn("does not look like snake_case", out)

    # -- enum auto-detection ---------------------------------------------

    def test_enum_columns_are_detected_in_order(self):
        data, _ = self.parse(BASE)
        self.assertEqual(data.enums["imm_type"], ["ALU_ADD", "IMM_SUB"])
        self.assertEqual(data.enums["alu_op"], ["ALU_ADD", "ADD_OP", "SUB_OP"])
        self.assertNotIn("flag", data.enums)

    def test_enum_detection_ignores_dont_care_values(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [["A", "0" * 30, "a", "IMM_A"],
             ["B", "1" * 30, "b", "x"]],
        )
        data, _ = self.parse(text)
        self.assertEqual(data.enums["imm_type"], ["IMM_A"])

    def test_enum_detection_rejects_mixed_case_values(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [["A", "0" * 30, "a", "IMM_A"],
             ["B", "1" * 30, "b", "alu_b"]],
        )
        data, _ = self.parse(text)
        self.assertNotIn("imm_type", data.enums)

    def test_external_enum_is_not_auto_declared(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "fpu_op{fpnew_pkg::operation_e}"],
            [["ADD", "0" * 30, "add", "IMM_A", "FPU_ADD"]],
        )
        data, _ = self.parse(text)
        self.assertNotIn("fpu_op", data.enums)

    def test_bad_external_enum_value_warns(self):
        text = csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "x{pkg::t}"],
            [["ADD", "0" * 30, "add", "IMM_A", "lowercase"]],
        )
        _, out = self.parse(text)
        self.assertIn("is not a valid enum member name", out)

    # -- input validation -------------------------------------------------

    def test_missing_required_column_exits(self):
        code, out = self.parse_exit(csv_text(
            ["instruction", "match_string", "foo"], [["A", "0" * 30, "1"]]))
        self.assertEqual(code, 1)
        self.assertIn("must contain 'instruction'", out)

    def test_empty_file_exits(self):
        code, out = self.parse_exit("")
        self.assertEqual(code, 1)
        self.assertIn("Empty CSV file", out)

    def test_missing_file_exits(self):
        with self.capture() as out, self.assertRaises(SystemExit) as cm:
            parse_csv(self.path("does_not_exist.csv"))
        self.assertEqual(cm.exception.code, 1)
        self.assertIn("Could not find file", out.getvalue())


if __name__ == "__main__":
    unittest.main()
