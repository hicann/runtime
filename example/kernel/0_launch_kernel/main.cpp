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
#include "acl/acl.h"
#include "utils.h"
#include "kernel_utils.h"


int32_t main(int32_t argc, char *argv[])
{
    std::string mode = argv[1];
    uint32_t blockDim = 8;
    size_t inputByteSize = 8 * 2048 * sizeof(uint16_t);
    size_t outputByteSize = 8 * 2048 * sizeof(uint16_t);

    CHECK_ERROR(aclInit(nullptr));
    int32_t deviceId = 0;
    CHECK_ERROR(aclrtSetDevice(deviceId));
    aclrtStream stream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));

    uint8_t *xHost;
    uint8_t *yHost;
    uint8_t *zHost;
    uint8_t *xDevice;
    uint8_t *yDevice;
    uint8_t *zDevice;

    // Allocate memmory for inputs and outputs 
    CHECK_ERROR(aclrtMallocHost((void **)(&xHost), inputByteSize));
    CHECK_ERROR(aclrtMallocHost((void **)(&yHost), inputByteSize));
    CHECK_ERROR(aclrtMallocHost((void **)(&zHost), outputByteSize));
    CHECK_ERROR(aclrtMalloc((void **)&xDevice, inputByteSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc((void **)&yDevice, inputByteSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc((void **)&zDevice, outputByteSize, ACL_MEM_MALLOC_HUGE_FIRST));

    // Read input data from target files
    kernel::ReadFile("./input/input_x.bin", inputByteSize, xHost, inputByteSize);
    kernel::ReadFile("./input/input_y.bin", inputByteSize, yHost, inputByteSize);

    // Copy input data from host addresses to device addresses
    CHECK_ERROR(aclrtMemcpy(xDevice, inputByteSize, xHost, inputByteSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(yDevice, inputByteSize, yHost, inputByteSize, ACL_MEMCPY_HOST_TO_DEVICE));

    aclrtBinHandle binHandle = nullptr;
    aclrtFuncHandle funcHandle = nullptr;
    aclrtArgsHandle argsHandle = nullptr;
    aclrtParamHandle paramHandle1 = nullptr;
    aclrtParamHandle paramHandle2 = nullptr;
    aclrtParamHandle paramHandle3 = nullptr;
    if (mode == "simple") {
        const char *filePath = "./out/fatbin/ascendc_kernels_simple/ascendc_kernels_simple.o";
        // Load the kernel binary file
        CHECK_ERROR(aclrtBinaryLoadFromFile(filePath, nullptr, &binHandle));
        
        // Obtain the kernel function handle
        CHECK_ERROR(aclrtBinaryGetFunction(binHandle, "add_custom", &funcHandle));
        
        // Initialize the argument list
        CHECK_ERROR(aclrtKernelArgsInit(funcHandle, &argsHandle));

        // Append arguments
        CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, (void **)&xDevice, sizeof(uintptr_t), &paramHandle1));
        CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, (void **)&yDevice, sizeof(uintptr_t), &paramHandle2));
        CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, (void **)&zDevice, sizeof(uintptr_t), &paramHandle3));
    }
    if (mode == "placeholder") {
        const char *filePath = "./out/fatbin/ascendc_kernels_placeholder/ascendc_kernels_placeholder.o";
        // Load the kernel binary file
        CHECK_ERROR(aclrtBinaryLoadFromFile(filePath, nullptr, &binHandle));
        
        // Obtain the kernel function handle
        CHECK_ERROR(aclrtBinaryGetFunction(binHandle, "add_custom", &funcHandle));
        
        // Initialize the argument list
        CHECK_ERROR(aclrtKernelArgsInit(funcHandle, &argsHandle));

        // Append arguments
        CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, (void **)&xDevice, sizeof(uintptr_t), &paramHandle1));
        CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, (void **)&yDevice, sizeof(uintptr_t), &paramHandle2));
        CHECK_ERROR(aclrtKernelArgsAppend(argsHandle, (void **)&zDevice, sizeof(uintptr_t), &paramHandle3));

        constexpr int32_t TOTAL_LENGTH = 8 * 2048; 
        constexpr int32_t TILE_NUM = 8;   
        int32_t *lengthHost;
        int32_t *numHost;
        aclrtParamHandle paramHandle4 = nullptr;
        aclrtParamHandle paramHandle5 = nullptr;
        CHECK_ERROR(aclrtKernelArgsAppendPlaceHolder(argsHandle, &paramHandle4));
        CHECK_ERROR(aclrtKernelArgsAppendPlaceHolder(argsHandle, &paramHandle5));

        CHECK_ERROR(aclrtKernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle4, sizeof(TOTAL_LENGTH), (void**)&lengthHost));
        CHECK_ERROR(aclrtKernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle5, sizeof(TILE_NUM), (void**)&numHost));

        *lengthHost = TOTAL_LENGTH;
        *numHost = TILE_NUM;  
    }
    // Finalize the argument list appending
    CHECK_ERROR(aclrtKernelArgsFinalize(argsHandle));

    // Launch kernel to start the corresponding kernel computation task
    CHECK_ERROR(aclrtLaunchKernelWithConfig(funcHandle, blockDim, stream, nullptr, argsHandle, nullptr));
    CHECK_ERROR(aclrtSynchronizeStream(stream));

    CHECK_ERROR(aclrtMemcpy(zHost, outputByteSize, zDevice, outputByteSize, ACL_MEMCPY_DEVICE_TO_HOST));
    kernel::WriteFile("./output/output_z.bin", zHost, outputByteSize);

    // Unload the kernel binary file
    CHECK_ERROR(aclrtBinaryUnLoad(binHandle));

    // Release runtime resources
    CHECK_ERROR(aclrtFree(xDevice));
    CHECK_ERROR(aclrtFree(yDevice));
    CHECK_ERROR(aclrtFree(zDevice));
    CHECK_ERROR(aclrtFreeHost(xHost));
    CHECK_ERROR(aclrtFreeHost(yHost));
    CHECK_ERROR(aclrtFreeHost(zHost));

    CHECK_ERROR(aclrtDestroyStreamForce(stream));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    return 0;
}
