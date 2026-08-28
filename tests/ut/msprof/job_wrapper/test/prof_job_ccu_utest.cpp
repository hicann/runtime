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
#include "ai_drv_prof_api.h"
#include "errno/error_code.h"
#include "platform/platform.h"
#include "prof_ccu_job.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;

namespace {
class JOB_WRAPPER_CCU_BASE_JOB_TEST : public testing::Test {
protected:
    void SetUp() override
    {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();
        auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
        auto jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
    }

    void TearDown() override
    {
        GlobalMockObject::reset();
        collectionJobCfg_.reset();
    }

    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

class JOB_WRAPPER_CCU_INSTRUCTION_JOB_TEST : public JOB_WRAPPER_CCU_BASE_JOB_TEST {};

TEST_F(JOB_WRAPPER_CCU_INSTRUCTION_JOB_TEST, Init)
{
    auto ccuInstrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuInstrJob>();
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->ccuInstr = "on";
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, ccuInstrJob->Init(collectionJobCfg_));
    params->ccuInstr = "off";
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_CCU_INSTRUCTION_JOB_TEST, Process)
{
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    auto ccuInstrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuInstrJob>();
    ccuInstrJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Process());

    MOCKER(prof_drv_start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Process());
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, ccuInstrJob->Process());
}

TEST_F(JOB_WRAPPER_CCU_INSTRUCTION_JOB_TEST, Uninit)
{
    auto ccuInstrJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuInstrJob>();
    ccuInstrJob->Init(collectionJobCfg_);
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, ccuInstrJob->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, ccuInstrJob->Uninit());
}

class JOB_WRAPPER_CCU_STATISTIC_JOB_TEST : public JOB_WRAPPER_CCU_BASE_JOB_TEST {};

TEST_F(JOB_WRAPPER_CCU_STATISTIC_JOB_TEST, Init)
{
    auto ccuStatJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuStatJob>();
    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    MOCKER_CPP(&Platform::CheckIfSupport, bool(Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    params->ccuInstr = "on";
    collectionJobCfg_->comParams->params = params;
    collectionJobCfg_->comParams->params->hostProfiling = true;
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Init(collectionJobCfg_));
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, ccuStatJob->Init(collectionJobCfg_));
    params->ccuInstr = "off";
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Init(collectionJobCfg_));
}

TEST_F(JOB_WRAPPER_CCU_STATISTIC_JOB_TEST, Process)
{
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    auto ccuStatJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuStatJob>();
    ccuStatJob->Init(collectionJobCfg_);
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Process());

    MOCKER(prof_drv_start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Process());
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, ccuStatJob->Process());
}

TEST_F(JOB_WRAPPER_CCU_STATISTIC_JOB_TEST, Uninit)
{
    auto ccuStatJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfCcuStatJob>();
    ccuStatJob->Init(collectionJobCfg_);
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, ccuStatJob->Uninit());
    EXPECT_EQ(PROFILING_SUCCESS, ccuStatJob->Uninit());
}
} // namespace
