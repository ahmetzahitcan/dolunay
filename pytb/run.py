#!/usr/bin/env python3
"""Run the cocotb testbenches of the project.

This is the only entry point. It finds the testbenches, builds them and runs
them, and the names of the testbenches to run are its arguments:

    python3 pytb/run.py             # every testbench (except those with autorun=false)
    python3 pytb/run.py fu_lsu      # one of them
    python3 pytb/run.py --list      # what is there

A testbench is a folder with a testbench.toml in it, which says what it is
and what it is built from. See pytb/README.md.

cocotb is installed in a virtualenv, so this script re-runs itself with that
interpreter when it is started with another one.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
from dataclasses import dataclass, field
from pathlib import Path

PYTB_DIR = Path(__file__).resolve().parent
PROJECT_DIR = PYTB_DIR.parent

# The virtualenv cocotb is installed in. It is the one in the project by
# default, because that is where the editor's language server and the other
# Python tools look for it.
VENV = Path(os.environ.get("DOLUNAY_COCOTB_VENV", PROJECT_DIR / ".venv"))

# A Verilator to use instead of the one on the PATH. It may point at a
# directory that holds the binary, either as <dir>/bin/verilator or as
# <dir>/usr/bin/verilator, which is how an unpacked Debian package is laid
# out.
VERILATOR_HOME = os.environ.get("DOLUNAY_VERILATOR")

# Where the build trees go. They are kept outside the project, because GNU
# Make misbehaves when the directory it builds in has a space in its path.
BUILD_ROOT = Path(
    os.environ.get("DOLUNAY_BUILD_DIR", Path.home() / "dolunay-sim")
) / "pytb"

# The oldest Verilator cocotb 2.x works with.
MIN_VERILATOR = (5, 36)

# The file in the build tree that says which toolchain it was made with.
MARKER_NAME = "pytb-build.json"

# The file in a testbench's folder that describes it.
METADATA_NAME = "testbench.toml"

# The keys a testbench.toml may have.
METADATA_KEYS = {
    "name",
    "description",
    "toplevel",
    "module",
    "sources",
    "project_sources",
    "bender_sources",
    "autorun",
    "options",
}

# The types an option may have. A flag is off unless it is given, and the
# others take a value of the given type.
OPTION_TYPES = {"int": int, "str": str}
OPTION_KINDS = (*OPTION_TYPES, "flag")

# What an option can be worth.
OptionValue = int | str | bool | None


# -----------------------------------------------------------------------------
# The testbenches
# -----------------------------------------------------------------------------


@dataclass(frozen=True)
class Option:
    """One option of a testbench."""

    name: str
    type: str  # "int", "str" or "flag"
    default: OptionValue = None
    values: list[str] = field(default_factory=list)  # the ones it accepts
    help: str = ""


@dataclass(frozen=True)
class Testbench:
    """One testbench: what it is and what it is built from."""

    name: str
    description: str
    toplevel: str  # the HDL top module
    module: str  # the Python module the tests are in
    folder: Path  # the folder the testbench lives in
    sources: list[Path] = field(default_factory=list)  # its own files
    project_sources: list[Path] = field(default_factory=list)  # the project's
    bender_sources: list[str] = field(default_factory=list)  # Bender's
    autorun: bool = True  # run when running all of them
    options: dict[str, Option] = field(default_factory=dict)

    def build_inputs(self) -> tuple[list[Path], dict[str, int], list[Path]]:
        """The sources it is built from, the defines and the include directories.

        The packages come first, because a package has to be read before the
        files that use it.
        """
        sources, defines, includes = bender_script(self.bender_sources)
        return sources + self.project_sources + self.sources, defines, includes

    def option(self, args: argparse.Namespace, name: str) -> OptionValue:
        """The value of one of this testbench's options."""
        return getattr(args, f"opt_{self.name}_{name}", None)

    def option_env(self, name: str) -> str:
        """The environment variable one of its options is handed over in."""
        return f"DOLUNAY_{self.name.upper()}_{name.upper()}"


def discover_testbenches() -> list[Testbench]:
    """Every testbench of the project.

    A testbench is a folder with a testbench.toml in it.
    """
    testbenches = []
    for folder in sorted(PYTB_DIR.iterdir()):
        metadata = folder / METADATA_NAME
        if folder.is_dir() and metadata.is_file():
            testbenches.append(load_testbench(folder, metadata))
    return testbenches


def load_testbench(folder: Path, metadata: Path) -> Testbench:
    """Read the metadata of a testbench."""
    import tomllib

    try:
        with metadata.open("rb") as handle:
            data = tomllib.load(handle)
    except tomllib.TOMLDecodeError as error:
        raise SystemExit(f"ERROR: {metadata}: {error}") from error

    unknown = set(data) - METADATA_KEYS
    if unknown:
        raise SystemExit(
            f"ERROR: {metadata}: unknown key(s): {', '.join(sorted(unknown))}\n"
            f"       The keys are: {', '.join(sorted(METADATA_KEYS))}"
        )
    for key in ("toplevel", "module"):
        if key not in data:
            raise SystemExit(f"ERROR: {metadata}: '{key}' is missing")

    # The name of the testbench and the names of its options end up in the
    # names of the environment variables the options are handed over in, so
    # they have to be usable as such.
    name = data.get("name", folder.name)
    for used in [name, *data.get("options", {})]:
        if not re.fullmatch(r"[A-Za-z0-9_]+", used):
            raise SystemExit(
                f"ERROR: {metadata}: '{used}' has to be letters, digits and\n"
                f"       underscores, because it is used in the name of an\n"
                f"       environment variable."
            )

    sources = [folder / name for name in data.get("sources", [])]
    project_sources = [PROJECT_DIR / name for name in data.get("project_sources", [])]
    for source in sources + project_sources:
        if not source.is_file():
            raise SystemExit(f"ERROR: {metadata}: {source} does not exist")

    return Testbench(
        name=name,
        description=data.get("description", ""),
        toplevel=data["toplevel"],
        module=data["module"],
        folder=folder,
        sources=sources,
        project_sources=project_sources,
        bender_sources=list(data.get("bender_sources", [])),
        autorun=data.get("autorun", True),
        options=load_options(data.get("options", {}), metadata),
    )


def load_options(specs: dict, metadata: Path) -> dict[str, Option]:
    """The options a testbench declares.

    An option is a table with a type, and optionally a default and a help
    text. The type is "int", "str" or "flag".
    """
    options = {}
    for name, spec in specs.items():
        if not isinstance(spec, dict):
            raise SystemExit(
                f"ERROR: {metadata}: the option '{name}' has to be a table"
            )
        kind = spec.get("type", "str")
        if kind not in OPTION_KINDS:
            raise SystemExit(
                f"ERROR: {metadata}: the option '{name}' has the unknown type "
                f"'{kind}'. The types are: {', '.join(OPTION_KINDS)}"
            )
        options[name] = Option(
            name=name,
            type=kind,
            default=spec.get("default"),
            values=list(spec.get("values", [])),
            help=spec.get("help", ""),
        )
    return options


def bender_script(
    patterns: list[str],
) -> tuple[list[Path], dict[str, int], list[Path]]:
    """The files of the Bender checkouts that match, the defines and the
    include directories.

    A pattern is the end of a path, so ".sv" is every source file of the
    checkouts.
    """
    if not patterns:
        return [], {}, []
    if shutil.which("bender") is None:
        raise SystemExit(
            "ERROR: bender is not on the PATH.\n"
            "       It manages the checkouts under .bender/, and the testbenches\n"
            "       need the fpnew package from it."
        )
    try:
        script = subprocess.run(
            ["bender", "script", "verilator"],
            cwd=PROJECT_DIR,
            capture_output=True,
            text=True,
            check=True,
        ).stdout
    except subprocess.CalledProcessError as error:
        raise SystemExit(
            f"ERROR: bender failed:\n{error.stderr.strip()}\n"
            f"       The checkouts may be missing: run 'bender update'."
        ) from error

    lines = script.splitlines()
    # The script describes the whole project, the checkouts and the project's
    # own files. The project's own files are listed in the metadata of the
    # testbench, in the order Verilator needs them, so only the checkouts are
    # taken from here. This is the same rule tb/common.sh uses.
    checkout_lines = [
        line
        for line in lines
        if not any(
            Path(line).is_relative_to(PROJECT_DIR / directory)
            for directory in ("src", "tb")
        )
    ]
    files = [
        Path(line)
        for line in checkout_lines
        if any(line.endswith(pattern) for pattern in patterns)
    ]
    missing = [
        pattern
        for pattern in patterns
        if not any(line.endswith(pattern) for line in checkout_lines)
    ]
    if missing:
        raise SystemExit(
            f"ERROR: bender did not give {', '.join(missing)}.\n"
            f"       Run 'bender update' to fetch the checkouts."
        )

    defines = {}
    for line in lines:
        if line.startswith("+define+"):
            name, _, value = line[len("+define+") :].partition("=")
            defines[name] = int(value) if value else 1

    includes = [
        Path(line[len("+incdir+") :])
        for line in lines
        if line.startswith("+incdir+")
    ]

    return files, defines, includes


# -----------------------------------------------------------------------------
# The environment
# -----------------------------------------------------------------------------


def use_verilator() -> tuple[str, str]:
    """Put the Verilator to use on the PATH, checked against what cocotb needs.

    The Verilator of the distribution is used unless DOLUNAY_VERILATOR points
    at another one, which is how a newer one is used on a machine whose
    distribution ships an older one.

    Returns the path of the Verilator and its version.
    """
    candidates = []
    if VERILATOR_HOME:
        candidates += [
            Path(VERILATOR_HOME) / "bin" / "verilator",
            Path(VERILATOR_HOME) / "usr" / "bin" / "verilator",
        ]
    on_path = shutil.which("verilator")
    if on_path:
        candidates.append(Path(on_path))

    for candidate in candidates:
        if not candidate.is_file():
            continue
        version = subprocess.run(
            [str(candidate), "--version"], capture_output=True, text=True, check=True
        ).stdout
        # "Verilator 5.046 2026-02-28 rev fedora-5.046"
        numbers = tuple(int(part) for part in version.split()[1].split("."))
        if numbers < MIN_VERILATOR:
            raise SystemExit(
                f"ERROR: {candidate} is Verilator {version.split()[1]}, which is too\n"
                f"       old for cocotb 2.x. {MIN_VERILATOR[0]}.{MIN_VERILATOR[1]:03d} or\n"
                f"       later is needed."
            )
        # The build finds the Verilator on the PATH, so put it in front of
        # it.
        os.environ["PATH"] = (
            f"{candidate.parent}{os.pathsep}{os.environ.get('PATH', '')}"
        )
        return str(candidate), version.split()[1]

    raise SystemExit(
        "ERROR: verilator not found.\n"
        "       It has to be on the PATH, or DOLUNAY_VERILATOR has to point at\n"
        "       one. See pytb/README.md."
    )


def in_virtualenv() -> bool:
    """Whether this is the interpreter of the virtualenv.

    cocotb is only importable with it.
    """
    try:
        import cocotb_tools.runner  # noqa: F401
    except ImportError:
        return False
    return True


def use_virtualenv() -> None:
    """Re-run this script with the virtualenv's Python.

    cocotb is installed in a virtualenv, so the script has to run with that
    interpreter. Doing it here means the user does not have to activate the
    virtualenv first.
    """
    python = VENV / "bin" / "python"
    if not python.is_file():
        raise SystemExit(
            f"ERROR: cocotb is not installed in {VENV}.\n"
            f"       See pytb/README.md for how to set it up."
        )
    os.execv(str(python), [str(python), str(Path(__file__).resolve()), *sys.argv[1:]])


# -----------------------------------------------------------------------------
# Running
# -----------------------------------------------------------------------------


def build_fingerprint(verilator: str) -> dict[str, str]:
    """What the build tree depends on.

    The makefile Verilator generates points at the cocotb sources of the
    virtualenv, so a build tree is only good for the toolchain it was made
    with. The fingerprint is written into the build tree, and the tree is
    thrown away when it does not match.
    """
    import cocotb

    return {
        "venv": str(VENV),
        "python": ".".join(str(part) for part in sys.version_info[:3]),
        "cocotb": cocotb.__version__,
        "verilator": verilator,
    }


def prepare_build_tree(build_dir: Path, fingerprint: dict[str, str]) -> None:
    """Throw the build tree away when it was made with another toolchain."""
    marker = build_dir / MARKER_NAME
    if build_dir.is_dir():
        recorded = None
        if marker.is_file():
            try:
                recorded = json.loads(marker.read_text())
            except (OSError, ValueError):
                pass
        if recorded == fingerprint:
            return
        print(f"the toolchain changed, rebuilding in {build_dir}", flush=True)
        shutil.rmtree(build_dir, ignore_errors=True)

    build_dir.mkdir(parents=True, exist_ok=True)


def mark_build_tree(build_dir: Path, fingerprint: dict[str, str]) -> None:
    """Record the toolchain the build tree was made with.

    It is written after the build, so that a build that failed is thrown
    away by the next run instead of being taken for a good one.
    """
    (build_dir / MARKER_NAME).write_text(
        json.dumps(fingerprint, indent=2, sort_keys=True) + "\n"
    )


def run_testbench(
    testbench: Testbench, args: argparse.Namespace, verilator: str
) -> tuple[int, int]:
    """Build and run one testbench.

    Returns the number of tests and the number of failures.
    """
    from cocotb_tools.check_results import get_results
    from cocotb_tools.runner import get_runner

    build_dir = BUILD_ROOT / testbench.name
    fingerprint = build_fingerprint(verilator)
    prepare_build_tree(build_dir, fingerprint)

    runner = get_runner("verilator")
    sources, defines, includes = testbench.build_inputs()
    runner.build(
        sources=[str(source) for source in sources],
        defines=defines,
        includes=[str(include) for include in includes],
        hdl_toplevel=testbench.toplevel,
        # --timing is how the SystemVerilog flow builds too: it tells
        # Verilator what to do with the event controls it cannot work out
        # statically, such as the wait for a clock edge in an initial block.
        build_args=["-Wno-fatal", "--timing"],
        build_dir=build_dir,
        always=True,
        waves=args.waves,
        verbose=args.verbose,
    )
    mark_build_tree(build_dir, fingerprint)

    # The tests are in the testbench's own folder, and the simulator imports
    # them from there, so the folder has to be on the import path.
    folder = str(testbench.folder)
    if folder not in sys.path:
        sys.path.insert(0, folder)

    # The seed of the testbench, if it has one, is the seed of cocotb too.
    seed = testbench.option(args, "seed")
    if seed is not None:
        seed = str(seed)

    results = runner.test(
        hdl_toplevel=testbench.toplevel,
        test_module=testbench.module,
        build_dir=build_dir,
        waves=args.waves,
        seed=seed,
        extra_env=test_environment(testbench, args),
        verbose=args.verbose,
    )

    try:
        return get_results(results)
    except RuntimeError as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 0, 1


def test_environment(
    testbench: Testbench, args: argparse.Namespace
) -> dict[str, str]:
    """The environment a testbench is run with.

    The options of the testbench are handed over in the environment, one
    variable each, named after the testbench and the option. The testbench
    knows the names, because they follow from the name of the testbench and
    the name of the option.
    """
    environment = {"DOLUNAY_TESTBENCH": testbench.name}
    for name, option in testbench.options.items():
        value = testbench.option(args, name)
        if option.type == "flag":
            environment[testbench.option_env(name)] = "1" if value else "0"
        elif value is not None:
            environment[testbench.option_env(name)] = str(value)
    return environment


def clean() -> None:
    """Remove the build trees."""
    if BUILD_ROOT.is_dir():
        print(f"removing {BUILD_ROOT}")
        shutil.rmtree(BUILD_ROOT, ignore_errors=True)
    else:
        print(f"nothing to remove in {BUILD_ROOT}")


# -----------------------------------------------------------------------------
# The command line
# -----------------------------------------------------------------------------


def add_testbench_options(
    parser: argparse.ArgumentParser, testbenches: list[Testbench]
) -> None:
    """Add the options the testbenches declare.

    The option of a testbench is named after it, so that the options of two
    testbenches do not collide: --fu_lsu+mode.
    """
    for testbench in testbenches:
        for name, option in testbench.options.items():
            flag = f"--{testbench.name}+{name}"
            dest = f"opt_{testbench.name}_{name}"
            if option.type == "flag":
                parser.add_argument(
                    flag,
                    dest=dest,
                    action="store_true",
                    default=False,
                    help=option.help,
                )
            else:
                parser.add_argument(
                    flag,
                    dest=dest,
                    type=OPTION_TYPES[option.type],
                    default=option.default,
                    choices=option.values or None,
                    metavar=_metavar(option),
                    help=option.help,
                )


def _metavar(option: Option) -> str:
    """What the value of an option is called on the command line."""
    if option.values:
        return "{" + ",".join(option.values) + "}"
    return "N" if option.type == "int" else "VALUE"


def options_help(testbenches: list[Testbench]) -> str:
    """The options of the testbenches, for the help of the command line."""
    lines = []
    for testbench in testbenches:
        for name, option in testbench.options.items():
            lines.append(f"  --{testbench.name}+{name}  {option.help}")
    if not lines:
        return ""
    return "The options of the testbenches:\n" + "\n".join(lines)


def parse_args(
    argv: list[str], testbenches: list[Testbench]
) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run the cocotb testbenches of the project.",
        epilog=options_help(testbenches),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "testbenches",
        nargs="*",
        metavar="TESTBENCH",
        help="the testbenches to run; all of them by default",
    )
    parser.add_argument(
        "--list", action="store_true", help="list the testbenches and exit"
    )
    parser.add_argument(
        "--waves", action="store_true", help="dump a waveform trace"
    )
    parser.add_argument(
        "--clean", action="store_true", help="remove the build trees and exit"
    )
    parser.add_argument(
        "--runall", action="store_true", help="run all the tests, even those with autorun=false"
    )
    parser.add_argument(
        "-v", "--verbose", action="store_true", help="say what the tools are doing"
    )
    add_testbench_options(parser, testbenches)
    return parser.parse_args(argv)


def main(argv: list[str]) -> int:
    # The metadata is read with tomllib, which is Python 3.11 and later, and
    # cocotb is only importable with the virtualenv's interpreter. So the
    # first thing that happens is a hand over to the virtualenv.
    if not in_virtualenv():
        use_virtualenv()
        return 0  # not reached, execv does not return

    try:
        import tomllib  # noqa: F401
    except ImportError:
        raise SystemExit(
            f"ERROR: reading the testbench metadata needs Python 3.11 or later,\n"
            f"       for tomllib. The virtualenv in {VENV} has "
            f"{sys.version.split()[0]}."
        ) from None

    # The options of the testbenches are in their metadata, so the
    # testbenches have to be found before the command line is parsed.
    testbenches = discover_testbenches()
    if not testbenches:
        raise SystemExit(
            f"ERROR: no testbench found in {PYTB_DIR}.\n"
            f"       A testbench is a folder with a {METADATA_NAME} in it."
        )

    args = parse_args(argv, testbenches)

    if args.list:
        for testbench in testbenches:
            print(f"{testbench.name:<12} {testbench.description}")
        return 0

    if args.clean:
        clean()
        return 0

    selected = testbenches if args.runall else [t for t in testbenches if t.autorun]
    if args.testbenches:
        known = {testbench.name: testbench for testbench in testbenches}
        unknown = [name for name in args.testbenches if name not in known]
        if unknown:
            print(
                f"ERROR: unknown testbench: {', '.join(unknown)}\n"
                f"       Run with --list to see them.",
                file=sys.stderr,
            )
            return 2
        selected = [known[name] for name in args.testbenches]

    _, verilator = use_verilator()  # fails with a helpful message if it is not there

    total_tests = 0
    total_failures = 0
    for testbench in selected:
        print(f"\n=== {testbench.name}: {testbench.description} ===", flush=True)
        tests, failures = run_testbench(testbench, args, verilator)
        total_tests += tests
        total_failures += failures

    print()
    print("=" * 49)
    if total_failures:
        print(
            f" pytb: {len(selected)} testbenches, {total_tests} tests, "
            f"{total_failures} FAILURES"
        )
    else:
        print(
            f" pytb: {len(selected)} testbenches, {total_tests} tests, 0 failures"
        )
    print("=" * 49)
    return 1 if total_failures else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
