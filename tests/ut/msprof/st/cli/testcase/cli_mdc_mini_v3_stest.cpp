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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "device_simulator_manager.h"
#include "errno/error_code.h"
#include "msprof_start.h"
#include "../stub/cli_stub.h"
#include "data_manager.h"
#include "aicpu_report_hdc.h"
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Config;
using namespace Cann::Dvvp::Test;

static const char MDCMINIV3_RM_RF[] = "rm -rf ./cliMdcMiniV3stest_workspace";
static const char MDCMINIV3_MKDIR[] = "mkdir ./cliMdcMiniV3stest_workspace";
static const char MDCMINIV3_OUTPUT_DIR[] = "--output=./cliMdcMiniV3stest_workspace/output";

class CliMdcMiniV3Stest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("mdc_mini_v3", curTest->name());
        optind = 1;
        system(MDCMINIV3_MKDIR);
        system("touch ./cli");
        MOCKER(mmCreateProcess).stubs().will(invoke(mmCreateProcessStub));
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_MDC_MINI_V3));
        SimulatorMgr().SetSocSide(SocType::DEVICE);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_MDC_MINI_V3));
        system(MDCMINIV3_RM_RF);
        system("rm -rf ./cli");
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

TEST_F(CliMdcMiniV3Stest, CliPipelineExecuteUtilizationTask)
{
    // mdc_mini_v3: Task-based AI core/vector metrics: PipelineExecuteUtilization
    const char* argv[] = {MDCMINIV3_OUTPUT_DIR, "--aic-metrics=PipelineExecuteUtilization",};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMdcMiniV3Stest, CliPipelineExecuteUtilizationSample)
{
    // mdc_mini_v3: Sample-based AI core/vector metrics: PipelineExecuteUtilization
    const char* argv[] = {MDCMINIV3_OUTPUT_DIR, "--aic-metrics=PipelineExecuteUtilization", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMdcMiniV3Stest, CliSysIoProfiling)
{
    // mdc_mini_v3: Collect NIC and ROCE data
    const char* argv[] = {MDCMINIV3_OUTPUT_DIR, "--sys-io-profiling=on", "--sys-devices=0"};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMdcMiniV3Stest, CliHostSys)
{
    // mdc_mini_v3: Collect data in host side
    const char* argv[] = {MDCMINIV3_OUTPUT_DIR, "--host-sys=cpu,mem,disk,network",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMdcMiniV3Stest, CliDataAicpuReportData)
{
    // mdc_mini_v3: Collect DATAPREPROCESS report data
    const char* argv[] = {MDCMINIV3_OUTPUT_DIR, "--aicpu=on",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMdcMiniV3Stest, CliModelExecution)
{
    // mdc_mini_v3: check --model-execution option is not available
    const char* argv[] = {MDCMINIV3_OUTPUT_DIR, "--model-execution=on",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}