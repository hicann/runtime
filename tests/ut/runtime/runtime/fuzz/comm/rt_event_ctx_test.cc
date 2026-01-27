/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <unistd.h>
#include "rt_comm_testcase.hpp"

#define ERROR_PROC(ret, stream, start, end, ctx)        \
    if (ret != 0)                                       \
    {                                                   \
        rtEventDestroy(start);                          \
        rtEventDestroy(end);                            \
        rtStreamDestroy(stream);                        \
        rtCtxDestroy(ctx);                              \
        rtDeviceReset(0);                                \
        return -1;                                      \
    }                                                   \

int rt_event_ctx_test(int32_t device, uint32_t flags, int32_t priority, uint32_t sleepTime, uint32_t count, int32_t listener)
{
    rtStream_t stream = NULL;
    rtEvent_t start = NULL;
    rtEvent_t end = NULL;
    rtContext_t ctx = NULL;
    rtContext_t current = NULL;
    rtError_t error;

    error = rtSetDevice(device);
    ERROR_PROC(error, stream, start, end, ctx);

    int32_t devId = 0;
    error = rtGetDevice(&devId);
    ERROR_PROC(error, stream, start, end, ctx);

    error = rtCtxCreate(&ctx, flags, devId);
    ERROR_PROC(error, stream, start, end, ctx);

    error = rtStreamCreate(&stream, 0);
    ERROR_PROC(error, stream, start, end, ctx);

    error = rtEventCreate(&start);
    ERROR_PROC(error, stream, start, end, ctx);

    error = rtEventCreate(&end);
    ERROR_PROC(error, stream, start, end, ctx);

    error = rtEventRecord(start, stream);
    ERROR_PROC(error, stream, start, end, ctx);

    usleep(sleepTime % 2000);

    error = rtEventRecord(end, stream);
    ERROR_PROC(error, stream, start, end, ctx);

    error = rtStreamSynchronize(stream);
    ERROR_PROC(error, stream, start, end, ctx);

    error = rtEventQuery(end);
    ERROR_PROC(error, stream, start, end, ctx);

    float time = 0.0;
    error = rtEventElapsedTime(&time, start, end);
    ERROR_PROC(error, stream, start, end, ctx);

    error = rtCtxSetCurrent(ctx);
    ERROR_PROC(error, stream, start, end, ctx);

    error = rtCtxGetCurrent(&current);
    ERROR_PROC(error, stream, start, end, ctx);

    int32_t currentDevId = -1;
    error = rtCtxGetDevice(&currentDevId);
    ERROR_PROC(error, stream, start, end, ctx);

    rtEventDestroy(start);
    rtEventDestroy(end);
    rtStreamDestroy(stream);
    rtCtxDestroy(ctx);
    rtDeviceReset(0);

    return 0;
}

