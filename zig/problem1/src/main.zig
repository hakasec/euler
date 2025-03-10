const std = @import("std");
const io = std.io;
const fmt = std.fmt;

pub fn main() !void {
    const stderr_file = io.getStdErr().writer();
    const stdout_file = io.getStdOut().writer();

    var stdout_bw = io.bufferedWriter(stdout_file);
    var stderr_bw = io.bufferedWriter(stderr_file);

    const stdout = stdout_bw.writer();
    const stderr = stderr_bw.writer();

    const args = try std.process.argsAlloc(std.heap.page_allocator);

    if (args.len != 2) {
        std.process.argsFree(std.heap.page_allocator, args);

        try stderr.print("Requires 1 arguments: number to count to", .{});
        try stderr_bw.flush();
        return;
    }

    const count_to = try fmt.parseInt(u32, args[1], 10);
    std.process.argsFree(std.heap.page_allocator, args);

    var sum: usize = 0;

    for (0..count_to) |num| {
        if (num % 3 == 0 or num % 5 == 0) {
            sum += num;
        }
    }

    try stdout.print("Sum is: {}", .{sum});
    try stdout_bw.flush(); // don't forget to flush!
}
