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
#include "job_device_soc.h"
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

class PROF_DEVICE_SOC_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {

    }
public:

};

TEST_F(PROF_DEVICE_SOC_UTEST, StartProf)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    auto jobDeviceSoc = std::make_shared<Analysis::Dvvp::JobWrapper::JobDeviceSoc>(0);
    std::string fileName = "/tmp/test";
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::JobDeviceSoc::GenerateFileName)
        .stubs()
        .will(returnValue(fileName));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::JobDeviceSoc::SendData)
        .stubs()
        .will(returnValue(0));
    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(2))
        .then(returnValue(2));
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

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::JobDeviceSoc::GetAndStoreStartTime)
        .stubs()
        .will(ignoreReturnValue());

    EXPECT_EQ(PROFILING_SUCCESS, jobDeviceSoc->StartProf(params));
    jobDeviceSoc->StopProf();
    jobDeviceSoc->isStarted_ = true;
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_V3_TYPE));
    EXPECT_EQ(PROFILING_FAILED, jobDeviceSoc->StartProf(params));
}

TEST_F(PROF_DEVICE_SOC_UTEST, StartProf1)
{
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    params->ai_ctrl_cpu_profiling_events = "0x11";
    params->ts_cpu_profiling_events = "0x11";
    params->llc_profiling_events = "read";
    params->ai_core_profiling_events = "0x12";
    params->aiv_profiling_events = "0x12";
    params->devices = "0";

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfChannelManager::UnInit)
        .stubs()
        .will(ignoreReturnValue());
    auto jobDeviceSoc = std::make_shared<Analysis::Dvvp::JobWrapper::JobDeviceSoc>(0);
    jobDeviceSoc->isStarted_ = true;

    EXPECT_EQ(PROFILING_FAILED, jobDeviceSoc->StartProf(params));

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::JobDeviceSoc::GetAndStoreStartTime)
        .stubs()
        .will(ignoreReturnValue());

    std::shared_ptr<CollectionJobCfg> jobCfg;
    MSVP_MAKE_SHARED0(jobCfg, CollectionJobCfg, return);
    jobDeviceSoc->collectionJobV_[HBM_DRV_COLLECTION_JOB].jobCfg = jobCfg;

    MSVP_MAKE_SHARED0(jobDeviceSoc->collectionJobCommCfg_, CollectionJobCommonParams, return);
    jobDeviceSoc->collectionJobCommCfg_->params = params;
    jobDeviceSoc->params_ = params;
    jobDeviceSoc->StartProf(params);

    jobDeviceSoc->collectionJobCommCfg_->params->nicProfiling = "on";
    jobDeviceSoc->collectionJobCommCfg_->params->dvpp_profiling = "on";
    jobDeviceSoc->collectionJobCommCfg_->params->llc_interval = 100;
    jobDeviceSoc->collectionJobCommCfg_->params->ddr_interval = 100;
    jobDeviceSoc->collectionJobCommCfg_->params->hbmProfiling = "on";
    jobDeviceSoc->collectionJobCommCfg_->params->hbm_profiling_events = "read,write";

    jobDeviceSoc->collectionJobCommCfg_->devIdOnHost = 0;

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::JobDeviceSoc::RegisterCollectionJobs)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::JobDeviceSoc::ParsePmuConfig)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    jobDeviceSoc->isStarted_ = false;
    EXPECT_EQ(PROFILING_FAILED, jobDeviceSoc->StartProf(params));
    EXPECT_EQ(PROFILING_SUCCESS, jobDeviceSoc->StartProf(params));
    jobDeviceSoc->StopProf();
    jobDeviceSoc->isStarted_ = true;
    EXPECT_EQ(PROFILING_FAILED, jobDeviceSoc->StartProf(params));
}

TEST_F(PROF_DEVICE_SOC_UTEST, StopProf)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfChannelManager::UnInit)
        .stubs()
        .will(ignoreReturnValue());
    auto jobDeviceSoc = std::make_shared<Analysis::Dvvp::JobWrapper::JobDeviceSoc>(0);
    EXPECT_EQ(PROFILING_FAILED,jobDeviceSoc->StopProf());
    jobDeviceSoc->isStarted_ = true;
    EXPECT_EQ(PROFILING_FAILED,jobDeviceSoc->StopProf());

    std::shared_ptr<PMUEventsConfig> cfg = std::make_shared<PMUEventsConfig>();
    auto tsCpuEvents = std::make_shared<std::vector<std::string>>();
    tsCpuEvents->push_back("0xa,0xb");
    cfg->ctrlCPUEvents = *tsCpuEvents;
    cfg->tsCPUEvents = *tsCpuEvents;
    cfg->llcEvents = *tsCpuEvents;
    cfg->aiCoreEvents = *tsCpuEvents;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);

    MSVP_MAKE_SHARED0(jobDeviceSoc->collectionJobCommCfg_, CollectionJobCommonParams, return);
    jobDeviceSoc->collectionJobCommCfg_->params = params;
    jobDeviceSoc->CreateCollectionJobArray();
    jobDeviceSoc->params_ = params;
    //MOCKER_CPP(&analysis::dvvp::common::thread::Thread::Stop)
    //    .stubs()
    //    .will(returnValue(PROFILING_SUCCESS));
    MOCKER(mmJoinTask)
        .stubs()
        .will(returnValue(EN_OK));

    EXPECT_EQ(PROFILING_SUCCESS,jobDeviceSoc->StopProf());

}
