/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#define private public
#include "aicpu_timer.h"
#include "aicpu_timer_api.h"
#include "aicpu_context.h"
#undef private
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

using namespace aicpu;

void CallbackFuncStub(const TimerHandle val)
{
    return;
}

class AicpuOpTimeoutTest : public ::testing::Test {
public:
    virtual void SetUp()
    {
        const auto startTimerCbk = [this](const aicpu::TimerHandle timerHandle, const TimerHandle timeInMs) {
            return CallbackFuncStub(timerHandle);
        };

        const auto stopTimerCbk = [this](const aicpu::TimerHandle timerHandle) {
            return CallbackFuncStub(timerHandle);
        };
        AicpuTimer::GetInstance().RegistMonitorFunc(startTimerCbk, stopTimerCbk);
        AicpuTimer::GetInstance().SetSupportTimer(true);
    }

    virtual void TearDown() {}
};

TEST_F(AicpuOpTimeoutTest, RegistEventFuncTest)
{
    const auto startTimerCbk = [this](const aicpu::TimerHandle timerHandle, const TimerHandle timeInMs) {
        return CallbackFuncStub(timerHandle);
    };

    const auto stopTimerCbk = [this](const aicpu::TimerHandle timerHandle) {
        return CallbackFuncStub(timerHandle);
    };
    AicpuTimer::GetInstance().RegistMonitorFunc(startTimerCbk, stopTimerCbk);
    EXPECT_NE(AicpuTimer::GetInstance().startTimerFunc_, nullptr);
    EXPECT_NE(AicpuTimer::GetInstance().stopTimerFunc_, nullptr);
}

TEST_F(AicpuOpTimeoutTest, StartTimerTest)
{
    const std::function<void ()> timeoutCallback = [this]() {
        return;
    };

    TimerHandle timerId = 0;
    const auto ret = AicpuTimer::GetInstance().StartTimer(timerId, timeoutCallback, 0UL);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_SUCCESS);
}

TEST_F(AicpuOpTimeoutTest, StartTimerErrTest1)
{
    TimerHandle timerId = 0;
    const auto ret = AicpuTimer::GetInstance().StartTimer(timerId, nullptr, 0UL);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_FAILED);
}

TEST_F(AicpuOpTimeoutTest, StopTimerTest)
{
    const std::function<void ()> timeoutCallback = [this]() {
        return;
    };

    TimerHandle timerId = 0;
    (void)AicpuTimer::GetInstance().StartTimer(timerId, timeoutCallback, 0UL);
    const auto ret = AicpuTimer::GetInstance().StopTimer(timerId);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_SUCCESS);
}

TEST_F(AicpuOpTimeoutTest, StartOpTimerErrTest2)
{
    const std::function<void ()> timeoutCallback = [this]() {
        return;
    };

    TimerHandle timerId = 0;
    const auto ret = AicpuTimer::GetInstance().StartTimer(timerId, timeoutCallback, 0UL);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_SUCCESS);
}

TEST_F(AicpuOpTimeoutTest, StartOpTimerErrTest3)
{
    const std::function<void ()> timeoutCallback = [this]() {
        return;
    };

    AicpuTimer timer;
    timer.SetSupportTimer(false);
    TimerHandle timerId = 0;
    const auto ret = timer.StartTimer(timerId, timeoutCallback, 0UL);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_SUCCESS);
}

TEST_F(AicpuOpTimeoutTest, CallOpTimeoutCallbackTest)
{
    const auto startTimerCbk = [this](const aicpu::TimerHandle timerHandle, const TimerHandle timeInMs) {
        return CallbackFuncStub(timerHandle);
    };

    const auto stopTimerCbk = [this](const aicpu::TimerHandle timerHandle) {
        return CallbackFuncStub(timerHandle);
    };
    AicpuTimer::GetInstance().RegistMonitorFunc(startTimerCbk, stopTimerCbk);

    const std::function<void ()> timeoutCallback = [this]() {
        return;
    };

    TimerHandle timerId = 0;
    const auto ret = AicpuTimer::GetInstance().StartTimer(timerId, timeoutCallback, 0UL);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_SUCCESS);
    AicpuTimer::GetInstance().CallTimeoutCallback(2U);
}

TEST_F(AicpuOpTimeoutTest, StopOpTimerTestErr3)
{
    const std::function<void ()> timeoutCallback = [this]() {
        return;
    };

    TimerHandle timerId = 0;
    (void)AicpuTimer::GetInstance().StartTimer(timerId, timeoutCallback, 0UL);
    MOCKER(&AicpuTimer::UnregistTimeoutCallback).stubs().will(returnValue(1));
    const auto ret = AicpuTimer::GetInstance().StopTimer(timerId);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_FAILED);
}

TEST_F(AicpuOpTimeoutTest, StartOpTimerInMonitorTestErr1)
{
    TimerHandle timerId = 0;
    AicpuTimer::GetInstance().startTimerFunc_ = nullptr;
    const auto ret = AicpuTimer::GetInstance().StartTimerInMonitor(timerId, 0UL);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_FAILED);
}

TEST_F(AicpuOpTimeoutTest, StartOpTimerInMonitorTestErr2)
{
    const auto startTimerCbk = [this](const aicpu::TimerHandle timerHandle, const TimerHandle timeInMs) {
        return CallbackFuncStub(timerHandle);
    };

    TimerHandle timerId = 0;
    AicpuTimer::GetInstance().startTimerFunc_ = startTimerCbk;
    const auto ret = AicpuTimer::GetInstance().StartTimerInMonitor(timerId, 0);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_SUCCESS);
}

TEST_F(AicpuOpTimeoutTest, StopOpTimerInMonitorTestErr1)
{
    AicpuTimer::GetInstance().stopTimerFunc_ = nullptr;
    const auto ret = AicpuTimer::GetInstance().StopTimerInMonitor(0);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_FAILED);
}

TEST_F(AicpuOpTimeoutTest, StopOpTimerInMonitorTestErr2)
{
    const auto stopTimerCbk = [this](const aicpu::TimerHandle timerHandle) {
        return CallbackFuncStub(timerHandle);
    };

    AicpuTimer::GetInstance().stopTimerFunc_ = stopTimerCbk;
    const auto ret = AicpuTimer::GetInstance().StopTimerInMonitor(0);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_SUCCESS);
}

TEST_F(AicpuOpTimeoutTest, StopOpTimerTestErr1)
{
    const std::function<void ()> timeoutCallback = [this]() {
        return;
    };

    TimerHandle timerId = 0;
    (void)AicpuTimer::GetInstance().StartTimer(timerId, timeoutCallback, 0UL);
    const auto ret = AicpuTimer::GetInstance().StopTimer(timerId);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_FAILED);
}

TEST_F(AicpuOpTimeoutTest, StopOpTimerTestErr2)
{
    const std::function<void ()> timeoutCallback = [this]() {
        return;
    };

    TimerHandle timerId = 0;
    (void)AicpuTimer::GetInstance().StartTimer(timerId, timeoutCallback, 0UL);
    MOCKER(&AicpuTimer::StopTimerInMonitor).stubs().will(returnValue(1));
    const auto ret = AicpuTimer::GetInstance().StopTimer(timerId);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_FAILED);
}

TEST_F(AicpuOpTimeoutTest, StopOpTimerTestErr4)
{
    AicpuTimer timer;
    TimerHandle timerId = 0;
    MOCKER(&AicpuTimer::StopTimerInMonitor).stubs().will(returnValue(1));
    (void)timer.SetSupportTimer(false);
    const auto ret = timer.StopTimer(timerId);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_SUCCESS);
}

TEST_F(AicpuOpTimeoutTest, AicpuStartOpTimerTest)
{
    const std::function<void ()> timeoutCallback = [this]() {
        return;
    };

    TimerHandle timerId = 0;
    auto ret = aicpu::StartTimer(timerId, timeoutCallback, 0UL);
    aicpu::StopTimer(0);
    EXPECT_EQ(ret, true);
}
