const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const xml_path: []const u8 = b.pathFromRoot("vk.xml");

    const vma_zig = b.dependency("vma_zig", .{
        .registry = xml_path,
    });

    const vkzig = b.dependency("vulkan_zig", .{
        .registry = xml_path,
    });

    const kickstart_dep = b.dependency("vk_kickstart", .{
        .registry = xml_path,
        .enable_validation = if (optimize == .Debug) true else false,
    });

    const glfw = b.dependency("glfw", .{
        .target = target,
        .optimize = .ReleaseFast,
    }).artifact("glfw");

    const exe = b.addExecutable(.{
        .name = "example",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("vma-zig", vma_zig.module("vma-zig"));
    exe.root_module.addImport("vk-kickstart", kickstart_dep.module("vk-kickstart"));
    exe.root_module.addImport("vulkan-zig", vkzig.module("vulkan-zig"));
    exe.linkLibrary(glfw);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
