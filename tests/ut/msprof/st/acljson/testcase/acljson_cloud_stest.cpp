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
#include "prof_common.h"
#include "aicpu_report_hdc.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char CLOUD_RM_RF[] = "rm -rf ./acljsonCloudstest_workspace";
static const char CLOUD_MKDIR[] = "mkdir ./acljsonCloudstest_workspace";
static const char CLOUD_OUTPUT_DIR[] = "./acljsonCloudstest_workspace/output";

class AclJsonCloudStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("", "acljson");
        optind = 1;
        system(CLOUD_MKDIR);
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CLOUD_TYPE));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CLOUD_TYPE));
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        system(CLOUD_RM_RF);
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(AclJsonCloudStest, AclJsonDefault)
{
    // cloud: TaskTime
    nlohmann::json data;
    data["output"] = CLOUD_OUTPUT_DIR;
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonCloudStest, AclJsonHardwareMem)
{
    // milan: HardwareMem
    nlohmann::json data;
    data["output"] = CLOUD_OUTPUT_DIR;
    data["sys_hardware_mem_freq"] = 50;
    std::vector<std::string> dataList = {"hbm.data", "ddr.data", "npu_mem.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}
namespace ge {
    extern int32_t HandleProfStartCommand(const MsprofCommandHandle * command);
}
TEST_F(AclJsonCloudStest, AclJsonDefaultCallBackFailed)
{
    // cloud: TaskTime
    nlohmann::json data;
    data["output"] = CLOUD_OUTPUT_DIR;
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    MOCKER(ge::HandleProfStartCommand).stubs().will(returnValue(-1));
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonCloudStest, AclJsonTaskMemory)
{
    // cloud: TaskMemory
    nlohmann::json data;
    data["output"] = CLOUD_OUTPUT_DIR;
    data["task_memory"] = "on";
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS, PROF_TASK_MEMORY};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(0, data));
}

// Unsupported Features
TEST_F(AclJsonCloudStest, AclJsonSysLpFreqFailed)
{
    // cloud: sys_lp_freq
    nlohmann::json data;
    data["output"] = CLOUD_OUTPUT_DIR;
    data["sys_lp_freq"] = "100";
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(0, data));
}