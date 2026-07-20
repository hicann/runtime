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
#include <iostream>
#include "errno/error_code.h"
#include "platform/platform.h"
#include "david_v121_platform.h"

using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::error;
using namespace Dvvp::Collect::Platform;

class PLATFORM_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(PLATFORM_STEST, Init) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
}

TEST_F(PLATFORM_STEST, Uninit) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
}

TEST_F(PLATFORM_STEST, PlatformIsRpcSide) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(false, platform->PlatformIsRpcSide());
}

TEST_F(PLATFORM_STEST, GetPlatform) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(SysPlatformType::INVALID, platform->GetPlatform());
}

TEST_F(PLATFORM_STEST, DavidV121PlatformL2CacheMetrics) {
    GlobalMockObject::verify();
    DavidV121Platform platform;
    std::string aicEvent;

    EXPECT_EQ(PROFILING_SUCCESS, platform.GetAiPmuMetrics("L2Cache", aicEvent));
    EXPECT_EQ("0x424,0x425,0x426,0x42a,0x42b,0x42c", aicEvent);
    EXPECT_EQ("0x00,0x81,0x82,0x83,0x74,0x75", platform.GetL2CacheEvents());
}
