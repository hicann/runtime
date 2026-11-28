/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/rt_utest_api_context_cases.hpp"

using namespace testing;
using namespace cce::runtime;

RT_UTEST_API_CONTEXT_FIXTURE(ApiContextTest, "ApiContextTest test start start. ", "ApiContextTest test start end. ")
RT_UTEST_API_CONTEXT_CASES(ApiContextTest)

void ClearLastDlogRecordLine();
bool DlogRecordContains(const std::string& keyword);

TEST_F(ApiContextTest, GetLastErrorLogsHexErrorAndClearsThreadError)
{
    const rtError_t originalError = InnerThreadLocalContainer::PeekGlobalErr();
    InnerThreadLocalContainer::SetGlobalErr(-1);
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    ClearLastDlogRecordLine();

    EXPECT_EQ(rtGetLastError(RT_THREAD_LEVEL), -1);
    EXPECT_TRUE(DlogRecordContains("GetLastErr:"));
    EXPECT_TRUE(DlogRecordContains("level=THREAD_LEVEL(0) err=0xffffffff."));
    EXPECT_EQ(rtPeekAtLastError(RT_THREAD_LEVEL), ACL_RT_SUCCESS);

    ClearLastDlogRecordLine();
    EXPECT_EQ(rtGetLastError(RT_THREAD_LEVEL), ACL_RT_SUCCESS);
    EXPECT_TRUE(DlogRecordContains("GetLastErr:"));
    EXPECT_TRUE(DlogRecordContains("level=THREAD_LEVEL(0) err=0."));

    InnerThreadLocalContainer::SetGlobalErr(originalError);
    ClearLastDlogRecordLine();
}

TEST_F(ApiContextTest, PeekAtLastErrorLogsHexErrorAndPreservesThreadError)
{
    const rtError_t originalError = InnerThreadLocalContainer::PeekGlobalErr();
    InnerThreadLocalContainer::SetGlobalErr(-1);
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    ClearLastDlogRecordLine();

    EXPECT_EQ(rtPeekAtLastError(RT_THREAD_LEVEL), -1);
    EXPECT_TRUE(DlogRecordContains("PeekLastErr:"));
    EXPECT_TRUE(DlogRecordContains("level=THREAD_LEVEL(0) err=0xffffffff."));
    EXPECT_EQ(rtPeekAtLastError(RT_THREAD_LEVEL), -1);
    EXPECT_EQ(rtGetLastError(RT_THREAD_LEVEL), -1);
    EXPECT_EQ(rtPeekAtLastError(RT_THREAD_LEVEL), ACL_RT_SUCCESS);

    InnerThreadLocalContainer::SetGlobalErr(originalError);
    ClearLastDlogRecordLine();
}
