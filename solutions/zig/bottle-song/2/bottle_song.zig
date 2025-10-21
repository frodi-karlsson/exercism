const std = @import("std");

const bottleNumberStrsLower = [_][]const u8{ "no ", "one ", "two ", "three ", "four ", "five ", "six ", "seven ", "eight ", "nine ", "ten " };
const bottleNumberStrsUpper = [_][]const u8{ "No ", "One ", "Two ", "Three ", "Four ", "Five ", "Six ", "Seven ", "Eight ", "Nine ", "Ten " };

const greenBottle = "green bottle";
const s = "s";
const hangingOnTheWall = " hanging on the wall";
const period = ".";
const commaNew = ",\n";
const andIfOneGreenBottle = "And if one green bottle should accidentally fall,\nThere'll be ";
const separatorStr = "\n\n";

fn append(buffer: []u8, offset: *usize, str: []const u8) !void {
    const written = try std.fmt.bufPrint(buffer[offset.*..], "{s}", .{str});
    offset.* += written.len;
}

fn appendBottles(buffer: []u8, offset: *usize, bottleCount: u32, upper: bool) !void {
    const bottleNumberStrs = if (upper) bottleNumberStrsUpper else bottleNumberStrsLower;
    try append(buffer, offset, bottleNumberStrs[bottleCount]);
    try append(buffer, offset, greenBottle);
    if (bottleCount != 1) {
        try append(buffer, offset, s);
    }
}

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) ![]const u8 {
    var offset: usize = 0;

    for (0..take_down) |i| {
        const u32i: u32 = @intCast(i);
        const bottlesLeft = start_bottles - u32i;
        const nextBottles = bottlesLeft - 1;

        for (0..2) |_| {
            try appendBottles(buffer, &offset, bottlesLeft, true);
            try append(buffer, &offset, hangingOnTheWall);
            try append(buffer, &offset, commaNew);
        }

        try append(buffer, &offset, andIfOneGreenBottle);
        try appendBottles(buffer, &offset, nextBottles, false);
        try append(buffer, &offset, hangingOnTheWall);
        try append(buffer, &offset, period);

        if (i < take_down - 1) {
            try append(buffer, &offset, separatorStr);
        }
    }

    return buffer[0..offset];
}