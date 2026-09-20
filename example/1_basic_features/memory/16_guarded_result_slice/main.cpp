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
 * This sample updates one result-table slice through indirect device base addresses and verifies its guard regions.
 */

#include <array>
#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kElementCount = 16U;
constexpr size_t kSourceOffset = 3U;
constexpr size_t kDestinationOffset = 5U;
constexpr size_t kSliceElementCount = 6U;
constexpr uint32_t kSentinel = 0xDEADBEEFU;
constexpr uint32_t kSourceValueBase = 0x10000000U;
constexpr uint32_t kSourceValueStride = 0x101U;
constexpr size_t kBaseAddressBytes = sizeof(void*);
constexpr size_t kTableBytes = kElementCount * sizeof(uint32_t);
constexpr size_t kSourceOffsetBytes = kSourceOffset * sizeof(uint32_t);
constexpr size_t kDestinationOffsetBytes = kDestinationOffset * sizeof(uint32_t);
constexpr size_t kSliceBytes = kSliceElementCount * sizeof(uint32_t);

struct RuntimeResources {
    aclrtStream stream = nullptr;
    void* sourceDevice = nullptr;
    void* resultDevice = nullptr;
    void* sourceBaseDevice = nullptr;
    void* resultBaseDevice = nullptr;
    uint32_t* expectedHost = nullptr;
    uint32_t* outputHost = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool workSubmitted = false;
};

void UpdateFinalResultOnError(const char* apiName, aclError ret, int32_t& finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}

std::array<uint32_t, kElementCount> CreateSourceTable()
{
    std::array<uint32_t, kElementCount> source{};
    for (size_t index = 0U; index < source.size(); ++index) {
        source[index] = kSourceValueBase + (static_cast<uint32_t>(index) * kSourceValueStride);
    }
    return source;
}

int32_t InitializeRuntime(RuntimeResources* resources)
{
    // Initialize ACL and create one stream on device 0.
    CHECK_ERROR(aclInit(nullptr));
    resources->aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources->deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&resources->stream));
    return 0;
}

int32_t AllocateBuffers(RuntimeResources* resources)
{
    // Allocate the data tables, device-resident base-address slots, and pinned Host verification tables.
    CHECK_ERROR(aclrtMalloc(&resources->sourceDevice, kTableBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources->resultDevice, kTableBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources->sourceBaseDevice, kBaseAddressBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources->resultBaseDevice, kBaseAddressBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources->expectedHost), kTableBytes));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources->outputHost), kTableBytes));
    return 0;
}

int32_t PrepareExpectedTable(const std::array<uint32_t, kElementCount>& source, RuntimeResources* resources)
{
    // Build the expected Host table from a 32-bit sentinel baseline and the selected source slice.
    CHECK_ERROR(aclrtMemsetD32(resources->expectedHost, kTableBytes, kSentinel, kElementCount));
    for (size_t index = 0U; index < kElementCount; ++index) {
        if (resources->expectedHost[index] != kSentinel) {
            ERROR_LOG(
                "Host sentinel mismatch at index %zu: expected 0x%08X, actual 0x%08X", index, kSentinel,
                resources->expectedHost[index]);
            return -1;
        }
    }
    INFO_LOG("Verified Host sentinel baseline (%zu elements)", kElementCount);
    for (size_t index = 0U; index < kSliceElementCount; ++index) {
        resources->expectedHost[kDestinationOffset + index] = source[kSourceOffset + index];
    }
    INFO_LOG("Prepared expected result table with sentinel 0x%08X", kSentinel);
    return 0;
}

int32_t StoreDeviceBaseAddresses(RuntimeResources* resources)
{
    // Store both base addresses in device memory for indirect resolution by the offset-copy task.
    void* sourceBase = resources->sourceDevice;
    void* resultBase = resources->resultDevice;
    CHECK_ERROR(aclrtMemcpy(
        resources->sourceBaseDevice, kBaseAddressBytes, static_cast<const void*>(&sourceBase), kBaseAddressBytes,
        ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(
        resources->resultBaseDevice, kBaseAddressBytes, static_cast<const void*>(&resultBase), kBaseAddressBytes,
        ACL_MEMCPY_HOST_TO_DEVICE));
    return 0;
}

int32_t SubmitSliceUpdate(const std::array<uint32_t, kElementCount>& source, RuntimeResources* resources)
{
    // Upload source data and initialize the actual result table asynchronously with the same sentinel.
    CHECK_ERROR(
        aclrtMemcpy(resources->sourceDevice, kTableBytes, source.data(), kTableBytes, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemsetD32Async(resources->resultDevice, kTableBytes, kSentinel, kElementCount, resources->stream));
    resources->workSubmitted = true;

    // Resolve device-resident base addresses and copy only the requested source slice to the result-table offset.
    CHECK_ERROR(aclrtMemcpyAsyncWithOffset(
        reinterpret_cast<void**>(resources->resultBaseDevice), kTableBytes, kDestinationOffsetBytes,
        reinterpret_cast<const void**>(resources->sourceBaseDevice), kSliceBytes, kSourceOffsetBytes,
        ACL_MEMCPY_INNER_DEVICE_TO_DEVICE, resources->stream));
    CHECK_ERROR(aclrtSynchronizeStream(resources->stream));
    resources->workSubmitted = false;
    CHECK_ERROR(aclrtMemcpy(
        resources->outputHost, kTableBytes, resources->resultDevice, kTableBytes, ACL_MEMCPY_DEVICE_TO_HOST));
    return 0;
}

int32_t VerifyRange(const uint32_t* actual, const uint32_t* expected, size_t begin, size_t end, const char* rangeName)
{
    for (size_t index = begin; index < end; ++index) {
        if (actual[index] != expected[index]) {
            ERROR_LOG(
                "%s mismatch at index %zu: expected 0x%08X, actual 0x%08X", rangeName, index, expected[index],
                actual[index]);
            return -1;
        }
    }
    INFO_LOG("Verified %s [%zu, %zu)", rangeName, begin, end);
    return 0;
}

int32_t VerifyResult(const RuntimeResources& resources)
{
    // Validate the copied slice and both untouched sentinel regions independently.
    if (VerifyRange(resources.outputHost, resources.expectedHost, 0U, kDestinationOffset, "prefix guard") != 0) {
        return -1;
    }
    const size_t sliceEnd = kDestinationOffset + kSliceElementCount;
    if (VerifyRange(resources.outputHost, resources.expectedHost, kDestinationOffset, sliceEnd, "copied slice") != 0) {
        return -1;
    }
    return VerifyRange(resources.outputHost, resources.expectedHost, sliceEnd, kElementCount, "suffix guard");
}

void SynchronizeAndDestroyStream(const RuntimeResources& resources, int32_t& finalResult)
{
    if (resources.workSubmitted && (resources.stream != nullptr)) {
        UpdateFinalResultOnError(
            "aclrtSynchronizeStream(resources.stream)", aclrtSynchronizeStream(resources.stream), finalResult);
    }
    if (resources.stream != nullptr) {
        UpdateFinalResultOnError(
            "aclrtDestroyStreamForce(resources.stream)", aclrtDestroyStreamForce(resources.stream), finalResult);
    }
}

void ReleaseHostBuffer(void* buffer, const char* apiName, int32_t& finalResult)
{
    if (buffer == nullptr) {
        return;
    }
    UpdateFinalResultOnError(apiName, aclrtFreeHost(buffer), finalResult);
}

void ReleaseDeviceBuffer(void* buffer, const char* apiName, int32_t& finalResult)
{
    if (buffer == nullptr) {
        return;
    }
    UpdateFinalResultOnError(apiName, aclrtFree(buffer), finalResult);
}

void FinalizeRuntime(const RuntimeResources& resources, int32_t& finalResult)
{
    if (resources.deviceSet) {
        UpdateFinalResultOnError("aclrtResetDeviceForce(kDeviceId)", aclrtResetDeviceForce(kDeviceId), finalResult);
    }
    if (resources.aclInitialized) {
        UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
}

void ReleaseResources(const RuntimeResources& resources, int32_t& finalResult)
{
    // Complete outstanding work and release Runtime resources in reverse lifecycle order.
    SynchronizeAndDestroyStream(resources, finalResult);
    ReleaseHostBuffer(resources.outputHost, "aclrtFreeHost(resources.outputHost)", finalResult);
    ReleaseHostBuffer(resources.expectedHost, "aclrtFreeHost(resources.expectedHost)", finalResult);
    ReleaseDeviceBuffer(resources.resultBaseDevice, "aclrtFree(resources.resultBaseDevice)", finalResult);
    ReleaseDeviceBuffer(resources.sourceBaseDevice, "aclrtFree(resources.sourceBaseDevice)", finalResult);
    ReleaseDeviceBuffer(resources.resultDevice, "aclrtFree(resources.resultDevice)", finalResult);
    ReleaseDeviceBuffer(resources.sourceDevice, "aclrtFree(resources.sourceDevice)", finalResult);
    FinalizeRuntime(resources, finalResult);
}

int32_t RunGuardedResultSliceSample()
{
    const std::array<uint32_t, kElementCount> source = CreateSourceTable();
    RuntimeResources resources;
    int32_t result = InitializeRuntime(&resources);
    if (result == 0) {
        result = AllocateBuffers(&resources);
    }
    if (result == 0) {
        result = PrepareExpectedTable(source, &resources);
    }
    if (result == 0) {
        result = StoreDeviceBaseAddresses(&resources);
    }
    if (result == 0) {
        result = SubmitSliceUpdate(source, &resources);
    }
    if (result == 0) {
        result = VerifyResult(resources);
    }

    int32_t finalResult = result;
    ReleaseResources(resources, finalResult);
    if (finalResult == 0) {
        INFO_LOG("[SUCCESS] Guarded result slice sample completed successfully");
    }
    return finalResult;
}
} // namespace

int32_t main() { return RunGuardedResultSliceSample(); }
