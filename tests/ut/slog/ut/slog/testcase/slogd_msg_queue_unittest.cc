/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/ipc.h>
#include <sys/msg.h>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
extern "C" {
    #include "log_common.h"
    #include "msg_queue.h"

    toolMsgid ToolMsgOpen(toolKey key, int32_t msgFlag);
    int32_t ToolMsgSnd(toolMsgid msqid, const void *buf, uint32_t bufLen, int32_t msgFlag);
    int32_t ToolMsgRcv(toolMsgid msqid, void *buf, uint32_t bufLen, int32_t msgFlag, long msgType);
    int32_t ToolMsgClose(toolMsgid msqid);
    LogStatus MsgQueueDelete(toolMsgid queueId);
}
class SlogdMsgQueue : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SlogdMsgQueue::SetUp()
{
}

void SlogdMsgQueue::TearDown()
{}

TEST_F(SlogdMsgQueue, DeleteMsgQueueIdLeZero)
{
    EXPECT_EQ(LOG_INVALID_QUEUE_ID, MsgQueueDelete(-1));
    //GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, DeleteMsgQueueMsgctlFail)
{
    MOCKER(msgctl).stubs().will(returnValue(-1));
    EXPECT_EQ(-1003, MsgQueueDelete(1));
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, DeleteMsgQueueMsgctlSuccess)
{
    MOCKER(msgctl).stubs().will(returnValue(0));
    EXPECT_EQ(0, MsgQueueDelete(1));    
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, DeleteMsgQueueMsgctlSuccess3)
{
    MOCKER(ToolMsgClose).stubs().will(returnValue(2));
    EXPECT_EQ(LOG_FAILURE_DELETE_MSG_QUEUE, MsgQueueDelete(1));
    GlobalMockObject::reset();
}


TEST_F(SlogdMsgQueue, SendMsgIdLeZero)
{
    EXPECT_EQ(LOG_INVALID_QUEUE_ID, MsgQueueSend(-1, NULL, 0, 0));
    
    //GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, SendMsgDataIsZero)
{
    EXPECT_EQ(LOG_INVALID_DATA, MsgQueueSend(1, (void*)0, 0, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, SendMsgLengthLeZero)
{
    LogCmdMsg data = {1, 0, "Msg"};
    EXPECT_EQ(LOG_INVALID_DATA, MsgQueueSend(1, (void*)&data, 0, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, SendMsgWaitIsZero)
{
    LogCmdMsg data = {1, 0, "Msg"};
    
    MOCKER(ToolMsgSnd).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE_SEND_MSG, MsgQueueSend(1, (void*)&data, 3, 0));
    
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, SendMsgWaitGeZero)
{
    LogCmdMsg data = {1, 0, "Msg"};

    MOCKER(ToolMsgSnd).stubs().will(returnValue(1));
    EXPECT_EQ(LOG_FAILURE_SEND_MSG, MsgQueueSend(1, (void*)&data, 3, 10));

    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, SendMsgWaitGeZero2)
{
    LogCmdMsg data = {1, 0, "Msg"};
    
    MOCKER(ToolMsgSnd).stubs().will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, MsgQueueSend(1, (void*)&data, 3, 10));
    
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, RecvMsgIdLeZero)
{
    EXPECT_EQ(LOG_INVALID_QUEUE_ID, MsgQueueRecv(-1, NULL, 0, 0, 1));
    
    //GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, RecvMsgDataIsZero)
{
    EXPECT_EQ(LOG_INVALID_DATA, MsgQueueRecv(1, (void*)0, 0, 0, 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, RecvMsgLengthLeZero)
{
    LogCmdMsg data = {1, 0, "Msg"};
    EXPECT_EQ(LOG_INVALID_DATA, MsgQueueRecv(1, (void*)&data, 0, 0, 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, RecvMsgWaitIsZero)
{
    LogCmdMsg data = {1, 0, "Msg"};

    MOCKER(ToolMsgRcv).stubs().will(returnValue(-1));
    EXPECT_EQ(LOG_FAILURE_RECV_MSG, MsgQueueRecv(1, (void*)&data, 3, 0, 1));

    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, RecvMsgWaitIsZero2)
{
    LogCmdMsg data = {1, 0, "Msg"};

    MOCKER(ToolMsgRcv).stubs().will(returnValue(0));
    EXPECT_EQ(LOG_SUCCESS, MsgQueueRecv(1, (void*)&data, 3, 0, 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, RecvMsgWaitGeZero)
{
    LogCmdMsg data = {1, 0, "Msg"};
    
    MOCKER(ToolMsgRcv).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(LOG_FAILURE_RECV_MSG, MsgQueueRecv(1, (void*)&data, 3, 10, 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, ToolMsgSnd2)
{
    LogCmdMsg buf = { 0, 0, "" };
    int sendLen = 10;;
    MOCKER(msgsnd).stubs().will(returnValue(sendLen));
    EXPECT_EQ(sendLen, ToolMsgSnd(1, (VOID *)(&buf), MSG_MAX_LEN, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, ToolMsgRcv2)
{
    LogCmdMsg buf = { 0, 0, "" };
    int recvLen = 10;
    MOCKER(msgrcv).stubs().will(returnValue(recvLen));
    EXPECT_EQ(recvLen, ToolMsgRcv(1, (VOID *)(&buf), MSG_MAX_LEN, 0, 1));
    GlobalMockObject::reset();
}

TEST_F(SlogdMsgQueue, ToolMsgClose1)
{
    MOCKER(msgctl).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolMsgClose(1));
    GlobalMockObject::reset();
}