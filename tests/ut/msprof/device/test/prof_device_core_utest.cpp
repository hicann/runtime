/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "securec.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "proto/profiler.pb.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "collection_entry.h"
#include "prof_device_core.h"
#include "transport/hdc/hdc_transport.h"
#include "task_manager.h"
#include "adx_prof_api.h"

using namespace analysis::dvvp::common::error;

class DEVICE_PROF_DEVICE_CORE_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
public:
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    std::string dev_id = "0";
};

int AdxIdeGetVfIdBySessionStub(HDC_SESSION session, int32_t &vfId) {
    vfId = 1;
    return IDE_DAEMON_OK;
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileInit) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::device::CollectionEntry::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_NE(PROFILING_SUCCESS, IdeDeviceProfileInit());
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileInit());
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileCleanup) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::device::CollectionEntry::Uinit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&analysis::dvvp::device::TaskManager::Uninit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileCleanup());
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileCleanup());
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileProcess_hdc_failed) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::AdxTransport> trans;
    trans.reset();
    MOCKER_CPP(&analysis::dvvp::transport::HDCTransportFactory::CreateHdcTransport,
        std::shared_ptr<analysis::dvvp::transport::AdxTransport>(analysis::dvvp::transport::HDCTransportFactory::*)(HDC_SESSION session) const)
        .stubs()
        .will(returnValue(trans));

    std::shared_ptr<analysis::dvvp::proto::CtrlChannelHandshake> message(
        new analysis::dvvp::proto::CtrlChannelHandshake);

    std::string buffer = analysis::dvvp::message::EncodeMessage(message);
    struct tlv_req * req = (struct tlv_req *)new char[sizeof(struct tlv_req) + buffer.size()];
    req->len = (int)buffer.size();
    memcpy_s(req->value, req->len, buffer.c_str(), buffer.size());
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));

    delete [] ((char*)req);
}

int32_t AdxIdeGetVfIdBySessionVfidStub(HDC_SESSION session, int32_t &vfId)
{
    vfId = 32;
    return IDE_DAEMON_OK;
}

extern int32_t IdeGetVfIdBySession(HDC_SESSION session, int32_t &vfId);
TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileProcessVfidFailed) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::proto::CtrlChannelHandshake> message(
        new analysis::dvvp::proto::CtrlChannelHandshake);

    std::string buffer = analysis::dvvp::message::EncodeMessage(message);
    struct tlv_req * req = (struct tlv_req *)new char[sizeof(struct tlv_req) + buffer.size()];
    req->len = (int)buffer.size();
    memcpy_s(req->value, req->len, buffer.c_str(), buffer.size());
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    MOCKER(Analysis::Dvvp::Adx::AdxIdeGetVfIdBySession)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(invoke(AdxIdeGetVfIdBySessionVfidStub));

    std::shared_ptr<analysis::dvvp::transport::AdxTransport>nullTran;
    std::shared_ptr<analysis::dvvp::transport::AdxTransport> dataTran;
    dataTran = std::make_shared<HDCTransport>(client);
    MOCKER_CPP(&analysis::dvvp::transport::HDCTransportFactory::CreateHdcTransport,
    std::shared_ptr<analysis::dvvp::transport::AdxTransport>(analysis::dvvp::transport::HDCTransportFactory::*)(HDC_SESSION session) const)
        .stubs()
        .will(returnValue(nullTran))
        .then(returnValue(dataTran));

    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
        new analysis::dvvp::transport::HDCTransport(session));
    MOCKER_CPP_VIRTUAL(*transport.get(), &analysis::dvvp::transport::HDCTransport::SendBuffer,
        int(analysis::dvvp::transport::HDCTransport::*)(const void *, int))
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    // get vfid failed
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));

    // create hdc failed
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));

    // send buffer failes
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));

    // vfid != 0
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileProcess(session, req));
    delete [] ((char*)req);
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileProcess) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::CtrlChannelHandshake> message(
        new analysis::dvvp::proto::CtrlChannelHandshake);

    std::string buffer = analysis::dvvp::message::EncodeMessage(message);
    struct tlv_req * req = (struct tlv_req *)new char[sizeof(struct tlv_req) + buffer.size()];
    req->len = (int)buffer.size();
    memcpy_s(req->value, req->len, buffer.c_str(), buffer.size());

    //null params
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(NULL, req));

    //null req
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, NULL));

    MOCKER(Analysis::Dvvp::Adx::AdxIdeGetVfIdBySession)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(analysis::dvvp::common::utils::Utils::CheckStringIsNonNegativeIntNum)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true))
        .then(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::device::CollectionEntry::Handle)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::AdxTransport> data_tran = std::make_shared<analysis::dvvp::transport::HDCTransport>(client);

    std::shared_ptr<analysis::dvvp::transport::AdxTransport> trans;
    trans.reset();

    MOCKER_CPP(&analysis::dvvp::transport::HDCTransportFactory::CreateHdcTransport,
        std::shared_ptr<analysis::dvvp::transport::AdxTransport>(analysis::dvvp::transport::HDCTransportFactory::*)(HDC_SESSION session) const)
        .stubs()
        .will(returnValue(trans))
        .then(returnValue(data_tran));

    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileProcess(session, req));
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileProcess(session, req));

    delete [] ((char*)req);
}
