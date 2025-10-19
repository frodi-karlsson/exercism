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

pub fn colorCode(colors: [2]ColorBand) usize {
    const left: usize = @intFromEnum(colors[0]);
    const right: usize = @intFromEnum(colors[1]);
    return left * 10 + right;
}