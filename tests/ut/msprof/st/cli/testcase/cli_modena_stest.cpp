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
#include <string>
#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "device_simulator_manager.h"
#include "errno/error_code.h"
#include "msprof_start.h"
#include "../stub/cli_stub.h"
#include "data_manager.h"
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char MODENA_RM_RF[] = "rm -rf ./cliModenastest_workspace";
static const char MODENA_MKDIR[] = "mkdir ./cliModenastest_workspace";
static const char MODENA_CREATE_CLI[] = "printf '#!/bin/sh\\nexit 0\\n' > ./cli && chmod +x ./cli";
static const char MODENA_RM_CLI[] = "rm -rf ./cli";
static const char MODENA_OUTPUT_DIR[] = "--output=./cliModenastest_workspace/output";
static const char MODENA_CUSTOM_EIGHT_EVENTS[] = "--aic-metrics=Custom:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8";
static const char MODENA_CUSTOM_NINE_EVENTS[] = "--aic-metrics=Custom:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9";

class CliModenaStest : public testing::Test {
protected:
    void SetUp() override
    {
        DlStub();
        const ::testing::TestInfo *curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("david", curTest->name());
        optind = 1;
        system(MODENA_MKDIR);
        system(MODENA_CREATE_CLI);
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_5162A));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }

    void TearDown() override
    {
        GlobalMockObject::verify();
        DevprofDrvAicpu::instance()->isRegister_ = false;
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_5162A));
        system(MODENA_RM_RF);
        system(MODENA_RM_CLI);
        DataMgr().UnInit();
        MsprofMgr().UnInit();
    }

    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(CliModenaStest, CliTaskTime)
{
    const char *argv[] = {MODENA_OUTPUT_DIR, "--task-time=on"};
    std::vector<std::string> dataList = {"ffts_profile.data", "stars_soc.data", "ts_track.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliModenaStest, CliBasicAicMetrics)
{
    const std::vector<std::string> metrics = {
        "PipeUtilization", "Memory", "MemoryUB", "ArithmeticUtilization", "ResourceConflictRatio"};
    for (const auto &metric : metrics) {
        std::string option = "--aic-metrics=" + metric;
        const char *argv[] = {MODENA_OUTPUT_DIR, option.c_str()};
        EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
        MsprofMgr().UnInit();
        optind = 1;
    }
}

TEST_F(CliModenaStest, CliCustomAicMetrics)
{
    const char *customOneEventArgv[] = {MODENA_OUTPUT_DIR, "--aic-metrics=Custom:0x0"};
    EXPECT_EQ(PROFILING_SUCCESS,
              MsprofMgr().MsprofStartByAppMode(sizeof(customOneEventArgv) / sizeof(char *), customOneEventArgv));

    MsprofMgr().UnInit();
    optind = 1;
    const char *customEightEventsArgv[] = {MODENA_OUTPUT_DIR, MODENA_CUSTOM_EIGHT_EVENTS};
    EXPECT_EQ(PROFILING_SUCCESS,
              MsprofMgr().MsprofStartByAppMode(sizeof(customEightEventsArgv) / sizeof(char *), customEightEventsArgv));
}

TEST_F(CliModenaStest, CliUnsupportedAicMetrics)
{
    const char *customNineEventsArgv[] = {MODENA_OUTPUT_DIR, MODENA_CUSTOM_NINE_EVENTS};
    EXPECT_EQ(PROFILING_FAILED,
              MsprofMgr().MsprofStartByAppMode(sizeof(customNineEventsArgv) / sizeof(char *), customNineEventsArgv));

    MsprofMgr().UnInit();
    optind = 1;
    const char *l2CacheArgv[] = {MODENA_OUTPUT_DIR, "--aic-metrics=L2Cache"};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(l2CacheArgv) / sizeof(char *), l2CacheArgv));
}
