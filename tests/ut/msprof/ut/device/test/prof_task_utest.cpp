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
#include <mutex>
#include "thread/thread.h"
#include "prof_msg_handler.h"
#include "message/codec.h"
#include "message/dispatcher.h"
#include "transport/transport.h"
#include "collect_engine.h"
#include "errno/error_code.h"
#include "prof_task.h"
#include "collection_entry.h"
#include "param_validation.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Statistics;

class PROF_TASK_TEST: public testing::Test {
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

/////////////////////////////////////////////////////////////
TEST_F(PROF_TASK_TEST, ProfJobHandler_destructor) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_EQ(PROFILING_SUCCESS, job->Init(0, "0x12345678", _transport));
    EXPECT_EQ(PROFILING_SUCCESS, job->Uinit());
    job.reset();
}

/////////////////////////////////////////////////////////////
TEST_F(PROF_TASK_TEST, Init) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    EXPECT_EQ(PROFILING_SUCCESS, job->Init(0, "0x12345678", _transport));
}

TEST_F(PROF_TASK_TEST, Uinit) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    EXPECT_EQ(PROFILING_SUCCESS, job->Init(0, "0x12345678", _transport));
    EXPECT_EQ(PROFILING_SUCCESS, job->Uinit());
}

TEST_F(PROF_TASK_TEST, ResetTask) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_EQ(PROFILING_SUCCESS, job->Init(0, "0x12345678", _transport));
    job->_is_started = true;
    job->ResetTask();
    EXPECT_EQ(PROFILING_SUCCESS, job->Uinit());
}

TEST_F(PROF_TASK_TEST, OnJobStart) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::CollectStart)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<analysis::dvvp::transport::AdxTransport> transport_invalid;
    std::shared_ptr<analysis::dvvp::transport::AdxTransport> transport(new analysis::dvvp::transport::HDCTransport(nullptr));
    std::shared_ptr<analysis::dvvp::device::Receiver> receive_invalid;
    std::shared_ptr<analysis::dvvp::device::Receiver> receive_invalid_transport(new analysis::dvvp::device::Receiver(transport_invalid));
    std::shared_ptr<analysis::dvvp::device::Receiver> receive(new analysis::dvvp::device::Receiver(transport));

    MOCKER_CPP(&analysis::dvvp::device::CollectionEntry::GetReceiver)
        .stubs()
        .will(returnValue(receive_invalid))
        .then(returnValue(receive_invalid_transport))
        .then(returnValue(receive));

    job->Init(0, "0x12345678", _transport);

    std::shared_ptr<analysis::dvvp::proto::JobStartReq> req(
        new analysis::dvvp::proto::JobStartReq);
    analysis::dvvp::message::StatusInfo status_info;

    // nullptr
    EXPECT_EQ(PROFILING_FAILED, job->OnJobStart(nullptr, status_info));

    //CollectEngine init failed
    EXPECT_EQ(PROFILING_FAILED, job->OnJobStart(req, status_info));
    EXPECT_FALSE(job->_is_started);

    //GetReceiver failed
    EXPECT_EQ(PROFILING_FAILED, job->OnJobStart(req, status_info));
    EXPECT_FALSE(job->_is_started);

    //GetTransport failed
    EXPECT_EQ(PROFILING_SUCCESS, job->OnJobStart(req, status_info));
    EXPECT_TRUE(job->_is_started);

    //CollectStart failed
    EXPECT_EQ(PROFILING_FAILED, job->OnJobStart(req, status_info));
    EXPECT_TRUE(job->_is_started);

    //succ
    EXPECT_EQ(PROFILING_FAILED, job->OnJobStart(req, status_info));
    EXPECT_TRUE(job->_is_started);

    //set again
    EXPECT_EQ(PROFILING_FAILED, job->OnJobStart(req, status_info));
}

TEST_F(PROF_TASK_TEST, OnJobEnd) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::CollectStop)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::SetDevIdOnHost)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    job->Init(0, "0x12345678", _transport);

    analysis::dvvp::message::StatusInfo status_info;

    job->_is_started = false;
    EXPECT_EQ(PROFILING_FAILED, job->OnJobEnd(status_info));
    EXPECT_EQ(analysis::dvvp::message::ERR, status_info.status);

    job->InitEngine(status_info);
    job->_is_started = true;
    EXPECT_EQ(PROFILING_SUCCESS, job->OnJobEnd(status_info));
}

TEST_F(PROF_TASK_TEST, OnReplayStart) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::CollectStartReplay)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));

    job->Init(0, "0x12345678", _transport);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);
    analysis::dvvp::message::StatusInfo status_info;

    job->_is_started = false;
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayStart(req, status_info));
    EXPECT_EQ(analysis::dvvp::message::ERR, status_info.status);

    req->add_ctrl_cpu_events("0x1");
    req->add_ts_cpu_events("0x2");
    req->add_ai_cpu_events("0x3");
    req->add_ai_core_events("0x4");
    req->add_ai_core_events_cores(1);
    req->add_llc_events("e1,e2,e3");
    req->add_ddr_events("d1,d2,d3");
    job->_is_started = true;
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayStart(req, status_info));
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayStart(req, status_info));

    MOCKER_CPP(&analysis::dvvp::device::ProfJobHandler::CheckEventValid)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayStart(req, status_info));
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayStart(req, status_info));

}

TEST_F(PROF_TASK_TEST, OnReplayEnd) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::CollectStopReplay)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));

    job->Init(0, "0x12345678", _transport);

    std::shared_ptr<analysis::dvvp::proto::ReplayStopReq> req(
        new analysis::dvvp::proto::ReplayStopReq);
    analysis::dvvp::message::StatusInfo status_info;

    EXPECT_EQ(PROFILING_FAILED, job->OnReplayEnd(nullptr, status_info));

    job->_is_started = false;
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayEnd(req, status_info));
    EXPECT_EQ(analysis::dvvp::message::ERR, status_info.status);

    job->_is_started = true;
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayEnd(req, status_info));
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayEnd(req, status_info));
}

TEST_F(PROF_TASK_TEST, OnConnectionReset) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::CollectStop)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    job->Init(0, "0x12345678", _transport);

    job->_is_started = true;
    EXPECT_EQ(PROFILING_FAILED, job->OnConnectionReset());
    analysis::dvvp::message::StatusInfo status_info;
    job->_is_started = false;
    job->InitEngine(status_info);
    job->_is_started = true;
    EXPECT_EQ(PROFILING_SUCCESS, job->OnConnectionReset());
}

TEST_F(PROF_TASK_TEST, GetDevId) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    job->Init(0, "0x12345", _transport);
    EXPECT_EQ(0, job->GetDevId());
}

TEST_F(PROF_TASK_TEST, CheckEventValid_faile1) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_NE(nullptr, job);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckPmuEventSizeIsValid)
        .stubs()
        .will(returnValue(false));
    job->CheckEventValid(req);
}

TEST_F(PROF_TASK_TEST, CheckEventValid_faile2) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_NE(nullptr, job);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckPmuEventSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    job->CheckEventValid(req);
}

TEST_F(PROF_TASK_TEST, CheckEventValid_faile8) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_NE(nullptr, job);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckPmuEventSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));
    job->CheckEventValid(req);
}

TEST_F(PROF_TASK_TEST, CheckEventValid_faile3) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_NE(nullptr, job);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckPmuEventSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));
    job->CheckEventValid(req);
}

TEST_F(PROF_TASK_TEST, CheckEventValid_faile4) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_NE(nullptr, job);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckPmuEventSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckCoreIdSizeIsValid)
        .stubs()
        .will(returnValue(false));
    job->CheckEventValid(req);
}

TEST_F(PROF_TASK_TEST, CheckEventValid_faile5) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_NE(nullptr, job);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckPmuEventSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckCoreIdSizeIsValid)
        .stubs()
        .will(returnValue(true));
    job->CheckEventValid(req);
}

TEST_F(PROF_TASK_TEST, CheckEventValid_faile6) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_NE(nullptr, job);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckPmuEventSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckCoreIdSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    job->CheckEventValid(req);
}

TEST_F(PROF_TASK_TEST, CheckEventValid_faile9) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_NE(nullptr, job);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckPmuEventSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckCoreIdSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true));
    job->CheckEventValid(req);
}

TEST_F(PROF_TASK_TEST, CheckEventValid_faile7) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    EXPECT_NE(nullptr, job);

    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckPmuEventSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckCoreIdSizeIsValid)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true));
    job->CheckEventValid(req);
}

TEST_F(PROF_TASK_TEST, Receiver_SendMessage) {
    GlobalMockObject::verify();

    analysis::dvvp::message::StatusInfo status("1", analysis::dvvp::message::SUCCESS, "test");
    std::shared_ptr<analysis::dvvp::proto::Response> response(
        new analysis::dvvp::proto::Response);
    response->set_message(status.ToString());
    std::shared_ptr<analysis::dvvp::transport::HDCTransport> transport(new analysis::dvvp::transport::HDCTransport(nullptr));
    std::shared_ptr<PerfCount> perfCount(new PerfCount("test"));
    transport->perfCount_ = perfCount;
    std::shared_ptr<analysis::dvvp::device::Receiver> receive(new analysis::dvvp::device::Receiver(transport));
    EXPECT_NE(nullptr, receive);
    MOCKER_CPP_VIRTUAL(*transport.get(), &analysis::dvvp::transport::HDCTransport::SendBuffer,
        int(analysis::dvvp::transport::HDCTransport::*)(const void *, int))
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    receive->SendMessage(response);
}

TEST_F(PROF_TASK_TEST, GetControlCpuEvent) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    req->add_ctrl_cpu_events("0x1");
    EXPECT_EQ(req->ctrl_cpu_events(0), job->GetControlCpuEvent(req)->begin()[0]);
}

TEST_F(PROF_TASK_TEST, GetLlcEvent) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());
    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(
        new analysis::dvvp::proto::ReplayStartReq);

    req->add_llc_events("l1");
    EXPECT_EQ(req->llc_events(0), job->GetLlcEvent(req)->begin()[0]);
}
