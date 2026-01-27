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
#define private public
#include "aicpusd_monitor.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

class AicpuStubMonitorTEST : public testing::Test {

    virtual void SetUp() {}

    virtual void TearDown() {}
};

TEST_F(AicpuStubMonitorTEST, HandleOpTimeoutTest) {
    AicpuMonitor::GetInstance().HandleOpTimeout();
    AicpuMonitor::GetInstance().InitAsyncOpTimer();
    AicpuMonitor::GetInstance().SendKillMsgToTsd();
    AicpuMonitor::GetInstance().SendKillMsgToTsd(10);
    AicpuMonitor::GetInstance().SetOpTimeoutFlag(0U);
    aicpu::TimerHandle timerId = 0UL;
    AicpuMonitor::GetInstance().SetOpTimerEndTime(timerId);
    AicpuMonitor::GetInstance().SetOpTimerStartTime(timerId, 0UL);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, InitMonitorTest) {
    auto ret = AicpuMonitor::GetInstance().InitMonitor(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuStubMonitorTEST, SendKillMsgToTsdTest02) {
    AicpuMonitor::GetInstance().SendKillMsgToTsd(2);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SendKillMsgToTsdTest2) {
    AicpuMonitor::GetInstance().SendKillMsgToTsd();
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SetTaskInfoTest) {
    TaskInfoForMonitor taskInfo;
    AicpuMonitor::GetInstance().SetTaskInfo(1, taskInfo);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SetOpExecuteTimeOutTest) {
    AicpuMonitor::GetInstance().SetOpExecuteTimeOut(2, 10);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SetTaskStartTimeTest) {
    AicpuMonitor::GetInstance().SetTaskStartTime(2);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SetTaskEndTimeTest) {
    AicpuMonitor::GetInstance().SetTaskEndTime(2);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SetAicpuStreamTaskStartTimeTest) {
    AicpuMonitor::GetInstance().SetAicpuStreamTaskStartTime(2);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SetAicpuStreamTaskEndTimeTest) {
    AicpuMonitor::GetInstance().SetAicpuStreamTaskEndTime(2);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SetModelStartTimeTest) {
    AicpuMonitor::GetInstance().SetModelStartTime(2);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SetModelEndTimeTest) {
    AicpuMonitor::GetInstance().SetModelEndTime(2);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, RunTest) {
    AicpuMonitor::GetInstance().Run();
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, StopMonitorTest) {
    AicpuMonitor::GetInstance().StopMonitor();
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, SetTaskTimeoutFlagTest) {
    auto ret = AicpuMonitor::GetInstance().SetTaskTimeoutFlag();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuStubMonitorTEST, SetModelTimeoutFlagTest) {
    auto ret = AicpuMonitor::GetInstance().SetModelTimeoutFlag();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuStubMonitorTEST, WorkTest) {
    AicpuMonitor *monitor;
    AicpuMonitor::GetInstance().Work(monitor);
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, HandleTaskTimeoutTest) {
    AicpuMonitor::GetInstance().HandleTaskTimeout();
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, HandleModelTimeoutTest) {
    AicpuMonitor::GetInstance().HandleModelTimeout();
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, DisableModelTimeoutTest) {
    AicpuMonitor::GetInstance().DisableModelTimeout();
    EXPECT_EQ(AicpuMonitor::GetInstance().deviceId_, 0);
}

TEST_F(AicpuStubMonitorTEST, GetTaskDefaultTimeoutTest) {
    auto ret = AicpuMonitor::GetInstance().GetTaskDefaultTimeout();
    EXPECT_EQ(ret, 0);
}
