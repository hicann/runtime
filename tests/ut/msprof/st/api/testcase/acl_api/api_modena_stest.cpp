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

class AclApiModenaStest : public testing::Test {
protected:
    std::string aclProfPath;
    uint32_t devId;

    void SetUp() override
    {
        DlStub();
        DataMgr().Init("", "acljson");
        devId = 0;
        int32_t randomNumber = std::rand() % 100 + 1;
        aclProfPath = "api_test_modena_output" + std::to_string(randomNumber);
        mkdir(aclProfPath.c_str(), 0750);
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_5162A));
        SimulatorMgr().SetSocSide(SocType::HOST);
        ClearApiSingleton();
        aclInit(nullptr);
        aclrtSetDevice(0);
        EXPECT_EQ(ACL_ERROR_NONE, aclprofInit(aclProfPath.c_str(), aclProfPath.size()));
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
    }

    void TearDown() override
    {
        DevprofDrvAicpu::instance()->isRegister_ = false;
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_5162A));
        std::string removeCmd = "rm -rf " + aclProfPath;
        system(removeCmd.c_str());
        DataMgr().UnInit();
        GlobalMockObject::verify();
    }

    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(AclApiModenaStest, AclProfStartStopTaskTime)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_NONE;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_TASK_TIME;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, dataTypeConfig));
}

TEST_F(AclApiModenaStest, AclProfStartStopAicoreMetrics)
{
    uint32_t deviceIdList[1] = {devId};
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_PIPE_UTILIZATION;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS;
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    EXPECT_NE(nullptr, config);

    EXPECT_EQ(PROFILING_SUCCESS, AclApiStart(config, dataTypeConfig));
}
