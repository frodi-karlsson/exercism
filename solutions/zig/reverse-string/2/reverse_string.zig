const std = @import("std");
/// Writes a reversed copy of `s` to `buffer`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    for (s, 1..) |char, index| {
        buffer[s.len - index] = char;
    }

    return buffer[0..s.len];
}