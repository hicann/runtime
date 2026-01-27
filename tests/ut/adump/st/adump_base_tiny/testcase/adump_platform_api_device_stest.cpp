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

using namespace Adx;

class DupAdumpPlatformApiStest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DupAdumpPlatformApiStest, Test_TensorPluginRegister)
{
    PlatformData data{0, 0, 0};
    BufferSize buffer {0, 0, 0, 0, 0};
    EXPECT_EQ(AdumpPlatformApi::GetUBSizeAndCoreNum("", PlatformType::CHIP_MDC_TYPE, data), true);
    EXPECT_EQ(AdumpPlatformApi::GetAicoreSizeInfo("", buffer), true);
}