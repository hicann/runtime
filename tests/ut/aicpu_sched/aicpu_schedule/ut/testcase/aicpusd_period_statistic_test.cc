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
#include "aicpusd_proc_mem_statistic.h"
#include "aicpusd_period_statistic.h"
#include "aicpusd_drv_manager.h"
#undef private
using namespace AicpuSchedule;
using namespace aicpu;
class AicpuSdPeriodStatisticTest : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AicpuSdPeriodStatisticTest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AicpuSdPeriodStatisticTest TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AicpuSdPeriodStatisticTest SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AicpuSdPeriodStatisticTest TearDown" << std::endl;
    }
};

TEST_F(AicpuSdPeriodStatisticTest, StartPeriodFailed) {
    MOCKER_CPP(&AicpuSdPeriodStatistic::SetThreadAffinity).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INNER_ERROR));
    MOCKER_CPP(&AicpuSdProcMemStatistic::InitProcMemStatistic).stubs().will(returnValue(false));
    MOCKER(&pthread_setaffinity_np).stubs().will(returnValue(1));
    AicpuSdPeriodStatistic::GetInstance().DoStatistic();
    EXPECT_EQ(AicpuSdPeriodStatistic::GetInstance().SetThreadAffinity(), AICPU_SCHEDULE_ERROR_INNER_ERROR);
    AicpuSdPeriodStatistic::GetInstance().initFlag_ = false;
    AicpuSdPeriodStatistic::GetInstance().InitStatistic(0U, 123U, 0U);
    EXPECT_EQ(AicpuSdPeriodStatistic::GetInstance().initFlag_, false);
    GlobalMockObject::verify();
}

TEST_F(AicpuSdPeriodStatisticTest, InitStatisticTwice) {
    AicpuSdPeriodStatistic::GetInstance().initFlag_ = true;
    AicpuSdPeriodStatistic::GetInstance().InitStatistic(0U, 123U, 0U);
    EXPECT_EQ(AicpuSdPeriodStatistic::GetInstance().initFlag_, true);
    GlobalMockObject::verify();
}

TEST_F(AicpuSdPeriodStatisticTest, SetThreadAffinity_Failed1) {
    MOCKER(&pthread_setaffinity_np).stubs().will(returnValue(1));
    EXPECT_EQ(AicpuSdPeriodStatistic::GetInstance().SetThreadAffinity(), AICPU_SCHEDULE_ERROR_INNER_ERROR);
    GlobalMockObject::verify();
}