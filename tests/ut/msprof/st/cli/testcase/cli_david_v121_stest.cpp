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
#include "aicpu_report_hdc.h"
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char DAVID_V121_RM_RF[] = "rm -rf ./cliDavidV121stest_workspace";
static const char DAVID_V121_MKDIR[] = "mkdir ./cliDavidV121stest_workspace";
static const char DAVID_V121_OUTPUT_DIR[] = "--output=./cliDavidV121stest_workspace/output";

class CliDavidV121Stest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("david", curTest->name());
        optind = 1;
        system(DAVID_V121_MKDIR);
        system("touch ./cli");
        MOCKER(mmCreateProcess).stubs().will(invoke(mmCreateProcessStub));
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(PROFILING_FAILED));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V4));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V4));
        system(DAVID_V121_RM_RF);
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

TEST_F(CliDavidV121Stest, CliTaskTime)
{
    // TaskTime
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--task-time=on"};
    std::vector<std::string> dataList = {"ffts_profile.data", "stars_soc.data", "ts_track.data", "ccu0.instr",
        "ccu1.instr"};
    std::vector<std::string> blackDataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliTaskTimeTwo)
{
    // TaskTime
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "cli",};
    std::vector<std::string> dataList = {"ffts_profile.data", "stars_soc.data","ts_track.data", "lpmFreqConv.data",
        "ccu0.instr", "ccu1.instr"};
    std::vector<std::string> blackDataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppModeTwo(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliPipeUtilizationTask)
{
    // Task-based AI core/vector metrics: PipeUtilization
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--aic-metrics=PipeUtilization",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliArithmeticUtilizationTask)
{
    // Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--aic-metrics=ArithmeticUtilization",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliMemoryTask)
{
    // Task-based AI core/vector metrics: Memory
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--aic-metrics=Memory",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliMemoryL0Task)
{
    // Task-based AI core/vector metrics: MemoryL0
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--aic-metrics=MemoryL0",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliMemoryUBTask)
{
    // Task-based AI core/vector metrics: MemoryUB
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--aic-metrics=MemoryUB",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliResourceConflictRatioTask)
{
    // Task-based AI core/vector metrics: ResourceConflictRatio
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--aic-metrics=ResourceConflictRatio",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliL2CacheTask)
{
    // Task-based AI core/vector metrics: L2Cache
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--aic-metrics=L2Cache",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliCustomTask)
{
    // david: Custom pmu events
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--aic-metrics=Custom:0x0,0x1,0x2,0x711,0x712,0x713,0x714,0x715,0x716,0x717",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliMemServiceflow)
{
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--sys-mem-serviceflow=aaa,bbb,ccc", "--sys-hardware-mem=on",};
    std::vector<std::string> dataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliSysCpuProfiling)
{
    SetPerfEnv();
    SimulatorMgr().SetSocSide(SocType::DEVICE);
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--sys-cpu-profiling=on"};
    std::vector<std::string> dataList = {"ai_ctrl_cpu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliScale)
{
    // david: scale normal
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--scale=opType:MatMulV3,Index;opName:aclnnMatmul_MatMulV3Common_MatMulV3,aclnnIndex_IndexAiCore_Index"};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliScaleEmptyName)
{
    // david: scale empty name
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, "--scale=opType:MatMulV3,Index;opName:aclnnMatmul_MatMulV3Common_MatMulV3,,,,"};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliScaleOverFlow)
{
    // david: scale overflow
    std::string opName(512, 't');
    std::string scaleCmd = "--scale=opType:MatMulV3;opName:" + opName;
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, scaleCmd.c_str()};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliScaleCritical)
{
    // david: scale critical
    std::string opName(511, 't');
    std::string scaleCmd = "--scale=opType:MatMulV3;opName:" + opName;
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, scaleCmd.c_str()};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidV121Stest, CliScaleDuplicate)
{
    // david: scale duplicate
    std::string opName = "aclnnIndex_IndexAiCore_Index";
    std::string scaleCmd = "--scale=opType:MatMulV3;opName:";
    for (auto i = 0; i < 20; ++i) {
        scaleCmd += opName;
        scaleCmd += ",";
    }
    scaleCmd.pop_back();
    const char* argv[] = {DAVID_V121_OUTPUT_DIR, scaleCmd.c_str()};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}