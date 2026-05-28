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
#include "op_analyzer_pmu.h"
#undef protected
#undef private
#include "data_struct.h"

using namespace Dvvp::Acp::Analyze;
using namespace Analysis::Dvvp::Analyze;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;

class OP_ANALYZER_PMU_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

// IsStarsData / IsFftsData
TEST_F(OP_ANALYZER_PMU_UTEST, IsStarsData_AndIsFftsData)
{
    OpAnalyzerPmu pmu;
    EXPECT_FALSE(pmu.IsStarsData("foo.txt"));
    EXPECT_TRUE(pmu.IsStarsData("device_0/stars_soc.data"));
    EXPECT_FALSE(pmu.IsFftsData("foo.txt"));
    EXPECT_TRUE(pmu.IsFftsData("device_0/ffts_profile.data"));
}

// IsExtPmu / pmuNum_ branch
TEST_F(OP_ANALYZER_PMU_UTEST, IsExtPmu_Branches)
{
    OpAnalyzerPmu pmu;
    pmu.pmuNum_ = DAVID_PMU_NUM;
    EXPECT_TRUE(pmu.IsExtPmu());
    pmu.pmuNum_ = 8;
    EXPECT_FALSE(pmu.IsExtPmu());
}

// Type-check helpers
TEST_F(OP_ANALYZER_PMU_UTEST, IsAic_NonExtPmu)
{
    OpAnalyzerPmu pmu;
    pmu.pmuNum_ = 8;  // non-ext
    EXPECT_TRUE(pmu.IsAic(FFTS_TYPE_FFTS, SUB_TASK_TYPE_AIC, 0));
    EXPECT_TRUE(pmu.IsAic(FFTS_TYPE_TRADITION_AIC, 99, 0));
    EXPECT_TRUE(pmu.IsAic(FFTS_TYPE_FFTS, SUB_TASK_TYPE_MIXAIC, 0));
    EXPECT_TRUE(pmu.IsAic(FFTS_TYPE_MIX_AIC, 99, 0));
    EXPECT_FALSE(pmu.IsAic(FFTS_TYPE_FFTS, SUB_TASK_TYPE_MIXAIV, 0));
}

TEST_F(OP_ANALYZER_PMU_UTEST, IsAic_ExtPmu)
{
    OpAnalyzerPmu pmu;
    pmu.pmuNum_ = DAVID_PMU_NUM;
    EXPECT_TRUE(pmu.IsAic(0, 0, CORE_TYPE_AIC));
    EXPECT_FALSE(pmu.IsAic(0, 0, CORE_TYPE_AIV));
}

TEST_F(OP_ANALYZER_PMU_UTEST, IsFftsAic_TraditionAic_FftsMixAic_FftsMixAiv)
{
    OpAnalyzerPmu pmu;
    EXPECT_TRUE(pmu.IsFftsAic(FFTS_TYPE_FFTS, SUB_TASK_TYPE_AIC));
    EXPECT_FALSE(pmu.IsFftsAic(FFTS_TYPE_FFTS, 99));
    EXPECT_FALSE(pmu.IsFftsAic(99, SUB_TASK_TYPE_AIC));

    EXPECT_TRUE(pmu.IsTraditionAic(FFTS_TYPE_TRADITION_AIC));
    EXPECT_FALSE(pmu.IsTraditionAic(99));

    EXPECT_TRUE(pmu.IsFftsMixAic(FFTS_TYPE_FFTS, SUB_TASK_TYPE_MIXAIC));
    EXPECT_TRUE(pmu.IsFftsMixAic(FFTS_TYPE_MIX_AIC, 0));
    EXPECT_FALSE(pmu.IsFftsMixAic(0, 0));

    EXPECT_TRUE(pmu.IsFftsMixAiv(FFTS_TYPE_FFTS, SUB_TASK_TYPE_MIXAIV));
    EXPECT_FALSE(pmu.IsFftsMixAiv(0, 0));
}

TEST_F(OP_ANALYZER_PMU_UTEST, IsMixType_AndIsSlaveCore)
{
    OpAnalyzerPmu pmu;
    EXPECT_TRUE(pmu.IsMixType(SUB_TASK_TYPE_MIXAIC));
    EXPECT_TRUE(pmu.IsMixType(SUB_TASK_TYPE_MIXAIV));
    EXPECT_FALSE(pmu.IsMixType(0));

    EXPECT_TRUE(pmu.IsSlaveCore(SUB_TASK_TYPE_MIXAIC, CORE_TYPE_AIV));
    EXPECT_TRUE(pmu.IsSlaveCore(SUB_TASK_TYPE_MIXAIV, CORE_TYPE_AIC));
    EXPECT_FALSE(pmu.IsSlaveCore(SUB_TASK_TYPE_MIXAIC, CORE_TYPE_AIC));
    EXPECT_FALSE(pmu.IsSlaveCore(0, CORE_TYPE_AIC));
}

TEST_F(OP_ANALYZER_PMU_UTEST, IsSqeControl_VariousTypes)
{
    OpAnalyzerPmu pmu;
    EXPECT_TRUE(pmu.IsSqeControl(PLACE_HOLER_SQE));
    EXPECT_TRUE(pmu.IsSqeControl(NOTIFY_RECORD_SQE));
    EXPECT_TRUE(pmu.IsSqeControl(NOTIFY_WAIT_SQE));
    EXPECT_TRUE(pmu.IsSqeControl(WRITE_VALUE_SQE));
    EXPECT_TRUE(pmu.IsSqeControl(CONDITION_SQE));
    EXPECT_TRUE(pmu.IsSqeControl(END_SQE));
    EXPECT_FALSE(pmu.IsSqeControl(0));
    EXPECT_FALSE(pmu.IsSqeControl(99));
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseStarsData_NullChunk)
{
    OpAnalyzerPmu pmu;
    pmu.ParseStarsData(nullptr);
    EXPECT_EQ(0u, pmu.starsBytes_);
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseStarsData_RemainingTooSmall)
{
    OpAnalyzerPmu pmu;
    pmu.frequency_ = 1.0;
    pmu.pmuNum_ = 8;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "stars_soc.data";
    chunk->chunk = std::string(10, '\x00');  // < STARS_DATA_SIZE
    chunk->chunkSize = 10;
    pmu.ParseStarsData(chunk);
    EXPECT_EQ(0u, pmu.starsBytes_);
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseStarsData_StarsAcsqStartEnd)
{
    OpAnalyzerPmu pmu;
    pmu.frequency_ = 1.0;
    pmu.pmuNum_ = 8;  // non-ext
    // Build a buffer with 2 records (start + end) of size STARS_DATA_SIZE each
    std::string buf;
    buf.resize(STARS_DATA_SIZE * 2 + 5, '\x00');  // tail bytes for "remains unparsed"
    auto *rec0 = reinterpret_cast<StarsAcsqLog *>(&buf[0]);
    rec0->head.logType = ACSQ_TASK_START_FUNC_TYPE;
    rec0->head.sqeType = 1;  // not control sqe
    rec0->streamId = 5;
    rec0->taskId = 7;
    rec0->sysCountHigh = 0;
    rec0->sysCountLow = 100;
    auto *rec1 = reinterpret_cast<StarsAcsqLog *>(&buf[STARS_DATA_SIZE]);
    rec1->head.logType = ACSQ_TASK_END_FUNC_TYPE;
    rec1->head.sqeType = 1;
    rec1->streamId = 5;
    rec1->taskId = 7;
    rec1->sysCountHigh = 0;
    rec1->sysCountLow = 200;

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "stars_soc.data";
    chunk->chunk = buf;
    chunk->chunkSize = static_cast<uint32_t>(buf.size());
    pmu.ParseStarsData(chunk);
    EXPECT_EQ(static_cast<uint64_t>(STARS_DATA_SIZE) * 2u, pmu.starsBytes_);
    auto it = pmu.logInfo_.find("7-5");
    ASSERT_NE(pmu.logInfo_.end(), it);
    EXPECT_EQ(100u, it->second.beginTime);
    EXPECT_EQ(200u, it->second.endTime);
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseStarsData_StarsAcsq_RepeatBeginEnd)
{
    OpAnalyzerPmu pmu;
    pmu.frequency_ = 1.0;
    pmu.pmuNum_ = 8;
    std::string buf;
    buf.resize(STARS_DATA_SIZE * 4, '\x00');
    auto build = [&](size_t idx, uint16_t logType, uint32_t timeLow) {
        auto *rec = reinterpret_cast<StarsAcsqLog *>(&buf[idx * STARS_DATA_SIZE]);
        rec->head.logType = logType;
        rec->head.sqeType = 1;
        rec->streamId = 1;
        rec->taskId = 1;
        rec->sysCountHigh = 0;
        rec->sysCountLow = timeLow;
    };
    build(0, ACSQ_TASK_START_FUNC_TYPE, 100);
    build(1, ACSQ_TASK_START_FUNC_TYPE, 150);  // repeat begin
    build(2, ACSQ_TASK_END_FUNC_TYPE, 200);
    build(3, ACSQ_TASK_END_FUNC_TYPE, 250);  // repeat end -> creates new entry

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "stars_soc.data";
    chunk->chunk = buf;
    chunk->chunkSize = static_cast<uint32_t>(buf.size());
    pmu.ParseStarsData(chunk);
    EXPECT_GE(pmu.logInfo_.size(), 1u);
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseStarsData_DavidAcsq)
{
    OpAnalyzerPmu pmu;
    pmu.frequency_ = 1.0;
    pmu.pmuNum_ = DAVID_PMU_NUM;  // ext
    std::string buf;
    buf.resize(DAVID_LOG_DATA_SIZE * 2, '\x00');
    auto *rec0 = reinterpret_cast<DavidAcsqLog *>(&buf[0]);
    rec0->head.logType = ACSQ_TASK_START_FUNC_TYPE;
    rec0->head.sqeType = 1;
    rec0->streamId = 3;
    rec0->taskId = 4;
    rec0->sysCountLow = 11;
    auto *rec1 = reinterpret_cast<DavidAcsqLog *>(&buf[DAVID_LOG_DATA_SIZE]);
    rec1->head.logType = ACSQ_TASK_END_FUNC_TYPE;
    rec1->head.sqeType = 1;
    rec1->streamId = 3;
    rec1->taskId = 4;
    rec1->sysCountLow = 22;

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "stars_soc.data";
    chunk->chunk = buf;
    chunk->chunkSize = static_cast<uint32_t>(buf.size());
    pmu.ParseStarsData(chunk);
    auto it = pmu.logInfo_.find("4-3");
    ASSERT_NE(pmu.logInfo_.end(), it);
    EXPECT_EQ(11u, it->second.beginTime);
    EXPECT_EQ(22u, it->second.endTime);
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseStarsData_SkipControlSqe)
{
    OpAnalyzerPmu pmu;
    pmu.frequency_ = 1.0;
    pmu.pmuNum_ = 8;
    std::string buf(STARS_DATA_SIZE, '\x00');
    auto *rec = reinterpret_cast<StarsAcsqLog *>(&buf[0]);
    rec->head.logType = ACSQ_TASK_START_FUNC_TYPE;
    rec->head.sqeType = PLACE_HOLER_SQE;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "stars_soc.data";
    chunk->chunk = buf;
    chunk->chunkSize = static_cast<uint32_t>(buf.size());
    pmu.ParseStarsData(chunk);
    EXPECT_TRUE(pmu.logInfo_.empty());
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseStarsData_SubTaskThread_AndUnknown)
{
    OpAnalyzerPmu pmu;
    pmu.frequency_ = 1.0;
    pmu.pmuNum_ = 8;
    std::string buf(STARS_DATA_SIZE * 2, '\x00');
    auto *rec0 = reinterpret_cast<StarsAcsqLog *>(&buf[0]);
    rec0->head.logType = FFTS_SUBTASK_THREAD_START_FUNC_TYPE;
    auto *rec1 = reinterpret_cast<StarsAcsqLog *>(&buf[STARS_DATA_SIZE]);
    rec1->head.logType = 50;  // unknown type
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "stars_soc.data";
    chunk->chunk = buf;
    chunk->chunkSize = static_cast<uint32_t>(buf.size());
    pmu.ParseStarsData(chunk);
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseFftsData_NullChunk)
{
    OpAnalyzerPmu pmu;
    pmu.ParseFftsData(nullptr);
    EXPECT_EQ(0u, pmu.fftsSubBytes_);
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseFftsData_RemainingTooSmall)
{
    OpAnalyzerPmu pmu;
    pmu.pmuNum_ = 8;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "ffts_profile.data";
    chunk->chunk = std::string(50, '\x00');  // < PMU_DATA_SIZE
    chunk->chunkSize = 50;
    pmu.ParseFftsData(chunk);
    EXPECT_EQ(0u, pmu.fftsSubBytes_);
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseFftsData_FftsSubAndBlock)
{
    OpAnalyzerPmu pmu;
    pmu.pmuNum_ = 8;
    std::string buf;
    buf.resize(PMU_DATA_SIZE * 2 + 10, '\x00');  // trailing bytes for "remains" branch
    auto *sub = reinterpret_cast<FftsSubProfile *>(&buf[0]);
    sub->head.funcType = FUNC_TYPE_SUBTASK;
    sub->streamId = 5;
    sub->taskId = 6;
    sub->contextId = 7;
    sub->fftsType = FFTS_TYPE_FFTS;
    sub->contextType = SUB_TASK_TYPE_AIC;
    sub->totalCycle = 1234;
    auto *blk = reinterpret_cast<FftsBlockProfile *>(&buf[PMU_DATA_SIZE]);
    blk->head.funcType = FUNC_TYPE_BLOCK;
    blk->streamId = 1;
    blk->taskId = 1;
    blk->contextId = 1;
    blk->contextType = SUB_TASK_TYPE_MIXAIC;
    blk->coreType = CORE_TYPE_AIV;
    blk->totalCycle = 200;
    blk->endCnt = 100;
    blk->startCnt = 0;

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "ffts_profile.data";
    chunk->chunk = buf;
    chunk->chunkSize = static_cast<uint32_t>(buf.size());
    pmu.ParseFftsData(chunk);
    EXPECT_EQ(static_cast<uint64_t>(PMU_DATA_SIZE), pmu.fftsSubBytes_);
    EXPECT_EQ(static_cast<uint64_t>(PMU_DATA_SIZE), pmu.fftsBlockBytes_);
    EXPECT_EQ(1u, pmu.subTaskInfo_.size());
    EXPECT_EQ(1u, pmu.blockInfo_.size());
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseFftsData_DavidTaskAndBlock)
{
    OpAnalyzerPmu pmu;
    pmu.pmuNum_ = DAVID_PMU_NUM;  // ext
    std::string buf(PMU_DATA_SIZE * 2, '\x00');
    auto *task = reinterpret_cast<DavidProfile *>(&buf[0]);
    task->head.funcType = FUNC_TYPE_DAVID_TASK;
    task->streamId = 1;
    task->taskId = 2;
    task->contextId = 3;
    task->contextType = 0;
    task->coreType = CORE_TYPE_AIC;
    task->totalCycle = 5000;
    task->endCnt = 100;
    task->startCnt = 0;
    auto *blk = reinterpret_cast<DavidProfile *>(&buf[PMU_DATA_SIZE]);
    blk->head.funcType = FUNC_TYPE_DAVID_BLOCK;
    blk->streamId = 1;
    blk->taskId = 1;
    blk->contextId = 1;
    blk->contextType = SUB_TASK_TYPE_MIXAIV;
    blk->coreType = CORE_TYPE_AIC;
    blk->totalCycle = 200;
    blk->endCnt = 50;
    blk->startCnt = 0;
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "ffts_profile.data";
    chunk->chunk = buf;
    chunk->chunkSize = static_cast<uint32_t>(buf.size());
    pmu.ParseFftsData(chunk);
    EXPECT_EQ(1u, pmu.subTaskInfo_.size());
    EXPECT_EQ(1u, pmu.blockInfo_.size());
}

TEST_F(OP_ANALYZER_PMU_UTEST, ParseFftsData_UnknownFuncType)
{
    OpAnalyzerPmu pmu;
    pmu.pmuNum_ = 8;
    std::string buf(PMU_DATA_SIZE, '\x00');
    auto *head = reinterpret_cast<StarsPmuHead *>(&buf[0]);
    head->funcType = 0b111111;  // unknown
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> chunk;
    MSVP_MAKE_SHARED0(chunk, analysis::dvvp::ProfileFileChunk, return);
    chunk->fileName = "ffts_profile.data";
    chunk->chunk = buf;
    chunk->chunkSize = static_cast<uint32_t>(buf.size());
    pmu.ParseFftsData(chunk);
    EXPECT_EQ(0u, pmu.fftsSubBytes_);
    EXPECT_EQ(0u, pmu.fftsBlockBytes_);
}

TEST_F(OP_ANALYZER_PMU_UTEST, HandleSubTaskThread_NoOp)
{
    OpAnalyzerPmu pmu;
    pmu.HandleSubTaskThread(nullptr, FFTS_SUBTASK_THREAD_START_FUNC_TYPE);
}

TEST_F(OP_ANALYZER_PMU_UTEST, PrintStats)
{
    OpAnalyzerPmu pmu;
    pmu.PrintStats();
}

TEST_F(OP_ANALYZER_PMU_UTEST, HandleBlockPmu_NotMixType_EarlyReturn)
{
    OpAnalyzerPmu pmu;
    pmu.pmuNum_ = 8;
    FftsBlockProfile data{};
    data.contextType = 0;  // not mix
    pmu.HandleBlockPmu(&data);
    EXPECT_TRUE(pmu.blockInfo_.empty());
}

TEST_F(OP_ANALYZER_PMU_UTEST, HandleBlockPmu_MixButNotSlave)
{
    OpAnalyzerPmu pmu;
    pmu.pmuNum_ = 8;
    FftsBlockProfile data{};
    data.contextType = SUB_TASK_TYPE_MIXAIC;
    data.coreType = CORE_TYPE_AIC;  // master core, not slave
    pmu.HandleBlockPmu(&data);
    EXPECT_TRUE(pmu.blockInfo_.empty());
}
