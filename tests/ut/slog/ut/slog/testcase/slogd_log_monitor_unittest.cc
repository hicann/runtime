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
#include "log_pm_sig.h"

extern "C" {
    #include <stdbool.h>
    #include "appmon_lib.h"
    #include "log_pm.h"
    #include "log_monitor.h"
    #include "slogd_utest_stub.h"

    struct LogMonitorMgr {
        int status;
        ToolThread  tid;
        client_info_t clnt;
    };

    enum LOG_MONITOR_STATUS {
    LOG_MONITOR_INIT = 0,
    LOG_MONITOR_RUNNING,
    LOG_MONITOR_HEARTBEAT,
    LOG_MONITOR_EXIT,
    };

    extern struct LogMonitorMgr g_logMonitorMgr;
    extern bool LogMonitorIsRun(void);
    extern void LogMonitorInit(void);
    extern void *LogMonitorThread(void *args);
    extern void LogMonitorSetStatus(int status);
    extern int LogMonitorRegister(unsigned int flagLog);
    extern bool GetLogDaemonScript(char **logDaemonScript);
    extern bool AppMonInit();
}

class LOG_MONITOR : public testing::Test
{
public:
    void SetUp(){
    }
    void TearDown(){
        GlobalMockObject::verify();
    }
};

TEST_F(LOG_MONITOR, LogMonitorIsRun)
{
    g_logMonitorMgr.status = LOG_MONITOR_RUNNING;
    EXPECT_EQ(true, LogMonitorIsRun());
    GlobalMockObject::reset();

    g_logMonitorMgr.status = LOG_MONITOR_HEARTBEAT;
    EXPECT_EQ(true, LogMonitorIsRun());
    GlobalMockObject::reset();

    g_logMonitorMgr.status = LOG_MONITOR_EXIT;
    EXPECT_EQ(false, LogMonitorIsRun());
    GlobalMockObject::reset();
}

extern int g_flag;

TEST_F(LOG_MONITOR, LogMonitorRegister)
{
    g_flag = 1;
    MOCKER(GetLogDaemonScript).stubs().will(returnValue(false));
    EXPECT_EQ(-1, LogMonitorRegister(g_flag));
    GlobalMockObject::reset();

    g_flag = 1;
    MOCKER(GetLogDaemonScript).stubs().will(returnValue(true));
    MOCKER(AppMonInit).stubs().will(returnValue(false));
    EXPECT_EQ(-1, LogMonitorRegister(g_flag));
    GlobalMockObject::reset();

    g_flag = 1;
    MOCKER(GetLogDaemonScript).stubs().will(returnValue(true));
    MOCKER(AppMonInit).stubs().will(returnValue(true));
    MOCKER(appmon_client_register).stubs().will(returnValue(1));
    EXPECT_EQ(-1, LogMonitorRegister(g_flag));
    GlobalMockObject::reset();

    g_flag = 1;
    MOCKER(GetLogDaemonScript).stubs().will(returnValue(true));
    MOCKER(AppMonInit).stubs().will(returnValue(true));
    MOCKER(appmon_client_register).stubs().will(returnValue(11));
    EXPECT_EQ(-1, LogMonitorRegister(g_flag));
    GlobalMockObject::reset();

    g_flag = 1;
    MOCKER(GetLogDaemonScript).stubs().will(returnValue(true));
    MOCKER(AppMonInit).stubs().will(returnValue(true));
    MOCKER(appmon_client_register).stubs().will(returnValue(0));
    MOCKER(appmon_client_heartbeat).stubs().will(returnValue(1));
    EXPECT_EQ(-1, LogMonitorRegister(g_flag));
    GlobalMockObject::reset();

    g_flag = 1;
    MOCKER(GetLogDaemonScript).stubs().will(returnValue(true));
    MOCKER(AppMonInit).stubs().will(returnValue(true));
    MOCKER(appmon_client_register).stubs().will(returnValue(0));
    MOCKER(appmon_client_heartbeat).stubs().will(returnValue(0));
    EXPECT_EQ(0, LogMonitorRegister(g_flag));
    GlobalMockObject::reset();
}