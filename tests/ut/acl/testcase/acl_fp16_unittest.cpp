/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>

#include "acl/acl_base.h"
#include "types/fp16_impl.h"

using namespace acl;

class UTEST_ACL_Fp16 : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}

};

bool Fp16Eq(uint16_t lhs, uint16_t rhs)
{
    return (lhs == rhs) || (((lhs | rhs) & INT16_T_MAX) == 0U);
}

TEST(UTEST_ACL_Fp16, TestHalfToFloat) {
    aclFloat16 halfVal1 = aclFloatToFloat16(1.0f);
    aclFloat16 halfVal2 = aclFloatToFloat16(1.0f);
    ASSERT_TRUE(Fp16Eq(halfVal1, halfVal2));
    halfVal2 = aclFloatToFloat16(-1.0f);
    ASSERT_FALSE(Fp16Eq(halfVal1, halfVal2));


    aclFloatToFloat16(999999999.0f);
    aclFloatToFloat16(-999999999.0f);
    aclFloatToFloat16(-0.00000001f);
}