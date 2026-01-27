/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <errno.h>
#include <strings.h>
#include <string.h>
#include <memory>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "utils/utils.h"
#include "errno/error_code.h"
#include "prof_msg_handler.h"
#include "task_manager.h"
#include "transport/hdc/hdc_transport.h"
#include "transport/transport.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::device;

class PROF_MSG_HANDLER_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}
};

TEST_F(PROF_MSG_HANDLER_TEST, CreateResponse_success) {
    GlobalMockObject::verify();

    analysis::dvvp::message::StatusInfo status_info(
        "2", analysis::dvvp::message::SUCCESS, "CreateResponse");

    std::shared_ptr<analysis::dvvp::proto::Response>
        rsp(std::dynamic_pointer_cast<analysis::dvvp::proto::Response>(
            analysis::dvvp::device::CreateResponse(status_info)));

    EXPECT_NE((analysis::dvvp::proto::Response *)NULL, rsp.get());
    EXPECT_STREQ(status_info.ToString().c_str(), rsp->message().c_str());
    EXPECT_EQ(analysis::dvvp::proto::SUCCESS, rsp->status());
}

TEST_F(PROF_MSG_HANDLER_TEST, CreateResponse_failed) {
    GlobalMockObject::verify();

    analysis::dvvp::message::StatusInfo status_info(
        "2", analysis::dvvp::message::ERR, "CreateResponse");

    std::shared_ptr<analysis::dvvp::proto::Response>
        rsp(std::dynamic_pointer_cast<analysis::dvvp::proto::Response>(
            analysis::dvvp::device::CreateResponse(status_info)));

    EXPECT_NE((analysis::dvvp::proto::Response *)NULL, rsp.get());
    EXPECT_STREQ(status_info.ToString().c_str(), rsp->message().c_str());
    EXPECT_EQ(analysis::dvvp::proto::FAILED, rsp->status());
}

/////////////////////////////////////////////////////////////

#define SET_JOBCTX(req) do {                                                                                \
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(new analysis::dvvp::message::JobContext);   \
    jobCtx->dev_id = "0";                                                                                   \
    jobCtx->job_id = "0x123456789";                                                                         \
    req->mutable_hdr()->set_job_ctx(jobCtx->ToString());                                                   \
    jobCtx.reset();                                                                                         \
} while(0);

#define SET_JOBCTX_INVALID(req) do {                                                                                \
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(new analysis::dvvp::message::JobContext);   \
    jobCtx->dev_id = "-1";                                                                                   \
    jobCtx->job_id = "0x123456789";                                                                         \
    req->mutable_hdr()->set_job_ctx(jobCtx->ToString());                                                   \
    jobCtx.reset();                                                                                         \
} while(0);

/////////////////////////////////////////////////////////////
TEST_F(PROF_MSG_HANDLER_TEST, JobStartHandler) {
    GlobalMockObject::verify();

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::ITransport> trans(new analysis::dvvp::transport::HDCTransport(session));

    std::shared_ptr<analysis::dvvp::device::JobStartHandler> handler(new analysis::dvvp::device::JobStartHandler(trans));
    EXPECT_NE(nullptr, handler);

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> req(new analysis::dvvp::proto::JobStartReq);
    EXPECT_NE(nullptr, req);
    SET_JOBCTX(req);


    handler->OnNewMessage(req);

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(new analysis::dvvp::device::ProfJobHandler);
    MOCKER_CPP(&analysis::dvvp::device::TaskManager::CreateTask)
        .stubs()
        .will(returnValue(job));
    handler->OnNewMessage(req);

    SET_JOBCTX_INVALID(req);
    handler->OnNewMessage(req);

    handler.reset();
    trans.reset();
}

/////////////////////////////////////////////////////////////
TEST_F(PROF_MSG_HANDLER_TEST, JobStopHandler) {
    GlobalMockObject::verify();


    std::shared_ptr<analysis::dvvp::device::JobStopHandler> handler(new analysis::dvvp::device::JobStopHandler());
    EXPECT_NE(nullptr, handler);

    std::shared_ptr<analysis::dvvp::proto::JobStopReq> req(new analysis::dvvp::proto::JobStopReq);
    EXPECT_NE(nullptr, req);
    SET_JOBCTX(req);

    handler->OnNewMessage(req);

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(new analysis::dvvp::device::ProfJobHandler);
    job->Init(0, "jobId", nullptr);
    MOCKER_CPP(&analysis::dvvp::device::TaskManager::GetTask)
        .stubs()
        .will(returnValue(job));
    handler->OnNewMessage(req);

    handler.reset();
}


/////////////////////////////////////////////////////////////
TEST_F(PROF_MSG_HANDLER_TEST, ReplayStartHandler) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ReplayStartHandler> handler(new analysis::dvvp::device::ReplayStartHandler());
    EXPECT_NE(nullptr, handler);
    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(new analysis::dvvp::proto::ReplayStartReq);
    EXPECT_NE(nullptr, req);
    SET_JOBCTX(req);
    handler->OnNewMessage(req);

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(new analysis::dvvp::device::ProfJobHandler);
    job->Init(0, "jobId", nullptr);
    MOCKER_CPP(&analysis::dvvp::device::TaskManager::GetTask)
        .stubs()
        .will(returnValue(job));
    handler->OnNewMessage(req);

    handler.reset();
}

/////////////////////////////////////////////////////////////
TEST_F(PROF_MSG_HANDLER_TEST, ReplayStopHandler) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ReplayStopHandler> handler(new analysis::dvvp::device::ReplayStopHandler());
    EXPECT_NE(nullptr, handler);

    std::shared_ptr<analysis::dvvp::proto::ReplayStopReq> req(new analysis::dvvp::proto::ReplayStopReq);
    EXPECT_NE(nullptr, req);
    SET_JOBCTX(req);

    handler->OnNewMessage(req);

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(new analysis::dvvp::device::ProfJobHandler);
    job->Init(0, "jobId", nullptr);
    MOCKER_CPP(&analysis::dvvp::device::TaskManager::GetTask)
        .stubs()
        .will(returnValue(job));
    handler->OnNewMessage(req);

    handler.reset();
}