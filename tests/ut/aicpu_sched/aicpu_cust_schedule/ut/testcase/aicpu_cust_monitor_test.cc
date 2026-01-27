/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <stdint.h>
#include <stdlib.h>
#include <semaphore.h>
#include <pthread.h>
#include <unistd.h>
#include <thread>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd.h"
#include "profiling_adp.h"

#define private public
#include "aicpusd_monitor.h"
#undef private

using namespace AicpuSchedule;

class AICPUCustMonitorTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUCustMonitorTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUCustMonitorTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUCustMonitorTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUCustMonitorTEST TearDown" << std::endl;
    }
};

TEST_F(AICPUCustMonitorTEST, PublicFuncTest_1) {
    AicpuMonitor monitor;
    MOCKER(aicpu::GetSystemTickFreq)
        .stubs()
        .will(returnValue(1));
    int32_t ret = monitor.InitAicpuMonitor(0, true);
    EXPECT_EQ(ret, 0);

    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    monitor.running_ = false;
    monitor.done_ = true;
    ret = monitor.Run();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_COMMON_ERROR);
    monitor.Stop();
    // wait for thread run end
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
}

TEST_F(AICPUCustMonitorTEST, Init_Succ) {
    AicpuMonitor monitor;
    int32_t ret = monitor.InitAicpuMonitor(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustMonitorTEST, Init_Succ_offline) {
    AicpuMonitor monitor;
    int32_t ret = monitor.InitAicpuMonitor(0, false);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustMonitorTEST, Init_setFlag_fail) {
    AicpuMonitor monitor;
    MOCKER_CPP(&AicpuMonitor::SetTaskTimeoutFlag)
        .stubs()
        .will(returnValue(1));
    int32_t ret = monitor.InitAicpuMonitor(0, true);
    EXPECT_EQ(ret, 1);
}

TEST_F(AICPUCustMonitorTEST, SendKillMsgToTsdFail) {
    MOCKER(TsdDestroy)
        .stubs()
        .will(returnValue(1));
    AicpuMonitor monitor;
    monitor.SendKillMsgToTsd();
    int32_t ret = monitor.SetTaskTimeoutFlag();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustMonitorTEST, HandleTaskTimeout) {
    AicpuMonitor m;
    m.online_ = true;
    m.taskTimeoutFlag_ = true;
    m.aicpuCoreNum_ = 1;
    m.taskTimeoutTick_ = 1;
    m.taskTimer_.reset(new (std::nothrow) TaskTimer[m.aicpuCoreNum_]);
    m.taskInfo_.reset(new (std::nothrow) TaskInfoForMonitor[m.aicpuCoreNum_]);
    m.SetTaskInfo(0, {0, 0, 0, false});
    MOCKER(aicpu::GetSystemTick)
        .stubs()
        .will(returnValue(20));
    if (m.taskTimer_ != nullptr && m.taskInfo_ != nullptr) {
        m.taskTimer_[0].runFlag_ = true;
        m.taskTimer_[0].startTick_ = 1;
        m.HandleTaskTimeout();
    }
    int32_t ret = m.SetTaskTimeoutFlag();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustMonitorTEST, HandleTaskTimeout_Fail) {
    AicpuMonitor m;
    m.online_ = true;
    m.taskTimeoutFlag_ = false;
    m.HandleTaskTimeout();
    int32_t ret = m.SetTaskTimeoutFlag();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustMonitorTEST, SetTaskTimeoutFlagSucc) {
    AicpuMonitor moniter;
    int32_t ret = moniter.SetTaskTimeoutFlag();
    EXPECT_EQ(ret, 0);
    EXPECT_EQ(moniter.taskTimeoutFlag_, true);
}

TEST_F(AICPUCustMonitorTEST, SetTaskEndTimeSucc) {
    AicpuMonitor moniter;
    int32_t ret = moniter.SetTaskTimeoutFlag();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    moniter.online_ = true;
    moniter.aicpuCoreNum_ = 1;
    moniter.taskTimeoutTick_ = 1;
    moniter.taskTimer_.reset(new (std::nothrow) TaskTimer[moniter.aicpuCoreNum_]);
    moniter.taskInfo_.reset(new (std::nothrow) TaskInfoForMonitor[moniter.aicpuCoreNum_]);
    moniter.SetTaskInfo(0, {0, 0, 0, false});
    MOCKER(aicpu::GetSystemTick)
        .stubs()
        .will(returnValue(20));

    moniter.SetTaskStartTime(0);
    moniter.SetTaskEndTime(0);
}


TEST_F(AICPUCustMonitorTEST, SendAbnormalMsgToMainSucc) {
    AicpuMonitor moniter;
    MOCKER(aicpu::HasErrorLog).stubs().will(returnValue(true));
    moniter.SendAbnormalMsgToMain();
    int32_t ret = moniter.SetTaskTimeoutFlag();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustMonitorTEST, SendAbnormalMsgToMainEventFail) {
    AicpuMonitor moniter;
    MOCKER(aicpu::HasErrorLog).stubs().will(returnValue(true));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    moniter.SendAbnormalMsgToMain();
    int32_t ret = moniter.SetTaskTimeoutFlag();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCustMonitorTEST, MonitorRunSemInitFail) {
    AicpuMonitor monitor;
    MOCKER(aicpu::GetSystemTickFreq).stubs().will(returnValue(1));
    int32_t ret = monitor.InitAicpuMonitor(0, true);
    EXPECT_EQ(ret, 0);

    MOCKER(sem_init).stubs().will(returnValue(-1));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    monitor.running_ = false;
    monitor.done_ = false;
    ret = monitor.Run();
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_COMMON_ERROR);
    monitor.Stop();
    // wait for thread run end
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
}

TEST_F(AICPUCustMonitorTEST, SendAbnormalMsgToMainNotHasLog) {
    AicpuMonitor monitor;
    monitor.SendAbnormalMsgToMain();
    int32_t ret = monitor.SetTaskTimeoutFlag();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}