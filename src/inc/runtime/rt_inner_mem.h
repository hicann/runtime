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
RTS_API rtError_t rtMemPoolDestroy(const rtMemPool_t memPool);

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

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_MEM_H
