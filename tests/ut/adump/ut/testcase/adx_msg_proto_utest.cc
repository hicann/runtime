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

#include "ide_daemon_stub.h"
#include "mmpa_api.h"
#include "adx_msg_proto.h"
#include "adx_msg_proto_utest.h"
#include "ide_hdc_stub.h"
#include "mmpa_stub.h"
#include "adx_comm_opt_manager.h"

using namespace Adx;
class ADX_MSG_PROTO_UTEST: public testing::Test {
protected:
    virtual void SetUp() {

    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_MSG_PROTO_UTEST, SendEventFile)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);

    MOCKER(mmLseek)
    .stubs()
    .will(returnValue((long)1000));

    MOCKER(mmRead)
    .stubs()
    .will(returnValue((long)-1))
    .then(returnValue((long)-1))
    .then(returnValue((long)1000));

    MOCKER(mmGetErrorCode)
    .stubs()
    .will(returnValue(EIO))
    .then(returnValue(0));

    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxMsgProto::SendEventFile(handle, IDE_FILE_GETD_REQ, 0, 1));
    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, AdxMsgProto::SendEventFile(handle, IDE_FILE_GETD_REQ, 0, 1));
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxMsgProto::SendEventFile(handle, IDE_FILE_GETD_REQ, 0, 1));
}

TEST_F(ADX_MSG_PROTO_UTEST, SendFile)
{
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_LOCAL);

    MOCKER(mmLseek)
    .stubs()
    .will(returnValue((long)1000));

    MOCKER(mmRead)
    .stubs()
    .will(returnValue((long)1000));

    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, AdxMsgProto::SendFile(handle, IDE_FILE_GETD_REQ, 0, 1));
}