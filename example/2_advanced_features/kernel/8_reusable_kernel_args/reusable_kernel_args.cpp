/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "reusable_kernel_args.h"

#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "kernel_operator.h"
#include "utils.h"

extern "C" __global__ __vector__ void ReusableKernelArgsKernel(__gm__ int32_t* output, int32_t value)
{
    output[0] = value;
#if __NPU_ARCH__ == 3510
    dcci(reinterpret_cast<__gm__ int64_t*>(output), cache_line_t::ENTIRE_DATA_CACHE, dcci_dst_t::CACHELINE_OUT);
#endif
}

namespace {
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kBlockDim = 1U;
constexpr int32_t kInitialValue = 7;
constexpr int32_t kUpdatedValue = 23;

constexpr size_t AlignToEight(size_t size) { return (size + 7U) & ~static_cast<size_t>(7U); }

struct Resources {
    aclrtStream stream = nullptr;
    void* outputDevice = nullptr;
    void* argsHandleMemory = nullptr;
    void* argsDataMemory = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
};

void RecordCleanup(const char* operation, aclError error, int& result)
{
    if (error != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d", operation, static_cast<int32_t>(error));
        result = -1;
    }
}

int Initialize(Resources& resources)
{
    CHECK_ERROR(aclInit(nullptr));
    resources.aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    CHECK_ERROR(aclrtMalloc(&resources.outputDevice, sizeof(int32_t), ACL_MEM_MALLOC_HUGE_FIRST));
    return 0;
}

int PrepareArgs(
    Resources& resources, aclrtFuncHandle& function, aclrtArgsHandle& argsHandle, aclrtParamHandle& valueParam)
{
    CHECK_ERROR(aclrtGetFuncBySymbol(reinterpret_cast<const void*>(&ReusableKernelArgsKernel), &function));

    size_t handleSize = 0U;
    size_t argsDataSize = 0U;
    constexpr size_t userArgsSize = AlignToEight(sizeof(uintptr_t)) + AlignToEight(sizeof(int32_t));
    CHECK_ERROR(aclrtKernelArgsGetHandleMemSize(function, &handleSize));
    CHECK_ERROR(aclrtKernelArgsGetMemSize(function, userArgsSize, &argsDataSize));
    if ((handleSize == 0U) || (argsDataSize < userArgsSize)) {
        ERROR_LOG("Invalid queried memory sizes: handle=%zu, arguments=%zu.", handleSize, argsDataSize);
        return -1;
    }

    CHECK_ERROR(aclrtMallocHost(&resources.argsHandleMemory, handleSize));
    CHECK_ERROR(aclrtMallocHost(&resources.argsDataMemory, argsDataSize));
    argsHandle = resources.argsHandleMemory;
    CHECK_ERROR(aclrtKernelArgsInitByUserMem(function, argsHandle, resources.argsDataMemory, argsDataSize));

    aclrtParamHandle outputParam = nullptr;
    CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, &resources.outputDevice, sizeof(uintptr_t), &outputParam));
    int32_t initialValue = kInitialValue;
    CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, &initialValue, sizeof(initialValue), &valueParam));
    if ((outputParam == nullptr) || (valueParam == nullptr)) {
        ERROR_LOG("Kernel parameter handles must not be null.");
        return -1;
    }
    CHECK_ERROR(aclrtKernelArgsFinalize(argsHandle));
    INFO_LOG("Allocated user memory: handle=%zu bytes, argument buffer=%zu bytes.", handleSize, argsDataSize);
    return 0;
}

int LaunchAndVerify(
    aclrtFuncHandle function, aclrtArgsHandle argsHandle, Resources& resources, int32_t expected, uint32_t launchIndex)
{
    CHECK_ERROR(aclrtLaunchKernelWithConfig(function, kBlockDim, resources.stream, nullptr, argsHandle, nullptr));
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
    int32_t actual = 0;
    CHECK_ERROR(
        aclrtMemcpy(&actual, sizeof(actual), resources.outputDevice, sizeof(actual), ACL_MEMCPY_DEVICE_TO_HOST));
    if (actual != expected) {
        ERROR_LOG("Launch %u produced %d, expected %d.", launchIndex, actual, expected);
        return -1;
    }
    INFO_LOG("Verified launch %u: scalar=%d, output=%d.", launchIndex, expected, actual);
    return 0;
}

int UpdateArgs(aclrtArgsHandle argsHandle, aclrtParamHandle valueParam)
{
    int32_t updatedValue = kUpdatedValue;
    CHECK_ERROR(aclrtKernelArgsParaUpdate(argsHandle, valueParam, &updatedValue, sizeof(updatedValue)));
    CHECK_ERROR(aclrtKernelArgsFinalize(argsHandle));
    INFO_LOG("Updated the reusable scalar parameter from %d to %d.", kInitialValue, kUpdatedValue);
    return 0;
}

int Release(Resources& resources, int result)
{
    if (resources.stream != nullptr) {
        RecordCleanup("aclrtDestroyStreamForce", aclrtDestroyStreamForce(resources.stream), result);
    }
    if (resources.outputDevice != nullptr) {
        RecordCleanup("aclrtFree", aclrtFree(resources.outputDevice), result);
    }
    if (resources.argsDataMemory != nullptr) {
        RecordCleanup("aclrtFreeHost(argsDataMemory)", aclrtFreeHost(resources.argsDataMemory), result);
    }
    if (resources.argsHandleMemory != nullptr) {
        RecordCleanup("aclrtFreeHost(argsHandleMemory)", aclrtFreeHost(resources.argsHandleMemory), result);
    }
    if (resources.deviceSet) {
        RecordCleanup("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
    }
    if (resources.aclInitialized) {
        RecordCleanup("aclFinalize", aclFinalize(), result);
    }
    return result;
}
} // namespace

int RunReusableKernelArgsSample()
{
    Resources resources;
    aclrtFuncHandle function = nullptr;
    aclrtArgsHandle argsHandle = nullptr;
    aclrtParamHandle valueParam = nullptr;

    int result = Initialize(resources);
    if (result == 0) {
        result = PrepareArgs(resources, function, argsHandle, valueParam);
    }
    if (result == 0) {
        result = LaunchAndVerify(function, argsHandle, resources, kInitialValue, 1U);
    }
    if (result == 0) {
        result = UpdateArgs(argsHandle, valueParam);
    }
    if (result == 0) {
        result = LaunchAndVerify(function, argsHandle, resources, kUpdatedValue, 2U);
    }
    return Release(resources, result);
}
