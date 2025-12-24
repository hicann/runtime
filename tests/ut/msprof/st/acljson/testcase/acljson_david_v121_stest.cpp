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

static const char DAVID_V121_RM_RF[] = "rm -rf ./acljsonDavidV121stest_workspace";
static const char DAVID_V121_MKDIR[] = "mkdir ./acljsonDavidV121stest_workspace";
static const char DAVID_V121_OUTPUT_DIR[] = "./acljsonDavidV121stest_workspace/output";

class AclJsonDavidV121Stest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("", "acljson");
        optind = 1;
        system(DAVID_V121_MKDIR);
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V4));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_CLOUD_V4));
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        system(DAVID_V121_RM_RF);
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(AclJsonDavidV121Stest, AclJsonDefault)
{
    // david: TaskTime
    nlohmann::json data;
    data["output"] = DAVID_V121_OUTPUT_DIR;
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

TEST_F(AclJsonDavidV121Stest, AclJsonSysCpuFreq)
{
    nlohmann::json data;
    data["output"] = DAVID_V121_OUTPUT_DIR;
    data["sys_cpu_freq"] = 50;
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidV121Stest, AclJsonScale)
{
    // david: scale
    nlohmann::json data;
    data["output"] = DAVID_V121_OUTPUT_DIR;
    data["scale"] = "opType:MatMulV3,Index;opName:aclnnMatmul_MatMulV3Common_MatMulV3,aclnnIndex_IndexAiCore_Index";
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidV121Stest, AclJsonScaleEmpty)
{
    // david: scale empty
    nlohmann::json data;
    data["output"] = DAVID_V121_OUTPUT_DIR;
    data["scale"] = "opType:MatMulV3,Index;opName:aclnnMatmul_MatMulV3Common_MatMulV3,,,,,,";
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidV121Stest, AclJsonScaleOverflow)
{
    // david: scale overflow
    nlohmann::json data;
    std::string opName(512, 't');
    std::string scaleCmd = "opType:MatMulV3;opName:" + opName;
    data["output"] = DAVID_V121_OUTPUT_DIR;
    data["scale"] = scaleCmd;
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidV121Stest, AclJsonScaleCritical)
{
    // david: scale critical
    nlohmann::json data;
    std::string opName(511, 't');
    std::string scaleCmd = "opType:MatMulV3;opName:" + opName;
    data["output"] = DAVID_V121_OUTPUT_DIR;
    data["scale"] = scaleCmd;
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonDavidV121Stest, AclJsonScaleDuplicate)
{
    // david: scale dumplicate
    nlohmann::json data;
    std::string opName = "aclnnIndex_IndexAiCore_Index";
    std::string scaleCmd = "opType:MatMulV3;opName:";
    for (auto i = 0; i < 20; ++i) {
        scaleCmd += opName;
        scaleCmd += ",";
    }
    scaleCmd.pop_back();
    data["output"] = DAVID_V121_OUTPUT_DIR;
    data["scale"] = scaleCmd;
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}