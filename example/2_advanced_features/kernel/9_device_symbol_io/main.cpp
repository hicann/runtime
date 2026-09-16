/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "acl/acl_rt_api.h"
#include "kernel_operator.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kValueCount = 8U;
constexpr int32_t kInitialStep = 10;
constexpr int32_t kIncrement = 7;
constexpr size_t kDataSize = kValueCount * sizeof(int32_t);
} // namespace

__gm__ int32_t g_deviceValues[kValueCount];

extern "C" __global__ __vector__ void UpdateDeviceValuesKernel(int32_t increment)
{
    for (uint32_t index = 0; index < kValueCount; ++index) {
        g_deviceValues[index] += increment;
    }
#if __NPU_ARCH__ == 3510
    dcci(reinterpret_cast<__gm__ int64_t*>(g_deviceValues), cache_line_t::ENTIRE_DATA_CACHE, dcci_dst_t::CACHELINE_OUT);
#endif
}

namespace {
struct RuntimeResources {
    aclrtStream stream = nullptr;
    int32_t* initialValues = nullptr;
    int32_t* asyncValues = nullptr;
    bool initialized = false;
    bool deviceSet = false;
    bool streamCreated = false;
};

void RecordCleanupError(const char* operation, aclError ret, int32_t& result)
{
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("%s failed, error code %d.", operation, static_cast<int32_t>(ret));
        result = -1;
    }
}

int32_t InitializeRuntime(RuntimeResources& resources)
{
    CHECK_ERROR(aclInit(nullptr));
    resources.initialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources.initialValues), kDataSize));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources.asyncValues), kDataSize));
    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    resources.streamCreated = true;
    return 0;
}

int32_t InspectDeviceSymbol()
{
    void* deviceAddress = nullptr;
    size_t symbolSize = 0U;
    CHECK_ERROR(aclrtGetSymbolAddress(g_deviceValues, &deviceAddress));
    CHECK_ERROR(aclrtGetSymbolSize(g_deviceValues, &symbolSize));
    if (deviceAddress == nullptr || reinterpret_cast<uintptr_t>(deviceAddress) % alignof(int32_t) != 0U) {
        ERROR_LOG("Device variable address is null or not aligned for int32_t.");
        return -1;
    }
    if (symbolSize != kDataSize) {
        ERROR_LOG("Device variable size is %zu bytes, expected %zu bytes.", symbolSize, kDataSize);
        return -1;
    }
    INFO_LOG("Resolved Device variable at %p with %zu bytes.", deviceAddress, symbolSize);
    return 0;
}

int32_t InitializeAndUpdateSymbol(RuntimeResources& resources)
{
    for (uint32_t index = 0; index < kValueCount; ++index) {
        resources.initialValues[index] = static_cast<int32_t>(index + 1U) * kInitialStep;
    }

    // Queue initialization and the dependent Kernel in the same Stream.
    CHECK_ERROR(aclrtMemcpyToSymbolAsync(
        g_deviceValues, resources.initialValues, kDataSize, 0U, ACL_MEMCPY_HOST_TO_DEVICE, resources.stream));
    aclrtFuncHandle function = nullptr;
    CHECK_ERROR(aclrtGetFuncBySymbol(reinterpret_cast<const void*>(&UpdateDeviceValuesKernel), &function));
    int32_t increment = kIncrement;
    void* arguments[] = {&increment};
    CHECK_ERROR(aclrtLaunchKernelWithArgsArray(function, 1U, resources.stream, nullptr, arguments));
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
    INFO_LOG("Initialized %u values asynchronously and added %d in the Kernel.", kValueCount, kIncrement);
    return 0;
}

int32_t VerifyValues(const int32_t* values, const char* readMode)
{
    for (uint32_t index = 0; index < kValueCount; ++index) {
        const int32_t expected = static_cast<int32_t>(index + 1U) * kInitialStep + kIncrement;
        if (values[index] != expected) {
            ERROR_LOG("%s read mismatch at index %u: got %d, expected %d.", readMode, index, values[index], expected);
            return -1;
        }
    }
    INFO_LOG("Verified %u values through the %s read path.", kValueCount, readMode);
    return 0;
}

int32_t ReadAndVerifySymbol(RuntimeResources& resources)
{
    int32_t syncValues[kValueCount] = {};
    CHECK_ERROR(aclrtMemcpyFromSymbol(
        syncValues, sizeof(syncValues), g_deviceValues, kDataSize, 0U, ACL_MEMCPY_DEVICE_TO_HOST));
    if (VerifyValues(syncValues, "synchronous") != 0) {
        return -1;
    }

    for (uint32_t index = 0; index < kValueCount; ++index) {
        resources.asyncValues[index] = 0;
    }
    CHECK_ERROR(aclrtMemcpyFromSymbolAsync(
        resources.asyncValues, kDataSize, g_deviceValues, kDataSize, 0U, ACL_MEMCPY_DEVICE_TO_HOST, resources.stream));
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
    if (VerifyValues(resources.asyncValues, "asynchronous") != 0) {
        return -1;
    }

    for (uint32_t index = 0; index < kValueCount; ++index) {
        if (syncValues[index] != resources.asyncValues[index]) {
            ERROR_LOG("Read paths differ at index %u.", index);
            return -1;
        }
    }
    INFO_LOG("Both read paths returned [%d, ..., %d].", syncValues[0], syncValues[kValueCount - 1U]);
    return 0;
}

int32_t ReleaseResources(RuntimeResources& resources, int32_t result)
{
    // Synchronize outstanding work before releasing Stream-owned Host buffers.
    if (resources.streamCreated) {
        RecordCleanupError("aclrtSynchronizeStream", aclrtSynchronizeStream(resources.stream), result);
        RecordCleanupError("aclrtDestroyStreamForce", aclrtDestroyStreamForce(resources.stream), result);
    }
    if (resources.asyncValues != nullptr) {
        RecordCleanupError("aclrtFreeHost(asyncValues)", aclrtFreeHost(resources.asyncValues), result);
    }
    if (resources.initialValues != nullptr) {
        RecordCleanupError("aclrtFreeHost(initialValues)", aclrtFreeHost(resources.initialValues), result);
    }
    if (resources.deviceSet) {
        RecordCleanupError("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
    }
    if (resources.initialized) {
        RecordCleanupError("aclFinalize", aclFinalize(), result);
    }
    return result;
}

int32_t RunDeviceSymbolIo()
{
    RuntimeResources resources;
    int32_t result = InitializeRuntime(resources);
    if (result == 0) {
        result = InspectDeviceSymbol();
    }
    if (result == 0) {
        result = InitializeAndUpdateSymbol(resources);
    }
    if (result == 0) {
        result = ReadAndVerifySymbol(resources);
    }
    return ReleaseResources(resources, result);
}
} // namespace

int32_t main()
{
    INFO_LOG("Start to run the 9_device_symbol_io sample.");
    if (RunDeviceSymbolIo() != 0) {
        ERROR_LOG("Run the 9_device_symbol_io sample failed.");
        return -1;
    }
    INFO_LOG("Run the 9_device_symbol_io sample successfully.");
    return 0;
}
