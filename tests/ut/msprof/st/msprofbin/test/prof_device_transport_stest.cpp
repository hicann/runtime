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
#include "securec.h"
#include "message/codec.h"
#include "errno/error_code.h"
#include "prof_manager.h"
#include "hdc/device_transport.h"
#include "hdc/helper_transport.h"
#include "data_handle.h"
#include "adx_prof_api.h"

using namespace analysis::dvvp::host;
using namespace analysis::dvvp::transport;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::MsprofErrMgr;
class HOST_PROF_DEVICE_TRANSPORT_UTEST: public testing::Test {
protected:

    virtual void SetUp() {
    }
    virtual void TearDown() {
    }

public:
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    std::string dev_id = "0";
    std::shared_ptr<DeviceTransport> dev_tran;
    std::shared_ptr<analysis::dvvp::transport::AdxTransport> data_tran;
    std::shared_ptr<analysis::dvvp::transport::AdxTransport> ctrl_tran;
};

namespace analysis {
namespace dvvp {
namespace transport {
extern int32_t SendBufferWithFixedLength(AdxTransport &transport, CONST_VOID_PTR buffer, int32_t length);
}
}
}
TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, CreateCoparamsnn){
    GlobalMockObject::verify();

    dev_tran = std::make_shared<DeviceTransport>(client, "-1", "123", "def_mode");

    std::shared_ptr<analysis::dvvp::proto::DataChannelHandshake> data_message(
            new analysis::dvvp::proto::DataChannelHandshake());
    EXPECT_EQ(nullptr, dev_tran->CreateConn());
    // EXPECT_EQ(PROFILING_FAILED, dev_tran->HandleShake(nullptr, data_message));

    data_tran = std::make_shared<HDCTransport>(client);
    std::shared_ptr<AdxTransport> fake_trans;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
        new analysis::dvvp::transport::HDCTransport(session));

    MOCKER_CPP(&analysis::dvvp::transport::HDCTransportFactory::CreateHdcTransport,
        std::shared_ptr<AdxTransport>(HDCTransportFactory::*)(HDC_CLIENT client, int dev_id) const)
        .stubs()
        .with(any(), any())
        .will(returnValue(fake_trans))
        .then(returnValue(data_tran));

    dev_tran = std::make_shared<DeviceTransport>(client, dev_id, "123", "def_mode");
    //tran empty
    EXPECT_EQ(fake_trans, dev_tran->CreateConn());
    EXPECT_EQ(data_tran, dev_tran->CreateConn());
    dev_tran->dataTran_ = data_tran;
    MOCKER(analysis::dvvp::transport::SendBufferWithFixedLength)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(0));  // retry 5 times
}


static int _drv_get_dev_ids_suc(int num_devices, std::vector<int> & dev_ids) {
    dev_ids.push_back(0);
    return PROFILING_SUCCESS;
}

static int _drv_get_dev_ids_fail(int num_devices, std::vector<int> & dev_ids) {
    return PROFILING_FAILED;
}

TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, init_ctrl_tran) {

    GlobalMockObject::verify();

    dev_tran = std::make_shared<DeviceTransport>(client, dev_id, "123", "def_mode");

    std::shared_ptr<AdxTransport> fake_tran;
    ctrl_tran = std::make_shared<HDCTransport>(client);

    MOCKER_CPP(&analysis::dvvp::transport::DeviceTransport::HandleShake)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, dev_tran->Init());
    EXPECT_EQ(PROFILING_FAILED, dev_tran->Init());
    MOCKER(&analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(1));

    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(invoke(_drv_get_dev_ids_fail))
        .then(invoke(_drv_get_dev_ids_suc));
    //tran empty

    auto entry = analysis::dvvp::transport::DevTransMgr::instance();
    EXPECT_EQ(PROFILING_FAILED, entry->Init("123", 0, "def_mode", 0));
    EXPECT_EQ(PROFILING_FAILED, entry->Init("123", 0, "def_mode", 0));
    EXPECT_EQ(PROFILING_FAILED, entry->Init("123", 0x12345678, "def_mode", 0));
}

TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, DoInit) {
        MOCKER(Analysis::Dvvp::Adx::AdxHdcClientCreate)
        .stubs()
        .will(returnValue(client));

    MOCKER_CPP(&analysis::dvvp::transport::DeviceTransport::Init)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(-2))
        .then(returnValue(0));

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    std::vector<int> devIds;
    devIds.push_back(0);

    auto entry = analysis::dvvp::transport::DevTransMgr::instance();
    EXPECT_EQ(PROFILING_FAILED, entry->Init("123", 0, "def_mode", 0));
    EXPECT_EQ(PROFILING_NOTSUPPORT, entry->Init("123", 0, "def_mode", 0));

}

TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, init_data_tran) {
    GlobalMockObject::verify();

    dev_tran = std::make_shared<DeviceTransport>(client, dev_id, "123", "def_mode");

    ctrl_tran = std::make_shared<HDCTransport>(client);
    data_tran = std::make_shared<HDCTransport>(client);

    MOCKER_CPP(&analysis::dvvp::transport::DeviceTransport::CreateConn)
        .stubs()
        .will(returnValue(ctrl_tran))
        .then(returnValue(data_tran));
    MOCKER_CPP(&analysis::dvvp::transport::DeviceTransport::HandleShake)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    //success
    EXPECT_EQ(PROFILING_SUCCESS, dev_tran->Init());
}

TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, run) {
    GlobalMockObject::verify();

    dev_tran = std::make_shared<DeviceTransport>(client, dev_id, "123", "def_mode");

    data_tran = std::make_shared<HDCTransport>(client);
    //dataInitialized_ false
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    dev_tran->Run(errorContext);
    EXPECT_FALSE(dev_tran->dataInitialized_);

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
        new analysis::dvvp::transport::HDCTransport(session));

    struct tlv_req* packet = (struct tlv_req *)new char[sizeof(struct tlv_req)];
    MOCKER_CPP_VIRTUAL(transport.get(), &analysis::dvvp::transport::HDCTransport::RecvPacket)
        .stubs()
        .with(outBoundP(&packet))
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER_CPP_VIRTUAL(transport.get(), &analysis::dvvp::transport::HDCTransport::DestroyPacket)
        .stubs();

    dev_tran->quit_ = true;
    //RecvPacket failed
    dev_tran->dataInitialized_ = true;
    dev_tran->dataTran_ = data_tran;
    dev_tran->Run(errorContext);
    EXPECT_FALSE(dev_tran->dataInitialized_);

    //ReceiveStreamData faield
    dev_tran->dataInitialized_ = true;
    dev_tran->dataTran_ = data_tran;
    dev_tran->Run(errorContext);
    EXPECT_FALSE(dev_tran->dataInitialized_);

    //success
    dev_tran->dataInitialized_ = true;
    dev_tran->dataTran_ = data_tran;
    dev_tran->Run(errorContext);
    EXPECT_FALSE(dev_tran->dataInitialized_);

    delete [] ((char*)packet);
}

TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, SendMsgAndRecvResponse)
{
    dev_tran = std::make_shared<DeviceTransport>(client, dev_id, "123", "def_mode");
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
        new analysis::dvvp::transport::HDCTransport(session));

    MOCKER_CPP_VIRTUAL(*transport.get(), &analysis::dvvp::transport::HDCTransport::SendBuffer,
        int(analysis::dvvp::transport::HDCTransport::*)(const void *, int))
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    ctrl_tran = std::make_shared<HDCTransport>(client);
    dev_tran->ctrlTran_ = ctrl_tran;
    std::string msg = "profiling msg";

    struct tlv_req **packetFake = nullptr;
    struct tlv_req* packet = nullptr;

    // invalid parameter
    EXPECT_EQ(PROFILING_FAILED, dev_tran->SendMsgAndRecvResponse(msg, packetFake));

    // send data failed
    EXPECT_EQ(PROFILING_FAILED, dev_tran->SendMsgAndRecvResponse(msg, &packet));

    MOCKER_CPP_VIRTUAL(transport.get(), &analysis::dvvp::transport::HDCTransport::RecvPacket)
        .stubs()
        .with(outBoundP(&packet))
        .will(returnValue(-1))
        .then(returnValue(0));

    //received succ
    EXPECT_EQ(PROFILING_SUCCESS, dev_tran->SendMsgAndRecvResponse(msg, &packet));
}

TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, SendBufferForProfileFileChunk) {
    GlobalMockObject::verify();

    HDC_SESSION session = (HDC_SESSION)0x12345678;

    std::shared_ptr<ITransport> trans(new HDCTransport(session));
    std::shared_ptr<PerfCount> perfCount(new PerfCount("test"));
    trans->perfCount_ = perfCount;

    void* out = (void*)0x12345678;

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq;
    fileChunkReq = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    fileChunkReq->chunkSize = 1;
    MOCKER(SendBufferWithFixedLength)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(PROFILING_FAILED, trans->SendBuffer(fileChunkReq));
}

TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, CloseConn)
{
    GlobalMockObject::verify();

    dev_tran = std::make_shared<DeviceTransport>(client, dev_id, "123", "def_mode");
    EXPECT_NE(nullptr, dev_tran);
    // ctrl_tran is null
    dev_tran->CloseConn();

    ctrl_tran = std::make_shared<HDCTransport>(client);
    EXPECT_NE(nullptr, ctrl_tran);
    dev_tran->ctrlTran_ = ctrl_tran;

    dev_tran->CloseConn();
}

TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, SendAdxBuffer)
{
    GlobalMockObject::verify();
    ctrl_tran = std::make_shared<HDCTransport>(client);
    EXPECT_NE(nullptr, ctrl_tran);

    void * buff = (void *)0x12345678;
    int length = 10;
    MOCKER(Analysis::Dvvp::Adx::AdxHdcWrite)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    EXPECT_EQ(PROFILING_FAILED, ctrl_tran->SendAdxBuffer(buff, length));
}

TEST_F(HOST_PROF_DEVICE_TRANSPORT_UTEST, IsInitialized)
{
    GlobalMockObject::verify();

    dev_tran = std::make_shared<DeviceTransport>(client, dev_id, "123", "def_mode");
    EXPECT_NE(nullptr, dev_tran);
    dev_tran->IsInitialized();
}

class HELPER_TRANSPORTFACTORY_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(HELPER_TRANSPORTFACTORY_TEST, TransportFactory) {
    GlobalMockObject::verify();

    std::shared_ptr<TransportFactory> factory(new TransportFactory());
    EXPECT_NE(nullptr, factory);
    factory.reset();
}

TEST_F(HELPER_TRANSPORTFACTORY_TEST, create_helper_transport_server) {
    GlobalMockObject::verify();
    HDC_SERVER server = (HDC_SERVER)0x12345678;
    MOCKER(Analysis::Dvvp::Adx::AdxHdcServerAccept)
        .stubs()
        .will(returnValue((HDC_SESSION)0x12345678))
        .then(returnValue((HDC_SESSION)nullptr));
    EXPECT_EQ((ITransport*)NULL, HelperTransportFactory().CreateHdcServerTransport(0, nullptr).get());
    EXPECT_NE((ITransport*)NULL, HelperTransportFactory().CreateHdcServerTransport(0, server).get());
    EXPECT_EQ((ITransport*)NULL, HelperTransportFactory().CreateHdcServerTransport(0, server).get());
}

TEST_F(HELPER_TRANSPORTFACTORY_TEST, create_hdc_transport_client) {
    GlobalMockObject::verify();

    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    int pid = 2023;
    int dev_id = 0;

    MOCKER_CPP(Analysis::Dvvp::Adx::AdxHalHdcSessionConnect)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ((ITransport*)NULL, HelperTransportFactory().CreateHdcClientTransport(pid, dev_id, client).get());
    EXPECT_NE((ITransport*)NULL, HelperTransportFactory().CreateHdcClientTransport(pid, dev_id, client).get());
}

class HELPERTRANSPORT_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(HELPERTRANSPORT_TEST, HelperTransport) {
    GlobalMockObject::verify();

    HDC_SESSION session = (HDC_SESSION)0x12345678;

    std::shared_ptr<ITransport> trans(new HelperTransport(session));
    EXPECT_NE(nullptr, trans);
    trans.reset();
}

TEST_F(HELPERTRANSPORT_TEST, SendBuffer) {
    GlobalMockObject::verify();

    HDC_SESSION session = (HDC_SESSION)0x12345678;

    std::shared_ptr<ITransport> trans(new HelperTransport(session));
    std::shared_ptr<PerfCount> perfCount(new PerfCount("test"));
    trans->perfCount_ = perfCount;
    void * buff = (void *)0x12345678;
    int length = 10;
    EXPECT_EQ(PROFILING_SUCCESS, trans->SendBuffer(buff, length));
}

TEST_F(HELPERTRANSPORT_TEST, CloseSession) {
    GlobalMockObject::verify();

    HDC_SESSION session = (HDC_SESSION)0x12345678;

    std::shared_ptr<ITransport> trans_s(new HelperTransport(session));
    EXPECT_EQ(PROFILING_SUCCESS, trans_s->CloseSession());
    trans_s.reset();

    session = (HDC_SESSION)0x12345678;
    std::shared_ptr<ITransport> trans_c(new HelperTransport(session, true));
    trans_c->WriteDone();
    EXPECT_EQ(PROFILING_SUCCESS, trans_c->CloseSession());
    trans_c.reset();
}

TEST_F(HELPERTRANSPORT_TEST, ReceivePacket) {
    GlobalMockObject::verify();

    ProfHalTlv *packet = nullptr;
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<HelperTransport> trans_c(new HelperTransport(session, true));
    MOCKER_CPP(&Analysis::Dvvp::Adx::AdxHdcRead)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    trans_c->WriteDone();

    EXPECT_EQ(-1, trans_c->ReceivePacket(&packet));
    trans_c->FreePacket(packet);
    packet = nullptr;
    trans_c.reset();
}

TEST_F(HELPERTRANSPORT_TEST, PackingData) {
    GlobalMockObject::verify();

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    ProfHalStruct package;
    std::string fileName = "unaging.additional.type_info_dic";
    std::string extraInfo = "null.0";
    std::string content = "abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz";
    std::shared_ptr<HelperTransport> trans(new HelperTransport(session));
    std::shared_ptr<PerfCount> perfCount(new PerfCount("test"));
    trans->perfCount_ = perfCount;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq;
    fileChunkReq = std::make_shared<analysis::dvvp::ProfileFileChunk>();
    fileChunkReq->isLastChunk = true;
    fileChunkReq->chunkModule = 2;
    fileChunkReq->offset = 0;
    fileChunkReq->chunkSize = content.size();
    fileChunkReq->chunk = content;
    fileChunkReq->fileName = fileName;
    fileChunkReq->extraInfo = extraInfo;

    EXPECT_EQ(EOK, trans->PackingData(package, fileChunkReq));
    EXPECT_EQ(2, package.chunkModule);
    EXPECT_EQ(0, package.offset);
    EXPECT_EQ(fileName, package.fileName);
    EXPECT_EQ(extraInfo, package.extraInfo);
    EXPECT_NE("", package.id);
}