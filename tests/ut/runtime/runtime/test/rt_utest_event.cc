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

class EventTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"event test start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"event test start end"<<std::endl;
    }

    virtual void SetUp()
    {
        ((Runtime *)Runtime::Instance())->SetDisableThread(false);
        (void)rtSetSocVersion("");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
        MOCKER_CPP(&Event::NotifierSync).stubs().will(returnValue(RT_REPORT_TIMEOUT_TIME));
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        (void)rtSetSocVersion("");
        ((Runtime *)Runtime::Instance())->SetDisableThread(false);
    }
};

TEST_F(EventTest, eventEx)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_NE(error, ACL_RT_SUCCESS);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_NE(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream);
    EXPECT_NE(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream);
    EXPECT_NE(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream, event);
    EXPECT_NE(error, ACL_RT_SUCCESS);

    error = rtEventSynchronize(event);
    EXPECT_NE(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream);
    EXPECT_NE(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_NE(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_NE(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest, query)
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

TEST_F(EventTest, eventfornotify)
{
    rtError_t error;
    rtNotify_t notify;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Driver* driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver_,
            &Driver::EventIdAlloc).stubs().with(mockcpp::any()(), mockcpp::any()(), mockcpp::any()())
    .will(returnValue(RT_ERROR_DRV_NO_EVENT_RESOURCES)).then(returnValue(RT_ERROR_NONE));

    error = rtNotifyCreate(0, &notify);
    EXPECT_EQ(error, ACL_ERROR_RT_NO_EVENT_RESOURCE);

    // Device *device = ((Runtime *)Runtime::Instance())->GetDevice(0, 0)
    // MOCKER_CPP_VIRTUAL(device, &Device::IsSupportEventPool).stubs().will(returnValue(false)).then(returnValue(false))

    error = rtNotifyCreate(0, &notify);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Device *device = ((Runtime *)Runtime::Instance())->GetDevice(0, 0);
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_STREAM_FULL));

    error = rtNotifyRecord(notify, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_TASK_FULL);

    GlobalMockObject::verify();
    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest, TestInsertToNotifierMapAndDeleteFromNotifierMap)
{
    rtError_t error;
    rtEvent_t event;

    error = rtEventCreate(&event);
    Event *eventObj = (Event*) event;
    EXPECT_EQ(error, RT_ERROR_NONE);

    Notifier *notifier;
    error = eventObj->CreateEventNotifier(notifier);
    EXPECT_EQ(error, RT_ERROR_NONE);
    eventObj->InsertToNotifierMap(0, 0, notifier);
    eventObj->InsertToNotifierMap(0, 0, notifier);
    eventObj->DeleteFromNotifierMap(0, 0);
    eventObj->DeleteFromNotifierMap(0, 0);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(EventTest, TaskReclaimAllForNoRes)
{
    uint32_t taskId;
    Device *device = ((Runtime *)Runtime::Instance())->GetDevice(0, 0);
    auto error = device->TaskReclaimAllForNoRes(false, taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(EventTest, UpdateEventOfCntNotifyInfo)
{
    Event evt;
    int32_t newEventId = 0;
    RawDevice *stub = new RawDevice(0);
    Stream *stm = new Stream(stub, 0);
    MOCKER_CPP_VIRTUAL(stm, &Stream::ApplyCntNotifyId)
            .stubs()
            .will(returnValue(RT_ERROR_NONE));
    rtError_t error = evt.UpdateEventOfCntNotifyInfo(stm, newEventId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stub;
    stm->device_ = nullptr;
    delete stm;
}

TEST_F(EventTest, event_sync_02)
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

    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER_CPP(&Event::NotifierSync).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}