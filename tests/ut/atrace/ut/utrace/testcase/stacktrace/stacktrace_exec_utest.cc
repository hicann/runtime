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

#include <pwd.h>
#include <signal.h>
#include "stacktrace_exec.h"
#include "stacktrace_safe_recorder.h"
#include "stacktrace_err_code.h"
#include "dumper_core.h"
#include "scd_process.h"

extern "C" {
    void TraceInit(void);
    void TraceExit(void);
    int32_t ScExecEntry(void *args);
}

void Mocker_Subprocess(void)
{
    // 通过mocker使st执行走到新的父进程框架
    MOCKER(ScdCoreStart).stubs().will(invoke(ScExecStart));
    MOCKER(ScdCoreEnd).stubs().will(invoke(ScExecEnd));
}

class TraceExecUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("mkdir -p " LLT_TEST_DIR );
        system("rm -rf " LLT_TEST_DIR "/*");
        struct passwd *pwd = getpwuid(getuid());
        pwd->pw_dir = LLT_TEST_DIR;
        MOCKER(getpwuid).stubs().will(returnValue(pwd));
        Mocker_Subprocess();
        TraceInit();
    }

    virtual void TearDown()
    {
        TraceExit();
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

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
    ret = ScExecEntry((void * )&args);
    EXPECT_EQ(SCD_ERR_CODE_SET_ARG, ret);
    GlobalMockObject::verify();

    MOCKER(memcpy_s).stubs().will(returnValue(0))
        .then(returnValue(-1));
    ret = ScExecEntry((void * )&args);
    EXPECT_EQ(SCD_ERR_CODE_SET_ARG, ret);
    GlobalMockObject::verify();

    MOCKER(strcpy_s).stubs().will(returnValue(-1));
    ret = ScExecEntry((void * )&args);
    EXPECT_EQ(SCD_ERR_CODE_SET_ARG, ret);
    GlobalMockObject::verify();

    MOCKER(strcpy_s).stubs().will(returnValue(0))
        .then(returnValue(-1));
    ret = ScExecEntry((void * )&args);
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

    MOCKER(pipe2).stubs().will(returnValue(-1));
    ret = ScExecEntry((void * )&args);
    EXPECT_EQ(SCD_ERR_CODE_PIPE2, ret);
    GlobalMockObject::verify();

    MOCKER(mocker_fcntl).stubs().will(returnValue(-1));
    ret = ScExecEntry((void * )&args);
    EXPECT_EQ(SCD_ERR_CODE_FCNTL, ret);
    GlobalMockObject::verify();

    MOCKER(dup2).stubs().will(returnValue(-1));
    ret = ScExecEntry((void * )&args);
    EXPECT_EQ(SCD_ERR_CODE_DUP2, ret);
    GlobalMockObject::verify();

    MOCKER(writev).stubs().will(returnValue(-1));
    ret = ScExecEntry((void * )&args);
    EXPECT_EQ(SCD_ERR_CODE_WRITEV, ret);
    GlobalMockObject::verify();

    // handle type is SCD_DUMP_THREADS_BIN
    args.siginfo.si_value.sival_int = 0xAABB0003U;
    args.signo = SIG_ATRACE;
    MOCKER(writev).stubs().will(returnValue(-1));
    ret = ScExecEntry((void * )&args);
    EXPECT_EQ(SCD_ERR_CODE_WRITEV, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceExecUtest, TestScExecStart)
{
    ThreadArgument args = {0};
    int32_t child = -1;
    void *stack = malloc(1024);
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

    MOCKER(mocker_prctl).stubs().will(returnValue(0))
        .then(returnValue(-1));
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
    ret = ScExecEnd(child);
    EXPECT_EQ(TRACE_FAILURE, ret);

    child = 123;
    // child terminated normally with non-zero exit status(1)
    waitpid_set(0x0100);
    ret = ScExecEnd(child);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // child terminated by a signal(3)
    waitpid_set(0x0083);
    ret = ScExecEnd(child);
    EXPECT_EQ(TRACE_FAILURE, ret);

    // child terminated with other error status(255)
    waitpid_set(0x00FF);
    ret = ScExecEnd(child);
    EXPECT_EQ(TRACE_FAILURE, ret);
}
