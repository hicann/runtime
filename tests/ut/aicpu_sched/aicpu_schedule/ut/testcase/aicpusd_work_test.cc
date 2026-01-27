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
#include "ProcMgrSysOperatorAgent.h"
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
    static void SetUpTestCase() {
        std::cout << "AICPUSDWorkerTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUSDWorkerTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUSDWorkerTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUSDWorkerTEST TearDown" << std::endl;
    }
};

namespace {
    int32_t halGetVdevNumStub(uint32_t *num_dev)
    {
        *num_dev = 1;
        return 0;
    }
}

TEST_F(AICPUSDWorkerTEST, CreateWorkTest) {

    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER(signal)
        .stubs()
        .will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    MOCKER_CPP(&ThreadPool::CreateOneWorker)
        .stubs()
        .will(returnValue(0));

    std::vector<uint32_t> deviceId;
    deviceId.push_back(0);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceId, 0, 0, true);

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkTest_aicpu_num_0) {
    MOCKER_CPP(&ThreadPool::CreateOneWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER(signal)
        .stubs()
        .will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 0;
    AicpuDrvManager::GetInstance().deviceVec_.push_back(0);
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkTest_sem_init_fail) {
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(-1));

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkTest_CreateOneWorker_fail) {
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateOneWorker)
        .stubs()
        .will(returnValue(-1));
 
     
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkTest_sem_wait_fail) {
    AicpuDrvManager::GetInstance().aicpuNumPerDev_ = 1;
    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateOneWorker)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
 
     
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
    ret = tp.CreateWorker(schedMode);
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUSDWorkerTEST, CreateOneWorkTest) {
    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_wait)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER(signal)
        .stubs()
        .will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_ERROR_INIT_FAILED));

    std::vector<uint32_t> deviceId;
    deviceId.push_back(0);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceId, 0, 0, true);

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    const int32_t ret = tp.CreateWorker(schedMode);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUSDWorkerTEST, SetThreadStatusSuccess) {
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.SetThreadStatus(0, ThreadStatus::THREAD_RUNNING);
    EXPECT_EQ(tp.threadStatusList_[0], ThreadStatus::THREAD_RUNNING);
}

TEST_F(AICPUSDWorkerTEST, CreateWorkerAicpuIsZero) {
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

TEST_F(AICPUSDWorkerTEST, WorkTest) {
    MOCKER_CPP(&ThreadPool::SetAffinity)
        .stubs()
        .will(returnValue(0));
    MOCKER(system)
        .stubs()
        .will(returnValue(0));
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    AicpuSchedule::ThreadPool::Instance().threadIdLists_ = std::vector<pid_t>(static_cast<size_t>(10), 0);
    tp.Work(0, 0, schedMode);
    EXPECT_EQ(tp.semInitedNum_, 0);
}

TEST_F(AICPUSDWorkerTEST, WorkTest_Fail) {
    MOCKER(halEschedSubscribeEvent)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;

    const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
    tp.Work(0, 0, schedMode);
    EXPECT_EQ(tp.schedMode_, SCHED_MODE_INTERRUPT);
}

TEST_F(AICPUSDWorkerTEST, WorkTestMsqSuccess) {
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

TEST_F(AICPUSDWorkerTEST, WorkTestMsqFail) {
    MOCKER_CPP(&ThreadPool::SetAffinity).stubs().will(returnValue(0));
    MOCKER(system).stubs().will(returnValue(0));
    MOCKER(sem_post).stubs().will(returnValue(0));
    MOCKER_CPP(&ThreadPool::PostSem).stubs();
    ThreadPool tp;

    MOCKER_CPP(&MessageQueue::InitMessageQueueForThread).stubs()
        .will(returnValue(AicpuSchedule::AICPU_SCHEDULE_ERROR_INNER_ERROR));
    const AicpuSchedMode schedMode = SCHED_MODE_MSGQ;
    tp.Work(0, 0, schedMode);
    EXPECT_EQ(tp.schedMode_, SCHED_MODE_INTERRUPT);
}

TEST_F(AICPUSDWorkerTEST, InitInterruptWorkerFail) {
    ThreadPool tp;
    MOCKER(halEschedSubscribeEvent).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));
    const int32_t ret = tp.InitInterruptWorker(0, 0);
    EXPECT_EQ(ret, DRV_ERROR_NOT_SUPPORT);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityBySelfTest) {
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
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

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityTest) {
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ = std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(1));
    MOCKER(waitpid).stubs().will(returnValue(0));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityTestSuccess) {
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ = std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuUtil::ExecuteCmd).stubs().will(returnValue(0));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityErrTest) {
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ = std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(-1));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityErrTest2) {
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ = std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(1));
    MOCKER(waitpid).stubs().will(returnValue(-1));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(threadIndex);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityErrTest3) {
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ = std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(vfork).stubs().will(returnValue(1));
    MOCKER(waitpid).stubs().will(returnValue(-1));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(aicpuNum+1);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUSDWorkerTEST, WriteTidForAffinityExecuteCmdFail) {
    const size_t threadIndex = 1;
    const size_t aicpuNum = 3;
    ThreadPool::Instance().threadStatusList_ = std::move(std::vector<ThreadStatus>(aicpuNum, ThreadStatus::THREAD_INIT));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuUtil::ExecuteCmd).stubs().will(returnValue(1));
    int32_t ret = ThreadPool::Instance().WriteTidForAffinity(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTest_Succ) {
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTest_Failed) {
    MOCKER(ProcMgrBindThread)
        .stubs()
        .will(returnValue(2));
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_NE(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTestWithZeroAicpu1_Succ) {
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTestWithZeroAicpu2_Succ) {
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;
    EXPECT_EQ(tp.SetAffinity(0, 32), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityByPmTestWithOneAicpu_Succ) {
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = true;
    EXPECT_EQ(tp.SetAffinity(0, 32), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityBySelfTestWithZeroAicpu1_Succ) {
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0));
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityBySelfTestWithZeroAicpu2_Succ) {
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&halGetVdevNum)
        .stubs()
        .will(invoke(halGetVdevNumStub));
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = false;
    EXPECT_EQ(tp.SetAffinity(0, 32), 0);
}

TEST_F(AICPUSDWorkerTEST, SetAffinityBySelfTestWithOneAicpu_Succ) {
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&halGetVdevNum)
        .stubs()
        .will(invoke(halGetVdevNumStub));
    setenv("PROCMGR_AICPU_CPUSET", "0", 1);
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    tp.hasAicpu_ = true;
    EXPECT_EQ(tp.SetAffinity(0, 32), 0);
}

TEST_F(AICPUSDWorkerTEST, SetThreadSchedModeByTsd_FAIL) {
    ThreadPool tp;
    tp.threadIdLists_ = std::move(std::vector<pid_t>(100, 0));
    tp.SetThreadSchedModeByTsd();
    EXPECT_EQ(tp.threadIdLists_.empty(), false);
}

TEST_F(AICPUSDWorkerTEST, SetThreadSchedModeByTsd_FAIL_02) {
    ThreadPool tp;
    tp.threadIdLists_ = std::move(std::vector<pid_t>(10, 0));
    MOCKER(SetSubProcScheduleMode)
        .stubs()
        .will(returnValue(1));
    tp.SetThreadSchedModeByTsd();
    EXPECT_EQ(tp.threadIdLists_.empty(), false);
}

TEST_F(AICPUSDWorkerTEST, SetThreadSchedModeByTsd_FAIL_03) {
    ThreadPool tp;
    tp.threadIdLists_ = std::move(std::vector<pid_t>(10, 0));
    MOCKER(SetSubProcScheduleMode)
        .stubs()
        .will(returnValue(1));
    std::vector<uint32_t> deviceVec = AicpuDrvManager::GetInstance().deviceVec_;
    AicpuDrvManager::GetInstance().deviceVec_.clear();
    tp.SetThreadSchedModeByTsd();
    AicpuDrvManager::GetInstance().deviceVec_ = deviceVec;
    EXPECT_EQ(tp.threadIdLists_.empty(), false);
}