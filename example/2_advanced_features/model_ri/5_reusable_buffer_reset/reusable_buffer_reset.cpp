/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "reusable_buffer_reset.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kBufferSize = 4096U;
constexpr int32_t kInitialValue = 0xA5;

struct RuntimeResources {
    bool aclInitialized = false;
    bool captureActive = false;
    bool streamPending = false;
    aclrtContext context = nullptr;
    aclrtStream stream = nullptr;
    aclmdlRI model = nullptr;
    void* deviceBuffer = nullptr;
};

void RecordCleanupResult(const char* operation, aclError ret, int& result)
{
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d", operation, static_cast<int32_t>(ret));
        result = -1;
    }
}

int InitializeRuntime(RuntimeResources& resources)
{
    CHECK_ERROR(aclInit(nullptr));
    resources.aclInitialized = true;
    uint32_t deviceCount = 0;
    CHECK_ERROR(aclrtGetDeviceCount(&deviceCount));
    if (deviceCount == 0U) {
        ERROR_LOG("No Device is available for the buffer reset workload.");
        return -1;
    }
    CHECK_ERROR(aclrtCreateContext(&resources.context, kDeviceId));
    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    CHECK_ERROR(aclrtMalloc(&resources.deviceBuffer, kBufferSize, ACL_MEM_MALLOC_HUGE_FIRST));
    return 0;
}

int PrepareBuffer(RuntimeResources& resources)
{
    CHECK_ERROR(aclrtMemsetAsync(resources.deviceBuffer, kBufferSize, kInitialValue, kBufferSize, resources.stream));
    resources.streamPending = true;
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
    resources.streamPending = false;

    std::vector<uint8_t> actual(kBufferSize, 0U);
    CHECK_ERROR(
        aclrtMemcpy(actual.data(), actual.size(), resources.deviceBuffer, kBufferSize, ACL_MEMCPY_DEVICE_TO_HOST));
    if (!std::all_of(actual.begin(), actual.end(), [](uint8_t value) { return value == kInitialValue; })) {
        ERROR_LOG("Failed to prepare the reusable buffer with non-zero data.");
        return -1;
    }
    INFO_LOG("Prepared %zu-byte reusable buffer with pattern 0x%X.", kBufferSize, kInitialValue);
    return 0;
}

int CaptureReset(RuntimeResources& resources)
{
    CHECK_ERROR(aclmdlRICaptureBegin(resources.stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL));
    resources.captureActive = true;
    const aclError resetRet = aclrtMemsetAsync(resources.deviceBuffer, kBufferSize, 0, kBufferSize, resources.stream);
    const aclError endRet = aclmdlRICaptureEnd(resources.stream, &resources.model);
    if (endRet == ACL_SUCCESS) {
        resources.captureActive = false;
    }
    if (resetRet != ACL_SUCCESS) {
        ERROR_LOG("Capture failed: aclrtMemsetAsync returned error code %d", static_cast<int32_t>(resetRet));
    }
    if (endRet != ACL_SUCCESS) {
        ERROR_LOG("Capture failed: aclmdlRICaptureEnd returned error code %d", static_cast<int32_t>(endRet));
    }
    return (resetRet == ACL_SUCCESS && endRet == ACL_SUCCESS) ? 0 : -1;
}

int InspectModel(aclmdlRI model)
{
    uint32_t streamCount = 0;
    CHECK_ERROR(aclmdlRIGetStreams(model, nullptr, &streamCount));
    if (streamCount == 0U) {
        ERROR_LOG("The captured Model RI contains no Stream.");
        return -1;
    }
    std::vector<aclrtStream> streams(streamCount, nullptr);
    uint32_t listedStreams = streamCount;
    CHECK_ERROR(aclmdlRIGetStreams(model, streams.data(), &listedStreams));
    if (listedStreams != streamCount ||
        std::any_of(streams.begin(), streams.end(), [](aclrtStream stream) { return stream == nullptr; })) {
        ERROR_LOG("The Model RI Stream manifest is inconsistent.");
        return -1;
    }

    uint64_t totalTaskCount = 0U;
    for (aclrtStream stream : streams) {
        uint32_t taskCount = 0;
        CHECK_ERROR(aclmdlRIGetTasksByStream(stream, nullptr, &taskCount));
        std::vector<aclmdlRITask> tasks(taskCount, nullptr);
        uint32_t listedTasks = taskCount;
        if (taskCount > 0U) {
            CHECK_ERROR(aclmdlRIGetTasksByStream(stream, tasks.data(), &listedTasks));
        }
        if (listedTasks != taskCount ||
            std::any_of(tasks.begin(), tasks.end(), [](aclmdlRITask task) { return task == nullptr; })) {
            ERROR_LOG("A Model RI Task manifest is inconsistent.");
            return -1;
        }
        totalTaskCount += listedTasks;
    }
    if (totalTaskCount == 0U) {
        ERROR_LOG("The captured Model RI contains no Task, so execution is blocked.");
        return -1;
    }
    INFO_LOG(
        "Model RI manifest: streams=%u, tasks=%llu.", streamCount, static_cast<unsigned long long>(totalTaskCount));
    return 0;
}

int ExecuteAndVerify(RuntimeResources& resources)
{
    CHECK_ERROR(aclmdlRIExecuteAsync(resources.model, resources.stream));
    resources.streamPending = true;
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
    resources.streamPending = false;

    std::vector<uint8_t> actual(kBufferSize, kInitialValue);
    CHECK_ERROR(
        aclrtMemcpy(actual.data(), actual.size(), resources.deviceBuffer, kBufferSize, ACL_MEMCPY_DEVICE_TO_HOST));
    if (!std::all_of(actual.begin(), actual.end(), [](uint8_t value) { return value == 0U; })) {
        ERROR_LOG("The reusable buffer was not completely reset to zero.");
        return -1;
    }
    INFO_LOG("Verified %zu-byte reusable buffer reset to zero.", kBufferSize);
    return 0;
}

int CleanupRuntime(RuntimeResources& resources)
{
    int result = 0;
    if (resources.streamPending && resources.stream != nullptr) {
        RecordCleanupResult("aclrtSynchronizeStream", aclrtSynchronizeStream(resources.stream), result);
        resources.streamPending = false;
    }
    if (resources.captureActive && resources.stream != nullptr) {
        aclmdlRI abandonedModel = nullptr;
        RecordCleanupResult("aclmdlRICaptureEnd", aclmdlRICaptureEnd(resources.stream, &abandonedModel), result);
        if (abandonedModel != nullptr) {
            if (abandonedModel == resources.model) {
                resources.model = nullptr;
            }
            RecordCleanupResult("aclmdlRIDestroy(abandoned)", aclmdlRIDestroy(abandonedModel), result);
        }
        resources.captureActive = false;
    }
    if (resources.model != nullptr) {
        RecordCleanupResult("aclmdlRIDestroy", aclmdlRIDestroy(resources.model), result);
        resources.model = nullptr;
    }
    if (resources.deviceBuffer != nullptr) {
        RecordCleanupResult("aclrtFree", aclrtFree(resources.deviceBuffer), result);
        resources.deviceBuffer = nullptr;
    }
    if (resources.stream != nullptr) {
        RecordCleanupResult("aclrtDestroyStream", aclrtDestroyStream(resources.stream), result);
        resources.stream = nullptr;
    }
    if (resources.context != nullptr) {
        RecordCleanupResult("aclrtDestroyContext", aclrtDestroyContext(resources.context), result);
        resources.context = nullptr;
    }
    if (resources.aclInitialized) {
        RecordCleanupResult("aclFinalize", aclFinalize(), result);
        resources.aclInitialized = false;
    }
    return result;
}
} // namespace

int RunReusableBufferReset()
{
    RuntimeResources resources;
    int result = InitializeRuntime(resources);
    if (result == 0) {
        result = PrepareBuffer(resources);
    }
    if (result == 0) {
        result = CaptureReset(resources);
    }
    if (result == 0) {
        result = InspectModel(resources.model);
    }
    if (result == 0) {
        result = ExecuteAndVerify(resources);
    }
    const int cleanupResult = CleanupRuntime(resources);
    return (result == 0 && cleanupResult == 0) ? 0 : -1;
}
