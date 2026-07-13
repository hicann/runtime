/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MEMSET_COMMON_H
#define MEMSET_COMMON_H

#include <cstddef>
#include <cstdint>
#include "device_properties.h"

namespace cce {
namespace runtime {

class Stream;

void MemsetD32Optimized(uint32_t* dst, uint32_t value, size_t count);
// Perform 32-bit fill on Host memory (using SIMD acceleration)
rtError_t MemsetD32OnHost(void* dst, uint64_t destMax, uint32_t value, uint64_t count);
// Perform 32-bit fill on Device memory (temporary Host memory + asynchronous copy)
rtError_t MemsetD32OnDevice(void* dst, uint64_t destMax, uint32_t value, uint64_t count, Stream* stm, bool isAsync, uint32_t memDevId = 0U);
rtError_t MemsetD32OnDeviceByMemcpy(
    void* dst, uint64_t destMax, uint32_t value, uint64_t count, Stream* stm, bool isAsync);
rtError_t DevMemSetAsyncByMemcpy(Stream* stm, void* ptr, uint64_t destMax, uint32_t fillVal, uint64_t fillCount);
rtError_t DevMemSetAsyncByMemset(Stream* stm, void* ptr, uint64_t destMax, uint32_t fillVal, uint64_t fillCount);

inline uint32_t ExpandByteToU32(uint32_t fillVal)
{
    const uint8_t byteValue = static_cast<uint8_t>(fillVal);
    uint32_t value = byteValue;
    return (value << 24) | (value << 16) | (value << 8) | value;
}

// Check if chip supports memset task
inline bool IsSupportMemsetTask(const uint32_t memDevId, const uint32_t curDevId,
    const DevProperties& props)
{
    // 1. Memory must belong to current device
    // 2. Chip supports memset task
    if (memDevId != curDevId) {
        return false;
    }
    return props.memsetTaskSupport == MemsetTaskSupportType::MEMSET_TASK_SUPPORT;
}

} // namespace runtime
} // namespace cce

#endif // MEMSET_COMMON_H
