/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
#include "runtime/rt.h"
#include "context.hpp"
#include "raw_device.hpp"
#include "event.hpp"
#include "runtime.hpp"
#include "api_impl.hpp"
#include "stream.hpp"
#include "task_info.hpp"
#include "kernel_utils.hpp"
#include <string>
#undef private

using namespace testing;
using namespace cce::runtime;

class CloudV2ApiImpltaskOwnerTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        std::cout << "CloudV2ApiImpltaskOwnerTest test start start. " << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "CloudV2ApiImpltaskOwnerTest test start end. " << std::endl;
    }

    virtual void SetUp()
    {
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        (void)rtSetDevice(0);
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        
        rtInstance_ = const_cast<Runtime *>(Runtime::Instance());
        device_ = rtInstance_->DeviceRetain(0, 0);
        ASSERT_NE(device_, nullptr);

        context_ = new Context(device_, false);
        context_->Init();
        
        stream_ = new Stream(context_, 0);
        stream_->SetContext(context_);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        
        if (stream_ != nullptr) {
            delete stream_;
            stream_ = nullptr;
        }
        
        if (context_ != nullptr) {
            delete context_;
            context_ = nullptr;
        }
        
        if (device_ != nullptr) {
            device_->WaitCompletion();
            rtInstance_->DeviceRelease(device_);
            device_ = nullptr;
        }
        
        rtDeviceReset(0);
    }

    Runtime *rtInstance_{nullptr};
    Device *device_{nullptr};
    Context *context_{nullptr};
    Stream *stream_{nullptr};
};

TEST_F(CloudV2ApiImpltaskOwnerTest, EventOwner_SetAndGet)
{
    Event event(device_, 0, context_);
    
    EXPECT_EQ(event.EventOwner_(), EventOwner::EVENT_UNKNOWN);
    
    event.SetEventOwner(EventOwner::EVENT_USER);
    EXPECT_EQ(event.EventOwner_(), EventOwner::EVENT_USER);
    
    event.SetEventOwner(EventOwner::EVENT_INNER);
    EXPECT_EQ(event.EventOwner_(), EventOwner::EVENT_INNER);
    
    event.SetEventOwner(EventOwner::EVENT_UNKNOWN);
    EXPECT_EQ(event.EventOwner_(), EventOwner::EVENT_UNKNOWN);
}

TEST_F(CloudV2ApiImpltaskOwnerTest, EventResetTask_InheritEventOwner)
{
    Event innerEvent(device_, 0, context_);
    innerEvent.SetEventOwner(EventOwner::EVENT_INNER);
    
    Event userEvent(device_, 0, context_);
    userEvent.SetEventOwner(EventOwner::EVENT_USER);

    TaskInfo innerTaskInfo;
    TaskInfo userTaskInfo;
    (void)memset_s(&innerTaskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    (void)memset_s(&userTaskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    innerTaskInfo.stream = stream_;
    userTaskInfo.stream = stream_;

    innerTaskInfo.taskOwner = TaskOwner::RT_TASK_USER;
    userTaskInfo.taskOwner = TaskOwner::RT_TASK_USER;

    rtError_t ret = EventResetTaskInit(&innerTaskInfo, &innerEvent, false, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(innerTaskInfo.taskOwner, TaskOwner::RT_TASK_INNER);

    ret = EventResetTaskInit(&userTaskInfo, &userEvent, false, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(userTaskInfo.taskOwner, TaskOwner::RT_TASK_USER);
}

TEST_F(CloudV2ApiImpltaskOwnerTest, EventWaitTask_InheritEventOwner)
{
    Event innerEvent(device_, 0, context_);
    innerEvent.SetEventOwner(EventOwner::EVENT_INNER);
    
    Event userEvent(device_, 0, context_);
    userEvent.SetEventOwner(EventOwner::EVENT_USER);

    TaskInfo innerTaskInfo;
    TaskInfo userTaskInfo;
    (void)memset_s(&innerTaskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    (void)memset_s(&userTaskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    innerTaskInfo.stream = stream_;
    userTaskInfo.stream = stream_;

    innerTaskInfo.taskOwner = TaskOwner::RT_TASK_USER;
    userTaskInfo.taskOwner = TaskOwner::RT_TASK_USER;

    rtError_t ret = EventWaitTaskInit(&innerTaskInfo, &innerEvent, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(innerTaskInfo.taskOwner, TaskOwner::RT_TASK_INNER);

    ret = EventWaitTaskInit(&userTaskInfo, &userEvent, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(userTaskInfo.taskOwner, TaskOwner::RT_TASK_USER);
}

TEST_F(CloudV2ApiImpltaskOwnerTest, TaskGetParams_InnerTaskReturnsDefaultType)
{
    TaskInfo innerTaskInfo;
    TaskInfo userTaskInfo;
    (void)memset_s(&innerTaskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    (void)memset_s(&userTaskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    innerTaskInfo.stream = stream_;
    userTaskInfo.stream = stream_;

    innerTaskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    userTaskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    
    innerTaskInfo.taskOwner = TaskOwner::RT_TASK_INNER;
    userTaskInfo.taskOwner = TaskOwner::RT_TASK_USER;

    ApiImpl apiImpl;
    rtTaskParams innerParams;
    rtTaskParams userParams;
    (void)memset_s(&innerParams, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    (void)memset_s(&userParams, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));

    rtError_t ret = apiImpl.TaskGetParams(&innerTaskInfo, &innerParams);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(CloudV2ApiImpltaskOwnerTest, ConvertTaskType_InnerTaskReturnsDefaultType)
{
    TaskInfo innerTaskInfo;
    TaskInfo userTaskInfo;
    (void)memset_s(&innerTaskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    (void)memset_s(&userTaskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    innerTaskInfo.stream = stream_;
    userTaskInfo.stream = stream_;

    innerTaskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    userTaskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    
    innerTaskInfo.taskOwner = TaskOwner::RT_TASK_INNER;
    userTaskInfo.taskOwner = TaskOwner::RT_TASK_USER;

    rtTaskType innerTaskType;
    rtTaskType userTaskType;

    rtError_t ret = ConvertTaskType(&innerTaskInfo, &innerTaskType);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(innerTaskType, rtTaskType::RT_TASK_DEFAULT);

    ret = ConvertTaskType(&userTaskInfo, &userTaskType);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(userTaskType, rtTaskType::RT_TASK_DEFAULT);
}