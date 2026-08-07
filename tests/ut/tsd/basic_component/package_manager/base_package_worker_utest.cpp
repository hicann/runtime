/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_manager_test_common.h"
#include "package_worker_utils.h"
#define private public
#define protected public
#include "package_worker_factory.h"
#undef private
#undef protected

using namespace tsd;
using namespace tsdtest;
using namespace std;

namespace {
class ObservableBasePackageWorker : public BasePackageWorker {
public:
    ObservableBasePackageWorker() : BasePackageWorker({0U, 0U}) {}
    TSD_StatusT LoadPackage(const std::string&, const std::string&) override { return TSD_OK; }
    TSD_StatusT UnloadPackage() override { return TSD_OK; }
    void SetDecompressPackagePath() override
    {
        decomPackagePath_ = PackagePath("/decompress", originPackagePath_.name);
    }
    std::string GetMovePackageToDecompressDirCmd() const override { return "move"; }
    std::string GetDecompressPackageCmd() const override { return "decompress"; }
};
} // namespace

class BasePackageWorkerComponentTest : public PackageManagerComponentTest {};

TEST_F(BasePackageWorkerComponentTest, GetPackageCheckCode_NewWorker_ReturnsZero)
{
    PackageWorkerParas paras;
    auto worker =
        PackageWorkerFactory::GetInstance().CreatePackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, paras);
    EXPECT_EQ(worker->GetPackageCheckCode(), 0UL);
}

TEST_F(BasePackageWorkerComponentTest, IsNeedLoadPackage_CodeMatchesSize_ReturnsFalse)
{
    ObservableBasePackageWorker worker;
    worker.SetOriginPackageSize(4096U);
    worker.SetCheckCode(4096U);
    EXPECT_FALSE(worker.IsNeedLoadPackage());

    worker.SetCheckCode(4095U);
    EXPECT_TRUE(worker.IsNeedLoadPackage());
}

TEST_F(BasePackageWorkerComponentTest, IsNeedUnloadPackage_ZeroCode_ReturnsFalse)
{
    PackageWorkerParas paras;
    auto worker =
        PackageWorkerFactory::GetInstance().CreatePackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, paras);
    EXPECT_FALSE(worker->IsNeedUnloadPackage());
}

TEST_F(BasePackageWorkerComponentTest, PreProcessPackage_ValidInput_SetsPathsAndSize)
{
    ObservableBasePackageWorker worker;
    const std::string expectedOriginPath = "/origin/pkg.tar.gz";
    MOCKER_CPP(&PackageWorkerUtils::GetFileSize)
        .expects(once())
        .with(expectedOriginPath)
        .will(returnValue(static_cast<uint64_t>(8192U)));

    worker.PreProcessPackage("/origin", "pkg.tar.gz");

    EXPECT_EQ(worker.originPackagePath_.path, "/origin/");
    EXPECT_EQ(worker.originPackagePath_.name, "pkg.tar.gz");
    EXPECT_EQ(worker.originPackagePath_.realPath, "/origin/pkg.tar.gz");
    EXPECT_EQ(worker.decomPackagePath_.path, "/decompress/");
    EXPECT_EQ(worker.decomPackagePath_.realPath, "/decompress/pkg.tar.gz");
    EXPECT_EQ(worker.GetOriginPackageSize(), 8192U);
}
