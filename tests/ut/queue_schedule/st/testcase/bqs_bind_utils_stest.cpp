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
#include <iostream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"
#include "ProcMgrSysOperatorAgent.h"
#include "common/bqs_feature_ctrl.h"
#define private public
#define protected public
#include "server/bind_cpu_utils.h"
#include "peek_state.h"
#include "queue_schedule.h"
#undef private
#undef protected

using namespace std;
using namespace bqs;

#ifdef __cplusplus
extern "C" {
drvError_t halGetDeviceInfoStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value) {
    *value = 1;
    return DRV_ERROR_NONE;
}
}
#endif

class BQS_BIND_UTILS_STest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before bqs_bind_utils_stest" << endl;
    }

    virtual void TearDown()
    {
        cout << "after bqs_bind_utils_stest" << endl;
        GlobalMockObject::verify();
    }

    void TestGetDevCpuInfoFail(uint32_t failIndex)
    {
        MOCKER(halGetDeviceInfo)
            .stubs()
            .will(repeat(DRV_ERROR_NONE, failIndex))
            .then(returnValue((int) DRV_ERROR_IOCRL_FAIL));
        const uint32_t deviceId = 0;
        std::vector<uint32_t> cpuIds;
        std::vector<uint32_t> aicpuIds;
        uint32_t coreNumPerDev;
        uint32_t aicpuNum;
        uint32_t aicpuBaseId;
        auto ret = BindCpuUtils::GetDevCpuInfo(deviceId, aicpuIds, cpuIds, coreNumPerDev, aicpuNum, aicpuBaseId);
        EXPECT_EQ(ret, BQS_STATUS_DRIVER_ERROR);
    }
};

TEST_F(BQS_BIND_UTILS_STest, BindAicpu_InitSem)
{
    MOCKER(sem_init)
            .stubs()
            .will(returnValue(-1))
            .then(returnValue(0));
    EXPECT_EQ(::bqs::BindCpuUtils::InitSem(), BQS_STATUS_INNER_ERROR);
    EXPECT_EQ(::bqs::BindCpuUtils::InitSem(), BQS_STATUS_OK);
}

TEST_F(BQS_BIND_UTILS_STest, BindAicpu_WaitSem)
{
    MOCKER(sem_wait)
            .stubs()
            .will(returnValue(-1))
            .then(returnValue(0));
    MOCKER(sem_destroy)
            .stubs()
            .will(returnValue(0));
    EXPECT_EQ(::bqs::BindCpuUtils::WaitSem(), BQS_STATUS_INNER_ERROR);
     EXPECT_EQ(::bqs::BindCpuUtils::WaitSem(), BQS_STATUS_OK);
}

TEST_F(BQS_BIND_UTILS_STest, BindAicpu_PostSem)
{
    MOCKER(sem_post)
            .stubs()
            .will(returnValue(-1))
            .then(returnValue(0));
    MOCKER(sem_destroy)
            .stubs()
            .will(returnValue(0));
    EXPECT_EQ(::bqs::BindCpuUtils::PostSem(), BQS_STATUS_INNER_ERROR);
    EXPECT_EQ(::bqs::BindCpuUtils::PostSem(), BQS_STATUS_OK);
    MOCKER(sem_destroy)
            .stubs()
            .will(returnValue(0));
    ::bqs::BindCpuUtils::DestroySem();
}

TEST_F(BQS_BIND_UTILS_STest, BindAicpuByPm_SUCCESS)
{
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    auto ret = BindCpuUtils::BindAicpu(0);
    EXPECT_EQ(ret, BQS_STATUS_OK);
}

TEST_F(BQS_BIND_UTILS_STest, BindAicpuByPm_failed)
{
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    MOCKER(ProcMgrBindThread)
                .stubs()
                .will(returnValue(1));
    auto ret = BindCpuUtils::BindAicpu(0);
    EXPECT_EQ(ret, BQS_STATUS_INNER_ERROR);
}

// TEST_F(BQS_BIND_UTILS_STest, BindAicpu_host_success)
// {
//     bqs::InitQsParams params;
//     bqs::QueueSchedule qs(params);
//     qs.hasAICPU_ = false;
//     MOCKER(sem_init).stubs().then(returnValue(0));
//     ::bqs::BindCpuUtils::InitSem();
//     MOCKER(sem_post).stubs().then(returnValue(0));
//     MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::HOST));
//     qs.BindAicpu(0, 0);
// }

TEST_F(BQS_BIND_UTILS_STest, SetThreadAffinity_01)
{
    int64_t chipType = 66048;
    MOCKER(halGetDeviceInfo)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&chipType))
        .will(returnValue((int)DRV_ERROR_NONE));
    BindCpuUtils::SetThreadFIFO(0);
    MOCKER(halGetDeviceInfo)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&chipType))
        .will(returnValue(1));
    BindCpuUtils::SetThreadFIFO(0);
    MOCKER(pthread_setaffinity_np)
            .stubs()
            .will(returnValue(-1));
    pthread_t threadId = pthread_self();
    std::vector<uint32_t> cpuIds = {0};
    EXPECT_EQ(BindCpuUtils::SetThreadAffinity(threadId, cpuIds), BQS_STATUS_INNER_ERROR);
}

TEST_F(BQS_BIND_UTILS_STest, SetThreadAffinity_02)
{
    MOCKER(pthread_setaffinity_np)
            .stubs()
            .will(returnValue(0));
    pthread_t threadId = pthread_self();
    std::vector<uint32_t> cpuIds = {0};
    EXPECT_EQ(BindCpuUtils::SetThreadAffinity(threadId, cpuIds), BQS_STATUS_OK);
}

TEST_F(BQS_BIND_UTILS_STest, SetThreadAffinity_03)
{
    MOCKER(pthread_getaffinity_np)
            .stubs()
            .will(returnValue(-1));
    pthread_t threadId = pthread_self();
    std::vector<uint32_t> cpuIds = {0};
    EXPECT_EQ(BindCpuUtils::SetThreadAffinity(threadId, cpuIds), BQS_STATUS_INNER_ERROR);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_driver_failed_001)
{
    TestGetDevCpuInfoFail(0U);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_driver_failed_002)
{
    TestGetDevCpuInfoFail(1U);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_driver_failed_003)
{
    TestGetDevCpuInfoFail(2U);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_driver_failed_004)
{
    TestGetDevCpuInfoFail(3U);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_driver_failed_005)
{
    TestGetDevCpuInfoFail(4U);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_driver_failed_006)
{
    TestGetDevCpuInfoFail(5U);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_driver_failed_007)
{
    TestGetDevCpuInfoFail(6U);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_driver_failed_008)
{
    TestGetDevCpuInfoFail(7U);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_SUCCESS)
{
    int64_t num = 1;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&num))
        .will(returnValue(DRV_ERROR_NONE));
    const uint32_t deviceId = 1;
    std::vector<uint32_t> cpuInfo;
    std::vector<uint32_t> cpuIds;
    uint32_t coreNumPerDev;
    uint32_t aicpuNum;
    uint32_t aicpuBaseId;
    auto ret = BindCpuUtils::GetDevCpuInfo(deviceId, cpuInfo, cpuIds, coreNumPerDev, aicpuNum, aicpuBaseId);
    EXPECT_EQ(ret, BQS_STATUS_OK);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_001)
{
    MOCKER(halGetDeviceInfo)
            .stubs()
            .will(invoke(halGetDeviceInfoStub));
    const uint32_t deviceId = 1;
    std::vector<uint32_t> cpuInfo;
    std::vector<uint32_t> cpuIds;
    uint32_t coreNumPerDev;
    uint32_t aicpuNum;
    uint32_t aicpuBaseId;
    MOCKER_CPP(&FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    auto ret = BindCpuUtils::GetDevCpuInfo(deviceId, cpuInfo, cpuIds, coreNumPerDev, aicpuNum, aicpuBaseId);
    EXPECT_EQ(ret, BQS_STATUS_OK);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_002)
{
    MOCKER(halGetDeviceInfo)
            .stubs()
            .will(invoke(halGetDeviceInfoStub));
    const uint32_t deviceId = 32;
    std::vector<uint32_t> cpuInfo;
    std::vector<uint32_t> cpuIds;
    uint32_t coreNumPerDev;
    uint32_t aicpuNum;
    uint32_t aicpuBaseId;
    auto ret = BindCpuUtils::GetDevCpuInfo(deviceId, cpuInfo, cpuIds, coreNumPerDev, aicpuNum, aicpuBaseId);
    EXPECT_EQ(ret, BQS_STATUS_OK);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_003)
{
    MOCKER(halGetDeviceInfo)
            .stubs()
            .will(invoke(halGetDeviceInfoStub));
    const uint32_t deviceId = 48;
    std::vector<uint32_t> cpuInfo;
    std::vector<uint32_t> cpuIds;
    uint32_t coreNumPerDev;
    uint32_t aicpuNum;
    uint32_t aicpuBaseId;
    auto ret = BindCpuUtils::GetDevCpuInfo(deviceId, cpuInfo, cpuIds, coreNumPerDev, aicpuNum, aicpuBaseId);
    EXPECT_EQ(ret, BQS_STATUS_OK);
}

TEST_F(BQS_BIND_UTILS_STest, GetDevCpuInfo_004)
{
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(1));
    const uint32_t deviceId = 48;
    std::vector<uint32_t> cpuInfo;
    std::vector<uint32_t> cpuIds;
    uint32_t coreNumPerDev;
    uint32_t aicpuNum;
    uint32_t aicpuBaseId;
    auto ret = BindCpuUtils::GetDevCpuInfo(deviceId, cpuInfo, cpuIds, coreNumPerDev, aicpuNum, aicpuBaseId);
    EXPECT_EQ(ret, BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_BIND_UTILS_STest, WriteTidToCpuSet)
{
    MOCKER(system).stubs().will(returnValue(-1));
    auto ret = BindCpuUtils::WriteTidToCpuSet();
    EXPECT_EQ(ret, BQS_STATUS_INNER_ERROR);
}