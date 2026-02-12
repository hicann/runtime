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
#include <fstream>
#include <thread>
#include <vector>
#include <signal.h>
#include <iostream>
#include <seccomp.h>
#include <stdio.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "tsd.h"
#include "profiling_adp.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpu_context.h"
#include "seccomp.h"
#include "aicpusd_common.h"
#include "feature_ctrl.h"

#define private public
#include "core/aicpusd_event_manager.h"
#include "core/aicpusd_drv_manager.h"
#include "core/aicpusd_worker.h"
#include "aicpusd_monitor.h"
#include "aicpusd_util.h"
#undef private

using namespace AicpuSchedule;

namespace {
void WaitAndStopThread(uint32_t time)
{
    std::this_thread::sleep_for(std::chrono::milliseconds(time));
    AicpuEventManager::GetInstance().SetRunningFlag(false);
}

void CreateSyscallFile(const std::string &fileName)
{
    std::ofstream outFile(fileName);
    if (!outFile) {
        std::cout << "Can not create file: " << fileName << std::endl;
        return;
    }

    outFile << "recv" << std::endl;
    outFile << "write" << std::endl;
    outFile << "recvmsg" << std::endl;
    outFile.close();
}
}  // namespace

class AICPUCusWorkerTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUCusWorkerTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUCusWorkerTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUCusWorkerTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUCusWorkerTEST TearDown" << std::endl;
    }
};

int32_t halGetVdevNumStub(uint32_t *num_dev)
{
    *num_dev = 1;
    return 0;
}

TEST_F(AICPUCusWorkerTEST, CreateWorkTest) {

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
    MOCKER(sem_destroy)
        .stubs()
        .will(returnValue(0));
    MOCKER(signal)
        .stubs()
        .will(returnValue(sighandler_t(1)));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();

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
    MOCKER_CPP(&ThreadPool::SecureCompute)
        .stubs()
        .will(returnValue(0));

    auto ret = AicpuDrvManager::GetInstance().InitDrvMgr(0, 0, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    ret = tp.CreateWorker();
    EXPECT_NE(ret, 0);
    ret = AicpuDrvManager::GetInstance().InitDrvMgr(1, 0, 1, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = AicpuDrvManager::GetInstance().InitDrvMgr(100, 0, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
    // wait for thread run end
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
}

TEST_F(AICPUCusWorkerTEST, CreateWorkTest_aicpu_no_0) {
    ThreadPool tp;
    AicpuDrvManager::GetInstance().aicpuNum_ = 0;
    AicpuSchedule::AicpuMonitor::GetInstance().done_ = false;
    int32_t ret = tp.CreateWorker();
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUCusWorkerTEST, CreateWorkTest_sem_init_fail) {
    AicpuDrvManager::GetInstance().aicpuNum_ = 1;
    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(-1));
    int32_t ret = tp.CreateWorker();
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUCusWorkerTEST, CreateWorkTest_CreateOneWorker_fail) {
    AicpuDrvManager::GetInstance().aicpuNum_ = 1;
    ThreadPool tp;
    MOCKER(sem_init)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::CreateOneWorker)
        .stubs()
        .will(returnValue(-1));
    int32_t ret = tp.CreateWorker();
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUCusWorkerTEST, CreateWorkTest_sem_wait_fail) {
    AicpuDrvManager::GetInstance().aicpuNum_ = 1;
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
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    int32_t ret = tp.CreateWorker();
    EXPECT_NE(ret, 0);
    ret = tp.CreateWorker();
    EXPECT_NE(ret, 0);
}

TEST_F(AICPUCusWorkerTEST, WorkTest) {
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
    MOCKER_CPP(&ThreadPool::SecureCompute)
        .stubs()
        .will(returnValue(0));
    ThreadPool tp;

    std::thread th(&WaitAndStopThread, 100);
    tp.Work(0);
    th.join();
    auto ret = tp.SecureCompute(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUCusWorkerTEST, SecureComputeTest) {
    ThreadPool tp;
    ThreadStatus s = ThreadStatus::THREAD_INIT;
    tp.threadStatus_.push_back(s);
    auto ret = tp.SecureCompute(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(tp.threadStatus_[0], ThreadStatus::THREAD_RUNNING);
}

TEST_F(AICPUCusWorkerTEST, SecureComputeTest_002) {
    ThreadPool tp;
    ThreadStatus s = ThreadStatus::THREAD_INIT;
    tp.threadStatus_.push_back(s);
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    EXPECT_EQ(tp.SecureCompute(0), 0);
}

TEST_F(AICPUCusWorkerTEST, SecureComputeTest_fall2) {
    MOCKER(seccomp_load)
        .stubs()
        .will(returnValue(-1));
    ThreadPool tp;
    ThreadStatus s = ThreadStatus::THREAD_INIT;
    tp.threadStatus_.push_back(s);
    EXPECT_EQ(tp.SecureCompute(0), 0);
}

TEST_F(AICPUCusWorkerTEST, WorkTest_Fail1) {
    MOCKER(halEschedSubscribeEvent)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    tp.Work(0);
    EXPECT_EQ(AicpuSchedule::AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AICPUCusWorkerTEST, WorkTest_Fail2) {
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
    MOCKER_CPP(&ThreadPool::SecureCompute)
        .stubs()
        .will(returnValue(0));

    MOCKER(aicpu::aicpuSetContext)
        .stubs()
        .will(returnValue(1));
    ThreadPool tp;
    tp.Work(0);
    EXPECT_EQ(AicpuSchedule::AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AICPUCusWorkerTEST, WorkTest_Fail3) {
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

    MOCKER_CPP(&ThreadPool::SecureCompute)
        .stubs()
        .will(returnValue(-1));

    ThreadPool tp;
    tp.Work(0);
    EXPECT_EQ(AicpuSchedule::AicpuEventManager::GetInstance().runningFlag_, false);
}

TEST_F(AICPUCusWorkerTEST, SetAffinityTest) {
    MOCKER(system)
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
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);

    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_NE(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUCusWorkerTEST, SetAffinityBySelfTest)
{
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(0));
    MOCKER_CPP(&halGetVdevNum).stubs().will(returnValue(1));
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinityBySelf(0), AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUCusWorkerTEST, SetAffinityBySelfTestFail)
{
    MOCKER_CPP(&ThreadPool::AddPidToTask).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INIT_FAILED));
    MOCKER_CPP(&halGetVdevNum).stubs().will(returnValue(1));
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinityBySelf(0), AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUCusWorkerTEST, SetAffinityBySelfTestVf)
{
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(0));
    MOCKER_CPP(&halGetVdevNum).stubs().will(invoke(halGetVdevNumStub));
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinityBySelf(0), 0);
}

TEST_F(AICPUCusWorkerTEST, WriteTidForAffinity)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuUtil::ExecuteCmd).stubs().will(returnValue(-1));
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    auto ret = tp.WriteTidForAffinity(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUCusWorkerTEST, WriteTidForAffinityFail)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(waitpid).stubs().will(returnValue(-1));
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    const auto ret = tp.WriteTidForAffinity(100);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUCusWorkerTEST, SetAffinityByPm) {
    MOCKER(ProcMgrBindThread)
        .stubs()
        .will(returnValue(0U))
        .then(returnValue(1U));
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinityByPm(0), 0);
}

TEST_F(AICPUCusWorkerTEST, SetAffinityByPmTest_Succ) {
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUCusWorkerTEST, SetAffinityByPmTest_Failed) {
    MOCKER(ProcMgrBindThread)
        .stubs()
        .will(returnValue(2));
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_NE(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUCusWorkerTEST, PostSemTest) {
    MOCKER(sem_post)
        .stubs()
        .will(returnValue(0));
    ThreadPool tp;
    tp.sems_.resize(1);
    tp.PostSem(0);
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(AICPUCusWorkerTEST, AddPidToTask_Success)
{
    MOCKER_CPP(&FeatureCtrl::IsBindPidByHal).stubs().will(returnValue(true));
    MOCKER(&halBindCgroup).stubs().will(returnValue(0));
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.AddPidToTask(0), 0);
}

TEST_F(AICPUCusWorkerTEST, AddPidToTask_Fail)
{
    MOCKER_CPP(&FeatureCtrl::IsBindPidByHal).stubs().will(returnValue(true));
    MOCKER(&halBindCgroup).stubs().will(returnValue(1));
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.AddPidToTask(0), 22202);
}

TEST_F(AICPUCusWorkerTEST, AddPidToTask_Fail2)
{
    MOCKER_CPP(&FeatureCtrl::IsBindPidByHal).stubs().will(returnValue(false));
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INIT_FAILED));
    ThreadPool tp;
    tp.threadStatus_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.AddPidToTask(0), AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUCusWorkerTEST, InitDrvMgr_001) {
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = AicpuDrvManager::GetInstance().InitDrvMgr(1, 0, 0, true);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUCusWorkerTEST, InitDrvMgr_002) {
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(0));
    auto ret = AicpuDrvManager::GetInstance().InitDrvMgr(48, 0, 0, true);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUCusWorkerTEST, InitDrvMgr_003) {
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    auto ret = AicpuDrvManager::GetInstance().InitDrvMgr(48, 0, 0, true);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(AICPUCusWorkerTEST, GetExpandedSysCalls_With_InvalidFile) {
    MOCKER(access).stubs().will(returnValue(-1));
    std::unordered_set<int32_t> filterSystemCalls;

    ThreadPool tp;
    tp.GetExpandedSysCalls("white_list");
    EXPECT_EQ(tp.expandedSystemCalls_.size(), 0U);
}

TEST_F(AICPUCusWorkerTEST, GetExpandedSysCalls_insert2_from3) {
    CreateSyscallFile("white_list");
    std::unordered_set<int32_t> filterSystemCalls = {64};
    MOCKER(seccomp_syscall_resolve_name)
        .stubs()
        .will(returnValue(-110))
        .then(returnValue(64))
        .then(returnValue(212))
        .then(returnValue(-1));

    ThreadPool tp;
    tp.GetExpandedSysCalls("white_list");
    EXPECT_EQ(tp.expandedSystemCalls_.size(), 2U);
    remove("white_list");
}

TEST_F(AICPUCusWorkerTEST, ExpandSysCallList_insert1_from2) {
    std::unordered_set<int32_t> filterSystemCalls = {64};
    ThreadPool tp;

    tp.expandedSystemCalls_.insert(212);
    tp.expandedSystemCalls_.insert(64);

    tp.ExpandSysCallList(filterSystemCalls);
    EXPECT_EQ(filterSystemCalls.size(), 2U);
}