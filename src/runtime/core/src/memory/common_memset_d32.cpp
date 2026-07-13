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
#include "api.hpp"
#include "memcpy_c.hpp"

namespace cce {
namespace runtime {

rtError_t MemsetD32OnHost(void* dst, uint64_t destMax, uint32_t value, uint64_t count)\
{
    (void)destMax; // Boundary check already done by caller
    uint32_t* dstPtr = static_cast<uint32_t*>(dst);
    RT_LOG(RT_LOG_DEBUG, "MemsetD32OnHost: dst=%p, count=%zu, value=0x%x", dst, count, value);
    MemsetD32Optimized(dstPtr, value, count);
    return RT_ERROR_NONE;
}

static rtError_t MemsetD32OnDeviceSingleBlock(void* curDst, uint64_t remainingMax, uint32_t value, uint64_t curCount,
                                              Stream* stm, bool isAsync, Device* device)
{
    uint64_t curBytes = curCount * sizeof(uint32_t);
    
    // Allocate temporary memory
    void* tempHostBuf = nullptr;
    const rtError_t allocError = device->Driver_()->HostMemAlloc(
        &tempHostBuf, curBytes, device->Id_(), 0, 0);
    if (allocError != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Failed to allocate temp host memory for block, size=%" PRIu64 ", retCode=%#x.", curBytes,
            static_cast<uint32_t>(allocError));
        return allocError;
    }

    uint32_t* tempPtr = static_cast<uint32_t*>(tempHostBuf);
    MemsetD32Optimized(tempPtr, value, curCount);

    // Copy to target device
    rtError_t copyError = RT_ERROR_NONE;
    if (isAsync) {
        uint64_t realSize = 0;
        std::shared_ptr<void> tempHostBufGuard(tempHostBuf,
            [device](void* ptr) { device->Driver_()->HostMemFree(ptr); });
        copyError = MemcopyAsync(curDst, remainingMax, tempHostBuf,
            curBytes, RT_MEMCPY_HOST_TO_DEVICE, stm, &realSize, tempHostBufGuard);
    } else {
        copyError = device->Driver_()->MemCopySync(curDst, remainingMax,
            tempHostBuf, curBytes, RT_MEMCPY_HOST_TO_DEVICE);
        (void)device->Driver_()->HostMemFree(tempHostBuf);
    }
    
    if (copyError != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to copy memory for block, retCode=%#x.", static_cast<uint32_t>(copyError));
        return copyError;
    }
    return RT_ERROR_NONE;
}

rtError_t MemsetD32OnDeviceByMemcpy(void* dst, uint64_t destMax, uint32_t value,
                            uint64_t count, Stream* stm, bool isAsync)
{
    // Dynamically get block size (consistent with MemcpyAsync)
    const uint64_t blockBytes = CalculateMemcpyAsyncSingleMaxSize(RT_MEMCPY_HOST_TO_DEVICE);
    const uint64_t blockCount = blockBytes / sizeof(uint32_t);

    Context* curCtx = Runtime::Instance()->CurrentContext();
    Device* device = curCtx->Device_();

    RT_LOG(RT_LOG_DEBUG, "MemsetD32OnDevice: using block size=%" PRIu64 " bytes (%" PRIu64 " elements), total count=%" PRIu64,
           blockBytes, blockCount, count);

    uint64_t remainingCount = count;
    uint64_t doneBytes = 0;
    const uint64_t totalBytes = count * sizeof(uint32_t);

    while (remainingCount > 0) {
        const uint64_t curCount = (remainingCount >= blockCount) ? blockCount : remainingCount;
        const uint64_t curBytes = curCount * sizeof(uint32_t);
        
        // Calculate current block's target address and remaining size
        void* curDst = static_cast<char*>(dst) + doneBytes;
        uint64_t remainingMax = destMax - doneBytes;
        
        const rtError_t err = MemsetD32OnDeviceSingleBlock(curDst, remainingMax, value, curCount,
                                                     stm, isAsync, device);
        if (err != RT_ERROR_NONE) {
            return err;
        }
        remainingCount -= curCount;
        doneBytes += curBytes;
    }
    
    RT_LOG(RT_LOG_DEBUG, "MemsetD32OnDevice completed: total bytes=%" PRIu64, totalBytes);
    return RT_ERROR_NONE;
}

rtError_t MemsetD32OnDevice(void* dst, uint64_t destMax, uint32_t value,
                            uint64_t count, Stream* stm, bool isAsync, uint32_t memDevId)
{
    const uint64_t totalBytes = count * sizeof(uint32_t);
    if (totalBytes > destMax) {
        RT_LOG(RT_LOG_ERROR, "Total size exceeds destMax, totalBytes=%" PRIu64 ", destMax=%" PRIu64 ".",
            totalBytes, destMax);
        return RT_ERROR_INVALID_VALUE;
    }

    // Only async path tries SDMA Memset
    if (isAsync) {
        NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
        Device* device = stm->Device_();
        const DevProperties &props = device->GetDevProperties();
        if (IsSupportMemsetTask(memDevId, device->Id_(), props)) {
            return DevMemSetAsyncByMemset(stm, dst, destMax, value, totalBytes);
        }
    }

    // Fallback path (sync or async without memset task support)
    return MemsetD32OnDeviceByMemcpy(dst, destMax, value, count, stm, isAsync);
}
}  // namespace runtime
}  // namespace cce