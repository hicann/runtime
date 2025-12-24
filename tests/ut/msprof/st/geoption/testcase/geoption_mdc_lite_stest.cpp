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
#include "devprof_drv_aicpu.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

static const char MDCLITE_RM_RF[] = "rm -rf ./geoptionMdcLitestest_workspace";
static const char MDCLITE_MKDIR[] = "mkdir ./geoptionMdcLitestest_workspace";
static const char MDCLITE_OUTPUT_DIR[] = "./geoptionMdcLitestest_workspace/output";

class GeOptionMdcLiteStest: public testing::Test {
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
        DevprofDrvAicpu::instance()->isRegister_ = false;   // 重置aicpu注册状态，使单进程内能多次注册
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_MDC_LITE));
        system(MDCLITE_RM_RF);
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

TEST_F(GeOptionMdcLiteStest, GeOptionDefault)
{
    // mdc: TaskTime
    NanoJson::Json data;
    data["output"] = MDCLITE_OUTPUT_DIR;
    std::vector<std::string> deviceDataList = {"hwts.data", "ts_track.data", "aicore.data"};
    MsprofMgr().SetDeviceCheckList(deviceDataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().GeOptionStart(0, data));
}