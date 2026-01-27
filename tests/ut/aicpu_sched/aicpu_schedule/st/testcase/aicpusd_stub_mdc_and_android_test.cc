/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <string>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "profiling_adp.h"
#include "aicpu_prof.h"
#undef private

using namespace aicpu;

class AICPUScheduleStubMdcAndAndroidTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUScheduleStubMdcAndAndroidTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUScheduleStubMdcAndAndroidTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUScheduleStubMdcAndAndroidTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "AICPUScheduleStubMdcAndAndroidTEST TearDown" << std::endl;
    }
};

TEST_F(AICPUScheduleStubMdcAndAndroidTEST, IsProfOpen) {
    EXPECT_EQ(IsProfOpen(), false);
}

TEST_F(AICPUScheduleStubMdcAndAndroidTEST, GetSystemTick) {
    EXPECT_EQ(GetSystemTick(), 0);
}

TEST_F(AICPUScheduleStubMdcAndAndroidTEST, UpdateModelMode) {
    UpdateModelMode(false);
    bool ret = IsModelProfOpen();
    EXPECT_EQ(ret, false);
}

TEST_F(AICPUScheduleStubMdcAndAndroidTEST, GetSystemTickFreq) {
    EXPECT_EQ(GetSystemTickFreq(), 1);
}

TEST_F(AICPUScheduleStubMdcAndAndroidTEST, SetProfHandle) {
    EXPECT_EQ(SetProfHandle(nullptr), 0);
}

TEST_F(AICPUScheduleStubMdcAndAndroidTEST, NowMicros) {
    EXPECT_EQ(NowMicros(), 1);
}

TEST_F(AICPUScheduleStubMdcAndAndroidTEST, InitProfilingDataInfo) {
    InitProfiling(0, 0, 0);
    InitProfilingDataInfo(0, 0, 0);
    LoadProfilingLib();
    char tag[3] = {'a', 'b', 'c'};
    ProfMessage profMsg(tag);
    ReleaseProfiling();
    std::string test = "test";
    SendToProfiling(test, test);
    SetProfilingFlagForKFC(0);
    UpdateMode(true);
    EXPECT_EQ(profMsg.tag_[0], 'a');
}

TEST_F(AICPUScheduleStubMdcAndAndroidTEST, SetMsprofReporterCallback) {
    MsprofReporterCallback reportCallback;
    EXPECT_EQ(SetMsprofReporterCallback(reportCallback), 0);
}



TEST_F(AICPUScheduleStubMdcAndAndroidTEST, IsSupportedProfData) {
    EXPECT_EQ(IsSupportedProfData(), false);
}
