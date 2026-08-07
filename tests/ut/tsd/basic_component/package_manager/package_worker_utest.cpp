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

#define private public
#define protected public
#include "package_worker.h"
#undef private
#undef protected
#include "package_worker_utils.h"

using namespace tsd;

class PackageWorkerTest : public testing::Test {
protected:
    using WorkerArray = decltype(PackageWorker::workers_);

    void SetUp() override
    {
        savedWorkerManager_ = PackageWorker::workerManager_;
        for (const auto& item : savedWorkerManager_) {
            savedWorkerState_.emplace(item.first, std::make_pair(item.second->workers_, item.second->isDestroy_));
        }
        PackageWorker::workerManager_.clear();
    }

    void TearDown() override
    {
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            RestoreWorkerState();
            throw;
        }
        GlobalMockObject::reset();
        RestoreWorkerState();
    }

private:
    void RestoreWorkerState()
    {
        PackageWorker::workerManager_.clear();
        for (const auto& item : savedWorkerState_) {
            const auto manager = savedWorkerManager_.at(item.first);
            manager->workers_ = item.second.first;
            manager->isDestroy_ = item.second.second;
        }
        PackageWorker::workerManager_ = savedWorkerManager_;
    }

    std::map<std::pair<uint32_t, uint32_t>, std::shared_ptr<PackageWorker>> savedWorkerManager_;
    std::map<std::pair<uint32_t, uint32_t>, std::pair<WorkerArray, bool>> savedWorkerState_;
};

TEST_F(PackageWorkerTest, DestroyPackageWorker_ExistingManager_RemovesManager)
{
    std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0);
    packageWorker->DestroyPackageWorker();
    EXPECT_EQ(PackageWorker::workerManager_.size(), 0);
}

TEST_F(PackageWorkerTest, LoadPackage_InvalidWorkerType_ReturnsNotFound)
{
    std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0);
    const auto ret = packageWorker->LoadPackage(PackageWorkerType::PACKAGE_WORKER_MAX, "", "");
    EXPECT_EQ(ret, TSD_INSTANCE_NOT_FOUND);
}

TEST_F(PackageWorkerTest, UnloadPackage_ExistingWorker_ReturnsOk)
{
    PackageWorkerParas paras;
    PackageWorkerFactory& inst = PackageWorkerFactory().GetInstance();
    std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0);
    auto reworker = inst.CreatePackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, paras);
    MOCKER_CPP(&PackageWorker::GetPackageWorker).stubs().will(returnValue(reworker));
    const auto ret = packageWorker->UnloadPackage(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD);
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageWorkerTest, LoadPackage_WorkerLookupReturnsNull_ReturnsNotFound)
{
    std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0);
    MOCKER_CPP(&PackageWorker::GetPackageWorker).stubs().will(returnValue(std::shared_ptr<BasePackageWorker>()));
    const auto ret = packageWorker->LoadPackage(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, "p", "f");
    EXPECT_EQ(ret, TSD_INSTANCE_NOT_FOUND);
}

TEST_F(PackageWorkerTest, UnloadPackage_WorkerLookupReturnsNull_ReturnsNotFound)
{
    std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0);
    MOCKER_CPP(&PackageWorker::GetPackageWorker).stubs().will(returnValue(std::shared_ptr<BasePackageWorker>()));
    const auto ret = packageWorker->UnloadPackage(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD);
    EXPECT_EQ(ret, TSD_INSTANCE_NOT_FOUND);
}

TEST_F(PackageWorkerTest, GetPackageCheckCode_WorkerLookupReturnsNull_ReturnsZero)
{
    std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0);
    MOCKER_CPP(&PackageWorker::GetPackageWorker).stubs().will(returnValue(std::shared_ptr<BasePackageWorker>()));
    const auto code = packageWorker->GetPackageCheckCode(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD);
    EXPECT_EQ(code, 0UL);
}

TEST_F(PackageWorkerTest, GetPackageCheckCode_WorkerHasNonzeroCode_ReturnsCode)
{
    PackageWorkerParas paras;
    auto packageWorker = PackageWorker::GetInstance(0, 0);
    auto reworker =
        PackageWorkerFactory::GetInstance().CreatePackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, paras);
    reworker->SetCheckCode(2026U);
    packageWorker->workers_[static_cast<size_t>(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD)] = reworker;

    EXPECT_EQ(packageWorker->GetPackageCheckCode(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD), 2026U);
}

TEST_F(PackageWorkerTest, ClearPackageCheckCode_WorkerHasNonzeroCode_ResetsCode)
{
    PackageWorkerParas paras;
    auto packageWorker = PackageWorker::GetInstance(0, 0);
    auto reworker =
        PackageWorkerFactory::GetInstance().CreatePackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, paras);
    reworker->SetCheckCode(2026U);
    packageWorker->workers_[static_cast<size_t>(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD)] = reworker;
    packageWorker->ClearPackageCheckCode(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD);

    EXPECT_EQ(packageWorker->GetPackageCheckCode(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD), 0U);
}

TEST_F(PackageWorkerTest, GetPackageWorker_DestroyReturnNull)
{
    std::shared_ptr<PackageWorker> packageWorker = PackageWorker::GetInstance(0, 0);
    packageWorker->isDestroy_ = true;
    auto worker = packageWorker->GetPackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD);
    EXPECT_EQ(worker, nullptr);
    packageWorker->isDestroy_ = false;
}

TEST_F(PackageWorkerTest, SetAsanMode_AppliesToAllWorkers)
{
    auto packageWorker = PackageWorker::GetInstance(0, 0);
    PackageWorkerParas paras;
    packageWorker->workers_[0] =
        PackageWorkerFactory::GetInstance().CreatePackageWorker(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, paras);
    packageWorker->workers_[1] =
        PackageWorkerFactory::GetInstance().CreatePackageWorker(PackageWorkerType::PACKAGE_WORKER_EXTEND_THREAD, paras);
    packageWorker->SetAsanMode(true);
    EXPECT_TRUE(packageWorker->workers_[0]->IsAsanMode());
    EXPECT_TRUE(packageWorker->workers_[1]->IsAsanMode());
    packageWorker->SetAsanMode(false);
    EXPECT_FALSE(packageWorker->workers_[0]->IsAsanMode());
    EXPECT_FALSE(packageWorker->workers_[1]->IsAsanMode());
}
