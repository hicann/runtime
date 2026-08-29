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
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "hdc_api.h"
#include "config.h"

using namespace Adx;
using namespace IdeDaemon::Common::Config;

class TinyHdcApiStubUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(TinyHdcApiStubUtest, Test_ClientApis)
{
    HDC_CLIENT client = nullptr;
    EXPECT_EQ(HdcClientInit(&client), IDE_DAEMON_ERROR);
    EXPECT_EQ(HdcClientCreate(HDC_SERVICE_TYPE_DUMP), nullptr);
    EXPECT_EQ(HdcClientDestroy(client), IDE_DAEMON_ERROR);
}

TEST_F(TinyHdcApiStubUtest, Test_ServerApis)
{
    EXPECT_EQ(HdcServerCreate(0, HDC_SERVICE_TYPE_DUMP), nullptr);
    HDC_SERVER server = nullptr;
    EXPECT_EQ(HdcServerDestroy(server), IDE_DAEMON_ERROR);
    EXPECT_EQ(HdcServerAccept(server), nullptr);
}

TEST_F(TinyHdcApiStubUtest, Test_StorePackage)
{
    IdeHdcPacket packet{};
    packet.len = 0;
    IoVec ioVec{};
    ioVec.base = nullptr;
    ioVec.len = 0;
    EXPECT_EQ(HdcStorePackage(packet, ioVec), IDE_DAEMON_ERROR);
}

TEST_F(TinyHdcApiStubUtest, Test_ReadApis)
{
    HDC_SESSION session = nullptr;
    void* recvBuf = nullptr;
    int32_t recvLen = 0;
    EXPECT_EQ(HdcRead(session, &recvBuf, &recvLen), IDE_DAEMON_ERROR);
    EXPECT_EQ(HdcReadNb(session, &recvBuf, &recvLen), IDE_DAEMON_ERROR);
    EXPECT_EQ(HdcReadTimeout(session, 100, &recvBuf, &recvLen), IDE_DAEMON_ERROR);
}

TEST_F(TinyHdcApiStubUtest, Test_WriteApis)
{
    HDC_SESSION session = nullptr;
    const char data[] = "test";
    EXPECT_EQ(HdcWrite(session, data, sizeof(data)), IDE_DAEMON_ERROR);
    EXPECT_EQ(HdcWriteNb(session, data, sizeof(data)), IDE_DAEMON_ERROR);
    EXPECT_EQ(HdcSessionWrite(session, data, sizeof(data), IDE_DAEMON_BLOCK), IDE_DAEMON_ERROR);
}

TEST_F(TinyHdcApiStubUtest, Test_SessionConnectApis)
{
    HDC_CLIENT client = nullptr;
    HDC_SESSION session = nullptr;
    EXPECT_EQ(HdcSessionConnect(0, 0, client, &session), IDE_DAEMON_ERROR);
    EXPECT_EQ(HalHdcSessionConnect(0, 0, 0, client, &session), IDE_DAEMON_ERROR);
}

TEST_F(TinyHdcApiStubUtest, Test_SessionDestroyApis)
{
    HDC_SESSION session = nullptr;
    EXPECT_EQ(HdcSessionDestroy(session), IDE_DAEMON_ERROR);
    EXPECT_EQ(HdcSessionClose(session), IDE_DAEMON_ERROR);
}

TEST_F(TinyHdcApiStubUtest, Test_Capacity)
{
    uint32_t segment = 0;
    EXPECT_EQ(HdcCapacity(&segment), IDE_DAEMON_ERROR);
}

TEST_F(TinyHdcApiStubUtest, Test_SessionInfoApis)
{
    HDC_SESSION session = nullptr;
    int32_t value = 0;
    EXPECT_EQ(IdeGetDevIdBySession(session, &value), IDE_DAEMON_ERROR);
    EXPECT_EQ(IdeGetRunEnvBySession(session, &value), IDE_DAEMON_ERROR);
    EXPECT_EQ(IdeGetVfIdBySession(session, &value), IDE_DAEMON_ERROR);
    EXPECT_EQ(IdeGetPidBySession(session, &value), IDE_DAEMON_ERROR);
    EXPECT_EQ(IdeGetAttrBySession(session, 0, &value), IDE_DAEMON_ERROR);
}
