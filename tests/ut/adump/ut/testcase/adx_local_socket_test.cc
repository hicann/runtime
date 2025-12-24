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
#include "adx_local_socket.h"
#include <string>
#include "utils.h"
#include "common/config.h"
#include "ide_daemon_stub.h"

using std::string;
using namespace IdeDaemon::Common::Utils;
using namespace IdeDaemon::Common::Config;

class ADX_LOCAL_SOCKET_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_LOCAL_SOCKET_UTEST, AdxLocalClientInit)
{
    int fd = 0;
    MOCKER(socket)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(12345));
    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(connect)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(IdeXmalloc)
        .stubs()
        .will(returnValue((void *)nullptr))
        .then(returnValue((void *)&fd));
    MOCKER(close)
        .stubs()
        .will(returnValue(0));

    // socket failed
    EXPECT_TRUE(AdxLocalClientInit() == nullptr);
    // strcpy_s failed
    EXPECT_TRUE(AdxLocalClientInit() == nullptr);
    // connect failed
    EXPECT_TRUE(AdxLocalClientInit() == nullptr);
    // IdeXmalloc failed
    EXPECT_TRUE(AdxLocalClientInit() == nullptr);
    // success
    EXPECT_EQ(AdxLocalClientInit(), &fd);
    std::cout<<"AdxLocalClientInit fd = "<<fd<<std::endl;
    EXPECT_EQ(12345, fd);
}

TEST_F(ADX_LOCAL_SOCKET_UTEST, AdxLocalReadData)
{
    int recvLen = 1;
    IdeSession session = (IdeSession)&recvLen;
    IdeRecvBuffT readBuf = (IdeRecvBuffT)0x12345;
    MOCKER(Getpkt)
        .stubs()
        .will(returnValue(-1));

    // parameter failed
    EXPECT_TRUE(AdxLocalReadData(nullptr, readBuf, &recvLen) == IDE_DAEMON_ERROR);
    // parameter failed
    EXPECT_TRUE(AdxLocalReadData(session, nullptr, &recvLen) == IDE_DAEMON_ERROR);
    // parameter failed
    EXPECT_TRUE(AdxLocalReadData(session, readBuf, nullptr) == IDE_DAEMON_ERROR);
    // IdeXmalloc failed
    EXPECT_EQ(AdxLocalReadData(session, readBuf, &recvLen), -1);
}

TEST_F(ADX_LOCAL_SOCKET_UTEST, AdxLocalWriteData)
{
    int recvLen = 1;
    IdeSession session = (IdeSession)&recvLen;
    IdeSendBuffT readBuf = (IdeSendBuffT)0x12345;
    MOCKER(Putpkt)
        .stubs()
        .will(returnValue(-1));

    // parameter failed
    EXPECT_TRUE(AdxLocalWriteData(nullptr, readBuf, recvLen) == IDE_DAEMON_ERROR);
    // parameter failed
    EXPECT_TRUE(AdxLocalWriteData(session, nullptr, recvLen) == IDE_DAEMON_ERROR);
    // parameter failed
    EXPECT_TRUE(AdxLocalWriteData(session, readBuf, 0) == IDE_DAEMON_ERROR);
    // IdeXmalloc failed
    EXPECT_EQ(AdxLocalWriteData(session, readBuf, recvLen), -1);
}

TEST_F(ADX_LOCAL_SOCKET_UTEST, AdxLocalClientDestroy)
{
    int fd = 1;
    IdeSession session = (IdeSession)&fd;;
    MOCKER(close)
        .stubs()
        .will(returnValue(0));
    MOCKER(IdeXfree)
        .stubs();

    // parameter failed
    AdxLocalClientDestroy(nullptr);
    EXPECT_CALL(AdxLocalClientDestroy(session));
}

TEST_F(ADX_LOCAL_SOCKET_UTEST, AdxLocalServerInit)
{
    MOCKER(socket)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(12345));
    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(bind)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(listen)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(close)
        .stubs()
        .will(returnValue(0));

    // socket failed
    EXPECT_TRUE(AdxLocalServerInit() == -1);
    // strcpy_s failed
    EXPECT_TRUE(AdxLocalServerInit() == -1);
    // bind failed
    EXPECT_TRUE(AdxLocalServerInit() == -1);
    // IdeXmalloc failed
    EXPECT_TRUE(AdxLocalServerInit() == -1);
    // success
    EXPECT_EQ(AdxLocalServerInit(), 12345);
}

TEST_F(ADX_LOCAL_SOCKET_UTEST, AdxLocalServerAccept)
{
    mmSockAddr clientAddr;
    MOCKER(accept)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(12345));

    // parameter failed
    EXPECT_TRUE(AdxLocalServerAccept(-1, clientAddr) == -1);
    // accept failed
    EXPECT_TRUE(AdxLocalServerAccept(1, clientAddr) == -1);
    // accept success
    EXPECT_EQ(AdxLocalServerAccept(1, clientAddr), 12345);
}

