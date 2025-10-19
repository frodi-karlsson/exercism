const std = @import("std");
const mem = std.mem;

pub const ColorBand = enum(u4) {
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9,
};

fn format(allocator: mem.Allocator, input: [2]u8, zeroes: u8) mem.Allocator.Error![]u8 {
    var str = try std.ArrayList(u8).initCapacity(allocator, 6);
    defer str.deinit(allocator);

    const left = input[0];
    const right = input[1];

    const shouldHaveLeft = left > 0;
    if (shouldHaveLeft) {
        try str.append(allocator, input[0] + '0');
    }

    const isDotNotation = zeroes % 3 == 2;
    const shouldHaveDot = isDotNotation and right > 0;
    if (shouldHaveDot) {
        try str.append(allocator, '.');
    }

    const shouldHaveRight = !isDotNotation or right > 0;
    if (shouldHaveRight) {
        try str.append(allocator, right + '0');
    }

    const shouldHaveTrailingZero = zeroes % 3 == 1;
    if (shouldHaveTrailingZero) try str.append(allocator, '0');

    try str.append(allocator, ' ');

    const prefix = switch (zeroes) {
        2, 3, 4 => "kilo",
        5, 6, 7 => "mega",
        8, 9 => "giga",
        else => null,
    };
    if (prefix != null) {
        try str.appendSlice(allocator, prefix.?);
    }
    try str.appendSlice(allocator, "ohms");
    return try str.toOwnedSlice(allocator);
}

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    const left = @intFromEnum(colors[0]);
    const right = @intFromEnum(colors[1]);
    const zeroes = @intFromEnum(colors[2]);

    return format(allocator, .{ left, right }, zeroes);
}