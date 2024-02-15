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
pub const Error = error{
    OutOfHostMemory,
    OutOfDeviceMemory,
    InitializationFailed,
    DeviceLost,
    MemoryMapFailed,
    LayerNotPresent,
    ExtensionNotPresent,
    FeatureNotPresent,
    IncompatibleDriver,
    TooManyObjects,
    FormatNotSupported,
    FragmentedPool,
    Unknown,
    OutOfPoolMemory,
    InvalidExternalHandle,
    Fragmentation,
    InvalidOpaqueCaptureAddress,
    SurfaceLostKhr,
    NativeWindowInUseKhr,
    OutOfDateKhr,
    IncompatibleDisplayKhr,
    ValidationFailedExt,
    InvalidShaderNv,
    ImageUsageNotSupportedKhr,
    VideoPictureLayoutNotSupportedKhr,
    VideoProfileOperationNotSupportedKhr,
    VideoProfileFormatNotSupportedKhr,
    VideoProfileCodecNotSupportedKhr,
    VideoStdVersionNotSupportedKhr,
    InvalidDrmFormatModifierPlaneLayoutExt,
    NotPermittedKhr,
    FullScreenExclusiveModeLostExt,
    InvalidVideoStdParametersKhr,
    CompressionExhaustedExt,
    IncompatibleShaderBinaryExt,
    _,
};

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
pub const AllocatorInfo = extern struct {
    instance: vk.Instance,
    physical_device: vk.PhysicalDevice,
    device: vk.Device,
};
pub const Statistics = extern struct {
    block_count: u32,
    allocation_count: u32,
    block_bytes: vk.DeviceSize,
    allocation_bytes: vk.DeviceSize,
};
pub const DetailedStatistics = extern struct {
    statistics: Statistics,
    unused_range_count: u32,
    allocation_size_min: vk.DeviceSize,
    allocation_size_max: vk.DeviceSize,
    unused_range_size_min: vk.DeviceSize,
    unused_range_size_max: vk.DeviceSize,
};
pub const TotalStatistics = extern struct {
    memory_type: [vk.MAX_MEMORY_TYPES]DetailedStatistics,
    memory_heap: [vk.MAX_MEMORY_HEAPS]DetailedStatistics,
    total: DetailedStatistics,
};
pub const Budget = extern struct {
    statistics: Statistics,
    usage: vk.DeviceSize,
    budget: vk.DeviceSize,
};
pub const AllocationCreateFlags = packed struct(Flags) {
    dedicated_memory_bit: bool = false,
    never_allocate_bit: bool = false,
    mapped_bit: bool = false,
    user_data_copy_string_bit: bool = false,
    upper_address_bit: bool = false,
    dont_bind_bit: bool = false,
    within_budget_bit: bool = false,
    can_alias_bit: bool = false,
    host_access_sequential_write_bit: bool = false,
    host_access_random_bit: bool = false,
    host_access_allow_transfer_instead_bit: bool = false,
    strategy_min_memory_bit: bool = false,
    strategy_min_time_bit: bool = false,
    strategy_min_offset_bit: bool = false,
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

    pub const strategy_best_fit_bit: @This() = .{ .strategy_min_memory_bit = true };
    pub const strategy_first_fit_bit: @This() = .{ .strategy_min_time_bit = true };
    pub const strategy_mask: @This() = .{ .strategy_min_memory_bit = true, .strategy_min_time_bit = true, .strategy_min_offset_bit = true };
};
pub const MemoryUsage = enum(u32) {
    unknown = 0,
    gpu_only = 1,
    cpu_only = 2,
    cpu_to_gpu = 3,
    gpu_to_cpu = 4,
    cpu_copy = 5,
    gpu_lazily_allocated = 6,
    auto = 7,
    auto_prefer_device = 8,
    auto_prefer_host = 9,
};
pub const Pool = c.VmaPool;
pub const AllocationCreateInfo = extern struct {
    flags: AllocationCreateFlags = .{},
    usage: MemoryUsage = .unknown,
    required_flags: vk.MemoryPropertyFlags = .{},
    preferred_flags: vk.MemoryPropertyFlags = .{},
    memory_type_bits: u32 = 0,
    pool: Pool = c.VK_NULL_HANDLE,
    p_user_data: ?*anyopaque = null,
    priority: f32 = 0,
};
pub const PoolCreateFlags = packed struct(Flags) {
    _reserved_bit_0: bool = false,
    _reserved_bit_1: bool = false,
    ignore_buffer_image_granularity_bit: bool = false,
    linear_algorithm_bit: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
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

    pub const algorithm_mask: @This() = .{ .linear_algorithm_bit = true };
};
pub const PoolCreateInfo = extern struct {
    memory_type_index: u32 = 0,
    flags: PoolCreateFlags = .{},
    block_size: vk.DeviceSize = 0,
    min_block_count: usize = 0,
    max_block_count: usize = 0,
    priority: f32 = 0,
    min_allocation_alignment: vk.DeviceSize = 0,
    p_memory_allocate_next: ?*anyopaque = null,
};
pub const AllocationInfo = extern struct {
    memory_type: u32 = 0,
    device_memory: vk.DeviceMemory = .null_handle,
    offset: vk.DeviceSize = 0,
    size: vk.DeviceSize = 0,
    p_mapped_data: ?*anyopaque = null,
    p_user_data: ?*anyopaque = null,
    p_name: ?[*:0]const u8 = null,
};
pub const AllocationInfo2 = extern struct {
    allocation_info: AllocationInfo = .{},
    block_size: vk.DeviceSize = 0,
    dedicated_memory: vk.Bool32 = vk.FALSE,
};
pub const Allocation = c.VmaAllocation;

pub fn createAllocator(p_create_info: *const AllocatorCreateInfo) Error!Allocator {
    var vma: Allocator = undefined;
    const result = c.vmaCreateAllocator(@ptrCast(p_create_info), &vma);
    try vkCheck(result);
    return vma;
}

pub fn destroyAllocator(allocator: Allocator) void {
    c.vmaDestroyAllocator(allocator);
}

pub fn getAllocatorInfo(allocator: Allocator) AllocatorInfo {
    var allocator_info: AllocatorInfo = undefined;
    c.vmaGetAllocatorInfo(allocator, @ptrCast(&allocator_info));
    return allocator_info;
}

pub fn getPhysicalDeviceProperties(allocator: Allocator) *const vk.PhysicalDeviceProperties {
    var properties: *const vk.PhysicalDeviceProperties = undefined;
    c.vmaGetPhysicalDeviceProperties(allocator, @ptrCast(&properties));
    return properties;
}

pub fn getMemoryProperties(allocator: Allocator) *const vk.PhysicalDeviceMemoryProperties {
    var properties: *const vk.PhysicalDeviceMemoryProperties = undefined;
    c.vmaGetMemoryProperties(allocator, @ptrCast(&properties));
    return properties;
}

pub fn getMemoryTypeProperties(allocator: Allocator, memory_type_index: u32) vk.MemoryPropertyFlags {
    var flags: vk.MemoryPropertyFlags = undefined;
    c.vmaGetMemoryTypeProperties(allocator, memory_type_index, @ptrCast(&flags));
    return flags;
}

pub fn setCurrentFrameIndex(allocator: Allocator, frame_index: u32) void {
    c.vmaSetCurrentFrameIndex(allocator, frame_index);
}

pub fn calculateStatistics(allocator: Allocator) TotalStatistics {
    var statistics: TotalStatistics = undefined;
    c.vmaCalculateStatistics(allocator, @ptrCast(&statistics));
    return statistics;
}

pub fn getHeapBudgets(allocator: Allocator, p_budgets: [*]Budget) void {
    c.vmaGetHeapBudgets(allocator, @ptrCast(p_budgets));
}

pub fn findMemoryTypeIndex(
    allocator: Allocator,
    memory_type_bits: u32,
    p_allocation_create_info: *const AllocationCreateInfo,
) Error!u32 {
    var type_index: u32 = undefined;
    const result = c.vmaFindMemoryTypeIndex(allocator, memory_type_bits, @ptrCast(p_allocation_create_info), &type_index);
    try vkCheck(result);
    return type_index;
}

pub fn findMemoryTypeIndexForBufferInfo(
    allocator: Allocator,
    p_buffer_create_info: *const vk.BufferCreateInfo,
    p_allocation_create_info: *const AllocationCreateInfo,
) Error!u32 {
    var type_index: u32 = undefined;
    const result = c.vmaFindMemoryTypeIndexForBufferInfo(
        allocator,
        @ptrCast(p_buffer_create_info),
        @ptrCast(p_allocation_create_info),
        &type_index,
    );
    try vkCheck(result);
    return type_index;
}

pub fn findMemoryTypeIndexForImageInfo(
    allocator: Allocator,
    p_image_create_info: *const vk.ImageCreateInfo,
    p_allocation_create_info: *const AllocationCreateInfo,
) Error!u32 {
    var type_index: u32 = undefined;
    const result = c.vmaFindMemoryTypeIndexForImageInfo(
        allocator,
        @ptrCast(p_image_create_info),
        @ptrCast(p_allocation_create_info),
        &type_index,
    );
    try vkCheck(result);
    return type_index;
}

pub fn createPool(allocator: Allocator, p_create_info: *const PoolCreateInfo) Error!Pool {
    var pool: Pool = undefined;
    const result = c.vmaCreatePool(allocator, @ptrCast(p_create_info), @ptrCast(&pool));
    try vkCheck(result);
    return pool;
}

pub fn destroyPool(allocator: Allocator, pool: Pool) void {
    c.vmaDestroyPool(allocator, pool);
}

pub fn getPoolStatistics(allocator: Allocator, pool: Pool) Statistics {
    var stats: Statistics = undefined;
    c.vmaGetPoolStatistics(allocator, pool, @ptrCast(&stats));
    return stats;
}

pub fn calculatePoolStatistics(allocator: Allocator, pool: Pool) DetailedStatistics {
    var stats: DetailedStatistics = undefined;
    c.vmaCalculatePoolStatistics(allocator, pool, @ptrCast(&stats));
    return stats;
}

pub fn vmaCheckPoolCorruption(allocator: Allocator, pool: Pool) Error!void {
    const result = c.vmaCheckPoolCorruption(allocator, pool);
    try vkCheck(result);
}

pub fn getPoolName(allocator: Allocator, pool: Pool) ?[*:0]const u8 {
    var name: ?[*:0]const u8 = undefined;
    c.vmaGetPoolName(allocator, pool, &name);
    return name;
}

pub fn setPoolName(allocator: Allocator, pool: Pool, name: ?[*:0]const u8) void {
    c.vmaSetPoolName(allocator, pool, name);
}

pub fn allocateMemory(
    allocator: Allocator,
    p_vk_memory_requirements: *const vk.MemoryRequirements,
    p_allocation_info: ?*AllocationInfo,
) Error!Allocation {
    var allocation: Allocation = undefined;
    const result = c.vmaAllocatorMemory(
        allocator,
        @ptrCast(p_vk_memory_requirements),
        @ptrCast(&allocation),
        @ptrCast(p_allocation_info),
    );
    try vkCheck(result);
    return allocation;
}

pub fn allocateMemoryPages(
    allocator: Allocator,
    p_vk_memory_requirements: []const vk.MemoryRequirements,
    p_create_info: []const AllocationCreateInfo,
    p_allocations: []Allocation,
    p_allocation_info: ?[]AllocationInfo,
) Error!void {
    const len = p_vk_memory_requirements.len;
    std.debug.assert(len == p_create_info.len and len == p_allocations.len);
    if (p_allocation_info) |alloc_info| std.debug.assert(len == alloc_info.len);

    const info: ?[*]AllocationInfo = if (p_allocation_info) |alloc_info| alloc_info.ptr else null;
    const result = c.vmaAllocateMemoryPages(
        allocator,
        @ptrCast(p_vk_memory_requirements.ptr),
        @ptrCast(p_create_info.ptr),
        len,
        @ptrCast(p_allocations.ptr),
        @ptrCast(info),
    );
    try vkCheck(result);
}

pub fn allocateMemoryForBuffer(
    allocator: Allocator,
    buffer: vk.Buffer,
    p_create_info: *const AllocationCreateInfo,
    p_allocation_info: ?*AllocationInfo,
) Error!Allocation {
    var allocation: Allocation = undefined;
    const result = c.vmaAllocateMemoryForBuffer(
        allocator,
        zigHandleToC(c.VkBuffer, buffer),
        @ptrCast(p_create_info),
        @ptrCast(&allocation),
        @ptrCast(&p_allocation_info),
    );
    try vkCheck(result);
    return allocation;
}

pub fn allocateMemoryForImage(
    allocator: Allocator,
    image: vk.Image,
    p_create_info: *const AllocationCreateInfo,
    p_allocation_info: ?*AllocationInfo,
) Error!Allocation {
    var allocation: Allocation = undefined;
    const result = c.vmaAllocateMemoryForImage(
        allocator,
        zigHandleToC(c.VkImage, image),
        @ptrCast(p_create_info),
        @ptrCast(&allocation),
        @ptrCast(&p_allocation_info),
    );
    try vkCheck(result);
    return allocation;
}

pub fn freeMemory(allocator: Allocator, allocation: Allocation) void {
    c.vmaFreeMemory(allocator, allocation);
}

pub fn freeMemoryPages(allocator: Allocator, allocations: ?[]const Allocation) void {
    if (allocations) |allocs| {
        c.vmaFreeMemoryPages(allocator, allocs.len, allocs.ptr);
    }
}

pub fn getAllocationInfo(allocator: Allocator, allocation: Allocation) AllocationInfo {
    var alloc_info: AllocationInfo = undefined;
    c.vmaGetAllocationInfo(allocator, allocation, @ptrCast(&alloc_info));
    return alloc_info;
}

pub fn getAllocationInfo2(allocator: Allocator, allocation: Allocation) AllocationInfo2 {
    var alloc_info: AllocationInfo2 = undefined;
    c.vmaGetAllocationInfo(allocator, allocation, @ptrCast(&alloc_info));
    return alloc_info;
}

pub fn setAllocationUserData(allocator: Allocator, allocation: Allocation, p_user_data: ?*anyopaque) void {
    c.vmaSetAllocationUserData(allocator, allocation, p_user_data);
}

pub fn setAllocationName(allocator: Allocator, allocation: Allocation, p_name: ?[*:0]const u8) void {
    c.vmaSetAllocationName(allocator, allocation, p_name);
}

pub fn getAllocationMemoryProperties(allocator: Allocator, allocation: Allocation) vk.MemoryPropertyFlags {
    var flags: vk.MemoryPropertyFlags = undefined;
    c.vmaGetAllocationMemoryProperties(allocator, allocation, @ptrCast(&flags));
    return flags;
}

pub fn mapMemory(allocator: Allocator, allocation: Allocation) Error!?*anyopaque {
    var ptr: ?*anyopaque = undefined;
    const result = c.vmaMapMemory(allocator, allocation, &ptr);
    try vkCheck(result);
    return ptr;
}

pub fn unmapMemory(allocator: Allocator, allocation: Allocation) void {
    c.vmaUnmapMemory(allocator, allocation);
}

pub fn buildStatsString(allocator: Allocator, detailed_map: vk.Bool32) ?[*:0]u8 {
    var ptr: ?[*:0]u8 = undefined;
    c.vmaBuildStatsString(allocator, &ptr, detailed_map);
    return ptr;
}

pub fn freeStatsString(allocator: Allocator, p_stats_string: ?[*:0]u8) void {
    c.vmaFreeStatsString(allocator, p_stats_string);
}

fn vkCheck(result: c.VkResult) Error!void {
    if (result >= 0) return;

    const r: vk.Result = @enumFromInt(result);
    switch (r) {
        .error_out_of_host_memory => return error.OutOfHostMemory,
        .error_out_of_device_memory => return error.OutOfDeviceMemory,
        .error_initialization_failed => return error.InitializationFailed,
        .error_device_lost => return error.DeviceLost,
        .error_memory_map_failed => return error.MemoryMapFailed,
        .error_layer_not_present => return error.LayerNotPresent,
        .error_extension_not_present => return error.ExtensionNotPresent,
        .error_feature_not_present => return error.FeatureNotPresent,
        .error_incompatible_driver => return error.IncompatibleDriver,
        .error_too_many_objects => return error.TooManyObjects,
        .error_format_not_supported => return error.FormatNotSupported,
        .error_fragmented_pool => return error.FragmentedPool,
        .error_out_of_pool_memory => return error.OutOfPoolMemory,
        .error_invalid_external_handle => return error.InvalidExternalHandle,
        .error_fragmentation => return error.Fragmentation,
        .error_invalid_opaque_capture_address => return error.InvalidOpaqueCaptureAddress,
        .error_surface_lost_khr => return error.SurfaceLostKhr,
        .error_native_window_in_use_khr => return error.NativeWindowInUseKhr,
        .error_out_of_date_khr => return error.OutOfDateKhr,
        .error_incompatible_display_khr => return error.IncompatibleDisplayKhr,
        .error_validation_failed_ext => return error.ValidationFailedExt,
        .error_invalid_shader_nv => return error.InvalidShaderNv,
        .error_image_usage_not_supported_khr => return error.ImageUsageNotSupportedKhr,
        .error_video_picture_layout_not_supported_khr => return error.VideoPictureLayoutNotSupportedKhr,
        .error_video_profile_operation_not_supported_khr => return error.VideoProfileOperationNotSupportedKhr,
        .error_video_profile_format_not_supported_khr => return error.VideoProfileFormatNotSupportedKhr,
        .error_video_profile_codec_not_supported_khr => return error.VideoProfileCodecNotSupportedKhr,
        .error_video_std_version_not_supported_khr => return error.VideoStdVersionNotSupportedKhr,
        .error_invalid_drm_format_modifier_plane_layout_ext => return error.InvalidDrmFormatModifierPlaneLayoutExt,
        .error_not_permitted_khr => return error.NotPermittedKhr,
        .error_full_screen_exclusive_mode_lost_ext => return error.FullScreenExclusiveModeLostExt,
        .error_invalid_video_std_parameters_khr => return error.InvalidVideoStdParametersKhr,
        .error_compression_exhausted_ext => return error.CompressionExhaustedExt,
        .error_incompatible_shader_binary_ext => return error.IncompatibleShaderBinaryExt,
        else => return error.Unknown,
    }
}
