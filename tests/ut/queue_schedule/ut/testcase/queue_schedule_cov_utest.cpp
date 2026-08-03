/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"

#include "bqs_util.h"
#include "driver/ascend_hal.h"

namespace {

TEST(QueueScheduleCoverageUtest, BqsUtilDeviceFunctions)
{
    EXPECT_EQ(bqs::GetRunContext(), bqs::RunContext::DEVICE);
    EXPECT_GT(bqs::GetNowTime(), 0UL);
}

TEST(QueueScheduleCoverageUtest, DriverQueryProcessHostPid)
{
    unsigned int chipId = 1U;
    unsigned int vfId = 2U;
    unsigned int hostPid = 3U;
    unsigned int cpType = 4U;

    EXPECT_EQ(drvQueryProcessHostPid(0, &chipId, &vfId, &hostPid, &cpType), DRV_ERROR_NONE);
    EXPECT_EQ(drvQueryProcessHostPid(0, nullptr, nullptr, nullptr, nullptr), DRV_ERROR_NONE);
}

} // namespace
