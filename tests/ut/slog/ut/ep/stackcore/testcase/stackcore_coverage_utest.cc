/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/**
 * @file  stackcore_coverage_utest.cc
 * @brief Coverage-focused unit tests for stackcore.c. Exercises the internal
 *        helpers (StackCoreName, StackOpen, StackReadLine, StackWriteData,
 *        StackClose, GetSelfMap, StackFrame, StackPcFrame, CreateStackCore,
 *        AnalysisContext, IsValidSubdir) plus error/edge paths of
 *        StackcoreSetSubdirectory and StackSigHandler that are not reached by
 *        the existing functional tests.
 */

#include "stackcore.h"
#include "securec.h"
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <errno.h>
#include <ucontext.h>
#include <sys/stat.h>
#include "stackcore_interface.h"
#include "stackcore_common.h"
#include "stackcore_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

/* Under LLT_TEST, STATIC is empty, so the file-static helpers below have
 * external linkage and can be invoked directly from the unit test. */
extern "C" {
    int IsValidSubdir(const char *subdir);
    int StackCoreName(char *name, unsigned int len, int signo);
    int StackOpen(const char *fileName);
    ssize_t StackReadLine(int fd, char *data, unsigned int len);
    ssize_t StackWriteData(int fd, const char *data, unsigned int len);
    int StackClose(int fd);
    void GetSelfMap(uintptr_t pc, char *data, unsigned int len);
    void StackPcFrame(int layer, uintptr_t pc, char *data, unsigned int len);
    ssize_t CreateStackCore(const uintptr_t nfp, uintptr_t pc, int signo);
    void AnalysisContext(const mcontext_t *mcontext, int signo);
    void StackUnInit(void);
    extern char g_filePath[STACK_PATH_MAX_LEN + 1U];
}

#define COV_SIGNO SIGABRT

/* FP_REGISTER/LR_REGISTER are defined privately inside stackcore.c; mirror
 * them here along with the per-arch mcontext member access (gregs on x86_64,
 * regs/pc on aarch64) so the test stays in sync with AnalysisContext(). */
#ifdef __x86_64__
#define COV_FP_REGISTER 15
#define COV_LR_REGISTER 16
#define COV_SET_FP(mc, val) ((mc)->gregs[COV_FP_REGISTER] = (val))
#define COV_SET_PC(mc, val) ((mc)->gregs[COV_LR_REGISTER] = (val))
#else
#define COV_FP_REGISTER 29
#define COV_SET_FP(mc, val) ((mc)->regs[COV_FP_REGISTER] = (val))
#define COV_SET_PC(mc, val) ((mc)->pc = (val))
#endif

/* Private limits mirrored from stackcore.c */
#define COV_MIN_NAME_LEN 256
#define COV_MAX_STACK_LAYER 19

class EP_STACKCORE_COV_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("mkdir -p " PATH_ROOT "/" SUBDIR);
        EXPECT_EQ(0, StackInit());
        EXPECT_EQ(0, StackcoreSetSubdirectory("")); // reset g_filePath to CORE_DEFAULT_PATH
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start cov test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End cov test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start cov test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End cov test suite");
    }
};

/* ── GetSelfMap (run first, before any libc/same-binary mocking in this
 * suite, so a libc r-xp mapping is still intact and the match branch is
 * exercised. Prior suites only PLT-hook `raise`, leaving libc r-xp; same-
 * binary `StackFrame` mocking flips the *binary* text to rwxp, so a libc
 * address is used for the match assertion.) ────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, GetSelfMap_InvalidAndSuccess)
{
    char buf[CORE_BUFFER_LEN] = {0};
    // null/zero len -> no crash
    GetSelfMap((uintptr_t)&open, NULL, sizeof(buf));
    GetSelfMap((uintptr_t)&open, buf, 0);

    // pc inside libc's r-xp segment -> match branch writes map info.
    GetSelfMap((uintptr_t)&open, buf, sizeof(buf));
    EXPECT_GT(strlen(buf), 0U);
}

TEST_F(EP_STACKCORE_COV_UTEST, GetSelfMap_PcOutOfRange)
{
    char buf[CORE_BUFFER_LEN] = {0};
    // pc not in any executable mapping -> loop exhausts, no crash
    GetSelfMap(0x1ULL, buf, sizeof(buf));
}

/* ── IsValidSubdir ─────────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, IsValidSubdir_ValidAndInvalid)
{
    EXPECT_EQ(0, IsValidSubdir("abc"));
    EXPECT_EQ(0, IsValidSubdir(""));
    EXPECT_EQ(-1, IsValidSubdir("a/b"));     // contains "/"
    EXPECT_EQ(-1, IsValidSubdir(".."));      // contains ".."
    EXPECT_EQ(-1, IsValidSubdir("a..b"));    // contains ".."
    EXPECT_EQ(-1, IsValidSubdir("../x"));    // contains "/" and ".."
}

/* ── StackcoreSetSubdirectory ──────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, SetSubdir_NullAndNonexistentAndTooLong)
{
    EXPECT_EQ(-1, StackcoreSetSubdirectory(NULL));
    // subdir that does not exist under CORE_DEFAULT_PATH -> realpath fails
    EXPECT_EQ(-1, StackcoreSetSubdirectory("no_such_subdir_xyz"));
    // too long subdir
    char tooLong[STACK_PATH_MAX_LEN + 8];
    (void)memset_s(tooLong, sizeof(tooLong), 'a', sizeof(tooLong) - 1U);
    tooLong[sizeof(tooLong) - 1U] = '\0';
    EXPECT_EQ(-1, StackcoreSetSubdirectory(tooLong));
    // invalid subdir with path separators
    EXPECT_EQ(-1, StackcoreSetSubdirectory("bad/dir"));
    EXPECT_EQ(0, StackcoreSetSubdirectory("")); // restore
}

TEST_F(EP_STACKCORE_COV_UTEST, SetSubdir_ValidSubdir)
{
    EXPECT_EQ(0, StackcoreSetSubdirectory(SUBDIR));
    EXPECT_EQ(0, StackcoreSetSubdirectory("")); // restore
}

/* ── StackCoreName ─────────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, StackCoreName_SuccessAndFail)
{
    char name[CORE_BUFFER_LEN] = {0};
    EXPECT_EQ(-1, StackCoreName(NULL, sizeof(name), COV_SIGNO));
    EXPECT_EQ(-1, StackCoreName(name, (unsigned int)(COV_MIN_NAME_LEN - 1), COV_SIGNO)); // len < MIN_NAME_LEN
    EXPECT_EQ(0, StackCoreName(name, sizeof(name), COV_SIGNO));
    // name should start with the default path and contain "stackcore."
    EXPECT_NE(nullptr, strstr(name, "stackcore."));
    EXPECT_EQ(0, strncmp(name, PATH_ROOT, strlen(PATH_ROOT)));
}

/* ── StackOpen ─────────────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, StackOpen_SuccessAndFail)
{
    EXPECT_EQ(-1, StackOpen(NULL));
    EXPECT_EQ(-1, StackOpen("../badpath")); // contains "../"
    char filePath[MAX_FILENAME_LEN] = {0};
    (void)snprintf_s(filePath, sizeof(filePath), sizeof(filePath) - 1U, "%s/stackopen_test.log", PATH_ROOT);
    int fd = StackOpen(filePath);
    EXPECT_GE(fd, 0);
    EXPECT_EQ(0, access(filePath, F_OK));
    EXPECT_EQ(0, StackClose(fd));
    // open in a nonexistent directory -> open() fails
    EXPECT_EQ(-1, StackOpen(PATH_ROOT "/no_such_dir/xyz.log"));
}

/* ── StackReadLine ─────────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, StackReadLine_NormalAndEof)
{
    char filePath[MAX_FILENAME_LEN] = {0};
    (void)snprintf_s(filePath, sizeof(filePath), sizeof(filePath) - 1U, "%s/readline_test.txt", PATH_ROOT);
    int fd = open(filePath, O_CREAT | O_RDWR, 0640);
    ASSERT_GE(fd, 0);
    ASSERT_EQ(11, write(fd, "hello\nworld", 11)); // line + trailing no-newline data
    lseek(fd, 0, SEEK_SET);

    // invalid params
    EXPECT_EQ(-1, StackReadLine(-1, nullptr, 16));
    EXPECT_EQ(-1, StackReadLine(fd, nullptr, 16));
    EXPECT_EQ(-1, StackReadLine(fd, nullptr, 0));

    char buf[CORE_BUFFER_LEN] = {0};
    // read "hello\n"
    ssize_t n = StackReadLine(fd, buf, sizeof(buf));
    EXPECT_EQ(6, n);
    EXPECT_EQ(0, strcmp(buf, "hello\n"));
    // read "world" until EOF (no newline) -> returns n-1
    (void)memset_s(buf, sizeof(buf), 0, sizeof(buf));
    n = StackReadLine(fd, buf, sizeof(buf));
    EXPECT_EQ(5, n);
    EXPECT_EQ(0, strcmp(buf, "world"));
    // already at EOF
    n = StackReadLine(fd, buf, sizeof(buf));
    EXPECT_EQ(0, n);
    (void)StackClose(fd);
}

static ssize_t ReadStub_EintrThenEof(int fd, void *buf, size_t count)
{
    (void)fd;
    (void)buf;
    (void)count;
    static int call = 0;
    if (call == 0) {
        call = 1;
        errno = EINTR;
        return -1;
    }
    return 0; // EOF
}

static ssize_t ReadStub_ErrorIo(int fd, void *buf, size_t count)
{
    (void)fd;
    (void)buf;
    (void)count;
    errno = EIO;
    return -1;
}

TEST_F(EP_STACKCORE_COV_UTEST, StackReadLine_EintrAndError)
{
    char filePath[MAX_FILENAME_LEN] = {0};
    (void)snprintf_s(filePath, sizeof(filePath), sizeof(filePath) - 1U, "%s/readline_eintr.txt", PATH_ROOT);
    int fd = open(filePath, O_CREAT | O_RDWR, 0640);
    ASSERT_GE(fd, 0);
    ASSERT_EQ(3, write(fd, "abc", 3));
    lseek(fd, 0, SEEK_SET);

    char buf[CORE_BUFFER_LEN] = {0};
    // EINTR then EOF
    MOCKER(read).stubs().will(invoke(ReadStub_EintrThenEof));
    ssize_t n = StackReadLine(fd, buf, sizeof(buf));
    EXPECT_EQ(0, n);
    GlobalMockObject::verify();

    // read error (errno != EINTR)
    lseek(fd, 0, SEEK_SET);
    MOCKER(read).stubs().will(invoke(ReadStub_ErrorIo));
    n = StackReadLine(fd, buf, sizeof(buf));
    EXPECT_EQ(-1, n);
    GlobalMockObject::verify();
    (void)StackClose(fd);
}

/* ── StackWriteData ────────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, StackWriteData_SuccessAndInvalid)
{
    char filePath[MAX_FILENAME_LEN] = {0};
    (void)snprintf_s(filePath, sizeof(filePath), sizeof(filePath) - 1U, "%s/writedata_test.txt", PATH_ROOT);
    int fd = open(filePath, O_CREAT | O_RDWR, 0640);
    ASSERT_GE(fd, 0);

    EXPECT_EQ(-1, StackWriteData(-1, "abc", 3));
    EXPECT_EQ(-1, StackWriteData(fd, NULL, 3));
    EXPECT_EQ(-1, StackWriteData(fd, "abc", 0));

    EXPECT_EQ(5, StackWriteData(fd, "hello", 5));
    (void)StackClose(fd);
}

static ssize_t WriteStub_EintrThenOk(int fd, const void *buf, size_t count)
{
    (void)fd;
    (void)buf;
    static int call = 0;
    if (call == 0) {
        call = 1;
        errno = EINTR;
        return -1;
    }
    return (ssize_t)count;
}

static ssize_t WriteStub_ErrorIo(int fd, const void *buf, size_t count)
{
    (void)fd;
    (void)buf;
    (void)count;
    errno = EIO;
    return -1;
}

TEST_F(EP_STACKCORE_COV_UTEST, StackWriteData_EintrAndError)
{
    char filePath[MAX_FILENAME_LEN] = {0};
    (void)snprintf_s(filePath, sizeof(filePath), sizeof(filePath) - 1U, "%s/writedata_eintr.txt", PATH_ROOT);
    int fd = open(filePath, O_CREAT | O_RDWR, 0640);
    ASSERT_GE(fd, 0);

    // EINTR then success
    MOCKER(write).stubs().will(invoke(WriteStub_EintrThenOk));
    EXPECT_EQ(5, StackWriteData(fd, "hello", 5));
    GlobalMockObject::verify();

    // hard error
    MOCKER(write).stubs().will(invoke(WriteStub_ErrorIo));
    EXPECT_EQ(-1, StackWriteData(fd, "hello", 5));
    GlobalMockObject::verify();
    (void)StackClose(fd);
}

/* ── StackClose ────────────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, StackClose_InvalidAndValid)
{
    EXPECT_EQ(0, StackClose(-1)); // invalid fd, early return 0
    char filePath[MAX_FILENAME_LEN] = {0};
    (void)snprintf_s(filePath, sizeof(filePath), sizeof(filePath) - 1U, "%s/close_test.txt", PATH_ROOT);
    int fd = open(filePath, O_CREAT | O_RDWR, 0640);
    ASSERT_GE(fd, 0);
    EXPECT_EQ(0, StackClose(fd));
}

/* ── StackFrame ────────────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, StackFrame_InvalidInputs)
{
    char buf[CORE_BUFFER_LEN] = {0};
    EXPECT_EQ(0U, StackFrame(0, 0, buf, sizeof(buf)));              // fp == 0
    EXPECT_EQ(0U, StackFrame(0, (uintptr_t)0x10, NULL, sizeof(buf))); // data null
    EXPECT_EQ(0U, StackFrame(0, (uintptr_t)0x10, buf, 0));            // len 0
    EXPECT_EQ(0U, StackFrame(COV_MAX_STACK_LAYER + 1, (uintptr_t)0x10, buf, sizeof(buf))); // layer too big
}

TEST_F(EP_STACKCORE_COV_UTEST, StackFrame_LayerZeroAndFrames)
{
    char buf[CORE_BUFFER_LEN] = {0};
    // layer 0: pc = fp, nfp = pc
    uintptr_t ret = StackFrame(0, (uintptr_t)0x4000, buf, sizeof(buf));
    EXPECT_EQ((uintptr_t)0x4000, ret);
    EXPECT_NE(nullptr, strstr(buf, "#0"));

    // layer > 0: dereference fp for pc/nfp
    uintptr_t frameMem[8] = {0};
    frameMem[0] = 0;            // *(fp) = next fp = 0 (stop)
    frameMem[1] = (uintptr_t)0x5000; // *(fp+8) = lr = pc
    ret = StackFrame(1, (uintptr_t)&frameMem[0], buf, sizeof(buf));
    EXPECT_EQ(0U, ret); // next fp == 0
    EXPECT_NE(nullptr, strstr(buf, "#1"));
}

/* ── StackPcFrame ──────────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, StackPcFrame_InvalidInputs)
{
    char buf[CORE_BUFFER_LEN] = {0};
    StackPcFrame(COV_MAX_STACK_LAYER + 1, (uintptr_t)0x10, buf, sizeof(buf)); // layer too big
    StackPcFrame(0, (uintptr_t)0x10, NULL, sizeof(buf));                  // data null
    StackPcFrame(0, (uintptr_t)0x10, buf, 0);                             // len 0
}

TEST_F(EP_STACKCORE_COV_UTEST, StackPcFrame_PcZeroAndNonZero)
{
    char buf[CORE_BUFFER_LEN] = {0};
    // pc == 0 -> snprintf the pc frame, then StackFrame(0, 0, ...) returns 0
    StackPcFrame(0, 0, buf, sizeof(buf));
    EXPECT_NE(nullptr, strstr(buf, "#0"));
    // pc != 0 -> skip snprintf, call StackFrame directly
    (void)memset_s(buf, sizeof(buf), 0, sizeof(buf));
    StackPcFrame(0, (uintptr_t)0x4000, buf, sizeof(buf));
    EXPECT_NE(nullptr, strstr(buf, "#0"));
}

/* ── CreateStackCore ───────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, CreateStackCore_SuccessNoFrames)
{
    // nfp == 0 -> fp loop does not execute, only pc frame is written
    ssize_t ret = CreateStackCore(0, (uintptr_t)0x4000, COV_SIGNO);
    EXPECT_GE(ret, 0);
    EXPECT_EQ(1, CheckStackcoreFileNum(PATH_ROOT));
}

TEST_F(EP_STACKCORE_COV_UTEST, CreateStackCore_WithFrameChain)
{
    // build a small fake frame chain so the fp loop iterates
    uintptr_t frameMem[8] = {0};
    frameMem[0] = (uintptr_t)&frameMem[2]; // frame0 next fp
    frameMem[1] = (uintptr_t)0x4000;       // frame0 lr (pc)
    frameMem[2] = 0;                       // frame1 next fp = 0 (stop)
    frameMem[3] = (uintptr_t)0x5000;       // frame1 lr (pc)
    ssize_t ret = CreateStackCore((uintptr_t)&frameMem[0], (uintptr_t)0x3000, COV_SIGNO);
    EXPECT_GE(ret, 0);
    EXPECT_EQ(1, CheckStackcoreFileNum(PATH_ROOT));
}

TEST_F(EP_STACKCORE_COV_UTEST, CreateStackCore_OpenFail)
{
    // point g_filePath to a nonexistent directory so StackOpen fails
    (void)strcpy_s(g_filePath, sizeof(g_filePath), "/no_such_dir_xyz_123");
    ssize_t ret = CreateStackCore(0, (uintptr_t)0x4000, COV_SIGNO);
    EXPECT_EQ(-1, ret);
    // restore
    EXPECT_EQ(0, StackcoreSetSubdirectory(""));
}

TEST_F(EP_STACKCORE_COV_UTEST, CreateStackCore_WriteFail)
{
    // mock write to fail on the first StackWriteData(STACK_SECTION) -> goto ERROR
    MOCKER(write).stubs().will(invoke(WriteStub_ErrorIo));
    ssize_t ret = CreateStackCore(0, (uintptr_t)0x4000, COV_SIGNO);
    EXPECT_EQ(-1, ret);
    GlobalMockObject::verify();
    EXPECT_EQ(0, StackcoreSetSubdirectory(""));
}

/* ── AnalysisContext ───────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, AnalysisContext_NullAndZeroFp)
{
    AnalysisContext(NULL, COV_SIGNO); // null mcontext -> return
    ucontext_t utext;
    (void)memset_s(&utext, sizeof(utext), 0, sizeof(utext));
    EXPECT_NE(-1, getcontext(&utext));
    mcontext_t *mc = (mcontext_t *)&(utext.uc_mcontext);
    COV_SET_FP(mc, 0); // nfp == 0 -> LOGE, return
    AnalysisContext(mc, COV_SIGNO);
    EXPECT_EQ(0, CheckStackcoreFileNum(PATH_ROOT));
}

TEST_F(EP_STACKCORE_COV_UTEST, AnalysisContext_WithFrameChain)
{
    ucontext_t utext;
    (void)memset_s(&utext, sizeof(utext), 0, sizeof(utext));
    EXPECT_NE(-1, getcontext(&utext));
    mcontext_t *mc = (mcontext_t *)&(utext.uc_mcontext);

    uintptr_t frameMem[8] = {0};
    frameMem[0] = 0;                  // next fp = 0 (stop after one frame)
    frameMem[1] = (uintptr_t)0x4000;  // lr (pc)
    COV_SET_FP(mc, (uintptr_t)&frameMem[0]);
    COV_SET_PC(mc, (uintptr_t)0x3000);
    AnalysisContext(mc, COV_SIGNO);
    EXPECT_EQ(1, CheckStackcoreFileNum(PATH_ROOT));
}

/* ── StackSigHandler ───────────────────────────────────────────────────── */
TEST_F(EP_STACKCORE_COV_UTEST, StackSigHandler_NullInfoAndData)
{
    ucontext_t utext;
    (void)memset_s(&utext, sizeof(utext), 0, sizeof(utext));
    EXPECT_NE(-1, getcontext(&utext));
    StackSigHandler(COV_SIGNO, NULL, &utext);   // null info -> return
    StackSigHandler(COV_SIGNO, NULL, NULL);     // null info -> return
    siginfo_t info;
    (void)memset_s(&info, sizeof(info), 0, sizeof(info));
    info.si_signo = COV_SIGNO;
    StackSigHandler(COV_SIGNO, &info, NULL);    // null data -> return
    EXPECT_EQ(0, CheckStackcoreFileNum(PATH_ROOT));
}

TEST_F(EP_STACKCORE_COV_UTEST, StackSigHandler_NoMatchingSignal)
{
    // si_signo does not match any registered core signal -> no recover path
    ucontext_t utext;
    (void)memset_s(&utext, sizeof(utext), 0, sizeof(utext));
    EXPECT_NE(-1, getcontext(&utext));
    mcontext_t *mc = (mcontext_t *)&(utext.uc_mcontext);
    uintptr_t frameMem[4] = {0};
    frameMem[0] = 0;
    frameMem[1] = (uintptr_t)0x4000;
    COV_SET_FP(mc, (uintptr_t)&frameMem[0]);
    COV_SET_PC(mc, (uintptr_t)0x3000);

    siginfo_t info;
    (void)memset_s(&info, sizeof(info), 0, sizeof(info));
    info.si_signo = 999; // not a registered core signal
    MOCKER(StackFrame).stubs().will(invoke(StackFrame_stub));
    StackSigHandler(999, &info, &utext);
    EXPECT_EQ(1, CheckStackcoreFileNum(PATH_ROOT));
    GlobalMockObject::verify();
}

TEST_F(EP_STACKCORE_COV_UTEST, StackSigHandler_RaiseFail)
{
    // registered signal, recover sigaction ok, raise returns nonzero -> LOGE
    ucontext_t utext;
    (void)memset_s(&utext, sizeof(utext), 0, sizeof(utext));
    EXPECT_NE(-1, getcontext(&utext));
    mcontext_t *mc = (mcontext_t *)&(utext.uc_mcontext);
    uintptr_t frameMem[4] = {0};
    frameMem[0] = 0;
    frameMem[1] = (uintptr_t)0x4000;
    COV_SET_FP(mc, (uintptr_t)&frameMem[0]);
    COV_SET_PC(mc, (uintptr_t)0x3000);

    siginfo_t info;
    (void)memset_s(&info, sizeof(info), 0, sizeof(info));
    info.si_signo = SIGQUIT;
    MOCKER(StackFrame).stubs().will(invoke(StackFrame_stub));
    MOCKER(raise).stubs().will(returnValue(-1));
    StackSigHandler(SIGQUIT, &info, &utext);
    EXPECT_EQ(1, CheckStackcoreFileNum(PATH_ROOT));
    GlobalMockObject::verify();
}

// NOTE: intentionally the last test in this suite. Mocking sigaction to fail
// leaves g_sigActs[<signo>].done == 0; no later test in this binary relies on
// that entry being "done" (the program-exit destructor restores handlers
// unconditionally). Registered tests from other suites run before this one.
TEST_F(EP_STACKCORE_COV_UTEST, StackSigHandler_SigactionRecoverFail)
{
    ucontext_t utext;
    (void)memset_s(&utext, sizeof(utext), 0, sizeof(utext));
    EXPECT_NE(-1, getcontext(&utext));
    mcontext_t *mc = (mcontext_t *)&(utext.uc_mcontext);
    uintptr_t frameMem[4] = {0};
    frameMem[0] = 0;
    frameMem[1] = (uintptr_t)0x4000;
    COV_SET_FP(mc, (uintptr_t)&frameMem[0]);
    COV_SET_PC(mc, (uintptr_t)0x3000);

    siginfo_t info;
    (void)memset_s(&info, sizeof(info), 0, sizeof(info));
    info.si_signo = SIGSYS;
    MOCKER(StackFrame).stubs().will(invoke(StackFrame_stub));
    MOCKER(sigaction).stubs().will(returnValue(-1));
    StackSigHandler(SIGSYS, &info, &utext);
    EXPECT_EQ(1, CheckStackcoreFileNum(PATH_ROOT));
    GlobalMockObject::verify();
}
