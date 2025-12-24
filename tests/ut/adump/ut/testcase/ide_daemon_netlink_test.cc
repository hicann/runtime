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

#include "mmpa_api.h"
#include "ide_daemon_netlink.h"
#include "ide_daemon_stub.h"
#include "ide_common_util.h"
#include "ide_daemon_dev.h"
#include "common/config.h"

using namespace IdeDaemon::Common::Config;

extern int g_netlink_notify_flag;
class IDE_DAEMON_NETLINK_UTEST: public testing::Test {
protected:
	virtual void SetUp() {
        g_netlink_notify_flag = 0;
	}
	virtual void TearDown() {
        GlobalMockObject::verify();
	}

};

TEST_F(IDE_DAEMON_NETLINK_UTEST, IdeNotifyNetlinkStatus_IdeXmalloc_failed)
{
    MOCKER(IdeXmalloc)
        .stubs()
        .will(returnValue((void *)NULL));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeNotifyNetlinkStatus(1));
}

TEST_F(IDE_DAEMON_NETLINK_UTEST, IdeNetlinkInit)
{
    MOCKER(mmSocket)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(mmBind)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(IdeInsertSock)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeNetlinkInit());
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeNetlinkInit());
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeNetlinkInit());
    EXPECT_EQ(IDE_DAEMON_OK, IdeNetlinkInit());

}

TEST_F(IDE_DAEMON_NETLINK_UTEST, IdeNotifyNetlinkStatus)
{
    MOCKER(recvmsg)
        .stubs()
        .will(invoke(recvmsg_stub));

    MOCKER(IdeCreateSock)
        .stubs()
        .will(returnValue(1));
    MOCKER(IdeInsertSock)
        .stubs()
        .will(returnValue(false));

    g_netlink_notify_flag = 0;
    EXPECT_EQ(IDE_DAEMON_OK, IdeNotifyNetlinkStatus(1));

    g_netlink_notify_flag = 1;
    EXPECT_EQ(IDE_DAEMON_OK, IdeNotifyNetlinkStatus(1));

    g_netlink_notify_flag = 2;
    EXPECT_EQ(IDE_DAEMON_OK, IdeNotifyNetlinkStatus(1));
}

TEST_F(IDE_DAEMON_NETLINK_UTEST, IdeInsertSock)
{
    IdeSockMapDestroy();
    std::string ifName = "eth0";
    EXPECT_EQ(false, IdeInsertSock(ifName, IDE_NETLINK_IP, -1));
    EXPECT_EQ(true, IdeInsertSock(ifName, IDE_NETLINK_IP, 1));
    EXPECT_EQ(false, IdeInsertSock(ifName, IDE_NETLINK_IP, 1));
}

TEST_F(IDE_DAEMON_NETLINK_UTEST, IdeDelSock)
{
    EXPECT_EQ(true, IdeInsertSock("eth0", "192.168.1.111", 1));
    IdeDelSock("eth0", "192.168.1.111");
}

