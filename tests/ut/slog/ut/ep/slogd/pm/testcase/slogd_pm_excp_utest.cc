/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_pm.h"
#include "log_pm_sig.h"
#include "self_log_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

class EP_SLOGD_PM_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " DEFAULT_LOG_WORKSPACE "/*");
        system("rm -rf " LOG_FILE_PATH "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " DEFAULT_LOG_WORKSPACE);
        system("mkdir -p " LOG_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " DEFAULT_LOG_WORKSPACE);
        system("rm -rf " LOG_FILE_PATH);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }

public:

};

// log_pm.h
TEST_F(EP_SLOGD_PM_EXCP_UTEST, LogPmStartInvalidFlag)
{
    // not in docker
    EXPECT_EQ(LOG_FAILURE, LogPmStart(SKLOGD_MONITOR_FLAG + 1, false));
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("monitor does not exist"));
}

TEST_F(EP_SLOGD_PM_EXCP_UTEST, LogSetDaemonizeFail)
{
    MOCKER(daemon).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE, LogSetDaemonize());
    EXPECT_EQ(1, GetErrLogNum());
    EXPECT_EQ(1, CheckErrLog("create daemon failed"));
}