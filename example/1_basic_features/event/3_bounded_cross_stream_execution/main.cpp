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
#include <limits>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kLegacyTimeoutSeconds = 1U;
constexpr uint32_t kEventWaitTimeoutSeconds = 5U;
constexpr int32_t kDeviceSyncTimeoutMs = 5000;
constexpr size_t kElementCount = 256U;
constexpr size_t kDataSize = kElementCount * sizeof(uint32_t);

struct SampleResources {
    aclrtContext context = nullptr;
    aclrtStream producerStream = nullptr;
    aclrtStream consumerStream = nullptr;
    aclrtEvent readyEvent = nullptr;
    uint32_t* inputHost = nullptr;
    uint32_t* outputHost = nullptr;
    uint32_t* dataDevice = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool contextCreated = false;
    bool producerStreamCreated = false;
    bool consumerStreamCreated = false;
    bool eventCreated = false;
    bool inputHostAllocated = false;
    bool outputHostAllocated = false;
    bool deviceMemoryAllocated = false;
};

void UpdateFinalResultOnError(const char* apiName, aclError ret, int32_t& finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}

int32_t InitializeRuntime(SampleResources& resources)
{
    CHECK_ERROR(aclInit(nullptr));
    resources.aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    CHECK_ERROR(aclrtCreateContext(&resources.context, kDeviceId));
    resources.contextCreated = true;
    return 0;
}

uint64_t AlignTimeoutToHardware(uint64_t requestedTimeoutUs, uint64_t intervalUs)
{
    if (intervalUs == 0U) {
        return 0U;
    }
    uint64_t intervalCount = requestedTimeoutUs / intervalUs;
    if ((requestedTimeoutUs % intervalUs) != 0U) {
        ++intervalCount;
    }
    const uint64_t effectiveCount = (intervalCount > 254U) ? 254U : intervalCount;
    return intervalUs * effectiveCount;
}

bool MatchesMillisecondReadback(uint64_t actualTimeoutUs, uint32_t timeoutMs)
{
    const uint64_t floorMs = actualTimeoutUs / 1000U;
    const uint64_t ceilMs = (actualTimeoutUs + 999U) / 1000U;
    return (timeoutMs == floorMs) || (timeoutMs == ceilMs);
}

int32_t ConfigureExecutionTimeouts()
{
    uint64_t intervalUs = 0U;
    CHECK_ERROR(aclrtGetOpTimeOutInterval(&intervalUs));
    if ((intervalUs == 0U) || (intervalUs > std::numeric_limits<uint64_t>::max() / 254U)) {
        ERROR_LOG("Invalid operation timeout interval: %llu us.", static_cast<unsigned long long>(intervalUs));
        return -1;
    }
    INFO_LOG("Hardware operation timeout interval: %llu us.", static_cast<unsigned long long>(intervalUs));

    CHECK_ERROR(aclrtSetOpExecuteTimeOut(kLegacyTimeoutSeconds));
    uint32_t legacyActualMs = 0U;
    CHECK_ERROR(aclrtGetOpExecuteTimeout(&legacyActualMs));
    constexpr uint64_t kMicrosecondsPerSecond = 1000000U;
    const uint64_t legacyRequestedUs = kLegacyTimeoutSeconds * kMicrosecondsPerSecond;
    const uint64_t legacyExpectedUs = AlignTimeoutToHardware(legacyRequestedUs, intervalUs);
    if (!MatchesMillisecondReadback(legacyExpectedUs, legacyActualMs)) {
        ERROR_LOG(
            "Second-level timeout verification failed: got %u ms, expected about %llu us.", legacyActualMs,
            static_cast<unsigned long long>(legacyExpectedUs));
        return -1;
    }
    INFO_LOG("Second-level request: %u s; hardware readback: %u ms.", kLegacyTimeoutSeconds, legacyActualMs);

    const uint64_t requestedTimeoutUs = intervalUs + 1U;
    const uint64_t expectedTimeoutUs = intervalUs * 2U;
    uint64_t actualTimeoutUs = 0U;
    CHECK_ERROR(aclrtSetOpExecuteTimeOutV2(requestedTimeoutUs, &actualTimeoutUs));
    if (actualTimeoutUs != expectedTimeoutUs) {
        ERROR_LOG(
            "Microsecond timeout verification failed: got %llu us, expected %llu us.",
            static_cast<unsigned long long>(actualTimeoutUs), static_cast<unsigned long long>(expectedTimeoutUs));
        return -1;
    }
    INFO_LOG(
        "Microsecond request: %llu us; actual: %llu us.", static_cast<unsigned long long>(requestedTimeoutUs),
        static_cast<unsigned long long>(actualTimeoutUs));
    return 0;
}

int32_t CreatePipelineResources(SampleResources& resources)
{
    CHECK_ERROR(aclrtCreateStream(&resources.producerStream));
    resources.producerStreamCreated = true;
    CHECK_ERROR(aclrtCreateStream(&resources.consumerStream));
    resources.consumerStreamCreated = true;
    CHECK_ERROR(aclrtCreateEvent(&resources.readyEvent));
    resources.eventCreated = true;
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources.inputHost), kDataSize));
    resources.inputHostAllocated = true;
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources.outputHost), kDataSize));
    resources.outputHostAllocated = true;
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&resources.dataDevice), kDataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    resources.deviceMemoryAllocated = true;

    for (size_t i = 0; i < kElementCount; ++i) {
        resources.inputHost[i] = static_cast<uint32_t>(i * 3U + 7U);
        resources.outputHost[i] = 0U;
    }
    return 0;
}

int32_t SubmitCrossStreamPipeline(SampleResources& resources)
{
    CHECK_ERROR(aclrtSetOpWaitTimeout(kEventWaitTimeoutSeconds));
    INFO_LOG("Event wait budget: %u s.", kEventWaitTimeoutSeconds);

    CHECK_ERROR(aclrtMemcpyAsync(
        resources.dataDevice, kDataSize, resources.inputHost, kDataSize, ACL_MEMCPY_HOST_TO_DEVICE,
        resources.producerStream));
    CHECK_ERROR(aclrtRecordEvent(resources.readyEvent, resources.producerStream));
    CHECK_ERROR(aclrtStreamWaitEvent(resources.consumerStream, resources.readyEvent));
    CHECK_ERROR(aclrtMemcpyAsync(
        resources.outputHost, kDataSize, resources.dataDevice, kDataSize, ACL_MEMCPY_DEVICE_TO_HOST,
        resources.consumerStream));
    INFO_LOG("Submitted producer copy, cross-Stream Event wait, and consumer copy.");
    return 0;
}

int32_t SynchronizeAndVerify(const SampleResources& resources)
{
    CHECK_ERROR(aclrtSynchronizeDeviceWithTimeout(kDeviceSyncTimeoutMs));
    INFO_LOG("Device synchronized within %d ms.", kDeviceSyncTimeoutMs);
    for (size_t i = 0; i < kElementCount; ++i) {
        if (resources.outputHost[i] != resources.inputHost[i]) {
            ERROR_LOG(
                "Data mismatch at index %zu: got %u, expected %u.", i, resources.outputHost[i], resources.inputHost[i]);
            return -1;
        }
    }
    INFO_LOG("Verified %zu values transferred across the Event dependency.", kElementCount);
    return 0;
}

int32_t RunSample(SampleResources& resources)
{
    if (InitializeRuntime(resources) != 0) {
        return -1;
    }
    if (ConfigureExecutionTimeouts() != 0) {
        return -1;
    }
    if (CreatePipelineResources(resources) != 0) {
        return -1;
    }
    if (SubmitCrossStreamPipeline(resources) != 0) {
        return -1;
    }
    return SynchronizeAndVerify(resources);
}

void DestroyStreams(const SampleResources& resources, bool mainFlowSucceeded, int32_t& finalResult)
{
    if (resources.consumerStreamCreated) {
        const aclError ret = mainFlowSucceeded ? aclrtDestroyStream(resources.consumerStream) :
                                                 aclrtDestroyStreamForce(resources.consumerStream);
        UpdateFinalResultOnError(
            mainFlowSucceeded ? "aclrtDestroyStream" : "aclrtDestroyStreamForce", ret, finalResult);
    }
    if (resources.producerStreamCreated) {
        const aclError ret = mainFlowSucceeded ? aclrtDestroyStream(resources.producerStream) :
                                                 aclrtDestroyStreamForce(resources.producerStream);
        UpdateFinalResultOnError(
            mainFlowSucceeded ? "aclrtDestroyStream" : "aclrtDestroyStreamForce", ret, finalResult);
    }
}

void CleanupResources(const SampleResources& resources, bool mainFlowSucceeded, int32_t& finalResult)
{
    if (mainFlowSucceeded && resources.eventCreated) {
        UpdateFinalResultOnError("aclrtDestroyEvent", aclrtDestroyEvent(resources.readyEvent), finalResult);
    }
    DestroyStreams(resources, mainFlowSucceeded, finalResult);
    if (!mainFlowSucceeded && resources.eventCreated) {
        UpdateFinalResultOnError("aclrtDestroyEvent", aclrtDestroyEvent(resources.readyEvent), finalResult);
    }
    if (resources.deviceMemoryAllocated) {
        UpdateFinalResultOnError("aclrtFree", aclrtFree(resources.dataDevice), finalResult);
    }
    if (resources.outputHostAllocated) {
        UpdateFinalResultOnError("aclrtFreeHost", aclrtFreeHost(resources.outputHost), finalResult);
    }
    if (resources.inputHostAllocated) {
        UpdateFinalResultOnError("aclrtFreeHost", aclrtFreeHost(resources.inputHost), finalResult);
    }
    if (resources.contextCreated) {
        UpdateFinalResultOnError("aclrtDestroyContext", aclrtDestroyContext(resources.context), finalResult);
    }
    if (resources.deviceSet) {
        UpdateFinalResultOnError("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), finalResult);
    }
    if (resources.aclInitialized) {
        UpdateFinalResultOnError("aclFinalize", aclFinalize(), finalResult);
    }
}
} // namespace

int32_t main()
{
    SampleResources resources;
    const int32_t result = RunSample(resources);
    int32_t finalResult = result;
    CleanupResources(resources, result == 0, finalResult);
    if (finalResult == 0) {
        INFO_LOG("[SUCCESS] Bounded cross-Stream execution sample completed successfully.");
    }
    return finalResult;
}
