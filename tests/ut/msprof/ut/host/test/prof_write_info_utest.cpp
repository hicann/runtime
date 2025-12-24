/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <fstream>
#include "errno/error_code.h"
#include "utils/utils.h"
#include "config/config_manager.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "info_json.h"
#include "mmpa_api.h"
#include "platform/platform.h"
#include "proto/profiler.pb.h"
#include "common-utils-stub.h"

using namespace analysis::dvvp::proto;
using namespace analysis::dvvp::host;
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

class INFO_JSON_TEST : public testing::Test {
protected:
    virtual void SetUp() {
        GlobalMockObject::verify();
        result_dir = (".");
        start_time = ("1539226807454372");
        end_time = ("1539226807454372");
        devices = ("0");
    }
    virtual void TearDown() {
    }
public:
    std::string result_dir;
    std::string start_time;
    std::string end_time;
    std::string devices;
};

TEST_F(INFO_JSON_TEST, InfoXml_init) {
    GlobalMockObject::verify();

    MOCKER_CPP(&InfoJson::AddHostInfo)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&InfoJson::AddDeviceInfo)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&InfoJson::AddOtherInfo)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    InfoJson infoJson(start_time, end_time, devices);
    std::string cont;

    // add host info failed
    EXPECT_EQ(PROFILING_FAILED, infoJson.Generate(cont));

    // add device info failed
    EXPECT_EQ(PROFILING_FAILED, infoJson.Generate(cont));

    // add other info failed
    EXPECT_EQ(PROFILING_FAILED, infoJson.Generate(cont));

    // save file failed
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.Generate(cont));

    // ok
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.Generate(cont));
}

TEST_F(INFO_JSON_TEST, AddHostInfo) {
    GlobalMockObject::verify();

    char info[128] = {0};
    MOCKER(mmGetOsVersion)
        .stubs()
        .with(outBoundP(info), any())
        .will(returnValue(0));

    MOCKER(mmGetOsName)
        .stubs()
        .with(outBoundP(info), any())
        .will(returnValue(0));

    INT32 cpu_num = 1;
    mmCpuDesc cpuInfo[1];
    mmCpuDesc *p_cpu_info = cpuInfo;
    cpuInfo[0].nthreads = 0;
    MOCKER(mmGetCpuInfo)
        .stubs()
        .with(outBoundP(&p_cpu_info), outBoundP(&cpu_num))
        .will(returnValue(0));

    MOCKER(mmCpuInfoFree)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    GlobalMockObject::verify();

    MOCKER(mmGetOsVersion)
        .stubs()
        .with(outBoundP(info), any())
        .will(returnValue(0));

    MOCKER(mmGetOsName)
        .stubs()
        .with(outBoundP(info), any())
        .will(returnValue(0));

    MOCKER(mmGetCpuInfo)
        .stubs()
        .with(outBoundP(&p_cpu_info), outBoundP(&cpu_num))
        .will(returnValue(0));

    MOCKER(mmCpuInfoFree)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    cpuInfo[0].nthreads = 1;

    InfoJson infoJson(start_time, end_time, devices);
    std::shared_ptr<InfoMain> infoMain = std::make_shared<InfoMain>();
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.AddHostInfo(infoMain));

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.AddHostInfo(infoMain));
}

TEST_F(INFO_JSON_TEST, AddDeviceInfo) {
    GlobalMockObject::verify();

    MOCKER_CPP(&InfoJson::GetDevInfo)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    InfoJson infoJson(start_time, end_time, devices);
    infoJson.InitDeviceIds();
    std::shared_ptr<InfoMain> infoMain = std::make_shared<InfoMain>();

    // failed to get dev info
    EXPECT_EQ(PROFILING_FAILED, infoJson.AddDeviceInfo(infoMain));

    // ok
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.AddDeviceInfo(infoMain));
}

TEST_F(INFO_JSON_TEST, AddOtherInfo) {
    GlobalMockObject::verify();
    InfoJson infoJson(start_time, end_time, devices);
    std::shared_ptr<InfoMain> infoMain = std::make_shared<InfoMain>();

    // failed to get mac, but only warn
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.AddOtherInfo(infoMain));
    EXPECT_EQ("1.0", infoMain->get_version());
}

TEST_F(INFO_JSON_TEST, SetPlatFormVersion) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_TYPE))
        .then(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CLOUD_TYPE))

    InfoJson infoJson(start_time, end_time, devices);
    std::shared_ptr<InfoMain> infoMain = std::make_shared<InfoMain>();

    infoJson.SetPlatFormVersion(infoMain);
    EXPECT_EQ(infoMain->SetPlatFormVersion, "0");
    infoJson.SetPlatFormVersion(infoMain);
    EXPECT_EQ(infoMain->SetPlatFormVersion, "1");
}

TEST_F(INFO_JSON_TEST, GetDevInfo) {
    GlobalMockObject::verify();

    int device_id = 0;
    analysis::dvvp::host::DeviceInfo dev_info;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(repeat(DRV_ERROR_NONE, 1))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(repeat(DRV_ERROR_NONE, 2))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(repeat(DRV_ERROR_NONE, 3))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(repeat(DRV_ERROR_NONE, 4))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(repeat(DRV_ERROR_NONE, 5))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(repeat(DRV_ERROR_NONE, 6))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(repeat(DRV_ERROR_NONE, 7))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(repeat(DRV_ERROR_NONE, 8))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(repeat(DRV_ERROR_NONE, 9))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    InfoJson infoJson(start_time, end_time, devices);

    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(device_id, dev_info));
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.GetDevInfo(device_id, dev_info));
}

