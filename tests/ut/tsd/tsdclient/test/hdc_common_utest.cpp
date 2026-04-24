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
#include "hdc_common.h"
#undef private
#undef protected

#include "driver/ascend_hal.h"
#include "stub_server_reply.h"
#include "stub_server_msg_impl.h"
#include "stub_driver.h"

using namespace tsd;
using namespace std;

class HdcCommonTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before HdcCommonTest()" << endl;
    }

    virtual void TearDown()
    {
        cout << "After HdcCommonTest" << endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(HdcCommonTest, Constructor_Success)
{
    HdcCommon hdcCommon;
    EXPECT_EQ(hdcCommon.isAdcEnv_, false);
    EXPECT_EQ(hdcCommon.msgMaxSize_, 0U);
    EXPECT_EQ(hdcCommon.msgShortHeadDataMaxSize_, 0U);
    EXPECT_EQ(hdcCommon.msgLongHeadDataMaxSize_, 0U);
}

TEST_F(HdcCommonTest, InitMsgSize_Success)
{
    HdcCommon hdcCommon;
    TSD_StatusT ret = hdcCommon.InitMsgSize();
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(hdcCommon.msgMaxSize_, 1024 * 1024);
}

TEST_F(HdcCommonTest, GetMsgMaxSize_Success)
{
    HdcCommon hdcCommon;
    hdcCommon.msgMaxSize_ = 1024;
    uint32_t size = hdcCommon.GetMsgMaxSize();
    EXPECT_EQ(size, 1024);
}

TEST_F(HdcCommonTest, MakeVersionVerifyNoThrow_Success)
{
    HdcCommon hdcCommon;
    auto versionVerify = hdcCommon.MakeVersionVerifyNoThrow();
    EXPECT_NE(versionVerify, nullptr);
}

TEST_F(HdcCommonTest, SendNormalMsg_Success)
{
    HdcCommon hdcCommon;
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_START_PROC_MSG);
    
    TSD_StatusT ret = hdcCommon.SendNormalMsg(msg, session);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(HdcCommonTest, GetHdcAttrStatus_Success)
{
    HdcCommon hdcCommon;
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    int32_t hdcSessStat = 0;
    
    TSD_StatusT ret = hdcCommon.GetHdcAttrStatus(session, hdcSessStat);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(HdcCommonTest, SendNormalShortMsg_SizeZero_Fail)
{
    HdcCommon hdcCommon;
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    HDCMessage msg;
    
    TSD_StatusT ret = hdcCommon.SendNormalShortMsg(msg, 0U, session);
    EXPECT_EQ(ret, TSD_HDC_SEND_MSG_ERROR);
}

TEST_F(HdcCommonTest, SendNormalShortMsg_SizeTooLarge_Fail)
{
    HdcCommon hdcCommon;
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    HDCMessage msg;
    uint32_t largeSize = 0x20000000U;
    
    TSD_StatusT ret = hdcCommon.SendNormalShortMsg(msg, largeSize, session);
    EXPECT_EQ(ret, TSD_INTERGER_REVERSED);
}

TEST_F(HdcCommonTest, InitMsgSize_FailedByDrv)
{
    HdcCommon hdcCommon;
    MOCKER(&drvHdcGetCapacity).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    TSD_StatusT ret = hdcCommon.InitMsgSize();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    EXPECT_EQ(hdcCommon.msgMaxSize_, 0U);
}

TEST_F(HdcCommonTest, SendHdcDefaultMsg_AllocMsgFailed)
{
    HdcCommon hdcCommon;
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    char_t msgBuf[64] = {0};
    
    MOCKER(&drvHdcAllocMsg).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    
    TSD_StatusT ret = hdcCommon.SendHdcDefaultMsg(session, msgBuf, 64U);
    EXPECT_EQ(ret, TSD_HDC_SEND_ERROR);
}

TEST_F(HdcCommonTest, SendHdcDefaultMsg_AddMsgBufferFailed)
{
    HdcCommon hdcCommon;
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    char_t msgBuf[64] = {0};
    
    MOCKER(&drvHdcAddMsgBuffer).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    
    TSD_StatusT ret = hdcCommon.SendHdcDefaultMsg(session, msgBuf, 64U);
    EXPECT_EQ(ret, TSD_HDC_SEND_ERROR);
}

TEST_F(HdcCommonTest, SendHdcDefaultMsg_HalHdcSendFailed)
{
    HdcCommon hdcCommon;
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    char_t msgBuf[64] = {0};
    
    MOCKER(&halHdcSend).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    
    TSD_StatusT ret = hdcCommon.SendHdcDefaultMsg(session, msgBuf, 64U);
    EXPECT_EQ(ret, TSD_HDC_SEND_ERROR);
}

TEST_F(HdcCommonTest, SendHdcDefaultMsg_HalHdcSendSocketClosed)
{
    HdcCommon hdcCommon;
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    char_t msgBuf[64] = {0};
    
    MOCKER(&halHdcSend).stubs().will(returnValue(DRV_ERROR_SOCKET_CLOSE));
    
    TSD_StatusT ret = hdcCommon.SendHdcDefaultMsg(session, msgBuf, 64U);
    EXPECT_EQ(ret, TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED);
}

TEST_F(HdcCommonTest, RecvHdcDefaultMsg_HalHdcRecvFailed)
{
    HdcCommon hdcCommon;
    hdcCommon.InitMsgSize();
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    drvHdcMsg drvMsg;
    char_t* buffer = nullptr;
    uint32_t bufferLengthOut = 0U;
    
    MOCKER(&halHdcRecv).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    
    TSD_StatusT ret = hdcCommon.RecvHdcDefaultMsg(session, &drvMsg, buffer, bufferLengthOut, 1000U);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
}

TEST_F(HdcCommonTest, RecvHdcDefaultMsg_HalHdcRecvSocketClosed)
{
    HdcCommon hdcCommon;
    hdcCommon.InitMsgSize();
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    drvHdcMsg drvMsg;
    char_t* buffer = nullptr;
    uint32_t bufferLengthOut = 0U;
    
    MOCKER(&halHdcRecv).stubs().will(returnValue(DRV_ERROR_SOCKET_CLOSE));
    
    TSD_StatusT ret = hdcCommon.RecvHdcDefaultMsg(session, &drvMsg, buffer, bufferLengthOut, 1000U);
    EXPECT_EQ(ret, TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED);
}

TEST_F(HdcCommonTest, RecvHdcDefaultMsg_GetMsgBufferFailed)
{
    HdcCommon hdcCommon;
    hdcCommon.InitMsgSize();
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    drvHdcMsg drvMsg;
    char_t* buffer = nullptr;
    uint32_t bufferLengthOut = 0U;
    
    MOCKER(&drvHdcGetMsgBuffer).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    
    TSD_StatusT ret = hdcCommon.RecvHdcDefaultMsg(session, &drvMsg, buffer, bufferLengthOut, 1000U);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
}

TEST_F(HdcCommonTest, RecvHdcDefaultMsg_BufferNull)
{
    HdcCommon hdcCommon;
    hdcCommon.InitMsgSize();
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    drvHdcMsg drvMsg;
    char_t* buffer = nullptr;
    uint32_t bufferLengthOut = 0U;
    
    SetHdcGetMsgBufferReturnNull(true);
    TSD_StatusT ret = hdcCommon.RecvHdcDefaultMsg(session, &drvMsg, buffer, bufferLengthOut, 1000U);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
    SetHdcGetMsgBufferReturnNull(false);
}

TEST_F(HdcCommonTest, RecvHdcDefaultMsg_LengthMismatch)
{
    HdcCommon hdcCommon;
    hdcCommon.InitMsgSize();
    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(0x1);
    drvHdcMsg drvMsg;
    char_t* buffer = nullptr;
    uint32_t bufferLengthOut = 0U;
    
    SetHdcGetMsgBufferLengthMismatch(true);
    TSD_StatusT ret = hdcCommon.RecvHdcDefaultMsg(session, &drvMsg, buffer, bufferLengthOut, 1000U);
    EXPECT_EQ(ret, TSD_HDC_RECV_MSG_ERROR);
    SetHdcGetMsgBufferLengthMismatch(false);
}