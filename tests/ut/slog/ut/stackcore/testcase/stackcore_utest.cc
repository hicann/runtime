/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public
#include <ucontext.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <signal.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <time.h>
#include "securec.h"
#include "stackcore_common.h"

extern "C" {
extern int StackInit(void);
extern void StackUnInit(void);
extern void StackSigHandler(int sigNum, siginfo_t *info, void *data);
extern void AnalysisContext(const mcontext_t *mcontext, int signo);
extern ssize_t CreateStackCore(uintptr_t nfp, uintptr_t pc, int signo);
extern uintptr_t StackFrame(int layer, uintptr_t fp, char *data, unsigned int len);
extern void GetSelfMap(uintptr_t pc, char *data, unsigned int len);
extern int StackClose(int fd);
extern ssize_t StackWriteData(int fd, const char *data, unsigned int len);
extern ssize_t StackReadLine(int fd, char *data, unsigned int len);
extern int StackOpen(const char *fileName);
extern int StackCoreName(char *name, unsigned int len, int signo);
extern void StackSysLog(int priority, const char *format, ...);
extern int StackcoreSetSubdirectory(const char *subdir);
}

class STACKCORE_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

static void EXPECT_CheckErrLogNum(int32_t num)
{
    MOCKER(vsyslog).expects(exactly(num));
}

TEST_F(STACKCORE_UTEST, StackInit)
{
    MOCKER(sigemptyset).stubs();
    MOCKER(sigaction).stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    EXPECT_EQ(0, StackInit());
}

TEST_F(STACKCORE_UTEST, StackUnInit)
{
    EXPECT_CheckErrLogNum(1);
    MOCKER(sigaction)
        .expects(exactly(10))
        .will(returnValue(-1))
        .then(returnValue(0));
    StackUnInit();
}

TEST_F(STACKCORE_UTEST, StackSigHandler)
{
    MOCKER(sigemptyset).stubs();
    MOCKER(sigaction).stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(raise).stubs();
    EXPECT_EQ(0, StackInit());
    MOCKER(AnalysisContext).stubs();
    ucontext_t utext;
    siginfo_t info;
    info.si_signo = 11;
    StackSigHandler(11, &info, &utext);
}

TEST_F(STACKCORE_UTEST, AnalysisContext)
{
    EXPECT_CheckErrLogNum(2);
    MOCKER(CreateStackCore).stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    mcontext_t utext;
    utext.gregs[15] = 0x0123456;
    utext.gregs[16] = 0x0ff1234;
    AnalysisContext(&utext, 11);
    AnalysisContext(&utext, 11);
}

TEST_F(STACKCORE_UTEST, CreateStackCore)
{
    uintptr_t nfp = 0;
    uintptr_t pc = 0;

    MOCKER(StackCoreName).stubs()
        .will(returnValue(ssize_t(-1)))
        .then(returnValue(ssize_t(0)));
    MOCKER(StackOpen).stubs()
        .will(returnValue(ssize_t(-1)))
        .then(returnValue(ssize_t(0)));
    MOCKER(StackWriteData).stubs()
        .will(returnValue(ssize_t(-1)))
        .then(returnValue(ssize_t(0)))
        .then(returnValue(ssize_t(-1)))
        .then(returnValue(ssize_t(0)));
    MOCKER(fchmod).stubs()
        .will(returnValue(ssize_t(-1)))
        .then(returnValue(ssize_t(0)));
    MOCKER(StackFrame).stubs()
        .will(returnValue((uintptr_t)0));
    // StackCoreName error
    EXPECT_EQ(-1, CreateStackCore(nfp, pc, 11));
    // StackOpen
    EXPECT_EQ(-1, CreateStackCore(nfp, pc, 11));
    // StackWriteData
    EXPECT_EQ(-1, CreateStackCore(nfp, pc, 11));
    EXPECT_EQ(-1, CreateStackCore(nfp, pc, 11));
    // fchmod error
    EXPECT_EQ(-1, CreateStackCore(nfp, pc, 11));
    // StackFrame
    nfp = 0x0ff1234;
    EXPECT_EQ(0, CreateStackCore(nfp, pc, 11));
}

TEST_F(STACKCORE_UTEST, StackFrame)
{
    int layer = 0;
    uintptr_t nfp = 0;
    char info[128] = {'\0'};
    MOCKER(GetSelfMap).stubs();
    EXPECT_EQ(0, StackFrame(0, nfp, info, sizeof(info)));
    EXPECT_EQ(0, StackFrame(0, nfp, info, 0));
    EXPECT_EQ(0, StackFrame(0, nfp, NULL, sizeof(info)));
    EXPECT_EQ(0, StackFrame(20, nfp, info, sizeof(info)));
    nfp = 0x0ff1234;
    EXPECT_EQ(0x0ff1234, StackFrame(0, nfp, info, sizeof(info)));
    EXPECT_EQ(0x0ff1234, StackFrame(0, nfp, info, sizeof(info)));
}

TEST_F(STACKCORE_UTEST, GetSelfMap)
{
    EXPECT_CheckErrLogNum(0);
    uintptr_t pc = 0x004004bc;
    char info[] = "00400000-00402000 r-xp 00000000 fd:00 2097334 /root/wk/a.out";
    MOCKER(StackReadLine).stubs()
        .will(returnValue(-1))
        .then(returnValue(sizeof(info)))
        .then(returnValue(0));
    GetSelfMap(pc, NULL, sizeof(info));
    GetSelfMap(pc, info, 0);
    GetSelfMap(pc, info, sizeof(info));
    GetSelfMap(pc, info, sizeof(info));
    GetSelfMap(pc, info, sizeof(info));
}

TEST_F(STACKCORE_UTEST, StackWriteData)
{
    uintptr_t pc = 0x004004bc;
    char info[] = "#0 0x004004bc 0x00400000 /root/wk/a.out";
    MOCKER(write).stubs()
        .will(returnValue(-1))
        .then(returnValue((ssize_t)sizeof(info)));
    EXPECT_EQ(-1, StackWriteData(0, NULL, sizeof(info)));
    EXPECT_EQ(-1, StackWriteData(0, info, 0));
    // write error
    EXPECT_EQ(-1, StackWriteData(0, info, sizeof(info)));
    EXPECT_EQ((ssize_t)sizeof(info), StackWriteData(pc, info, sizeof(info)));
}

TEST_F(STACKCORE_UTEST, StackReadLine)
{
    uintptr_t pc = 0x004004bc;
    char info[] = "#0 0x004004bc 0x00400000 /root/wk/a.out";
    MOCKER(read).stubs()
        .will(returnValue(-1))
        .then(returnValue((ssize_t)0))
        .then(returnValue((ssize_t)1));
    EXPECT_EQ(-1, StackReadLine(0, NULL, sizeof(info)));
    EXPECT_EQ(-1, StackReadLine(0, info, 0));
    // read error
    EXPECT_EQ(-1, StackReadLine(0, info, sizeof(info)));
    EXPECT_EQ(0, StackReadLine(0, info, sizeof(info)));
    EXPECT_EQ(sizeof(info), StackReadLine(0, info, sizeof(info)));
}

TEST_F(STACKCORE_UTEST, StackCoreName)
{
    uintptr_t pc = 0x004004bc;
    char info[512] = "stackcore.out";

    EXPECT_EQ(-1, StackCoreName(NULL, sizeof(info), 11));
    EXPECT_EQ(-1, StackCoreName(info, 0, 11));
    EXPECT_EQ(0, StackCoreName(info, sizeof(info), 11));
}

TEST_F(STACKCORE_UTEST, StackOpen)
{
    char info[] = "/llt_test/stackcore.out";
    EXPECT_EQ(-1, StackOpen(nullptr));
    EXPECT_EQ(-1, StackOpen(info));
    EXPECT_EQ(-1, StackOpen("../slog"));
}

int32_t TestProcessName(char *newName)
{
    int32_t signo = 11;
    char name[512] = { 0 };
    char *orgName = program_invocation_short_name;
    printf("parent program_invocation_name: %s\n", program_invocation_short_name);
    program_invocation_short_name = newName;
    printf("parent program_invocation_name: %s\n", program_invocation_short_name);
    ssize_t ret = StackCoreName(name, sizeof(name), signo);
    EXPECT_EQ(0, ret);

    int32_t fd = StackOpen(name);
    close(fd);
    program_invocation_short_name = orgName;
    if (fd < 0) {
        printf("name = [%s], invalid path\n", name);
        return -1;
    } else {
        printf("name = [%s], valid path\n", name);
        return 0;
    }
}

TEST_F(STACKCORE_UTEST, StackCheckPath)
{
    system("mkdir " CORE_DEFAULT_PATH);
    // invalid path
    EXPECT_EQ(-1, TestProcessName("./"));
    EXPECT_EQ(-1, TestProcessName("../"));
    EXPECT_EQ(-1, TestProcessName("\.\.\/"));
    EXPECT_EQ(-1, TestProcessName("\\../"));
    EXPECT_EQ(-1, TestProcessName("\\.\\./"));
    EXPECT_EQ(-1, TestProcessName("\\.\\.\\/"));
}
