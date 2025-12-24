/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <memory>
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "config/config_manager.h"
#include "config/config.h"
#include "utils/utils.h"
#include "ai_drv_dev_api.h"
#include "ascend_hal.h"
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::error;
static const std::string TYPE_CONFIG = "type";

class COMMON_CONFIG_MANAGER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }

};

TEST_F(COMMON_CONFIG_MANAGER_TEST, GetPlatformType)
{
    GlobalMockObject::verify();
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    EXPECT_EQ(PlatformType::MINI_TYPE, configManger->GetPlatformType());
    configManger->configMap_[TYPE_CONFIG] = "0";
    configManger->isInit_ = true;
    EXPECT_EQ(PlatformType::MINI_TYPE, configManger->GetPlatformType());
    configManger->Uninit();
    configManger->configMap_[TYPE_CONFIG] = "0";
    MOCKER(halGetDeviceInfo)
            .stubs()
            .will(returnValue(DRV_ERROR_NOT_SUPPORT))
            .then(returnValue(DRV_ERROR_INVALID_VALUE))
            .then(returnValue(MSPROF_HELPER_HOST));
    configManger->Init();
    EXPECT_EQ(PlatformType::MDC_TYPE, configManger->GetPlatformType());
    configManger->Uninit();
    configManger->configMap_[TYPE_CONFIG] = "0";

    configManger->Init();
    EXPECT_EQ(PlatformType::MINI_TYPE, configManger->GetPlatformType());
    configManger->Uninit();
    configManger->configMap_[TYPE_CONFIG] = "0";

    configManger->Init();
    EXPECT_EQ(PlatformType::MDC_TYPE, configManger->GetPlatformType());
    configManger->Uninit();
}

TEST_F(COMMON_CONFIG_MANAGER_TEST, GetPlatformTypeTiny)
{
    GlobalMockObject::verify();
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    int64_t versionInfo = static_cast<uint64_t>(PlatformType::CHIP_TINY_V1) << 8;
    MOCKER(halGetDeviceInfo)
            .stubs()
            .with(any(), any(), any(), outBoundP(&versionInfo, sizeof(versionInfo)))
            .will(returnValue(DRV_ERROR_NONE));
    configManger->Init();
    EXPECT_EQ(PlatformType::CHIP_TINY_V1, configManger->GetPlatformType());
    configManger->Uninit();
}

TEST_F(COMMON_CONFIG_MANAGER_TEST, IsDriverSupportLlc)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
            .stubs()
            .will(returnValue(PlatformType::CLOUD_TYPE))
            .then(returnValue(PlatformType::MINI_TYPE));
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    EXPECT_EQ(true, configManger->IsDriverSupportLlc());
    EXPECT_EQ(false, configManger->IsDriverSupportLlc());
}

TEST_F(COMMON_CONFIG_MANAGER_TEST, GetVersionSpecificMetrics)
{
    GlobalMockObject::verify();
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    std::string aiCoreMetrics = "PipeUtilization";
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
            .stubs()
            .will(returnValue(PlatformType::CHIP_V4_1_0));
    configManger->GetVersionSpecificMetrics(aiCoreMetrics);
    EXPECT_EQ("PipeUtilizationExct", aiCoreMetrics);
}

static int DrvGetDevIdsStub(int num, std::vector<int> &devIds) {
    for (auto i = 0; i < num; i++) {
        devIds.push_back(i);
    }
    return PROFILING_SUCCESS;
}

TEST_F(COMMON_CONFIG_MANAGER_TEST, GetChipIdTest)
{
    GlobalMockObject::verify();
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    configManger->isInit_ = false;
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    MOCKER(drvGetDevNum)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(PROFILING_FAILED, configManger->Init());

    GlobalMockObject::verify();
    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(8));
    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(invoke(DrvGetDevIdsStub));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));
    MOCKER(analysis::dvvp::driver::DrvGetDeviceStatus)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, configManger->Init());
    EXPECT_EQ(PROFILING_SUCCESS, configManger->Init());
    configManger->isInit_ = false;
}