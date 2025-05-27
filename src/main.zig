const std = @import("std");
const Discord = @import("discord").Discord;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(gpa.deinit() == .ok);
    const allocator = gpa.allocator();

    // const stdout_file = std.io.getStdOut().writer();
    // var bw = std.io.bufferedWriter(stdout_file);
    // const stdout = bw.writer();

    var discord = Discord.init(allocator);
    try discord.login("email", "pass");
    // try stdout.print("Another thing {}", .{discord.add(1, 2)});

    // try bw.flush(); // Don't forget to flush!
}
