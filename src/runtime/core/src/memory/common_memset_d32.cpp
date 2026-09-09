/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memset_common.h"
#include "api_impl_david.hpp"
#include "api_impl.hpp"
#include "memcpy_c.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "npu_driver.hpp"
#include <algorithm>
#include <cstring>
#include <memory>
#include <vector>

namespace cce {
namespace runtime {

// Perform 32-bit fill on Host memory (using SIMD acceleration).
// Boundary check is done by caller, destMax is for interface compatibility only.
rtError_t MemsetD32OnHost(void* dst, uint64_t destMax, uint32_t value, uint64_t count)
{
    (void)destMax; // Boundary check already done by caller
    uint32_t* dstPtr = static_cast<uint32_t*>(dst);
    RT_LOG(RT_LOG_DEBUG, "MemsetD32OnHost: dst=%p, count=%zu, value=0x%x", dst, count, value);
    MemsetD32Optimized(dstPtr, value, count);
    return RT_ERROR_NONE;
}

// Single block: HostMemAlloc -> SIMD fill -> DMA copy -> HostMemFree.
// sync uses MemCopySync, async uses MemcopyAsync with shared_ptr deferred release.
static rtError_t MemsetD32OnDeviceSingleBlock(
    void* curDst, uint64_t remainingMax, uint32_t value, uint64_t curCount, Stream* stm, bool isAsync, Device* device)
{
    const uint64_t curBytes = curCount * sizeof(uint32_t);

    void* tempHostBuf = nullptr;
    const rtError_t allocError = device->Driver_()->HostMemAlloc(&tempHostBuf, curBytes, device->Id_(), 0, 0);
    if (allocError != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Failed to allocate temp host memory for block, size=%" PRIu64 "(bytes), retCode=%#x.",
            curBytes, static_cast<uint32_t>(allocError));
        return allocError;
    }

    uint32_t* tempPtr = static_cast<uint32_t*>(tempHostBuf);
    MemsetD32Optimized(tempPtr, value, curCount);

    rtError_t copyError = RT_ERROR_NONE;
    if (isAsync) {
        uint64_t realSize = 0;
        std::shared_ptr<void> tempHostBufGuard(
            tempHostBuf, [device](void* ptr) { (void)device->Driver_()->HostMemFree(ptr); });
        copyError = MemcopyAsync(
            curDst, remainingMax, tempHostBuf, curBytes, RT_MEMCPY_HOST_TO_DEVICE, stm, &realSize, tempHostBufGuard);
    } else {
        copyError =
            device->Driver_()->MemCopySync(curDst, remainingMax, tempHostBuf, curBytes, RT_MEMCPY_HOST_TO_DEVICE);
        (void)device->Driver_()->HostMemFree(tempHostBuf);
    }

    if (copyError != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to copy memory for block, retCode=%#x.", static_cast<uint32_t>(copyError));
        return copyError;
    }
    return RT_ERROR_NONE;
}

// D32 memset block-by-block ByMemcpy path: split by hardware single DMA limit,
// each block is SIMD-filled on host side then DMA-copied to device.
// Block size is from MemcpyAsync single max copy size.
rtError_t MemsetD32OnDeviceByMemcpy(
    void* dst, uint64_t destMax, uint32_t value, uint64_t count, Stream* stm, bool isAsync)
{
    // Dynamically get block size (consistent with MemcpyAsync)
    const uint64_t blockBytes = CalculateMemcpyAsyncSingleMaxSize(RT_MEMCPY_HOST_TO_DEVICE);
    const uint64_t blockCount = blockBytes / sizeof(uint32_t);

    Context* curCtx = Runtime::Instance()->CurrentContext();
    Device* device = curCtx->Device_();

    RT_LOG(
        RT_LOG_DEBUG,
        "MemsetD32OnDevice: using block size=%" PRIu64 " bytes (%" PRIu64 " elements), total count=%" PRIu64,
        blockBytes, blockCount, count);

    uint64_t remainingCount = count;
    uint64_t doneBytes = 0;
    const uint64_t totalBytes = count * sizeof(uint32_t);

    while (remainingCount > 0) {
        const uint64_t curCount = (remainingCount >= blockCount) ? blockCount : remainingCount;
        const uint64_t curBytes = curCount * sizeof(uint32_t);

        void* curDst = static_cast<char*>(dst) + doneBytes;
        uint64_t remainingMax = destMax - doneBytes;

        const rtError_t err = MemsetD32OnDeviceSingleBlock(curDst, remainingMax, value, curCount, stm, isAsync, device);
        if (err != RT_ERROR_NONE) {
            return err;
        }
        remainingCount -= curCount;
        doneBytes += curBytes;
    }

    RT_LOG(RT_LOG_DEBUG, "MemsetD32OnDevice completed: total bytes=%" PRIu64, totalBytes);
    return RT_ERROR_NONE;
}

rtError_t MemsetD32OnDeviceByBatch(void* dst, uint64_t destMax, uint32_t value, uint64_t count, uint32_t memDevId)
{
    (void)memDevId;
    (void)destMax;
    const uint64_t totalBytes = count * sizeof(uint32_t);

    Context* curCtx = Runtime::Instance()->CurrentContext();
    Device* device = curCtx->Device_();

    void* fillBuf = nullptr;
    const rtError_t allocError = device->Driver_()->HostMemAlloc(&fillBuf, MEMSET_BATCH_BUF_SIZE, device->Id_(), 0, 0);
    if (allocError != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Failed to allocate host buffer for batch memset, size=%" PRIu64 "(bytes), retCode=%#x.",
            MEMSET_BATCH_BUF_SIZE, static_cast<uint32_t>(allocError));
        return allocError;
    }
    const ScopeGuard freeGuard([&device, &fillBuf]() { (void)device->Driver_()->HostMemFree(fillBuf); });

    const uint64_t fillCount = MEMSET_BATCH_BUF_SIZE / sizeof(uint32_t);
    MemsetD32Optimized(static_cast<uint32_t*>(fillBuf), value, fillCount);

    const uint64_t fillBufAddr = reinterpret_cast<uint64_t>(fillBuf);

    // Dispatch MemcpyBatch in 2MB chunks, each batch up to hal max descriptor count (4096).
    // Single batch covers up to 2MB x 4096 = 8GB, larger sizes split into multiple rounds.
    uint64_t done = 0U;
    while (done < totalBytes) {
        const uint64_t remain = totalBytes - done;
        // Ceiling division without overflow: use quotient + remainder instead of (remain + size - 1) / size
        const uint64_t batchCnt = remain / MEMSET_BATCH_BUF_SIZE + ((remain % MEMSET_BATCH_BUF_SIZE != 0U) ? 1U : 0U);
        const uint64_t realBatch = std::min(batchCnt, MEMSET_BATCH_MAX_COUNT);
        if (realBatch == 0U) {
            RT_LOG(
                RT_LOG_ERROR, "Invalid batch count, remain=%" PRIu64 ", fillBytes=%" PRIu64 ".", remain,
                MEMSET_BATCH_BUF_SIZE);
            return RT_ERROR_INVALID_VALUE;
        }

        // Build batch DMA descriptor table: src addresses point to the same template, dst addresses advance by offset
        std::vector<uint64_t> dsts(realBatch);
        std::vector<uint64_t> srcs(realBatch, fillBufAddr);
        std::vector<size_t> sizes(realBatch);

        for (uint64_t i = 0U; i < realBatch; ++i) {
            const uint64_t cur = std::min(MEMSET_BATCH_BUF_SIZE, totalBytes - done);
            dsts[i] = reinterpret_cast<uint64_t>(static_cast<char*>(dst) + done);
            sizes[i] = cur;
            done += cur;
        }

        RT_LOG(
            RT_LOG_DEBUG, "MemsetD32OnDeviceByBatch: batch=%" PRIu64 ", done=%" PRIu64 ", total=%" PRIu64 ".",
            realBatch, done, totalBytes);

        const rtError_t ret = NpuDriver::MemcpyBatch(dsts.data(), srcs.data(), sizes.data(), realBatch);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "MemcpyBatch failed, retCode=%#x.", static_cast<uint32_t>(ret));
            return ret;
        }
    }
    return RT_ERROR_NONE;
}

// D32 memset Device unified entry, dispatches by sync/async and data size:
// - Async: try hardware SDMA Memset task first, fallback to ByMemcpy if not supported
// - Sync: >= 2MB goes ByBatch, < 2MB goes ByMemcpy
rtError_t MemsetD32OnDevice(
    void* dst, uint64_t destMax, uint32_t value, uint64_t count, Stream* stm, bool isAsync, uint32_t memDevId)
{
    const uint64_t totalBytes = count * sizeof(uint32_t);
    if (totalBytes > destMax) {
        RT_LOG(
            RT_LOG_ERROR, "Total size exceeds destMax, totalBytes=%" PRIu64 ", destMax=%" PRIu64 ".", totalBytes,
            destMax);
        return RT_ERROR_INVALID_VALUE;
    }

    // Only async path tries SDMA Memset
    if (isAsync) {
        NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
        Device* device = stm->Device_();
        const DevProperties& props = device->GetDevProperties();
        if (IsSupportMemsetTask(memDevId, device->Id_(), props)) {
            return DevMemSetAsyncByMemset(stm, dst, destMax, value, totalBytes);
        }
    }

    // Sync path: >= 2MB goes ByBatch, < 2MB goes ByMemcpy
    if (!isAsync && (totalBytes >= MEMSET_D32_THRESHOLD)) {
        return MemsetD32OnDeviceByBatch(dst, destMax, value, count, memDevId);
    }

    // Fallback path (sync or async without memset task support)
    return MemsetD32OnDeviceByMemcpy(dst, destMax, value, count, stm, isAsync);
}
} // namespace runtime
} // namespace cce
