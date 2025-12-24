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

static const char MDCMINIV3_RM_RF[] = "rm -rf ./acljsonMdcMiniV3stest_workspace";
static const char MDCMINIV3_MKDIR[] = "mkdir ./acljsonMdcMiniV3stest_workspace";
static const char MDCMINIV3_OUTPUT_DIR[] = "./acljsonMdcMiniV3stest_workspace/output";

class AclJsonMdcMiniV3Stest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        DataMgr().Init("", "acljson");
        optind = 1;
        system(MDCMINIV3_MKDIR);
        MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(-1));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_MDC_MINI_V3));
        SimulatorMgr().SetSocSide(SocType::DEVICE);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_MDC_MINI_V3));
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        system(MDCMINIV3_RM_RF);
    }
    void DlStub()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
};

TEST_F(AclJsonMdcMiniV3Stest, AclJsonDefault)
{
    // mdc_mini_v3: TaskTime
    nlohmann::json data;
    data["output"] = MDCMINIV3_OUTPUT_DIR;
    std::vector<std::string> dataList = {"ffts_profile.data", "ts_track.data", "stars_soc.data", "stars_soc_profile.data"};
    MsprofMgr().SetDeviceCheckList(dataList);
    std::vector<std::string> hostDataList = {
        "unaging.api_event.data", "unaging.compact.node_basic_info", "unaging.compact.task_track", "unaging.additional.context_id_info"
    };
    MsprofMgr().SetHostCheckList(hostDataList);
    std::vector<uint64_t> bitList = {PROF_ACL_API, PROF_TASK_TIME_L1, PROF_AICORE_METRICS};
    MsprofMgr().SetBitSwitchCheckList(bitList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AclJsonStart(0, data));
}

TEST_F(AclJsonMdcMiniV3Stest, AclJsonAicpu)
{
    // mdc_mini_v3: aicpu
    nlohmann::json data;
    data["output"] = MDCMINIV3_OUTPUT_DIR;
    data["aicpu"] = "on";
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AclJsonStart(1, data));
}
