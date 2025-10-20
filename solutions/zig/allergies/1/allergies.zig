const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum(usize) {
    eggs,
    peanuts,
    shellfish,
    strawberries,
    tomatoes,
    chocolate,
    pollen,
    cats,
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    return score & std.math.pow(usize, 2, @intFromEnum(allergen)) > 0;
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    var set = EnumSet(Allergen).initEmpty();
    for (std.enums.values(Allergen)) |allergen| {
        if (score & std.math.pow(usize, 2, @intFromEnum(allergen)) > 0) set.toggle(allergen);
    }
    return set;
}
