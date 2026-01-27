/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <arpa/inet.h>
#include <memory>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "proto/profiler.pb.h"
#include "message/codec.h"

class MESSAGE_CODEC_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(MESSAGE_CODEC_TEST, CreateMessage) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> message(
        new analysis::dvvp::proto::JobStartReq);

    auto created = analysis::dvvp::message::CreateMessage(message->GetTypeName());
    EXPECT_STREQ(message->GetTypeName().c_str(), created->GetTypeName().c_str());
}

TEST_F(MESSAGE_CODEC_TEST, FindMessageTypeByName) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> message(
        new analysis::dvvp::proto::JobStartReq);

    EXPECT_NE((const google::protobuf::Descriptor*)NULL, 
            analysis::dvvp::message::FindMessageTypeByName(message->GetTypeName()));
}

TEST_F(MESSAGE_CODEC_TEST, create_message_FindMessageTypeByName_fail) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> message(
        new analysis::dvvp::proto::JobStartReq);

    MOCKER(&analysis::dvvp::message::FindMessageTypeByName)
        .stubs()
        .will(returnValue((const google::protobuf::Descriptor*)NULL));

    auto created = analysis::dvvp::message::CreateMessage(message->GetTypeName());
    EXPECT_EQ((google::protobuf::Message const *)NULL, created.get());
}

TEST_F(MESSAGE_CODEC_TEST, create_message_GetPrototype_fail) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> message(
        new analysis::dvvp::proto::JobStartReq);

    MOCKER_CPP_VIRTUAL(google::protobuf::MessageFactory::generated_factory(), &google::protobuf::MessageFactory::GetPrototype)
        .stubs()
        .will(returnValue((google::protobuf::Message const*)NULL));

    auto created = analysis::dvvp::message::CreateMessage(message->GetTypeName());
    EXPECT_EQ((google::protobuf::Message const *)NULL, created.get());
}

TEST_F(MESSAGE_CODEC_TEST, AppendMessage) {
    GlobalMockObject::verify();

    std::string out;
    std::shared_ptr<analysis::dvvp::proto::JobStartReq> message(
        new analysis::dvvp::proto::JobStartReq);

    EXPECT_TRUE(analysis::dvvp::message::AppendMessage(out, message));
}

TEST_F(MESSAGE_CODEC_TEST, EncodeMessage) {
    GlobalMockObject::verify();

    std::shared_ptr<google::protobuf::Message> message_null;
    EXPECT_EQ(0, (int)analysis::dvvp::message::EncodeMessage(message_null).size());

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> message(
        new analysis::dvvp::proto::JobStartReq);

    MOCKER(analysis::dvvp::message::AppendMessage)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    EXPECT_EQ(0, (int)analysis::dvvp::message::EncodeMessage(message).size());
    EXPECT_NE(0, (int)analysis::dvvp::message::EncodeMessage(message).size());
}

TEST_F(MESSAGE_CODEC_TEST, EncodeMessageShared) {
    GlobalMockObject::verify();

    std::shared_ptr<google::protobuf::Message> message_null;
    EXPECT_EQ(nullptr, analysis::dvvp::message::EncodeMessageShared(message_null));

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> message(
        new analysis::dvvp::proto::JobStartReq);

    MOCKER(analysis::dvvp::message::AppendMessage)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    EXPECT_EQ(nullptr, analysis::dvvp::message::EncodeMessageShared(message));
    EXPECT_NE(nullptr, analysis::dvvp::message::EncodeMessageShared(message));
}

TEST_F(MESSAGE_CODEC_TEST, decode_message_name_len) {
    GlobalMockObject::verify();

    char * data = new char[3];
    std::string buffer(data, 3);
    delete [] data;

    auto dec = analysis::dvvp::message::DecodeMessage(buffer);

    EXPECT_EQ(NULL, dec.get());

    const int maxBufSize = 128 * 1024 * 1024 + 10;
    data = new char[maxBufSize];
    std::string newBuffer(data, maxBufSize);
    delete [] data;

    dec = analysis::dvvp::message::DecodeMessage(newBuffer);
    EXPECT_EQ(NULL, dec.get());
}

TEST_F(MESSAGE_CODEC_TEST, decode_message_name) {
    GlobalMockObject::verify();

    char * data = new char[6];
    *(int *)data = ::htonl(10);
    std::string buffer(data, 6);
    delete [] data;

    auto dec = analysis::dvvp::message::DecodeMessage(buffer);

    EXPECT_EQ(NULL, dec.get());
}

TEST_F(MESSAGE_CODEC_TEST, decode_message_create_message_fail) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> enc(
        new analysis::dvvp::proto::JobStartReq);

    std::string buffer = analysis::dvvp::message::EncodeMessage(enc);

    std::shared_ptr<google::protobuf::Message> message;
    MOCKER(analysis::dvvp::message::CreateMessage)
        .stubs()
        .will(returnValue(message));

    auto dec = analysis::dvvp::message::DecodeMessage(buffer);

    EXPECT_EQ(NULL, dec.get());
}

TEST_F(MESSAGE_CODEC_TEST, decode_message_ParseFromArray_fail) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> enc(
        new analysis::dvvp::proto::JobStartReq);

    std::string buffer = analysis::dvvp::message::EncodeMessage(enc);

    MOCKER_CPP(&google::protobuf::Message::ParseFromArray)
        .stubs()
        .will(returnValue(false));

    auto dec = analysis::dvvp::message::DecodeMessage(buffer);

    EXPECT_EQ(NULL, dec.get());
}

TEST_F(MESSAGE_CODEC_TEST, DecodeMessage) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> enc(
        new analysis::dvvp::proto::JobStartReq);

    std::string buffer = analysis::dvvp::message::EncodeMessage(enc);

    auto dec = analysis::dvvp::message::DecodeMessage(buffer);

    EXPECT_STREQ(enc->GetTypeName().c_str(), dec->GetTypeName().c_str());
}