const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var out = try allocator.alloc(u8, 0);
    var it = mem.tokenizeAny(u8, words, " -,_");

    var i: u8 = 0;
    while (it.next()) |w| : (i += 1) {
        if (out.len <= i) out = try allocator.realloc(out, i + 1);
        out[i] = std.ascii.toUpper(w[0]);
    }

    return out[0..i];
}