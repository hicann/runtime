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
#include "uploader.h"
#include "transport/hdc/hdc_transport.h"
#include "errno/error_code.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Statistics;
using namespace Analysis::Dvvp::MsprofErrMgr;

class UPLOADER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        HDC_SESSION session = (HDC_SESSION)0x12345678;
        analysis::dvvp::transport::HDCTransport hdcTransport(session);
        _transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
        _transport->perfCount_ = std::shared_ptr<PerfCount> (new PerfCount("test"));
    }
    virtual void TearDown() {
        _transport.reset();
    }
public:
    std::shared_ptr<analysis::dvvp::transport::HDCTransport> _transport;
};

TEST_F(UPLOADER_TEST, Uploader_destructor) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::Uploader> uploader(
        new analysis::dvvp::transport::Uploader(_transport));
    uploader->isInited_ = false;
    EXPECT_EQ(PROFILING_SUCCESS, uploader->Uinit());
    uploader.reset();
}

TEST_F(UPLOADER_TEST, Init) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::Uploader> uploader(
        new analysis::dvvp::transport::Uploader(_transport));

    EXPECT_EQ(PROFILING_SUCCESS, uploader->Init());
    EXPECT_TRUE(uploader->isInited_);
}

TEST_F(UPLOADER_TEST, Uinit) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::Uploader> uploader(
        new analysis::dvvp::transport::Uploader(_transport));

    EXPECT_EQ(PROFILING_SUCCESS, uploader->Uinit());
    EXPECT_FALSE(uploader->isInited_);
}

TEST_F(UPLOADER_TEST, UploadData) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::Uploader> uploader(
        new analysis::dvvp::transport::Uploader(_transport));

    std::string buffer("123456");

    EXPECT_EQ(PROFILING_FAILED, uploader->UploadData(buffer.c_str(), buffer.size()));

    EXPECT_EQ(PROFILING_SUCCESS, uploader->Init());
    EXPECT_EQ(PROFILING_SUCCESS, uploader->UploadData(buffer.c_str(), buffer.size()));
}

TEST_F(UPLOADER_TEST, run_uploader_not_init) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::Uploader> uploader(
        new analysis::dvvp::transport::Uploader(_transport));
    EXPECT_NE(nullptr, uploader);
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    uploader->Run(errorContext);
}

TEST_F(UPLOADER_TEST, run_no_data) {
    GlobalMockObject::verify();
    using namespace analysis::dvvp::transport;

    std::shared_ptr<Uploader> uploader(
        new Uploader(_transport));

    MOCKER_CPP_VIRTUAL(*_transport.get(), &HDCTransport::SendBuffer, int(HDCTransport::*)(const void *, int))
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    EXPECT_EQ(PROFILING_SUCCESS, uploader->Init());

    uploader->forceQuit_ = true;
    uploader->queue_->Quit();
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    uploader->Run(errorContext);
    uploader.reset();
}

TEST_F(UPLOADER_TEST, run_with_data) {
    GlobalMockObject::verify();
    using namespace analysis::dvvp::transport;

    std::shared_ptr<Uploader> uploader(new Uploader(_transport));
    MOCKER_CPP_VIRTUAL(*_transport.get(), &HDCTransport::SendBuffer, int(HDCTransport::*)(const void *, int))
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    std::string buffer("123456");
    EXPECT_EQ(PROFILING_SUCCESS, uploader->Init());
    EXPECT_EQ(PROFILING_SUCCESS, uploader->UploadData(buffer.c_str(), buffer.size()));
    uploader->forceQuit_ = true;
    uploader->queue_->Quit();
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    uploader->Run(errorContext);
    uploader.reset();
}

TEST_F(UPLOADER_TEST, Flush) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::Uploader> uploader(
        new analysis::dvvp::transport::Uploader(_transport));

    MOCKER_CPP(&analysis::dvvp::transport::UploaderQueue::Size)
        .stubs()
        .will(returnValue((unsigned long)1))
        .then(returnValue((unsigned long)0));
    EXPECT_EQ(uploader->Init(), PROFILING_SUCCESS);
    uploader->Flush();
    uploader->Flush();
}
