/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_UT_MEMORY_TRANSFER_DRIVER_HPP
#define RUNTIME_UT_MEMORY_TRANSFER_DRIVER_HPP

#include "npu_driver.hpp"
#include "securec.h"

namespace cce {
namespace runtime {
namespace ut {

// A concrete virtual override preserves the complete allocation signature, including allocation config flags.
class MemoryTransferTestDriver final : public NpuDriver {
public:
    rtError_t DevMemAlloc(
        void** const dptr, const uint64_t size, const rtMemType_t type, const uint32_t deviceId,
        const uint16_t moduleId, const bool isLogError, const DevMemAllocConfig config, const bool isNewApi) override
    {
        UNUSED(type);
        UNUSED(moduleId);
        UNUSED(isLogError);
        UNUSED(isNewApi);
        ++allocationCalls;
        allocationSize = size;
        allocationDeviceId = deviceId;
        phyContinuous = config.starsTillingFlag;
        *dptr = (allocationResult == RT_ERROR_NONE || allocateOnFailure) ? storage : nullptr;
        return allocationResult;
    }

    rtError_t MemCopySync(
        void* dst, uint64_t destMax, const void* src, uint64_t size, rtMemcpyKind_t kind, bool errShow,
        uint32_t devId) override
    {
        UNUSED(errShow);
        UNUSED(devId);
        ++copyCalls;
        copySize = size;
        copyDestMax = destMax;
        copyKind = kind;
        if (copyResult != RT_ERROR_NONE) {
            return copyResult;
        }
        return memcpy_s(dst, destMax, src, size) == EOK ? RT_ERROR_NONE : RT_ERROR_INVALID_VALUE;
    }

    rtError_t DevMemFree(void* const ptr, const uint32_t deviceId) override
    {
        ++freeCalls;
        freedPointer = ptr;
        freeDeviceId = deviceId;
        return RT_ERROR_NONE;
    }

    uint32_t GetRunMode() override { return runMode; }

    rtError_t DevMemFlushCache(const uint64_t base, const size_t len) override
    {
        UNUSED(base);
        UNUSED(len);
        ++flushCalls;
        return flushResult;
    }

    uint8_t storage[128] = {};
    rtError_t allocationResult = RT_ERROR_NONE;
    rtError_t copyResult = RT_ERROR_NONE;
    rtError_t flushResult = RT_ERROR_NONE;
    bool allocateOnFailure = false;
    bool phyContinuous = false;
    uint32_t allocationCalls = 0U;
    uint32_t copyCalls = 0U;
    uint32_t freeCalls = 0U;
    uint32_t flushCalls = 0U;
    uint32_t allocationDeviceId = 0U;
    uint32_t freeDeviceId = 0U;
    uint32_t runMode = RT_RUN_MODE_OFFLINE;
    uint64_t allocationSize = 0U;
    uint64_t copySize = 0U;
    uint64_t copyDestMax = 0U;
    rtMemcpyKind_t copyKind = RT_MEMCPY_HOST_TO_DEVICE;
    void* freedPointer = nullptr;
};

} // namespace ut
} // namespace runtime
} // namespace cce

#endif // RUNTIME_UT_MEMORY_TRANSFER_DRIVER_HPP
