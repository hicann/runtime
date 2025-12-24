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

#include "ide_daemon_hdc_test.h"
#include "mmpa_stub.h"
#include "appmon_lib.h"
#include "ide_daemon_monitor.h"

struct IdeMonitorMgr {
    int status;
    mmThread tid;
    client_info_t clnt;
};

class IDE_DAEMON_MONITOR_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(IDE_DAEMON_MONITOR_UTEST, IdeMonitorThread)
{
    MOCKER(appmon_client_init)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(appmon_client_register)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(IdeMonitorIsRun)
        .stubs()
        .will(repeat(true, 10))
        .then(returnValue(false));

    MOCKER(IdeMonitorIsHeartBeat)
        .stubs()
        .will(repeat(false, 2))
        .then(returnValue(true));

    EXPECT_EQ(IdeMonitorThread(NULL), nullptr);
    EXPECT_EQ(IdeMonitorThread(NULL), nullptr);
    EXPECT_EQ(IdeMonitorThread(NULL), nullptr);
}

TEST_F(IDE_DAEMON_MONITOR_UTEST, IdeMonitorHostInit)
{
    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));

    MOCKER(mmSetThreadName)
        .stubs()
        .will(returnValue(0));

    EXPECT_EQ( 0, IdeMonitorHostInit());
    EXPECT_EQ(-1, IdeMonitorHostInit());
}

TEST_F(IDE_DAEMON_MONITOR_UTEST, IdeMonitorHostDestroy)
{
    MOCKER(mmJoinTask)
        .stubs()
        .will(returnValue(0));

    g_ideMonitorMgr.tid = 1;
    g_ideMonitorMgr.status = 2;
    EXPECT_EQ( 0, IdeMonitorHostDestroy());

    g_ideMonitorMgr.tid = 0;
    g_ideMonitorMgr.status = 0;
}


