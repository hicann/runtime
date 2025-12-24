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
#include "self_log_stub.h"
#include "log_daemon_stub.h"
#include "sys_monitor_frame.h"
#include "sys_monitor_common.h"
#include "log_time.h"
using namespace std;
using namespace testing;

extern "C" {
extern SysmonitorInfo g_sysmonitorInfo[SYS_MONITOR_COUNT];
extern uint32_t g_threadStatus;
}

class EP_SYS_MONITOR_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        ResetErrLog();
    }
 
    virtual void TearDown()
    {
        EXPECT_EQ(0, GetErrLogNum());
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }
 
    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }
 
    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

static int32_t WaitThreadFinish(void)
{
    while (true) {
        if (g_threadStatus != 3) { // exit
            usleep(3000);
            continue;
        }
        break;
    }
    return 0;
}

TEST(EP_SYS_MONITOR_EXCP_UTEST, SysmonitorReadFail)
{
    MOCKER(ToolSleep)
        .stubs()
        .will(returnValue(0));
    MOCKER(read)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    EXPECT_EQ(LOG_SUCCESS, SysmonitorProcess());
    usleep(50000);
    SysmonitorExit();

    EXPECT_EQ(0, WaitThreadFinish());
    EXPECT_EQ(0, LogGetCpuAlarmNum());
    EXPECT_EQ(0, LogGetMemAlarmNum());
    LogClearPrintNum();
}

TEST(EP_SYS_MONITOR_EXCP_UTEST, SysmonitorScanfFail)
{
    MOCKER(ToolSleep)
        .stubs()
        .will(returnValue(0));
    MOCKER(vsscanf_s)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    EXPECT_EQ(LOG_SUCCESS, SysmonitorProcess());
    usleep(50000);
    SysmonitorExit();
    EXPECT_EQ(0, WaitThreadFinish());
    EXPECT_EQ(0, LogGetCpuAlarmNum());
    EXPECT_EQ(0, LogGetMemAlarmNum());
    LogClearPrintNum();
}

TEST(EP_SYS_MONITOR_EXCP_UTEST, SysmonitorSprintfFail)
{
    MOCKER(ToolSleep)
        .stubs()
        .will(returnValue(0));
    MOCKER(vsprintf_s)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(LOG_SUCCESS, SysmonitorInit());
    g_sysmonitorInfo[0].statCount = 1000;
    g_sysmonitorInfo[1].statCount = 1000;
    EXPECT_EQ(LOG_SUCCESS, SysmonitorProcess());
    usleep(50000);
    SysmonitorExit();
    EXPECT_EQ(0, WaitThreadFinish());
    EXPECT_EQ(0, LogGetCpuAlarmNum());
    EXPECT_EQ(0, LogGetMemAlarmNum());
    LogClearPrintNum();
    GlobalMockObject::verify();
}