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
#include "prof_inner_api.h"
#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "msprof_drv_api.h"

namespace {
std::vector<int32_t> g_startedChannels;

int32_t DrvInstrProfileStartStub(const uint32_t devId, const analysis::dvvp::driver::AI_DRV_CHANNEL channelId,
    void *userData, size_t dataSize)
{
    (void)devId;
    (void)userData;
    (void)dataSize;
    g_startedChannels.push_back(static_cast<int32_t>(channelId));
    return analysis::dvvp::common::error::PROFILING_SUCCESS;
}

// Records the config size received by DrvInstrProfileStart, used to verify the struct chosen for
// new/old driver versions.
size_t g_lastConfigSize = 0;
int32_t DrvInstrProfileStartSizeStub(const uint32_t devId, const analysis::dvvp::driver::AI_DRV_CHANNEL channelId,
    void *userData, size_t dataSize)
{
    (void)devId;
    (void)channelId;
    (void)userData;
    g_lastConfigSize = dataSize;
    return analysis::dvvp::common::error::PROFILING_SUCCESS;
}
}

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
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, Launch) {
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
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

TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, MdcV2InstrProfilingOnlyStartsWhitelistChannels)
{
    g_startedChannels.clear();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    std::vector<BiuPerfChannelInfo> platformChannels = {
        {0, 0, 0, 11},
        {2, 0, 2, 17},
        {3, 0, 3, 20},
        {5, 0, 5, 26},
    };
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetBiuPerfChannelInfos,
        std::vector<BiuPerfChannelInfo> (Analysis::Dvvp::Common::Platform::Platform::*)(
            const std::vector<uint32_t> &, uint32_t) const)
        .stubs()
        .will(returnValue(platformChannels));
    int64_t aiCoreNum = 8;
    MOCKER(analysis::dvvp::driver::DrvGetAiCoreNum)
        .stubs()
        .with(any(), outBound(aiCoreNum))
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    MOCKER(analysis::dvvp::driver::DrvInstrProfileStart)
        .stubs()
        .will(invoke(DrvInstrProfileStartStub));

    auto profBiuPerfJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfBiuPerfJob>();
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    collectionJobCfg_->comParams->params->pcSampling = "off";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Process());

    std::vector<int32_t> expectedChannels = {11, 17, 20, 26};
    EXPECT_EQ(expectedChannels, g_startedChannels);
}

// New driver version: Process should use BiuProfileConfigTV2 (with reportDataLoss) as the parameter.
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, ProcessUsesV2ConfigOnNewDriver)
{
    g_lastConfigSize = 0;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    int64_t aiCoreNum = 8;
    MOCKER(analysis::dvvp::driver::DrvGetAiCoreNum)
        .stubs()
        .with(any(), outBound(aiCoreNum))
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    // Force the new driver version branch.
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::DrvGetApiVersion)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(
            Analysis::Dvvp::Common::Platform::BIU_REPORT_DATA_LOSS_API_VERSION)));
    MOCKER(analysis::dvvp::driver::DrvInstrProfileStart)
        .stubs()
        .will(invoke(DrvInstrProfileStartSizeStub));

    auto profBiuPerfJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfBiuPerfJob>();
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    collectionJobCfg_->comParams->params->pcSampling = "off";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Process());
    EXPECT_EQ(sizeof(analysis::dvvp::driver::BiuProfileConfigTV2), g_lastConfigSize);
}

// Old driver version: Process should fall back to using BiuProfileConfigT as the parameter.
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, ProcessUsesV1ConfigOnOldDriver)
{
    g_lastConfigSize = 0;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    int64_t aiCoreNum = 8;
    MOCKER(analysis::dvvp::driver::DrvGetAiCoreNum)
        .stubs()
        .with(any(), outBound(aiCoreNum))
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    // Force the old driver version branch.
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::DrvGetApiVersion)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(
            Analysis::Dvvp::Common::Platform::BIU_REPORT_DATA_LOSS_API_VERSION) - 1));
    MOCKER(analysis::dvvp::driver::DrvInstrProfileStart)
        .stubs()
        .will(invoke(DrvInstrProfileStartSizeStub));

    auto profBiuPerfJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfBiuPerfJob>();
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    collectionJobCfg_->comParams->params->pcSampling = "off";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Process());
    EXPECT_EQ(sizeof(analysis::dvvp::driver::BiuProfileConfigT), g_lastConfigSize);
}

// DrvBiuPerfStop should log an error but still return success when it hits the data loss status code (0x916).
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, DrvBiuPerfStopReturnsSuccessOnDataLoss)
{
    MOCKER_CPP(&analysis::dvvp::driver::MsprofDrvApi::ProfStop)
        .stubs()
        .will(returnValue(0x916));
    EXPECT_EQ(PROFILING_SUCCESS,
        analysis::dvvp::driver::DrvBiuPerfStop(0, static_cast<analysis::dvvp::driver::AI_DRV_CHANNEL>(0)));

    // Other non-success codes should still return failure.
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::driver::MsprofDrvApi::ProfStop)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(PROFILING_FAILED,
        analysis::dvvp::driver::DrvBiuPerfStop(0, static_cast<analysis::dvvp::driver::AI_DRV_CHANNEL>(0)));
}
