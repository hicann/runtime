/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string.h>
#include "mergeslog.h"
#include "self_log_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

using namespace std;
using namespace testing;

extern "C"
{
extern int32_t ioctl(int32_t fd, uint32_t cmd, int32_t f);
}

class MDC_MERGESLOG_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start mergeslog test case");
    }
    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End mergeslog test case");
        MergeslogCheckPrint();
        system("rm -rf " PATH_ROOT "/*");
        GlobalMockObject::verify();
    }
    static void SetUpTestCase()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start mergeslog test suite");
        MergeslogConstructor();
    }
    static void TearDownTestCase()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End mergeslog test suite");
        MergeslogDestructor();
    }

public:
    static void MergeslogConstructor()
    {
        system("mkdir -p " PATH_ROOT);
        system("> " LOGOUT_IAM_SERVICE_PATH);
    }
    static void MergeslogDestructor()
    {
        system("rm -rf " PATH_ROOT);
    }
    static void MergeslogCheckPrint()
    {
        ResetErrLog();
    }
};

TEST_F(MDC_MERGESLOG_EXCP_UTEST, DlogGetLogPatternsStrcpyFailed)
{
    struct DlogNamePatterns logs = { 0 };
    MOCKER(strncpy_s).stubs().will(returnValue(10));
    EXPECT_EQ(MERGE_SUCCESS, DlogGetLogPatterns(&logs)); 
    EXPECT_EQ(12 + 3 * 3 + 1 + 1, logs.logNum);
    EXPECT_EQ(3, GetErrLogNum());

    EXPECT_STREQ("/home/mdc/var/log/slogd/", logs.patterns[0].path);
    EXPECT_STREQ("slogdlog", logs.patterns[0].active);
    EXPECT_STREQ("slogdlog.old", logs.patterns[0].rotate);

    free(logs.patterns);
}

TEST_F(MDC_MERGESLOG_EXCP_UTEST, DlogCollectLogCheckPathFailed)
{
    system("rm -rf " TESTCASE_PATH);
    system("mkdir -p " TESTCASE_PATH);
    MOCKER(strcat_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(MERGE_ERROR, DlogCollectLog(TESTCASE_PATH, 256));
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("make log path failed"));
}

TEST_F(MDC_MERGESLOG_EXCP_UTEST, DlogCheckCollectStatusCheckPathFailed)
{
    system("rm -rf " TESTCASE_PATH);
    system("mkdir -p " TESTCASE_PATH);
    MOCKER(strcat_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(MERGE_ERROR, DlogCheckCollectStatus(TESTCASE_PATH, 256));
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("make log path failed"));
}