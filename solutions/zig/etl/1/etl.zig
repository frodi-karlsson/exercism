const std = @import("std");
const mem = std.mem;

pub fn transform(allocator: mem.Allocator, legacy: std.AutoHashMap(i5, []const u8)) mem.Allocator.Error!std.AutoHashMap(u8, i5) {
    var it = legacy.iterator();
    var new = std.AutoHashMap(u8, i5).init(allocator);
    while (it.next()) |legacyEntry| {
        for (legacyEntry.value_ptr.*) |char| {
            try new.put(std.ascii.toLower(char), legacyEntry.key_ptr.*);
        }
    }
    return new;
}