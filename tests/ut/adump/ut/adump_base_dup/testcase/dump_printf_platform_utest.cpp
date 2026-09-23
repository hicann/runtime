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
#include "dump_printf_platform.h"

class DupDumpPrintfPlatformUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(DupDumpPrintfPlatformUtest, Test_DumpPrintfPlatform)
{
    EXPECT_EQ(AdxGetCoreTypeIDOffset(), 50U);
    EXPECT_EQ(AdxGetBlockNum(), 75U);
    EXPECT_EQ(AdxEnableSimtDump(0), false);
    EXPECT_EQ(GetStreamSynchronizeTimeout(), 60000U);
}

TEST_F(DupDumpPrintfPlatformUtest, Test_AdxGetCoreTypeIDOffsetMultipleCalls)
{
    for (int i = 0; i < 10; i++) {
        EXPECT_EQ(AdxGetCoreTypeIDOffset(), 50U);
    }
}

TEST_F(DupDumpPrintfPlatformUtest, Test_AdxGetBlockNumMultipleCalls)
{
    for (int i = 0; i < 10; i++) {
        EXPECT_EQ(AdxGetBlockNum(), 75U);
    }
}

TEST_F(DupDumpPrintfPlatformUtest, Test_AdxEnableSimtDumpWithDifferentSizes)
{
    std::vector<size_t> sizes = {0, 1024, 1024 * 1024, 1024 * 1024 * 10, 1024 * 1024 * 100, 1024 * 1024 * 200};
    for (size_t size : sizes) {
        EXPECT_EQ(AdxEnableSimtDump(size), false);
    }
}

TEST_F(DupDumpPrintfPlatformUtest, Test_GetStreamSynchronizeTimeoutMultipleCalls)
{
    for (int i = 0; i < 5; i++) {
        EXPECT_EQ(GetStreamSynchronizeTimeout(), 60000U);
    }
}

TEST_F(DupDumpPrintfPlatformUtest, Test_AllFunctionsConsistency)
{
    uint32_t offset1 = AdxGetCoreTypeIDOffset();
    uint32_t block1 = AdxGetBlockNum();
    bool simt1 = AdxEnableSimtDump(1024 * 1024);
    uint32_t timeout1 = GetStreamSynchronizeTimeout();

    uint32_t offset2 = AdxGetCoreTypeIDOffset();
    uint32_t block2 = AdxGetBlockNum();
    bool simt2 = AdxEnableSimtDump(1024 * 1024);
    uint32_t timeout2 = GetStreamSynchronizeTimeout();

    EXPECT_EQ(offset1, offset2);
    EXPECT_EQ(block1, block2);
    EXPECT_EQ(simt1, simt2);
    EXPECT_EQ(timeout1, timeout2);
}

TEST_F(DupDumpPrintfPlatformUtest, Test_AdxEnableSimtDumpBoundaryValues)
{
    EXPECT_EQ(AdxEnableSimtDump(0), false);
    EXPECT_EQ(AdxEnableSimtDump(SIZE_MAX), false);
    EXPECT_EQ(AdxEnableSimtDump(1), false);
}

TEST_F(DupDumpPrintfPlatformUtest, Test_AdxGetCoreTypeIDOffsetReturnValue)
{
    uint32_t offset = AdxGetCoreTypeIDOffset();
    EXPECT_TRUE(offset <= 100);
}

TEST_F(DupDumpPrintfPlatformUtest, Test_AdxGetBlockNumReturnValue)
{
    uint32_t blockNum = AdxGetBlockNum();
    EXPECT_TRUE(blockNum <= 200);
}

TEST_F(DupDumpPrintfPlatformUtest, Test_GetStreamSynchronizeTimeoutReturnValue)
{
    uint32_t timeout = GetStreamSynchronizeTimeout();
    EXPECT_TRUE(timeout > 0);
    EXPECT_TRUE(timeout <= 60000U * 30U);
}

TEST_F(DupDumpPrintfPlatformUtest, Test_FunctionsIndependentCalls)
{
    EXPECT_EQ(AdxGetCoreTypeIDOffset(), 50U);
    EXPECT_EQ(AdxGetBlockNum(), 75U);
    EXPECT_EQ(AdxEnableSimtDump(1024), false);
    EXPECT_EQ(GetStreamSynchronizeTimeout(), 60000U);

    EXPECT_EQ(AdxGetBlockNum(), 75U);
    EXPECT_EQ(AdxGetCoreTypeIDOffset(), 50U);
    EXPECT_EQ(GetStreamSynchronizeTimeout(), 60000U);
    EXPECT_EQ(AdxEnableSimtDump(1024 * 1024), false);
}