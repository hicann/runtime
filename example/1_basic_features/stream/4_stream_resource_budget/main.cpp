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
constexpr aclrtDevResLimitType kResourceType = ACL_RT_DEV_RES_VECTOR_CORE;
constexpr uint32_t kRequestedLimit = 1;
constexpr uint32_t kInputValue = 41;
constexpr uint32_t kExpectedValue = 42;

struct SampleResources {
    aclrtStream stream = nullptr;
    uint32_t* valueDevice = nullptr;
    uint32_t defaultLimit = 0;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool streamCreated = false;
    bool deviceMemoryAllocated = false;
    bool streamLimitSet = false;
    bool streamLimitInUse = false;
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

    uint32_t availableBefore = 0;
    CHECK_ERROR(aclrtGetStreamAvailableNum(&availableBefore));
    if (availableBefore == 0U) {
        ERROR_LOG("No Stream is available on Device %d.", kDeviceId);
        return -1;
    }
    INFO_LOG("Available Streams before creation: %u.", availableBefore);

    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    resources.streamCreated = true;
    uint32_t availableAfter = 0;
    CHECK_ERROR(aclrtGetStreamAvailableNum(&availableAfter));
    INFO_LOG("Available Streams after creation: %u.", availableAfter);
    return 0;
}

int32_t PrepareDeviceMemory(SampleResources& resources)
{
    CHECK_ERROR(
        aclrtMalloc(reinterpret_cast<void**>(&resources.valueDevice), sizeof(uint32_t), ACL_MEM_MALLOC_HUGE_FIRST));
    resources.deviceMemoryAllocated = true;
    CHECK_ERROR(aclrtMemcpy(
        resources.valueDevice, sizeof(uint32_t), &kInputValue, sizeof(uint32_t), ACL_MEMCPY_HOST_TO_DEVICE));
    return 0;
}

int32_t ConfigureStreamBudget(SampleResources& resources, uint32_t& configuredLimit)
{
    CHECK_ERROR(aclrtGetStreamResLimit(resources.stream, kResourceType, &resources.defaultLimit));
    if (resources.defaultLimit < kRequestedLimit) {
        ERROR_LOG(
            "The default Vector Core limit %u cannot satisfy the requested limit %u.", resources.defaultLimit,
            kRequestedLimit);
        return -1;
    }
    INFO_LOG("Default Vector Core limit: %u.", resources.defaultLimit);

    CHECK_ERROR(aclrtSetStreamResLimit(resources.stream, kResourceType, kRequestedLimit));
    resources.streamLimitSet = true;
    CHECK_ERROR(aclrtGetStreamResLimit(resources.stream, kResourceType, &configuredLimit));
    if (configuredLimit != kRequestedLimit) {
        ERROR_LOG("Unexpected configured Vector Core limit: got %u, expected %u.", configuredLimit, kRequestedLimit);
        return -1;
    }
    INFO_LOG("Configured Vector Core limit: %u.", configuredLimit);
    return 0;
}

int32_t ExecuteKernel(SampleResources& resources, uint32_t configuredLimit)
{
    CHECK_ERROR(aclrtUseStreamResInCurrentThread(resources.stream));
    resources.streamLimitInUse = true;
    INFO_LOG("Use the Stream resource limit in the current thread.");

    EasyOP(configuredLimit, resources.stream, resources.valueDevice);
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));

    uint32_t outputValue = 0;
    CHECK_ERROR(aclrtMemcpy(
        &outputValue, sizeof(uint32_t), resources.valueDevice, sizeof(uint32_t), ACL_MEMCPY_DEVICE_TO_HOST));
    if (outputValue != kExpectedValue) {
        ERROR_LOG("Unexpected Kernel output: got %u, expected %u.", outputValue, kExpectedValue);
        return -1;
    }
    INFO_LOG("Kernel output: %u (expected: %u).", outputValue, kExpectedValue);
    return 0;
}

int32_t RestoreStreamBudget(SampleResources& resources)
{
    CHECK_ERROR(aclrtUnuseStreamResInCurrentThread(resources.stream));
    resources.streamLimitInUse = false;
    INFO_LOG("Stop using the Stream resource limit in the current thread.");

    CHECK_ERROR(aclrtResetStreamResLimit(resources.stream));
    resources.streamLimitSet = false;
    uint32_t resetLimit = 0;
    CHECK_ERROR(aclrtGetStreamResLimit(resources.stream, kResourceType, &resetLimit));
    if (resetLimit != resources.defaultLimit) {
        ERROR_LOG(
            "Unexpected reset Vector Core limit: got %u, expected default %u.", resetLimit, resources.defaultLimit);
        return -1;
    }
    INFO_LOG("Reset Vector Core limit: %u.", resetLimit);
    return 0;
}

int32_t RunSample(SampleResources& resources)
{
    if (InitializeRuntime(resources) != 0) {
        return -1;
    }
    if (PrepareDeviceMemory(resources) != 0) {
        return -1;
    }
    uint32_t configuredLimit = 0;
    if (ConfigureStreamBudget(resources, configuredLimit) != 0) {
        return -1;
    }
    if (ExecuteKernel(resources, configuredLimit) != 0) {
        return -1;
    }
    if (RestoreStreamBudget(resources) != 0) {
        return -1;
    }
    return 0;
}

void CleanupSample(SampleResources& resources, int32_t& finalResult)
{
    if (resources.streamLimitInUse) {
        UpdateFinalResultOnError(
            "aclrtUnuseStreamResInCurrentThread", aclrtUnuseStreamResInCurrentThread(resources.stream), finalResult);
        resources.streamLimitInUse = false;
    }
    if (resources.streamLimitSet) {
        UpdateFinalResultOnError("aclrtResetStreamResLimit", aclrtResetStreamResLimit(resources.stream), finalResult);
        resources.streamLimitSet = false;
    }
    if ((finalResult == 0) && resources.deviceMemoryAllocated) {
        const aclError ret = aclrtFree(resources.valueDevice);
        UpdateFinalResultOnError("aclrtFree", ret, finalResult);
        resources.deviceMemoryAllocated = false;
        resources.valueDevice = nullptr;
    }
    if (resources.streamCreated) {
        const aclError ret =
            (finalResult == 0) ? aclrtDestroyStream(resources.stream) : aclrtDestroyStreamForce(resources.stream);
        UpdateFinalResultOnError(
            (finalResult == 0) ? "aclrtDestroyStream" : "aclrtDestroyStreamForce", ret, finalResult);
        resources.streamCreated = false;
        resources.stream = nullptr;
    }
    if (resources.deviceMemoryAllocated) {
        UpdateFinalResultOnError("aclrtFree", aclrtFree(resources.valueDevice), finalResult);
        resources.deviceMemoryAllocated = false;
        resources.valueDevice = nullptr;
    }
    if (resources.deviceSet) {
        UpdateFinalResultOnError("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), finalResult);
        resources.deviceSet = false;
    }
    if (resources.aclInitialized) {
        UpdateFinalResultOnError("aclFinalize", aclFinalize(), finalResult);
        resources.aclInitialized = false;
    }
}
} // namespace

int32_t main()
{
    SampleResources resources;
    int32_t finalResult = RunSample(resources);
    CleanupSample(resources, finalResult);
    if (finalResult == 0) {
        INFO_LOG("[SUCCESS] Stream resource budget sample completed successfully.");
    }
    return finalResult;
}
