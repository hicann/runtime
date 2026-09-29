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
#include "mockcpp/mockcpp.hpp"

#include "driver/ascend_hal.h"
#include "npu_driver.hpp"
#include "thread_local_container.hpp"

using namespace cce::runtime;

namespace {
uint32_t g_lastSqeDepth = 0U;

drvError_t HalSqCqAllocateCapture(
    const uint32_t deviceId, struct halSqCqInputInfo* const input, struct halSqCqOutputInfo* const output)
{
    UNUSED(deviceId);
    g_lastSqeDepth = input->sqeDepth;
    output->sqId = 0U;
    output->cqId = 0U;
    return DRV_ERROR_NONE;
}
} // namespace

class Arch5162NpuDriverTest : public testing::Test {
protected:
    void SetUp() override
    {
        originalGlobalChipType_ = GlobalContainer::GetRtChipType();
        GlobalContainer::SetRtChipType(CHIP_5162A);
    }

    void TearDown() override
    {
        GlobalContainer::SetRtChipType(originalGlobalChipType_);
        GlobalMockObject::verify();
    }

    rtChipType_t originalGlobalChipType_ = CHIP_END;
};

TEST_F(Arch5162NpuDriverTest, NormalSqCqAllocateUsesStreamFlags)
{
    NpuDriver driver;

    uint32_t sqId = 0U;
    uint32_t cqId = 0U;
    uint32_t info[5] = {};
    uint32_t msg[1] = {};
    MOCKER(halSqCqAllocate).stubs().will(invoke(HalSqCqAllocateCapture));

    EXPECT_EQ(driver.NormalSqCqAllocate(0U, 0U, 0U, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg)), RT_ERROR_NONE);
    EXPECT_EQ(g_lastSqeDepth, 2048U);

    EXPECT_EQ(
        driver.NormalSqCqAllocate(
            0U, 0U, 0U, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg), PRE_ALLOC_SQ_CQ_RETRY_MAX_COUNT, 0U),
        RT_ERROR_NONE);
    EXPECT_EQ(g_lastSqeDepth, 128U);

    EXPECT_EQ(
        driver.NormalSqCqAllocate(
            0U, 0U, 0U, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg), PRE_ALLOC_SQ_CQ_RETRY_MAX_COUNT,
            RT_STREAM_HUGE),
        RT_ERROR_NONE);
    EXPECT_EQ(g_lastSqeDepth, 2048U);
}

TEST_F(Arch5162NpuDriverTest, NormalSqCqAllocateRejectsInvalidConfiguredDepth)
{
    NpuDriver driver;
    uint32_t sqId = 0U;
    uint32_t cqId = 0U;
    uint32_t info[5] = {};
    uint32_t msg[1] = {};

    driver.properties_.rtsqDepth = 0U;
    EXPECT_EQ(
        driver.NormalSqCqAllocate(
            0U, 0U, 0U, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg), PRE_ALLOC_SQ_CQ_RETRY_MAX_COUNT, 0U),
        RT_ERROR_INVALID_VALUE);

    driver.properties_.rtsqDepth = 128U;
    driver.properties_.maxTaskNumPerHugeStream = 2049U;
    EXPECT_EQ(
        driver.NormalSqCqAllocate(
            0U, 0U, 0U, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg), PRE_ALLOC_SQ_CQ_RETRY_MAX_COUNT,
            RT_STREAM_HUGE),
        RT_ERROR_INVALID_VALUE);
}

TEST_F(Arch5162NpuDriverTest, NormalSqCqAllocateIgnoresStreamFlagsWhenConfigurationDoesNotOptIn)
{
    NpuDriver driver;
    uint32_t sqId = 0U;
    uint32_t cqId = 0U;
    uint32_t info[5] = {};
    uint32_t msg[1] = {};
    MOCKER(halSqCqAllocate).stubs().will(invoke(HalSqCqAllocateCapture));

    driver.properties_.isStars = false;
    EXPECT_EQ(
        driver.NormalSqCqAllocate(
            0U, 0U, 0U, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg), PRE_ALLOC_SQ_CQ_RETRY_MAX_COUNT, 0U),
        RT_ERROR_NONE);
    EXPECT_EQ(g_lastSqeDepth, 2048U);

    driver.properties_.isStars = true;
    driver.properties_.maxTaskNumPerHugeStream = 0U;
    EXPECT_EQ(
        driver.NormalSqCqAllocate(
            0U, 0U, 0U, &sqId, &cqId, info, sizeof(info), msg, sizeof(msg), PRE_ALLOC_SQ_CQ_RETRY_MAX_COUNT,
            RT_STREAM_HUGE),
        RT_ERROR_NONE);
    EXPECT_EQ(g_lastSqeDepth, 2048U);
}
