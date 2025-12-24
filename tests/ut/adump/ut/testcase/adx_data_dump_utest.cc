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
using namespace Adx;
class ADX_DATA_DUMP_UTEST : public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

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

TEST_F(ADX_DATA_DUMP_UTEST, IdeDumpHdcApiSuccessRemote)
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