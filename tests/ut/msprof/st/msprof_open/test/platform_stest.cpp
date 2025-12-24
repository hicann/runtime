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

using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::error;

class PLATFORM_OPEN_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(PLATFORM_OPEN_STEST, Init) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
}

TEST_F(PLATFORM_OPEN_STEST, Uninit) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
}

TEST_F(PLATFORM_OPEN_STEST, PlatformIsRpcSide) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(false, platform->PlatformIsRpcSide());
}

TEST_F(PLATFORM_OPEN_STEST, GetPlatform) {
    GlobalMockObject::verify();
    auto platform = std::make_shared<Platform>();

    EXPECT_EQ(SysPlatformType::INVALID, platform->GetPlatform());
}