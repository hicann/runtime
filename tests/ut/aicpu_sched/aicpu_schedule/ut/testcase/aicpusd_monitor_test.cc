/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <dlfcn.h>
#include <vector>
#include "core/aicpusd_resource_manager.h"
#include "core/aicpusd_drv_manager.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "aicpusd_info.h"
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "ascend_hal.h"
#include "profiling_adp.h"
#include "tsd.h"
#define private public
#include "aicpusd_interface_process.h"
#include "task_queue.h"
#include "dump_task.h"
#include "aicpu_sharder.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_task_queue.h"
#include "tdt_server.h"
#include "aicpusd_monitor.h"
#include "aicpu_timer.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

namespace {
unsigned int sleep_stub(unsigned int seconds)
{
    std::cout << "sleep_stub..." << std::endl;
    std::this_thread::sleep_for(std::chrono::milliseconds(10));
    return 0;
}
}

class AicpuMonitorTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AicpuMonitorTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AicpuMonitorTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AicpuMonitorTEST SetUP" << std::endl;
        MOCKER(sleep)
        .stubs()
        .will(invoke(sleep_stub));
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AicpuMonitorTEST TearDown" << std::endl;
    }
};

TEST_F(AicpuMonitorTEST, PublicFuncTest_1) {
    setenv("AICPU_TASK_TIMEOUT", "1", 1);
    setenv("AICPU_MODEL_TIMEOUT", "1", 1);
    AicpuMonitor monitor;
    MOCKER(aicpu::GetSystemTickFreq)
        .stubs()
        .will(returnValue(1));
    int32_t ret = monitor.InitMonitor(0, true);
    unsetenv("AICPU_TASK_TIMEOUT");
    unsetenv("AICPU_MODEL_TIMEOUT");
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
    monitor.StopMonitor();
}

TEST_F(AicpuMonitorTEST, PublicFuncTest_2) {
    setenv("AICPU_TASK_TIMEOUT", "1", 1);
    setenv("AICPU_MODEL_TIMEOUT", "1", 1);
    AicpuMonitor monitor;
    MOCKER(aicpu::GetSystemTickFreq)
        .stubs()
        .will(returnValue(1));
    int32_t ret = monitor.InitMonitor(0, true);
    unsetenv("AICPU_TASK_TIMEOUT");
    unsetenv("AICPU_MODEL_TIMEOUT");
    EXPECT_EQ(ret, 0);

    bool needWait = false;
    EventWaitManager::AnyQueNotEmptyWaitManager().WaitEvent(1U, 0U, needWait);
    MOCKER(halEschedSubmitEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    monitor.done_ = false;

    monitor.running_ = false;
    ret = monitor.Run();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    monitor.aicpuTaskTimer_.reset(new (std::nothrow) TaskTimer[MAX_MODEL_COUNT]);
    monitor.monitorTaskInfo_.reset(new (std::nothrow) TaskInfoForMonitor[MAX_MODEL_COUNT]);
    monitor.SetTaskStartTime(0);
    monitor.SetTaskEndTime(0);
    monitor.StopMonitor();
}

TEST_F(AicpuMonitorTEST, Run_sem_init_fail) {
    setenv("AICPU_TASK_TIMEOUT", "1", 1);
    AicpuMonitor monitor;
    MOCKER(aicpu::GetSystemTickFreq)
        .stubs()
        .will(returnValue(1));
    int32_t ret = monitor.InitMonitor(0, true);
    unsetenv("AICPU_TASK_TIMEOUT");
    EXPECT_EQ(ret, 0);

    MOCKER(sem_init)
        .stubs()
        .will(returnValue(-1));
    ret = monitor.Run();
    EXPECT_NE(ret, 0);
}

TEST_F(AicpuMonitorTEST, Run_sem_wait_fail) {
    setenv("AICPU_TASK_TIMEOUT", "1", 1);
    AicpuMonitor monitor;
    MOCKER(aicpu::GetSystemTickFreq)
        .stubs()
        .will(returnValue(1));
    int32_t ret = monitor.InitMonitor(0, true);
    unsetenv("AICPU_TASK_TIMEOUT");
    EXPECT_EQ(ret, 0);

    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(-1));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));

    monitor.done_ = true;

    monitor.running_ = true;
    ret = monitor.Run();
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
    monitor.StopMonitor();
}

TEST_F(AicpuMonitorTEST, Init_Success) {
    setenv("AICPU_TASK_TIMEOUT", "aa", 1);
    AicpuMonitor monitor;
    int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    unsetenv("AICPU_TASK_TIMEOUT");
}

TEST_F(AicpuMonitorTEST, Init_Success_02) {
    setenv("AICPU_TASK_TIMEOUT", "aa", 1);
    setenv("DATAMASTER_RUN_MODE", "1", 1);
    AicpuMonitor monitor;
    int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    unsetenv("AICPU_TASK_TIMEOUT");
    unsetenv("DATAMASTER_RUN_MODE");
}

TEST_F(AicpuMonitorTEST, SendKillMsgToTsdFail) {
    MOCKER(TsdDestroy)
        .stubs()
        .will(returnValue(1));
    AicpuMonitor monitor;
    monitor.SendKillMsgToTsd();
    EXPECT_EQ(monitor.running_, false);
}

TEST_F(AicpuMonitorTEST, HandleTaskTimeout) {
    AicpuMonitor m;
    m.taskTimeoutFlag_ = true;
    m.aicpuCoreNum_ = 1;
    m.taskTimeoutTick_ = 1;
    m.aicpuTaskTimer_.reset(new (std::nothrow) TaskTimer[m.aicpuCoreNum_]);
    m.aicpuStreamTaskTimer_.reset(new (std::nothrow) TaskTimer[MAX_MODEL_COUNT]);
    MOCKER(aicpu::GetSystemTick)
        .stubs()
        .will(returnValue(20));
    m.monitorTaskInfo_.reset(new (std::nothrow) TaskInfoForMonitor[m.aicpuCoreNum_]);
    m.online_ = true;
    m.SetTaskInfo(0, {0, 0, 0, false});
    if (m.aicpuTaskTimer_ != nullptr && m.aicpuStreamTaskTimer_ != nullptr && m.monitorTaskInfo_ != nullptr) {
        m.aicpuTaskTimer_[0].runFlag = true;
        m.aicpuTaskTimer_[0].startTick = 1;
        for (int i = 0; i < MAX_MODEL_COUNT; ++i) {
            m.aicpuStreamTaskTimer_[i].runFlag = true;
        }
        m.HandleTaskTimeout();
    }
    EXPECT_EQ(m.running_, false);
}

TEST_F(AicpuMonitorTEST, HandleTaskAicpuStreamTimeout) {
    AicpuMonitor m;
    m.taskTimeoutFlag_ = true;
    m.aicpuCoreNum_ = 1;
    m.taskTimeoutTick_ = 1;
    m.aicpuTaskTimer_.reset(new (std::nothrow) TaskTimer[m.aicpuCoreNum_]);
    m.aicpuStreamTaskTimer_.reset(new (std::nothrow) TaskTimer[MAX_MODEL_COUNT]);
    MOCKER(aicpu::GetSystemTick)
        .stubs()
        .will(returnValue(20));
    m.monitorTaskInfo_.reset(new (std::nothrow) TaskInfoForMonitor[m.aicpuCoreNum_]);
    m.online_ = true;
    m.SetTaskInfo(0, {0, 0, 0, false});
    if (m.aicpuTaskTimer_ != nullptr && m.aicpuStreamTaskTimer_ != nullptr && m.monitorTaskInfo_ != nullptr) {
        m.aicpuTaskTimer_[0].runFlag = false;
        m.aicpuTaskTimer_[0].startTick = 1;
        for (int i = 0; i < MAX_MODEL_COUNT; ++i) {
            m.aicpuStreamTaskTimer_[i].runFlag = true;
            m.aicpuStreamTaskTimer_[i].startTick = 1;
        }
        m.HandleTaskTimeout();
    }
    EXPECT_EQ(m.running_, false);
}

TEST_F(AicpuMonitorTEST, HandleModelTimeout) {
    AicpuMonitor m;
    m.modelTimeoutFlag_ = true;
    m.modelTimeoutTick_ = 1;
    m.modelTimer_.reset(new (std::nothrow) TaskTimer[MAX_MODEL_COUNT]);
    MOCKER(aicpu::GetSystemTick)
        .stubs()
        .will(returnValue(20));
    if (m.modelTimer_ != nullptr) {
        for (int i = 0; i < MAX_MODEL_COUNT; ++i) {
            m.modelTimer_[i].runFlag = true;
            m.modelTimer_[i].startTick = 1;
        }
        m.HandleModelTimeout();
    }
    EXPECT_EQ(m.running_, false);
}

TEST_F(AicpuMonitorTEST, HandleOpTimeout) {
    AicpuMonitor m;
    m.opTimeoutFlag_ = true;
    m.online_ = true;
    m.aicpuCoreNum_ = 2;
    aicpu::TimerHandle timerId = 1UL;
    m.SetOpTimerStartTime(timerId, 1);
    m.taskTimeoutTick_ = 1;

    m.HandleOpTimeout();
    EXPECT_EQ(m.running_, false);
}

TEST_F(AicpuMonitorTEST, TimerFunTest) {
    setenv("AICPU_TASK_TIMEOUT", "1", 1);
    setenv("AICPU_MODEL_TIMEOUT", "1", 1);
    AicpuMonitor monitor;
    MOCKER(aicpu::GetSystemTickFreq)
        .stubs()
        .will(returnValue(1));
    int32_t ret = monitor.InitMonitor(0, true);
    unsetenv("AICPU_TASK_TIMEOUT");
    unsetenv("AICPU_MODEL_TIMEOUT");
    EXPECT_EQ(ret, 0);
    monitor.aicpuTaskTimer_.reset(new (std::nothrow) TaskTimer[MAX_MODEL_COUNT]);
    monitor.monitorTaskInfo_.reset(new (std::nothrow) TaskInfoForMonitor[MAX_MODEL_COUNT]);
    if (ret == 0) {
        monitor.SetTaskStartTime(0);
        monitor.SetTaskEndTime(0);
        monitor.SetAicpuStreamTaskStartTime(0);
        monitor.SetAicpuStreamTaskEndTime(0);
        monitor.SetModelStartTime(0);
        monitor.SetModelEndTime(0);
    }
}

TEST_F(AicpuMonitorTEST, SetOpTimeoutFlagTest) {
    AicpuMonitor monitor;
    monitor.SetOpTimeoutFlag(true);
    EXPECT_EQ(monitor.opTimeoutFlag_, true);
}

TEST_F(AicpuMonitorTEST, GetTaskDefaultTimeoutTest) {
    AicpuMonitor monitor;
    (void)monitor.InitMonitor(0, true);
    const auto ret = monitor.GetTaskDefaultTimeout();
    EXPECT_EQ(ret, 28UL);
}

TEST_F(AicpuMonitorTEST, MonitorDebugSuccess) {
    const TaskInfoForMonitor info = {.serialNo = 1UL, .taskId = 2UL, .streamId = 3UL, .isHwts = false};
    const auto ret = MonitorDebug::MonitorDebugString(info);
    EXPECT_STREQ(ret.c_str(), "serialNo=1, stream_id=3, task_id=2");
}
void regFake()
{

}
TEST_F(AicpuMonitorTEST, StartTimerError_01) {
    AicpuTimer tempTimer;
    tempTimer.isSupportTimer_ = true;
    TimerHandle handle = 1UL;
    MOCKER_CPP(&AicpuTimer::RegistTimeoutCallback)
        .stubs()
        .will(returnValue(TimerStatus::AICPU_TIMER_FAILED));
    TimerStatus ret = tempTimer.StartTimer(handle, regFake, 0U);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_FAILED);
    GlobalMockObject::verify();
}

TEST_F(AicpuMonitorTEST, StartTimerError_02) {
    AicpuTimer tempTimer;
    tempTimer.isSupportTimer_ = true;
    TimerHandle handle = 1UL;
    MOCKER_CPP(&AicpuTimer::RegistTimeoutCallback)
        .stubs()
        .will(returnValue(TimerStatus::AICPU_TIMER_SUCCESS));
    MOCKER_CPP(&AicpuTimer::StartTimerInMonitor)
        .stubs()
        .will(returnValue(TimerStatus::AICPU_TIMER_FAILED));
    TimerStatus ret = tempTimer.StartTimer(handle, regFake, 0U);
    EXPECT_EQ(ret, TimerStatus::AICPU_TIMER_FAILED);
    GlobalMockObject::verify();
}

TEST_F(AicpuMonitorTEST, InitMonitorSetTaskTimeFail) {
    AicpuMonitor monitor;
    const int32_t expect = 1;
    MOCKER_CPP(&AicpuMonitor::SetTaskTimeoutFlag).stubs().will(returnValue(expect));
    const int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, expect);
}

TEST_F(AicpuMonitorTEST, InitMonitorSetModelTimeFai) {
    AicpuMonitor monitor;
    const int32_t expect = AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    MOCKER_CPP(&AicpuMonitor::SetModelTimeoutFlag).stubs().will(returnValue(expect));
    const int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, expect);
}

TEST_F(AicpuMonitorTEST, SetModelTimeoutFlagFai) {
    AicpuMonitor monitor;
    const int32_t expect = AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    setenv("AICPU_MODEL_TIMEOUT", "100", 1);
    MOCKER(aicpu::GetSystemTickFreq)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&AicpuUtil::IsUint64MulOverflow).stubs().will(returnValue(true));
    const int32_t ret = monitor.SetModelTimeoutFlag();
    unsetenv("AICPU_MODEL_TIMEOUT");
    EXPECT_EQ(ret, expect);
}

TEST_F(AicpuMonitorTEST, SetModelTimeoutFlagExpection) {
    AicpuMonitor monitor;
    const int32_t expect = AICPU_SCHEDULE_ERROR_COMMON_ERROR;
    MOCKER_CPP(&AicpuUtil::GetEnvVal).stubs().will(returnValue(true));
    const int32_t ret = monitor.SetModelTimeoutFlag();
    EXPECT_EQ(ret, expect);
}

TEST_F(AicpuMonitorTEST, InitMonitorInitTimerFail) {
    AicpuMonitor monitor;
    const int32_t expect = AICPU_SCHEDULE_ERROR_COMMON_ERROR;
    MOCKER_CPP(&AicpuMonitor::InitTimer).stubs().will(returnValue(expect));
    const int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, expect);
}

TEST_F(AicpuMonitorTEST, InitAsyncOpTimerSuccess) {
    AicpuMonitor monitor;
    const int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    aicpu::AicpuTimer::GetInstance().startTimerFunc_(100, 0);
    aicpu::AicpuTimer::GetInstance().stopTimerFunc_(100);
}

TEST_F(AicpuMonitorTEST, SendKillMsgToTsdFail1) {
    AicpuMonitor monitor;
    const int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(TsdDestroy).stubs().will(returnValue(1));
    monitor.SendKillMsgToTsd(0);
}

TEST_F(AicpuMonitorTEST, RunSemWaitFail) {
    AicpuMonitor monitor;
    const int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER(sem_wait).stubs().will(returnValue(-1));
    monitor.Run();
}

TEST_F(AicpuMonitorTEST, SetOpExecuteTimeOutNotEnable) {
    AicpuMonitor monitor;
    const int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    monitor.SetOpExecuteTimeOut(0, 100);
}

TEST_F(AicpuMonitorTEST, HandleTaskTimeoutSuccess) {
    AicpuMonitor monitor;
    const int32_t ret = monitor.InitMonitor(0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    monitor.taskTimeoutFlag_ = false;
    monitor.HandleTaskTimeout();
}