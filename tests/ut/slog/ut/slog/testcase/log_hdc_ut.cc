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

#include "log_hdc.h"
#include "log_session_manage.h"
#include "log_common.h"
#include "hdc_api.h"

using namespace Adx;
static const std::string INSERT_MSG = "###[HDC_MSG]_DEVICE_FRAMEWORK_START_###";
static const std::string DELETE_MSG = "###[HDC_MSG]_DEVICE_FRAMEWORK_END_###";

class ADX_LOG_HDC_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_LOG_HDC_TEST, Init)
{
    Adx::LogHdc LogHdc;
    EXPECT_EQ(IDE_DAEMON_OK, LogHdc.Init());
}

TEST_F(ADX_LOG_HDC_TEST, UnInit)
{
    Adx::LogHdc LogHdc;
    EXPECT_EQ(IDE_DAEMON_OK, LogHdc.UnInit());
}

SessionNode *g_node = NULL;
static SessionNode* GetSessionNodeStub(uint32_t pid, uint32_t devId)
{
    if(g_node == NULL){
        g_node = (SessionNode *)malloc(sizeof(SessionNode));
    }
    return g_node;
}

static SessionNode* GetSessionNodeNullStub(uint32_t pid, uint32_t devId)
{
    return NULL;
}

static LogRt DeleteSessionNodeStub(uintptr_t session, int pid, int devId)
{
    free(g_node);
    return (LogRt)IDE_DAEMON_OK;
}

TEST_F(ADX_LOG_HDC_TEST, Process)
{
    LogHdc LogHdc;
    CommHandle handle = ADX_COMMOPT_INVALID_HANDLE(OptType::COMM_HDC);
    handle.type = OptType::COMM_HDC;
    handle.session = 0x123456789;

    MsgProto *proto = (MsgProto *)malloc(sizeof(MsgProto)+100);
    proto->msgType = MsgType::MSG_DATA;
    proto->status = MsgStatus::MSG_STATUS_HAND_SHAKE;
    LogNotifyMsg *msg = (LogNotifyMsg *)proto->data;
    strcpy(msg->data, INSERT_MSG.c_str());
    SharedPtr<MsgProto> protoPtrs(proto, free);

    MOCKER(IdeGetDevIdBySession)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(IdeGetPidBySession)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(InsertSessionNode).stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(GetSessionNode).stubs()
        .will(invoke(GetSessionNodeStub))
        .then(invoke(GetSessionNodeNullStub));

    MOCKER(IsSessionNodeListNull).stubs()
        .will(returnValue(true));

    MOCKER(DeleteSessionNode).stubs()
        .will(invoke(DeleteSessionNodeStub));

    EXPECT_EQ(IDE_DAEMON_OK, LogHdc.Init());
    EXPECT_EQ(IDE_DAEMON_ERROR, LogHdc.Process(handle, protoPtrs));
    EXPECT_EQ(IDE_DAEMON_ERROR, LogHdc.Process(handle, protoPtrs));
    EXPECT_EQ(IDE_DAEMON_OK, LogHdc.Process(handle, protoPtrs));
    strcpy(msg->data, DELETE_MSG.c_str());
    EXPECT_EQ(IDE_DAEMON_OK, LogHdc.Process(handle, protoPtrs));
    EXPECT_EQ(IDE_DAEMON_OK, LogHdc.Process(handle, protoPtrs));
    strcpy(msg->data, "TEST FAILED");
    EXPECT_EQ(IDE_DAEMON_ERROR, LogHdc.Process(handle, protoPtrs));

    EXPECT_EQ(IDE_DAEMON_OK, LogHdc.UnInit());
}
