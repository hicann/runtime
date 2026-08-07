/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstring>
#include <fstream>
#include <iostream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "error_code.h"
#include "tsd_util_func.h"
#include "package_worker_utils.h"
#define private public
#define protected public
#include "aicpu_package_process.h"
#undef private
#undef protected

using namespace tsd;

namespace {
constexpr const char* OPEN_FAIL_VERSION_INFO_PATH = "/tmp/cann_runtime_ut_nonexistent_version.info";

char* RealpathFakeOpenFail(const char* path, char* resolvedPath)
{
    (void)path;
    if (resolvedPath == nullptr) {
        return nullptr;
    }

    const size_t pathLen = std::strlen(OPEN_FAIL_VERSION_INFO_PATH);
    if (pathLen >= PATH_MAX) {
        return nullptr;
    }

    const auto ret = memcpy_s(resolvedPath, PATH_MAX, OPEN_FAIL_VERSION_INFO_PATH, pathLen + 1U);
    if (ret != EOK) {
        return nullptr;
    }
    return resolvedPath;
}

bool CreateVersionFile(const std::string& dirPath)
{
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

void ClearDir(const std::string& dirPath)
{
    if (dirPath.empty()) {
        return;
    }
    const std::string cmd = "rm -rf " + dirPath;
    PackSystem(cmd.c_str());
}
} // namespace

class AicpuPackageProcessTest : public testing::Test {
protected:
    void SetUp() override
    {
        char dirTemplate[] = "/tmp/aicpu_package_process_ut_XXXXXX";
        char* dir = mkdtemp(dirTemplate);
        ASSERT_NE(dir, nullptr);
        soInstallPath_ = std::string(dir) + "/";
    }

    void TearDown() override
    {
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            ClearDir(soInstallPath_);
            throw;
        }
        GlobalMockObject::reset();
        ClearDir(soInstallPath_);
    }

    std::string soInstallPath_;
};

TEST_F(AicpuPackageProcessTest, CheckPackageName_SourceMatchesVersionFile_ReturnsOk)
{
    ASSERT_TRUE(CreateVersionFile(soInstallPath_));
    const std::string packageName = "/test/asd/Ascend910-aicpu_syskernels.tar.gz";
    const TSD_StatusT ret = AicpuPackageProcess::CheckPackageName(soInstallPath_, packageName);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuPackageProcessTest, CheckPackageName_VersionFileMissing_ReturnsInternalError)
{
    const std::string soInstallPath = "/usr/lib64/aicpu_kernels/0";
    const std::string packageName = "/test/asd/Ascend_test_tsd.tar.gz";
    const TSD_StatusT ret = AicpuPackageProcess::CheckPackageName(soInstallPath, packageName);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, CheckPackageName_SourceNameContainsInvalidCharacter_ReturnsStartFail)
{
    const std::string soInstallPath = "/usr/lib64/aicpu_kernels/0";
    const std::string packageName = "/test/asd/_test?_tsd.tar.gz";
    const TSD_StatusT ret = AicpuPackageProcess::CheckPackageName(soInstallPath, packageName);
    EXPECT_EQ(ret, TSD_START_FAIL);
}

TEST_F(AicpuPackageProcessTest, CheckPackageName_SourceDiffersFromVersionFile_ReturnsInternalError)
{
    ASSERT_TRUE(CreateVersionFile(soInstallPath_));
    const std::string packageName = "/test/asd/Ascend-ai_sys.tar.gz";
    const TSD_StatusT ret = AicpuPackageProcess::CheckPackageName(soInstallPath_, packageName);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, MoveSoToSandBox_VersionListsSandboxSo_ReturnsOk)
{
    ASSERT_TRUE(CreateVersionFile(soInstallPath_));
    MOCKER(rename).stubs().will(returnValue(0));
    TSD_StatusT ret = AicpuPackageProcess::MoveSoToSandBox(soInstallPath_);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuPackageProcessTest, MoveSoToSandBox_VersionWalkFails_ReturnsInternalError)
{
    ASSERT_TRUE(CreateVersionFile(soInstallPath_));
    MOCKER(rename).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuPackageProcess::WalkInVersionFile)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    TSD_StatusT ret = AicpuPackageProcess::MoveSoToSandBox(soInstallPath_);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, MoveSoToSandBox_SandboxDirectoryCreationFails_ReturnsInternalError)
{
    ASSERT_TRUE(CreateVersionFile(soInstallPath_));
    MOCKER(rename).stubs().will(returnValue(0));
    MOCKER_CPP(PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    TSD_StatusT ret = AicpuPackageProcess::MoveSoToSandBox(soInstallPath_);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, IsSoExist_PathMissingThenAccessible_ReturnsFalseThenTrue)
{
    EXPECT_EQ(AicpuPackageProcess::IsSoExist(0U), false);
    MOCKER(access).stubs().will(returnValue(0));
    EXPECT_EQ(AicpuPackageProcess::IsSoExist(0U), true);
}

TEST_F(AicpuPackageProcessTest, CopyExtendSoToCommonSoPath_AsanAndNormalModes_HandleCommandResult)
{
    MOCKER(PackSystem).stubs().will(returnValue(0)).then(returnValue(1));
    const std::string soInstallPath = "/usr/lib64/aicpu_kernels/0";
    TSD_StatusT ret = AicpuPackageProcess::CopyExtendSoToCommonSoPath(soInstallPath, true);
    EXPECT_EQ(ret, TSD_OK);
    ret = AicpuPackageProcess::CopyExtendSoToCommonSoPath(soInstallPath, false);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, CopyExtendSoToCommonSoPath_AsanCommandFails_StillReturnsOk)
{
    MOCKER(PackSystem).stubs().will(returnValue(1));
    const std::string soInstallPath = "/usr/lib64/aicpu_kernels/0";
    TSD_StatusT ret = AicpuPackageProcess::CopyExtendSoToCommonSoPath(soInstallPath, true);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuPackageProcessTest, WalkInVersionFile_MemsetFails_ReturnsInternalError)
{
    const std::string soInstallPath = "";
    const auto handler = [](const std::string& line) -> bool { return true; };
    MOCKER(memset_s).stubs().will(returnValue(-1));
    const TSD_StatusT ret = AicpuPackageProcess::WalkInVersionFile(soInstallPath, handler);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuPackageProcessTest, WalkInVersionFile_FileOpenFails_ReturnsInternalError)
{
    const std::string soInstallPath = "/tmp/";
    const auto handler = [](const std::string& line) -> bool {
        (void)line;
        return false;
    };

    MOCKER(realpath).stubs().will(invoke(RealpathFakeOpenFail));
    const TSD_StatusT ret = AicpuPackageProcess::WalkInVersionFile(soInstallPath, handler);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}
