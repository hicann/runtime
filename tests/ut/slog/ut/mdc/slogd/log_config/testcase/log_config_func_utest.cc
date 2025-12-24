/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "log_config_group.h"
#include "self_log_stub.h"

using namespace std;
using namespace testing;

#define SLOG_CONF_FILE  "slog_func_A1SUs28SDBwhdcus.conf"
#define SLOG_11CONF_FILE  "slog_11func_A1SUs28SDBwhdcus.conf"

extern GeneralGroupInfo g_groupInfo;

class MDC_LOG_CONFIG_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("> " BOOTARGS_FILE_PATH);
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        EXPECT_EQ(0, GetErrLogNum());
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("mkdir -p " FILE_DIR);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    static void DlogConstructor()
    {
    }

    static void DlogDestructor()
    {
        (void)memset_s(&g_groupInfo, sizeof(GeneralGroupInfo), 0, sizeof(GeneralGroupInfo));
    }
};

TEST_F(MDC_LOG_CONFIG_FUNC_UTEST, LogConfigGroupInit)
{
    // 初始化
    DlogConstructor();
    char file[256] = { 0 };
    sprintf(file, "%s%s", SLOG_CONF_FILE_DIR, SLOG_CONF_FILE);
    LogConfGroupInit(file);

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(MDC_LOG_CONFIG_FUNC_UTEST, LogConfigGroupInit11)
{
    // 初始化
    DlogConstructor();
    char file[256] = { 0 };
    sprintf(file, "%s%s", SLOG_CONF_FILE_DIR, SLOG_11CONF_FILE);
    LogConfGroupInit(file);

    // 释放
    DlogDestructor();
    EXPECT_EQ(0, GetErrLogNum());
}