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
#include "package_worker_utils.h"
#define private public
#define protected public
#include "package_process_config.h"
#undef private
#undef protected

using namespace tsd;

class PackageProcessConfigTest : public testing::Test {
protected:
    void SetUp() override
    {
        char dirTemplate[] = "/tmp/package_process_config_ut_XXXXXX";
        char* dir = mkdtemp(dirTemplate);
        ASSERT_NE(dir, nullptr);
        tempDir_ = dir;
        configFile_ = tempDir_ + "/ascend_package_load.ini";

        config_ = PackageProcessConfig::GetInstance();
        savedConfigMap_ = config_->configMap_;
        savedHostPluginVersions_ = config_->hostPluginVersions_;
        savedHashCode_ = config_->hashCode_;
        savedFinishParse_ = config_->finishParse_;
        config_->configMap_.clear();
        config_->hostPluginVersions_.clear();
        config_->hashCode_.clear();
        config_->finishParse_ = false;
    }

    void TearDown() override
    {
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            RestoreState();
            throw;
        }
        GlobalMockObject::reset();
        RestoreState();
    }

    std::string configFile_;

private:
    void RestoreState()
    {
        config_->configMap_ = savedConfigMap_;
        config_->hostPluginVersions_ = savedHostPluginVersions_;
        config_->hashCode_ = savedHashCode_;
        config_->finishParse_ = savedFinishParse_;
        (void)remove(configFile_.c_str());
        (void)remove(tempDir_.c_str());
    }

    PackageProcessConfig* config_ = nullptr;
    std::string tempDir_;
    std::map<std::string, PackConfDetail> savedConfigMap_;
    std::map<std::string, PluginPkgVersion> savedHostPluginVersions_;
    std::string savedHashCode_;
    bool savedFinishParse_ = false;
};
namespace {
bool WriteConfigFile(const std::string fileName, const std::vector<std::string> itemVec)
{
    std::ofstream outFile(fileName);
    if (!outFile) {
        std::cout << "Can not creat file." << std::endl;
        return false;
    }
    for (auto& item : itemVec) {
        outFile << item << std::endl;
    }
    outFile.close();
    std::ifstream inFile(fileName);
    if (!inFile) {
        std::cout << "Can not read file." << std::endl;
        return false;
    }
    std::string line;
    while (getline(inFile, line)) {
        std::cout << line << std::endl;
    }
    inFile.close();
    return true;
}

bool WriteConfigFile2(const std::string fileName)
{
    std::vector<std::string> itemVec{
        "name:Ascend-aicpu_legacy.tar.gz", "install_path:3", "optional:true", "package_path:opp",
        "load_as_per_soc:false"};
    return WriteConfigFile(fileName, itemVec);
}

bool WriteConfigFile3(const std::string fileName)
{
    std::vector<std::string> itemVec{"install_path:3", "optional:true", "package_path:opp", "load_as_per_soc:false"};
    return WriteConfigFile(fileName, itemVec);
}
} // namespace

TEST_F(PackageProcessConfigTest, GetConfigDetailInfo_ExistingAndMissingNames_ReturnsStoredOrDefaultDetail)
{
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
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

TEST_F(PackageProcessConfigTest, SetConfigDataOnServer_ValidPackageName_ReturnsTrue)
{
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    SinkPackageConfig hdcConfig;
    hdcConfig.set_package_name("Ascend_aicpu_sys.tar.gz");
    bool ret = pkgcfg->SetConfigDataOnServer(hdcConfig);
    EXPECT_EQ(ret, true);
}

TEST_F(PackageProcessConfigTest, ParseConfigDataFromProtoBuf_AllEntriesAccepted_ReturnsOk)
{
    HDCMessage msg;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    msg.set_real_device_id(0U);
    msg.set_type(HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG);
    for (uint32_t index = 0; index < 101; index++) {
        std::string tmpName = "Ascend.tar.gz" + std::to_string(index);
        SinkPackageConfig* curConf = msg.add_sink_pkg_con_list();
        curConf->set_package_name(tmpName);
        curConf->set_file_dec_dst_dir(0);
    }
    MOCKER_CPP(&PackageProcessConfig::SetConfigDataOnServer).stubs().will(returnValue(true));
    auto ret = pkgcfg->ParseConfigDataFromProtoBuf(msg);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageProcessConfigTest, ParseConfigDataFromProtoBuf_EntryRejected_ReturnsStartFail)
{
    HDCMessage msg;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    msg.set_real_device_id(0U);
    msg.set_type(HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG);
    MOCKER_CPP(&PackageProcessConfig::SetConfigDataOnServer).stubs().will(returnValue(false));
    for (uint32_t index = 0; index < 2; index++) {
        std::string tmpName = "Ascend.tar.gz" + std::to_string(index);
        SinkPackageConfig* curConf = msg.add_sink_pkg_con_list();
        curConf->set_package_name(tmpName);
        curConf->set_file_dec_dst_dir(0);
    }
    auto ret = pkgcfg->ParseConfigDataFromProtoBuf(msg);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageProcessConfigTest, GetHostFilePath_AccessiblePackage_ReturnsPackagePath)
{
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    std::string packagePath = "/tmp/";
    std::string packageName = "Ascend-aicpu_legacy.tar.gz";
    MOCKER(access).stubs().will(returnValue(0));
    std::string path = pkgcfg->GetHostFilePath(packagePath, packageName);
    EXPECT_FALSE(path.empty());
    EXPECT_NE(path.find(packageName), std::string::npos);
}

TEST_F(PackageProcessConfigTest, ParseConfigDataFromFile_ValidConfig_SetsFinishFlag)
{
    MOCKER(access).stubs().will(returnValue(0));
    ASSERT_TRUE(WriteConfigFile2(configFile_));
    PackageProcessConfig* pkgConf = PackageProcessConfig::GetInstance();
    MOCKER_CPP(&PackageProcessConfig::GetHostFilePath).stubs().will(returnValue(configFile_));
    auto ret = pkgConf->ParseConfigDataFromFile("Ascend");
    EXPECT_EQ(ret, TSD_OK);
    EXPECT_EQ(pkgConf->finishParse_, true);
}

TEST_F(PackageProcessConfigTest, ParseConfigDataFromFile_EmptyPackageName_ReturnsStartFail)
{
    MOCKER(access).stubs().will(returnValue(0));
    std::vector<std::string> itemVec{
        "name:",
        "install_path:3",
        "optional:true",
        "package_path:opp",
    };
    ASSERT_TRUE(WriteConfigFile(configFile_, itemVec));
    PackageProcessConfig* pkgConf = PackageProcessConfig::GetInstance();
    MOCKER_CPP(&PackageProcessConfig::GetHostFilePath).stubs().will(returnValue(configFile_));
    auto ret = pkgConf->ParseConfigDataFromFile("Ascend");
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageProcessConfigTest, ParseConfigDataFromFile_HostConfigStoreRejects_ReturnsStartFail)
{
    MOCKER(access).stubs().will(returnValue(0));
    ASSERT_TRUE(WriteConfigFile2(configFile_));
    PackageProcessConfig* pkgConf = PackageProcessConfig::GetInstance();
    MOCKER_CPP(&PackageProcessConfig::GetHostFilePath).stubs().will(returnValue(configFile_));
    MOCKER_CPP(&PackageProcessConfig::SetConfigDataOnHost).stubs().will(returnValue(false));
    auto ret = pkgConf->ParseConfigDataFromFile("Ascend");
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(PackageProcessConfigTest, SetConfigDataOnHost_AllRequiredItemsPresent_ReturnsTrue)
{
    MOCKER(access).stubs().will(returnValue(0));
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    ASSERT_TRUE(WriteConfigFile3(configFile_));
    std::string fileName = "Ascend-aicpu_legacy.tar.gz";
    std::ifstream inFile(configFile_);
    ASSERT_TRUE(inFile.is_open());
    MOCKER_CPP(&PackageProcessConfig::SetPkgHostTruePath).stubs().will(returnValue(true));
    auto ret = pkgcfg->SetConfigDataOnHost(inFile, fileName, "Ascend");
    EXPECT_EQ(ret, true);
}

TEST_F(PackageProcessConfigTest, SetConfigDataOnHost_ParameterParsingFails_ReturnsFalse)
{
    MOCKER(access).stubs().will(returnValue(0));
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    ASSERT_TRUE(WriteConfigFile3(configFile_));
    std::string fileName = "Ascend-aicpu_legacy.tar.gz";
    std::ifstream inFile(configFile_);
    ASSERT_TRUE(inFile.is_open());
    MOCKER_CPP(&PackageProcessConfig::ParseSinglePara).stubs().will(returnValue(false));
    auto ret = pkgcfg->SetConfigDataOnHost(inFile, fileName, "Ascend");
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, SetConfigDataOnHost_RequiredItemMissing_ReturnsFalse)
{
    MOCKER(access).stubs().will(returnValue(0));
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    std::vector<std::string> itemVec{
        "install_path:3",
        "optional:true",
        "package_path:opp",
    };
    ASSERT_TRUE(WriteConfigFile(configFile_, itemVec));
    std::string fileName = "Ascend-aicpu_legacy.tar.gz";
    std::ifstream inFile(configFile_);
    ASSERT_TRUE(inFile.is_open());
    auto ret = pkgcfg->SetConfigDataOnHost(inFile, fileName, "Ascend");
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, SetConfigDataOnHost_HostPathResolutionFails_ReturnsFalse)
{
    MOCKER(access).stubs().will(returnValue(0));
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    ASSERT_TRUE(WriteConfigFile3(configFile_));
    std::string fileName = "Ascend-aicpu_legacy.tar.gz";
    std::ifstream inFile(configFile_);
    ASSERT_TRUE(inFile.is_open());
    MOCKER_CPP(&PackageProcessConfig::SetPkgHostTruePath).stubs().will(returnValue(false));
    auto ret = pkgcfg->SetConfigDataOnHost(inFile, fileName, "Ascend");
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, SetPkgHostTruePath_LegacyPackageWithoutSoc_ReturnsTrue)
{
    PackConfDetail tempNode;
    std::string pkgName = "-aicpu_legacy.tar.gz";
    std::string pkgTitle = "";
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->SetPkgHostTruePath(tempNode, pkgName, pkgTitle);
    EXPECT_EQ(ret, true);
}

TEST_F(PackageProcessConfigTest, SetPkgHostTruePath_SocVersionProvided_ReturnsTrue)
{
    PackConfDetail tempNode;
    tempNode.loadAsPerSocFlag = true;
    std::string pkgName;
    std::string pkgTitle = "Ascend;Ascend910B";
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->SetPkgHostTruePath(tempNode, pkgName, pkgTitle);
    EXPECT_EQ(ret, true);
}

TEST_F(PackageProcessConfigTest, SetPkgHostTruePath_EmptySocVersion_ReturnsFalse)
{
    PackConfDetail tempNode;
    tempNode.loadAsPerSocFlag = true;
    std::string pkgName;
    std::string pkgTitle = "Ascend;";
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->SetPkgHostTruePath(tempNode, pkgName, pkgTitle);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, SetPkgHostTruePath_SocSeparatorMissing_ReturnsFalse)
{
    PackConfDetail tempNode;
    tempNode.loadAsPerSocFlag = true;
    std::string pkgName;
    std::string pkgTitle = "Ascend";
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->SetPkgHostTruePath(tempNode, pkgName, pkgTitle);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseSinglePara_ValidOptionalFlag_SetsFlagAndReturnsTrue)
{
    std::string inputLine = "optional:true";
    PackConfDetail tempNode;
    std::unordered_set<std::string> finishedParseItemSet;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseSinglePara(inputLine, tempNode, finishedParseItemSet);
    EXPECT_EQ(tempNode.optionalFlag, true);
    EXPECT_EQ(ret, true);
}

TEST_F(PackageProcessConfigTest, ParseSinglePara_ColonMissing_ReturnsFalse)
{
    std::string inputLine = "optional";
    PackConfDetail tempNode;
    std::unordered_set<std::string> finishedParseItemSet;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseSinglePara(inputLine, tempNode, finishedParseItemSet);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseSinglePara_ConfigKeyUnknown_ReturnsFalse)
{
    std::string inputLine = "invalidItem:123";
    PackConfDetail tempNode;
    std::unordered_set<std::string> finishedParseItemSet;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseSinglePara(inputLine, tempNode, finishedParseItemSet);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseSinglePara_ConfigValueInvalid_ReturnsFalse)
{
    std::string inputLine = "optional:123";
    PackConfDetail tempNode;
    std::unordered_set<std::string> finishedParseItemSet;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseSinglePara(inputLine, tempNode, finishedParseItemSet);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseInstallPath_ValidEnumValue_SetsDestination)
{
    std::string para = "0";
    PackConfDetail tempNode;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseInstallPath(para, tempNode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(tempNode.decDstDir, static_cast<DeviceInstallPath>(0));
}

TEST_F(PackageProcessConfigTest, ParseInstallPath_NegativeValue_ReturnsFalse)
{
    std::string para = "-1";
    PackConfDetail tempNode;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseInstallPath(para, tempNode);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseOptionalFlag_TrueValue_SetsFlag)
{
    std::string para = "true";
    PackConfDetail tempNode;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseOptionalFlag(para, tempNode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(tempNode.optionalFlag, true);
}

TEST_F(PackageProcessConfigTest, ParseOptionalFlag_NonBooleanValue_ReturnsFalse)
{
    std::string para = "123";
    PackConfDetail tempNode;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseOptionalFlag(para, tempNode);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParsePackagePath_NonemptyValue_SetsFindPath)
{
    std::string para = "opp";
    PackConfDetail tempNode;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParsePackagePath(para, tempNode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(tempNode.findPath, para);
}

TEST_F(PackageProcessConfigTest, ParsePackagePath_EmptyValue_ReturnsFalse)
{
    std::string para = "";
    PackConfDetail tempNode;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParsePackagePath(para, tempNode);
    EXPECT_EQ(ret, false);
}

TEST_F(PackageProcessConfigTest, ParseLoadAsPerSocFlag_TrueValue_SetsFlag)
{
    std::string para = "true";
    PackConfDetail tempNode;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseLoadAsPerSocFlag(para, tempNode);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(tempNode.loadAsPerSocFlag, true);
}

TEST_F(PackageProcessConfigTest, ParseLoadAsPerSocFlag_NonBooleanValue_ReturnsFalse)
{
    std::string para = "123";
    PackConfDetail tempNode;
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    const auto ret = pkgcfg->ParseLoadAsPerSocFlag(para, tempNode);
    EXPECT_EQ(ret, false);
}

// 覆盖 RefreshHostPluginVersions 中加锁写 hostPluginVersions_ 的两条 lock_guard 分支：
// 1) compat 包 hostTruePath 为空 -> empty 分支加锁写入空版本
// 2) compat 包 hostTruePath 非空 -> 末尾加锁写入解析结果
TEST_F(PackageProcessConfigTest, RefreshHostPluginVersions_MissingCompatIni_StoresEmptyFallbackVersions)
{
    PackageProcessConfig* pkgcfg = PackageProcessConfig::GetInstance();
    pkgcfg->configMap_.clear();
    pkgcfg->hostPluginVersions_.clear();

    // 分支1：compat 包，hostTruePath 为空 -> 命中 empty 分支的 lock_guard
    PackConfDetail compatEmptyPath = {};
    compatEmptyPath.decDstDir = DeviceInstallPath::COMPAT_PLUGIN_PATH;
    compatEmptyPath.hostTruePath = "";
    pkgcfg->configMap_["cann-emptypath-compat.tar.gz"] = compatEmptyPath;

    // 分支2：compat 包，hostTruePath 非空（ini 不存在解析失败回退）-> 命中末尾的 lock_guard
    PackConfDetail compatNonEmptyPath = {};
    compatNonEmptyPath.decDstDir = DeviceInstallPath::COMPAT_PLUGIN_PATH;
    compatNonEmptyPath.hostTruePath = "./cann-nonexist-compat.tar.gz";
    pkgcfg->configMap_["cann-nonexist-compat.tar.gz"] = compatNonEmptyPath;

    pkgcfg->RefreshHostPluginVersions();

    // 两个包都应被加锁写入 hostPluginVersions_
    ASSERT_NE(pkgcfg->hostPluginVersions_.find("cann-emptypath-compat.tar.gz"), pkgcfg->hostPluginVersions_.end());
    EXPECT_TRUE(pkgcfg->hostPluginVersions_["cann-emptypath-compat.tar.gz"].Empty());
    ASSERT_NE(pkgcfg->hostPluginVersions_.find("cann-nonexist-compat.tar.gz"), pkgcfg->hostPluginVersions_.end());
    EXPECT_TRUE(pkgcfg->hostPluginVersions_["cann-nonexist-compat.tar.gz"].Empty());

    pkgcfg->configMap_.clear();
    pkgcfg->hostPluginVersions_.clear();
}

TEST_F(PackageProcessConfigTest, ConstructPkgConfigMsg_NormalAndCompatEntries_SetsVersionsCountAndExactHash)
{
    {
        std::ofstream configFile(configFile_, std::ios::binary | std::ios::trunc);
        ASSERT_TRUE(configFile.is_open());
        configFile << "abc";
    }
    PackageProcessConfig* config = PackageProcessConfig::GetInstance();
    PackConfDetail normal{};
    normal.decDstDir = DeviceInstallPath::RUNTIME_PATH;
    PackConfDetail compat{};
    compat.decDstDir = DeviceInstallPath::COMPAT_PLUGIN_PATH;
    config->configMap_["normal.tar.gz"] = normal;
    config->configMap_["compat.tar.gz"] = compat;
    config->hostPluginVersions_["compat.tar.gz"] = {"8.5.0", "20260806_120000000"};
    MOCKER_CPP(&PackageProcessConfig::GetHostFilePath).expects(once()).will(returnValue(configFile_));
    HDCMessage msg;

    config->ConstructPkgConfigMsg(msg);

    ASSERT_EQ(msg.sink_pkg_con_list_size(), 2);
    EXPECT_EQ(msg.sink_pkg_con_list(0).package_name(), "compat.tar.gz");
    EXPECT_EQ(
        msg.sink_pkg_con_list(0).file_dec_dst_dir(), static_cast<uint32_t>(DeviceInstallPath::COMPAT_PLUGIN_PATH));
    EXPECT_EQ(msg.sink_pkg_con_list(1).package_name(), "normal.tar.gz");
    EXPECT_EQ(msg.sink_pkg_con_list(1).file_dec_dst_dir(), static_cast<uint32_t>(DeviceInstallPath::RUNTIME_PATH));
    ASSERT_EQ(msg.host_plugin_versions_size(), 1);
    EXPECT_EQ(msg.host_plugin_versions(0).package_name(), "compat.tar.gz");
    EXPECT_EQ(msg.host_plugin_versions(0).version(), "8.5.0");
    EXPECT_EQ(msg.host_plugin_versions(0).timestamp(), "20260806_120000000");
    EXPECT_EQ(msg.package_config_hash_code(), "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
}
