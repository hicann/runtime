/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <errno.h>
#include <sys/socket.h>
#include <sys/file.h>
#include <limits.h>
#include <stdio.h>
#include "log_file_util.h"
#include "log_pm_sig.h"
#include "log_pm.h"
#include "log_print.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

extern "C" {
    #include "slogd_utest_stub.h"
    #include "securec.h"
    #include "log_path_mgr.h"

    typedef struct {
        char *buff;
        unsigned int buffLen;
    } Buffer;

    void GetLocalTimeForSelfLog(size_t bufLen, char *timeBuffer);
    int GetRingFd(const char *slogdFile, const char *msg);
    void SetRingFile(const char *slogdFile);
    int CatStr(const char *str1, unsigned int len1, const char *str2, unsigned int len2, Buffer *buffer);
    int LogInitRootPath(void);
    void LogSignalActionSet(int32_t sig, void (*handler)(int32_t));
}

#define LLT_SLOG_DIR "llt/abl/slog"

#undef SLOGD_LOG_FILE
#define SLOGD_LOG_FILE LLT_SLOG_DIR "/ut/slog/res/slogd.log"

class SlogdLib : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SlogdLib::SetUp()
{
}

void SlogdLib::TearDown()
{
    unlink(SLOGD_LOG_FILE);
}

void function(int b)
{
    int a = 0;
    return;
}

TEST_F(SlogdLib, RecordSigno)
{
    LogRecordSigNo(10);

    EXPECT_EQ(10, LogGetSigNo());
    GlobalMockObject::reset();
}

TEST_F(SlogdLib, GetRingFdInputNull)
{
    const char* slogd_file = LLT_SLOG_DIR "/ut/slog/res/slogd.log";
    EXPECT_EQ(-1, GetRingFd(slogd_file, NULL));

    char* msg = "/var/log/msg.txt";
    MOCKER(stat).stubs().will(returnValue(-1));

    GlobalMockObject::reset();
}

TEST_F(SlogdLib, CatStr_NULL)
{
    Buffer buffer = {NULL, 10};
    EXPECT_EQ(-1, CatStr(NULL, 10, NULL, 10, &buffer));
}

TEST_F(SlogdLib, CatStr_STRCPY_S_ERR1)
{
    char* str1 = "hello";
    unsigned int len1 = strlen(str1) + 1;
    char* str2 = "world";
    unsigned int len2 = strlen(str2) + 1;
    char buff[128] = {0};

    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(1));
    Buffer buffer = {buff, 128};
    EXPECT_EQ(-1, CatStr(str1, len1, str2, len2, &buffer));
    GlobalMockObject::reset();
}

TEST_F(SlogdLib, CatStr_STRCPY_S_ERR2)
{
    char* str1 = "hello";
    unsigned int len1 = strlen(str1) + 1;
    char* str2 = "world";
    unsigned int len2 = strlen(str2) + 1;
    char buff[128] = {0};

    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(EOK))
        .then(returnValue(-1));
    Buffer buffer = {buff, 128};
    EXPECT_EQ(-1, CatStr(str1, len1, str2, len2, &buffer));
    GlobalMockObject::reset();
}

TEST_F(SlogdLib, CatStr_STRCPY_S_SUCCESS)
{
    char* str1 = "hello";
    unsigned int len1 = strlen(str1) + 1;
    char* str2 = "world";
    unsigned int len2 = strlen(str2) + 1;
    char buff[128] = {0};

    Buffer buffer = {buff, 128};
    EXPECT_EQ(EOK, CatStr(str1, len1, str2, len2, &buffer));
    std::cout<<"buff = "; 
    std::cout<< buff << std::endl;
    GlobalMockObject::reset();
}

TEST_F(SlogdLib, CheckSelfLogPath)
{
    MOCKER(LogGetRootPath).stubs().will(returnValue((char *)NULL));
    EXPECT_EQ(SYS_ERROR, CheckSelfLogPath());
    GlobalMockObject::reset();

    char logPath[24] = { 0 };
    char selfLogPath[32] = { 0 };
    strcpy(logPath, "/var/log/npu/slog");
    strcpy(selfLogPath, "/var/log/npu/slog/slogd");

    MOCKER(LogGetRootPath).stubs().will(returnValue((char *)logPath));
    MOCKER(LogMkdir).stubs().will(returnValue(SUCCESS + 1));
    EXPECT_EQ(SYS_ERROR, CheckSelfLogPath());
    GlobalMockObject::reset();

    MOCKER(LogGetRootPath).stubs().will(returnValue((char *)logPath));
    MOCKER(LogMkdir).stubs().will(returnValue(SUCCESS));
    MOCKER(LogGetSelfPath).stubs().will(returnValue((char *)NULL));
    EXPECT_EQ(SYS_ERROR, CheckSelfLogPath());
    GlobalMockObject::reset();

    MOCKER(LogGetRootPath).stubs().will(returnValue((char *)logPath));
    MOCKER(LogMkdir).stubs().will(returnValue(SUCCESS)).then(returnValue(SUCCESS + 1));
    MOCKER(LogGetSelfPath).stubs().will(returnValue((char *)selfLogPath));
    EXPECT_EQ(SYS_ERROR, CheckSelfLogPath());
    GlobalMockObject::reset();

    MOCKER(LogGetRootPath).stubs().will(returnValue((char *)logPath));
    MOCKER(LogMkdir).stubs().will(returnValue(SUCCESS));
    MOCKER(LogGetSelfPath).stubs().will(returnValue((char *)selfLogPath));
    EXPECT_EQ(SYS_OK, CheckSelfLogPath());
    GlobalMockObject::reset();
}