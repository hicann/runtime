/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_config_api.h"
#include "log_config_list.h"
#include "log_to_file.h"
#include "slogd_config_mgr.h"
#include "self_log_stub.h"
#include "config_stub.h"
#include "slogd_buffer.h"
#include "adcore_api.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

extern "C" {
    extern ToolMutex g_confMutex;
}

class EP_SLOGD_CONFIG_FUNC_MILAN_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        g_confMutex = TOOL_MUTEX_INITIALIZER;
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " DEFAULT_LOG_WORKSPACE "/*");
        system("rm -rf " LOG_FILE_PATH "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " DEFAULT_LOG_WORKSPACE);
        system("mkdir -p " LOG_FILE_PATH);
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

int32_t AdxSendMsg(const CommHandle *handle, AdxString data, uint32_t len)
{
    return 0;
}

TEST_F(EP_SLOGD_CONFIG_FUNC_MILAN_UTEST, SlogdConfigGetItem)
{
    SlogdConfigMgrInit();
    uint32_t oneMegabyte = 1024 * 1024;
    EXPECT_EQ(3U * oneMegabyte, SlogdConfigMgrGetBufSize(DEBUG_SYS_LOG_TYPE));
    EXPECT_EQ(2U * oneMegabyte, SlogdConfigMgrGetBufSize(SEC_SYS_LOG_TYPE));
    EXPECT_EQ(3U * oneMegabyte, SlogdConfigMgrGetBufSize(RUN_SYS_LOG_TYPE));
    EXPECT_EQ(2U * oneMegabyte, SlogdConfigMgrGetBufSize(EVENT_LOG_TYPE));
    EXPECT_EQ(20U * oneMegabyte, SlogdConfigMgrGetBufSize(FIRM_LOG_TYPE));
    EXPECT_EQ(65536, SlogdConfigMgrGetBufSize(DEBUG_APP_LOG_TYPE));
    EXPECT_EQ(0, GetErrLogNum());
    EXPECT_EQ(0, SlogdConfigMgrGetBufSize(1000));
    EXPECT_EQ(1, GetErrLogNum());
    SlogdConfigMgrExit();
}