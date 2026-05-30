/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "info_json.h"
#include <cstdio>
#include <fstream>
#include "ai_drv_dev_api.h"
#include "ai_drv_dsmi_api.h"
#include "config/config.h"
#include "config_manager.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "prof_manager.h"
#include "securec.h"
#include "utils/utils.h"
#include "platform/platform.h"
#include "task_relationship_mgr.h"
#include "json/json.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::host;
using namespace Dvvp::Collect::Platform;

const int TEST_HOST_PID = 1;

class INFO_JSON_TEST: public testing::Test {
public:
    std::string jobInfo;
    std::string devices;
    int hostpid;
protected:
    virtual void SetUp() {
        GlobalMockObject::verify();
        jobInfo = "";
        devices = "0";
        hostpid = TEST_HOST_PID;
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

#ifndef BUILD_OPEN_PROJECT
TEST_F(INFO_JSON_TEST, GetHwtsFreq) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_CLOUD_V3));
    InfoJson infoJson("1", "0", 1);
    std::string freq = "1005";
    EXPECT_EQ("1000", infoJson.GetHwtsFreq(freq));
    freq = "1000.1";
    EXPECT_EQ("1000.1", infoJson.GetHwtsFreq(freq));
}
#endif

TEST_F(INFO_JSON_TEST, GetHwtsFreq_NotCloudV3) {
    // else branch when platform is not CHIP_CLOUD_V3 -> input returned as-is
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    InfoJson infoJson("1", "0", 1);
    std::string freq = "9999";
    EXPECT_EQ("9999", infoJson.GetHwtsFreq(freq));
}

TEST_F(INFO_JSON_TEST, SetPidInfo) {
    GlobalMockObject::verify();

    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);

    InfoJson infoJson(jobInfo, devices, hostpid);

    int32_t invalidPid = -1;
    int32_t validPid = 1;

    infoJson.SetPidInfo(infoMain, invalidPid);
    EXPECT_EQ("NA", infoMain->pidName);
    EXPECT_EQ("NA", infoMain->pid);

    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(static_cast<long>(MSVP_LARGE_FILE_MAX_LEN + 1)))
        .then(returnValue(static_cast<long>(MSVP_LARGE_FILE_MAX_LEN)));

    infoJson.SetPidInfo(infoMain, validPid);
    EXPECT_EQ("NA", infoMain->pidName);
    EXPECT_EQ("1", infoMain->pid);

    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(static_cast<long>(100)));

    infoJson.SetPidInfo(infoMain, validPid);
    EXPECT_NE("NA", infoMain->pidName);
    EXPECT_EQ("1", infoMain->pid);
}

TEST_F(INFO_JSON_TEST, SetCannVersionWillNotSetVersionWhenAscendHomePathIsNotSet) {
    GlobalMockObject::verify();

    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);

    std::string emptyAscendHome = "";
    InfoJson infoJson(jobInfo, devices, hostpid);

    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(emptyAscendHome));

    infoJson.SetCannVersion(infoMain);
    EXPECT_EQ("", infoMain->cannVersion);
}

TEST_F(INFO_JSON_TEST, SetCannVersionWillNotSetVersionWhenAscendHomePathIsInvalid) {
    GlobalMockObject::verify();

    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);

    std::string invalidAscendHome = "/////";
    InfoJson infoJson(jobInfo, devices, hostpid);

    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(invalidAscendHome));

    infoJson.SetCannVersion(infoMain);
    EXPECT_EQ("", infoMain->cannVersion);
}

TEST_F(INFO_JSON_TEST, SetCannVersionWillNotSetVersionWhenVersionFileIsNotAccessible) {
    GlobalMockObject::verify();

    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);

    std::string utAscendHome = "./info_ut";
    std::string versionFile = utAscendHome + "/share/info/runtime/version.info";
    Utils::RemoveDir(utAscendHome);
    InfoJson infoJson(jobInfo, devices, hostpid);

    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(utAscendHome));

    infoJson.SetCannVersion(infoMain);
    EXPECT_EQ("", infoMain->cannVersion);
    Utils::RemoveDir(utAscendHome);
}

TEST_F(INFO_JSON_TEST, SetCannVersionWillNotSetVersionWhenVersionFileContentIsInvalid) {
    GlobalMockObject::verify();

    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);

    std::string utAscendHome = "./info_ut";
    std::string versionFile = utAscendHome + "/share/info/runtime/version.info";
    Utils::RemoveDir(utAscendHome);
    Utils::CreateDir(utAscendHome + "/share/info/runtime");
    std::ofstream invalidFile(versionFile);
    invalidFile << "invalid_version_content" << std::endl;
    invalidFile.close();

    InfoJson infoJson(jobInfo, devices, hostpid);

    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(utAscendHome));

    infoJson.SetCannVersion(infoMain);
    EXPECT_EQ("", infoMain->cannVersion);

    invalidFile.open(versionFile, std::ios::trunc);
    invalidFile << "Version=\n" << std::endl;
    invalidFile.close();
    infoJson.SetCannVersion(infoMain);
    EXPECT_EQ("", infoMain->cannVersion);

    invalidFile.open(versionFile, std::ios::trunc);
    invalidFile << "Version=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" << std::endl;
    invalidFile.close();
    infoJson.SetCannVersion(infoMain);
    EXPECT_EQ("", infoMain->cannVersion);

    remove(versionFile.c_str());
    Utils::RemoveDir(utAscendHome);
}

TEST_F(INFO_JSON_TEST, SetCannVersionWillSetVersionWhenVersionFileContentIsValid) {
    GlobalMockObject::verify();

    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);

    std::string utAscendHome = "./info_ut";
    std::string versionFile = utAscendHome + "/share/info/runtime/version.info";
    Utils::RemoveDir(utAscendHome);
    Utils::CreateDir(utAscendHome + "/share/info/runtime");
    std::ofstream validFile(versionFile);
    validFile << "Version=9.1.0" << std::endl;
    validFile.close();

    InfoJson infoJson(jobInfo, devices, hostpid);

    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(utAscendHome));

    infoJson.SetCannVersion(infoMain);
    EXPECT_EQ("9.1.0", infoMain->cannVersion);

    validFile.open(versionFile, std::ios::trunc);
    validFile << "Version=9.1.0\nVersion=9.2.0" << std::endl;
    validFile.close();
    infoJson.SetCannVersion(infoMain);
    EXPECT_EQ("9.1.0", infoMain->cannVersion);

    remove(versionFile.c_str());
    Utils::RemoveDir(utAscendHome);
}
TEST_F(INFO_JSON_TEST, EncodeInfoMainJson_Null) {
    InfoJson infoJson(jobInfo, devices, hostpid);
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    EXPECT_EQ("", infoJson.EncodeInfoMainJson(infoMain));
}

TEST_F(INFO_JSON_TEST, EncodeInfoMainJson_Filled) {
    InfoJson infoJson(jobInfo, devices, hostpid);
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    // populate at least one each of deviceInfos / netCardInfos / infoCpus
    infoMain->deviceInfos.push_back({1, 0, 4, 1, 4, 4, 4, 0, 0, 0, 4, "ARMv8", "0,1,2,3", "0,1,2,3", "1000", "1500",
        "1500"});
    infoMain->netCardInfos.push_back({"eth0", 100});
    InfoCpu cpu{0, "ARM", "1.5GHz", "8", "armv8"};
    infoMain->infoCpus.push_back(cpu);
    infoMain->memoryTotal = 1024;
    infoMain->cpuNums = 8;
    infoMain->sysClockFreq = 100;
    infoMain->cpuCores = 8;
    infoMain->netCardNums = 1;
    infoMain->rankId = 0;
    infoMain->drvVersion = 0x10000;
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    std::string out = infoJson.EncodeInfoMainJson(infoMain);
    EXPECT_FALSE(out.empty());
}

TEST_F(INFO_JSON_TEST, InitDeviceIds_Branches) {
    // valid: covers normal push_back
    InfoJson infoJson1("", "0,1", 1);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson1.InitDeviceIds());

    // invalid range: > MSVP_MAX_DEV_NUM -> continue
    InfoJson infoJson2("", "9999", 1);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson2.InitDeviceIds());

    // negative number -> continue
    InfoJson infoJson3("", "-1", 1);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson3.InitDeviceIds());

    // empty string handled
    InfoJson infoJson4("", "", 1);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson4.InitDeviceIds());

    // unparseable -> stoi throws -> catch -> PROFILING_FAILED
    InfoJson infoJson5("", "abc", 1);
    EXPECT_EQ(PROFILING_FAILED, infoJson5.InitDeviceIds());
}

TEST_F(INFO_JSON_TEST, GetRankId_Branches) {
    // All-digit env var -> stoi returns
    setenv("RANK_ID", "5", 1);
    InfoJson infoJson("", "0", 1);
    EXPECT_EQ(5, infoJson.GetRankId());

    // Non-digit -> -1
    setenv("RANK_ID", "abc", 1);
    EXPECT_EQ(-1, infoJson.GetRankId());

    // Empty -> -1
    unsetenv("RANK_ID");
    EXPECT_EQ(-1, infoJson.GetRankId());

    // SetRankId wrapper
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    setenv("RANK_ID", "7", 1);
    infoJson.SetRankId(infoMain);
    EXPECT_EQ(7, infoMain->rankId);
    unsetenv("RANK_ID");
}

TEST_F(INFO_JSON_TEST, SetVersionInfo_And_PlatformVersion_And_DrvVersion) {
    InfoJson infoJson("", "0", 1);
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    infoJson.SetVersionInfo(infoMain);
    EXPECT_FALSE(infoMain->version.empty());

    infoJson.SetPlatFormVersion(infoMain);
    // Just exercise the call - ChipIdStr may be empty in stub env

    MOCKER_CPP(&Platform::DrvGetApiVersion)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(0x12345)));
    infoJson.SetDrvVersion(infoMain);
    EXPECT_EQ(0x12345u, infoMain->drvVersion);
}

TEST_F(INFO_JSON_TEST, GetHostOscFrequency_And_GetDeviceOscFrequency) {
    InfoJson infoJson("", "0", 1);
    MOCKER_CPP(&Platform::PlatformGetHostOscFreq)
        .stubs()
        .will(returnValue(std::string("12345")));
    EXPECT_EQ("12345", infoJson.GetHostOscFrequency());

    MOCKER_CPP(&Platform::PlatformGetDeviceOscFreq)
        .stubs()
        .will(returnValue(std::string("67890")));
    EXPECT_EQ("67890", infoJson.GetDeviceOscFrequency(0u, "1000"));
}

// Stubs for driver Drv* functions
namespace info_json_stub {
int32_t Ok(uint32_t, int64_t &out) { out = 0; return PROFILING_SUCCESS; }
int32_t Fail(uint32_t, int64_t &) { return PROFILING_FAILED; }
int32_t OkOne(uint32_t, int64_t &out) { out = 1; return PROFILING_SUCCESS; }
int32_t OkA55(uint32_t, int64_t &out) { out = 0x41d05; return PROFILING_SUCCESS; }
}

TEST_F(INFO_JSON_TEST, GetCtrlCpuInfo_Branches) {
    InfoJson infoJson("", "0", 1);
    DeviceInfo devInfo;

    // First Drv fails
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetCtrlCpuInfo(0, devInfo));
    GlobalMockObject::verify();

    // First ok, second fails
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetCtrlCpuInfo(0, devInfo));
    GlobalMockObject::verify();

    // First ok, second ok, third fails
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle)
        .stubs()
        .will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetCtrlCpuInfo(0, devInfo));
    GlobalMockObject::verify();

    // All ok
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.GetCtrlCpuInfo(0, devInfo));
}

TEST_F(INFO_JSON_TEST, GetDevInfo_AllSuccess_AndFailureBranches) {
    InfoJson infoJson("", "0", 1);
    DeviceInfo devInfo;

    // 1. EnvType fails
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType)
        .stubs()
        .will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(0, devInfo));
    GlobalMockObject::verify();

    // 2. CtrlCpuInfo failed (CtrlCpuId fail)
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(0, devInfo));
    GlobalMockObject::verify();

    // 3. AiCpuCoreNum fail
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(0, devInfo));
    GlobalMockObject::verify();

    // 4. AivNum fail
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum)
        .stubs()
        .will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(0, devInfo));
    GlobalMockObject::verify();
}

TEST_F(INFO_JSON_TEST, GetDevInfo_AiCpuCoreId_Branch) {
    InfoJson infoJson("", "0", 1);
    DeviceInfo devInfo;

    // aiCpuCoreNum != 0 -> DrvGetAiCpuCoreId called -> fail
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::OkOne));  // -> aiCpuCoreNum = 1 (nonzero)
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreId)
        .stubs()
        .will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(0, devInfo));
    GlobalMockObject::verify();

    // AiCpuOccupyBitmap fail (aiCpuCoreNum=0 path skips AiCpuCoreId)
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));  // 0 -> skip CoreId
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum)
        .stubs()
        .will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap)
        .stubs()
        .will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(0, devInfo));
}

TEST_F(INFO_JSON_TEST, GetDevInfo_TsCore_AiCoreId_AiCoreNum_Branches) {
    InfoJson infoJson("", "0", 1);
    DeviceInfo devInfo;

    // TsCpuCoreNum fail
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetTsCpuCoreNum).stubs().will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(0, devInfo));
    GlobalMockObject::verify();

    // AiCoreId fail
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetTsCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreId).stubs().will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(0, devInfo));
    GlobalMockObject::verify();

    // AiCoreNum fail
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetTsCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreId).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreNum).stubs().will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.GetDevInfo(0, devInfo));
    GlobalMockObject::verify();

    // All ok
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetTsCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreId).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreNum).stubs().will(invoke(info_json_stub::Ok));
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.GetDevInfo(0, devInfo));
}

TEST_F(INFO_JSON_TEST, AddDeviceInfo_Branches) {
    // Run with valid devices_, hostIds_/devIds_ set up via InitDeviceIds.
    InfoJson infoJson("", "0", 1);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.InitDeviceIds());
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    // Stub all Drv* with success so GetDevInfo passes
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId)
        .stubs()
        .will(invoke(info_json_stub::OkOne));  // ctrlCpuId=1 -> not in cpuTypes map (else branch ctrlCpuId="")
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetTsCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreId).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&Analysis::Dvvp::Driver::DrvGeAicFrq)
        .stubs()
        .will(returnValue(std::string("1500")));
    MOCKER_CPP(&Platform::PlatformGetDeviceOscFreq)
        .stubs()
        .will(returnValue(std::string("100")));
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.AddDeviceInfo(infoMain));
}

TEST_F(INFO_JSON_TEST, AddDeviceInfo_GetDevInfoFailed) {
    InfoJson infoJson("", "0", 1);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.InitDeviceIds());
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType).stubs().will(invoke(info_json_stub::Fail));
    EXPECT_EQ(PROFILING_FAILED, infoJson.AddDeviceInfo(infoMain));
}

TEST_F(INFO_JSON_TEST, AddDeviceInfo_CpuTypeMatchesMap) {
    InfoJson infoJson("", "0", 1);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.InitDeviceIds());
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuId).stubs().will(invoke(info_json_stub::OkA55));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAivNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetTsCpuCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreId).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetAiCoreNum).stubs().will(invoke(info_json_stub::Ok));
    MOCKER_CPP(&Analysis::Dvvp::Driver::DrvGeAicFrq).stubs().will(returnValue(std::string("1500")));
    MOCKER_CPP(&Platform::PlatformGetDeviceOscFreq).stubs().will(returnValue(std::string("100")));
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.AddDeviceInfo(infoMain));
    EXPECT_FALSE(infoMain->deviceInfos.empty());
    EXPECT_EQ("ARMv8_Cortex_A55", infoMain->deviceInfos[0].ctrlCpuId);
}

TEST_F(INFO_JSON_TEST, AddOtherInfo_EmptyJobInfo) {
    InfoJson infoJson("", "0", 1);
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.AddOtherInfo(infoMain));
    EXPECT_EQ("NA", infoMain->jobInfo);
}

TEST_F(INFO_JSON_TEST, AddOtherInfo_NonEmptyJobInfo) {
    InfoJson infoJson("myJob", "0", 1);
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    EXPECT_EQ(PROFILING_SUCCESS, infoJson.AddOtherInfo(infoMain));
    EXPECT_EQ("myJob", infoMain->jobInfo);
}

TEST_F(INFO_JSON_TEST, AddSysConf_AddSysTime_AddMemTotal) {
    InfoJson infoJson("", "0", 1);
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    // Just exercise without stubbing - relies on /proc on Linux
    infoJson.AddSysConf(infoMain);

    // SysTime: getfilesize too large -> early return
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(static_cast<long>(MSVP_LARGE_FILE_MAX_LEN + 1)));
    infoJson.AddSysTime(infoMain);
    infoJson.AddMemTotal(infoMain);
    GlobalMockObject::verify();

    // size negative -> early return
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(static_cast<long>(-1)));
    infoJson.AddSysTime(infoMain);
    infoJson.AddMemTotal(infoMain);
}

TEST_F(INFO_JSON_TEST, AddNetCardInfo_NoCards) {
    InfoJson infoJson("", "0", 1);
    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);
    // Just exercise without stubbing - usually no /sys/class/net cards in unit env or yields some entries
    infoJson.AddNetCardInfo(infoMain);
}

TEST_F(INFO_JSON_TEST, Generate_InitDevicesFail) {
    InfoJson infoJson("", "abc", 1);  // unparseable -> InitDeviceIds fail
    std::string content;
    EXPECT_EQ(PROFILING_FAILED, infoJson.Generate(content));
}

TEST_F(INFO_JSON_TEST, Generate_AddHostInfoFail) {
    InfoJson infoJson("", "0", 1);
    // Force AddHostInfo to return PROFILING_FAILED via OsalGetCpuInfo failure
    auto stubFail = [](OsalCpuDesc **, int32_t *) -> int32_t { return -1; };
    MOCKER_CPP(&OsalGetCpuInfo).stubs().will(invoke(static_cast<int32_t(*)(OsalCpuDesc**, int32_t*)>(stubFail)));
    std::string content;
    EXPECT_EQ(PROFILING_FAILED, infoJson.Generate(content));
}

TEST_F(INFO_JSON_TEST, Generate_AddDeviceInfoFail) {
    InfoJson infoJson("", "0", 1);
    // Make AddHostInfo succeed (single fake cpu)
    static OsalCpuDesc fakeCpu;
    (void)memset_s(&fakeCpu, sizeof(fakeCpu), 0, sizeof(fakeCpu));
    auto cpuStub = [](OsalCpuDesc **info, int32_t *count) -> int32_t {
        *info = &fakeCpu;
        *count = 1;
        return OSAL_EN_OK;
    };
    auto cpuFreeStub = [](OsalCpuDesc *, int32_t) -> int32_t { return OSAL_EN_OK; };
    MOCKER_CPP(&OsalGetCpuInfo).stubs().will(invoke(static_cast<int32_t(*)(OsalCpuDesc**, int32_t*)>(cpuStub)));
    MOCKER_CPP(&OsalCpuInfoFree).stubs().will(invoke(static_cast<int32_t(*)(OsalCpuDesc*, int32_t)>(cpuFreeStub)));
    // Make AddDeviceInfo fail
    MOCKER_CPP(&analysis::dvvp::driver::DrvGetEnvType).stubs().will(invoke(info_json_stub::Fail));
    std::string content;
    EXPECT_EQ(PROFILING_FAILED, infoJson.Generate(content));
}
