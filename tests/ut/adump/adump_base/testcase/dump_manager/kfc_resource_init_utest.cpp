/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>

#include "mockcpp/mockcpp.hpp"
#include "adump_platform_manager.h"
#include "adx_dump_record.h"
#include "common/thread.h"
#include "dump_manager.h"
#include "file_utils.h"
#include "operator_preliminary.h"

using namespace Adx;

class KfcResourceInitUtest : public testing::Test {
protected:
    void SetUp() override
    {
        ResetAllPlatformManagers();
        DumpManager::Instance().SetKFCInitStatus(false);
        DumpManager::operatorMap_.clear();
        MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
        MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));
    }

    void TearDown() override
    {
        (void)DumpManager::Instance().UnSetDumpConfig();
        DumpManager::operatorMap_.clear();
        DumpManager::Instance().SetKFCInitStatus(false);
        DumpManager::Instance().Reset();
        ResetAllPlatformManagers();
        (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);
        DumpManager::Instance().opTimeoutModified_ = false;
        DumpManager::Instance().originOpExecuteTimeOut_ = 0U;
        GlobalMockObject::verify();
    }
};

TEST_F(KfcResourceInitUtest, Test_KFCResourceInit_SuccessAndRepeatedCall)
{
    MOCKER_CPP(&AdumpDsmi::DrvGetDeviceList).stubs().will(returnValue(std::vector<uint32_t>{0U}));
    MOCKER(&OperatorPreliminary::OperatorInit).stubs().will(returnValue(ADUMP_SUCCESS));

    DumpManager::Instance().KFCResourceInit();
    EXPECT_TRUE(DumpManager::Instance().GetKFCInitStatus());
    ASSERT_EQ(DumpManager::operatorMap_.size(), 1U);

    DumpManager::Instance().KFCResourceInit();
    EXPECT_EQ(DumpManager::operatorMap_.size(), 1U);
}

TEST_F(KfcResourceInitUtest, Test_SetDumpConfig_KFCResourceInitFailed)
{
    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));
    MOCKER(&FileUtils::IsFileExist).stubs().will(returnValue(true));
    MOCKER(&OperatorPreliminary::OperatorInit).expects(atLeast(1)).will(returnValue(ADUMP_FAILED));

    DumpConfig config;
    config.dumpPath = "/tmp/dump_test";
    config.dumpStatus = "on";
    config.dumpData = "stats";
    config.dumpMode = "output";

    EXPECT_EQ(DumpManager::Instance().SetDumpConfig(DumpType::OPERATOR, config), ADUMP_FAILED);
    EXPECT_FALSE(DumpManager::Instance().GetKFCInitStatus());
    EXPECT_TRUE(DumpManager::operatorMap_.empty());
}
