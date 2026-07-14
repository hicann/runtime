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

extern "C" {
#include "dlog_unified_timer_api.h"
}

class DLOG_UNIFIED_TIMER_API_UTEST : public testing::Test {
protected:
    void TearDown() override
    {
        (void)DlogCloseTimerDll();
    }
};

TEST_F(DLOG_UNIFIED_TIMER_API_UTEST, LoadTimerDllReturnsFailureWhenLibraryIsUnavailable)
{
    EXPECT_EQ(LOG_FAILURE, DlogLoadTimerDll());
    EXPECT_EQ(LOG_SUCCESS, DlogCloseTimerDll());
}

TEST_F(DLOG_UNIFIED_TIMER_API_UTEST, TimerOperationsReturnFailureWhenFunctionsAreUnavailable)
{
    EXPECT_EQ(1U, DlogAddUnifiedTimer("slog_test_timer", nullptr, 1, ONESHOT_TIMER));
    EXPECT_EQ(1U, DlogRemoveUnifiedTimer("slog_test_timer"));
}
