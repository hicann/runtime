/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <thread>
#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "core/aicpusd_drv_manager.h"
#include "core/aicpusd_worker.h"
#include "core/aicpusd_resource_manager.h"
#include "aicpusd_monitor.h"
#include "core/aicpusd_event_manager.h"
#include "aicpu_pulse.h"
#include "aicpusd_so_manager.h"
#include "tdt_server.h"
#include "task_queue.h"
#undef private
#include "gtest/gtest.h"

namespace AicpuSchedule{
class HostCpuDrvManagerTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "HostCpuDrvManagerTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "HostCpuDrvManagerTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "HostCpuDrvManagerTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "HostCpuDrvManagerTEST TearDown" << std::endl;
    }
};

ModelStreamManager &ModelStreamManager::GetInstance()
{
    static ModelStreamManager instance;
    return instance;
}

BufManager &BufManager::GetInstance()
{
    static BufManager instance;
    return instance;
}

void BufManager::InitBufManager()
{
}

EventWaitManager &EventWaitManager::NotifyWaitManager(const uint32_t waitIdCount)
{
    static EventWaitManager notifyWaitInstance("Notify", waitIdCount);
    return notifyWaitInstance;
}

EventWaitManager &EventWaitManager::EndGraphWaitManager(const uint32_t waitIdCount)
{
    static EventWaitManager endGraphWaitInstance("EndGraph", waitIdCount);
    return endGraphWaitInstance;
}

EventWaitManager &EventWaitManager::QueueNotEmptyWaitManager(const uint32_t waitIdCount)
{
    static EventWaitManager queueNotEmptyWaitInstance("QueueNotEmpty", waitIdCount);
    return queueNotEmptyWaitInstance;
}

EventWaitManager &EventWaitManager::QueueNotFullWaitManager(const uint32_t waitIdCount)
{
    static EventWaitManager queueNotFullWaitInstance("QueueNotFull", waitIdCount);
    return queueNotFullWaitInstance;
}

EventWaitManager &EventWaitManager::PrepareMemWaitManager(const uint32_t waitIdCount)
{
    static EventWaitManager prepareMemWaitInstance("PrepareMem", waitIdCount);
    return prepareMemWaitInstance;
}

EventWaitManager &EventWaitManager::AnyQueNotEmptyWaitManager(const uint32_t waitIdCount)
{
    static EventWaitManager anyQueNotEmptyWaitInstance("AnyQueNotEmpty", waitIdCount);
    return anyQueNotEmptyWaitInstance;
}

EventWaitManager &EventWaitManager::TableUnlockWaitManager(const uint32_t waitIdCount)
{
    static EventWaitManager tableUnlockWaitInstance("TableUnlock", waitIdCount);
    return tableUnlockWaitInstance;
}

AicpuMonitor::AicpuMonitor() {}

AicpuMonitor::~AicpuMonitor() {}

AicpuMonitor &AicpuMonitor::GetInstance()
{
    static AicpuMonitor instance;
    return instance;
}

int32_t AicpuMonitor::Run()
{
    return AICPU_SCHEDULE_OK;
}

AicpuEventManager::AicpuEventManager() {}

AicpuEventManager &AicpuEventManager::GetInstance()
{
    static AicpuEventManager instance;
    return instance;
}

void AicpuEventManager::LoopProcess(const uint32_t threadIndex)
{
}

int32_t AicpuEventManager::DoOnce(const uint32_t threadIndex, const uint32_t deviceId, const int32_t timeout)
{
}

void AicpuEventManager::SetRunningFlag(const bool runningFlag)
{
}
}

namespace aicpu{
status_t aicpuSetContext(aicpuContext_t *ctx)
{
    return AICPU_ERROR_NONE;
}
status_t SetAicpuThreadIndex(uint32_t threadIndex)
{
    return AICPU_ERROR_NONE;
}
}

void ClearPulseNotifyFunc()
{
}

pid_t drvDeviceGetBareTgid(void)
{
    return getpid();
}

drvError_t drvBindHostPid(struct drvBindHostpidInfo info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
                                  unsigned int *host_pid, unsigned int *cp_type)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value != nullptr) {
        *value = 1;
    }
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfoHostFake1(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value != nullptr) {
        if (infoType == INFO_TYPE_CORE_NUM) {
            *value = 1;
        } else if (infoType == INFO_TYPE_OCCUPY) {
            *value = 1;
        }
    }
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfoHostFake2(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    return DRV_ERROR_PARA_ERROR;
}

drvError_t halGetDeviceInfoHostFake3(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value != nullptr) {
        if (infoType == INFO_TYPE_CORE_NUM) {
            *value = 1;
        } else if (infoType == INFO_TYPE_OCCUPY) {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

int halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max_num)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSetEventPriority(unsigned int devId, EVENT_ID eventId, SCHEDULE_PRIORITY priority)
{
    return DRV_ERROR_NONE;
}

namespace AicpuSchedule{
TEST_F(HostCpuDrvManagerTEST, SetAffinityBySelfHostCpuBindSuccess) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(0U);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoHostFake1)).then(invoke(halGetDeviceInfoHostFake1));;
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(HostCpuDrvManagerTEST, SetAffinityBySelfHostCpuBindFail) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(0U);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoHostFake1)).then(invoke(halGetDeviceInfoHostFake1));;
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(-1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(HostCpuDrvManagerTEST, SetAffinityBySelfHostCpuUnBindSuccess) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(0U);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoHostFake3)).then(invoke(halGetDeviceInfoHostFake3));;
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(HostCpuDrvManagerTEST, SetAffinityBySelfHostCpuUnBindFail) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(0U);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoHostFake3)).then(invoke(halGetDeviceInfoHostFake3));;
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, DRV_ERROR_NONE);
    MOCKER_CPP(&ThreadPool::WriteTidForAffinity)
        .stubs()
        .will(returnValue(0));
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(-1));
    MOCKER_CPP(&ThreadPool::PostSem)
        .stubs();
    ThreadPool tp;
    tp.threadStatusList_ = std::move(std::vector<ThreadStatus>(1, ThreadStatus::THREAD_INIT));
    EXPECT_EQ(tp.SetAffinity(0, 0), 0);
}

TEST_F(HostCpuDrvManagerTEST, GetHostAicpuInfoFail) {
    std::vector<uint32_t> device_vec;
    device_vec.push_back(0U);
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfoHostFake2)).then(invoke(halGetDeviceInfoHostFake2));;
    int ret = AicpuDrvManager::GetInstance().GetNormalAicpuInfo(device_vec);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INIT_FAILED);
}

TEST_F(HostCpuDrvManagerTEST, SetDeviceIdToDvpp) {
    AicpuSchedule::AicpuSoManager::GetInstance().SetDeviceIdToDvpp(0);
    EXPECT_EQ(AicpuSchedule::AicpuSoManager::GetInstance().soHandle_, nullptr);
}


TEST_F(HostCpuDrvManagerTEST, OnPreprocessEvent)
{
    uint32_t eventId = 2;
    DataPreprocess::TaskQueueMgr::GetInstance().OnPreprocessEvent(eventId);
    EXPECT_EQ(DataPreprocess::TaskQueueMgr::GetInstance().cancelLastword_, nullptr);
}

TEST_F(HostCpuDrvManagerTEST, TDTServerInit) {
    const std::list<uint32_t> bindCoreList;
    int32_t ret = tdt::TDTServerInit(0, bindCoreList);
    EXPECT_EQ(ret, 0);
}

TEST_F(HostCpuDrvManagerTEST, TDTServerStop) {
    int32_t ret = tdt::TDTServerStop();
    EXPECT_EQ(ret, 0);
}

TEST_F(HostCpuDrvManagerTEST, GetErrDesc) {
    std::string ret = tdt::StatusFactory::GetInstance()->GetErrDesc(0);
    EXPECT_EQ(ret, "");
    ret = tdt::StatusFactory::GetInstance()->GetErrCodeDesc(0);
    EXPECT_EQ(ret, "");
}
}