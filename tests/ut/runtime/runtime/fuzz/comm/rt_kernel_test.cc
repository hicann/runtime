/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_comm_testcase.hpp"

#define ERROR_PROC(ret, streamId, x, y, xHost, yHost, binHandle)        \
    if (ret != 0)                                                       \
    {                                                                   \
        rtStreamDestroy(streamId);                                      \
        rtFree(x);                                                      \
        rtFree(y);                                                      \
        rtFreeHost(xHost);                                              \
        rtFreeHost(yHost);                                              \
        rtDevBinaryUnRegister(binHandle);                               \
        rtDeviceReset(0);                                                \
        return false;                                                   \
    }                                                                   \

int rt_kernel_test(rtDevBinary_t *binary, uint32_t funcMode, int32_t device, int32_t priority, uint64_t size,
                   uint32_t blockDim, uint32_t argsSize, rtL2Ctrl_t *l2ctrl)
{
    rtError_t error;
    uint32_t stubFunc;
    uint32_t devFunc;

    rtStream_t stream = NULL;
    void *binHandle = NULL;
    void *xHost = NULL;
    void *yHost = NULL;
    void *x = NULL;
    void *y = NULL;

    unsigned char binArray[2] = { 0xff, 0xff };
    binary->data = binArray;
    binary->length = sizeof(binArray);

    error = rtDevBinaryRegister(binary, &binHandle);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    error = rtFunctionRegister(binHandle, &stubFunc, "fuzz", &devFunc, funcMode);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    error = rtSetDevice(device);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    error = rtStreamCreate(&stream, priority);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    size = size % 1000;
    error = rtMallocHost((void**)&xHost, size, DEFAULT_MODULEID);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    error = rtMallocHost((void**)&yHost, size, DEFAULT_MODULEID);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    error = rtMalloc(&x, size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    error = rtMalloc(&y, size, RT_MEMORY_HBM, DEFAULT_MODULEID);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    error = rtMemcpyAsync(x, size, xHost, size, RT_MEMCPY_HOST_TO_DEVICE, stream);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    uint8_t *args = NULL;
    if (argsSize > 0)
    {
        args = new uint8_t[argsSize];
    }
    error = rtKernelLaunch(&stubFunc, blockDim, args, argsSize, l2ctrl, stream);
    if (argsSize > 0)
    {
        delete[] args;
    }
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    error = rtStreamSynchronize(stream);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    error = rtMemcpy(yHost, size, y, size, RT_MEMCPY_DEVICE_TO_HOST);
    ERROR_PROC(error, stream, x, y, xHost, yHost, binHandle);

    rtFreeHost(xHost);
    rtFreeHost(yHost);
    rtFree(x);
    rtFree(y);
    rtStreamDestroy(stream);
    rtDevBinaryUnRegister(binHandle);
    rtDeviceReset(0);

    return 0;
}

