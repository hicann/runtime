/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <mutex>
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "inc/internal_api.h"
#include "inc/tsd_path_mgr.h"
#include "inc/package_worker_utils.h"
#include "inc/package_worker_factory.h"
#include "driver/ascend_hal.h"
#include "inc/process_util_common.h"
#include "inc/weak_ascend_hal.h"
#define private public
#define protected public
#include "inc/common_sink_package_worker.h"
#include "inc/package_process_config.h"
#include "inc/base_package_worker.h"
#undef private
#undef protected

using namespace tsd;
using namespace std;

class CommonSinkPackageWorkerTest : public testing::Test {
protected:
    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

bool WriteConfigFile(const std::string fileName)
{
    std::ofstream outFile(fileName);
    if(!outFile) {
        std::cout<<"Can not creat file."<<std::endl;
        return false;
    }
    outFile << "name:Ascend-aicpu_legacy.tar.gz"<<std::endl;
    outFile << "install_path:2"<<std::endl;
    outFile << "optional:true"<<std::endl;
    outFile << "package_path:opp"<<std::endl;
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

TEST_F(CommonSinkPackageWorkerTest, PackageNameNoPass_01)
{
    std::string configFile = "/tmp/ascend_package_load.ini";
    if (WriteConfigFile(configFile)) {
        PackageProcessConfig *pkgConf = PackageProcessConfig::GetInstance();
        MOCKER_CPP(&PackageProcessConfig::GetHostFilePath)
        .stubs()
        .will(returnValue(configFile));
        MOCKER_CPP(&CommonSinkPackageWorker::StartLoadCommonSinkPackage)
        .stubs()
        .will(returnValue(0U));
        MOCKER_CPP(&access).stubs().will(returnValue(0));
        pkgConf->ParseConfigDataFromFile("Ascend");
        HDCMessage msg;
        msg.set_real_device_id(0U);
        msg.set_type(HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG);
        pkgConf->ConstructPkgConfigMsg(msg);
        pkgConf->ParseConfigDataFromProtoBuf(msg);
        CommonSinkPackageWorker inst({0U, 0U});
        std::string packagePath = "/tmp";
        std::string packageName = "Ascend-aicpu_legacy.tar.gz";
        auto ret = inst.LoadPackage(packagePath, packageName);
        remove(configFile.c_str());
        EXPECT_EQ(ret, TSD_INTERNAL_ERROR);

        packageName = "123_Ascend-aicpu_legacy.tar.gz";
        ret = inst.LoadPackage(packagePath, packageName);
        EXPECT_EQ(ret, TSD_OK);

        MOCKER(PackSystem).stubs().will(returnValue(0));
        (void)inst.GetMovePackageToDecompressDirCmd();
        (void)inst.GetDecompressPackageCmd();
        (void)inst.UnloadPackage();
        (void)inst.DecompressPackage();
        (void)inst.SetAicpuThreadModeInstallPath();
        (void)inst.StartLoadCommonSinkPackage();
        (void)inst.PostProcessPackage();
        (void)pkgConf->IsConfigPackageInfo(packageName);
        (void)pkgConf->GetPackageHostTruePath(packageName);
        std::string hashCode = "1234566";
        (void)inst.SetCurPkgHashCode(packageName, hashCode);
        (void)inst.GetProcessedPkgHashCode(packageName);
        std::map<std::string, std::string> pkgHashMap;
        (void)inst.GetAllPackageHashCode(pkgHashMap);
        GlobalMockObject::verify();
    }
}

TEST_F(CommonSinkPackageWorkerTest, PackageNameNoPass_02)
{
    std::string configFile = "/tmp/ascend_package_load.ini";
    if (WriteConfigFile(configFile)) {
        PackageProcessConfig *pkgConf = PackageProcessConfig::GetInstance();
        MOCKER_CPP(&access).stubs().will(returnValue(0));
        pkgConf->ParseConfigDataFromFile("Ascend");
        HDCMessage msg;
        msg.set_real_device_id(0U);
        msg.set_type(HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG);
        pkgConf->ConstructPkgConfigMsg(msg);
        pkgConf->ParseConfigDataFromProtoBuf(msg);
        CommonSinkPackageWorker inst({0U, 0U});
        std::string packagePath = "/tmp";
        std::string packageName = "Ascend-aicpu_legacy.tar.gz";
        std::string orgFile;
        std::string dstFile;
        const pid_t hostPid = 123;
        (void)inst.StartLoadCommonSinkPackage();
        (void)pkgConf->GetPkgHostAndDeviceDstPath(packageName, orgFile, dstFile, hostPid);
        (void)pkgConf->GetHostFilePath(packagePath, packageName);
        HDCMessage rspMsg;
        (void)pkgConf->SetAllCommonSinkPackageHashCode(msg, rspMsg);
        SinkPackageConfig hdcConfig;
        hdcConfig.set_package_name("Ascend_aicpu_sys.tar.gz");
        (void)pkgConf->SetConfigDataOnServer(hdcConfig);
        remove(configFile.c_str());
        GlobalMockObject::verify();
    }
}

TEST_F(CommonSinkPackageWorkerTest, PackageNameNoPass_03)
{
    CommonSinkPackageWorker inst({0U, 0U});
    MOCKER_CPP(&PackageWorkerUtils::IsSetMemLimit)
    .stubs()
    .will(returnValue(true));
    MOCKER_CPP(&PackageWorkerUtils::CheckMemoryUsage)
    .stubs()
    .will(returnValue(0U));
    MOCKER_CPP(PackSystem)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&PackageWorkerUtils::CheckMemoryUsage)
    .stubs()
    .will(returnValue(0U));
    (void)inst.DecompressPackage();
    GlobalMockObject::verify();
}

TEST_F(CommonSinkPackageWorkerTest, PackageNameNoPass_04)
{
    CommonSinkPackageWorker inst({0U, 0U});
    (void)inst.GetSoInstallPathByConfig(0U);
    (void)inst.GetSoInstallPathByConfig(1U);
    (void)inst.GetSoInstallPathByConfig(2U);
    (void)inst.GetSoInstallPathByConfig(3U);
    (void)inst.GetSoInstallPathByConfig(4U);
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage)
    .stubs()
    .will(returnValue(TSD_OK));
    (void)inst.StartLoadCommonSinkPackage();
    GlobalMockObject::verify();
}

TEST_F(CommonSinkPackageWorkerTest, PackageNameNoPass_05)
{
    CommonSinkPackageWorker inst({0U, 0U});
    std::string path = "/tmp";
    std::string fileName = "aicpu_atr.gz";
    (void)inst.PreProcessPackage(path, fileName);
    (void)inst.SetDecompressPackagePath();
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage)
    .stubs()
    .will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory)
    .stubs()
    .will(returnValue(TSD_OK));
    MOCKER_CPP(PackSystem)
    .stubs()
    .will(returnValue(0));
    (void)inst.StartLoadCommonSinkPackage();
    GlobalMockObject::verify();
}

TEST_F(CommonSinkPackageWorkerTest, PackageNameNoPass_06)
{
    PackageProcessConfig *pkgConf = PackageProcessConfig::GetInstance();
    MOCKER_CPP(&access).stubs().will(returnValue(0));
    (void)pkgConf->ParseConfigDataFromFile("Ascend");
    HDCMessage msg;
    msg.set_real_device_id(0U);
    msg.set_type(HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG);
    (void)pkgConf->ConstructPkgConfigMsg(msg);
    for (uint32_t index = 0; index < 101; index++) {
        std::string tmpName = "Ascend.atr.gz" + std::to_string(index);
        SinkPackageConfig *curConf = msg.add_sink_pkg_con_list();
        curConf->set_package_name(tmpName);
        curConf->set_file_dec_dst_dir(0);
    }
    pkgConf->ParseConfigDataFromProtoBuf(msg);
    GlobalMockObject::verify();
}