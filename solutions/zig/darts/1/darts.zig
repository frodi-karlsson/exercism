const std = @import("std");

pub const Coordinate = struct {
    x: f32,
    y: f32,
    // This struct, as well as its fields and methods, needs to be implemented.

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{ .x = x_coord, .y = y_coord };
    }
    pub fn score(self: Coordinate) usize {
        const hypot = std.math.hypot(self.x, self.y);
        if (hypot > 10) return 0;
        if (hypot > 5) return 1;
        if (hypot > 1) return 5;
        return 10;
    }
};
