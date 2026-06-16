/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_jetty_context.h"
#include "drv/driver.hpp"
#include "error_code.h"
#include "securec.h"
#include "runtime.hpp"

namespace cce {
namespace runtime {
uint8_t *StreamJettyContext::GetNextWqeBuffer() const
{
    if (filledWqeCount >= capacity) {
        return nullptr;
    }

    uint32_t idx = filledWqeCount / WQE_BUFFER_DEPTH;
    uint32_t off = (filledWqeCount % WQE_BUFFER_DEPTH) * WQE_SIZE;

    if (idx >= wqeBuffers.size() || wqeBuffers[idx] == nullptr) {
        return nullptr;
    }

    return wqeBuffers[idx].get() + off;
}

rtError_t StreamJettyContext::AllocWqeBuffer(Driver *driver)
{
    const uint64_t allocSize = static_cast<uint64_t>(WQE_BUFFER_DEPTH) * WQE_SIZE;
    void *hostPtr = nullptr;
    rtError_t error = driver->HostMemAlloc(&hostPtr, allocSize, 0);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    if (hostPtr == nullptr) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    auto buffer = std::unique_ptr<uint8_t[]>(RtPtrToPtr<uint8_t *>(hostPtr));
    errno_t rc = memset_s(buffer.get(), allocSize, 0, allocSize);
    if (rc != EOK) {
        (void)driver->HostMemFree(buffer.release());
        return RT_ERROR_SEC_HANDLE;
    }

    wqeBuffers.push_back(std::move(buffer));
    return RT_ERROR_NONE;
}

rtError_t StreamJettyContext::GrowBuffer(Driver *driver)
{
    if (driver == nullptr) {
        return RT_ERROR_DRV_NULL;
    }

    rtError_t error = AllocWqeBuffer(driver);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    capacity += WQE_BUFFER_DEPTH;
    return RT_ERROR_NONE;
}

rtError_t StreamJettyContext::RoundUpCapacity(Driver *driver, uint32_t deviceId)
{
    if (filledWqeCount == 0 || capacity <= WQE_BUFFER_DEPTH) {
        return RT_ERROR_NONE;
    }

    uint32_t validDepth = WQE_BUFFER_DEPTH;
    while (validDepth < capacity) {
        validDepth *= 2U; // 2 jetty深度限制
        if (validDepth > JETTY_DEPTH_MAX) {
            RT_LOG(RT_LOG_ERROR, "capacity %u exceeds max jetty depth %u.",
                capacity, JETTY_DEPTH_MAX);
            return RT_ERROR_INVALID_VALUE;
        }
    }

    if (validDepth == capacity) {
        return RT_ERROR_NONE;
    }

    uint32_t old = static_cast<uint32_t>(wqeBuffers.size());
    uint32_t need = validDepth / WQE_BUFFER_DEPTH;

    while (wqeBuffers.size() < need) {
        rtError_t error = AllocWqeBuffer(driver);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    const uint64_t allocSize = static_cast<uint64_t>(WQE_BUFFER_DEPTH) * WQE_SIZE;
    for (uint32_t i = old; i < need; ++i) {
        AsyncWqeInputPara input = {};
        input.wqeBuffer = wqeBuffers[i].get();
        input.wqeType = static_cast<uint32_t>(DRV_ASYNC_DMA_TYPE_NOP);
        input.size = static_cast<uint32_t>(allocSize);
        input.nop.nopCnt = WQE_BUFFER_DEPTH;

        AsyncWqeOutputPara output = {};
        rtError_t error = driver->AsyncDmaWqeConvert(deviceId, &input, &output);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "NOP WQE fill failed for buffer %u, ret=%d.", i, error);
            return error;
        }
    }

    capacity = validDepth;
    isLargeDepth = true;
    return RT_ERROR_NONE;
}

void StreamJettyContext::ReleaseBuffers(Driver *driver)
{
    if (driver == nullptr) {
        return;
    }

    for (size_t i = 0; i < wqeBuffers.size(); ++i) {
        if (wqeBuffers[i] != nullptr) {
            rtError_t ret = driver->HostMemFree(wqeBuffers[i].release());
            if (ret != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "HostMemFree failed, buf_idx=%zu, ret=%d.", i, static_cast<int32_t>(ret));
            }
        }
    }
    wqeBuffers.clear();
    filledWqeCount = 0;
    capacity = 0;
}

} // namespace runtime
} // namespace cce
