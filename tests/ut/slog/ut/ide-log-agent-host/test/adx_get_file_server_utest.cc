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

#include "log_daemon_server.h"
#include "server_register.h"
#include "adx_component_api_c.h"
#include "cpu_detect.h"
#include "file_monitor_core.h"

using namespace Adx;

class ADX_DUMP_SERVER_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_DUMP_SERVER_UTEST, LogDaemonServersInit)
{
    MOCKER(FileMonitorInit).stubs().will(returnValue(0));
    MOCKER(AdxRegisterComponentFunc).stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxRegisterService).stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxServiceStartup).stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, LogDaemonServersInit());
    EXPECT_EQ(IDE_DAEMON_ERROR, LogDaemonServersInit());
    EXPECT_EQ(IDE_DAEMON_ERROR, LogDaemonServersInit());
    EXPECT_EQ(IDE_DAEMON_OK, LogDaemonServersInit());
}
