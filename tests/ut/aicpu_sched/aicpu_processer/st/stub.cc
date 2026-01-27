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
#include "ascend_inpackage_hal.h"

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

int halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max)
{
    *vf_max = 8U;
    return 0U;
}

class AicpuContextStubSTest : public testing::Test {
protected:
static void SetUpTestCase()
{
    std::cout << "AicpuContextStubSTest SetUpTestCase" << std::endl;
}

static void TearDownTestCase()
{
    std::cout << "AicpuContextStubSTest TearDownTestCase" << std::endl;
}

virtual void SetUp()
{
    std::cout << "AicpuContextStubSTest SetUp" << std::endl;
}

virtual void TearDown()
{
    std::cout << "AicpuContextStubSTest TearDown" << std::endl;
}
};

TEST_F(AicpuContextStubSTest, AicpuGetContextTest)
{
    aicpuContext_t ctx;
    status_t status = aicpuGetContext(&ctx);
    EXPECT_EQ(status, AICPU_ERROR_NONE);
}
}