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
#include <mutex>
#include "prof_host_job.h"
#include "config/config.h"
#include "logger/msprof_dlog.h"
#include "platform/platform.h"
#include "uploader_mgr.h"
#include "utils/utils.h"
#include "thread/thread.h"
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::MsprofErrMgr;

class JOB_WRAPPER_PROF_HOST_CPU_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_HOST_CPU_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostCpuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostCpuJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostCpuJob->Init(nullptr));

    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostCpuJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostCpuJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->host_cpu_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profHostCpuJob->Init(collectionJobCfg_));

    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(nullptr);
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
        .stubs()
        .with(any(), outBound(uploader));
    analysis::dvvp::transport::UploaderMgr::instance()->AddUploader("0", uploader);
    collectionJobCfg_->comParams->params->job_id = "0";
    collectionJobCfg_->comParams->params->host_cpu_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHostCpuJob->Init(collectionJobCfg_));
    EXPECT_TRUE(profHostCpuJob->IsGlobalJobLevel() == true);
    collectionJobCfg_->comParams->params->host_cpu_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profHostCpuJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_HOST_CPU_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    collectionJobCfg_->comParams->params->host_cpu_profiling = "on";
    auto profHostCpuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostCpuJob>();
    profHostCpuJob->Init(collectionJobCfg_);

    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 20;
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams());
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext());
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(nullptr);

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_HOST_PROC_CPU, 0, bufSize,
        sampleIntervalMs});
    attr->retFileName = retFileName;
    Analysis::Dvvp::JobWrapper::ProcHostCpuHandler hostCpuHandler(attr, params, jobCtx, uploader);

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProcTimerHandler*)&hostCpuHandler, &Analysis::Dvvp::JobWrapper::ProcHostCpuHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, profHostCpuJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profHostCpuJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_HOST_CPU_JOB_TEST, DISABLED_Uninit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));

    auto profHostCpuJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostCpuJob>();
    EXPECT_EQ(PROFILING_SUCCESS, profHostCpuJob->Uninit());
}

class JOB_WRAPPER_PROF_HOST_MEM_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_HOST_MEM_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostMemJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostMemJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostMemJob->Init(nullptr));

    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostMemJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostMemJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->host_mem_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profHostMemJob->Init(collectionJobCfg_));

    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(nullptr);
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
        .stubs()
        .with(any(), outBound(uploader));
    analysis::dvvp::transport::UploaderMgr::instance()->AddUploader("0", uploader);
    collectionJobCfg_->comParams->params->job_id = "0";
    collectionJobCfg_->comParams->params->host_mem_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHostMemJob->Init(collectionJobCfg_));
    EXPECT_TRUE(profHostMemJob->IsGlobalJobLevel() == true);
}

TEST_F(JOB_WRAPPER_PROF_HOST_MEM_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    collectionJobCfg_->comParams->params->host_mem_profiling = "on";
    auto profHostMemJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostMemJob>();
    profHostMemJob->Init(collectionJobCfg_);

    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 20;
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams());
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext());
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(nullptr);

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_HOST_PROC_MEM, 0, bufSize,
        sampleIntervalMs});
    attr->retFileName = retFileName;
    Analysis::Dvvp::JobWrapper::ProcHostMemHandler hostMemHandler(attr, params, jobCtx, uploader);

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProcTimerHandler*)&hostMemHandler, &Analysis::Dvvp::JobWrapper::ProcHostMemHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, profHostMemJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profHostMemJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_HOST_MEM_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));

    auto profHostMemJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostMemJob>();
    EXPECT_EQ(PROFILING_SUCCESS, profHostMemJob->Uninit());
}

class JOB_WRAPPER_PROF_HOST_ALL_PID_JOB_TEST: public testing::Test {
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
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string>>(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_HOST_ALL_PID_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostAllPidJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostAllPidJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostAllPidJob->Init(nullptr));

    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostAllPidJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostAllPidJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->hostAllPidCpuProfiling = "off";
    collectionJobCfg_->comParams->params->hostAllPidMemProfiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profHostAllPidJob->Init(collectionJobCfg_));

    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(nullptr);
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
        .stubs()
        .with(any(), outBound(uploader));
    analysis::dvvp::transport::UploaderMgr::instance()->AddUploader("0", uploader);
    collectionJobCfg_->comParams->params->job_id = "0";
    collectionJobCfg_->comParams->params->hostAllPidMemProfiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHostAllPidJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostAllPidCpuProfiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHostAllPidJob->Init(collectionJobCfg_));
    EXPECT_TRUE(profHostAllPidJob->IsGlobalJobLevel() == true);
}

TEST_F(JOB_WRAPPER_PROF_HOST_ALL_PID_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    collectionJobCfg_->comParams->params->hostAllPidMemProfiling = "on";
    auto profHostAllPidJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostAllPidJob>();
    profHostAllPidJob->Init(collectionJobCfg_);

    unsigned int devId = 0;
    unsigned int sampleIntervalMs = 20;
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(new analysis::dvvp::message::JobContext());
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(nullptr);

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_HOST_ALL_PID_MEM, devId, 0,
        sampleIntervalMs});
    Analysis::Dvvp::JobWrapper::ProcAllPidsFileHandler allPidsHandler(attr, params, jobCtx, uploader);

    MOCKER_CPP_VIRTUAL(&allPidsHandler, &Analysis::Dvvp::JobWrapper::ProcAllPidsFileHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, profHostAllPidJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profHostAllPidJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_HOST_ALL_PID_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));

    auto profHostAllPidJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostAllPidJob>();
    EXPECT_EQ(PROFILING_SUCCESS, profHostAllPidJob->Uninit());
}

class JOB_WRAPPER_PROF_HOST_NETWORK_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_HOST_NETWORK_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostNetworkJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostNetworkJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostNetworkJob->Init(nullptr));

    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostNetworkJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostNetworkJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->host_network_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profHostNetworkJob->Init(collectionJobCfg_));

    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(nullptr);
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader)
        .stubs()
        .with(any(), outBound(uploader));
    analysis::dvvp::transport::UploaderMgr::instance()->AddUploader("0", uploader);
    collectionJobCfg_->comParams->params->job_id = "0";
    collectionJobCfg_->comParams->params->host_network_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHostNetworkJob->Init(collectionJobCfg_));
    EXPECT_TRUE(profHostNetworkJob->IsGlobalJobLevel() == true);
    collectionJobCfg_->comParams->params->host_network_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profHostNetworkJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_HOST_NETWORK_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));
    collectionJobCfg_->comParams->params->hostProfiling = true;
    collectionJobCfg_->comParams->params->host_network_profiling = "on";
    auto profHostNetworkJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostNetworkJob>();
    profHostNetworkJob->Init(collectionJobCfg_);

    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 20;
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams());
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext());
    auto uploader = std::make_shared<analysis::dvvp::transport::Uploader>(nullptr);

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_HOST_SYS_NETWORK, 0, bufSize,
        sampleIntervalMs});
    attr->retFileName = retFileName;
    Analysis::Dvvp::JobWrapper::ProcHostNetworkHandler hostNetworkHandler(attr, params, jobCtx, uploader);

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProcTimerHandler*)&hostNetworkHandler, &Analysis::Dvvp::JobWrapper::ProcHostNetworkHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, profHostNetworkJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profHostNetworkJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_HOST_NETWORK_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));

    auto profHostNetworkJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostNetworkJob>();
    EXPECT_EQ(PROFILING_SUCCESS, profHostNetworkJob->Uninit());
}

class JOB_WRAPPER_PROF_HOST_SYSCALLS_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_HOST_SYSCALLS_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostSysCallsJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Init(nullptr));

    collectionJobCfg_->comParams->devIdOnHost = DEFAULT_HOST_ID + 1;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostSysCallsJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostSysCallsJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->host_osrt_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->host_osrt_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHostSysCallsJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_HOST_SYSCALLS_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    Analysis::Dvvp::JobWrapper::ProfHostService hostServiceThread;

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    collectionJobCfg_->comParams->params->host_osrt_profiling = "on";
    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostSysCallsJob>();
    profHostSysCallsJob->Init(collectionJobCfg_);

    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Process());

    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profHostSysCallsJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_HOST_SYSCALLS_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    Analysis::Dvvp::JobWrapper::ProfHostService hostServiceThread;

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Stop)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Start)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));

    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostSysCallsJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Uninit());
    collectionJobCfg_->comParams->params->hostProfiling = true;
    profHostSysCallsJob->Init(collectionJobCfg_);
    profHostSysCallsJob->Process();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, profHostSysCallsJob->Uninit());
}

TEST_F(JOB_WRAPPER_PROF_HOST_SYSCALLS_JOB_TEST, UninitFailed) {
    GlobalMockObject::verify();
    Analysis::Dvvp::JobWrapper::ProfHostService hostServiceThread;

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Stop)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostSysCallsJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Uninit());
}

class JOB_WRAPPER_PROF_HOST_PTHREAD_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_HOST_PTHREAD_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostPthreadJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Init(nullptr));

    collectionJobCfg_->comParams->devIdOnHost = DEFAULT_HOST_ID + 1;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostSysCallsJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostSysCallsJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->host_osrt_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->host_osrt_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHostSysCallsJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_HOST_PTHREAD_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    Analysis::Dvvp::JobWrapper::ProfHostService hostServiceThread;

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    collectionJobCfg_->comParams->params->host_osrt_profiling = "on";
    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostPthreadJob>();
    profHostSysCallsJob->Init(collectionJobCfg_);

    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Process());

    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profHostSysCallsJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_HOST_PTHREAD_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    Analysis::Dvvp::JobWrapper::ProfHostService hostServiceThread;

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Stop)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Start)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));

    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostPthreadJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Uninit());
    collectionJobCfg_->comParams->params->hostProfiling = true;
    profHostSysCallsJob->Init(collectionJobCfg_);
    profHostSysCallsJob->Process();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, profHostSysCallsJob->Uninit());
}

TEST_F(JOB_WRAPPER_PROF_HOST_PTHREAD_JOB_TEST, UninitFailed) {
    GlobalMockObject::verify();
    Analysis::Dvvp::JobWrapper::ProfHostService hostServiceThread;

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Stop)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostPthreadJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Uninit());
}

class JOB_WRAPPER_PROF_HOST_DISK_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_HOST_DISK_JOB_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostDiskJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Init(nullptr));

    collectionJobCfg_->comParams->devIdOnHost = DEFAULT_HOST_ID + 1;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostSysCallsJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_NOTSUPPORT, profHostSysCallsJob->Init(collectionJobCfg_));

    collectionJobCfg_->comParams->params->host_disk_profiling = "off";
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->host_disk_profiling = "on";
    EXPECT_EQ(PROFILING_SUCCESS, profHostSysCallsJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_PROF_HOST_DISK_JOB_TEST, Process) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    Analysis::Dvvp::JobWrapper::ProfHostService hostServiceThread;

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    collectionJobCfg_->comParams->params->hostProfiling = true;
    collectionJobCfg_->comParams->params->host_disk_profiling = "on";
    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostDiskJob>();
    profHostSysCallsJob->Init(collectionJobCfg_);

    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Process());

    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profHostSysCallsJob->Process());
}

TEST_F(JOB_WRAPPER_PROF_HOST_DISK_JOB_TEST, Uninit) {
    GlobalMockObject::verify();
    Analysis::Dvvp::JobWrapper::ProfHostService hostServiceThread;

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Stop)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Start)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));

    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostDiskJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Uninit());
    collectionJobCfg_->comParams->params->hostProfiling = true;
    profHostSysCallsJob->Init(collectionJobCfg_);
    profHostSysCallsJob->Process();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, profHostSysCallsJob->Uninit());
}

TEST_F(JOB_WRAPPER_PROF_HOST_DISK_JOB_TEST, UninitFailed) {
    GlobalMockObject::verify();
    Analysis::Dvvp::JobWrapper::ProfHostService hostServiceThread;

    MOCKER_CPP_VIRTUAL(
            (Analysis::Dvvp::JobWrapper::ProfHostService*)&hostServiceThread, &Analysis::Dvvp::JobWrapper::ProfHostService::Stop)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    auto profHostSysCallsJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostDiskJob>();
    EXPECT_EQ(PROFILING_FAILED, profHostSysCallsJob->Uninit());
}

class JOB_WRAPPER_PROF_HOST_SERVER_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, Init) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    EXPECT_EQ(PROFILING_FAILED, profHostService->Init(nullptr, PROF_HOST_SYS_CALL));
    EXPECT_EQ(PROFILING_FAILED, profHostService->Init(collectionJobCfg_, PROF_HOST_MAX_TAG));
    EXPECT_EQ(PROFILING_SUCCESS, profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_CALL));
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, GetCollectIOTopCmd) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    std::string test = "test";
    EXPECT_EQ(PROFILING_FAILED, profHostService->GetCollectIOTopCmd(-1, test));

    EXPECT_EQ(PROFILING_SUCCESS, profHostService->GetCollectIOTopCmd(1, test));
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, GetCollectPthreadsCmd) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    std::string test = "test";
    EXPECT_EQ(PROFILING_FAILED, profHostService->GetCollectPthreadsCmd(-1, test));

    EXPECT_EQ(PROFILING_SUCCESS, profHostService->GetCollectPthreadsCmd(1, test));
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, GetCollectSysCallsCmd) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    std::string test = "test";
    EXPECT_EQ(PROFILING_FAILED, profHostService->GetCollectSysCallsCmd(-1, test));

    EXPECT_EQ(PROFILING_SUCCESS, profHostService->GetCollectSysCallsCmd(1, test));
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, Handler) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Uninit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Process)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    EXPECT_EQ(PROFILING_FAILED, profHostService->Handler());
    EXPECT_EQ(PROFILING_SUCCESS, profHostService->Handler());
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, Run) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Uninit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Process)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(3*1024*1024))
        .then(returnValue(10));

    std::shared_ptr<Analysis::Dvvp::JobWrapper::ProfHostService> profHostService
        (new Analysis::Dvvp::JobWrapper::ProfHostService());
    EXPECT_NE(nullptr, profHostService);
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    profHostService->Run(errorContext);
    profHostService->Run(errorContext);
    profHostService->Run(errorContext);
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, Stop) {
    GlobalMockObject::verify();
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    EXPECT_EQ(PROFILING_FAILED, profHostService->Stop());
    profHostService->isStarted_ = true;
    EXPECT_EQ(PROFILING_SUCCESS, profHostService->Stop());
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, Start) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Uninit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::Process)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(3*1024*1024))
        .then(returnValue(10));

    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    EXPECT_EQ(PROFILING_FAILED, profHostService->Start());
    profHostService->isStarted_ = true;
    EXPECT_EQ(PROFILING_SUCCESS, profHostService->Start());
    sleep(1);
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, ProcessFailed) {
    GlobalMockObject::verify();

    std::vector<std::string> paramsV;
    MOCKER(analysis::dvvp::common::utils::Utils::Split)
        .stubs()
        .will(returnValue(paramsV));

    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    collectionJobCfg_->comParams->params->host_sys_pid = -1;
    profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_CALL);
    EXPECT_EQ(PROFILING_FAILED, profHostService->Process());

    profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_PTHREAD);
    EXPECT_EQ(PROFILING_FAILED, profHostService->Process());

    profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_DISK);
    EXPECT_EQ(PROFILING_FAILED, profHostService->Process());
    collectionJobCfg_->comParams->params->host_sys_pid = 1;
    EXPECT_EQ(PROFILING_FAILED, profHostService->Process());
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, Process) {
    GlobalMockObject::verify();

    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::WaitCollectToolStart)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    collectionJobCfg_->comParams->params->host_sys_pid = 1;
    profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_PTHREAD);

    EXPECT_EQ(PROFILING_FAILED, profHostService->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profHostService->Process());
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, Uninit) {
    GlobalMockObject::verify();
    uint32_t exitcode = 0;

    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(analysis::dvvp::common::utils::Utils::WaitProcess)
        .stubs()
        .with(any(), any(), outBound(125), any())
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::WaitCollectToolEnd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    collectionJobCfg_->comParams->params->host_sys_pid = 1;
    profHostService->hostProcess_ = 1;
    profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_DISK);

    EXPECT_EQ(PROFILING_FAILED, profHostService->Uninit());
    EXPECT_EQ(PROFILING_FAILED, profHostService->Uninit());
    profHostService->profHostOutDir_ = "/JOB_WRAPPER_PROF_HOST_SERVER_TEST";
    EXPECT_EQ(PROFILING_SUCCESS, profHostService->Uninit());
    analysis::dvvp::common::utils::Utils::CreateDir("/tmp/JOB_WRAPPER_PROF_HOST_SERVER_TEST/");
    profHostService->profHostOutDir_ = "/tmp/JOB_WRAPPER_PROF_HOST_SERVER_TEST";
    EXPECT_EQ(PROFILING_SUCCESS, profHostService->Uninit());
    analysis::dvvp::common::utils::Utils::RemoveDir("/tmp/JOB_WRAPPER_PROF_HOST_SERVER_TEST/");
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, CollectToolIsRun) {
    GlobalMockObject::verify();

    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(&analysis::dvvp::common::utils::Utils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    int64_t length = 10;
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(length));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    collectionJobCfg_->comParams->params->host_sys_pid = 1;
    profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_PTHREAD);

    EXPECT_EQ(PROFILING_FAILED, profHostService->CollectToolIsRun());
    EXPECT_EQ(PROFILING_FAILED, profHostService->CollectToolIsRun());
    EXPECT_EQ(PROFILING_SUCCESS, profHostService->CollectToolIsRun());
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, CollectToolIsRunFail) {
    GlobalMockObject::verify();

    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(analysis::dvvp::common::utils::Utils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(false));

    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    collectionJobCfg_->comParams->params->host_sys_pid = 1;
    profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_PTHREAD);

    EXPECT_EQ(PROFILING_FAILED, profHostService->CollectToolIsRun());
    EXPECT_EQ(PROFILING_FAILED, profHostService->CollectToolIsRun());
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, WaitCollectToolEnd) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::CollectToolIsRun)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    collectionJobCfg_->comParams->params->host_sys_pid = 1;
    profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_PTHREAD);

    EXPECT_EQ(PROFILING_SUCCESS, profHostService->WaitCollectToolEnd());
    EXPECT_EQ(PROFILING_FAILED, profHostService->WaitCollectToolEnd());
}

TEST_F(JOB_WRAPPER_PROF_HOST_SERVER_TEST, WaitCollectToolStart) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProfHostService::CollectToolIsRun)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    auto profHostService = std::make_shared<Analysis::Dvvp::JobWrapper::ProfHostService>();
    collectionJobCfg_->comParams->params->host_sys_pid = 1;
    profHostService->Init(collectionJobCfg_, PROF_HOST_SYS_PTHREAD);

    EXPECT_EQ(PROFILING_SUCCESS, profHostService->WaitCollectToolStart());
    EXPECT_EQ(PROFILING_FAILED, profHostService->WaitCollectToolStart());
}