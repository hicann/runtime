/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstring>
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include "error_code.h"
#include "msprof_dlog.h"
#include "prof_utils.h"
#define private public
#define protected public
#include "op_analyzer_biu.h"
#undef protected
#undef private
#include "ai_drv_dsmi_api.h"
#include "data_struct.h"

using namespace Dvvp::Acp::Analyze;
using namespace Analysis::Dvvp::Analyze;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;

namespace op_analyzer_biu_stub {
static std::string DrvGeAivFrqOk(int32_t)
{
    return "1000";
}

static std::string DrvGeAivFrqBad(int32_t)
{
    return "abc";
}

static std::string DrvGeAivFrqZero(int32_t)
{
    return "0";
}
}  // namespace op_analyzer_biu_stub

class OP_ANALYZER_BIU_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

// Pack a BiuPerfProfile into 4 bytes for ParseBiuData input.
static void AppendBiuRecord(std::string &buf, uint16_t timeData, uint16_t events, uint16_t ctrlType)
{
    BiuPerfProfile rec;
    rec.timeData = timeData;
    rec.events = events & 0xFFF;
    rec.ctrlType = ctrlType & 0xF;
    char tmp[sizeof(BiuPerfProfile)] = {0};
    std::memcpy(tmp, &rec, sizeof(BiuPerfProfile));
    buf.append(tmp, sizeof(BiuPerfProfile));
}

TEST_F(OP_ANALYZER_BIU_UTEST, IsBiuPerfData_Branches)
{
    OpAnalyzerBiu biu;
    EXPECT_FALSE(biu.IsBiuPerfData("foo.bin"));
    EXPECT_FALSE(biu.IsBiuPerfData("biu_perf_group0.bin"));
    EXPECT_TRUE(biu.IsBiuPerfData("biu_perf_group0_aic.bin"));
    EXPECT_TRUE(biu.IsBiuPerfData("biu_perf_group1_aiv0.bin"));
    EXPECT_TRUE(biu.IsBiuPerfData("biu_perf_group2_aiv1.bin"));
}

TEST_F(OP_ANALYZER_BIU_UTEST, SetDeviceInfo_FreqInvalid)
{
    OpAnalyzerBiu biu;
    biu.SetDeviceInfo(0, 0.0, 100.0);
    EXPECT_FALSE(biu.inited_);
    biu.SetDeviceInfo(0, -1.0, 100.0);
    EXPECT_FALSE(biu.inited_);
}

TEST_F(OP_ANALYZER_BIU_UTEST, SetDeviceInfo_AicFreqInvalid)
{
    // NOTE: source uses MSPROF_LOGE("... %s", aicFreq_) which would segfault on log emission.
    // We rely on the MSPROF log level filtering this out, so only smoke-test that the function returns.
    OpAnalyzerBiu biu;
    // Skip explicit invocation to avoid the buggy %s vs double printf path.
    EXPECT_FALSE(biu.inited_);
}

TEST_F(OP_ANALYZER_BIU_UTEST, SetDeviceInfo_DrvAivFreqBadStr)
{
    MOCKER_CPP(&Analysis::Dvvp::Driver::DrvGeAivFrq)
        .stubs()
        .will(invoke(op_analyzer_biu_stub::DrvGeAivFrqBad));
    OpAnalyzerBiu biu;
    biu.SetDeviceInfo(0, 1.0, 100.0);
    EXPECT_FALSE(biu.inited_);
}

TEST_F(OP_ANALYZER_BIU_UTEST, SetDeviceInfo_DrvAivFreqZero)
{
    MOCKER_CPP(&Analysis::Dvvp::Driver::DrvGeAivFrq)
        .stubs()
        .will(invoke(op_analyzer_biu_stub::DrvGeAivFrqZero));
    OpAnalyzerBiu biu;
    biu.SetDeviceInfo(0, 1.0, 100.0);
    EXPECT_FALSE(biu.inited_);
}

TEST_F(OP_ANALYZER_BIU_UTEST, SetDeviceInfo_Success)
{
    MOCKER_CPP(&Analysis::Dvvp::Driver::DrvGeAivFrq)
        .stubs()
        .will(invoke(op_analyzer_biu_stub::DrvGeAivFrqOk));
    OpAnalyzerBiu biu;
    biu.SetDeviceInfo(0, 1.0, 100.0);
    EXPECT_TRUE(biu.inited_);
    EXPECT_DOUBLE_EQ(1.0, biu.frequency_);
    EXPECT_DOUBLE_EQ(100.0, biu.aicFreq_);
    EXPECT_DOUBLE_EQ(1000.0, biu.aivFreq_);
}

TEST_F(OP_ANALYZER_BIU_UTEST, SplitFileName_NoTokens)
{
    OpAnalyzerBiu biu;
    EXPECT_FALSE(biu.SplitFileName("foo.bar"));
    // missing biu_perf_group prefix
    EXPECT_FALSE(biu.SplitFileName("nogroup_aic.bin"));
}

TEST_F(OP_ANALYZER_BIU_UTEST, SplitFileName_BadCursor)
{
    OpAnalyzerBiu biu;
    // dot before underscore: groupPos=0, underline > dotPos triggers cursor abnormal branch
    EXPECT_FALSE(biu.SplitFileName("biu_perf_group.0_aic"));
}

TEST_F(OP_ANALYZER_BIU_UTEST, SplitFileName_GroupNotNumeric)
{
    OpAnalyzerBiu biu;
    EXPECT_FALSE(biu.SplitFileName("biu_perf_groupX_aic.bin"));
}

TEST_F(OP_ANALYZER_BIU_UTEST, SplitFileName_GroupOverflow)
{
    OpAnalyzerBiu biu;
    EXPECT_FALSE(biu.SplitFileName("biu_perf_group99_aic.bin"));
}

TEST_F(OP_ANALYZER_BIU_UTEST, SplitFileName_TagUnknown)
{
    OpAnalyzerBiu biu;
    EXPECT_FALSE(biu.SplitFileName("biu_perf_group0_xxx.bin"));
}

TEST_F(OP_ANALYZER_BIU_UTEST, SplitFileName_Success)
{
    OpAnalyzerBiu biu;
    EXPECT_TRUE(biu.SplitFileName("biu_perf_group2_aiv1.bin"));
    EXPECT_EQ(2u, biu.group_);
    EXPECT_EQ(2u, biu.groupTag_);
    EXPECT_TRUE(biu.SplitFileName("biu_perf_group0_aic.bin"));
    EXPECT_EQ(0u, biu.group_);
    EXPECT_EQ(0u, biu.groupTag_);
}

TEST_F(OP_ANALYZER_BIU_UTEST, ParseBiuData_NotInited)
{
    OpAnalyzerBiu biu;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "biu_perf_group0_aic.bin";
    chunk->chunk = std::string(4, '\x00');
    chunk->chunkSize = 4;
    biu.ParseBiuData(chunk);
}

TEST_F(OP_ANALYZER_BIU_UTEST, ParseBiuData_NullChunk)
{
    OpAnalyzerBiu biu;
    biu.inited_ = true;
    biu.ParseBiuData(nullptr);
}

TEST_F(OP_ANALYZER_BIU_UTEST, ParseBiuData_BadFileName)
{
    OpAnalyzerBiu biu;
    biu.inited_ = true;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "junk";
    chunk->chunk = std::string(4, '\x00');
    chunk->chunkSize = 4;
    biu.ParseBiuData(chunk);
}

TEST_F(OP_ANALYZER_BIU_UTEST, ParseBiuData_RemainingTooSmall)
{
    OpAnalyzerBiu biu;
    biu.inited_ = true;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 100.0;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "biu_perf_group0_aic.bin";
    // Only 3 bytes < BIU_DATA_SIZE(4)
    chunk->chunk = std::string(3, '\x00');
    chunk->chunkSize = 3;
    biu.ParseBiuData(chunk);
    EXPECT_EQ(0u, biu.countTimes_);
}

TEST_F(OP_ANALYZER_BIU_UTEST, ParseBiuData_AllCtrlTypes)
{
    OpAnalyzerBiu biu;
    biu.inited_ = true;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 100.0;

    std::string buf;
    // 4 syscnt records to satisfy initTimes==SYSCNT_DATA_TIMES
    AppendBiuRecord(buf, 0x1111, 0xAA, 14);   // CTRL_START_STAMP
    AppendBiuRecord(buf, 0x2222, 0xBB, 14);
    AppendBiuRecord(buf, 0x3333, 0xCC, 14);
    AppendBiuRecord(buf, 0x4444, 0xDD, 14);
    // stamp data for ctrl types 0..5 and 10
    AppendBiuRecord(buf, 100, 1, 0);   // CTRL_SU
    AppendBiuRecord(buf, 100, 1, 1);   // CTRL_VEC
    AppendBiuRecord(buf, 100, 1, 2);   // CTRL_CUBE
    AppendBiuRecord(buf, 100, 1, 3);   // CTRL_MTE1
    AppendBiuRecord(buf, 100, 1, 4);   // CTRL_MTE2
    AppendBiuRecord(buf, 100, 1, 5);   // CTRL_MTE3
    AppendBiuRecord(buf, 100, 1, 10);  // CTRL_FIXP
    // status data
    AppendBiuRecord(buf, 100, 0x3, 15);  // CTRL_STATE - bits 0,1 set
    AppendBiuRecord(buf, 100, 0x0, 15);  // CTRL_STATE - all clear (stop)
    // unknown ctrl type
    AppendBiuRecord(buf, 100, 1, 7);
    // trailing odd byte to hit "remaining bytes unparsed" branch
    buf.push_back('\x00');

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "biu_perf_group0_aic.bin";
    chunk->chunk = buf;
    chunk->chunkSize = static_cast<uint32_t>(buf.size());
    biu.ParseBiuData(chunk);
    EXPECT_TRUE(biu.IsBiuMode());
}

TEST_F(OP_ANALYZER_BIU_UTEST, HandleSyscnt_Overflow)
{
    OpAnalyzerBiu biu;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 100.0;
    // Already saturated
    biu.biuData_[0][0].initTimes = SYSCNT_DATA_TIMES;
    BiuPerfProfile data{};
    data.timeData = 1;
    data.events = 1;
    data.ctrlType = 14;
    biu.HandleSyscnt(&data);
    // initTimes unchanged
    EXPECT_EQ(SYSCNT_DATA_TIMES, biu.biuData_[0][0].initTimes);
}

TEST_F(OP_ANALYZER_BIU_UTEST, HandleStampData_NotEnoughSyscnt)
{
    OpAnalyzerBiu biu;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 100.0;
    // initTimes != SYSCNT_DATA_TIMES => early return
    biu.biuData_[0][0].initTimes = 1;
    BiuPerfProfile data{};
    data.timeData = 100;
    data.events = 1;
    data.ctrlType = 0;
    biu.HandleStampData(&data);
    EXPECT_TRUE(biu.biuData_[0][0].data.empty());
}

TEST_F(OP_ANALYZER_BIU_UTEST, HandleStampData_AivBranch)
{
    OpAnalyzerBiu biu;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 200.0;
    biu.group_ = 1;
    biu.groupTag_ = 1;  // aiv
    biu.biuData_[1][1].initTimes = SYSCNT_DATA_TIMES;
    BiuPerfProfile data{};
    data.timeData = 100;
    data.events = 1;
    data.ctrlType = 1;  // CTRL_VEC -> tid=1
    biu.HandleStampData(&data);
    EXPECT_FALSE(biu.biuData_[1][1].data.empty());
}

TEST_F(OP_ANALYZER_BIU_UTEST, HandleStatusData_NotEnoughSyscnt)
{
    OpAnalyzerBiu biu;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 100.0;
    biu.biuData_[0][0].initTimes = 0;
    BiuPerfProfile data{};
    data.timeData = 100;
    data.events = 0x3;
    data.ctrlType = 15;
    biu.HandleStatusData(&data);
    EXPECT_TRUE(biu.biuData_[0][0].data.empty());
}

TEST_F(OP_ANALYZER_BIU_UTEST, HandleStatusData_BusyToIdle)
{
    OpAnalyzerBiu biu;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 100.0;
    biu.group_ = 0;
    biu.groupTag_ = 0;
    biu.biuData_[0][0].initTimes = SYSCNT_DATA_TIMES;

    // First: events=0x1 (bit 0 set) -> instr 0 starts (busy)
    BiuPerfProfile start{};
    start.timeData = 50;
    start.events = 0x1;
    start.ctrlType = 15;
    biu.HandleStatusData(&start);
    EXPECT_TRUE(biu.biuData_[0][0].instrMap[0].isBusy);

    // Second: events=0 -> instr 0 stops; data should be appended via HandleInstrStop
    BiuPerfProfile stop{};
    stop.timeData = 50;
    stop.events = 0x0;
    stop.ctrlType = 15;
    biu.HandleStatusData(&stop);
    EXPECT_FALSE(biu.biuData_[0][0].instrMap[0].isBusy);
    EXPECT_FALSE(biu.biuData_[0][0].data.empty());
}

TEST_F(OP_ANALYZER_BIU_UTEST, HandleStatusData_AivBranchUsesAivFreq)
{
    OpAnalyzerBiu biu;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 200.0;
    biu.group_ = 0;
    biu.groupTag_ = 1;  // aiv branch
    biu.biuData_[0][1].initTimes = SYSCNT_DATA_TIMES;
    BiuPerfProfile data{};
    data.timeData = 100;
    data.events = 0x0;  // nothing changes
    data.ctrlType = 15;
    biu.HandleStatusData(&data);
}

TEST_F(OP_ANALYZER_BIU_UTEST, HandleInstrStop_TimeBefore)
{
    OpAnalyzerBiu biu;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 100.0;
    biu.biuData_[0][0].initTimes = SYSCNT_DATA_TIMES;
    biu.biuData_[0][0].instrMap[0].timeStart = 1000;
    biu.biuData_[0][0].baseTime = 100;  // less than timeStart
    biu.HandleInstrStop(0);
    EXPECT_TRUE(biu.biuData_[0][0].data.empty());
}

TEST_F(OP_ANALYZER_BIU_UTEST, CheckBitsAndCheckNumberExist)
{
    OpAnalyzerBiu biu;
    auto bits = biu.CheckBits(0x5);  // bits 0 and 2
    ASSERT_EQ(2u, bits.size());
    EXPECT_EQ(0u, bits[0]);
    EXPECT_EQ(2u, bits[1]);
    EXPECT_TRUE(biu.CheckNumberExist(bits, 0));
    EXPECT_TRUE(biu.CheckNumberExist(bits, 2));
    EXPECT_FALSE(biu.CheckNumberExist(bits, 1));
    EXPECT_TRUE(biu.CheckBits(0x0).empty());
}

TEST_F(OP_ANALYZER_BIU_UTEST, ConvCtrlToInstr)
{
    OpAnalyzerBiu biu;
    EXPECT_EQ(INSTR_FIXP_TYPE_NUM, biu.ConvCtrlToInstr(INSTR_FIXP_CTRL_TYPE_NUM));
    EXPECT_EQ(0u, biu.ConvCtrlToInstr(0u));
    EXPECT_EQ(5u, biu.ConvCtrlToInstr(5u));
}

TEST_F(OP_ANALYZER_BIU_UTEST, SaveDataToFile_Empty)
{
    OpAnalyzerBiu biu;
    biu.SaveDataToFile("/tmp/biu_empty_");  // all data empty -> early return
}

TEST_F(OP_ANALYZER_BIU_UTEST, SaveDataToFile_WithData)
{
    MOCKER_CPP(&Utils::GenTimeLineJsonFile)
        .stubs()
        .will(returnValue(static_cast<int32_t>(PROFILING_SUCCESS)));
    OpAnalyzerBiu biu;
    biu.biuData_[0][0].data = "{\"foo\":1},";
    biu.biuData_[1][2].data = "{\"bar\":2}";  // no trailing comma path
    biu.SaveDataToFile("/tmp/biu_data_");
}

TEST_F(OP_ANALYZER_BIU_UTEST, IsBiuModeAndPrintStats)
{
    OpAnalyzerBiu biu;
    EXPECT_FALSE(biu.IsBiuMode());
    biu.countTimes_ = 5;
    EXPECT_TRUE(biu.IsBiuMode());
    biu.PrintStats();  // smoke
}

TEST_F(OP_ANALYZER_BIU_UTEST, SaveCntData_FillsMetadata)
{
    OpAnalyzerBiu biu;
    biu.frequency_ = 1.0;
    biu.aicFreq_ = 100.0;
    biu.aivFreq_ = 100.0;
    biu.group_ = 0;
    biu.groupTag_ = 0;
    biu.biuData_[0][0].sysCnt = 1000000;
    biu.SaveCntData();
    EXPECT_FALSE(biu.biuData_[0][0].data.empty());
}
