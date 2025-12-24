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
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char DAVID_RM_RF[] = "rm -rf ./geoptionDavidstest_workspace";
static const char DAVID_MKDIR[] = "mkdir ./geoptionDavidstest_workspace";
static const char DAVID_OUTPUT_DIR[] = "./geoptionDavidstest_workspace/output";

class GeOptionDavidStest: public testing::Test {
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
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V3));
        system(DAVID_RM_RF);
        system("rm -rf ./geoption.json");
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

TEST_F(GeOptionDavidStest, GeOptionDefault)
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
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(0, data));
}

TEST_F(GeOptionDavidStest, GeOptionCcuStatUbFreqMax)
{
    // david: statistic
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_interconnection_freq"] = 50;
    std::vector<std::string> dataList = {"ccu0.stat", "ccu1.stat", "ub.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionDavidStest, GeOptionCcuStatUbFreqMin)
{
    // david: statistic
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_interconnection_freq"] = 1;
    std::vector<std::string> dataList = {"ccu0.stat", "ccu1.stat", "ub.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionDavidStest, GeOptionMemServiceflow)
{
    // milan: MemServiceflow
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_mem_serviceflow"] = "aaa,bbb";
    data["sys_hardware_mem_freq"] = 10000;
    std::vector<std::string> dataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionDavidStest, GeOptionHardwareMemOverflow)
{
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["sys_hardware_mem_freq"] = 10001;
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionDavidStest, GeOptionL2)
{
    // milan: l2
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["l2"] = "on";
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionDavidStest,GeOptionInstrProfiling)
{
    // milan: InstrProfiling
    nlohmann::json data;
    data["output"] = DAVID_OUTPUT_DIR;
    data["instr_profiling"] = "on";
    std::vector<std::string> dataList = {"instr.biu_perf_group0", "instr.biu_perf_group1", "instr.biu_perf_group2"};
    // david device simulator return aicore num 18 <= DAVID_DIE0_AICORE_NUM
    std::vector<std::string> blackDataList = {"instr.biu_perf_group3", "instr.biu_perf_group4", "instr.biu_perf_group5"};
    MsprofMgr().SetDeviceCheckList(dataList, blackDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}