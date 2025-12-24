/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime/rt.h"
#include "event.hpp"
#include "gtest/gtest.h"
#include "stars.hpp"
#include "hwts.hpp"
#include "npu_driver.hpp"
#include "event.hpp"
#include "subscribe.hpp"
#include "config_define.hpp"
#include "task_res.hpp"
#include "raw_device.hpp"
#include "stars_engine.hpp"
#include <thread>
#include <chrono>
#include "stream.hpp"
#include "runtime.hpp"
#include "config.hpp"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "osal.hpp"
#include "api.hpp"
#include "thread_local_container.hpp"
using namespace testing;
using namespace cce::runtime;

class TaskResManageTest : public testing::Test
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
        std::cout << "TaskResManageTest SetUp start" << std::endl;
        rtSetDevice(0);
        std::cout << "TaskResManageTest SetUp end" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "TaskResManageTest TearDown start" << std::endl;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout << "TaskResManageTest TearDown end" << std::endl;
    }
};

TEST_F(TaskResManageTest, TestUpdateAddrField)
{
    rtHostInputInfo hostInputInfo = {0};
    uint32_t kerArgs[128];
    uint32_t argsHostAddr[128];
    TaskResManage *taskResMng = new (std::nothrow) TaskResManage;
    taskResMng->UpdateAddrField(kerArgs, argsHostAddr, 1, &hostInputInfo);
    EXPECT_NE(kerArgs, nullptr);
    delete taskResMng;
}

TEST_F(TaskResManageTest, TestLoadInputOutputArgs)
{
    TaskResManage *taskResMng = new (std::nothrow) TaskResManage;
    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    bool ret = taskResMng->CreateTaskRes(static_cast<Stream *>(stream));
    EXPECT_EQ(ret, true);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    rtHostInputInfo_t hostInputInfo = {};
    rtArgsEx_t argsInfo = {};
    uint32_t args[128];
    argsInfo.args = args;
    argsInfo.hostInputInfoPtr = &hostInputInfo;
    argsInfo.hasTiling = 1U;
    uint32_t taskResId;
    ret = taskResMng->AllocTaskResId(taskResId);
    void *kerArgs = static_cast<void *>(args);
    error = taskResMng->LoadInputOutputArgs(static_cast<Stream *>(stream), kerArgs, taskResId, 4, (void *)args, &argsInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    taskResMng->ReleaseTaskResource(static_cast<Stream *>(stream));
    rtStreamDestroy(stream);
    delete taskResMng;
}

TEST_F(TaskResManageTest, TestLoadInputOutputArgsWithAicpuArgs)
{
    TaskResManage *taskResMng = new (std::nothrow) TaskResManage;
    rtStream_t stream = nullptr;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    bool ret = taskResMng->CreateTaskRes(static_cast<Stream *>(stream));
    EXPECT_EQ(ret, true);
    MOCKER(memcpy_s).stubs().will(returnValue(0));
    rtHostInputInfo_t hostInputInfo = {};
    rtAicpuArgsEx_t argsInfo = {};
    uint32_t args[128];
    argsInfo.args = args;
    argsInfo.hostInputInfoPtr = &hostInputInfo;
    argsInfo.kernelOffsetInfoPtr = &hostInputInfo;
    uint32_t taskResId;
    ret = taskResMng->AllocTaskResId(taskResId);
    void *kerArgs = static_cast<void *>(args);
    error = taskResMng->LoadInputOutputArgs(static_cast<Stream *>(stream), kerArgs, taskResId, 4, (void *)args, &argsInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    taskResMng->ReleaseTaskResource(static_cast<Stream *>(stream));
    rtStreamDestroy(stream);
    delete taskResMng;
}

TEST_F(TaskResManageTest, TestFreePcieBarBuffer)
{
    TaskResManage *taskResMng = new (std::nothrow) TaskResManage;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostUnRegister)
        .stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemFree)
        .stubs().will(returnValue(RT_ERROR_NONE));
    uint32_t tmpVal;
    taskResMng->FreePcieBarBuffer(&tmpVal, device);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    EXPECT_NE(&tmpVal, nullptr);
    delete taskResMng;
}

TEST_F(TaskResManageTest, TestMallocPcieBarBufferWithDevMemAllocFailed)
{
    TaskResManage *taskResMng = new (std::nothrow) TaskResManage;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy).stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    void *ret = taskResMng->MallocPcieBarBuffer(0, device, true);
    EXPECT_EQ(ret, nullptr);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    delete taskResMng;
}

TEST_F(TaskResManageTest, TestMallocPcieBarBufferWithPcieHostRegisterFailed)
{
    TaskResManage *taskResMng = new (std::nothrow) TaskResManage;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    uint32_t support = RT_CAPABILITY_SUPPORT;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::CheckSupportPcieBarCopy).stubs()
        .with(mockcpp::any(), outBound(support), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    void *ret = taskResMng->MallocPcieBarBuffer(0, device, true);
    EXPECT_EQ(ret, nullptr);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    delete taskResMng;
}

TEST_F(TaskResManageTest, TestAllocTaskResIdFailed)
{
    uint32_t taskResId = 0;
    TaskResManage *taskResMng = new (std::nothrow) TaskResManage;
    taskResMng->taskResHead_ = 1;
    bool ret = taskResMng->AllocTaskResId(taskResId);
    EXPECT_EQ(ret, false);
    delete taskResMng;
}

TEST_F(TaskResManageTest, TestEventRecordWithStreamFastLaunch)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_FAST_LAUNCH);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamWaitEvent(stream, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(TaskResManageTest, streamSyncFailed)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_FAST_LAUNCH);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamWaitEvent(stream, event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    error = ((Stream*)stream)->Synchronize(true, 1);
    GlobalMockObject::verify();
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(TaskResManageTest, FastErrorProcess1)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_FAST_LAUNCH);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER_CPP_VIRTUAL(((Stream *)stream)->Device_(), &Device::GetDevStatus)
    .stubs()
    .will(returnValue(RT_ERROR_NONE))
    .then(returnValue(RT_ERROR_LOST_HEARTBEAT));

    ((Stream *)stream)->SetLimitFlag(true);
    Engine* engine = (Engine*)(((RawDevice*)(((Stream *)stream)->Device_()))->Engine_());
    MOCKER_CPP_VIRTUAL(engine, &Engine::TryRecycleTask).stubs().with(mockcpp::any()).will(returnValue(RT_ERROR_NONE));
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_LOST_HEARTBEAT);
    ((Stream *)stream)->SetLimitFlag(false);

    GlobalMockObject::verify();

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(TaskResManageTest, FastErrorProcess2)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_FAST_LAUNCH);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ((Stream *)stream)->abortStatus_ = RT_ERROR_STREAM_ABORT;
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_ABORT);
    ((Stream *)stream)->abortStatus_ = RT_ERROR_NONE;

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(TaskResManageTest, FastErrorProcess3)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_FAST_LAUNCH);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(WaitAsyncCopyComplete).stubs().will(returnValue(RT_ERROR_LOST_HEARTBEAT));
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_LOST_HEARTBEAT);
    GlobalMockObject::verify();

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(TaskResManageTest, FastErrorProcess4)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_FAST_LAUNCH);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER_CPP_VIRTUAL(((Stream *)stream), &Stream::PrintStmDfxAndCheckDevice).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    MOCKER(halSqTaskSend).stubs().will(returnValue(DRV_ERROR_IOCRL_FAIL));
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_DRV_INTERNAL_ERROR);
    GlobalMockObject::verify();

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(TaskResManageTest, FastErrorProcess5)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreateWithFlags(&stream, 0, RT_STREAM_FAST_LAUNCH);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER_CPP(&StarsEngine::AddTaskToStream).stubs().will(returnValue(RT_ERROR_LOST_HEARTBEAT));
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_LOST_HEARTBEAT);
    GlobalMockObject::verify();

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}