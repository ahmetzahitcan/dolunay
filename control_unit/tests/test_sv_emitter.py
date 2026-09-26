"""Tests for cugen.sv_emitter."""

import unittest

from cugen.model import ControlUnitData, ExternalEnum
from cugen.sv_emitter import emit_sv_module, emit_sv_package, format_value

from .helpers import GeneratorTestCase, csv_text

SMALL = csv_text(
    ["instruction", "match_string", "sim__disasm_format", "imm_type", "alu_op", "flag"],
    [
        ["INVALID", "", "", "ALU_ADD", "ALU_ADD", "0"],
        ["ADD", "0" * 30, "add", "ALU_ADD", "ADD_OP", "1"],
        # leading "~" marks an impossible instruction: enum values are still
        # generated, but no case entry is emitted.
        ["~NOPE", "0" * 28 + "??", "nope", "IMM_XXX", "XXX_OP", "0"],
        ["SUB", "0" * 29 + "1", "sub", "IMM_SUB", "SUB_OP", "0"],
    ],
)


def make_data(control_signals=(), enums=None, external_enums=None,
              default_values=None, instructions=None):
    """Build a ControlUnitData with sensible defaults for emitter tests."""
    return ControlUnitData(
        control_signals=list(control_signals),
        default_values=default_values or {},
        instructions=instructions or [],
        enums=enums or {},
        external_enums=external_enums or {},
    )


class TestFormatValue(unittest.TestCase):
    def test_external_enum_member(self):
        ext = ExternalEnum("fpu_op", "fpnew_pkg::operation_e", "OP_")
        self.assertEqual(
            format_value("ADD", "fpu_op", "", {}, {"fpu_op": ext}),
            "fpnew_pkg::OP_ADD",
        )

    def test_external_enum_dont_care_is_a_cast(self):
        ext = ExternalEnum("fpu_op", "fpnew_pkg::operation_e", "OP_")
        self.assertEqual(
            format_value("x", "fpu_op", "", {}, {"fpu_op": ext}),
            "fpnew_pkg::operation_e'('x)",
        )

    def test_external_enum_explicit_default(self):
        ext = ExternalEnum("fu", "params_pkg::fu_e", "FU_", "NONE")
        self.assertEqual(
            format_value("", "fu", "", {}, {"fu": ext}),
            "params_pkg::FU_NONE",
        )

    def test_internal_enum_member_is_prefixed(self):
        self.assertEqual(
            format_value("ADD_OP", "alu_op", "", {"alu_op": ["ADD_OP"]}, {}),
            "ALU_OP_ADD_OP",
        )

    def test_internal_enum_dont_care_is_a_cast(self):
        self.assertEqual(
            format_value("?", "alu_op", "", {"alu_op": ["ADD_OP"]}, {}),
            "alu_op_e'('x)",
        )

    def test_plain_dont_care_values(self):
        for value in ("", "x", "X", "-", "d", "D", "?"):
            with self.subTest(value=value):
                self.assertEqual(format_value(value, "sig", "", {}, {}), "'x")

    def test_plain_single_bit_becomes_a_literal(self):
        self.assertEqual(format_value("1", "sig", "", {}, {}), "1'b1")
        self.assertEqual(format_value("0", "sig", "", {}, {}), "1'b0")

    def test_plain_single_bit_with_range_is_raw(self):
        self.assertEqual(format_value("1", "sig", "3:0", {}, {}), "1")

    def test_plain_value_is_passed_through(self):
        self.assertEqual(format_value("4", "br", "3:0", {}, {}), "4")


class TestEmitSvModule(GeneratorTestCase):
    def _emit(self, data, module_name="cu", package_name="cu_pkg"):
        path = self.path("cu.sv")
        with self.capture():
            emit_sv_module(data, path, module_name, package_name, "input.csv")
        with open(path, encoding="utf-8") as f:
            return f.read()

    def test_module_scaffolding(self):
        data, _ = self.parse(SMALL)
        text = self._emit(data)
        self.assertTrue(text.startswith("`default_nettype none\n"))
        self.assertIn("module cu\n", text)
        self.assertIn("import cu_pkg::*;\n", text)
        self.assertIn("    imm_type_e imm_type_w;\n", text)
        self.assertIn("endmodule\n", text)
        self.assertTrue(text.endswith("`default_nettype wire\n"))

    def test_case_entries_are_emitted(self):
        data, _ = self.parse(SMALL)
        text = self._emit(data)
        self.assertIn("30'b" + "0" * 30 + ": begin // ADD\n", text)
        self.assertIn("30'b" + "0" * 29 + "1: begin // SUB\n", text)

    def test_impossible_instruction_has_no_case_entry(self):
        data, _ = self.parse(SMALL)
        text = self._emit(data)
        self.assertNotIn("// ~NOPE", text)
        self.assertNotIn("sim__disasm_format_w = \"nope\";", text)

    def test_signal_assignments_use_the_right_targets(self):
        data, _ = self.parse(SMALL)
        text = self._emit(data)
        self.assertIn("                instr_o.alu_op = ALU_OP_ADD_OP;\n", text)
        self.assertIn("                instr_o.flag = 1'b1;\n", text)
        self.assertIn("                imm_type_w = IMM_TYPE_ALU_ADD;\n", text)

    def test_disasm_format_is_quoted(self):
        data, _ = self.parse(SMALL)
        text = self._emit(data)
        self.assertIn('sim__disasm_format_w = "add";\n', text)

    def test_default_case_uses_invalid_row(self):
        data, _ = self.parse(SMALL)
        text = self._emit(data)
        self.assertIn("default: begin // INVALID\n", text)
        self.assertIn("                instr_o.alu_op = ALU_OP_ALU_ADD;\n", text)
        self.assertIn("                instr_o.flag = 1'b0;\n", text)
        self.assertIn("                imm_type_w = IMM_TYPE_ALU_ADD;\n", text)
        self.assertIn("$warning(", text)

    def test_short_match_string_is_skipped_with_warning(self):
        data, _ = self.parse(csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type"],
            [["SHORT", "0000", "short", "IMM_A"]],
        ))
        path = self.path("cu.sv")
        with self.capture() as out:
            emit_sv_module(data, path, "cu", "cu_pkg", "input.csv")
        self.assertIn("expected 30", out.getvalue())
        with open(path, encoding="utf-8") as f:
            self.assertNotIn("// SHORT", f.read())

    def test_external_imm_type_is_declared_by_its_qualified_name(self):
        data, _ = self.parse(csv_text(
            ["instruction", "match_string", "sim__disasm_format",
             "imm_type{my_pkg::imm_e|IMM_}"],
            [["ADD", "0" * 30, "add", "ADD"]],
        ))
        text = self._emit(data)
        self.assertIn("    my_pkg::imm_e imm_type_w;\n", text)
        self.assertIn("                imm_type_w = my_pkg::IMM_ADD;\n", text)


class TestEmitSvPackage(GeneratorTestCase):
    def _emit(self, data, package_name="cu_pkg"):
        path = self.path("cu_pkg.sv")
        with self.capture():
            emit_sv_package(data, path, package_name, "input.csv")
        with open(path, encoding="utf-8") as f:
            return f.read()

    def test_package_scaffolding(self):
        data, _ = self.parse(SMALL)
        text = self._emit(data)
        self.assertTrue(text.startswith("`default_nettype none\n"))
        self.assertIn("package cu_pkg;\n", text)
        self.assertIn("\t} instr_s;\n", text)
        self.assertIn("endpackage\n", text)
        self.assertTrue(text.endswith("`default_nettype wire\n"))

    def test_enum_members_and_typedef_are_emitted(self):
        data, _ = self.parse(SMALL)
        text = self._emit(data)
        self.assertIn("\t\tIMM_TYPE_ALU_ADD", text)
        self.assertIn("\t\tIMM_TYPE_IMM_XXX", text)  # from the impossible instruction
        self.assertIn("\t} imm_type_e;\n", text)
        self.assertIn("\t} alu_op_e;\n", text)

    def test_enum_bit_width_is_derived_from_member_count(self):
        two = make_data([("op", "op", "")], enums={"op": ["A", "B"]})
        self.assertIn("typedef enum logic {", self._emit(two))

        four = make_data([("op", "op", "")], enums={"op": ["A", "B", "C", "D"]})
        self.assertIn("typedef enum logic [1:0] {", self._emit(four))

        five = make_data([("op", "op", "")], enums={"op": ["A", "B", "C", "D", "E"]})
        self.assertIn("typedef enum logic [2:0] {", self._emit(five))

    def test_struct_fields_and_imm_type_is_skipped(self):
        data, _ = self.parse(SMALL)
        text = self._emit(data)
        self.assertIn("\t\tlogic [RLEN-1:0] imm;\n", text)
        self.assertIn("\t\talu_op_e alu_op;\n", text)
        self.assertIn("\t\tlogic flag;\n", text)
        self.assertNotIn("\t\timm_type_e imm_type;\n", text)

    def test_plain_signal_with_bit_range(self):
        data = make_data([("br", "br", "3:0")])
        self.assertIn("\t\tlogic [3:0] br;\n", self._emit(data))

    def test_external_enum_field_uses_qualified_type(self):
        data, _ = self.parse(csv_text(
            ["instruction", "match_string", "sim__disasm_format", "imm_type",
             "fpu_op{fpnew_pkg::operation_e}"],
            [["ADD", "0" * 30, "add", "IMM_A", "FPU_ADD"]],
        ))
        self.assertIn("\t\tfpnew_pkg::operation_e fpu_op;\n", self._emit(data))


if __name__ == "__main__":
    unittest.main()
