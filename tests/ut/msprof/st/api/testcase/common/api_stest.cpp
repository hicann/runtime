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
#include "../stub/aoe_stub.h"
#include "data_manager.h"
#include "acl_prof.h"
#include "aicpu_report_hdc.h"
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

class ApiTest: public testing::Test {
protected:
    int32_t deviceNum;
    uint32_t devId;
    std::string aclProfPath;
    virtual void SetUp()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));

        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init(SOC_TYPE, curTest->name());
        aclProfPath = "api_test_" SOC_TYPE "_output";
        deviceNum = 1;
        devId = 0;
        EXPECT_EQ(deviceNum, SimulatorMgr().CreateDeviceSimulator(deviceNum, static_cast<StPlatformType>(PLATFORM_TYPE)));
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
    }
    virtual void TearDown()
    {
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(deviceNum, SimulatorMgr().DelDeviceSimulator(deviceNum, static_cast<StPlatformType>(PLATFORM_TYPE)));
        DataMgr().UnInit();
        std::string cmd = "rm -rf "  + aclProfPath;
        system(cmd.c_str());
        GlobalMockObject::verify();
    }
};

TEST_F(ApiTest, AclApiTest)
{
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = 0;

    auto ret = RunInferWithApi(aclProfPath, devId, aicoreMetrics, aicoreEvents, dataTypeConfig);

    EXPECT_EQ(ret, ACL_ERROR_NONE);
    // todo: check file under aclProfPath
}

TEST_F(ApiTest, AclApiTestError)
{
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents *aicoreEvents = nullptr;
    uint64_t dataTypeConfig = 0;

    aclInit(nullptr);
    aclrtSetDevice(devId);
    auto ret = aclprofInit(aclProfPath.c_str(), aclProfPath.size());
    uint32_t deviceIdList[1] = {devId};
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);

    aclprofConfigType configType = ACL_PROF_SYS_HARDWARE_MEM_FREQ;
    std::string setConfig("50");
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size() + 1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    std::string longSetconfig(266, 't');
    ret = aclprofSetConfig(configType, longSetconfig.c_str(), longSetconfig.size());
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    std::string errorSetConfig("error_test");
    aclprofSetConfig(configType, errorSetConfig.c_str(), errorSetConfig.size());
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ret);

    configType = ACL_PROF_ARGS_MIN;
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    configType = ACL_PROF_STORAGE_LIMIT;
    ret = aclprofSetConfig(configType, setConfig.c_str(), setConfig.size());
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PROFILING_CONFIG);

    aclprofDestroyConfig(config);
    aclprofFinalize();
    aclFinalize();
}