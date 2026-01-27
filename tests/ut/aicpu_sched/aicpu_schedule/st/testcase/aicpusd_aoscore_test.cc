/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <any>
#include <list>
#include "tdt/status.h"
#include "tsd.h"
#include "common/type_def.h"
#include "tdt_server.h"
#include "gtest/gtest.h"
#include "ts_api.h"
#include "mockcpp/mockcpp.hpp"
#include "operator_kernel_context.h"
#define private public
#include "aicpusd_profiler.h"
#include "aicpusd_meminfo_process.h"
#undef private

class AICPUAoscoreTEST : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "AICPUAoscoreTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "AICPUAoscoreTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUAoscoreTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUAoscoreTEST TearDown" << std::endl;
    }
};

TEST_F(AICPUAoscoreTEST, AoscoreTestSuccess)
{
    std::list<uint32_t> bindCoreList;
    int32_t ret = tdt::TDTServerInit(0, bindCoreList);
    EXPECT_EQ(ret, 0);
    ret = tdt::TDTServerStop();
    EXPECT_EQ(ret, 0);
    tdt::StatusFactory::GetInstance()->RegisterErrorNo(0, "test");
    std::string result = tdt::StatusFactory::GetInstance()->GetErrDesc(0);
    EXPECT_EQ(result, "");
    result = tdt::StatusFactory::GetInstance()->GetErrCodeDesc(0);
    EXPECT_EQ(result, "");
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerTest)
{
    AicpuSchedule::g_aicpuProfiler.InitProfiler(1, 1);
    EXPECT_EQ(AicpuSchedule::g_aicpuProfiler.pid_, 1);
    EXPECT_EQ(AicpuSchedule::g_aicpuProfiler.tid_, 1);
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerUninit)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.InitProfiler(1, 1);
    EXPECT_EQ(profiler.pid_, 1);
    EXPECT_EQ(profiler.tid_, 1);
    profiler.Uninit();
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerAgentInit)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.InitProfiler(1, 1);
    EXPECT_EQ(profiler.pid_, 1);
    EXPECT_EQ(profiler.tid_, 1);
    profiler.ProfilerAgentInit();
    profiler.Uninit();
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerInitRepeat)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.accessHiperfSo_ = true;
    profiler.hiperfExisted_ = false;
    profiler.InitProfiler(1, 1);
    EXPECT_EQ(profiler.pid_, 0);
    EXPECT_EQ(profiler.tid_, 0);
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerProfiler)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.InitProfiler(1, 1);
    profiler.hiperfExisted_ = true;
    profiler.ProfilerAgentInit();
    EXPECT_EQ(profiler.hiperfExisted_, true);
    EXPECT_EQ(profiler.accessHiperfSo_, true);
    profiler.Profiler();
    profiler.Uninit();
}

TEST_F(AICPUAoscoreTEST, AicpusdSchedGetCurCpuTick)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.InitProfiler(1, 1);
    uint64_t ret = profiler.SchedGetCurCpuTick();
    EXPECT_EQ(ret, 0UL);
}

TEST_F(AICPUAoscoreTEST, AicpusdGetAicpuSysFreq)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.InitProfiler(1, 1);
    uint64_t ret = profiler.GetAicpuSysFreq();
    EXPECT_EQ(ret, 1UL);
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerProfilerActiveStream)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.InitProfiler(1, 1);
    profiler.hiperfExisted_ = true;
    profiler.ProfilerAgentInit();
    EXPECT_EQ(profiler.hiperfExisted_, true);
    EXPECT_EQ(profiler.accessHiperfSo_, true);
    profiler.kernelTrack_.activeStream = 1;
    profiler.Profiler();
    profiler.Uninit();
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerProfilerEndGraph)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.InitProfiler(1, 1);
    profiler.hiperfExisted_ = true;
    profiler.ProfilerAgentInit();
    EXPECT_EQ(profiler.hiperfExisted_, true);
    EXPECT_EQ(profiler.accessHiperfSo_, true);
    profiler.kernelTrack_.endGraph = 1;
    profiler.Profiler();
    profiler.Uninit();
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerCpuTick)
{
    AicpuSchedule::AicpuProfiler profiler;
    const uint64_t cnt = profiler.SchedGetCurCpuTick();
    EXPECT_EQ(cnt, 0UL);
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerCpuFreq)
{
    AicpuSchedule::AicpuProfiler profiler;
    const uint64_t freq = profiler.GetAicpuSysFreq();
    EXPECT_EQ(freq, 1UL);
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerSetData)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.InitProfiler(1, 1);
    profiler.hiperfExisted_ = true;
    profiler.ProfilerAgentInit();
    EXPECT_EQ(profiler.hiperfExisted_, true);
    EXPECT_EQ(profiler.accessHiperfSo_, true);

    profiler.SetModelId(1);
    EXPECT_EQ(profiler.kernelTrack_.modelId, 1);
    profiler.SetStreamId(1);
    EXPECT_EQ(profiler.kernelTrack_.streamId, 1);
    profiler.SetTsStreamId(1);
    EXPECT_EQ(profiler.kernelTrack_.tsStreamId, 1);
    profiler.SetQueueId(1);
    EXPECT_EQ(profiler.kernelTrack_.queueId, 1);
    profiler.SetDqStart();
    profiler.SetDqEnd();
    profiler.SetModelStart();
    profiler.SetPrepareOutStart();
    profiler.SetActiveStream();
    profiler.SetEndGraph();
    profiler.SetEqStart();
    profiler.SetEqEnd();
    profiler.SetModelEnd();
    profiler.SetRepeatStart();
    profiler.SetRepeatEnd();
    profiler.SetProcEventStart();
    profiler.SetProcEventEnd();
    profiler.SetEventId(1);
    EXPECT_EQ(profiler.kernelTrack_.eventId, 1);
    profiler.SetPrepareOutEnd();

    profiler.Profiler();
    profiler.Uninit();
}

TEST_F(AICPUAoscoreTEST, AicpusdProfilerSetMbufHead)
{
    AicpuSchedule::AicpuProfiler profiler;
    profiler.InitProfiler(1, 1);
    profiler.hiperfExisted_ = true;
    profiler.ProfilerAgentInit();
    EXPECT_EQ(profiler.hiperfExisted_, true);
    EXPECT_EQ(profiler.accessHiperfSo_, true);

    AicpuSchedule::MbufHeadMsg mbufHead = {};
    profiler.SetMbufHead(reinterpret_cast<void *>(&mbufHead));

    profiler.Profiler();
    profiler.Uninit();
}

TEST_F(AICPUAoscoreTEST, TestMemInfoStubSuccess)
{
    AicpuSchedule::AicpuMemInfoProcess inst;
    BuffCfg cfg;
    EXPECT_EQ(inst.GetMemZoneInfo(cfg), AicpuSchedule::AICPU_SCHEDULE_OK);
}
