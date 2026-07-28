/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <fstream>
#include <nlohmann/json.hpp>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "device_simulator_manager.h"
#include "errno/error_code.h"
#include "msprof_start.h"
#include "data_manager.h"
#include "aicpu_report_hdc.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char MODENA_ACLJSON_RM_RF[] = "rm -rf ./acljsonModenastest_workspace";
static const char MODENA_ACLJSON_MKDIR[] = "mkdir ./acljsonModenastest_workspace";
static const char MODENA_ACLJSON_OUTPUT_DIR[] = "./acljsonModenastest_workspace/output";

class AclJsonModenaStest : public testing::Test {
protected:
    void SetUp() override
    {
        DlStub();
        DataMgr().Init("", "acljson");
        optind = 1;
        system(MODENA_ACLJSON_MKDIR);
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_5162A));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }

    void TearDown() override
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_5162A));
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        system(MODENA_ACLJSON_RM_RF);
        GlobalMockObject::reset();
    }

    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(AclJsonModenaStest, AclJsonTaskTime)
{
    nlohmann::json data;
    data["output"] = MODENA_ACLJSON_OUTPUT_DIR;
    data["task_time"] = "on";
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonModenaStest, AclJsonBasicAicMetrics)
{
    const std::vector<std::string> metrics = {
        "PipeUtilization", "Memory", "MemoryUB", "ArithmeticUtilization", "ResourceConflictRatio"};
    for (const auto &metric : metrics) {
        nlohmann::json data;
        data["output"] = MODENA_ACLJSON_OUTPUT_DIR;
        data["aic_metrics"] = metric;
        EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
        MsprofMgr().UnInit();
    }
}

TEST_F(AclJsonModenaStest, AclJsonCustomAicMetrics)
{
    nlohmann::json oneEventData;
    oneEventData["output"] = MODENA_ACLJSON_OUTPUT_DIR;
    oneEventData["aic_metrics"] = "Custom:0x0";
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, oneEventData));

    MsprofMgr().UnInit();
    nlohmann::json eightEventsData;
    eightEventsData["output"] = MODENA_ACLJSON_OUTPUT_DIR;
    eightEventsData["aic_metrics"] = "Custom:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8";
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, eightEventsData));
}

TEST_F(AclJsonModenaStest, AclJsonUnsupportedAicMetrics)
{
    nlohmann::json nineEventsData;
    nineEventsData["output"] = MODENA_ACLJSON_OUTPUT_DIR;
    nineEventsData["aic_metrics"] = "Custom:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9";
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, nineEventsData));

    nlohmann::json l2CacheData;
    l2CacheData["output"] = MODENA_ACLJSON_OUTPUT_DIR;
    l2CacheData["aic_metrics"] = "L2Cache";
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, l2CacheData));
}
