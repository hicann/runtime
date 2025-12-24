/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_path_mgr.h"
#include "log_file_info.h"
#include "log_config_api.h"
#include "self_log_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

#define SLOGD_LOG_FILE              "/slogdlog"
#define SLOGD_LOG_OLD_FILE          "/slogdlog.old"
#define SLOGD_LOG_LOCK              "/tmp.lock"

extern "C"
{
    extern char g_rootLogPath[CFG_LOGAGENT_PATH_MAX_LENGTH + 1U];
}

class EP_SLOGD_LOG_PATH_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        memset_s(&g_rootLogPath, CFG_LOGAGENT_PATH_MAX_LENGTH + 1U, 0, CFG_LOGAGENT_PATH_MAX_LENGTH + 1U);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        EXPECT_EQ(0, GetErrLogNum());
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
        system("rm -rf " DEFAULT_LOG_WORKSPACE);
        system("rm -rf " LOG_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:

};

TEST_F(EP_SLOGD_LOG_PATH_FUNC_UTEST, LogPathMgrInitDefault)
{
    EXPECT_EQ(SYS_OK, LogPathMgrInit());

    EXPECT_STREQ(LOG_FILE_PATH, LogGetRootPath());
    char path[256] = { 0 };
    snprintf_s(path, 256, 255, "%s%s", LOG_FILE_PATH, LOG_DIR_FOR_SELF_LOG);
    EXPECT_STREQ(path, LogGetSelfPath());

    memset_s(path, 256, 0, 256);
    snprintf_s(path, 256, 255, "%s%s", LogGetSelfPath(), SLOGD_LOG_FILE);
    EXPECT_STREQ(path, LogGetSelfFile());
    memset_s(path, 256, 0, 256);
    snprintf_s(path, 256, 255, "%s%s", LogGetSelfPath(), SLOGD_LOG_OLD_FILE);
    EXPECT_STREQ(path, LogGetSelfOldFile());
    memset_s(path, 256, 0, 256);
    snprintf_s(path, 256, 255, "%s%s", LogGetSelfPath(), SLOGD_LOG_LOCK);
    EXPECT_STREQ(path, LogGetSelfLockFile());

    LogPathMgrExit();
}

TEST_F(EP_SLOGD_LOG_PATH_FUNC_UTEST, LogPathMgrInit)
{
    char cmd[256] = { 0 };
    snprintf_s(cmd, 256, 255, "sed -i 's/npu/&test/' %s", SLOG_CONF_FILE_PATH);
    system(cmd);
    char *rootPath = "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/nputest/slog";
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/nputest/slog");

    EXPECT_EQ(SYS_OK, LogConfInit());
    EXPECT_EQ(SYS_OK, LogPathMgrInit());

    EXPECT_STREQ(rootPath, LogGetRootPath());

    char path[256] = { 0 };
    snprintf_s(path, 256, 255, "%s%s", LogGetRootPath(), LOG_DIR_FOR_SELF_LOG);
    EXPECT_STREQ(path, LogGetSelfPath());

    memset_s(path, 256, 0, 256);
    snprintf_s(path, 256, 255, "%s%s", LogGetSelfPath(), SLOGD_LOG_FILE);
    EXPECT_STREQ(path, LogGetSelfFile());
    memset_s(path, 256, 0, 256);
    snprintf_s(path, 256, 255, "%s%s", LogGetSelfPath(), SLOGD_LOG_OLD_FILE);
    EXPECT_STREQ(path, LogGetSelfOldFile());
    memset_s(path, 256, 0, 256);
    snprintf_s(path, 256, 255, "%s%s", LogGetSelfPath(), SLOGD_LOG_LOCK);
    EXPECT_STREQ(path, LogGetSelfLockFile());

    LogPathMgrExit();
    LogConfListFree();
    system("rm "SLOG_CONF_FILE_PATH);
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
}

TEST_F(EP_SLOGD_LOG_PATH_FUNC_UTEST, LogPathMgrInitFailed)
{
    char cmd[256] = { 0 };
    snprintf_s(cmd, 256, 255, "sed -i 's/npu/&test/' %s", SLOG_CONF_FILE_PATH);
    system(cmd);
    char *rootPath = "/tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/nputest/slog";
    system("mkdir -p /tmp/ep_slogd_utest_6cEd5299d8d9Be97/var/log/nputest/slog");

    EXPECT_EQ(SYS_OK, LogConfInit());
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, LogPathMgrInit());
    LogPathMgrExit();
    LogConfListFree();
    system("rm "SLOG_CONF_FILE_PATH);
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
}

TEST_F(EP_SLOGD_LOG_PATH_FUNC_UTEST, LogGetWorkspacePath)
{
    EXPECT_STREQ(DEFAULT_LOG_WORKSPACE, LogGetWorkspacePath());
}