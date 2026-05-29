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
#include "platform/platform.h"
#include "job_device_rpc.h"
#include "job_device_soc.h"
#include "utils.h"
#include "hdc_api.h"
#include "dev_mgr_api.h"
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char MDC_LITE_V2_RM_RF[] = "rm -rf ./cliMdcLiteV2stest_workspace";
static const char MDC_LITE_V2_MKDIR[] = "mkdir ./cliMdcLiteV2stest_workspace";
static const char MDC_LITE_V2_OUTPUT_DIR[] = "--output=./cliMdcLiteV2stest_workspace/output";

class CliMdcLiteV2Stest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("david", curTest->name());
        optind = 1;
        system(MDC_LITE_V2_MKDIR);
        system("touch ./cli");
        MOCKER(mmCreateProcess).stubs().will(invoke(mmCreateProcessStub));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_MDC_LITE_V2));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_MDC_LITE_V2));
        system(MDC_LITE_V2_RM_RF);
        system("rm -rf ./cli");
        DataMgr().UnInit();
        MsprofMgr().UnInit();
    }
    void SetPerfEnv()
    {
        MOCKER(mmWaitPid).stubs().will(returnValue(1));
        std::string perfDataDirStub = "./perf";
        MockPerfDir(perfDataDirStub);
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(CliMdcLiteV2Stest, CliTaskTime)
{
    // TaskTime
    const char* argv[] = {MDC_LITE_V2_OUTPUT_DIR, "--task-time=on"};
    std::vector<std::string> dataList = {"ffts_profile.data", "stars_soc.data","ts_track.data",
        "stars_soc_profile.data"};
    std::vector<std::string> blackDataList = {};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMdcLiteV2Stest, CliTaskBlockOn)
{
    const char* argv[] = {MDC_LITE_V2_OUTPUT_DIR, "--task-block=on"};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMdcLiteV2Stest, CliL2CacheTask)
{
    const char* argv[] = {MDC_LITE_V2_OUTPUT_DIR, "--aic-metrics=L2Cache"};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMdcLiteV2Stest, CliAivNotSupport)
{
    const char* argv[] = {MDC_LITE_V2_OUTPUT_DIR, "--aiv=on"};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}
