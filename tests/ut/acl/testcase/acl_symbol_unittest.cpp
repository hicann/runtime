/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstddef>
#include <limits>

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "acl/acl_rt.h"
#include "acl/error_codes/rt_error_codes.h"
#include "acl_stub.h"

using namespace testing;

class UTEST_ACL_Symbol : public testing::Test {
protected:
    void SetUp() override { MockFunctionTest::aclStubInstance().ResetToDefaultMock(); }

    void TearDown() override { Mock::VerifyAndClear(&MockFunctionTest::aclStubInstance()); }
};

TEST_F(UTEST_ACL_Symbol, aclrtGetSymbolSize_NullSymbolRejectsBeforeLookup)
{
    size_t size = 64U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSymbolLookup(_, _, _)).Times(0);

    EXPECT_EQ(aclrtGetSymbolSize(nullptr, &size), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(size, 64U);
}

TEST_F(UTEST_ACL_Symbol, aclrtGetSymbolSize_NullSizeRejectsBeforeLookup)
{
    int symbol = 0;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSymbolLookup(_, _, _)).Times(0);

    EXPECT_EQ(aclrtGetSymbolSize(&symbol, nullptr), ACL_ERROR_INVALID_PARAM);
}

class UTEST_ACL_SymbolSize : public UTEST_ACL_Symbol, public WithParamInterface<size_t> {};

TEST_P(UTEST_ACL_SymbolSize, aclrtGetSymbolSize_LookupSuccessPreservesFullSize)
{
    int symbol = 0;
    int deviceSymbol = 0;
    const size_t expectedSize = GetParam();
    size_t size = 64U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSymbolLookup(&symbol, Pointee(IsNull()), &size))
        .Times(1)
        .WillOnce(DoAll(
            SetArgPointee<1>(static_cast<void*>(&deviceSymbol)), SetArgPointee<2>(expectedSize),
            Return(RT_ERROR_NONE)));

    EXPECT_EQ(aclrtGetSymbolSize(&symbol, &size), ACL_SUCCESS);
    EXPECT_EQ(size, expectedSize);
}

INSTANTIATE_TEST_SUITE_P(
    SizeBoundaries, UTEST_ACL_SymbolSize,
    Values(
        size_t{0}, size_t{1}, size_t{1} << (std::numeric_limits<size_t>::digits - 1),
        std::numeric_limits<size_t>::max()));

class UTEST_ACL_SymbolLookupError : public UTEST_ACL_Symbol, public WithParamInterface<aclError> {};

TEST_P(UTEST_ACL_SymbolLookupError, aclrtGetSymbolSize_LookupFailurePreservesErrorAndUnwrittenSize)
{
    int symbol = 0;
    size_t size = 64U;
    const aclError expectedError = GetParam();
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSymbolLookup(&symbol, Pointee(IsNull()), &size))
        .Times(1)
        .WillOnce(Return(expectedError));

    EXPECT_EQ(aclrtGetSymbolSize(&symbol, &size), expectedError);
    EXPECT_EQ(size, 64U);
}

INSTANTIATE_TEST_SUITE_P(
    LookupErrors, UTEST_ACL_SymbolLookupError,
    Values(ACL_ERROR_RT_INVALID_SYMBOL, ACL_ERROR_RT_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_INTERNAL_ERROR));
