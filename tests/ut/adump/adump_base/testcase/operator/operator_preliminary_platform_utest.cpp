/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "operator_preliminary.h"
#include "dump_setting.h"
#include "adump_platform_manager.h"

using namespace Adx;

class OperatorPreliminaryPlatformUtest : public testing::Test {
protected:
    virtual void SetUp() { Adx::ResetAllPlatformManagers(); }
    virtual void TearDown()
    {
        Adx::ResetAllPlatformManagers();
        GlobalMockObject::verify();
    }
};

TEST_F(OperatorPreliminaryPlatformUtest, Test_CalcStackSize)
{
    DumpSetting dumpSetting = DumpSetting();
    OperatorPreliminary opIniter = OperatorPreliminary(dumpSetting, 0);
    EXPECT_EQ(opIniter.CalcStackSize(), 0);
}

TEST_F(OperatorPreliminaryPlatformUtest, Test_CalcStackSizeDCType)
{
    DumpSetting dumpSetting = DumpSetting();
    uint32_t dcType = static_cast<uint32_t>(PlatformType::CHIP_DC_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(dcType)).will(returnValue(true));
    DumpConfig dumpConfig;
    dumpConfig.dumpStatus = "on";
    dumpConfig.dumpPath = "/path/to/dump";
    dumpConfig.dumpMode = "all";
    dumpSetting.Init(DumpType::OPERATOR, dumpConfig);
    OperatorPreliminary opIniter = OperatorPreliminary(dumpSetting, 0);
    EXPECT_EQ(opIniter.CalcStackSize(), 2 * 32 * 1024);
}

TEST_F(OperatorPreliminaryPlatformUtest, Test_CalcStackSizeCloudV2)
{
    DumpSetting dumpSetting = DumpSetting();
    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));
    DumpConfig dumpConfig;
    dumpConfig.dumpStatus = "on";
    dumpConfig.dumpPath = "/path/to/dump";
    dumpConfig.dumpMode = "all";
    dumpSetting.Init(DumpType::OPERATOR, dumpConfig);
    OperatorPreliminary opIniter = OperatorPreliminary(dumpSetting, 0);
    EXPECT_EQ(opIniter.CalcStackSize(), 75 * 32 * 1024);
}

TEST_F(OperatorPreliminaryPlatformUtest, Test_CalcStackSizeCloudV4)
{
    DumpSetting dumpSetting = DumpSetting();
    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));
    DumpConfig dumpConfig;
    dumpConfig.dumpStatus = "on";
    dumpConfig.dumpPath = "/path/to/dump";
    dumpConfig.dumpMode = "all";
    dumpSetting.Init(DumpType::OPERATOR, dumpConfig);
    OperatorPreliminary opIniter = OperatorPreliminary(dumpSetting, 0);
    EXPECT_EQ(opIniter.CalcStackSize(), 108 * 32 * 1024);
}

TEST_F(OperatorPreliminaryPlatformUtest, Test_CalcStackSizeCloudV3)
{
    DumpSetting dumpSetting = DumpSetting();
    uint32_t v3Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V3);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v3Type)).will(returnValue(true));
    DumpConfig dumpConfig;
    dumpConfig.dumpStatus = "on";
    dumpConfig.dumpPath = "/path/to/dump";
    dumpConfig.dumpMode = "all";
    dumpSetting.Init(DumpType::OPERATOR, dumpConfig);
    OperatorPreliminary opIniter = OperatorPreliminary(dumpSetting, 0);
    EXPECT_EQ(opIniter.CalcStackSize(), 0);
}