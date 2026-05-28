/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include "error_code.h"
#include "msprof_dlog.h"
#include "prof_utils.h"
#define private public
#define protected public
#include "op_analyzer.h"
#include "op_analyzer_pc_sampling.h"
#include "op_data_manager.h"
#undef protected
#undef private
#include "platform/platform.h"
#include "david_analyzer.h"
#include "david_platform.h"
#include "config_manager.h"
#include "ascend_hal.h"

using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::error;
using namespace Dvvp::Acp::Analyze;
using namespace analysis::dvvp::common::utils;
using namespace Dvvp::Collect::Platform;
class OP_DATA_MANAGER_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(OP_DATA_MANAGER_UTEST, DataManagerBase)
{
    GlobalMockObject::verify();
    // error data cycle
    KernelDetail data;
    data.streamId = 1;
    data.beginTime = 100;
    data.endTime = 200;
    data.aicTotalCycle = 0;
    data.aivTotalCycle = 0;
    std::string metrics1 = "Custom:0xa";
    std::string metrics2 = "Custom:0xb";
    OpDataManager::instance()->UnInit();
    // replay time 1
    for (uint32_t i = 0; i < 5; i++) {
        OpDataManager::instance()->AddMetrics(metrics1);
        OpDataManager::instance()->AddSummaryInfo(data);
        OpDataManager::instance()->AddAnalyzeCount();
    }
    // replay time 2
    for (uint32_t i = 0; i < 5; i++) {
        OpDataManager::instance()->AddMetrics(metrics2);
        OpDataManager::instance()->AddSummaryInfo(data);
        OpDataManager::instance()->AddAnalyzeCount();
    }
    std::vector<std::string> metricsVec = OpDataManager::instance()->GetMetricsInfo();
    std::vector<std::vector<KernelDetail>> summaryVec = OpDataManager::instance()->GetSummaryInfo();
    EXPECT_EQ(2, metricsVec.size());
    EXPECT_EQ(2, summaryVec.size());
    EXPECT_EQ(10, OpDataManager::instance()->GetAnalyzeCount());
    // Op data over flow
    EXPECT_EQ(false, OpDataManager::instance()->CheckSummaryInfoData(1));
    // Op data not enough
    EXPECT_EQ(false, OpDataManager::instance()->CheckSummaryInfoData(3));
    // Op data not complete
    EXPECT_EQ(false, OpDataManager::instance()->CheckSummaryInfoData(2));
    OpDataManager::instance()->UnInit();
    metricsVec.clear();
    summaryVec.clear();
    // normal data cycle
    KernelDetail data2;
    data2.streamId = 1;
    data2.beginTime = 100;
    data2.endTime = 200;
    data2.aicTotalCycle = 1000;
    data2.aivTotalCycle = 0;
    // replay time 1
    for (uint32_t i = 0; i < 5; i++) {
        OpDataManager::instance()->AddMetrics(metrics1);
        OpDataManager::instance()->AddSummaryInfo(data2);
        OpDataManager::instance()->AddAnalyzeCount();
    }
    metricsVec = OpDataManager::instance()->GetMetricsInfo();
    summaryVec = OpDataManager::instance()->GetSummaryInfo();
    EXPECT_EQ(1, metricsVec.size());
    EXPECT_EQ(1, summaryVec.size());
    EXPECT_EQ(5, OpDataManager::instance()->GetAnalyzeCount());
    EXPECT_EQ(true, OpDataManager::instance()->CheckSummaryInfoData(1));
    OpDataManager::instance()->UnInit();
}

drvError_t halGetDeviceInfoTransOpStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value) {
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

TEST_F(OP_DATA_MANAGER_UTEST, OpAnalyzerDavidBase)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_CLOUD_V3));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoTransOpStub));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    // init analyzer object
    SHARED_PTR_ALIA<Dvvp::Acp::Analyze::OpAnalyzer> analyzer_ = nullptr;
    MSVP_MAKE_SHARED0(analyzer_, Dvvp::Acp::Analyze::OpAnalyzer, return);
    analyzer_->InitAnalyzerByDeviceId("0");
    // normal data cycle
    KernelDetail data2;
    data2.streamId = 1;
    data2.beginTime = 100;
    data2.endTime = 200;
    data2.aicTotalCycle = 10000;
    data2.aivTotalCycle = 0;
    data2.aicCnt = 1000;
    data2.aivCnt = 10000;
    uint64_t val = 100;
    for (uint32_t i = 0; i < 20; ++i) {
        data2.pmu[i] = val;
        val += 100;
    }
    // replay time 1
    for (uint32_t i = 0; i < 5; i++) {
        OpDataManager::instance()->AddSummaryInfo(data2);
    }
    std::vector<std::vector<KernelDetail>> summaryVec = OpDataManager::instance()->GetSummaryInfo();
    EXPECT_EQ(1, summaryVec.size());
    EXPECT_EQ(true, OpDataManager::instance()->CheckSummaryInfoData(1));

    // transport end_info chunk
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return);
    fileChunk->fileName = Utils::PackDotInfo("end_info", "1");
    fileChunk->offset = -1;
    fileChunk->chunk = "Custom:0x1,0x2,0x3";
    fileChunk->chunkSize = fileChunk->chunk.size();
    fileChunk->isLastChunk = false;
    fileChunk->chunkModule = 0;
    fileChunk->extraInfo = "./david_";
    fileChunk->id = "1";
    for (uint32_t i = 0; i < 5; i++) {
        analyzer_->OnOpData(fileChunk);
    }

    std::vector<std::string> metricsVec = OpDataManager::instance()->GetMetricsInfo();
    EXPECT_EQ(0, metricsVec.size());
    EXPECT_EQ(0, OpDataManager::instance()->GetAnalyzeCount());

    // replay time 2
    for (uint32_t i = 0; i < 5; i++) {
        OpDataManager::instance()->AddSummaryInfo(data2);
    }
    std::vector<std::vector<KernelDetail>> summaryVec2 = OpDataManager::instance()->GetSummaryInfo();
    EXPECT_EQ(1, summaryVec2.size());
    EXPECT_EQ(true, OpDataManager::instance()->CheckSummaryInfoData(1));

    MOCKER_CPP(&OpAnalyzerBiu::IsBiuMode)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&OpAnalyzerPcSampling::IsPcSamplingMode)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    // IsBiuMode
    for (uint32_t i = 0; i < 5; i++) {
        analyzer_->OnOpData(fileChunk);
    }
    // IsPcSamplingMode
    for (uint32_t i = 0; i < 5; i++) {
        analyzer_->OnOpData(fileChunk);
    }

    OpDataManager::instance()->UnInit();
    Platform::instance()->Uninit();
}

TEST_F(OP_DATA_MANAGER_UTEST, OpAnalyzerMilanBase)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_V4_1_0));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoTransOpStub));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    // init analyzer object
    SHARED_PTR_ALIA<Dvvp::Acp::Analyze::OpAnalyzer> analyzer_ = nullptr;
    MSVP_MAKE_SHARED0(analyzer_, Dvvp::Acp::Analyze::OpAnalyzer, return);
    analyzer_->InitAnalyzerByDeviceId("0");
    // normal data cycle
    KernelDetail data2;
    data2.streamId = 1;
    data2.beginTime = 100;
    data2.endTime = 200;
    data2.aicTotalCycle = 10000;
    data2.aivTotalCycle = 0;
    data2.aicCnt = 1000;
    data2.aivCnt = 10000;
    uint64_t val = 100;
    for (uint32_t i = 0; i < 20; ++i) {
        data2.pmu[i] = val;
        val += 100;
    }
    // replay time 1
    for (uint32_t i = 0; i < 5; i++) {
        OpDataManager::instance()->AddSummaryInfo(data2);
    }
    std::vector<std::vector<KernelDetail>> summaryVec = OpDataManager::instance()->GetSummaryInfo();
    EXPECT_EQ(1, summaryVec.size());
    EXPECT_EQ(true, OpDataManager::instance()->CheckSummaryInfoData(1));

    // transport end_info chunk
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return);
    fileChunk->fileName = Utils::PackDotInfo("end_info", "1");
    fileChunk->offset = -1;
    fileChunk->chunk = "PipeUtilization";
    fileChunk->chunkSize = fileChunk->chunk.size();
    fileChunk->isLastChunk = false;
    fileChunk->chunkModule = 0;
    fileChunk->extraInfo = "./milan_";
    fileChunk->id = "1";
    for (uint32_t i = 0; i < 5; i++) {
        analyzer_->OnOpData(fileChunk);
    }
    std::vector<std::string> metricsVec = OpDataManager::instance()->GetMetricsInfo();
    EXPECT_EQ(0, metricsVec.size());
    EXPECT_EQ(0, OpDataManager::instance()->GetAnalyzeCount());
    OpDataManager::instance()->UnInit();
    Platform::instance()->Uninit();
}

TEST_F(OP_DATA_MANAGER_UTEST, PcSampling_IsPcSamplingData)
{
    GlobalMockObject::verify();
    OpAnalyzerPcSampling pc;
    EXPECT_FALSE(pc.IsPcSamplingData("foo.csv"));
    EXPECT_TRUE(pc.IsPcSamplingData("david_pc_sampling.bin"));
    // No data parsed -> IsPcSamplingMode returns false
    EXPECT_FALSE(pc.IsPcSamplingMode());
}

TEST_F(OP_DATA_MANAGER_UTEST, PcSampling_ParsePcSamplingData_AndAnalyze)
{
    GlobalMockObject::verify();
    OpAnalyzerPcSampling pc;

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return);
    fileChunk->fileName = "pc_sampling.0";
    fileChunk->offset = -1;
    // Construct payload: 16 bytes (looks like one SamplingInstrRecord aligned).
    std::string payload(16, '\x01');
    fileChunk->chunk = payload;
    fileChunk->chunkSize = payload.size();
    fileChunk->isLastChunk = false;

    // First parse: data is filled and at least one record extracted.
    pc.ParsePcSamplingData(fileChunk);
    // After parsing, mode becomes true.
    EXPECT_TRUE(pc.IsPcSamplingMode());

    // Add another chunk for second branch (find succeeds in first if).
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk2;
    MSVP_MAKE_SHARED0(fileChunk2, analysis::dvvp::ProfileFileChunk, return);
    fileChunk2->fileName = "pc_sampling.0";
    fileChunk2->chunk = payload;
    fileChunk2->chunkSize = payload.size();
    pc.ParsePcSamplingData(fileChunk2);

    // Analyze: stub AnalyzeBinaryObject + DumpFile so we do not depend on llvm-objdump.
    MOCKER_CPP(&Utils::ExecCmd)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_FAILED)));
    MOCKER_CPP(&Utils::DumpFile)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    pc.AnalyzePcSamplingDataAndSaveSummary("/tmp/pc_sampling_out");
    // After analyze, sampling enable cleared
    // (no public getter; we just verify subsequent call is the early-return branch)
    pc.AnalyzePcSamplingDataAndSaveSummary("/tmp/pc_sampling_out");
}

TEST_F(OP_DATA_MANAGER_UTEST, OpAnalyzer_OnOpData_NotInited)
{
    SHARED_PTR_ALIA<Dvvp::Acp::Analyze::OpAnalyzer> analyzer = nullptr;
    MSVP_MAKE_SHARED0(analyzer, Dvvp::Acp::Analyze::OpAnalyzer, return);
    analyzer->inited_ = false;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return);
    fileChunk->fileName = "anything";
    analyzer->OnOpData(fileChunk);
    // null fileChunk path
    analyzer->inited_ = true;
    analyzer->OnOpData(nullptr);
    // empty fileName path
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> emptyChunk;
    MSVP_MAKE_SHARED0(emptyChunk, analysis::dvvp::ProfileFileChunk, return);
    emptyChunk->fileName = "";
    analyzer->OnOpData(emptyChunk);
}

TEST_F(OP_DATA_MANAGER_UTEST, OpAnalyzer_InitAnalyzerByDeviceId_BadId)
{
    SHARED_PTR_ALIA<Dvvp::Acp::Analyze::OpAnalyzer> analyzer = nullptr;
    MSVP_MAKE_SHARED0(analyzer, Dvvp::Acp::Analyze::OpAnalyzer, return);
    analyzer->inited_ = true;
    // not numeric -> StrToUint32 fails -> hit branch lines 60-63
    analyzer->InitAnalyzerByDeviceId("not_a_number_id");
    EXPECT_FALSE(analyzer->inited_);
}

TEST_F(OP_DATA_MANAGER_UTEST, OpAnalyzer_BlockAndSubTaskAssociation_Empty)
{
    SHARED_PTR_ALIA<Dvvp::Acp::Analyze::OpAnalyzer> analyzer = nullptr;
    MSVP_MAKE_SHARED0(analyzer, Dvvp::Acp::Analyze::OpAnalyzer, return);
    // BlockInfoMatch with key not in blockInfo_ -> early return (lines 210-212)
    KernelDetail value;
    analyzer->BlockInfoMatch("nonexistent", value);

    // SubTaskInfoMatch with empty subTaskInfo_ -> nothing happens
    analyzer->SubTaskInfoMatch(value);

    // Empty StoreAssociation path
    analyzer->StoreAssociation();
}

TEST_F(OP_DATA_MANAGER_UTEST, OpAnalyzer_OnOpData_EndInfo_ConvertFail)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_CLOUD_V3));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoTransOpStub));
    Platform::instance()->Uninit();
    Platform::instance()->Init();

    SHARED_PTR_ALIA<Dvvp::Acp::Analyze::OpAnalyzer> analyzer = nullptr;
    MSVP_MAKE_SHARED0(analyzer, Dvvp::Acp::Analyze::OpAnalyzer, return);
    analyzer->inited_ = true;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return);
    // GetInfoSuffix returns non-numeric -> StrToUint32 fails -> early return
    fileChunk->fileName = Utils::PackDotInfo("end_info", "abc");
    fileChunk->chunk = "Custom:0x1";
    fileChunk->id = "1";
    analyzer->OnOpData(fileChunk);
    Platform::instance()->Uninit();
}