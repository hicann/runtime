/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <malloc.h>
#include <stdio.h>
#include <cstdio>
#include <stdlib.h>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "context.hpp"
#include "context_protect.hpp"
#include "raw_device.hpp"
#include "kernel.hpp"
#include "module.hpp"
#include "stream.hpp"
#include "task_info.hpp"
#include "arg_loader.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "npu_driver.hpp"
#include "api.hpp"
#include "task_submit.hpp"
#include "task.hpp"
#include "task_res.hpp"
#include "thread_local_container.hpp"
#include "runtime_keeper.h"
#include "memory_task.h"
#undef protected
#undef private
#include "ffts_task.h"

using namespace testing;
using namespace cce::runtime;

class ContextTest910B : public testing::Test
{
protected:
    static void SetUpTestCase()
    {

    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {
        std::cout << "ContextTest SetUp" << std::endl;
        rtSetDevice(0);
        std::cout << "ContextTest SetUp end" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "ContextTest TearDown" << std::endl;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout << "ContextTest TearDown end" << std::endl;
    }
};

TEST_F(ContextTest910B, kernel_task_config_test)
{
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    ctx = refObject->GetVal();

    TaskInfo *task = (TaskInfo *)malloc(sizeof(TaskInfo));
    task->type = TS_TASK_TYPE_KERNEL_AICPU;
    ArgLoaderResult* result = (ArgLoaderResult *)malloc(sizeof(ArgLoaderResult));
    error = ctx->KernelTaskConfig(task, nullptr, nullptr, result, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(task);
    free(result);
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ContextTest910B, DebugSetDumpMode_test)
{
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    ctx = refObject->GetVal();
    Device* dev = ((Runtime *)Runtime::Instance())->GetDevice(devId, 0);

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DebugSqCqAllocate).stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DebugSqTaskSend).stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DebugCqReport).stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev, &Device::CheckFeatureSupport).stubs()
        .will(returnValue(true));

    error = ctx->DebugSetDumpMode(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ContextTest910B, DebugGetStalledCore_test)
{
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    ctx = refObject->GetVal();
    Device* dev = ((Runtime *)Runtime::Instance())->GetDevice(devId, 0);
    dev->SetCoredumpEnable();

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DebugSqTaskSend).stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DebugCqReport).stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtDbgCoreInfo_t *info = (rtDbgCoreInfo_t *)malloc(sizeof(rtDbgCoreInfo_t));
    error = ctx->DebugGetStalledCore(info);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(info);
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ContextTest910B, DebugReadAICore_invalid_param)
{
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    ctx = refObject->GetVal();
    Device* dev = ((Runtime *)Runtime::Instance())->GetDevice(devId, 0);

    MOCKER_CPP_VIRTUAL(dev, &Device::IsCoredumpEnable).stubs()
        .will(returnValue(true));

    rtDebugMemoryParam_t *param = (rtDebugMemoryParam_t *)malloc(sizeof(rtDebugMemoryParam_t));
    param->debugMemType = RT_MEM_TYPE_REGISTER;
    param->memLen = 1;
    param->srcAddr = 0;
    error = ctx->DebugReadAICore(param);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    free(param);
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ContextTest910B, CheckStatus_test)
{
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    ctx = refObject->GetVal();
    Device* dev = ((Runtime *)Runtime::Instance())->GetDevice(devId, 0);
    dev->SetDevStatus(0);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stmPtr = static_cast<Stream *>(stm);

    stmPtr->failureMode_ = CONTINUE_ON_FAILURE;
    ctx->streams_.push_back(stmPtr);

    MOCKER_CPP_VIRTUAL(dev, &Device::ProcessReportFastRingBuffer).stubs()
        .will(returnValue(NULL));

    error = ctx->CheckStatus(stmPtr, false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stm);
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ContextTest910B, task_group_create)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskGrp(nullptr, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamEndTaskGrp(stream1, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamEndTaskGrp(nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDebugDotPrint(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ContextTest910B, TaskReclaimforSyncDevice_test_timeout)
{
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    ctx = refObject->GetVal();

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    Stream *stmPtr = static_cast<Stream *>(stm);
    stmPtr->failureMode_ = STOP_ON_FAILURE;
    stmPtr->flags_ = 0;
    ctx->streams_.push_back(stmPtr);

    Device* dev = ((Runtime *)Runtime::Instance())->GetDevice(devId, 0);
    MOCKER_CPP_VIRTUAL(dev, &Device::TaskReclaim).stubs()
        .will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    MOCKER_CPP_VIRTUAL(stmPtr, &Stream::IsSeparateSendAndRecycle).stubs()
        .will(returnValue(false));

    error = ctx->TaskReclaimforSyncDevice(1, -1);
    EXPECT_NE(error, RT_ERROR_NONE);
    ctx->streams_.clear();

    rtStreamDestroy(stm);
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}
