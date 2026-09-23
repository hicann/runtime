/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdlib>
#include <string>
#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "data_manager.h"
#include "errno/error_code.h"
#include "device_simulator_manager.h"
#include "acl_api_stub.h"
#include "aicpu_report_hdc.h"
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

namespace {
constexpr uint32_t RC_V2_API_DEVICE_NUM = 2;
constexpr int32_t RC_V2_PROF_DIR_SUFFIX_BASE = 1;
constexpr int32_t RC_V2_PROF_DIR_SUFFIX_RANGE = 100;
const char RC_V2_NTS_PIPE_UTILIZATION[] = "PipeUtilization";
const char RC_V2_NTS_INVALID_METRIC[] = "NotExistsMetrics";
} // namespace

class AclApiRcV2Stest : public testing::Test {
protected:
    void SetUp() override
    {
        StubDlFuncs();
        DataMgr().Init("", "acljson");
        deviceId_ = 0;
        int32_t suffix = std::rand() % RC_V2_PROF_DIR_SUFFIX_RANGE + RC_V2_PROF_DIR_SUFFIX_BASE;
        profDir_ = "api_test_rc_v2_output" + std::to_string(suffix);
        mkdir(profDir_.c_str(), 0750);
        EXPECT_EQ(
            RC_V2_API_DEVICE_NUM,
            SimulatorMgr().CreateDeviceSimulator(RC_V2_API_DEVICE_NUM, StPlatformType::RC_V2_TYPE));
        SimulatorMgr().SetSocSide(SocType::HOST);
        ClearApiSingleton();
        aclInit(nullptr);
        aclrtSetDevice(0);
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(ACL_ERROR_NONE, aclprofInit(profDir_.c_str(), profDir_.size()));
    }

    void TearDown() override
    {
        DevprofDrvAicpu::instance()->isRegister_ = false;
        EXPECT_EQ(
            RC_V2_API_DEVICE_NUM, SimulatorMgr().DelDeviceSimulator(RC_V2_API_DEVICE_NUM, StPlatformType::RC_V2_TYPE));
        std::string removeCmd = "rm -rf " + profDir_;
        system(removeCmd.c_str());
        DataMgr().UnInit();
        GlobalMockObject::verify();
    }

    void StubDlFuncs()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }

    aclprofConfig* CreateRcV2Config(aclprofAicoreMetrics metrics, uint64_t dataTypeConfig)
    {
        uint32_t deviceIdList[1] = {deviceId_};
        return aclprofCreateConfig(deviceIdList, 1, metrics, nullptr, dataTypeConfig);
    }

    std::string profDir_;
    uint32_t deviceId_ = 0;
};

// 对应黄区问题一/问题三：ACL API方式下rc_v2应能正常start并产出PROF_*目录与基础数据
TEST_F(AclApiRcV2Stest, AclApiDefaultTaskTime)
{
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS;
    auto config = CreateRcV2Config(ACL_AICORE_PIPE_UTILIZATION, dataTypeConfig);
    ASSERT_NE(nullptr, config);

    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, dataTypeConfig));
    std::vector<std::string> deviceDataList = {
        "stars_soc.data", "stars_soc_profile.data", "ffts_profile.data", "ts_track.data"};
    std::vector<std::string> hostDataList = {};
    EXPECT_EQ(0, CheckFiles(profDir_, deviceDataList, hostDataList));
}

// PLATFORM_TASK_NTS：nts_metrics=PipeUtilization应被接受
TEST_F(AclApiRcV2Stest, AclApiSetNtsMetricsSuccess)
{
    std::string ntsConfig = RC_V2_NTS_PIPE_UTILIZATION;
    auto ret = aclprofSetConfig(ACL_PROF_NTS_METRICS, ntsConfig.c_str(), ntsConfig.size());
    EXPECT_EQ(ACL_SUCCESS, ret);

    auto config = CreateRcV2Config(ACL_AICORE_NONE, ACL_PROF_TASK_TIME);
    ASSERT_NE(nullptr, config);
    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, ACL_PROF_TASK_TIME));
}

// 非法nts_metrics取值必须失败，不能静默放行
TEST_F(AclApiRcV2Stest, AclApiSetNtsMetricsInvalid)
{
    std::string ntsConfig = RC_V2_NTS_INVALID_METRIC;
    auto ret = aclprofSetConfig(ACL_PROF_NTS_METRICS, ntsConfig.c_str(), ntsConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ret);
    aclprofFinalize();
    aclFinalize();
}

// 对应黄区 test_L2CacheIsOn_AclProf/test_NtsAclProf 失败：rc_v2 的 AICPU 采集特性必须放行 ACL_PROF_AICPU，
// 否则 CheckDataTypeSupport 会以 0x8 not support 拒绝整个通用 mask
TEST_F(AclApiRcV2Stest, AclApiAicpuTraceSupported)
{
    uint64_t dataTypeConfig = ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICPU;
    auto config = CreateRcV2Config(ACL_AICORE_NONE, dataTypeConfig);
    ASSERT_NE(nullptr, config);
    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, dataTypeConfig));

    // mask 不含 ACL_PROF_AICORE_METRICS，仅产出 stars_soc/ts_track 两路通道数据
    std::vector<std::string> deviceDataList = {"stars_soc.data", "ts_track.data"};
    std::vector<std::string> hostDataList = {};
    EXPECT_EQ(0, CheckFiles(profDir_, deviceDataList, hostDataList));
}
