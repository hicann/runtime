/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>

#include "platform_error_define.h"
#include "platform_manager_v2.h"

TEST(PlatformManagerV2StubUTest, GetTinyVersionSpec)
{
    PlatformManagerV2& instance = PlatformManagerV2::Instance();
    std::string value;

    EXPECT_EQ(instance.GetSocSpec("Ascend031", "version", "NpuArch", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "3004");

    EXPECT_EQ(instance.GetSocSpec("Ascend031", "version", "Chip_type", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "8");
}

TEST(PlatformManagerV2StubUTest, GetTinyStreamSpec)
{
    PlatformManagerV2& instance = PlatformManagerV2::Instance();
    std::string value;

    EXPECT_EQ(instance.GetSocSpec("Ascend031", "SoCInfo", "normal_stream_num", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "480");

    EXPECT_EQ(instance.GetSocSpec("Ascend031", "SoCInfo", "normal_stream_depth", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "2048");

    EXPECT_EQ(instance.GetSocSpec("Ascend031", "SoCInfo", "huge_stream_num", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "0");

    EXPECT_EQ(instance.GetSocSpec("Ascend031", "SoCInfo", "huge_stream_depth", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "0");
}

TEST(PlatformManagerV2StubUTest, GetTinyCoreCountSpec)
{
    PlatformManagerV2& instance = PlatformManagerV2::Instance();
    std::string value;

    EXPECT_EQ(instance.GetSocSpec("Ascend031", "SoCInfo", "ai_core_cnt", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "1");

    EXPECT_EQ(instance.GetSocSpec("Ascend031", "SoCInfo", "ai_cpu_cnt", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "4");
}

TEST(PlatformManagerV2StubUTest, UnknownSpecUsesDefaultNpuArch)
{
    PlatformManagerV2& instance = PlatformManagerV2::Instance();
    std::string value = "unexpected";

    EXPECT_EQ(instance.GetSocSpec("UnknownSoc", "version", "NpuArch", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "3004");

    value = "unexpected";
    EXPECT_EQ(instance.GetSocSpec("Ascend031", "SoCInfo", "unknown", value), PLATFORM_SUCCESS);
    EXPECT_EQ(value, "3004");
}
