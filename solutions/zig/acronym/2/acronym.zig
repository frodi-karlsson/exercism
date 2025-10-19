const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var out = try std.ArrayList(u8).initCapacity(allocator, 3);
    defer out.deinit(allocator);

    var it = mem.tokenizeAny(u8, words, " -,_");

    while (it.next()) |w| {
        try out.append(allocator, std.ascii.toUpper(w[0]));
    }

    return out.toOwnedSlice(allocator);
}