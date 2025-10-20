const std = @import("std");
const mem = std.mem;

pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var set = std.BufSet.init(allocator);
    errdefer set.deinit();

    var count = std.mem.zeroes([26]usize);

    for (word) |char| {
        count[std.ascii.toLower(char) - 'a'] += 1;
    }

    outer: for (candidates) |candidate| {
        if (candidate.len != word.len) continue;
        if (std.ascii.eqlIgnoreCase(candidate, word)) continue;

        var candCount = std.mem.zeroes([26]usize);
        for (candidate) |char| {
            const index = std.ascii.toLower(char) - 'a';
            candCount[index] += 1;
            if (candCount[index] > count[index]) continue :outer;
        }

        for (candCount, 0..) |candCountEl, index| {
            if (count[index] != candCountEl) continue :outer;
        }

        try set.insert(candidate);
    }

    return set;
}