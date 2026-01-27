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
#include "adcore_api.h"
#include "file_utils.h"
#include "adx_dsmi.h"
#include "adx_comm_opt_manager.h"
using namespace Adx;

class ADX_API_STEST: public testing::Test {
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
    std::cout<<"<-- adx_api_stest HdcReadStub --> "<<*recvLen <<std::endl;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

static int HdcReadTimeoutStub(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = nullptr;
    msg = (MsgProto *)IdeXmalloc(sizeof(MsgProto));
    msg->msgType = MsgType::MSG_CTRL;
    msg->status = MsgStatus::MSG_STATUS_FILE_LOAD;
    *recvLen = sizeof(MsgProto);
    std::cout<<"<-- adx_api_stest HdcReadTimeoutStub --> "<<*recvLen <<std::endl;
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

static const int32_t BLOCK_RETURN_CODE = 4;
TEST_F(ADX_API_STEST, AdxGetDeviceFileDocker)
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

TEST_F(ADX_API_STEST, AdxGetDeviceFileEnd)
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

TEST_F(ADX_API_STEST, AdxGetDeviceFile)
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

    MOCKER(HdcReadTimeout)
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

TEST_F(ADX_API_STEST, AdxGetDeviceFileScript)
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

    MOCKER(HdcReadTimeout)
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

    EXPECT_EQ(IDE_DAEMON_OK, AdxGetDeviceFile(0x1, "PATH1", "dvpp"));
}

TEST_F(ADX_API_STEST, AdxGetDeviceFileFileMsgMix)
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

    MOCKER(HdcReadTimeout)
    .stubs()
    .will(invoke(HdcReadTimeoutStub));

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

TEST_F(ADX_API_STEST, AdxGetDeviceFileTimeout)
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

    MOCKER(HdcReadTimeout)
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

TEST_F(ADX_API_STEST, AdxGetDeviceFileGetFileFailed)
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

TEST_F(ADX_API_STEST, AdxGetDeviceFileRecvFileFailed)
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

int g_GetStringMsgDataStub = 0;
static MsgCode GetStringMsgDataStub(const CommHandle &handle, std::string &value)
{
    if(g_GetStringMsgDataStub < 2){
        value = "TEST";
        g_GetStringMsgDataStub++;
    } else {
        value = std::string(HDC_END_MSG);
        g_GetStringMsgDataStub = 0;
    }

    return IDE_DAEMON_NONE_ERROR;
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

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileInputFailed)
{
    char *path = nullptr;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, path, "PATH2", 1, 1));
}

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileGetLogIdFailed)
{
    MOCKER(AdxGetLogIdByPhyId)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, AdxGetSpecifiedFile(0x1, "PATH1", "PATH2", 1, 1));
}

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileSendMsgFailed)
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

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileRecvMsgFailed)
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

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileContainer)
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

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileEnd)
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

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileSucc)
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

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileCtrlFail)
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
        .will(invoke(HdcReadTimeoutStub));

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

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileWriteFail)
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

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileCreateDirFailed)
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

TEST_F(ADX_API_STEST, AdxGetSpecifiedFileOpenFailed)
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

TEST_F(ADX_API_STEST, AdxRecvDevFileTimeout)
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