/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"

#define private public
#define protected public
#include "hdc_client.h"
#undef private
#undef protected

#include "driver/ascend_hal.h"
#include "stub_server_reply.h"
#include "stub_server_msg_impl.h"
#include "inc/version_verify.h"

using namespace tsd;
using namespace std;

class HdcClientTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before HdcClientTest()" << endl;
        HdcClient::hdcClientMap_.clear();
    }

    virtual void TearDown()
    {
        cout << "After HdcClientTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
        HdcClient::hdcClientMap_.clear();
    }
};

TEST_F(HdcClientTest, GetInstance_DevIdOutOfRange_ReturnNull)
{
    auto client = HdcClient::GetInstance(129, HDCServiceType::TSD);
    EXPECT_EQ(client, nullptr);
}

TEST_F(HdcClientTest, GetInstance_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    EXPECT_NE(client, nullptr);
}

TEST_F(HdcClientTest, GetInstance_Twice_ReturnSame)
{
    auto client1 = HdcClient::GetInstance(0, HDCServiceType::TSD);
    auto client2 = HdcClient::GetInstance(0, HDCServiceType::TSD);
    EXPECT_EQ(client1, client2);
}

TEST_F(HdcClientTest, Constructor_Success)
{
    HdcClient client(0, HDCServiceType::TSD);
    EXPECT_EQ(client.deviceId_, 0U);
    EXPECT_EQ(client.type_, HDCServiceType::TSD);
    EXPECT_EQ(client.isClientClose_, true);
    EXPECT_EQ(client.sessionIdNumVec_.size(), 96U);
}

TEST_F(HdcClientTest, GetDeviceId_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    EXPECT_EQ(client->GetDeviceId(), 0U);
}

TEST_F(HdcClientTest, GetHdcServiceType_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    EXPECT_EQ(client->GetHdcServiceType(), HDCServiceType::TSD);
}

TEST_F(HdcClientTest, InitPre_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    TSD_StatusT ret = client->InitPre();
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(client->isClientClose_, false);
}

TEST_F(HdcClientTest, Init_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    TSD_StatusT ret = client->Init(1000, false);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(client->hostPid_, 1000U);
}

TEST_F(HdcClientTest, CreateHdcSession_ClientClosed_Fail)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    uint32_t sessionId = 0;
    TSD_StatusT ret = client->CreateHdcSession(sessionId);
    EXPECT_EQ(ret, TSD_HDC_CLIENT_CLOSED);
}

TEST_F(HdcClientTest, CreateHdcSession_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    client->InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    TSD_StatusT ret = client->CreateHdcSession(sessionId);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_NE(sessionId, 0U);
}

TEST_F(HdcClientTest, GetHdcSession_SessionNotExist_Fail)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    HDC_SESSION session = nullptr;
    TSD_StatusT ret = client->GetHdcSession(999, session);
    EXPECT_EQ(ret, TSD_HDC_SESSION_DO_NOT_EXIST);
}

TEST_F(HdcClientTest, GetHdcSession_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    client->InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client->CreateHdcSession(sessionId);
    
    HDC_SESSION session = nullptr;
    TSD_StatusT ret = client->GetHdcSession(sessionId, session);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(HdcClientTest, GetVersionVerify_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    client->InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client->CreateHdcSession(sessionId);
    
    std::shared_ptr<VersionVerify> inspector = nullptr;
    TSD_StatusT ret = client->GetVersionVerify(sessionId, inspector);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_NE(inspector, nullptr);
}

TEST_F(HdcClientTest, GetHdcConctStatus_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    client->InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client->CreateHdcSession(sessionId);
    
    int32_t hdcSessStat = 0;
    TSD_StatusT ret = client->GetHdcConctStatus(hdcSessStat);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(HdcClientTest, SendMsg_SessionNotExist_Fail)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    HDCMessage msg;
    TSD_StatusT ret = client->SendMsg(999, msg);
    EXPECT_EQ(ret, TSD_HDC_SEND_MSG_ERROR);
}

TEST_F(HdcClientTest, RecvMsg_SessionNotExist_Fail)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    HDCMessage msg;
    TSD_StatusT ret = client->RecvMsg(999, msg, 1000);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
}

TEST_F(HdcClientTest, Destroy_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    client->InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client->CreateHdcSession(sessionId);
    
    client->Destroy();
    EXPECT_EQ(client->isClientClose_, true);
}

TEST_F(HdcClientTest, ClearAllSession_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    client->InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client->CreateHdcSession(sessionId);
    
    client->ClearAllSession();
    EXPECT_EQ(client->hdcClientSessionMap_.empty(), true);
}

TEST_F(HdcClientTest, ClearClientPtr_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    client->InitPre();
    
    client->ClearClientPtr();
    EXPECT_EQ(HdcClient::hdcClientMap_.find(client->index_), HdcClient::hdcClientMap_.end());
}

TEST_F(HdcClientTest, TsdRecvData_Success)
{
    auto client = HdcClient::GetInstance(0, HDCServiceType::TSD);
    client->InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client->CreateHdcSession(sessionId);
    
    TSD_StatusT ret = client->TsdRecvData(sessionId, false, 1000);
    EXPECT_EQ(ret, TSD_OK);
}