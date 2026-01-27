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
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "job_device_rpc.h"
#include "config/config.h"
#include "prof_manager.h"
#include "hdc/device_transport.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;

class PROF_DEVICE_RPC_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {

    }
public:

};

TEST_F(PROF_DEVICE_RPC_UTEST, StartProf) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    auto jobDeviceRpc = std::make_shared<Analysis::Dvvp::JobWrapper::JobDeviceRpc>(0);
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->StartProf(params));
    MOCKER_CPP(&Analysis ::Dvvp::JobWrapper::JobDeviceRpc::SendMsgAndHandleResponse)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, jobDeviceRpc->StartProf(params));
}

TEST_F(PROF_DEVICE_RPC_UTEST, BuildStartReplayMessage) {
    GlobalMockObject::verify();
    auto jobDeviceRpc = std::make_shared<Analysis::Dvvp::JobWrapper::JobDeviceRpc>(0);
    std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> req(new analysis::dvvp::proto::ReplayStartReq);
    EXPECT_NE(nullptr, req);
    auto cfg = std::make_shared<Analysis::Dvvp::JobWrapper::PMUEventsConfig>();
    auto ctrlCPUEvents = std::make_shared<std::vector<std::string>>(0);
    auto aiCoreEventsCoreIds = std::make_shared<std::vector<int>>();
    aiCoreEventsCoreIds->push_back(1);
    ctrlCPUEvents->push_back("aa");
    cfg->ctrlCPUEvents = *ctrlCPUEvents;
    cfg->tsCPUEvents = *ctrlCPUEvents;
    cfg->aiCoreEvents = *ctrlCPUEvents;
    cfg->aiCoreEventsCoreIds = *aiCoreEventsCoreIds;
    cfg->llcEvents = *ctrlCPUEvents;
    cfg->ddrEvents = *ctrlCPUEvents;
    cfg->aivEvents = *ctrlCPUEvents;
    cfg->aivEventsCoreIds = *aiCoreEventsCoreIds;
    jobDeviceRpc->BuildStartReplayMessage(cfg, req);
}

TEST_F(PROF_DEVICE_RPC_UTEST, StartProf1) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    params->ai_ctrl_cpu_profiling_events = "aa";
    auto jobDeviceRpc = std::make_shared<Analysis::Dvvp::JobWrapper::JobDeviceRpc>(0);

    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->StartProf(params));
    
    jobDeviceRpc->isStarted_ = true;
    
    jobDeviceRpc->params_ = params;
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->StartProf(params));
    MOCKER_CPP(&Analysis ::Dvvp::JobWrapper::JobDeviceRpc::SendMsgAndHandleResponse)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, jobDeviceRpc->StartProf(params));
}

TEST_F(PROF_DEVICE_RPC_UTEST, StopProf) {
    GlobalMockObject::verify();
    auto jobDeviceRpc = std::make_shared<Analysis::Dvvp::JobWrapper::JobDeviceRpc>(0);
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->StopProf());
    jobDeviceRpc->isStarted_ = true;
    MOCKER_CPP(&Analysis ::Dvvp::JobWrapper::JobDeviceRpc::SendMsgAndHandleResponse)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->StopProf());
    EXPECT_EQ(PROFILING_SUCCESS, jobDeviceRpc->StopProf());
}


TEST_F(PROF_DEVICE_RPC_UTEST, StopProf) {
    GlobalMockObject::verify();
    auto jobDeviceRpc = std::make_shared<Analysis::Dvvp::JobWrapper::JobDeviceRpc>(0);\
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    jobDeviceRpc->params_ = params;
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->StopProf());
    jobDeviceRpc->isStarted_ = true;
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->StopProf());
    MOCKER_CPP(&Analysis ::Dvvp::JobWrapper::JobDeviceRpc::SendMsgAndHandleResponse)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, jobDeviceRpc->StopProf());
}

TEST_F(PROF_DEVICE_RPC_UTEST, SendMsgAndHandleResponse) {
    GlobalMockObject::verify();
    auto jobDeviceRpc = std::make_shared<Analysis::Dvvp::JobWrapper::JobDeviceRpc>(0);
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    jobDeviceRpc->params_ = params;
    std::shared_ptr<analysis::dvvp::proto::JobStartReq> message(
        new analysis::dvvp::proto::JobStartReq);
    EXPECT_EQ(-1, jobDeviceRpc->SendMsgAndHandleResponse(message));
    HDC_CLIENT client;
    std::shared_ptr<analysis::dvvp::transport::IDeviceTransport> deviceTransport = std::make_shared<analysis::dvvp::transport::DeviceTransport>(client,"123", "0", "def_mode");

    std::shared_ptr<analysis::dvvp::transport::IDeviceTransport> mockTransport;
    mockTransport.reset();

    std::shared_ptr<std::string> encodeMessage = std::make_shared<std::string>();
    std::shared_ptr<std::string> mockMessage;
    mockMessage.reset();

    MOCKER(analysis::dvvp::message::EncodeMessageShared)
        .stubs()
        .will(returnValue(mockMessage))
        .then(returnValue(encodeMessage));

    // MOCKER_CPP(&analysis::dvvp::transport::DeviceTransport::SendMsgAndRecvResponse)
    //     .stubs()
    //     .will(returnValue(-1))
    //     .then(returnValue(0));

    // MOCKER_CPP(&analysis::dvvp::transport::DeviceTransport::HandlePacket)
    //     .stubs()
    //     .will(returnValue(-1))
    //     .then(returnValue(0));
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->SendMsgAndHandleResponse(message));
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->SendMsgAndHandleResponse(message));
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->SendMsgAndHandleResponse(message));
    EXPECT_EQ(PROFILING_FAILED, jobDeviceRpc->SendMsgAndHandleResponse(message));
    //EXPECT_EQ(PROFILING_SUCCESS, jobDeviceRpc->SendMsgAndHandleResponse(message));
}




