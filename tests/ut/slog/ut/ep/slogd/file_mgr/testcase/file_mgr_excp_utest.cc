/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "self_log_stub.h"
#include "log_to_file.h"
#include "slogd_config_mgr.h"
#include "slogd_flush.h"
#include "log_file_util.h"
#include "slogd_syslog.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

class EP_SLOGD_FILE_MGR_LOG_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    int DlogCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/EP_SLOGD_EXCP_STEST_cmd_result.txt", path);

        char cmdToFile[400] = {0};
        sprintf(cmdToFile, "%s > %s", cmd, resultFile);
        system(cmdToFile);

        char buf[100] = {0};
        FILE *fp = fopen(resultFile, "r");
        if (fp == NULL) {
            return 0;
        }
        int size = fread(buf, 1, 100, fp);
        fclose(fp);
        if (size == 0) {
            return 0;
        }
        return atoi(buf);
    }

    int DlogCheckDir(const char *path, const char *str)
    {
        if (access(path, F_OK) != 0) {
            return 0;
        }

        char cmd[200] = {0};
        sprintf(cmd, "ls %s | grep %s | wc -l", path, str);
        int ret = DlogCmdGetIntRet(PATH_ROOT, cmd);
        return ret;
    }
};

static void *MallocStub(size_t size)
{
    if (size == 0) {
        return NULL;
    }

    void *buffer = malloc(size);
    if (buffer == NULL) {
        return NULL;
    }

    int32_t ret = memset_s(buffer, size, 0, size);
    if (ret != EOK) {
        free(buffer);
        return NULL;
    }
    return buffer;
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_EXCP_UTEST, LogAgentInitDeviceMallocFailed)
{
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    SlogdConfigMgrInit();
    StLogFileList logList = { 0 };
    LogAgentGetCfg(&logList);
    MOCKER(LogMalloc).stubs().will(invoke(MallocStub)).then(invoke(MallocStub)).then(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, LogAgentInitDevice(&logList, MAX_DEV_NUM));
    EXPECT_EQ(1, GetErrLogNum());
    LogAgentCleanUpDevice(&logList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_EXCP_UTEST, LogAgentGetCfgNull)
{
    EXPECT_EQ(LOG_INVALID_PTR, LogAgentGetCfg(NULL));
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_EXCP_UTEST, LogAgentInitDeviceOsMallocFailed)
{
    // 初始化
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    system("mkdir -p " LOG_FILE_PATH "/security/device-app-100");
    SlogdConfigMgrInit();
    MOCKER(LogMalloc).stubs().will(returnValue((void *)NULL));
    StLogFileList logList = { 0 };
    snprintf_truncated_s(logList.aucFilePath, MAX_FILEDIR_LEN + 1U, "%s", LOG_FILE_PATH);
    LogAgentGetCfg(&logList);
    EXPECT_EQ(LOG_FAILURE, SlogdSyslogMgrInit(&logList));
    EXPECT_EQ(2, GetErrLogNum());
    LogAgentCleanUpDevice(&logList);
    SlogdConfigMgrExit();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_EXCP_UTEST, LogRemoveDirFailed)
{
    system("mkdir -p " PATH_ROOT);
    EXPECT_EQ(LOG_FAILURE, LogRemoveDir(NULL, 10));
    EXPECT_EQ(LOG_FAILURE, LogRemoveDir(PATH_ROOT, 10));
    GlobalMockObject::verify();

    system("mkdir -p " PATH_ROOT);
    MOCKER(opendir).stubs().will(returnValue((DIR *)NULL));
    EXPECT_EQ(LOG_FAILURE, LogRemoveDir(PATH_ROOT, 0));
    GlobalMockObject::verify();

    system("mkdir -p " PATH_ROOT "/testDir");
    system("mkdir -p " PATH_ROOT "/testDirNull");
    system("echo test > " PATH_ROOT "/testDir/test.log");
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, LogRemoveDir(PATH_ROOT, 0));
    GlobalMockObject::verify();

    system("mkdir -p " PATH_ROOT "/testDir");
    system("mkdir -p " PATH_ROOT "/testDirNull");
    system("echo test > " PATH_ROOT "/testDir/test.log");
    MOCKER(ToolStatGet).stubs().will(returnValue(LOG_FAILURE));
    EXPECT_EQ(LOG_FAILURE, LogRemoveDir(PATH_ROOT, 0));
    GlobalMockObject::verify();

    system("mkdir -p " PATH_ROOT "/testDir");
    system("mkdir -p " PATH_ROOT "/testDirNull");
    system("echo test > " PATH_ROOT "/testDir/test.log");
    MOCKER(ToolRmdir).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, LogRemoveDir(PATH_ROOT, 0));
    GlobalMockObject::verify();
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_EXCP_UTEST, LogFileTellFailed)
{
    EXPECT_EQ(-1, LogFileTell(NULL));
    system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
    FILE *fp = fopen(SLOG_CONF_FILE_PATH, "r");
    fclose(fp);
    EXPECT_EQ(-1, LogFileTell(fp));
}

TEST_F(EP_SLOGD_FILE_MGR_LOG_EXCP_UTEST, LogGetDirSizeFailed)
{
    system("mkdir -p " PATH_ROOT "/testDir");
    system("mkdir -p " PATH_ROOT "/testDirNull");
    system("echo test > " PATH_ROOT "/testDir/test.log");
    EXPECT_EQ(0, LogGetDirSize(NULL, 10));
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(0, LogGetDirSize(PATH_ROOT, 0));
    GlobalMockObject::verify();

    system("mkdir -p " PATH_ROOT "/testDir");
    system("mkdir -p " PATH_ROOT "/testDirNull");
    system("echo test > " PATH_ROOT "/testDir/test.log");
    MOCKER(ToolStatGet).stubs().will(returnValue(LOG_FAILURE));
    EXPECT_EQ(0, LogGetDirSize(PATH_ROOT, 0));
    GlobalMockObject::verify();

    system("mkdir -p " PATH_ROOT "/testDir");
    system("mkdir -p " PATH_ROOT "/testDirNull");
    system("echo test > " PATH_ROOT "/testDir/test.log");
    MOCKER(opendir).stubs().will(returnValue((DIR *)NULL));
    EXPECT_EQ(0, LogGetDirSize(PATH_ROOT, 0));
    GlobalMockObject::verify();
}