/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "runtime/event.h"
#include "gtest/gtest.h"
#define private public
#define protected public
#include "event.hpp"
#include "stars_engine.hpp"
#include "raw_device.hpp"
#include "engine.hpp"
#include "scheduler.hpp"
#include "task_info.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "npu_driver.hpp"
#undef protected
#undef private
#include "stream_sqcq_manage.hpp"
#include "thread_local_container.hpp"
using namespace testing;
using namespace cce::runtime;

class EventTest910 : public testing::Test
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
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        (void)rtSetSocVersion("Ascend910");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        oldChipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_CLOUD);
        GlobalContainer::SetRtChipType(CHIP_CLOUD);
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        (void)rtSetSocVersion("");
        ((Runtime *)Runtime::Instance())->SetDisableThread(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(oldChipType);
        GlobalContainer::SetRtChipType(oldChipType);
        GlobalMockObject::verify();
    }
private:
    rtChipType_t oldChipType;
};

TEST_F(EventTest910, newModel_waitnotsend)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtStream_t stream2;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // just wait
    error = rtStreamWaitEvent(stream, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // record complete  wait not submit

    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream2, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // destroy obj
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910, query)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQueryStatus(event, &status);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(status, RT_EVENT_INIT);


    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQuery(event);
    if (error == RT_ERROR_EVENT_NOT_COMPLETE) {
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQueryStatus(event, &status);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(status, RT_EVENT_RECORDED);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910, event_elapse_arg)
{
    rtEvent_t start;
    rtEvent_t end;
    float time;
    rtError_t error;
    uint64_t timstamp;

    error = rtEventCreate(&start);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventGetTimeStamp(&timstamp, start);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtEventCreate(&end);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventElapsedTime(NULL, NULL, NULL);
    EXPECT_NE(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtEventRecord(start, NULL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(end, NULL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventElapsedTime(&time, start, end);
    EXPECT_NE(error, ACL_ERROR_RT_EVENT_TIMESTAMP_INVALID);

    error = rtEventDestroy(start);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(end);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910, QueryEventTask)
{
    rtError_t error;
    rtEvent_t event;
    rtEvent_t event2;
    rtStream_t stream;
    rtStream_t stream2;
    rtEventStatus_t status;
    rtEventWaitStatus_t status2;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event2, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream, event2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQueryWaitStatus(event2, &status2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQueryStatus(event, &status);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event2, stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQueryStatus(event, &status);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(status, RT_EVENT_RECORDED);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910, event_sync_timeout_invalid)
{
    rtError_t error;
    rtEvent_t event;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventSynchronizeWithTimeout(event, -3);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(EventTest910, TestElapsedTime)
{
    rtError_t error;
    Event event1, event2;
    float32_t timeInterval;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t curChipType = rtInstance->GetChipType();
    
    rtInstance->SetDisableThread(false);
    RawDevice *stub = new RawDevice(0);
    event1.device_ = stub;
    event2.device_ = stub;


    event1.SetRecord(true);
    event2.SetRecord(true);
    event1.timestamp_ = 20480000;
    event2.timestamp_ = 10240000;
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    error = event1.ElapsedTime(&timeInterval, &event2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetDisableThread(true);
    delete stub;
}

TEST_F(EventTest910, UpdateTimelineWithNoTask)
{
    rtError_t error;
    rtEvent_t eventPtr;
    Event* event;
    rtStream_t stream;

    error = rtEventCreate(&eventPtr);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Stream * stm = (Stream *)stream;
    int32_t streamId = stm->Id_();
    event = (Event *)eventPtr;

    RecordTaskInfo latestRecord = {streamId, 0, RECORDING};
    event->UpdateLatestRecord(latestRecord, 0);
    latestRecord.state = RECORDED;
    event->UpdateLatestRecord(latestRecord, 0);

    TaskInfo taskInfo = {0};
    taskInfo.stream = stm;
    taskInfo.id = 0;
    taskInfo.type = TS_TASK_TYPE_EVENT_RECORD;
    event->InsertRecordResetToMap(&taskInfo);

    std::shared_ptr<Stream> stmSharedPtr = stm->GetSharedPtr();
    MOCKER_CPP(&StreamSqCqManage::GetStreamSharedPtrById).stubs().with(mockcpp::any(), outBound(stmSharedPtr))
        .will(returnValue(RT_ERROR_NONE));

    event->UpdateTimeline();

    GlobalMockObject::verify();
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910, TestWaitSendCheck)
{
    rtError_t error;
    rtEvent_t eventPtr;
    Event* event;
    rtStream_t stream;

    error = rtEventCreate(&eventPtr);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Stream * stm = (Stream *)stream;
    event = (Event *)eventPtr;

    stm->bindFlag_.Set(true);
    int32_t eventId = 0;
    bool ret = event->WaitSendCheck(stm, eventId);
    EXPECT_EQ(ret, true);

    event->EventIdCountSub(eventId);
    error = rtEventDestroy(eventPtr);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910, UpdateTimelineWithRecordTask)
{
    rtError_t error;
    rtEvent_t eventPtr;
    Event* event;
    rtStream_t stream;

    error = rtEventCreate(&eventPtr);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventRecord(eventPtr, stream);
    Stream * stm = (Stream *)stream;
    int32_t streamId = stm->Id_();
    event = (Event *)eventPtr;

    RecordTaskInfo latestRecord = {streamId, 1, RECORDING};
    event->UpdateLatestRecord(latestRecord, 0);
    latestRecord.state = RECORDED;
    event->UpdateLatestRecord(latestRecord, 0);

    TaskInfo taskInfo = {0};
    taskInfo.stream = stm;
    taskInfo.id = 0;
    taskInfo.type = TS_TASK_TYPE_EVENT_RECORD;
    event->InsertRecordResetToMap(&taskInfo);

    std::shared_ptr<Stream> stmSharedPtr = stm->GetSharedPtr();
    MOCKER_CPP(&StreamSqCqManage::GetStreamSharedPtrById).stubs().with(mockcpp::any(), outBound(stmSharedPtr))
        .will(returnValue(RT_ERROR_NONE));

    event->UpdateTimeline();

    GlobalMockObject::verify();
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910, UpdateTimeLine)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    uint64_t timstamp;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_TIME_LINE);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    TaskInfo recordTask = {};
    recordTask.type = TS_TASK_TYPE_EVENT_RECORD;
    MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&recordTask));
    error = rtEventGetTimeStamp(&timstamp, event);
    GlobalMockObject::verify();

    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

rtError_t QueryEventWaitStatusStub(Event *evt, const bool disableThread, bool &waitFlag)
{
    waitFlag = true;
    return RT_ERROR_NONE;
}

TEST_F(EventTest910, EventIdCountSub)
{
    Event evt;
    EXPECT_NE(sizeof(evt), 0);
    RawDevice *stub = new RawDevice(0);
    evt.device_ = stub;
    evt.EventIdCountSub(0, false);
    evt.EventIdCountAdd(1);

    evt.EventIdCountSub(1, false);
    evt.EventIdCountSub(1, false);
    delete stub;
}

TEST_F(EventTest910, EventIdclear)
{
    Event evt;
    RawDevice *stub = new RawDevice(0);
    evt.device_ = stub;
    rtError_t error = evt.ClearRecordStatus();
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete stub;
}

TEST_F(EventTest910, event_TimeStamp_arg)
{
    rtEvent_t start;
    rtError_t error;
    uint64_t timstamp;

    error = rtEventCreate(&start);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Event *eventObj = (Event*) start;
    eventObj->hasRecord_.Set(true);
    eventObj->timestamp_ = UINT64_MAX;
    eventObj->timeline_ = UINT64_MAX;
    error = eventObj->GetTimeStamp(&timstamp);
    EXPECT_EQ(error, RT_ERROR_EVENT_TIMESTAMP_INVALID);
    error = rtEventDestroy(start);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910, event_sync_01)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Event *evt= (Event*) event;
    MOCKER_CPP_VIRTUAL(evt, &Event::WaitTask).stubs().will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_ERROR_RT_EVENT_SYNC_TIMEOUT);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}