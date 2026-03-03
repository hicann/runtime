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
#include "runtime/rt.h"
#include "utils.h"
#include "xpu_context.hpp"
#include "arg_manage_david.hpp"
#define private public
#define protected public
#include "kernel.hpp"
#include "program.hpp"
#include "arg_loader_xpu.hpp"
#include "stream_xpu.hpp"
#undef protected
#undef private
#include "xpu_stub.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "tprt.hpp"
#include "inner_thread_local.hpp"

using namespace testing;
using namespace cce::runtime;

class ArgManageXpuTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(ArgManageXpuTest, xpu_arg_manager_test_01)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    EXPECT_EQ(error, RT_ERROR_NONE);

    XpuStream *stream = static_cast<XpuStream *>(context->StreamList_().front());
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    DavidArgLoaderResult result1 = {nullptr, nullptr, nullptr, UINT32_MAX};
    error = stream->ArgManagePtr()->AllocCopyPtr(100, true, &result1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = stream->ArgManagePtr()->AllocCopyPtr(100, false, &result1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *args = malloc(100);

    error = stream->ArgManagePtr()->H2DArgCopy(&result1, args, 100);
    EXPECT_EQ(error, RT_ERROR_NONE);

    result1.handle = nullptr;
    error = stream->ArgManagePtr()->H2DArgCopy(&result1, args, 100);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
    free(args);
 }

 TEST_F(ArgManageXpuTest, xpu_arg_manager_test_02)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
    error = context->StreamCreate(prio, flag, result);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
 }

TEST_F(ArgManageXpuTest, xpu_arg_manager_test_03)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    EXPECT_EQ(error, RT_ERROR_NONE);
    XpuArgManage *xpuArgsManager = new XpuArgManage(context->StreamList_().front());
    DavidArgLoaderResult result1 = {nullptr, nullptr, nullptr, UINT32_MAX};
    MOCKER_CPP(&DavidArgManage::AllocStmArgPos).stubs().will(returnValue(false));
    xpuArgsManager->AllocStmPool(100, &result1);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete xpuArgsManager;
    delete result;
 }