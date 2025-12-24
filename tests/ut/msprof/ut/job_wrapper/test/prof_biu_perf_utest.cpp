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
#include "thread/thread.h"
#include "prof_biu_perf_job.h"
#include "file_transport.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::transport;

class JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST: public testing::Test {
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

TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, Launch) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetPlatformType)
        .stubs()
        .will(returnValue(14));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    auto profBiuPerfJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfBiuPerfJob>();
    do {
        EXPECT_NE(profBiuPerfJob, nullptr);
        if (profBiuPerfJob == nullptr) {
            break;
        }
        collectionJobCfg_->comParams->params->instrProfiling = "on";
        collectionJobCfg_->comParams->params->hostProfiling = true;
        EXPECT_EQ(PROFILING_FAILED, profBiuPerfJob->Init(collectionJobCfg_));
        collectionJobCfg_->comParams->params->hostProfiling = false;
        EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Init(collectionJobCfg_));
        collectionJobCfg_->comParams->params->pcSampling = "on";
        EXPECT_EQ(PROFILING_FAILED, profBiuPerfJob->Init(collectionJobCfg_));
        EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Process());
        EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Uninit());
    } while (0);
}