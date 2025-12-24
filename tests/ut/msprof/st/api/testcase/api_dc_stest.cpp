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
#include "aicpu_report_hdc.h"
#include "devprof_drv_aicpu.h"

class ApiDcTest: public testing::Test {
protected:
    int32_t deviceNum;
    virtual void SetUp()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init(SOC_TYPE, curTest->name());
        deviceNum = 1;
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

TEST_F(ApiDcTest, SubscribeModelTest)
{
    std::set<RunnerOpInfo> modelOpInfo;
    DataMgr().SetModelId(4);
    EXPECT_TRUE(RunInfer(modelOpInfo, RunModel));
    EXPECT_EQ(DataMgr().CheckSubscribeResult(modelOpInfo), 0);
}

TEST_F(ApiDcTest, SubscribeOpTest)
{
    std::set<RunnerOpInfo> modelOpInfo;
    MOCKER(mmGetTid).stubs().will(returnValue(3));
    DataMgr().SetDataDir("subscribe_model_test"); // use same data with SubscribeModelTest
    DataMgr().SetModelId(4);
    EXPECT_TRUE(RunInfer(modelOpInfo, RunOp));
    EXPECT_EQ(DataMgr().CheckSubscribeResult(modelOpInfo, "thread_result.txt"), 0);
}

