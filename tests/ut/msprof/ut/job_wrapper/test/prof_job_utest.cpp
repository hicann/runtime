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
#include "utils/utils.h"
#include "errno/error_code.h"
#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "config/config.h"
#include "prof_timer.h"
#include "uploader_mgr.h"
#include "platform/platform.h"
#include "transport/hdc/hdc_transport.h"
#include "prof_task.h"
#include "config_manager.h"
#include "prof_perf_job.h"
#include "prof_ts_job.h"
#include "prof_sys_info_job.h"
#include "prof_stars_job.h"
#include "prof_instr_perf_job.h"
#include "prof_l2cache_job.h"
#include "prof_soc_pmu_job.h"
#include "prof_hwts_log_job.h"
#include "prof_aicore_job.h"
#include "prof_aicpu_job.h"
#include "prof_adprof_job.h"
#include "prof_ccu_job.h"
#include "tsd_stub.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::driver;

class JOB_WRAPPER_PROF_TsCPu_JOB_TEST: public testing::Test {
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
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_TsCPu_JOB_TEST, Init) {
    GlobalMockObject::verify();

    auto profTscpuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfTscpuJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->jobParams.events = nullptr;
    EXPECT_EQ(PROFILING_FAILED, profTscpuJob->Init(collectionJobCfg_));
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profTscpuJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, profTscpuJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_TsCPu_JOB_TEST, Process) {
    GlobalMockObject::verify();

    auto proTsCpuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfTscpuJob>();
    proTsCpuJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_FAILED, proTsCpuJob->Process());
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->comParams->params->cpu_sampling_interval = 20;
    proTsCpuJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proTsCpuJob->Process());
    MOCKER(malloc)
        .stubs()
        .will(returnValue((void*)NULL));
    EXPECT_EQ(PROFILING_SUCCESS, proTsCpuJob->Process());
    MOCKER_CPP(&analysis::dvvp::driver::DrvL2CacheTaskStart)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, proTsCpuJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_TsCPu_JOB_TEST, Uninit) {
    GlobalMockObject::verify();

    auto proTsCpuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfTscpuJob>();
    proTsCpuJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proTsCpuJob->Uninit());
    collectionJobCfg_->jobParams.events->push_back("0x11");
    proTsCpuJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proTsCpuJob->Uninit());
}

class JOB_WRAPPER_PROF_TsTrack_JOB_TEST: public testing::Test {
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
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_TsTrack_JOB_TEST, Init) {
    GlobalMockObject::verify();

    auto profTsTrackJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfTsTrackJob>();
    EXPECT_EQ(PROFILING_FAILED, profTsTrackJob->Init(nullptr));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profTsTrackJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->ts_task_track = "off";
    collectionJobCfg_->comParams->params->ts_cpu_usage = "off";
    collectionJobCfg_->comParams->params->ai_core_status = "off";
    collectionJobCfg_->comParams->params->ts_timeline = "off";
    collectionJobCfg_->comParams->params->ts_keypoint = "off";
    EXPECT_EQ(PROFILING_FAILED, profTsTrackJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->ts_keypoint = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profTsTrackJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_TsTrack_JOB_TEST, Process) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));

    auto profTsTrackJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfTsTrackJob>();
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->ts_keypoint = "on";
    profTsTrackJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profTsTrackJob->Process());
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->ts_timeline = "on";
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->comParams->params->cpu_sampling_interval = 20;
    profTsTrackJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profTsTrackJob->Process());
    MOCKER(malloc)
        .stubs()
        .will(returnValue((void*)NULL));
    EXPECT_EQ(PROFILING_SUCCESS, profTsTrackJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_TsTrack_JOB_TEST, Uninit) {
    GlobalMockObject::verify();

    auto profTsTrackJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfTsTrackJob>();
    collectionJobCfg_->jobParams.events->push_back("0x11");
    profTsTrackJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profTsTrackJob->Uninit());
    profTsTrackJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profTsTrackJob->Uninit());
}

class JOB_WRAPPER_PROF_AICORE_JOB_TEST: public testing::Test {
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_AICORE_JOB_TEST, Init) {
    GlobalMockObject::verify();

    auto profAicoreJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAicoreJob>();

    collectionJobCfg_->jobParams.events->push_back("0x11");
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    params->ai_core_profiling_mode = "sample-based";
    params->ai_core_profiling = "on";
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profAicoreJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreJob->Init(collectionJobCfg_));

    auto aivSample = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAivJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> aivParams(
        new analysis::dvvp::message::ProfileParams);
    aivParams->aiv_profiling_mode = "sample-based";
    aivParams->aiv_profiling = "on";
    collectionJobCfg_->comParams->params = aivParams;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, aivSample->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, aivSample->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_AICORE_JOB_TEST, Process) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    auto profAicoreJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAicoreJob>();
    profAicoreJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_FAILED, profAicoreJob->Process());

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->jobParams.cores->push_back(1);
    collectionJobCfg_->comParams->params->aicore_sampling_interval = 20;
    profAicoreJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreJob->Process());
    MOCKER(malloc)
        .stubs()
        .will(returnValue((void*)NULL));
    EXPECT_EQ(PROFILING_FAILED, profAicoreJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_AICORE_JOB_TEST, Uninit) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    auto profAicoreJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAicoreJob>();
    profAicoreJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_FAILED, profAicoreJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreJob->Uninit());
    collectionJobCfg_->jobParams.events->push_back("0x11");
    profAicoreJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreJob->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreJob->Uninit());
}

class JOB_WRAPPER_PROF_AICORETASK_JOB_TEST: public testing::Test {
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_AICORETASK_JOB_TEST, Init) {
    GlobalMockObject::verify();

    auto profAicoreTaskBasedJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAicoreTaskBasedJob>();
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->jobParams.events = nullptr;
        params->ai_core_profiling_mode = "task-based";
    params->ai_core_profiling = "on";
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profAicoreTaskBasedJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_FAILED, profAicoreTaskBasedJob->Init(collectionJobCfg_));
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    collectionJobCfg_->jobParams.events->push_back("0x11");
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreTaskBasedJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profAicoreTaskBasedJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;

    auto aivTaskBased = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAivTaskBasedJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> aivParams(
        new analysis::dvvp::message::ProfileParams);
    aivParams->aiv_profiling_mode = "task-based";
    aivParams->aiv_profiling = "on";
    collectionJobCfg_->comParams->params = aivParams;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, aivTaskBased->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, aivTaskBased->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_AICORETASK_JOB_TEST, Process) {
    GlobalMockObject::verify();

    auto profAicoreTaskBasedJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAicoreTaskBasedJob>();
    profAicoreTaskBasedJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_FAILED, profAicoreTaskBasedJob->Process());
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    params->ai_core_profiling_mode = "task-based";
    params->ai_core_profiling = "on";
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->jobParams.cores->push_back(1);
    collectionJobCfg_->comParams->params->aicore_sampling_interval = 20;
    profAicoreTaskBasedJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreTaskBasedJob->Process());
    MOCKER(malloc)
        .stubs()
        .will(returnValue((void*)NULL));
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreTaskBasedJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_AICORETASK_JOB_TEST, Uninit) {
    GlobalMockObject::verify();

    auto profAicoreTaskBasedJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAicoreTaskBasedJob>();
    profAicoreTaskBasedJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreTaskBasedJob->Uninit());

    collectionJobCfg_->jobParams.events->push_back("0x11");
    profAicoreTaskBasedJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreTaskBasedJob->Uninit());

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false));
    EXPECT_EQ(PROFILING_SUCCESS, profAicoreTaskBasedJob->Uninit());
}

class JOB_WRAPPER_PROF_AICPU_JOB_TEST : public testing::Test {
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_AICPU_JOB_TEST, Init) {
    GlobalMockObject::verify();
    auto profAicpuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAicpuJob>();
    EXPECT_EQ(PROFILING_FAILED, profAicpuJob->Init(nullptr));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profAicpuJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->aicpuTrace = "off";
    EXPECT_EQ(PROFILING_FAILED, profAicpuJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->aicpuTrace = "on";

    MOCKER_CPP(&Platform::CheckIfSupportAdprof)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, profAicpuJob->Init(collectionJobCfg_));

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false));
    profAicpuJob->eventAttr_.isWaitDevPid = true;
    MOCKER(halQueryDevpid)
    .stubs()
    .will(returnValue(1));
    EXPECT_EQ(PROFILING_SUCCESS, profAicpuJob->Init(collectionJobCfg_));
    do {
        OsalSleep(80);
    } while (!(profAicpuJob->eventAttr_.isThreadStart));
    profAicpuJob.reset();

    auto profAicpuJCustomjob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAiCustomCpuJob>();
    profAicpuJCustomjob->eventAttr_.isWaitDevPid = true;
    EXPECT_EQ(PROFILING_SUCCESS, profAicpuJCustomjob->Init(collectionJobCfg_));
    do {
        OsalSleep(80);
    } while (!(profAicpuJCustomjob->eventAttr_.isThreadStart));
    profAicpuJCustomjob.reset();
}

TEST_F(JOB_WRAPPER_PROF_AICPU_JOB_TEST, Process) {
    GlobalMockObject::verify();
    auto profAicpuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAicpuJob>();
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->aicpuTrace = "on";
    MOCKER_CPP(&Platform::CheckIfSupportAdprof)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    profAicpuJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profAicpuJob->Process());
    profAicpuJob->eventAttr_.isChannelValid = true;
    EXPECT_EQ(PROFILING_SUCCESS, profAicpuJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profAicpuJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_AICPU_JOB_TEST, Uninit) {
    GlobalMockObject::verify();

    auto profAicpuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAicpuJob>();
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->aicpuTrace = "on";
    MOCKER_CPP(&Platform::CheckIfSupportAdprof)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfDrvEvent::SubscribeEventThreadInit)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    profAicpuJob->Init(collectionJobCfg_);

    MOCKER(OsalJoinTask)
        .stubs()
        .will(returnValue(OSAL_EN_OK))
        .then(returnValue(OSAL_EN_ERR));

    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::GetAllChannels)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    profAicpuJob->eventAttr_.isProcessRun = false;
    profAicpuJob->eventAttr_.handle = 123;
    profAicpuJob->eventAttr_.isAttachDevice = true;
    EXPECT_EQ(PROFILING_SUCCESS,profAicpuJob->Uninit());
    profAicpuJob->eventAttr_.isProcessRun = true;
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS,profAicpuJob->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS,profAicpuJob->Uninit());
}

drvError_t drvDeviceGetPhyIdByIndexStub(uint32_t devId, uint32_t *phyId)
{
    if (devId == static_cast<uint32_t>(4)) {
        *phyId = static_cast<uint32_t>(7);
    }
    return DRV_ERROR_NONE;
}

class JOB_WRAPPER_PROF_ADPROF_JOB_TEST : public testing::Test {
protected:
    virtual void SetUp() {
        GlobalMockObject::verify();
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
    void StubTsd() {
        MOCKER(OsalDlopen).stubs().will(returnValue((void *)0x12345678));
        MOCKER(OsalDlsym).stubs().will(invoke(mmDlsymTsd));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_ADPROF_JOB_TEST, Init) {
    MOCKER_CPP(&Platform::GetPlatformType).stubs().will(returnValue(5));
    auto profAdprofJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAdprofJob>();

    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->Init(nullptr));
    collectionJobCfg_->comParams->params->app = "test";
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->app = "";
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->cpu_profiling = "off";
    collectionJobCfg_->comParams->params->sys_profiling = "on";
    collectionJobCfg_->comParams->params->pid_profiling = "on";
    collectionJobCfg_->comParams->params->profiling_period = 10;
    collectionJobCfg_->comParams->devId = 4;

    MOCKER_CPP(&Platform::CheckIfSupportAdprof)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->Init(collectionJobCfg_));

    MOCKER(drvDeviceGetPhyIdByIndex)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT))
        .then(invoke(drvDeviceGetPhyIdByIndexStub));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->Init(collectionJobCfg_));

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfAdprofJob::InitAdprof)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->Init(collectionJobCfg_));
    EXPECT_EQ(4, profAdprofJob->phyId_);
    EXPECT_EQ(PROFILING_SUCCESS, profAdprofJob->Init(collectionJobCfg_));
    EXPECT_EQ(7, profAdprofJob->phyId_);
}

TEST_F(JOB_WRAPPER_PROF_ADPROF_JOB_TEST, InitAdprof) {
    MOCKER_CPP(&Platform::GetPlatformType).stubs().will(returnValue(5));
    auto profAdprofJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAdprofJob>();

    collectionJobCfg_->comParams->params->app = "";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->cpu_profiling = "off";
    collectionJobCfg_->comParams->params->sys_profiling = "on";
    collectionJobCfg_->comParams->params->pid_profiling = "on";
    collectionJobCfg_->comParams->params->profiling_period = 10;
    collectionJobCfg_->comParams->devId = 0;
    profAdprofJob->collectionJobCfg_ = collectionJobCfg_;

    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->InitAdprof());
    StubTsd();

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfDrvEvent::SubscribeEventThreadInit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->InitAdprof());
    EXPECT_EQ(PROFILING_SUCCESS, profAdprofJob->InitAdprof());

    ProcStatusParam pidInfo;
    pidInfo.curStat = SUB_PROCESS_STATUS_EXITED;
    MOCKER(TsdGetProcListStatus)
        .stubs()
        .with(any(), outBoundP(&pidInfo, sizeof(pidInfo)), any())
        .will(returnValue(1U))
        .then(returnValue(0U));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->InitAdprof());
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->InitAdprof());

    MOCKER(TsdProcessOpen)
        .stubs()
        .will(returnValue(1));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->InitAdprof());
    MOCKER(TsdCapabilityGet)
        .stubs()
        .will(returnValue(1));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->InitAdprof());
}

TEST_F(JOB_WRAPPER_PROF_ADPROF_JOB_TEST, LoadTsdApi) {
    auto profAdprofJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAdprofJob>();
    MOCKER(OsalDlopen)
        .stubs()
        .will(returnValue((void *)nullptr))
        .then(returnValue((void *)0x12345678));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->LoadTsdApi());
    MOCKER(OsalDlsym)
        .stubs()
        .will(returnValue((void *)nullptr));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->LoadTsdApi());
    GlobalMockObject::verify();
    MOCKER(OsalDlopen).stubs().will(returnValue((void *)0x12345678));
    MOCKER(OsalDlsym)
        .stubs()
        .will(returnValue((void *)0x12345678))
        .then(returnValue((void *)nullptr));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->LoadTsdApi());
    GlobalMockObject::verify();
    MOCKER(OsalDlopen).stubs().will(returnValue((void *)0x12345678));
    MOCKER(OsalDlsym)
        .stubs()
        .will(repeat((void *)0x12345678, 2))
        .then(returnValue((void *)nullptr));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->LoadTsdApi());
    GlobalMockObject::verify();
    MOCKER(OsalDlopen).stubs().will(returnValue((void *)0x12345678));
    MOCKER(OsalDlsym)
        .stubs()
        .will(repeat((void *)0x12345678, 3))
        .then(returnValue((void *)nullptr));
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->LoadTsdApi());
}

TEST_F(JOB_WRAPPER_PROF_ADPROF_JOB_TEST, Process) {
    MOCKER_CPP(&Platform::GetPlatformType).stubs().will(returnValue(5));
    auto profAdprofJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAdprofJob>();
    EXPECT_EQ(PROFILING_FAILED, profAdprofJob->Process());
    StubTsd();
    collectionJobCfg_->comParams->params->app = "";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->cpu_profiling = "on";
    collectionJobCfg_->comParams->params->sys_profiling = "on";
    collectionJobCfg_->comParams->params->pid_profiling = "on";
    collectionJobCfg_->comParams->params->profiling_period = 10;
    collectionJobCfg_->comParams->devId = 0;
    MOCKER_CPP(&Platform::CheckIfSupportAdprof)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfDrvEvent::SubscribeEventThreadInit)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, profAdprofJob->Init(collectionJobCfg_));
    profAdprofJob->eventAttr_.isChannelValid = false;
    EXPECT_EQ(PROFILING_SUCCESS, profAdprofJob->Process());
    profAdprofJob->eventAttr_.isChannelValid = true;
    EXPECT_EQ(PROFILING_SUCCESS, profAdprofJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profAdprofJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_ADPROF_JOB_TEST, Uninit) {
    MOCKER_CPP(&Platform::GetPlatformType).stubs().will(returnValue(5));
    StubTsd();
    auto profAdprofJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAdprofJob>();
    collectionJobCfg_->comParams->params->app = "";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->cpu_profiling = "off";
    collectionJobCfg_->comParams->params->sys_profiling = "on";
    collectionJobCfg_->comParams->params->pid_profiling = "on";
    collectionJobCfg_->comParams->params->profiling_period = 10;
    collectionJobCfg_->comParams->devId = 0;
    MOCKER_CPP(&Platform::CheckIfSupportAdprof)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfDrvEvent::SubscribeEventThreadInit)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER(OsalJoinTask)
        .stubs()
        .will(returnValue(OSAL_EN_OK))
        .then(returnValue(OSAL_EN_ERR));

    MOCKER(halEschedDettachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));

    EXPECT_EQ(PROFILING_SUCCESS, profAdprofJob->Init(collectionJobCfg_));
    profAdprofJob->eventAttr_.isProcessRun = false;
    profAdprofJob->eventAttr_.handle = 123;
    profAdprofJob->eventAttr_.isAttachDevice = true;
    EXPECT_EQ(PROFILING_SUCCESS, profAdprofJob->Uninit());
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfAdprofJob::CloseAdprof)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    profAdprofJob->Init(collectionJobCfg_);
    profAdprofJob->eventAttr_.isProcessRun = true;
    EXPECT_EQ(PROFILING_SUCCESS, profAdprofJob->Uninit());
}

class JOB_WRAPPER_PROF_EVENT_TEST : public testing::Test {
    virtual void SetUp() {
        GlobalMockObject::verify();
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(JOB_WRAPPER_PROF_EVENT_TEST, SubscribeEventThreadInit) {
    auto profDrvEvent = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDrvEvent>();
    struct TaskEventAttr eventAttr = {0, PROF_CHANNEL_ADPROF, ADPROF_COLLECTION_JOB, false, false, false, false, 0,
                                      false, false, nullptr};
    MOCKER(OsalCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(OSAL_EN_OK));
    EXPECT_EQ(PROFILING_FAILED, profDrvEvent->SubscribeEventThreadInit(&eventAttr));
    EXPECT_EQ(PROFILING_SUCCESS, profDrvEvent->SubscribeEventThreadInit(&eventAttr));
}

TEST_F(JOB_WRAPPER_PROF_EVENT_TEST, EventThreadHandle) {
    EXPECT_EQ(nullptr, ProfDrvEvent::EventThreadHandle(nullptr));

    const char *grpName = "prof_adprof_grp";
    struct TaskEventAttr eventAttr = {0, PROF_CHANNEL_AICPU, ADPROF_COLLECTION_JOB, false, false, false, false, 0,
                                      false, false, grpName};
    MOCKER(halQueryDevpid)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(DRV_ERROR_NONE));
    MOCKER(halEschedAttachDevice)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(nullptr, ProfDrvEvent::EventThreadHandle(&eventAttr));
    eventAttr.channelId = PROF_CHANNEL_ADPROF;

    MOCKER_CPP(&Platform::Platform::HalEschedQueryInfo)
        .stubs()
        .will(returnValue(1));
    uint32_t grpId = 32;
    MOCKER_CPP(&Platform::Platform::HalEschedCreateGrpEx)
        .stubs()
        .with(any(), any(), outBoundP(&grpId))
        .will(returnValue(1))
        .then(returnValue((int32_t)DRV_ERROR_NONE));
    EXPECT_EQ(nullptr, ProfDrvEvent::EventThreadHandle(&eventAttr));
    MOCKER(halEschedSubscribeEvent)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(nullptr, ProfDrvEvent::EventThreadHandle(&eventAttr));
    EXPECT_EQ(nullptr, ProfDrvEvent::EventThreadHandle(&eventAttr));
}

TEST_F(JOB_WRAPPER_PROF_EVENT_TEST, QueryGroupId) {
    MOCKER_CPP(&Platform::Platform::HalEschedQueryInfo)
        .stubs()
        .will(returnValue(1))
        .then(returnValue((int32_t)DRV_ERROR_NONE));
    uint32_t grpId = 0;
    const char *grpName = "prof_adprof_grp";
    EXPECT_EQ(PROFILING_FAILED, ProfDrvEvent::QueryGroupId(0, grpId, grpName));
    EXPECT_EQ(PROFILING_SUCCESS, ProfDrvEvent::QueryGroupId(0, grpId, grpName));
}

TEST_F(JOB_WRAPPER_PROF_EVENT_TEST, WaitEvent) {
    auto profDrvEvent = std::make_shared<Analysis::Dvvp::JobWrapper::ProfDrvEvent>();
    struct TaskEventAttr eventAttr = {0, PROF_CHANNEL_ADPROF, ADPROF_COLLECTION_JOB, false, false, false, false, 0,
                                      false, false, nullptr};
    event_info event;
    event.comm.event_id = EVENT_TEST;

    MOCKER(halEschedWaitEvent)
        .stubs()
        .with(any(), any(), any(), any(), outBoundP(&event))
        .will(returnValue(DRV_ERROR_NONE));
    ProfDrvEvent::WaitEvent(&eventAttr, 0);     // Receive unexpected event
    EXPECT_TRUE(!eventAttr.isChannelValid);
    GlobalMockObject::verify();

    event.comm.event_id = EVENT_USR_START;
    MOCKER(halEschedWaitEvent)
        .stubs()
        .with(any(), any(), any(), any(), outBoundP(&event))
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::CollectionRegisterMgr::CollectionJobRun)
        .stubs()
        .will(returnValue(0));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::GetAllChannels)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false)).then(returnValue(true));

    ProfDrvEvent::WaitEvent(&eventAttr, 0);
    EXPECT_TRUE(!eventAttr.isChannelValid);
    ProfDrvEvent::WaitEvent(&eventAttr, 0);
    EXPECT_TRUE(eventAttr.isChannelValid);

    GlobalMockObject::verify();
    MOCKER(halEschedWaitEvent)
        .stubs()
        .with(any(), any(), any(), any(), outBoundP(&event))
        .will(returnValue(DRV_ERROR_SCHED_INNER_ERR))
        .then(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::CollectionRegisterMgr::CollectionJobRun)
        .stubs()
        .will(returnValue(0));
    ProfDrvEvent::WaitEvent(&eventAttr, 0);
    EXPECT_TRUE(eventAttr.isChannelValid);

    GlobalMockObject::verify();
    MOCKER(halEschedWaitEvent)
        .stubs()
        .with(any(), any(), any(), any(), outBoundP(&event))
        .will(repeat(DRV_ERROR_SCHED_WAIT_TIMEOUT, 2))
        .then(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::CollectionRegisterMgr::CollectionJobRun)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::GetAllChannels)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    ProfDrvEvent::WaitEvent(&eventAttr, 0);
    EXPECT_TRUE(eventAttr.isChannelValid);
}

class JOB_WRAPPER_STARS_SOC_LOG_JOB_TEST: public testing::Test {
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
        collectionJobCfg_->jobParams.aivEvents = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->jobParams.aivCores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};
 
TEST_F(JOB_WRAPPER_STARS_SOC_LOG_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Platform::Platform::GetMaxMonitorNumber)
        .stubs()
        .will(returnValue(static_cast<uint16_t>(10)));
 
    auto profStarsSocLogJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfStarsSocLogJob>();
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->jobParams.events = nullptr;
    collectionJobCfg_->comParams->params = params;
 
    params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profStarsSocLogJob->Init(collectionJobCfg_));
    params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, profStarsSocLogJob->Init(collectionJobCfg_));
 
    params->profMode = "system";
    EXPECT_EQ(PROFILING_FAILED, profStarsSocLogJob->Init(collectionJobCfg_));
}

class JOB_WRAPPER_PROF_FFTS_JOB_TEST: public testing::Test {
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
        collectionJobCfg_->jobParams.aivEvents = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->jobParams.aivCores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_FFTS_JOB_TEST, Init) {
    GlobalMockObject::verify();

    auto profFftsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfFftsProfileJob>();
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->jobParams.events = nullptr;
    params->ai_core_profiling_mode = "task-based";
    params->ai_core_profiling = "on";
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profFftsJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_FAILED, profFftsJob->Init(collectionJobCfg_));
    params->taskBlock = "on";
    collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    collectionJobCfg_->jobParams.events->push_back("0x11");
    EXPECT_EQ(PROFILING_SUCCESS, profFftsJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profFftsJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_FFTS_JOB_TEST, Process) {
    GlobalMockObject::verify();

    auto profFftsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfFftsProfileJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    params->ai_core_profiling_mode = "task-based";
    params->ai_core_profiling = "on";
    params->aiv_profiling = "on";
    params->taskBlock = "on";
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->jobParams.cores->push_back(1);
    collectionJobCfg_->comParams->params->aicore_sampling_interval = 20;
    profFftsJob->Init(collectionJobCfg_);

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, profFftsJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_FFTS_JOB_TEST, Uninit) {
    GlobalMockObject::verify();

    auto profFftsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfFftsProfileJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    params->ai_core_profiling_mode = "sample-based";
    params->aiv_profiling_mode = "sample-based";
    params->ai_core_profiling = "on";
    params->aiv_profiling = "on";
    params->taskBlock = "on";
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->jobParams.cores->push_back(1);
    collectionJobCfg_->jobParams.aivEvents->push_back("0x11");
    collectionJobCfg_->jobParams.aivCores->push_back(1);
    collectionJobCfg_->comParams->params->aicore_sampling_interval = 20;
    profFftsJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profFftsJob->Uninit());

    profFftsJob->Init(collectionJobCfg_);
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, profFftsJob->Uninit());
}

class JOB_WRAPPER_STARS_SOC_PROFILE_JOB_TEST: public testing::Test {
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
        collectionJobCfg_->jobParams.aivEvents = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->jobParams.aivCores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};
 
TEST_F(JOB_WRAPPER_STARS_SOC_PROFILE_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Platform::Platform::GetMaxMonitorNumber)
        .stubs()
        .will(returnValue(static_cast<uint16_t>(10)));
 
    auto profStarsSocProfileJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfStarsSocProfileJob>();
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->jobParams.events = nullptr;
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profStarsSocProfileJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_FAILED, profStarsSocProfileJob->Init(collectionJobCfg_));
 
    params->interconnection_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profStarsSocProfileJob->Init(collectionJobCfg_));
    params->interconnection_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profStarsSocProfileJob->Init(collectionJobCfg_));
 
    params->hardware_mem = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profStarsSocProfileJob->Init(collectionJobCfg_));
    params->hardware_mem = "off";
    EXPECT_EQ(PROFILING_FAILED, profStarsSocProfileJob->Init(collectionJobCfg_));
 
    params->sysLp = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profStarsSocProfileJob->Init(collectionJobCfg_));
    params->sysLp = "off";
    EXPECT_EQ(PROFILING_FAILED, profStarsSocProfileJob->Init(collectionJobCfg_));
    // rc mode test
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    params->hardware_mem = "on";
    params->hardware_mem_sampling_interval = 10;
    int32_t profPeriod = 0;
    StarsSocProfileConfigT configP;
    profStarsSocProfileJob->SetConfigP(profPeriod, &configP);
    EXPECT_EQ(10, configP.onChip.period);
}

class JOB_WRAPPER_PROF_INSTR_JOB_TEST: public testing::Test {
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
        collectionJobCfg_->jobParams.aivEvents = std::make_shared<std::vector<std::string> >(0);
        collectionJobCfg_->jobParams.aivCores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_INSTR_JOB_TEST, Init) {
    GlobalMockObject::verify();

    auto profInstrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfInstrPerfJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->jobParams.events = nullptr;
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profInstrJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->instrProfiling = "off";
    collectionJobCfg_->comParams->params->instrProfilingFreq = 1000;
    EXPECT_EQ(PROFILING_FAILED, profInstrJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    // Support PLATFORM_SYS_DEVICE_INSTR_PROFILING
    EXPECT_EQ(PROFILING_FAILED, profInstrJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profInstrJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_INSTR_JOB_TEST, Process) {
    GlobalMockObject::verify();

    auto profInstrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfInstrPerfJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->jobParams.events = nullptr;
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    collectionJobCfg_->comParams->params->instrProfilingFreq = 1000;
    profInstrJob->Init(collectionJobCfg_);

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, profInstrJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_INSTR_JOB_TEST, Uninit) {
    GlobalMockObject::verify();

    auto profInstrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfInstrPerfJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->jobParams.events = nullptr;
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    collectionJobCfg_->comParams->params->instrProfilingFreq = 1000;
    profInstrJob->Init(collectionJobCfg_);
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, profInstrJob->Uninit());
}

class JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST: public testing::Test {
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

void fake_get_files_perf(const std::string &dir, bool is_recur, std::vector<std::string>& files)
{
    files.push_back("ctrlcpu.data.1");
    files.push_back("ctrlcpu.data.2");
    files.push_back("ctrlcpu.data.3");
    files.push_back("ctrlcpu.data.4");
}

TEST_F(JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST, InitFailed) {
    GlobalMockObject::verify();

    auto profCtrlCpuBasedJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCtrlcpuJob>();
    collectionJobCfg_->jobParams.events->push_back("0x11");
    EXPECT_EQ(PROFILING_FAILED, profCtrlCpuBasedJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST, Init) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));

    auto profCtrlCpuBasedJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCtrlcpuJob>();
    collectionJobCfg_->jobParams.events->push_back("0x11");
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profCtrlCpuBasedJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;

    EXPECT_EQ(PROFILING_FAILED, profCtrlCpuBasedJob->Init(nullptr));
}

TEST_F(JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));

    auto profCtrlCpuBasedJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCtrlcpuJob>();
    profCtrlCpuBasedJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_FAILED, profCtrlCpuBasedJob->Process());
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->jobParams.cores->push_back(1);
    collectionJobCfg_->jobParams.dataPath = "./ctrlCpu.data";
    collectionJobCfg_->comParams->params->aicore_sampling_interval = 20;
    profCtrlCpuBasedJob->Init(collectionJobCfg_);
    collectionJobCfg_->comParams->jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

    std::string filePath = "./ctrlCpu.data";
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfCtrlcpuJob::PrepareDataDir)
        .stubs()
        .with(outBound(filePath))
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER(analysis::dvvp::common::utils::Utils::GetFiles)
        .stubs()
        .will(invoke(fake_get_files_perf));

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    EXPECT_EQ(PROFILING_SUCCESS, profCtrlCpuBasedJob->Process());

    std::vector<std::string> paramsV;
    MOCKER(analysis::dvvp::common::utils::Utils::Split)
        .stubs()
        .will(returnValue(paramsV));
    EXPECT_EQ(PROFILING_FAILED, profCtrlCpuBasedJob->Process());
    remove("./ctrlCpu.data");
    rmdir(collectionJobCfg_->comParams->tmpResultDir.c_str());
}

TEST_F(JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));

    auto profCtrlCpuBasedJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCtrlcpuJob>();
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->jobParams.cores->push_back(1);
    profCtrlCpuBasedJob->Init(collectionJobCfg_);
    MOCKER(mmWaitPid).stubs().will(returnValue(EN_OK));
    EXPECT_EQ(PROFILING_FAILED,profCtrlCpuBasedJob->Uninit());
    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    profCtrlCpuBasedJob->Init(collectionJobCfg_);
    profCtrlCpuBasedJob->ctrlcpuProcess_ = 123456;
    EXPECT_EQ(PROFILING_FAILED,profCtrlCpuBasedJob->Uninit());
    bool is_exited = true;
    MOCKER(analysis::dvvp::common::utils::Utils::WaitProcess)
        .stubs()
        .with(any(), outBound(is_exited), any(), any())
        .will(returnValue(PROFILING_SUCCESS));
    profCtrlCpuBasedJob->Init(collectionJobCfg_);
    profCtrlCpuBasedJob->ctrlcpuProcess_ = 123456;
    EXPECT_EQ(PROFILING_SUCCESS,profCtrlCpuBasedJob->Uninit());
    rmdir(collectionJobCfg_->comParams->tmpResultDir.c_str());
}

TEST_F(JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST, GetCollectCtrlCpuEventCmd) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));

    auto profCtrlCpuBasedJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCtrlcpuJob>();
    collectionJobCfg_->jobParams.events->push_back("0x11");
    collectionJobCfg_->jobParams.cores->push_back(1);
    profCtrlCpuBasedJob->Init(collectionJobCfg_);

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->cpu_sampling_interval = 10;
    std::string filePath = "./GetCollectCtrlCpuEventCmd";
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfCtrlcpuJob::PrepareDataDir)
        .stubs()
        .with(outBound(filePath))
        .will(returnValue(PROFILING_SUCCESS));


    int dev_id = 0;
    std::vector<std::string> events;
    std::string prof_ctrl_cpu_cmd;
    EXPECT_EQ(PROFILING_FAILED, profCtrlCpuBasedJob->GetCollectCtrlCpuEventCmd(events, prof_ctrl_cpu_cmd));
    events.push_back("0x11");
    std::string fileName = "./GetCollectCtrlCpuEventCmd";
    std::ofstream ofs(fileName);
    ofs << "test" << std::endl;
    ofs.close();
    collectionJobCfg_->jobParams.dataPath = fileName;
    profCtrlCpuBasedJob->Init(collectionJobCfg_);

    EXPECT_EQ(PROFILING_SUCCESS, profCtrlCpuBasedJob->GetCollectCtrlCpuEventCmd(events, prof_ctrl_cpu_cmd));
    collectionJobCfg_->jobParams.dataPath = "./tmp_dir/test";
    profCtrlCpuBasedJob->Init(collectionJobCfg_);

    EXPECT_EQ(PROFILING_SUCCESS, profCtrlCpuBasedJob->GetCollectCtrlCpuEventCmd(events, prof_ctrl_cpu_cmd));
    remove(fileName.c_str());
    rmdir(collectionJobCfg_->comParams->tmpResultDir.c_str());
}

TEST_F(JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST, PrepareDataDir) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));

    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    auto profCtrlCpuBasedJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCtrlcpuJob>();
    profCtrlCpuBasedJob->collectionJobCfg_ = collectionJobCfg_;
    std::string dir;
    EXPECT_EQ(PROFILING_FAILED, profCtrlCpuBasedJob->PrepareDataDir(dir));
    EXPECT_EQ(PROFILING_FAILED, profCtrlCpuBasedJob->PrepareDataDir(dir));
}


TEST_F(JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST, PerfScriptTask) {
    GlobalMockObject::verify();

    MOCKER(analysis::dvvp::common::utils::Utils::GetFiles)
        .stubs()
        .will(invoke(fake_get_files_perf));

    MOCKER(remove)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&analysis::dvvp::common::thread::Thread::IsQuit)
        .stubs()
        .will(returnValue(true));

    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::PerfExtraTask::StoreData)
        .stubs();
    Analysis::Dvvp::JobWrapper::PerfExtraTask perfTask(10, "./ret", collectionJobCfg_->comParams->jobCtx, collectionJobCfg_->comParams->params);
    EXPECT_EQ(PROFILING_SUCCESS, perfTask.Init());
    perfTask.PerfScriptTask();
}

TEST_F(JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST, run) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::PerfExtraTask::PerfScriptTask)
        .stubs();

    MOCKER_CPP(&analysis::dvvp::common::thread::Thread::IsQuit)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    Analysis::Dvvp::JobWrapper::PerfExtraTask perfTask(10, "./", collectionJobCfg_->comParams->jobCtx, collectionJobCfg_->comParams->params);
    // BufInit failed
    EXPECT_EQ(PROFILING_FAILED, perfTask.Init());
    // Init succ
    EXPECT_EQ(PROFILING_SUCCESS, perfTask.Init());
    // Init failed
    EXPECT_EQ(PROFILING_FAILED, perfTask.Init());
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    perfTask.Run(errorContext);
    EXPECT_EQ(PROFILING_SUCCESS, perfTask.UnInit());
}

TEST_F(JOB_WRAPPER_PROF_CTRLCPU_JOB_TEST, StoreData) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::transport::Uploader::UploadData,
        int(analysis::dvvp::transport::Uploader::*)(const void *, int))
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    auto jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();
    Analysis::Dvvp::JobWrapper::PerfExtraTask perfTask(10, "./", jobCtx, collectionJobCfg_->comParams->params);
    EXPECT_EQ(PROFILING_SUCCESS, perfTask.Init());
    //file open failed
    std::string fileName = "./test/test";
    perfTask.StoreData(fileName);
    //suss
    fileName = "./test";
    std::ofstream ofs(fileName);
    ofs << "test" << std::endl;
    ofs.close();

    perfTask.StoreData(fileName);
    remove("./test");
}


class JOB_WRAPPER_PROF_SYSSTAT_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_SYSSTAT_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    auto profSysStatJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfSysStatJob>();
    profSysStatJob->Init(nullptr);
    profSysStatJob->Init(collectionJobCfg_);

    collectionJobCfg_->comParams->params->sys_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profSysStatJob->Init(collectionJobCfg_));
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
        .stubs()
        .will(returnValue(uploader));
    analysis::dvvp::transport::UploaderMgr::instance()->AddUploader("0", uploader);
    collectionJobCfg_->comParams->params->sys_profiling = "on";
    profSysStatJob->Init(collectionJobCfg_);
    EXPECT_TRUE(profSysStatJob->IsGlobalJobLevel() == true);
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profSysStatJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_SYSSTAT_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    collectionJobCfg_->comParams->params->cpu_sampling_interval = 200;
    auto profSysStatJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfSysStatJob>();
    profSysStatJob->Init(collectionJobCfg_);

    EXPECT_EQ(PROFILING_SUCCESS, profSysStatJob->Process());

    profSysStatJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profSysStatJob->Process());
    unsigned int devId = 0;
    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 100;
    std::string srcFileName = "srcFileName";
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams());
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext());
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);


    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_MEM, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    Analysis::Dvvp::JobWrapper::ProcStatFileHandler memHandler(attr, params, jobCtx, uploader);

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProcTimerHandler*)&memHandler, &Analysis::Dvvp::JobWrapper::ProcStatFileHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, profSysStatJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_SYSSTAT_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));

    auto profSysStatJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfSysStatJob>();
    EXPECT_EQ(PROFILING_SUCCESS,profSysStatJob->Uninit());
}

class JOB_WRAPPER_PROF_ALLPIDS_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_ALLPIDS_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    auto profAllPidsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAllPidsJob>();
    profAllPidsJob->Init(nullptr);
    profAllPidsJob->Init(collectionJobCfg_);
    collectionJobCfg_->comParams->params->pid_profiling = "off";
    collectionJobCfg_->comParams->params->sys_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profAllPidsJob->Init(collectionJobCfg_));
    EXPECT_TRUE(profAllPidsJob->IsGlobalJobLevel() == true);
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profAllPidsJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_ALLPIDS_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    auto profAllPidsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAllPidsJob>();
    profAllPidsJob->Init(collectionJobCfg_);

    EXPECT_EQ(PROFILING_SUCCESS, profAllPidsJob->Process());
    unsigned int devId = 0;
    unsigned int sampleIntervalMs = 100;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams());
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext());
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_ALL_PID, devId, 0,
        sampleIntervalMs});
    Analysis::Dvvp::JobWrapper::ProcAllPidsFileHandler allPidsHandler(attr, params, jobCtx, uploader);

    MOCKER_CPP_VIRTUAL(&allPidsHandler, &Analysis::Dvvp::JobWrapper::ProcAllPidsFileHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, profAllPidsJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_ALLPIDS_JOB_TEST, ProfTimerJobCommonInit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    collectionJobCfg_->comParams->params->pid_profiling = "on";
    auto profAllPidsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAllPidsJob>();
    profAllPidsJob->Init(collectionJobCfg_);

    unsigned int devId = 0;
    unsigned int sampleIntervalMs = 100;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams());
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext());
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_ALL_PID, devId, 0,
        sampleIntervalMs});
    Analysis::Dvvp::JobWrapper::ProcAllPidsFileHandler allPidsHandler(attr, params, jobCtx, uploader);

    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
        .stubs()
        .will(returnValue(uploader));
    EXPECT_EQ(PROFILING_SUCCESS, profAllPidsJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_ALLPIDS_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));

    auto profAllPidsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfAllPidsJob>();
    EXPECT_EQ(PROFILING_SUCCESS,profAllPidsJob->Uninit());
}

class JOB_WRAPPER_PROF_SYSMEM_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_SYSMEM_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    auto profSysMemJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfSysMemJob>();
    profSysMemJob->Init(nullptr);
    profSysMemJob->Init(collectionJobCfg_);
    collectionJobCfg_->comParams->params->sys_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profSysMemJob->Init(collectionJobCfg_));
    EXPECT_TRUE(profSysMemJob->IsGlobalJobLevel() == true);
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profSysMemJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_SYSMEM_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    auto profSysMemJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfSysMemJob>();
    profSysMemJob->Init(collectionJobCfg_);

    EXPECT_EQ(PROFILING_SUCCESS, profSysMemJob->Process());
    profSysMemJob->Init(collectionJobCfg_);

    EXPECT_EQ(PROFILING_SUCCESS, profSysMemJob->Process());
    unsigned int devId = 0;
    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 100;
    std::string srcFileName = "srcFileName";
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams());
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext());
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);


    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_MEM, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    Analysis::Dvvp::JobWrapper::ProcMemFileHandler memHandler(attr, params, jobCtx, uploader);

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProcTimerHandler*)&memHandler, &Analysis::Dvvp::JobWrapper::ProcMemFileHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, profSysMemJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_SYSMEM_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));

    auto profSysMemJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfSysMemJob>();
    EXPECT_EQ(PROFILING_SUCCESS,profSysMemJob->Uninit());
}

class JOB_WRAPPER_PROF_FMK_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_FMK_JOB_TEST, Init) {
    GlobalMockObject::verify();
    auto proFmkJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfFmkJob>();
    EXPECT_EQ(PROFILING_FAILED, proFmkJob->Init(nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, proFmkJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, proFmkJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_FMK_JOB_TEST, Process) {
    GlobalMockObject::verify();
    auto proFmkJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfFmkJob>();
    proFmkJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proFmkJob->Process());
    collectionJobCfg_->comParams->params->ts_fw_training = "on";
    proFmkJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, proFmkJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_FMK_JOB_TEST, Uninit) {
    GlobalMockObject::verify();

    auto proFmkJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfFmkJob>();
    proFmkJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS,proFmkJob->Uninit());
    collectionJobCfg_->comParams->params->ts_fw_training = "on";
    proFmkJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS,proFmkJob->Uninit());
}

class JOB_WRAPPER_PROF_HWTS_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_HWTS_JOB_TEST, Init) {
    GlobalMockObject::verify();
    auto profHwtsLogJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHwtsLogJob>();
    EXPECT_EQ(PROFILING_FAILED, profHwtsLogJob->Init(nullptr));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profHwtsLogJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->hwts_log = "off";
    EXPECT_EQ(PROFILING_FAILED, profHwtsLogJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hwts_log = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHwtsLogJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profHwtsLogJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_HWTS_JOB_TEST, Process) {
    GlobalMockObject::verify();
    auto profHwtsLogJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHwtsLogJob>();
    collectionJobCfg_->comParams->params->hostProfiling = false;
    collectionJobCfg_->comParams->params->hwts_log = "on";
    profHwtsLogJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profHwtsLogJob->Process());
    profHwtsLogJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profHwtsLogJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_HWTS_JOB_TEST, Uninit) {
    GlobalMockObject::verify();

    auto profHwtsLogJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHwtsLogJob>();
    profHwtsLogJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS,profHwtsLogJob->Uninit());
    profHwtsLogJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS,profHwtsLogJob->Uninit());
}

class JOB_WRAPPER_PROF_SOC_PMU_JOB_TEST: public testing::Test {
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
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_SOC_PMU_JOB_TEST, Base) {
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    // init
    auto profSocPmuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfSocPmuTaskJob>();
    EXPECT_EQ(PROFILING_FAILED, profSocPmuJob->Init(nullptr));
    collectionJobCfg_->comParams->params->l2CacheTaskProfiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profSocPmuJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->l2CacheTaskProfiling = "on";
    collectionJobCfg_->comParams->params->npuEvents = "";
    EXPECT_EQ(PROFILING_FAILED, profSocPmuJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->npuEvents = "HA:0x00,0x88,0x89,0x8A,0x74,0x75,0x97;SMMU:0x2,0x8a,0x8b,0x8c,0x8d";
    EXPECT_EQ(PROFILING_SUCCESS, profSocPmuJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profSocPmuJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;

    EXPECT_EQ(PROFILING_SUCCESS, profSocPmuJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profSocPmuJob->Process());

    collectionJobCfg_->comParams->params->npuEvents = "MATA:0x00,0x88,0x89,0x8A,0x74,0x75,0x97;NOC:0x1,0x2,0x3,0x3f";
    EXPECT_EQ(PROFILING_SUCCESS, profSocPmuJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profSocPmuJob->Process());

    collectionJobCfg_->comParams->params->npuEvents = "0x88,0x89,0x8A,0x74,0x75,0x97";
    EXPECT_EQ(PROFILING_SUCCESS, profSocPmuJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profSocPmuJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profSocPmuJob->Uninit());
}

class JOB_WRAPPER_PROF_L2_CACHE_JOB_TEST: public testing::Test {
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
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_L2_CACHE_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(false));
    auto profL2CacheJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfL2CacheTaskJob>();
    EXPECT_EQ(PROFILING_FAILED, profL2CacheJob->Init(nullptr));
    collectionJobCfg_->comParams->params->l2CacheTaskProfiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profL2CacheJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->l2CacheTaskProfiling = "on";
    collectionJobCfg_->comParams->params->l2CacheTaskProfilingEvents = "0x5b, 0x59, 0xfa";
    EXPECT_EQ(PROFILING_SUCCESS, profL2CacheJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->l2CacheTaskProfilingEvents = "0x5b, 0x59, 0x5c";
    EXPECT_EQ(PROFILING_SUCCESS, profL2CacheJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, profL2CacheJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_L2_CACHE_JOB_TEST, Process) {
    GlobalMockObject::verify();
    auto profL2CacheJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfL2CacheTaskJob>();
    profL2CacheJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_FAILED, profL2CacheJob->Process());
    collectionJobCfg_->jobParams.events->push_back("0x5b");
    profL2CacheJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profL2CacheJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_L2_CACHE_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    auto profL2CacheJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfL2CacheTaskJob>();
    profL2CacheJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profL2CacheJob->Uninit());
    collectionJobCfg_->jobParams.events->push_back("0x5b");
    profL2CacheJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_SUCCESS, profL2CacheJob->Uninit());
}

TEST_F(JOB_WRAPPER_PROF_L2_CACHE_JOB_TEST, TaskInit) {
    GlobalMockObject::verify();

    auto param_ = std::shared_ptr<analysis::dvvp::message::ProfileParams>(
            new analysis::dvvp::message::ProfileParams());
    std::vector<std::string> _devices;
     _devices.push_back("0");
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));

    MOCKER_CPP(&analysis::dvvp::transport::Uploader::Flush)
        .stubs();

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(pthread_create)
        .stubs()
        .then(returnValue(-1));

    EXPECT_EQ(PROFILING_FAILED, task->Init());
    task->isInited_ = true;
}

class JOB_WRAPPER_PROF_PERF_EXTRA_JOB_TEST: public testing::Test {
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
        collectionJobCfg_->jobParams.cores = std::make_shared<std::vector<int> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

void fake_get_files_perf_extra(const std::string &dir, bool is_recur, std::vector<std::string>& files)
{
    files.push_back("ai_ctrl_cpu.data.1.task");
    files.push_back("ai_ctrl_cpu.data.2.task");
    files.push_back("ai_ctrl_cpu.data.3.task");
    files.push_back("ai_ctrl_cpu.data.4.task");
}

std::vector<std::string> g_argv;
int32_t ExecCmdStub(const ExecCmdParams &execCmdParams, const std::vector<std::string> &argv,
    const std::vector<std::string> &envp, int &exitCodeP, OsalProcess &childProcess)
{
    g_argv = argv;
    return PROFILING_SUCCESS;
}

TEST_F(JOB_WRAPPER_PROF_PERF_EXTRA_JOB_TEST, ResolvePerfRecordData) {
    GlobalMockObject::verify();

    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(invoke(ExecCmdStub));
    std::string fileName = "JOB_WRAPPER_PROF_PERF_EXTRA_JOB_TEST.ResolvePerfRecordData";
    Analysis::Dvvp::JobWrapper::PerfExtraTask perfExtraTask(10, "./ret", collectionJobCfg_->comParams->jobCtx, collectionJobCfg_->comParams->params);
    perfExtraTask.ResolvePerfRecordData(fileName);
    EXPECT_EQ(g_argv.size(), 3);
    if (g_argv.size() == 3) {
        EXPECT_EQ(g_argv[0], "/var/prof_collect.sh");
        EXPECT_EQ(g_argv[1], "--script");
        EXPECT_EQ(g_argv[2], "JOB_WRAPPER_PROF_PERF_EXTRA_JOB_TEST.ResolvePerfRecordData");
    }
}

class JOB_WRAPPER_CCU_INSTRUCTION_JOB_TEST: public testing::Test {
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
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_CCU_INSTRUCTION_JOB_TEST, Init) {
    GlobalMockObject::verify();
    auto ccuInstrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuInstrJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    params->ccuInstr = "on";
    collectionJobCfg_->comParams->params = params;
    // Ccu instruction not enabled in host profiling
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, ccuInstrJob->Init(collectionJobCfg_));
    // Ccu instruction not enabled with ccuInstr switch off
    params->ccuInstr = "off";
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_CCU_INSTRUCTION_JOB_TEST, Process) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    auto ccuInstrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuInstrJob>();
    ccuInstrJob->Init(collectionJobCfg_);
    // Ccu instruction channel is invalid
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Process());

    MOCKER(prof_drv_start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    // ProfCcuInstrJob Process failed
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Process());
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, ccuInstrJob->Process());
}

TEST_F(JOB_WRAPPER_CCU_INSTRUCTION_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    auto ccuInstrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuInstrJob>();
    ccuInstrJob->Init(collectionJobCfg_);
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Uninit());

    EXPECT_EQ(PROFILING_SUCCESS, ccuInstrJob->Uninit());
}

class JOB_WRAPPER_CCU_STATISTIC_JOB_TEST: public testing::Test {
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
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_CCU_STATISTIC_JOB_TEST, Init) {
    GlobalMockObject::verify();
    auto ccuStatJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuStatJob>();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    params->ccuInstr = "on";
    collectionJobCfg_->comParams->params = params;
    // Ccu statistic not enabled in host profiling
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Init(collectionJobCfg_));
    // The platform not support ccu statistic feature
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Init(collectionJobCfg_));

    EXPECT_EQ(PROFILING_SUCCESS, ccuStatJob->Init(collectionJobCfg_));
    // Ccu statistic not enabled with ccuInstr switch off
    params->ccuInstr = "off";
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_CCU_STATISTIC_JOB_TEST, Process) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    auto ccuStatJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuStatJob>();
    ccuStatJob->Init(collectionJobCfg_);
    // Ccu statistic channel is invalid
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Process());

    MOCKER(prof_drv_start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    // ProfCcuStatJob Process failed
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Process());
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, ccuStatJob->Process());
}

TEST_F(JOB_WRAPPER_CCU_STATISTIC_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    auto ccuStatJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuStatJob>();
    ccuStatJob->Init(collectionJobCfg_);
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Uninit());

    EXPECT_EQ(PROFILING_SUCCESS, ccuStatJob->Uninit());
}