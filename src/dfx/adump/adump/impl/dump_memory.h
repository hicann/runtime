/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_MEMORY_H
#define DUMP_MEMORY_H

#include <cstdint>
#include "context_guard.h"

namespace Adx {
class DumpMemory {
public:
    static int32_t CheckDeviceMemory(int32_t deviceId, const void *addr);
    static void *CopyHostToHost(const void *hostMem, uint64_t memSize);
    static void *CopyHostToDevice(const void *hostMem, uint64_t memSize);
    static void *CopyDeviceToHost(const void *devMem, uint64_t memSize);
    static void *CopyDeviceToHostEx(const void *devMem, uint64_t memSize);
    static void FreeHost(void *&hostMem);
    static void FreeDevice(void *&devMem);
};

#define HOST_RT_MEMORY_GUARD(var)        \
    MAKE_CONTEXT_GUARD(var, [&var]() {      \
        if ((var) != nullptr) {          \
            DumpMemory::FreeHost((var)); \
        }                                \
    })

#define DEVICE_RT_MEMORY_GUARD(var)        \
    MAKE_CONTEXT_GUARD(var, [&var]() {        \
        if ((var) != nullptr) {            \
            DumpMemory::FreeDevice((var)); \
        }                                  \
    })
} // namespace Adx
#endif // DUMP_MEMORY_H