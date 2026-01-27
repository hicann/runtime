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
#include <thread>
#include "mmpa/mmpa_api.h"
#include "inc/internal_api.h"
#include "inc/message_parse_client.h"
#include "inc/log.h"

#define private public
#define protected public
#include "inc/client_manager.h"
#include "inc/domain_socket_client.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;


class DomainSocketClientTest : public testing::Test {
protected:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

void GetScheduleEnvStub1(const char_t * const envName, std::string &envValue)
{
    envValue = "";
}

TEST_F(DomainSocketClientTest, getsocktfile)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    ASSERT_TRUE(socketClient != nullptr);
    std::string filename;
    socketClient->GetDomainSocketFilePath(filename);
    std::shared_ptr<DomainSocketClient> socketClient2 = DomainSocketClient::GetInstance(200U);
    EXPECT_EQ(socketClient2, nullptr);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, Init_ok)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->isClientClose_ = true;
    MOCKER(socket).stubs().will(returnValue(0));
    MOCKER(connect).stubs().will(returnValue(0));
    MOCKER(setsockopt).stubs().will(returnValue(0));
    auto ret = socketClient->Init(100U);
    EXPECT_EQ(tsd::TSD_OK, ret);
    GlobalMockObject::verify();
}

ssize_t sendFake(int sockfd, const void *buff, size_t nbytes, int flags)
{
    std::cout<<"enter into sendfake"<<std::endl;
    return 0;
}

ssize_t sendFakeFail(int sockfd, const void *buff, size_t nbytes, int flags)
{
    std::cout<<"enter into sendfake"<<std::endl;
    return -1;
}
TEST_F(DomainSocketClientTest, sendMsg_ok)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->clientSocket_ = 1;
    MOCKER(send).stubs().will(invoke(sendFake));
    HDCMessage msg;
    auto ret = socketClient->SendMsg(0U, msg);
    EXPECT_EQ(tsd::TSD_OK, ret);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, RecvMsg_nodata)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->clientSocket_ = 1;
    MOCKER(recv).stubs().will(returnValue(0));
    HDCMessage msg;
    auto ret = socketClient->RecvMsg(0U, msg);
    EXPECT_EQ(TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED, ret);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, RecvMsg_socket_error)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->clientSocket_ = 1;
    MOCKER(recv).stubs().will(returnValue(-1));
    HDCMessage msg;
    auto ret = socketClient->RecvMsg(0U, msg);
    EXPECT_EQ(TSD_HDC_RECV_MSG_ERROR, ret);
    GlobalMockObject::verify();
}

int closeFake(int fd)
{
    return 0;
}
TEST_F(DomainSocketClientTest, destorytest)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->clientSocket_ = 1;
    socketClient->isClientClose_ = false;
    HDCMessage msg;
    MOCKER(close).stubs().will(invoke(closeFake));
    socketClient->Destroy();
    EXPECT_EQ(socketClient->clientSocket_, -1);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, TsdRecvDataTest)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->clientSocket_ = 1;
    MOCKER(recv).stubs().will(returnValue(1));
    HDCMessage msg;
    auto ret = socketClient->TsdRecvData(0U);
    EXPECT_EQ(tsd::TSD_OK, ret);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, ClearClientPtr_fail1)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->isClientClose_ = true;
    socketClient->deviceId_ = 200U;
    MOCKER_CPP(&DomainSocketCommon::RecvMsg).stubs().will(returnValue(1));
    socketClient->ClearClientPtr();
    EXPECT_EQ(socketClient->domainSocketClientMap_.find(200U) == socketClient->domainSocketClientMap_.end(), true);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, GetDomainSocketSession_fail)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->isClientClose_ = true;
    socketClient->clientSocket_ = -1;
    int32_t socketFd = -1;
    auto ret = socketClient->GetDomainSocketSession(0, socketFd);
    EXPECT_NE(tsd::TSD_OK, ret);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, sendmsg_fail_01)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->isClientClose_ = true;
    socketClient->clientSocket_ = -1;
    int32_t socketFd = -1;
    HDCMessage msg;
    auto ret = socketClient->SendMsg(0, msg);
    EXPECT_NE(tsd::TSD_OK, ret);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, sendmsg_fail_02)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->isClientClose_ = true;
    socketClient->clientSocket_ = 1;
    int32_t socketFd = -1;
    HDCMessage msg;
    MOCKER(send).stubs().will(invoke(sendFakeFail));
    auto ret = socketClient->SendMsg(0, msg);
    EXPECT_NE(tsd::TSD_OK, ret);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, recvmsg_fail_01)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->isClientClose_ = true;
    socketClient->clientSocket_ = -1;
    int32_t socketFd = -1;
    HDCMessage msg;
    MOCKER(send).stubs().will(invoke(sendFakeFail));
    auto ret = socketClient->RecvMsg(0, msg);
    EXPECT_NE(tsd::TSD_OK, ret);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, GetDomainSocketFilePath_fail_01)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->isClientClose_ = true;
    socketClient->clientSocket_ = -1;
    int32_t socketFd = -1;
    HDCMessage msg;
    MOCKER(tsd::CheckValidatePath).stubs().will(returnValue(false));
    auto ret = socketClient->RecvMsg(0, msg);
    EXPECT_NE(tsd::TSD_OK, ret);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, GetDomainSocketFilePath_fail_02)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->isClientClose_ = true;
    socketClient->clientSocket_ = -1;
    int32_t socketFd = -1;
    HDCMessage msg;
    MOCKER(tsd::CheckRealPath).stubs().will(returnValue(false));
    auto ret = socketClient->RecvMsg(0, msg);
    EXPECT_NE(tsd::TSD_OK, ret);
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, GetDomainSocketFilePath_fail_03)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    std::string filename = "";
    MOCKER(tsd::GetScheduleEnv).stubs().will(invoke(GetScheduleEnvStub1));
    socketClient->GetDomainSocketFilePath(filename);
    EXPECT_EQ(filename, "/home/HwHiAiUser/tsd_socket_server");
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, GetDomainSocketFilePath_fail_04)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    std::string filename = "";
    MOCKER(tsd::CheckValidatePath).stubs().will(returnValue(false));
    socketClient->GetDomainSocketFilePath(filename);
    EXPECT_EQ(filename, "/home/HwHiAiUser/tsd_socket_server");
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, GetDomainSocketFilePath_fail_05)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    std::string filename = "";
    MOCKER(tsd::CheckValidatePath).stubs().will(returnValue(true));
    MOCKER(tsd::CheckRealPath).stubs().will(returnValue(false));
    socketClient->GetDomainSocketFilePath(filename);
    EXPECT_EQ(filename, "/home/HwHiAiUser/tsd_socket_server");
    GlobalMockObject::verify();
}

TEST_F(DomainSocketClientTest, GetDomainSocketClientDestory)
{
    std::shared_ptr<DomainSocketClient> socketClient = DomainSocketClient::GetInstance(0U);
    socketClient->clientSocket_ = 1;
    EXPECT_EQ(socketClient->deviceId_, 200U);
    GlobalMockObject::verify();
}