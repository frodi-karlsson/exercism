const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var set = std.AutoHashMap(u32, void).init(allocator);
    defer set.deinit();

    var total: u64 = 0;

    for (factors) |factor| {
        var current: u32 = factor;
        while (current < limit) {
            if (!set.contains(current)) {
                total += current;
                try set.put(current, {});
            }
            current += factor;
            if (current == 0) break;
        }
    }

    return total;
}