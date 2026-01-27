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
#include "adump_dsmi.h"
#include "dump_common.h"
#include "dump_core.h"

using namespace Adx;

class DupAdumpPlatformApiUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DupAdumpPlatformApiUtest, Test_GetAicoreSizeInfo)
{
    const std::string socVersion("123");
    BufferSize bufferSize{};
    EXPECT_EQ(AdumpPlatformApi::GetAicoreSizeInfo(socVersion, bufferSize), true);
}

TEST_F(DupAdumpPlatformApiUtest, Test_GetUBSizeAndCoreNum)
{
    const std::string socVersion("123");
    PlatformType platform = PlatformType::CHIP_CLOUD_V4;
    PlatformData platformData;
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, platform, platformData), false);
    platform = PlatformType::CHIP_CLOUD_V2;
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, platform, platformData), true);
    platform = PlatformType::CHIP_DC_TYPE;
    PlatformData platformDataDC;
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum(socVersion, platform, platformDataDC), true);
}