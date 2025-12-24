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
#include "prof_api.h"
#include "data_manager.h"
#include "acl/acl.h"
#include "acl_prof.h"
#include "prof_acl_api.h"
#include "runtime/stream.h"
#include "ge/ge_prof.h"
#include "aicpu_report_hdc.h"
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;
using namespace ge;

class ApiTest: public testing::Test {

protected:
    int32_t deviceNum;
    virtual void SetUp()
    {
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init(SOC_TYPE, curTest->name());
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        deviceNum = 2;
        EXPECT_EQ(deviceNum, SimulatorMgr().CreateDeviceSimulator(deviceNum, static_cast<StPlatformType>(PLATFORM_TYPE)));
    }
    virtual void TearDown()
    {
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(deviceNum, SimulatorMgr().DelDeviceSimulator(deviceNum, static_cast<StPlatformType>(PLATFORM_TYPE)));
        DataMgr().UnInit();
        GlobalMockObject::verify();
    }
};

TEST_F(ApiTest, ReportDataBeforeInit)
{
    MsprofApi api;
    EXPECT_EQ(MsprofReportApi(0, &api), MSPROF_ERROR_UNINITIALIZE);
    MsprofEvent event;
    EXPECT_EQ(MsprofReportEvent(0, &event), MSPROF_ERROR_UNINITIALIZE);
    MsprofCompactInfo compactInfo;
    EXPECT_EQ(MsprofReportCompactInfo(0, &compactInfo, sizeof(compactInfo)), MSPROF_ERROR_UNINITIALIZE);
    MsprofAdditionalInfo additionalInfo;
    EXPECT_EQ(MsprofReportAdditionalInfo(0, &additionalInfo, sizeof(additionalInfo)), MSPROF_ERROR_UNINITIALIZE);
}

TEST_F(ApiTest, SubscribeModelNotLoaded)
{
    EXPECT_EQ(aclInit(nullptr), 0);
    int8_t opTimeSwitch = 1;
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_NONE;
    uint32_t fd = 1;
    auto *config = aclprofCreateSubscribeConfig(opTimeSwitch, aicoreMetrics, reinterpret_cast<void *>(&fd));
    EXPECT_NE(config, nullptr);

    uint32_t modelId = 1;
    auto ret = aclprofModelSubscribe(modelId, config);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_MODEL_ID);

    EXPECT_EQ(aclprofDestroySubscribeConfig(config), ACL_ERROR_NONE);
    aclFinalize();
}

TEST_F(ApiTest, UnsubscribeModelNotLoaded)
{
    EXPECT_EQ(aclInit(nullptr), 0);
    uint32_t modelId = 1;
    auto ret = aclprofModelUnSubscribe(modelId);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_MODEL_ID);
    aclFinalize();
}

TEST_F(ApiTest, UnsubscribeModelNotSubscribed)
{
    EXPECT_EQ(aclInit(nullptr), 0);
    uint32_t modelId = 1;
    auto err = aclmdlLoadFromFile(nullptr, &modelId);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlLoadFromFile failed");
    }
    auto ret = aclprofModelUnSubscribe(modelId);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_MODEL_ID);
    aclFinalize();
}

TEST_F(ApiTest, TestAclUnmatchedDataConfig)
{
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    aclInit(nullptr);
    uint32_t devId = 0;
    aclrtSetDevice(devId);
    std::string aclProfPath = "api_test_output";
    EXPECT_EQ(aclprofInit(aclProfPath.c_str(), aclProfPath.size()), ACL_ERROR_NONE);
    uint32_t deviceIdList[1] = {devId};
    uint64_t dataTypeConfig = ACL_PROF_ACL_API;
    auto config1 = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(config1, nullptr);
    EXPECT_EQ(aclprofStart(config1), ACL_ERROR_NONE);
    dataTypeConfig = 0;
    auto config2 = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(config2, nullptr);
    EXPECT_EQ(aclprofStop(config2), ACL_ERROR_INVALID_PROFILING_CONFIG);
    EXPECT_EQ(aclprofDestroyConfig(config1), ACL_ERROR_NONE);
    EXPECT_EQ(aclprofDestroyConfig(config2), ACL_ERROR_NONE);
    EXPECT_EQ(aclprofFinalize(), ACL_ERROR_NONE);
    aclFinalize();
}

TEST_F(ApiTest, TestAclGraphUnmatchedDataConfig)
{
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    aclInit(nullptr);
    uint32_t devId = 0;
    aclrtSetDevice(devId);
    std::string aclProfPath = "api_test_output";
    EXPECT_EQ(aclprofInit(aclProfPath.c_str(), aclProfPath.size()), ACL_ERROR_NONE);
    uint32_t deviceIdList[1] = {devId};
    uint64_t dataTypeConfig = ACL_PROF_ACL_API;
    auto config1 = aclgrphProfCreateConfig(deviceIdList, 1, (ge::ProfilingAicoreMetrics)aicoreMetrics, nullptr, dataTypeConfig);
    EXPECT_NE(config1, nullptr);
    uint32_t graphId = 0;
    EXPECT_EQ(aclgrphProfStart(config1), ACL_ERROR_NONE);
    dataTypeConfig = 0;
    auto config2 = aclgrphProfCreateConfig(deviceIdList, 1, (ge::ProfilingAicoreMetrics)aicoreMetrics, nullptr, dataTypeConfig);
    EXPECT_NE(config2, nullptr);
    EXPECT_EQ(aclgrphProfStop(config2), ge::FAILED);
    EXPECT_EQ(aclgrphProfDestroyConfig(config1), ACL_ERROR_NONE);
    EXPECT_EQ(aclgrphProfDestroyConfig(config2), ACL_ERROR_NONE);
    EXPECT_EQ(aclprofFinalize(), ACL_ERROR_NONE);
    aclFinalize();
}

TEST_F(ApiTest, TestUnmatchedDataConfig)
{
    int32_t fd[2] = {-1, -1};
    pipe2(fd, O_CLOEXEC);
    int8_t opTimeSwitch = 1;
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_NONE;

    aclprofSubscribeConfig *profSubscribeConfig = aclprofCreateSubscribeConfig(opTimeSwitch, aicoreMetrics, reinterpret_cast<void *>(&fd[0]));
    EXPECT_NE(profSubscribeConfig, nullptr);
    uint32_t modelId1 = 0;
    DataMgr().SetModelId(0);
    auto err = aclmdlLoadFromFile(nullptr, &modelId1);
    EXPECT_EQ(err, ACL_ERROR_NONE);
    err = aclprofModelSubscribe(modelId1, profSubscribeConfig);
    EXPECT_EQ(err, ACL_ERROR_NONE);
    err = aclprofDestroySubscribeConfig(profSubscribeConfig);
    EXPECT_EQ(err, ACL_ERROR_NONE);

    aicoreMetrics = ACL_AICORE_PIPE_UTILIZATION;
    profSubscribeConfig = aclprofCreateSubscribeConfig(opTimeSwitch, aicoreMetrics, reinterpret_cast<void *>(&fd[1]));
    EXPECT_NE(profSubscribeConfig, nullptr);
    uint32_t modelId2 = 1;
    DataMgr().SetModelId(1);
    err = aclmdlLoadFromFile(nullptr, &modelId2);
    EXPECT_EQ(err, ACL_ERROR_NONE);
    err = aclprofModelSubscribe(modelId2, profSubscribeConfig);
    EXPECT_EQ(err, ACL_ERROR_INVALID_PROFILING_CONFIG);
    err = aclprofDestroySubscribeConfig(profSubscribeConfig);
    EXPECT_EQ(err, ACL_ERROR_NONE);

    err = aclprofModelUnSubscribe(modelId1);
    EXPECT_EQ(err, ACL_ERROR_NONE);
    err = aclmdlUnload(modelId1);
    EXPECT_EQ(err, ACL_ERROR_NONE);
    err = aclmdlUnload(modelId2);
    EXPECT_EQ(err, ACL_ERROR_NONE);
}


