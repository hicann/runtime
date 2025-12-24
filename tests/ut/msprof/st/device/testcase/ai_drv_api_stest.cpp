/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <dlfcn.h>
#include <map>
#include <errno.h>
#include <iostream>
#include <stdexcept>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "errno/error_code.h"
#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "config/config_manager.h"
#include "validation/param_validation.h"
#include "utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::utils;
#define CHANNEL_STR(s) #s

///////////////////////////////////////////////////////////////////
class DRIVER_AI_DRV_API_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(DRIVER_AI_DRV_API_TEST, DrvGetDeviceStatusTest) {
    GlobalMockObject::verify();

    drvStatus_t deviceStatus = DRV_STATUS_COMMUNICATION_LOST;

    MOCKER(drvDeviceStatus)
        .stubs()
        .with(any(), outBoundP(&deviceStatus))
        .will(returnValue(DRV_ERROR_NOT_SUPPORT))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(true, analysis::dvvp::driver::DrvGetDeviceStatus(0));
    EXPECT_EQ(false, analysis::dvvp::driver::DrvGetDeviceStatus(0));
    EXPECT_EQ(false, analysis::dvvp::driver::DrvGetDeviceStatus(0));
}

TEST_F(DRIVER_AI_DRV_API_TEST, DrvGetDevNumTest) {
    GlobalMockObject::verify();

    uint32_t num_dev = 0;

    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&num_dev))
        .will(returnValue(DRV_ERROR_NOT_SUPPORT))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetDevNum());
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetDevNum());
    EXPECT_EQ((int)num_dev, analysis::dvvp::driver::DrvGetDevNum());
}

TEST_F(DRIVER_AI_DRV_API_TEST, DrvFftsProfileStart) {
    GlobalMockObject::verify();

    analysis::dvvp::driver::AI_DRV_CHANNEL prof_channel = analysis::dvvp::driver::PROF_CHANNEL_FFTS_PROFILE_TASK;
    std::vector<int>  prof_cores;
    std::vector<std::string> prof_events;
    std::vector<int>  prof_aivCores;
    std::vector<std::string> prof_aivEvents;
    std::string prof_data_file_path = "/path/to/data";

    prof_cores.push_back(0);
    prof_events.push_back("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55");
    prof_aivCores.push_back(0);
    prof_aivEvents.push_back("0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55");
    analysis::dvvp::driver::DrvPeripheralProfileCfg drvPeripheralProfileCfg;
    drvPeripheralProfileCfg.profDeviceId = 0;
    drvPeripheralProfileCfg.profChannel = prof_channel;
    drvPeripheralProfileCfg.profSamplePeriod = 10;
    drvPeripheralProfileCfg.profSamplePeriodHi = 10;
    drvPeripheralProfileCfg.cfgMode = 1;
    drvPeripheralProfileCfg.aicMode = 1;
    drvPeripheralProfileCfg.aivMode = 1;

    StarsAccProfileConfigT *configP = static_cast<StarsAccProfileConfigT*>(
        Utils::ProfMalloc(sizeof(StarsAccProfileConfigT)));
    EXPECT_NE(configP, nullptr);
    if (configP == nullptr) {
        return;
    }
    configP->aicScale = 1;
    drvPeripheralProfileCfg.configP = configP;

    MOCKER(prof_drv_start)
        .stubs()
        .will(returnValue(PROF_ERROR))
        .then(returnValue(PROF_OK));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvFftsProfileStart(drvPeripheralProfileCfg,
                prof_cores, prof_events, prof_aivCores, prof_aivEvents));

    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvFftsProfileStart(drvPeripheralProfileCfg,
                prof_cores, prof_events, prof_aivCores, prof_aivEvents));
    void *configVoid = static_cast<void *>(configP);
    Utils::ProfFree(configVoid);
    EXPECT_EQ(configVoid, nullptr);
}

TEST_F(DRIVER_AI_DRV_API_TEST, DrvTsFwStart) {
    GlobalMockObject::verify();

    analysis::dvvp::driver::DrvPeripheralProfileCfg peripheralCfg;
    peripheralCfg.profDeviceId = 0;
    peripheralCfg.profChannel = analysis::dvvp::driver::PROF_CHANNEL_TS_FW;
    peripheralCfg.profSamplePeriod = 10;
    peripheralCfg.profDataFilePath = "/path/to/data";

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvTsFwStart(peripheralCfg, nullptr));

    auto profileParams = std::make_shared<analysis::dvvp::message::ProfileParams>();

    profileParams->ts_timeline = "on";
    profileParams->ts_task_track = "on";
    profileParams->ts_cpu_usage = "on";
    profileParams->ai_core_status = "on";
    profileParams->ai_vector_status = "on";
    profileParams->taskTsfw = "on";
    MOCKER(prof_drv_start)
        .stubs()
        .will(returnValue(PROF_ERROR))
        .then(returnValue(PROF_OK));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvTsFwStart(peripheralCfg, profileParams));

    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvTsFwStart(peripheralCfg, profileParams));
}