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
#include "mstx_inject.h"
#include "mstx_domain_mgr.h"

namespace {
class MsprofMstxStest : public testing::Test {
protected:
    void SetUp() override {}
    void TearDown() override {}
};
} // namespace

TEST_F(MsprofMstxStest, MstxMarkAndRange)
{
    void* message = nullptr;
    MsprofMstxApi::MstxMarkAFunc(nullptr, message);
    EXPECT_EQ(0, MsprofMstxApi::MstxRangeStartAFunc(nullptr, message));
    MsprofMstxApi::MstxRangeEndFunc(1);
}

TEST_F(MsprofMstxStest, MstxDomainLifecycle)
{
    auto domain = MsprofMstxApi::MstxDomainCreateAFunc("test_domain");
    MsprofMstxApi::MstxDomainMarkAFunc(domain, nullptr, nullptr);
    EXPECT_EQ(0, MsprofMstxApi::MstxDomainRangeStartAFunc(domain, nullptr, nullptr));
    MsprofMstxApi::MstxDomainRangeEndFunc(domain, 1);
    MsprofMstxApi::MstxDomainDestroyFunc(domain);
}
