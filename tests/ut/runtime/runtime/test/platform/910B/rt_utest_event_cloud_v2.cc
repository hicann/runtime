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
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "runtime/event.h"
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

class EventTest910B : public testing::Test {
public:
    Device *device_ = nullptr;
    rtChipType_t oldChipType;
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
        (void)rtSetSocVersion("Ascend910B1");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        (void)rtSetDevice(0);
        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    }

    virtual void TearDown()
    {
        RawDevice *rd = (RawDevice *)device_;
        while (rd->IsNeedFreeEventId()) {rd->PopNextPoolFreeEventId();}
        rtDeviceReset(0);
        ((Runtime *)Runtime::Instance())->SetDisableThread(false);
        (void)rtSetSocVersion("");
        GlobalMockObject::verify();
    }
};

TEST_F(EventTest910B, eventEx)
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

    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910B, reset_submitfailed_rollback)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER_CPP(&StarsEngine::AddTaskToStream).stubs().will(returnValue(RT_ERROR_STREAM_FULL));

    error = rtEventReset(event, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_TASK_FULL);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    mmSleep(10);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910B, query)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQueryStatus(event, &status);
    if (status == RT_EVENT_RECORDED) {
        EXPECT_EQ(status, RT_EVENT_RECORDED);
    } else {
        EXPECT_EQ(status, RT_EVENT_INIT);
    }

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910B, querytest)
{
    rtError_t error;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Stream * stm = (Stream *)stream;
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetSqHead).stubs().will(returnValue(RT_ERROR_NONE));
    stm->taskPosTail_.Set(2);
    stm->JudgeHeadTailPos(&status, 1);

    Device * dev = stm->Device_();
    stm->device_ = nullptr;
    stm->JudgeHeadTailPos(&status, 3);
    stm->device_ = dev;

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910B, querytest1)
{
    rtError_t error;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Stream * stm = (Stream *)stream;
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetSqHead).stubs().will(returnValue(RT_ERROR_NONE));
    stm->taskPosTail_.Set(2);
    stm->JudgeHeadTailPos(&status, 3);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910B, stubDevice)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtContext_t ctx;
    MOCKER_CPP(&Stream::AllocExecutedTimesSvm).stubs().will(returnValue(RT_ERROR_NONE));
    rtContext_t curCtx;
    error = rtCtxGetCurrent(&curCtx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
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

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtCtxSetCurrent(curCtx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(EventTest910B, QueryEventTask_TimeLine)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_TIME_LINE);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtEventStatus_t status1 = RT_EVENT_RECORDED;
    MOCKER_CPP_VIRTUAL(static_cast<Stream *>(stream), &Stream::JudgeHeadTailPos)
        .stubs()
        .with(outBoundP(&status1, sizeof(status1)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    Device* dev = ((Runtime *)Runtime::Instance())->GetDevice(0, 0);
    MOCKER_CPP_VIRTUAL(dev, &Device::TaskReclaim).stubs()
        .will(returnValue(RT_ERROR_NONE));
    
    Stream * const streamPtr = static_cast<Stream *>(stream);
    Event * const eventPtr = static_cast<Event *>(event);
    eventPtr->latestRecord_.state = RECORDING;
    eventPtr->latestRecord_.streamId = streamPtr->Id_();
    eventPtr->latestRecord_.taskId = 0;
    eventPtr->SetRecord(true);
    error = rtEventQueryStatus(event, &status);
    eventPtr->SetRecord(false);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Stream *stm = (Stream*)stream;
    stm->pendingNum_.Sub(stm->pendingNum_.Value());

    MOCKER_CPP(&Engine::ProcessTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(true));

    Device* device = ((Runtime *)Runtime::Instance())->GetDevice(0, 0);
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(returnValue(0));

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910B, TestInsertToNotifierMapWithDisableThread)
{
    rtError_t error;
    rtEvent_t event;

    error = rtEventCreate(&event);
    Event *eventObj = (Event*) event;
    EXPECT_EQ(error, RT_ERROR_NONE);
    eventObj->InsertToNotifierMap(0, 0, nullptr);
    eventObj->DeleteFromNotifierMap(0, 0);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910B, TestWaitForBusy)
{
    rtError_t error;
    rtEvent_t event;

    bool isDisableThread = ((Runtime *)Runtime::Instance())->GetDisableThread();

    error = rtEventCreate(&event);
    Event *eventObj = (Event*) event;
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Event::IsEventTaskEmpty).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER_CPP_VIRTUAL(eventObj, &Event::ReclaimTask).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    error = eventObj->WaitForBusy();
    EXPECT_EQ(error, RT_ERROR_END_OF_SEQUENCE);
    GlobalMockObject::verify();

    MOCKER_CPP(&Event::IsEventTaskEmpty).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER_CPP(&Event::GetFailureStatus).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    ((Runtime *)Runtime::Instance())->SetDisableThread(false);
    error = eventObj->WaitForBusy();
    EXPECT_EQ(error, RT_ERROR_END_OF_SEQUENCE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    ((Runtime *)Runtime::Instance())->SetDisableThread(true);
    GlobalMockObject::verify();
    ((Runtime *)Runtime::Instance())->SetDisableThread(isDisableThread);
}

TEST_F(EventTest910B, TestWaitForBusy_device_down)
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

    MOCKER_CPP(&Event::IsEventTaskEmpty).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER_CPP(&Event::GetFailureStatus).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));
    ((Runtime *)Runtime::Instance())->SetDisableThread(true);

    Event *eventObj = (Event*) event;
    Stream *stm = (Stream*)stream;
    Device* dev = stm->Device_();
    MOCKER_CPP_VIRTUAL(dev, &Device::GetDevRunningState)
        .stubs()
        .will(returnValue((uint32_t)DEV_RUNNING_DOWN));
    error = eventObj->WaitForBusy();

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest910B, TestElapsedTime)
{
    rtError_t error;
    Event event1;
    Event event2;
    float32_t timeInterval;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    
    rtInstance->SetDisableThread(false);
    rtInstance->SetDisableThread(false);
    RawDevice *stub = new RawDevice(0);
    event1.device_ = stub;
    event2.device_ = stub;
    error = event1.ElapsedTime(&timeInterval, &event2);
    EXPECT_EQ(error, RT_ERROR_EVENT_RECORDER_NULL);

    event1.SetRecord(true);
    event2.SetRecord(true);
    error = event1.ElapsedTime(&timeInterval, &event2);
    EXPECT_EQ(error, RT_ERROR_EVENT_TIMESTAMP_INVALID);

    event1.timestamp_ = 20480000;
    event2.timestamp_ = 10240000;
    error = event1.ElapsedTime(&timeInterval, &event2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetDisableThread(true);
    delete stub;
}

TEST_F(EventTest910B, TestGetQueueSize)
{
    EventPool *eventPool = new (std::nothrow) EventPool(device_, 0);
    eventPool->poolSize_ = 100;
    eventPool->eventQueueHead_ = 0;
    eventPool->eventQueueTail_ = 10;
    uint32_t queueSize = eventPool->GetQueueAvilableNum();
    EXPECT_EQ(queueSize, 10);
    delete eventPool;
}

TEST_F(EventTest910B, TestTryAllocEventIdForPool)
{   
    EventPool *eventPool = new (std::nothrow) EventPool(device_, 0);
    eventPool->eventQueueHead_ = 0;
    eventPool->eventQueueTail_ = 99;
    eventPool->isAging_ = true;
    eventPool->TryAllocEventIdForPool();
    EXPECT_EQ(eventPool->eventQueueTail_, 99);
    EXPECT_EQ(eventPool->eventQueueHead_, 0);

    eventPool->eventQueueTail_ = 99;
    eventPool->poolSize_ = 100;
    eventPool->isAging_ = false;
    eventPool->TryAllocEventIdForPool();
    EXPECT_EQ(eventPool->eventQueueTail_, 99);
    EXPECT_EQ(eventPool->eventQueueHead_, 0);

    eventPool->eventQueueHead_ = 0;
    eventPool->eventQueueTail_ = 2;
    eventPool->eventQueue_[0] = 1;
    eventPool->eventQueue_[1] = 2;
    eventPool->eventQueue_[2] = 3;

    Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::NotifyIdAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    eventPool->TryAllocEventIdForPool();
    EXPECT_EQ(eventPool->eventQueueHead_, 0);
    EXPECT_EQ(eventPool->eventQueueTail_, 3);
    
    MOCKER_CPP(&EventPool::IsNeedAllocIdForPool).stubs().will(returnValue(true)).then(returnValue(false));
    eventPool->TryAllocEventIdForPool();
    EXPECT_EQ(eventPool->eventQueueHead_, 0);
    EXPECT_EQ(eventPool->eventQueueTail_, 3);
    rtError_t err = eventPool->FreeEventId(0);
    EXPECT_EQ(err, RT_ERROR_NONE);
    delete eventPool;
}

TEST_F(EventTest910B, TestFreeAllEvent)
{
    EventPool *eventPool = new (std::nothrow) EventPool(device_, 0);
    
    eventPool->eventQueueHead_ = 0;
    eventPool->eventQueueTail_ = 2;
    eventPool->eventQueue_[0] = 1;
    eventPool->eventQueue_[1] = 2;

    MOCKER_CPP_VIRTUAL(device_, &Device::FreeEventIdFromDrv).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = eventPool->FreeAllEvent();
    EXPECT_EQ(eventPool->eventQueueHead_, eventPool->eventQueueTail_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete eventPool;
}

TEST_F(EventTest910B, TestAllocEventIdFromPool)
{
    EventPool *eventPool = new (std::nothrow) EventPool(device_, 0);
    eventPool->eventQueueHead_ = 0;
    eventPool->eventQueueTail_ = 2;
    eventPool->eventQueue_[0] = 1;
    eventPool->eventQueue_[1] = 2;
    eventPool->poolSize_ = 100;
    MOCKER_CPP_VIRTUAL(device_, &Device::SetLastUsagePoolTimeStamp).stubs().will(returnValue(RT_ERROR_NONE));
    int res;
    bool result = eventPool->AllocEventIdFromPool(&res);
    EXPECT_EQ(eventPool->eventQueueHead_, 1);
    EXPECT_EQ(eventPool->eventQueueTail_, 2);
    EXPECT_EQ(result, true);
    EXPECT_EQ(res, 1);

    eventPool->eventQueueHead_ = 1;
    eventPool->eventQueueTail_ = 1;
    result = eventPool->AllocEventIdFromPool(&res);
    EXPECT_EQ(result, false);
    delete eventPool;
}