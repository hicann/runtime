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
#include "xpu_context.hpp"
#define private public
#define protected public
#include "stream_xpu.hpp"
#include "arg_manage_xpu.hpp"
#include "stream_sqcq_manage_xpu.hpp"
#include "tprt_api.h"
#include "task_res.hpp"
#include "task_res_da.hpp"
#include "task_info.hpp"
#include "stream_xpu_c.hpp"
#include "task_xpu.hpp"
#undef private
#undef protected
#include "xpu_stub.h"

using namespace cce::runtime;
class XpuStreamTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "XpuStreamTest SetUP" << std::endl;

        std::cout << "XpuStreamTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "XpuStreamTest end" << std::endl;
    }

    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(XpuStreamTest, createStreamArgRes_Success)
{
    // 正常调用流程

    XpuDevice *device = new XpuDevice(1);
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;

    XpuArgManage *argManage = new XpuArgManage(stream);

    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    // 正常流程中的Mock
    MOCKER_CPP_VIRTUAL(argManage, &XpuArgManage::CreateArgRes).stubs().will(returnValue(true));

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStream::ReleaseStreamTaskRes).stubs();
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq)
        .stubs()
        .with(eq((uint32_t)1), eq((uint32_t)1))
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(stream->CreateStreamArgRes(), RT_ERROR_NONE);
    DELETE_O(argManage);
    DELETE_O(stream);
    DELETE_O(device);
}

TEST_F(XpuStreamTest, createStreamTaskRes_Success)
{
    // 正常调用流程
    XpuDevice *device = new XpuDevice(1);
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;
    stream->device_ = device;

    TaskResManageDavid *taskManage = new TaskResManageDavid();

    // 正常流程中的Mock
    MOCKER_CPP_VIRTUAL(taskManage, &TaskResManageDavid::CreateTaskRes).stubs().will(returnValue(true));

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq)
        .stubs()
        .with(eq((uint32_t)1), eq((uint32_t)1))
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(stream->CreateStreamTaskRes(), RT_ERROR_NONE);
    DELETE_O(taskManage);
    DELETE_O(stream);
    DELETE_O(device);
}

TEST_F(XpuStreamTest, createStreamTaskRes_Fail)
{
    // 正常调用流程
    XpuDevice *device = new XpuDevice(1);
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;
    stream->device_ = device;

    TaskResManageDavid *taskManage = new TaskResManageDavid();

    // 正常流程中的Mock
    MOCKER_CPP_VIRTUAL(taskManage, &TaskResManageDavid::CreateTaskRes).stubs().will(returnValue(false));

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq)
        .stubs()
        .with(eq((uint32_t)1), eq((uint32_t)1))
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(stream->CreateStreamTaskRes(), RT_ERROR_STREAM_NEW);
    DELETE_O(taskManage);
    DELETE_O(stream);
    DELETE_O(device);
}

TEST_F(XpuStreamTest, setup_Success)
{
    // 正常调用流程

    XpuDevice *device = new XpuDevice(1);
    device->deviceId_ = 1;
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;

    XpuArgManage *argManage = new XpuArgManage(stream);

    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    // 正常流程中的Mock
    MOCKER_CPP(&Bitmap::AllocId).stubs().will(returnValue(1));
    MOCKER_CPP_VIRTUAL(argManage, &XpuArgManage::CreateArgRes).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(stream, &XpuStream::CreateStreamTaskRes).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&XpuStream::CreateStreamArgRes).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&XpuStreamSqCqManage::AllocXpuStreamSqCq).stubs().with(mockcpp::any()).will(returnValue(RT_ERROR_NONE));

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStream::ReleaseStreamTaskRes).stubs();
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq)
        .stubs()
        .with(eq((uint32_t)1), eq((uint32_t)1))
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(stream->Setup(), RT_ERROR_NONE);
    DELETE_O(argManage);
    DELETE_O(stream);
    DELETE_O(device);
}

TEST_F(XpuStreamTest, setup_RT_ERROR_STREAM_DUPLICATE_Fail)
{
    // 正常调用流程

    XpuDevice *device = new XpuDevice(1);
    device->deviceId_ = 1;
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;

    XpuArgManage *argManage = new XpuArgManage(stream);

    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    // 正常流程中的Mock
    MOCKER_CPP(&Bitmap::AllocId).stubs().will(returnValue(1));
    MOCKER_CPP_VIRTUAL(argManage, &XpuArgManage::CreateArgRes).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(stream, &XpuStream::CreateStreamTaskRes).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&XpuStream::CreateStreamArgRes).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&XpuStreamSqCqManage::AllocXpuStreamSqCq)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(RT_ERROR_STREAM_DUPLICATE));

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStream::ReleaseStreamTaskRes).stubs();
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq)
        .stubs()
        .with(eq((uint32_t)1), eq((uint32_t)1))
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(stream->Setup(), RT_ERROR_STREAM_DUPLICATE);
    DELETE_O(argManage);
    DELETE_O(stream);
    DELETE_O(device);
}

void StreamRecycleUnlock_mock(Stream *This)
{
    This->recycleMutex_.unlock();
    dynamic_cast<TaskResManageDavid *>(This->taskResMang_)->taskResATail_.Set(0);
}

uint32_t TprtOpSqCqInfo_mock(uint32_t devId, TprtSqCqOpInfo_t *opInfo)
{
    opInfo->value[0] = 1U;
    return RT_ERROR_NONE;
}

TEST_F(XpuStreamTest, TearDown_Success)
{
    XpuDevice *device = new XpuDevice(1);
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;
    stream->sqId_ = 0U;
    XpuArgManage *argManage = new XpuArgManage(stream);
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    // 正常流程中的Mock
    MOCKER(TprtDeviceOpen).stubs().will(returnValue((uint32_t)RT_ERROR_NONE));
    MOCKER(TprtDeviceClose).stubs().will(returnValue((uint32_t)RT_ERROR_NONE));
    MOCKER(TprtOpSqCqInfo).stubs().will(invoke(TprtOpSqCqInfo_mock));
    MOCKER(TprtCqReportRecv).stubs().will(returnValue((uint32_t)TPRT_SUCCESS));
    MOCKER_CPP(&Stream::StreamRecycleUnlock).stubs().will(invoke(StreamRecycleUnlock_mock));

    device->InitXpuDriver();
    stream->SetFailureMode(ABORT_ON_FAILURE);

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStream::ReleaseStreamTaskRes).stubs();
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq)
        .stubs()
        .with(eq((uint32_t)1), eq((uint32_t)1))
        .will(returnValue(RT_ERROR_NONE));

    TaskResManageDavid *taskManage = new TaskResManageDavid();
    MOCKER_CPP_VIRTUAL(taskManage, &TaskResManageDavid::CreateTaskRes).stubs().will(returnValue(true));
    stream->CreateStreamTaskRes();
    dynamic_cast<TaskResManageDavid *>(stream->taskResMang_)->taskResATail_.Set(1);
    TaskRes* taskRes = new TaskRes();
    taskRes->taskInfo = TaskInfo();
    taskRes->copyDev = nullptr;
    taskRes->taskInfo.stream = stream;
    stream->taskResMang_->taskRes_ = taskRes;

    EXPECT_EQ(stream->TearDown(true, true), RT_ERROR_NONE);
    delete argManage;
    delete stream->taskResMang_;
    delete stream;
    delete device;
    delete taskManage;
    delete taskRes;
}

TEST_F(XpuStreamTest, tprtOpSqCqInfo_error_mock)
{
    XpuDevice *device = new XpuDevice(1);
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;
    stream->sqId_ = 0U;
    XpuArgManage *argManage = new XpuArgManage(stream);
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    // 正常流程中的Mock
    MOCKER(TprtDeviceOpen).stubs().will(returnValue((uint32_t)RT_ERROR_NONE));
    MOCKER(TprtDeviceClose).stubs().will(returnValue((uint32_t)RT_ERROR_NONE));
    MOCKER(TprtOpSqCqInfo).stubs().will(returnValue(TPRT_INPUT_INVALID));
    MOCKER(TprtCqReportRecv).stubs().will(returnValue((uint32_t)TPRT_SUCCESS));
    MOCKER_CPP(&Stream::StreamRecycleUnlock).stubs().will(invoke(StreamRecycleUnlock_mock));

    device->InitXpuDriver();
    stream->SetFailureMode(ABORT_ON_FAILURE);

    // 析构流程中的函数Mock
    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStream::ReleaseStreamTaskRes).stubs();
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq)
        .stubs()
        .with(eq((uint32_t)1), eq((uint32_t)1))
        .will(returnValue(RT_ERROR_NONE));

    TaskResManageDavid *taskManage = new TaskResManageDavid();
    MOCKER_CPP_VIRTUAL(taskManage, &TaskResManageDavid::CreateTaskRes).stubs().will(returnValue(true));
    stream->CreateStreamTaskRes();
    dynamic_cast<TaskResManageDavid *>(stream->taskResMang_)->taskResATail_.Set(1);
    TaskRes* taskRes = new TaskRes();
    taskRes->taskInfo = TaskInfo();
    taskRes->copyDev = nullptr;
    taskRes->taskInfo.stream = stream;
    stream->taskResMang_->taskRes_ = taskRes;

    EXPECT_EQ(stream->TearDown(true, true), RT_ERROR_DRV_INPUT);
    delete argManage;
    delete stream->taskResMang_;
    delete stream;
    delete device;
    delete taskManage;
    delete taskRes;
}

TEST_F(XpuStreamTest, xpu_stream_launch_kernel_recycle_error)
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
    DavidArgLoaderResult result1 = {nullptr, nullptr, (void *)10, UINT32_MAX};
    TaskInfo *taskInfo = nullptr;
    MOCKER_CPP_VIRTUAL(((XpuStream *)(context->StreamList_().front()))->ArgManagePtr(), &XpuArgManage::RecycleDevLoader).stubs();
    XpuStreamLaunchKernelRecycleAicpu(result1, taskInfo, context->StreamList_().front());
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
}

TEST_F(XpuStreamTest, stars_add_task_to_stream_error)
{
    XpuDevice *device = new XpuDevice(1);
    XpuStream *stream = new XpuStream(device, RT_STREAM_DEFAULT);
    stream->streamId_ = 1;
    stream->sqId_ = 0U;
    XpuArgManage *argManage = new XpuArgManage(stream);
    XpuStreamSqCqManage *stmSqCqManage = new XpuStreamSqCqManage(device);
    device->streamSqCqManage_ = stmSqCqManage;

    MOCKER_CPP(&XpuDevice::FreeStreamIdBitmap).stubs().with(eq(1));
    MOCKER_CPP(&XpuStream::ReleaseStreamTaskRes).stubs();
    MOCKER_CPP(&XpuStreamSqCqManage::DeAllocXpuStreamSqCq)
        .stubs()
        .with(eq((uint32_t)1), eq((uint32_t)1))
        .will(returnValue(RT_ERROR_NONE));
    TaskInfo * tsk;
    MOCKER_CPP_VIRTUAL(stream, &XpuStream::AddTaskToList).stubs().will(returnValue(1));
    stream->StarsAddTaskToStream(tsk, 100);
    delete argManage;
    delete stream->taskResMang_;
    delete stream;
    delete device;
}

TEST_F(XpuStreamTest, get_cur_sq_pos)
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
    DavidArgLoaderResult result1 = {nullptr, nullptr, (void *)10, UINT32_MAX};
    TaskInfo *taskInfo = nullptr;
    ((XpuStream *)(context->StreamList_().front()))->GetCurSqPos();
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
}


TEST_F(XpuStreamTest, david_update_public_queue)
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
    ((XpuStream *)(context->StreamList_().front()))->DavidUpdatePublicQueue();
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
}

TEST_F(XpuStreamTest, Is_exist_cqe)
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
    MOCKER_CPP_VIRTUAL((XpuDriver *)context->Device_()->Driver_(), &XpuDriver::GetCqeStatus).stubs().will(returnValue(1));
    DavidArgLoaderResult result1 = {nullptr, nullptr, (void *)10, UINT32_MAX};
    TaskInfo *taskInfo = nullptr;
    ((XpuStream *)(context->StreamList_().front()))->IsExistCqe();
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
}

TEST_F(XpuStreamTest, arg_release_single_task)
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
    XpuStream *stream = ((XpuStream *)(context->StreamList_().front()));
    TaskInfo *taskInfo = new TaskInfo();
    taskInfo->id = 0;
    taskInfo->stmArgPos = 1;
    MOCKER_CPP(&DavidArgManage::RecycleStmArgPos).stubs().will(returnValue(false));
    stream->ArgReleaseSingleTask(taskInfo, true);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete taskInfo;
    delete result;
}
