/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#define private public
#include "inc/tsd_message_parse_client.h"
#undef private

using namespace tsd;

namespace {
uint32_t g_sessionId = 0U;
HDCMessage::MsgType g_msgType = HDCMessage::INIT;

void TestParseFunc(const uint32_t sessionId, const HDCMessage& msg)
{
    g_sessionId = sessionId;
    g_msgType = msg.type();
}
} // namespace

class MessageParseClientUTest : public testing::Test {
protected:
    void SetUp() override
    {
        g_sessionId = 0U;
        g_msgType = HDCMessage::INIT;
    }

    void TearDown() override { MessageParseClient::GetInstance()->parseFuncMap_.erase(HDCMessage::TEST_HDC_SEND); }
};

TEST_F(MessageParseClientUTest, GetInstanceReturnsSingleton)
{
    MessageParseClient* first = MessageParseClient::GetInstance();
    MessageParseClient* second = MessageParseClient::GetInstance();

    EXPECT_NE(first, nullptr);
    EXPECT_EQ(first, second);
}

TEST_F(MessageParseClientUTest, GetInstanceSupportsRegisteredParser)
{
    constexpr uint32_t sessionId = 123U;
    MessageParseClient* client = MessageParseClient::GetInstance();
    ASSERT_NE(client, nullptr);

    client->RegisterMsgProcess(HDCMessage::TEST_HDC_SEND, TestParseFunc);
    HDCMessage msg;
    msg.set_type(HDCMessage::TEST_HDC_SEND);
    client->ProcessMessage(sessionId, msg);

    EXPECT_EQ(g_sessionId, sessionId);
    EXPECT_EQ(g_msgType, HDCMessage::TEST_HDC_SEND);
}
