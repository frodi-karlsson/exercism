const std = @import("std");

pub const TriangleError = error{
    Invalid,
};

pub const Triangle = struct {
    a: f64,
    b: f64,
    c: f64,
    // This struct, as well as its fields and methods, needs to be implemented.

    pub fn init(a: f64, b: f64, c: f64) TriangleError!Triangle {
        const all = [_]f64{ a, b, c };
        const allSlice = all[0..];
        if (std.mem.min(f64, allSlice) < 0 or
            std.mem.max(f64, allSlice) <= 0) return TriangleError.Invalid;
        if (a + b < c or
            a + c < b or
            b + c < a) return TriangleError.Invalid;
        return Triangle{ .a = a, .b = b, .c = c };
    }

    pub fn isEquilateral(self: Triangle) bool {
        return self.a == self.b and self.b == self.c;
    }

    pub fn isIsosceles(self: Triangle) bool {
        return self.a == self.b or self.b == self.c or self.a == self.c;
    }

    pub fn isScalene(self: Triangle) bool {
        return self.a != self.b and self.b != self.c and self.a != self.c;
    }
};