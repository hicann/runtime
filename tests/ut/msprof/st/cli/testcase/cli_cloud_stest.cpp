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

static const char CLOUD_RM_RF[] = "rm -rf ./cliCloudstest_workspace";
static const char CLOUD_MKDIR[] = "mkdir ./cliCloudstest_workspace";
static const char CLOUD_OUTPUT_DIR[] = "--output=./cliCloudstest_workspace/output";

class CliCloudStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("cloud", curTest->name());
        optind = 1;
        system(CLOUD_MKDIR);
        system("touch ./cli");
        MOCKER(mmCreateProcess).stubs().will(invoke(mmCreateProcessStub));
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CLOUD_TYPE));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CLOUD_TYPE));
        system(CLOUD_RM_RF);
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

TEST_F(CliCloudStest, CliTaskTime)
{
    // cloud: TaskTime
    const char* argv[] = {CLOUD_OUTPUT_DIR,};
    std::vector<std::string> dataList = {"aicore.data", "hwts.data","ts_track.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliSampleTime)
{
    // cloud: SampleTime
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--aic-metrics=PipeUtilization", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"aicore.data", "hwts.data","ts_track.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliL2CacheTask)
{
    // cloud: Task-based AI core/vector metrics: L2Cache
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--aic-metrics=L2Cache",};
    std::vector<std::string> dataList = {"l2_cache.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDelayDurationUtilTaskOn)
{
    // cloud: delay 1s before start and duration 1s before stop
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--delay=1", "--duration=1",};
    std::vector<std::string> dataList = {"aicore.data", "hwts.data","ts_track.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDelayUtilTaskOn)
{
    // cloud: delay 1s start and wait task stop
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--delay=1",};
    std::vector<std::string> dataList = {"aicore.data", "hwts.data","ts_track.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDelayUtilTaskOff)
{
    // cloud: delay 111s start and task is already stop
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--delay=111",}; // use a particular num 111 to simulate that task do not need to wait: cli_stub.cpp: delayTime != 111
    std::vector<std::string> dataList = {"aicore.data", "hwts.data","ts_track.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDurationUtilTaskOff)
{
    // cloud: wait task stop and notify in duration waiting
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--duration=1",};
    std::vector<std::string> dataList = {"aicore.data", "hwts.data","ts_track.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDelayOutRange)
{
    // cloud: delay out of range 1~4294967295s
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--delay=4294967296",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDelaylowRange)
{
    // cloud: delay out of range 1~4294967295s
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--delay=0.1",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDelayNegtive)
{
    // cloud: delay out of range 1~4294967295s
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--delay=-1",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDurationOutRange)
{
    // cloud: duration out of range 1~4294967295s
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--duration=4294967296",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDurationlowRange)
{
    // cloud: duration out of range 1~4294967295s
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--duration=0.1",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliDurationNegtive)
{
    // cloud: duration out of range 1~4294967295s
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--duration=-1",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliTaskMemory)
{
    // cloud: TaskMemory
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--task-memory=on",};
    std::vector<uint64_t> bitList = {PROF_TASK_MEMORY};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliCloudStest, CliTx)
{
    // cloud: msproftx
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--msproftx=on"};
    std::vector<std::string> hostDataList = {"aging.additional.msproftx"};
    MsprofMgr().SetHostCheckList(hostDataList);
    MsprofMgr().SetMsprofTx(true);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    MsprofMgr().SetMsprofTx(false);
}

TEST_F(CliCloudStest, CliL2)
{
    // cloud: msproftx
    const char* argv[] = {CLOUD_OUTPUT_DIR, "--l2=on"};
    std::vector<std::string> dataList = {"l2_cache.data"};
    std::vector<std::string> blackDataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

