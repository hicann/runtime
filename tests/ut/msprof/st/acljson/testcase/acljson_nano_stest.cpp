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
#include "osal.h"

static const char NANO_RM_RF[] = "rm -rf ./acljsonnanostest_workspace";
static const char NANO_MKDIR[] = "mkdir ./acljsonnanostest_workspace";
static const char NANO_OUTPUT_DIR[] = "./acljsonnanostest_workspace/output";
static const char NANO_DIR_WITHOUT_CREATE[] = "./acljsonnanostest_workspace/output/test_dir_test/test_second";
// Statistic OsalSleep time
uint32_t g_sleepCount = 0;
int32_t OsalSleepStub(uint32_t milliSecond)
{
    if (milliSecond > 0) {
        g_sleepCount++;
    }
    return OSAL_EN_OK;
}
// Get OsalSleep time
uint32_t GetSleepCount()
{
    return g_sleepCount;
}

class AclJsonNanoStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("", "acljson");
        optind = 1;
        system(NANO_RM_RF);
        system(NANO_MKDIR);
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_NANO_V1));
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_NANO_V1));
        EXPECT_EQ(0, GetSleepCount());
        system(NANO_RM_RF);
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        system(NANO_RM_RF);
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
        MOCKER(OsalSleep).stubs().will(invoke(OsalSleepStub));
    }
};

TEST_F(AclJsonNanoStest, AclJsonDefault)
{
    // nano: TaskTime
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoStest, AclJsonNotSupportL2)
{
    // nano: TaskTime
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["l2"] = "on";
    EXPECT_EQ(-1, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonNanoStest, AclJsonTaskTraceOn)
{
    // nano: task_trace
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["task_trace"] = "on";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsPipeUtilization)
{
    // aic_metrics: PipeUtilization
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "PipeUtilization";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsPipeStallCycle)
{
    // aic_metrics: PipeStallCycle
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "PipeStallCycle";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsMemory)
{
    // aic_metrics: Memory
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "Memory";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsMemoryUB)
{
    // aic_metrics: MemoryUB
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "MemoryUB";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsScalar)
{
    // aic_metrics: Scalar
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "ScalarRatio";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonTaskTraceOff)
{
    // nano: task_trace
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["task_trace"] = "off";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonTaskTraceLevel0)
{
    // nano: task_trace
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["task_trace"] = "l0";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonTaskTraceLevel1)
{
    // nano: task_trace
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["task_trace"] = "l1";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonTaskTraceLevel2)
{
    // nano: task_trace
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["task_trace"] = "l2";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.additional.type_info_dic", "unaging.additional.hash_dic",
        "aging.additional.context_id_info", "unaging.additional.context_id_info", "aging.compact.node_basic_info",
        "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.compact.task_track"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonMultiOutput)
{
    // nano: test for output with multi layers
    nlohmann::json data;
    data["output"] = NANO_DIR_WITHOUT_CREATE;
    data["task_trace"] = "on";
    std::vector<std::string> dataList = {"nano_stars_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(1, data));
}

// start::不支持的参数 and 异常参数
TEST_F(AclJsonNanoStest, AclJsonExceptionAicMetrics)
{
    // aic_metrics: pipfix
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "pipfix";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonExceptionTaskTrace)
{
    // task_trace: onoff
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["task_trace"] = "onoff";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsArithmeticUtilization)
{
    // aic_metrics: ArithmeticUtilization
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "ArithmeticUtilization";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsPipelineExecuteUtilization)
{
    // aic_metrics: PipelineExecuteUtilization
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "PipelineExecuteUtilization";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsResourceConflictRatio)
{
    // aic_metrics: ResourceConflictRatio
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "ResourceConflictRatio";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsMemoryL0)
{
    // aic_metrics: MemoryL0
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "MemoryL0";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicMetricsL2Cache)
{
    // aic_metrics: L2Cache
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aic_metrics"] = "L2Cache";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonFwkSchedule)
{
    // aic_metrics: L2Cache
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["ge_api"] = "on";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonAicpu)
{
    // aic_metrics: L2Cache
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["aicpu"] = "on";
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonHostSysUsageFreq)
{
    // host_sys_usage_freq: 20. not support
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["host_sys_usage_freq"] = 20;
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}

TEST_F(AclJsonNanoStest, AclJsonDvppFreq)
{
    // dvpp_freq: 20. not support
    nlohmann::json data;
    data["output"] = NANO_OUTPUT_DIR;
    data["dvpp_freq"] = 20;
    std::vector<std::string> dataList = {""};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}
// end::不支持的参数