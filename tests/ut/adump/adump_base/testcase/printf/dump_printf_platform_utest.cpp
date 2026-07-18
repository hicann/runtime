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
#include "mockcpp/mockcpp.hpp"
#include "adump_dsmi.h"
#include "adump_platform_manager.h"
#include "dump_printf_platform.h"

using namespace Adx;

class DumpPrintfPlatformUtest : public testing::Test {
protected:
    void SetUp() override
    {
        ResetAllPlatformManagers();
    }
    void TearDown() override
    {
        ResetAllPlatformManagers();
        GlobalMockObject::verify();
    }
};

TEST_F(DumpPrintfPlatformUtest, Test_DumpPrintfPlatform_DefaultPlatform)
{
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().will(returnValue(false));
    EXPECT_EQ(AdxGetCoreTypeIDOffset(), 50U);
    EXPECT_EQ(AdxGetBlockNum(), 75U);
    EXPECT_EQ(AdxEnableSimtDump(0), false);
    EXPECT_EQ(GetStreamSynchronizeTimeout(), 60000);
}

TEST_F(DumpPrintfPlatformUtest, Test_Ascend950Platform)
{
    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));
    EXPECT_EQ(AdxGetCoreTypeIDOffset(), 72U);
    EXPECT_EQ(AdxGetBlockNum(), 108U);
    EXPECT_EQ(AdxEnableSimtDump(1024U * 1024U * 200U), true);
    EXPECT_EQ(GetStreamSynchronizeTimeout(), 60000 * 30);
}

TEST_F(DumpPrintfPlatformUtest, Test_EnableSimtDumpThreshold)
{
    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));
    size_t threshold = AdxGetBlockNum() * (1024U * 1024U);
    EXPECT_EQ(AdxEnableSimtDump(threshold - 1), false);
    EXPECT_EQ(AdxEnableSimtDump(threshold + 1), true);
}

TEST_F(DumpPrintfPlatformUtest, Test_EnableSimtDump_Non950Platform)
{
    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));
    EXPECT_EQ(AdxEnableSimtDump(1024U * 1024U * 200U), false);
    EXPECT_EQ(AdxEnableSimtDump(0), false);
}

TEST_F(DumpPrintfPlatformUtest, Test_GetStreamSynchronizeTimeout_Non950)
{
    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));
    EXPECT_EQ(GetStreamSynchronizeTimeout(), 60000);
}

TEST_F(DumpPrintfPlatformUtest, Test_EnableSimtDump_ExactThreshold)
{
    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));
    size_t threshold = AdxGetBlockNum() * (1024U * 1024U);
    EXPECT_EQ(AdxEnableSimtDump(threshold), false);
}

TEST_F(DumpPrintfPlatformUtest, Test_EnableSimtDump_LargeWorkspace)
{
    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));
    EXPECT_EQ(AdxEnableSimtDump(1024U * 1024U * 500U), true);
}

TEST_F(DumpPrintfPlatformUtest, Test_GetCoreTypeIDOffset_MultipleCalls)
{
    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));
    EXPECT_EQ(AdxGetCoreTypeIDOffset(), 72U);
    EXPECT_EQ(AdxGetCoreTypeIDOffset(), 72U);
}

TEST_F(DumpPrintfPlatformUtest, Test_GetBlockNum_MultipleCalls)
{
    uint32_t v4Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4Type)).will(returnValue(true));
    EXPECT_EQ(AdxGetBlockNum(), 108U);
    EXPECT_EQ(AdxGetBlockNum(), 108U);
}

TEST_F(DumpPrintfPlatformUtest, Test_PlatformManagerRetryAfterFailure)
{
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().will(returnValue(false));
    EXPECT_EQ(DataDumpManager::Get(), nullptr);

    GlobalMockObject::verify();
    ResetAllPlatformManagers();

    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));
    EXPECT_NE(DataDumpManager::Get(), nullptr);
}
