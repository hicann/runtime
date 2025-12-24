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
#include "global_state_manager.hpp"

using namespace testing;
using namespace cce::runtime;

class SnapshotTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(SnapshotTest, StateToString)
{
    EXPECT_STREQ(GlobalStateManager::StateToString(RT_PROCESS_STATE_RUNNING), "RUNNING");
    EXPECT_STREQ(GlobalStateManager::StateToString(RT_PROCESS_STATE_LOCKED), "LOCKED");
    EXPECT_STREQ(GlobalStateManager::StateToString(RT_PROCESS_STATE_BACKED_UP), "BACKED_UP");
    EXPECT_STREQ(GlobalStateManager::StateToString(RT_PROCESS_STATE_MAX), "UNKNOWN");
}