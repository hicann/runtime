/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "memory_utils.h"
#include "securec.h"
#include "msprof_dlog.h"

namespace Analysis {
namespace Dvvp {
namespace Adx {
IdeMemHandle IdeXmalloc(size_t size)
{
    errno_t err;

    if (size == 0) {
        return nullptr;
    }

    IdeMemHandle val = malloc(size);
    if (val == nullptr) {
        MSPROF_LOGE("ran out of memory while trying to allocate %lu bytes", size);
        return nullptr;
    }

    err = memset_s(val, size, 0, size);
    if (err != EOK) {
        MSPROF_LOGE("[IdeXmalloc]memory clear failed, err: %d", err);
        free(val);
        val = nullptr;
        return nullptr;
    }
    return val;
}

IdeMemHandle IdeXrmalloc(const IdeMemHandle ptr, size_t ptrsize, size_t size)
{
    if (size == 0) {
        return nullptr;
    }

    if (ptr == nullptr) {
        return IdeXmalloc(size);
    }
    size_t cpLen = (ptrsize > size) ? size : ptrsize;
    IdeMemHandle val = IdeXmalloc(size);
    if (val != nullptr) {
        errno_t err = memcpy_s(val, size, ptr, cpLen);
        if (err != EOK) {
            IDE_XFREE_AND_SET_NULL(val);
            return nullptr;
        }
    }
    return val;
}

void IdeXfree(IdeMemHandle ptr)
{
    if (ptr != nullptr) {
        free(ptr);
        ptr = nullptr;
    }
}
}   // namespace Adx
}   // namespace Dvvp
}   // namespace Analysis