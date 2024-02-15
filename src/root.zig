const std = @import("std");
const c = @import("c.zig");
const vk = @import("vulkan-zig");

fn zigHandleToC(comptime T: type, zig_handle: anytype) T {
    const Z = @typeInfo(@TypeOf(zig_handle));
    if (Z != .Enum) @compileError("must be a Vulkan handle");

    const handle_int: Z.Enum.tag_type = @intFromEnum(zig_handle);
    const handle_c: T = @ptrFromInt(handle_int);

    return handle_c;
}

fn cHandleToZig(comptime T: type, c_handle: anytype) T {
    const Z = @typeInfo(@TypeOf(c_handle));
    if (Z != .Optional) @compileError("must be a Vulkan handle");
    if (@typeInfo(Z.Optional.child) != .Pointer) @compileError("must be a Vulkan handle");

    const handle_int: u64 = @intFromPtr(c_handle);
    const handle_zig: T = @enumFromInt(handle_int);

    return handle_zig;
}

pub const Flags = u32;
pub const Allocator = c.VmaAllocator;

pub const AllocatorCreateFlags = packed struct(Flags) {
    externally_synchronized_bit: bool = false,
    khr_dedicated_allocation_bit: bool = false,
    khr_bind_memory2_bit: bool = false,
    ext_memory_budget_bit: bool = false,
    amd_device_coherent_memory_bit: bool = false,
    buffer_device_address_bit: bool = false,
    ext_memory_priority_bit: bool = false,
    khr_maintenance4_bit: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace vk.FlagsMixin(@This());
};

pub const PfnAllocateDeviceMemoryFunction = ?*const fn (Allocator, u32, vk.DeviceMemory, vk.DeviceSize, ?*anyopaque) callconv(.C) void;
pub const PfnFreeDeviceMemoryFunction = ?*const fn (Allocator, u32, vk.DeviceMemory, vk.DeviceSize, ?*anyopaque) callconv(.C) void;
pub const DeviceMemoryCallbacks = extern struct {
    pfn_allocate: PfnAllocateDeviceMemoryFunction = null,
    pfn_free: PfnFreeDeviceMemoryFunction = null,
    p_user_data: ?*anyopaque = null,
};

pub const PfnVkVoidFunction = ?*const fn () callconv(.C) void;
pub const PfnVkGetInstanceProcAddr = ?*const fn (vk.Instance, [*:0]const u8) callconv(.C) PfnVkVoidFunction;
pub const PfnVkGetDeviceProcAddr = ?*const fn (vk.Device, [*:0]const u8) callconv(.C) PfnVkVoidFunction;
pub const PfnVkGetPhysicalDeviceProperties = ?*const fn (vk.PhysicalDevice, *vk.PhysicalDeviceProperties) callconv(.C) void;
pub const PfnVkGetPhysicalDeviceMemoryProperties = ?*const fn (vk.PhysicalDevice, *vk.PhysicalDeviceMemoryProperties) callconv(.C) void;
pub const PfnVkAllocateMemory = ?*const fn (vk.Device, ?*const vk.MemoryAllocateInfo, ?*const vk.AllocationCallbacks, *vk.DeviceMemory) callconv(.C) vk.Result;
pub const PfnVkFreeMemory = ?*const fn (vk.Device, vk.DeviceMemory, ?*const vk.AllocationCallbacks) callconv(.C) void;
pub const PfnVkMapMemory = ?*const fn (vk.Device, vk.DeviceMemory, vk.DeviceSize, vk.DeviceSize, vk.MemoryMapFlags, *?*anyopaque) callconv(.C) vk.Result;
pub const PfnVkUnmapMemory = ?*const fn (vk.Device, vk.DeviceMemory) callconv(.C) void;
pub const PfnVkFlushMappedMemoryRanges = ?*const fn (vk.Device, u32, [*]const vk.MappedMemoryRange) callconv(.C) vk.Result;
pub const PfnVkInvalidateMappedMemoryRanges = ?*const fn (vk.Device, u32, [*]const vk.MappedMemoryRange) callconv(.C) vk.Result;
pub const PfnVkBindBufferMemory = ?*const fn (vk.Device, vk.Buffer, vk.DeviceMemory, vk.DeviceSize) callconv(.C) vk.Result;
pub const PfnVkBindImageMemory = ?*const fn (vk.Device, vk.Image, vk.DeviceMemory, vk.DeviceSize) callconv(.C) vk.Result;
pub const PfnVkGetBufferMemoryRequirements = ?*const fn (vk.Device, vk.Buffer, *vk.MemoryRequirements) callconv(.C) void;
pub const PfnVkGetImageMemoryRequirements = ?*const fn (vk.Device, vk.Image, *vk.MemoryRequirements) callconv(.C) void;
pub const PfnVkCreateBuffer = ?*const fn (vk.Device, *const vk.BufferCreateInfo, ?*const vk.AllocationCallbacks, *vk.Buffer) callconv(.C) vk.Result;
pub const PfnVkDestroyBuffer = ?*const fn (vk.Device, vk.Buffer, ?*const vk.AllocationCallbacks) callconv(.C) void;
pub const PfnVkCreateImage = ?*const fn (vk.Device, *const vk.ImageCreateInfo, ?*const vk.AllocationCallbacks, *vk.Image) callconv(.C) vk.Result;
pub const PfnVkDestroyImage = ?*const fn (vk.Device, vk.Image, ?*const vk.AllocationCallbacks) callconv(.C) void;
pub const PfnVkCmdCopyBuffer = ?*const fn (vk.CommandBuffer, vk.Buffer, vk.Buffer, u32, [*]const vk.BufferCopy) callconv(.C) void;
pub const PfnVkGetBufferMemoryRequirements2KHR = ?*const fn (vk.Device, *const vk.BufferMemoryRequirementsInfo2, *vk.MemoryRequirements2) callconv(.C) void;
pub const PfnVkGetImageMemoryRequirements2KHR = ?*const fn (vk.Device, *const vk.ImageMemoryRequirementsInfo2, *vk.MemoryRequirements2) callconv(.C) void;
pub const PfnVkBindBufferMemory2KHR = ?*const fn (vk.Device, u32, *const vk.BindBufferMemoryInfo) callconv(.C) vk.Result;
pub const PfnVkBindImageMemory2KHR = ?*const fn (vk.Device, u32, *const vk.BindImageMemoryInfo) callconv(.C) vk.Result;
pub const PfnVkGetPhysicalDeviceMemoryProperties2KHR = ?*const fn (vk.PhysicalDevice, ?*vk.PhysicalDeviceMemoryProperties2) callconv(.C) void;
pub const PfnVkGetDeviceBufferMemoryRequirementsKHR = ?*const fn (vk.Device, *const vk.DeviceBufferMemoryRequirements, *vk.MemoryRequirements2) callconv(.C) void;
pub const PfnVkGetDeviceImageMemoryRequirementsKHR = ?*const fn (vk.Device, *const vk.DeviceImageMemoryRequirements, *vk.MemoryRequirements2) callconv(.C) void;
pub const VulkanFunctions = extern struct {
    vk_get_instance_proc_addr: PfnVkGetInstanceProcAddr = null,
    vk_get_device_proc_addr: PfnVkGetDeviceProcAddr = null,
    vk_get_physical_device_properties: PfnVkGetPhysicalDeviceProperties = null,
    vk_get_physical_device_memory_properties: PfnVkGetPhysicalDeviceMemoryProperties = null,
    vk_allocate_memory: PfnVkAllocateMemory = null,
    vk_free_memory: PfnVkFreeMemory = null,
    vk_map_memory: PfnVkMapMemory = null,
    vk_unmap_memory: PfnVkUnmapMemory = null,
    vk_flush_mapped_memory_ranges: PfnVkFlushMappedMemoryRanges = null,
    vk_invalidate_mapped_memory_ranges: PfnVkInvalidateMappedMemoryRanges = null,
    vk_bind_buffer_memory: PfnVkBindBufferMemory = null,
    vk_bind_image_memory: PfnVkBindImageMemory = null,
    vk_get_buffer_memory_requirements: PfnVkGetBufferMemoryRequirements = null,
    vk_get_image_memory_requirements: PfnVkGetImageMemoryRequirements = null,
    vk_create_buffer: PfnVkCreateBuffer = null,
    vk_destroy_buffer: PfnVkDestroyBuffer = null,
    vk_create_image: PfnVkCreateImage = null,
    vk_destroy_image: PfnVkDestroyImage = null,
    vk_cmd_copy_buffer: PfnVkCmdCopyBuffer = null,
    vk_get_buffer_memory_requirements2khr: PfnVkGetBufferMemoryRequirements2KHR = null,
    vk_get_image_memory_requirements2khr: PfnVkGetImageMemoryRequirements2KHR = null,
    vk_bind_buffer_memory2khr: PfnVkBindBufferMemory2KHR = null,
    vk_bind_image_memory2khr: PfnVkBindImageMemory2KHR = null,
    vk_get_physical_device_memory_properties2khr: PfnVkGetPhysicalDeviceMemoryProperties2KHR = null,
    vk_get_device_buffer_memory_requirements: PfnVkGetDeviceBufferMemoryRequirementsKHR = null,
    vk_get_device_image_memory_requirements: PfnVkGetDeviceImageMemoryRequirementsKHR = null,
};

pub const AllocatorCreateInfo = extern struct {
    flags: AllocatorCreateFlags = .{},
    physical_device: vk.PhysicalDevice,
    device: vk.Device,
    preferred_large_heap_block_size: vk.DeviceSize = 0,
    p_allocation_callbacks: ?*const vk.AllocationCallbacks = null,
    p_device_memory_callbacks: ?[*]const DeviceMemoryCallbacks = null,
    p_heap_size_limit: ?[*]const vk.DeviceSize = null,
    p_vulkan_functions: ?[*]const VulkanFunctions = null,
    instance: vk.Instance,
    vulkan_api_version: u32 = vk.API_VERSION_1_0,
    p_type_external_memory_handle_types: ?[*]const vk.ExternalMemoryHandleTypeFlagsKHR = null,
};

pub const CreateAllocatorError = error{_};

pub fn createAllocator(p_create_info: *const AllocatorCreateInfo) CreateAllocatorError!Allocator {
    var vma: Allocator = undefined;
    const result = c.vmaCreateAllocator(@ptrCast(p_create_info), &vma);
    _ = result; // Always VK_SUCCESS
    return vma;
}

pub fn destroyAllocator(allocator: Allocator) void {
    c.vmaDestroyAllocator(allocator);
}
