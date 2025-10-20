pub fn squareRoot(radicand: usize) usize {
    if (radicand == 1) return 1;
    for (0..radicand / 2 + 1) |i| {
        if (i * i == radicand) {
            return i;
        }
    }
    unreachable;
}
