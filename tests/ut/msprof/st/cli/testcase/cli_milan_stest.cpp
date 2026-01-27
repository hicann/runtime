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
#include "aicpu_report_hdc.h"
#include "dev_mgr_api.h"
#include "aicpu_report_hdc.h"
#include "devprof_drv_aicpu.h"
#include "dlog_pub.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char MILAN_RM_RF[] = "rm -rf ./cliMilanstest_workspace";
static const char MILAN_MKDIR[] = "mkdir ./cliMilanstest_workspace";
static const char MILAN_OUTPUT_DIR[] = "--output=./cliMilanstest_workspace/output";

static uint32_t g_multiCallbackCnt_ = 0;
int32_t MultiCallbackHandle(uint32_t dataType, void *data, uint32_t dataLen)
{
    (void)dataType;
    (void)data;
    (void)dataLen;
    g_multiCallbackCnt_++; // init;start;stop;finalize
    return 0;
};

class CliMilanStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("milan", curTest->name());
        optind = 1;
        system(MILAN_MKDIR);
        system("touch ./cli");
        MOCKER(mmCreateProcess).stubs().will(invoke(mmCreateProcessStub));
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(PROFILING_FAILED));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_V4_1_0));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_V4_1_0));
        system(MILAN_RM_RF);
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
    bool CheckMultiCallback()
    {
        uint32_t oneCallbackCnt = 4;
        if (g_multiCallbackCnt_ > oneCallbackCnt) {
            return true;
        }
        return false;
    }
};

TEST_F(CliMilanStest, CliTaskTime)
{
    // multi aclInit aclFinalize include callback
    MsprofRegisterCallback(HSS, &MultiCallbackHandle);
    // milan: TaskTime
    const char* argv[] = {MILAN_OUTPUT_DIR,};
    std::vector<std::string> dataList = {"ffts_profile.data", "stars_soc.data", "stars_soc_profile.data","ts_track.data", "lpmInfoConv.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<std::string> hostDataList = {"unaging.additional.diagnostic"};
    MsprofMgr().SetHostCheckList(hostDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    EXPECT_EQ(false, CheckMultiCallback());
}

TEST_F(CliMilanStest, CliTaskTimeTwo)
{
    // milan: TaskTime
    const char* argv[] = {MILAN_OUTPUT_DIR, "cli",};
    std::vector<std::string> dataList = {"ffts_profile.data", "stars_soc.data", "stars_soc_profile.data","ts_track.data", "lpmInfoConv.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppModeTwo(sizeof(argv) / sizeof(char *), argv));
    EXPECT_EQ(true, CheckMultiCallback());
}

TEST_F(CliMilanStest, CliPipeUtilizationTask)
{
    // milan: Task-based AI core/vector metrics: PipeUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=PipeUtilization",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmInfoConv.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliArithmeticUtilizationTask)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=ArithmeticUtilization",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmInfoConv.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliMemoryTask)
{
    // milan: Task-based AI core/vector metrics: Memory
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=Memory",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmInfoConv.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliMemoryL0Task)
{
    // milan: Task-based AI core/vector metrics: MemoryL0
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=MemoryL0",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmInfoConv.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliMemoryUBTask)
{
    // milan: Task-based AI core/vector metrics: MemoryUB
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=MemoryUB",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmInfoConv.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliResourceConflictRatioTask)
{
    // milan: Task-based AI core/vector metrics: ResourceConflictRatio
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=ResourceConflictRatio",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmInfoConv.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliL2CacheTask)
{
    // milan: Task-based AI core/vector metrics: L2Cache
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=L2Cache",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmInfoConv.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliPipeUtilizationSample)
{
    // milan: Sample-based AI core/vector metrics: PipeUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=PipeUtilization", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliArithmeticUtilizationSample)
{
    // milan: Sample-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=ArithmeticUtilization", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliMemorySample)
{
    // milan: Sample-based AI core/vector metrics: Memory
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=Memory", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliMemoryL0Sample)
{
    // milan: Sample-based AI core/vector metrics: MemoryL0
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=MemoryL0", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliMemoryUBSample)
{
    // milan: Sample-based AI core/vector metrics: MemoryUB
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=MemoryUB", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliResourceConflictRatioSample)
{
    // milan: Sample-based AI core/vector metrics: ResourceConflictRatio
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=ResourceConflictRatio", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliL2CacheSample)
{
    // milan: Sample-based AI core/vector metrics: L2Cache
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aic-metrics=L2Cache", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliInstrProfiling)
{
    // milan: instr-profiling collect perf monitor data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--instr-profiling=on",};
    std::vector<std::string> dataList = {"instr.group_"};
    std::vector<std::string> blackDataList = {"instr.biu_perf_group"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliSysProfiling)
{
    // TODO: Simulate ADDA transport
    // milan: Collect system CPU usage and memory data by adda
    SimulatorMgr().SetSocSide(SocType::DEVICE);
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-profiling=on"};
    std::vector<std::string> dataList = {"SystemCpuUsage.data", "Memory.data"};
    std::vector<std::string> blackDataList = {"stars_soc.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliSysCpuProfiling)
{
    // milan: Collect AI CPU, Ctrl CPU and TS CPU data by adda
    SetPerfEnv();
    SimulatorMgr().SetSocSide(SocType::DEVICE);
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-cpu-profiling=on"};
    std::vector<std::string> dataList = {"tscpu.data", "ai_ctrl_cpu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliSysPidProfiling)
{
    // TODO: Simulate ADDA transport
    // milan: Collect process CPU usage and memory data by adda
    SimulatorMgr().SetSocSide(SocType::DEVICE);
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-pid-profiling=on"};
    std::vector<std::string> dataList = {"CpuUsage.data", "Memory.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliLlcProfilingRead)
{
    // milan: Collect llc data by adda
    const char* argv[] = {MILAN_OUTPUT_DIR, "--llc-profiling=read", "--sys-devices=0"};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliLlcProfilingWrite)
{
    // milan: Collect llc data by adda
    const char* argv[] = {MILAN_OUTPUT_DIR, "--llc-profiling=write", "--sys-devices=0"};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliSysHardwareMem)
{
    // milan: Collect HBM and DDR data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-hardware-mem=on", "--sys-devices=0"};
    std::vector<std::string> dataList = {"hbm.data", "llc.data", "qos.data", "npu_mem.data", "npu_module_mem.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliSysInterconnectionProfiling)
{
    // milan: Collect PCIE and HCCS data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-interconnection-profiling=on", "--sys-devices=0"};
    std::vector<std::string> dataList = {"pcie.data", "hccs.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliSysIoProfiling)
{
    // milan: Collect NIC and ROCE data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-io-profiling=on", "--sys-devices=0"};
    std::vector<std::string> dataList = {"nic.data", "roce.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliDvvpProfiling)
{
    // milan: Collect dvvp data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--dvpp-profiling=on", "--sys-devices=0"};
    std::vector<std::string> dataList = {"dvpp.data", "dvpp.venc", "dvpp.jpege", "dvpp.vdec", "dvpp.jpegd", "dvpp.vpc", "dvpp.png", "dvpp.scd"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliHostSys)
{
    // milan: Collect data in host side
    int32_t pid = analysis::dvvp::common::utils::Utils::GetPid();
    std::string hostPid = "--host-sys-pid=" + std::to_string(pid);
    const char* argv[] = {MILAN_OUTPUT_DIR, "--host-sys=cpu,mem,network", hostPid.c_str(), "--sys-devices=0"};
    std::vector<std::string> dataList = {"host_cpu.data", "host_mem.data", "host_network.data"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliHostSysUsage)
{
    // milan: Collect data in host side
    const char* argv[] = {MILAN_OUTPUT_DIR, "--host-sys-usage=cpu,mem","--host-sys-usage-freq=20"};
    std::vector<std::string> dataList = {"CpuUsage.data", "Memory.data"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliL2)
{
    // milan: Collect l2 data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--l2=on",};
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, NpuEvents)
{
    // milan: Collect npu-events data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--npu-events=0x1,0x2,0x3,0x4,0x5",};
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, SocPmuEvents)
{
    // david: Collect npu-events data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x5;SMMU:0x1,0x2,0x3",};
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, SocPmuEventsHaRepeat)
{
    // david: Collect npu-events data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x5;HA:0x1,0x2,0x3",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, SocPmuEventsSmmuRepeat)
{
    // david: Collect npu-events data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--npu-events=SMMU:0x1,0x2,0x3,0x4,0x5;SMMU:0x1,0x2,0x3",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, SocPmuEventsNocNotAllow)
{
    // david: Collect npu-events data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--npu-events=NOC:0x1,0x2,0x3",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, SocPmuEventsHaOverFlow)
{
    // david: Collect npu-events data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9;SMMU:0x1,0x2,0x3",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, SocPmuEventsSmmuOverFlow)
{
    // david: Collect npu-events data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3;SMMU:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, SocPmuEventsSmmuOverFlowEvent)
{
    // david: Collect npu-events data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x5;SMMU:0x1,0x2,0x3,0x809",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, SocPmuEventsHaOverFlowEvent)
{
    // david: Collect npu-events data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x256;SMMU:0x1,0x2,0x3,0x809",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliDataAicpuReportData)
{
    // milan: Collect DATAPREPROCESS report data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aicpu=on",};
    std::vector<std::string> dataList = {"DATA_PREPROCESS.test"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliMsproftxReportAdditionalInfo)
{
    // milan: Collect tx data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--msproftx=on",};
    std::vector<std::string> dataList = {"aging.additional.msproftx"};
    MsprofMgr().SetHostCheckList(dataList);
    MsprofMgr().SetMsprofTx(true);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    MsprofMgr().SetMsprofTx(false);
}

TEST_F(CliMilanStest, CliMemVisualization)
{
    // milan: Collect mem data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-hardware-mem=on",};
    std::vector<std::string> dataList = {"npu_mem.app"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliSysHardwareMemOverflow)
{
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-hardware-mem=on", "--sys-hardware-mem-freq=101",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliDvvpProfilingApp)
{
    // milan: Collect dvvp data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--dvpp-profiling=on",};
    std::vector<std::string> dataList = {"dvpp.data", "dvpp.venc", "dvpp.jpege", "dvpp.vdec", "dvpp.jpegd", "dvpp.vpc", "dvpp.png", "dvpp.scd"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliFreqConvAicoreOff)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--ai-core=off",};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliTaskTimeOff)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--task-time=off", };
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliTaskTimeOn)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--task-time=l0", };
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliTaskTimeL3)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--task-time=l3", };
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliFwkScheduleOff)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--fwk-schedule=off", };
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliFwkScheduleOn)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--fwk-schedule=l0", };
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliFwkScheduleERROR)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--fwk-schedule=L1", };
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliTaskTimeERROR)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {MILAN_OUTPUT_DIR, "--task-time=L0", };
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliDataAicpuReportDataNew)
{
    // milan: Collect aicpu report data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--aicpu=on",};
    std::vector<std::string> dataList = {"aicpu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    MsprofMgr().SetSleepTime(100);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    optind = 1;
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    GlobalMockObject::verify();
}

TEST_F(CliMilanStest, CliDataAicpuReportDataMC2HCCL)
{
    // milan: Collect aicpu report data
    const char* argv[] = {MILAN_OUTPUT_DIR, "--task-time=l0",};
    std::vector<std::string> dataList = {"aicpu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    MsprofMgr().SetSleepTime(100);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    GlobalMockObject::verify();
}

int32_t g_StubCnt = 0;
hdcError_t halHdcRecvStub(HDC_SESSION session, struct drvHdcMsg *msg, int bufLen,
    unsigned long long flag, int *recvBufCount, unsigned int timeout)
{
    if (g_StubCnt >= 1) {
        return DRV_ERROR_NO_DEVICE;
    }
    sleep(5); // Simulation stuck for 5 seconds
    g_StubCnt++;
    return DRV_ERROR_WAIT_TIMEOUT;
}

TEST_F(CliMilanStest, CliAddaStuck)
{
    // TODO: Simulate ADDA transport
    // milan: Collect system CPU usage and memory data by adda
    constexpr uint32_t SUPPORT_ADPROF_VERSION = 0x72316;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::DrvGetApiVersion)
        .stubs()
        .will(returnValue(SUPPORT_ADPROF_VERSION - 1));
    int32_t recvBufCount = 1;
    uint32_t platformInfo = 1; // device type
    struct drvHdcMsg *hdcMsg = (struct drvHdcMsg *)0x12345678;
    SimulatorMgr().SetSocSide(SocType::DEVICE);
    MOCKER(halHdcRecv)
        .stubs()
        .with(any(), any(), any(), any(), outBoundP(&recvBufCount, sizeof(recvBufCount)), any())
        .will(invoke(halHdcRecvStub));
    MOCKER(drvHdcAllocMsg)
        .stubs()
        .with(any(), outBoundP(&hdcMsg, sizeof(drvHdcMsg)), any())
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(drvGetPlatformInfo)
        .stubs()
        .with(outBoundP(&platformInfo, sizeof(platformInfo)))
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP(&Analysis::Dvvp::Adx::HdcSessionWrite)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-profiling=on", "--sys-period=1"};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliMemServiceflow)
{
    const char* argv[] = {MILAN_OUTPUT_DIR, "--sys-mem-serviceflow=,aaa,,bbb,ccc", "--sys-hardware-mem=on",};
    std::vector<std::string> dataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliMilanStest, CliHelperPureCpu)
{
    // milan: pure cpu in hostcpu-ps slave process
    MsprofMgr().SetMsprofConfig(StProfConfigType::PROF_CONFIG_PURE_CPU);
    const char* argv[] = {MILAN_OUTPUT_DIR,};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    MsprofMgr().SetMsprofConfig(StProfConfigType::PROF_CONFIG_DYNAMIC);
}