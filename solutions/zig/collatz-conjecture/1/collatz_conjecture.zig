// Please implement the `ComputationError.IllegalArgument` error.

pub const ComputationError = error{
    IllegalArgument,
};

pub fn steps(number: usize) anyerror!usize {
    if (number == 0) return ComputationError.IllegalArgument;
    var res = number;
    var numSteps: usize = 0;
    while (res != 1) : (numSteps += 1) {
        res = if (res % 2 == 0) res / 2 else res * 3 + 1;
    }
    return numSteps;
}
