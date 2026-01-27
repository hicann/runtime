/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_context.h"
#include "gtest/gtest.h"
#include <cstdint>
#include <stdio.h>
#include <stdlib.h>
#include <queue>
#include <exception>
#include <string>
#include <functional>
#include "aicpusd_common.h"

using namespace aicpu;
using namespace std;

class AiCPUContextStubUt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(AiCPUContextStubUt, AiCPUContextStubUtSuccess)
{
    aicpuContext_t aicpuContext;
    status_t ret = aicpuSetContext(&aicpuContext);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = aicpuGetContext(&aicpuContext);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    aicpuProfContext_t aicpuProfContext;
    ret = aicpuSetProfContext(aicpuProfContext);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    aicpuGetProfContext();
    ret = InitTaskMonitorContext(0);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = SetAicpuThreadIndex(0);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    uint32_t rets = GetAicpuThreadIndex();
    EXPECT_EQ(rets, AICPU_ERROR_NONE);
    ret = SetOpname("test");
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    std::string opName;
    ret = GetOpname(0, opName);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = SetTaskAndStreamId(0, 0);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    string key = "test";
    string value = "test";
    ret = SetThreadLocalCtx(key, value);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = GetThreadLocalCtx(key, value);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = SetAicpuRunMode(0);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    uint32_t runMode;
    ret = GetAicpuRunMode(runMode);
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    uint32_t result = GetUniqueVfId();
    EXPECT_EQ(result, 0);
    SetUniqueVfId(0);
    SetCustAicpuSdFlag(false);
    bool rets2 = IsCustAicpuSd();
    EXPECT_EQ(rets2, false);    
}