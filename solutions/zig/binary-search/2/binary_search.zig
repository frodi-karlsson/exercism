const std = @import("std");

pub fn binarySearch(numType: type, target: numType, items: []const numType) ?usize {
    if (items.len == 0) return null;

    var max: usize = items.len - 1;
    var min: usize = 0;
    var curr = items.len / 2;

    while (min <= max) {
        curr = min + (max - min) / 2;
        const val = items[curr];

        if (val == target) return curr;
        if (curr == 0 or curr == items.len - 1) break;
        if (val < target) min = curr + 1 else max = curr - 1;
    }
    return null;
}