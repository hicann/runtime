/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prefetch_strategy_comparison.h"

#include <array>
#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "utils.h"

int32_t TransformWorksetDo(
    uint32_t blockDim, void* stream, uint32_t* input, uint32_t* output, uint32_t elementCount, uint32_t scale,
    uint32_t offset);

namespace {
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kBlockDim = 1;
constexpr uint32_t kElementCount = 256;
constexpr uint32_t kScale = 3;
constexpr uint32_t kOffset = 7;
constexpr int32_t kModelTimeoutMs = 5000;
constexpr size_t kStrategyCount = 2;
constexpr size_t kBufferBytes = kElementCount * sizeof(uint32_t);

class PrefetchWorkflow {
public:
    int Run();

private:
    int InitializeRuntime();
    int AllocateBuffers();
    void PrepareInput();
    int ExecuteStrategies();
    bool VerifyResults() const;
    void RecordCleanupFailure(const char* operation, aclError error, int& result) const;
    void ReleaseModel(int& result);
    void ReleaseBuffers(int& result);
    void ShutdownRuntime(int& result);
    void Cleanup(int& result);

    aclrtStream directStream_ = nullptr;
    aclrtStream descriptorStream_ = nullptr;
    aclmdlRI modelRI_ = nullptr;
    std::array<uint32_t*, kStrategyCount> inputDevice_ = {};
    std::array<uint32_t*, kStrategyCount> outputDevice_ = {};
    std::array<uint32_t, kElementCount> inputHost_ = {};
    std::array<std::array<uint32_t, kElementCount>, kStrategyCount> outputHost_ = {};
    void* cmoDescDevice_ = nullptr;
    size_t cmoDescSize_ = 0;
    bool initialized_ = false;
    bool deviceSet_ = false;
    bool streamBound_ = false;
};

int PrefetchWorkflow::InitializeRuntime()
{
    CHECK_ERROR(aclInit(nullptr));
    initialized_ = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    deviceSet_ = true;
    CHECK_ERROR(aclrtCreateStream(&directStream_));
    CHECK_ERROR(aclrtCreateStreamWithConfig(&descriptorStream_, 0U, ACL_STREAM_PERSISTENT));
    return 0;
}

int PrefetchWorkflow::AllocateBuffers()
{
    for (size_t index = 0; index < kStrategyCount; ++index) {
        CHECK_ERROR(
            aclrtMalloc(reinterpret_cast<void**>(&inputDevice_[index]), kBufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
        CHECK_ERROR(
            aclrtMalloc(reinterpret_cast<void**>(&outputDevice_[index]), kBufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    CHECK_ERROR(aclrtCmoGetDescSize(&cmoDescSize_));
    if (cmoDescSize_ == 0) {
        ERROR_LOG("CMO descriptor size must be greater than zero.");
        return -1;
    }
    CHECK_ERROR(aclrtMalloc(&cmoDescDevice_, cmoDescSize_, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtCmoSetDesc(cmoDescDevice_, inputDevice_[1], kBufferBytes));
    return 0;
}

void PrefetchWorkflow::PrepareInput()
{
    for (uint32_t index = 0; index < kElementCount; ++index) {
        inputHost_[index] = index + 1;
        outputHost_[0][index] = 0;
        outputHost_[1][index] = 0;
    }
}

int PrefetchWorkflow::ExecuteStrategies()
{
    for (size_t index = 0; index < kStrategyCount; ++index) {
        CHECK_ERROR(
            aclrtMemcpy(inputDevice_[index], kBufferBytes, inputHost_.data(), kBufferBytes, ACL_MEMCPY_HOST_TO_DEVICE));
    }

    CHECK_ERROR(aclrtCmoAsync(inputDevice_[0], kBufferBytes, ACL_RT_CMO_TYPE_PREFETCH, directStream_));
    int32_t launchResult =
        TransformWorksetDo(kBlockDim, directStream_, inputDevice_[0], outputDevice_[0], kElementCount, kScale, kOffset);
    if (launchResult != ACL_SUCCESS) {
        ERROR_LOG("TransformWorksetDo returned error code %d", launchResult);
        return -1;
    }
    CHECK_ERROR(aclrtSynchronizeStream(directStream_));

    CHECK_ERROR(aclmdlRIBuildBegin(&modelRI_, 0U));
    CHECK_ERROR(aclmdlRIBindStream(modelRI_, descriptorStream_, ACL_MODEL_STREAM_FLAG_HEAD));
    streamBound_ = true;
    CHECK_ERROR(aclrtCmoAsyncWithDesc(cmoDescDevice_, ACL_RT_CMO_TYPE_PREFETCH, descriptorStream_, nullptr));
    launchResult = TransformWorksetDo(
        kBlockDim, descriptorStream_, inputDevice_[1], outputDevice_[1], kElementCount, kScale, kOffset);
    if (launchResult != ACL_SUCCESS) {
        ERROR_LOG("TransformWorksetDo returned error code %d", launchResult);
        return -1;
    }
    CHECK_ERROR(aclmdlRIEndTask(modelRI_, descriptorStream_));
    CHECK_ERROR(aclmdlRIBuildEnd(modelRI_, nullptr));
    CHECK_ERROR(aclmdlRIExecute(modelRI_, kModelTimeoutMs));

    for (size_t index = 0; index < kStrategyCount; ++index) {
        CHECK_ERROR(aclrtMemcpy(
            outputHost_[index].data(), kBufferBytes, outputDevice_[index], kBufferBytes, ACL_MEMCPY_DEVICE_TO_HOST));
    }
    return 0;
}

bool PrefetchWorkflow::VerifyResults() const
{
    for (uint32_t index = 0; index < kElementCount; ++index) {
        const uint32_t expected = inputHost_[index] * kScale + kOffset;
        if (outputHost_[0][index] != expected || outputHost_[1][index] != expected ||
            outputHost_[0][index] != outputHost_[1][index]) {
            ERROR_LOG(
                "Result mismatch at %u: direct=%u, descriptor=%u, expected=%u", index, outputHost_[0][index],
                outputHost_[1][index], expected);
            return false;
        }
    }
    INFO_LOG("Verified %u elements: direct and descriptor prefetch results are identical and correct.", kElementCount);
    return true;
}

void PrefetchWorkflow::RecordCleanupFailure(const char* operation, aclError error, int& result) const
{
    if (error != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d", operation, static_cast<int32_t>(error));
        result = -1;
    }
}

void PrefetchWorkflow::ReleaseModel(int& result)
{
    if (streamBound_) {
        RecordCleanupFailure("aclmdlRIUnbindStream", aclmdlRIUnbindStream(modelRI_, descriptorStream_), result);
    }
    if (modelRI_ != nullptr) {
        RecordCleanupFailure("aclmdlRIDestroy", aclmdlRIDestroy(modelRI_), result);
    }
}

void PrefetchWorkflow::ReleaseBuffers(int& result)
{
    if (cmoDescDevice_ != nullptr) {
        RecordCleanupFailure("aclrtFree(cmoDescDevice)", aclrtFree(cmoDescDevice_), result);
    }
    for (size_t count = kStrategyCount; count > 0; --count) {
        const size_t index = count - 1;
        if (outputDevice_[index] != nullptr) {
            RecordCleanupFailure("aclrtFree(outputDevice)", aclrtFree(outputDevice_[index]), result);
        }
        if (inputDevice_[index] != nullptr) {
            RecordCleanupFailure("aclrtFree(inputDevice)", aclrtFree(inputDevice_[index]), result);
        }
    }
}

void PrefetchWorkflow::ShutdownRuntime(int& result)
{
    if (descriptorStream_ != nullptr) {
        RecordCleanupFailure("aclrtDestroyStream(descriptorStream)", aclrtDestroyStream(descriptorStream_), result);
    }
    if (directStream_ != nullptr) {
        RecordCleanupFailure("aclrtDestroyStream(directStream)", aclrtDestroyStream(directStream_), result);
    }
    if (deviceSet_) {
        RecordCleanupFailure("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
    }
    if (initialized_) {
        RecordCleanupFailure("aclFinalize", aclFinalize(), result);
    }
}

void PrefetchWorkflow::Cleanup(int& result)
{
    if (directStream_ != nullptr) {
        RecordCleanupFailure("aclrtSynchronizeStream", aclrtSynchronizeStream(directStream_), result);
    }
    ReleaseModel(result);
    ReleaseBuffers(result);
    ShutdownRuntime(result);
}

int PrefetchWorkflow::Run()
{
    int result = InitializeRuntime();
    if (result == 0) {
        result = AllocateBuffers();
    }
    if (result == 0) {
        PrepareInput();
        result = ExecuteStrategies();
    }
    if (result == 0 && !VerifyResults()) {
        result = -1;
    }
    Cleanup(result);
    return result;
}
} // namespace

int RunPrefetchStrategyComparison()
{
    PrefetchWorkflow workflow;
    return workflow.Run();
}
