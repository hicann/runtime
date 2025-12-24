/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cerrno>
#include "securec.h"
#include "log/adx_log.h"
#include "memory_utils.h"
namespace Adx {
/**
 * @brief malloc memory and memset memory
 * @param size: the size of memory to malloc
 *
 * @return
 *        NULL: malloc memory failed
 *        not NULL: malloc memory succ
 */
IdeMemHandle IdeXmalloc(size_t size)
{
    errno_t err;

    if (size == 0) {
        return nullptr;
    }

    IdeMemHandle val = malloc(size);
    if (val == nullptr) {
        IDE_LOGE("ran out of memory while trying to allocate %zu bytes", size);
        return nullptr;
    }

    err = memset_s(val, size, 0, size);
    if (err != EOK) {
        free(val);
        val = nullptr;
        IDE_LOGE("memory clear failed, err: %d", err);
        return nullptr;
    }

    return val;
}

/**
 * @brief realloc memory and copy ptr to new memory address
 * @param ptr: the pre memory
 * @param ptrsize: the pre memory size
 * @param size: the new memory size
 *
 * @return
 *        NULL: malloc memory failed
 *        not NULL: malloc memory succ
 */
IdeMemHandle IdeXrmalloc(const IdeMemHandle ptr, size_t ptrsize, size_t size)
{
    IdeMemHandle val = nullptr;
    if (size == 0) {
        return nullptr;
    }

    if (ptr != nullptr) {
        size_t cpLen = (ptrsize > size) ? size : ptrsize;
        val = IdeXmalloc(size);
        if (val != nullptr) {
            errno_t err = memcpy_s(val, size, ptr, cpLen);
            if (err != EOK) {
                IDE_XFREE_AND_SET_NULL(val);
                return nullptr;
            }
        }
    } else {
        val = IdeXmalloc(size);
    }

    return val;
}

/**
 * @brief free memory
 * @param ptr: the memory to free
 *
 * @return
 */
void IdeXfree(const IdeMemHandle ptr)
{
    if (ptr != nullptr) {
        free(ptr);
    }
}
}
