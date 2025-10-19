const std = @import("std");
const mem = std.mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    var out = try allocator.alloc(u8, dna.len);

    for (dna, 0..) |nucleotide, index| {
        out[index] = switch (nucleotide) {
            'C' => 'G',
            'G' => 'C',
            'T' => 'A',
            'A' => 'U',
            else => unreachable,
        };
    }

    return out[0..];
}