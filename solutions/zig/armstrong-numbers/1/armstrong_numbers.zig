const std = @import("std");
const mem = std.mem;

pub fn isArmstrongNumber(num: u128) bool {
    var digits = [_]u128{0} ** 64;
    var divided = num;

    var i: u32 = 0;
    while (divided >= 10) : (i += 1) {
        digits[i] = divided % 10;
        divided /= 10;
    }
    digits[i] = divided % 10;

    std.mem.reverse(u128, digits[0..]);

    var total: u128 = 0;
    for (digits.len - i - 1..digits.len) |index| {
        total += std.math.pow(u128, digits[index], i + 1);
    }

    return total == num;
}