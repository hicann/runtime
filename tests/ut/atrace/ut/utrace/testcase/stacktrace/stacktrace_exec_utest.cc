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

#include <fstream>
#include <signal.h>
#include <string>
#include "stacktrace_exec.h"
#include "stacktrace_safe_recorder.h"
#include "stacktrace_err_code.h"
#include "scd_process.h"
#include "stacktrace_logger.h"
#include "stacktrace_ut_common.h"

extern "C" {
int32_t ScExecEntry(void* args);
}

static void CheckFileContains(const char* filePath, const char* content)
{
    std::ifstream file(filePath);
    ASSERT_TRUE(file.is_open());
    std::string log((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    EXPECT_NE(std::string::npos, log.find(content)) << "missing log content: " << content << ", file: " << filePath;
}

static void SetLogPath(const char* name) { StacktraceLogSetPathSuffix(LLT_TEST_DIR, name, ".log"); }

static void SaveAndCheckLogContains(const char* name, const char* content)
{
    StackcoreLogSave();
    const std::string path = std::string(LLT_TEST_DIR) + "/" + name + ".log";
    CheckFileContains(path.c_str(), content);
}

static int32_t g_sigprocmask_checked = 0;
static int sigprocmask_unblock_stub(int how, const sigset_t* set, sigset_t* oldset)
{
    (void)oldset;
    g_sigprocmask_checked++;
    EXPECT_EQ(SIG_UNBLOCK, how);
    EXPECT_NE(nullptr, set);
    if (set == nullptr) {
        return -1;
    }
    EXPECT_EQ(1, sigismember(set, SIGSEGV));
    EXPECT_EQ(1, sigismember(set, SIG_ATRACE));
    return 0;
}

class TraceExecUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        g_sigprocmask_checked = 0;
        SetupTraceUtestEnv();
    }

    virtual void TearDown()
    {
        TraceExit();
        GlobalMockObject::verify();
        g_sigprocmask_checked = 0;
        system("rm -rf " LLT_TEST_DIR);
    }

    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    void EXPECT_CheckArgs(int32_t pid, int32_t tid, int32_t signo);
};

TEST_F(TraceExecUtest, TestStacktraceExec)
{
    // test SIGINT
    raise(SIGINT); // call signal + fork + execv

    // test SIG_ATRACE
    sigval_t value;
    value.sival_int = 0xAABB0003U;
    int32_t ret = sigqueue(getpid(), SIG_ATRACE, value);
    EXPECT_EQ(0, ret);
}

TEST_F(TraceExecUtest, TestScExecSetArgs)
{
    ThreadArgument args = {0};
    int32_t ret = 0;

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_SET_ARG, ret);
    GlobalMockObject::verify();

    MOCKER(memcpy_s).stubs().will(returnValue(0)).then(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_SET_ARG, ret);
    GlobalMockObject::verify();

    MOCKER(strcpy_s).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_SET_ARG, ret);
    GlobalMockObject::verify();

    MOCKER(strcpy_s).stubs().will(returnValue(0)).then(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_SET_ARG, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceExecUtest, TestScExecEntry)
{
    ThreadArgument args = {0};
    int32_t ret = 0;
    auto mocker_fcntl = reinterpret_cast<int (*)(int, int)>(fcntl);

    ret = ScExecEntry(NULL);
    EXPECT_EQ(1, ret);

    MOCKER(sigprocmask).stubs().will(invoke(sigprocmask_unblock_stub));
    MOCKER(pipe2).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_PIPE2, ret);
    GlobalMockObject::verify();

    MOCKER(mocker_fcntl).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_FCNTL, ret);
    GlobalMockObject::verify();

    MOCKER(dup2).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_DUP2, ret);
    GlobalMockObject::verify();

    MOCKER(writev).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_WRITEV, ret);
    GlobalMockObject::verify();

    // handle type is SCD_DUMP_THREADS_BIN
    args.siginfo.si_value.sival_int = 0xAABB0003U;
    args.signo = SIG_ATRACE;
    MOCKER(writev).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_WRITEV, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceExecUtest, TestScExecEntrySyscallFailedLog)
{
    ThreadArgument args = {0};
    int32_t ret = 0;
    auto mocker_fcntl = reinterpret_cast<int (*)(int, int)>(fcntl);

    MOCKER(sigprocmask).stubs().will(invoke(sigprocmask_unblock_stub));
    SetLogPath("test_exec_entry_pipe2_failed");
    MOCKER(pipe2).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_PIPE2, ret);
    SaveAndCheckLogContains("test_exec_entry_pipe2_failed", "create args pipe failed");
    GlobalMockObject::verify();

    SetLogPath("test_exec_entry_fcntl_failed");
    MOCKER(mocker_fcntl).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_FCNTL, ret);
    SaveAndCheckLogContains("test_exec_entry_fcntl_failed", "set args pipe size failed");
    GlobalMockObject::verify();

    SetLogPath("test_exec_entry_writev_failed");
    MOCKER(writev).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_WRITEV, ret);
    SaveAndCheckLogContains("test_exec_entry_writev_failed", "write args to pipe failed");
    GlobalMockObject::verify();

    SetLogPath("test_exec_entry_dup2_failed");
    MOCKER(dup2).stubs().will(returnValue(-1));
    ret = ScExecEntry((void*)&args);
    EXPECT_EQ(SCD_ERR_CODE_DUP2, ret);
    SaveAndCheckLogContains("test_exec_entry_dup2_failed", "dup2 stdin failed");
    GlobalMockObject::verify();
}

TEST_F(TraceExecUtest, TestScExecEntryUnblocksSignalsBeforeExec)
{
    ThreadArgument args = {0};

    MOCKER(sigprocmask).stubs().will(invoke(sigprocmask_unblock_stub));
    MOCKER(pipe2).stubs().will(returnValue(-1));
    EXPECT_EQ(SCD_ERR_CODE_PIPE2, ScExecEntry((void*)&args));
    EXPECT_EQ(1, g_sigprocmask_checked);
    GlobalMockObject::verify();
}

TEST_F(TraceExecUtest, TestScExecEntryUnblockSignalsFailure)
{
    ThreadArgument args = {0};

    SetLogPath("test_exec_entry_sigemptyset_failed");
    MOCKER(sigemptyset).stubs().will(returnValue(-1));
    EXPECT_EQ(SCD_ERR_CODE_SIGMASK, ScExecEntry((void*)&args));
    SaveAndCheckLogContains("test_exec_entry_sigemptyset_failed", "empty signal mask failed");
    GlobalMockObject::verify();

    SetLogPath("test_exec_entry_sigaddset_failed");
    MOCKER(sigaddset).stubs().will(returnValue(-1));
    EXPECT_EQ(SCD_ERR_CODE_SIGMASK, ScExecEntry((void*)&args));
    SaveAndCheckLogContains("test_exec_entry_sigaddset_failed", "add signal");
    GlobalMockObject::verify();

    SetLogPath("test_exec_entry_sigprocmask_failed");
    MOCKER(sigprocmask).stubs().will(returnValue(-1));
    EXPECT_EQ(SCD_ERR_CODE_SIGMASK, ScExecEntry((void*)&args));
    SaveAndCheckLogContains("test_exec_entry_sigprocmask_failed", "unblock stacktrace signals failed");
    GlobalMockObject::verify();
}

TEST_F(TraceExecUtest, TestScExecStart)
{
    ThreadArgument args = {0};
    int32_t child = -1;
    void* stack = malloc(1024);
    EXPECT_NE(nullptr, stack);
    TraStatus ret = TRACE_FAILURE;

    ret = ScExecStart(NULL, &args, &child);
    EXPECT_EQ(TRACE_FAILURE, ret);

    auto mocker_prctl = reinterpret_cast<int (*)(int)>(prctl);
    MOCKER(mocker_prctl).stubs().will(returnValue(-1));
    ret = ScExecStart(stack, &args, &child);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    auto mocker_clone = reinterpret_cast<int (*)(int)>(clone);
    MOCKER(mocker_clone).stubs().will(returnValue(-1));
    ret = ScExecStart(stack, &args, &child);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(mocker_prctl).stubs().will(returnValue(0)).then(returnValue(-1));
    MOCKER(mocker_clone).stubs().will(returnValue(123));
    ret = ScExecStart(stack, &args, &child);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    MOCKER(mocker_prctl).stubs().will(returnValue(0));
    MOCKER(mocker_clone).stubs().will(returnValue(123));
    MOCKER(TraceSafeMkdirPath).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScExecStart(stack, &args, &child);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    free(stack);
    stack = NULL;
}

TEST_F(TraceExecUtest, TestScExecStartSyscallFailedLog)
{
    ThreadArgument args = {0};
    args.signo = SIG_ATRACE;
    int32_t child = -1;
    void* stack = malloc(1024);
    ASSERT_NE(nullptr, stack);
    TraStatus ret = TRACE_FAILURE;
    auto mocker_prctl = reinterpret_cast<int (*)(int)>(prctl);
    auto mocker_clone = reinterpret_cast<int (*)(int)>(clone);

    SetLogPath("test_exec_start_prctl_failed");
    MOCKER(mocker_prctl).stubs().will(returnValue(-1));
    ret = ScExecStart(stack, &args, &child);
    EXPECT_EQ(TRACE_FAILURE, ret);
    SaveAndCheckLogContains("test_exec_start_prctl_failed", "set dumpable failed");
    GlobalMockObject::verify();

    SetLogPath("test_exec_start_clone_failed");
    MOCKER(mocker_prctl).stubs().will(returnValue(0));
    MOCKER(mocker_clone).stubs().will(returnValue(-1));
    ret = ScExecStart(stack, &args, &child);
    EXPECT_EQ(TRACE_FAILURE, ret);
    SaveAndCheckLogContains("test_exec_start_clone_failed", "clone failed");
    GlobalMockObject::verify();

    SetLogPath("test_exec_start_ptracer_failed");
    MOCKER(mocker_prctl).stubs().will(returnValue(0)).then(returnValue(-1));
    MOCKER(mocker_clone).stubs().will(returnValue(123));
    ret = ScExecStart(stack, &args, &child);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    SaveAndCheckLogContains("test_exec_start_ptracer_failed", "set ptracer failed");
    GlobalMockObject::verify();

    SetLogPath("test_exec_start_mkdir_failed");
    MOCKER(mocker_prctl).stubs().will(returnValue(0));
    MOCKER(mocker_clone).stubs().will(returnValue(123));
    MOCKER(TraceSafeMkdirPath).stubs().will(returnValue(TRACE_FAILURE));
    ret = ScExecStart(stack, &args, &child);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    SaveAndCheckLogContains("test_exec_start_mkdir_failed", "mkdir path failed");
    GlobalMockObject::verify();

    free(stack);
}

static int32_t g_waitpid_status = 0;
static void waitpid_set(int32_t status) { g_waitpid_status = status; }

static pid_t waitpid_stub(pid_t pid, int* wstatus, int options)
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

static void CheckScExecEndFailure(pid_t child, int32_t status, const char* logName, const char* expectedLog)
{
    SetLogPath(logName);
    waitpid_set(status);
    EXPECT_EQ(TRACE_FAILURE, ScExecEnd(child));
    SaveAndCheckLogContains(logName, expectedLog);
}

TEST_F(TraceExecUtest, TestScExecEnd)
{
    TraStatus ret = TRACE_FAILURE;
    pid_t child = 123;

    MOCKER(waitpid).stubs().will(returnValue(0));
    ret = ScExecEnd(child);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();

    // waitpid return -1
    child = -1;
    MOCKER(waitpid).stubs().will(invoke(waitpid_stub));
    CheckScExecEndFailure(child, 0, "test_exec_end_waitpid_failed", "waitpid failed");

    child = 123;
    // child terminated normally with non-zero exit status(1)
    CheckScExecEndFailure(
        child, 0x0100, "test_exec_end_nonzero_failed", "child 123 exited normally with non-zero exit status(1)");

    // child execlp failed, expect explicit error log instead of only exit code.
    CheckScExecEndFailure(
        child, SCD_ERR_CODE_EXECLP << 8, "test_exec_end_execlp_failed", "execlp stacktrace dumper process failed");

    struct ExitLogCase {
        int32_t errCode;
        const char* logName;
        const char* expectedLog;
    };
    const ExitLogCase exitLogCases[] = {
        {SCD_ERR_CODE_PIPE2, "test_exec_end_pipe2_failed", "create args pipe failed"},
        {SCD_ERR_CODE_FCNTL, "test_exec_end_fcntl_failed", "set args pipe size failed"},
        {SCD_ERR_CODE_WRITEV, "test_exec_end_writev_failed", "write args to pipe failed"},
        {SCD_ERR_CODE_DUP2, "test_exec_end_dup2_failed", "dup2 stdin failed"},
        {SCD_ERR_CODE_SIGMASK, "test_exec_end_sigmask_failed", "unblock stacktrace signals failed"},
    };
    for (const auto& item : exitLogCases) {
        CheckScExecEndFailure(child, item.errCode << 8, item.logName, item.expectedLog);
    }

    // child terminated by a signal(3)
    CheckScExecEndFailure(child, 0x0083, "test_exec_end_signal_failed", "sub process exited by signal, signal(3)");

    // child terminated with other error status(255)
    CheckScExecEndFailure(child, 0x00FF, "test_exec_end_unknown_failed", "child 123 did not exit normally");
}
