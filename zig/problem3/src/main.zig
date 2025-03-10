const std = @import("std");

fn is_prime(n: u64) bool {
    if (n & 1 == 0) return false;

    const limit = std.math.sqrt(n);
    var i: u64 = 3;

    while (i < limit) : (i += 2) {
        if (n % i == 0)
            return false;
    }

    return true;
}

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var stdout_bw = std.io.bufferedWriter(stdout_file);
    const stdout = stdout_bw.writer();

    const target = 600851475143;

    for (2..target / 2) |div| {
        const div_result: f64 = @as(f64, target) / @as(f64, @floatFromInt(div));

        if (@mod(div_result, 1) == 0 and is_prime(@as(u64, @intFromFloat(div_result)))) {
            try stdout.print("Max is: {}", .{@as(u64, @intFromFloat(div_result))});
            break;
        }
    }

    try stdout_bw.flush(); // don't forget to flush!
}
