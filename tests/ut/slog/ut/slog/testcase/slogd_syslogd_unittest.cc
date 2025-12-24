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
#include <errno.h>
#include <sys/stat.h>
#include "securec.h"
#include "slogd_dev_mgr.h"
#include "slogd_parse_msg.h"
#include "log_pm_sr.h"
#include "log_pm_sig.h"
#include "log_pm.h"
#include "slogd_communication.h"
#include "slogd_flush.h"
#include "slogd_recv_core.h"
#include "slogd_appnum_watch.h"
#include "slogd_recv_msg.h"
#include "log_file_util.h"
#include "slogd_syslog.h"
#include <grp.h>

extern "C" {
    #include "slog.h"
    #include "operate_loglevel.h"
    #include "share_mem.h"
    #include "log_config_api.h"
    #include "log_common.h"
    #include "log_session_manage.h"
    #include "slogd_utest_stub.h"
    #include "dlog_socket.h"
    #include "log_path_mgr.h"
    #include "log_recv.h"
    #include "log_to_file.h"
    int32_t SlogdCreateSocket(int32_t devId, uint32_t *fileNum);
    int SlogdDataBufUnlock(ToolMutex* mutex);
    void *SlogdFlushCommonLog(void *arg);
    extern int32_t SlogdGetSocketPath(int32_t devId, char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U], uint32_t *fileNum);
    extern toolSockHandle SlogdCreateSocketBySlogFile(char *socketPath, char *username, int32_t permission);
    int32_t SlogdInitArgs(int argc, char **argv, struct SlogdOptions *opt);
    int GetPermissionForAllUserFlag(void);
    void LogSignalActionSet(int32_t sig, void (*handler)(int32_t));
}

#define DEFAULT_LOG_BUF_SIZE (256 * 1024) // 256KB
#define MIN_LOG_BUF_SIZE (64 * 1024) // 64KB
#define MAX_LOG_BUF_SIZE (1024 * 1024) // 1024KB

class SlogdSyslogd : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SlogdSyslogd::SetUp()
{
    SlogdCommunicationInit();
}

void SlogdSyslogd::TearDown()
{
    SlogdCommunicationExit();
}

TEST_F(SlogdSyslogd, FflushLogDataBuf00)
{
    SessionNode *node = (SessionNode *)malloc(sizeof(SessionNode));
    node->next = nullptr;
    node->session = (uintptr_t)0x12345678;
    node->pid = 1;
    node->devId = 1;
    node->timeout = 1000;
    LogInfo info = { DEBUG_LOG, SYSTEM, 0, 0 };
    MOCKER(SlogdSyslogMgrInit).stubs().will(returnValue(LOG_SUCCESS));
    MOCKER(ToolCreateTaskWithDetach).stubs().will(returnValue(LOG_SUCCESS));
    EXPECT_EQ(LOG_SUCCESS, SlogdFlushInit());
    SlogdWriteToBuffer("msg", strlen("msg"), &info);
    MOCKER(LogAgentWriteDeviceOsLog).stubs().will(returnValue((unsigned int)1));
    PushDeletedSessionNode(node);
    SlogdFlushToFile(false);
    SlogdFlushExit();
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, ProcSyslogBuf)
{
    char buf[] = "test for ProcSyslogBuf, proc syslog buf with space or endline.\n";
    int size = (int)strlen(buf);
    EXPECT_EQ(SYS_OK, ProcSyslogBuf(buf, &size));
    EXPECT_EQ(strlen(buf) - 1, size);
}

TEST_F(SlogdSyslogd, CreateSocket00)
{
    char *workDir = "/usr/slog";
    uint32_t fileNum = 0;


    MOCKER(SlogdGetSocketPath).stubs()
        .with(any(), any(), outBoundP(&fileNum))
        .will(returnValue(0));
    MOCKER(SlogdCreateSocketBySlogFile).stubs().will(returnValue(0));
    EXPECT_EQ(0, SlogdCreateSocket(0, &fileNum));
    GlobalMockObject::reset();
}

void ChangeSignal() {
    LogRecordSigNo(1);
}

TEST_F(SlogdSyslogd, CreateSocket01)
{
    MOCKER(ToolSocket).stubs().will(returnValue(-1));

    uint32_t fileNum = 0;
    EXPECT_EQ(SYS_ERROR, SlogdCreateSocket(0, &fileNum));
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, CreateSocket02)
{
    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(ToolBind).stubs().will(returnValue(-1));

    uint32_t fileNum = 0;
    EXPECT_EQ(SYS_ERROR, SlogdCreateSocket(0, &fileNum));
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, CreateSocket03)
{
    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(ToolBind).stubs().will(returnValue(-1));
    MOCKER(memset_s).stubs().will(returnValue(1));
    MOCKER(strcpy_s).stubs().will(returnValue(1));

    uint32_t fileNum = 0;
    EXPECT_EQ(SYS_ERROR, SlogdCreateSocket(0, &fileNum));
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, CreateSocket04)
{
    MOCKER(ToolSocket).stubs().will(returnValue(0));
    MOCKER(ToolBind).stubs().will(returnValue(-1));
    MOCKER(memset_s).stubs().will(returnValue(1));
    MOCKER(ToolUnlink).stubs().will(returnValue(1));

    uint32_t fileNum = 0;
    EXPECT_EQ(SYS_ERROR, SlogdCreateSocket(0, &fileNum));
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, SlogdCreateSocket)
{
    MOCKER(memset_s).stubs().will(returnValue(-1));
    MOCKER(strcpy_s).stubs().will(returnValue(-1));
    MOCKER(ToolUnlink).stubs().will(returnValue(-1));
    uint32_t fileNum = 0;
    EXPECT_EQ(SYS_ERROR, SlogdCreateSocket(0, &fileNum));
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, GetDeviceSideDeviceId)
{
    EXPECT_EQ(0, GetDeviceSideDeviceId(0));
    EXPECT_EQ(HOST_MAX_DEV_NUM, GetDeviceSideDeviceId(HOST_MAX_DEV_NUM));
}

TEST_F(SlogdSyslogd, getSlogdSocketPath_approve_vfidNotSet)
{
    char *workDir = "/usr/slog";
    char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U];
    (void)memset_s(socketPath, sizeof(socketPath), 0, sizeof(socketPath));
    uint32_t fileNum = 0;

    int32_t devId = -1;
    char *expectRes = "/usr/slog/slog";
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue(workDir));
    SlogdGetSocketPath(devId, socketPath, &fileNum);
    EXPECT_EQ(2, fileNum);
    EXPECT_STREQ(socketPath[0], expectRes);
    EXPECT_STREQ(socketPath[1], "/usr/slog/slog_app");
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, getSlogdSocketPath_approve_vfidMin)
{
    char *workDir = "/usr/slog";
    char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U];
    (void)memset_s(socketPath, sizeof(socketPath), 0, sizeof(socketPath));
    uint32_t fileNum = 0;

    int32_t devId = 32;
    char *expectRes = "/usr/slog/slog_32";
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue(workDir));
    SlogdGetSocketPath(devId, socketPath, &fileNum);
    EXPECT_EQ(1, fileNum);
    EXPECT_STREQ(socketPath[0], expectRes);
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, getSlogdSocketPath_approve_vfidMax)
{
    char *workDir = "/usr/slog";
    char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U];
    (void)memset_s(socketPath, sizeof(socketPath), 0, sizeof(socketPath));
    uint32_t fileNum = 0;

    int32_t devId = 63;
    char *expectRes = "/usr/slog/slog_63";
    MOCKER(LogGetWorkspacePath).stubs().will(returnValue(workDir));
    SlogdGetSocketPath(devId, socketPath, &fileNum);
    EXPECT_EQ(1, fileNum);
    EXPECT_STREQ(socketPath[0], expectRes);
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, getSlogdSocketPath_approve_vfidExceed)
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

TEST_F(SlogdSyslogd, slogdInitArgs_reject_nullArgs)
{
    int32_t argc = 0;
    char *argv[] = {};
    struct SlogdOptions opt = { 0, 0, -1};
    EXPECT_EQ(SlogdInitArgs(argc, argv, &opt), SYS_ERROR);
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, slogdInitArgs_approve_helpArgs)
{
    int32_t argc = 2;
    char *argv[2] = {"./slogd", "-h"};
    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(ParseSlogdArgv).stubs().will(returnValue(SYS_ERROR));
    MOCKER(LogSetDaemonize).stubs().will(returnValue(SYS_OK));
    printf("ret=%d\n", SlogdInitArgs(argc, argv, &opt));
    EXPECT_EQ(SlogdInitArgs(argc, argv, &opt), SYS_ERROR);
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, slogdInitArgs_approve_levelArgs)
{
    int32_t argc = 3;
    char *argv[3] = { "./slogd", "-l", "2"};
    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(ParseSlogdArgv).stubs().will(returnValue(SYS_OK));
    MOCKER(LogSetDaemonize).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SlogdInitArgs(argc, argv, &opt), SYS_OK);
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, slogdInitArgs_approve_vfidArgs)
{
    int32_t argc = 3;
    char *argv[3] = { "./slogd", "-v", "32"};
    struct SlogdOptions opt = { 0, 0, -1};
    MOCKER(ParseSlogdArgv).stubs().will(returnValue(SYS_OK));
    MOCKER(LogSetDaemonize).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SlogdInitArgs(argc, argv, &opt), SYS_OK);
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, GetSystemState)
{
    EXPECT_EQ(WORKING, GetSystemState());
    GlobalMockObject::reset();
}

TEST_F(SlogdSyslogd, RegisterSRNotifyCallback)
{
    EXPECT_EQ(0, RegisterSRNotifyCallback());
    GlobalMockObject::reset();
}

