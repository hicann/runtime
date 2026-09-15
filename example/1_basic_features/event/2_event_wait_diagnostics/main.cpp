/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>

#include "acl/acl.h"
#include "kernel_func/kernel_ops.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kBlockDim = 1U;
constexpr int32_t kWaitTimeoutSeconds = 5;
constexpr uint32_t kInputValue = 0U;
constexpr uint32_t kExpectedValue = 2U;

struct SampleResources {
    aclrtContext context = nullptr;
    aclrtStream producerStream = nullptr;
    aclrtStream consumerStream = nullptr;
    aclrtEvent event = nullptr;
    uint32_t* valueDevice = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool contextCreated = false;
    bool producerStreamCreated = false;
    bool consumerStreamCreated = false;
    bool eventCreated = false;
    bool deviceMemoryAllocated = false;
};

const char* WaitStatusToString(aclrtEventWaitStatus status)
{
    switch (status) {
        case ACL_EVENT_WAIT_STATUS_COMPLETE:
            return "COMPLETE";
        case ACL_EVENT_WAIT_STATUS_NOT_READY:
            return "NOT_READY";
        default:
            return "RESERVED";
    }
}

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
    CHECK_ERROR(aclrtCreateStream(&resources.producerStream));
    resources.producerStreamCreated = true;
    CHECK_ERROR(aclrtCreateStream(&resources.consumerStream));
    resources.consumerStreamCreated = true;
    return 0;
}

int32_t PrepareEvent(SampleResources& resources)
{
    uint32_t availableBefore = 0U;
    CHECK_ERROR(aclrtGetEventAvailNum(&availableBefore));
    if (availableBefore == 0U) {
        ERROR_LOG("No Event is available on Device %d.", kDeviceId);
        return -1;
    }
    INFO_LOG("Available Events before creation: %u.", availableBefore);

    CHECK_ERROR(aclrtCreateEvent(&resources.event));
    resources.eventCreated = true;

    uint32_t availableAfter = 0U;
    CHECK_ERROR(aclrtGetEventAvailNum(&availableAfter));
    INFO_LOG("Available Events after creation: %u.", availableAfter);
    return 0;
}

int32_t SubmitWaitTask(SampleResources& resources)
{
    CHECK_ERROR(
        aclrtMalloc(reinterpret_cast<void**>(&resources.valueDevice), sizeof(uint32_t), ACL_MEM_MALLOC_HUGE_FIRST));
    resources.deviceMemoryAllocated = true;
    CHECK_ERROR(aclrtMemcpy(
        resources.valueDevice, sizeof(uint32_t), &kInputValue, sizeof(uint32_t), ACL_MEMCPY_HOST_TO_DEVICE));

    INFO_LOG("Producer starts a long task: value += 1.");
    LongOP(kBlockDim, resources.producerStream, resources.valueDevice);
    CHECK_ERROR(aclrtRecordEvent(resources.event, resources.producerStream));

    uint32_t eventId = 0U;
    CHECK_ERROR(aclrtGetEventId(resources.event, &eventId));
    INFO_LOG("Recorded ordinary Event ID: %u.", eventId);

    CHECK_ERROR(aclrtStreamWaitEventWithTimeout(resources.consumerStream, resources.event, kWaitTimeoutSeconds));
    INFO_LOG("Consumer waits for the Event with a %d-second timeout.", kWaitTimeoutSeconds);

    aclrtEventWaitStatus waitStatus = ACL_EVENT_WAIT_STATUS_RESERVED;
    CHECK_ERROR(aclrtQueryEventWaitStatus(resources.event, &waitStatus));
    INFO_LOG("Wait status before consumer synchronization: %s.", WaitStatusToString(waitStatus));
    if (waitStatus != ACL_EVENT_WAIT_STATUS_NOT_READY) {
        ERROR_LOG("Expected wait status NOT_READY before synchronization, got %s.", WaitStatusToString(waitStatus));
        return -1;
    }
    return 0;
}

int32_t SynchronizeAndVerify(SampleResources& resources)
{
    INFO_LOG("Consumer submits the dependent task: value *= 2.");
    ShortOP(kBlockDim, resources.consumerStream, resources.valueDevice);
    CHECK_ERROR(aclrtSynchronizeStream(resources.consumerStream));
    CHECK_ERROR(aclrtSynchronizeStream(resources.producerStream));

    aclrtEventWaitStatus waitStatus = ACL_EVENT_WAIT_STATUS_RESERVED;
    CHECK_ERROR(aclrtQueryEventWaitStatus(resources.event, &waitStatus));
    INFO_LOG("Wait status after consumer synchronization: %s.", WaitStatusToString(waitStatus));
    if (waitStatus != ACL_EVENT_WAIT_STATUS_COMPLETE) {
        ERROR_LOG("Expected wait status COMPLETE after synchronization, got %s.", WaitStatusToString(waitStatus));
        return -1;
    }

    uint32_t outputValue = 0U;
    CHECK_ERROR(aclrtMemcpy(
        &outputValue, sizeof(uint32_t), resources.valueDevice, sizeof(uint32_t), ACL_MEMCPY_DEVICE_TO_HOST));
    INFO_LOG("Output value: %u (expected: %u).", outputValue, kExpectedValue);
    if (outputValue != kExpectedValue) {
        ERROR_LOG("Unexpected output value: got %u, expected %u.", outputValue, kExpectedValue);
        return -1;
    }
    return 0;
}

int32_t RunSample(SampleResources& resources)
{
    if (InitializeRuntime(resources) != 0) {
        return -1;
    }
    if (PrepareEvent(resources) != 0) {
        return -1;
    }
    if (SubmitWaitTask(resources) != 0) {
        return -1;
    }
    return SynchronizeAndVerify(resources);
}

void DestroyStream(aclrtStream stream, bool mainFlowSucceeded, int32_t& finalResult)
{
    const aclError ret = mainFlowSucceeded ? aclrtDestroyStream(stream) : aclrtDestroyStreamForce(stream);
    UpdateFinalResultOnError(mainFlowSucceeded ? "aclrtDestroyStream" : "aclrtDestroyStreamForce", ret, finalResult);
}

void CleanupResources(const SampleResources& resources, bool mainFlowSucceeded, int32_t& finalResult)
{
    if (resources.eventCreated) {
        UpdateFinalResultOnError("aclrtDestroyEvent", aclrtDestroyEvent(resources.event), finalResult);
    }
    if (resources.consumerStreamCreated) {
        DestroyStream(resources.consumerStream, mainFlowSucceeded, finalResult);
    }
    if (resources.producerStreamCreated) {
        DestroyStream(resources.producerStream, mainFlowSucceeded, finalResult);
    }
    if (resources.deviceMemoryAllocated) {
        UpdateFinalResultOnError("aclrtFree", aclrtFree(resources.valueDevice), finalResult);
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
        INFO_LOG("[SUCCESS] Event wait diagnostics sample completed successfully.");
    }
    return finalResult;
}
