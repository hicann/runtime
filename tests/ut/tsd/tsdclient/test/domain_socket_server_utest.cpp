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
#include "mmpa/mmpa_api.h"
#include "inc/internal_api.h"
#include "inc/message_parse_server.h"
#include "inc/log.h"
#include "inc/process_util_server.h"
#include "inc/process_util_common.h"

#define private public
#define protected public
#include "inc/client_manager.h"
#include "inc/domain_socket_server.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;


class DomainSocketServerTest : public testing::Test {
protected:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};


TEST_F(DomainSocketServerTest, Getinstance)
{
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    EXPECT_NE(socketServer, nullptr);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, InitTest)
{
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    socketServer->isServerClose_ = false;
    auto ret = socketServer->Init();
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, AcceptTest_SRV_CLOSED)
{
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    socketServer->acceptSwitch_ = true;
    socketServer->domainScoketServer_ = 1;
    MOCKER_CPP(&DomainSocketServer::AcceptDomainSocketSession)
    .stubs().will(returnValue(static_cast<uint32_t>(TSD_HDC_SRV_CLOSED)));
    auto ret = socketServer->Accept();
    socketServer->acceptSwitch_ = false;
    EXPECT_NE(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, AcceptTest_SRV_CLOSED_002)
{
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    socketServer->acceptSwitch_ = true;
    socketServer->domainScoketServer_ = 1;
    MOCKER_CPP(&DomainSocketServer::AcceptDomainSocketSession)
    .stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR))).
    then(returnValue(static_cast<uint32_t>(TSD_HDC_SRV_CLOSED)));
    auto ret = socketServer->Accept();
    socketServer->acceptSwitch_ = false;
    EXPECT_NE(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, AcceptTest_SRV_CLOSED_003)
{
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    socketServer->acceptSwitch_ = true;
    socketServer->domainScoketServer_ = 1;
    MOCKER_CPP(&DomainSocketServer::AcceptDomainSocketSession)
    .stubs().will(returnValue(static_cast<uint32_t>(TSD_OK))).
    then(returnValue(static_cast<uint32_t>(TSD_HDC_SRV_CLOSED)));
    auto ret = socketServer->Accept();
    socketServer->acceptSwitch_ = false;
    EXPECT_NE(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, IsEndRecvDataThread_TEST)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::SOCKET_CLOSED);
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    auto ret = socketServer->IsEndRecvDataThread(msg, 0);
    msg.set_type(HDCMessage::TSD_CLOSE_PROC_MSG);
    ret = socketServer->IsEndRecvDataThread(msg, 0);
    EXPECT_EQ(ret, true);
}

TEST_F(DomainSocketServerTest, SetAcceptSwitch_TEST)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::SOCKET_CLOSED);
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    socketServer->SetAcceptSwitch(true);
    socketServer->SetRunSwitch(true);
    EXPECT_EQ(socketServer->acceptSwitch_, true);
    EXPECT_EQ(socketServer->recvRunSwitch_, true);
}

TEST_F(DomainSocketServerTest, GetDomainSocketSession_TEST)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::SOCKET_CLOSED);
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    int session = -1;
    auto ret = socketServer->GetDomainSocketSession(0U, session);
    EXPECT_EQ(ret, TSD_HDC_SESSION_DO_NOT_EXIST);
    socketServer->ClearSingleSession(0U);
    socketServer->ClearAllSession();
    socketServer->ClearServerPtr();
}

TEST_F(DomainSocketServerTest, SetHdcMsgBasicInfo_test)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::SOCKET_CLOSED);
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    socketServer->SetHdcMsgBasicInfo(msg, TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED, 0);
    socketServer->SetHdcMsgBasicInfo(msg, tsd::TSD_OK, 0);
    EXPECT_EQ(socketServer->deviceId_, 0U);
}

TEST_F(DomainSocketServerTest, RecvData_test)
{
    HDCMessage msg;
    msg.set_type(HDCMessage::SOCKET_CLOSED);
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    MOCKER_CPP(&DomainSocketCommon::RecvMsg)
    .stubs().will(returnValue(static_cast<uint32_t>(TSD_HDC_SRV_CLOSED)));
    socketServer->recvRunSwitch_ = true;
    socketServer->RecvData(0U);
    EXPECT_EQ(socketServer->deviceId_, 0U);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, RecvData_test_01)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    MOCKER_CPP(&DomainSocketCommon::RecvMsg)
    .stubs().will(returnValue(tsd::TSD_OK));
    socketServer->recvRunSwitch_ = true;
    MOCKER_CPP(&DomainSocketServer::IsEndRecvDataThread)
    .stubs().will(returnValue(true));
    socketServer->RecvData(0U);
    EXPECT_EQ(socketServer->deviceId_, 0U);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, SocketBindToAddress_fail_01)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(0U);
    socketServer->recvRunSwitch_ = true;
    auto ret = socketServer->SocketBindToAddress(-1);
    EXPECT_NE(ret, tsd::TSD_OK);
}

TEST_F(DomainSocketServerTest, Init_fail_001)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(2U);
    MOCKER(socket)
    .stubs().will(returnValue(-1));
    socketServer->isServerClose_ = true;
    auto ret = socketServer->Init();
    EXPECT_EQ(ret, TSD_HDC_SRV_CREATE_ERROR);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, Init_fail_002)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(3U);
    MOCKER(socket).stubs().will(returnValue(0));
    MOCKER_CPP(&DomainSocketServer::SocketBindToAddress)
    .stubs().will(returnValue(1));
    socketServer->isServerClose_ = true;
    auto ret = socketServer->Init();
    EXPECT_EQ(ret, TSD_HDC_SRV_CREATE_ERROR);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, Init_fail_003)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(4U);
    MOCKER_CPP(&DomainSocketServer::SocketBindToAddress)
    .stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(listen)
    .stubs().will(returnValue(-1));
    socketServer->isServerClose_ = true;
    auto ret = socketServer->Init();
    EXPECT_EQ(ret, TSD_HDC_SRV_CREATE_ERROR);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, Init_Success)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(7U);
    MOCKER(socket).stubs().will(returnValue(0));
    MOCKER_CPP(&DomainSocketServer::SocketBindToAddress).stubs().will(returnValue(tsd::TSD_OK));
    MOCKER(listen).stubs().will(returnValue(0));
    socketServer->acceptSwitch_ = false;
    socketServer->isServerClose_ = true;
    auto ret = socketServer->Init();
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, AcceptDomainSocketSession_fail_001)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(8U);
    MOCKER_CPP(&DomainSocketServer::SocketBindToAddress)
    .stubs().will(returnValue(tsd::TSD_OK));
    socketServer->isServerClose_ = true;
    uint32_t sessionId = 0U;
    auto ret = socketServer->AcceptDomainSocketSession(sessionId);
    EXPECT_NE(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, AcceptDomainSocketSession_fail_002)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(9U);
    MOCKER_CPP(&DomainSocketServer::SocketBindToAddress)
    .stubs().will(returnValue(tsd::TSD_OK));
    socketServer->isServerClose_ = false;
    socketServer->sessionIdNumVec_.clear();
    uint32_t sessionId = 0U;
    auto ret = socketServer->AcceptDomainSocketSession(sessionId);
    EXPECT_NE(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, AcceptDomainSocketSession_fail_003)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(10U);
    MOCKER_CPP(&DomainSocketServer::SocketBindToAddress)
    .stubs().will(returnValue(tsd::TSD_OK));
    socketServer->isServerClose_ = false;
    MOCKER(accept)
    .stubs().will(returnValue(-1));
    uint32_t sessionId = 0U;
    auto ret = socketServer->AcceptDomainSocketSession(sessionId);
    EXPECT_NE(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, AcceptDomainSocketSession_fail_004)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(10U);
    MOCKER_CPP(&DomainSocketServer::SocketBindToAddress)
    .stubs().will(returnValue(tsd::TSD_OK));
    socketServer->isServerClose_ = false;
    MOCKER(accept)
    .stubs().will(returnValue(0));
    uint32_t sessionId = 0U;
    auto ret = socketServer->AcceptDomainSocketSession(sessionId);
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}

int closeFakeStub(int fd)
{
    return 0;
}

TEST_F(DomainSocketServerTest, DestroyServer_ok_001)
{
    HDCMessage msg;
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(11U);
    socketServer->isServerClose_ = false;
    MOCKER(close).stubs().will(invoke(closeFakeStub));
    socketServer->DestroyServer();
    EXPECT_EQ(socketServer->isServerClose_, true);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketServerTest, Destroy_ok_001)
{
    std::shared_ptr<DomainSocketServer> socketServer = DomainSocketServer::GetInstance(11U);
    socketServer->isServerClose_ = false;
    MOCKER(close).stubs().will(invoke(closeFakeStub));
    auto ret = socketServer->Destroy();
    EXPECT_EQ(ret, tsd::TSD_OK);
    GlobalMockObject::verify();
}