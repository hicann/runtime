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
#include <thread>
#include <sys/wait.h>
#include <link.h>
#include "atrace_api.h"
#include "dumper_core.h"
#include "tracer_core.h"
#include "trace_system_api.h"
#include "stacktrace_safe_recorder.h"
#include "stacktrace_signal.h"
#include "stacktrace_parse.h"
#include "stacktrace_file_struct.h"
#include "adiag_utils.h"

#define BIN_PATH  LLT_TEST_DIR"/stackcore_tracer_11_49324_python3.8_20241107094559638058.bin"

extern "C" {
    int32_t StacktraceDumperMain(int32_t argc, const char *argv[]);
    int32_t TraceGetTxtFd(const char *filePath, uint32_t len);
    void TraceWriteKernelVersion(int32_t fd);
    TraStatus TraceParseBinFile(const char *filePath, uint32_t len);
}

class StacktraceDumperBinUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("mkdir -p " LLT_TEST_DIR );
        system("rm -rf " LLT_TEST_DIR "/*");
        struct passwd *pwd = getpwuid(getuid());
        pwd->pw_dir = LLT_TEST_DIR;
        MOCKER(getpwuid).stubs().will(returnValue(pwd));
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};

TEST_F(StacktraceDumperBinUtest, TestMainSuccess)
{
    const char *argv[] = {"./asc_dumper", "1"};
    auto argc = sizeof(argv) / sizeof(argv[0]);
    MOCKER(TraceStackParse).stubs().will(returnValue(0));
    EXPECT_EQ(StacktraceDumperMain(argc, argv), 0);
}

TEST_F(StacktraceDumperBinUtest, TestMainFailed)
{
    const char *argv[] = {"./asc_dumper"};
    auto argc = sizeof(argv) / sizeof(argv[0]);
    EXPECT_EQ(StacktraceDumperMain(argc, argv), 1);
}

TEST_F(StacktraceDumperBinUtest, TestTraceCheckBinPath_Failed)
{
    char binPath[1024] = {BIN_PATH};
    TraStatus ret = TRACE_SUCCESS;

    // path does not exist
    ret = TraceStackParse(binPath, strlen(binPath));
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    // path length exceeds TRACE_MAX_PATH
    system("touch " BIN_PATH);
    ret = TraceStackParse(binPath, TRACE_MAX_PATH);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    // path length is 0
    ret = TraceStackParse(binPath, 0);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);
    system("rm -f " BIN_PATH);

    // suffix is not "bin"
    MOCKER(access).stubs().will(returnValue(0));
    strcat_s(binPath, 1024, "a");
    ret = TraceStackParse(binPath, strlen(binPath));
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);
    GlobalMockObject::verify();
}

TEST_F(StacktraceDumperBinUtest, TestTraceParseBinFile_Failed)
{
    char binPath[1024] = {BIN_PATH};
    TraStatus ret = TRACE_SUCCESS;

    system("touch " BIN_PATH);

    // open failed
    auto mocker = reinterpret_cast<int (*)(char *, int)>(open);
    MOCKER(mocker).stubs().will(returnValue(-1));
    ret = TraceStackParse(binPath, strlen(binPath));
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);
    GlobalMockObject::verify();

    // malloc failed
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    ret = TraceStackParse(binPath, strlen(binPath));
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    // read failed
    ret = TraceStackParse(binPath, strlen(binPath));
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);
    GlobalMockObject::verify();
    system("rm -f " BIN_PATH);
}

TEST_F(StacktraceDumperBinUtest, TestTraceCheckBinHead_Failed)
{
    char binPath[1024] = {BIN_PATH};
    struct StackcoreBuffer *data = (struct StackcoreBuffer *)malloc(sizeof(struct StackcoreBuffer));
    EXPECT_NE(((void*)NULL), data);
    memset_s(data, sizeof(struct StackcoreBuffer), 0, sizeof(struct StackcoreBuffer));
    TraStatus ret = TRACE_SUCCESS;

    int32_t fd = open(binPath, O_CREAT | O_WRONLY | O_APPEND, 0640);
    EXPECT_LT(0, fd);
    write(fd, (const char *)data, sizeof(struct StackcoreBuffer));

    // magic = 0, version = 0
    ret = TraceStackParse(binPath, strlen(binPath));
    EXPECT_EQ(TRACE_FAILURE, ret);


    // get txt fd failed
    MOCKER(TraceGetTxtFd).stubs().will(returnValue(-1));
    ftruncate(fd, 0); // 清空bin文件
    data->head.magic = STACK_HEAD_MAGIC;
    data->head.version = STACK_HEAD_VERSION;
    write(fd, (const char *)data, sizeof(struct StackcoreBuffer));
    ret = TraceStackParse(binPath, strlen(binPath));
    EXPECT_EQ(TRACE_FAILURE, ret);

    close(fd);
    free(data);
    remove(binPath);
}

TEST_F(StacktraceDumperBinUtest, TestTraceGetTxtFd_Failed)
{
    char binPath[1024] = {BIN_PATH};
    int32_t ret = -1;

    MOCKER(strncpy_s).stubs().will(returnValue(-1));
    ret = TraceGetTxtFd(binPath, strlen(binPath));
    EXPECT_EQ(-1, ret);
    GlobalMockObject::verify();

    // suffix is not "bin"
    ret = TraceGetTxtFd(LLT_TEST_DIR, strlen(LLT_TEST_DIR));
    EXPECT_EQ(-1, ret);
}

TEST_F(StacktraceDumperBinUtest, TestTraceWriteKernelVersion_Failed)
{
    int32_t fd = open(LLT_TEST_DIR "/tmpfile", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
    EXPECT_LT(0, fd);
    int32_t result = -1;
    char buffer[256] = {0};
    char exceptString[256] = "kernel version: unknown\n";

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));// snprintf_s failed
    TraceWriteKernelVersion(fd);
    result = read(fd, buffer, sizeof(buffer) -1);
    EXPECT_EQ(0, result);
    GlobalMockObject::verify();

    MOCKER(popen).stubs().will(returnValue((FILE *)0));
    TraceWriteKernelVersion(fd);
    lseek(fd, 0, SEEK_SET);
    result = read(fd, buffer, sizeof(buffer) -1);
    EXPECT_EQ(strlen(exceptString), result);
    EXPECT_STREQ(exceptString, buffer);
    GlobalMockObject::verify();

    MOCKER(vsnprintf_s).stubs().will(returnValue(0)).then(returnValue(-1));// snprintf_s failed
    TraceWriteKernelVersion(fd);
    lseek(fd, 0, SEEK_SET);
    result = read(fd, buffer, sizeof(buffer) -1);
    EXPECT_EQ(strlen(exceptString), result);
    EXPECT_STREQ(exceptString, buffer);
    GlobalMockObject::verify();

    close(fd);
}

TEST_F(StacktraceDumperBinUtest, TestTraceStackParse_Failed)
{
    char binPath[1024] = {BIN_PATH};
    TraStatus ret = TRACE_SUCCESS;

    system("touch " BIN_PATH);

    MOCKER(TraceRealPath).stubs().will(returnValue(-1));
    ret = TraceStackParse(binPath, strlen(binPath));
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceParseBinFile).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(remove).stubs().will(returnValue(-1));
    ret = TraceStackParse(binPath, strlen(binPath));
    EXPECT_EQ(TRACE_SUCCESS, ret);
    GlobalMockObject::verify();
    system("rm -f " BIN_PATH);
}
