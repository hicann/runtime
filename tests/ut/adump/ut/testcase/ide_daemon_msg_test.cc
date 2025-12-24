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
#include "adump_device_pub.h"
#include "hdc_api.h"
/*
extern struct IdeMessage *IdeCeateStatusMsg(IdeErrorCode status, const void *data, uint32_t len);

class IDE_DAEMON_MSG_UTEST: public testing::Test {
protected:
   virtual void SetUp() {

   }
   virtual void TearDown() {
       GlobalMockObject::verify();
   }
};

TEST_F(IDE_DAEMON_MSG_UTEST, IdeGetMsgLen)
{
    EXPECT_EQ(0, IdeGetMsgLen(NULL));

    struct IdeMessage *msg = IdeCreateDataMsg("test123", strlen("test123"));
    uint32_t len = offsetof(struct IdeMessage, value.data.data) + strlen("test123");
    EXPECT_EQ(len, IdeGetMsgLen(msg));

    IDE_FREE_MSG_AND_SET_NULL(msg);

    msg = IdeCreateCtrlMsg("end", strlen("end"));
    len = offsetof(struct IdeMessage, value.data.data) + strlen("end");
    EXPECT_EQ(len, IdeGetMsgLen(msg));

    IDE_FREE_MSG_AND_SET_NULL(msg);

    msg = IdeCeateStatusMsg(IDE_DAEMON_WRITE_ERROR, IdeGetStatusError(IDE_DAEMON_NO_SPACE_ERROR), strlen(IdeGetStatusError(IDE_DAEMON_NO_SPACE_ERROR)));
    len = IDE_MSG_STATUS_LEN();
    EXPECT_EQ(len, IdeGetMsgLen(msg));

    IDE_FREE_MSG_AND_SET_NULL(msg);

    msg = (struct IdeMessage *)IdeXmalloc(IDE_MSG_STATUS_LEN());
    IDE_SET_MSG_TYPE(msg, NR_IDE_MESSAGE_TYPE);
    EXPECT_EQ(0, IdeGetMsgLen(msg));

    IDE_FREE_MSG_AND_SET_NULL(msg);
}

TEST_F(IDE_DAEMON_MSG_UTEST, IdeCreateMsgByType)
{
    struct IdeMessage *msg = IdeCreateMsgByType(IDE_MESSAGE_CTRL, "end", 3);
    EXPECT_TRUE(msg != NULL);
    IDE_FREE_MSG_AND_SET_NULL(msg);
    GlobalMockObject::verify();

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOK + 1));

    msg = IdeCreateMsgByType(IDE_MESSAGE_CTRL, "end", 3);
    EXPECT_TRUE(msg == NULL);
    GlobalMockObject::verify();

    msg = IdeCreateMsgByType(NR_IDE_MESSAGE_TYPE, "end", 3);
    EXPECT_TRUE(msg == NULL);
    GlobalMockObject::verify();
}

TEST_F(IDE_DAEMON_MSG_UTEST, IdeCeateStatusMsg)
{
    struct IdeMessage *msg = IdeCeateStatusMsg(IDE_DAEMON_WRITE_ERROR, "write failed", strlen("write failed"));
    EXPECT_TRUE(msg != NULL);
    EXPECT_STREQ("write failed", IDE_GET_MSG_DATA(msg));
    IDE_FREE_MSG_AND_SET_NULL(msg);
    GlobalMockObject::verify();

    msg = IdeCeateStatusMsg(IDE_DAEMON_WRITE_ERROR, NULL, 0);
    EXPECT_TRUE(msg == NULL);
    GlobalMockObject::verify();

    MOCKER(strcpy_s)
        .stubs()
        .will(returnValue(EOK + 1));

    msg = IdeCeateStatusMsg(IDE_DAEMON_WRITE_ERROR, "end", 3);
    EXPECT_TRUE(msg == NULL);
    GlobalMockObject::verify();
}

TEST_F(IDE_DAEMON_MSG_UTEST, IdeSendResponse)
{
    MOCKER(IdeWrite)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    struct IdeTransChannel tranChannel = {IdeChannel::IDE_CHANNEL_HDC, (void *)0x1234};
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, IdeSendResponse(tranChannel, IDE_DAEMON_NONE_ERROR));
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeSendResponse(tranChannel, IDE_DAEMON_NONE_ERROR));
}

TEST_F(IDE_DAEMON_MSG_UTEST, IdeGetResponse)
{
    struct IdeMessage *msg = IdeCeateStatusMsg(IDE_DAEMON_WRITE_ERROR, "write failed", strlen("write failed"));
    int msgLen = IdeGetMsgLen(msg);

    MOCKER(memset_s)
        .stubs()
        .will(returnValue(EOK + 1));
    struct IdeMessage statusMsg = {IDE_MESSAGE_STATUS, {0}};
    struct IdeTransChannel tranChannel = {IdeChannel::IDE_CHANNEL_HDC, (void *)0x1234};
    EXPECT_EQ(IDE_DAEMON_MEMSET_ERROR, IdeGetResponse(tranChannel, &statusMsg));
    GlobalMockObject::verify();

    MOCKER(IdeRead)
        .stubs()
        .with(any(), outBoundP((void **)&msg, sizeof(void *)), outBoundP(&msgLen, sizeof(int)), any())
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOK + 1));
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, IdeGetResponse(tranChannel, &statusMsg));
    EXPECT_EQ(IDE_DAEMON_MEMCPY_ERROR, IdeGetResponse(tranChannel, &statusMsg));
    GlobalMockObject::verify();

    msg = IdeCeateStatusMsg(IDE_DAEMON_WRITE_ERROR, "write failed", strlen("write failed"));
    msgLen = IdeGetMsgLen(msg);
    IDE_SET_MSG_TYPE(msg, IDE_MESSAGE_CTRL);
    MOCKER(IdeRead)
        .stubs()
        .with(any(), outBoundP((void **)&msg, sizeof(void *)), outBoundP(&msgLen, sizeof(int)), any())
        .will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, IdeGetResponse(tranChannel, &statusMsg));
    GlobalMockObject::verify();

    msg = IdeCeateStatusMsg(IDE_DAEMON_WRITE_ERROR, "write failed", strlen("write failed"));
    msgLen = IdeGetMsgLen(msg);
    MOCKER(IdeRead)
        .stubs()
        .with(any(), outBoundP((void **)&msg, sizeof(void *)), outBoundP(&msgLen, sizeof(int)), any())
        .will(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeGetResponse(tranChannel, &statusMsg));
    EXPECT_EQ(IDE_DAEMON_WRITE_ERROR, IDE_GET_MSG_STATUS(&statusMsg));
    EXPECT_EQ(IDE_MESSAGE_STATUS, IDE_MSG_TYPE(&statusMsg));
}

TEST_F(IDE_DAEMON_MSG_UTEST, IdeGetAndCheckResponse)
{
    struct IdeMessage msg = {IDE_MESSAGE_STATUS, {0}};
    IDE_SET_MSG_STATUS(&msg, IDE_DAEMON_CHANNEL_ERROR);
    int msgLen = IdeGetMsgLen(&msg);

    MOCKER(IdeGetResponse)
        .stubs()
        .with(any(), outBoundP(&msg, sizeof(void *)))
        .will(returnValue(IDE_DAEMON_CHANNEL_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR));

    struct IdeTransChannel handle = {IdeChannel::IDE_CHANNEL_HDC, (void *)0x12345};
    EXPECT_FALSE(IdeGetAndCheckResponse(handle));
    EXPECT_FALSE(IdeGetAndCheckResponse(handle));
    GlobalMockObject::verify();

    IDE_SET_MSG_STATUS(&msg, IDE_DAEMON_NONE_ERROR);
    MOCKER(IdeGetResponse)
        .stubs()
        .with(any(), outBoundP(&msg, sizeof(void *)))
        .will(returnValue(IDE_DAEMON_NONE_ERROR));
    EXPECT_TRUE(IdeGetAndCheckResponse(handle));
}

TEST_F(IDE_DAEMON_MSG_UTEST, IdeHandShake)
{
    struct IdeMessage msg = {IDE_MESSAGE_STATUS, {0}};
    IDE_SET_MSG_STATUS(&msg, IDE_DAEMON_CHANNEL_ERROR);
    int msgLen = IdeGetMsgLen(&msg);

    MOCKER(IdeCreatePacket)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    struct IdeTransChannel handle = {IdeChannel::IDE_CHANNEL_HDC, (void *)0x12345};
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeHandShake(handle, IDE_DUMP_REQ, 0, NULL));
    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, IdeHandShake(handle, IDE_DUMP_REQ, 0, &msg));
    GlobalMockObject::verify();

    MOCKER(IdeWrite)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));
    MOCKER(IdeGetAndCheckResponse)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, IdeHandShake(handle, IDE_DUMP_REQ, 0, &msg));
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, IdeHandShake(handle, IDE_DUMP_REQ, 0, &msg));
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeHandShake(handle, IDE_DUMP_REQ, 0, &msg));
}

TEST_F(IDE_DAEMON_MSG_UTEST, IdeGetStatusError)
{
    EXPECT_STREQ("Status Error", IdeGetStatusError(NR_IDE_DAEMON_ERROR));
}
*/
