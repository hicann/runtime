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
    char openHandleFirstByte_ = 0;
    IpcEvent* openEvent_ = nullptr;
    IpcEvent* getEvent_ = nullptr;
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
    EXPECT_EQ(ThreadLocalContainer::GetEnvFlags(), API_ENV_FLAGS_DEFAULT);
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
    EXPECT_EQ(ThreadLocalContainer::GetEnvFlags(), API_ENV_FLAGS_DEFAULT);
}
