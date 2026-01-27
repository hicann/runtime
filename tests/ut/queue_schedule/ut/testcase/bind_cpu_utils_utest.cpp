/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "server/bind_cpu_utils.h"
#include <stdlib.h>
#include <semaphore.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "ProcMgrSysOperatorAgent.h"
#include "common/bqs_feature_ctrl.h"

#ifdef __cplusplus
extern "C" {
drvError_t halGetDeviceInfoStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value) {
    *value = 1;
    return DRV_ERROR_NONE;
}
}
#endif

// extern "C" int open(const char *pathname, int flags);
// extern "C" int close(int fd);

namespace bqs {
class BindCpuUtilsUTest : public testing::Test {
protected:
    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

public:
    void MockWriteFileSuccess()
    {
        MOCKER(system).stubs()
                .will(returnValue(0));
    }

    void MockBindSuccess()
    {
        setenv("PROCMGR_AICPU_CPUSET", "0", 1);
        MockWriteFileSuccess();
        CPU_ZERO(&mask_);
        CPU_SET(static_cast<int>(aicpuBeginIndex_), &mask_);
        MOCKER(pthread_getaffinity_np)
                .stubs()
                .with(mockcpp::any(), mockcpp::any(), outBoundP((&mask_), sizeof(cpu_set_t)))
                .will(returnValue(0));
    }

    void MockBindFailed()
    {
        setenv("PROCMGR_AICPU_CPUSET", "0", 1);
        MockWriteFileSuccess();
        CPU_ZERO(&mask_);
        MOCKER(pthread_getaffinity_np)
                .stubs()
                .with(mockcpp::any(), mockcpp::any(), outBoundP((&mask_), sizeof(cpu_set_t)))
                .will(returnValue(0));
    }

    void TestGetDevCpuInfoFail(uint32_t failIndex)
    {
        MOCKER(halGetDeviceInfo)
            .stubs()
            .will(repeat(DRV_ERROR_NONE, failIndex))
            .then(returnValue((int) DRV_ERROR_IOCRL_FAIL));
        const uint32_t deviceId = 0;
        std::vector<uint32_t> cpuInfo;
        std::vector<uint32_t> cpuIds;
        uint32_t coreNumPerDev;
        uint32_t aicpuNum;
        uint32_t aicpuBaseId;
        auto ret = BindCpuUtils::GetDevCpuInfo(deviceId, cpuInfo, cpuIds, coreNumPerDev, aicpuNum, aicpuBaseId);
        EXPECT_EQ(ret, BQS_STATUS_DRIVER_ERROR);
    }

    uint32_t aicpuBeginIndex_ = 0;
    cpu_set_t mask_;
};

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_driver_failed_001)
{
    TestGetDevCpuInfoFail(0U);
}

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_driver_failed_002)
{
    TestGetDevCpuInfoFail(1U);
}

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_driver_failed_003)
{
    TestGetDevCpuInfoFail(2U);
}

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_driver_failed_004)
{
    TestGetDevCpuInfoFail(3U);
}

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_driver_failed005)
{
    TestGetDevCpuInfoFail(4U);
}

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_driver_failed006)
{
    TestGetDevCpuInfoFail(5U);
}

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_driver_failed007)
{
    TestGetDevCpuInfoFail(6U);
}

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_driver_failed008)
{
    TestGetDevCpuInfoFail(7U);
}

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_SUCCESS)
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
    auto ret = BindCpuUtils::GetDevCpuInfo(deviceId, cpuInfo, cpuIds, coreNumPerDev, aicpuNum, aicpuBaseId);
    EXPECT_EQ(ret, BQS_STATUS_OK);
}

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_001)
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

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_002)
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

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_003)
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

TEST_F(BindCpuUtilsUTest, GetDevCpuInfo_004)
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

TEST_F(BindCpuUtilsUTest, BindAicpu_pthread_setaffinity_np_failed_as_system)
{
    MOCKER(system).stubs()
            .will(returnValue(-1));

    MOCKER(pthread_setaffinity_np)
            .stubs()
            .will(returnValue(-1));

    auto ret = BindCpuUtils::BindAicpu(aicpuBeginIndex_);
    EXPECT_EQ(ret, BQS_STATUS_INNER_ERROR);
}

TEST_F(BindCpuUtilsUTest, BindAicpu_pthread_getaffinity_np_failed)
{
    MockWriteFileSuccess();
    MOCKER(pthread_getaffinity_np)
            .stubs()
            .will(returnValue(-1));
    auto ret = BindCpuUtils::BindAicpu(aicpuBeginIndex_);
    EXPECT_EQ(ret, BQS_STATUS_INNER_ERROR);
}

TEST_F(BindCpuUtilsUTest, BindAicpuBySelf_SUCCESS)
{
    MockBindSuccess();
    auto ret = BindCpuUtils::BindAicpu(aicpuBeginIndex_);
    EXPECT_EQ(ret, BQS_STATUS_OK);
}

TEST_F(BindCpuUtilsUTest, BindAicpuBySelf_failed)
{
    MockBindFailed();
    auto ret = BindCpuUtils::BindAicpu(aicpuBeginIndex_);
    EXPECT_EQ(ret, BQS_STATUS_INNER_ERROR);
}

TEST_F(BindCpuUtilsUTest, BindAicpuByPm_SUCCESS)
{
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    auto ret = BindCpuUtils::BindAicpu(aicpuBeginIndex_);
    EXPECT_EQ(ret, BQS_STATUS_OK);
}

TEST_F(BindCpuUtilsUTest, BindAicpuByPm_failed)
{
    setenv("PROCMGR_AICPU_CPUSET", "1", 1);
    MOCKER(ProcMgrBindThread)
                .stubs()
                .will(returnValue(1));
    auto ret = BindCpuUtils::BindAicpu(aicpuBeginIndex_);
    EXPECT_EQ(ret, BQS_STATUS_INNER_ERROR);
}

TEST_F(BindCpuUtilsUTest, BindAicpu_InitSem)
{
    MOCKER(sem_init)
            .stubs()
            .will(returnValue(-1))
            .then(returnValue(0));
    EXPECT_EQ(BindCpuUtils::InitSem(), BQS_STATUS_INNER_ERROR);
    EXPECT_EQ(BindCpuUtils::InitSem(), BQS_STATUS_OK);
}

TEST_F(BindCpuUtilsUTest, BindAicpu_WaitSem)
{
    MOCKER(sem_wait)
            .stubs()
            .will(returnValue(-1))
            .then(returnValue(0));
    MOCKER(sem_destroy)
            .stubs()
            .will(returnValue(0));
    EXPECT_EQ(BindCpuUtils::WaitSem(), BQS_STATUS_INNER_ERROR);
    EXPECT_EQ(BindCpuUtils::WaitSem(), BQS_STATUS_OK);
}

TEST_F(BindCpuUtilsUTest, BindAicpu_PostSem)
{
    MOCKER(sem_post)
            .stubs()
            .will(returnValue(-1))
            .then(returnValue(0));
    MOCKER(sem_destroy)
            .stubs()
            .will(returnValue(0));
    EXPECT_EQ(BindCpuUtils::PostSem(), BQS_STATUS_INNER_ERROR);
    EXPECT_EQ(BindCpuUtils::PostSem(), BQS_STATUS_OK);
    MOCKER(sem_destroy)
            .stubs()
            .will(returnValue(0));
    BindCpuUtils::DestroySem();
}

TEST_F(BindCpuUtilsUTest, SetThreadAffinity_01)
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
    MOCKER(halGetDeviceInfo)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&chipType))
        .will(returnValue(0));
    MOCKER(sched_get_priority_max)
        .stubs()
        .will(returnValue(-1));
    BindCpuUtils::SetThreadFIFO(0);
    MOCKER(pthread_setaffinity_np)
        .stubs()
        .will(returnValue(-1));
    pthread_t threadId = pthread_self();
    std::vector<uint32_t> cpuIds = {0};
    EXPECT_EQ(BindCpuUtils::SetThreadAffinity(threadId, cpuIds), BQS_STATUS_INNER_ERROR);
}

TEST_F(BindCpuUtilsUTest, SetThreadAffinity_02)
{
    MOCKER(pthread_setaffinity_np)
            .stubs()
            .will(returnValue(0));
    pthread_t threadId = pthread_self();
    std::vector<uint32_t> cpuIds = {0};
    EXPECT_EQ(BindCpuUtils::SetThreadAffinity(threadId, cpuIds), BQS_STATUS_OK);
}

TEST_F(BindCpuUtilsUTest, SetThreadAffinity_03)
{
    MOCKER(pthread_getaffinity_np)
            .stubs()
            .will(returnValue(-1));
    pthread_t threadId = pthread_self();
    std::vector<uint32_t> cpuIds = {0};
    EXPECT_EQ(BindCpuUtils::SetThreadAffinity(threadId, cpuIds), BQS_STATUS_INNER_ERROR);
}

TEST_F(BindCpuUtilsUTest, AddToCgroup_success)
{
    uint32_t deviceId = 1;
    uint32_t vfId = 0;

    int64_t chipType = 65792;
    MOCKER(halGetDeviceInfo)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&chipType))
        .will(returnValue(0));

    MOCKER(system)
        .stubs()
        .will(returnValue(0));

    bool ret = BindCpuUtils::AddToCgroup(deviceId, vfId);
    EXPECT_EQ(ret, true);
}
}