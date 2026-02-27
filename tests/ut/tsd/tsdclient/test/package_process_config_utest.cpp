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
#include <vector>
#include <unordered_set>
#include <pwd.h> 
#include "gtest/gtest.h" 
#include "mockcpp/mockcpp.hpp" 
#include "inc/package_worker_utils.h"
#define private public 
#define protected public 
#include "inc/package_process_config.h"
#undef private 
#undef protected

using namespace tsd;

class PackageProcessConfigTest : public testing::Test { 
protected: 
    virtual void SetUp() {} 


    virtual void TearDown() 
    { 
        GlobalMockObject::verify();
    } 
}; 
namespace {
bool WriteConfigFile(const std::string fileName, const std::vector<std::string> itemVec)
{
    std::ofstream outFile(fileName);
    if(!outFile) {
        std::cout<<"Can not creat file."<<std::endl;
        return false;
    }
    for(auto &item:itemVec) {
        outFile << item <<std::endl;
    }
    outFile.close();
    std::ifstream inFile(fileName);
    if(!inFile) {
        std::cout<<"Can not read file."<<std::endl;
        return false;
    }
    std::string line;
    while (getline(inFile, line)) {
        std::cout<<line<<std::endl;
    }
    inFile.close();
    return true;
}

bool WriteConfigFile2(const std::string fileName)
{
    std::vector<std::string> itemVec{
        "name:Ascend-aicpu_legacy.tar.gz",
        "install_path:3",
        "optional:true",
        "package_path:opp",
        "load_as_per_soc:false"
    };
    return WriteConfigFile(fileName, itemVec);
}

bool WriteConfigFile3(const std::string fileName)
{
    std::vector<std::string> itemVec{
        "install_path:3",
        "optional:true",
        "package_path:opp",
        "load_as_per_soc:false"
    };
    return WriteConfigFile(fileName, itemVec);
}
}

TEST_F(PackageProcessConfigTest, GetConfigDetailInfoSuccess) 
{
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    PackConfDetail config = {};
    config.decDstDir = DeviceInstallPath::RUNTIME_PATH;
    config.findPath = "compat";
    config.hostTruePath = "test/compat";
    pkgcfg->configMap_.emplace("cann-test-compat.tar.gz", config);
    PackConfDetail res = pkgcfg->GetConfigDetailInfo("cann-test-compat.tar.gz");
    EXPECT_EQ(res.decDstDir, DeviceInstallPath::RUNTIME_PATH);
    EXPECT_EQ(res.findPath, "compat");
    EXPECT_EQ(res.hostTruePath, "test/compat");
    PackConfDetail res1 = pkgcfg->GetConfigDetailInfo("cann-test-no-pkg-compat.tar.gz");
    EXPECT_EQ(res1.decDstDir, DeviceInstallPath::MAX_PATH);
    EXPECT_EQ(res1.findPath, "");
    EXPECT_EQ(res1.hostTruePath, "");
}

TEST_F(PackageProcessConfigTest, SetConfigDataOnServerSuccess) 
{ 
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    SinkPackageConfig hdcConfig;
    hdcConfig.set_package_name("Ascend_aicpu_sys.tar.gz");
    bool ret = pkgcfg->SetConfigDataOnServer(hdcConfig);
    EXPECT_EQ(ret, true);
}

TEST_F(PackageProcessConfigTest, ParseConfigDataFromProtoBufSuccess) 
{ 
    HDCMessage msg;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    msg.set_real_device_id(0U);
    msg.set_type(HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG);
    for (uint32_t index = 0; index < 101; index++) {
        std::string tmpName = "Ascend.tar.gz" + std::to_string(index);
        SinkPackageConfig *curConf = msg.add_sink_pkg_con_list();
        curConf->set_package_name(tmpName);
        curConf->set_file_dec_dst_dir(0);
    }
    MOCKER_CPP(&PackageProcessConfig::SetConfigDataOnServer).stubs().will(returnValue(true));
    auto ret = pkgcfg->ParseConfigDataFromProtoBuf(msg);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageProcessConfigTest, ParseConfigDataFromProtoBufFailed) 
{ 
    HDCMessage msg;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    msg.set_real_device_id(0U);
    msg.set_type(HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG);
    MOCKER_CPP(&PackageProcessConfig::SetConfigDataOnServer).stubs().will(returnValue(false));
    for (uint32_t index = 0; index < 2; index++) {
        std::string tmpName = "Ascend.tar.gz" + std::to_string(index);
        SinkPackageConfig *curConf = msg.add_sink_pkg_con_list();
        curConf->set_package_name(tmpName);
        curConf->set_file_dec_dst_dir(0);
    }
    auto ret = pkgcfg->ParseConfigDataFromProtoBuf(msg);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageProcessConfigTest, GetHostFilePathSucc) 
{ 
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    std::string packagePath = "/tmp/";
    std::string packageName = "Ascend-aicpu_legacy.tar.gz";
    MOCKER(access).stubs().will(returnValue(0));
    std::string path = pkgcfg->GetHostFilePath(packagePath, packageName);
}


TEST_F(PackageProcessConfigTest, ParseConfigDataFromFileSucc) 
{ 
    std::string configFile = "/tmp/ascend_package_load.ini";
    MOCKER(access).stubs().will(returnValue(0));
    if (WriteConfigFile2(configFile)) {
        PackageProcessConfig *pkgConf = PackageProcessConfig::GetInstance();
        MOCKER_CPP(&PackageProcessConfig::GetHostFilePath)
        .stubs()
        .will(returnValue(configFile));
        auto ret = pkgConf->ParseConfigDataFromFile("Ascend");
        MOCKER_CPP(&PackageProcessConfig::SetConfigDataOnHost).stubs().will(returnValue(true));
        EXPECT_EQ(ret, TSD_OK);
        EXPECT_EQ(pkgConf->finishParse_, true);
        pkgConf->configMap_.clear();
        pkgConf->finishParse_ = false;
    }
}

TEST_F(PackageProcessConfigTest, ParseConfigDataFromFile_EmptyPkgName_Failed) 
{ 
    std::string configFile = "/tmp/ascend_package_load.ini";
    MOCKER(access).stubs().will(returnValue(0));
    std::vector<std::string> itemVec{
        "name:",
        "install_path:3",
        "optional:true",
        "package_path:opp",
    };
    if (WriteConfigFile(configFile, itemVec)) {
        PackageProcessConfig *pkgConf = PackageProcessConfig::GetInstance();
        MOCKER_CPP(&PackageProcessConfig::GetHostFilePath)
        .stubs()
        .will(returnValue(configFile));
        auto ret = pkgConf->ParseConfigDataFromFile("Ascend");
        EXPECT_EQ(ret, TSD_START_FAIL);
    }
}

TEST_F(PackageProcessConfigTest, ParseConfigDataFromFile_SetConfigDataOnHostFailed_Failed) 
{ 
    std::string configFile = "/tmp/ascend_package_load.ini";
    MOCKER(access).stubs().will(returnValue(0));
    if (WriteConfigFile2(configFile)) {
        PackageProcessConfig *pkgConf = PackageProcessConfig::GetInstance();
        MOCKER_CPP(&PackageProcessConfig::GetHostFilePath)
        .stubs()
        .will(returnValue(configFile));
        MOCKER_CPP(&PackageProcessConfig::SetConfigDataOnHost).stubs().will(returnValue(false));
        auto ret = pkgConf->ParseConfigDataFromFile("Ascend");
        EXPECT_EQ(ret, TSD_START_FAIL);
    }
}

TEST_F(PackageProcessConfigTest, SetConfigDataOnHostSucc)
{
    std::string configFile = "/tmp/ascend_package_load3.ini";
    MOCKER(access).stubs().will(returnValue(0));
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    if (WriteConfigFile3(configFile)) 
    {   
        std::string fileName = "Ascend-aicpu_legacy.tar.gz";
        std::ifstream inFile(configFile);
        MOCKER_CPP(&PackageProcessConfig::SetPkgHostTruePath).stubs().will(returnValue(true));
        auto ret = pkgcfg->SetConfigDataOnHost(inFile, fileName, "Ascend");
        EXPECT_EQ(ret, true);
    }
}

TEST_F(PackageProcessConfigTest, SetConfigDataOnHost_ParseSingleParaFailed_Failed)
{
    std::string configFile = "/tmp/ascend_package_load3.ini";
    MOCKER(access).stubs().will(returnValue(0));
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    if (WriteConfigFile3(configFile)) 
    {   
        std::string fileName = "Ascend-aicpu_legacy.tar.gz";
        std::ifstream inFile(configFile);
        MOCKER_CPP(&PackageProcessConfig::ParseSinglePara).stubs().will(returnValue(false));
        auto ret = pkgcfg->SetConfigDataOnHost(inFile, fileName, "Ascend");
        EXPECT_EQ(ret, false);
    }
}

TEST_F(PackageProcessConfigTest, SetConfigDataOnHost_NotAllItemParsed_Failed)
{
    std::string configFile = "/tmp/ascend_package_load3.ini";
    MOCKER(access).stubs().will(returnValue(0));
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    std::vector<std::string> itemVec{
        "install_path:3",
        "optional:true",
        "package_path:opp",
    };
    if (WriteConfigFile(configFile, itemVec)) 
    {   
        std::string fileName = "Ascend-aicpu_legacy.tar.gz";
        std::ifstream inFile(configFile);
        auto ret = pkgcfg->SetConfigDataOnHost(inFile, fileName, "Ascend");
        EXPECT_EQ(ret, false);
    }
}

TEST_F(PackageProcessConfigTest, SetConfigDataOnHost_SetPkgHostTruePathFailed_Failed)
{
    std::string configFile = "/tmp/ascend_package_load3.ini";
    MOCKER(access).stubs().will(returnValue(0));
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    if (WriteConfigFile3(configFile)) 
    {   
        std::string fileName = "Ascend-aicpu_legacy.tar.gz";
        std::ifstream inFile(configFile);
        MOCKER_CPP(&PackageProcessConfig::SetPkgHostTruePath).stubs().will(returnValue(false));
        auto ret = pkgcfg->SetConfigDataOnHost(inFile, fileName, "Ascend");
        EXPECT_EQ(ret, false);
    }
}

TEST_F(PackageProcessConfigTest, SetPkgHostTruePath_Success)
{
    PackConfDetail tempNode;
    std::string pkgName = "-aicpu_legacy.tar.gz";
    std::string pkgTitle = "";
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->SetPkgHostTruePath(tempNode, pkgName, pkgTitle);
    EXPECT_EQ(ret, true);
}

TEST_F(PackageProcessConfigTest, SetPkgHostTruePath_UseShortSocVersion_Success)
{
    PackConfDetail tempNode;
    tempNode.loadAsPerSocFlag = true;
    std::string pkgName;
    std::string pkgTitle = "Ascend;Ascend910B";
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->SetPkgHostTruePath(tempNode, pkgName, pkgTitle);
    EXPECT_EQ(ret, true);
}

TEST_F(PackageProcessConfigTest, SetPkgHostTruePath_UseShortSocVersion_Failed)
{
    PackConfDetail tempNode;
    tempNode.loadAsPerSocFlag = true;
    std::string pkgName;
    std::string pkgTitle = "Ascend;";
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->SetPkgHostTruePath(tempNode, pkgName, pkgTitle);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, SetPkgHostTruePath_NoSocVersion_Failed)
{
    PackConfDetail tempNode;
    tempNode.loadAsPerSocFlag = true;
    std::string pkgName;
    std::string pkgTitle = "Ascend";
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->SetPkgHostTruePath(tempNode, pkgName, pkgTitle);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseSinglePara_Success)
{
    std::string inputLine = "optional:true";
    PackConfDetail tempNode;
    std::unordered_set<std::string> finishedParseItemSet;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseSinglePara(inputLine, tempNode, finishedParseItemSet);
    EXPECT_EQ(tempNode.optionalFlag, true);
    EXPECT_EQ(ret, true);
}

TEST_F(PackageProcessConfigTest, ParseSinglePara_ItemWithoutColon_Failed)
{
    std::string inputLine = "optional";
    PackConfDetail tempNode;
    std::unordered_set<std::string> finishedParseItemSet;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseSinglePara(inputLine, tempNode, finishedParseItemSet);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseSinglePara_InvalidConfigItem_Failed)
{
    std::string inputLine = "invalidItem:123";
    PackConfDetail tempNode;
    std::unordered_set<std::string> finishedParseItemSet;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseSinglePara(inputLine, tempNode, finishedParseItemSet);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseSinglePara_ParseItemFailed_Failed)
{
    std::string inputLine = "optional:123";
    PackConfDetail tempNode;
    std::unordered_set<std::string> finishedParseItemSet;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseSinglePara(inputLine, tempNode, finishedParseItemSet);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseInstallPath_Success)
{
    std::string para = "0";
    PackConfDetail tempNode;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseInstallPath(para, tempNode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(tempNode.decDstDir, static_cast<DeviceInstallPath>(0));
}

TEST_F(PackageProcessConfigTest, ParseInstallPath_Failed)
{
    std::string para = "-1";
    PackConfDetail tempNode;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseInstallPath(para, tempNode);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseOptionalFlag_Success)
{
    std::string para = "true";
    PackConfDetail tempNode;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseOptionalFlag(para, tempNode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(tempNode.optionalFlag, true);
}

TEST_F(PackageProcessConfigTest, ParseOptionalFlag_Failed)
{
    std::string para = "123";
    PackConfDetail tempNode;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseOptionalFlag(para, tempNode);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParsePackagePath_Success)
{
    std::string para = "opp";
    PackConfDetail tempNode;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParsePackagePath(para, tempNode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(tempNode.findPath, para);
}

TEST_F(PackageProcessConfigTest, ParsePackagePath_Failed)
{
    std::string para = "";
    PackConfDetail tempNode;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParsePackagePath(para, tempNode);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseLoadAsPerSocFlag_Success)
{
    std::string para = "true";
    PackConfDetail tempNode;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseLoadAsPerSocFlag(para, tempNode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(tempNode.loadAsPerSocFlag, true);
}

TEST_F(PackageProcessConfigTest, ParseLoadAsPerSocFlag_Failed)
{
    std::string para = "123";
    PackConfDetail tempNode;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseLoadAsPerSocFlag(para, tempNode);
    EXPECT_EQ(ret, false);
}