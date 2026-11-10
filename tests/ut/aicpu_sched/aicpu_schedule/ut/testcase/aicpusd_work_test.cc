/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <semaphore.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <thread>
#include <vector>
#include <signal.h>
#include <iostream>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "tsd.h"
#include "profiling_adp.h"
#include "aicpusd_common.h"
#include "aicpusd_util.h"
#include "aicpusd_proc_mgr_sys_operator_agent.h"
#include "aicpusd_feature_ctrl.h"
#include "aicpusd_message_queue.h"
#define private public
#include "core/aicpusd_event_manager.h"
#include "core/aicpusd_drv_manager.h"
#include "aicpusd_monitor.h"
#include "core/aicpusd_worker.h"
#undef private

using namespace AicpuSchedule;

class AICPUSDWorkerTEST : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "AICPUSDWorkerTEST SetUpTestCase" << std::endl; }

    static void TearDownTestCase() { std::cout << "AICPUSDWorkerTEST TearDownTestCase" << std::endl; }

    virtual void SetUp() { std::cout << "AICPUSDWorkerTEST SetUP" << std::endl; }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUSDWorkerTEST TearDown" << std::endl;
    }
};

namespace {
int32_t halGetVdevNumStub(uint32_t* num_dev)
{
    *num_dev = 1;
    return 0;
}
} // namespace

TEST_F(AICPUSDWorkerTEST, CreateWorkTest)
{
    ThreadPool tp;
    MOCKER(sem_init).stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(signal).stubs().will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    MOCKER_CPP(&ThreadPool::CreateOneWorker).stubs().will(returnValue(0));

    std::vector<uint32_t> deviceId;
    deviceId.push_back(0);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceId, 0, 0, true);

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkTest_aicpu_num_0)
{
    MOCKER_CPP(&ThreadPool::CreateOneWorker).stubs().will(returnValue(0));
    MOCKER(sem_init).stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(signal).stubs().will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    ThreadPool tp;
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 0;
    AicpuDrvManager::GetInstance().deviceVec_.push_back(0);
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkTest_sem_init_fail)
{
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    ThreadPool tp;
    MOCKER(sem_init).stubs().will(returnValue(-1));

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, IsValidTimeoutValZero) { EXPECT_FALSE(AicpuUtil::IsValidTimeoutVal(0U)); }

TEST_F(AICPUSDWorkerTEST, CreateWorkTest_CreateOneWorker_fail)
{
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    ThreadPool tp;
    MOCKER(sem_init).stubs().will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateOneWorker).stubs().will(returnValue(-1));

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkTest_sem_wait_fail)
{
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    ThreadPool tp;
    MOCKER(sem_init).stubs().will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateOneWorker).stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(-1)).then(returnValue(0));

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
    ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, CreateOneWorkTest)
{
    ThreadPool tp;
    MOCKER(sem_init).stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(signal).stubs().will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INIT_FAILED));

    std::vector<uint32_t> deviceId;
    deviceId.push_back(0);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceId, 0, 0, true);

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    const int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkerInitFailThreadStatusExit)
{
    ThreadPool& tp = ThreadPool::Instance();
    MOCKER_CPP(&ThreadPool::AddPidToTask).stubs().will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_OK)));
    MOCKER_CPP(&AicpuDrvManager::GetAicpuPhysIndex).stubs().will(returnValue(static_cast<uint32_t>(INVALID_AICPU_ID)));
    MOCKER(halEschedSubscribeEvent).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    MOCKER_CPP(&AicpuMonitor::Run).stubs().will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_OK)));
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);

    AicpuDrvManager& drvMgr = AicpuDrvManager::GetInstance();
    drvMgr.deviceVec_ = {0U};
    drvMgr.deviceNum_ = 1U;
    drvMgr.aicpuNumPerDev_ = 1U;

    const int32_t ret = tp.CreateWorker(SCHED_MODE_INTERRUPT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
    ASSERT_FALSE(tp.threadStatusList_.empty());
    EXPECT_EQ(tp.threadStatusList_[0U], ThreadStatus::THREAD_EXIT);
}

TEST_F(AICPUSDWorkerTEST, SetThreadStatusSuccess)
{
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.SetThreadStatus(0, ThreadStatus::THREAD_RUNNING);
    EXPECT_EQ(tp.threadStatusList_[0], ThreadStatus::THREAD_RUNNING);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkerAicpuIsZero)
{
    ThreadPool tp;
    tp.hasAicpu_ = true;
    std::vector<uint32_t> deviceId = {0};
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceId, 0, 0, true);
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    MOCKER_CPP(&AicpuDrvManager::GetAicpuNumPerDevice).stubs().will(returnValue(0U));
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUSDWorkerTEST, WorkTest)
{
    AicpuEventManager::GetInstance().InitEventFunc(SCHED_MODE_INTERRUPT);
    AicpuEventManager::GetInstance().SetRunningFlag(false);
    MOCKER_CPP(&AicpuEventManager::LoopProcess).stubs();
    MOCKER_CPP(&ThreadPool::SetAffinity).stubs().will(returnValue(0));
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    ThreadPool tp;
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    AicpuSchedule::ThreadPool::Instance().threadIdLists_ = std::vector<pid_t>(static_cast<size_t>(10), 0);
    tp.Work(0, 0, schedMode);
    EXPECT_EQ(tp.semInitedNum_, 0);
}

TEST_F(AICPUSDWorkerTEST, WorkTest_Fail)
{
    MOCKER(halEschedSubscribeEvent).stubs().will(returnValue(1));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    ThreadPool tp;

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    tp.Work(0, 0, schedMode);
    EXPECT_EQ(tp.schedMode_, SCHED_MODE_INTERRUPT);
}

TEST_F(AICPUSDWorkerTEST, WorkTestMsqSuccess)
{
    AicpuEventManager::GetInstance().SetRunningFlag(false);
    MOCKER_CPP(&AicpuEventManager::LoopProcess).stubs();
    MOCKER_CPP(&ThreadPool::SetAffinity).stubs().will(returnValue(0));
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    ThreadPool tp;

    MOCKER_CPP(&MessageQueue::InitMessageQueueForThread).stubs().will(returnValue(AicpuSchedule::AICPU_SCHEDULE_OK));
    const AicpuSchedMode schedMode = SCHED_MODE_MSGQ;
    tp.Work(0, 0, schedMode);
    EXPECT_EQ(tp.schedMode_, SCHED_MODE_INTERRUPT);
}

TEST_F(AICPUSDWorkerTEST, WorkTestMsqFail)
{
    AicpuEventManager::GetInstance().SetRunningFlag(false);
    MOCKER_CPP(&AicpuEventManager::LoopProcess).stubs();
    MOCKER_CPP(&ThreadPool::SetAffinity).stubs().will(returnValue(0));
    MOCKER_CPP(&ThreadPool::SetThreadStatus).stubs();
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    ThreadPool tp;

    MOCKER_CPP(&MessageQueue::InitMessageQueueForThread)
        .stubs()
        .will(returnValue(AicpuSchedule::AICPU_SCHEDULE_ERROR_INNER_ERROR));
    const AicpuSchedMode schedMode = SCHED_MODE_MSGQ;
    tp.Work(0, 0, schedMode);
    EXPECT_EQ(tp.schedMode_, SCHED_MODE_INTERRUPT);
}

TEST_F(AICPUSDWorkerTEST, InitInterruptWorkerFail)
{
    ThreadPool tp;
    MOCKER(halEschedSubscribeEvent).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    const int32_t ret = tp.InitInterruptWorker(0, 0);
    EXPECT_EQ(ret, DRV_ERROR_NOT_SUPPORT);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityBySelfTest)
{
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(0));
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0)).then(returnValue(-1));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);

    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_NE(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityBySelfTest2)
{
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(0));
    MOCKER_CPP(&halGetVdevNum).stubs().will(returnValue(1));
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinityBySelf(0, 32), AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUSDWorkerTEST, AddPidToTask_Success)
{
    MOCKER_CPP(&FeatureCtrl::IsBindPidByHal).stubs().will(returnValue(true));
    MOCKER(&halBindCgroup).stubs().will(returnValue(0));
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.AddPidToTask(0), AICPU_SCHEDULE_OK);
}

TEST_F(AICPUSDWorkerTEST, AddPidToTask_Fail)
{
    MOCKER_CPP(&FeatureCtrl::IsBindPidByHal).stubs().will(returnValue(true));
    MOCKER(&halBindCgroup).stubs().will(returnValue(1));
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.AddPidToTask(0), AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityTest)
{
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ =
        std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(1));
    MOCKER(waitpid).stubs().will(returnValue(0));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityTestSuccess)
{
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ =
        std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuUtil::ExecuteCmd).stubs().will(returnValue(0));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityErrTest)
{
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ =
        std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(-1));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityErrTest2)
{
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ =
        std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(1));
    MOCKER(waitpid).stubs().will(returnValue(-1));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityErrTest3)
{
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ =
        std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(1));
    MOCKER(waitpid).stubs().will(returnValue(-1));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(aicpuNum + 1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityExecuteCmdFail)
{
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ =
        std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuUtil::ExecuteCmd).stubs().will(returnValue(1));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTest_Succ)
{
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTest_Failed)
{
    MOCKER(ProcMgrBindThread).stubs().will(returnValue(2));
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_NE(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTestWithZeroAicpu1_Succ)
{
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTestWithZeroAicpu2_Succ)
{
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;
    EXPECT_EQ(tp.SetAffinity(0, 32), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTestWithOneAicpu_Succ)
{
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = true;
    EXPECT_EQ(tp.SetAffinity(0, 32), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityBySelfTestWithZeroAicpu1_Succ)
{
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(0));
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityBySelfTestWithZeroAicpu2_Succ)
{
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(0));
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
    MOCKER_CPP(&halGetVdevNum).stubs().will(invoke(halGetVdevNumStub));
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;
    EXPECT_EQ(tp.SetAffinity(0, 32), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityBySelfTestWithOneAicpu_Succ)
{
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(0));
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
    MOCKER_CPP(&halGetVdevNum).stubs().will(invoke(halGetVdevNumStub));
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = true;
    EXPECT_EQ(tp.SetAffinity(0, 32), 0);
}

TEST_F(AICPUSDWorkerTEST, SetThreadSchedModeByTsd_FAIL)
{
    ThreadPool tp;
    tp.threadIdLists_ = std::move(std::vector<pid_t>(100, 0));
    tp.SetThreadSchedModeByTsd();
    EXPECT_EQ(tp.threadIdLists_.empty(), false);
}

TEST_F(AICPUSDWorkerTEST, SetThreadSchedModeByTsd_FAIL_02)
{
    ThreadPool tp;
    tp.threadIdLists_ = std::move(std::vector<pid_t>(10, 0));
    MOCKER(SetSubProcScheduleMode).stubs().will(returnValue(1));
    tp.SetThreadSchedModeByTsd();
    EXPECT_EQ(tp.threadIdLists_.empty(), false);
}

TEST_F(AICPUSDWorkerTEST, SetThreadSchedModeByTsd_FAIL_03)
{
    ThreadPool tp;
    tp.threadIdLists_ = std::move(std::vector<pid_t>(10, 0));
    MOCKER(SetSubProcScheduleMode).stubs().will(returnValue(1));
    std::vector<uint32_t> deviceVec = AicpuDrvManager::GetInstance().deviceVec_;
    AicpuDrvManager::GetInstance().deviceVec_.clear();
    tp.SetThreadSchedModeByTsd();
    AicpuDrvManager::GetInstance().deviceVec_ = deviceVec;
    EXPECT_EQ(tp.threadIdLists_.empty(), false);
}

namespace {
std::vector<uint32_t> g_recordedCoreAffinity;
uint32_t ProcMgrBindThreadRecordStub(pid_t threadId, const std::vector<uint32_t>& coreAffinity)
{
    (void)threadId;
    g_recordedCoreAffinity = coreAffinity;
    return 0U;
}
} // namespace

// No AICPU core: GetWorkerNum returns NO_AICPU_WORKER_NUM (2).
TEST_F(AICPUSDWorkerTEST, GetWorkerNum_NoAicpuReturnsTwo)
{
    MOCKER_CPP(&AicpuDrvManager::GetAicpuNum).stubs().will(returnValue(0U));
    EXPECT_EQ(ThreadPool::GetWorkerNum(), 2UL);
}

// With AICPU cores: GetWorkerNum returns the AICPU core number.
TEST_F(AICPUSDWorkerTEST, GetWorkerNum_WithAicpuReturnsCoreNum)
{
    MOCKER_CPP(&AicpuDrvManager::GetAicpuNum).stubs().will(returnValue(8U));
    EXPECT_EQ(ThreadPool::GetWorkerNum(), 8UL);
}

// No AICPU core: worker 0 should bind to the largest CTRLCPU core,
// worker 1 to the second largest CTRLCPU core.
TEST_F(AICPUSDWorkerTEST, GetNoAicpuCcpuPhysIndex_BindLargestTwoCcpu)
{
    ThreadPool tp;
    auto& drv = AicpuDrvManager::GetInstance();
    const auto bakCcpu = drv.ccpuIdVec_;
    const auto bakCore = drv.coreNumPerDev_;
    drv.ccpuIdVec_ = {2U, 5U, 8U, 11U};
    drv.coreNumPerDev_ = 0U;
    // worker 0 -> largest core (11), worker 1 -> second largest core (8)
    EXPECT_EQ(tp.GetNoAicpuCcpuPhysIndex(0, 0), 11U);
    EXPECT_EQ(tp.GetNoAicpuCcpuPhysIndex(1, 0), 8U);
    drv.ccpuIdVec_ = bakCcpu;
    drv.coreNumPerDev_ = bakCore;
}

// No AICPU core but no CTRLCPU core available: return invalid id to skip binding.
TEST_F(AICPUSDWorkerTEST, GetNoAicpuCcpuPhysIndex_EmptyReturnsInvalid)
{
    ThreadPool tp;
    auto& drv = AicpuDrvManager::GetInstance();
    const auto bakCcpu = drv.ccpuIdVec_;
    drv.ccpuIdVec_.clear();
    EXPECT_EQ(tp.GetNoAicpuCcpuPhysIndex(0, 0), INVALID_AICPU_ID);
    drv.ccpuIdVec_ = bakCcpu;
}

// No AICPU core and fewer CTRLCPU cores than workers: extra workers fall back to the smallest core.
TEST_F(AICPUSDWorkerTEST, GetNoAicpuCcpuPhysIndex_MoreWorkersThanCoresFallback)
{
    ThreadPool tp;
    auto& drv = AicpuDrvManager::GetInstance();
    const auto bakCcpu = drv.ccpuIdVec_;
    const auto bakCore = drv.coreNumPerDev_;
    drv.ccpuIdVec_ = {3U, 7U};
    drv.coreNumPerDev_ = 0U;
    // worker index (5) >= ccpu num (2) -> fall back to the smallest core ccpuIdVec_[0] = 3
    EXPECT_EQ(tp.GetNoAicpuCcpuPhysIndex(5, 0), 3U);
    drv.ccpuIdVec_ = bakCcpu;
    drv.coreNumPerDev_ = bakCore;
}

// No AICPU core: CreateWorker should start two work threads.
TEST_F(AICPUSDWorkerTEST, CreateWorkerNoAicpuCreatesTwoWorkers)
{
    MOCKER(sem_init).stubs().will(returnValue(0));
    MOCKER(sem_wait).stubs().will(returnValue(0));
    MOCKER(sem_destroy).stubs().will(returnValue(0));
    MOCKER(signal).stubs().will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    MOCKER_CPP(&ThreadPool::CreateOneWorker).expects(exactly(2)).will(returnValue(0));
    ThreadPool tp;
    auto& drv = AicpuDrvManager::GetInstance();
    const auto bakPerDev = drv.aicpuNumPerDev_;
    const auto bakDevNum = drv.deviceNum_;
    const auto bakDevVec = drv.deviceVec_;
    drv.aicpuNumPerDev_ = 0U; // GetAicpuNum() == 0 -> no aicpu core
    drv.deviceNum_ = 1UL;
    drv.deviceVec_.clear();
    drv.deviceVec_.push_back(0);

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    (void)tp.CreateWorker(schedMode);
    EXPECT_EQ(tp.hasAicpu_, false);
    EXPECT_EQ(tp.sems_.size(), 2UL);
    EXPECT_EQ(tp.threadStatusList_.size(), 2UL);

    drv.aicpuNumPerDev_ = bakPerDev;
    drv.deviceNum_ = bakDevNum;
    drv.deviceVec_ = bakDevVec;
}

// No AICPU core: SetAffinityBySelf for both workers should succeed and bind successfully.
TEST_F(AICPUSDWorkerTEST, SetAffinityBySelf_NoAicpu_TwoWorkers_Succ)
{
    MOCKER(pthread_setaffinity_np).stubs().will(returnValue(0));
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ThreadPool tp;
    auto& drv = AicpuDrvManager::GetInstance();
    const auto bakCcpu = drv.ccpuIdVec_;
    const auto bakCore = drv.coreNumPerDev_;
    drv.ccpuIdVec_ = {0U, 1U, 2U, 3U};
    drv.coreNumPerDev_ = 0U;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(2, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
    EXPECT_EQ(tp.threadStatusList_[0], ThreadStatus::THREAD_RUNNING);
    EXPECT_EQ(tp.SetAffinity(1, 0), 0);
    EXPECT_EQ(tp.threadStatusList_[1], ThreadStatus::THREAD_RUNNING);
    drv.ccpuIdVec_ = bakCcpu;
    drv.coreNumPerDev_ = bakCore;
}

// No AICPU core via ProcMgr: worker 0 binds to the largest CTRLCPU core, worker 1 to the second largest.
TEST_F(AICPUSDWorkerTEST, SetAffinityByPm_NoAicpu_BindLargestTwoCcpu)
{
    MOCKER(ProcMgrBindThread).stubs().will(invoke(ProcMgrBindThreadRecordStub));
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    auto& drv = AicpuDrvManager::GetInstance();
    const auto bakCcpu = drv.ccpuIdVec_;
    const auto bakCore = drv.coreNumPerDev_;
    drv.ccpuIdVec_ = {0U, 1U, 4U, 9U};
    drv.coreNumPerDev_ = 0U;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(2, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;

    g_recordedCoreAffinity.clear();
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
    ASSERT_EQ(g_recordedCoreAffinity.size(), 1UL);
    EXPECT_EQ(g_recordedCoreAffinity[0], 9U); // largest core

    g_recordedCoreAffinity.clear();
    EXPECT_EQ(tp.SetAffinity(1, 0), 0);
    ASSERT_EQ(g_recordedCoreAffinity.size(), 1UL);
    EXPECT_EQ(g_recordedCoreAffinity[0], 4U); // second largest core

    drv.ccpuIdVec_ = bakCcpu;
    drv.coreNumPerDev_ = bakCore;
}
