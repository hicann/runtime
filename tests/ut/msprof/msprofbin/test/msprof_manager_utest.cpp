/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include <iostream>
#include "errno/error_code.h"
#include "msprof_manager.h"
#include "message/codec.h"
#include "config/config.h"
#include "config_manager.h"
#include "param_validation.h"
#include "running_mode.h"
#include "input_parser.h"
#include "platform/platform.h"
#include "info_json.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Msprof;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::host;
using namespace analysis::dvvp::common::utils;
class MSPROF_MANAGER_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};


TEST_F(MSPROF_MANAGER_UTEST, Init) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);

    auto msprofManager = MsprofManager::instance();
    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(nullptr));

    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(params));
    MOCKER_CPP(&Analysis::Dvvp::Msprof::MsprofManager::GenerateRunningMode)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(params));

    MOCKER_CPP(&Analysis::Dvvp::Msprof::MsprofManager::ParamsCheck)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(params));
    EXPECT_EQ(PROFILING_SUCCESS, MsprofManager::instance()->Init(params));
}

TEST_F(MSPROF_MANAGER_UTEST, NotifyStop) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<Collector::Dvvp::Msprofbin::AppMode> rMode(
    new Collector::Dvvp::Msprofbin::AppMode("app", params));
    auto msprofManager = MsprofManager::instance();

    msprofManager->rMode_ = nullptr;
    msprofManager->NotifyStop();
    EXPECT_TRUE(msprofManager->rMode_ == nullptr);
    msprofManager->rMode_ = rMode;
    msprofManager->NotifyStop();
    EXPECT_TRUE(msprofManager->rMode_->isQuit_);
}

TEST_F(MSPROF_MANAGER_UTEST, MsProcessCmd) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<Collector::Dvvp::Msprofbin::AppMode> rMode(
    new Collector::Dvvp::Msprofbin::AppMode("app", params));
    auto msprofManager = MsprofManager::instance();
    msprofManager->UnInit();
    EXPECT_EQ(PROFILING_FAILED, msprofManager->MsProcessCmd());
    msprofManager->params_ = params;
    msprofManager->rMode_ = rMode;
    MOCKER_CPP_VIRTUAL(rMode.get(), &Collector::Dvvp::Msprofbin::AppMode::RunModeTasks)
        .stubs()
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->MsProcessCmd());
}

TEST_F(MSPROF_MANAGER_UTEST, GetTask) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<Collector::Dvvp::Msprofbin::AppMode> rMode(
    new Collector::Dvvp::Msprofbin::AppMode("app", params));
    auto msprofManager = MsprofManager::instance();
    msprofManager->UnInit();
    EXPECT_EQ(nullptr, msprofManager->GetTask("1"));
    msprofManager->rMode_ = rMode;
    std::shared_ptr<Analysis::Dvvp::Msprof::MsprofTask> info(new Analysis::Dvvp::Msprof::ProfSocTask(1, params));
    MOCKER_CPP(&Collector::Dvvp::Msprofbin::RunningMode::GetRunningTask)
        .stubs()
        .will(returnValue(info));
    EXPECT_EQ(info, msprofManager->GetTask("1"));
}

TEST_F(MSPROF_MANAGER_UTEST, GenerateRunningMode) {
    auto msprofManager = MsprofManager::instance();
    EXPECT_EQ(PROFILING_FAILED, msprofManager->GenerateRunningMode());
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    params->app = "main";
    msprofManager->params_ = params;
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->GenerateRunningMode());
    params->app = "";
    params->devices = "0";
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->GenerateRunningMode());
    params->devices = "";
    params->host_sys = "on";
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->GenerateRunningMode());
    params->host_sys = "";
    params->parseSwitch = "on";
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->GenerateRunningMode());
    params->parseSwitch = "";
    params->querySwitch = "on";
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->GenerateRunningMode());
    params->querySwitch = "";
    params->exportSwitch = "on";
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->GenerateRunningMode());
    params->exportSwitch = "";
    params->analyzeSwitch = "on";
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->GenerateRunningMode());
    params->analyzeSwitch = "";
    EXPECT_EQ(PROFILING_FAILED, msprofManager->GenerateRunningMode());

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    params->devices = "0";
    EXPECT_EQ(PROFILING_FAILED, msprofManager->GenerateRunningMode());
    params->devices = "";
    params->host_sys = "on";
    EXPECT_EQ(PROFILING_FAILED, msprofManager->GenerateRunningMode());
}

TEST_F(MSPROF_MANAGER_UTEST, GenerateRunningMod_helper) {
    auto msprofManager = MsprofManager::instance();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsHelperHostSide)
        .stubs()
        .will(returnValue(true));
    params->devices = "0";
    EXPECT_EQ(PROFILING_FAILED, msprofManager->GenerateRunningMode());
    params->host_sys = "on";
    EXPECT_EQ(PROFILING_FAILED, msprofManager->GenerateRunningMode());
}

TEST_F(MSPROF_MANAGER_UTEST, ParamsCheck) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<Collector::Dvvp::Msprofbin::AppMode> rMode(
    new Collector::Dvvp::Msprofbin::AppMode("app", params));
    auto msprofManager = MsprofManager::instance();
    msprofManager->UnInit();
    EXPECT_EQ(PROFILING_FAILED, msprofManager->ParamsCheck());
    msprofManager->params_ = params;
    EXPECT_EQ(PROFILING_FAILED, msprofManager->ParamsCheck());
    msprofManager->rMode_ = rMode;
    MOCKER_CPP_VIRTUAL(rMode.get(), &Collector::Dvvp::Msprofbin::AppMode::ModeParamsCheck)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, msprofManager->ParamsCheck());
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->ParamsCheck());
}

TEST_F(MSPROF_MANAGER_UTEST, GetRankId) {
    GlobalMockObject::verify();
    std::string start_time = "1539226807454372";
    std::string end_time = "1539226807454380";
    InfoJson infoJson(start_time, end_time, 1);
    const std::string rankId = "100";
    MOCKER_CPP(&Utils::IsAllDigit)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(rankId));
    EXPECT_EQ(-1, infoJson.GetRankId());
    EXPECT_EQ(100, infoJson.GetRankId());
}

drvError_t g_error = (drvError_t)0;

extern "C" drvError_t halGetDeviceInfoByBuff(uint32_t devId, int32_t moduleType, int32_t infoType,
    void *value, int32_t *len)
{
    if (moduleType = MODULE_TYPE_QOS) {
        QosProfileInfo *info = (QosProfileInfo*)value;
        if (info->mode == 0) {
            info->streamNum = 10;
            info->mpamId[0] = 12;
            info->mpamId[1] = 13;
            info->mpamId[2] = 14;
            info->mpamId[3] = 15;
            info->mpamId[4] = 16;
            info->mpamId[5] = 17;
            info->mpamId[6] = 18;
            info->mpamId[7] = 19;
            info->mpamId[8] = 20;
            info->mpamId[9] = 21;
        } else if (info->mode == 1) {
            strcpy(info->streamName, "st_mpamid_i");
        } else if (info->mode == 2) {
            info->streamNum = 2;
            info->mpamId[0] = 12;
            info->mpamId[1] = 13;
        }
    }
    return g_error;
}

TEST_F(MSPROF_MANAGER_UTEST, PlatformDavidGetQosProfileInfo) {
    GlobalMockObject::verify();
    // david
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_CLOUD_V3));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    MOCKER(OsalDlsym)
        .stubs()
        .will(returnValue((void*)halGetDeviceInfoByBuff));
    Analysis::Dvvp::Common::Platform::Platform::instance()->ascendHalAdaptor_.LoadApi();
    std::string info;
    std::vector<uint8_t> events;
    Platform::instance()->GetQosProfileInfo(0, info, events);
    EXPECT_EQ(8, events.size());
    std::string info2 = "aaa,bbb";
    Platform::instance()->GetQosProfileInfo(0, info2, events);
    EXPECT_EQ(2, events.size());
    Platform::instance()->Uninit();
}

TEST_F(MSPROF_MANAGER_UTEST, PlatformMilanGetQosProfileInfo) {
    GlobalMockObject::verify();
    // milan
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_V4_1_0));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    MOCKER(OsalDlsym)
        .stubs()
        .will(returnValue((void*)halGetDeviceInfoByBuff));
    Analysis::Dvvp::Common::Platform::Platform::instance()->ascendHalAdaptor_.LoadApi();
    std::string info;
    std::vector<uint8_t> events;
    Platform::instance()->GetQosProfileInfo(0, info, events);
    EXPECT_EQ(8, events.size());
    Platform::instance()->Uninit();
}