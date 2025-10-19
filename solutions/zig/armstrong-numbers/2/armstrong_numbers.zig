const std = @import("std");
const mem = std.mem;

pub fn isArmstrongNumber(num: u128) bool {
    var digits = [_]u4{0} ** 39; // max digits for u128 in dec
    var divided = num;

    var i: u32 = 0;
    while (divided >= 10) : (i += 1) {
        digits[i] = @truncate(divided % 10);
        divided /= 10;
    }
    digits[i] = @truncate(divided % 10);

    var total: u128 = 0;
    for (0..i + 1) |index| {
        total += std.math.pow(u128, digits[index], i + 1);
    }

    return total == num;
}