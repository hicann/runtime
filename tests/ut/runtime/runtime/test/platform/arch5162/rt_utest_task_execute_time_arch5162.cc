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
#define protected public
#define private public
#include "base.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#undef protected
#undef private
#include "task_execute_time.h"
#include "dev_info_manage.h"

using namespace cce::runtime;

class Arch5162TaskExecuteTimeTest : public testing::Test {
protected:
    void SetUp() override
    {
        origGlobalChipType_ = GlobalContainer::GetRtChipType();
        GlobalContainer::SetRtChipType(CHIP_5162A);

        rtInstance_ = (Runtime*)Runtime::Instance();
        ASSERT_NE(rtInstance_, nullptr);

        origChipType_ = rtInstance_->GetChipType();
        rtInstance_->SetChipType(CHIP_5162A);

        origCurChipProperties_ = rtInstance_->curChipProperties_;
        DevProperties props;
        if (GET_DEV_PROPERTIES(CHIP_5162A, props) == RT_ERROR_NONE) {
            rtInstance_->curChipProperties_ = props;
        }
        rtInstance_->curChipProperties_.KernelCreditScale = 1000.0;

        origIsCfgOpExcTaskTimeout_ = rtInstance_->timeoutConfig_.isCfgOpExcTaskTimeout;
        origOpExcTaskTimeout_ = rtInstance_->timeoutConfig_.opExcTaskTimeout;
        origIsOpTimeoutMs_ = rtInstance_->timeoutConfig_.isOpTimeoutMs;
        rtInstance_->timeoutConfig_.isCfgOpExcTaskTimeout = false;
        rtInstance_->timeoutConfig_.opExcTaskTimeout = 0UL;
        rtInstance_->timeoutConfig_.isOpTimeoutMs = false;
    }

    void TearDown() override
    {
        if (rtInstance_ != nullptr) {
            rtInstance_->SetChipType(origChipType_);
            rtInstance_->curChipProperties_ = origCurChipProperties_;
            rtInstance_->timeoutConfig_.isCfgOpExcTaskTimeout = origIsCfgOpExcTaskTimeout_;
            rtInstance_->timeoutConfig_.opExcTaskTimeout = origOpExcTaskTimeout_;
            rtInstance_->timeoutConfig_.isOpTimeoutMs = origIsOpTimeoutMs_;
        }
        GlobalContainer::SetRtChipType(origGlobalChipType_);
        GlobalMockObject::verify();
    }

    Runtime* rtInstance_ = nullptr;
    rtChipType_t origGlobalChipType_ = CHIP_BEGIN;
    rtChipType_t origChipType_ = CHIP_BEGIN;
    DevProperties origCurChipProperties_;
    bool origIsCfgOpExcTaskTimeout_ = false;
    uint64_t origOpExcTaskTimeout_ = 0UL;
    bool origIsOpTimeoutMs_ = false;
};

TEST_F(Arch5162TaskExecuteTimeTest, TransKernelCreditCreditByChip_ZeroCredit)
{
    EXPECT_EQ(TransKernelCreditCreditByChip(0U), 0U);
}

TEST_F(Arch5162TaskExecuteTimeTest, TransKernelCreditCreditByChip_NonZeroCredit)
{
    EXPECT_EQ(TransKernelCreditCreditByChip(1U), 0U);
    EXPECT_EQ(TransKernelCreditCreditByChip(100U), 99U);
    EXPECT_EQ(TransKernelCreditCreditByChip(256U), 255U);
}

TEST_F(Arch5162TaskExecuteTimeTest, TransExeTimeoutCfgToKernelCredit_ZeroTimeout)
{
    uint16_t kernelCredit = 0U;
    TransExeTimeoutCfgToKernelCredit(0ULL, kernelCredit);
    EXPECT_EQ(kernelCredit, 256U);
}

TEST_F(Arch5162TaskExecuteTimeTest, TransExeTimeoutCfgToKernelCredit_NormalTimeout)
{
    uint16_t kernelCredit = 0U;
    TransExeTimeoutCfgToKernelCredit(1000ULL, kernelCredit);
    EXPECT_EQ(kernelCredit, 1U);

    kernelCredit = 0U;
    TransExeTimeoutCfgToKernelCredit(200000ULL, kernelCredit);
    EXPECT_EQ(kernelCredit, 200U);
}

TEST_F(Arch5162TaskExecuteTimeTest, TransExeTimeoutCfgToKernelCredit_OverflowTimeout)
{
    uint16_t kernelCredit = 0U;
    TransExeTimeoutCfgToKernelCredit(257000ULL, kernelCredit);
    EXPECT_EQ(kernelCredit, 256U);
}

TEST_F(Arch5162TaskExecuteTimeTest, TransExeTimeoutCfgToKernelCredit_ZeroScale)
{
    rtInstance_->curChipProperties_.KernelCreditScale = 0.0;
    uint16_t kernelCredit = 0U;
    TransExeTimeoutCfgToKernelCredit(1000ULL, kernelCredit);
    EXPECT_EQ(kernelCredit, 256U);
}

TEST_F(Arch5162TaskExecuteTimeTest, GetAicoreKernelCredit_NeverTimeout)
{
    EXPECT_EQ(GetAicoreKernelCredit(std::numeric_limits<uint64_t>::max()), 255U);
}

TEST_F(Arch5162TaskExecuteTimeTest, GetAicoreKernelCredit_CustomTimeout)
{
    EXPECT_EQ(GetAicoreKernelCredit(1000ULL), 0U);
}

TEST_F(Arch5162TaskExecuteTimeTest, GetAicoreKernelCredit_CfgTimeout)
{
    rtInstance_->timeoutConfig_.isCfgOpExcTaskTimeout = true;
    rtInstance_->timeoutConfig_.opExcTaskTimeout = 200000ULL;
    EXPECT_EQ(GetAicoreKernelCredit(0ULL), 199U);
}

TEST_F(Arch5162TaskExecuteTimeTest, GetAicoreKernelCredit_Default) { EXPECT_EQ(GetAicoreKernelCredit(0ULL), 0U); }
