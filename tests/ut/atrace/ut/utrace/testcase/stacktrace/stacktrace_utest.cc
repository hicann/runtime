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
#include <errno.h>
#include <pthread.h>
#include <signal.h>
#include <sys/ptrace.h>
#include <sys/prctl.h>
#include <sys/wait.h>
#include "dumper_core.h"
#include "tracer_core.h"
#include "adiag_utils.h"
#include "stacktrace_dumper.h"
#include "stacktrace_signal.h"
#include "stacktrace_fp.h"
#include "stacktrace_unwind.h"
#include "stacktrace_safe_recorder.h"
#include "trace_recorder.h"
#include "dumper_process.h"
#include "trace_system_api.h"
#include "ascend_hal_stub.h"
#include "slog_stub.h"

extern "C" {
    void TraceInit(void);
    void TraceExit(void);
    TraStatus TraceGetSelfMap(uintptr_t pc, char *data, uint32_t len);
    void TraceSignalHandler(int32_t signo, siginfo_t *siginfo, void *ucontext);
    int32_t ScdCoreEntry(void *args);
    bool TraceCheckRegister(uintptr_t rbp, uintptr_t rsp);
    TraStatus TraceSafeWrite(int32_t fd, const char *data, size_t len);
    TraStatus DumperSignalHandler(const TraceSignalInfo *arg);
    uintptr_t TraceGetStackBaseAddr(void);
    TraStatus TraceSafeWriteMemoryInfo(int32_t fd);
    TraStatus TraceSafeWriteStatusInfo(int32_t fd, int32_t pid);
    TraStatus TraceSafeWriteLimitsInfo(int32_t fd, int32_t pid);
    TraStatus TraceSafeWriteMapsInfo(int32_t fd, int32_t pid);
    TraStatus TraceSaveProcessTask(int32_t pid);
}

extern TraceStackInfo g_stackInfo;
static void CheckStackLayer(int32_t exceptLayer)
{
    EXPECT_EQ(exceptLayer, g_stackInfo.layer);
}
class TraceStackcoreUtest: public testing::Test {
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
        system("rm -rf " LLT_TEST_DIR "/*");
        GlobalMockObject::verify();
        TraceExit();
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};

TEST_F(TraceStackcoreUtest, TraceStackInfoInit_failed)
{
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    MOCKER(pthread_getattr_np).stubs().will(returnValue(-1));
    TraceExit();
    TraceInit();
    auto ret = TraceGetStackBaseAddr();
    EXPECT_EQ(0, ret);
}

TEST_F(TraceStackcoreUtest, TestTraceStackFp_failed)
{
    TraStatus ret = TRACE_FAILURE;
    ThreadArgument arg = { 0 };
    TraceStackInfo info = { 0 };
    uintptr_t regs[TRACE_CORE_REG_NUM] = { 0 };

    // arg==NULL
    ret = TraceStackFp(NULL, regs, TRACE_CORE_REG_NUM, &info);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    // stackInfo==NULL
    ret = TraceStackFp(&arg, regs, TRACE_CORE_REG_NUM, NULL);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    // regs==NULL
    ret = TraceStackFp(&arg, NULL, TRACE_CORE_REG_NUM, &info);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);
}

TEST_F(TraceStackcoreUtest, TraceSignal_NullMyact)
{
    ThreadArgument arg = { 0 };
    auto ret = TraceStackSigHandler(&arg);
    EXPECT_EQ(TRACE_SUCCESS, ret); // execute success and no core dump occurs.
}
 
TEST_F(TraceStackcoreUtest, TestTraceStackSigHandler)
{
    siginfo_t siginfo;
    ucontext_t ucontext;
    TraceSignalInfo info = { 2, &siginfo, (void *)&ucontext, std::time(0) };

    MOCKER(ScdCoreStart).stubs().will(returnValue(TRACE_FAILURE));
    MOCKER(TraceStackSigHandler).expects(once()).will(returnValue(TRACE_SUCCESS));
    auto ret = DumperSignalHandler(&info);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSignalCheckExit).stubs().will(returnValue(true));
    ret = DumperSignalHandler(&info);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestDumperSignalSetArgs)
{
    siginfo_t siginfo;
    ucontext_t ucontext;
    TraceSignalInfo info = { 2, &siginfo, (void *)&ucontext, std::time(0) };

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    auto ret = DumperSignalHandler(&info);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(memcpy_s).stubs().will(returnValue(0)).then(returnValue(-1));
    ret = DumperSignalHandler(&info);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeGetDirPath).stubs().will(returnValue(TRACE_FAILURE));
    ret = DumperSignalHandler(&info);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeGetFileName).stubs().will(returnValue(TRACE_FAILURE));
    ret = DumperSignalHandler(&info);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSignal_WriteInfoFailed)
{
    ThreadArgument info = { 0 };
    int32_t ret = 0;

    ret = ScdCoreEntry(NULL);
    EXPECT_EQ(1, ret);

    // ptrace attach failed
    ret = ScdCoreEntry((void *)&info);
    EXPECT_EQ(1, ret);
}

TEST_F(TraceStackcoreUtest, TestSignal_TracerExit)
{
    TracerExit(); // TracerExit before receive signal
    siginfo_t siginfo;
    ucontext_t ucontext;
    TraceSignalInfo info = { 2, &siginfo, (void *)&ucontext, std::time(0) };

    MOCKER(TraceRecorderWrite).expects(never());
    MOCKER(ScdCoreStart).stubs().will(returnValue(TRACE_FAILURE));
    auto ret = DumperSignalHandler(&info);
    EXPECT_EQ(TRACE_SUCCESS, ret); // execute success and no core dump occurs.
}

TEST_F(TraceStackcoreUtest, TestDumpSetCallback_Null)
{
    auto ret = TraceDumperSetCallback(NULL, NULL);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);
}

static int32_t g_waitpid_status = 0;
static void waitpid_set(int32_t status)
{
    g_waitpid_status = status;
}

static pid_t waitpid_stub(pid_t pid, int *wstatus, int options)
{
    if (pid == -1) {
        errno = 0;
        return -1;
    }
    if (pid > 0) {
        errno = 0;
        *wstatus = g_waitpid_status;
        return 0;
    }
    return 0;
}

TEST_F(TraceStackcoreUtest, TestWaitpid_Timeout)
{
    TraStatus ret = TRACE_FAILURE;
    pid_t child = 123;
    MOCKER(waitpid).stubs().will(returnValue(0));
 
    ret = ScdCoreEnd(child);
    EXPECT_EQ(TRACE_SUCCESS, ret);
}
 
TEST_F(TraceStackcoreUtest, TestWaitpid_Failed)
{
    TraStatus ret = TRACE_FAILURE;
    pid_t child = -1;
    MOCKER(waitpid).stubs().will(invoke(waitpid_stub));

    ret = ScdCoreEnd(child);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceStackcoreUtest, TestScdCoreEnd_Failed)
{
    TraStatus ret = TRACE_FAILURE;
    pid_t child = 123;
    MOCKER(waitpid).stubs().will(invoke(waitpid_stub));

    // child terminated normally with non-zero exit status(1)
    waitpid_set(0x0100);
    ret = ScdCoreEnd(child);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // child terminated by a signal(3)
    waitpid_set(0x0083);
    ret = ScdCoreEnd(child);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // child terminated with other error status(255)
    waitpid_set(0x00FF);
    ret = ScdCoreEnd(child);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceStackcoreUtest, TestScdCoreStart_Failed)
{
    auto ret = ScdCoreStart(NULL, NULL, NULL);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceStackcoreUtest, TestTraceDumperInit_Failed)
{
    auto ret = TraceDumperInit();
    EXPECT_EQ(TRACE_SUCCESS, ret);

    // malloc failed
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)0));
    TraceDumperExit();
    ret = TraceDumperInit();
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceStackcoreUtest, TestTraceStackSigHandler_Failed)
{
    ThreadArgument arg = { 0 };
    arg.stackBaseAddr = TraceGetStackBaseAddr();
    TraStatus ret = TRACE_FAILURE;
 
    // invalid register
    MOCKER(TraceCheckRegister).stubs().will(returnValue(false));
    ret = TraceStackSigHandler(&arg);
    CheckStackLayer(-1);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
 
    // copy pc frame
    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    MOCKER(TraceSafeGetFd).stubs().will(returnValue(TRACE_FAILURE));
    ret = TraceStackSigHandler(&arg);
    CheckStackLayer(-1);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
 
    // copy stack frame
    MOCKER(memcpy_s).stubs().will(returnValue(0))
                            .then(returnValue(-1));
    MOCKER(TraceSafeGetFd).stubs().will(returnValue(TRACE_FAILURE));
    ret = TraceStackSigHandler(&arg);
    CheckStackLayer(0);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

// sub process coredump
TEST_F(TraceStackcoreUtest, TestSignal_CheckPid)
{
    int32_t parent = 123;
    int32_t child = 134;
    MOCKER(getpid).stubs().will(returnValue(parent)).then(returnValue(parent)).then(returnValue(child));
    MOCKER(ScdCoreStart).stubs().will(returnValue(TRACE_FAILURE));

    siginfo_t siginfo;
    ucontext_t ucontext;
    TraceSignalInfo info = { 11, &siginfo, (void *)&ucontext, std::time(0) };
    auto ret = DumperSignalHandler(&info);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = DumperSignalHandler(&info);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

// safe recorder
static ssize_t read_stub(int fd, void *buf, size_t count)
{
    static int32_t cnt = 0;
    cnt++;
    if (cnt <= 1) {
        errno = EINTR;
        return -1;
    } else if (cnt == 2) {
        errno = 0;
        return -1;
    }

    errno = 0;
    return 0;
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeReadLine)
{
    int32_t fd = 1;
    char msg[512] = {0};
    uint32_t len = 512;
    ssize_t ret = 0;

    ret = TraceSafeReadLine(fd, NULL, 0);
    EXPECT_EQ(-1, ret);

    MOCKER(read).stubs().will(invoke(read_stub));
    ret = TraceSafeReadLine(fd, msg, len);
    EXPECT_EQ(-1, ret);

    ret = TraceSafeReadLine(fd, msg, len);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeGetFd)
{
    uint64_t crashTime = std::time(0);
    int32_t signo = 2;
    int32_t pid = getpid();
    int32_t tid = gettid();
    TraceStackRecorderInfo info = { crashTime, signo, pid, tid };
    int32_t fd = 1;
    TraStatus ret = TRACE_FAILURE;

    ret = TraceSafeGetFd(NULL, ".txt", &fd);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    MOCKER(TimestampToFileStr).stubs().will(returnValue(TRACE_FAILURE));
    ret = TraceSafeGetFd(&info, ".txt", &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TimestampToFileStr).stubs().will(returnValue(TRACE_SUCCESS))
                                      .then(returnValue(TRACE_FAILURE));
    ret = TraceSafeGetFd(&info, ".txt", &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

static ssize_t write_stub(int fd, void const*buf, size_t count)
{
    static int32_t cnt = 0;
    cnt++;
    if (cnt <= 1) {
        errno = EINTR;
        return -1;
    } else if (cnt == 2) {
        errno = 0;
        return -1;
    }

    errno = 0;
    return count;
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeWriteSystemInfo)
{
    int32_t fd = 1;
    TraStatus ret = TRACE_FAILURE;
    int32_t pid = getpid();

    ret = TraceSafeWriteSystemInfo(-1, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    MOCKER(write).stubs().will(invoke(write_stub));
    ret = TraceSafeWriteSystemInfo(fd, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeWrite).stubs().will(returnValue(TRACE_SUCCESS))
                                  .then(returnValue(TRACE_FAILURE));
    ret = TraceSafeWriteSystemInfo(fd, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeWriteStackInfo)
{
    std::array<const char*, 3> strings = {
        "error log : invalid register\n",
        "#0 0x00007f4f17af9db5 0x00007f4f17ab8000 /home/libatrace_test.so\n",
        "#1 0x00007f4f17ea8609 0x00007f4f17ea0000 /usr/lib/x86_64-linux-gnu/libpthread-2.31.so\n"
    };
    int32_t fd = 1;
    TraStatus ret = TRACE_FAILURE;
    TraceStackInfo stackInfo = { 0 };
    TraStatus status = TRACE_FAILURE;

    ret = TraceSafeWriteStackInfo(fd, NULL);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    MOCKER(write).stubs().will(returnValue((ssize_t)-1));
    ret = TraceSafeWriteStackInfo(fd, &stackInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    stackInfo.layer = MAX_STACK_LAYER;
    ret = TraceSafeWriteStackInfo(fd, &stackInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);

    stackInfo.layer = -1;
    (void)memcpy_s(stackInfo.errLog, CORE_BUFFER_LEN, strings[0], strlen(strings[0]));
    ret = TraceSafeWriteStackInfo(fd, &stackInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);

    stackInfo.layer = 1;
    (void)memcpy_s(stackInfo.frame[0].info, CORE_BUFFER_LEN, strings[1], strlen(strings[1]));
    (void)memcpy_s(stackInfo.frame[1].info, CORE_BUFFER_LEN, strings[2], strlen(strings[2]));
    ret = TraceSafeWriteStackInfo(fd, &stackInfo);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    MOCKER(TraceSafeWrite).stubs().will(returnValue(TRACE_SUCCESS))
                                  .then(returnValue(status));
    ret = TraceSafeWriteStackInfo(fd, &stackInfo);
    EXPECT_EQ(status, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeWriteProcessInfo)
{
    int32_t fd = 1;
    TraStatus ret = TRACE_FAILURE;
    TraceStackProcessInfo processInfo = { 11, getpid(), gettid(), 139977600800512, 139977600798400 };
    TraStatus status = TRACE_FAILURE;

    ret = TraceSafeWriteProcessInfo(fd, NULL);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    MOCKER(TraceSafeWrite).stubs().will(returnValue(status));
    ret = TraceSafeWriteProcessInfo(fd, &processInfo);
    EXPECT_EQ(status, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeWrite).stubs().will(returnValue(TRACE_SUCCESS))
                                  .then(returnValue(status));
    ret = TraceSafeWriteProcessInfo(fd, &processInfo);
    EXPECT_EQ(status, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSaveStackInfo)
{
    int32_t fd = 1;
    TraStatus ret = TRACE_FAILURE;
    TraceStackInfo stackInfo = { 0 };
    TraStatus status = TRACE_FAILURE;

    ret = TraceSaveStackInfo(NULL);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    stackInfo.threadIdx = MAX_THREAD_NUM;
    ret = TraceSaveStackInfo(&stackInfo);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    stackInfo.threadIdx = 0;
    ret = TraceSaveStackInfo(&stackInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    stackInfo.layer = -1;
    ret = TraceSaveStackInfo(&stackInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);

    stackInfo.layer = MAX_STACK_LAYER;
    ret = TraceSaveStackInfo(&stackInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);

    stackInfo.layer = 1;
    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    ret = TraceSaveStackInfo(&stackInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSaveProcessReg)
{
    uintptr_t regs[TRACE_CORE_REG_NUM] = {0};
    TraStatus ret = TRACE_FAILURE;

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    ret = TraceSaveProcessReg(regs, sizeof(regs));
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeWriteMemoryInfo)
{
    TraStatus ret = TRACE_FAILURE;
    int32_t fd = 1;

    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    ret = TraceSafeWriteMemoryInfo(fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeWrite).stubs().will(returnValue(TRACE_SUCCESS))
                                  .then(returnValue(TRACE_FAILURE));
    ret = TraceSafeWriteMemoryInfo(fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeWriteStatusInfo)
{
    TraStatus ret = TRACE_FAILURE;
    int32_t fd = 1;
    int32_t pid = getpid();

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));// snprintf_s failed
    ret = TraceSafeWriteStatusInfo(fd, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    ret = TraceSafeWriteStatusInfo(fd, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeWrite).stubs().will(returnValue(TRACE_SUCCESS))
                                  .then(returnValue(TRACE_FAILURE));
    ret = TraceSafeWriteStatusInfo(fd, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeWriteLimitsInfo)
{
    TraStatus ret = TRACE_FAILURE;
    int32_t fd = 1;
    int32_t pid = getpid();

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));// snprintf_s failed
    ret = TraceSafeWriteLimitsInfo(fd, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    ret = TraceSafeWriteLimitsInfo(fd, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeWrite).stubs().will(returnValue(TRACE_SUCCESS))
                                  .then(returnValue(TRACE_FAILURE));
    ret = TraceSafeWriteLimitsInfo(fd, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeWriteMapsInfo)
{
    TraStatus ret = TRACE_FAILURE;
    int32_t fd = 1;
    int32_t pid = getpid();

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));// snprintf_s failed
    ret = TraceSafeWriteMapsInfo(fd, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    ret = TraceSafeWriteMapsInfo(fd, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeWrite).stubs().will(returnValue(TRACE_SUCCESS))
                                  .then(returnValue(TRACE_FAILURE));
    ret = TraceSafeWriteMapsInfo(fd, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSaveProcessTask)
{
    TraStatus ret = TRACE_FAILURE;
    int32_t pid = getpid();

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));// snprintf_s failed
    ret = TraceSaveProcessTask(pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    ret = TraceSaveProcessTask(pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceSafeReadLine).stubs().will(returnValue(-1));
    ret = TraceSaveProcessTask(pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeMkdirPath)
{
    uint64_t crashTime = std::time(0);
    int32_t signo = 2;
    int32_t pid = getpid();
    int32_t tid = gettid();
    TraceStackRecorderInfo info = { crashTime, signo, pid, tid };
    TraStatus ret = TRACE_FAILURE;
    char path[1024] = {0};

    EXPECT_EQ(TRACE_INVALID_PARAM, TraceSafeMkdirPath(NULL));

    MOCKER(TimestampToFileStr).stubs().will(returnValue(TRACE_FAILURE));
    ret = TraceSafeMkdirPath(&info);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    ret = TraceSafeMkdirPath(&info);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeGetDirPath)
{
    uint64_t crashTime = std::time(0);
    int32_t signo = 2;
    int32_t pid = getpid();
    int32_t tid = gettid();
    TraceStackRecorderInfo info = { crashTime, signo, pid, tid };
    TraStatus ret = TRACE_FAILURE;
    char path[1024] = {0};

    EXPECT_EQ(TRACE_INVALID_PARAM, TraceSafeGetDirPath(NULL, path, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceSafeGetDirPath(&info, NULL, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceSafeGetDirPath(&info, path, 0));

    MOCKER(TimestampToFileStr).stubs().will(returnValue(TRACE_FAILURE));
    ret = TraceSafeGetDirPath(&info, path, 1024);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestSafeRecorder_TraceSafeGetFileName)
{
    uint64_t crashTime = std::time(0);
    int32_t signo = 2;
    int32_t pid = getpid();
    int32_t tid = gettid();
    TraceStackRecorderInfo info = { crashTime, signo, pid, tid };
    TraStatus ret = TRACE_FAILURE;
    char name[1024] = {0};

    EXPECT_EQ(TRACE_INVALID_PARAM, TraceSafeGetFileName(NULL, name, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceSafeGetFileName(&info, NULL, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceSafeGetFileName(&info, name, 0));

    MOCKER(TimestampToFileStr).stubs().will(returnValue(TRACE_FAILURE));
    ret = TraceSafeGetFileName(&info, name, 1024);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TimestampToFileStr).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ret = TraceSafeGetFileName(&info, name, 1024);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceStackcoreUtest, TestCoredumpInSubProcess)
{
    int status = fork();
    if (status == -1) {
        return;
    }
    if (status == 0) {
        raise(SIGINT);
        exit(0);
    } else {
        int ret = 0;
        (void)wait(&ret);
        EXPECT_EQ(ret, 0);
        CheckStackLayer(0);
    }
}

TEST_F(TraceStackcoreUtest, TestTraceSignalInit)
{
    MOCKER(sigaction).stubs().will(returnValue(-1));
    TraStatus ret = TRACE_FAILURE;
    
    ret = TraceSignalInit();
    EXPECT_EQ(TRACE_FAILURE, ret);

    TraceSignalExit();
}

TEST_F(TraceStackcoreUtest, TestStackcoreLogSave)
{
    TraceExit();
    TraStatus ret = TRACE_FAILURE;
    ret = StacktraceLogInit("[test logcat]");
    EXPECT_EQ(TRACE_SUCCESS, ret);
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    StacktraceLogSetPath(LLT_TEST_DIR, "test_log");
    GlobalMockObject::verify();

    StacktraceLogSetPath(LLT_TEST_DIR, "test_log");
    StacktraceLogSetPath(LLT_TEST_DIR "../", "test_log");
    StacktraceLogSetPath(LLT_TEST_DIR , "../test_log");
    STACKTRACE_LOG_RUN("test log");
    StackcoreLogSave();
    StackcoreLogExit();
}

TEST_F(TraceStackcoreUtest, TestStackcoreLogSave_Failed)
{
    TraceExit();
    TraStatus ret = TRACE_FAILURE;
    
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));
    ret = StacktraceLogInit("[test logcat]");
    EXPECT_EQ(TRACE_FAILURE, ret);

    StacktraceLogSetPath(LLT_TEST_DIR, "test_log");
    STACKTRACE_LOG_RUN("test log");
    StackcoreLogSave();
    StackcoreLogExit();
}