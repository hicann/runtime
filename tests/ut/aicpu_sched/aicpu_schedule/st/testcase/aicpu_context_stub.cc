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

class AiCPUContextStubSt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(AiCPUContextStubSt, AiCPUContextStubStSuccess)
{
    aicpuContext_t aicpuContext;
    aicpuSetContext(&aicpuContext);
    aicpuGetContext(&aicpuContext);
    aicpuProfContext_t aicpuProfContext;
    aicpuSetProfContext(aicpuProfContext);
    aicpuGetProfContext();
    InitTaskMonitorContext(0);
    SetAicpuThreadIndex(0);
    GetAicpuThreadIndex();
    SetOpname("test");
    std::string opName;
    GetOpname(0, opName);
    SetTaskAndStreamId(0, 0);
    string key = "test";
    string value = "test";
    SetThreadLocalCtx(key, value);
    GetThreadLocalCtx(key, value);
    SetAicpuRunMode(0);
    uint32_t runMode;
    GetAicpuRunMode(runMode);
    GetUniqueVfId();
    SetUniqueVfId(0);
    SetCustAicpuSdFlag(false);
    EXPECT_EQ(IsCustAicpuSd(), false);
}