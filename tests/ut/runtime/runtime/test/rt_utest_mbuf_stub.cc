/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "api_impl_creator.hpp"
#include "rt_error_codes.h"
#include "runtime/rt.h"

using namespace cce::runtime;

TEST(ApiMbufStubTest, MbufImplLifecycleNotSupport)
{
    EXPECT_FALSE(IsImplMbufSupported());
    ApiMbuf* apiImplMbuf = CreateImplMbufAndGet();
    EXPECT_EQ(apiImplMbuf, nullptr);

    DestroyImplMbuf(apiImplMbuf);

    EXPECT_EQ(apiImplMbuf, nullptr);
}

TEST(ApiMbufStubTest, MbufApisNotSupport)
{
    EXPECT_EQ(rtMbufInit(nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufBuild(nullptr, 0U, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufAlloc(nullptr, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufAllocEx(nullptr, 0U, 0U, 0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufUnBuild(nullptr, nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtBuffGet(nullptr, nullptr, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtBuffPut(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufFree(nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufSetDataLen(nullptr, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufGetDataLen(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufGetBuffAddr(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufGetBuffSize(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufGetPrivInfo(nullptr, nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufCopyBufRef(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufChainAppend(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufChainGetMbufNum(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtMbufChainGetMbuf(nullptr, 0U, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
