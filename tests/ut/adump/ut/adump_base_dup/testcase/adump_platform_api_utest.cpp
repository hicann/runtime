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
#include "adump_platform_api.h"
#include "adump_platform_manager.h"
#include "dump_common.h"
#include "dump_core.h"

using namespace Adx;

namespace {
void MockPlatformInfoSuccess()
{
    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo)
        .stubs().will(returnValue(0U));
    MOCKER_CPP(&fe::PlatformInfoManager::GetPlatformInfo)
        .stubs().will(returnValue(0U));
}
}

class DupAdumpPlatformApiUtest : public testing::Test {
protected:
    virtual void SetUp() { ResetAllPlatformManagers(); }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        ResetAllPlatformManagers();
    }
};

TEST_F(DupAdumpPlatformApiUtest, Test_GetAicoreSizeInfo)
{
    const std::string socVersion("123");
    BufferSize bufferSize{};
    EXPECT_EQ(AdumpPlatformApi::GetAicoreSizeInfo(socVersion, bufferSize), true);
}

// UB 来源按入参 platform 查询，不依赖 DSMI 当前平台缓存。
TEST_F(DupAdumpPlatformApiUtest, Test_GetUBSizeAndCoreNumUsesInputPlatform)
{
    MockPlatformInfoSuccess();

    const std::string socVersion("Ascend950");
    PlatformData platformData;
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, PlatformType::CHIP_CLOUD_V4, platformData), true);
}

TEST_F(DupAdumpPlatformApiUtest, Test_GetUBSizeAndCoreNumV4Success)
{
    MockPlatformInfoSuccess();

    const std::string socVersion("Ascend950");
    PlatformData platformData;
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, PlatformType::CHIP_CLOUD_V4, platformData), true);
}

TEST_F(DupAdumpPlatformApiUtest, Test_GetUBSizeAndCoreNumV2Success)
{
    MockPlatformInfoSuccess();

    const std::string socVersion("Ascend910B");
    PlatformData platformData;
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, PlatformType::CHIP_CLOUD_V2, platformData), true);
}

TEST_F(DupAdumpPlatformApiUtest, Test_GetUBSizeAndCoreNumDCSuccess)
{
    MockPlatformInfoSuccess();

    const std::string socVersion("Ascend310P");
    PlatformData platformData;
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, PlatformType::CHIP_DC_TYPE, platformData), true);
}

TEST_F(DupAdumpPlatformApiUtest, Test_GetUBSizeAndCoreNumInitFail)
{
    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo)
        .stubs().will(returnValue(1U));

    const std::string socVersion("Ascend950");
    PlatformData platformData;
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, PlatformType::CHIP_CLOUD_V4, platformData), false);
}

TEST_F(DupAdumpPlatformApiUtest, Test_GetAicoreSizeInfoFail)
{
    const std::string socVersion("test");
    BufferSize bufferSize{};

    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo)
        .stubs().will(returnValue(1U));

    EXPECT_EQ(AdumpPlatformApi::GetAicoreSizeInfo(socVersion, bufferSize), false);
}

TEST_F(DupAdumpPlatformApiUtest, Test_GetAicoreSizeInfoGetPlatformInfoFail)
{
    const std::string socVersion("test");
    BufferSize bufferSize{};

    MOCKER_CPP(&fe::PlatformInfoManager::InitializePlatformInfo)
        .stubs().will(returnValue(0U));
    MOCKER_CPP(&fe::PlatformInfoManager::GetPlatformInfo)
        .stubs().will(returnValue(1U));

    EXPECT_EQ(AdumpPlatformApi::GetAicoreSizeInfo(socVersion, bufferSize), false);
}

// 未注册平台类型时 DataDumpManager 返回 nullptr，UB 来源无法判定，返回 false。
TEST_F(DupAdumpPlatformApiUtest, Test_GetUBSizeAndCoreNumUnregisteredPlatform)
{
    MockPlatformInfoSuccess();

    const std::string socVersion("test");
    PlatformData platformData;
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, static_cast<PlatformType>(255), platformData), false);
}
