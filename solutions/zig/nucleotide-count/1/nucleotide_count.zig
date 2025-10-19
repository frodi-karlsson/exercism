const std = @import("std");

pub const NucleotideError = error{Invalid};

pub const Counts = struct {
    a: u32,
    c: u32,
    g: u32,
    t: u32,
};

const fields = @typeInfo(Counts).@"struct".fields;

pub fn countNucleotides(s: []const u8) NucleotideError!Counts {
    var counts = Counts{ .a=0, .c=0, .g=0, .t=0 };
    for (s) |c| {
        switch (std.ascii.toLower(c)) {
            'a' => counts.a += 1,
            'c' => counts.c += 1,
            'g' => counts.g += 1,
            't' => counts.t += 1,
            else => return NucleotideError.Invalid,
        }
    }
    return counts;
}
