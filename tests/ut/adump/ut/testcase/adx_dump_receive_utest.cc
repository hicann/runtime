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

#include "adx_log.h"
#include "component/adx_server_manager.h"
#include "epoll/adx_hdc_epoll.h"
#include "epoll/adx_hdc_epoll.h"
#include "commopts/hdc_comm_opt.h"
#include "adx_dump_receive.h"
#include "mmpa_api.h"
#include "file_utils.h"
#include "ide_daemon_stub.h"
#include "adx_msg_proto.h"
#include "adx_msg.h"
#include "memory_utils.h"

using namespace Adx;

class ADX_DUMP_RECEIVE_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_DUMP_RECEIVE_TEST, Init)
{
    Adx::AdxDumpReceive adxDumpReceive;
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Init());
}

TEST_F(ADX_DUMP_RECEIVE_TEST, UnInit)
{
    Adx::AdxDumpReceive adxDumpReceive;
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.UnInit());
}

static drvError_t drvHdcEpollWaitStub(HDC_EPOLL epoll, struct drvHdcEvent * events, int maxevents, int timeout, int * eventnum)
{
    events->data = 0x12345678;
    events->events = HDC_EPOLL_SESSION_CLOSE | HDC_EPOLL_CONN_IN | HDC_EPOLL_DATA_IN;
    *eventnum = 3;
    std::cout<<"drvHdcEpollWaitStub Enable"<<std::endl;
    return DRV_ERROR_NONE;
}

static int HdcReadCtrlStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    msg->totalLen = strlen(srcFile) + 1;
    msg->msgType = MsgType::MSG_CTRL;
    msg->status = MsgStatus::MSG_STATUS_DATA_END;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}
static int HdcReadDataStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    const char *srcFile = "adx_server_manager";
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_FILE_GETD_REQ, 0, srcFile, strlen(srcFile) + 1);
    *recvLen = sizeof(MsgProto) + strlen(srcFile) + 1;
    msg->totalLen = strlen(srcFile) + 1;
    msg->msgType = MsgType::MSG_DATA;
    msg->status = MsgStatus::MSG_STATUS_DATA_END;
    *recvBuf = msg;
    return IDE_DAEMON_OK;
}

TEST_F(ADX_DUMP_RECEIVE_TEST, Process)
{
    std::unique_ptr<AdxEpoll> epoll(new(std::nothrow)AdxHdcEpoll());
    std::unique_ptr<AdxComponent> cpn(new(std::nothrow)AdxDumpReceive());
    IDE_CTRL_VALUE_FAILED(cpn != nullptr, , "register epoll error");
    std::unique_ptr<AdxCommOpt> opt(new(std::nothrow)HdcCommOpt());
    IDE_CTRL_VALUE_FAILED(opt != nullptr, , "register epoll error");
    AdxServerManager manager;
    bool ret;
    ret = manager.RegisterEpoll(epoll);
    ret = manager.RegisterCommOpt(opt, std::to_string(HDC_SERVICE_TYPE_IDE_FILE_TRANS));
    IDE_CTRL_VALUE_FAILED(ret, , "register commopt error");
    ret = manager.ComponentAdd(cpn);
    IDE_CTRL_VALUE_FAILED(ret, , "component add error");
    ret = manager.ComponentInit();
    IDE_CTRL_VALUE_FAILED(ret, , "component Init error");
    AdxDumpReceive adxDumpReceive;
    CommHandle handle;
    handle.type = OptType::COMM_HDC;

    MsgProto *proto = (MsgProto *)IdeXmalloc(sizeof(MsgProto));
    proto->msgType = MsgType::MSG_DATA;
    proto->status = MsgStatus::MSG_STATUS_HAND_SHAKE;
    proto->reqType = 1;
    SharedPtr<MsgProto> protoPtrs(proto, IdeXfree);

    MOCKER(AdxMsgProto::SendResponse)
        .stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR))
        .then(returnValue(IDE_DAEMON_UNKNOW_ERROR));

    MOCKER(drvHdcEpollWait).stubs()
        .will(invoke(drvHdcEpollWaitStub))
        .then(invoke(HdcReadDataStub));
    MOCKER(HdcReadNb).stubs()
        .will(invoke(HdcReadCtrlStub))
        .then(invoke(HdcReadDataStub));
    MOCKER(HdcRead).stubs()
        .will(invoke(HdcReadCtrlStub))
        .then(invoke(HdcReadDataStub));

    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Init());
    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.Process(handle, protoPtrs));
    proto->msgType = MsgType::MSG_CTRL;
    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, adxDumpReceive.Process(handle, protoPtrs));
    EXPECT_EQ(IDE_DAEMON_ERROR, adxDumpReceive.Process(handle, protoPtrs));

    EXPECT_EQ(IDE_DAEMON_OK, adxDumpReceive.UnInit());
}
