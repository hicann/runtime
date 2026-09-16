/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_utest_api.hpp"

#include "api_snapshot.hpp"

using namespace cce::runtime;
using namespace testing;

namespace {
constexpr rtChipType_t kSnapshotSupportedChip = CHIP_910_B_93;
constexpr rtChipType_t kSnapshotUnsupportedChip = CHIP_CLOUD;

uint32_t SnapshotCallback(int32_t devId, void* args)
{
    UNUSED(devId);
    UNUSED(args);
    return 0U;
}

class ApiSnapshotRouteStub : public ApiSnapshot {
public:
    rtError_t SnapShotProcessLock() override
    {
        ++lockCount_;
        return lockRet_;
    }

    rtError_t SnapShotProcessUnlock() override
    {
        ++unlockCount_;
        return unlockRet_;
    }

    rtError_t SnapShotProcessBackup() override
    {
        ++backupCount_;
        return backupRet_;
    }

    rtError_t SnapShotProcessRestore() override
    {
        ++restoreCount_;
        return restoreRet_;
    }

    rtError_t SnapShotCallbackRegister(
        const rtSnapShotStage stage, const rtSnapShotCallBack callback, void* const args) override
    {
        ++registerCount_;
        registerStage_ = stage;
        registerCallback_ = callback;
        registerArgs_ = args;
        return registerRet_;
    }

    rtError_t SnapShotCallbackUnregister(const rtSnapShotStage stage, const rtSnapShotCallBack callback) override
    {
        ++unregisterCount_;
        unregisterStage_ = stage;
        unregisterCallback_ = callback;
        return unregisterRet_;
    }

    uint32_t lockCount_ = 0U;
    uint32_t unlockCount_ = 0U;
    uint32_t backupCount_ = 0U;
    uint32_t restoreCount_ = 0U;
    uint32_t registerCount_ = 0U;
    uint32_t unregisterCount_ = 0U;
    rtSnapShotStage registerStage_ = RT_SNAPSHOT_LOCK_PRE;
    rtSnapShotStage unregisterStage_ = RT_SNAPSHOT_LOCK_PRE;
    rtSnapShotCallBack registerCallback_ = nullptr;
    rtSnapShotCallBack unregisterCallback_ = nullptr;
    void* registerArgs_ = nullptr;
    rtError_t lockRet_ = RT_ERROR_NONE;
    rtError_t unlockRet_ = RT_ERROR_NONE;
    rtError_t backupRet_ = RT_ERROR_NONE;
    rtError_t restoreRet_ = RT_ERROR_NONE;
    rtError_t registerRet_ = RT_ERROR_NONE;
    rtError_t unregisterRet_ = RT_ERROR_NONE;
};

class ApiSnapshotRouteTest : public Test {
protected:
    void SetUp() override
    {
        runtime_ = Runtime::Instance();
        ASSERT_NE(runtime_, nullptr);
        oldApi_ = runtime_->api_;
        oldApiSnapshot_ = runtime_->apiSnapshot_;
        oldRuntimeChipType_ = runtime_->chipType_;
        oldGlobalChipType_ = GlobalContainer::GetRtChipType();
        runtime_->api_ = nullptr;
        runtime_->apiSnapshot_ = &apiSnapshot_;
        SetChipType(kSnapshotSupportedChip);
    }

    void TearDown() override
    {
        runtime_->api_ = oldApi_;
        runtime_->apiSnapshot_ = oldApiSnapshot_;
        runtime_->SetChipType(oldRuntimeChipType_);
        GlobalContainer::SetRtChipType(oldGlobalChipType_);
        GlobalMockObject::verify();
    }

    void SetChipType(const rtChipType_t chipType)
    {
        runtime_->SetChipType(chipType);
        GlobalContainer::SetRtChipType(chipType);
    }

    Runtime* runtime_ = nullptr;
    Api* oldApi_ = nullptr;
    ApiSnapshot* oldApiSnapshot_ = nullptr;
    rtChipType_t oldRuntimeChipType_ = CHIP_BEGIN;
    rtChipType_t oldGlobalChipType_ = CHIP_BEGIN;
    ApiSnapshotRouteStub apiSnapshot_;
};
} // namespace

TEST_F(ApiSnapshotRouteTest, RoutesApisToApiSnapshot)
{
    int32_t callbackArgs = 7;

    EXPECT_EQ(rtSnapShotProcessLock(), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSnapShotProcessBackup(), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSnapShotProcessRestore(), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSnapShotProcessUnlock(), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSnapShotCallbackRegister(RT_SNAPSHOT_LOCK_PRE, SnapshotCallback, &callbackArgs), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSnapShotCallbackUnregister(RT_SNAPSHOT_LOCK_PRE, SnapshotCallback), ACL_RT_SUCCESS);

    EXPECT_EQ(apiSnapshot_.lockCount_, 1U);
    EXPECT_EQ(apiSnapshot_.backupCount_, 1U);
    EXPECT_EQ(apiSnapshot_.restoreCount_, 1U);
    EXPECT_EQ(apiSnapshot_.unlockCount_, 1U);
    EXPECT_EQ(apiSnapshot_.registerCount_, 1U);
    EXPECT_EQ(apiSnapshot_.registerStage_, RT_SNAPSHOT_LOCK_PRE);
    EXPECT_EQ(apiSnapshot_.registerCallback_, SnapshotCallback);
    EXPECT_EQ(apiSnapshot_.registerArgs_, &callbackArgs);
    EXPECT_EQ(apiSnapshot_.unregisterCount_, 1U);
    EXPECT_EQ(apiSnapshot_.unregisterStage_, RT_SNAPSHOT_LOCK_PRE);
    EXPECT_EQ(apiSnapshot_.unregisterCallback_, SnapshotCallback);
}

TEST_F(ApiSnapshotRouteTest, PreservesErrorMapping)
{
    apiSnapshot_.lockRet_ = RT_ERROR_SNAPSHOT_LOCK_FAILED;
    EXPECT_EQ(rtSnapShotProcessLock(), ACL_ERROR_SNAPSHOT_LOCK_FAILED);

    apiSnapshot_.backupRet_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    EXPECT_EQ(rtSnapShotProcessBackup(), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    apiSnapshot_.restoreRet_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    EXPECT_EQ(rtSnapShotProcessRestore(), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiSnapshotRouteTest, ReturnsNotSupportBeforeRoutingOnUnsupportedChip)
{
    SetChipType(kSnapshotUnsupportedChip);

    EXPECT_EQ(rtSnapShotProcessLock(), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiSnapshot_.lockCount_, 0U);
}

TEST_F(ApiSnapshotRouteTest, ReturnsInternalErrorWhenApiSnapshotMissing)
{
    runtime_->apiSnapshot_ = nullptr;

    EXPECT_EQ(rtSnapShotProcessLock(), ACL_ERROR_RT_INTERNAL_ERROR);
}
