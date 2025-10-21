const std = @import("std");

const BottleNumber = enum {
    Zero,
    One,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Ten,

    pub fn cap(self: BottleNumber) []const u8 {
        return switch (self) {
            .Zero => "No green bottles",
            .One => "One green bottle",
            .Two => "Two green bottles",
            .Three => "Three green bottles",
            .Four => "Four green bottles",
            .Five => "Five green bottles",
            .Six => "Six green bottles",
            .Seven => "Seven green bottles",
            .Eight => "Eight green bottles",
            .Nine => "Nine green bottles",
            .Ten => "Ten green bottles",
        };
    }

    pub fn lower(self: BottleNumber) []const u8 {
        return switch (self) {
            .Zero => "no green bottles",
            .One => "one green bottle",
            .Two => "two green bottles",
            .Three => "three green bottles",
            .Four => "four green bottles",
            .Five => "five green bottles",
            .Six => "six green bottles",
            .Seven => "seven green bottles",
            .Eight => "eight green bottles",
            .Nine => "nine green bottles",
            .Ten => "ten green bottles",
        };
    }
};

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) ![]const u8 {
    var bufIndex: usize = 0;
    var written = buffer;

    for (0..take_down) |i| {
        const u32I: u32 = @intCast(i);
        const bottlesLeft = start_bottles - u32I;
        const bottleNumber: BottleNumber = @enumFromInt(bottlesLeft);

        const nextBottles = bottlesLeft - 1;
        const nextBottleNumber: BottleNumber = @enumFromInt(nextBottles);

        for (0..2) |_| {
            written = try std.fmt.bufPrint(buffer[bufIndex..], "{s} hanging on the wall,\n", .{bottleNumber.cap()});
            bufIndex += written.len;
        }

        written = try std.fmt.bufPrint(buffer[bufIndex..],
            \\And if one green bottle should accidentally fall,
            \\There'll be {s} hanging on the wall.
        , .{nextBottleNumber.lower()});
        bufIndex += written.len;

        if (i < take_down - 1) {
            written = try std.fmt.bufPrint(buffer[bufIndex..], "\n\n", .{});
            bufIndex += written.len;
        }
    }

    return buffer[0..bufIndex];
}