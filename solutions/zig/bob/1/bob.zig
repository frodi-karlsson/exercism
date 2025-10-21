const std = @import("std");

const BobResponse = enum {
    Sure,
    WhoaChillOut,
    CalmDownIKnowWhatImDoing,
    FineBeThatWay,
    Whatever,

    pub fn str(self: BobResponse) []const u8 {
        return switch (self) {
            .Sure => "Sure.",
            .WhoaChillOut => "Whoa, chill out!",
            .CalmDownIKnowWhatImDoing => "Calm down, I know what I'm doing!",
            .FineBeThatWay => "Fine. Be that way!",
            .Whatever => "Whatever.",
        };
    }
};

pub fn response(s: []const u8) []const u8 {
    const trimmed = std.mem.trim(u8, s, " \t\n\r");
    if (trimmed.len == 0) return BobResponse.FineBeThatWay.str();

    const isQuestion = trimmed[trimmed.len - 1] == '?';

    var isCaps = false;
    for (trimmed) |c| {
        if (std.ascii.isLower(c)) {
            return if (isQuestion) BobResponse.Sure.str() else BobResponse.Whatever.str();
        } else if (std.ascii.isUpper(c)) {
            isCaps = true;
        }
    }

    if (!isCaps) return if (isQuestion) BobResponse.Sure.str() else BobResponse.Whatever.str();
    return if (isQuestion) BobResponse.CalmDownIKnowWhatImDoing.str() else BobResponse.WhoaChillOut.str();
}