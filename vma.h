/** \brief Binds buffer to allocation.

Binds specified buffer to region of memory represented by specified allocation.
Gets `VkDeviceMemory` handle and offset from the allocation.
If you want to create a buffer, allocate memory for it and bind them together separately,
you should use this function for binding instead of standard `vkBindBufferMemory()`,
because it ensures proper synchronization so that when a `VkDeviceMemory` object is used by multiple
allocations, calls to `vkBind*Memory()` or `vkMapMemory()` won't happen from multiple threads simultaneously
(which is illegal in Vulkan).

It is recommended to use function vmaCreateBuffer() instead of this one.
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaBindBufferMemory(
    VmaAllocator VMA_NOT_NULL allocator,
    VmaAllocation VMA_NOT_NULL allocation,
    VkBuffer VMA_NOT_NULL_NON_DISPATCHABLE buffer);

/** \brief Binds buffer to allocation with additional parameters.

\param allocator
\param allocation
\param allocationLocalOffset Additional offset to be added while binding, relative to the beginning of the `allocation`. Normally it should be 0.
\param buffer
\param pNext A chain of structures to be attached to `VkBindBufferMemoryInfoKHR` structure used internally. Normally it should be null.

This function is similar to vmaBindBufferMemory(), but it provides additional parameters.

If `pNext` is not null, #VmaAllocator object must have been created with #VMA_ALLOCATOR_CREATE_KHR_BIND_MEMORY2_BIT flag
or with VmaAllocatorCreateInfo::vulkanApiVersion `>= VK_API_VERSION_1_1`. Otherwise the call fails.
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaBindBufferMemory2(
    VmaAllocator VMA_NOT_NULL allocator,
    VmaAllocation VMA_NOT_NULL allocation,
    VkDeviceSize allocationLocalOffset,
    VkBuffer VMA_NOT_NULL_NON_DISPATCHABLE buffer,
    const void* VMA_NULLABLE VMA_EXTENDS_VK_STRUCT(VkBindBufferMemoryInfoKHR) pNext);

/** \brief Binds image to allocation.

Binds specified image to region of memory represented by specified allocation.
Gets `VkDeviceMemory` handle and offset from the allocation.
If you want to create an image, allocate memory for it and bind them together separately,
you should use this function for binding instead of standard `vkBindImageMemory()`,
because it ensures proper synchronization so that when a `VkDeviceMemory` object is used by multiple
allocations, calls to `vkBind*Memory()` or `vkMapMemory()` won't happen from multiple threads simultaneously
(which is illegal in Vulkan).

It is recommended to use function vmaCreateImage() instead of this one.
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaBindImageMemory(
    VmaAllocator VMA_NOT_NULL allocator,
    VmaAllocation VMA_NOT_NULL allocation,
    VkImage VMA_NOT_NULL_NON_DISPATCHABLE image);

/** \brief Binds image to allocation with additional parameters.

\param allocator
\param allocation
\param allocationLocalOffset Additional offset to be added while binding, relative to the beginning of the `allocation`. Normally it should be 0.
\param image
\param pNext A chain of structures to be attached to `VkBindImageMemoryInfoKHR` structure used internally. Normally it should be null.

This function is similar to vmaBindImageMemory(), but it provides additional parameters.

If `pNext` is not null, #VmaAllocator object must have been created with #VMA_ALLOCATOR_CREATE_KHR_BIND_MEMORY2_BIT flag
or with VmaAllocatorCreateInfo::vulkanApiVersion `>= VK_API_VERSION_1_1`. Otherwise the call fails.
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaBindImageMemory2(
    VmaAllocator VMA_NOT_NULL allocator,
    VmaAllocation VMA_NOT_NULL allocation,
    VkDeviceSize allocationLocalOffset,
    VkImage VMA_NOT_NULL_NON_DISPATCHABLE image,
    const void* VMA_NULLABLE VMA_EXTENDS_VK_STRUCT(VkBindImageMemoryInfoKHR) pNext);

/** \brief Creates a new `VkBuffer`, allocates and binds memory for it.

\param allocator
\param pBufferCreateInfo
\param pAllocationCreateInfo
\param[out] pBuffer Buffer that was created.
\param[out] pAllocation Allocation that was created.
\param[out] pAllocationInfo Optional. Information about allocated memory. It can be later fetched using function vmaGetAllocationInfo().

This function automatically:

-# Creates buffer.
-# Allocates appropriate memory for it.
-# Binds the buffer with the memory.

If any of these operations fail, buffer and allocation are not created,
returned value is negative error code, `*pBuffer` and `*pAllocation` are null.

If the function succeeded, you must destroy both buffer and allocation when you
no longer need them using either convenience function vmaDestroyBuffer() or
separately, using `vkDestroyBuffer()` and vmaFreeMemory().

If #VMA_ALLOCATOR_CREATE_KHR_DEDICATED_ALLOCATION_BIT flag was used,
VK_KHR_dedicated_allocation extension is used internally to query driver whether
it requires or prefers the new buffer to have dedicated allocation. If yes,
and if dedicated allocation is possible
(#VMA_ALLOCATION_CREATE_NEVER_ALLOCATE_BIT is not used), it creates dedicated
allocation for this buffer, just like when using
#VMA_ALLOCATION_CREATE_DEDICATED_MEMORY_BIT.

\note This function creates a new `VkBuffer`. Sub-allocation of parts of one large buffer,
although recommended as a good practice, is out of scope of this library and could be implemented
by the user as a higher-level logic on top of VMA.
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaCreateBuffer(
    VmaAllocator VMA_NOT_NULL allocator,
    const VkBufferCreateInfo* VMA_NOT_NULL pBufferCreateInfo,
    const VmaAllocationCreateInfo* VMA_NOT_NULL pAllocationCreateInfo,
    VkBuffer VMA_NULLABLE_NON_DISPATCHABLE* VMA_NOT_NULL pBuffer,
    VmaAllocation VMA_NULLABLE* VMA_NOT_NULL pAllocation,
    VmaAllocationInfo* VMA_NULLABLE pAllocationInfo);

/** \brief Creates a buffer with additional minimum alignment.

Similar to vmaCreateBuffer() but provides additional parameter `minAlignment` which allows to specify custom,
minimum alignment to be used when placing the buffer inside a larger memory block, which may be needed e.g.
for interop with OpenGL.
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaCreateBufferWithAlignment(
    VmaAllocator VMA_NOT_NULL allocator,
    const VkBufferCreateInfo* VMA_NOT_NULL pBufferCreateInfo,
    const VmaAllocationCreateInfo* VMA_NOT_NULL pAllocationCreateInfo,
    VkDeviceSize minAlignment,
    VkBuffer VMA_NULLABLE_NON_DISPATCHABLE* VMA_NOT_NULL pBuffer,
    VmaAllocation VMA_NULLABLE* VMA_NOT_NULL pAllocation,
    VmaAllocationInfo* VMA_NULLABLE pAllocationInfo);

/** \brief Creates a new `VkBuffer`, binds already created memory for it.

\param allocator
\param allocation Allocation that provides memory to be used for binding new buffer to it.
\param pBufferCreateInfo
\param[out] pBuffer Buffer that was created.

This function automatically:

-# Creates buffer.
-# Binds the buffer with the supplied memory.

If any of these operations fail, buffer is not created,
returned value is negative error code and `*pBuffer` is null.

If the function succeeded, you must destroy the buffer when you
no longer need it using `vkDestroyBuffer()`. If you want to also destroy the corresponding
allocation you can use convenience function vmaDestroyBuffer().

\note There is a new version of this function augmented with parameter `allocationLocalOffset` - see vmaCreateAliasingBuffer2().
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaCreateAliasingBuffer(
    VmaAllocator VMA_NOT_NULL allocator,
    VmaAllocation VMA_NOT_NULL allocation,
    const VkBufferCreateInfo* VMA_NOT_NULL pBufferCreateInfo,
    VkBuffer VMA_NULLABLE_NON_DISPATCHABLE* VMA_NOT_NULL pBuffer);

/** \brief Creates a new `VkBuffer`, binds already created memory for it.

\param allocator
\param allocation Allocation that provides memory to be used for binding new buffer to it.
\param allocationLocalOffset Additional offset to be added while binding, relative to the beginning of the allocation. Normally it should be 0.
\param pBufferCreateInfo 
\param[out] pBuffer Buffer that was created.

This function automatically:

-# Creates buffer.
-# Binds the buffer with the supplied memory.

If any of these operations fail, buffer is not created,
returned value is negative error code and `*pBuffer` is null.

If the function succeeded, you must destroy the buffer when you
no longer need it using `vkDestroyBuffer()`. If you want to also destroy the corresponding
allocation you can use convenience function vmaDestroyBuffer().

\note This is a new version of the function augmented with parameter `allocationLocalOffset`.
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaCreateAliasingBuffer2(
    VmaAllocator VMA_NOT_NULL allocator,
    VmaAllocation VMA_NOT_NULL allocation,
    VkDeviceSize allocationLocalOffset,
    const VkBufferCreateInfo* VMA_NOT_NULL pBufferCreateInfo,
    VkBuffer VMA_NULLABLE_NON_DISPATCHABLE* VMA_NOT_NULL pBuffer);

/** \brief Destroys Vulkan buffer and frees allocated memory.

This is just a convenience function equivalent to:

\code
vkDestroyBuffer(device, buffer, allocationCallbacks);
vmaFreeMemory(allocator, allocation);
\endcode

It is safe to pass null as buffer and/or allocation.
*/
VMA_CALL_PRE void VMA_CALL_POST vmaDestroyBuffer(
    VmaAllocator VMA_NOT_NULL allocator,
    VkBuffer VMA_NULLABLE_NON_DISPATCHABLE buffer,
    VmaAllocation VMA_NULLABLE allocation);

/// Function similar to vmaCreateBuffer().
VMA_CALL_PRE VkResult VMA_CALL_POST vmaCreateImage(
    VmaAllocator VMA_NOT_NULL allocator,
    const VkImageCreateInfo* VMA_NOT_NULL pImageCreateInfo,
    const VmaAllocationCreateInfo* VMA_NOT_NULL pAllocationCreateInfo,
    VkImage VMA_NULLABLE_NON_DISPATCHABLE* VMA_NOT_NULL pImage,
    VmaAllocation VMA_NULLABLE* VMA_NOT_NULL pAllocation,
    VmaAllocationInfo* VMA_NULLABLE pAllocationInfo);

/// Function similar to vmaCreateAliasingBuffer() but for images.
VMA_CALL_PRE VkResult VMA_CALL_POST vmaCreateAliasingImage(
    VmaAllocator VMA_NOT_NULL allocator,
    VmaAllocation VMA_NOT_NULL allocation,
    const VkImageCreateInfo* VMA_NOT_NULL pImageCreateInfo,
    VkImage VMA_NULLABLE_NON_DISPATCHABLE* VMA_NOT_NULL pImage);

/// Function similar to vmaCreateAliasingBuffer2() but for images.
VMA_CALL_PRE VkResult VMA_CALL_POST vmaCreateAliasingImage2(
    VmaAllocator VMA_NOT_NULL allocator,
    VmaAllocation VMA_NOT_NULL allocation,
    VkDeviceSize allocationLocalOffset,
    const VkImageCreateInfo* VMA_NOT_NULL pImageCreateInfo,
    VkImage VMA_NULLABLE_NON_DISPATCHABLE* VMA_NOT_NULL pImage);

/** \brief Destroys Vulkan image and frees allocated memory.

This is just a convenience function equivalent to:

\code
vkDestroyImage(device, image, allocationCallbacks);
vmaFreeMemory(allocator, allocation);
\endcode

It is safe to pass null as image and/or allocation.
*/
VMA_CALL_PRE void VMA_CALL_POST vmaDestroyImage(
    VmaAllocator VMA_NOT_NULL allocator,
    VkImage VMA_NULLABLE_NON_DISPATCHABLE image,
    VmaAllocation VMA_NULLABLE allocation);

/** @} */

/**
\addtogroup group_virtual
@{
*/

/** \brief Creates new #VmaVirtualBlock object.

\param pCreateInfo Parameters for creation.
\param[out] pVirtualBlock Returned virtual block object or `VMA_NULL` if creation failed.
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaCreateVirtualBlock(
    const VmaVirtualBlockCreateInfo* VMA_NOT_NULL pCreateInfo,
    VmaVirtualBlock VMA_NULLABLE* VMA_NOT_NULL pVirtualBlock);

/** \brief Destroys #VmaVirtualBlock object.

Please note that you should consciously handle virtual allocations that could remain unfreed in the block.
You should either free them individually using vmaVirtualFree() or call vmaClearVirtualBlock()
if you are sure this is what you want. If you do neither, an assert is called.

If you keep pointers to some additional metadata associated with your virtual allocations in their `pUserData`,
don't forget to free them.
*/
VMA_CALL_PRE void VMA_CALL_POST vmaDestroyVirtualBlock(
    VmaVirtualBlock VMA_NULLABLE virtualBlock);

/** \brief Returns true of the #VmaVirtualBlock is empty - contains 0 virtual allocations and has all its space available for new allocations.
*/
VMA_CALL_PRE VkBool32 VMA_CALL_POST vmaIsVirtualBlockEmpty(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock);

/** \brief Returns information about a specific virtual allocation within a virtual block, like its size and `pUserData` pointer.
*/
VMA_CALL_PRE void VMA_CALL_POST vmaGetVirtualAllocationInfo(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock,
    VmaVirtualAllocation VMA_NOT_NULL_NON_DISPATCHABLE allocation, VmaVirtualAllocationInfo* VMA_NOT_NULL pVirtualAllocInfo);

/** \brief Allocates new virtual allocation inside given #VmaVirtualBlock.

If the allocation fails due to not enough free space available, `VK_ERROR_OUT_OF_DEVICE_MEMORY` is returned
(despite the function doesn't ever allocate actual GPU memory).
`pAllocation` is then set to `VK_NULL_HANDLE` and `pOffset`, if not null, it set to `UINT64_MAX`.

\param virtualBlock Virtual block
\param pCreateInfo Parameters for the allocation
\param[out] pAllocation Returned handle of the new allocation
\param[out] pOffset Returned offset of the new allocation. Optional, can be null.
*/
VMA_CALL_PRE VkResult VMA_CALL_POST vmaVirtualAllocate(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock,
    const VmaVirtualAllocationCreateInfo* VMA_NOT_NULL pCreateInfo,
    VmaVirtualAllocation VMA_NULLABLE_NON_DISPATCHABLE* VMA_NOT_NULL pAllocation,
    VkDeviceSize* VMA_NULLABLE pOffset);

/** \brief Frees virtual allocation inside given #VmaVirtualBlock.

It is correct to call this function with `allocation == VK_NULL_HANDLE` - it does nothing.
*/
VMA_CALL_PRE void VMA_CALL_POST vmaVirtualFree(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock,
    VmaVirtualAllocation VMA_NULLABLE_NON_DISPATCHABLE allocation);

/** \brief Frees all virtual allocations inside given #VmaVirtualBlock.

You must either call this function or free each virtual allocation individually with vmaVirtualFree()
before destroying a virtual block. Otherwise, an assert is called.

If you keep pointer to some additional metadata associated with your virtual allocation in its `pUserData`,
don't forget to free it as well.
*/
VMA_CALL_PRE void VMA_CALL_POST vmaClearVirtualBlock(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock);

/** \brief Changes custom pointer associated with given virtual allocation.
*/
VMA_CALL_PRE void VMA_CALL_POST vmaSetVirtualAllocationUserData(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock,
    VmaVirtualAllocation VMA_NOT_NULL_NON_DISPATCHABLE allocation,
    void* VMA_NULLABLE pUserData);

/** \brief Calculates and returns statistics about virtual allocations and memory usage in given #VmaVirtualBlock.

This function is fast to call. For more detailed statistics, see vmaCalculateVirtualBlockStatistics().
*/
VMA_CALL_PRE void VMA_CALL_POST vmaGetVirtualBlockStatistics(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock,
    VmaStatistics* VMA_NOT_NULL pStats);

/** \brief Calculates and returns detailed statistics about virtual allocations and memory usage in given #VmaVirtualBlock.

This function is slow to call. Use for debugging purposes.
For less detailed statistics, see vmaGetVirtualBlockStatistics().
*/
VMA_CALL_PRE void VMA_CALL_POST vmaCalculateVirtualBlockStatistics(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock,
    VmaDetailedStatistics* VMA_NOT_NULL pStats);

/** @} */

#if VMA_STATS_STRING_ENABLED
/**
\addtogroup group_stats
@{
*/

/** \brief Builds and returns a null-terminated string in JSON format with information about given #VmaVirtualBlock.
\param virtualBlock Virtual block.
\param[out] ppStatsString Returned string.
\param detailedMap Pass `VK_FALSE` to only obtain statistics as returned by vmaCalculateVirtualBlockStatistics(). Pass `VK_TRUE` to also obtain full list of allocations and free spaces.

Returned string must be freed using vmaFreeVirtualBlockStatsString().
*/
VMA_CALL_PRE void VMA_CALL_POST vmaBuildVirtualBlockStatsString(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock,
    char* VMA_NULLABLE* VMA_NOT_NULL ppStatsString,
    VkBool32 detailedMap);

/// Frees a string returned by vmaBuildVirtualBlockStatsString().
VMA_CALL_PRE void VMA_CALL_POST vmaFreeVirtualBlockStatsString(
    VmaVirtualBlock VMA_NOT_NULL virtualBlock,
    char* VMA_NULLABLE pStatsString);

