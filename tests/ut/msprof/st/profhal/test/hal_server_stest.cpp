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
#include <iostream>
#include "errno/error_code.h"
#include "prof_hdc_server.h"
#include "prof_server_manager.h"
#include "message/codec.h"
#include "message/prof_params.h"
#include "proto/profiler.pb.h"
#include "msprof_reporter.h"
#include "prof_aicpu_api.h"
#include "hdc/hdc_transport.h"
#include "param_validation.h"
#include "adx_prof_api.h"

using namespace Dvvp::Hal::Server;
using namespace analysis::dvvp::common::error;

class HAL_SERVER_STEST : public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

void flushModule() {}
int32_t sendAicpuData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) {return PROFILING_FAILED;}
TEST_F(HAL_SERVER_STEST, Simulate_ReceiveStreamData) {
    GlobalMockObject::verify();
    auto aicpu = std::make_shared<ProfHdcServer>();
    aicpu->logicDevId_ = 1;
    aicpu->logicDevIdStr_ = "1";
    aicpu->flushModuleCallback_ = flushModule;
    aicpu->sendAicpuDataCallback_ = sendAicpuData;
    EXPECT_EQ(PROFILING_FAILED, aicpu->ReceiveStreamData(nullptr, 0));

    std::string message = "test";
    EXPECT_EQ(PROFILING_FAILED, aicpu->ReceiveStreamData(message.c_str(), message.size()));

    std::shared_ptr<analysis::dvvp::proto::FileChunkReq> req(
        new analysis::dvvp::proto::FileChunkReq());
    std::string encode = analysis::dvvp::message::EncodeMessage(req);
    EXPECT_EQ(PROFILING_FAILED, aicpu->ReceiveStreamData(encode.c_str(), encode.size()));

    req->set_islastchunk(true);
    encode = analysis::dvvp::message::EncodeMessage(req);
    EXPECT_EQ(PROFILING_SUCCESS, aicpu->ReceiveStreamData(encode.c_str(), encode.size()));

    analysis::dvvp::message::JobContext jobCtx;
    jobCtx.dev_id = "1";
    jobCtx.tag = "test";
    req->set_islastchunk(false);
    req->mutable_hdr()->set_job_ctx(jobCtx.ToString());
    encode = analysis::dvvp::message::EncodeMessage(req);
    EXPECT_EQ(PROFILING_FAILED, aicpu->ReceiveStreamData(encode.c_str(), encode.size()));
}

TEST_F(HAL_SERVER_STEST, Simulate_ProfHdcServer) {
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::CheckStringIsNonNegativeIntNum)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    auto device_aicpu = std::make_shared<ProfHdcServer>();
    EXPECT_EQ(PROFILING_FAILED, device_aicpu->Init(0));
    EXPECT_EQ(PROFILING_SUCCESS, device_aicpu->Init(0));

    auto host_aicpu = std::make_shared<ProfHdcServer>();
    EXPECT_EQ(PROFILING_FAILED, host_aicpu->Init(64));
    usleep(300000);
    device_aicpu->StopNoWait();
    device_aicpu->UnInit();
    EXPECT_EQ(false, device_aicpu->dataInitialized_);
    EXPECT_EQ(nullptr, device_aicpu->server_);
    device_aicpu.reset();
}

TEST_F(HAL_SERVER_STEST, Simulate_ServerManager) {
    GlobalMockObject::verify();
    uint32_t configSize =
        static_cast<uint32_t>(sizeof(ProfHalModuleConfig) + sizeof(uint32_t));
    auto moduleConfigP = static_cast<ProfHalModuleConfig *>(malloc(configSize));
    EXPECT_NE(nullptr, moduleConfigP);
    (void)memset_s(moduleConfigP, configSize, 0, configSize);
    const uint32_t devIdList[2] = {64, 0};
    moduleConfigP->devIdList = const_cast<uint32_t *>(devIdList);
    moduleConfigP->devIdListNums = 2;
    ProfHalModuleInitialize(PROF_HAL_AICPU, moduleConfigP, sizeof(moduleConfigP));
    EXPECT_EQ(1, ServerManager::instance()->hdcDevMap_.size());

    sleep(1);
    MOCKER_CPP(&Dvvp::Hal::Server::ProfHdcServer::UnInit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    ProfHalModuleFinalize();
    EXPECT_EQ(1, ServerManager::instance()->hdcDevMap_.size());

    ProfHalModuleFinalize();
    EXPECT_EQ(0, ServerManager::instance()->hdcDevMap_.size());

    MOCKER_CPP(&Dvvp::Hal::Server::ProfHdcServer::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, ProfHalModuleInitialize(PROF_HAL_AICPU, moduleConfigP, sizeof(moduleConfigP)));
    free(moduleConfigP);
}

TEST_F(HAL_SERVER_STEST, Simulate_ProfHalGetVersion) {
    GlobalMockObject::verify();
    uint32_t address = 1;
    uint32_t *version = &address;
    ProfHalGetVersion(version);
    EXPECT_EQ(65536, *version);
}

int AdxHdcReadStub(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    *recvLen = 100;
    return 0;
}

TEST_F(HAL_SERVER_STEST, ProfHdcServerRun) {
    GlobalMockObject::verify();
    MOCKER(Analysis::Dvvp::Adx::AdxHdcServerCreate)
        .stubs()
        .will(returnValue((HDC_SERVER)0x12345678));
    MOCKER(Analysis::Dvvp::Adx::AdxHdcServerAccept)
        .stubs()
        .will(returnValue((HDC_SERVER)0x12345678))
        .then(returnValue((HDC_SERVER)nullptr));

    MOCKER(Analysis::Dvvp::Adx::AdxHdcRead)
        .stubs()
        .will(invoke(AdxHdcReadStub));
    MOCKER_CPP(&ProfHdcServer::ReceiveStreamData)
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    auto device_aicpu = std::make_shared<ProfHdcServer>();
    EXPECT_EQ(PROFILING_SUCCESS, device_aicpu->Init(0));
    usleep(300000);
    device_aicpu->StopNoWait();
    EXPECT_EQ(PROFILING_SUCCESS, device_aicpu->UnInit());
    device_aicpu.reset();
}

TEST_F(HAL_SERVER_STEST, Simulate_ProfHelperServer) {
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::CheckStringIsNonNegativeIntNum)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    auto helperServer = std::make_shared<ProfHelperServer>();
    EXPECT_EQ(PROFILING_FAILED, helperServer->Init(0));
    EXPECT_EQ(PROFILING_SUCCESS, helperServer->Init(0));
    sleep(1);
    EXPECT_EQ(PROFILING_SUCCESS, helperServer->UnInit());
    helperServer.reset();
}

TEST_F(HAL_SERVER_STEST, Simulate_InitHelperServer) {
    GlobalMockObject::verify();
    MOCKER(Analysis::Dvvp::Adx::AdxHdcServerCreate)
        .stubs()
        .will(returnValue((HDC_SERVER)0x12345678));
    MOCKER(Analysis::Dvvp::Adx::AdxHdcServerAccept)
        .stubs()
        .will(returnValue((HDC_SERVER)0x12345678))
        .then(returnValue((HDC_SERVER)nullptr));

    MOCKER(Analysis::Dvvp::Adx::AdxHdcRead)
        .stubs()
        .will(invoke(AdxHdcReadStub));
    MOCKER_CPP(&ProfHelperServer::ReceiveStreamData)
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    auto helperServer = std::make_shared<ProfHelperServer>();
    EXPECT_EQ(PROFILING_SUCCESS, helperServer->Init(0));
    usleep(300000);
    helperServer->StopNoWait();
    sleep(1);
    EXPECT_EQ(PROFILING_SUCCESS, helperServer->UnInit());
    helperServer.reset();
}

TEST_F(HAL_SERVER_STEST, Simulate_UninitHelperServer) {
    GlobalMockObject::verify();
    auto helperServer = std::make_shared<ProfHelperServer>();
    helperServer->server_ = (HDC_SERVER)0x123245678;
    helperServer->dataInitialized_ = true;
    sleep(1);
    helperServer->UnInit();
    EXPECT_EQ(nullptr, helperServer->server_);
}

analysis::dvvp::ProfileFileChunk g_result = {0};
ProfHalTlv GenerateProfHalStruct (bool isLastChunk, int32_t chunkModule, size_t offset,
    std::string chunk, std::string fileName, std::string extraInfo, std::string id)
{
    ProfHalStruct data;
    data.isLastChunk = isLastChunk;
    data.chunkModule = chunkModule;
    data.chunkSize = chunk.size();
    data.offset = offset;

    strcpy_s(&data.chunk[0], HAL_CHUNK_MAX_LEN + 1, chunk.c_str());
    strcpy_s(&data.fileName[0], HAL_FILENAME_MAX_LEN + 1, fileName.c_str());
    strcpy_s(&data.extraInfo[0], HAL_EXTRAINFO_MAX_LEN + 1, extraInfo.c_str());
    strcpy_s(&data.id[0], HAL_ID_MAX_LEN + 1, id.c_str());

    struct ProfHalTlv tlv;
    tlv.head = HAL_HELPER_TLV_HEAD;
    tlv.version = HAL_TLV_VERSION;
    tlv.type = HELPER_TLV_TYPE;
    tlv.len = sizeof(ProfHalTlv) + sizeof(ProfHalStruct);
    memcpy_s(&tlv.value[0], HAL_TLV_VALUE_MAX_LEN, &data, sizeof(ProfHalStruct));
    return tlv;
}

void SetFlushModuleCallbackStub () {}

int32_t SendHelperDataCallbackStub (SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk)
{
    g_result.isLastChunk = fileChunk->isLastChunk;
    g_result.fileName = fileChunk->fileName;
    g_result.chunk = fileChunk->chunk;
    g_result.id = fileChunk->id;
    return PROFILING_SUCCESS;
}

int32_t SetHelperDirStub (const std::string helperDir)
{
    EXPECT_EQ(helperDir, ".123456");
    return PROFILING_SUCCESS;
}

TEST_F(HAL_SERVER_STEST, Simulate_HelperReceiveStreamData) {
    GlobalMockObject::verify();
    ProfHalTlv tlv_normal = GenerateProfHalStruct(false, 0, 0, "12345", "normal.file", "no extra", "123456");
    ProfHalTlv tlv_filename = GenerateProfHalStruct(false, 0, 0, "12345", "helper_device_pid", "no extra", "123456");
    ProfHalTlv tlv_lastChunk = GenerateProfHalStruct(true, 0, 0, "", "normal1.file", "no extra", "123456");
    ProfHalTlv tlv_sampleJson0 = GenerateProfHalStruct(false, 0, 0, "abc ", "sample.json", "no extra", "123456");
    ProfHalTlv tlv_sampleJson1 = GenerateProfHalStruct(false, 0, 0, "def ", "sample.json", "no extra", "123456");
    ProfHalTlv tlv_sampleJson2 = GenerateProfHalStruct(true, 0, 0, "ghi", "sample.json", "no extra", "123456");

    ProfHalTlv tlv_sampleJson3 = GenerateProfHalStruct(false, 0, 0, "abc ", "sample.json", "no extra", "654321");
    ProfHalTlv tlv_sampleJson4 = GenerateProfHalStruct(false, 0, 0, "def ", "sample.json", "no extra", "654321");
    ProfHalTlv tlv_sampleJson5 = GenerateProfHalStruct(true, 0, 0, "ghi", "sample.json", "no extra", "654321");

    auto helperServer = std::make_shared<ProfHelperServer>();
    helperServer->SetFlushModuleCallback(SetFlushModuleCallbackStub);
    helperServer->SetSendHelperDataCallback(SendHelperDataCallbackStub);
    helperServer->SetHelperDirCallback(SetHelperDirStub);

    helperServer->ReceiveStreamData((CONST_VOID_PTR)&tlv_filename.value[0], tlv_filename.len);

    helperServer->ReceiveStreamData((CONST_VOID_PTR)&tlv_sampleJson0.value[0], tlv_sampleJson0.len);
    helperServer->ReceiveStreamData((CONST_VOID_PTR)&tlv_sampleJson1.value[0], tlv_sampleJson1.len);
    helperServer->ReceiveStreamData((CONST_VOID_PTR)&tlv_sampleJson2.value[0], tlv_sampleJson2.len);
    helperServer->ReceiveStreamData((CONST_VOID_PTR)&tlv_sampleJson3.value[0], tlv_sampleJson3.len);
    helperServer->ReceiveStreamData((CONST_VOID_PTR)&tlv_sampleJson4.value[0], tlv_sampleJson4.len);
    helperServer->ReceiveStreamData((CONST_VOID_PTR)&tlv_sampleJson5.value[0], tlv_sampleJson5.len);
    EXPECT_EQ(2, helperServer->sampleJsonMap_.size());
    EXPECT_STREQ("abc def ghi", helperServer->sampleJsonMap_[".123456"].c_str());
    EXPECT_STREQ("abc def ghi", helperServer->sampleJsonMap_[".654321"].c_str());

    helperServer->ReceiveStreamData((CONST_VOID_PTR)&tlv_normal.value[0], tlv_normal.len);
    EXPECT_EQ(g_result.isLastChunk, false);
    EXPECT_STREQ(g_result.fileName.c_str(), "normal.file");
    EXPECT_STREQ(g_result.chunk.c_str(), "12345");
    EXPECT_STREQ(g_result.id.c_str(), ".123456");
    helperServer.reset();
}