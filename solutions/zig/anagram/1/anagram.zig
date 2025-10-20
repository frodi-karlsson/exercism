const std = @import("std");
const mem = std.mem;

fn eql(a: []const u8, b: []const u8) bool {
    if (a.len != b.len) return false;
    if (&a == &b) return true;

    for (a, b) |aEl, bEl| {
        if (std.ascii.toLower(aEl) != std.ascii.toLower(bEl)) return false;
    }

    return true;
}

pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var set = std.BufSet.init(allocator);
    errdefer set.deinit();

    const sorted = try allocator.alloc(u8, word.len);
    defer allocator.free(sorted);

    for (word, 0..) |char, index| {
        sorted[index] = std.ascii.toLower(char);
    }

    std.sort.block(u8, sorted, {}, std.sort.asc(u8));

    for (candidates) |candidate| {
        if (candidate.len != word.len) continue;
        if (eql(candidate, word)) continue;
        const sortedCandidate = try allocator.alloc(u8, word.len);
        defer allocator.free(sortedCandidate);

        for (candidate, 0..) |char, index| {
            sortedCandidate[index] = std.ascii.toLower(char);
        }

        std.sort.block(u8, sortedCandidate, {}, std.sort.asc(u8));

        if (eql(sorted, sortedCandidate)) try set.insert(candidate);
    }

    return set;
}