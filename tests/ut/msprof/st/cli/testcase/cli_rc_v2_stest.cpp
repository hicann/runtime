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

namespace {
const char RC_V2_WORKSPACE[] = "./cliRcV2stest_workspace";
const char RC_V2_OUTPUT_ARG[] = "--output=./cliRcV2stest_workspace/output";
const char RC_V2_LLC_READ_ARG[] = "--llc-profiling=read";
const char RC_V2_SYS_DEVICE_ARG[] = "--sys-devices=0";
constexpr uint32_t RC_V2_DEVICE_NUM = 2;
} // namespace

class CliRcV2Stest : public testing::Test {
protected:
    void SetUp() override
    {
        StubDlFuncs();
        const ::testing::TestInfo* testInfo = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("david", testInfo->name());
        optind = 1;
        std::string mkWorkspace = std::string("mkdir -p ") + RC_V2_WORKSPACE;
        system(mkWorkspace.c_str());
        system("printf '#!/bin/sh\\nexit 0\\n' > ./cli && chmod +x ./cli");
        EXPECT_EQ(RC_V2_DEVICE_NUM, SimulatorMgr().CreateDeviceSimulator(RC_V2_DEVICE_NUM, StPlatformType::RC_V2_TYPE));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }

    void TearDown() override
    {
        GlobalMockObject::verify();
        DevprofDrvAicpu::instance()->isRegister_ = false;
        EXPECT_EQ(RC_V2_DEVICE_NUM, SimulatorMgr().DelDeviceSimulator(RC_V2_DEVICE_NUM, StPlatformType::RC_V2_TYPE));
        std::string rmWorkspace = std::string("rm -rf ") + RC_V2_WORKSPACE + " ./cli";
        system(rmWorkspace.c_str());
        DataMgr().UnInit();
        MsprofMgr().UnInit();
    }

    void StubDlFuncs()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }

    int32_t StartAppMode(std::vector<const char*>& args)
    {
        return MsprofMgr().MsprofStartByAppMode(static_cast<int>(args.size()), args.data());
    }
};

// 默认采集口径：rc_v2支持PLATFORM_TASK_STARS_ACSQ，默认数据清单与rc lite v2形态一致
TEST_F(CliRcV2Stest, CliTaskTimeDefaultDataList)
{
    std::vector<const char*> args = {RC_V2_OUTPUT_ARG, "--task-time=on"};
    const std::vector<std::string> expectData = {
        "ffts_profile.data", "stars_soc.data", "ts_track.data", "stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(expectData);
    EXPECT_EQ(PROFILING_SUCCESS, StartAppMode(args));
}

// PLATFORM_TASK_BLOCK_ON：rc_v2支持task-block=on
TEST_F(CliRcV2Stest, CliTaskBlockOn)
{
    std::vector<const char*> args = {RC_V2_OUTPUT_ARG, "--task-block=on"};
    const std::vector<std::string> expectData = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(expectData);
    EXPECT_EQ(PROFILING_SUCCESS, StartAppMode(args));
}

// PLATFORM_AICORE_EVENT_FROM_ZERO：AICore事件从0开始编号，Custom事件与内置metrics均应放行
TEST_F(CliRcV2Stest, CliAicMetricsSupported)
{
    const std::vector<std::string> metrics = {
        "PipeUtilization", "Memory", "MemoryL0", "MemoryUB", "ArithmeticUtilization", "ResourceConflictRatio"};
    for (const auto& metric : metrics) {
        std::string option = "--aic-metrics=" + metric;
        std::vector<const char*> args = {RC_V2_OUTPUT_ARG, option.c_str()};
        EXPECT_EQ(PROFILING_SUCCESS, StartAppMode(args)) << "metric: " << metric;
        MsprofMgr().UnInit();
        optind = 1;
    }
}

// PLATFORM_TASK_L2_CACHE_REG与PLATFORM_TASK_L2_CACHE_PMU：L2Cache采集应成功
TEST_F(CliRcV2Stest, CliL2CacheMetrics)
{
    std::vector<const char*> args = {RC_V2_OUTPUT_ARG, "--aic-metrics=L2Cache"};
    const std::vector<std::string> expectData = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(expectData);
    EXPECT_EQ(PROFILING_SUCCESS, StartAppMode(args));
}

// PLATFORM_SYS_DEVICE_LLC_EXT：驱动未上报LLC能力时，rc_v2仍可走扩展LLC采集
TEST_F(CliRcV2Stest, CliLlcExtProfiling)
{
    std::vector<const char*> args = {RC_V2_OUTPUT_ARG, RC_V2_LLC_READ_ARG, RC_V2_SYS_DEVICE_ARG};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(static_cast<int>(args.size()), args.data()));
}

// rc_v2 only owns PLATFORM_TASK_INSTR_PROFILING, the freq switch is accepted but reported useless
TEST_F(CliRcV2Stest, CliInstrProfilingOnWithFreq)
{
    std::vector<const char*> args = {RC_V2_OUTPUT_ARG, "--instr-profiling=on", "--instr-profiling-freq=10000"};
    EXPECT_EQ(PROFILING_SUCCESS, StartAppMode(args));
}

// without the freq switch the task level instr collection keeps working
TEST_F(CliRcV2Stest, CliInstrProfilingOnWithoutFreq)
{
    std::vector<const char*> args = {RC_V2_OUTPUT_ARG, "--instr-profiling=on"};
    EXPECT_EQ(PROFILING_SUCCESS, StartAppMode(args));
}
