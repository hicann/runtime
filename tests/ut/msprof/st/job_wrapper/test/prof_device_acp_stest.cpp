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
#include "acp_compute_device_job.h"
#include "config/config.h"
#include "config/config_manager.h"
#include "prof_manager.h"
#include "hdc/device_transport.h"
#include "param_validation.h"
#include "prof_channel_manager.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;
using namespace analysis::dvvp::common::validation;
using namespace Collector::Dvvp::Acp;

class PROF_DEVICE_ACP_STEST : public testing::Test {
protected:
    virtual void SetUp()
    {}
    virtual void TearDown()
    {}

public:
};

TEST_F(PROF_DEVICE_ACP_STEST, StartProf)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    auto acpComputeDeviceJob = std::make_shared<AcpComputeDeviceJob>(0);

    MOCKER(analysis::dvvp::driver::DrvGetDevNum).stubs().will(returnValue(2)).then(returnValue(2));
    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckProfilingParams)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfChannelManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, acpComputeDeviceJob->StartProf(params));
    acpComputeDeviceJob->isStarted_ = true;
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_V3_TYPE));
    EXPECT_EQ(PROFILING_FAILED, acpComputeDeviceJob->StartProf(params));
}

TEST_F(PROF_DEVICE_ACP_STEST, StopProf)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfChannelManager::UnInit).stubs().will(ignoreReturnValue());
    auto acpComputeDeviceJob = std::make_shared<AcpComputeDeviceJob>(0);
    EXPECT_EQ(PROFILING_FAILED, acpComputeDeviceJob->StopProf());
    acpComputeDeviceJob->isStarted_ = true;

    std::shared_ptr<PMUEventsConfig> cfg = std::make_shared<PMUEventsConfig>();
    auto tsCpuEvents = std::make_shared<std::vector<std::string>>();
    tsCpuEvents->push_back("0xa,0xb");
    cfg->ctrlCPUEvents = *tsCpuEvents;
    cfg->tsCPUEvents = *tsCpuEvents;
    cfg->llcEvents = *tsCpuEvents;
    cfg->aiCoreEvents = *tsCpuEvents;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams);

    MSVP_MAKE_SHARED0(acpComputeDeviceJob->collectionJobCommCfg_, CollectionJobCommonParams, return);
    acpComputeDeviceJob->collectionJobCommCfg_->params = params;
    acpComputeDeviceJob->CreateCollectionJobArray();
    acpComputeDeviceJob->params_ = params;
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK));

    EXPECT_EQ(PROFILING_SUCCESS, acpComputeDeviceJob->StopProf());
}

TEST_F(PROF_DEVICE_ACP_STEST, StartProf1)
{
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams);
    params->ai_ctrl_cpu_profiling_events = "0x11";
    params->ts_cpu_profiling_events = "0x11";
    params->llc_profiling_events = "read";
    params->ai_core_profiling_events = "0x12";
    params->aiv_profiling_events = "0x12";
    params->devices = "0";
    params->sysLp = "on";

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfChannelManager::UnInit).stubs().will(ignoreReturnValue());
    auto acpComputeDeviceJob = std::make_shared<AcpComputeDeviceJob>(0);
    acpComputeDeviceJob->isStarted_ = true;
    EXPECT_EQ(PROFILING_FAILED, acpComputeDeviceJob->StartProf(params));

    std::shared_ptr<CollectionJobCfg> jobCfg;
    MSVP_MAKE_SHARED0(jobCfg, CollectionJobCfg, return);
    acpComputeDeviceJob->collectionJobV_[HBM_DRV_COLLECTION_JOB].jobCfg = jobCfg;

    MSVP_MAKE_SHARED0(acpComputeDeviceJob->collectionJobCommCfg_, CollectionJobCommonParams, return);
    acpComputeDeviceJob->collectionJobCommCfg_->params = params;
    acpComputeDeviceJob->params_ = params;
    acpComputeDeviceJob->StartProf(params);

    acpComputeDeviceJob->collectionJobCommCfg_->params->nicProfiling = "on";
    acpComputeDeviceJob->collectionJobCommCfg_->params->dvpp_profiling = "on";
    acpComputeDeviceJob->collectionJobCommCfg_->params->llc_interval = 100;
    acpComputeDeviceJob->collectionJobCommCfg_->params->ddr_interval = 100;
    acpComputeDeviceJob->collectionJobCommCfg_->params->hbmProfiling = "on";
    acpComputeDeviceJob->collectionJobCommCfg_->params->hbm_profiling_events = "read,write";

    acpComputeDeviceJob->collectionJobCommCfg_->devIdOnHost = 0;

    MOCKER_CPP(&AcpComputeDeviceJob::RegisterCollectionJobs).stubs().will(returnValue(0));
    MOCKER_CPP(&AcpComputeDeviceJob::ParsePmuConfig).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(analysis::dvvp::driver::DrvGetDevNum).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(1));
    acpComputeDeviceJob->isStarted_ = false;
    EXPECT_EQ(PROFILING_FAILED, acpComputeDeviceJob->StartProf(params));
    EXPECT_EQ(PROFILING_SUCCESS, acpComputeDeviceJob->StartProf(params));
}

TEST_F(PROF_DEVICE_ACP_STEST, GenerateFileName)
{
    GlobalMockObject::verify();

    const std::string fileName = "/tmp/PROF_DEVICE_SOC_UTEST/GenerateFileName";
    auto acpComputeDeviceJob = std::make_shared<AcpComputeDeviceJob>(0);
    MSVP_MAKE_SHARED0(acpComputeDeviceJob->collectionJobCommCfg_, CollectionJobCommonParams, return);
    EXPECT_EQ(acpComputeDeviceJob->GenerateFileName(fileName), "/tmp/PROF_DEVICE_SOC_UTEST/GenerateFileName.0");
}

TEST_F(PROF_DEVICE_ACP_STEST, ParseAiCoreConfig) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckAiCoreEventsIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckAiCoreEventCoresIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    std::shared_ptr<PMUEventsConfig> cfg = std::make_shared<PMUEventsConfig>();
    auto acpComputeDeviceJob = std::make_shared<AcpComputeDeviceJob>(0);
    auto tsCpuEvents = std::make_shared<std::vector<std::string>>();
    auto tmpAiCoreEventsCoreIds = std::make_shared<std::vector<int>>();
    tsCpuEvents->push_back("0xa,0xb");
    tmpAiCoreEventsCoreIds->push_back(1);
    cfg->aiCoreEvents = *tsCpuEvents;
    cfg->aiCoreEventsCoreIds = *tmpAiCoreEventsCoreIds;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    acpComputeDeviceJob->params_ = params;
    acpComputeDeviceJob->params_->taskBlock = "on";
    std::shared_ptr<CollectionJobCfg> jobCfg1;
    MSVP_MAKE_SHARED0(jobCfg1, CollectionJobCfg, return);
    acpComputeDeviceJob->collectionJobV_[AI_CORE_SAMPLE_DRV_COLLECTION_JOB].jobCfg = jobCfg1;
    acpComputeDeviceJob->collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg = jobCfg1;
    std::shared_ptr<CollectionJobCfg> jobCfg2;
    MSVP_MAKE_SHARED0(jobCfg2, CollectionJobCfg, return);
    acpComputeDeviceJob->collectionJobV_[AI_CORE_TASK_DRV_COLLECTION_JOB].jobCfg = jobCfg2;
    acpComputeDeviceJob->collectionJobV_[FFTS_PROFILE_COLLECTION_JOB].jobCfg = jobCfg2;
    EXPECT_EQ(PROFILING_FAILED,acpComputeDeviceJob->ParseAiCoreConfig(cfg));
    EXPECT_EQ(PROFILING_FAILED,acpComputeDeviceJob->ParseAiCoreConfig(cfg));
    EXPECT_EQ(PROFILING_SUCCESS,acpComputeDeviceJob->ParseAiCoreConfig(cfg));
}

TEST_F(PROF_DEVICE_ACP_STEST, ParsePmuConfig)
{
    GlobalMockObject::verify();

    MOCKER_CPP(&AcpComputeDeviceJob::ParseAiCoreConfig).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER_CPP(&AcpComputeDeviceJob::ParseAivConfig).stubs().will(returnValue(-1)).then(returnValue(0));

    auto acpComputeDeviceJob = std::make_shared<AcpComputeDeviceJob>(0);
    std::shared_ptr<PMUEventsConfig> cfg = std::make_shared<PMUEventsConfig>();
    EXPECT_EQ(PROFILING_FAILED, acpComputeDeviceJob->ParsePmuConfig(cfg));
    EXPECT_EQ(PROFILING_FAILED, acpComputeDeviceJob->ParsePmuConfig(cfg));
}