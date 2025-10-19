const std = @import("std");
const mem = std.mem;

pub fn isArmstrongNumber(num: u128) bool {
    var digits: [39]u4 = undefined; // max digits for u128 in dec
    var divided = num;

    var i: u32 = 0;
    while (divided > 0) : (i += 1) {
        digits[i] = @truncate(divided % 10);
        divided /= 10;
    }

    var total: u128 = 0;
    for (0..i) |index| {
        total += std.math.pow(u128, digits[index], i);
    }

    return total == num;
}