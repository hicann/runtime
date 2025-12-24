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

static const char DAVID_RM_RF[] = "rm -rf ./cliDavidstest_workspace";
static const char DAVID_MKDIR[] = "mkdir ./cliDavidstest_workspace";
static const char DAVID_OUTPUT_DIR[] = "--output=./cliDavidstest_workspace/output";

class CliDavidStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("david", curTest->name());
        optind = 1;
        system(DAVID_MKDIR);
        system("touch ./cli");
        MOCKER(mmCreateProcess).stubs().will(invoke(mmCreateProcessStub));
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(PROFILING_FAILED));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V3));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V3));
        system(DAVID_RM_RF);
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

TEST_F(CliDavidStest, CliTaskTime)
{
    // TaskTime
    const char* argv[] = {DAVID_OUTPUT_DIR, "--task-time=on"};
    std::vector<std::string> dataList = {"ffts_profile.data", "stars_soc.data","ts_track.data", "lpmFreqConv.data",
        "ccu0.instr", "ccu1.instr"};
    std::vector<std::string> blackDataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliTaskTimeTwo)
{
    // david: TaskTime
    const char* argv[] = {DAVID_OUTPUT_DIR, "cli",};
    std::vector<std::string> dataList = {"ffts_profile.data", "stars_soc.data","ts_track.data", "lpmFreqConv.data",
        "ccu0.instr", "ccu1.instr"};
    std::vector<std::string> blackDataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppModeTwo(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliPipeUtilizationTask)
{
    // david: Task-based AI core/vector metrics: PipeUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=PipeUtilization",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliArithmeticUtilizationTask)
{
    // david: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=ArithmeticUtilization",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliMemoryTask)
{
    // david: Task-based AI core/vector metrics: Memory
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=Memory",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliMemoryL0Task)
{
    // david: Task-based AI core/vector metrics: MemoryL0
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=MemoryL0",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliMemoryUBTask)
{
    // david: Task-based AI core/vector metrics: MemoryUB
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=MemoryUB",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliResourceConflictRatioTask)
{
    // david: Task-based AI core/vector metrics: ResourceConflictRatio
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=ResourceConflictRatio",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliL2CacheTask)
{
    // david: Task-based AI core/vector metrics: L2Cache
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=L2Cache",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliCustomTask)
{
    // david: Custom pmu events
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=Custom:0x0,0x1,0x2,0x711,0x712,0x713,0x714,0x715,0x716,0x717",};
    std::vector<std::string> dataList = {"ffts_profile.data", "lpmFreqConv.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliPipeUtilizationSample)
{
    // david: Sample-based AI core/vector metrics: PipeUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=PipeUtilization", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliArithmeticUtilizationSample)
{
    // david: Sample-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=ArithmeticUtilization", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliMemorySample)
{
    // david: Sample-based AI core/vector metrics: Memory
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=Memory", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliMemoryL0Sample)
{
    // david: Sample-based AI core/vector metrics: MemoryL0
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=MemoryL0", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliMemoryUBSample)
{
    // david: Sample-based AI core/vector metrics: MemoryUB
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=MemoryUB", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliResourceConflictRatioSample)
{
    // david: Sample-based AI core/vector metrics: ResourceConflictRatio
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=ResourceConflictRatio", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliL2CacheSample)
{
    // david: Sample-based AI core/vector metrics: L2Cache
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aic-metrics=L2Cache", "--aic-mode=sample-based",};
    std::vector<std::string> dataList = {"ffts_profile.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliInstrProfiling)
{
    // david: instr-profiling collect perf monitor data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--instr-profiling=on", "--instr-profiling-freq=1",};
    std::vector<std::string> dataList = {"instr.biu_perf_group0", "instr.biu_perf_group1", "instr.biu_perf_group2"};
    // david device simulator return aicore num 18 <= DAVID_DIE0_AICORE_NUM
    std::vector<std::string> blackDataList = {"instr.biu_perf_group3", "instr.biu_perf_group4", "instr.biu_perf_group5"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliMemServiceflow)
{
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-mem-serviceflow=aaa,bbb,ccc", "--sys-hardware-mem=on",};
    std::vector<std::string> dataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliMemServiceflowError)
{
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-mem-serviceflow=", "--sys-hardware-mem=on",};
    const char* argv1[] = {DAVID_OUTPUT_DIR, "--sys-mem-serviceflow=,,,", "--sys-hardware-mem=on",};
    std::vector<std::string> dataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv1) / sizeof(char *), argv1));
}

TEST_F(CliDavidStest, CliSysProfiling)
{
    // TODO: Simulate ADDA transport
    // david: Collect system CPU usage and memory data by adda
    SimulatorMgr().SetSocSide(SocType::DEVICE);
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-profiling=on"};
    std::vector<std::string> dataList = {"SystemCpuUsage.data", "Memory.data"};
    std::vector<std::string> blackDataList = {"stars_soc.data"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysCpuProfiling)
{
    // david: Collect AI CPU, Ctrl CPU and TS CPU data by adda
    SetPerfEnv();
    SimulatorMgr().SetSocSide(SocType::DEVICE);
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-cpu-profiling=on"};
    std::vector<std::string> dataList = {"tscpu.data", "ai_ctrl_cpu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysPidProfiling)
{
    // TODO: Simulate ADDA transport
    // david: Collect process CPU usage and memory data by adda
    SimulatorMgr().SetSocSide(SocType::DEVICE);
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-pid-profiling=on"};
    std::vector<std::string> dataList = {"CpuUsage.data", "Memory.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliLlcProfilingRead)
{
    // david: Collect llc data by adda
    const char* argv[] = {DAVID_OUTPUT_DIR, "--llc-profiling=read", "--sys-devices=0"};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliLlcProfilingWrite)
{
    // david: Collect llc data by adda
    const char* argv[] = {DAVID_OUTPUT_DIR, "--llc-profiling=write", "--sys-devices=0"};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysHardwareMem)
{
    // david: Collect HBM and DDR data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-hardware-mem=on", "--sys-hardware-mem-freq=10000", "--sys-devices=0"};
    std::vector<std::string> dataList = {"hbm.data", "llc.data", "qos.data", "npu_mem.data", "npu_module_mem.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysHardwareMemOverflow)
{
    // david: Collect HBM and DDR data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-hardware-mem=on", "--sys-hardware-mem-freq=10001", "--sys-devices=0"};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysInterconnection)
{
    // david: Collect PCIE, HCCS and UB data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-devices=0", "--sys-interconnection-profiling=on", "--sys-interconnection-freq=1"};
    std::vector<std::string> dataList = {"pcie.data", "hccs.data", "ub.data", "ccu0.stat", "ccu1.stat"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysIoProfiling)
{
    // david: Collect NIC and ROCE data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-io-profiling=on", "--sys-devices=0"};
    std::vector<std::string> dataList = {"nic.data", "roce.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliDvvpProfiling)
{
    // david: Collect dvvp data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--dvpp-profiling=on", "--sys-devices=0"};
    std::vector<std::string> dataList = {"dvpp.data", "dvpp.venc", "dvpp.jpege", "dvpp.vdec", "dvpp.jpegd", "dvpp.vpc", "dvpp.png", "dvpp.scd"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliHostSys)
{
    // david: Collect data in host side
    int32_t pid = analysis::dvvp::common::utils::Utils::GetPid();
    std::string hostPid = "--host-sys-pid=" + std::to_string(pid);
    const char* argv[] = {DAVID_OUTPUT_DIR, "--host-sys=cpu,mem,network", hostPid.c_str(), "--sys-devices=0"};
    std::vector<std::string> dataList = {"host_cpu.data", "host_mem.data", "host_network.data"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliHostSysUsage)
{
    // david: Collect data in host side
    const char* argv[] = {DAVID_OUTPUT_DIR, "--host-sys-usage=cpu,mem","--host-sys-usage-freq=20"};
    std::vector<std::string> dataList = {"CpuUsage.data", "Memory.data"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartBySysMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliL2)
{
    // david: Collect l2 data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--l2=on",};
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, NpuEvents)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=0x1,0x2,0x3,0x4,0x5",};
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, SocPmuEvents)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x5;SMMU:0x1,0x2,0x3;NOC:0x1,0x2",};
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, SocPmuEventsHaRepeat)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x5;HA:0x1,0x2,0x3",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, SocPmuEventsSmmuRepeat)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=SMMU:0x1,0x2,0x3,0x4,0x5;SMMU:0x1,0x2,0x3",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, SocPmuEventsNocRepeat)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=NOC:0x1,0x2,0x3;NOC:0x1,0x2,0x3",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, SocPmuEventsHaOverFlow)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9;SMMU:0x1,0x2,0x3",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, SocPmuEventsSmmuOverFlow)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3;SMMU:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, SocPmuEventsNocOverFlowEvent)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x5;SMMU:0x1,0x2,0x3;NOC:0x40",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, SocPmuEventsSmmuOverFlowEvent)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x5;SMMU:0x1,0x2,0x3,0x809",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, SocPmuEventsHaOverFlowEvent)
{
    // david: Collect npu-events data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--npu-events=HA:0x1,0x2,0x3,0x4,0x256;SMMU:0x1,0x2,0x3,0x809",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliDataAicpuReportData)
{
    // david: Collect DATAPREPROCESS report data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aicpu=on",};
    std::vector<std::string> dataList = {"DATA_PREPROCESS.test"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliMsproftxReportAdditionalInfo)
{
    // david: Collect tx data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--msproftx=on",};
    std::vector<std::string> dataList = {"aging.additional.msproftx"};
    MsprofMgr().SetHostCheckList(dataList);
    MsprofMgr().SetMsprofTx(true);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    MsprofMgr().SetMsprofTx(false);
}

TEST_F(CliDavidStest, CliMemVisualization)
{
    // david: Collect mem data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-hardware-mem=on",};
    std::vector<std::string> dataList = {"npu_mem.app"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliDvvpProfilingApp)
{
    // david: Collect dvvp data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--dvpp-profiling=on",};
    std::vector<std::string> dataList = {"dvpp.data", "dvpp.venc", "dvpp.jpege", "dvpp.vdec", "dvpp.jpegd", "dvpp.vpc", "dvpp.png", "dvpp.scd"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliFreqConvAicoreOff)
{
    // david: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--ai-core=off",};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliTaskTimeOff)
{
    // david: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--task-time=off", };
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliTaskTimeOn)
{
    // david: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--task-time=l0", };
    std::vector<std::string> dataList = {};
    std::vector<std::string> blackDataList = {"ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliTaskTimeL3)
{
    // david: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--task-time=l3", };
    std::vector<std::string> dataList = {};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliFwkScheduleOff)
{
    // david: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--fwk-schedule=off", };
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliFwkScheduleOn)
{
    // david: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--fwk-schedule=l0", };
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliFwkScheduleERROR)
{
    // david: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--fwk-schedule=L1", };
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliTaskTimeERROR)
{
    // david: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {DAVID_OUTPUT_DIR, "--task-time=L0", };
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliDataAicpuReportDataNew)
{
    // david: Collect aicpu report data
    constexpr uint32_t SUPPORT_ADPROF_VERSION = 0x72316;
    const char* argv[] = {DAVID_OUTPUT_DIR, "--aicpu=on",};
    std::vector<std::string> dataList = {"aicpu.data"};
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::DrvGetApiVersion)
        .stubs()
        .will(returnValue(SUPPORT_ADPROF_VERSION));
    MOCKER(Analysis::Dvvp::Adx::HalHdcSessionConnect).stubs().will(returnValue(-1));
    MsprofMgr().SetDeviceCheckList(dataList);
    MsprofMgr().SetSleepTime(100);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
    GlobalMockObject::verify();
}

TEST_F(CliDavidStest, CliSysLp)
{
    // david: sys-lp sys-lp-freq
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-lp=on", "--sys-lp-freq=100"};
    std::vector<std::string> dataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysLpOverFlow)
{
    // david: sys-lp sys-lp-freq
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-lp=on", "--sys-lp-freq=101"};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysInterconnectionApp)
{
    // david: Collect PCIE, HCCS and UB data
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-interconnection-profiling=on", "--sys-interconnection-freq=50"};
    std::vector<std::string> dataList = {"pcie.data", "hccs.data", "ub.data", "ccu0.stat", "ccu1.stat"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysInterconnectionAppLow)
{
    // david: freq low than min
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-interconnection-profiling=on", "--sys-interconnection-freq=0.1"};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliSysInterconnectionAppOverflow)
{
    // david: freq overflow
    const char* argv[] = {DAVID_OUTPUT_DIR, "--sys-interconnection-profiling=on", "--sys-interconnection-freq=51"};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliDavidStest, CliScale)
{
    // david: scale normal
    const char* argv[] = {DAVID_OUTPUT_DIR, "--scale=opType:MatMulV3,Index;opName:aclnnMatmul_MatMulV3Common_MatMulV3,aclnnIndex_IndexAiCore_Index"};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().MsprofStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}