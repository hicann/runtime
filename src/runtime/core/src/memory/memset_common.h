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
// Perform 32-bit fill on Device memory: unified entry, dispatches by sync/async and data size
rtError_t MemsetD32OnDevice(
    void* dst, uint64_t destMax, uint32_t value, uint64_t count, Stream* stm, bool isAsync, uint32_t memDevId = 0U);
// Perform 32-bit fill on Device memory via block-by-block Host→Device DMA copy
rtError_t MemsetD32OnDeviceByMemcpy(
    void* dst, uint64_t destMax, uint32_t value, uint64_t count, Stream* stm, bool isAsync);
rtError_t DevMemSetAsyncByMemcpy(Stream* stm, void* ptr, uint64_t destMax, uint32_t fillVal, uint64_t fillCount);
rtError_t DevMemSetAsyncByMemset(Stream* stm, void* ptr, uint64_t destMax, uint32_t fillVal, uint64_t fillCount);

// Host fill template size for batch memset, empirically 2MB is the performance crossover point:
// below 2MB the fixed overhead of host alloc/free + SIMD fill exceeds batch benefit
constexpr uint64_t MEMSET_BATCH_BUF_SIZE = 2ULL * 1024ULL * 1024ULL;
// Max descriptor count per MemcpyBatch call, limited by hal layer
constexpr uint64_t MEMSET_BATCH_MAX_COUNT = 4096ULL;
// Batch dispatch threshold for D32 memset sync path
constexpr uint32_t MEMSET_D32_THRESHOLD = 2U * 1024U * 1024U;

// D32 memset sync batch path: allocate 2MB template + SIMD fill + MemcpyBatch batch DMA copy
rtError_t MemsetD32OnDeviceByBatch(void* dst, uint64_t destMax, uint32_t value, uint64_t count, uint32_t memDevId);

// Expand the lowest byte of a 32-bit value to 4 identical bytes.
// e.g. 0x000000A5 -> 0xA5A5A5A5. Used by DevMemSetAsyncByMemcpy for D8 fallback fill value.
inline uint32_t ExpandByteToU32(uint32_t fillVal)
{
    const uint8_t byteValue = static_cast<uint8_t>(fillVal);
    uint32_t value = byteValue;
    return (value << 24) | (value << 16) | (value << 8) | value;
}

// Check if chip supports memset task
inline bool IsSupportMemsetTask(const uint32_t memDevId, const uint32_t curDevId, const DevProperties& props)
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
