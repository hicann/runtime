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
#define protected public
#define private public
#include "utils.h"
#include "runtime.hpp"
#include "xpu_context.hpp"
#include "stream_xpu.hpp"
#include "tprt.hpp"
#include "stream_sqcq_manage_xpu.hpp"
#include "task_res_da.hpp"
#include "runtime_keeper.h"
#undef protected
#undef private
#include "xpu_device.hpp"

using namespace cce::runtime;
class XpuContextTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "XpuContextTest SetUP" << std::endl;

        std::cout << "XpuContextTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "XpuContextTest end" << std::endl;
    }

    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

rtError_t InsertStreamList_Mock(Context *ctx, Stream *const stm)
{
    delete stm;
    return RT_ERROR_NONE;
}

TEST_F(XpuContextTest, streamCreate_Success)
{
    // 正常调用流程
    XpuDevice *device = new XpuDevice(1);
    XpuContext *context = new XpuContext(device, false);
    XpuStream *xpuStream = new XpuStream(device, RT_STREAM_DEFAULT);
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    // 正常流程中的Mock
    MOCKER_CPP_VIRTUAL(xpuStream, &XpuStream::Setup).stubs().will(returnValue(RT_ERROR_NONE));

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(mockcpp::any());

    // 特殊Mock：析构Stream
    MOCKER_CPP(&XpuContext::InsertStreamList).stubs().will(invoke(InsertStreamList_Mock));
    Stream *stream;
    EXPECT_EQ(
        context->StreamCreate(RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_DEFAULT, &stream, nullptr, false), RT_ERROR_NONE);
    DELETE_O(xpuStream);
    DELETE_O(context);
}

TEST_F(XpuContextTest, TearDownStream_Success)
{
    XpuDevice *device = new XpuDevice(1);
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    XpuContext *ctxt = new (std::nothrow) XpuContext(device, true);
    MOCKER_CPP_VIRTUAL(stream, &XpuStream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&XpuStream::Destructor).stubs().will(returnValue((void *)nullptr));
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = ctxt->TearDownStream(stream, true);
    EXPECT_EQ(error, RT_ERROR_NONE);

    DELETE_O(stream);
    DELETE_O(ctxt);
}

TEST_F(XpuContextTest, TearDownStream_TearDown_error)
{
    XpuDevice *device = new XpuDevice(1);
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    XpuContext *ctxt = new (std::nothrow) XpuContext(device, true);
    MOCKER_CPP_VIRTUAL(stream, &XpuStream::TearDown).stubs().will(returnValue(RT_ERROR_DRV_INVALID_HANDLE));
    MOCKER_CPP(&XpuStream::Destructor).stubs().will(returnValue((void *)nullptr));
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = ctxt->TearDownStream(stream, true);
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_HANDLE);
    DELETE_O(stream);
    DELETE_O(ctxt);
}

TEST_F(XpuContextTest, streamCreate_prior_Fail)
{
    // 正常调用流程
    XpuDevice *device = new XpuDevice(1);
    XpuContext *context = new XpuContext(device, false);
    XpuStream *xpuStream = new XpuStream(device, RT_STREAM_DEFAULT);
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    // 正常流程中的Mock
    MOCKER_CPP_VIRTUAL(xpuStream, &XpuStream::Setup).stubs().will(returnValue(RT_ERROR_NONE));

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(mockcpp::any());

    // 特殊Mock：析构Stream
    MOCKER_CPP(&XpuContext::InsertStreamList).stubs().will(invoke(InsertStreamList_Mock));
    Stream *stream;
    EXPECT_EQ(context->StreamCreate(1U, RT_STREAM_DEFAULT, &stream, nullptr, false), RT_ERROR_INVALID_VALUE);
    DELETE_O(xpuStream);
    DELETE_O(context);
}

TEST_F(XpuContextTest, streamCreate_flag_Fail)
{
    // 正常调用流程
    XpuDevice *device = new XpuDevice(1);
    XpuContext *context = new XpuContext(device, false);
    XpuStream *xpuStream = new XpuStream(device, RT_STREAM_DEFAULT);
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    // 正常流程中的Mock
    MOCKER_CPP_VIRTUAL(xpuStream, &XpuStream::Setup).stubs().will(returnValue(RT_ERROR_NONE));

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(mockcpp::any());

    // 特殊Mock：析构Stream
    MOCKER_CPP(&XpuContext::InsertStreamList).stubs().will(invoke(InsertStreamList_Mock));
    Stream *stream;
    EXPECT_EQ(context->StreamCreate(RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_PERSISTENT, &stream, nullptr, false),
        RT_ERROR_INVALID_VALUE);
    DELETE_O(xpuStream);
    DELETE_O(context);
}

TEST_F(XpuContextTest, streamCreate_setUp_Fail)
{
    // 正常调用流程
    XpuDevice *device = new XpuDevice(1);
    XpuContext *context = new XpuContext(device, false);
    XpuStream *xpuStream = new XpuStream(device, RT_STREAM_DEFAULT);
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    // 正常流程中的Mock
    MOCKER_CPP_VIRTUAL(xpuStream, &XpuStream::Setup).stubs().will(returnValue(RT_ERROR_STREAM_NEW));

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(mockcpp::any());

    // 特殊Mock：析构Stream
    MOCKER_CPP(&XpuContext::InsertStreamList).stubs().will(invoke(InsertStreamList_Mock));
    Stream *stream;
    EXPECT_EQ(context->StreamCreate(RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_DEFAULT, &stream, nullptr, false),
        RT_ERROR_STREAM_NEW);
    DELETE_O(xpuStream);
    DELETE_O(context);
}

TEST_F(XpuContextTest, ConstructRuntimeImpl_success)
{
    Runtime *rt = ConstructRuntimeImpl();
    EXPECT_NE(rt, nullptr);
    DestructorRuntimeImpl(rt);
}
