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
#include <sys/epoll.h>
#include "adx_datadump_server.h"
#include "component/adx_server_manager.h"
#include "adx_dump_record.h"
#include "epoll/adx_hdc_epoll.h"
#include "commopts/hdc_comm_opt.h"
#include "hdc_api.h"
#include "config.h"
#include "adx_dsmi.h"
using namespace Adx;
class ADX_DATA_DUMP_STEST : public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        std::cout << "ADX_DATA_DUMP_STEST TearDown" << std::endl;
        GlobalMockObject::verify();
    }
};

static drvError_t drvHdcEpollWaitStub(HDC_EPOLL epoll, struct drvHdcEvent * events, int maxevents, int timeout, int * eventnum)
{
    events->data = 0x12345678;
    events->events = HDC_EPOLL_SESSION_CLOSE | HDC_EPOLL_CONN_IN | HDC_EPOLL_DATA_IN;
    *eventnum = 3;
    std::cout<<"drvHdcEpollWaitStub Enable"<<std::endl;
    return DRV_ERROR_NONE;
}

static int HdcReadShakeHandStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    MsgProto *msg = (MsgProto *)malloc(sizeof(MsgProto));
    (void)AdxMsgProto::CreateCtrlMsg(*msg, MsgStatus::MSG_STATUS_HAND_SHAKE);
    msg->reqType = IDE_DUMP_REQ;
    msg->devId = 0;

    std::cout<<"HdcReadShakeHandStub"<<*recvLen <<std::endl;
    *recvBuf = (void *)msg;
    *recvLen = sizeof(MsgProto);
    return IDE_DAEMON_OK;
}

static int HdcReadDumpDataStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    static int loop = 0;
    if (loop == 0) {
        const char *srcFile = "adx_data_dump_server_manager";
        uint32_t dataLen = strlen(srcFile) + 1 + sizeof(DumpChunk);
        MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
        DumpChunk* data = (DumpChunk *)msg->data;
        data->bufLen = strlen(srcFile) + 1;
        data->flag = 0;
        data->isLastChunk = 1;
        data->offset = -1;
        strcpy(data->fileName, srcFile);
        memcpy(data->dataBuf, srcFile, strlen(srcFile) + 1);
        msg->sliceLen = strlen(srcFile) + 1;
        msg->totalLen = strlen(srcFile) + 1;
        std::cout << "HdcReadDumpDataStub" << std::endl;
        *recvBuf = (void *)msg;
        *recvLen = sizeof(MsgProto) + dataLen;
        loop++;
        return IDE_DAEMON_OK;
    } else {
        MsgProto *msg = (MsgProto *)malloc(sizeof(MsgProto));
        (void)AdxMsgProto::CreateCtrlMsg(*msg, MsgStatus::MSG_STATUS_DATA_END);
        msg->reqType = IDE_DUMP_REQ;
        msg->devId = 0;


        std::cout<<"HdcReadDataEndStub"<<*recvLen <<std::endl;
        *recvBuf = (void *)msg;
        *recvLen = sizeof(MsgProto);
        // set dump record data thread exit
        Adx::AdxDumpRecord::Instance().dumpRecordFlag_ = false;
    }

    return IDE_DAEMON_OK;
}

extern int g_ide_create_task_time;

static int HdcReadDumpDataRemoteStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    static int loop = 0;
    if (loop == 0) {
        const char *srcFile = "127.0.0.1:adx_data_dump_server_manager";
        uint32_t dataLen = strlen(srcFile) + 1 + sizeof(DumpChunk);
        MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
        DumpChunk* data = (DumpChunk *)msg->data;
        data->bufLen = strlen(srcFile) + 1;
        data->flag = 0;
        data->isLastChunk = 1;
        data->offset = -1;
        strcpy(data->fileName, srcFile);
        memcpy(data->dataBuf, srcFile, strlen(srcFile) + 1);
        msg->sliceLen = strlen(srcFile) + 1;
        msg->totalLen = strlen(srcFile) + 1;
        std::cout << "HdcReadDumpDataRemoteStub" << std::endl;
        *recvBuf = (void *)msg;
        *recvLen = sizeof(MsgProto) + dataLen;
        loop++;
        return IDE_DAEMON_OK;
    } else {
        MsgProto *msg = (MsgProto *)malloc(sizeof(MsgProto));
        (void)AdxMsgProto::CreateCtrlMsg(*msg, MsgStatus::MSG_STATUS_DATA_END);
        msg->reqType = IDE_DUMP_REQ;
        msg->devId = 0;

        std::cout<<"HdcReadDumpDataRemoteEndStub"<<*recvLen <<std::endl;
        *recvBuf = (void *)msg;
        *recvLen = sizeof(MsgProto);
        // set dump record data thread exit
        Adx::AdxDumpRecord::Instance().dumpRecordFlag_ = false;
    }

    return IDE_DAEMON_OK;
}


static mmSsize_t SockRecvDumpRemoteStub(mmSockHandle sockfd, VOID* pstRecvBuf, INT32 recvLen, INT32 recvFlag)
{
    std::cout<<"SockRecvDumpRemoteStub"<<recvLen <<std::endl;
    return recvLen;
}

static mmSsize_t SockSendDumpRemoteStub(mmSockHandle sockfd, VOID* pstSendBuf, INT32 sendLen, INT32 sendFlag)
{
    std::cout<<"SockRecvDumpRemoteStub"<<sendLen <<std::endl;
    return sendLen;
}

static mmSsize_t SockRecvDumpDataStub(mmSockHandle sockfd, VOID* pstRecvBuf, INT32 recvLen, INT32 recvFlag)
{
    static int loop = 0;
    const char *srcFile = "/tmp/0/1/;127.0.0.1:adx_data_dump_server_manager";
    if (loop == 0) {
        MsgProto* msg = (MsgProto*)pstRecvBuf;
        AdxMsgProto::CreateCtrlMsg(*msg, MsgStatus::MSG_STATUS_LOAD_DONE);
        msg->reqType = IDE_DUMP_REQ;
        msg->msgType = MsgType::MSG_DATA;
        msg->sliceLen = strlen(srcFile) + 1;
        msg->totalLen = strlen(srcFile) + 1;
        loop = 1;
    } else if (loop == 1) {
        std::cout << "SockRecvDumpDataStub loop : " << loop << " length : " << strlen(srcFile) + 1 <<std::endl;
        memcpy(pstRecvBuf, srcFile, recvLen);
    }
    std::cout << "SockRecvDumpDataStub" << recvLen <<std::endl;
    return recvLen;
}

static mmSsize_t SockSendDumpDataStub(mmSockHandle sockfd, VOID* pstSendBuf, INT32 sendLen, INT32 sendFlag)
{
    std::cout << "SockSendDumpDataStub" << sendLen <<std::endl;
    return sendLen;
}

int SockEpollWaitStub(int epfd, struct epoll_event *events, int maxevents, int timeout)
{
    events[0].events = EPOLLIN;
    events[0].data.fd = 0;
    events[1].events = EPOLLHUP;
    events[1].data.fd = 0;
    std::cout << "SockEpollWaitStub Enable" << std::endl;
    return 2;
}

void EpollMocker()
{
    MOCKER(epoll_create).stubs().will(returnValue(0));
    MOCKER(epoll_ctl).stubs().will(returnValue(0));
    MOCKER(epoll_wait).stubs().will(invoke(SockEpollWaitStub));
}

extern int IdeSockWriteData(IdeSession sock, IdeSendBuffT buf, int len);

static int HdcReadDumpDataApiStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    static int loop = 0;
    MsgProto *msg = (MsgProto *)malloc(sizeof(MsgProto));
    (void)AdxMsgProto::CreateCtrlMsg(*msg, MsgStatus::MSG_STATUS_NONE_ERROR);
    msg->reqType = IDE_DUMP_REQ;
    msg->devId = 0;

    std::cout<<"HdcReadDumpDataApiStub : "<<*recvLen <<std::endl;
    *recvBuf = (void *)msg;
    *recvLen = sizeof(MsgProto);
    return IDE_DAEMON_OK;
}

TEST_F(ADX_DATA_DUMP_STEST, IdeDumpHdcApiSuccessRemote)
{
    MOCKER(HdcRead).stubs()
        .will(invoke(HdcReadDumpDataApiStub));

    MOCKER(HdcReadNb).stubs()
        .will(invoke(HdcReadDumpDataApiStub));

    MOCKER(HdcWrite).stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(HdcWriteNb).stubs()
        .will(returnValue(IDE_DAEMON_OK));

    const char *info = "127.0.0.1:22118;0;1000";
    IDE_SESSION session = IdeDumpStart(info);
    EXPECT_EQ(true, session != nullptr);
    IdeDumpChunk dumpChunk;
    dumpChunk.fileName = "127.0.0.1:adx_data_dump_server_manager";
    dumpChunk.bufLen = strlen("127.0.0.1:adx_data_dump_server_manager");
    dumpChunk.dataBuf = (unsigned char *)"127.0.0.1:adx_data_dump_server_manager";
    dumpChunk.flag = IDE_DUMP_NONE_FLAG;        // flag
    dumpChunk.isLastChunk = 1;                  // last chunk
    dumpChunk.offset = -1;                      // write append
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeDumpData(session, &dumpChunk));
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeDumpEnd(session));
}

TEST_F(ADX_DATA_DUMP_STEST, IdeDumpHdcHelperApiSuccessRemote)
{
    MOCKER(HdcRead).stubs()
        .will(invoke(HdcReadDumpDataApiStub));

    MOCKER(HdcReadNb).stubs()
        .will(invoke(HdcReadDumpDataApiStub));

    MOCKER(HdcWrite).stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(HdcWriteNb).stubs()
        .will(returnValue(IDE_DAEMON_OK));

    const char *info = "127.0.0.1:22118;0;1000";
    std::string hostPID = "1000";
    int ret = setenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str(), hostPID.c_str(), 0);
    IDE_SESSION session = IdeDumpStart(info);
    EXPECT_EQ(true, session != nullptr);
    IdeDumpChunk dumpChunk;
    dumpChunk.fileName = "127.0.0.1:adx_data_dump_server_manager";
    dumpChunk.bufLen = strlen("127.0.0.1:adx_data_dump_server_manager");
    dumpChunk.dataBuf = (unsigned char *)"127.0.0.1:adx_data_dump_server_manager";
    dumpChunk.flag = IDE_DUMP_NONE_FLAG;        // flag
    dumpChunk.isLastChunk = 1;                  // last chunk
    dumpChunk.offset = -1;                      // write append
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeDumpData(session, &dumpChunk));
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeDumpEnd(session));
    ret = unsetenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str());
}

TEST_F(ADX_DATA_DUMP_STEST, IdeDumpHdcApiSuccessLocal)
{
    MOCKER(HdcRead).stubs()
        .will(invoke(HdcReadDumpDataApiStub));

    MOCKER(HdcReadNb).stubs()
        .will(invoke(HdcReadDumpDataApiStub));

    MOCKER(HdcWrite).stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(HdcWriteNb).stubs()
        .will(returnValue(IDE_DAEMON_OK));

    const char *info = "127.0.0.1:22118;0;1000";
    IDE_SESSION session = IdeDumpStart(info);
    EXPECT_EQ(true, session != nullptr);
    IdeDumpChunk dumpChunk;
    dumpChunk.fileName = "adx_data_dump_server_manager";
    dumpChunk.bufLen = strlen("127.0.0.1:adx_data_dump_server_manager");
    dumpChunk.dataBuf = (unsigned char *)"127.0.0.1:adx_data_dump_server_manager";
    dumpChunk.flag = IDE_DUMP_NONE_FLAG;        // flag
    dumpChunk.isLastChunk = 1;                  // last chunk
    dumpChunk.offset = -1;                      // write append
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeDumpData(session, &dumpChunk));
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeDumpEnd(session));
}

TEST_F(ADX_DATA_DUMP_STEST, IdeDumpHdcApiFailed)
{
    // pid error
    std::string info = "127.0.0.1:22118;0;-1";
    IDE_SESSION session = IdeDumpStart(info.c_str());
    EXPECT_EQ(true, session == nullptr);

    // pid error
    info = "127.0.0.1:22118;0;abc";
    session = IdeDumpStart(info.c_str());
    EXPECT_EQ(true, session == nullptr);

    // device error
    info = "127.0.0.1:22118;-1;0";
    session = IdeDumpStart(info.c_str());
    EXPECT_EQ(true, session == nullptr);
    // device error
    info = "127.0.0.1:22118;abc;0";
    session = IdeDumpStart(info.c_str());
    EXPECT_EQ(true, session == nullptr);
}

TEST_F(ADX_DATA_DUMP_STEST, VirtualDeviceEnable)
{
    std::unique_ptr<Adx::AdxCommOpt> opt = std::unique_ptr<Adx::HdcCommOpt>(new Adx::HdcCommOpt());
    auto device = opt->GetDevice();
    EXPECT_EQ(true, device != nullptr);
    std::vector<std::string> devices;
    device->GetAllEnableDevices(1, 31, devices);
    EXPECT_EQ(devices.size(), 0);
    device->GetAllEnableDevices(0, -1, devices);
    EXPECT_EQ(devices.size(), 1);
}

TEST_F(ADX_DATA_DUMP_STEST, GetLogIdByPhyId)
{
    uint32_t phyId = 0;
    uint32_t logId = 0;
    EXPECT_EQ(IdeGetLogIdByPhyId(phyId, &logId), 0);
    EXPECT_EQ(AdxGetLogIdByPhyId(phyId, &logId), 0);
}