const std = @import("std");
pub fn isIsogram(str: []const u8) bool {
    var usageMap = [1]u2{ 0 } ** 26;
    for (str) |char| {
        switch (char) {
            '-' => continue,
            ' ' => continue,
            else => {
                const index = std.ascii.toLower(char) - 'a';
                if (usageMap[index] > 0) return false;
                usageMap[index] += 1;
            },
        }
    }
    return true;
}
