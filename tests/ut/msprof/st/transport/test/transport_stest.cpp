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
#include "transport/file_transport.h"
#include "errno/error_code.h"
#include "config/config.h"
#include "op_transport.h"
#include "data_struct.h"
#include "config_manager.h"
#include "platform/platform.h"
#include "ascend_hal.h"

using namespace analysis::dvvp::transport;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;
using namespace Dvvp::Acp::Analyze;
class TRANSPORT_TRANSPORT_ITRANSPORT_TEST: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("mkdir ./transport_stest_workspace");
    }

    virtual void TearDown()
    {
        system("rm -rf ./transport_stest_workspace");
    }
private:
};

ProfTlv GenerateProfTlvData(bool isLastChunk, int32_t chunkModule, size_t offset,
    std::string chunk, std::string fileName, std::string extraInfo, std::string id)
{
    ProfTlvValue data;
    data.isLastChunk = isLastChunk;
    data.chunkModule = chunkModule;
    data.chunkSize = chunk.size();
    data.offset = offset;

    strcpy_s(data.chunk, TLV_VALUE_CHUNK_MAX_LEN, chunk.c_str());
    strcpy_s(data.fileName, TLV_VALUE_FILENAME_MAX_LEN, fileName.c_str());
    strcpy_s(data.extraInfo, TLV_VALUE_EXTRAINFO_MAX_LEN, extraInfo.c_str());
    strcpy_s(data.id, TLV_VALUE_ID_MAX_LEN, id.c_str());

    struct ProfTlv tlv;
    tlv.head = TLV_HEAD;
    tlv.version = 0x100;
    tlv.type = 1;
    tlv.len = sizeof(ProfTlvValue);
    memcpy_s(tlv.value, TLV_VALUE_MAX_LEN, &data, sizeof(ProfTlvValue));
    return tlv;
}

TEST_F(TRANSPORT_TRANSPORT_ITRANSPORT_TEST, SendBuffer_TLV) {
    GlobalMockObject::verify();

    std::string path = Utils::RelativePathToAbsolutePath("transport_stest_workspace/");
    std::shared_ptr<FILETransport> trans(new FILETransport(path, "200MB"));
    std::shared_ptr<PerfCount> perfCount(new PerfCount("test"));
    trans->perfCount_ = perfCount;
    trans->Init();

    std::shared_ptr<analysis::dvvp::ProfileFileChunk> message(new analysis::dvvp::ProfileFileChunk());
    message->extraInfo = "trace000000017775175798806765773.0";
    message->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_DEVICE;
    message->fileName = "data/adprof.data.null";
    ProfTlv tlv_data1 = GenerateProfTlvData(false, 0, -1, "12345", "Memory.data", "no extra", "123456");
    ProfTlv tlv_data2 = GenerateProfTlvData(false, 0, -1, "faef", "AppCpuUsage.data", "no extra", "123456");
    message->chunk = std::string();
    message->chunk.reserve(2 * sizeof(ProfTlv));
    message->chunk.insert(0, std::string(reinterpret_cast<CHAR_PTR>(&tlv_data1), sizeof(ProfTlv)));
    message->chunk.insert(sizeof(ProfTlv), std::string(reinterpret_cast<CHAR_PTR>(&tlv_data2), 100));
    message->chunkSize = message->chunk.size();


    EXPECT_EQ(PROFILING_SUCCESS, trans->SendBuffer(message));
    message->chunk = std::string(reinterpret_cast<CHAR_PTR>(&tlv_data2) + 100, sizeof(ProfTlv) - 100);
    message->chunkSize = message->chunk.size();
    EXPECT_EQ(PROFILING_SUCCESS, trans->SendBuffer(message));
    std::vector<std::string> files;
    Utils::GetFiles(path, true, files, 1);
    int32_t findNum = 0;
    for (const std::string &file : files) {
        if (file.find("Memory.data") != std::string::npos) {
            findNum++;
        }
        if (file.find("AppCpuUsage.data") != std::string::npos) {
            findNum++;
        }
    }
    EXPECT_EQ(2, findNum);
}

drvError_t halGetDeviceInfoTransStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value) {
    if (moduleType == static_cast<int32_t>(MODULE_TYPE_AICORE) &&
        (infoType == static_cast<int32_t>(INFO_TYPE_CORE_NUM))) {
        *value = 20;
    } else if (moduleType == static_cast<int32_t>(MODULE_TYPE_VECTOR_CORE) &&
        (infoType == static_cast<int32_t>(INFO_TYPE_CORE_NUM))) {
        *value = 40;
    } else if (moduleType == static_cast<int32_t>(MODULE_TYPE_SYSTEM) &&
        (infoType == static_cast<int32_t>(INFO_TYPE_DEV_OSC_FREQUE))) {
        *value = 50000;
    }
    return DRV_ERROR_NONE;
}

TEST_F(TRANSPORT_TRANSPORT_ITRANSPORT_TEST, ParseMilanOpAicData) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::AscendHalAdaptor::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoTransStub));
    Platform::instance()->Init();
    using namespace Analysis::Dvvp::Analyze;
    std::string deviceId = "0";
    auto trans = OpTransportFactory().CreateOpTransport(deviceId);
    EXPECT_NE((ITransport*)NULL, trans.get());
    // stars_soc.data
    std::shared_ptr<analysis::dvvp::ProfileFileChunk> chunk(
        new analysis::dvvp::ProfileFileChunk());
    chunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_DEVICE;
    chunk->fileName = "stars_soc.data";
    chunk->extraInfo = "null.0";
    StarsAcsqLog data;
    data.streamId = 0;
    data.taskId = 1;
    // start
    data.sysCountHigh = 1;
    data.sysCountLow = 1;
    data.head.logType = ACSQ_TASK_START_FUNC_TYPE;
    std::string starsData((char *)&data, sizeof(data));
    chunk->chunk = starsData;
    chunk->chunkSize = sizeof(data);
    int ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // end
    data.sysCountHigh = 1;
    data.sysCountLow = 2;
    data.head.logType = ACSQ_TASK_END_FUNC_TYPE;
    std::string starsDataEnd((char *)&data, sizeof(data));
    chunk->chunk = starsDataEnd;
    chunk->chunkSize = sizeof(data);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // Ffts.data
    chunk->fileName = "ffts_profile.data";
    FftsSubProfile data2;
    data2.streamId = 0;
    data2.taskId = 1;
    data2.head.funcType = 0b101000;
    data2.fftsType = FFTS_TYPE_FFTS;
    data2.contextType = SUB_TASK_TYPE_AIC;
    data2.totalCycle = 1000;
    data2.startCnt = 0;
    data2.endCnt = 1;
    data2.pmu[0] = 10;
    data2.pmu[1] = 20;
    data2.pmu[2] = 30;
    data2.pmu[3] = 40;
    data2.pmu[4] = 50;
    data2.pmu[5] = 60;
    data2.pmu[6] = 70;
    data2.pmu[7] = 80;
    std::string FftsData((char *)&data2, sizeof(data2));
    chunk->chunk = FftsData;
    chunk->chunkSize = sizeof(data2);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // end_info
    std::shared_ptr<analysis::dvvp::ProfileFileChunk> chunk2(
        new analysis::dvvp::ProfileFileChunk());
    chunk2->fileName = "end_info";
    chunk2->extraInfo = "./";
    chunk2->chunk = "PipeUtilization";
    uint16_t low = 0x0001;
    uint16_t high = 0x0000;
    uint32_t blockDim = ((uint32_t)high << 16) | low;
    chunk2->id = std::to_string(blockDim);
    ret = trans->SendBuffer(chunk2);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    Platform::instance()->Uninit();
}

TEST_F(TRANSPORT_TRANSPORT_ITRANSPORT_TEST, ParseMilanOpAivData) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::AscendHalAdaptor::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoTransStub));
    Platform::instance()->Init();
    using namespace Analysis::Dvvp::Analyze;
    std::string deviceId = "0";
    auto trans = OpTransportFactory().CreateOpTransport(deviceId);
    EXPECT_NE((ITransport*)NULL, trans.get());
    // stars_soc.data
    std::shared_ptr<analysis::dvvp::ProfileFileChunk> chunk(
        new analysis::dvvp::ProfileFileChunk());
    chunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_DEVICE;
    chunk->fileName = "stars_soc.data";
    chunk->extraInfo = "null.0";
    StarsAcsqLog data;
    data.streamId = 0;
    data.taskId = 1;
    // start
    data.sysCountHigh = 1;
    data.sysCountLow = 1;
    data.head.logType = ACSQ_TASK_START_FUNC_TYPE;
    std::string starsData((char *)&data, sizeof(data));
    chunk->chunk = starsData;
    chunk->chunkSize = sizeof(data);
    int ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // end
    data.sysCountHigh = 1;
    data.sysCountLow = 2;
    data.head.logType = ACSQ_TASK_END_FUNC_TYPE;
    std::string starsDataEnd((char *)&data, sizeof(data));
    chunk->chunk = starsDataEnd;
    chunk->chunkSize = sizeof(data);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // Ffts.data
    chunk->fileName = "ffts_profile.data";
    FftsSubProfile data2;
    data2.streamId = 0;
    data2.taskId = 1;
    data2.head.funcType = 0b101000;
    data2.fftsType = FFTS_TYPE_FFTS;
    data2.contextType = SUB_TASK_TYPE_AIC + 1;
    data2.totalCycle = 1000;
    data2.startCnt = 0;
    data2.endCnt = 1;
    data2.pmu[0] = 10;
    data2.pmu[1] = 20;
    data2.pmu[2] = 30;
    data2.pmu[3] = 40;
    data2.pmu[4] = 50;
    data2.pmu[5] = 60;
    data2.pmu[6] = 70;
    data2.pmu[7] = 80;
    std::string FftsData((char *)&data2, sizeof(data2));
    chunk->chunk = FftsData;
    chunk->chunkSize = sizeof(data2);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // end_info
    std::shared_ptr<analysis::dvvp::ProfileFileChunk> chunk2(
        new analysis::dvvp::ProfileFileChunk());
    chunk2->fileName = "end_info";
    chunk2->extraInfo = "./";
    chunk2->chunk = "ArithmeticUtilization";
    uint16_t low = 0x0001;
    uint16_t high = 0x0000;
    uint32_t blockDim = ((uint32_t)high << 16) | low;
    chunk2->id = std::to_string(blockDim);
    ret = trans->SendBuffer(chunk2);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    Platform::instance()->Uninit();
}

TEST_F(TRANSPORT_TRANSPORT_ITRANSPORT_TEST, ParseMilanOpMixAicData) { // aic context，aiv block
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::AscendHalAdaptor::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoTransStub));
    Platform::instance()->Init();
    using namespace Analysis::Dvvp::Analyze;
    std::string deviceId = "0";
    auto trans = OpTransportFactory().CreateOpTransport(deviceId);
    EXPECT_NE((ITransport*)NULL, trans.get());
    // stars_soc.data
    std::shared_ptr<analysis::dvvp::ProfileFileChunk> chunk(
        new analysis::dvvp::ProfileFileChunk());
    chunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_DEVICE;
    chunk->fileName = "stars_soc.data";
    chunk->extraInfo = "null.0";
    StarsAcsqLog data;
    data.streamId = 0;
    data.taskId = 1;
    // start
    data.sysCountHigh = 1;
    data.sysCountLow = 1;
    data.head.logType = ACSQ_TASK_START_FUNC_TYPE;
    std::string starsData((char *)&data, sizeof(data));
    chunk->chunk = starsData;
    chunk->chunkSize = sizeof(data);
    int ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // end
    data.sysCountHigh = 1;
    data.sysCountLow = 2;
    data.head.logType = ACSQ_TASK_END_FUNC_TYPE;
    std::string starsDataEnd((char *)&data, sizeof(data));
    chunk->chunk = starsDataEnd;
    chunk->chunkSize = sizeof(data);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // Ffts.data context
    chunk->fileName = "ffts_profile.data";
    FftsSubProfile data2;
    data2.streamId = 0;
    data2.taskId = 1;
    data2.contextId = 1;
    data2.head.funcType = 0b101000;
    data2.fftsType = FFTS_TYPE_FFTS;
    data2.contextType = SUB_TASK_TYPE_MIXAIC;
    data2.totalCycle = 1000;
    data2.startCnt = 0;
    data2.endCnt = 1;
    data2.pmu[0] = 10;
    data2.pmu[1] = 20;
    data2.pmu[2] = 30;
    std::string FftsSubData((char *)&data2, sizeof(data2));
    chunk->chunk = FftsSubData;
    chunk->chunkSize = sizeof(data2);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // Ffts.data block
    FftsBlockProfile data3;
    data3.streamId = 0;
    data3.taskId = 1;
    data3.contextId = 1;
    data3.head.funcType = 0b101001;
    data3.fftsType = FFTS_TYPE_FFTS;
    data3.contextType = SUB_TASK_TYPE_MIXAIC;
    data3.coreType = CORE_TYPE_AIV;
    data3.totalCycle = 1000;
    data3.startCnt = 0;
    data3.endCnt = 1;
    data3.pmu[0] = 10;
    data3.pmu[1] = 20;
    data3.pmu[2] = 30;
    std::string FftsBlockData((char *)&data3, sizeof(data3));
    chunk->chunk = FftsBlockData;
    chunk->chunkSize = sizeof(data3);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // Ffts.data block repeat 3
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // end_info
    std::shared_ptr<analysis::dvvp::ProfileFileChunk> chunk2(
        new analysis::dvvp::ProfileFileChunk());
    chunk2->fileName = "end_info";
    chunk2->extraInfo = "./";
    chunk2->chunk = "ResourceConflictRatio";
    uint16_t low = 0x0001;
    uint16_t high = 0x0010;
    uint32_t blockDim = ((uint32_t)high << 16) | low;
    chunk2->id = std::to_string(blockDim);
    ret = trans->SendBuffer(chunk2);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    Platform::instance()->Uninit();
}