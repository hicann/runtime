/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "config.h"
#include "runtime.hpp"
#include "runtime/context.h"
#include "rt_error_codes.h"
#include "api_impl.hpp"
#include "api_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "api_profile_decorator.hpp"
#include "profiler.hpp"
#include "binary_loader.hpp"
#undef private


using namespace testing;
using namespace cce::runtime;

class ApiContextTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"ApiContextTest test start start. "<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"ApiContextTest test start end. "<<std::endl;

    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
};

TEST_F(ApiContextTest, TestRtsCtxDestroy)
{
    rtError_t error;
    error = rtsCtxDestroy(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiContextTest, TestRtsCtxGetAndSetCurrent)
{
    rtError_t error;
    int32_t state = 0;
    int32_t devId = 0;
    uint32_t flag;
    error = rtsGetPrimaryCtxState(devId, &flag, &state);
    EXPECT_EQ(error, RT_ERROR_NONE);


    rtContext_t ctxA, ctxB, ctxC;
    rtContext_t current = NULL;
    int32_t currentDevId = -1;

    error = rtsCtxGetCurrent(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);

    error = rtsGetPrimaryCtxState(devId, &flag, &state);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCtxCreate(&ctxA, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCtxCreate(&ctxB, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCtxCreate(&ctxC, 1, devId);
    EXPECT_EQ(error,  ACL_ERROR_RT_PARAM_INVALID);

    error = rtsCtxSetCurrent(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);

    error = rtsCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(current, ctxA);

    error = rtsCtxSetCurrent(ctxB);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);

    error = rtsCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(current, ctxB);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctxB);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsGetPrimaryCtxState(devId, &flag, &state);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiContextTest, TestRtsGetPrimaryCtxState)
{
    rtError_t error;
    int32_t state = 0;
    int32_t devId = 0;
    uint32_t flag;
    rtContext_t ctx = nullptr;
    rtsCtxCreate(&ctx, 0, devId);
    error = rtsGetPrimaryCtxState(1, &flag, &state);
    bool isInUse = false;
    ContextManage::QueryContextInUse(0, isInUse);
    rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

}
TEST_F(ApiContextTest, TestRtsCtxGetAndSetSysParamOpt)
{
    rtError_t error;
    int64_t val;
    // abnormal test not set
    error = rtsCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_SYSPARAMOPT_NOT_SET);

    error = rtsCtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 1);

    // abnormal test
    error =rtsCtxSetSysParamOpt(SYS_OPT_RESERVED, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error =rtsCtxGetSysParamOpt(SYS_OPT_RESERVED, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiContextTest, TestRtsCtxGetCurrentDefaultStream)
{
    rtStream_t stream;
    rtError_t error = rtsCtxGetCurrentDefaultStream(&stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(stream, nullptr);
    error = rtsCtxGetCurrentDefaultStream(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}