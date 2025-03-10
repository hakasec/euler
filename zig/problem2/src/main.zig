const std = @import("std");

fn fib(num: u32) u32 {
    if (num <= 1) return num;

    return fib(num - 1) + fib(num - 2);
}

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var stdout_bw = std.io.bufferedWriter(stdout_file);
    const stdout = stdout_bw.writer();

    const max = 4000000;
    var sum: u32 = 0;
    var count: u32 = 3;
    var f: u32 = 2;

    while (f <= max) : ({
        count += 3;
        f = fib(count);
    }) {
        sum += f;
    }

    try stdout.print("Sum is: {}", .{sum});
    try stdout_bw.flush(); // don't forget to flush!
}
