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
#include "dump_manager.h"
#include "adump_dsmi.h"
#include "dump_common.h"

using namespace Adx;

class DupDumpManagerUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
};

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformFail)
{
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().will(returnValue(false));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformNotSupport)
{
    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatform)
{
    uint32_t v2type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), true);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformCloudV4)
{
    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), true);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformDCType)
{
    uint32_t dcType = static_cast<uint32_t>(PlatformType::CHIP_DC_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(dcType)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformBothV2V4)
{
    uint32_t v2type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), true);

    DumpManager::Instance().Reset();

    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), true);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatform310P)
{
    uint32_t type310P = static_cast<uint32_t>(PlatformType::CHIP_DC_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type310P)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformUnknown)
{
    uint32_t unknownType = 255;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(unknownType)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformAllTypes)
{
    uint32_t v2type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), true);

    DumpManager::Instance().Reset();

    uint32_t v4type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V4);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), true);

    DumpManager::Instance().Reset();

    uint32_t dcType = static_cast<uint32_t>(PlatformType::CHIP_DC_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(dcType)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);

    DumpManager::Instance().Reset();

    uint32_t miniType = static_cast<uint32_t>(PlatformType::CHIP_MINI_V3_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(miniType)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);

    DumpManager::Instance().Reset();

    uint32_t unknownType = 255;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(unknownType)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerUtest, Test_InstanceSingleton)
{
    DumpManager& instance1 = DumpManager::Instance();
    DumpManager& instance2 = DumpManager::Instance();
    EXPECT_EQ(&instance1, &instance2);
}

TEST_F(DupDumpManagerUtest, Test_ResetAfterCheck)
{
    uint32_t v2type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), true);

    DumpManager::Instance().Reset();

    uint32_t dcType = static_cast<uint32_t>(PlatformType::CHIP_DC_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(dcType)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformMiniV3)
{
    uint32_t miniType = static_cast<uint32_t>(PlatformType::CHIP_MINI_V3_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(miniType)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformDefault)
{
    uint32_t defaultType = static_cast<uint32_t>(PlatformType::CHIP_MINI_TYPE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(defaultType)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}

TEST_F(DupDumpManagerUtest, Test_CheckCoredumpSupportedPlatformMdcLite)
{
    uint32_t mdcLiteType = static_cast<uint32_t>(PlatformType::CHIP_MDC_LITE);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(mdcLiteType)).will(returnValue(true));
    EXPECT_EQ(DumpManager::Instance().CheckCoredumpSupportedPlatform(), false);
}