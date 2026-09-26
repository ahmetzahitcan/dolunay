"""Shared helpers for the control-unit generator tests."""

import contextlib
import io
import os
import tempfile
import unittest

from cugen.csv_parser import parse_csv


def csv_text(header, rows):
    """Return CSV text for the given header and rows (no quoting needed)."""
    lines = [",".join(header)]
    lines.extend(",".join(row) for row in rows)
    return "\n".join(lines) + "\n"


class GeneratorTestCase(unittest.TestCase):
    """Base test case with temp-dir, CSV and output-capture helpers."""

    def setUp(self):
        self._tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self._tmp.cleanup)

    def path(self, name):
        """Return an absolute path inside this test's temp directory."""
        return os.path.join(self._tmp.name, name)

    def write_csv(self, text, name="input.csv"):
        """Write CSV text to a temp file and return its path."""
        path = self.path(name)
        with open(path, "w", encoding="utf-8", newline="") as f:
            f.write(text)
        return path

    @contextlib.contextmanager
    def capture(self):
        """Capture stdout written during the block."""
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf):
            yield buf

    def parse(self, text):
        """Parse CSV text, returning (ControlUnitData, captured stdout)."""
        with self.capture() as out:
            data = parse_csv(self.write_csv(text))
        return data, out.getvalue()

    def parse_exit(self, text):
        """Parse CSV text, returning (exit_code, captured stdout)."""
        with self.capture() as out, self.assertRaises(SystemExit) as cm:
            parse_csv(self.write_csv(text))
        return cm.exception.code, out.getvalue()
