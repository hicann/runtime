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

#include <string>

#include "mstx_resource_name_util.h"

namespace {
constexpr uint32_t INVALID_TYPE = static_cast<uint32_t>(MSTX_RESOURCE_TYPE_INVALID);
constexpr uint32_t SIZE_TYPE = static_cast<uint32_t>(MSTX_RESOURCE_TYPE_SIZE);
} // namespace

TEST(MSTX_RESOURCE_NAME_UTEST, ValidResourceTypeBoundary)
{
    // 非法类型：INVALID(0) 与 SIZE(7) 及以上都应被拒绝
    EXPECT_FALSE(MstxIsValidResourceType(INVALID_TYPE));
    EXPECT_FALSE(MstxIsValidResourceType(SIZE_TYPE));
    EXPECT_FALSE(MstxIsValidResourceType(99u));
    // 合法类型：1~6
    for (uint32_t type = 1u; type < SIZE_TYPE; ++type) {
        EXPECT_TRUE(MstxIsValidResourceType(type)) << "type=" << type;
    }
}

TEST(MSTX_RESOURCE_NAME_UTEST, TruncateResourceNameNormal)
{
    EXPECT_EQ(MstxTruncateResourceName("stream0"), std::string("stream0"));
}

TEST(MSTX_RESOURCE_NAME_UTEST, TruncateResourceNameEmptyAndNull)
{
    EXPECT_EQ(MstxTruncateResourceName(""), std::string());
    EXPECT_EQ(MstxTruncateResourceName(nullptr), std::string());
}

TEST(MSTX_RESOURCE_NAME_UTEST, TruncateResourceNameTooLong)
{
    // 超过 64 字节的名称应被截断到 64 字节
    std::string longName(100, 'a');
    EXPECT_EQ(MstxTruncateResourceName(longName.c_str()).size(), static_cast<size_t>(MSTX_RESOURCE_NAME_MAX_LEN));
    // 恰好 64 字节不截断
    std::string exact(MSTX_RESOURCE_NAME_MAX_LEN, 'b');
    EXPECT_EQ(MstxTruncateResourceName(exact.c_str()), exact);
}
