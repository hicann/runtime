/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "model_task_fallback.h"

#include <array>
#include <climits>
#include <cstdint>
#include <cstdlib>
#include <vector>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kElementCount = 8;
constexpr size_t kBufferBytes = kElementCount * sizeof(int32_t);
constexpr int32_t kExecutionTimeoutMs = 5000;
constexpr int32_t kMainBias = 10;
constexpr int32_t kPostScale = 2;
constexpr int32_t kSentinel = -1;
constexpr char kKernelPath[] = "./out/fatbin/model_task_fallback_kernel/model_task_fallback_kernel.o";
using BufferData = std::array<int32_t, kElementCount>;
constexpr BufferData kPrimaryInput = {1, 2, 3, 4, 5, 6, 7, 8};
constexpr BufferData kBackupInput = {21, 22, 23, 24, 25, 26, 27, 28};

struct KernelArgs {
    int32_t* input;
    int32_t* output;
};

struct SelectedTasks {
    aclmdlRITask main = nullptr;
    aclmdlRITask optional = nullptr;
    uint32_t mainSequence = 0;
    uint32_t optionalSequence = 0;
    aclmdlRITaskParams mainParams{};
};

class ModelFallbackWorkflow {
public:
    int Run();

private:
    int Initialize();
    int AllocateAndPrepare();
    int LoadKernels();
    int CaptureModel();
    int Execute(BufferData& main, BufferData& optional);
    int GetTasks(std::vector<aclmdlRITask>& tasks);
    int SelectTasks(SelectedTasks& selected);
    int ApplyFallback(const SelectedTasks& selected);
    int ResetOutputs();
    bool VerifyPath(
        const BufferData& input, const BufferData& main, const BufferData& optional, bool runOptional) const;
    void RecordCleanup(const char* operation, aclError error, int& result) const;
    void Cleanup(int& result);

    aclrtStream stream_ = nullptr;
    aclrtBinHandle binary_ = nullptr;
    aclrtFuncHandle mainFunction_ = nullptr;
    aclrtFuncHandle optionalFunction_ = nullptr;
    aclmdlRI model_ = nullptr;
    int32_t* primaryInput_ = nullptr;
    int32_t* backupInput_ = nullptr;
    int32_t* mainOutput_ = nullptr;
    int32_t* optionalOutput_ = nullptr;
    KernelArgs initialMainArgs_{};
    KernelArgs optionalArgs_{};
    KernelArgs fallbackMainArgs_{};
    bool initialized_ = false;
    bool deviceSet_ = false;
    bool capturing_ = false;
};

int ModelFallbackWorkflow::Initialize()
{
    CHECK_ERROR(aclInit(nullptr));
    initialized_ = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    deviceSet_ = true;
    CHECK_ERROR(aclrtCreateStream(&stream_));
    return 0;
}

int ModelFallbackWorkflow::ResetOutputs()
{
    BufferData sentinel{};
    sentinel.fill(kSentinel);
    CHECK_ERROR(aclrtMemcpy(mainOutput_, kBufferBytes, sentinel.data(), kBufferBytes, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(optionalOutput_, kBufferBytes, sentinel.data(), kBufferBytes, ACL_MEMCPY_HOST_TO_DEVICE));
    return 0;
}

int ModelFallbackWorkflow::AllocateAndPrepare()
{
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&primaryInput_), kBufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&backupInput_), kBufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&mainOutput_), kBufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&optionalOutput_), kBufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(
        aclrtMemcpy(primaryInput_, kBufferBytes, kPrimaryInput.data(), kBufferBytes, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(backupInput_, kBufferBytes, kBackupInput.data(), kBufferBytes, ACL_MEMCPY_HOST_TO_DEVICE));
    return ResetOutputs();
}

int ModelFallbackWorkflow::LoadKernels()
{
    char absolutePath[PATH_MAX] = {};
    if (realpath(kKernelPath, absolutePath) == nullptr) {
        ERROR_LOG("Resolve Kernel path failed: %s", kKernelPath);
        return -1;
    }
    CHECK_ERROR(aclrtBinaryLoadFromFile(absolutePath, nullptr, &binary_));
    CHECK_ERROR(aclrtBinaryGetFunction(binary_, "fallback_main", &mainFunction_));
    CHECK_ERROR(aclrtBinaryGetFunction(binary_, "fallback_postprocess", &optionalFunction_));
    return 0;
}

int ModelFallbackWorkflow::CaptureModel()
{
    initialMainArgs_ = {primaryInput_, mainOutput_};
    optionalArgs_ = {mainOutput_, optionalOutput_};
    CHECK_ERROR(aclmdlRICaptureBegin(stream_, ACL_MODEL_RI_CAPTURE_MODE_RELAXED));
    capturing_ = true;
    CHECK_ERROR(aclrtLaunchKernelWithHostArgs(
        mainFunction_, 1, stream_, nullptr, &initialMainArgs_, sizeof(initialMainArgs_), nullptr, 0));
    CHECK_ERROR(aclrtLaunchKernelWithHostArgs(
        optionalFunction_, 1, stream_, nullptr, &optionalArgs_, sizeof(optionalArgs_), nullptr, 0));
    const aclError error = aclmdlRICaptureEnd(stream_, &model_);
    capturing_ = false;
    if (error != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: aclmdlRICaptureEnd returned error code %d", static_cast<int32_t>(error));
        return -1;
    }
    return 0;
}

int ModelFallbackWorkflow::Execute(BufferData& main, BufferData& optional)
{
    CHECK_ERROR(aclmdlRIExecuteAsync(model_, stream_));
    CHECK_ERROR(aclrtSynchronizeStreamWithTimeout(stream_, kExecutionTimeoutMs));
    CHECK_ERROR(aclrtMemcpy(main.data(), kBufferBytes, mainOutput_, kBufferBytes, ACL_MEMCPY_DEVICE_TO_HOST));
    CHECK_ERROR(aclrtMemcpy(optional.data(), kBufferBytes, optionalOutput_, kBufferBytes, ACL_MEMCPY_DEVICE_TO_HOST));
    return 0;
}

int ModelFallbackWorkflow::GetTasks(std::vector<aclmdlRITask>& tasks)
{
    uint32_t streamCount = 0;
    CHECK_ERROR(aclmdlRIGetStreams(model_, nullptr, &streamCount));
    if (streamCount != 1) {
        ERROR_LOG("Expected one model Stream, but found %u.", streamCount);
        return -1;
    }
    std::vector<aclrtStream> streams(streamCount);
    CHECK_ERROR(aclmdlRIGetStreams(model_, streams.data(), &streamCount));
    uint32_t taskCount = 0;
    CHECK_ERROR(aclmdlRIGetTasksByStream(streams[0], nullptr, &taskCount));
    if (taskCount < 2) {
        ERROR_LOG("Expected at least two model tasks, but found %u.", taskCount);
        return -1;
    }
    tasks.resize(taskCount);
    CHECK_ERROR(aclmdlRIGetTasksByStream(streams[0], tasks.data(), &taskCount));
    tasks.resize(taskCount);
    return 0;
}

int ModelFallbackWorkflow::SelectTasks(SelectedTasks& selected)
{
    std::vector<aclmdlRITask> tasks;
    if (GetTasks(tasks) != 0) {
        return -1;
    }
    uint32_t kernelCount = 0;
    for (aclmdlRITask task : tasks) {
        aclmdlRITaskType type = ACL_MODEL_RI_TASK_DEFAULT;
        CHECK_ERROR(aclmdlRITaskGetType(task, &type));
        if (type != ACL_MODEL_RI_TASK_KERNEL) {
            continue;
        }
        ++kernelCount;
        uint32_t sequence = 0;
        aclmdlRITaskParams params{};
        CHECK_ERROR(aclmdlRITaskGetSeqId(task, &sequence));
        CHECK_ERROR(aclmdlRITaskGetParams(task, &params));
        if (params.kernelTaskParams.funcHandle == mainFunction_) {
            selected.main = task;
            selected.mainSequence = sequence;
            selected.mainParams = params;
        } else if (params.kernelTaskParams.funcHandle == optionalFunction_) {
            selected.optional = task;
            selected.optionalSequence = sequence;
        }
    }
    if (kernelCount != 2 || selected.main == nullptr || selected.optional == nullptr ||
        selected.mainSequence >= selected.optionalSequence) {
        ERROR_LOG("Cannot uniquely identify the ordered main and optional tasks.");
        return -1;
    }
    INFO_LOG(
        "Selected fallback tasks: main_seq=%u, optional_seq=%u.", selected.mainSequence, selected.optionalSequence);
    return 0;
}

int ModelFallbackWorkflow::ApplyFallback(const SelectedTasks& selected)
{
    const aclmdlRIKernelTaskParams& original = selected.mainParams.kernelTaskParams;
    if (selected.mainParams.type != ACL_MODEL_RI_TASK_KERNEL || original.funcHandle != mainFunction_ ||
        original.isHostArgs != 0 || original.argsSize != sizeof(KernelArgs) || original.numBlocks != 1) {
        ERROR_LOG("The main task parameters do not match the captured Kernel launch.");
        return -1;
    }
    fallbackMainArgs_ = {backupInput_, mainOutput_};
    aclmdlRITaskParams updated = selected.mainParams;
    updated.kernelTaskParams.args = &fallbackMainArgs_;
    updated.kernelTaskParams.isHostArgs = 1;
    CHECK_ERROR(aclmdlRITaskSetParams(selected.main, &updated));
    CHECK_ERROR(aclmdlRITaskDisable(selected.optional));
    CHECK_ERROR(aclmdlRIUpdate(model_));
    return 0;
}

bool ModelFallbackWorkflow::VerifyPath(
    const BufferData& input, const BufferData& main, const BufferData& optional, bool runOptional) const
{
    for (size_t i = 0; i < kElementCount; ++i) {
        const int32_t expectedMain = input[i] + kMainBias;
        const int32_t expectedOptional = runOptional ? expectedMain * kPostScale : kSentinel;
        if (main[i] != expectedMain || optional[i] != expectedOptional) {
            ERROR_LOG("Path mismatch at %zu: main=%d, optional=%d.", i, main[i], optional[i]);
            return false;
        }
    }
    INFO_LOG(
        "%s path verified: main_first=%d, optional_first=%d.", runOptional ? "Baseline" : "Fallback", main[0],
        optional[0]);
    return true;
}

void ModelFallbackWorkflow::RecordCleanup(const char* operation, aclError error, int& result) const
{
    if (error != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d", operation, static_cast<int32_t>(error));
        result = -1;
    }
}

void ModelFallbackWorkflow::Cleanup(int& result)
{
    if (capturing_) {
        RecordCleanup("aclmdlRICaptureEnd", aclmdlRICaptureEnd(stream_, &model_), result);
    }
    if (model_ != nullptr) {
        RecordCleanup("aclmdlRIDestroy", aclmdlRIDestroy(model_), result);
    }
    if (binary_ != nullptr) {
        RecordCleanup("aclrtBinaryUnLoad", aclrtBinaryUnLoad(binary_), result);
    }
    for (void* buffer : {optionalOutput_, mainOutput_, backupInput_, primaryInput_}) {
        if (buffer != nullptr) {
            RecordCleanup("aclrtFree", aclrtFree(buffer), result);
        }
    }
    if (stream_ != nullptr) {
        RecordCleanup("aclrtDestroyStream", aclrtDestroyStream(stream_), result);
    }
    if (deviceSet_) {
        RecordCleanup("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
    }
    if (initialized_) {
        RecordCleanup("aclFinalize", aclFinalize(), result);
    }
}

int ModelFallbackWorkflow::Run()
{
    BufferData main{};
    BufferData optional{};
    SelectedTasks selected;
    const bool success = Initialize() == 0 && AllocateAndPrepare() == 0 && LoadKernels() == 0 && CaptureModel() == 0 &&
                         Execute(main, optional) == 0 && VerifyPath(kPrimaryInput, main, optional, true) &&
                         ResetOutputs() == 0 && SelectTasks(selected) == 0 && ApplyFallback(selected) == 0 &&
                         Execute(main, optional) == 0 && VerifyPath(kBackupInput, main, optional, false);
    int result = success ? 0 : -1;
    Cleanup(result);
    return result;
}
} // namespace

int RunModelTaskFallbackSample()
{
    ModelFallbackWorkflow workflow;
    return workflow.Run();
}
