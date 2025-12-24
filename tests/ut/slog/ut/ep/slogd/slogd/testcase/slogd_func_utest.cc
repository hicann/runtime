/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ascend_hal_stub.h"
#include "self_log_stub.h"
#include "slogd_main.h"
#include "slogd_flush.h"
#include "log_pm.h"
#include "slogd_communication.h"
#include <grp.h>
#include "slogd_recv_msg.h"
#include "log_system_api.h"
#include "log_pm_sr.h"
#include "log_pm_sig.h"
#include "log_file_info.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "log_path_mgr.h"
#include "slogd_appnum_watch.h"
#include "log_path_mgr.h"
#include <sys/msg.h>
#include "trace_server.h"
using namespace std;
using namespace testing;

extern "C" {
    extern ToolMutex g_confMutex;
    extern SlogdStatus g_slogdStatus;
    extern char g_rootLogPath[CFG_LOGAGENT_PATH_MAX_LENGTH + 1U];
    int32_t TestMain(int32_t argc, char **argv);
    toolSockHandle SlogdCreateSocketBySlogFile(char *socketPath, char *username, int32_t permission);
    int32_t SlogdGetSocketPath(int32_t devId, char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U], uint32_t *fileNum);
}
class SLOGD_FUNC_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        DlogConstructor();
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        DlogDestructor();
        system("rm -rf " DEFAULT_LOG_WORKSPACE "/*");
        system("rm -rf " LOG_FILE_PATH "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " DEFAULT_LOG_WORKSPACE);
        system("mkdir -p " LOG_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:
    static void DlogConstructor()
    {
        g_confMutex = TOOL_MUTEX_INITIALIZER;
        g_slogdStatus = SLOGD_RUNNING;
        optind = 1;
        MOCKER(lchown).stubs().will(returnValue(0));
        MOCKER(msgrcv).stubs().will(returnValue(-1));
        memset_s(&g_rootLogPath, CFG_LOGAGENT_PATH_MAX_LENGTH + 1U, 0, CFG_LOGAGENT_PATH_MAX_LENGTH + 1U);
        LogRecordSigNo(0);
    }

    static void DlogDestructor() {
        log_release_buffer();
    }

    int DlogCmdGetIntRet(const char *path, const char*cmd)
    {
        char resultFile[200] = {0};
        sprintf(resultFile, "%s/EP_SLOGD_FUNC_STEST_cmd_result.txt", path);

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

typedef struct {
    int32_t argc;
    char **argv;
} Args;

static void *MainThreadFunc(void *arg)
{
    Args *in = (Args *)arg;
    TestMain(in->argc, in->argv);
    return NULL;
}

static pthread_t StartThread(Args *arg)
{
    pthread_t tid = 0;
    pthread_attr_t attr;
    (void)pthread_create(&tid, NULL, MainThreadFunc, (void *)arg);
    return tid;
}

static toolSockHandle SlogdCreateSocketBySlogFile_stub(char *socketPath, char *groupName, int32_t permission)
{
    int32_t fd = open(socketPath, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
    char str[128] = "socket test.";
    int len = write(fd, str, strlen(str));
    return (toolSockHandle)fd;
}

static int32_t ToolRead_stub(int32_t fd, void *buf, uint32_t bufLen)
{
    lseek(fd, 0L, SEEK_SET);
    int32_t ret = (int32_t)read(fd, buf, (size_t)bufLen);
    EXPECT_STREQ("socket test.", (char *)buf);
    return ret;
}

TEST_F(SLOGD_FUNC_UTEST, SlogdCreateSocketBySlogFile)
{
    struct group grpInfo;

    char *workDir = "/usr/slog";

    MOCKER(ToolUnlink).stubs().will(returnValue(0));
    MOCKER(ToolSocket).stubs().will(returnValue(2));
    MOCKER(setsockopt).stubs().will(returnValue(0));
    MOCKER(ToolBind).stubs().will(returnValue(0));
    MOCKER(getgrnam).stubs().will(returnValue(&grpInfo));
    MOCKER(lchown).stubs().will(returnValue(0));
    MOCKER(ToolChmod).stubs().will(returnValue(0));

    uint32_t fileNum = 0;
    EXPECT_EQ(2, SlogdCreateSocketBySlogFile(workDir, "HwHiAiUser", (int32_t)SyncGroupToOther(S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP)));
    GlobalMockObject::reset();
}

TEST_F(SLOGD_FUNC_UTEST, SlogdGetSocketPath_devIdNotSet)
{
    char *workDir = "/usr/slog";
    char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U];
    (void)memset_s(socketPath, sizeof(socketPath), 0, sizeof(socketPath));
    uint32_t fileNum = 0;
    int32_t devId = -1;

    MOCKER(LogGetWorkspacePath).stubs().will(returnValue(workDir));
    SlogdGetSocketPath(devId, socketPath, &fileNum);

    EXPECT_EQ(2, fileNum);
    EXPECT_STREQ("/usr/slog/slog", socketPath[0]);
    EXPECT_STREQ("/usr/slog/slog_app", socketPath[1]);
    GlobalMockObject::reset();
}

TEST_F(SLOGD_FUNC_UTEST, SlogdGetSocketPath_vfId)
{
    char *workDir = "/usr/slog";
    char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U];
    (void)memset_s(socketPath, sizeof(socketPath), 0, sizeof(socketPath));
    uint32_t fileNum = 0;

    int32_t devId = 32;
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue(workDir));
    SlogdGetSocketPath(devId, socketPath, &fileNum);

    EXPECT_EQ(1, fileNum);
    EXPECT_STREQ("/usr/slog/slog_32", socketPath[0]);

    devId = 63;
    SlogdGetSocketPath(devId, socketPath, &fileNum);
    EXPECT_EQ(1, fileNum);
    EXPECT_STREQ(socketPath[0], "/usr/slog/slog_63");
    GlobalMockObject::reset();
}

TEST_F(SLOGD_FUNC_UTEST, SlogdGetSocketPath_devIdExceed)
{
    char *workDir = "/usr/slog";
    char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U];
    (void)memset_s(socketPath, sizeof(socketPath), 0, sizeof(socketPath));
    uint32_t fileNum = 0;

    int32_t devId = 64;
    char *expectRes = "/usr/slog/slog";
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue(workDir));
    SlogdGetSocketPath(devId, socketPath, &fileNum);
    EXPECT_EQ(2, fileNum);
    EXPECT_STREQ(socketPath[0], expectRes);
    EXPECT_STREQ(socketPath[1], "/usr/slog/slog_app");
    GlobalMockObject::reset();
}

TEST_F(SLOGD_FUNC_UTEST, argvInvalid)
{
    char *argv[] = {"slogd", "--test_error"};
    EXPECT_EQ(LOG_FAILURE, TestMain(2, argv));
}

TEST_F(SLOGD_FUNC_UTEST, TraceServerFailed)
{
    MOCKER(CreateAppLogWatchThread).stubs();
    system("touch " KERNEL_LOG_PATH);
    MOCKER(TraceServerProcess).stubs().will(returnValue(-1));
    char *argv[] = { "slogd", "-n", NULL };
    EXPECT_EQ(LOG_FAILURE, TestMain(2, argv));
}