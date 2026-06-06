/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/*
 * This sample demonstrates kernel loading and execution.
 * When the mode is 'simple', all kernel inputs are regular pointer-type arguments,
 * requiring users to manually copy input data to the device.
 * When the mode is 'placeholder', the kernel inputs include placeholder-type arguments;
 * for these arguments, the device address does not need to be specified when adding arguments,
 * and input arguments are automatically transferred to the device during kernel launch.
 */

#include <cstddef>
#include <cstdint>
#include <string>
#include "acl/acl.h"
#include "utils.h"
#include "kernel_utils.h"

namespace {
struct KernelBuffers {
    uint8_t *xHost = nullptr;
    uint8_t *yHost = nullptr;
    uint8_t *zHost = nullptr;
    uint8_t *xDevice = nullptr;
    uint8_t *yDevice = nullptr;
    uint8_t *zDevice = nullptr;
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

void UpdateFinalResultOnError(const char *apiName, aclError ret, int32_t &finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}

int32_t InitializeRuntime(RuntimeResources *runtime)
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

int32_t AllocateKernelBuffers(size_t inputByteSize, size_t outputByteSize, KernelBuffers *buffers)
{
    // Allocate host and device buffers for kernel inputs and output.
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void **>(&buffers->xHost), inputByteSize));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void **>(&buffers->yHost), inputByteSize));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void **>(&buffers->zHost), outputByteSize));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void **>(&buffers->xDevice), inputByteSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void **>(&buffers->yDevice), inputByteSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void **>(&buffers->zDevice), outputByteSize, ACL_MEM_MALLOC_HUGE_FIRST));
    return 0;
}

int32_t PrepareInputData(size_t inputByteSize, const KernelBuffers &buffers)
{
    // Load generated input files and copy them to device memory.
    size_t xFileSize = inputByteSize;
    if (!kernel::ReadFile("./input/input_x.bin", xFileSize, buffers.xHost, inputByteSize) ||
        xFileSize != inputByteSize) {
        ERROR_LOG("Read input_x.bin failed or file size is invalid.");
        return -1;
    }
    size_t yFileSize = inputByteSize;
    if (!kernel::ReadFile("./input/input_y.bin", yFileSize, buffers.yHost, inputByteSize) ||
        yFileSize != inputByteSize) {
        ERROR_LOG("Read input_y.bin failed or file size is invalid.");
        return -1;
    }

    CHECK_ERROR(aclrtMemcpy(buffers.xDevice, inputByteSize, buffers.xHost, inputByteSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(buffers.yDevice, inputByteSize, buffers.yHost, inputByteSize, ACL_MEMCPY_HOST_TO_DEVICE));
    return 0;
}

int32_t AppendCommonKernelArgs(aclrtArgsHandle argsHandle, uint8_t *xDevice, uint8_t *yDevice, uint8_t *zDevice)
{
    aclrtParamHandle paramHandle1 = nullptr;
    aclrtParamHandle paramHandle2 = nullptr;
    aclrtParamHandle paramHandle3 = nullptr;
    CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, reinterpret_cast<void **>(&xDevice), sizeof(uintptr_t), &paramHandle1));
    CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, reinterpret_cast<void **>(&yDevice), sizeof(uintptr_t), &paramHandle2));
    CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, reinterpret_cast<void **>(&zDevice), sizeof(uintptr_t), &paramHandle3));
    return 0;
}

int32_t ConfigurePlaceholderArgs(aclrtArgsHandle argsHandle)
{
    constexpr int32_t TOTAL_LENGTH = 8 * 2048;
    constexpr int32_t TILE_NUM = 8;

    int32_t *lengthHost = nullptr;
    int32_t *numHost = nullptr;
    aclrtParamHandle paramHandle4 = nullptr;
    aclrtParamHandle paramHandle5 = nullptr;

    CHECK_ERROR(aclrtKernelArgsAppendPlaceHolder(argsHandle, &paramHandle4));
    CHECK_ERROR(aclrtKernelArgsAppendPlaceHolder(argsHandle, &paramHandle5));
    CHECK_ERROR(aclrtKernelArgsGetPlaceHolderBuffer(
        argsHandle, paramHandle4, sizeof(TOTAL_LENGTH), reinterpret_cast<void **>(&lengthHost)));
    CHECK_ERROR(aclrtKernelArgsGetPlaceHolderBuffer(
        argsHandle, paramHandle5, sizeof(TILE_NUM), reinterpret_cast<void **>(&numHost)));

    *lengthHost = TOTAL_LENGTH;
    *numHost = TILE_NUM;
    return 0;
}

int32_t BuildKernelArgs(
    const std::string &mode,
    uint8_t *xDevice,
    uint8_t *yDevice,
    uint8_t *zDevice,
    RuntimeResources *runtime,
    aclrtFuncHandle *funcHandle,
    aclrtArgsHandle *argsHandle)
{
    // Load the selected kernel binary and build the launch argument list.
    const bool isPlaceholder = (mode == "placeholder");
    const char *filePath = isPlaceholder
        ? "./out/fatbin/ascendc_kernels_placeholder/ascendc_kernels_placeholder.o"
        : "./out/fatbin/ascendc_kernels_simple/ascendc_kernels_simple.o";

    CHECK_ERROR(aclrtBinaryLoadFromFile(filePath, nullptr, &runtime->binHandle));
    runtime->binLoaded = true;
    CHECK_ERROR(aclrtBinaryGetFunction(runtime->binHandle, "add_custom", funcHandle));
    CHECK_ERROR(aclrtKernelArgsInit(*funcHandle, argsHandle));

    if (AppendCommonKernelArgs(*argsHandle, xDevice, yDevice, zDevice) != 0) {
        return -1;
    }
    if (isPlaceholder && ConfigurePlaceholderArgs(*argsHandle) != 0) {
        return -1;
    }

    CHECK_ERROR(aclrtKernelArgsFinalize(*argsHandle));
    return 0;
}

int32_t LaunchKernelAndWriteOutput(
    aclrtFuncHandle funcHandle,
    aclrtArgsHandle argsHandle,
    uint32_t blockDim,
    aclrtStream stream,
    uint8_t *zDevice,
    uint8_t *zHost,
    size_t outputByteSize)
{
    // Launch the kernel, synchronize the stream, and write output for verification.
    CHECK_ERROR(aclrtLaunchKernelWithConfig(funcHandle, blockDim, stream, nullptr, argsHandle, nullptr));
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtMemcpy(zHost, outputByteSize, zDevice, outputByteSize, ACL_MEMCPY_DEVICE_TO_HOST));
    if (!kernel::WriteFile("./output/output_z.bin", zHost, outputByteSize)) {
        ERROR_LOG("Write output_z.bin failed.");
        return -1;
    }
    return 0;
}

void ReleaseKernelResources(RuntimeResources &runtime, KernelBuffers &buffers, int32_t &finalResult)
{
    if (runtime.binLoaded) {
        UpdateFinalResultOnError(
            "aclrtBinaryUnLoad(runtime.binHandle)", aclrtBinaryUnLoad(runtime.binHandle), finalResult);
    }
    if (buffers.zDevice != nullptr) {
        UpdateFinalResultOnError("aclrtFree(buffers.zDevice)", aclrtFree(buffers.zDevice), finalResult);
    }
    if (buffers.yDevice != nullptr) {
        UpdateFinalResultOnError("aclrtFree(buffers.yDevice)", aclrtFree(buffers.yDevice), finalResult);
    }
    if (buffers.xDevice != nullptr) {
        UpdateFinalResultOnError("aclrtFree(buffers.xDevice)", aclrtFree(buffers.xDevice), finalResult);
    }
    if (buffers.zHost != nullptr) {
        UpdateFinalResultOnError("aclrtFreeHost(buffers.zHost)", aclrtFreeHost(buffers.zHost), finalResult);
    }
    if (buffers.yHost != nullptr) {
        UpdateFinalResultOnError("aclrtFreeHost(buffers.yHost)", aclrtFreeHost(buffers.yHost), finalResult);
    }
    if (buffers.xHost != nullptr) {
        UpdateFinalResultOnError("aclrtFreeHost(buffers.xHost)", aclrtFreeHost(buffers.xHost), finalResult);
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

int32_t RunKernelLaunchSample(const std::string &mode)
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
        if (BuildKernelArgs(
            mode, buffers.xDevice, buffers.yDevice, buffers.zDevice, &runtime, &funcHandle, &argsHandle) != 0) {
            return -1;
        }
        if (LaunchKernelAndWriteOutput(
            funcHandle, argsHandle, blockDim, runtime.stream, buffers.zDevice, buffers.zHost, outputByteSize) != 0) {
            return -1;
        }
        INFO_LOG("Kernel launch sample runs in %s mode.", mode.c_str());
        return 0;
    }();

    int32_t finalResult = result;
    ReleaseKernelResources(runtime, buffers, finalResult);
    if (finalResult == 0) {
        INFO_LOG("Run the launch_kernel sample successfully.");
    }
    return finalResult;
}
} // namespace

int32_t main(int32_t argc, char *argv[])
{
    const std::string mode = (argc > 1) ? argv[1] : "simple";
    if (mode != "simple" && mode != "placeholder") {
        ERROR_LOG("Invalid run mode: %s. Mode must be simple or placeholder.", mode.c_str());
        return -1;
    }
    return RunKernelLaunchSample(mode);
}
