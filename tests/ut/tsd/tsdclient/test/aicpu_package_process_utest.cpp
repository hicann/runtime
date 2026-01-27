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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "inc/error_code.h"
#include "inc/internal_api.h"
#include "inc/package_worker_utils.h"
#define private public
#define protected public
#include "inc/aicpu_package_process.h"
#undef private
#undef protected

using namespace tsd;

namespace {
std::string GetDirName()
{
    std::unique_ptr<char_t []> path(new (std::nothrow) char_t[PATH_MAX]);
    if (path == nullptr) {
        std::cout << "Oom" << std::endl;
        return "";
    }
    const int32_t eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
    if (eRet != EOK) {
        std::cout << "memset failed" << std::endl;
        return "";
    }

    const auto ret = getcwd(path.get(), PATH_MAX);
    if (ret == nullptr) {
        std::cout << "Get current work path failed" << std::endl;
        return "";
    }

    std::string dirPath(path.get());
    if (dirPath.back() != '/') {
        dirPath.append("/");
    }
    dirPath.append(std::to_string(getpid())).append("versionFileDir/");

    return dirPath;
}

bool CreateVersionFile(const std::string &dirPath)
{
    (void)PackageWorkerUtils::MakeDirectory(dirPath);
    std::string fileName = dirPath + "version.info";
    std::cout << fileName << std::endl;

    std::ofstream outFile(fileName);
    if (!outFile) {
        std::cout << "Can not create file" << std::endl;
        return false;
    }

    outFile << "Version=7.7.T5.0.B019" << std::endl;
    outFile << "timestamp=20250121_000122058" << std::endl;
    outFile << "Name=Ascend910-aicpu_syskernels.tar.gz" << std::endl;
    outFile << "SandBoxSo=libtensorflow.so" << std::endl;
    outFile << "Featurelist=AICPU_PROF_V2" << std::endl;
    outFile << "Trustlist=libccl_kernel.so,libccl_kernel_plf.so,libtensorflow" << std::endl;
    outFile.close();

    std::ifstream inFile(fileName);
    if (!inFile) {
        std::cout << "Can not read file" << std::endl;
        return false;
    }

    std::string line;
    while (std::getline(inFile, line)) {
        std::cout << line << std::endl;
    }
    inFile.close();

    return true;
}

void ClearDir(const std::string &dirPath)
{
    const std::string cmd = "rm -rf " + dirPath;
    PackSystem(cmd.c_str());
}
}

class AicpuPackageProcessTest : public testing::Test {
protected:
    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(AicpuPackageProcessTest, CheckPackageNameSuccess)
{
    const std::string soInstallPath = GetDirName();
    if (!CreateVersionFile(soInstallPath)) {
        return;
    }
    const std::string packageName = "/test/asd/Ascend910-aicpu_syskernels.tar.gz";
    const TSD_StatusT ret = AicpuPackageProcess::CheckPackageName(soInstallPath, packageName);
    ClearDir(soInstallPath);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuPackageProcessTest, CheckPackageNameFail)
{
    const std::string soInstallPath = "/usr/lib64/aicpu_kernels/0";
    const std::string packageName = "/test/asd/Ascend_test_tsd.tar.gz";
    const TSD_StatusT ret = AicpuPackageProcess::CheckPackageName(soInstallPath, packageName);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, CheckPackageNameGetSrcPkgNameFail)
{
    const std::string soInstallPath = "/usr/lib64/aicpu_kernels/0";
    const std::string packageName = "/test/asd/_test?_tsd.tar.gz";
    const TSD_StatusT ret = AicpuPackageProcess::CheckPackageName(soInstallPath, packageName);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(AicpuPackageProcessTest, CheckPackageNamePackageNameEqualFail)
{
    const std::string soInstallPath = GetDirName();
    if (!CreateVersionFile(soInstallPath)) {
        return;
    }
    const std::string packageName = "/test/asd/Ascend-ai_sys.tar.gz";
    const TSD_StatusT ret = AicpuPackageProcess::CheckPackageName(soInstallPath, packageName);
    ClearDir(soInstallPath);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, MoveSoToSandBoxSuccess)
{
    const std::string soInstallPath = GetDirName();
    if (!CreateVersionFile(soInstallPath)) {
        return;
    }
    MOCKER(rename).stubs().will(returnValue(0));
    TSD_StatusT ret = AicpuPackageProcess::MoveSoToSandBox(soInstallPath);
    ClearDir(soInstallPath);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuPackageProcessTest, MoveSoToSandBoxGetSandboxFail)
{
    const std::string soInstallPath = GetDirName();
    if (!CreateVersionFile(soInstallPath)) {
        return;
    }
    MOCKER(rename).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuPackageProcess::WalkInVersionFile).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    TSD_StatusT ret = AicpuPackageProcess::MoveSoToSandBox(soInstallPath);
    ClearDir(soInstallPath);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, MoveSoToSandBoxCreateDirFail)
{
    const std::string soInstallPath = GetDirName();
    if (!CreateVersionFile(soInstallPath)) {
        return;
    }
    MOCKER(rename).stubs().will(returnValue(0));
    MOCKER_CPP(PackageWorkerUtils::MakeDirectory).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    TSD_StatusT ret = AicpuPackageProcess::MoveSoToSandBox(soInstallPath);
    ClearDir(soInstallPath);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, IsSoExistSuccess)
{
    EXPECT_EQ(AicpuPackageProcess::IsSoExist(0U), false);
    MOCKER(access).stubs().will(returnValue(0));
    EXPECT_EQ(AicpuPackageProcess::IsSoExist(0U), true);
}

TEST_F(AicpuPackageProcessTest, CopyExtendSoToCommonSoPathSuccess)
{
    MOCKER(PackSystem).stubs().will(returnValue(0)).then(returnValue(1));
    const std::string soInstallPath = "/usr/lib64/aicpu_kernels/0";
    TSD_StatusT ret = AicpuPackageProcess::CopyExtendSoToCommonSoPath(soInstallPath, true);
    EXPECT_EQ(ret, TSD_OK);
    ret = AicpuPackageProcess::CopyExtendSoToCommonSoPath(soInstallPath, false);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, CopyExtendSoToCommonSoPathAsanFail)
{
    MOCKER(PackSystem).stubs().will(returnValue(1));
    const std::string soInstallPath = "/usr/lib64/aicpu_kernels/0";
    TSD_StatusT ret = AicpuPackageProcess::CopyExtendSoToCommonSoPath(soInstallPath, true);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuPackageProcessTest, WalkInVersionFileMemsetFail)
{
    const std::string soInstallPath = "";
    const auto handler = [] (const std::string &line) -> bool {
        return true;
    };
    MOCKER(memset_s).stubs().will(returnValue(-1));
    const TSD_StatusT ret = AicpuPackageProcess::WalkInVersionFile(soInstallPath, handler);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}