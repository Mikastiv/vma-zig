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

pub const Flags = u32;
pub const Error = error{
    NotReady,
    Timeout,
    EventSet,
    EventReset,
    Incomplete,
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
    PipelineCompileRequired,
    SurfaceLostKhr,
    NativeWindowInUseKhr,
    SuboptimalKhr,
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
    ThreadIdleKhr,
    ThreadDoneKhr,
    OperationDeferredKhr,
    OperationNotDeferredKhr,
    InvalidVideoStdParametersKhr,
    CompressionExhaustedExt,
    IncompatibleShaderBinaryExt,
    _,
};

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
pub const PfnVmaAllocateDeviceMemoryFunction = ?*const fn (AllocatorHandle, u32, vk.DeviceMemory, vk.DeviceSize, ?*anyopaque) callconv(.C) void;
pub const PfnVmaFreeDeviceMemoryFunction = ?*const fn (AllocatorHandle, u32, vk.DeviceMemory, vk.DeviceSize, ?*anyopaque) callconv(.C) void;
pub const DeviceMemoryCallbacks = extern struct {
    pfn_allocate: PfnVmaAllocateDeviceMemoryFunction = null,
    pfn_free: PfnVmaFreeDeviceMemoryFunction = null,
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
    pub const strategy_mask: @This() = .{
        .strategy_min_memory_bit = true,
        .strategy_min_time_bit = true,
        .strategy_min_offset_bit = true,
    };

    pub usingnamespace vk.FlagsMixin(@This());
};
pub const MemoryUsage = enum(c_uint) {
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
    pool: Pool = @ptrCast(c.VK_NULL_HANDLE),
    p_user_data: ?*anyopaque = null,
    priority: f32 = 0,
};
pub const PoolCreateFlags = packed struct(Flags) {
    _reserved_bit_0: bool = false,
    ignore_buffer_image_granularity_bit: bool = false,
    linear_algorithm_bit: bool = false,
    _reserved_bit_3: bool = false,
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

    pub usingnamespace vk.FlagsMixin(@This());
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
pub const DefragmentationFlags = packed struct(Flags) {
    algorithm_fast_bit: bool = false,
    algorithm_balanced_bit: bool = false,
    algorithm_full_bit: bool = false,
    algorithm_extensive_bit: bool = false,
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

    pub const algorithm_mask: @This() = .{
        .algorithm_fast_bit = true,
        .algorithm_balanced_bit = true,
        .algorithm_full_bit = true,
        .algorithm_extensive_bit = true,
    };

    pub usingnamespace vk.FlagsMixin(@This());
};
pub const PfnVmaCheckDefragmentationBreakFunction = ?*const fn (?*anyopaque) callconv(.C) vk.Bool32;
pub const DefragmentationInfo = extern struct {
    flags: DefragmentationFlags = .{},
    pool: Pool = @ptrCast(c.VK_NULL_HANDLE),
    max_bytes_per_pass: vk.DeviceSize = 0,
    max_allocations_per_pass: u32 = 0,
    pfn_break_callback: PfnVmaCheckDefragmentationBreakFunction = null,
    p_break_callback_user_data: ?*anyopaque = null,
};
pub const DefragmentationContext = c.VmaDefragmentationContext;
pub const DefragmentationStats = extern struct {
    bytes_moved: vk.DeviceSize = 0,
    bytes_freed: vk.DeviceSize = 0,
    allocations_moved: u32 = 0,
    device_memory_blocks_freed: u32 = 0,
};
pub const DefragmentationMoveOperation = enum(c_int) {
    copy = 0,
    ignore = 1,
    destroy = 2,
};
pub const DefragmentationMove = extern struct {
    operation: DefragmentationMoveOperation = @enumFromInt(0),
    src_allocation: Allocation = @ptrCast(c.VK_NULL_HANDLE),
    dst_tmp_allocation: Allocation = @ptrCast(c.VK_NULL_HANDLE),
};
pub const DefragmentationPassMoveInfo = extern struct {
    move_count: u32 = 0,
    p_moves: ?[*]DefragmentationMove = null,
};
pub const VirtualBlockCreateFlags = packed struct(Flags) {
    linear_algorithm_bit: bool = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
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

    pub usingnamespace vk.FlagsMixin(@This());
};
pub const VirtualBlockCreateInfo = extern struct {
    size: vk.DeviceSize = 0,
    flags: VirtualBlockCreateFlags = .{},
    p_allocation_callbacks: ?*const vk.AllocationCallbacks = null,
};
pub const VirtualAllocation = c.VmaVirtualAllocation;
pub const VirtualAllocationInfo = extern struct {
    offset: vk.DeviceSize = 0,
    size: vk.DeviceSize = 0,
    p_user_data: ?*anyopaque = null,
};
pub const VirtualAllocationCreateFlags = packed struct(Flags) {
    _reserved_bit_0: bool = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    upper_address_bit: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
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

    pub const strategy_mask: @This() = .{
        .strategy_min_memory_bit = true,
        .strategy_min_time_bit = true,
        .strategy_min_offset_bit = true,
    };

    pub usingnamespace vk.FlagsMixin(@This());
};
pub const VirtualAllocationCreateInfo = extern struct {
    size: vk.DeviceSize = 0,
    alignment: vk.DeviceSize = 0,
    flags: VirtualAllocationCreateFlags = .{},
    p_user_data: ?*anyopaque = null,
};
pub const AllocatedBuffer = struct {
    handle: vk.Buffer,
    allocation: Allocation,
};
pub const AllocatedImage = struct {
    handle: vk.Image,
    allocation: Allocation,
};
pub const AllocatorHandle = c.VmaAllocator;
pub const VirtualBlockHandle = c.VmaVirtualBlock;
pub const Allocator = struct {
    handle: AllocatorHandle,

    pub fn create(p_create_info: *const AllocatorCreateInfo) Error!Allocator {
        var handle: AllocatorHandle = undefined;
        const result = c.vmaCreateAllocator(@ptrCast(p_create_info), &handle);
        try vkCheck(result);
        return .{ .handle = handle };
    }

    pub fn destroy(self: Allocator) void {
        c.vmaDestroyAllocator(self.handle);
    }

    pub fn getAllocatorInfo(self: Allocator) AllocatorInfo {
        var allocator_info: AllocatorInfo = undefined;
        c.vmaGetAllocatorInfo(self.handle, @ptrCast(&allocator_info));
        return allocator_info;
    }

    pub fn getPhysicalDeviceProperties(self: Allocator) *const vk.PhysicalDeviceProperties {
        var properties: *const vk.PhysicalDeviceProperties = undefined;
        c.vmaGetPhysicalDeviceProperties(self.handle, @ptrCast(&properties));
        return properties;
    }

    pub fn getMemoryProperties(self: Allocator) *const vk.PhysicalDeviceMemoryProperties {
        var properties: *const vk.PhysicalDeviceMemoryProperties = undefined;
        c.vmaGetMemoryProperties(self.handle, @ptrCast(&properties));
        return properties;
    }

    pub fn getMemoryTypeProperties(
        self: Allocator,
        memory_type_index: u32,
    ) vk.MemoryPropertyFlags {
        var flags: vk.MemoryPropertyFlags = undefined;
        c.vmaGetMemoryTypeProperties(self.handle, memory_type_index, @ptrCast(&flags));
        return flags;
    }

    pub fn setCurrentFrameIndex(self: Allocator, frame_index: u32) void {
        c.vmaSetCurrentFrameIndex(self.handle, frame_index);
    }

    pub fn calculateStatistics(self: Allocator) TotalStatistics {
        var statistics: TotalStatistics = undefined;
        c.vmaCalculateStatistics(self.handle, @ptrCast(&statistics));
        return statistics;
    }

    pub fn getHeapBudgets(self: Allocator, p_budgets: [*]Budget) void {
        c.vmaGetHeapBudgets(self.handle, @ptrCast(p_budgets));
    }

    pub fn findMemoryTypeIndex(
        self: Allocator,
        memory_type_bits: u32,
        p_allocation_create_info: *const AllocationCreateInfo,
    ) Error!u32 {
        var type_index: u32 = undefined;
        const result = c.vmaFindMemoryTypeIndex(
            self.handle,
            memory_type_bits,
            @ptrCast(p_allocation_create_info),
            &type_index,
        );
        try vkCheck(result);
        return type_index;
    }

    pub fn findMemoryTypeIndexForBufferInfo(
        self: Allocator,
        p_buffer_create_info: *const vk.BufferCreateInfo,
        p_allocation_create_info: *const AllocationCreateInfo,
    ) Error!u32 {
        var type_index: u32 = undefined;
        const result = c.vmaFindMemoryTypeIndexForBufferInfo(
            self.handle,
            @ptrCast(p_buffer_create_info),
            @ptrCast(p_allocation_create_info),
            &type_index,
        );
        try vkCheck(result);
        return type_index;
    }

    pub fn findMemoryTypeIndexForImageInfo(
        self: Allocator,
        p_image_create_info: *const vk.ImageCreateInfo,
        p_allocation_create_info: *const AllocationCreateInfo,
    ) Error!u32 {
        var type_index: u32 = undefined;
        const result = c.vmaFindMemoryTypeIndexForImageInfo(
            self.handle,
            @ptrCast(p_image_create_info),
            @ptrCast(p_allocation_create_info),
            &type_index,
        );
        try vkCheck(result);
        return type_index;
    }

    pub fn createPool(self: Allocator, p_create_info: *const PoolCreateInfo) Error!Pool {
        var pool: Pool = undefined;
        const result = c.vmaCreatePool(self.handle, @ptrCast(p_create_info), @ptrCast(&pool));
        try vkCheck(result);
        return pool;
    }

    pub fn destroyPool(self: Allocator, pool: Pool) void {
        c.vmaDestroyPool(self.handle, pool);
    }

    pub fn getPoolStatistics(self: Allocator, pool: Pool) Statistics {
        var stats: Statistics = undefined;
        c.vmaGetPoolStatistics(self.handle, pool, @ptrCast(&stats));
        return stats;
    }

    pub fn calculatePoolStatistics(self: Allocator, pool: Pool) DetailedStatistics {
        var stats: DetailedStatistics = undefined;
        c.vmaCalculatePoolStatistics(self.handle, pool, @ptrCast(&stats));
        return stats;
    }

    pub fn vmaCheckPoolCorruption(self: Allocator, pool: Pool) Error!void {
        const result = c.vmaCheckPoolCorruption(self.handle, pool);
        try vkCheck(result);
    }

    pub fn getPoolName(self: Allocator, pool: Pool) ?[*:0]const u8 {
        var name: ?[*:0]const u8 = undefined;
        c.vmaGetPoolName(self.handle, pool, &name);
        return name;
    }

    pub fn setPoolName(self: Allocator, pool: Pool, name: ?[*:0]const u8) void {
        c.vmaSetPoolName(self.handle, pool, name);
    }

    pub fn allocateMemory(
        self: Allocator,
        p_vk_memory_requirements: *const vk.MemoryRequirements,
        p_allocation_info: ?*AllocationInfo,
    ) Error!Allocation {
        var allocation: Allocation = undefined;
        const result = c.vmaAllocatorMemory(
            self.handle,
            @ptrCast(p_vk_memory_requirements),
            @ptrCast(&allocation),
            @ptrCast(p_allocation_info),
        );
        try vkCheck(result);
        return allocation;
    }

    pub fn allocateMemoryPages(
        self: Allocator,
        p_vk_memory_requirements: [*]const vk.MemoryRequirements,
        p_create_info: [*]const AllocationCreateInfo,
        allocation_count: usize,
        p_allocations: [*]Allocation,
        p_allocation_info: ?[*]AllocationInfo,
    ) Error!void {
        const result = c.vmaAllocateMemoryPages(
            self.handle,
            @ptrCast(p_vk_memory_requirements.ptr),
            @ptrCast(p_create_info.ptr),
            allocation_count,
            @ptrCast(p_allocations),
            @ptrCast(p_allocation_info),
        );
        try vkCheck(result);
    }

    pub fn allocateMemoryForBuffer(
        self: Allocator,
        buffer: vk.Buffer,
        p_create_info: *const AllocationCreateInfo,
        p_allocation_info: ?*AllocationInfo,
    ) Error!Allocation {
        var allocation: Allocation = undefined;
        const result = c.vmaAllocateMemoryForBuffer(
            self.handle,
            zigHandleToC(c.VkBuffer, buffer),
            @ptrCast(p_create_info),
            @ptrCast(&allocation),
            @ptrCast(p_allocation_info),
        );
        try vkCheck(result);
        return allocation;
    }

    pub fn allocateMemoryForImage(
        self: Allocator,
        image: vk.Image,
        p_create_info: *const AllocationCreateInfo,
        p_allocation_info: ?*AllocationInfo,
    ) Error!Allocation {
        var allocation: Allocation = undefined;
        const result = c.vmaAllocateMemoryForImage(
            self.handle,
            zigHandleToC(c.VkImage, image),
            @ptrCast(p_create_info),
            @ptrCast(&allocation),
            @ptrCast(p_allocation_info),
        );
        try vkCheck(result);
        return allocation;
    }

    pub fn freeMemory(self: Allocator, allocation: Allocation) void {
        c.vmaFreeMemory(self.handle, allocation);
    }

    pub fn freeMemoryPages(self: Allocator, allocations: ?[]const Allocation) void {
        if (allocations) |allocs| {
            c.vmaFreeMemoryPages(self.handle, allocs.len, allocs.ptr);
        }
    }

    pub fn getAllocationInfo(self: Allocator, allocation: Allocation) AllocationInfo {
        var alloc_info: AllocationInfo = undefined;
        c.vmaGetAllocationInfo(self.handle, allocation, @ptrCast(&alloc_info));
        return alloc_info;
    }

    pub fn getAllocationInfo2(self: Allocator, allocation: Allocation) AllocationInfo2 {
        var alloc_info: AllocationInfo2 = undefined;
        c.vmaGetAllocationInfo(self.handle, allocation, @ptrCast(&alloc_info));
        return alloc_info;
    }

    pub fn setAllocationUserData(
        self: Allocator,
        allocation: Allocation,
        p_user_data: ?*anyopaque,
    ) void {
        c.vmaSetAllocationUserData(self.handle, allocation, p_user_data);
    }

    pub fn setAllocationName(
        self: Allocator,
        allocation: Allocation,
        p_name: ?[*:0]const u8,
    ) void {
        c.vmaSetAllocationName(self.handle, allocation, p_name);
    }

    pub fn getAllocationMemoryProperties(
        self: Allocator,
        allocation: Allocation,
    ) vk.MemoryPropertyFlags {
        var flags: vk.MemoryPropertyFlags = undefined;
        c.vmaGetAllocationMemoryProperties(self.handle, allocation, @ptrCast(&flags));
        return flags;
    }

    pub fn mapMemory(self: Allocator, allocation: Allocation) Error!?*anyopaque {
        var ptr: ?*anyopaque = undefined;
        const result = c.vmaMapMemory(self.handle, allocation, &ptr);
        try vkCheck(result);
        return ptr;
    }

    pub fn unmapMemory(self: Allocator, allocation: Allocation) void {
        c.vmaUnmapMemory(self.handle, allocation);
    }

    pub fn flushAllocation(
        self: Allocator,
        allocation: Allocation,
        offset: vk.DeviceSize,
        size: vk.DeviceSize,
    ) Error!void {
        const result = c.vmaFlushAllocation(self.handle, allocation, offset, size);
        try vkCheck(result);
    }

    pub fn invalidateAllocation(
        self: Allocator,
        allocation: Allocation,
        offset: vk.DeviceSize,
        size: vk.DeviceSize,
    ) Error!void {
        const result = c.vmaInvalidateAllocation(self.handle, allocation, offset, size);
        try vkCheck(result);
    }

    pub fn flushAllocations(
        self: Allocator,
        allocation_count: u32,
        allocations: [*]const Allocation,
        offsets: ?[*]const vk.DeviceSize,
        sizes: ?[*]const vk.DeviceSize,
    ) Error!void {
        const result = c.vmaFlushAllocations(
            self.handle,
            allocation_count,
            @ptrCast(allocations),
            @ptrCast(offsets),
            @ptrCast(sizes),
        );
        try vkCheck(result);
    }

    pub fn invalidateAllocations(
        self: Allocator,
        allocation_count: u32,
        allocations: []const Allocation,
        offsets: ?[]const vk.DeviceSize,
        sizes: ?[]const vk.DeviceSize,
    ) Error!void {
        const result = c.vmaInvalidateAllocations(
            self.handle,
            allocation_count,
            allocations,
            offsets,
            sizes,
        );
        try vkCheck(result);
    }

    pub fn copyMemoryToAllocation(
        self: Allocator,
        p_src_host_pointer: ?*const anyopaque,
        dst_allocation: Allocation,
        dst_allocation_local_offset: vk.DeviceSize,
        size: vk.DeviceSize,
    ) Error!void {
        const result = c.vmaCopyMemoryToAllocation(
            self.handle,
            p_src_host_pointer,
            dst_allocation,
            dst_allocation_local_offset,
            size,
        );
        try vkCheck(result);
    }

    pub fn copyAllocationToMemory(
        self: Allocator,
        src_allocation: Allocation,
        src_allocation_local_offset: vk.DeviceSize,
        p_dst_host_pointer: ?*anyopaque,
        size: vk.DeviceSize,
    ) Error!void {
        const result = c.vmaCopyAllocationToMemory(
            self.handle,
            src_allocation,
            src_allocation_local_offset,
            p_dst_host_pointer,
            size,
        );
        try vkCheck(result);
    }

    pub fn checkCorruption(self: Allocator, memory_type_bits: u32) Error!void {
        const result = c.vmaCheckCorruption(self.handle, memory_type_bits);
        try vkCheck(result);
    }

    pub fn beginDefragmentation(
        self: Allocator,
        p_info: *const DefragmentationInfo,
    ) Error!DefragmentationContext {
        var context: DefragmentationContext = undefined;
        const result = c.vmaBeginDefragmentation(self.handle, @ptrCast(p_info), @ptrCast(&context));
        try vkCheck(result);
        return context;
    }

    pub fn endDefragmentation(
        self: Allocator,
        context: DefragmentationContext,
        p_stats: ?*DefragmentationStats,
    ) void {
        c.vmaEndDefragmentation(self.handle, context, @ptrCast(p_stats));
    }

    pub fn beginDefragmentationPass(
        self: Allocator,
        context: DefragmentationContext,
    ) Error!DefragmentationPassMoveInfo {
        var pass_info: DefragmentationPassMoveInfo = undefined;
        const result = c.vmaBeginDefragmentationPass(self.handle, context, @ptrCast(&pass_info));
        try vkCheck(result);
        return pass_info;
    }

    pub fn endDefragmentationPass(
        self: Allocator,
        context: DefragmentationContext,
        p_pass_info: *DefragmentationPassMoveInfo,
    ) Error!void {
        const result = c.vmaEndDefragmentationPass(self.handle, context, @ptrCast(p_pass_info));
        try vkCheck(result);
    }

    pub fn bindBufferMemory(
        self: Allocator,
        allocation: Allocation,
        buffer: vk.Buffer,
    ) Error!void {
        const result = c.vmaBindBufferMemory(
            self.handle,
            allocation,
            zigHandleToC(c.VkBuffer, buffer),
        );
        try vkCheck(result);
    }

    pub fn bindBufferMemory2(
        self: Allocator,
        allocation: Allocation,
        allocation_local_offset: vk.DeviceSize,
        buffer: vk.Buffer,
        p_next: ?*const anyopaque,
    ) Error!void {
        const result = c.vmaBindBufferMemory2(
            self.handle,
            allocation,
            allocation_local_offset,
            zigHandleToC(c.VkBuffer, buffer),
            p_next,
        );
        try vkCheck(result);
    }

    pub fn bindImageMemory(
        self: Allocator,
        allocation: Allocation,
        image: vk.Image,
    ) Error!void {
        const result = c.vmaBindImageMemory(
            self.handle,
            allocation,
            zigHandleToC(c.VkImage, image),
        );
        try vkCheck(result);
    }

    pub fn bindImageMemory2(
        self: Allocator,
        allocation: Allocation,
        allocation_local_offset: vk.DeviceSize,
        image: vk.Image,
        p_next: ?*const anyopaque,
    ) Error!void {
        const result = c.vmaBindImageMemory2(
            self.handle,
            allocation,
            allocation_local_offset,
            zigHandleToC(c.VkImage, image),
            p_next,
        );
        try vkCheck(result);
    }

    pub fn createBuffer(
        self: Allocator,
        p_buffer_create_info: *const vk.BufferCreateInfo,
        p_allocation_create_info: *const AllocationCreateInfo,
        p_allocation_info: ?*AllocationInfo,
    ) Error!AllocatedBuffer {
        var buffer: vk.Buffer = undefined;
        var allocation: Allocation = undefined;
        const result = c.vmaCreateBuffer(
            self.handle,
            @ptrCast(p_buffer_create_info),
            @ptrCast(p_allocation_create_info),
            @ptrCast(&buffer),
            @ptrCast(&allocation),
            @ptrCast(p_allocation_info),
        );
        try vkCheck(result);
        return .{ .handle = buffer, .allocation = allocation };
    }

    pub fn createBufferWithAlignment(
        self: Allocator,
        p_buffer_create_info: *const vk.BufferCreateInfo,
        p_allocation_create_info: *const AllocationCreateInfo,
        min_alignment: vk.DeviceSize,
        p_allocation_info: ?*AllocationInfo,
    ) Error!AllocatedBuffer {
        var buffer: vk.Buffer = undefined;
        var allocation: Allocation = undefined;
        const result = c.vmaCreateBufferWithAlignment(
            self.handle,
            @ptrCast(p_buffer_create_info),
            @ptrCast(p_allocation_create_info),
            min_alignment,
            @ptrCast(&buffer),
            @ptrCast(&allocation),
            @ptrCast(p_allocation_info),
        );
        try vkCheck(result);
        return .{ .handle = buffer, .allocation = allocation };
    }

    pub fn createAliasingBuffer(
        self: Allocator,
        allocation: Allocation,
        p_buffer_create_info: *const vk.BufferCreateInfo,
    ) Error!vk.Buffer {
        var buffer: vk.Buffer = undefined;
        const result = c.vmaCreateAliasingBuffer(
            self.handle,
            allocation,
            @ptrCast(p_buffer_create_info),
            @ptrCast(&buffer),
        );
        try vkCheck(result);
        return buffer;
    }

    pub fn createAliasingBuffer2(
        self: Allocator,
        allocation: Allocation,
        allocation_local_offset: vk.DeviceSize,
        p_buffer_create_info: *const vk.BufferCreateInfo,
    ) Error!vk.Buffer {
        var buffer: vk.Buffer = undefined;
        const result = c.vmaCreateAliasingBuffer2(
            self.handle,
            allocation,
            allocation_local_offset,
            @ptrCast(p_buffer_create_info),
            @ptrCast(&buffer),
        );
        try vkCheck(result);
        return buffer;
    }

    pub fn destroyBuffer(self: Allocator, buffer: vk.Buffer, allocation: Allocation) void {
        c.vmaDestroyBuffer(self.handle, zigHandleToC(c.VkBuffer, buffer), allocation);
    }

    pub fn createImage(
        self: Allocator,
        p_image_create_info: *const vk.ImageCreateInfo,
        p_allocation_create_info: *const AllocationCreateInfo,
        p_allocation_info: ?*AllocationInfo,
    ) Error!AllocatedImage {
        var image: vk.Image = undefined;
        var allocation: Allocation = undefined;
        const result = c.vmaCreateImage(
            self.handle,
            @ptrCast(p_image_create_info),
            @ptrCast(p_allocation_create_info),
            @ptrCast(&image),
            @ptrCast(&allocation),
            @ptrCast(p_allocation_info),
        );
        try vkCheck(result);
        return .{ .handle = image, .allocation = allocation };
    }

    pub fn createAliasingImage(
        self: Allocator,
        allocation: Allocation,
        p_image_create_info: *const vk.ImageCreateInfo,
    ) Error!vk.Image {
        var image: vk.Image = undefined;
        const result = c.vmaCreateAliasingImage(
            self.handle,
            allocation,
            @ptrCast(p_image_create_info),
            @ptrCast(&image),
        );
        try vkCheck(result);
        return image;
    }

    pub fn createAliasingImage2(
        self: Allocator,
        allocation: Allocation,
        allocation_local_offset: vk.DeviceSize,
        p_image_create_info: *const vk.ImageCreateInfo,
    ) Error!vk.Image {
        var image: vk.Image = undefined;
        const result = c.vmaCreateAliasingImage2(
            self.handle,
            allocation,
            allocation_local_offset,
            @ptrCast(p_image_create_info),
            @ptrCast(&image),
        );
        try vkCheck(result);
        return image;
    }

    pub fn destroyImage(self: Allocator, image: vk.Image, allocation: Allocation) void {
        c.vmaDestroyImage(self.handle, zigHandleToC(c.VkImage, image), allocation);
    }

    pub fn buildStatsString(self: Allocator, detailed_map: vk.Bool32) ?[*:0]u8 {
        var ptr: ?[*:0]u8 = undefined;
        c.vmaBuildStatsString(self.handle, &ptr, detailed_map);
        return ptr;
    }

    pub fn freeStatsString(self: Allocator, p_stats_string: ?[*:0]u8) void {
        c.vmaFreeStatsString(self.handle, p_stats_string);
    }
};

pub const VirtualBlock = struct {
    handle: VirtualBlockHandle,

    pub fn create(p_create_info: *const VirtualBlockCreateInfo) Error!VirtualBlock {
        var handle: VirtualBlockHandle = undefined;
        const result = c.vmaCreateVirtualBlock(@ptrCast(p_create_info), &handle);
        try vkCheck(result);
        return .{ .handle = handle };
    }

    pub fn destroy(self: VirtualBlock) void {
        c.vmaDestroyVirtualBlock(self.handle);
    }

    pub fn isVirtualBlockEmpty(self: VirtualBlock) vk.Bool32 {
        return c.vmaIsVirtualBlockEmpty(self.handle);
    }

    pub fn getVirtualAllocationInfo(
        self: VirtualBlock,
        allocation: VirtualAllocation,
    ) VirtualAllocationInfo {
        var info: VirtualAllocationInfo = undefined;
        c.vmaGetVirtualAllocationInfo(self.handle, allocation, @ptrCast(&info));
        return info;
    }

    pub fn virtualAllocate(
        self: VirtualBlock,
        p_create_info: *const VirtualAllocationCreateInfo,
        p_offset: ?*vk.DeviceSize,
    ) Error!VirtualAllocation {
        var allocation: VirtualAllocation = undefined;
        const result = c.vmaVirtualAllocate(
            self.handle,
            @ptrCast(p_create_info),
            &allocation,
            @ptrCast(p_offset),
        );
        try vkCheck(result);
        return allocation;
    }

    pub fn virtualFree(self: VirtualBlock, allocation: VirtualAllocation) void {
        c.vmaVirtualFree(self.handle, allocation);
    }

    pub fn clearVirtualBlock(self: VirtualBlock) void {
        c.vmaClearVirtualBlock(self.handle);
    }

    pub fn setVirtualAllocationUserData(
        self: VirtualBlock,
        allocation: VirtualAllocation,
        p_user_data: ?*anyopaque,
    ) void {
        c.vmaSetVirtualAllocationUserData(self.handle, allocation, p_user_data);
    }

    pub fn getVirtualBlockStatistics(self: VirtualBlock) Statistics {
        var stats: Statistics = undefined;
        c.vmaGetVirtualBlockStatistics(self.handle, @ptrCast(&stats));
        return stats;
    }

    pub fn calculateVirtualBlockStatistics(self: VirtualBlock) DetailedStatistics {
        var stats: DetailedStatistics = undefined;
        c.vmaCalculateVirtualBlockStatistics(self.handle, @ptrCast(&stats));
        return stats;
    }

    pub fn buildVirtualBlockStatsString(self: VirtualBlock, detailed_map: vk.Bool32) ?[*:0]u8 {
        var ptr: ?[*:0]u8 = undefined;
        c.vmaBuildVirtualBlockStatsString(self.handle, &ptr, detailed_map);
        return ptr;
    }

    pub fn freeVirtualBlockStatsString(self: VirtualBlock, p_stats_string: ?[*:0]u8) void {
        c.vmaFreeVirtualBlockStatsString(self.handle, p_stats_string);
    }
};

fn vkCheck(result: c.VkResult) Error!void {
    const r: vk.Result = @enumFromInt(result);
    return switch (r) {
        .success => {},
        .not_ready => error.NotReady,
        .timeout => error.Timeout,
        .event_set => error.EventSet,
        .event_reset => error.EventReset,
        .incomplete => error.Incomplete,
        .error_out_of_host_memory => error.OutOfHostMemory,
        .error_out_of_device_memory => error.OutOfDeviceMemory,
        .error_initialization_failed => error.InitializationFailed,
        .error_device_lost => error.DeviceLost,
        .error_memory_map_failed => error.MemoryMapFailed,
        .error_layer_not_present => error.LayerNotPresent,
        .error_extension_not_present => error.ExtensionNotPresent,
        .error_feature_not_present => error.FeatureNotPresent,
        .error_incompatible_driver => error.IncompatibleDriver,
        .error_too_many_objects => error.TooManyObjects,
        .error_format_not_supported => error.FormatNotSupported,
        .error_fragmented_pool => error.FragmentedPool,
        .error_out_of_pool_memory => error.OutOfPoolMemory,
        .error_invalid_external_handle => error.InvalidExternalHandle,
        .error_fragmentation => error.Fragmentation,
        .error_invalid_opaque_capture_address => error.InvalidOpaqueCaptureAddress,
        .pipeline_compile_required => error.PipelineCompileRequired,
        .error_surface_lost_khr => error.SurfaceLostKhr,
        .error_native_window_in_use_khr => error.NativeWindowInUseKhr,
        .suboptimal_khr => error.SuboptimalKhr,
        .error_out_of_date_khr => error.OutOfDateKhr,
        .error_incompatible_display_khr => error.IncompatibleDisplayKhr,
        .error_validation_failed_ext => error.ValidationFailedExt,
        .error_invalid_shader_nv => error.InvalidShaderNv,
        .error_image_usage_not_supported_khr => error.ImageUsageNotSupportedKhr,
        .error_video_picture_layout_not_supported_khr => error.VideoPictureLayoutNotSupportedKhr,
        .error_video_profile_operation_not_supported_khr => error.VideoProfileOperationNotSupportedKhr,
        .error_video_profile_format_not_supported_khr => error.VideoProfileFormatNotSupportedKhr,
        .error_video_profile_codec_not_supported_khr => error.VideoProfileCodecNotSupportedKhr,
        .error_video_std_version_not_supported_khr => error.VideoStdVersionNotSupportedKhr,
        .error_invalid_drm_format_modifier_plane_layout_ext => error.InvalidDrmFormatModifierPlaneLayoutExt,
        .error_not_permitted_khr => error.NotPermittedKhr,
        .error_full_screen_exclusive_mode_lost_ext => error.FullScreenExclusiveModeLostExt,
        .thread_idle_khr => error.ThreadIdleKhr,
        .thread_done_khr => error.ThreadDoneKhr,
        .operation_deferred_khr => error.OperationDeferredKhr,
        .operation_not_deferred_khr => error.OperationNotDeferredKhr,
        .error_invalid_video_std_parameters_khr => error.InvalidVideoStdParametersKhr,
        .error_compression_exhausted_ext => error.CompressionExhaustedExt,
        .incompatible_shader_binary_ext => error.IncompatibleShaderBinaryExt,
        .error_unknown => error.Unknown,
        else => error.Unknown,
    };
}
