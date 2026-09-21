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
 * This sample round-trips independent small tensors with four synchronous and asynchronous batch-copy modes.
 */

#include <algorithm>
#include <array>
#include <cstddef>
#include <cstdint>
#include <limits>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kBatchCount = 3U;
constexpr size_t kNoFailedCopy = std::numeric_limits<size_t>::max();
constexpr std::array<size_t, kBatchCount> kElementCounts = {4U, 7U, 11U};

using PointerArray = std::array<void*, kBatchCount>;
using SizeArray = std::array<size_t, kBatchCount>;

struct RuntimeResources {
    aclrtStream stream = nullptr;
    PointerArray hostInputs = {};
    PointerArray hostOutputs = {};
    PointerArray deviceBuffers = {};
    SizeArray byteSizes = {};
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

aclrtMemcpyBatchAttr MakeCopyAttr(aclrtMemLocationType sourceType, aclrtMemLocationType destinationType)
{
    aclrtMemcpyBatchAttr attr = {};
    attr.srcLoc.id = static_cast<uint32_t>(kDeviceId);
    attr.srcLoc.type = sourceType;
    attr.dstLoc.id = static_cast<uint32_t>(kDeviceId);
    attr.dstLoc.type = destinationType;
    return attr;
}

int32_t InitializeRuntime(RuntimeResources* resources)
{
    // Initialize ACL, bind device 0, and create the stream used by asynchronous modes.
    CHECK_ERROR(aclInit(nullptr));
    resources->aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources->deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&resources->stream));
    return 0;
}

void FillInputTensor(size_t tensorIndex, RuntimeResources* resources)
{
    auto* input = static_cast<uint32_t*>(resources->hostInputs[tensorIndex]);
    for (size_t elementIndex = 0U; elementIndex < kElementCounts[tensorIndex]; ++elementIndex) {
        input[elementIndex] = static_cast<uint32_t>((tensorIndex + 1U) * 100U + elementIndex * 7U + 3U);
    }
}

int32_t AllocateBuffers(RuntimeResources* resources)
{
    // Allocate page-locked Host buffers so asynchronous copies remain asynchronous.
    for (size_t index = 0U; index < kBatchCount; ++index) {
        const size_t byteSize = kElementCounts[index] * sizeof(uint32_t);
        resources->byteSizes[index] = byteSize;
        CHECK_ERROR(aclrtMallocHost(&resources->hostInputs[index], byteSize));
        CHECK_ERROR(aclrtMallocHost(&resources->hostOutputs[index], byteSize));
        CHECK_ERROR(aclrtMalloc(&resources->deviceBuffers[index], byteSize, ACL_MEM_MALLOC_HUGE_FIRST));
        FillInputTensor(index, resources);
    }
    return 0;
}

void ClearHostOutputs(RuntimeResources* resources)
{
    for (size_t index = 0U; index < kBatchCount; ++index) {
        auto* output = static_cast<uint32_t*>(resources->hostOutputs[index]);
        std::fill_n(output, kElementCounts[index], 0U);
    }
}

int32_t VerifyRoundTrip(const char* modeName, const RuntimeResources& resources)
{
    // Compare every element so each independent tensor contributes to the result.
    for (size_t tensorIndex = 0U; tensorIndex < kBatchCount; ++tensorIndex) {
        const auto* expected = static_cast<const uint32_t*>(resources.hostInputs[tensorIndex]);
        const auto* actual = static_cast<const uint32_t*>(resources.hostOutputs[tensorIndex]);
        for (size_t elementIndex = 0U; elementIndex < kElementCounts[tensorIndex]; ++elementIndex) {
            if (expected[elementIndex] != actual[elementIndex]) {
                ERROR_LOG(
                    "%s tensor %zu mismatch at element %zu: expected %u, actual %u", modeName, tensorIndex,
                    elementIndex, expected[elementIndex], actual[elementIndex]);
                return -1;
            }
        }
        INFO_LOG("%s verified tensor %zu (%zu elements)", modeName, tensorIndex, kElementCounts[tensorIndex]);
    }
    return 0;
}

aclError CopyLegacySync(
    PointerArray& destinations, PointerArray& sources, SizeArray& sizes, aclrtMemcpyBatchAttr* attr, size_t* failIndex)
{
    size_t attrIndex = 0U;
    return aclrtMemcpyBatch(
        destinations.data(), sizes.data(), sources.data(), sizes.data(), kBatchCount, attr, &attrIndex, 1U, failIndex);
}

aclError CopyV2Sync(PointerArray& destinations, PointerArray& sources, SizeArray& sizes, aclrtMemcpyBatchAttr* attr)
{
    size_t attrIndex = 0U;
    return aclrtMemcpyBatchV2(
        destinations.data(), sizes.data(), sources.data(), sizes.data(), kBatchCount, attr, &attrIndex, 1U);
}

aclError CopyLegacyAsync(
    PointerArray& destinations, PointerArray& sources, SizeArray& sizes, aclrtMemcpyBatchAttr* attr, size_t* failIndex,
    aclrtStream stream)
{
    size_t attrIndex = 0U;
    return aclrtMemcpyBatchAsync(
        destinations.data(), sizes.data(), sources.data(), sizes.data(), kBatchCount, attr, &attrIndex, 1U, failIndex,
        stream);
}

aclError CopyV2Async(
    PointerArray& destinations, PointerArray& sources, SizeArray& sizes, aclrtMemcpyBatchAttr* attr, aclrtStream stream)
{
    size_t attrIndex = 0U;
    return aclrtMemcpyBatchAsyncV2(
        destinations.data(), sizes.data(), sources.data(), sizes.data(), kBatchCount, attr, &attrIndex, 1U, stream);
}

int32_t CheckLegacyResult(const char* modeName, size_t h2dFailIndex, size_t d2hFailIndex)
{
    if ((h2dFailIndex != kNoFailedCopy) || (d2hFailIndex != kNoFailedCopy)) {
        ERROR_LOG("%s reported unexpected failIndex values: H2D=%zu, D2H=%zu", modeName, h2dFailIndex, d2hFailIndex);
        return -1;
    }
    INFO_LOG("%s returned ACL_SUCCESS; H2D and D2H failIndex are SIZE_MAX", modeName);
    return 0;
}

int32_t RunLegacySynchronous(RuntimeResources* resources)
{
    ClearHostOutputs(resources);
    aclrtMemcpyBatchAttr h2dAttr = MakeCopyAttr(ACL_MEM_LOCATION_TYPE_HOST, ACL_MEM_LOCATION_TYPE_DEVICE);
    aclrtMemcpyBatchAttr d2hAttr = MakeCopyAttr(ACL_MEM_LOCATION_TYPE_DEVICE, ACL_MEM_LOCATION_TYPE_HOST);
    size_t h2dFailIndex = 0U;
    size_t d2hFailIndex = 0U;

    // Round-trip the tensor batch with the legacy synchronous API.
    CHECK_ERROR(
        CopyLegacySync(resources->deviceBuffers, resources->hostInputs, resources->byteSizes, &h2dAttr, &h2dFailIndex));
    CHECK_ERROR(CopyLegacySync(
        resources->hostOutputs, resources->deviceBuffers, resources->byteSizes, &d2hAttr, &d2hFailIndex));
    if (CheckLegacyResult("Legacy synchronous mode", h2dFailIndex, d2hFailIndex) != 0) {
        return -1;
    }
    return VerifyRoundTrip("Legacy synchronous mode", *resources);
}

int32_t RunV2Synchronous(RuntimeResources* resources)
{
    ClearHostOutputs(resources);
    aclrtMemcpyBatchAttr h2dAttr = MakeCopyAttr(ACL_MEM_LOCATION_TYPE_HOST, ACL_MEM_LOCATION_TYPE_DEVICE);
    aclrtMemcpyBatchAttr d2hAttr = MakeCopyAttr(ACL_MEM_LOCATION_TYPE_DEVICE, ACL_MEM_LOCATION_TYPE_HOST);

    // Round-trip the same tensor batch with the V2 synchronous API.
    CHECK_ERROR(CopyV2Sync(resources->deviceBuffers, resources->hostInputs, resources->byteSizes, &h2dAttr));
    CHECK_ERROR(CopyV2Sync(resources->hostOutputs, resources->deviceBuffers, resources->byteSizes, &d2hAttr));
    INFO_LOG("V2 synchronous mode returned ACL_SUCCESS for H2D and D2H; V2 has no failIndex output");
    return VerifyRoundTrip("V2 synchronous mode", *resources);
}

int32_t RunLegacyAsynchronous(RuntimeResources* resources)
{
    ClearHostOutputs(resources);
    aclrtMemcpyBatchAttr h2dAttr = MakeCopyAttr(ACL_MEM_LOCATION_TYPE_HOST, ACL_MEM_LOCATION_TYPE_DEVICE);
    aclrtMemcpyBatchAttr d2hAttr = MakeCopyAttr(ACL_MEM_LOCATION_TYPE_DEVICE, ACL_MEM_LOCATION_TYPE_HOST);
    size_t h2dFailIndex = 0U;
    size_t d2hFailIndex = 0U;

    // Enqueue H2D and D2H on one stream, then wait before validating Host output.
    CHECK_ERROR(CopyLegacyAsync(
        resources->deviceBuffers, resources->hostInputs, resources->byteSizes, &h2dAttr, &h2dFailIndex,
        resources->stream));
    resources->workSubmitted = true;
    CHECK_ERROR(CopyLegacyAsync(
        resources->hostOutputs, resources->deviceBuffers, resources->byteSizes, &d2hAttr, &d2hFailIndex,
        resources->stream));
    CHECK_ERROR(aclrtSynchronizeStream(resources->stream));
    resources->workSubmitted = false;
    if (CheckLegacyResult("Legacy asynchronous mode", h2dFailIndex, d2hFailIndex) != 0) {
        return -1;
    }
    return VerifyRoundTrip("Legacy asynchronous mode", *resources);
}

int32_t RunV2Asynchronous(RuntimeResources* resources)
{
    ClearHostOutputs(resources);
    aclrtMemcpyBatchAttr h2dAttr = MakeCopyAttr(ACL_MEM_LOCATION_TYPE_HOST, ACL_MEM_LOCATION_TYPE_DEVICE);
    aclrtMemcpyBatchAttr d2hAttr = MakeCopyAttr(ACL_MEM_LOCATION_TYPE_DEVICE, ACL_MEM_LOCATION_TYPE_HOST);

    // Enqueue the same round trip with the V2 asynchronous API and synchronize once.
    CHECK_ERROR(CopyV2Async(
        resources->deviceBuffers, resources->hostInputs, resources->byteSizes, &h2dAttr, resources->stream));
    resources->workSubmitted = true;
    CHECK_ERROR(CopyV2Async(
        resources->hostOutputs, resources->deviceBuffers, resources->byteSizes, &d2hAttr, resources->stream));
    CHECK_ERROR(aclrtSynchronizeStream(resources->stream));
    resources->workSubmitted = false;
    INFO_LOG("V2 asynchronous mode returned ACL_SUCCESS for H2D and D2H; V2 has no failIndex output");
    return VerifyRoundTrip("V2 asynchronous mode", *resources);
}

int32_t RunAllCopyModes(RuntimeResources* resources)
{
    if (RunLegacySynchronous(resources) != 0) {
        return -1;
    }
    if (RunV2Synchronous(resources) != 0) {
        return -1;
    }
    if (RunLegacyAsynchronous(resources) != 0) {
        return -1;
    }
    return RunV2Asynchronous(resources);
}

void ReleasePointerArray(PointerArray& pointers, bool hostMemory, int32_t& finalResult)
{
    for (size_t remaining = kBatchCount; remaining > 0U; --remaining) {
        const size_t index = remaining - 1U;
        if (pointers[index] == nullptr) {
            continue;
        }
        const aclError ret = hostMemory ? aclrtFreeHost(pointers[index]) : aclrtFree(pointers[index]);
        UpdateFinalResultOnError(hostMemory ? "aclrtFreeHost" : "aclrtFree", ret, finalResult);
        pointers[index] = nullptr;
    }
}

void ReleaseResources(RuntimeResources& resources, int32_t& finalResult)
{
    // Complete outstanding work and release resources in reverse lifecycle order.
    if (resources.workSubmitted && (resources.stream != nullptr)) {
        UpdateFinalResultOnError(
            "aclrtSynchronizeStream(resources.stream)", aclrtSynchronizeStream(resources.stream), finalResult);
    }
    if (resources.stream != nullptr) {
        UpdateFinalResultOnError(
            "aclrtDestroyStreamForce(resources.stream)", aclrtDestroyStreamForce(resources.stream), finalResult);
    }
    ReleasePointerArray(resources.deviceBuffers, false, finalResult);
    ReleasePointerArray(resources.hostOutputs, true, finalResult);
    ReleasePointerArray(resources.hostInputs, true, finalResult);
    if (resources.deviceSet) {
        UpdateFinalResultOnError("aclrtResetDeviceForce(kDeviceId)", aclrtResetDeviceForce(kDeviceId), finalResult);
    }
    if (resources.aclInitialized) {
        UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
}

int32_t RunBatchTensorRoundTripSample()
{
    RuntimeResources resources;
    int32_t result = InitializeRuntime(&resources);
    if (result == 0) {
        result = AllocateBuffers(&resources);
    }
    if (result == 0) {
        result = RunAllCopyModes(&resources);
    }

    int32_t finalResult = result;
    ReleaseResources(resources, finalResult);
    if (finalResult == 0) {
        INFO_LOG("[SUCCESS] Batch tensor round-trip sample completed successfully");
    }
    return finalResult;
}
} // namespace

int32_t main() { return RunBatchTensorRoundTripSample(); }
