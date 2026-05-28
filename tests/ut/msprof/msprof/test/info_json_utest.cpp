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
    }
};

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

TEST_F(INFO_JSON_TEST, SetPidInfo) {
    GlobalMockObject::verify();

    SHARED_PTR_ALIA<InfoMain> infoMain = nullptr;
    MSVP_MAKE_SHARED0(infoMain, InfoMain, return);

    InfoJson infoJson(jobInfo, devices, hostpid);

    int32_t invalidPid = -1;
    int32_t validPid = 1; // system pid

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