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
#include <string.h>
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "runtime/dev.h"
#include "runtime/rt.h"
#include "dump_printf_platform.h"

class DumpPrintfPlatformUtest : public testing::Test {
protected:
    virtual void SetUp() {
        setenv("ADX_LLT_SOC_VERSION", "Ascend910_9599", 1);
    }
    virtual void TearDown() {
        setenv("ADX_LLT_SOC_VERSION", "", 1);
        GlobalMockObject::verify();
    }
};

TEST_F(DumpPrintfPlatformUtest, Test_DumpPrintfPlatform)
{
    EXPECT_EQ(AdxGetCoreTypeIDOffset(), 50U);
    EXPECT_EQ(AdxGetBlockNum(), 75U);
    EXPECT_EQ(AdxEnableSimtDump(0), false);
    EXPECT_EQ(GetStreamSynchronizeTimeout(), 60000U);
}