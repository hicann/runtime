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
#include "log_system_api.h"
#include "log_platform.h"
#include "log_print.h"
#include "self_log_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

using namespace std;
using namespace testing;
extern "C"
{
extern int32_t MergeCheckDir(const char *dir, int32_t mode);
extern int32_t MergeOpenIamService(int32_t *fd);
extern int32_t MergeIoctlCollect(int32_t fd, char *dir, uint32_t len);
int32_t DlogCollectLog(char *dir, uint32_t len);
int32_t DlogCheckCollectStatus(char *dir, uint32_t len);
}

class MDC_MERGESLOG_FUNC_UTEST : public testing::Test
{
    protected:
        virtual void SetUp()
        {
            ResetErrLog();
            system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        }
        virtual void TearDown()
        {
            system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
            GlobalMockObject::verify();
        }
        static void SetUpTestCase()
        {
            system("mkdir -p " PATH_ROOT);
            system("> " LOGOUT_IAM_SERVICE_PATH);
            system("cp " CONF_PATH " " SLOG_CONF_FILE_PATH);
            system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
        }
        static void TearDownTestCase()
        {
            system("rm -rf " PATH_ROOT);
            system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
        }
};

TEST_F(MDC_MERGESLOG_FUNC_UTEST, MergeCheckDir_FAIL)
{
    char dir[256] = "test";
    EXPECT_EQ(MergeCheckDir(dir, R_OK), SYS_ERROR);
    GlobalMockObject::reset();
}

TEST_F(MDC_MERGESLOG_FUNC_UTEST, MergeCheckDir_SUCCESS)
{
    char dir[256] = "test";
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(MergeCheckDir(dir, R_OK), SYS_OK);
    GlobalMockObject::reset();
}

TEST_F(MDC_MERGESLOG_FUNC_UTEST, DlogCollectLog)
{
    char dir[256] = "test";
    uint32_t len = 256;
    MOCKER(MergeCheckDir)
    .stubs()
    .will(returnValue(INVALID))
    .then(returnValue(SYS_OK));

    MOCKER(MergeOpenIamService)
    .stubs()
    .will(returnValue(SYS_ERROR))
    .then(returnValue(SYS_OK));

    MOCKER(MergeIoctlCollect)
    .stubs()
    .will(returnValue(SYS_ERROR))
    .then(returnValue(SYS_OK));

    EXPECT_EQ(MERGE_NO_PERMISSION, DlogCollectLog(dir, len));
    EXPECT_EQ(MERGE_ERROR, DlogCollectLog(dir, len));
    EXPECT_EQ(MERGE_ERROR, DlogCollectLog(dir, len));
    EXPECT_EQ(MERGE_SUCCESS, DlogCollectLog(dir, len));
    GlobalMockObject::reset();
}

TEST_F(MDC_MERGESLOG_FUNC_UTEST, DlogCheckCollectStatus)
{
    char dir[256] = "test";
    uint32_t len = 256;
    MOCKER(MergeCheckDir)
    .stubs()
    .will(returnValue(INVALID))
    .then(returnValue(SYS_OK));

    MOCKER(ToolAccess)
    .stubs()
    .will(returnValue(-1))
    .then(returnValue(0));

    EXPECT_EQ(MERGE_NO_PERMISSION, DlogCheckCollectStatus(dir, len));
    EXPECT_EQ(MERGE_NOT_FOUND, DlogCheckCollectStatus(dir, len));
    EXPECT_EQ(MERGE_SUCCESS, DlogCheckCollectStatus(dir, len));
    GlobalMockObject::reset();
}

TEST_F(MDC_MERGESLOG_FUNC_UTEST, DlogGetLogPatterns)
{
    struct DlogNamePatterns logs;
    EXPECT_EQ(MERGE_SUCCESS, DlogGetLogPatterns(&logs)); 
    EXPECT_EQ(12 + 3 * 3 + 1 + 1, logs.logNum);

    EXPECT_STREQ("/home/mdc/var/log/debug/device-0/", logs.patterns[0].path);
    EXPECT_STREQ("device-0.*_act.log.gz", logs.patterns[0].active);
    EXPECT_STREQ("device-0(?!.*_act).*.gz", logs.patterns[0].rotate);

    EXPECT_STREQ("/home/mdc/var/log/debug/", logs.patterns[1].path);
    EXPECT_STREQ("TSYNC.*_act.log.gz", logs.patterns[1].active);
    EXPECT_STREQ("TSYNC(?!.*_act).*.gz", logs.patterns[1].rotate);

    EXPECT_STREQ("/home/mdc/var/log/debug/device-os*/", logs.patterns[12].path);
    EXPECT_STREQ("device-os.*_act.log.gz", logs.patterns[12].active);
    EXPECT_STREQ("device-os(?!.*_act).*.gz", logs.patterns[12].rotate);

    EXPECT_STREQ("/home/mdc/var/log/debug/device-app*/", logs.patterns[13].path);
    EXPECT_STREQ("device-app.*_act.log.gz", logs.patterns[13].active);
    EXPECT_STREQ("device-app(?!.*_act).*.gz", logs.patterns[13].rotate);

    EXPECT_STREQ("/home/mdc/var/log/debug/aos-core-app*/", logs.patterns[14].path);
    EXPECT_STREQ("aos-core-app.*_act.log.gz", logs.patterns[14].active);
    EXPECT_STREQ("aos-core-app(?!.*_act).*.gz", logs.patterns[14].rotate);

    EXPECT_STREQ("/home/mdc/var/log/run/event/", logs.patterns[21].path);
    EXPECT_STREQ("event.*_act.log.gz", logs.patterns[21].active);
    EXPECT_STREQ("event(?!.*_act).*.gz", logs.patterns[21].rotate);

    EXPECT_STREQ("/home/mdc/var/log/slogd/", logs.patterns[22].path);
    EXPECT_STREQ("slogdlog", logs.patterns[22].active);
    EXPECT_STREQ("slogdlog.old", logs.patterns[22].rotate);

    free(logs.patterns);
}