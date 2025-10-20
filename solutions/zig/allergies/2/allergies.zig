const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum {
    eggs,
    peanuts,
    shellfish,
    strawberries,
    tomatoes,
    chocolate,
    pollen,
    cats,
};

const bwOne: u8 = 1;

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    return score & (bwOne << @intFromEnum(allergen)) > 0;
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    var set = EnumSet(Allergen).initEmpty();
    for (std.enums.values(Allergen)) |allergen| {
        if (score & (bwOne << @intFromEnum(allergen)) > 0) set.toggle(allergen);
    }
    return set;
}