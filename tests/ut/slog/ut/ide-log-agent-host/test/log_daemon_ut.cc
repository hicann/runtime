/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_group_log.h"
#include "log_print.h"
extern "C"
{
    #include "log_queue.h"
    #include "log_common.h"
    #include "string.h"
    #include "log_daemon_ut_stub.h"
    #include "log_common.h"
    #include "log_config_api.h"
    #include "log_path_mgr.h"
    #include "log_pm.h"
    #include "log_monitor.h"
    #include <signal.h>
    #include <execinfo.h>
    #include <getopt.h>
    extern int MainInit(int argc, const char *argv[]);
    extern int LogMonitorRegister(unsigned int flagLog);
    void InitFileServer(void);
    void ExitFileServer(void);
    void StartSysmonitorThread(void);
    void ExitSysmonitorThread(void);
};

#include "start_single_process.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "log_pm_sig.h"

using namespace std;
using namespace testing;

class LogDaemonUtest : public testing::Test{
protected:
    virtual void SetUp()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

TEST_F(LogDaemonUtest, TestDaemonFailed01)
{
    MOCKER(signal)
        .stubs()
        .will(returnValue((sighandler_t)0));

    MOCKER(sigaction)
        .stubs()
        .will(returnValue(0));

    MOCKER(daemon)
        .stubs()
        .will(returnValue(-1));

    MOCKER(getopt_long)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));

    int a = 0;
    char** argv;
    EXPECT_EQ(SYS_ERROR, LogDaemonTest(a, argv));
    GlobalMockObject::reset();
}

TEST_F(LogDaemonUtest, TestDaemonFailed02)
{
    MOCKER(signal)
        .stubs()
        .will(returnValue((sighandler_t)0));

    MOCKER(sigaction)
        .stubs()
        .will(returnValue(0));

    MOCKER(daemon)
        .stubs()
        .will(returnValue(0));

    MOCKER(getopt_long)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));

    MOCKER(LogMonitorStart)
        .stubs()
        .will(returnValue(-1));

    int a = 0;
    char** argv;
    EXPECT_EQ(SYS_ERROR, LogDaemonTest(a, argv));
    GlobalMockObject::reset();
}

TEST_F(LogDaemonUtest, TestDaemonCreatClientErr)
{
    MOCKER(MainInit).stubs().will(returnValue(-1));
    int a = 0;
    char** argv;
    EXPECT_EQ(SYS_ERROR, LogDaemonTest(a, argv));

    GlobalMockObject::reset();
}

unsigned char IsInitErrorStub()
{
    LogRecordSigNo(1);
    return (unsigned char)0;
}

TEST_F(LogDaemonUtest, LockRegFdLtZero)
{
    int fd = -1;
    LockRegParams params = {fd, 0, 0, 0, 0, 0};
    EXPECT_EQ(0, LockReg(&params));
    GlobalMockObject::reset();
}

TEST_F(LogDaemonUtest, LockRegFdEqZero)
{
    int fd = 0;
    LockRegParams params = {fd, 0, 0, 0, 0, 0};
    EXPECT_EQ(0, LockReg(&params));
    GlobalMockObject::reset();
}

extern int g_lockFd;

TEST_F(LogDaemonUtest, JustStartAProcessFileIsNull)
{
    const char* file = NULL;
    EXPECT_EQ(LOG_INVALID_PARAM, JustStartAProcess(file));
    GlobalMockObject::reset();
}

TEST_F(LogDaemonUtest, JustStartAProcessMmopen2)
{
    g_lockFd = -1;
    const char* file = "a.txt";
    MOCKER(ToolOpenWithMode)
         .stubs()
         .will(returnValue(-1));
    EXPECT_EQ(LOG_INVALID_DATA, JustStartAProcess(file));
    GlobalMockObject::reset();
}

TEST_F(LogDaemonUtest, JustStartAProcessLockReg)
{
    g_lockFd = 0;
    const char* file = "a.txt";
    MOCKER(ToolOpenWithMode)
        .stubs()
        .will(returnValue(0));
    MOCKER(LockReg).stubs().will(returnValue(-1));
    MOCKER(ToolGetErrorCode).stubs().will(returnValue(EAGAIN)).then(returnValue(EAGAIN + 1));
    EXPECT_EQ((int)LOG_PROCESS_REPEAT, JustStartAProcess(file));
    GlobalMockObject::reset();
}

TEST_F(LogDaemonUtest, JustStartAProcessMmFtruncate)
{
    g_lockFd = 0;
    const char* file = "a.txt";
    MOCKER(ToolOpenWithMode)
        .stubs()
        .will(returnValue(0));
    MOCKER(LockReg)
        .stubs()
        .will(returnValue(0));
    MOCKER(ftruncate)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ((int)LOG_INVALID_DATA, JustStartAProcess(file));
    GlobalMockObject::reset();
}

TEST_F(LogDaemonUtest, JustStartAProcessMmWriteFailed)
{
    g_lockFd = 0;
    const char* file = "a.txt";
    MOCKER(ToolOpenWithMode)
        .stubs()
        .will(returnValue(0));
    MOCKER(LockReg)
        .stubs()
        .will(returnValue(0));
    MOCKER(ftruncate)
        .stubs()
        .will(returnValue(0));
    MOCKER(ToolWrite)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ((int)LOG_INVALID_DATA, JustStartAProcess(file));
    GlobalMockObject::reset();
}

TEST_F(LogDaemonUtest, JustStartAProcessMmWriteSuccess)
{
    g_lockFd = 0;
    const char* file = "a.txt";
    MOCKER(ToolOpenWithMode)
        .stubs()
        .will(returnValue(0));
    MOCKER(LockReg)
        .stubs()
        .will(returnValue(0));
    MOCKER(ftruncate)
        .stubs()
        .will(returnValue(0));
    MOCKER(ToolGetPid)
        .stubs()
        .will(returnValue(1234));
    MOCKER(ToolWrite)
        .stubs()
        .will(returnValue(5));
    EXPECT_EQ((int)LOG_SUCCESS, JustStartAProcess(file));
    GlobalMockObject::reset();
}

TEST_F(LogDaemonUtest, MainInit)
{
    int argc = 1;
    const char **argv = NULL;
    MOCKER(JustStartAProcess)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(SYS_OK, MainInit(argc, argv));
    GlobalMockObject::reset();
}
