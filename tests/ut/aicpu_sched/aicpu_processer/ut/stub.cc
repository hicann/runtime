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
#include "aicpu_context.h"
#include <string>

namespace aicpu {
status_t SetOpname(const std::string &opname)
{
    return AICPU_ERROR_NONE;
}

status_t SetThreadLocalCtx(const std::string &key, const std::string &value)
{
    return AICPU_ERROR_NONE;
}

status_t GetThreadLocalCtx(const std::string &key, const std::string &value)
{
    return AICPU_ERROR_NONE;
}

uint32_t GetAicpuThreadIndex()
{
    return 0U;
}

status_t GetOpname(uint32_t threadIndex, std::string &opname)
{
    opname = "test";
    return AICPU_ERROR_NONE;
}

status_t GetAicpuRunMode(uint32_t &runMode)
{
    runMode = aicpu::PROCESS_PCIE_MODE;
    return AICPU_ERROR_NONE;
}

uint32_t GetUniqueVfId()
{
    return 0U;
}

void SetUniqueVfId(uint32_t uniqueVfId)
{
}

void SetCustAicpuSdFlag(bool isCustAicpuSdFlag)
{
}

bool IsCustAicpuSd()
{
    return false;
}
class AicpuContextStubUTest : public testing::Test {
protected:
static void SetUpTestCase()
{
    std::cout << "AicpuContextStubUTest SetUpTestCase" << std::endl;
}

static void TearDownTestCase()
{
    std::cout << "AicpuContextStubUTest TearDownTestCase" << std::endl;
}

virtual void SetUp()
{
    std::cout << "AicpuContextStubUTest SetUp" << std::endl;
}

virtual void TearDown()
{
    std::cout << "AicpuContextStubUTest TearDown" << std::endl;
}
};

TEST_F(AicpuContextStubUTest, AicpuGetContextTest)
{
    aicpuContext_t ctx;
    status_t status = aicpuGetContext(&ctx);
    EXPECT_EQ(status, AICPU_ERROR_NONE);
}
}