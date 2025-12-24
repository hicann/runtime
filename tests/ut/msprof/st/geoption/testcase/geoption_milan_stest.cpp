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
#include "aicpu_report_hdc.h"
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char MILAN_RM_RF[] = "rm -rf ./geoptionMilanstest_workspace";
static const char MILAN_MKDIR[] = "mkdir ./geoptionMilanstest_workspace";
static const char MILAN_OUTPUT_DIR[] = "./geoptionMilanstest_workspace/output";

class GeOptionMilanStest: public testing::Test {
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
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_V4_1_0));
        system(MILAN_RM_RF);
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

TEST_F(GeOptionMilanStest, GeOptionDefault)
{
    // milan: TaskTime
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(0, data));
}

TEST_F(GeOptionMilanStest,GeOptionL2)
{
    // milan: l2
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["l2"] = "on";
    std::vector<std::string> dataList = {"socpmu.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest,GeOptionInstrProfiling)
{
    // milan: InstrProfiling
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["instr_profiling"] = "on";
    std::vector<std::string> dataList = {"instr.group"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest,GeOptionTaskTimeFwkL0)
{
    // milan: InstrProfiling
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["ge_api"] = "l0";
    data["task_trace"] = "l0";
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest,GeOptionTaskTimeFwkOff)
{
    // milan: InstrProfiling
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["ge_api"] = "off";
    data["task_trace"] = "off";
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest,GeOptionTaskTimeFwkL1)
{
    // milan: InstrProfiling
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["ge_api"] = "l1";
    data["task_trace"] = "l1";
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest, GeOptionHardwareMem)
{
    // milan: HardwareMem
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_hardware_mem_freq"] = 50;
    std::vector<std::string> dataList = {"hbm.data", "npu_mem.data", "npu_module_mem.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest, GeOptionLlc)
{
    // milan: llc
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_hardware_mem_freq"] = 50;
    data["llc_profiling"] = "read";
    std::vector<std::string> dataList = {"llc.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest, GeOptionSysIo)
{
    // milan: SysIo
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_io_sampling_freq"] = 50;
    std::vector<std::string> dataList = {"nic.data", "roce.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest, GeOptionSysInterconnection)
{
    // milan: SysInterconnection
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_interconnection_freq"] = 50;
    std::vector<std::string> dataList = {"pcie.data", "hccs.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest, GeOptionDvpp)
{
    // milan: dvpp
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["dvpp_freq"] = 50;
    std::vector<std::string> dataList = {"dvpp.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest, GeOptionHostSys)
{
    // milan: host sys profiling
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["host_sys"] = "cpu,mem";
    std::vector<std::string> dataList = {"host_cpu.data", "host_mem.data"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest, GeOptionHostSysUsage)
{
    // milan: host all pid profiling
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["host_sys_usage"] = "cpu,mem";
    data["host_sys_usage_freq"] = 50;
    std::vector<std::string> dataList = {"CpuUsage.data", "Memory.data"};
    MsprofMgr().SetHostCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest, GeOptionMemServiceflow)
{
    // milan: MemServiceflow
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["sys_mem_serviceflow"] = "aaa,bbb";
    data["sys_hardware_mem_freq"] = 50;
    std::vector<std::string> dataList = {"stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
}

TEST_F(GeOptionMilanStest, GeOptionMsprofTx)
{
    // milan: MsprofTx
    nlohmann::json data;
    data["output"] = MILAN_OUTPUT_DIR;
    data["msproftx"] = "on";
    std::vector<std::string> dataList = {"aging.additional.msproftx"};
    MsprofMgr().SetHostCheckList(dataList);
    MsprofMgr().SetMsprofTx(true);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(1, data));
    MsprofMgr().SetMsprofTx(false);
}