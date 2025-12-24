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
#include "securec.h"
#include <pwd.h>
#include <time.h>
#include <signal.h>
#include <future>
#include <thread>
#include <setjmp.h>
#include <ucontext.h>
#include <unwind.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include "atrace_api.h"
#include "dumper_core.h"
#include "dumper_process.h"
#include "trace_system_api.h"
#include "stacktrace_unwind.h"
#include "adiag_utils.h"
#include "stacktrace_parse.h"
#include "stacktrace_safe_recorder.h"
#include "stacktrace_dumper.h"
#include "atrace_stackcore_api.h"

extern "C" {
    void TraceInit(void);
    void TraceExit(void);
    TraStatus ScdCoreDumpData(const ThreadArgument *args);
    int32_t ScdCoreEntry(void *args);
    uintptr_t TraceGetStackBaseAddr(void);
    int ScdWaitPid(pid_t pid, int *status, int flags);
    TraStatus TraceGetExePath(char *path, uint32_t len);
}

#define STACKTRACE_DUMP_MODE_1  0xAABB0001
#define STACKTRACE_DUMP_MODE_2  0xAABB0002
#define STACKTRACE_DUMP_MODE_3  0xAABB0003

static int32_t g_signalMode = 0;
static void SetSignalMode(int32_t mode)
{
    switch (mode) {
        case 1:
            g_signalMode = STACKTRACE_DUMP_MODE_1;
            break;
        case 2:
            g_signalMode = STACKTRACE_DUMP_MODE_2;
            break;
        case 3:
            g_signalMode = STACKTRACE_DUMP_MODE_3;
            break;
        default:
            g_signalMode = 0;
            break;
    }
}

static void TraceSignalHandlerStub(int32_t signo, siginfo_t *siginfo, void *ucontext)
{
    ThreadArgument info = { 0 };
    info.stackBaseAddr = TraceGetStackBaseAddr();
    info.pid = getpid();
    info.tid = gettid();
    info.signo = signo;
    siginfo->si_value.sival_int = g_signalMode;
    (void)memcpy_s(&(info.siginfo), sizeof(siginfo_t), siginfo, sizeof(siginfo_t));
    (void)memcpy_s(&(info.ucontext), sizeof(ucontext_t), ucontext, sizeof(ucontext_t));
    MOCKER(ScdProcessSuspendThreads).stubs();
    MOCKER(ScdProcessResumeThreads).stubs();
    EXPECT_EQ(ScdCoreDumpData(&info), TRACE_SUCCESS);
}

class DumperProcessUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("mkdir -p " LLT_TEST_DIR );
        system("rm -rf " LLT_TEST_DIR "/*");
        struct passwd *pwd = getpwuid(getuid());
        pwd->pw_dir = LLT_TEST_DIR;
        MOCKER(getpwuid).stubs().will(returnValue(pwd));
        TraceInit();
    }

    virtual void TearDown()
    {
        TraceExit();
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }
};


static bool g_exit = false;
static char g_getName[THREAD_NAME_LEN] = { 0 };
void *SetThreadName(void *arg)
{
    if (arg != NULL) {
        char *threadName = (char *)arg;
        prctl(PR_SET_NAME, threadName); // threadName不能超过16个字节,会被截断
    } else {
        prctl(PR_SET_NAME, "");
    }
    DumperThreadGetName(getpid(), gettid(), g_getName, THREAD_NAME_LEN);
    while (!g_exit) {
        sleep(1);
    }
    return NULL;
}

TEST_F(DumperProcessUtest, Test_MultiThread)
{
    struct sigaction sigAct; // the new action for signo
    sigAct.sa_sigaction = TraceSignalHandlerStub;
    sigAct.sa_flags = SA_SIGINFO;
    sigaction(SIGINT, &sigAct, NULL);

    g_exit = false;
    int32_t threadNum = 2;
    pthread_t theadId[threadNum] = { 0 };
    int32_t ret;

    for (int i = 0; i < threadNum; i++) {
        ret = pthread_create(&theadId[i], NULL, SetThreadName, NULL);
        EXPECT_EQ(0, ret);
    }

    sleep(1);
    raise(SIGINT);
    sleep(1);

    g_exit = true;
    for (int i = 0; i < threadNum; i++) {
        pthread_join(theadId[i], NULL);
    }
}

TEST_F(DumperProcessUtest, Test_ScdProcessLoadThreads)
{
    TraStatus ret = TRACE_FAILURE;
    pid_t pid = getpid();
    pid_t tid = gettid();

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));// snprintf_s failed
    ret = ScdProcessLoadAllThreads(pid, tid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    ret = ScdProcessLoadAllThreads(0, tid); // invalid pid, opendir failed
    EXPECT_EQ(TRACE_FAILURE, ret);

    MOCKER(AdiagStrToInt).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdProcessLoadAllThreads(pid, tid); // invalid pid, opendir failed
    EXPECT_EQ(TRACE_SUCCESS, ret);
}

TEST_F(DumperProcessUtest, Test_DumperThreadGetRegs)
{
    TraStatus ret = TRACE_FAILURE;
    pid_t pid = getpid();
    pid_t tid = gettid();
    uintptr_t regs[TRACE_CORE_REG_NUM + 1] = { 0 };

    ret = DumperThreadGetRegs(tid, NULL, 0); // null pointer
    EXPECT_EQ(TRACE_FAILURE, ret);

    ret = DumperThreadGetRegs(0, regs, TRACE_CORE_REG_NUM + 1); // invalid tid
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(DumperProcessUtest, Test_DumperThreadGetName)
{
    char threadName[THREAD_NAME_LEN] = { 0 };
    uint32_t nameLen = THREAD_NAME_LEN;
    pid_t pid = getpid();
    pid_t tid = gettid();

    DumperThreadGetName(pid, tid, threadName, 0);
    EXPECT_NE("unknown", threadName);
}

TEST_F(DumperProcessUtest, Test_PtraceInvalidTid)
{
    TraStatus ret = TRACE_FAILURE;
    pid_t tid = 0;

    ret = DumperThreadSuspend(tid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    DumperThreadResume(tid);
}

TEST_F(DumperProcessUtest, TestScdCoreDumpData_success)
{
    g_exit = false;
    int32_t threadNum = 10;
    pthread_t theadId[threadNum] = { 0 };
    int32_t ret;

    for (int i = 0; i < threadNum; i++) {
        ret = pthread_create(&theadId[i], NULL, SetThreadName, NULL);
        EXPECT_EQ(0, ret);
    }

    ThreadArgument info = { 0 };
    info.stackBaseAddr = TraceGetStackBaseAddr();
    info.pid = getpid();
    info.tid = gettid();


    pid_t child = fork();
    if (child == 0) {
        // 子进程
        sleep(1);
        MOCKER(TraceStackUnwind).stubs().will(returnValue(TRACE_SUCCESS));
        MOCKER(TraceSafeWriteStackInfo).stubs().will(returnValue(TRACE_SUCCESS));
        EXPECT_EQ(ScdCoreDumpData(&info), TRACE_SUCCESS);
        exit(0);
    }
    EXPECT_LT(0, child);
    int32_t err = prctl(PR_SET_PTRACER, child, 0, 0, 0);
    EXPECT_NE(-1, err);

    int32_t status = 0;
    do {
        errno = 0;
        err = waitpid(child, &status, __WALL);
    } while (err == -1 && errno == EINTR);

    g_exit = true;
    for (int i = 0; i < threadNum; i++) {
        pthread_join(theadId[i], NULL);
    }
}


TEST_F(DumperProcessUtest, TestScdCoreDumpData_failed)
{
    TraStatus ret = TRACE_FAILURE;
    ret = ScdProcessLoadAllThreads(getpid(), gettid());
    EXPECT_EQ(TRACE_SUCCESS, ret);
    ThreadArgument info = { 0 };
    info.stackBaseAddr = TraceGetStackBaseAddr();
    info.pid = getpid();
    info.tid = gettid();

    MOCKER(TraceOpen).stubs().will(returnValue(-1));
    ret = ScdProcessUnwindStack(&info);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(write).stubs().will(returnValue((ssize_t)-1));
    MOCKER(TraceStackUnwind).stubs().will(returnValue(TRACE_SUCCESS));
    ret = ScdProcessUnwindStack(&info);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    MOCKER(TraceStackUnwind).stubs().will(returnValue(TRACE_FAILURE));
    MOCKER(TraceStackFp).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScdProcessUnwindStack(&info);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeReadLine).stubs().will(returnValue(-1));
    MOCKER(TraceSafeWriteSystemInfo).stubs().will(returnValue(-1));
    ret = ScdProcessUnwindStack(&info);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
}

TEST_F(DumperProcessUtest, TestScdCoreEntry_failed)
{
    g_exit = false;
    int32_t threadNum = 2;
    pthread_t theadId[threadNum] = { 0 };
    int32_t ret;

    for (int i = 0; i < threadNum; i++) {
        ret = pthread_create(&theadId[i], NULL, SetThreadName, NULL);
        EXPECT_EQ(0, ret);
    }

    ThreadArgument info = { 0 };
    info.stackBaseAddr = TraceGetStackBaseAddr();
    info.pid = getpid();
    info.tid = gettid();

    pid_t child = fork();
    if (child == 0) {
        // 子进程
        sleep(1);
        MOCKER(ScdProcessUnwindStack).stubs().will(returnValue(TRACE_FAILURE));
        EXPECT_EQ(ScdCoreEntry((void *)&info), 1);
        exit(0);
    }
    EXPECT_LT(0, child);
    int32_t err = prctl(PR_SET_PTRACER, child, 0, 0, 0);
    EXPECT_NE(-1, err);

    int32_t status = 0;
    do {
        errno = 0;
        err = waitpid(child, &status, __WALL);
    } while (err == -1 && errno == EINTR);

    g_exit = true;
    for (int i = 0; i < threadNum; i++) {
        pthread_join(theadId[i], NULL);
    }
}

static void TestThreadName(const char *setName)
{
    g_exit = false;
    pthread_t thread = 0;
    pthread_create(&thread, NULL, SetThreadName, (void *)setName);

    // thread exit
    g_exit = true;
    pthread_join(thread, NULL);
}

TEST_F(DumperProcessUtest, TestGetThreadName)
{
    std::string strA;
    std::string strB;
    // thread name is less than THREAD_NAME_LEN(16)
    strA.assign(THREAD_NAME_LEN , 'A');
    strB.assign(THREAD_NAME_LEN -1 , 'A');
    TestThreadName(strA.c_str());
    EXPECT_STREQ(strB.c_str(), g_getName);

    TestThreadName(NULL); // // does not set thread name
    EXPECT_STREQ("unknown", g_getName);
}

TEST_F(DumperProcessUtest, TestGetThreadName_failed)
{
    pid_t pid = getpid();
    pid_t tid = 123;
    char getName[THREAD_NAME_LEN] = { 0 };
    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).expects(never());
    DumperThreadGetName(pid, tid, NULL, 0);
    GlobalMockObject::verify();

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    DumperThreadGetName(pid, tid, getName, THREAD_NAME_LEN);
    GlobalMockObject::verify();
    EXPECT_STREQ("unknown", getName);

    MOCKER(mocker).stubs().will(returnValue(-1));
    DumperThreadGetName(pid, tid, getName, THREAD_NAME_LEN);
    GlobalMockObject::verify();
    EXPECT_STREQ("unknown", getName);
}

pid_t WaitpidStubStopped(pid_t pid, int *wstatus, int options)
{
    printf("WaitpidStubStopped\n");
    *wstatus = 0x137F;
    // wait for thread stopped;
    usleep(1000);
    return 0;
}
pid_t WaitpidStubOtherSignal(pid_t pid, int *wstatus, int options)
{
    printf("WaitpidStubOtherSignal\n");
    *wstatus = 0x27F;
    return 0;
}
pid_t WaitpidStubFailed(pid_t pid, int *wstatus, int options)
{
    errno = 0;
    return -1;
}

pid_t WaitpidNotStopped(pid_t pid, int *wstatus, int options)
{
    *wstatus = 0xFF;
    // wait for thread stopped;
    usleep(1000);
    return 0;
}
TEST_F(DumperProcessUtest, TestScdThreadWaitTidStopped)
{
    MOCKER(ScdWaitPid)
        .stubs()
        .will(invoke(WaitpidStubFailed));
    EXPECT_EQ(DumperThreadWaitTidStopped(0), TRACE_FAILURE);
    GlobalMockObject::verify();

    MOCKER(ScdWaitPid)
        .stubs()
        .will(invoke(WaitpidNotStopped));
    EXPECT_EQ(DumperThreadWaitTidStopped(0), TRACE_FAILURE);
    GlobalMockObject::verify();

    MOCKER(ScdWaitPid)
        .stubs()
        .will(invoke(WaitpidStubOtherSignal))
        .then(invoke(WaitpidStubOtherSignal))
        .then(invoke(WaitpidStubStopped));
    EXPECT_EQ(DumperThreadWaitTidStopped(0), TRACE_SUCCESS);
    GlobalMockObject::verify();
}

TEST_F(DumperProcessUtest, TestTraceGetExePath)
{
    char path[MAX_BIN_PATH_LEN] = { 0 };
    TraStatus ret = TRACE_FAILURE;

    MOCKER(mmDladdr).stubs().will(returnValue(-1));
    ret = TraceGetExePath(path, MAX_BIN_PATH_LEN);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceRealPath).stubs().will(returnValue(-1));
    ret = TraceGetExePath(path, MAX_BIN_PATH_LEN);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    mmDlInfo dlInfo = {0};
    dlInfo.dli_fname = "libascend_trace.so";
    MOCKER(mmDladdr).stubs().with(any(), outBoundP(&dlInfo, sizeof(mmDlInfo))).will(returnValue(EN_OK));
    ret = TraceGetExePath(path, MAX_BIN_PATH_LEN);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    ret = TraceGetExePath(path, MAX_BIN_PATH_LEN);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceRealPath).stubs().will(returnValue(EOK))
        .then(returnValue(-1));
    ret = TraceGetExePath(path, MAX_BIN_PATH_LEN);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(strncpy_s).stubs().will(returnValue(EOK))
        .then(returnValue(-1));
    ret = TraceGetExePath(path, MAX_BIN_PATH_LEN);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(DumperProcessUtest, TestRealTime_Mode1)
{
    struct sigaction sigAct; // the new action for signo
    SetSignalMode(1);
    sigAct.sa_sigaction = TraceSignalHandlerStub;
    sigAct.sa_flags = SA_SIGINFO;
    sigaction(SIG_ATRACE, &sigAct, NULL);

    raise(SIG_ATRACE);
    const char* binFile = TraceSafeGetFilePath();
    std::string pathString(binFile);
    size_t pos = pathString.find(".bin");
    if (pos != std::string::npos) {
        pathString.replace(pos, 4, ".txt");
    }

    int32_t ret = access(pathString.c_str(), F_OK);
    EXPECT_EQ(0, ret);
}

TEST_F(DumperProcessUtest, TestRealTime_Mode2)
{
    struct sigaction sigAct; // the new action for signo
    SetSignalMode(2);
    sigAct.sa_sigaction = TraceSignalHandlerStub;
    sigAct.sa_flags = SA_SIGINFO;
    sigaction(SIG_ATRACE, &sigAct, NULL);

    raise(SIG_ATRACE);
    const char* binFile = TraceSafeGetFilePath();
    TraStatus ret = AtraceStackcoreParse(binFile, strlen(binFile));
    EXPECT_EQ(TRACE_SUCCESS, ret);
}

TEST_F(DumperProcessUtest, TestRealTime_Mode3)
{
    struct sigaction sigAct; // the new action for signo
    SetSignalMode(3);
    sigAct.sa_sigaction = TraceSignalHandlerStub;
    sigAct.sa_flags = SA_SIGINFO;
    sigaction(SIG_ATRACE, &sigAct, NULL);

    raise(SIG_ATRACE);

    // parse bin file
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));// snprintf_s failed
    const char* binFile = TraceSafeGetFilePath();
    TraStatus ret = AtraceStackcoreParse(binFile, strlen(binFile));
    EXPECT_EQ(TRACE_SUCCESS, ret);
}
