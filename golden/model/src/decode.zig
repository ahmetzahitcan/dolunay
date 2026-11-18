//! Instruction decode: finds the row of `control_unit/control_unit.csv` whose
//! pattern matches an instruction word. Only the CSV's `instruction` and
//! `match_string` columns are read (CONTRACT.md §3).
//!
//! Rows for custom instructions are the previous variant's encodings:
//! placeholders until `spec/` specifies them (CONTRACT.md §3).

const std = @import("std");

const csv_rows: []const Row = parse(@embedFile("control_unit.csv"));

/// One field per decode row of the CSV, named by its `instruction` column, in
/// the CSV's order.
pub const Instruction = blk: {
    const Tag = std.math.IntFittingRange(0, csv_rows.len - 1);
    var names: [csv_rows.len][]const u8 = undefined;
    for (csv_rows, &names) |row, *name| name.* = row.name;
    break :blk @Enum(Tag, .exhaustive, &names, &std.simd.iota(Tag, csv_rows.len));
};

pub const Pattern = struct {
    instruction: Instruction,
    mask: u32,
    match: u32,

    fn fixedBits(p: Pattern) u32 {
        return @popCount(p.mask);
    }

    fn matches(p: Pattern, word: u32) bool {
        return word & p.mask == p.match;
    }
};

/// Every decode row of the CSV, most fixed bits first.
pub const patterns: []const Pattern = blk: {
    var unsorted: [csv_rows.len]Pattern = undefined;
    for (csv_rows, &unsorted, 0..) |row, *p, i| {
        p.* = .{ .instruction = @fromBackingInt(@intCast(i)), .mask = row.mask, .match = row.match };
    }
    const sorted = sortByFixedBits(&unsorted);
    checkOverlaps(sorted);
    break :blk sorted;
};

/// The instruction whose pattern matches `word`, or null if none does. When
/// several match, the one with the most fixed bits wins (CONTRACT.md §3).
pub fn decode(word: u32) ?Instruction {
    for (patterns) |p| {
        if (p.matches(word)) return p.instruction;
    }
    return null;
}

/// A decode row of the CSV: its `instruction` and `match_string` columns.
const Row = struct {
    name: []const u8,
    mask: u32,
    match: u32,
};

fn parse(comptime csv: []const u8) []const Row {
    @setEvalBranchQuota(1_000_000);
    comptime {
        var rows: []const Row = &.{};
        var lines = std.mem.splitScalar(u8, csv, '\n');
        _ = lines.next(); // header
        while (lines.next()) |line| {
            var fields = Fields{ .rest = std.mem.trimEnd(u8, line, "\r") };
            const name = fields.next();
            // An empty name is a spacer row; `'` comments a row out; `~` only
            // declares enum values (CONTRACT.md §3).
            if (name.len == 0 or name[0] == '\'' or name[0] == '~') continue;
            rows = rows ++ .{parseRow(name, fields.next())};
        }
        return rows;
    }
}

/// A `match_string` holds instruction bits 31..2, most significant first, as
/// `0`, `1` or `?`, with `_` as a separator. Bits 1..0 are `11`, which every
/// 32-bit instruction has (RISC-V unprivileged ISA, "Base Instruction-Length
/// Encoding"); Dolunay has 32-bit instructions only (CONTRACT.md §2).
fn parseRow(comptime name: []const u8, comptime match_string: []const u8) Row {
    var mask: u32 = 0b11;
    var match: u32 = 0b11;
    var bit: u32 = 32;
    for (match_string) |c| {
        if (c == '_') continue;
        if (bit == 2) @compileError("control_unit.csv: " ++ name ++ ": match_string is longer than 30 bits");
        bit -= 1;
        switch (c) {
            '0' => mask |= 1 << bit,
            '1' => {
                mask |= 1 << bit;
                match |= 1 << bit;
            },
            '?' => {},
            else => @compileError("control_unit.csv: " ++ name ++ ": bad character in match_string"),
        }
    }
    if (bit != 2) @compileError("control_unit.csv: " ++ name ++ ": match_string is shorter than 30 bits");
    return .{ .name = name, .mask = mask, .match = match };
}

fn sortByFixedBits(comptime rows: []const Pattern) []const Pattern {
    @setEvalBranchQuota(1_000_000);
    var sorted: [rows.len]Pattern = rows[0..rows.len].*;
    // Insertion sort: stable, so equally specific rows keep the CSV's order.
    for (1..sorted.len) |i| {
        const p = sorted[i];
        var j = i;
        while (j > 0 and sorted[j - 1].fixedBits() < p.fixedBits()) : (j -= 1) {
            sorted[j] = sorted[j - 1];
        }
        sorted[j] = p;
    }
    const result = sorted;
    return &result;
}

/// Two overlapping patterns with equally many fixed bits are an error in the
/// CSV (CONTRACT.md §3).
fn checkOverlaps(comptime rows: []const Pattern) void {
    @setEvalBranchQuota(1_000_000);
    for (rows, 0..) |a, i| {
        for (rows[i + 1 ..]) |b| {
            const overlap = (a.match ^ b.match) & a.mask & b.mask == 0;
            if (overlap and a.fixedBits() == b.fixedBits())
                @compileError("control_unit.csv: " ++ @tagName(a.instruction) ++ " and " ++
                    @tagName(b.instruction) ++
                    " overlap with equally many fixed bits");
        }
    }
}

/// Reads the comma-separated fields of one CSV line. A field may be quoted;
/// a quoted field may contain commas. Doubled quotes are not handled: the
/// first two columns never contain one.
const Fields = struct {
    rest: []const u8,

    fn next(f: *Fields) []const u8 {
        if (f.rest.len > 0 and f.rest[0] == '"') {
            const end = std.mem.indexOfScalarPos(u8, f.rest, 1, '"') orelse
                @compileError("control_unit.csv: unterminated quote");
            const field = f.rest[1..end];
            f.rest = f.rest[end + 1 ..];
            if (f.rest.len > 0) f.rest = f.rest[1..]; // the comma
            return field;
        }
        const end = std.mem.indexOfScalar(u8, f.rest, ',') orelse f.rest.len;
        const field = f.rest[0..end];
        f.rest = if (end < f.rest.len) f.rest[end + 1 ..] else "";
        return field;
    }
};

// The words below are encoded by hand from the RISC-V unprivileged ISA's base
// opcode map and instruction formats; they test the reading of the CSV.

test "decode: add x1, x2, x3 is ADD" {
    // R-type: funct7=0000000 rs2=3 rs1=2 funct3=000 rd=1 opcode=OP (0110011).
    try std.testing.expectEqual(Instruction.ADD, decode(0x003100B3).?);
}

test "decode: sub x1, x2, x3 is SUB" {
    // As ADD, with funct7=0100000.
    try std.testing.expectEqual(Instruction.SUB, decode(0x403100B3).?);
}

test "decode: addi x1, x0, 1 is ADDI" {
    // I-type: imm=1 rs1=0 funct3=000 rd=1 opcode=OP-IMM (0010011).
    try std.testing.expectEqual(Instruction.ADDI, decode(0x00100093).?);
}

test "decode: jal x0, 0 is JAL" {
    // J-type: imm=0 rd=0 opcode=JAL (1101111).
    try std.testing.expectEqual(Instruction.JAL, decode(0x0000006F).?);
}

test "decode: a 16-bit encoding matches nothing" {
    // Bits 1..0 = 01: not a 32-bit instruction.
    try std.testing.expectEqual(@as(?Instruction, null), decode(0x0000_0001));
}

test "decode: the more specific of two overlapping patterns wins" {
    // slti x0, x0, 0 matches both SLTI and the CSV's WDONE row, which has
    // every bit fixed.
    try std.testing.expectEqual(Instruction.WDONE, decode(0x00002013).?);
    // slti x1, x0, 0 matches SLTI only.
    try std.testing.expectEqual(Instruction.SLTI, decode(0x00002093).?);
}
