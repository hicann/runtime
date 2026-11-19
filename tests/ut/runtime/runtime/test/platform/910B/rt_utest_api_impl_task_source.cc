/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/enum_log.hpp"
#include "runtime/base.h"
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
#include "event_task.h"
#include "memory_task.h"
#include "capture_model.hpp"
#include "model/capture_model_utils.hpp"
#include <string>
#undef private

void ClearLastDlogRecordLine();
bool DlogRecordContains(const std::string& keyword);

using namespace testing;
using namespace cce::runtime;

class CloudV2ApiImpltaskOwnerTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        RawDevice* rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        std::cout << "CloudV2ApiImpltaskOwnerTest test start start. " << std::endl;
    }

    static void TearDownTestCase() { std::cout << "CloudV2ApiImpltaskOwnerTest test start end. " << std::endl; }

    virtual void SetUp()
    {
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
        (void)rtSetDevice(0);
        RawDevice* rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;

        rtInstance_ = const_cast<Runtime*>(Runtime::Instance());
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

    Runtime* rtInstance_{nullptr};
    Device* device_{nullptr};
    Context* context_{nullptr};
    Stream* stream_{nullptr};
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

    innerTaskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);
    userTaskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);

    rtError_t ret = EventResetTaskInit(&innerTaskInfo, &innerEvent, false, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(innerTaskInfo.taskOwner, static_cast<uint8_t>(TaskOwner::RT_TASK_INNER));

    ret = EventResetTaskInit(&userTaskInfo, &userEvent, false, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(userTaskInfo.taskOwner, static_cast<uint8_t>(TaskOwner::RT_TASK_USER));
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

    innerTaskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);
    userTaskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);

    rtError_t ret = EventWaitTaskInit(&innerTaskInfo, &innerEvent, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(innerTaskInfo.taskOwner, static_cast<uint8_t>(TaskOwner::RT_TASK_INNER));

    ret = EventWaitTaskInit(&userTaskInfo, &userEvent, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(userTaskInfo.taskOwner, static_cast<uint8_t>(TaskOwner::RT_TASK_USER));
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

    innerTaskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    userTaskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);

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

    innerTaskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    userTaskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);

    rtTaskType innerTaskType;
    rtTaskType userTaskType;

    rtError_t ret = ConvertTaskType(&innerTaskInfo, &innerTaskType);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(innerTaskType, rtTaskType::RT_TASK_DEFAULT);

    ret = ConvertTaskType(&userTaskInfo, &userTaskType);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(userTaskType, rtTaskType::RT_TASK_DEFAULT);
}

TEST_F(CloudV2ApiImpltaskOwnerTest, TaskGetParams_UnknownTaskType_DefaultCase)
{
    MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(returnValue(RT_ERROR_NONE));

    Model* model = nullptr;
    ASSERT_EQ(context_->ModelCreate(&model, RT_MODEL_CAPTURE_MODEL), RT_ERROR_NONE);
    CaptureModel* const captureModel = dynamic_cast<CaptureModel*>(model);
    ASSERT_NE(captureModel, nullptr);
    stream_->SetModel(captureModel);
    TaskInfo taskInfo;
    (void)memset_s(&taskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    taskInfo.stream = stream_;
    taskInfo.type = static_cast<tsTaskType_t>(0xFFFF); // Unknown task type to trigger default case
    taskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);
    taskInfo.typeName = "UNKNOWN_TYPE";

    ApiImpl apiImpl;
    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));

    rtError_t ret = apiImpl.TaskGetParams(&taskInfo, &params);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    stream_->SetModel(nullptr);
    EXPECT_EQ(context_->ModelDestroy(model), RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImpltaskOwnerTest, ConvertTaskType_CaptureExternalRecordReturnsEventRecord)
{
    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);
    taskInfo.typeName = "CAPTURE_RECORD_EXTERNAL";

    rtTaskType taskType = RT_TASK_DEFAULT;
    EXPECT_EQ(ConvertTaskType(&taskInfo, &taskType), RT_ERROR_NONE);
    EXPECT_EQ(taskType, RT_TASK_EVENT_RECORD);
}

TEST_F(CloudV2ApiImpltaskOwnerTest, TaskGetParams_CaptureExternalRecordReturnsExternalEventParams)
{
    MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(returnValue(RT_ERROR_NONE));

    Model* model = nullptr;
    ASSERT_EQ(context_->ModelCreate(&model, RT_MODEL_CAPTURE_MODEL), RT_ERROR_NONE);
    CaptureModel* const captureModel = dynamic_cast<CaptureModel*>(model);
    ASSERT_NE(captureModel, nullptr);
    stream_->SetModel(captureModel);
    Event event(device_, RT_EVENT_DDSYNC_NS, context_);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);
    taskInfo.typeName = "CAPTURE_RECORD_EXTERNAL";
    taskInfo.u.writeValTask.event = &event;

    ApiImpl apiImpl;
    rtTaskParams params = {};
    EXPECT_EQ(apiImpl.TaskGetParams(&taskInfo, &params), RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_RECORD);
    EXPECT_EQ(params.eventRecordTaskParams.event, event.GetInnerHandle());
    EXPECT_EQ(params.eventRecordTaskParams.eventFlag, RT_EVENT_DDSYNC_NS);
    EXPECT_EQ(params.eventRecordTaskParams.recordFlag, RT_EVENT_RECORD_EXTERNAL);
    stream_->SetModel(nullptr);
    EXPECT_EQ(context_->ModelDestroy(model), RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImpltaskOwnerTest, CacheWriteValueTaskParams_CaptureExternalRecordReturnsInvalidValue)
{
    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);
    taskInfo.typeName = "CAPTURE_RECORD_EXTERNAL";

    rtTaskParams params = {};
    params.type = RT_TASK_VALUE_WRITE;
    EXPECT_EQ(CacheWriteValueTaskParams(&taskInfo, &params), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(taskInfo.type, TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL);
}

TEST_F(CloudV2ApiImpltaskOwnerTest, ModelTaskDisable_CaptureExternalRecordSetsModelFault)
{
    MOCKER(CheckCaptureModelForUpdate).stubs().will(returnValue(RT_ERROR_NONE));

    Model* model = nullptr;
    ASSERT_EQ(context_->ModelCreate(&model, RT_MODEL_CAPTURE_MODEL), RT_ERROR_NONE);
    CaptureModel* const captureModel = dynamic_cast<CaptureModel*>(model);
    ASSERT_NE(captureModel, nullptr);
    captureModel->SetCaptureModelStatus(RtCaptureModelStatus::READY);
    stream_->SetModel(captureModel);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.type = TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL;
    taskInfo.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);
    taskInfo.typeName = "CAPTURE_RECORD_EXTERNAL";

    ApiImpl apiImpl;
    EXPECT_EQ(apiImpl.ModelTaskDisable(&taskInfo), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(captureModel->GetCaptureModelStatus(), RtCaptureModelStatus::FAULT);
    stream_->SetModel(nullptr);
    EXPECT_EQ(context_->ModelDestroy(model), RT_ERROR_NONE);
}

class ConvertTaskTypeLogTest : public testing::Test {
protected:
    void TearDown() override { GlobalMockObject::verify(); }
};

TEST_F(ConvertTaskTypeLogTest, ConvertTaskTypeLog_PairsBorrowedNameAndNullFallback)
{
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    Stream stream(static_cast<Device*>(nullptr), 0U);
    const TaskOwner owners[] = {TaskOwner::RT_TASK_INNER, TaskOwner::RT_TASK_USER};
    const char* names[] = {"BORROWED_TASK", nullptr};
    for (const TaskOwner owner : owners) {
        for (const char* name : names) {
            TaskInfo task = {};
            task.stream = &stream;
            task.id = 29U;
            task.type = static_cast<tsTaskType_t>(65535);
            task.typeName = name;
            task.taskOwner = static_cast<uint8_t>(owner);
            rtTaskType converted = RT_TASK_KERNEL;
            ClearLastDlogRecordLine();
            EXPECT_EQ(ConvertTaskType(&task, &converted), RT_ERROR_NONE);
            EXPECT_EQ(converted, RT_TASK_DEFAULT);
            EXPECT_TRUE(DlogRecordContains("streamId=" + std::to_string(stream.Id_()) + ", taskId=29,"));
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
            EXPECT_TRUE(DlogRecordContains(
                std::string("alloc taskType=") + ((name == nullptr) ? "UNKNOWN" : name) + "(65535)"));
            EXPECT_FALSE(DlogRecordContains("taskName="));
#else
            EXPECT_TRUE(DlogRecordContains("alloc taskType=65535,"));
            EXPECT_FALSE(DlogRecordContains("taskName="));
#endif
        }
    }
}
