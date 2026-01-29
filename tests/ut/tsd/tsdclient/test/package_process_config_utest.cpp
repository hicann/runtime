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


bool WriteConfigFile2(const std::string fileName)
{
    std::ofstream outFile2(fileName);
    if(!outFile2) {
        std::cout<<"Can not creat file."<<std::endl;
        return false;
    }
    outFile2 << "name:Ascend-aicpu_legacy.tar.gz"<<std::endl;
    outFile2 << "install_path:2"<<std::endl;
    outFile2 << "optional:true"<<std::endl;
    outFile2 << "package_path:opp"<<std::endl;
    outFile2.close();
    std::ifstream inFile2(fileName);
    if(!inFile2) {
        std::cout<<"Can not read file."<<std::endl;
        return false;
    }
    std::string line;
    while (getline(inFile2, line)) {
        std::cout<<line<<std::endl;
    }
    inFile2.close();
    return true;
}

bool WriteConfigFile3(const std::string fileName)
{
    std::ofstream outFile(fileName);
    if(!outFile) {
        std::cout<<"Can not creat file."<<std::endl;
        return false;
    }
    outFile << "install_path:3"<<std::endl;
    outFile << "optional:true"<<std::endl;
    outFile << "package_path:oppp"<<std::endl;
    
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
    }
}

TEST_F(PackageProcessConfigTest, FillDetailNode)
{
    std::string dstDir = "0";
    std::string optionalFlag = "true";
    std::string findPath = "tmp";
    PackConfDetail tmpNode;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    auto ret = pkgcfg->FillDetailNode(dstDir, optionalFlag, findPath, tmpNode);
    EXPECT_EQ(ret, true);
    ret = pkgcfg->FillDetailNode(dstDir, optionalFlag, findPath, tmpNode);
    optionalFlag = "hahaha";
    ret = pkgcfg->FillDetailNode(dstDir, optionalFlag, findPath, tmpNode);
    EXPECT_EQ(ret, false);
    dstDir = "4";
    ret = pkgcfg->FillDetailNode(dstDir, optionalFlag, findPath, tmpNode);
    EXPECT_EQ(ret, false);
    findPath.clear();
    ret = pkgcfg->FillDetailNode(dstDir, optionalFlag, findPath, tmpNode);
    EXPECT_EQ(ret, false);
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
        MOCKER_CPP(&PackageProcessConfig::FillDetailNode).stubs().will(returnValue(true));
        auto ret = pkgcfg->SetConfigDataOnHost(inFile, fileName, "Ascend");
        EXPECT_EQ(ret, true);
    }
}

TEST_F(PackageProcessConfigTest, SetPkgHostTruePathSucc)
{
    PackConfDetail tempNode;
    std::string pkgName;
    PackageProcessConfig *pkgcfg = PackageProcessConfig::GetInstance();
    pkgcfg->SetPkgHostTruePath(tempNode, pkgName, "");
}






