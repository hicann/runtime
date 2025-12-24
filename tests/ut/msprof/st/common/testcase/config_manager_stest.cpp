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
#include "singleton/singleton.h"
#include "platform_interface.h"
#include "platform.h"
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::error;
using namespace Dvvp::Collect::Platform;
static const std::string TYPE_CONFIG = "type";

class COMMON_CONFIG_MANAGER_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }

};

TEST_F(COMMON_CONFIG_MANAGER_STEST, GetPlatformType)
{
    GlobalMockObject::verify();
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    EXPECT_EQ(Analysis::Dvvp::Common::Config::PlatformType::MINI_TYPE, configManger->GetPlatformType());
    configManger->configMap_[TYPE_CONFIG] = "0";
    configManger->isInit_ = true;
    EXPECT_EQ(Analysis::Dvvp::Common::Config::PlatformType::MINI_TYPE, configManger->GetPlatformType());
    configManger->Uninit();
    configManger->configMap_[TYPE_CONFIG] = "0";
    MOCKER(halGetDeviceInfo)
            .stubs()
            .will(returnValue(DRV_ERROR_NOT_SUPPORT))
            .then(returnValue(DRV_ERROR_INVALID_VALUE))
            .then(returnValue(MSPROF_HELPER_HOST));
    configManger->Init();
    EXPECT_EQ(Analysis::Dvvp::Common::Config::PlatformType::MDC_TYPE, configManger->GetPlatformType());
    configManger->Uninit();
    configManger->configMap_[TYPE_CONFIG] = "0";

    configManger->Init();
    EXPECT_EQ(Analysis::Dvvp::Common::Config::PlatformType::MINI_TYPE, configManger->GetPlatformType());
    configManger->Uninit();
    configManger->configMap_[TYPE_CONFIG] = "0";

    configManger->Init();
    EXPECT_EQ(Analysis::Dvvp::Common::Config::PlatformType::MDC_TYPE, configManger->GetPlatformType());
    configManger->Uninit();
}

// 基类功能可行性
TEST_F(COMMON_CONFIG_MANAGER_STEST, PlatformGetAicoreEvents)
{
    GlobalMockObject::verify();
    std::shared_ptr<PlatformInterface> platformInterface(new PlatformInterface());
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetDeviceOscDefaultFreq());
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetAicDefaultFreq());
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetAivDefaultFreq());
    EXPECT_EQ(INTERFACE_L2CACHEEVENT, platformInterface->GetL2CacheEvents());
    EXPECT_EQ(INTERFACE_AIRTHMETICUTILIZATION, platformInterface->GetArithmeticUtilizationMetrics());
    EXPECT_EQ(INTERFACE_PIPEUTILIZATION, platformInterface->GetPipeUtilizationMetrics());
    EXPECT_EQ(INTERFACE_PIPELINEEXECUTEUTILIZATION, platformInterface->GetPipelineExecuteUtilizationMetrics());
    EXPECT_EQ(INTERFACE_RESOURCECONFLICTRATIO, platformInterface->GetResourceConflictRatioMetrics());
    EXPECT_EQ(INTERFACE_PIPELINEEXECUTEUTILIZATION, platformInterface->GetPipeStallCycleMetrics());
    EXPECT_EQ(INTERFACE_MEMORY, platformInterface->GetMemoryMetrics());
    EXPECT_EQ(INTERFACE_MEMORYL0, platformInterface->GetMemoryL0Metrics());
    EXPECT_EQ(INTERFACE_MEMORYUB, platformInterface->GetMemoryUBMetrics());
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetScalarMetrics());
    EXPECT_EQ(INTERFACE_L2CACHE, platformInterface->GetL2CacheMetrics());
    EXPECT_EQ(PlatformFeature::PLATFORM_FEATURE_INVALID, platformInterface->PmuMetricsToFeature("AbsMetrics"));
    EXPECT_EQ(EMPTY_FREQUENCY, platformInterface->GetMetricsValue(PlatformFeature::PLATFORM_COLLECTOR_TYPES_MAX));
}