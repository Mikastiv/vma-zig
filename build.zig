const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const registry = b.option([]const u8, "registry", "Path to the Vulkan registry") orelse @panic("provide path to the Vulkan registry");

    const vkzig = b.dependency("vulkan_zig", .{
        .registry = registry,
    });

    const vulkan_lib = if (target.result.os.tag == .windows) "vulkan-1" else "vulkan";
    const vulkan_sdk = b.graph.env_map.get("VK_SDK_PATH") orelse @panic("VK_SDK_PATH is not set");

    const wf = b.addWriteFiles();
    const vma_src = wf.add("vk_mem_alloc.cpp",
        \\#define VMA_IMPLEMENTATION
        \\#include "vk_mem_alloc.h"
    );

    const vma = b.addStaticLibrary(.{
        .name = "vma",
        .target = target,
        .optimize = optimize,
    });
    vma.linkLibCpp();
    vma.addIncludePath(.{ .path = "." });
    vma.addIncludePath(.{ .path = b.pathJoin(&.{ vulkan_sdk, "include" }) });
    vma.addLibraryPath(.{ .path = b.pathJoin(&.{ vulkan_sdk, "lib" }) });
    vma.linkSystemLibrary(vulkan_lib);
    vma.addCSourceFile(.{ .file = vma_src });

    const vma_zig = b.addModule("vma-zig", .{
        .root_source_file = .{ .path = "src/root.zig" },
        .imports = &.{
            .{ .name = "vulkan-zig", .module = vkzig.module("vulkan-zig") },
        },
    });
    vma_zig.addLibraryPath(.{ .path = b.pathJoin(&.{ vulkan_sdk, "lib" }) });
    vma_zig.addIncludePath(.{ .path = b.pathJoin(&.{ vulkan_sdk, "include" }) });
    vma_zig.addIncludePath(.{ .path = "." });
    vma_zig.linkLibrary(vma);

    const lib_unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}
