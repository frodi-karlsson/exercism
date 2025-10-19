const std = @import("std");
const mem = std.mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    var arrayList = try std.ArrayList(u8).initCapacity(allocator, 128);

    for (dna) |nucleotide| {
        try arrayList.append(allocator, switch (nucleotide) {
            'C' => 'G',
            'G' => 'C',
            'T' => 'A',
            'A' => 'U',
            else => unreachable,
        });
    }

    return arrayList.toOwnedSlice(allocator);
}