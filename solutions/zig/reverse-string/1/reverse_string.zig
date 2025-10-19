const std = @import("std");
/// Writes a reversed copy of `s` to `buffer`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    var i = s.len;
    while (i > 0) : (i -= 1) {
        buffer[s.len - i] = s[i - 1];
    }

    return buffer[0..s.len];
}