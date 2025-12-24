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
#include "mmpa_api.h"
#include "data_manager.h"
#include "aicpu_report_hdc.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char MILAN_RM_RF[] = "rm -rf ./acljsonMilanstest_workspace";
static const char MILAN_MKDIR[] = "mkdir ./acljsonMilanstest_workspace";
static const char MILAN_OUTPUT_DIR[] = "./acljsonMilanstest_workspace/output";

class AclJsonMilanStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("", "acljson");
        optind = 1;
        system(MILAN_MKDIR);
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_V4_1_0));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_V4_1_0));
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        system(MILAN_RM_RF);
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(AclJsonMilanStest, AclJsonDefault)
{
    // milan: TaskTime
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonMilanStest, AclJsonEmptyAicMetrics)
{
    // milan: l2
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["aic_metrics"] = "";
    std::vector<std::string> dataList = {"ffts_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonL2)
{
    // milan: l2
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["l2"] = "on";
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<uint64_t> bitList = {PROF_L2CACHE};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonMsprofTx)
{
    // milan: MsprofTx
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["msproftx"] = "on";
    std::vector<std::string> dataList = {"aging.additional.msproftx"};
    MsprofMgr().SetHostCheckList(dataList);
    MsprofMgr().SetMsprofTx(true);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
    MsprofMgr().SetMsprofTx(false);
}

TEST_F(AclJsonMilanStest, AclJsonInstrProfiling)
{
    // milan: InstrProfiling
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["instr_profiling"] = "on";
    std::vector<std::string> dataList = {"instr.group"};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<uint64_t> bitList = {PROF_INSTR};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonTaskTimeFwkL0)
{
    // milan: TaskTimeFwkL0
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["ge_api"] = "l0";
    data["task_trace"] = "l0";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<uint64_t> bitList = {PROF_GE_API_L0, PROF_TASK_TIME};
    std::vector<uint64_t> bitBlackList = {PROF_GE_API_L1};
    MsprofMgr().SetBitSwitchCheckList(bitList, bitBlackList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonTaskTimeFwkOff)
{
    // milan: TaskTimeFwkOff
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["ge_api"] = "off";
    data["task_trace"] = "off";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonTaskTimeFwkERROR)
{
    // milan: TaskTimeFwkERROR
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["ge_api"] = "L1";
    data["task_trace"] = "L0";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<uint64_t> bitList = {PROF_GE_API_L1, PROF_TASK_TIME};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonTaskTimeL3)
{
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["task_trace"] = "l3";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<uint64_t> bitList = {PROF_TASK_TIME_L3};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonHardwareMem)
{
    // milan: HardwareMem
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_hardware_mem_freq"] = 50;
    std::vector<std::string> dataList = {"hbm.data", "npu_mem.data", "npu_module_mem.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonLlc)
{
    // milan: llc
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_hardware_mem_freq"] = 50;
    data["llc_profiling"] = "read";
    std::vector<std::string> dataList = {"llc.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonSysIo)
{
    // milan: SysIo
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_io_sampling_freq"] = 50;
    std::vector<std::string> dataList = {"nic.data", "roce.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonSysInterconnection)
{
    // milan: SysInterconnection
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_interconnection_freq"] = 50;
    std::vector<std::string> dataList = {"pcie.data", "hccs.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonDvpp)
{
    // milan: dvpp
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["dvpp_freq"] = 50;
    std::vector<std::string> dataList = {"dvpp.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonHostSys)
{
    // milan: host sys profiling
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["host_sys"] = "cpu,mem";
    std::vector<std::string> dataList = {"host_cpu.data", "host_mem.data"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonHostSysUsage)
{
    // milan: host all pid profiling
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["host_sys_usage"] = "cpu,mem";
    data["host_sys_usage_freq"] = 20;
    std::vector<std::string> dataList = {"CpuUsage.data", "Memory.data"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

// Unsupported Features
TEST_F(AclJsonMilanStest, AclJsonSysLpFreqFailed)
{
    // cloud: sys_lp_freq
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_lp_freq"] = "100";
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonMilanStest, AclJsonMemServiceflow)
{
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_mem_serviceflow"] = "aaa,bbb";
    data["sys_hardware_mem_freq"] = 50;
    std::vector<std::string> dataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMilanStest, AclJsonHardwareMemOverflow)
{
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_hardware_mem_freq"] = 101;
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}