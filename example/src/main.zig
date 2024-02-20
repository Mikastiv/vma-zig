const std = @import("std");
const vma = @import("vma-zig");
const vk = @import("vulkan-zig");
const vkk = @import("vk-kickstart");
const c = @import("c.zig");
const Window = @import("Window.zig");

const log = std.log;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    if (c.glfwInit() == c.GLFW_FALSE) return error.GlfwInitFailed;
    defer c.glfwTerminate();

    _ = c.glfwSetErrorCallback(errorCallback);

    const window = try Window.init(allocator, 800, 600, "Vma");
    defer window.deinit(allocator);

    const instance = try vkk.Instance.create(allocator, c.glfwGetInstanceProcAddress, .{});
    const surface = try window.createSurface(instance.handle);
    const physical_device = try vkk.PhysicalDevice.select(allocator, &instance, .{ .surface = surface });
    const device = try vkk.Device.create(allocator, &physical_device, null, null);

    const vma_info: vma.AllocatorCreateInfo = .{
        .instance = instance.handle,
        .physical_device = physical_device.handle,
        .device = device.handle,
    };

    const vma_alloc = try vma.Allocator.create(&vma_info);
    defer vma_alloc.destroy();

    const info = vma_alloc.getAllocatorInfo();

    log.info("{d} {d}", .{ instance.handle, info.instance });
    log.info("{d} {d}", .{ physical_device.handle, info.physical_device });
    log.info("{d} {d}", .{ device.handle, info.device });

    const properties = vma_alloc.getPhysicalDeviceProperties();

    log.info("{d}.{d}.{d}", .{ vk.apiVersionMajor(properties.api_version), vk.apiVersionMinor(properties.api_version), vk.apiVersionPatch(properties.api_version) });

    const mem_properties = vma_alloc.getMemoryProperties();

    log.info("{:.2}", .{std.fmt.fmtIntSizeBin(mem_properties.memory_heaps[0].size)});

    const mem_types = vma_alloc.getMemoryTypeProperties(1);

    log.info("{d}", .{mem_types.toInt()});

    vma_alloc.setCurrentFrameIndex(0);

    const stats = vma_alloc.calculateStatistics();

    log.info("alloc count {d}", .{stats.total.statistics.allocation_count});

    var budgets: [vk.MAX_MEMORY_HEAPS]vma.Budget = undefined;
    vma_alloc.getHeapBudgets(&budgets);

    log.info("budget {d}", .{budgets[0].usage});

    const stats_str = vma_alloc.buildStatsString(vk.TRUE);
    defer vma_alloc.freeStatsString(stats_str);

    log.info("{?s}", .{stats_str});

    // const alloc_info = vma.AllocationCreateInfo{
    //     .usage = .gpu_only,
    // };
    // const mem_type_index = try vma.findMemoryTypeIndex(vma_alloc, , &alloc_info);

    // log.info("{d}", .{mem_type_index});
}

fn errorCallback(error_code: i32, description: [*c]const u8) callconv(.C) void {
    const glfw_log = std.log.scoped(.glfw);
    glfw_log.err("{d}: {s}\n", .{ error_code, description });
}
