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
#include "runtime/rt.h"
#include "runtime.hpp"
#include "device.hpp"
#include "event.hpp"
#include "context.hpp"

using namespace cce::runtime;
namespace {
class TaskLaunchTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        GlobalMockObject::verify();
        std::cout<<"TaskLaunchTest test start start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"TaskLaunchTest test start end"<<std::endl;
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
};
}

TEST_F(TaskLaunchTest, rtEventDestroySync_test4)
{
    rtError_t error;
    rtEvent_t event;

    error = rtEventCreate(&event);
    Event *eventObj = (Event*) event;
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Event::IsEventTaskEmpty).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER_CPP_VIRTUAL(eventObj, &Event::ReclaimTask).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    error = eventObj->WaitForBusy();

    MOCKER_CPP(&Event::IsEventTaskEmpty).stubs().will(returnValue(false)).then(returnValue(true));
    MOCKER_CPP(&Event::GetFailureStatus).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * const dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);
    MOCKER_CPP_VIRTUAL(dev, &Device::CheckFeatureSupport)
    .stubs()
    .will(returnValue(false));

    error = rtEventDestroySync(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}