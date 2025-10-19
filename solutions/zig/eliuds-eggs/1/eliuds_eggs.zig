pub fn eggCount(number: usize) usize {
    var curr = number;
    var count: usize = 0;
    while (curr > 0) {
        count += (curr & 1);
        curr = curr >> 1;
    }
    return count;
}