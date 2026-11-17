//! Builds the Dolunay golden model. The model has no architectural code yet;
//! this file builds its module, Berkeley SoftFloat, and the tests.
//!
//!     zig build test

const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const softfloat = try addSoftFloat(b, target, optimize);

    const dolunay = b.addModule("dolunay", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    dolunay.addImport("softfloat", softfloat.headers);
    dolunay.linkLibrary(softfloat.lib);

    const tests = b.addTest(.{ .root_module = dolunay });
    const test_step = b.step("test", "Run the model's tests");
    test_step.dependOn(&b.addRunArtifact(tests).step);
}

const SoftFloat = struct {
    lib: *std.Build.Step.Compile,
    headers: *std.Build.Module,
};

/// Berkeley SoftFloat, pinned in build.zig.zon, compiled from its own
/// `build/Linux-x86_64-GCC` recipe with one change: the specialization is
/// `RISCV`, which gives RISC-V's canonical NaN (RISC-V unprivileged ISA,
/// "F" Standard Extension, "NaN Generation and Propagation").
///
/// The upstream Makefile is the authority for the file list and the flags;
/// the file list is read from it rather than copied here.
fn addSoftFloat(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.Optimize,
) !SoftFloat {
    const dep = b.dependency("softfloat", .{});
    const recipe = "build/Linux-x86_64-GCC";
    const specialization = "source/RISCV";

    // SOFTFLOAT_OPTS and COMPILE_C from the recipe's Makefile.
    const flags: []const []const u8 = &.{
        "-DSOFTFLOAT_FAST_INT64",
        "-DSOFTFLOAT_ROUND_ODD",
        "-DINLINE_LEVEL=5",
        "-DSOFTFLOAT_FAST_DIV32TO16",
        "-DSOFTFLOAT_FAST_DIV64TO32",
        "-Werror-implicit-function-declaration",
    };

    const objs = try readMakefileObjects(b, dep, recipe ++ "/Makefile");

    const mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    mod.addIncludePath(dep.path(recipe));
    mod.addIncludePath(dep.path(specialization));
    mod.addIncludePath(dep.path("source/include"));
    mod.addCSourceFiles(.{ .root = dep.path("source"), .files = objs.generic, .flags = flags });
    mod.addCSourceFiles(.{ .root = dep.path(specialization), .files = objs.specialized, .flags = flags });

    const lib = b.addLibrary(.{ .name = "softfloat", .root_module = mod });

    const headers = b.addTranslateC(.{
        .root_source_file = dep.path("source/include/softfloat.h"),
        .target = target,
        .optimize = optimize,
    });
    headers.addIncludePath(dep.path("source/include"));

    return .{ .lib = lib, .headers = headers.createModule() };
}

const MakefileObjects = struct {
    /// OBJS_PRIMITIVES and OBJS_OTHERS: `source/<name>.c`.
    generic: []const []const u8,
    /// OBJS_SPECIALIZE: `source/<specialization>/<name>.c`.
    specialized: []const []const u8,
};

/// Reads the three object lists of SoftFloat's Makefile. Each list starts with
/// `OBJS_<NAME> = \` and has one `  <name>$(OBJ) \` per line.
fn readMakefileObjects(b: *std.Build, dep: *std.Build.Dependency, sub_path: []const u8) !MakefileObjects {
    const text = try std.Io.Dir.cwd().readFileAlloc(
        b.graph.io,
        try dep.builder.root.joinString(b.allocator, sub_path),
        b.allocator,
        .limited(1 << 20),
    );

    var generic: std.ArrayList([]const u8) = .empty;
    var specialized: std.ArrayList([]const u8) = .empty;
    var list: ?*std.ArrayList([]const u8) = null;

    var lines = std.mem.splitScalar(u8, text, '\n');
    while (lines.next()) |line| {
        if (std.mem.startsWith(u8, line, "OBJS_PRIMITIVES =") or
            std.mem.startsWith(u8, line, "OBJS_OTHERS ="))
        {
            list = &generic;
        } else if (std.mem.startsWith(u8, line, "OBJS_SPECIALIZE =")) {
            list = &specialized;
        } else if (line.len == 0 or line[0] != ' ') {
            list = null;
        } else if (list) |l| {
            const entry = std.mem.trim(u8, line, " \\");
            const name = std.mem.cutSuffix(u8, entry, "$(OBJ)") orelse
                std.debug.panic("unexpected line in {s}: {q}", .{ sub_path, line });
            try l.append(b.allocator, b.fmt("{s}.c", .{name}));
        }
    }

    if (generic.items.len == 0 or specialized.items.len == 0)
        std.debug.panic("no object lists found in {s}", .{sub_path});
    return .{ .generic = generic.items, .specialized = specialized.items };
}
