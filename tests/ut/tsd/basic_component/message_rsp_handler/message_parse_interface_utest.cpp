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
#include "tsd_message_parse_interface.h"

using namespace tsd;

namespace {
class TestMessageParseInterface final : public MessageParseInterface {
public:
    TestMessageParseInterface() = default;
};

uint32_t g_firstCount = 0U;
uint32_t g_secondCount = 0U;
uint32_t g_sessionId = 0U;
HDCMessage::MsgType g_msgType = HDCMessage::INIT;

void FirstParser(uint32_t sessionId, const HDCMessage& msg)
{
    ++g_firstCount;
    g_sessionId = sessionId;
    g_msgType = msg.type();
}

void SecondParser(uint32_t, const HDCMessage&) { ++g_secondCount; }
} // namespace

class MessageParseInterfaceBehaviorUTest : public testing::Test {
protected:
    void SetUp() override
    {
        g_firstCount = 0U;
        g_secondCount = 0U;
        g_sessionId = 0U;
        g_msgType = HDCMessage::INIT;
    }
};

TEST_F(MessageParseInterfaceBehaviorUTest, FirstRegistrationDispatchesMatchingMessage)
{
    TestMessageParseInterface parser;
    parser.RegisterMsgProcess(HDCMessage::TEST_HDC_SEND, FirstParser);
    HDCMessage msg;
    msg.set_type(HDCMessage::TEST_HDC_SEND);

    parser.ProcessMessage(123U, msg);

    EXPECT_EQ(g_firstCount, 1U);
    EXPECT_EQ(g_sessionId, 123U);
    EXPECT_EQ(g_msgType, HDCMessage::TEST_HDC_SEND);
}

TEST_F(MessageParseInterfaceBehaviorUTest, RegistrationForSameTypeReplacesParser)
{
    TestMessageParseInterface parser;
    parser.RegisterMsgProcess(HDCMessage::TEST_HDC_SEND, FirstParser);
    parser.RegisterMsgProcess(HDCMessage::TEST_HDC_SEND, SecondParser);
    HDCMessage msg;
    msg.set_type(HDCMessage::TEST_HDC_SEND);

    parser.ProcessMessage(1U, msg);

    EXPECT_EQ(g_firstCount, 0U);
    EXPECT_EQ(g_secondCount, 1U);
}

TEST_F(MessageParseInterfaceBehaviorUTest, NullParserReplacesExistingParserWithoutDispatch)
{
    TestMessageParseInterface parser;
    parser.RegisterMsgProcess(HDCMessage::TEST_HDC_SEND, FirstParser);
    parser.RegisterMsgProcess(HDCMessage::TEST_HDC_SEND, nullptr);
    HDCMessage msg;
    msg.set_type(HDCMessage::TEST_HDC_SEND);

    parser.ProcessMessage(1U, msg);

    EXPECT_EQ(g_firstCount, 0U);
}

TEST_F(MessageParseInterfaceBehaviorUTest, UnknownTypeDoesNotDispatch)
{
    TestMessageParseInterface parser;
    parser.RegisterMsgProcess(HDCMessage::TEST_HDC_SEND, FirstParser);
    HDCMessage msg;
    msg.set_type(HDCMessage::INIT);

    parser.ProcessMessage(1U, msg);

    EXPECT_EQ(g_firstCount, 0U);
}

TEST_F(MessageParseInterfaceBehaviorUTest, MultipleTypesDispatchOnlyMatchingParser)
{
    TestMessageParseInterface parser;
    parser.RegisterMsgProcess(HDCMessage::TEST_HDC_SEND, FirstParser);
    parser.RegisterMsgProcess(HDCMessage::INIT, SecondParser);
    HDCMessage msg;
    msg.set_type(HDCMessage::INIT);

    parser.ProcessMessage(1U, msg);

    EXPECT_EQ(g_firstCount, 0U);
    EXPECT_EQ(g_secondCount, 1U);
}
