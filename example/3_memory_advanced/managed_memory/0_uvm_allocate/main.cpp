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
 * This example leverages the Unified Virtual Memory (UVM) mechanism to allocate memory
 * for kernel inputs and outputs via UVM allocation APIs, thereby eliminating the need
 * for explicit data transfers during parameter passing and result write-back.
 */

#include <cstddef>
#include <cstdint>
#include <string>
#include "acl/acl.h"
#include "utils.h"
#include "kernel_utils.h"

namespace {
struct KernelBuffers {
    uint8_t* xPtr = nullptr;
    uint8_t* yPtr = nullptr;
    uint8_t* zPtr = nullptr;
};

struct RuntimeResources {
    int32_t deviceId = 0;
    aclrtStream stream = nullptr;
    aclrtBinHandle binHandle = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool streamCreated = false;
    bool binLoaded = false;
};

void UpdateFinalResultOnError(const char* apiName, aclError ret, int32_t& finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}

int32_t InitializeRuntime(RuntimeResources* runtime)
{
    // Initialize ACL and create a stream on device 0.
    CHECK_ERROR(aclInit(nullptr));
    runtime->aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(runtime->deviceId));
    runtime->deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&runtime->stream));
    runtime->streamCreated = true;
    return 0;
}

int32_t AllocateKernelBuffers(size_t inputByteSize, size_t outputByteSize, KernelBuffers* buffers)
{
    // Allocate uvm memory for kernel inputs and output.
    CHECK_ERROR(
        aclrtMemAllocManaged(reinterpret_cast<void**>(&buffers->xPtr), inputByteSize, ACL_RT_MEM_ATTACH_GLOBAL));
    CHECK_ERROR(
        aclrtMemAllocManaged(reinterpret_cast<void**>(&buffers->yPtr), inputByteSize, ACL_RT_MEM_ATTACH_GLOBAL));
    CHECK_ERROR(
        aclrtMemAllocManaged(reinterpret_cast<void**>(&buffers->zPtr), outputByteSize, ACL_RT_MEM_ATTACH_GLOBAL));
    return 0;
}

int32_t PrepareInputData(size_t inputByteSize, const KernelBuffers& buffers)
{
    // Load generated input files.
    size_t xFileSize = inputByteSize;
    if (!kernel::ReadFile("./input/input_x.bin", xFileSize, buffers.xPtr, inputByteSize) ||
        xFileSize != inputByteSize) {
        ERROR_LOG("Read input_x.bin failed or file size is invalid.");
        return -1;
    }
    size_t yFileSize = inputByteSize;
    if (!kernel::ReadFile("./input/input_y.bin", yFileSize, buffers.yPtr, inputByteSize) ||
        yFileSize != inputByteSize) {
        ERROR_LOG("Read input_y.bin failed or file size is invalid.");
        return -1;
    }

    return 0;
}

int32_t AppendCommonKernelArgs(aclrtArgsHandle argsHandle, uint8_t* xPtr, uint8_t* yPtr, uint8_t* zPtr)
{
    aclrtParamHandle paramHandle1 = nullptr;
    aclrtParamHandle paramHandle2 = nullptr;
    aclrtParamHandle paramHandle3 = nullptr;
    CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, reinterpret_cast<void**>(&xPtr), sizeof(uintptr_t), &paramHandle1));
    CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, reinterpret_cast<void**>(&yPtr), sizeof(uintptr_t), &paramHandle2));
    CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, reinterpret_cast<void**>(&zPtr), sizeof(uintptr_t), &paramHandle3));
    return 0;
}

int32_t BuildKernelArgs(
    uint8_t* xPtr, uint8_t* yPtr, uint8_t* zPtr, RuntimeResources* runtime, aclrtFuncHandle* funcHandle,
    aclrtArgsHandle* argsHandle)
{
    // Load the selected kernel binary and build the launch argument list.
    const char* filePath = "./out/fatbin/ascendc_kernels_simple/ascendc_kernels_simple.o";

    CHECK_ERROR(aclrtBinaryLoadFromFile(filePath, nullptr, &runtime->binHandle));
    runtime->binLoaded = true;
    CHECK_ERROR(aclrtBinaryGetFunction(runtime->binHandle, "add_custom", funcHandle));
    CHECK_ERROR(aclrtKernelArgsInit(*funcHandle, argsHandle));

    if (AppendCommonKernelArgs(*argsHandle, xPtr, yPtr, zPtr) != 0) {
        return -1;
    }

    CHECK_ERROR(aclrtKernelArgsFinalize(*argsHandle));
    return 0;
}

int32_t LaunchKernelAndWriteOutput(
    aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle, uint32_t blockDim, aclrtStream stream, uint8_t* zPtr,
    size_t outputByteSize)
{
    // Launch the kernel, synchronize the stream, and write output for verification.
    CHECK_ERROR(aclrtLaunchKernelWithConfig(funcHandle, blockDim, stream, nullptr, argsHandle, nullptr));
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    if (!kernel::WriteFile("./output/output_z.bin", zPtr, outputByteSize)) {
        ERROR_LOG("Write output_z.bin failed.");
        return -1;
    }
    return 0;
}

void ReleaseKernelResources(RuntimeResources& runtime, KernelBuffers& buffers, int32_t& finalResult)
{
    if (runtime.binLoaded) {
        UpdateFinalResultOnError(
            "aclrtBinaryUnLoad(runtime.binHandle)", aclrtBinaryUnLoad(runtime.binHandle), finalResult);
    }
    if (buffers.zPtr != nullptr) {
        UpdateFinalResultOnError("aclrtFree(buffers.zPtr)", aclrtFree(buffers.zPtr), finalResult);
    }
    if (buffers.yPtr != nullptr) {
        UpdateFinalResultOnError("aclrtFree(buffers.yPtr)", aclrtFree(buffers.yPtr), finalResult);
    }
    if (buffers.xPtr != nullptr) {
        UpdateFinalResultOnError("aclrtFree(buffers.xPtr)", aclrtFree(buffers.xPtr), finalResult);
    }
    if (runtime.streamCreated) {
        UpdateFinalResultOnError(
            "aclrtDestroyStreamForce(runtime.stream)", aclrtDestroyStreamForce(runtime.stream), finalResult);
    }
    if (runtime.deviceSet) {
        UpdateFinalResultOnError(
            "aclrtResetDeviceForce(runtime.deviceId)", aclrtResetDeviceForce(runtime.deviceId), finalResult);
    }
    if (runtime.aclInitialized) {
        UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
}

int32_t RunKernelLaunchSample()
{
    const uint32_t blockDim = 8;
    const size_t inputByteSize = 8 * 2048 * sizeof(uint16_t);
    const size_t outputByteSize = 8 * 2048 * sizeof(uint16_t);
    const int32_t deviceId = 0;

    aclrtFuncHandle funcHandle = nullptr;
    aclrtArgsHandle argsHandle = nullptr;
    RuntimeResources runtime;
    runtime.deviceId = deviceId;
    KernelBuffers buffers;

    const int32_t result = [&]() -> int32_t {
        if (InitializeRuntime(&runtime) != 0) {
            return -1;
        }
        if (AllocateKernelBuffers(inputByteSize, outputByteSize, &buffers) != 0) {
            return -1;
        }
        if (PrepareInputData(inputByteSize, buffers) != 0) {
            return -1;
        }
        if (BuildKernelArgs(buffers.xPtr, buffers.yPtr, buffers.zPtr, &runtime, &funcHandle, &argsHandle) != 0) {
            return -1;
        }
        if (LaunchKernelAndWriteOutput(
                funcHandle, argsHandle, blockDim, runtime.stream, buffers.zPtr, outputByteSize) != 0) {
            return -1;
        }
        return 0;
    }();

    int32_t finalResult = result;
    ReleaseKernelResources(runtime, buffers, finalResult);
    if (finalResult == 0) {
        INFO_LOG("Run the uvm_allocate sample successfully.");
    }
    return finalResult;
}
} // namespace

int32_t main(int32_t argc, char* argv[]) { return RunKernelLaunchSample(); }
