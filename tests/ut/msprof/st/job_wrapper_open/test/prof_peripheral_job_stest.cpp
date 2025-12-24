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
#include <sys/wait.h>
#include <sys/time.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>
#include <sys/stat.h>
#include <string>
#include <fstream>
#include <iostream>
#include <sstream>
#include <pthread.h>
#include "utils/utils.h"
#include "errno/error_code.h"
#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "config/config.h"
#include "config/open/config_manager.h"
#include "prof_timer.h"
#include "prof_channel_manager.h"
#include "platform/platform.h"
#include "prof_hardware_mem_job.h"
#include "prof_dvpp_job.h"
#include "prof_lpm_job.h"
#include "prof_inter_connection_job.h"
#include "prof_io_job.h"
#include "prof_perf_job.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;

class JOB_WRAPPER_PROF_PERIPHERAL_JOB_OPEN_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        comParams->jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_PERIPHERAL_JOB_OPEN_TEST, Init) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));
    auto profPeripheralJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfPeripheralJob>();
    EXPECT_EQ(PROFILING_FAILED, profPeripheralJob->Init(nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, profPeripheralJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_PERIPHERAL_JOB_OPEN_TEST, Process) {
    GlobalMockObject::verify();
    auto profPeripheralJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfPeripheralJob>();
    profPeripheralJob->Init(collectionJobCfg_);

    collectionJobCfg_->comParams->params->nicProfiling = "NIaC";
    EXPECT_EQ(PROFILING_SUCCESS, profPeripheralJob->Process());
    collectionJobCfg_->comParams->params->nicProfiling = "on";
    collectionJobCfg_->comParams->params->dvpp_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profPeripheralJob->Process());

    EXPECT_EQ(PROFILING_SUCCESS, profPeripheralJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_PERIPHERAL_JOB_OPEN_TEST, Uninit) {
    GlobalMockObject::verify();

    auto profPeripheralJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfPeripheralJob>();
    collectionJobCfg_->comParams->params->nicProfiling = "on";
    collectionJobCfg_->comParams->params->dvpp_profiling = "on";
    profPeripheralJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS,profPeripheralJob->Uninit());
}

class JOB_WRAPPER_PROF_DDR_JOB_OPEN_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->jobParams.events->push_back("0x11");
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_DDR_JOB_OPEN_TEST, Init) {
    GlobalMockObject::verify();

    auto proDdrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDdrJob>();
    collectionJobCfg_->jobParams.events = nullptr;
    EXPECT_EQ(PROFILING_FAILED, proDdrJob->Init(collectionJobCfg_));
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    collectionJobCfg_->jobParams.events->push_back("write");
    collectionJobCfg_->jobParams.events->push_back("read");
    collectionJobCfg_->comParams->params->ddr_interval = 30;
    EXPECT_EQ(PROFILING_FAILED, proDdrJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->ddr_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, proDdrJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_FAILED, proDdrJob->Init(nullptr));
}

TEST_F(JOB_WRAPPER_PROF_DDR_JOB_OPEN_TEST, Process) {
    GlobalMockObject::verify();

    auto proDdrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDdrJob>();
    proDdrJob->Init(collectionJobCfg_);
    auto poller = std::make_shared<analysis::dvvp::transport::ChannelPoll>();
    MOCKER_CPP(&ProfChannelManager::GetChannelPoller)
        .stubs()
        .will(returnValue(poller));
    EXPECT_EQ(PROFILING_SUCCESS, proDdrJob->Process());
    MOCKER(malloc)
        .stubs()
        .will(returnValue((void*)nullptr));
    EXPECT_EQ(PROFILING_FAILED, proDdrJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_DDR_JOB_OPEN_TEST, SetPeripheralConfig) {
    GlobalMockObject::verify();
    unsigned char tmp[100] = {0};
    auto proDdrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDdrJob>();
    collectionJobCfg_->comParams->params->ddr_profiling = "on";
    proDdrJob->Init(collectionJobCfg_);
    MOCKER(analysis::dvvp::common::utils::Utils::ProfMalloc)
        .stubs()
        .will(returnValue((void*)tmp));
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    collectionJobCfg_->jobParams.events->push_back("write");
    collectionJobCfg_->jobParams.events->push_back("read");
    collectionJobCfg_->jobParams.events->push_back("master_id");
    EXPECT_EQ(PROFILING_SUCCESS, proDdrJob->SetPeripheralConfig());
    EXPECT_EQ(PROFILING_SUCCESS, proDdrJob->SetPeripheralConfig());
}


TEST_F(JOB_WRAPPER_PROF_DDR_JOB_OPEN_TEST, AddReader) {
    GlobalMockObject::verify();

    auto proDdrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDdrJob>();
    EXPECT_NE(nullptr, proDdrJob);
    auto poller = std::make_shared<analysis::dvvp::transport::ChannelPoll>();
    EXPECT_NE(nullptr, poller);
    int dev_id = 0;
    analysis::dvvp::driver::AI_DRV_CHANNEL channel_id = analysis::dvvp::driver::PROF_CHANNEL_AI_CORE;
    std::string file_path = "test";
    proDdrJob->Init(collectionJobCfg_);
    MOCKER_CPP(&ProfChannelManager::GetChannelPoller)
        .stubs()
        .will(returnValue(poller));
    proDdrJob->AddReader("jobId", dev_id, channel_id, file_path);
}

TEST_F(JOB_WRAPPER_PROF_DDR_JOB_OPEN_TEST, Uninit) {
    GlobalMockObject::verify();

    auto proDdrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDdrJob>();
    auto poller = std::make_shared<analysis::dvvp::transport::ChannelPoll>();
    MOCKER_CPP(&ProfChannelManager::GetChannelPoller)
        .stubs()
        .will(returnValue(poller));
    proDdrJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proDdrJob->Uninit());
}

class JOB_WRAPPER_PROF_HBM_JOB_OPEN_TEST : public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();\
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->comParams->params->hbmInterval =30;
        collectionJobCfg_->jobParams.events->push_back("write");
        collectionJobCfg_->jobParams.events->push_back("read");
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_HBM_JOB_OPEN_TEST, Init) {
    GlobalMockObject::verify();

    auto profHbmJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHbmJob>();
    collectionJobCfg_->jobParams.events = nullptr;
    profHbmJob->Init(collectionJobCfg_);
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    EXPECT_EQ(PROFILING_FAILED, profHbmJob->Init(nullptr));
    collectionJobCfg_->jobParams.events->push_back("write");
    collectionJobCfg_->jobParams.events->push_back("read");
    EXPECT_EQ(PROFILING_FAILED, profHbmJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hbmProfiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHbmJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_HBM_JOB_OPEN_TEST, Process) {
    GlobalMockObject::verify();

    auto proHbmJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHbmJob>();
    proHbmJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proHbmJob->Process());
    MOCKER(malloc)
        .stubs()
        .will(returnValue((void*)nullptr));
    EXPECT_EQ(PROFILING_FAILED, proHbmJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_HBM_JOB_OPEN_TEST, Uninit) {
    GlobalMockObject::verify();

    auto proHbmJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHbmJob>();
    EXPECT_EQ(PROFILING_FAILED, proHbmJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, proHbmJob->Uninit());
}

class JOB_WRAPPER_PROF_LLC_JOB_OPEN_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->devIdOnHost = 64;
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string>>(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_LLC_JOB_OPEN_TEST, LlcJobInit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));
    auto profLlcJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfLlcJob>();
    // fail to CHECK_JOB_EVENT_PARAM_RET
    collectionJobCfg_->jobParams.events = nullptr;
    EXPECT_EQ(PROFILING_FAILED, profLlcJob->Init(collectionJobCfg_));
    // msprof_llc_profiling is not on
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string>>(0);
    collectionJobCfg_->jobParams.events->push_back("read");
    EXPECT_EQ(PROFILING_FAILED, profLlcJob->Init(collectionJobCfg_));
    // pass
    collectionJobCfg_->comParams->params->msprof_llc_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profLlcJob->Init(collectionJobCfg_));
    // hostProfiling is open
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profLlcJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_LLC_JOB_OPEN_TEST, LlcJobIsGlobalJobLevel) {
    GlobalMockObject::verify();
    auto profLlcJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfLlcJob>();
    EXPECT_EQ(false, profLlcJob->IsGlobalJobLevel());
}

TEST_F(JOB_WRAPPER_PROF_LLC_JOB_OPEN_TEST, SetPeripheralConfig) {
    GlobalMockObject::verify();
    unsigned char tmp[100] = {0};

    MOCKER(analysis::dvvp::common::utils::Utils::ProfMalloc)
        .stubs()
        .will(returnValue((void*)tmp));

    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string>>(0);
    collectionJobCfg_->jobParams.events->push_back("read");
    collectionJobCfg_->jobParams.events->push_back("write");
    auto profLlcJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfLlcJob>();
    profLlcJob->Init(collectionJobCfg_);
    collectionJobCfg_->comParams->params->llc_interval = 50;
    analysis::dvvp::driver::DrvPeripheralProfileCfg peripheralCfg;
    profLlcJob->peripheralCfg_ = peripheralCfg;
    profLlcJob->collectionJobCfg_ = collectionJobCfg_;
    EXPECT_EQ(PROFILING_SUCCESS, profLlcJob->SetPeripheralConfig());
}

class JOB_WRAPPER_PROF_HCCS_JOB_OPEN_TEST : public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();\
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->comParams->params->hccsInterval =30;
        collectionJobCfg_->jobParams.events->push_back("write");
        collectionJobCfg_->jobParams.events->push_back("read");
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_HCCS_JOB_OPEN_TEST, Init) {
    GlobalMockObject::verify();

    auto profJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHccsJob>();
    collectionJobCfg_->jobParams.events = nullptr;
    profJob->Init(collectionJobCfg_);
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(nullptr));
    collectionJobCfg_->jobParams.events->push_back("write");
    collectionJobCfg_->jobParams.events->push_back("read");
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hccsProfiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_HCCS_JOB_OPEN_TEST, Process) {
    GlobalMockObject::verify();

    auto proJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHccsJob>();
    proJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Process());}

TEST_F(JOB_WRAPPER_PROF_HCCS_JOB_OPEN_TEST, Uninit) {
    GlobalMockObject::verify();

    auto proJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHccsJob>();
    EXPECT_EQ(PROFILING_FAILED, proJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Uninit());
}

class JOB_WRAPPER_PROF_PCIE_JOB_OPEN_TEST : public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();\
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->comParams->params->pcieInterval =30;
        collectionJobCfg_->jobParams.events->push_back("write");
        collectionJobCfg_->jobParams.events->push_back("read");
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_PCIE_JOB_OPEN_TEST, Init) {
    GlobalMockObject::verify();

    auto profJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfPcieJob>();
    collectionJobCfg_->jobParams.events = nullptr;
    profJob->Init(collectionJobCfg_);
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(nullptr));
    collectionJobCfg_->jobParams.events->push_back("write");
    collectionJobCfg_->jobParams.events->push_back("read");
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->pcieProfiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_PCIE_JOB_OPEN_TEST, Process) {
    GlobalMockObject::verify();

    auto proJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfPcieJob>();
    proJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_PCIE_JOB_OPEN_TEST, Uninit) {
    GlobalMockObject::verify();

    auto proJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfPcieJob>();
    EXPECT_EQ(PROFILING_FAILED, proJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Uninit());
}

class JOB_WRAPPER_PROF_NIC_JOB_OPEN_TEST : public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();\
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->comParams->params->nicInterval =30;
        collectionJobCfg_->jobParams.events->push_back("write");
        collectionJobCfg_->jobParams.events->push_back("read");
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_NIC_JOB_OPEN_TEST, Init) {
    GlobalMockObject::verify();

    auto profJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfNicJob>();
    collectionJobCfg_->jobParams.events = nullptr;
    profJob->Init(collectionJobCfg_);
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(nullptr));
    collectionJobCfg_->jobParams.events->push_back("write");
    collectionJobCfg_->jobParams.events->push_back("read");
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->nicProfiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->profiling_mode = "system-wide";
    collectionJobCfg_->comParams->params->nicInterval = 100;
    EXPECT_EQ(PROFILING_SUCCESS, profJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_NIC_JOB_OPEN_TEST, Process) {
    GlobalMockObject::verify();

    auto proJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfNicJob>();
    proJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_NIC_JOB_OPEN_TEST, Uninit) {
    GlobalMockObject::verify();

    auto proJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfNicJob>();
    EXPECT_EQ(PROFILING_FAILED, proJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Uninit());
}

class JOB_WRAPPER_PROF_DVPP_JOB_OPEN_TEST : public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();\
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->comParams->params->dvpp_sampling_interval =30;
        collectionJobCfg_->jobParams.events->push_back("write");
        collectionJobCfg_->jobParams.events->push_back("read");
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_DVPP_JOB_OPEN_TEST, Init) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));


    auto profJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDvppJob>();
    collectionJobCfg_->jobParams.events = nullptr;
    profJob->Init(collectionJobCfg_);
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(nullptr));
    collectionJobCfg_->jobParams.events->push_back("write");
    collectionJobCfg_->jobParams.events->push_back("read");
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->dvpp_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_DVPP_JOB_OPEN_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(false))
        .then(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));

    auto proJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDvppJob>();
    proJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Process());

    MOCKER(&analysis::dvvp::driver::DrvPeripheralStart)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, proJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_DVPP_JOB_OPEN_TEST, Uninit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    auto proJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDvppJob>();
    EXPECT_EQ(PROFILING_FAILED, proJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, proJob->Uninit());
}

class JOB_WRAPPER_PROF_ROCE_JOB_OPEN_TEST : public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();\
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->comParams->params->roceInterval =30;
        collectionJobCfg_->jobParams.events->push_back("write");
        collectionJobCfg_->jobParams.events->push_back("read");
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_ROCE_JOB_OPEN_TEST, Init) {
    GlobalMockObject::verify();

    auto profJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfRoceJob>();
    collectionJobCfg_->jobParams.events = nullptr;
    profJob->Init(collectionJobCfg_);
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(nullptr));
    collectionJobCfg_->jobParams.events->push_back("write");
    collectionJobCfg_->jobParams.events->push_back("read");
    EXPECT_EQ(PROFILING_FAILED, profJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->roceProfiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profJob->Init(collectionJobCfg_));
}

class JOB_WRAPPER_PROF_HSCB_JOB_OPEN_STEST: public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->devId = 0;
        comParams->devIdOnHost = 0;
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string>>(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};
