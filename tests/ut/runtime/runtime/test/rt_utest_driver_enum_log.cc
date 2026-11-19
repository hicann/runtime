/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/api_enum_log.hpp"
#include <cstdio>
#include "gtest/gtest.h"
#include "runtime/dev.h"

using namespace cce::runtime;

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
TEST(DriverEnumLogNamesTest, RunModeNamesKeepReservedUnknown)
{
    EXPECT_EQ(std::string(RtRunModeToString(RT_RUN_MODE_OFFLINE)), "RUN_MODE_OFFLINE");
    EXPECT_EQ(std::string(RtRunModeToString(RT_RUN_MODE_ONLINE)), "RUN_MODE_ONLINE");
    EXPECT_EQ(std::string(RtRunModeToString(RT_RUN_MODE_AICPU_SCHED)), "RUN_MODE_AICPU_SCHED");
    EXPECT_EQ(std::string(RtRunModeToString(RT_RUN_MODE_RESERVED)), "UNKNOWN");
    // The unfixed enum's complete 0..3 range is covered above.
}
#else
TEST(DriverEnumLogNamesTest, DriverExtensionsReturnNumbersWithoutNames)
{
    char buffer[32] = {};
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%u"),
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(RT_RUN_MODE_ONLINE), RtRunModeToString(RT_RUN_MODE_ONLINE)));
    EXPECT_STREQ(buffer, "1");
}
#endif

TEST(DriverEnumLogFormatTest, ReservedRunModeNamePreservesRawWidthAndFollowingValue)
{
    char buffer[128] = {};
    const uint32_t mode = UINT32_MAX;
    // Keep the raw numeric carrier independent from the typed reserved-name probe.
    const int written = std::snprintf(
        buffer, sizeof(buffer), "Run mode=" RT_ENUM_LOG_FORMAT("%u") ", env type=%d",
        RT_ENUM_LOG_VALUE(mode, RtRunModeToString(RT_RUN_MODE_RESERVED)), -7);
    EXPECT_GT(written, 0);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(buffer, "Run mode=UNKNOWN(4294967295), env type=-7");
#else
    EXPECT_STREQ(buffer, "Run mode=4294967295, env type=-7");
#endif
}
