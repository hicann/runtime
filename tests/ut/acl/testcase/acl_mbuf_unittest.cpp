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
#include <cstdint>
#include <limits>

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "acl/acl_rt.h"
#include "acl/error_codes/rt_error_codes.h"
#include "acl_stub.h"

using namespace testing;

class UTEST_ACL_Mbuf : public testing::Test {
protected:
    void SetUp() override { MockFunctionTest::aclStubInstance().ResetToDefaultMock(); }

    void TearDown() override { Mock::VerifyAndClear(&MockFunctionTest::aclStubInstance()); }

    // Runtime dependencies treat these addresses as opaque handles and never dereference them.
    uint8_t headStorage_ = 0U;
    uint8_t bufStorage_ = 0U;
    aclrtMbuf headBuf_ = &headStorage_;
    aclrtMbuf buf_ = &bufStorage_;
};

TEST_F(UTEST_ACL_Mbuf, aclrtAppendBufChain_ForwardsBothHandles)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainAppend(headBuf_, buf_)).WillOnce(Return(RT_ERROR_NONE));

    EXPECT_EQ(aclrtAppendBufChain(headBuf_, buf_), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Mbuf, aclrtCopyBufRef_ReturnsRuntimeReference)
{
    aclrtMbuf copiedBuf = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufCopyBufRef(buf_, &copiedBuf))
        .WillOnce(DoAll(SetArgPointee<1>(headBuf_), Return(RT_ERROR_NONE)));

    EXPECT_EQ(aclrtCopyBufRef(buf_, &copiedBuf), ACL_SUCCESS);
    EXPECT_EQ(copiedBuf, headBuf_);
}

class UTEST_ACL_MbufChain : public UTEST_ACL_Mbuf, public WithParamInterface<uint32_t> {};

TEST_P(UTEST_ACL_MbufChain, aclrtGetBufChainNum_ReturnsRuntimeCount)
{
    uint32_t num = 0U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainGetMbufNum(headBuf_, &num))
        .WillOnce(DoAll(SetArgPointee<1>(GetParam()), Return(RT_ERROR_NONE)));

    EXPECT_EQ(aclrtGetBufChainNum(headBuf_, &num), ACL_SUCCESS);
    EXPECT_EQ(num, GetParam());
}

TEST_P(UTEST_ACL_MbufChain, aclrtGetBufFromChain_ForwardsIndexAndReturnsNode)
{
    const uint32_t index = GetParam() - 1U;
    aclrtMbuf node = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainGetMbuf(headBuf_, index, &node))
        .WillOnce(DoAll(SetArgPointee<2>(buf_), Return(RT_ERROR_NONE)));

    EXPECT_EQ(aclrtGetBufFromChain(headBuf_, index, &node), ACL_SUCCESS);
    EXPECT_EQ(node, buf_);
}

INSTANTIATE_TEST_SUITE_P(SingleAndMultipleNodes, UTEST_ACL_MbufChain, Values(1U, 3U));

TEST_F(UTEST_ACL_Mbuf, aclrtGetBufFromChain_PropagatesOutOfRangeIndexError)
{
    const uint32_t index = std::numeric_limits<uint32_t>::max();
    aclrtMbuf node = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainGetMbuf(headBuf_, index, &node))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    EXPECT_EQ(aclrtGetBufFromChain(headBuf_, index, &node), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(node, nullptr);
}

class UTEST_ACL_MbufLength : public UTEST_ACL_Mbuf, public WithParamInterface<size_t> {};

TEST_P(UTEST_ACL_MbufLength, aclrtGetBufData_ReturnsRuntimeAddressAndSize)
{
    uint8_t data = 0U;
    void* dataPtr = nullptr;
    size_t size = std::numeric_limits<size_t>::max();
    InSequence sequence;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffAddr(buf_, &dataPtr))
        .WillOnce(DoAll(SetArgPointee<1>(static_cast<void*>(&data)), Return(RT_ERROR_NONE)));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffSize(buf_, NotNull()))
        .WillOnce(DoAll(SetArgPointee<1>(static_cast<uint64_t>(GetParam())), Return(RT_ERROR_NONE)));

    EXPECT_EQ(aclrtGetBufData(buf_, &dataPtr, &size), ACL_SUCCESS);
    EXPECT_EQ(dataPtr, &data);
    EXPECT_EQ(size, GetParam());
}

TEST_P(UTEST_ACL_MbufLength, aclrtGetBufDataLen_ReturnsRuntimeLength)
{
    size_t len = std::numeric_limits<size_t>::max();
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetDataLen(buf_, NotNull()))
        .WillOnce(DoAll(SetArgPointee<1>(static_cast<uint64_t>(GetParam())), Return(RT_ERROR_NONE)));

    EXPECT_EQ(aclrtGetBufDataLen(buf_, &len), ACL_SUCCESS);
    EXPECT_EQ(len, GetParam());
}

TEST_P(UTEST_ACL_MbufLength, aclrtSetBufDataLen_ForwardsLength)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufSetDataLen(buf_, static_cast<uint64_t>(GetParam())))
        .WillOnce(Return(RT_ERROR_NONE));

    EXPECT_EQ(aclrtSetBufDataLen(buf_, GetParam()), ACL_SUCCESS);
}

INSTANTIATE_TEST_SUITE_P(
    ZeroSmallAndWideLengths, UTEST_ACL_MbufLength,
    Values(size_t{0U}, size_t{1U}, static_cast<size_t>(std::numeric_limits<uint32_t>::max()) + 17U));

class UTEST_ACL_MbufNullInput : public UTEST_ACL_Mbuf, public WithParamInterface<bool> {};

TEST_P(UTEST_ACL_MbufNullInput, aclrtAppendBufChain_RejectsNullWithoutCallingRuntime)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainAppend(_, _)).Times(0);

    EXPECT_EQ(
        aclrtAppendBufChain(GetParam() ? nullptr : headBuf_, GetParam() ? buf_ : nullptr), ACL_ERROR_INVALID_PARAM);
}

TEST_P(UTEST_ACL_MbufNullInput, aclrtCopyBufRef_RejectsNullWithoutCallingRuntime)
{
    aclrtMbuf copiedBuf = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufCopyBufRef(_, _)).Times(0);

    EXPECT_EQ(aclrtCopyBufRef(GetParam() ? nullptr : buf_, GetParam() ? &copiedBuf : nullptr), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(copiedBuf, nullptr);
}

TEST_P(UTEST_ACL_MbufNullInput, aclrtGetBufChainNum_RejectsNullWithoutCallingRuntime)
{
    uint32_t num = 7U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainGetMbufNum(_, _)).Times(0);

    EXPECT_EQ(
        aclrtGetBufChainNum(GetParam() ? nullptr : headBuf_, GetParam() ? &num : nullptr), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(num, 7U);
}

TEST_P(UTEST_ACL_MbufNullInput, aclrtGetBufFromChain_RejectsNullWithoutCallingRuntime)
{
    aclrtMbuf node = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainGetMbuf(_, _, _)).Times(0);

    EXPECT_EQ(
        aclrtGetBufFromChain(GetParam() ? nullptr : headBuf_, 0U, GetParam() ? &node : nullptr),
        ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(node, nullptr);
}

TEST_P(UTEST_ACL_MbufNullInput, aclrtGetBufData_RejectsNullBufferOrDataOutputWithoutCallingRuntime)
{
    void* dataPtr = nullptr;
    size_t size = 7U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffAddr(_, _)).Times(0);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffSize(_, _)).Times(0);

    EXPECT_EQ(
        aclrtGetBufData(GetParam() ? nullptr : buf_, GetParam() ? &dataPtr : nullptr, &size), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(dataPtr, nullptr);
    EXPECT_EQ(size, 7U);
}

TEST_P(UTEST_ACL_MbufNullInput, aclrtGetBufDataLen_RejectsNullWithoutCallingRuntime)
{
    size_t len = 7U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetDataLen(_, _)).Times(0);

    EXPECT_EQ(aclrtGetBufDataLen(GetParam() ? nullptr : buf_, GetParam() ? &len : nullptr), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(len, 7U);
}

INSTANTIATE_TEST_SUITE_P(NullHandleOrSecondArgument, UTEST_ACL_MbufNullInput, Bool());

TEST_F(UTEST_ACL_Mbuf, aclrtGetBufData_RejectsNullSizeWithoutCallingRuntime)
{
    void* dataPtr = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffAddr(_, _)).Times(0);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffSize(_, _)).Times(0);

    EXPECT_EQ(aclrtGetBufData(buf_, &dataPtr, nullptr), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(dataPtr, nullptr);
}

TEST_F(UTEST_ACL_Mbuf, aclrtSetBufDataLen_RejectsNullWithoutCallingRuntime)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufSetDataLen(_, _)).Times(0);

    EXPECT_EQ(aclrtSetBufDataLen(nullptr, 1U), ACL_ERROR_INVALID_PARAM);
}

class UTEST_ACL_MbufRuntimeError : public UTEST_ACL_Mbuf, public WithParamInterface<rtError_t> {};

TEST_P(UTEST_ACL_MbufRuntimeError, aclrtAppendBufChain_PropagatesRuntimeError)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainAppend(headBuf_, buf_)).WillOnce(Return(GetParam()));

    EXPECT_EQ(aclrtAppendBufChain(headBuf_, buf_), GetParam());
}

TEST_P(UTEST_ACL_MbufRuntimeError, aclrtCopyBufRef_PropagatesRuntimeError)
{
    aclrtMbuf copiedBuf = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufCopyBufRef(buf_, &copiedBuf)).WillOnce(Return(GetParam()));

    EXPECT_EQ(aclrtCopyBufRef(buf_, &copiedBuf), GetParam());
    EXPECT_EQ(copiedBuf, nullptr);
}

TEST_P(UTEST_ACL_MbufRuntimeError, aclrtGetBufChainNum_PropagatesRuntimeError)
{
    uint32_t num = 7U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainGetMbufNum(headBuf_, &num))
        .WillOnce(Return(GetParam()));

    EXPECT_EQ(aclrtGetBufChainNum(headBuf_, &num), GetParam());
    EXPECT_EQ(num, 7U);
}

TEST_P(UTEST_ACL_MbufRuntimeError, aclrtGetBufFromChain_PropagatesRuntimeError)
{
    aclrtMbuf node = nullptr;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufChainGetMbuf(headBuf_, 2U, &node))
        .WillOnce(Return(GetParam()));

    EXPECT_EQ(aclrtGetBufFromChain(headBuf_, 2U, &node), GetParam());
    EXPECT_EQ(node, nullptr);
}

TEST_P(UTEST_ACL_MbufRuntimeError, aclrtGetBufData_StopsBeforeSizeQueryWhenAddressQueryFails)
{
    void* dataPtr = nullptr;
    size_t size = 7U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffAddr(buf_, &dataPtr)).WillOnce(Return(GetParam()));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffSize(_, _)).Times(0);

    EXPECT_EQ(aclrtGetBufData(buf_, &dataPtr, &size), GetParam());
    EXPECT_EQ(size, 7U);
}

TEST_P(UTEST_ACL_MbufRuntimeError, aclrtGetBufData_DoesNotPublishSizeWhenSizeQueryFails)
{
    uint8_t data = 0U;
    void* dataPtr = nullptr;
    size_t size = 7U;
    InSequence sequence;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffAddr(buf_, &dataPtr))
        .WillOnce(DoAll(SetArgPointee<1>(static_cast<void*>(&data)), Return(RT_ERROR_NONE)));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetBuffSize(buf_, NotNull()))
        .WillOnce(DoAll(SetArgPointee<1>(uint64_t{512U}), Return(GetParam())));

    EXPECT_EQ(aclrtGetBufData(buf_, &dataPtr, &size), GetParam());
    EXPECT_EQ(dataPtr, &data);
    EXPECT_EQ(size, 7U);
}

TEST_P(UTEST_ACL_MbufRuntimeError, aclrtGetBufDataLen_DoesNotPublishLengthWhenRuntimeFails)
{
    size_t len = 7U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufGetDataLen(buf_, NotNull()))
        .WillOnce(DoAll(SetArgPointee<1>(uint64_t{512U}), Return(GetParam())));

    EXPECT_EQ(aclrtGetBufDataLen(buf_, &len), GetParam());
    EXPECT_EQ(len, 7U);
}

TEST_P(UTEST_ACL_MbufRuntimeError, aclrtSetBufDataLen_PropagatesRuntimeError)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMbufSetDataLen(buf_, uint64_t{1U})).WillOnce(Return(GetParam()));

    EXPECT_EQ(aclrtSetBufDataLen(buf_, 1U), GetParam());
}

INSTANTIATE_TEST_SUITE_P(
    InvalidParameterAndUnsupported, UTEST_ACL_MbufRuntimeError,
    Values(
        static_cast<rtError_t>(ACL_ERROR_RT_PARAM_INVALID), static_cast<rtError_t>(ACL_ERROR_RT_FEATURE_NOT_SUPPORT)));
