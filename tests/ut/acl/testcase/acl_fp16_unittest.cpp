/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdint>
#include <cstring>

#include <gtest/gtest.h>

#include "acl/acl_base.h"
#include "types/fp16_impl.h"

using namespace acl;

class UTEST_ACL_Fp16 : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}
};

bool Fp16Eq(uint16_t lhs, uint16_t rhs) { return (lhs == rhs) || (((lhs | rhs) & INT16_T_MAX) == 0U); }

TEST(UTEST_ACL_Fp16, TestHalfToFloat)
{
    aclFloat16 halfVal1 = aclFloatToFloat16(1.0f);
    aclFloat16 halfVal2 = aclFloatToFloat16(1.0f);
    ASSERT_TRUE(Fp16Eq(halfVal1, halfVal2));
    halfVal2 = aclFloatToFloat16(-1.0f);
    ASSERT_FALSE(Fp16Eq(halfVal1, halfVal2));

    aclFloatToFloat16(999999999.0f);
    aclFloatToFloat16(-999999999.0f);
    aclFloatToFloat16(-0.00000001f);
}

namespace {
struct Float16ToFloatCase {
    const char* name;
    aclFloat16 input;
    uint32_t expectedBits;
};
} // namespace

class UTEST_ACL_Float16ToFloat : public testing::TestWithParam<Float16ToFloatCase> {};

TEST_P(UTEST_ACL_Float16ToFloat, aclFloat16ToFloat_ReturnsExactFloatBits)
{
    const auto& testCase = GetParam();
    const float actual = aclFloat16ToFloat(testCase.input);
    uint32_t actualBits = 0U;
    static_assert(sizeof(actual) == sizeof(actualBits), "The API returns a 32-bit float");
    std::memcpy(&actualBits, &actual, sizeof(actualBits));

    // Comparing the representation also distinguishes positive and negative zero.
    EXPECT_EQ(actualBits, testCase.expectedBits);
}

INSTANTIATE_TEST_SUITE_P(
    FixedBitPatterns, UTEST_ACL_Float16ToFloat,
    testing::Values(
        Float16ToFloatCase{"PositiveZero", 0x0000U, 0x00000000U},
        Float16ToFloatCase{"NegativeZero", 0x8000U, 0x80000000U},
        Float16ToFloatCase{"PositiveOne", 0x3C00U, 0x3F800000U},
        Float16ToFloatCase{"NegativeOne", 0xBC00U, 0xBF800000U}, Float16ToFloatCase{"OneAndHalf", 0x3E00U, 0x3FC00000U},
        Float16ToFloatCase{"NegativeTwoAndHalf", 0xC100U, 0xC0200000U},
        Float16ToFloatCase{"NextAfterOne", 0x3C01U, 0x3F802000U},
        Float16ToFloatCase{"SmallestSubnormal", 0x0001U, 0x33800000U},
        Float16ToFloatCase{"NegativeSmallestSubnormal", 0x8001U, 0xB3800000U},
        Float16ToFloatCase{"SecondSubnormal", 0x0002U, 0x34000000U},
        Float16ToFloatCase{"MiddleSubnormal", 0x0200U, 0x38000000U},
        Float16ToFloatCase{"LargestSubnormal", 0x03FFU, 0x387FC000U},
        Float16ToFloatCase{"SmallestNormal", 0x0400U, 0x38800000U},
        Float16ToFloatCase{"NegativeSmallestNormal", 0x8400U, 0xB8800000U},
        Float16ToFloatCase{"LargestFinite", 0x7BFFU, 0x477FE000U},
        Float16ToFloatCase{"NegativeLargestFinite", 0xFBFFU, 0xC77FE000U},
        // The documented API contract converts Inf/NaN encodings to finite values.
        Float16ToFloatCase{"PositiveInfTo65536", 0x7C00U, 0x47800000U},
        Float16ToFloatCase{"NegativeInfToMinus65536", 0xFC00U, 0xC7800000U},
        Float16ToFloatCase{"QuietNanTo98304", 0x7E00U, 0x47C00000U},
        Float16ToFloatCase{"NegativeQuietNanToMinus98304", 0xFE00U, 0xC7C00000U},
        Float16ToFloatCase{"NanPayloadOneTo65600", 0x7C01U, 0x47802000U},
        Float16ToFloatCase{"NanPayloadMaxTo131008", 0x7FFFU, 0x47FFE000U}),
    [](const testing::TestParamInfo<Float16ToFloatCase>& info) { return info.param.name; });