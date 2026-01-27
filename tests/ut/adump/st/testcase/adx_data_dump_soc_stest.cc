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
#include <memory>
#define protected public
#define private public
#include "adx_datadump_server.h"
#include "component/adx_server_manager.h"
#include "adx_dump_record.h"
#include "epoll/adx_sock_epoll.h"
#include "commopts/sock_comm_opt.h"
using namespace Adx;
class ADX_DATA_DUMP_SOC_STEST : public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

static mmSsize_t SockRecvDumpDataApiStub(mmSockHandle sockfd, VOID* pstRecvBuf, INT32 recvLen, INT32 recvFlag)
{
    MsgProto* msg = (MsgProto*)pstRecvBuf;
    AdxMsgProto::CreateCtrlMsg(*msg, MsgStatus::MSG_STATUS_NONE_ERROR);
    msg->reqType = IDE_DUMP_REQ;
    msg->msgType = MsgType::MSG_DATA;
    msg->sliceLen = 0;
    msg->totalLen = 0;
    std::cout << "SockRecvDumpDataStub" << recvLen <<std::endl;
    return recvLen;
}

static mmSsize_t SockSendDumpDataApiStub(mmSockHandle sockfd, VOID* pstSendBuf, INT32 sendLen, INT32 sendFlag)
{
    std::cout << "SockSendDumpDataStub" << sendLen <<std::endl;
    return sendLen;
}

TEST_F(ADX_DATA_DUMP_SOC_STEST, IdeDumpSocApiFailed)
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
