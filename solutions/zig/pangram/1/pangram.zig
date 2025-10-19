const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    if (str.len < 26) return false;

    var found = [1]bool{false} ** 26;
    for (str) |char| {
        const asLower = std.ascii.toLower(char);
        if (asLower < 'a' or asLower > 'z') continue;
        const index = asLower - 'a';
        found[index] = true;
    }

    for (found) |alpha| {
        if (alpha == false) return false;
    }
    return true;
}
