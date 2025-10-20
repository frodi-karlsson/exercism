const std = @import("std");

pub fn binarySearch(numType: type, target: numType, items: []const numType) ?usize {
    if (items.len == 0) return null;

    var max: f32 = @floatFromInt(items.len - 1);
    var min: f32 = 0;
    var curr = @divFloor(items.len, 2);

    while (min <= max) : (curr = @intFromFloat(min + @floor(max / 2 - min / 2))) {
        const val = items[curr];
        if (val == target) {
            return curr;
        }

        if (val < target) {
            if (curr >= items.len - 1) break;
            min = @floatFromInt(curr + 1);
        } else {
            if (curr <= 0) break;
            max = @floatFromInt(curr - 1);
        }
    }
    return null;
}