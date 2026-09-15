/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <array>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <memory>

#include <gtest/gtest.h>

#include "acl/acl_base.h"
#include "common/resource_statistics.h"

namespace {
struct DataBufferDeleter {
    void operator()(aclDataBuffer* buffer) const { EXPECT_EQ(aclDestroyDataBuffer(buffer), ACL_SUCCESS); }
};

using DataBufferPtr = std::unique_ptr<aclDataBuffer, DataBufferDeleter>;
} // namespace

class UTEST_ACL_DataBuffer : public testing::Test {
protected:
    void SetUp() override
    {
        // Statistics has no public snapshot/reset API; this target already enables -fno-access-control.
        auto& statistics =
            acl::ResourceStatistics::GetInstance().counter_[acl::ACL_STATISTICS_CREATE_DESTROY_DATA_BUFFER];
        for (size_t i = 0U; i < savedStatistics_.size(); ++i) {
            savedStatistics_[i] = statistics.appplyReleaseValue[i].load();
        }
    }

    void TearDown() override
    {
        auto& statistics =
            acl::ResourceStatistics::GetInstance().counter_[acl::ACL_STATISTICS_CREATE_DESTROY_DATA_BUFFER];
        for (size_t i = 0U; i < savedStatistics_.size(); ++i) {
            statistics.appplyReleaseValue[i].store(savedStatistics_[i]);
        }
    }

private:
    std::array<uint64_t, acl::APPLY_RELEASE_SIZE> savedStatistics_{};
};

class UTEST_ACL_DataBufferLength : public UTEST_ACL_DataBuffer, public testing::WithParamInterface<size_t> {};

TEST_P(UTEST_ACL_DataBufferLength, aclCreateDataBuffer_PreservesAddressAndFullLength)
{
    uint8_t data = 7U;
    // The descriptor only stores metadata; even a wide length must not allocate or access the payload.
    DataBufferPtr buffer(aclCreateDataBuffer(&data, GetParam()));

    ASSERT_NE(buffer, nullptr);
    EXPECT_EQ(aclGetDataBufferAddr(buffer.get()), &data);
    EXPECT_EQ(aclGetDataBufferSizeV2(buffer.get()), GetParam());
}

TEST_P(UTEST_ACL_DataBufferLength, aclUpdateDataBuffer_ReplacesAddressAndFullLength)
{
    uint8_t oldData = 7U;
    uint8_t newData = 9U;
    DataBufferPtr buffer(aclCreateDataBuffer(&oldData, 3U));
    ASSERT_NE(buffer, nullptr);

    EXPECT_EQ(aclUpdateDataBuffer(buffer.get(), &newData, GetParam()), ACL_SUCCESS);
    EXPECT_EQ(aclGetDataBufferAddr(buffer.get()), &newData);
    EXPECT_EQ(aclGetDataBufferSizeV2(buffer.get()), GetParam());
}

INSTANTIATE_TEST_SUITE_P(
    ZeroSmallAndWideLengths, UTEST_ACL_DataBufferLength,
    testing::Values(
        size_t{0U}, size_t{1U}, static_cast<size_t>(std::numeric_limits<uint32_t>::max()) + 17U,
        std::numeric_limits<size_t>::max()));

TEST_F(UTEST_ACL_DataBuffer, aclCreateDataBuffer_AcceptsNullData)
{
    DataBufferPtr buffer(aclCreateDataBuffer(nullptr, 0U));

    ASSERT_NE(buffer, nullptr);
    EXPECT_EQ(aclGetDataBufferAddr(buffer.get()), nullptr);
    EXPECT_EQ(aclGetDataBufferSizeV2(buffer.get()), 0U);
}

TEST_F(UTEST_ACL_DataBuffer, aclUpdateDataBuffer_AcceptsNullData)
{
    uint8_t data = 7U;
    DataBufferPtr buffer(aclCreateDataBuffer(&data, sizeof(data)));
    ASSERT_NE(buffer, nullptr);

    EXPECT_EQ(aclUpdateDataBuffer(buffer.get(), nullptr, 0U), ACL_SUCCESS);
    EXPECT_EQ(aclGetDataBufferAddr(buffer.get()), nullptr);
    EXPECT_EQ(aclGetDataBufferSizeV2(buffer.get()), 0U);
}

TEST_F(UTEST_ACL_DataBuffer, aclUpdateDataBuffer_RejectsNullBuffer)
{
    uint8_t data = 7U;

    EXPECT_EQ(aclUpdateDataBuffer(nullptr, &data, sizeof(data)), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(data, 7U);
}

TEST_F(UTEST_ACL_DataBuffer, aclDestroyDataBuffer_RejectsNullBuffer)
{
    EXPECT_EQ(aclDestroyDataBuffer(nullptr), ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_DataBuffer, aclGetDataBufferAddr_ReturnsNullForNullBuffer)
{
    EXPECT_EQ(aclGetDataBufferAddr(nullptr), nullptr);
}

TEST_F(UTEST_ACL_DataBuffer, aclGetDataBufferSizeV2_ReturnsZeroForNullBuffer)
{
    EXPECT_EQ(aclGetDataBufferSizeV2(nullptr), 0U);
}

TEST_F(UTEST_ACL_DataBuffer, aclUpdateDataBuffer_LeavesOldDataOwnedByCaller)
{
    std::unique_ptr<uint8_t[]> oldData(new uint8_t[2U]{7U, 8U});
    std::unique_ptr<uint8_t[]> newData(new uint8_t[2U]{9U, 10U});
    DataBufferPtr buffer(aclCreateDataBuffer(oldData.get(), 2U));
    ASSERT_NE(buffer, nullptr);

    EXPECT_EQ(aclUpdateDataBuffer(buffer.get(), newData.get(), 2U), ACL_SUCCESS);
    EXPECT_EQ(aclGetDataBufferAddr(buffer.get()), newData.get());
    EXPECT_EQ(aclGetDataBufferSizeV2(buffer.get()), 2U);
    EXPECT_EQ(oldData[0U], 7U);
    EXPECT_EQ(oldData[1U], 8U);
    oldData[0U] = 11U;
    EXPECT_EQ(oldData[0U], 11U);
    EXPECT_EQ(newData[0U], 9U);
}

TEST_F(UTEST_ACL_DataBuffer, aclDestroyDataBuffer_LeavesDataOwnedByCaller)
{
    std::unique_ptr<uint8_t[]> data(new uint8_t[2U]{7U, 8U});
    DataBufferPtr buffer(aclCreateDataBuffer(data.get(), 2U));
    ASSERT_NE(buffer, nullptr);

    EXPECT_EQ(aclDestroyDataBuffer(buffer.release()), ACL_SUCCESS);
    EXPECT_EQ(data[0U], 7U);
    EXPECT_EQ(data[1U], 8U);
    data[0U] = 9U;
    EXPECT_EQ(data[0U], 9U);
}
