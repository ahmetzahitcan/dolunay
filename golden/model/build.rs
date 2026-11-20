//! Builds Berkeley SoftFloat from the `berkeley-softfloat-3` submodule, and the
//! shim the model calls it through (`c/softfloat_shim.c`).
//!
//! SoftFloat is compiled from its own `build/Linux-x86_64-GCC` recipe with one
//! change: the specialization is `RISCV`, which gives RISC-V's canonical NaN
//! (RISC-V unprivileged ISA, "F" Standard Extension, "NaN Generation and
//! Propagation"). The recipe's Makefile is the authority for the file list and
//! the flags; the file list is read from it rather than copied here.

use std::path::{Path, PathBuf};

const RECIPE: &str = "build/Linux-x86_64-GCC";
const SPECIALIZATION: &str = "source/RISCV";

fn main() {
    let root = PathBuf::from(std::env::var("CARGO_MANIFEST_DIR").unwrap()).join("berkeley-softfloat-3");
    let makefile = root.join(RECIPE).join("Makefile");
    if !makefile.exists() {
        panic!(
            "{} is missing: the SoftFloat submodule is not checked out. Run `git submodule update --init`.",
            makefile.display()
        );
    }
    println!("cargo::rerun-if-changed=berkeley-softfloat-3");
    println!("cargo::rerun-if-changed=c/softfloat_shim.c");

    let objects = read_makefile_objects(&makefile);

    let mut build = cc::Build::new();
    build
        .include(root.join(RECIPE))
        .include(root.join(SPECIALIZATION))
        .include(root.join("source/include"))
        // SOFTFLOAT_OPTS and COMPILE_C from the recipe's Makefile, plus
        // thread-local state: each host thread gets its own rounding mode and
        // exception flags, so tests running on several host threads cannot
        // see each other's.
        .define("THREAD_LOCAL", "_Thread_local")
        .define("SOFTFLOAT_FAST_INT64", None)
        .define("SOFTFLOAT_ROUND_ODD", None)
        .define("INLINE_LEVEL", "5")
        .define("SOFTFLOAT_FAST_DIV32TO16", None)
        .define("SOFTFLOAT_FAST_DIV64TO32", None)
        .flag("-Werror-implicit-function-declaration")
        .warnings(false);
    for name in &objects.generic {
        build.file(root.join("source").join(name));
    }
    for name in &objects.specialized {
        build.file(root.join(SPECIALIZATION).join(name));
    }
    build.file("c/softfloat_shim.c");
    build.compile("softfloat");
}

struct MakefileObjects {
    /// OBJS_PRIMITIVES and OBJS_OTHERS: `source/<name>.c`.
    generic: Vec<String>,
    /// OBJS_SPECIALIZE: `source/<specialization>/<name>.c`.
    specialized: Vec<String>,
}

/// Reads the three object lists of SoftFloat's Makefile. Each list starts with
/// `OBJS_<NAME> = \` and has one `  <name>$(OBJ) \` per line.
fn read_makefile_objects(path: &Path) -> MakefileObjects {
    let text = std::fs::read_to_string(path).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
    let mut objects = MakefileObjects { generic: Vec::new(), specialized: Vec::new() };
    let mut list: Option<&mut Vec<String>> = None;

    for line in text.lines() {
        if line.starts_with("OBJS_PRIMITIVES =") || line.starts_with("OBJS_OTHERS =") {
            list = Some(&mut objects.generic);
        } else if line.starts_with("OBJS_SPECIALIZE =") {
            list = Some(&mut objects.specialized);
        } else if !line.starts_with(' ') {
            list = None;
        } else if let Some(list) = list.as_mut() {
            let entry = line.trim_matches(|c| c == ' ' || c == '\\');
            let name = entry
                .strip_suffix("$(OBJ)")
                .unwrap_or_else(|| panic!("unexpected line in {}: {line:?}", path.display()));
            list.push(format!("{name}.c"));
        }
    }

    if objects.generic.is_empty() || objects.specialized.is_empty() {
        panic!("no object lists found in {}", path.display());
    }
    objects
}
