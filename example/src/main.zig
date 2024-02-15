const std = @import("std");
const vma = @import("vma-zig");
const vk = @import("vulkan-zig");
const vkk = @import("vk-kickstart");
const c = @import("c.zig");
const Window = @import("Window.zig");

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
    const device = try vkk.Device.create(allocator, &physical_device, null);

    const vma_info: vma.AllocatorCreateInfo = .{
        .instance = instance.handle,
        .physical_device = physical_device.handle,
        .device = device.handle,
    };

    const vma_alloc = try vma.createAllocator(&vma_info);
    defer vma.destroyAllocator(vma_alloc);
}

fn errorCallback(error_code: i32, description: [*c]const u8) callconv(.C) void {
    const glfw_log = std.log.scoped(.glfw);
    glfw_log.err("{d}: {s}\n", .{ error_code, description });
}
