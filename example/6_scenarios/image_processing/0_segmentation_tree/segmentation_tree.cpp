/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "segmentation_tree.h"

#include <array>
#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kPixelCount = 64;
constexpr size_t kBufferBytes = kPixelCount * sizeof(uint8_t);
constexpr char kKernelPath[] = "./out/fatbin/segmentation_tree_kernel/segmentation_tree_kernel.o";

struct RuntimeResources {
    aclrtStream stream = nullptr;
    aclrtBinHandle binary = nullptr;
    size_t freeMemory = 0;
    size_t totalMemory = 0;
    bool initialized = false;
    bool deviceSet = false;
    bool streamCreated = false;
    bool binaryLoaded = false;
};

struct Buffers {
    uint8_t* pixelsHost = nullptr;
    uint8_t* fineHost = nullptr;
    uint8_t* coarseHost = nullptr;
    uint8_t* pixelsDevice = nullptr;
    uint8_t* fineDevice = nullptr;
    uint8_t* coarseDevice = nullptr;
};

void RecordCleanupError(const char* operation, aclError ret, int& result)
{
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d", operation, static_cast<int32_t>(ret));
        result = -1;
    }
}

int InitializeRuntime(RuntimeResources* runtime)
{
    CHECK_ERROR(aclInit(nullptr));
    runtime->initialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    runtime->deviceSet = true;
    CHECK_ERROR(aclrtGetMemInfo(ACL_HBM_MEM, &runtime->freeMemory, &runtime->totalMemory));
    constexpr size_t kRequiredMemory = 3 * kBufferBytes;
    if (runtime->totalMemory == 0 || runtime->freeMemory > runtime->totalMemory ||
        runtime->freeMemory < kRequiredMemory) {
        ERROR_LOG(
            "Segmentation admission failed: required=%zu, free=%zu, total=%zu bytes", kRequiredMemory,
            runtime->freeMemory, runtime->totalMemory);
        return -1;
    }
    INFO_LOG("Memory admission passed: required=%zu bytes, free=%zu bytes.", kRequiredMemory, runtime->freeMemory);
    CHECK_ERROR(aclrtCreateStream(&runtime->stream));
    runtime->streamCreated = true;
    return 0;
}

int AllocateBuffers(Buffers* buffers)
{
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&buffers->pixelsHost), kBufferBytes));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&buffers->fineHost), kBufferBytes));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&buffers->coarseHost), kBufferBytes));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&buffers->pixelsDevice), kBufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&buffers->fineDevice), kBufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&buffers->coarseDevice), kBufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    return 0;
}

void PrepareImage(const Buffers& buffers)
{
    for (size_t index = 0; index < kPixelCount; ++index) {
        buffers.pixelsHost[index] = static_cast<uint8_t>(index * 4);
    }
}

int BuildKernel(
    RuntimeResources* runtime, const Buffers& buffers, aclrtFuncHandle* function, aclrtArgsHandle* arguments)
{
    CHECK_ERROR(aclrtBinaryLoadFromFile(kKernelPath, nullptr, &runtime->binary));
    runtime->binaryLoaded = true;
    CHECK_ERROR(aclrtBinaryGetFunction(runtime->binary, "segmentation_tree", function));
    CHECK_ERROR(aclrtKernelArgsInit(*function, arguments));
    const std::array<void*, 3> values = {buffers.pixelsDevice, buffers.fineDevice, buffers.coarseDevice};
    for (void* value : values) {
        aclrtParamHandle parameter = nullptr;
        CHECK_ERROR(aclrtKernelArgsAppend(*arguments, &value, sizeof(uintptr_t), &parameter));
    }
    CHECK_ERROR(aclrtKernelArgsFinalize(*arguments));
    return 0;
}

int ExecuteSegmentation(
    const RuntimeResources& runtime, const Buffers& buffers, aclrtFuncHandle function, aclrtArgsHandle arguments)
{
    CHECK_ERROR(aclrtMemcpyAsync(
        buffers.pixelsDevice, kBufferBytes, buffers.pixelsHost, kBufferBytes, ACL_MEMCPY_HOST_TO_DEVICE,
        runtime.stream));
    CHECK_ERROR(aclrtLaunchKernelWithConfig(function, 1, runtime.stream, nullptr, arguments, nullptr));
    CHECK_ERROR(aclrtMemcpyAsync(
        buffers.fineHost, kBufferBytes, buffers.fineDevice, kBufferBytes, ACL_MEMCPY_DEVICE_TO_HOST, runtime.stream));
    CHECK_ERROR(aclrtMemcpyAsync(
        buffers.coarseHost, kBufferBytes, buffers.coarseDevice, kBufferBytes, ACL_MEMCPY_DEVICE_TO_HOST,
        runtime.stream));
    CHECK_ERROR(aclrtSynchronizeStream(runtime.stream));
    return 0;
}

bool VerifySegmentation(const Buffers& buffers)
{
    std::array<size_t, 4> fineCounts{};
    std::array<size_t, 2> coarseCounts{};
    for (size_t index = 0; index < kPixelCount; ++index) {
        const uint8_t expectedFine = static_cast<uint8_t>(index / 16);
        const uint8_t expectedCoarse = static_cast<uint8_t>(expectedFine / 2);
        if (buffers.fineHost[index] != expectedFine || buffers.coarseHost[index] != expectedCoarse ||
            buffers.coarseHost[index] != buffers.fineHost[index] / 2) {
            ERROR_LOG(
                "Segmentation mismatch at pixel %zu: fine=%u, coarse=%u", index,
                static_cast<unsigned int>(buffers.fineHost[index]),
                static_cast<unsigned int>(buffers.coarseHost[index]));
            return false;
        }
        ++fineCounts[buffers.fineHost[index]];
        ++coarseCounts[buffers.coarseHost[index]];
    }
    INFO_LOG(
        "Segmentation verified: fine counts=[%zu,%zu,%zu,%zu], coarse counts=[%zu,%zu].", fineCounts[0], fineCounts[1],
        fineCounts[2], fineCounts[3], coarseCounts[0], coarseCounts[1]);
    return fineCounts == std::array<size_t, 4>{16, 16, 16, 16} && coarseCounts == std::array<size_t, 2>{32, 32};
}

void ReleaseBuffers(Buffers& buffers, int& result)
{
    if (buffers.coarseDevice != nullptr) {
        RecordCleanupError("aclrtFree(coarseDevice)", aclrtFree(buffers.coarseDevice), result);
    }
    if (buffers.fineDevice != nullptr) {
        RecordCleanupError("aclrtFree(fineDevice)", aclrtFree(buffers.fineDevice), result);
    }
    if (buffers.pixelsDevice != nullptr) {
        RecordCleanupError("aclrtFree(pixelsDevice)", aclrtFree(buffers.pixelsDevice), result);
    }
    if (buffers.coarseHost != nullptr) {
        RecordCleanupError("aclrtFreeHost(coarseHost)", aclrtFreeHost(buffers.coarseHost), result);
    }
    if (buffers.fineHost != nullptr) {
        RecordCleanupError("aclrtFreeHost(fineHost)", aclrtFreeHost(buffers.fineHost), result);
    }
    if (buffers.pixelsHost != nullptr) {
        RecordCleanupError("aclrtFreeHost(pixelsHost)", aclrtFreeHost(buffers.pixelsHost), result);
    }
}

void Cleanup(RuntimeResources& runtime, Buffers& buffers, int& result)
{
    if (runtime.streamCreated) {
        RecordCleanupError("aclrtSynchronizeStream", aclrtSynchronizeStream(runtime.stream), result);
    }
    if (runtime.binaryLoaded) {
        RecordCleanupError("aclrtBinaryUnLoad", aclrtBinaryUnLoad(runtime.binary), result);
    }
    ReleaseBuffers(buffers, result);
    if (runtime.streamCreated) {
        RecordCleanupError("aclrtDestroyStream", aclrtDestroyStream(runtime.stream), result);
    }
    if (runtime.deviceSet) {
        RecordCleanupError("aclrtResetDevice", aclrtResetDevice(kDeviceId), result);
    }
    if (runtime.initialized) {
        RecordCleanupError("aclFinalize", aclFinalize(), result);
    }
}
} // namespace

int RunSegmentationTreeSample()
{
    RuntimeResources runtime;
    Buffers buffers;
    aclrtFuncHandle function = nullptr;
    aclrtArgsHandle arguments = nullptr;
    int result = [&]() -> int {
        if (InitializeRuntime(&runtime) != 0 || AllocateBuffers(&buffers) != 0) {
            return -1;
        }
        PrepareImage(buffers);
        if (BuildKernel(&runtime, buffers, &function, &arguments) != 0 ||
            ExecuteSegmentation(runtime, buffers, function, arguments) != 0) {
            return -1;
        }
        return VerifySegmentation(buffers) ? 0 : -1;
    }();
    Cleanup(runtime, buffers, result);
    return result;
}
