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

static const char MDCLITE_RM_RF[] = "rm -rf ./acljsonMdcLitestest_workspace";
static const char MDCLITE_MKDIR[] = "mkdir ./acljsonMdcLitestest_workspace";
static const char MDCLITE_OUTPUT_DIR[] = "./acljsonMdcLitestest_workspace/output";

class AclJsonMdcLiteStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("", "acljson");
        optind = 1;
        system(MDCLITE_MKDIR);
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_MDC_LITE));
        SimulatorMgr().SetSocSide(SocType::DEVICE);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_MDC_LITE));
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        system(MDCLITE_RM_RF);
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(AclJsonMdcLiteStest, AclJsonDefault)
{
    // mdc: TaskTime
    nlohmann::json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
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

TEST_F(AclJsonMdcLiteStest, AclJsonPipeUtilizationAicMetrics)
{
    // mdc: AicMetrics: PipeUtilization
    nlohmann::json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
    data["aic_metrics"] = "PipeUtilization";
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMdcLiteStest, AclJsonPipelineExecuteUtilizationAicMetrics)
{
    // mdc: AicMetrics: PipelineExecuteUtilization
    nlohmann::json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
    data["aic_metrics"] = "PipelineExecuteUtilization";
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMdcLiteStest, AclJsonArithmeticUtilizationAicMetrics)
{
    // mdc: AicMetrics: ArithmeticUtilization
    nlohmann::json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
    data["aic_metrics"] = "ArithmeticUtilization";
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMdcLiteStest, AclJsonMemoryAicMetrics)
{
    // mdc: AicMetrics: Memory
    nlohmann::json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
    data["aic_metrics"] = "Memory";
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMdcLiteStest, AclJsonMemoryL0AicMetrics)
{
    // mdc: AicMetrics: MemoryL0
    nlohmann::json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
    data["aic_metrics"] = "MemoryL0";
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMdcLiteStest, AclJsonMemoryUBAicMetrics)
{
    // mdc: AicMetrics: MemoryUB
    nlohmann::json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
    data["aic_metrics"] = "MemoryUB";
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMdcLiteStest, AclJsonResourceConflictRatioAicMetrics)
{
    // mdc: AicMetrics: ResourceConflictRatio
    nlohmann::json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
    data["aic_metrics"] = "ResourceConflictRatio";
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonMdcLiteStest, AclJsonL2CacheAicMetrics)
{
    // mdc: AicMetrics: L2Cache
    nlohmann::json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
    data["aic_metrics"] = "L2Cache";
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}