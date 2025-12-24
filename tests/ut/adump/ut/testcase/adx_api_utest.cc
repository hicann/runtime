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

#include "epoll/adx_hdc_epoll.h"
#include "protocol/adx_msg_proto.h"
#include "commopts/hdc_comm_opt.h"
#include "log/adx_log.h"
#include "memory_utils.h"
#include "hdc_api.h"
#include "adx_api.h"
#include "file_utils.h"
#include "adx_msg.h"
#include "adx_dsmi.h"
#include "config.h"
#include "adcore_api.h"
#include "adx_comm_opt_manager.h"
using namespace Adx;

extern int32_t AdxCommonGetFile(const CommHandle &handle, const std::string &srcFile);

class ADX_API_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

static int HdcReadStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = nullptr;
    msg = (MsgProto *)IdeXmalloc(sizeof(MsgProto));
    msg->msgType = MsgType::MSG_CTRL;
    msg->status = MsgStatus::MSG_STATUS_NONE_ERROR;
    *recvLen = sizeof(MsgProto);
    std::cout<<"<-- adx_api_utest HdcReadStub --> "<<*recvLen <<std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

static int HdcReadNbStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = nullptr;
    msg = (MsgProto *)IdeXmalloc(sizeof(MsgProto));
    msg->msgType = MsgType::MSG_CTRL;
    msg->status = MsgStatus::MSG_STATUS_FILE_LOAD;
    *recvLen = sizeof(MsgProto);
    std::cout<<"<-- adx_api_utest HdcReadNbStub --> "<<*recvLen <<std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

static int32_t HdcReadTimeoutDataStub(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    msg->sliceLen = strlen(srcFile) + 1;
    msg->totalLen = strlen(srcFile) + 1;
    msg->msgType = MsgType::MSG_DATA;
    msg->status = MsgStatus::MSG_STATUS_DATA_END;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

static int32_t HdcReadTimeoutDataErrorStub(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    msg->offset = 0;
    msg->sliceLen = 1;
    msg->totalLen = strlen(srcFile) + 1;
    msg->msgType = MsgType::MSG_DATA;
    msg->status = MsgStatus::MSG_STATUS_DATA_END;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

static int32_t HdcReadTimeoutCtrlStub(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = nullptr;
    msg = (MsgProto *)IdeXmalloc(sizeof(MsgProto));
    msg->msgType = MsgType::MSG_CTRL;
    msg->status = MsgStatus::MSG_STATUS_FILE_LOAD;
    *recvLen = sizeof(MsgProto);
    std::cout<<"<-- adx_api_utest HdcReadTimeoutCtrlStub --> "<<*recvLen <<std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

int g_GetStringMsgDataStub = 0;
static MsgCode GetStringMsgDataStub(const CommHandle &handle, std::string &value)
{
    if(g_GetStringMsgDataStub < 3){
        value = "TEST";
        g_GetStringMsgDataStub += 1;
    } else {
        value = HDC_END_MSG;
        g_GetStringMsgDataStub = 0;
    }

    return IDE_DAEMON_NONE_ERROR;
}

TEST_F(ADX_API_UTEST, AdxGetDeviceFile)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.type = OptType::COMM_HDC;
    handle.session = 0x123456789;
    std::string srcFile = "test"; 

    MOCKER(AdxGetLogIdByPhyId)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(Adx::FileUtils::IsFileExist)
    .stubs()
    .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
    .stubs()
    .will(returnValue(IDE_DAEMON_INVALID_PATH_ERROR))
    .then(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
    .stubs()
    .will(returnValue(1));

    MOCKER(AdxMsgProto::RecvFile)
    .stubs()
    .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
    .then(returnValue(IDE_DAEMON_CHANNEL_ERROR));

    MOCKER(remove)
    .stubs()
    .will(returnValue(1));

    EXPECT_EQ(IDE_DAEMON_OK, AdxGetDeviceFile(0x1, "PATH1", "PATH2"));
}

TEST_F(ADX_API_UTEST, AdxGetDeviceFileScript)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.type = OptType::COMM_HDC;
    handle.session = 0x123456789;
    std::string srcFile = "test";

    MOCKER(AdxGetLogIdByPhyId)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(Adx::FileUtils::IsFileExist)
    .stubs()
    .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
    .stubs()
    .will(returnValue(IDE_DAEMON_INVALID_PATH_ERROR))
    .then(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
    .stubs()
    .will(returnValue(1));

    MOCKER(AdxMsgProto::RecvFile)
    .stubs()
    .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
    .then(returnValue(IDE_DAEMON_CHANNEL_ERROR));

    MOCKER(remove)
    .stubs()
    .will(returnValue(1));

    EXPECT_EQ(IDE_DAEMON_OK, AdxGetDeviceFile(0x1, "PATH1", "hal"));
}

static const int32_t BLOCK_RETURN_CODE = 4;
TEST_F(ADX_API_UTEST, AdxGetDeviceFileDocker)
{
    std::string value = "MESSAGE_CONTAINER_NO_SUPPORT";

    MOCKER(AdxGetLogIdByPhyId)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
    .stubs()
    .with(any(), outBound(value))
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    EXPECT_EQ(BLOCK_RETURN_CODE, AdxGetDeviceFile(0x1, "PATH1", "PATH2"));
}

TEST_F(ADX_API_UTEST, AdxGetDeviceFileEnd)
{
    std::string value = "game_over";

    MOCKER(AdxGetLogIdByPhyId)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
    .stubs()
    .with(any(), outBound(value))
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    EXPECT_EQ(IDE_DAEMON_OK, AdxGetDeviceFile(0x1, "PATH1", "PATH2"));
}

TEST_F(ADX_API_UTEST, AdxGetDeviceFileFileMsgMix)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.type = OptType::COMM_HDC;
    handle.session = 0x123456789;
    std::string srcFile = "test";

    MOCKER(AdxGetLogIdByPhyId)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(HdcReadNb)
    .stubs()
    .will(invoke(HdcReadNbStub));

    MOCKER(Adx::FileUtils::IsFileExist)
    .stubs()
    .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
    .stubs()
    .will(returnValue(IDE_DAEMON_INVALID_PATH_ERROR))
    .then(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
    .stubs()
    .will(returnValue(1));

    MOCKER(AdxMsgProto::RecvFile)
    .stubs()
    .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
    .then(returnValue(IDE_DAEMON_CHANNEL_ERROR));

    MOCKER(remove)
    .stubs()
    .will(returnValue(1));

    EXPECT_EQ(IDE_DAEMON_OK, AdxGetDeviceFile(0x1, "PATH1", "PATH2"));
}

TEST_F(ADX_API_UTEST, AdxGetDeviceFileTimeout)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.type = OptType::COMM_HDC;
    handle.session = 0x123456789;
    std::string srcFile = "test";

    MOCKER(AdxGetLogIdByPhyId)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(HdcReadNb)
    .stubs()
    .will(returnValue(IDE_DAEMON_RECV_NODATA));

    MOCKER(mmSleep)
    .stubs()
    .will(returnValue(0));

    MOCKER(Adx::FileUtils::IsFileExist)
    .stubs()
    .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
    .stubs()
    .will(returnValue(IDE_DAEMON_INVALID_PATH_ERROR))
    .then(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
    .stubs()
    .will(returnValue(1));

    MOCKER(AdxMsgProto::RecvFile)
    .stubs()
    .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
    .then(returnValue(IDE_DAEMON_CHANNEL_ERROR));

    MOCKER(remove)
    .stubs()
    .will(returnValue(1));

    EXPECT_EQ(IDE_DAEMON_OK, AdxGetDeviceFile(0x1, "PATH1", "PATH2"));
}

TEST_F(ADX_API_UTEST, AdxGetDeviceFileGetFileFailed)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.type = OptType::COMM_HDC;
    handle.session = 0x123456789;
    MOCKER(AdxGetLogIdByPhyId)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));

    MOCKER(Adx::AdxMsgProto::SendMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(Adx::AdxMsgProto::GetStringMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR))
    .then(returnValue(IDE_DAEMON_UNKNOW_ERROR));

    MOCKER(Adx::FileUtils::IsFileExist)
    .stubs()
    .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
    .stubs()
    .will(returnValue(IDE_DAEMON_INVALID_PATH_ERROR))
    .then(returnValue(IDE_DAEMON_NONE_ERROR));

    EXPECT_EQ(IDE_DAEMON_OK, AdxGetDeviceFile(0x1, "PATH1", "PATH2"));
}

TEST_F(ADX_API_UTEST, AdxGetDeviceFileRecvFileFailed)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.type = OptType::COMM_HDC;
    handle.session = 0x123456789;

    MOCKER(AdxGetLogIdByPhyId)
    .stubs()
    .will(returnValue(IDE_DAEMON_OK));

    MOCKER(Adx::AdxMsgProto::SendMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(Adx::AdxMsgProto::GetStringMsgData)
    .stubs()
    .will(returnValue(IDE_DAEMON_NONE_ERROR))
    .then(returnValue(IDE_DAEMON_UNKNOW_ERROR));

    MOCKER(Adx::AdxMsgProto::RecvFile)
    .stubs()
    .will(returnValue(IDE_DAEMON_CHANNEL_ERROR));

    EXPECT_EQ(IDE_DAEMON_OK, AdxGetDeviceFile(0x1, "PATH1", "PATH2"));
}

static hdcError_t DrvHdcAllocMsgStub(HDC_SESSION session, struct drvHdcMsg **ppMsg, signed int count)
{
    char *tmp = "tmp_value.";
    uint32_t len = strlen(tmp);
    struct IdeHdcPacket* packet = NULL;
    packet = (struct IdeHdcPacket *)IdeXmalloc(len + sizeof(struct IdeHdcPacket));
    packet->type = IdeDaemonPackageType::IDE_DAEMON_LITTLE_PACKAGE;
    packet->len = len;
    packet->isLast = IdeLastPacket::IDE_LAST_PACK;
    memcpy(packet->value, tmp, len);

    *ppMsg = (drvHdcMsg*)packet;
    return DRV_ERROR_NONE;
}

static drvError_t DrvHdcFreeMsgStub(struct drvHdcMsg *msg)
{
    IdeXfree(msg);
    return DRV_ERROR_NONE;
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFile)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .will(invoke(GetStringMsgDataStub));

    MOCKER(HdcReadTimeout)
        .stubs()
        .will(invoke(HdcReadTimeoutDataStub));

    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(1));

    MOCKER(remove)
        .stubs()
        .will(returnValue(1));

    g_GetStringMsgDataStub = 0;
    EXPECT_EQ(IDE_DAEMON_OK, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileCtrlFail)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .will(invoke(GetStringMsgDataStub));

    MOCKER(HdcReadTimeout)
        .stubs()
        .will(invoke(HdcReadTimeoutCtrlStub));

    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(1));

    MOCKER(remove)
        .stubs()
        .will(returnValue(1));

    g_GetStringMsgDataStub = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileWriteFail)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .will(invoke(GetStringMsgDataStub));

    MOCKER(HdcReadTimeout)
        .stubs()
        .will(invoke(HdcReadTimeoutDataErrorStub));

    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(1));

    MOCKER(mmWrite)
        .stubs()
        .will(returnValue((mmSsize_t)1))
        .then(returnValue((mmSsize_t)(-1)));

    MOCKER(remove)
        .stubs()
        .will(returnValue(1));

    g_GetStringMsgDataStub = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

static uint32_t g_sendErrorTime = 3;
static int32_t AdxSendMsgStub(AdxCommConHandle handle, AdxString data, uint32_t len)
{
    if (--g_sendErrorTime == 0) {
        return IDE_DAEMON_ERROR;
    }
    return IDE_DAEMON_OK;
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileResponseFailWarn)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxSendMsg)
        .stubs()
        .will(invoke(AdxSendMsgStub));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .will(invoke(GetStringMsgDataStub));

    MOCKER(HdcReadTimeout)
        .stubs()
        .will(invoke(HdcReadTimeoutDataStub));

    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(1));

    MOCKER(remove)
        .stubs()
        .will(returnValue(1));

    g_GetStringMsgDataStub = 0;
    g_sendErrorTime = 2;
    EXPECT_EQ(IDE_DAEMON_OK, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
    g_sendErrorTime = 3;
    EXPECT_EQ(IDE_DAEMON_OK, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileInputFailed)
{
    char *path = nullptr;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, path, "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileGetLogIdFailed)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileSendMsgFailed)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.type = OptType::COMM_HDC;
    handle.session = 0x123456789;
    std::string srcFile = "test";

    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileRecvMsgFailed)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.type = OptType::COMM_HDC;
    handle.session = 0x123456789;
    std::string srcFile = "test";

    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR));

    EXPECT_EQ((int32_t)IDE_DAEMON_UNKNOW_ERROR, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileContainer)
{
    const std::string container = "MESSAGE_CONTAINER_NO_SUPPORT";
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .with(any(), outBound(container))
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    EXPECT_EQ(4, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileEnd)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .with(any(), outBound(std::string(HDC_END_MSG)))
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    EXPECT_EQ(IDE_DAEMON_OK, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileCreateDirFailed)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .will(invoke(GetStringMsgDataStub));

    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
        .stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR));

    g_GetStringMsgDataStub = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileOpenFailed)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .will(invoke(GetStringMsgDataStub));

    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1));

    g_GetStringMsgDataStub = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxGetSpecifiedFileRecvFileFailed)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(AdxMsgProto::SendMsgData)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(AdxMsgProto::GetStringMsgData)
        .stubs()
        .will(invoke(GetStringMsgDataStub));

    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false));

    MOCKER(Adx::FileUtils::CreateDir)
        .stubs()
        .will(returnValue(IDE_DAEMON_NONE_ERROR));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(1));

    MOCKER(AdxMsgProto::RecvFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
        .then(returnValue(IDE_DAEMON_CHANNEL_ERROR));

    MOCKER(remove)
        .stubs()
        .will(returnValue(1));

    g_GetStringMsgDataStub = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_UTEST, AdxRecvDevFileTimeout)
{
    AdxCommHandle handle = (AdxCommHandle)malloc(sizeof(CommHandle));
    const char *desPath = "/tmp/adcore_utest";
    char filename[1024] = {0};
    char *value = HDC_END_MSG;
    MOCKER(AdxRecvMsg)
        .stubs()
        .with(any(), outBoundP(&value, sizeof(value)), any(), any())
        .will(returnValue(1))
        .then(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(1, AdxRecvDevFileTimeout(handle, desPath, 1000, filename, 1024));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxRecvDevFileTimeout(handle, desPath, 1000, filename, 1024));

    GlobalMockObject::verify();
    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1));
    value = "test";
    MOCKER(AdxRecvMsg)
        .stubs()
        .with(any(), outBoundP(&value, sizeof(value)), any(), any())
        .will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxRecvDevFileTimeout(handle, desPath, 1000, filename, 1024));
    free(handle);
}

TEST_F(ADX_API_UTEST, AdxRecvDevFileTimeoutSucc)
{
    AdxCommHandle handle = (AdxCommHandle)IdeXmalloc(sizeof(CommHandle));
    const char *desPath = "/tmp/adcore_utest";
    char filename[1024] = {0};
    char *value = "test";
    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(1));
    MOCKER(AdxRecvMsg)
        .stubs()
        .with(any(), outBoundP(&value, sizeof(value)), any(), any())
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER(HdcReadTimeout)
        .stubs()
        .will(invoke(HdcReadTimeoutDataStub));
    EXPECT_EQ(IDE_DAEMON_OK, AdxRecvDevFileTimeout(handle, desPath, 1000, filename, 1024));
    free(handle);
}