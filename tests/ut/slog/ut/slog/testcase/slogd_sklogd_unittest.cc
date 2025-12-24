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
#include <sys/klog.h>
#include "log_pm_sig.h"
extern "C" {
    #include "log_common.h"
    #include "slog.h"
    #include "operate_loglevel.h"
    #include "klogd.h"
    #include "log_path_mgr.h"
    #include "slogd_utest_stub.h"
    #include "dlog_console.h"

    int KlogdLltMain(int argc, char **argv);
    INT32 ToolGetErrorCode();
    LogRt LogConfListInit(const char *file);
    LogRt LogConfListGetValue(const char *confName, uint32_t nameLen, char *confValue, uint32_t valueLen);
    extern int ReadKernelLog(char *bufP, size_t len);
    void OpenKernelLog(void);
    void KLogdSetLogLevel(int lvl);
    void CloseKernelLog(void);
    void ParseArgv(int argc, const char **argv);
    void ProcKernelLog(void);
    void KLogToSLog(unsigned int priority, const char *msg);
    void ParseKernelLog(const char *start);
    int ProcessBuf(char *msg, unsigned int length);
    void DecodeMsg(char *msg, unsigned int length);
    char GetChValue(char ch);
    int IsDigit(char c);
    int CheckProessBufParm(const char *msg, unsigned int length, char **heapBuf);
}
#include <getopt.h>

class SlogdSklogd : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SlogdSklogd::SetUp()
{}

void SlogdSklogd::TearDown()
{}

TEST_F(SlogdSklogd, IsDigit)
{
    EXPECT_EQ(1, IsDigit('0'));
    EXPECT_EQ(0, IsDigit('a'));
    GlobalMockObject::reset();
}

TEST_F(SlogdSklogd, GetChValue)
{
    EXPECT_EQ(0, GetChValue('0'));
    EXPECT_EQ(10, GetChValue('a'));
    EXPECT_EQ(10, GetChValue('A'));
    EXPECT_EQ((unsigned int)'*', GetChValue('*'));
    GlobalMockObject::reset();
}

TEST_F(SlogdSklogd,CheckProessBufParm)
{
    char *buf;
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(-1, CheckProessBufParm(buf, 2, &buf));
    GlobalMockObject::reset();
}
TEST_F(SlogdSklogd,CheckProessBufParmNULL)
{
    char *buf;
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(-1, CheckProessBufParm(buf, 0, &buf));
    GlobalMockObject::reset();

    EXPECT_EQ(-1, CheckProessBufParm(NULL, 0, NULL));
    GlobalMockObject::reset();
}
TEST_F(SlogdSklogd, ProcessBuf)
{
    EXPECT_EQ(-1, ProcessBuf(NULL, 0));

    char *msg = "12,1,8269165240,-;h";
    char *buf = (char*)malloc(COMMON_BUFSIZE);
    strncpy_s(buf, strlen(msg) + 1, msg, strlen(msg) + 1);
    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(-1, ProcessBuf(buf, strlen(buf) + 1));
    GlobalMockObject::reset();

    strncpy_s(buf, strlen(msg) + 1, msg, strlen(msg) + 1);
    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    EXPECT_EQ(-1, ProcessBuf(buf, strlen(buf) + 1));
    GlobalMockObject::reset();

    strncpy_s(buf, strlen(msg) + 1, msg, strlen(msg) + 1);
    EXPECT_EQ(0, ProcessBuf(buf, strlen(buf) + 1));
    free(buf);
    GlobalMockObject::reset();
}

TEST_F(SlogdSklogd, ProcessBufMaxLong)
{
    EXPECT_EQ(-1, ProcessBuf(NULL, 0));

    char *msg = "12,1,9999999999999999999999999999999999999999999999,-;test msg";
    char *msgok = "6,1864,797350183989,-;this is test msg";
    char *buf = (char*)malloc(strlen(msg) + 1);
    char *bufok = (char*)malloc(strlen(msgok) + 1);

    strncpy_s(buf, strlen(msg) + 1, msg, strlen(msg) + 1);
    EXPECT_EQ(-1, ProcessBuf(buf, strlen(buf) + 1));
    free(buf);
    GlobalMockObject::reset();

    char *msgLevelErr = "65536,1,8269165240,-;h";
    char *bufLevelErr = (char*)malloc(strlen(msgLevelErr) + 1);
    strncpy_s(bufLevelErr, strlen(msgLevelErr) + 1, msgLevelErr, strlen(msgLevelErr) + 1);
    EXPECT_EQ(-1, ProcessBuf(bufLevelErr, strlen(bufLevelErr) + 1));
    free(bufLevelErr);
    GlobalMockObject::reset();
    strncpy_s(bufok, strlen(msgok) + 1, msgok, strlen(msgok) + 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK));
    EXPECT_EQ(0, ProcessBuf(bufok, strlen(bufok) + 1));
    free(bufok);
    GlobalMockObject::reset();
}

TEST_F(SlogdSklogd, KlogdReadPassThrought)
{
    char buf[1024] = {0};
    OpenKernelLog();
    MOCKER(read).stubs().will(returnValue(-1));
    EXPECT_EQ(-1, ReadKernelLog(buf, 1024));
    CloseKernelLog();
    GlobalMockObject::reset();
}

TEST_F(SlogdSklogd, KlogdLltMain1)
{
    char op;
    char* pc = &op;
    LogRecordSigNo(1);
    MOCKER(JustStartAProcess).stubs().will(returnValue(-1));
    EXPECT_EQ(1, KlogdLltMain(0, &pc));
    GlobalMockObject::reset();
    LogRecordSigNo(0);
}

TEST_F(SlogdSklogd, KlogdLltMain2)
{
    char op;
    char* pc = &op;
    LogRecordSigNo(1);
    MOCKER(JustStartAProcess).stubs().will(returnValue(0));
    EXPECT_EQ(1, KlogdLltMain(0, &pc));
    GlobalMockObject::reset();
    LogRecordSigNo(0);
}

TEST_F(SlogdSklogd, KlogdLltMain3)
{
    char op;
    char* pc = &op;
    LogRecordSigNo(1);
    MOCKER(JustStartAProcess).stubs().will(returnValue(0));
    EXPECT_EQ(1, KlogdLltMain(0, &pc));
    GlobalMockObject::reset();
    LogRecordSigNo(0);
}

TEST_F(SlogdSklogd, KlogdLltMain4)
{
    char op;
    char* pc = &op;
    LogRecordSigNo(1);
    MOCKER(JustStartAProcess).stubs().will(returnValue(0));
    MOCKER(StrcatDir).stubs().will(returnValue(SYS_OK + 1));
    EXPECT_EQ(1, KlogdLltMain(0, &pc));
    GlobalMockObject::reset();
    LogRecordSigNo(0);
}