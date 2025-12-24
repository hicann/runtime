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
#include "platform/platform.h"
#include "aicpu_report_hdc.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char DAVID_RM_RF[] = "rm -rf ./acljsonDavidstest_workspace";
static const char DAVID_MKDIR[] = "mkdir ./acljsonDavidstest_workspace";
static const char DAVID_OUTPUT_DIR[] = "./acljsonDavidstest_workspace/output";

class AclJsonDavidStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("", "acljson");
        optind = 1;
        system(DAVID_MKDIR);
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V3));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V3));
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        system(DAVID_RM_RF);
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(AclJsonDavidStest, AclJsonDefault)
{
    // david: TaskTime
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    std::vector<std::string> deviceDataList = {"ts_track.data", "ccu0.instr", "ccu1.instr"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonDavidStest, AclJsonCcuStatUbFreqMax)
{
    // david: statistic
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_interconnection_freq"] = 50;
    std::vector<std::string> dataList = {"ccu0.stat", "ccu1.stat", "ub.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonCcuStatUbFreqMin)
{
    // david: statistic
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_interconnection_freq"] = 1;
    std::vector<std::string> dataList = {"ccu0.stat", "ccu1.stat", "ub.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonCcuStatUbOverflow)
{
    // david: statistic
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_interconnection_freq"] = 51;
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonCcuStatUbLow)
{
    // david: statistic
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_interconnection_freq"] = 0.1;
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonMemServiceflow)
{
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_mem_serviceflow"] = "aaa,bbb";
    data["sys_hardware_mem_freq"] = 10000;
    std::vector<std::string> dataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonHardwareMemOverflow)
{
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_hardware_mem_freq"] = 10001;
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonL2)
{
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["l2"] = "on";
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonInstrProfiling)
{
    // milan: InstrProfiling
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["instr_profiling"] = "on";
    data["instr_profiling_freq"] = "10000";
    std::vector<std::string> dataList = {"instr.biu_perf_group0", "instr.biu_perf_group1", "instr.biu_perf_group2"};
    // david device simulator return aicore num 18 <= DAVID_DIE0_AICORE_NUM
    std::vector<std::string> blackDataList = {"instr.biu_perf_group3", "instr.biu_perf_group4", "instr.biu_perf_group5"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    std::vector<uint64_t> bitList = {PROF_INSTR};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonSysCpuFreq)
{
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_cpu_freq"] = 50;
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonScale)
{
    // david: scale
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["scale"] = "opType:MatMulV3,Index;opName:aclnnMatmul_MatMulV3Common_MatMulV3,aclnnIndex_IndexAiCore_Index";
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidStest, AclJsonTaskTimeL3)
{
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["task_trace"] = "l3";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<uint64_t> bitList = {PROF_TASK_TIME_L3};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}