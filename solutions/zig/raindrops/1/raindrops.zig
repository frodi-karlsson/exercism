const std = @import("std");

pub fn convert(buffer: []u8, n: u32) []const u8 {
    var bufW = std.Io.Writer.fixed(buffer);
    var didPlxng = false;
    if (n % 3 == 0) {
        _ = bufW.writeAll("Pling") catch unreachable;
        didPlxng = true;
    }
    if (n % 5 == 0) {
        _ = bufW.writeAll("Plang") catch unreachable;
        didPlxng = true;
    }
    if (n % 7 == 0) {
        _ = bufW.writeAll("Plong") catch unreachable;
        didPlxng = true;
    }
    if (!didPlxng) {
        _ = bufW.print("{d}", .{n}) catch unreachable;
    }
    return buffer[0..bufW.end];
}