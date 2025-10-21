const std = @import("std");

pub fn modifier(score: i8) i8 {
    const asFloat: f16 = @floatFromInt(score);
    const modified = @floor((asFloat - 10) / 2);
    const result: i8 = @intFromFloat(modified);
    return result;
}

pub fn ability() i8 {
    var total: i8 = 0;
    var lowest: i8 = 7;
    for (0..4) |i| {
        const roll = std.crypto.random.intRangeAtMost(i8, 1, 6);
        const isBiggerThanLowest = roll > lowest;
        const mustReplaceLowest = i >= 3;
        if (isBiggerThanLowest and mustReplaceLowest) total -= lowest;
        if (isBiggerThanLowest or !mustReplaceLowest) total += roll;
        if (!isBiggerThanLowest) lowest = roll;
    }
    return total;
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