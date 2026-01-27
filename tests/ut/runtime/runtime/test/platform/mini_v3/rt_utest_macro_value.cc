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
#include "runtime.hpp"

using namespace cce::runtime;

class MacroInitValueTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        GlobalMockObject::verify();
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

TEST_F(MacroInitValueTest, MacroInitValue)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_NE(rtInstance, nullptr);
    RtMacroValue &value = Runtime::macroValue_;
    uint32_t rtsqDepth = 2048U;
    EXPECT_EQ(value.maxPersistTaskNum, 65535U);
    EXPECT_EQ(value.maxTaskNumPerStream, 2010U);
    EXPECT_EQ(value.maxSinkTaskNum, 1000000U);
    EXPECT_EQ(value.maxSupportTaskNum, 2000000U);
    EXPECT_EQ(value.pctraceFileLength, (4U * 1024U) + 6U);
    EXPECT_EQ(value.pctraceFileHead, 32U);
    EXPECT_EQ(value.maxAllocStreamNum, 480U);
    EXPECT_EQ(value.stubEventCount, 65536U);
    EXPECT_EQ(value.maxReportTimeoutCnt, 360);
    EXPECT_EQ(value.maxTaskNumPerHugeStream, 0U);
    EXPECT_EQ(value.maxAllocHugeStreamNum, 0U);
    EXPECT_EQ(value.maxModelNum, 2048U);
    EXPECT_EQ(value.rtsqDepth, rtsqDepth);
    EXPECT_EQ(value.baseAicpuStreamId, 1024U);
}