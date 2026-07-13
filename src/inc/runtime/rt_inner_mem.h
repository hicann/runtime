/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_MEM_H
#define CCE_RUNTIME_RT_INNER_MEM_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

// for mem link
#define RT_MEM_LINK_IDX_0 0U     // SIO
#define RT_MEM_LINK_IDX_1 1U     // HCCS

typedef struct {
    uint32_t side;
    uint32_t devId;
    rtDrvMemHandleType handleType;
    size_t maxSize;
    uint64_t reserve;
} rtMemPoolProps;

typedef void *rtMemPool_t;

typedef enum rtMemPoolAttr {
    rtMemPoolReuseFollowEventDependencies = 0x1,
    rtMemPoolReuseAllowOpportunistic = 0x2,
    rtMemPoolReuseAllowInternalDependencies = 0x3,
    rtMemPoolAttrReleaseThreshold = 0x4,
    rtMemPoolAttrReservedMemCurrent = 0x5,
    rtMemPoolAttrReservedMemHigh = 0x6,
    rtMemPoolAttrUsedMemCurrent = 0x7,
    rtMemPoolAttrUsedMemHigh = 0x8
} rtMemPoolAttr;

typedef enum rtGraphMemAttributeType {
    rtGraphMemAttrReservedMemCurrent = 0x0,
    rtGraphMemAttrReservedMemHigh = 0x1,
    rtGraphMemAttrUsedMemCurrent = 0x2,
    rtGraphMemAttrUsedMemHigh = 0x3
} rtGraphMemAttributeType;

typedef enum rtMemPoolReleaseFlag {
    rtMemPoolReleaseFlagSingle = 0x0,
    rtMemPoolReleaseFlagForce = 0x1,
    rtMemPoolReleaseFlagAll = 0x2
} rtMemPoolReleaseFlag;

typedef enum tagRtMemManagedRangeAttribute {
    rtMemRangeAttributeReadMostly = 1,
    rtMemRangeAttributePreferredLocation,
    rtMemRangeAttributeAccessedBy,
    rtMemRangeAttributePreferredLocationType,
    rtMemRangeAttributePreferredLocationId,
    rtMemRangeAttributeLastPrefetchLocation,
    rtMemRangeAttributeLastPrefetchLocationType,
    rtMemRangeAttributeLastPrefetchLocationId
} rtMemManagedRangeAttribute;

typedef enum rtMemManagedAdvise {
    rtMemAdviseSetReadMostly = 0,
    rtMemAdviseUnSetReadMostly,
    rtMemAdviseSetPreferredLocation,
    rtMemAdviseUnSetPreferredLocation,
    rtMemAdviseSetAccessedBy,
    rtMemAdviseUnSetAccessedBy
} rtMemManagedAdviseType;

typedef enum rtMemManagedLocationType {
    rtMemLocationTypeInvalid = 0,
    rtMemLocationTypeDevice,
    rtMemLocationTypeHost,
    rtMemLocationTypeHostNuma,
    rtMemLocationTypeHostNumaCurrent
} rtMemManagedLocationType;

typedef struct rtMemManagedLocation{
    rtMemManagedLocationType type;
    int32_t id;
} rtMemManagedLocation;

typedef struct {
    unsigned int memMapRoute; /* 1:hccs  0:sio */
    unsigned int rev[4];
} rtHandleAttr;

typedef enum rtMemLinkType {
    RT_MEM_ACCESS_LINK_SIO = 0, // only support A3
    RT_MEM_ACCESS_LINK_HCCS = 1, // only support A3
    RT_MEM_ACCESS_UB_ONE_PORT_PATH = 2, // only support A5
    RT_MEM_ACCESS_UB_MULTI_PORT_PATH = 3, // only support A5
    RT_MEM_ACCESS_LINK_MAX
} rtMemLinkType;

typedef enum tagRtIpcMemAttr {
    RT_IPC_MEM_ATTR_SIO = 0, // only support A3
    RT_IPC_MEM_ATTR_HCCS = 1, // only support A3
    RT_IPC_MEM_ATTR_UB_ONE_PORT_PATH = 2, // only support A5
    RT_IPC_MEM_ATTR_UB_MULTI_PORT_PATH = 3, // only support A5
    RT_IPC_MEM_ATTR_MAX
} rtIpcMemAttr;

/**
* @ingroup rt_mem
* @brief Create new memory pool.
* @param [IN] poolProps The memory pool parameters.
* @param [OUT] memPool Pointer to memory pool handle.
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtMemPoolCreate(rtMemPool_t *memPool, const rtMemPoolProps *poolProps);

/**
* @ingroup rt_mem
* @brief Destroy the memory pool.
* @param [IN] memPool Virtual mem pool handle.
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtMemPoolDestroy(rtMemPool_t const memPool);

/**
* @ingroup rt_mem
* @brief Set specific attributes of the memory pool.
* @param [IN] memPool Virtual mem pool handle.
* @param [IN] attr The Memory pool attribute to be modified.
* @param [IN] value The value to be modified.
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value);

/**
* @ingroup rt_mem
* @brief Get specific attributes of the memory pool.
* @param [IN] memPool Virtual mem pool handle.
* @param [IN] attr The Memory pool attribute to be obtained.
* @param [OUT] value The value to be obtained.
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value);

/**
 * @ingroup dvrt_mem
 * @brief get start address and size of memory block
 * @param  [in] ptr Address whithin a certain memory block range
 * @param  [out] pbase Start address of the memory block
 * @param  [out] psize Size of th memory block
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtMemGetAddressRange(void *ptr, void **pbase, size_t *psize);

/**
 * @ingroup dvrt_mem
 * @brief Prefetch memory to device
 * @param devPtr [IN]   Device memory address
 * @param len [IN]  Size of the memory
 * @param devId [IN]  Physical id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtMemPrefetchToDevice(void *devPtr, uint64_t len, int32_t devId);

/**
* @ingroup rt_mem
* @brief Allocating memory from memory pool asynchronously.
* @param [OUT] ptr The pointer pointing to the memory to be allocated.
* @param [IN] size The size of memory to be allocated.
* @param [IN] memPoolId Id of the target memory pool.
* @param [IN] stm The stream to perform memory allocation task.
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtMemPoolMallocAsync(void **ptr, const uint64_t size, const rtMemPool_t memPoolId, const rtStream_t stm);
 
/**
 * @ingroup rt_mem
 * @brief Free memory from memory pool asynchronously.
 * @param [IN] ptr The pointer to the memory to be released.
 * @param [IN] stm The stream to perform memory releasing task.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemPoolFreeAsync(void* ptr, rtStream_t stm);

/**
 * @ingroup dvrt_mem
 * @brief Set/cancel the properties of a section of UVM memory
 * @param [in] Ptr      memory pointer
 * @param [in] size     memory count
 * @param [in] advise   advise type
 * @param [in] location the location information of physical memory
 * @return RT_ERROR_NONE for ok
 * @return others for error
 */
RTS_API rtError_t rtMemManagedAdvise(const void *const ptr, uint64_t size, uint16_t advise, rtMemManagedLocation location);

/**
 * @ingroup dvrt_mem
 * @brief query the attribute of UVM memory
 * @param [in] attribute    The type of the attribute
 * @param [in] ptr          memory pointer
 * @param [in] size         memory size
 * @param [out] data        the result of the query
 * @param [in] dataSize     the size of the buffer where the query result are stored  
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemManagedGetAttr(rtMemManagedRangeAttribute attribute, const void *ptr, size_t size, void *data, size_t dataSize);

/**
 * @ingroup dvrt_mem
 * @brief query the attributes of UVM memory
 * @param [in] attributes       The type of the attributes
 * @param [in] numAttributes    The number of the attributes
 * @param [in] ptr              memory pointer
 * @param [in] size             memory size
 * @param [out] data            the result of the query
 * @param [in] dataSizes        the size of the buffer where the query result are stored
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemManagedGetAttrs(rtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, 
                                      size_t size, void **data, size_t *dataSizes);

/**
 * @ingroup rts_mem
 * @brief Trim the specified memory pool to retain the specified minimum free memory.
 * @param [IN] memPool Id of the target memory pool.
 * @param [IN] minBytesToKeep The minimum number of bytes to keep in the memory pool.
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_XXX for error input
 */
RTS_API rtError_t rtMemPoolTrimTo(rtMemPool_t memPool, uint64_t minBytesToKeep);

/**
* @ingroup rt_mem
 * @brief Asynchronous prefetch memory to the specified destination device.
 * @param [in] ptr      UVM(unified virtual memory) address which will be prefetched.
 * @param [in] size     size of memory in bytes.
 * @param [in] location destination physics memory location to prefetch to.
 * @param [in] flags    reserved, must be 0.
 * @param [in] stream   stream to enqueue prefetch operation.
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemManagedPrefetchAsync(const void* ptr, size_t size, rtMemManagedLocation location,
    uint32_t flags, rtStream_t stream);

/**
 * @ingroup rt_mem
 * @brief Performs a batch of memory prefetches asynchronously.
 * @param [in] ptrs            array of UVM(unified virtual memory) address which will be prefetched.
 * @param [in] sizes           array of each prefetched memory size (in byte).
 * @param [in] count           size of dptrs and sizes arrays.
 * @param [in] prefetchLocs    array of destination physics memory location to prefetch to.
 * @param [in] prefetchLocIdxs index array mapping prefetchLocs elements to a range of prefetch operations:
                               prefetchLocs[k] applies to operations from prefetchLocIdxs[k] to prefetchLocIdxs[k+1]-1;
                               prefetchLocs[numPrefetchLocs - 1] applies from prefetchLocIdxs[numPrefetchLocs-1] to count-1.
 * @param [in] numPrefetchLocs size of prefetchLocs and prefetchLocIdxs arrays.
 * @param [in] flags           reserved, must be 0.
 * @param [in] stream          stream to enqueue prefetch operation.
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemManagedPrefetchBatchAsync(const void** ptrs, size_t* sizes, size_t count,
    rtMemManagedLocation* prefetchLocs, size_t* prefetchLocIdxs, size_t numPrefetchLocs, uint64_t flags,
    rtStream_t stream);

/** 
 * @ingroup rt_mem
 * @brief virPtrDst can be mapped to the physical address of virPtrSrc through different channels.
 * @param [in] virPtrDst        virtual address.
 * @param [in] size             Memory size.
 * @param [in] virPtrSrc        Mapped virtual address.
 * @param [in] linkIdx          Link channel.
 * @return RT_ERROR_NONE for ok, errno for failed.
 * @return RT_ERROR_INVALID_VALUE for error input.
 * @return RT_ERROR_FEATURE_NOT_SUPPORT for not support.
 * @return RT_ERROR_DRV_ERR for driver error.
 */
RTS_API rtError_t rtMemMapSelectedLink(void *virPtrDst, size_t size, void *virPtrSrc, uint32_t linkIdx);

/**
 * @ingroup rt_mem
 * @brief Bind physical memory to a virtual address range without access permission.
 * @param [in] virPtr virtual address to map.
 * @param [in] size mapping size in bytes.
 * @param [in] offset offset into the memory represented by handle.
 * @param [in] handle physical memory handle.
 * @param [in] flags reserved, must be 0.
 * @return RT_ERROR_NONE for ok.
 * @return RT_ERROR_FEATURE_NOT_SUPPORT if the driver does not support this function.
 * @return RT_ERROR_DRV_ERR for driver error.
 */
RTS_API rtError_t rtMemMapNoAccess(
    void *virPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags);

/**
 * @ingroup dvrt_mem
 * @brief set memory with uint32_t value (element-wise)
 * @param [in] dst      destination address
 * @param [in] destMax  length of destination address memory in bytes
 * @param [in] value    32-bit value to fill
 * @param [in] count    number of uint32_t elements to set
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemsetD32(void *dst, uint64_t destMax, uint32_t value, uint64_t count);

/**
 * @ingroup dvrt_mem
 * @brief set memory with uint32_t value asynchronously (element-wise)
 * @param [in] dst      destination address
 * @param [in] destMax  length of destination address memory in bytes
 * @param [in] value    32-bit value to fill
 * @param [in] count    number of uint32_t elements to set
 * @param [in] stm      stream handle
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMemsetD32Async(void *dst, uint64_t destMax, uint32_t value, uint64_t count, rtStream_t stm);
#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_MEM_H
