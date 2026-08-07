/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <vector>
#include "package_worker_utils.h"
#define private public
#define protected public
#include "aicpu_package_process.h"
#include "aicpu_thread_package_worker.h"
#undef private
#undef protected

using namespace tsd;

namespace {
std::string GetDirName()
{
    std::unique_ptr<char_t[]> path(new (std::nothrow) char_t[PATH_MAX]);
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

    return dirPath;
}
std::string g_curWorkDir = "";
std::vector<std::string> g_packCommands;

int32_t CapturePackSystem(const char* command)
{
    g_packCommands.emplace_back(command == nullptr ? "" : command);
    return 0;
}
} // namespace

class AicpuThreadPackageWorkerTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        g_curWorkDir = GetDirName();
        g_packCommands.clear();
        MOCKER(getenv).stubs().will(returnValue(const_cast<char*>(g_curWorkDir.c_str())));
    }

    virtual void TearDown()
    {
        std::string extendFileName = g_curWorkDir + "extend_aicpu_package_install.info";
        std::string aicpuFileName = g_curWorkDir + "aicpu_package_install.info";
        (void)remove(extendFileName.c_str());
        (void)remove(aicpuFileName.c_str());
        g_curWorkDir = "";
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            throw;
        }
        GlobalMockObject::reset();
    }
};

TEST_F(AicpuThreadPackageWorkerTest, LoadPackage_AllProcessingStepsSucceed_InvokesEachStepOnce)
{
    AicpuThreadPackageWorker inst({0U, 0U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP(&AicpuThreadPackageWorker::GetOriginPackageSize).stubs().will(returnValue(static_cast<uint64_t>(1U)));
    const std::string decomDir = g_curWorkDir + "/";
    const std::string decomPackage = decomDir + name;
    const std::string installRoot = decomDir + "aicpu_kernels/0/";
    const std::string installPath = installRoot + "aicpu_kernels_device/";
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage).expects(once()).with(decomPackage).will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).expects(once()).with(decomDir).will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::CheckPackageName)
        .expects(once())
        .with(installPath, name)
        .will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::MoveSoToSandBox).expects(once()).with(installPath).will(returnValue(TSD_OK));
    MOCKER(PackSystem).expects(exactly(2)).will(invoke(CapturePackSystem));

    EXPECT_EQ(inst.LoadPackage(path, name), TSD_OK);
    EXPECT_EQ(inst.GetPackageCheckCode(), 1U);
    ASSERT_EQ(g_packCommands.size(), 2U);
    EXPECT_EQ(g_packCommands[0], "cp '/home/test/Ascend-aicpu_syskernels.tar.gz' '" + decomPackage + "'");
    EXPECT_EQ(
        g_packCommands[1],
        "mkdir -p " + installRoot + " ; tar --no-same-owner -ozxf " + decomPackage + " -C " + installRoot);
}

TEST_F(AicpuThreadPackageWorkerTest, LoadExtendPackage_AllStepsSucceed_ReturnsOk)
{
    ExtendThreadPackageWorker inst({0U, 0U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP(&ExtendThreadPackageWorker::GetOriginPackageSize).stubs().will(returnValue(3U));
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::CheckPackageName).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::MoveSoToSandBox).stubs().will(returnValue(TSD_OK));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_OK);
    ret = inst.UnloadPackage();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuThreadPackageWorkerTest, LoadPackage_NeedLoadAndPostProcessSucceeds_ReturnsOk)
{
    AicpuThreadPackageWorker inst({0U, 0U});
    inst.SetCheckCode(1);
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    inst.PreProcessPackage(path, name);
    inst.decomPackagePath_ = BasePackageWorker::PackagePath(path, name);
    MOCKER_CPP_VIRTUAL(inst, &AicpuThreadPackageWorker::IsNeedLoadPackage).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP_VIRTUAL(inst, &AicpuThreadPackageWorker::PostProcessPackage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage).stubs().will(returnValue(TSD_OK));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.LoadPackage(path, name);

    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuThreadPackageWorkerTest, LoadPackage_MoveSucceedsAndVerifyFails_ReturnsVerifyError)
{
    AicpuThreadPackageWorker inst({0U, 0U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    const std::string decomDir = g_curWorkDir + "/";
    const std::string decomPackage = decomDir + name;
    MOCKER_CPP_VIRTUAL(inst, &AicpuThreadPackageWorker::IsNeedLoadPackage).expects(once()).will(returnValue(true));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).expects(once()).with(decomDir).will(returnValue(TSD_OK));
    MOCKER(PackSystem).expects(once()).will(invoke(CapturePackSystem));
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage)
        .expects(once())
        .with(decomPackage)
        .will(returnValue(static_cast<TSD_StatusT>(TSD_VERIFY_OPP_FAIL)));
    MOCKER_CPP_VIRTUAL(static_cast<BasePackageWorker&>(inst), &BasePackageWorker::DecompressPackage).expects(never());
    MOCKER_CPP_VIRTUAL(inst, &AicpuThreadPackageWorker::PostProcessPackage).expects(never());

    const auto ret = inst.LoadPackage(path, name);

    EXPECT_EQ(ret, TSD_VERIFY_OPP_FAIL);
    ASSERT_EQ(g_packCommands.size(), 1U);
    EXPECT_EQ(g_packCommands[0], "cp '/home/test/Ascend-aicpu_syskernels.tar.gz' '" + decomPackage + "'");
}

TEST_F(AicpuThreadPackageWorkerTest, LoadPackage_VerifyAndDecompressSucceedButPostProcessFails_ReturnsInternalError)
{
    AicpuThreadPackageWorker inst({0U, 0U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    const std::string decomDir = g_curWorkDir + "/";
    const std::string decomPackage = decomDir + name;
    const std::string installRoot = decomDir + "aicpu_kernels/0/";
    MOCKER_CPP_VIRTUAL(inst, &AicpuThreadPackageWorker::IsNeedLoadPackage).expects(once()).will(returnValue(true));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).expects(once()).with(decomDir).will(returnValue(TSD_OK));
    MOCKER(PackSystem).expects(exactly(2)).will(invoke(CapturePackSystem));
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage).expects(once()).with(decomPackage).will(returnValue(TSD_OK));
    MOCKER_CPP_VIRTUAL(inst, &AicpuThreadPackageWorker::PostProcessPackage)
        .expects(once())
        .will(returnValue(static_cast<TSD_StatusT>(TSD_INTERNAL_ERROR)));

    const auto ret = inst.LoadPackage(path, name);

    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
    ASSERT_EQ(g_packCommands.size(), 2U);
    EXPECT_EQ(g_packCommands[0], "cp '/home/test/Ascend-aicpu_syskernels.tar.gz' '" + decomPackage + "'");
    EXPECT_EQ(
        g_packCommands[1],
        "mkdir -p " + installRoot + " ; tar --no-same-owner -ozxf " + decomPackage + " -C " + installRoot);
}

TEST_F(AicpuThreadPackageWorkerTest, IsNeedLoadPackage_VerifyFileClosed_ReturnsFalse)
{
    AicpuThreadPackageWorker inst({0U, 0U});
    inst.SetCheckCode(1);
    inst.SetOriginPackageSize(2);
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    auto ret = inst.IsNeedLoadPackage();
    EXPECT_EQ(ret, false);
    inst.GetMovePackageToDecompressDirCmd();
    inst.GetDecompressPackageCmd();
}

TEST_F(AicpuThreadPackageWorkerTest, LoadPackage_RepeatedPackageSizeMatches_ReturnsOk)
{
    AicpuThreadPackageWorker inst({0U, 0U});
    inst.SetCheckCode(1);
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP_VIRTUAL(inst, &AicpuThreadPackageWorker::PostProcessPackage).stubs().will(returnValue(0U));
    MOCKER_CPP(&PackageWorkerUtils::GetFileSize).stubs().will(returnValue(1));
    MOCKER_CPP(PackageWorkerUtils::VerifyPackage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_OK);
    ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuThreadPackageWorkerTest, UnloadPackage_Always_ReturnsOk)
{
    AicpuThreadPackageWorker inst({0U, 0U});
    MOCKER(PackSystem).stubs().will(returnValue(0));
    const auto ret = inst.UnloadPackage();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuThreadPackageWorkerTest, PostProcessPackage_MoveToSandboxFails_StillReturnsOk)
{
    AicpuThreadPackageWorker inst({0U, 0U});
    MOCKER_CPP(&AicpuPackageProcess::CheckPackageName).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::MoveSoToSandBox)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = inst.PostProcessPackage();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuThreadPackageWorkerTest, ExtendPostProcess_CopySucceeds_ReturnsOk)
{
    ExtendThreadPackageWorker inst({0U, 0U});

    MOCKER_CPP(&AicpuPackageProcess::CopyExtendSoToCommonSoPath)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_OK)));
    const TSD_StatusT ret = inst.PostProcessPackage();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuThreadPackageWorkerTest, ExtendPostProcess_CopyFails_PropagatesError)
{
    ExtendThreadPackageWorker inst({0U, 0U});

    MOCKER_CPP(&AicpuPackageProcess::CopyExtendSoToCommonSoPath)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const TSD_StatusT ret = inst.PostProcessPackage();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}
