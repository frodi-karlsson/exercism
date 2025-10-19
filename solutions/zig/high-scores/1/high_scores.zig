const std = @import("std");

pub const HighScores = struct {
    scores: []const i32,
    pb: ?i32,
    topThree: [3]i32,
    topThreeLen: usize,
    iLatest: ?i32,

    pub fn init(scores: []const i32) HighScores {
        const iLatest = scores[scores.len - 1];
        var topThree = [3]i32{ 0, 0, 0 };
        var pb: ?i32 = null;

        var topThreeLen: usize = 0;

        for (scores) |score| {
            if (score > pb orelse 0) {
                pb = score;
            }
            if (score > topThree[2]) {
                if (topThreeLen < 3) topThreeLen += 1;
                topThree[2] = score;
                std.sort.block(i32, &topThree, {}, std.sort.desc(i32));
            }
        }

        return HighScores{
            .scores = scores,
            .pb = pb,
            .topThree = topThree,
            .iLatest = iLatest,
            .topThreeLen = topThreeLen,
        };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        return self.iLatest;
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        return self.pb;
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        return self.topThree[0..self.topThreeLen];
    }
};
