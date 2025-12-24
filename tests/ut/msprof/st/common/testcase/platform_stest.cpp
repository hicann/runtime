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
#include <stdio.h>
#include <errno.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <google/protobuf/util/json_util.h>
#include "config/config_manager.h"
#include "singleton/singleton.h"
#include "platform_interface.h"
#include "utils/utils.h"
#include "platform.h"
#include "config/config.h"
#include "ai_drv_dev_api.h"
#include "errno/error_code.h"
#include "cloud_v2_platform.h"

using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Dvvp::Collect::Platform;

class COMMON_PLATFORM_STEST: public testing::Test {
protected:
    virtual void SetUp() {
        GlobalMockObject::verify();
    }
    virtual void TearDown() {
    }
};

TEST_F(COMMON_PLATFORM_STEST, PlatformAnalyzerBase) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0))
        .then(returnValue(15));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::AscendHalAdaptor::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    Platform::instance()->Init();
    std::string pmu = "ArithmeticUtilization";
    // check analyzer not init
    EXPECT_EQ(0, Platform::instance()->GetMetricsPmuNum(pmu));
    EXPECT_EQ("", Platform::instance()->GetMetricsTopName(pmu));
    EXPECT_EQ(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    // init analyzer
    EXPECT_EQ(PROFILING_SUCCESS, Platform::instance()->InitOnlineAnalyzer());
    std::string res = "";
    res = Platform::instance()->GetMetricsTopName(pmu);
    int32_t count = 0;
    size_t pos = res.find("mac_fp16_ratio"); // 0x49
    while (pos != std::string::npos) {
        count++;
        pos = res.find("mac_fp16_ratio", pos + 1);
    }
    EXPECT_EQ(2, count);
    EXPECT_NE(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    EXPECT_EQ(nullptr, Platform::instance()->GetMetricsFunc(pmu, 7));
    // check milan pmu partical
    pmu = "PipeUtilization";
    res = "";
    count = 0;
    res = Platform::instance()->GetMetricsTopName(pmu);
    pos = res.find("mac_fp_ratio"); // 0x416
    while (pos != std::string::npos) {
        count++;
        pos = res.find("mac_fp_ratio", pos + 1);
    }
    EXPECT_EQ(1, count);
    EXPECT_NE(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    EXPECT_NE(nullptr, Platform::instance()->GetMetricsFunc(pmu, 8));
    Platform::instance()->Uninit();
    // check platform not init
    Platform::instance()->Init();
    EXPECT_EQ(PROFILING_FAILED, Platform::instance()->InitOnlineAnalyzer());
    EXPECT_EQ(0, Platform::instance()->GetMetricsPmuNum(pmu));
    EXPECT_EQ("", Platform::instance()->GetMetricsTopName(pmu));
    EXPECT_EQ(nullptr, Platform::instance()->GetMetricsFunc(pmu, 0));
    Platform::instance()->Uninit();
}