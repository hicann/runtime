/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License");
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <memory>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "acp_compute_device_job.h"
#include "param_validation.h"
#include "prof_channel_manager.h"
#include "prof_stars_job.h"
#include "prof_biu_perf_job.h"

using namespace Collector::Dvvp::Acp;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::JobWrapper;

namespace {
class AcpComputeDeviceJobStest : public testing::Test {
protected:
    void TearDown() override { GlobalMockObject::verify(); }

    std::shared_ptr<analysis::dvvp::message::ProfileParams> MakeParams()
    {
        auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
        params->result_dir = "/tmp/acp_compute_device_job_stest";
        params->job_id = "job-st";
        return params;
    }
};
} // namespace

TEST_F(AcpComputeDeviceJobStest, StartProfRejectsInvalidParams)
{
    AcpComputeDeviceJob job(0);
    EXPECT_EQ(PROFILING_FAILED, job.StartProf(nullptr));
    EXPECT_NE(analysis::dvvp::message::SUCCESS, job.GetLastStatus().status);
}

TEST_F(AcpComputeDeviceJobStest, StartProfStopsWhenChannelInitFails)
{
    auto params = MakeParams();
    MOCKER_CPP(&ParamValidation::CheckProfilingParams).stubs().will(returnValue(true));
    MOCKER_CPP(&ProfChannelManager::Init).stubs().will(returnValue(PROFILING_FAILED));

    AcpComputeDeviceJob job(0);
    EXPECT_EQ(PROFILING_FAILED, job.StartProf(params));
    EXPECT_EQ(analysis::dvvp::message::ERR, job.GetLastStatus().status);
    EXPECT_EQ(PROFILING_FAILED, job.StopProf());
}

TEST_F(AcpComputeDeviceJobStest, StartProfStopsWhenGetChannelsFails)
{
    auto params = MakeParams();
    MOCKER_CPP(&ParamValidation::CheckProfilingParams).stubs().will(returnValue(true));
    MOCKER_CPP(&ProfChannelManager::Init).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::GetAllChannels).stubs().will(returnValue(PROFILING_FAILED));

    AcpComputeDeviceJob job(0);
    EXPECT_EQ(PROFILING_FAILED, job.StartProf(params));
    EXPECT_EQ(analysis::dvvp::message::ERR, job.GetLastStatus().status);
    EXPECT_EQ(PROFILING_FAILED, job.StopProf());
}

TEST_F(AcpComputeDeviceJobStest, StartAndStopCoverRegisteredJobs)
{
    auto params = MakeParams();
    params->ai_core_profiling_events = "PipeUtilization";
    params->aiv_profiling_events = "VectorPipeUtilization";
    MOCKER_CPP(&ParamValidation::CheckProfilingParams).stubs().will(returnValue(true));
    MOCKER_CPP(&ParamValidation::CheckAiCoreEventsIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ParamValidation::CheckAiCoreEventCoresIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ParamValidation::CheckAivEventsIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ParamValidation::CheckAivEventCoresIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ProfChannelManager::Init).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::GetAllChannels).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&CollectionRegisterMgr::CollectionJobRegisterAndRun).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&CollectionRegisterMgr::CollectionJobUnregisterAndStop).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfChannelManager::UnInit).stubs();

    AcpComputeDeviceJob job(0);
    EXPECT_EQ(PROFILING_SUCCESS, job.StartProf(params));
    EXPECT_EQ(analysis::dvvp::message::SUCCESS, job.GetLastStatus().status);
    EXPECT_EQ(PROFILING_SUCCESS, job.StopProf());
    EXPECT_EQ(analysis::dvvp::message::SUCCESS, job.GetLastStatus().status);
}

static void PrepareStartProfSuccessMocks()
{
    MOCKER_CPP(&ParamValidation::CheckProfilingParams).stubs().will(returnValue(true));
    MOCKER_CPP(&ProfChannelManager::Init).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::GetAllChannels).stubs().will(returnValue(PROFILING_SUCCESS));
}

namespace {
int32_t AiCoreNumStub(uint32_t, int64_t& coreNum)
{
    coreNum = 2;
    return PROFILING_SUCCESS;
}

int32_t AivNumStub(uint32_t, int64_t& coreNum)
{
    coreNum = 2;
    return PROFILING_SUCCESS;
}
} // namespace

TEST_F(AcpComputeDeviceJobStest, StartProfRejectsInvalidAiCoreEvents)
{
    auto params = MakeParams();
    params->ai_core_profiling_events = "InvalidEvent";
    PrepareStartProfSuccessMocks();
    MOCKER_CPP(&ParamValidation::CheckAiCoreEventsIsValid).stubs().will(returnValue(false));

    AcpComputeDeviceJob job(0);
    EXPECT_EQ(PROFILING_FAILED, job.StartProf(params));
}

TEST_F(AcpComputeDeviceJobStest, StartProfRejectsInvalidAiCoreCores)
{
    auto params = MakeParams();
    params->ai_core_profiling_events = "PipeUtilization";
    PrepareStartProfSuccessMocks();
    MOCKER_CPP(&ParamValidation::CheckAiCoreEventsIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreNum).stubs().will(invoke(AiCoreNumStub));
    MOCKER_CPP(&ParamValidation::CheckAiCoreEventCoresIsValid).stubs().will(returnValue(false));

    AcpComputeDeviceJob job(0);
    EXPECT_EQ(PROFILING_FAILED, job.StartProf(params));
}

TEST_F(AcpComputeDeviceJobStest, StartProfRejectsInvalidAivEvents)
{
    auto params = MakeParams();
    params->aiv_profiling_events = "InvalidEvent";
    PrepareStartProfSuccessMocks();
    MOCKER_CPP(&ParamValidation::CheckAiCoreEventsIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ParamValidation::CheckAivEventsIsValid).stubs().will(returnValue(false));

    AcpComputeDeviceJob job(0);
    EXPECT_EQ(PROFILING_FAILED, job.StartProf(params));
}

TEST_F(AcpComputeDeviceJobStest, StartProfRejectsInvalidAivCores)
{
    auto params = MakeParams();
    params->aiv_profiling_events = "VectorPipeUtilization";
    PrepareStartProfSuccessMocks();
    MOCKER_CPP(&ParamValidation::CheckAiCoreEventsIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ParamValidation::CheckAivEventsIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum).stubs().will(invoke(AivNumStub));
    MOCKER_CPP(&ParamValidation::CheckAivEventCoresIsValid).stubs().will(returnValue(false));

    AcpComputeDeviceJob job(0);
    EXPECT_EQ(PROFILING_FAILED, job.StartProf(params));
}
