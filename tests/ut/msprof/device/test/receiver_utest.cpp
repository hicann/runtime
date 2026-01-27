/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <memory>
#include "securec.h"
#include "thread/thread.h"
#include "prof_msg_handler.h"
#include "message/codec.h"
#include "message/dispatcher.h"
#include "transport/hdc/hdc_transport.h"
#include "errno/error_code.h"
#include "prof_task.h"
#include "receiver.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::MsprofErrMgr;

class RECEIVER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        HDC_SESSION session = (HDC_SESSION)0x12345678;
        _transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    }
    virtual void TearDown() {
        _transport.reset();
    }
public:
    std::shared_ptr<analysis::dvvp::transport::HDCTransport> _transport;
};

TEST_F(RECEIVER_TEST, Receiver_destructor) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::Receiver> recv(
        new analysis::dvvp::device::Receiver(_transport));
    EXPECT_EQ(PROFILING_SUCCESS, recv->Uinit());
    recv.reset();
}

TEST_F(RECEIVER_TEST, Init) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::Receiver> recv(
        new analysis::dvvp::device::Receiver(_transport));

    EXPECT_EQ(PROFILING_SUCCESS, recv->Init(0));
}

TEST_F(RECEIVER_TEST, Uinit) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::Receiver> recv(
        new analysis::dvvp::device::Receiver(_transport));

    EXPECT_EQ(PROFILING_SUCCESS, recv->Uinit());
}

TEST_F(RECEIVER_TEST, GetTransport) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::Receiver> recv(
        new analysis::dvvp::device::Receiver(_transport));

    EXPECT_EQ(_transport.get(), recv->GetTransport().get());
}

TEST_F(RECEIVER_TEST, run) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::Receiver> recv(
        new analysis::dvvp::device::Receiver(_transport));

     //before init
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    recv->Run(errorContext);
    EXPECT_EQ(PROFILING_SUCCESS, recv->Init(0));

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> message(new analysis::dvvp::proto::JobStartReq);
    std::string buffer = analysis::dvvp::message::EncodeMessage(message);

    int length = (int)(sizeof(struct tlv_req) + buffer.size());

    std::shared_ptr<char> req_buffer(new char[length], 
                                std::default_delete<char[]>());

    struct tlv_req * req = (struct tlv_req *)req_buffer.get();
    req->len = (int)buffer.size();
    memcpy_s(req->value, req->len, buffer.c_str(), buffer.size());

    MOCKER_CPP_VIRTUAL(_transport.get(), &analysis::dvvp::transport::HDCTransport::RecvPacket)
        .stubs()
        .with(outBoundP(&req))
        .will(returnValue(-1))
        .then(returnValue(length));

    MOCKER_CPP_VIRTUAL(_transport.get(), &analysis::dvvp::transport::HDCTransport::DestroyPacket)
        .stubs();

    MOCKER_CPP(&analysis::dvvp::message::MsgDispatcher::OnNewMessage)
        .stubs();
    recv->Run(errorContext);
    EXPECT_EQ(PROFILING_SUCCESS, recv->Stop());
    recv->Run(errorContext);
}