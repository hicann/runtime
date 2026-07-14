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

extern "C" {
#include "log_error_code.h"
#include "msnpureport_level.h"
#include "msnpureport_print.h"
#include "msnpureport_utils.h"
}

class EP_LOG_DAEMON_MSNPUREPORT_LEVEL_UTEST : public testing::Test {
};

TEST_F(EP_LOG_DAEMON_MSNPUREPORT_LEVEL_UTEST, GetModuleInfoByNameHandlesValidAndInvalidNames)
{
    const ModuleInfo *module = GetModuleInfoByName("SLOG");
    ASSERT_NE(nullptr, module);
    EXPECT_STREQ("SLOG", module->moduleName);

    EXPECT_EQ(nullptr, GetModuleInfoByName(nullptr));
    EXPECT_EQ(nullptr, GetModuleInfoByName("INVALID_MODULE"));
}

TEST_F(EP_LOG_DAEMON_MSNPUREPORT_LEVEL_UTEST, GetLevelIdByNameHandlesValidAndInvalidNames)
{
    EXPECT_EQ(DLOG_DEBUG, GetLevelIdByName("DEBUG"));
    EXPECT_EQ(DLOG_INFO, GetLevelIdByName("INFO"));
    EXPECT_EQ(DLOG_WARN, GetLevelIdByName("WARNING"));
    EXPECT_EQ(DLOG_ERROR, GetLevelIdByName("ERROR"));
    EXPECT_EQ(DLOG_NULL, GetLevelIdByName("NULL"));
    EXPECT_EQ(DLOG_EVENT, GetLevelIdByName("EVENT"));

    EXPECT_EQ(-1, GetLevelIdByName(nullptr));
    EXPECT_EQ(-1, GetLevelIdByName("INVALID_LEVEL"));
}

TEST_F(EP_LOG_DAEMON_MSNPUREPORT_LEVEL_UTEST, PrintConfigAccessorsUpdateGlobalState)
{
    MsnPrintSetLogLevel(LOG_DEBUG);
    EXPECT_EQ(LOG_DEBUG, MsnPrintGetLogLevel());

    MsnSetLogPrintMode(PRINT_STDOUT);
    EXPECT_EQ(PRINT_STDOUT, MsnGetLogPrintMode());

    MsnSetLogPrintMode(PRINT_SYSLOG);
    EXPECT_EQ(PRINT_SYSLOG, MsnGetLogPrintMode());
}

TEST_F(EP_LOG_DAEMON_MSNPUREPORT_LEVEL_UTEST, MsnPrintInfoIgnoresNullInfo)
{
    MsnPrintInfo(0, nullptr);
}

TEST_F(EP_LOG_DAEMON_MSNPUREPORT_LEVEL_UTEST, MsnUtilityMemoryAndStringHelpers)
{
    EXPECT_EQ(nullptr, MsnMalloc(0));

    void *buffer = MsnMalloc(8);
    ASSERT_NE(nullptr, buffer);
    MsnFree(buffer);
    MsnFree(nullptr);

    char text[] = "aBc123";
    MsnToUpper(text, sizeof(text));
    EXPECT_STREQ("ABC123", text);
}

TEST_F(EP_LOG_DAEMON_MSNPUREPORT_LEVEL_UTEST, MsnUtilityErrorPathsAreDeterministic)
{
    EXPECT_EQ(-1, MsnMkdir(nullptr));
    EXPECT_EQ(-1, MsnMkdirMulti(nullptr));

    uint32_t devNum = 0;
    uint32_t devIds[MAX_DEV_NUM] = {0};
    EXPECT_EQ(-1, MsnGetDevIDs(&devNum, devIds, MAX_DEV_NUM));
    EXPECT_EQ(-1, MsnCheckDeviceId(0));
}
