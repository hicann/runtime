/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <thread>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "inc/aicpu_package_process.h"
#include "inc/aicpu_process_package_worker.h"
#include "inc/package_worker_utils.h"
#include "inc/process_util_common.h"
#undef private
#undef protected

using namespace tsd;

class AicpuProcessPackageWorkerTest : public testing::Test {
protected:
    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(AicpuProcessPackageWorkerTest, LoadAndUnloadPackageSuccess)
{
    AicpuProcessPackageWorker inst({0U, 0U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP(&AicpuProcessPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1U));
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

TEST_F(AicpuProcessPackageWorkerTest, LoadPackagePostProcessFail)
{
    AicpuProcessPackageWorker inst({0U, 0U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP(&AicpuProcessPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1U));
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::CheckPackageName).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&AicpuPackageProcess::MoveSoToSandBox).stubs().will(returnValue(TSD_OK));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, LoadAndUnloadExtendPackageESuccess)
{
    ExtendProcessPackageWorker inst({0U, 0U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP(&ExtendProcessPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1U));
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

TEST_F(AicpuProcessPackageWorkerTest, LoadPackageVfSuccess)
{
    AicpuProcessPackageWorker inst({0U, 1U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP(&AicpuProcessPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1U));
    MOCKER_CPP(&PackageWorkerUtils::IsCgroupMemMode).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageWorkerUtils::CheckMemoryUsage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::RestoreMemUsage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::CheckPackageName).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::MoveSoToSandBox).stubs().will(returnValue(TSD_OK));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, LoadPackageVfRestoreMemFail)
{
    AicpuProcessPackageWorker inst({0U, 1U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP(&AicpuProcessPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1U));
    MOCKER_CPP(&PackageWorkerUtils::IsCgroupMemMode).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageWorkerUtils::CheckMemoryUsage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::RestoreMemUsage).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::CheckPackageName).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::MoveSoToSandBox).stubs().will(returnValue(TSD_OK));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, LoadPackageVfFail)
{
    AicpuProcessPackageWorker inst({0U, 1U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP(&AicpuProcessPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1U));
    MOCKER_CPP(&PackageWorkerUtils::IsCgroupMemMode).stubs().will(returnValue(true));
    MOCKER_CPP(&PackageWorkerUtils::VerifyPackage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::CheckPackageName).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::MoveSoToSandBox).stubs().will(returnValue(TSD_OK));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, LoadPackageNoNeedLoad)
{
    AicpuProcessPackageWorker inst({0U, 0U});
    inst.SetCheckCode(1);
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP_VIRTUAL(inst, &AicpuProcessPackageWorker::PostProcessPackage).stubs().will(returnValue(0U));
    MOCKER_CPP(&PackageWorkerUtils::GetFileSize).stubs().will(returnValue(1));
    MOCKER_CPP(PackageWorkerUtils::VerifyPackage).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::MakeDirectory).stubs().will(returnValue(TSD_OK));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_OK);
    ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, LoadPackageVerifyFail)
{
    AicpuProcessPackageWorker inst({0U, 0U});
    const std::string path = "/home/test";
    const std::string name = "Ascend-aicpu_syskernels.tar.gz";
    MOCKER_CPP(&AicpuProcessPackageWorker::GetOriginPackageSize).stubs().will(returnValue(1));
    MOCKER_CPP(PackageWorkerUtils::VerifyPackage).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.LoadPackage(path, name);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, UnloadPackageSuccess)
{
    AicpuProcessPackageWorker inst({0U, 0U});
    MOCKER(PackSystem).stubs().will(returnValue(0));
    const auto ret = inst.UnloadPackage();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, CgroupMemMode)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessUtilCommon::ReadCurMemCtrolType).stubs().will(returnValue(TSD_OK));
    const auto ret = PackageWorkerUtils::IsCgroupMemMode(0, 0);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuProcessPackageWorkerTest, CgroupMemModeFail1)
{
    MOCKER(access).stubs().will(returnValue(1));
    MOCKER_CPP(&ProcessUtilCommon::ReadCurMemCtrolType).stubs().will(returnValue(TSD_OK));
    const auto ret = PackageWorkerUtils::IsCgroupMemMode(0, 0);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuProcessPackageWorkerTest, CgroupMemModeFail2)
{
    MOCKER(access).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER_CPP(&ProcessUtilCommon::ReadCurMemCtrolType).stubs().will(returnValue(TSD_OK));
    const auto ret = PackageWorkerUtils::IsCgroupMemMode(0, 0);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuProcessPackageWorkerTest, CgroupMemModeFail3)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&ProcessUtilCommon::ReadCurMemCtrolType).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = PackageWorkerUtils::IsCgroupMemMode(0, 0);
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuProcessPackageWorkerTest, CheckMemoryUsageAccessFail)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryLimit).stubs().will(returnValue(TSD_OK));
    std::string soInstallRootPath;
    std::string memoryLimitFilePath;
    std::string memoryUsedFilePath;
    const auto ret = PackageWorkerUtils::CheckMemoryUsage(soInstallRootPath, memoryLimitFilePath,
                                                          memoryUsedFilePath, 0, 0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, CheckMemoryUsageGetUserMemoryFail)
{
    MOCKER(access).stubs().will(returnValue(1));
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryLimit).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryUsed).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    std::string soInstallRootPath;
    std::string memoryLimitFilePath;
    std::string memoryUsedFilePath;
    const auto ret = PackageWorkerUtils::CheckMemoryUsage(soInstallRootPath, memoryLimitFilePath,
                                                          memoryUsedFilePath, 0, 0);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, CheckMemoryUsageCheckFail)
{
    MOCKER(access).stubs().will(returnValue(1));
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryLimit).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryUsed).stubs().will(returnValue(TSD_OK));
    std::string soInstallRootPath;
    std::string memoryLimitFilePath;
    std::string memoryUsedFilePath;
    const auto ret = PackageWorkerUtils::CheckMemoryUsage(soInstallRootPath, memoryLimitFilePath,
                                                          memoryUsedFilePath, 0, 0);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, GetUserMemoryUsedSuccess)
{
    MOCKER_CPP(&PackageWorkerUtils::ReadMemControlValue).stubs().will(returnValue(TSD_OK));
    uint64_t userMemoryUsed = 0UL;
    std::string memoryUsedFilePath;
    const auto ret = PackageWorkerUtils::GetUserMemoryUsed(userMemoryUsed, memoryUsedFilePath);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, GetUserMemoryUsedFail)
{
    MOCKER_CPP(&PackageWorkerUtils::ReadMemControlValue).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    uint64_t userMemoryUsed = 0UL;
    std::string memoryUsedFilePath;
    const auto ret = PackageWorkerUtils::GetUserMemoryUsed(userMemoryUsed, memoryUsedFilePath);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, RestoreMemUsageSuccess)
{
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryLimit).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::SetMemoryControlValue).stubs().will(returnValue(TSD_OK));
    std::string memoryLimitFilePath;
    const auto ret = PackageWorkerUtils::RestoreMemUsage(1, 0, 0, 0, memoryLimitFilePath);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, RestoreMemUsageGetLimitFail)
{
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryLimit).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    std::string memoryLimitFilePath;
    const auto ret = PackageWorkerUtils::RestoreMemUsage(1, 0, 0, 0, memoryLimitFilePath);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, RestoreMemUsageOverflow)
{
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryLimit).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::SetMemoryControlValue).stubs().will(returnValue(TSD_OK));
    std::string memoryLimitFilePath;
    const auto ret = PackageWorkerUtils::RestoreMemUsage(ULLONG_MAX, 0, 0, 0, memoryLimitFilePath);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, RestoreMemUsageOom)
{
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryLimit).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::SetMemoryControlValue).stubs().will(returnValue(TSD_OK));
    std::string memoryLimitFilePath;
    const auto ret = PackageWorkerUtils::RestoreMemUsage(0, ULLONG_MAX, 0, 0, memoryLimitFilePath);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, RestoreMemUsageSetFail)
{
    MOCKER_CPP(&PackageWorkerUtils::GetUserMemoryLimit).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&PackageWorkerUtils::SetMemoryControlValue).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    std::string memoryLimitFilePath;
    const auto ret = PackageWorkerUtils::RestoreMemUsage(1, 0, 0, 0, memoryLimitFilePath);
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(AicpuProcessPackageWorkerTest, SetMemoryControlValueSuccess0)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(PackSystem).stubs().will(returnValue(0));
    const auto ret = PackageWorkerUtils::SetMemoryControlValue(1, 0, 0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, SetMemoryControlValueSuccess1)
{
    MOCKER(access).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(PackSystem).stubs().will(returnValue(0));
     const auto ret = PackageWorkerUtils::SetMemoryControlValue(1, 0, 0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, SetMemoryControlValueSuccess2)
{
    MOCKER(access).stubs().will(returnValue(1));
    MOCKER(PackSystem).stubs().will(returnValue(0));
     const auto ret = PackageWorkerUtils::SetMemoryControlValue(1, 0, 0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, SetMemoryControlValueSuccess3)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(PackSystem).stubs().will(returnValue(1));
    MOCKER(mmSleep).stubs().will(returnValue(0));
    const auto ret = PackageWorkerUtils::SetMemoryControlValue(1, 0, 0);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, PostProcessPackageMoveSoFail)
{
    AicpuProcessPackageWorker inst({0U, 0U});
    MOCKER_CPP(&AicpuPackageProcess::CheckPackageName).stubs().will(returnValue(TSD_OK));
    MOCKER_CPP(&AicpuPackageProcess::MoveSoToSandBox).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const auto ret = inst.PostProcessPackage();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AicpuProcessPackageWorkerTest, GetPackageCheckCodeSoNotExist)
{
    AicpuProcessPackageWorker inst({0U, 0U});
    inst.SetCheckCode(123);
    MOCKER_CPP(&AicpuPackageProcess::IsSoExist).stubs().will(returnValue(false));
    const auto ret = inst.GetPackageCheckCode();
    EXPECT_EQ(ret, 0UL);
    EXPECT_EQ(inst.GetCheckCode(), 0UL);
}

TEST_F(AicpuProcessPackageWorkerTest, GetPackageCheckCodeSoExist)
{
    AicpuProcessPackageWorker inst({0U, 0U});
    inst.SetCheckCode(123UL);
    MOCKER_CPP(&AicpuPackageProcess::IsSoExist).stubs().will(returnValue(true));
    const auto ret = inst.GetPackageCheckCode();
    EXPECT_EQ(ret, 123UL);
    EXPECT_EQ(inst.GetCheckCode(), 123UL);
}

TEST_F(AicpuProcessPackageWorkerTest, CheckSumOppVerifyFail)
{
    AicpuProcessPackageWorker inst({0U, 0U});
    inst.isVerifyOppFail_ = true;
    const uint64_t curCode = 123UL;
    inst.SetCheckCode(curCode);

    TSD_StatusT ret = TSD_OK;
    std::thread th([&inst, &ret, &curCode]() {
        ret = inst.CheckSum(curCode);
    });
    if (th.joinable()) {
        th.join();
    }

    EXPECT_EQ(inst.GetCheckCode(), curCode);
}

TEST_F(AicpuProcessPackageWorkerTest, ExtendPostProcessFail)
{
    ExtendProcessPackageWorker inst({0U, 0U});

    MOCKER_CPP(&AicpuPackageProcess::CopyExtendSoToCommonSoPath).stubs()
        .will(returnValue(static_cast<uint32_t>(TSD_INTERNAL_ERROR)));
    const TSD_StatusT ret = inst.PostProcessPackage();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

class AscendcppProcessPackageWorkerTest : public testing::Test {
protected:
    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(AscendcppProcessPackageWorkerTest, GetDecompressPackageCmd)
{
    const AscendcppProcessPackageWorker inst({0U, 0U});
    std::string cmd = inst.GetDecompressPackageCmd();
    EXPECT_NE(cmd, ""); // cmd = rm -rf  ; tar -xf  -C 
}

TEST_F(AscendcppProcessPackageWorkerTest, PostProcessPackage001)
{
    AscendcppProcessPackageWorker inst({0U, 0U});
    MOCKER(PackSystem).stubs().will(returnValue(0));
    auto ret = inst.PostProcessPackage();
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(AscendcppProcessPackageWorkerTest, PostProcessPackage002)
{
    AscendcppProcessPackageWorker inst({0U, 0U});
    MOCKER(PackSystem).stubs().will(returnValue(1));
    auto ret = inst.PostProcessPackage();
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}