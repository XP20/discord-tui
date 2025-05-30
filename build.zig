const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "discord_tui",
        .root_module = exe_mod,
    });

    // Dependencies
    const vaxis = b.dependency("vaxis", .{ .target = target, .optimize = optimize });
    const discord = b.dependency("discord", .{ .target = target, .optimize = optimize });

    exe.root_module.addImport("vaxis", vaxis.module("vaxis"));
    exe.root_module.addImport("discord", discord.module("discord"));

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_cmd.addArgs(args);

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
