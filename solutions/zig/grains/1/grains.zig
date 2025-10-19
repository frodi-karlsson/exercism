const std = @import("std");

pub const ChessboardError = error{ IndexOutOfBounds };

pub fn square(index: usize) ChessboardError!u64 {
    return if (index > 64 or index < 1) ChessboardError.IndexOutOfBounds else std.math.pow(usize, 2, index - 1);
}

pub fn total() u64 {
    return std.math.maxInt(u64);
}