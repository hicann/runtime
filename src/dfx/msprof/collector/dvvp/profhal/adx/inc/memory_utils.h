/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_COMMON_MEMORY_UTILS_H
#define ADX_COMMON_MEMORY_UTILS_H
#include <cstddef>
#include "extra_config.h"
#define IDE_XFREE_AND_SET_NULL(ptr) do {                    \
    IdeXfree(ptr);                                          \
    ptr = nullptr;                                          \
} while (0)

namespace Analysis {
namespace Dvvp {
namespace Adx {
IdeMemHandle IdeXmalloc(size_t size);
IdeMemHandle IdeXrmalloc(const IdeMemHandle ptr, size_t ptrsize, size_t size);
void IdeXfree(IdeMemHandle ptr);
}   // namespace Adx
}   // namespace Dvvp
}   // namespace Analysis

#endif // ADX_COMMON_MEMORY_UTILS_H