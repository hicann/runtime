/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/*
 * This sample uses a device-side descriptor to copy a data block asynchronously within one device.
 */

#include <cstddef>
#include <cstdint>
#include <vector>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kElementCount = 1024U;
constexpr aclrtMemcpyKind kMemcpyKind = ACL_MEMCPY_INNER_DEVICE_TO_DEVICE;

struct RuntimeResources {
    aclrtStream stream = nullptr;
    void* sourceDevice = nullptr;
    void* destinationDevice = nullptr;
    void* memcpyDesc = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool copySubmitted = false;
};

void UpdateFinalResultOnError(const char* apiName, aclError ret, int32_t& finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}

int32_t InitializeRuntime(RuntimeResources* resources)
{
    // Initialize ACL and create a stream on device 0.
    CHECK_ERROR(aclInit(nullptr));
    resources->aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources->deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&resources->stream));
    return 0;
}

int32_t AllocateDeviceData(size_t dataSize, RuntimeResources* resources)
{
    // Allocate source and destination buffers on the same device.
    CHECK_ERROR(aclrtMalloc(&resources->sourceDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources->destinationDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    return 0;
}

int32_t ConfigureMemcpyDescriptor(size_t dataSize, size_t* descSize, RuntimeResources* resources)
{
    // Query and allocate the device-side descriptor before recording the copy parameters.
    CHECK_ERROR(aclrtGetMemcpyDescSize(kMemcpyKind, descSize));
    if (*descSize == 0U) {
        ERROR_LOG("Invalid memcpy descriptor size: 0 bytes");
        return -1;
    }
    CHECK_ERROR(aclrtMalloc(&resources->memcpyDesc, *descSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtSetMemcpyDesc(
        resources->memcpyDesc, kMemcpyKind, resources->sourceDevice, resources->destinationDevice, dataSize, nullptr));
    INFO_LOG("Configured a %zu-byte memcpy descriptor for %zu bytes of data", *descSize, dataSize);
    return 0;
}

int32_t VerifyResult(const std::vector<uint32_t>& source, const std::vector<uint32_t>& destination)
{
    for (size_t index = 0U; index < source.size(); ++index) {
        if (source[index] != destination[index]) {
            ERROR_LOG("Data mismatch at index %zu: expected %u, actual %u", index, source[index], destination[index]);
            return -1;
        }
    }
    INFO_LOG("Verified all %zu copied elements", source.size());
    return 0;
}

int32_t ExecuteDescriptorCopy(
    const std::vector<uint32_t>& source, std::vector<uint32_t>* destination, RuntimeResources* resources)
{
    const size_t dataSize = source.size() * sizeof(source[0]);

    // Prepare the device source data and configure the reusable copy descriptor.
    CHECK_ERROR(aclrtMemcpy(resources->sourceDevice, dataSize, source.data(), dataSize, ACL_MEMCPY_HOST_TO_DEVICE));
    size_t descSize = 0U;
    if (ConfigureMemcpyDescriptor(dataSize, &descSize, resources) != 0) {
        return -1;
    }

    // Submit the descriptor-based copy and wait before reading the destination.
    CHECK_ERROR(aclrtMemcpyAsyncWithDesc(resources->memcpyDesc, kMemcpyKind, resources->stream));
    resources->copySubmitted = true;
    CHECK_ERROR(aclrtSynchronizeStream(resources->stream));
    resources->copySubmitted = false;
    CHECK_ERROR(
        aclrtMemcpy(destination->data(), dataSize, resources->destinationDevice, dataSize, ACL_MEMCPY_DEVICE_TO_HOST));

    return VerifyResult(source, *destination);
}

void ReleaseResources(RuntimeResources& resources, int32_t& finalResult)
{
    // Finish outstanding work and release Runtime resources in reverse lifecycle order.
    if (resources.copySubmitted && (resources.stream != nullptr)) {
        UpdateFinalResultOnError(
            "aclrtSynchronizeStream(resources.stream)", aclrtSynchronizeStream(resources.stream), finalResult);
    }
    if (resources.stream != nullptr) {
        UpdateFinalResultOnError(
            "aclrtDestroyStreamForce(resources.stream)", aclrtDestroyStreamForce(resources.stream), finalResult);
    }
    if (resources.memcpyDesc != nullptr) {
        UpdateFinalResultOnError("aclrtFree(resources.memcpyDesc)", aclrtFree(resources.memcpyDesc), finalResult);
    }
    if (resources.destinationDevice != nullptr) {
        UpdateFinalResultOnError(
            "aclrtFree(resources.destinationDevice)", aclrtFree(resources.destinationDevice), finalResult);
    }
    if (resources.sourceDevice != nullptr) {
        UpdateFinalResultOnError("aclrtFree(resources.sourceDevice)", aclrtFree(resources.sourceDevice), finalResult);
    }
    if (resources.deviceSet) {
        UpdateFinalResultOnError("aclrtResetDeviceForce(kDeviceId)", aclrtResetDeviceForce(kDeviceId), finalResult);
    }
    if (resources.aclInitialized) {
        UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
}

int32_t RunMemcpyDescriptorSample()
{
    std::vector<uint32_t> source(kElementCount);
    std::vector<uint32_t> destination(kElementCount, 0U);
    for (size_t index = 0U; index < source.size(); ++index) {
        source[index] = (static_cast<uint32_t>(index) * 37U + 11U) ^ 0x5A5AU;
    }

    RuntimeResources resources;
    const int32_t result = [&]() -> int32_t {
        if (InitializeRuntime(&resources) != 0) {
            return -1;
        }
        const size_t dataSize = source.size() * sizeof(source[0]);
        if (AllocateDeviceData(dataSize, &resources) != 0) {
            return -1;
        }
        return ExecuteDescriptorCopy(source, &destination, &resources);
    }();

    int32_t finalResult = result;
    ReleaseResources(resources, finalResult);
    if (finalResult == 0) {
        INFO_LOG("[SUCCESS] Memcpy descriptor sample completed successfully");
    }
    return finalResult;
}
} // namespace

int32_t main() { return RunMemcpyDescriptorSample(); }
