/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef INC_EXTERNAL_ACL_RT_MEMORY_H_
#define INC_EXTERNAL_ACL_RT_MEMORY_H_

#include <stddef.h>
#include "acl_base.h"
#include "acl/acl_rt.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef void *aclrtMemPool; 

typedef enum aclrtMemPoolAttr{
    ACL_RT_MEM_POOL_REUSE_FOLLOW_EVENT_DEPENDENCIES = 0x1,
    ACL_RT_MEM_POOL_REUSE_ALLOW_OPPORTUNISTIC = 0x2,
    ACL_RT_MEM_POOL_REUSE_ALLOW_INTERNAL_DEPENDENCIES = 0x3,
    ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD = 0x4,
    ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_CURRENT = 0x5,
    ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_HIGH = 0x6,
    ACL_RT_MEM_POOL_ATTR_USED_MEM_CURRENT = 0x7,
    ACL_RT_MEM_POOL_ATTR_USED_MEM_HIGH = 0x8
} aclrtMemPoolAttr;

typedef struct {
    aclrtMemAllocationType allocType;
    aclrtMemHandleType handleType;
    aclrtMemLocation location;
    size_t maxSize;
    unsigned char reserved[32];
} aclrtMemPoolProps;

/**
* @ingroup AscendCL
* @brief Create new memory pool
*
* @param poolProps [IN] the memory pool parameters
* @param memPool [OUT] pointer to memory pool handle
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
ACL_FUNC_VISIBILITY aclError aclrtMemPoolCreate(aclrtMemPool *memPool, const aclrtMemPoolProps *poolProps);

/**
* @ingroup AscendCL
* @brief Destroy the memory pool
*
* @param memPool [IN] virtual mem pool handle
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
ACL_FUNC_VISIBILITY aclError aclrtMemPoolDestroy(const aclrtMemPool memPool);

/**
* @ingroup AscendCL
* @brief Set specific attribute of the memory pool
*
* @param memPool [IN] virtual mem pool handle
* @param attr [IN] the Memory pool attribute to be modified
* @param value [IN] the value to be modified
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
ACL_FUNC_VISIBILITY aclError aclrtMemPoolSetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value);

/**
* @ingroup AscendCL
* @brief Get specific attribute of the memory pool
*
* @param memPool [IN] virtual mem pool handle
* @param attr [IN] the Memory pool attribute to be obtained
* @param value [OUT] the value to be obtained
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
ACL_FUNC_VISIBILITY aclError aclrtMemPoolGetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value);

/**
* @ingroup AscendCL
* @brief asynchronous allocate memory from specified memory pool
*
* @param ptr [OUT] pointer to the device memory address allocated from memory pool
* @param size [IN] size of memory to allocate (unit: bytes, must be greater than 0)
* @param memPool [IN] unique ID of the target memory pool
* @param stream [IN] stream ID for asynchronous memory allocation operation
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
ACL_FUNC_VISIBILITY aclError aclrtMemPoolMallocAsync(void **ptr, size_t size, aclrtMemPool memPool, aclrtStream stream);

/**
* @ingroup AscendCL
* @brief Asynchronous free memory from mempool
*
* @param ptr [IN] address pointer of the memory to be released
* @param stream [IN] asynchronized task stream
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
ACL_FUNC_VISIBILITY aclError aclrtMemPoolFreeAsync(void *ptr, aclrtStream stream);

/**
 * @ingroup AscendCL
 * @brief Trim the specified memory pool to retain the specified minimum free memory
 *
 * @param memPool [IN] virtual mem pool handle
 * @param minBytesToKeep [IN] The minimum number of bytes to keep in the memory pool
 *
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
ACL_FUNC_VISIBILITY aclError aclrtMemPoolTrimTo(aclrtMemPool memPool, size_t minBytesToKeep);

#ifdef __cplusplus
}
#endif

#endif // INC_EXTERNAL_ACL_RT_MEMORY_H_