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
#include "data_handle.h"
#include "errno/error_code.h"
#include "prof_manager.h"
#include "uploader_mgr.h"
#include "platform/platform.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Transport;

class DATA_HANDLE_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(DATA_HANDLE_TEST, Msprof_ProcessStreamFileChunk) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsSocSide)
        .stubs()
        .will(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::UploadData)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<analysis::dvvp::proto::FileChunkReq> req(new analysis::dvvp::proto::FileChunkReq);
    analysis::dvvp::message::JobContext jobCtx;
    jobCtx.dev_id = "0";
    jobCtx.job_id = "jobId";
    req->mutable_hdr()->set_job_ctx(jobCtx.ToString());
    req->set_filename("Framework");
    // UPLOAD FAILED
    EXPECT_EQ(PROFILING_FAILED, MsprofDataHandle::ProcessStreamFileChunk(req));
    // OK
    EXPECT_EQ(PROFILING_SUCCESS, MsprofDataHandle::ProcessStreamFileChunk(req));
}

TEST_F(DATA_HANDLE_TEST, Msprof_ProcessFileChunkFlush) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsSocSide)
        .stubs()
        .will(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::UploadData)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<analysis::dvvp::proto::FileChunkFlushReq> req(new analysis::dvvp::proto::FileChunkFlushReq);
    analysis::dvvp::message::JobContext jobCtx;
    jobCtx.dev_id = "0";
    jobCtx.job_id = "jobId";
    req->mutable_hdr()->set_job_ctx(jobCtx.ToString());
    req->set_filename("DATA_PREPROCESS");
    // UPLOAD FAILED
    EXPECT_EQ(PROFILING_SUCCESS, MsprofDataHandle::ProcessFileChunkFlush(req));
    // OK
    EXPECT_EQ(PROFILING_SUCCESS, MsprofDataHandle::ProcessFileChunkFlush(req));

    EXPECT_EQ(PROFILING_FAILED, MsprofDataHandle::SendData("jobId", 0, "DATA_PREPROCESS", jobCtx));
}

TEST_F(DATA_HANDLE_TEST, PlatformTest) {
    GlobalMockObject::verify();

    auto platform = Analysis::Dvvp::Common::Platform::Platform::instance();

    EXPECT_EQ(PROFILING_SUCCESS, platform->Init());
    EXPECT_EQ(PROFILING_SUCCESS, platform->Uninit());
    platform->SetPlatformSoc();
    EXPECT_EQ(Analysis::Dvvp::Common::Platform::PlatformType::DEVICE, platform->GetPlatform());
}
