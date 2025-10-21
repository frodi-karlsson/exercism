const std = @import("std");

var xshiro = std.Random.DefaultPrng.init(0);
const rand = xshiro.random();

pub fn modifier(score: i8) i8 {
    const asFloat: f16 = @floatFromInt(score);
    const modified = @floor((asFloat - 10) / 2);
    const result: i8 = @intFromFloat(modified);
    return result;
}

pub fn ability() i8 {
    return std.Random.intRangeAtMost(rand, i8, 3, 18);
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constitution = ability();
        return Character{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + modifier(constitution),
        };
    }
};