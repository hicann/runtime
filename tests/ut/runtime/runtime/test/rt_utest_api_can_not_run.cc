/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_utest_api.hpp"
/*
error 放最前面也跑不了，单独跑可以
TEST_F(ApiTest, context_conflict1)
{
    int32_t devId = 0;
    rtError_t error;
    rtContext_t ctx;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // kernel launch
    void *args[] = {&error, NULL};
    error = rtKernelLaunch(&args, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelFusionStart(stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelFusionEnd(stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamWaitEvent(stream_, event_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamQuery(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event_, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(&error, 64, &ctx, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_);
    //EXPECT_NE(error, RT_ERROR_NONE);

    void *devPtr = NULL;
    error = rtMalloc(&devPtr, 60, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemsetAsync(devPtr, 60, 0, 60, stream_);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CONTEXT);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
*/
