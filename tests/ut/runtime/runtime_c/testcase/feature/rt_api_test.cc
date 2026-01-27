/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <string>
#include <iostream>
#include <pthread.h>
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "rt.h"
#include "hal_ts.h"
#include "error_codes/rt_error_codes.h"
#include "rt_ctrl_model.h"
#include "sort_vector.h"
#include "vector.h"
#include "mem_pool.h"
using namespace testing;

#define LINUX 0
#define LITEOS 1

class ApiCTest : public testing::Test {
protected:
    void SetUp() {
        MOCKER(GetMemPoolReuseFlag).stubs().will(returnValue(true));
    }
    void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ApiCTest, memalloc_free) {
    rtError_t error;
    error = rtFree(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    void *ptr1 = nullptr;
    error = rtMalloc(&ptr1, 100, RT_MEMORY_HBM, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtFree(ptr1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemAlloc).stubs().will(returnObjectList(DRV_ERROR_MALLOC_FAIL));
    void *ptr2 = nullptr;
    error = rtMalloc(&ptr2, 100, RT_MEMORY_HBM, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_RESOURCE_ALLOC_FAIL);
}

TEST_F(ApiCTest, memset_sync) {
    rtError_t error;
    void *devPtr1 = nullptr;
    void *devPtr2 = nullptr;
    void *devPtr3 = nullptr;

    error = rtMalloc(&devPtr1, 60, RT_MEMORY_DDR, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr1, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr2, 60, RT_MEMORY_DDR, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(devPtr2, 60, 1, 70);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);

    error = rtFree(devPtr2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr1, 60, RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiCTest, memcpy_sync) {
    rtError_t error;
    void *devPtr1 = nullptr;
    void *devPtr2 = nullptr;
    void *devPtr3 = nullptr;

    error = rtMalloc(&devPtr1, 60, RT_MEMORY_DDR, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr2, 70, RT_MEMORY_DDR, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr3, 60, RT_MEMORY_DDR, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr3, 60, devPtr1, 60, RT_MEMCPY_DEVICE_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr3, 60, devPtr1, 70, RT_MEMCPY_DEVICE_TO_DEVICE);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);

    error = rtFree(devPtr1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr3);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiCTest, mem_get_info) {
    rtError_t error;
    size_t free;
    size_t total;

    error = rtMemGetInfoEx(RT_MEMORYINFO_DDR, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemGetInfoEx(RT_MEMORYINFO_HBM_P2P_NORMAL, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemGetInfoEx(RT_MEMORYINFO_HBM_HUGE, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemGetInfoEx((tagRtMemInfoType)11, &free, &total);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtMemGetInfoEx(RT_MEMORYINFO_DDR_P2P_NORMAL, &free, &total);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halMemGetInfo).stubs().will(returnObjectList(DRV_ERROR_MEMORY_OPT_FAIL));
    error = rtMemGetInfoEx(RT_MEMORYINFO_DDR_P2P_NORMAL, &free, &total);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

// env
TEST_F(ApiCTest, rt_init_deinit_case) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halTsInit).stubs().will(returnObjectList(int(DRV_ERROR_INVALID_DEVICE)));
    EXPECT_EQ(rtInit(), int(ACL_ERROR_RT_INVALID_DEVICEID));

    rtDeinit();
    MOCKER(halTsDeinit).stubs().will(returnObjectList(int32_t(DRV_ERROR_NO_DEVICE)));
    rtDeinit();
}

// device
TEST_F(ApiCTest, rt_get_runmode) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtRunMode runMode;
    error = rtGetRunMode(&runMode);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();

    error = rtGetRunMode(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(ApiCTest, rt_get_device_normal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    int32_t devId;
    error = rtGetDevice(&devId); // 依赖context
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, rt_get_device_abnormal1) {
    rtError_t error;
    error = rtGetDevice(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiCTest, rt_get_device_abnormal2) {
    rtError_t error;
    int32_t devId;
    error = rtGetDevice(&devId);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiCTest, rt_get_device_abnormal3) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    int32_t devId;
    error = rtGetDevice(&devId);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, device_set_normal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, device_set_abnormal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(-1);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDeviceReset(-1);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, rt_set_device_mmMalloc_abnormal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(malloc).stubs().will(returnValue((void *)nullptr));
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_ERROR_RT_DEV_SETUP_ERROR);

    rtDeinit();
}

TEST_F(ApiCTest, device_not_have) {
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    int32_t devId;
    error = rtGetDevice(&devId);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtRunMode runMode;
    error = rtGetRunMode(&runMode);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// context
TEST_F(ApiCTest, context_create_normal1) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, context_create_normal2) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, context_get_current) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t curCtx;
    error = rtCtxGetCurrent(&curCtx);
    EXPECT_EQ(ctx, curCtx);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, context_get_abnormal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetCurrent(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtContext_t curCtx;
    error = rtCtxGetCurrent(&curCtx);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtDeinit();
}


TEST_F(ApiCTest, context_set_current) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx1;
    error = rtCtxCreateEx(&ctx1, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx2;
    error = rtCtxCreateEx(&ctx2, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxSetCurrent(ctx1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t curCtx;
    error = rtCtxGetCurrent(&curCtx);
    EXPECT_EQ(ctx1, curCtx);

    error = rtCtxDestroyEx(ctx1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, context_set_current_abnormal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxSetCurrent(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx1;
    error = rtCtxCreateEx(&ctx1, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxSetCurrent(ctx1);
    EXPECT_EQ(error, ACL_ERROR_RT_CONTEXT_NULL);

    rtDeinit();
}

TEST_F(ApiCTest, context_create_abnormal1) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreateEx(nullptr, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_CONTEXT_NULL);

    error = rtCtxDestroyEx(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_CONTEXT_NULL);


    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, context_create_abnormal2) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);


    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, -1);
    EXPECT_EQ(error, ACL_ERROR_RT_DEV_SETUP_ERROR);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, context_create_abnormal3) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);


    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, -1);
    EXPECT_EQ(error, ACL_ERROR_RT_DEV_SETUP_ERROR);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, context_create_abnormal4) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx1;
    error = rtCtxCreateEx(&ctx1, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx2;
    error = rtCtxCreateEx(&ctx2, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx3;
    error = rtCtxCreateEx(&ctx3, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx4;
    error = rtCtxCreateEx(&ctx4, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx4);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, context_create_abnormal5) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);


    rtContext_t ctx;
    MOCKER(EmplaceSortVector).stubs().will(returnValue((void *)NULL));
    if (rtCtxCreateEx(&ctx, 0, 0) == RT_ERROR_NONE) {
        rtCtxDestroyEx(ctx);
    }
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, context_create_abnormal6) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);


    rtContext_t ctx;
    MOCKER(MemPoolAllocWithCSingleList).stubs().will(returnValue((void *)NULL));
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_MEMORY_ALLOCATION);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

// stream
TEST_F(ApiCTest, stream_create_normal1) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_create_normal2) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_create_normal3) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_create_normal0) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream;
    MOCKER(EmplaceBackVector).stubs().will(returnValue((void *)NULL));
    error = rtStreamCreateWithConfig(&stream, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_create_abnormal1) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    error = rtStreamCreateWithConfig(nullptr, &handle);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_create_abnormal2) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    error = rtStreamCreateWithConfig(nullptr, &handle);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_create_abnormal3) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_create_abnormal4) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream1;
    error = rtStreamCreateWithConfig(&stream1, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream2;
    error = rtStreamCreateWithConfig(&stream2, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream3;
    error = rtStreamCreateWithConfig(&stream3, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream4;
    error = rtStreamCreateWithConfig(&stream4, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream5;
    error = rtStreamCreateWithConfig(&stream5, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream3);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream4);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_with_nullcontext_abnormal1) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxSetCurrent(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t sqid;
    error = rtStreamGetSqid(nullptr, &sqid);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_sync_normal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_sync_abnormal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_sync_abnormal2) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halModelExec).stubs().will(returnObjectList(DRV_ERROR_NO_DEVICE));
    error = rtStreamSynchronize(stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_sync_abnormal3) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx0;
    error = rtCtxCreateEx(&ctx0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_sync_abnormal4) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx0;
    error = rtCtxCreateEx(&ctx0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_sqId_normal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx0;
    error = rtCtxCreateEx(&ctx0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t sqId;
    error = rtStreamGetSqid(stream, &sqId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetSqid(NULL, &sqId);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_sqId_abnormal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t sqId;
    error = rtStreamGetSqid(NULL, &sqId);
    EXPECT_NE(error, RT_ERROR_NONE);

    rtStream_t stream;
    error = rtStreamGetSqid(&stream, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    rtDeinit();
}

TEST_F(ApiCTest, stream_workspace_normal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx0;
    error = rtCtxCreateEx(&ctx0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *workspace;
    size_t worksize;
    error = rtStreamGetWorkspace(stream, &workspace, &worksize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetWorkspace(nullptr, &workspace, &worksize);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, stream_create_mmMalloc_abnormal) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    rtStream_t stream;
    MOCKER(malloc).stubs().will(returnValue((void *)nullptr));
    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, ACL_ERROR_RT_MEMORY_ALLOCATION);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, runtime_rtSubscribeReport)
{
    rtStreamConfigHandle handle;
    rtStream_t stream;
    rtError_t error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t threadId = 1;
    error = rtSubscribeReport(threadId, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSubscribeReport(threadId, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtSubscribeReport(threadId, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_SUBSCRIBE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, runtime_rtProcessReport)
{
    rtError_t error;
    int32_t timeout = 1;
    error = rtProcessReport(timeout);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halCbIrqWait)
        .stubs()
        .will(returnObjectList(DRV_ERROR_INVALID_VALUE, DRV_ERROR_WAIT_TIMEOUT));
    timeout = 0;
    error = rtProcessReport(timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    timeout = -2;
    error = rtProcessReport(timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    timeout = 1;
    error = rtProcessReport(timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtProcessReport(timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_REPORT_TIMEOUT);
}

TEST_F(ApiCTest, runtime_rtUnSubscribeReport) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t threadId = 1;
    error = rtSubscribeReport(threadId, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(halSqUnSubscribeTid).stubs().will(returnObjectList(DRV_ERROR_NONE));
    error = rtUnSubscribeReport(threadId, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUnSubscribeReport(threadId, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_SUBSCRIBE);

    error = rtSubscribeReport(threadId, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtUnSubscribeReport(threadId, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

void CallBackFuncStub(void *arg)
{
    (void)arg;
    int a = 1;
    a++;
}

TEST_F(ApiCTest, runtime_rtCallbackLaunch) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamConfigHandle handle;
    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halModelExec).stubs().will(returnObjectList(DRV_ERROR_NONE, DRV_ERROR_INVALID_VALUE, DRV_ERROR_NONE)); // 3次

    bool isBlock = false;
    error = rtCallbackLaunch(CallBackFuncStub, nullptr, stream, isBlock);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_NO_CB_REG);

    uint64_t threadId = 1;
    error = rtSubscribeReport(threadId, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtCallbackLaunch(CallBackFuncStub, nullptr, stream, isBlock); // 1
    EXPECT_EQ(error, RT_ERROR_NONE);

    isBlock = true;
    error = rtCallbackLaunch(CallBackFuncStub, nullptr, stream, isBlock); // 2
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtCallbackLaunch(CallBackFuncStub, nullptr, stream, isBlock); // 3
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSubscribeReport(threadId, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtCallbackLaunch(CallBackFuncStub, nullptr, nullptr, isBlock);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtUnSubscribeReport(threadId, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtUnSubscribeReport(threadId, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, runtime_SendNullMdl) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream;
    error = rtStreamCreateWithConfig(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halModelExec).stubs().will(returnObjectList(DRV_ERROR_NONE, DRV_ERROR_NO_DEVICE));
    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_ERROR_RT_NO_DEVICE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, runtime_InitCtrlMdl) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDeinit();
}

TEST_F(ApiCTest, runtime_DeInitCtrlMdl) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halModelLoad).stubs().will(returnValue(DRV_ERROR_NO_DEVICE)).then(returnValue(DRV_ERROR_NONE));
    error = rtInit();
    EXPECT_EQ(error, ACL_ERROR_RT_NO_DEVICE);

    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NO_DEVICE)).then(returnValue(DRV_ERROR_NONE));
    error = rtInit();
    EXPECT_EQ(error, ACL_ERROR_RT_NO_DEVICE);

    MOCKER(halGetTaskDesc).stubs().will(returnValue(DRV_ERROR_NO_DEVICE)).then(returnValue(DRV_ERROR_NONE));
    error = rtInit();
    EXPECT_EQ(error, ACL_ERROR_RT_NO_DEVICE);

    error = rtInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
    MOCKER(halModelDestroy).stubs().will(returnValue(DRV_ERROR_NO_DEVICE)).then(returnValue(DRV_ERROR_NONE));

    rtDeinit();
}

TEST_F(ApiCTest, runtime_rtSubscribeHostFunc) {
    rtStreamConfigHandle handle;
    rtStream_t stream;
    rtError_t error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halSqSubscribeTid).stubs().will(returnObjectList(DRV_ERROR_NONE));

    uint64_t threadId = 1;
    error = rtSubscribeHostFunc(threadId, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSubscribeHostFunc(threadId, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtSubscribeHostFunc(threadId, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_SUBSCRIBE);
    error = rtUnSubscribeHostFunc(threadId, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

TEST_F(ApiCTest, runtime_rtUnSubscribeHostFunc) {
    rtStreamConfigHandle handle;
    rtStream_t stream;
    rtError_t error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t ctx;
    error = rtCtxCreateEx(&ctx, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreateWithConfig(&stream, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halSqUnSubscribeTid).stubs().will(returnObjectList(DRV_ERROR_NONE));

    uint64_t threadId = 1;
    error = rtSubscribeHostFunc(threadId, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtUnSubscribeHostFunc(threadId, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUnSubscribeHostFunc(threadId, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_SUBSCRIBE);

    error = rtSubscribeHostFunc(threadId, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtUnSubscribeHostFunc(threadId, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroyEx(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtDeinit();
}

void *ThreadFunc(void *arg)
{
    int32_t timeout = 1;
    (void)rtProcessHostFunc(timeout);
    return nullptr;
}

TEST_F(ApiCTest, runtime_rtProcessHostFunc) {
    pthread_t threadId;
    int ret = pthread_create(&threadId, nullptr, ThreadFunc, nullptr);
    if (ret != 0) {
        printf("create thread failed, err = %d\n", ret);
    }
    pthread_join(threadId, nullptr);

    rtError_t error;
    int32_t timeout = 1;
    error = rtProcessHostFunc(timeout);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halHostFuncWait).stubs().will(returnObjectList(DRV_ERROR_INVALID_VALUE, DRV_ERROR_WAIT_TIMEOUT));
    timeout = 0;
    error = rtProcessHostFunc(timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    timeout = -2;
    error = rtProcessHostFunc(timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    timeout = 1;
    error = rtProcessHostFunc(timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtProcessHostFunc(timeout);
    EXPECT_EQ(error, ACL_ERROR_RT_REPORT_TIMEOUT);
}