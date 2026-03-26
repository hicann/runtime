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

int32_t InitializeRuntime(int32_t deviceId, aclrtStream *stream)
{
    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateStream(stream));
    return 0;
}

int32_t AllocateKernelBuffers(size_t inputByteSize, size_t outputByteSize, KernelBuffers *buffers)
{
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
    kernel::ReadFile("./input/input_x.bin", inputByteSize, buffers.xHost, inputByteSize);
    kernel::ReadFile("./input/input_y.bin", inputByteSize, buffers.yHost, inputByteSize);

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
    CHECK_ERROR(aclrtKernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle4, sizeof(TOTAL_LENGTH), reinterpret_cast<void **>(&lengthHost)));
    CHECK_ERROR(aclrtKernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle5, sizeof(TILE_NUM), reinterpret_cast<void **>(&numHost)));

    *lengthHost = TOTAL_LENGTH;
    *numHost = TILE_NUM;
    return 0;
}

int32_t BuildKernelArgs(
    const std::string &mode,
    uint8_t *xDevice,
    uint8_t *yDevice,
    uint8_t *zDevice,
    aclrtBinHandle *binHandle,
    aclrtFuncHandle *funcHandle,
    aclrtArgsHandle *argsHandle)
{
    const bool isPlaceholder = (mode == "placeholder");
    const char *filePath = isPlaceholder
        ? "./out/fatbin/ascendc_kernels_placeholder/ascendc_kernels_placeholder.o"
        : "./out/fatbin/ascendc_kernels_simple/ascendc_kernels_simple.o";

    CHECK_ERROR(aclrtBinaryLoadFromFile(filePath, nullptr, binHandle));
    CHECK_ERROR(aclrtBinaryGetFunction(*binHandle, "add_custom", funcHandle));
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
    CHECK_ERROR(aclrtLaunchKernelWithConfig(funcHandle, blockDim, stream, nullptr, argsHandle, nullptr));
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    CHECK_ERROR(aclrtMemcpy(zHost, outputByteSize, zDevice, outputByteSize, ACL_MEMCPY_DEVICE_TO_HOST));
    kernel::WriteFile("./output/output_z.bin", zHost, outputByteSize);
    return 0;
}

int32_t RunKernelLaunchSample(const std::string &mode)
{
    const uint32_t blockDim = 8;
    const size_t inputByteSize = 8 * 2048 * sizeof(uint16_t);
    const size_t outputByteSize = 8 * 2048 * sizeof(uint16_t);
    const int32_t deviceId = 0;

    aclrtStream stream = nullptr;
    aclrtBinHandle binHandle = nullptr;
    aclrtFuncHandle funcHandle = nullptr;
    aclrtArgsHandle argsHandle = nullptr;
    KernelBuffers buffers;

    if (InitializeRuntime(deviceId, &stream) != 0) {
        return -1;
    }
    if (AllocateKernelBuffers(inputByteSize, outputByteSize, &buffers) != 0) {
        return -1;
    }
    if (PrepareInputData(inputByteSize, buffers) != 0) {
        return -1;
    }
    if (BuildKernelArgs(mode, buffers.xDevice, buffers.yDevice, buffers.zDevice, &binHandle, &funcHandle, &argsHandle) != 0) {
        return -1;
    }
    if (LaunchKernelAndWriteOutput(funcHandle, argsHandle, blockDim, stream, buffers.zDevice, buffers.zHost, outputByteSize) != 0) {
        return -1;
    }

    CHECK_ERROR(aclrtBinaryUnLoad(binHandle));
    CHECK_ERROR(aclrtFree(buffers.xDevice));
    CHECK_ERROR(aclrtFree(buffers.yDevice));
    CHECK_ERROR(aclrtFree(buffers.zDevice));
    CHECK_ERROR(aclrtFreeHost(buffers.xHost));
    CHECK_ERROR(aclrtFreeHost(buffers.yHost));
    CHECK_ERROR(aclrtFreeHost(buffers.zHost));
    CHECK_ERROR(aclrtDestroyStreamForce(stream));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    return 0;
}
} // namespace

int32_t main(int32_t argc, char *argv[])
{
    (void)argc;
    const std::string mode = argv[1];
    return RunKernelLaunchSample(mode);
}
