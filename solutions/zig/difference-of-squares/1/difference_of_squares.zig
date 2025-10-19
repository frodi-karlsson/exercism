const std = @import("std");

pub fn squareOfSum(number: usize) usize {
    const sqrt = number * (number + 1) / 2;
    return sqrt * sqrt;
}

pub fn sumOfSquares(number: usize) usize {
    return number * (number + 1) * (2 * number + 1) / 6;
}

pub fn differenceOfSquares(number: usize) usize {
    const signed: isize = @intCast(number);
    const square = signed * signed;
    return @intCast(@abs(@divTrunc((3 * square + 2 * signed) * (1 - square), 12)));
}