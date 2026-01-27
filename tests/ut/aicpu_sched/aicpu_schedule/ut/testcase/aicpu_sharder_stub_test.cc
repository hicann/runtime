/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#define private public
#include "aicpu_sharder.h"
#undef private
#include "gtest/gtest.h"
#include <cstdint>
#include <stdio.h>
#include <stdlib.h>
#include <queue>
#include <exception>
#include <string>

using namespace aicpu;
using namespace std;

class AiCPUSharderStubUt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(AiCPUSharderStubUt, AiCPUSharderStubUtSuccess)
{
    const RandomKernelScheduler randomKernelScheduler = [](const aicpu::Closure &task) {return 0U;};
    const SplitKernelScheduler splitKernelScheduler = [](const uint32_t parallelId, const int64_t shardNum,
                                                         const std::queue<Closure> &queue) {return 0U;};
    const SplitKernelGetProcesser splitKernelGetProcesser = []() {return true;};
    SharderNonBlock::GetInstance().Register(1, randomKernelScheduler, splitKernelScheduler, splitKernelGetProcesser);
    EXPECT_EQ(SharderNonBlock::GetInstance().cpuCoreNum_, 0);
}