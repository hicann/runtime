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
#include "device_comm.h"
#include "hdc_client.h"
#undef private
#undef protected

#include "driver/ascend_hal.h"
#include "stub_server_reply.h"
#include "stub_server_msg_impl.h"
#include "inc/version_verify.h"

using namespace tsd;
using namespace std;

namespace {
drvError_t HalHdcGetSessionAttrCloseStub(HDC_SESSION session, int attr, int *value)
{
    (void)session;
    (void)attr;
    if (value != nullptr) {
        *value = HDC_SESSION_STATUS_CLOSE;
    }
    return DRV_ERROR_NONE;
}

uint32_t GetNextTestDeviceId()
{
    static uint32_t nextDeviceId = 0U;
    return nextDeviceId++;
}
}

class HdcClientTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before HdcClientTest()" << endl;
        devId_ = GetNextTestDeviceId();
    }

    virtual void TearDown()
    {
        cout << "After HdcClientTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }

    uint32_t devId_ = 0U;
};

TEST_F(HdcClientTest, GetInstance_DevIdOutOfRange_ReturnNull)
{
    auto client = DeviceComm::GetInstance(129, DeviceCommType::HDC);
    EXPECT_EQ(client, nullptr);
}

TEST_F(HdcClientTest, GetInstance_Success)
{
    auto client = DeviceComm::GetInstance(devId_, DeviceCommType::HDC);
    EXPECT_NE(client, nullptr);
}

TEST_F(HdcClientTest, GetInstance_Twice_ReturnSame)
{
    auto client1 = DeviceComm::GetInstance(devId_, DeviceCommType::HDC);
    auto client2 = DeviceComm::GetInstance(devId_, DeviceCommType::HDC);
    EXPECT_EQ(client1, client2);
}

TEST_F(HdcClientTest, Constructor_Success)
{
    HdcClient client(devId_);
    EXPECT_EQ(client.deviceId_, devId_);
    EXPECT_EQ(client.isClientClose_, true);
    EXPECT_EQ(client.sessionIdNumVec_.size(), 96U);
}

TEST_F(HdcClientTest, GetDeviceId_Success)
{
    HdcClient client(devId_);
    EXPECT_EQ(client.GetDeviceId(), devId_);
}

TEST_F(HdcClientTest, InitPre_Success)
{
    HdcClient client(devId_);
    TSD_StatusT ret = client.InitPre();
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(client.isClientClose_, false);
}

TEST_F(HdcClientTest, Init_Success)
{
    HdcClient client(devId_);
    TSD_StatusT ret = client.CommInit(1000, false);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(client.hostPid_, 1000U);
}

TEST_F(HdcClientTest, CreateHdcSession_ClientClosed_Fail)
{
    HdcClient client(devId_);
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, TSD_HDC_CLIENT_CLOSED);
}

TEST_F(HdcClientTest, CreateHdcSession_Success)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_NE(sessionId, 0U);
}

TEST_F(HdcClientTest, GetHdcSession_SessionNotExist_Fail)
{
    HdcClient client(devId_);
    HDC_SESSION session = nullptr;
    TSD_StatusT ret = client.GetHdcSession(999, session);
    EXPECT_EQ(ret, TSD_HDC_SESSION_DO_NOT_EXIST);
}

TEST_F(HdcClientTest, GetHdcSession_Success)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);
    
    HDC_SESSION session = nullptr;
    TSD_StatusT ret = client.GetHdcSession(sessionId, session);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(HdcClientTest, GetHdcSession_DefaultSessionIdZero_ReturnFirstSession)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    HDC_SESSION session = nullptr;
    TSD_StatusT ret = client.GetHdcSession(0U, session);
    EXPECT_EQ(ret, TSD_OK);
    ASSERT_FALSE(client.hdcClientSessionMap_.empty());
    EXPECT_EQ(session, client.hdcClientSessionMap_.begin()->second);
}

TEST_F(HdcClientTest, GetVersionVerify_Success)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);
    
    std::shared_ptr<VersionVerify> inspector = nullptr;
    TSD_StatusT ret = client.CommGetVersionVerify(sessionId, inspector);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_NE(inspector, nullptr);
}

TEST_F(HdcClientTest, GetVersionVerify_DefaultSessionIdZero_ReturnFirstInspector)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    std::shared_ptr<VersionVerify> inspector = nullptr;
    TSD_StatusT ret = client.CommGetVersionVerify(0U, inspector);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_NE(inspector, nullptr);
}

TEST_F(HdcClientTest, GetHdcConctStatus_Success)
{
    auto client = std::dynamic_pointer_cast<HdcClient>(DeviceComm::GetInstance(0, DeviceCommType::HDC));
    client->InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client->CommCreateSession(sessionId);
    
    int32_t hdcSessStat = 0;
    TSD_StatusT ret = client->CommGetConctStatus(hdcSessStat);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(HdcClientTest, SendMsg_SessionNotExist_Fail)
{
    auto client = std::dynamic_pointer_cast<HdcClient>(DeviceComm::GetInstance(devId_, DeviceCommType::HDC));
    HDCMessage msg;
    TSD_StatusT ret = client->CommSendMsg(999, msg);
    EXPECT_EQ(ret, TSD_HDC_SEND_MSG_ERROR);
}

TEST_F(HdcClientTest, RecvMsg_SessionNotExist_Fail)
{
    HdcClient client(devId_);
    HDCMessage msg;
    TSD_StatusT ret = client.RecvMsg(999, msg, 1000);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
}

TEST_F(HdcClientTest, Destroy_Success)
{
    auto client = std::dynamic_pointer_cast<HdcClient>(DeviceComm::GetInstance(devId_, DeviceCommType::HDC));
    client->InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client->CommCreateSession(sessionId);
    
    client->CommDestroy();
    EXPECT_EQ(client->isClientClose_, true);
}

TEST_F(HdcClientTest, ClearAllSession_Success)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);
    
    client.ClearAllSession();
    EXPECT_EQ(client.hdcClientSessionMap_.empty(), true);
}

TEST_F(HdcClientTest, ClearClientPtr_Success)
{
    auto client = std::dynamic_pointer_cast<HdcClient>(DeviceComm::GetInstance(devId_, DeviceCommType::HDC));
    client->InitPre();

    HdcClient *oldPtr = client.get();
    client->ClearClientPtr();
    auto newClient = std::dynamic_pointer_cast<HdcClient>(DeviceComm::GetInstance(devId_, DeviceCommType::HDC));
    ASSERT_NE(newClient, nullptr);
    EXPECT_NE(newClient.get(), oldPtr);
}

TEST_F(HdcClientTest, CommDestroy_ClearDeviceCommMap_Success)
{
    auto client = std::dynamic_pointer_cast<HdcClient>(DeviceComm::GetInstance(devId_, DeviceCommType::HDC));
    client->InitPre();

    HdcClient *oldPtr = client.get();
    client->CommDestroy();
    EXPECT_EQ(client->isClientClose_, true);
    auto newClient = std::dynamic_pointer_cast<HdcClient>(DeviceComm::GetInstance(devId_, DeviceCommType::HDC));
    ASSERT_NE(newClient, nullptr);
    EXPECT_NE(newClient.get(), oldPtr);
}

TEST_F(HdcClientTest, CommDestroy_ClientAlreadyClosed_KeepDeviceCommMap)
{
    auto client = std::dynamic_pointer_cast<HdcClient>(DeviceComm::GetInstance(devId_, DeviceCommType::HDC));

    client->CommDestroy();
    EXPECT_EQ(client->isClientClose_, true);
    auto sameClient = std::dynamic_pointer_cast<HdcClient>(DeviceComm::GetInstance(devId_, DeviceCommType::HDC));
    ASSERT_NE(sameClient, nullptr);
    EXPECT_EQ(sameClient.get(), client.get());
}

TEST_F(HdcClientTest, TsdRecvData_Success)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);
    
    TSD_StatusT ret = client.CommRecvData(sessionId, false, 1000);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(HdcClientTest, TsdRecvData_IgnoreRecvErr_ReturnRecvError)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    MOCKER(&halHdcRecv).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    TSD_StatusT ret = client.CommRecvData(sessionId, true, 1000);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
}

// =====================================================================
// 异常分支补充用例 - 增加 device_comm/hdc_client.cpp 的覆盖率
// =====================================================================

TEST_F(HdcClientTest, InitPre_DrvHdcClientCreate_AllRetryFail)
{
    HdcClient client(devId_);
    MOCKER(&drvHdcClientCreate).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    MOCKER(&mmSleep).stubs().will(returnValue(0));
    TSD_StatusT ret = client.InitPre();
    EXPECT_EQ(ret, TSD_HDC_CLIENT_INIT_ERROR);
}

TEST_F(HdcClientTest, InitPre_DrvHdcClientCreate_RetryThenSuccess)
{
    HdcClient client(devId_);
    MOCKER(&drvHdcClientCreate).stubs()
        .will(returnValue(DRV_ERROR_INNER_ERR))
        .then(returnValue(DRV_ERROR_NONE));
    MOCKER(&mmSleep).stubs().will(returnValue(0));
    TSD_StatusT ret = client.InitPre();
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(client.isClientClose_, false);
}

TEST_F(HdcClientTest, CommInit_InitMsgSizeFail)
{
    HdcClient client(devId_);
    MOCKER(&drvHdcGetCapacity).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    TSD_StatusT ret = client.CommInit(1000U, false);
    EXPECT_EQ(ret, TSD_HDC_CLIENT_INIT_ERROR);
}

TEST_F(HdcClientTest, CommCreateSession_SessionIdEmpty_Fail)
{
    HdcClient client(devId_);
    client.InitPre();
    client.sessionIdNumVec_.clear();
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, TSD_HDCSESSIONID_NOT_AVAILABLE);
}

TEST_F(HdcClientTest, CommCreateSession_SessionConnect_RepeatedInit)
{
    HdcClient client(devId_);
    client.InitPre();
    MOCKER(&drvHdcSessionConnect).stubs().will(returnValue(DRV_ERROR_REPEATED_INIT));
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, DRV_ERROR_REPEATED_INIT);
}

TEST_F(HdcClientTest, CommCreateSession_SessionConnect_RemoteNotListen)
{
    HdcClient client(devId_);
    client.InitPre();
    MOCKER(&drvHdcSessionConnect).stubs().will(returnValue(DRV_ERROR_REMOTE_NOT_LISTEN));
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, DRV_ERROR_REMOTE_NOT_LISTEN);
}

TEST_F(HdcClientTest, CommCreateSession_SessionConnect_OtherFail)
{
    HdcClient client(devId_);
    client.InitPre();
    MOCKER(&drvHdcSessionConnect).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, TSD_HDC_CREATE_SESSION_FAILED);
}

TEST_F(HdcClientTest, CommCreateSession_SetSessionReferenceFail)
{
    HdcClient client(devId_);
    client.InitPre();
    MOCKER(&drvHdcSetSessionReference).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, TSD_SET_HDCSESSION_REFERENCE_FAILED);
}

TEST_F(HdcClientTest, CommCreateSession_SetSessionReferenceFail_CloseFail)
{
    HdcClient client(devId_);
    client.InitPre();
    MOCKER(&drvHdcSetSessionReference).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    MOCKER(&drvHdcSessionClose).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, TSD_SET_HDCSESSION_REFERENCE_FAILED);
}

TEST_F(HdcClientTest, CommCreateSession_CheckHdcConnection_RecvFail)
{
    HdcClient client(devId_);
    client.InitPre();
    // 不注册回调，halHdcRecv 默认返回 DRV_ERROR_INNER_ERR
    StubServerReply::GetInstance()->ClearAllCallBack();
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
}

TEST_F(HdcClientTest, CommCreateSession_CheckHdcConnection_RspTypeMismatch)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultStartProcMsgProc);
    uint32_t sessionId = 0;
    TSD_StatusT ret = client.CommCreateSession(sessionId);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
}

TEST_F(HdcClientTest, CommGetVersionVerify_NotExist_Fail)
{
    HdcClient client(devId_);
    std::shared_ptr<VersionVerify> inspector = nullptr;
    TSD_StatusT ret = client.CommGetVersionVerify(123U, inspector);
    EXPECT_EQ(ret, TSD_HDC_SESSION_DO_NOT_EXIST);
}

TEST_F(HdcClientTest, CommGetConctStatus_HalGetAPIVersionFail)
{
    HdcClient client(devId_);
    MOCKER(&halGetAPIVersion).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    int32_t hdcSessStat = 0;
    TSD_StatusT ret = client.CommGetConctStatus(hdcSessStat);
    EXPECT_EQ(ret, TSD_HDC_SESSION_STATUS_GET_FAILED);
}

TEST_F(HdcClientTest, CommGetConctStatus_GetSessionAttrFail)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    MOCKER(&halHdcGetSessionAttr).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    int32_t hdcSessStat = 0;
    TSD_StatusT ret = client.CommGetConctStatus(hdcSessStat);
    EXPECT_EQ(ret, TSD_HDC_SESSION_STATUS_GET_FAILED);
}

TEST_F(HdcClientTest, CommGetConctStatus_CloseSession_RecycleSessionId)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    const size_t sessionCount = client.hdcClientSessionMap_.size();
    const size_t verifyCount = client.hdcClientVerifyMap_.size();
    const size_t sessionIdCount = client.sessionIdNumVec_.size();

    MOCKER(&halHdcGetSessionAttr).stubs().will(invoke(HalHdcGetSessionAttrCloseStub));
    int32_t hdcSessStat = HDC_SESSION_STATUS_CONNECT;
    TSD_StatusT ret = client.CommGetConctStatus(hdcSessStat);
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(hdcSessStat, HDC_SESSION_STATUS_CLOSE);
    EXPECT_EQ(client.hdcClientSessionMap_.size(), sessionCount - 1U);
    EXPECT_EQ(client.hdcClientVerifyMap_.size(), verifyCount - 1U);
    EXPECT_EQ(client.sessionIdNumVec_.size(), sessionIdCount + 1U);
}

TEST_F(HdcClientTest, ClearAllSession_SessionCloseFail)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    MOCKER(&drvHdcSessionClose).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    client.ClearAllSession();
    EXPECT_EQ(client.hdcClientSessionMap_.empty(), true);
}

TEST_F(HdcClientTest, ClearClientPtr_DeviceIdNotInMap)
{
    HdcClient client(99);
    client.ClearClientPtr();
    SUCCEED();
}

TEST_F(HdcClientTest, DestroyClient_DrvHdcClientDestroyFail)
{
    HdcClient client(devId_);
    MOCKER(&drvHdcClientDestroy).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    client.DestroyClient();
    EXPECT_EQ(client.isClientClose_, true);
}

TEST_F(HdcClientTest, CommSendMsg_SpecialFeatureCheckFail)
{
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    MOCKER_CPP(&VersionVerify::SpecialFeatureCheck).stubs().will(returnValue(false));
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_START_PROC_MSG);
    TSD_StatusT ret = client.CommSendMsg(sessionId, msg);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
}

// =====================================================================
// 补充用例：InitPre / CommSendMsg / CommRecvData 缺失分支
// =====================================================================

TEST_F(HdcClientTest, InitPre_ClientAlreadyOpen_SkipCreate)
{
    // isClientClose_=false 时，InitPre 应跳过 drvHdcClientCreate 直接返回 TSD_OK
    HdcClient client(devId_);
    client.isClientClose_ = false;
    // 若 drvHdcClientCreate 被调用则测试会因默认 stub 失败；此处验证不会调用
    MOCKER(&drvHdcClientCreate).expects(never());
    TSD_StatusT ret = client.InitPre();
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(client.isClientClose_, false);
}

TEST_F(HdcClientTest, CommSendMsg_Success)
{
    // CommSendMsg 全路径成功：session 存在、SpecialFeatureCheck 通过、halHdcSend 成功
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_START_PROC_MSG);
    TSD_StatusT ret = client.CommSendMsg(sessionId, msg);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(HdcClientTest, CommRecvData_RecvFail_NotIgnoreErr_ReturnError)
{
    // recv 返回非 socket-closed 错误，ignoreRecvErr=false 时应返回该错误码
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    MOCKER(&halHdcRecv).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    TSD_StatusT ret = client.CommRecvData(sessionId, false, 1000U);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
}

TEST_F(HdcClientTest, CommRecvData_SocketClosed_IgnoreErr_ReturnSocketClosed)
{
    // recv 返回 DRV_ERROR_SOCKET_CLOSE（→TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED），
    // ignoreRecvErr=true 时直接返回该错误码，不打印 ERROR 级别日志
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    MOCKER(&halHdcRecv).stubs().will(returnValue(DRV_ERROR_SOCKET_CLOSE));
    TSD_StatusT ret = client.CommRecvData(sessionId, true, 1000U);
    EXPECT_EQ(ret, TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED);
}

TEST_F(HdcClientTest, CommRecvData_SocketClosed_NotIgnoreErr_ReturnSocketClosed)
{
    // recv 返回 DRV_ERROR_SOCKET_CLOSE，ignoreRecvErr=false 时同样返回 SOCKET_CLOSED
    HdcClient client(devId_);
    client.InitPre();
    StubServerReply::GetInstance()->RegisterCallBack(HDCMessage::TEST_HDC_SEND,
        StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    uint32_t sessionId = 0;
    client.CommCreateSession(sessionId);

    MOCKER(&halHdcRecv).stubs().will(returnValue(DRV_ERROR_SOCKET_CLOSE));
    TSD_StatusT ret = client.CommRecvData(sessionId, false, 1000U);
    EXPECT_EQ(ret, TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED);
}
