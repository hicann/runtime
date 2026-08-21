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
#include "runtime/event.h"

#define private public
#include "runtime.hpp"
#undef private

#include "api_event.hpp"
#include "api_handle_guard.h"
#include "dev_info_manage.h"
#include "ipc_event.hpp"
#include "thread_local_container.hpp"

using namespace cce::runtime;
using namespace testing;

namespace {
class ApiEventRouteStub : public ApiEvent {
public:
    rtError_t GetEventID(Event* const evt, uint32_t* const evtId) override
    {
        isGetEventIdCalled_ = true;
        getEventIdEvent_ = evt;
        *evtId = 7U;
        return RT_ERROR_NONE;
    }

    rtError_t EventQuery(Event* const evt) override
    {
        isQueryCalled_ = true;
        queryEvent_ = evt;
        return RT_ERROR_NONE;
    }

    rtError_t EventQueryStatus(Event* const evt, rtEventStatus_t* const status) override
    {
        isQueryStatusCalled_ = true;
        queryStatusEvent_ = evt;
        *status = RT_EVENT_RECORDED;
        return RT_ERROR_NONE;
    }

    rtError_t EventQueryWaitStatus(Event* const evt, rtEventWaitStatus_t* const status) override
    {
        isQueryWaitStatusCalled_ = true;
        queryWaitStatusEvent_ = evt;
        *status = EVENT_STATUS_COMPLETE;
        return RT_ERROR_NONE;
    }

    rtError_t EventElapsedTime(float32_t* const retTime, Event* const startEvt, Event* const endEvt) override
    {
        isElapsedTimeCalled_ = true;
        elapsedStartEvent_ = startEvt;
        elapsedEndEvent_ = endEvt;
        *retTime = 1.0F;
        return RT_ERROR_NONE;
    }

    rtError_t EventGetTimeStamp(uint64_t* const retTime, Event* const evt) override
    {
        isGetTimeStampCalled_ = true;
        getTimeStampEvent_ = evt;
        *retTime = 100U;
        return RT_ERROR_NONE;
    }

    rtError_t IpcOpenEventHandle(rtIpcEventHandle_t* handle, IpcEvent** const event) override
    {
        isOpenCalled_ = true;
        openHandleFirstByte_ = handle->reserved[0];
        *event = openEvent_;
        return RT_ERROR_NONE;
    }

    rtError_t IpcGetEventHandle(IpcEvent* const event, rtIpcEventHandle_t* handle) override
    {
        isGetCalled_ = true;
        getEvent_ = event;
        handle->reserved[0] = 1;
        return RT_ERROR_NONE;
    }

    bool isOpenCalled_ = false;
    bool isGetCalled_ = false;
    bool isGetEventIdCalled_ = false;
    bool isQueryCalled_ = false;
    bool isQueryStatusCalled_ = false;
    bool isQueryWaitStatusCalled_ = false;
    bool isElapsedTimeCalled_ = false;
    bool isGetTimeStampCalled_ = false;
    char openHandleFirstByte_ = 0;
    IpcEvent* openEvent_ = nullptr;
    IpcEvent* getEvent_ = nullptr;
    Event* getEventIdEvent_ = nullptr;
    Event* queryEvent_ = nullptr;
    Event* queryStatusEvent_ = nullptr;
    Event* queryWaitStatusEvent_ = nullptr;
    Event* elapsedStartEvent_ = nullptr;
    Event* elapsedEndEvent_ = nullptr;
    Event* getTimeStampEvent_ = nullptr;
};

class ApiEventRouteTest : public Test {
protected:
    void SetUp() override
    {
        runtime_ = Runtime::Instance();
        ASSERT_NE(runtime_, nullptr);
        oldApi_ = runtime_->api_;
        oldApiEvent_ = runtime_->apiEvent_;
        oldEnvFlags_ = ThreadLocalContainer::GetEnvFlags();
        runtime_->api_ = nullptr;
        runtime_->apiEvent_ = &apiEvent_;
        ThreadLocalContainer::SetEnvFlags(API_ENV_FLAGS_NO_TSD);
        MOCKER_CPP(&DevInfoManage::IsSupportChipFeature).stubs().will(returnValue(true));
    }

    void TearDown() override
    {
        runtime_->api_ = oldApi_;
        runtime_->apiEvent_ = oldApiEvent_;
        ThreadLocalContainer::SetEnvFlags(oldEnvFlags_);
        GlobalMockObject::verify();
    }

    Runtime* runtime_ = nullptr;
    Api* oldApi_ = nullptr;
    ApiEvent* oldApiEvent_ = nullptr;
    uint32_t oldEnvFlags_ = API_ENV_FLAGS_DEFAULT;
    ApiEventRouteStub apiEvent_;
};
} // namespace

TEST_F(ApiEventRouteTest, RoutesIpcGetEventHandleToApiEvent)
{
    IpcEvent ipcEvent(nullptr, RT_EVENT_IPC, nullptr);
    InitEmbeddedInnerHandle<Event>(&ipcEvent);
    const rtEvent_t event = ExportEmbeddedHandle<rtEvent_t>(&ipcEvent);
    rtIpcEventHandle_t handle = {};

    EXPECT_EQ(rtIpcGetEventHandle(event, &handle), RT_ERROR_NONE);
    EXPECT_TRUE(apiEvent_.isGetCalled_);
    EXPECT_EQ(apiEvent_.getEvent_, &ipcEvent);
    EXPECT_EQ(handle.reserved[0], 1);
    EXPECT_EQ(ThreadLocalContainer::GetEnvFlags(), API_ENV_FLAGS_NO_TSD);
}

TEST_F(ApiEventRouteTest, RoutesEventQueryApisToApiEvent)
{
    Event startEvent(nullptr, RT_EVENT_DEFAULT, nullptr);
    Event endEvent(nullptr, RT_EVENT_DEFAULT, nullptr);
    InitEmbeddedInnerHandle<Event>(&startEvent);
    InitEmbeddedInnerHandle<Event>(&endEvent);
    const rtEvent_t startHandle = ExportEmbeddedHandle<rtEvent_t>(&startEvent);
    const rtEvent_t endHandle = ExportEmbeddedHandle<rtEvent_t>(&endEvent);
    uint32_t eventId = 0U;
    rtEventStatus_t eventStatus = RT_EVENT_INIT;
    rtEventWaitStatus_t waitStatus = EVENT_STATUS_NOT_READY;
    float32_t elapsedTime = 0.0F;
    uint64_t timeStamp = 0U;

    EXPECT_EQ(rtGetEventID(startHandle, &eventId), RT_ERROR_NONE);
    EXPECT_EQ(rtEventQuery(startHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtEventQueryStatus(startHandle, &eventStatus), RT_ERROR_NONE);
    EXPECT_EQ(rtEventQueryWaitStatus(startHandle, &waitStatus), RT_ERROR_NONE);
    EXPECT_EQ(rtEventElapsedTime(&elapsedTime, startHandle, endHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtEventGetTimeStamp(&timeStamp, startHandle), RT_ERROR_NONE);

    EXPECT_TRUE(apiEvent_.isGetEventIdCalled_);
    EXPECT_TRUE(apiEvent_.isQueryCalled_);
    EXPECT_TRUE(apiEvent_.isQueryStatusCalled_);
    EXPECT_TRUE(apiEvent_.isQueryWaitStatusCalled_);
    EXPECT_TRUE(apiEvent_.isElapsedTimeCalled_);
    EXPECT_TRUE(apiEvent_.isGetTimeStampCalled_);
    EXPECT_EQ(apiEvent_.getEventIdEvent_, &startEvent);
    EXPECT_EQ(apiEvent_.queryEvent_, &startEvent);
    EXPECT_EQ(apiEvent_.queryStatusEvent_, &startEvent);
    EXPECT_EQ(apiEvent_.queryWaitStatusEvent_, &startEvent);
    EXPECT_EQ(apiEvent_.elapsedStartEvent_, &startEvent);
    EXPECT_EQ(apiEvent_.elapsedEndEvent_, &endEvent);
    EXPECT_EQ(apiEvent_.getTimeStampEvent_, &startEvent);
    EXPECT_EQ(eventId, 7U);
    EXPECT_EQ(eventStatus, RT_EVENT_RECORDED);
    EXPECT_EQ(waitStatus, EVENT_STATUS_COMPLETE);
    EXPECT_FLOAT_EQ(elapsedTime, 1.0F);
    EXPECT_EQ(timeStamp, 100U);
    EXPECT_EQ(ThreadLocalContainer::GetEnvFlags(), API_ENV_FLAGS_NO_TSD);
}

TEST_F(ApiEventRouteTest, RoutesIpcOpenEventHandleToApiEvent)
{
    IpcEvent ipcEvent(nullptr, RT_EVENT_IPC, nullptr);
    InitEmbeddedInnerHandle<Event>(&ipcEvent);
    apiEvent_.openEvent_ = &ipcEvent;
    rtIpcEventHandle_t handle = {};
    handle.reserved[0] = 1;
    rtEvent_t event = nullptr;

    EXPECT_EQ(rtIpcOpenEventHandle(handle, &event), RT_ERROR_NONE);
    EXPECT_TRUE(apiEvent_.isOpenCalled_);
    EXPECT_EQ(apiEvent_.openHandleFirstByte_, 1);
    EXPECT_EQ(event, ExportEmbeddedHandle<rtEvent_t>(&ipcEvent));
    EXPECT_EQ(ThreadLocalContainer::GetEnvFlags(), API_ENV_FLAGS_NO_TSD);
}
