/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <array>
#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kSlotCount = 3U;
constexpr size_t kRoundCount = 3U;
constexpr size_t kElementCount = 32U;
constexpr size_t kSlotDataSize = kElementCount * sizeof(uint32_t);
constexpr size_t kHostDataSize = kSlotCount * kSlotDataSize;
constexpr uint32_t kNotifyWaitTimeout = 0U;

struct SampleResources {
    aclrtContext context = nullptr;
    aclrtStream producerStream = nullptr;
    aclrtStream consumerStream = nullptr;
    std::array<aclrtNotify, kSlotCount> notifies{};
    std::array<uint32_t, kSlotCount> notifyIds{};
    std::array<uint32_t*, kSlotCount> deviceBuffers{};
    uint32_t* inputHost = nullptr;
    uint32_t* outputHost = nullptr;
    size_t notifyCount = 0U;
    size_t deviceBufferCount = 0U;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool contextCreated = false;
    bool producerStreamCreated = false;
    bool consumerStreamCreated = false;
    bool inputHostAllocated = false;
    bool outputHostAllocated = false;
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

int32_t CreateStreamsAndNotifies(SampleResources& resources)
{
    CHECK_ERROR(aclrtCreateStream(&resources.producerStream));
    resources.producerStreamCreated = true;
    CHECK_ERROR(aclrtCreateStream(&resources.consumerStream));
    resources.consumerStreamCreated = true;
    for (size_t slot = 0U; slot < kSlotCount; ++slot) {
        CHECK_ERROR(aclrtCreateNotify(&resources.notifies[slot], ACL_NOTIFY_DEFAULT));
        ++resources.notifyCount;
        CHECK_ERROR(aclrtGetNotifyId(resources.notifies[slot], &resources.notifyIds[slot]));
        INFO_LOG("Notify slot %zu has ID %u.", slot, resources.notifyIds[slot]);
    }
    return 0;
}

int32_t AllocateBuffers(SampleResources& resources)
{
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources.inputHost), kHostDataSize));
    resources.inputHostAllocated = true;
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources.outputHost), kHostDataSize));
    resources.outputHostAllocated = true;
    for (size_t slot = 0U; slot < kSlotCount; ++slot) {
        CHECK_ERROR(aclrtMalloc(
            reinterpret_cast<void**>(&resources.deviceBuffers[slot]), kSlotDataSize, ACL_MEM_MALLOC_HUGE_FIRST));
        ++resources.deviceBufferCount;
    }
    return 0;
}

uint32_t ExpectedValue(size_t round, size_t slot, size_t index)
{
    return static_cast<uint32_t>((round + 1U) * 10000U + slot * 100U + index + 1U);
}

void PrepareRound(SampleResources& resources, size_t round)
{
    for (size_t slot = 0U; slot < kSlotCount; ++slot) {
        const size_t offset = slot * kElementCount;
        for (size_t index = 0U; index < kElementCount; ++index) {
            resources.inputHost[offset + index] = ExpectedValue(round, slot, index);
            resources.outputHost[offset + index] = 0U;
        }
    }
}

int32_t VerifyNotifyIdentity(const SampleResources& resources, size_t round)
{
    for (size_t slot = 0U; slot < kSlotCount; ++slot) {
        uint32_t currentId = 0U;
        CHECK_ERROR(aclrtGetNotifyId(resources.notifies[slot], &currentId));
        if (currentId != resources.notifyIds[slot]) {
            ERROR_LOG(
                "Notify ID changed in round %zu at slot %zu: got %u, expected %u.", round + 1U, slot, currentId,
                resources.notifyIds[slot]);
            return -1;
        }
    }
    INFO_LOG("Round %zu reused %zu stable Notify IDs.", round + 1U, kSlotCount);
    return 0;
}

int32_t SubmitRound(SampleResources& resources)
{
    for (size_t slot = 0U; slot < kSlotCount; ++slot) {
        const size_t offset = slot * kElementCount;
        CHECK_ERROR(aclrtMemcpyAsync(
            resources.deviceBuffers[slot], kSlotDataSize, resources.inputHost + offset, kSlotDataSize,
            ACL_MEMCPY_HOST_TO_DEVICE, resources.producerStream));
        CHECK_ERROR(aclrtRecordNotify(resources.notifies[slot], resources.producerStream));
        CHECK_ERROR(aclrtWaitAndResetNotify(resources.notifies[slot], resources.consumerStream, kNotifyWaitTimeout));
        CHECK_ERROR(aclrtMemcpyAsync(
            resources.outputHost + offset, kSlotDataSize, resources.deviceBuffers[slot], kSlotDataSize,
            ACL_MEMCPY_DEVICE_TO_HOST, resources.consumerStream));
    }
    return 0;
}

int32_t SynchronizeAndVerify(const SampleResources& resources, size_t round)
{
    CHECK_ERROR(aclrtSynchronizeStream(resources.producerStream));
    CHECK_ERROR(aclrtSynchronizeStream(resources.consumerStream));
    for (size_t slot = 0U; slot < kSlotCount; ++slot) {
        const size_t offset = slot * kElementCount;
        for (size_t index = 0U; index < kElementCount; ++index) {
            const uint32_t expected = ExpectedValue(round, slot, index);
            if (resources.outputHost[offset + index] != expected) {
                ERROR_LOG(
                    "Data mismatch in round %zu, slot %zu, index %zu: got %u, expected %u.", round + 1U, slot, index,
                    resources.outputHost[offset + index], expected);
                return -1;
            }
        }
    }
    INFO_LOG(
        "Round %zu verified %zu values without cross-round or cross-slot interference.", round + 1U,
        kSlotCount * kElementCount);
    return 0;
}

int32_t ExecuteRound(SampleResources& resources, size_t round)
{
    if (VerifyNotifyIdentity(resources, round) != 0) {
        return -1;
    }
    PrepareRound(resources, round);
    if ((SubmitRound(resources) != 0) || (SynchronizeAndVerify(resources, round) != 0)) {
        return -1;
    }
    CHECK_ERROR(aclrtNotifyBatchReset(resources.notifies.data(), resources.notifyCount));
    INFO_LOG("Round %zu batch-reset %zu Notifies.", round + 1U, resources.notifyCount);
    return 0;
}

int32_t RunSample(SampleResources& resources)
{
    if ((InitializeRuntime(resources) != 0) || (CreateStreamsAndNotifies(resources) != 0) ||
        (AllocateBuffers(resources) != 0)) {
        return -1;
    }
    for (size_t round = 0U; round < kRoundCount; ++round) {
        if (ExecuteRound(resources, round) != 0) {
            return -1;
        }
    }
    return 0;
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

void ReleasePipelineResources(const SampleResources& resources, int32_t& finalResult)
{
    for (size_t i = resources.deviceBufferCount; i > 0U; --i) {
        UpdateFinalResultOnError("aclrtFree", aclrtFree(resources.deviceBuffers[i - 1U]), finalResult);
    }
    if (resources.outputHostAllocated) {
        UpdateFinalResultOnError("aclrtFreeHost", aclrtFreeHost(resources.outputHost), finalResult);
    }
    if (resources.inputHostAllocated) {
        UpdateFinalResultOnError("aclrtFreeHost", aclrtFreeHost(resources.inputHost), finalResult);
    }
    for (size_t i = resources.notifyCount; i > 0U; --i) {
        UpdateFinalResultOnError("aclrtDestroyNotify", aclrtDestroyNotify(resources.notifies[i - 1U]), finalResult);
    }
}

void CleanupResources(const SampleResources& resources, bool mainFlowSucceeded, int32_t& finalResult)
{
    DestroyStreams(resources, mainFlowSucceeded, finalResult);
    ReleasePipelineResources(resources, finalResult);
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
        INFO_LOG("[SUCCESS] Reusable Stream handoff sample completed successfully.");
    }
    return finalResult;
}
