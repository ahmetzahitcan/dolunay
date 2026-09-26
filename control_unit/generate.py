#!/usr/bin/python3

"""Generate a SystemVerilog control unit (module + package) from a CSV sheet.

This is the entry point; the implementation lives in the ``cugen`` package:

    cugen.csv_parser  parse + validate the CSV sheet
    cugen.sv_emitter  render the SystemVerilog module and package
    cugen.model       shared data model and don't-care helpers

Run ``python3 generate.py --help`` for the command-line interface.
"""

import argparse
import sys

from cugen.csv_parser import parse_csv
from cugen.sv_emitter import emit_sv_module, emit_sv_package
from cugen.util import extract_base_name


def main():
    parser = argparse.ArgumentParser(
        description='Generate SystemVerilog control unit from a CSV sheet.'
    )
    parser.add_argument('input_csv', nargs='?', default=f"{sys.path[0]}/control_unit.csv", help='Input CSV file containing instructions and control signals')
    parser.add_argument('output_module',   nargs='?', default=f"{sys.path[0]}/../src/control_unit.sv", help='Output SystemVerilog module filename')
    parser.add_argument('output_package', nargs='?', default=None,
                        help='Output SystemVerilog package filename '
                             '(default: <output_module_no_ext>_pkg.sv)')
    args = parser.parse_args()

    if args.output_package is None:
        extless = extract_base_name(args.output_module, remove_path=False)
        args.output_package = f"{extless}_pkg.sv"

    package_name = extract_base_name(args.output_package)
    module_name = extract_base_name(args.output_module)

    data = parse_csv(args.input_csv)
    emit_sv_module(data, args.output_module, module_name, package_name, args.input_csv)
    emit_sv_package(data, args.output_package, package_name, args.input_csv)


if __name__ == "__main__":
    main()
