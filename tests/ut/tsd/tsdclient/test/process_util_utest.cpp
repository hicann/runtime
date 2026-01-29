/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"
#include <unistd.h>
#include <fstream>
#define private public
#define protected public
#include "inc/process_util_server.h"
#include "inc/internal_api.h"
#include "driver/ascend_hal_define.h"
#include "inc/process_util_common.h"
#undef private
#undef protected
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "inc/tsd_feature_ctrl.h"

using namespace tsd;
using namespace std;
class ProcessUtilTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        setenv("RUN_MODE", "1", "1");
        cout << "Before TsdEzcomTest()" << endl;
    }

    virtual void TearDown()
    {
        cout << "After TsdEzcomTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(ProcessUtilTest, RestoreThreadAffinity)
{
    pthread_t threadId = pthread_self();
    cpu_set_t cpusetSaved;
    CPU_ZERO(&cpusetSaved);
    MOCKER(pthread_setaffinity_np)
    .stubs()
    .will(returnValue(1));
    TSD_StatusT ret = ProcessUtilCommon::RestoreThreadAffinity(threadId, &cpusetSaved);
    EXPECT_EQ(ret, tsd::TSD_BIND_CPUCORE_FAILED);
}

TEST_F(ProcessUtilTest, SaveThreadAffinity)
{
    pthread_t threadId = pthread_self();
    cpu_set_t cpusetSaved;
    CPU_ZERO(&cpusetSaved);
    MOCKER(pthread_getaffinity_np)
    .stubs()
    .will(returnValue(1));
    TSD_StatusT ret = ProcessUtilCommon::SaveThreadAffinity(threadId, &cpusetSaved);
    EXPECT_EQ(ret, tsd::TSD_BIND_CPUCORE_FAILED);
}

void GetScheduleEnvFake1(const char_t * const envName, std::string &envValue)
{
    return;
}

TEST_F(ProcessUtilTest, GetCurHomePath_01)
{
    MOCKER(&tsd::GetScheduleEnv).stubs().will(invoke(GetScheduleEnvFake1));
    std::string curHomePath;
    ProcessUtilCommon::GetCurHomePath(curHomePath);
    EXPECT_EQ(curHomePath.empty(), true);
    GlobalMockObject::verify();
}

TEST_F(ProcessUtilTest, GetCurHomePath_02)
{
    MOCKER(&tsd::CheckValidatePath).stubs().will(returnValue(false));
    std::string curHomePath;
    ProcessUtilCommon::GetCurHomePath(curHomePath);
    EXPECT_EQ(curHomePath.empty(), true);
    GlobalMockObject::verify();
}

TEST_F(ProcessUtilTest, GetCurHomePath_03)
{
    MOCKER(&tsd::CheckRealPath).stubs().will(returnValue(false));
    std::string curHomePath;
    ProcessUtilCommon::GetCurHomePath(curHomePath);
    EXPECT_EQ(curHomePath.empty(), true);
    GlobalMockObject::verify();
}

int pthread_setaffinity_np_fake(pthread_t thread, size_t cpusetsize, const cpu_set_t *cpuset)
{
    std::cout<<"enter pthread_setaffinity_np_fake" <<std::endl;
    return 0;
}

int pthread_setaffinity_np_fake_fail(pthread_t thread, size_t cpusetsize, const cpu_set_t *cpuset)
{
    std::cout<<"enter pthread_setaffinity_np_fake_fail" <<std::endl;
    return 1;
}

int pthread_getaffinity_np_fake(pthread_t thread, size_t cpusetsize, cpu_set_t *cpuset)
{
    std::cout<<"enter pthread_getaffinity_np_fake" <<std::endl;
    return 1;
}

TEST_F(ProcessUtilTest, SetThreadAffinity_001)
{
    pthread_t threadId = pthread_self();
    std::vector<uint32_t> cpuIds;
    cpuIds.push_back(0);
    cpuIds.push_back(1);
    MOCKER(pthread_setaffinity_np).stubs().will(invoke(pthread_setaffinity_np_fake_fail));
    auto ret = ProcessUtilCommon::SetThreadAffinity(threadId, cpuIds);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}

TEST_F(ProcessUtilTest, SetThreadAffinity_002)
{
    pthread_t threadId = pthread_self();
    std::vector<uint32_t> cpuIds;
    cpuIds.push_back(0);
    MOCKER(pthread_setaffinity_np).stubs().will(invoke(pthread_setaffinity_np_fake));
    MOCKER(pthread_getaffinity_np).stubs().will(invoke(pthread_getaffinity_np_fake));
    auto ret = ProcessUtilCommon::SetThreadAffinity(threadId, cpuIds);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    GlobalMockObject::verify();
}

TEST_F(ProcessUtilTest, ReadCuIsInBlackEnvList_Yes)
{
    EXPECT_TRUE(ProcessUtilCommon::IsInBlackEnvList("LD_PRELOAD"));
}

TEST_F(ProcessUtilTest, ReadCuIsInBlackEnvList_No)
{
    EXPECT_FALSE(ProcessUtilCommon::IsInBlackEnvList("Unknown"));
}