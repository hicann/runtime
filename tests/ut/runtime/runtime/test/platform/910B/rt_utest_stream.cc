/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <stdlib.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "engine.hpp"
#include "event.hpp"
#include "task_res.hpp"
#include "ctrl_stream.hpp"
#include "coprocessor_stream.hpp"
#include "tsch_stream.hpp"
#include "engine_stream_observer.hpp"
#include "stream_sqcq_manage.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "raw_device.hpp"
#include "task_info.hpp"
#include "async_hwts_engine.hpp"
#undef private
#undef protected
#include "ffts_task.h"
#include "context.hpp"
#include "securec.h"
#include "api.hpp"
#include "npu_driver.hpp"
#include "task_submit.hpp"
#include "capture_model_utils.hpp"
#include "thread_local_container.hpp"
#include "capture_adapt.hpp"
using namespace testing;
using namespace cce::runtime;

static uint16_t ind = 0;

class CloudV2StreamTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"CloudV2StreamTest start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"CloudV2StreamTest end"<<std::endl;
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
        rtError_t error;
        Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);

        GlobalContainer::SetHardwareChipType(CHIP_END);
        std::cout<<"ut test start."<<std::endl;
    }

    virtual void TearDown()
    {
        std::cout<<"ut test end."<<std::endl;
        ind = 0;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);
    }

public:
    static Api        *oldApi_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
private:
    rtChipType_t originType;
};

Api * CloudV2StreamTest::oldApi_ = nullptr;
rtEvent_t CloudV2StreamTest::event_ = nullptr;
void* CloudV2StreamTest::binHandle_ = nullptr;
char  CloudV2StreamTest::function_ = 'a';
uint32_t CloudV2StreamTest::binary_[32] = {};

class SubmitFailSchedulerT : public FifoScheduler
{
public:
    Scheduler *test;

    void set(Scheduler *fifoScheduler)
    {
        test = fifoScheduler;
    }

    virtual rtError_t PushTask(TaskInfo *task)
    {
        std::cout << "PushTask begin taskType = " << task->type << "ind = " << ind << std::endl;
        if (0 == ind)
        {
            ind = 1;
            std::cout << "PushTask begin taskType = " << task->type << "ind = " << ind << std::endl;
            return  test->PushTask(task);
            // return  FifoScheduler::PushTask(task);
        }
        return RT_ERROR_INVALID_VALUE;
    }

    virtual TaskInfo * PopTask()
    {
        return test->PopTask();
    }
};

static void ApiTest_Stream_Cb(void *arg)
{
}

TEST_F(CloudV2StreamTest, stream_set_attribute2)
{
    const bool olgFlag = Runtime::Instance()->GetDisableThread();
    Runtime::Instance()->SetDisableThread(true);
    rtStream_t stream;
    rtError_t error;
    rtStreamAttrValue_t value;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    value.failureMode = RT_STREAM_FAILURE_MODE_CONTINUE_ON_FAILURE; // 假设这是一个有效的失败模式值

    // 创建流
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // 设置属性
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_FAILURE_MODE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);

    value.overflowSwitch = false; // 关闭溢出检测
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    value.userCustomTag = 0; // 不使用自定义标签
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_USER_CUSTOM_TAG, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_MAX, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_MAX, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // 销毁流
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    Runtime::Instance()->SetDisableThread(olgFlag);
}


TEST_F(CloudV2StreamTest, stream_get_attribute2)
{
    const bool olgFlag = Runtime::Instance()->GetDisableThread();
    Runtime::Instance()->SetDisableThread(true);
    rtError_t error;
    rtStreamAttrValue_t setvalue;
    rtStreamAttrValue_t stmModeRet;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);

    Stream *stream = nullptr;
    error = rtsStreamGetAttribute(stream, RT_STREAM_ATTR_MAX, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsStreamGetAttribute(nullptr, RT_STREAM_ATTR_MAX, &stmModeRet);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    stream = static_cast<Stream *>(stm);

    setvalue.failureMode = RT_STREAM_FAILURE_MODE_CONTINUE_ON_FAILURE; // 假设这是一个有效的失败模式值
    error = rtsStreamSetAttribute(stm, RT_STREAM_ATTR_FAILURE_MODE, &setvalue);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsStreamGetAttribute(stm, RT_STREAM_ATTR_FAILURE_MODE, &stmModeRet);
    EXPECT_EQ(stmModeRet.failureMode, RT_STREAM_FAILURE_MODE_CONTINUE_ON_FAILURE);

    setvalue = {0};
    setvalue.overflowSwitch = true; // 关闭溢出检测
    error = rtsStreamSetAttribute(stm, RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK, &setvalue);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    stmModeRet = {0};
    error = rtsStreamGetAttribute(stm, RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK, &stmModeRet);
    EXPECT_EQ(stmModeRet.overflowSwitch, 0);

    setvalue = {0};
    setvalue.userCustomTag = 0; // 关闭溢出检测
    error = rtsStreamSetAttribute(stm, RT_STREAM_ATTR_USER_CUSTOM_TAG, &setvalue);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stmModeRet = {0};
    error = rtsStreamGetAttribute(stm, RT_STREAM_ATTR_USER_CUSTOM_TAG, &stmModeRet);
    EXPECT_EQ(stmModeRet.userCustomTag, 0);

    error = rtStreamDestroy(stm);
    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    Runtime::Instance()->SetDisableThread(olgFlag);
}

TEST_F(CloudV2StreamTest, rtsLaunchHostFunc01)
{
    const bool olgFlag = Runtime::Instance()->GetDisableThread();
    Runtime::Instance()->SetDisableThread(true);
    rtError_t error;
    rtStream_t stream;
    uint32_t cqId = 0;
    uint32_t sqId = 0;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchHostFunc(stream, ApiTest_Stream_Cb, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLaunchHostFunc(stream, ApiTest_Stream_Cb, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamSynchronize(stream);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime::Instance()->SetDisableThread(olgFlag);
}

TEST_F(CloudV2StreamTest, Query_test)
{
    const bool olgFlag = Runtime::Instance()->GetDisableThread();

    std::unique_ptr<RawDevice> device = std::make_unique<RawDevice>(0);
    device->Init();
    std::unique_ptr<Stream> stream = std::make_unique<Stream>(device.get(), 0);

    Runtime::Instance()->SetDisableThread(true);
    rtPlatformType_t oldPlatForm = device->platformType_;
    uint16_t sqHead = 0U;
    uint16_t sqTail = 1U;
    device->platformType_ = PLATFORM_CLOUD_V2;
    rtError_t ret = stream->Query();
    EXPECT_NE(ret, RT_ERROR_NONE);

    device->platformType_ = oldPlatForm;
    Runtime::Instance()->SetDisableThread(olgFlag);
    GlobalMockObject::verify();
}

TEST_F(CloudV2StreamTest, TestIsTaskLimitedWithTaskFinished)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    Stream stream(device, 0);
    stream.waitTaskList_.push_back(512);
    TaskInfo task = {};
    bool ret = stream.IsTaskLimited(&task);
    ASSERT_EQ(ret, false);
}

TEST_F(CloudV2StreamTest, TestIsTaskLimitedWithTaskTypeUnexpected)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    Stream stream(device, 0);
    stream.waitTaskList_.push_back(512);
    TaskInfo aicoreTask = {};
    aicoreTask.type = TS_TASK_TYPE_KERNEL_AICORE;
    MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&aicoreTask));
    TaskInfo task = {};
    bool ret = stream.IsTaskLimited(&task);
    ASSERT_EQ(ret, false);
}

TEST_F(CloudV2StreamTest, EngineStreamObserver_TaskSubmited)
{
    MOCKER_CPP(&Stream::ProcL2AddrTask).stubs().will(returnValue(RT_ERROR_NONE));
    std::shared_ptr<RawDevice> device = std::make_shared<RawDevice>(0);
    MOCKER_CPP_VIRTUAL(device.get(), &RawDevice::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    device->Init();
    std::shared_ptr<Stream> stream = std::make_shared<Stream>(device.get(), 0);
    stream->SetNeedSubmitTask(true);
    std::shared_ptr<Model> model = std::make_shared<Model>();
    stream->SetModel(model.get());
    stream->SetLatestModlId(model.get()->Id_());
    TaskInfo task = {0};
    task.stream = stream.get();

    std::shared_ptr<EngineStreamObserver> streamObserver = std::make_shared<EngineStreamObserver>();
    EXPECT_EQ(stream->GetPendingNum(), 0);
    streamObserver->TaskSubmited(device.get(), &task);
    EXPECT_EQ(stream->GetPendingNum(), 1);
}

TEST_F(CloudV2StreamTest, rtGetAvailStreamNum)
{
    rtError_t error;
    uint32_t avaliStrCount;

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtGetAvailStreamNum(RT_HUGE_STREAM, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_HUGE_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halResourceInfoQuery)
        .stubs()
        .will(returnValue(code));
    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}