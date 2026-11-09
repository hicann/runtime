/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <array>
#include <cstring>
#include <list>
#include <map>
#include <memory>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "runtime/rts/rts_kernel.h"
#include "runtime/rt_inner_task.h"
#define private public
#define protected public
#include "api_decorator.hpp"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "context.hpp"
#include "npu_driver.hpp"
#include "raw_device.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "task_info.hpp"
#include "thread_local_container.hpp"
#include "h2d_copy_mgr.hpp"
#include "rt_unwrap.h"
#undef private
#undef protected
#ifdef COPY_ARGS_DAVID
#include "rt_utest_config_define.hpp"
#include "platform/950/rt_utest_david_fixture_helper.h"
#endif

using namespace testing;
using namespace cce::runtime;

namespace {
struct ArgsCopyDriverState {
    std::map<void*, std::unique_ptr<uint8_t[]>> allocations;
    uint32_t allocationCalls{0U};
    uint32_t copies{0U};
    uint32_t frees{0U};
    uint32_t failedFrees{0U};
    rtError_t allocError{RT_ERROR_NONE};
    rtError_t copyError{RT_ERROR_NONE};
    rtError_t capabilityError{RT_ERROR_NONE};
    void* failedAllocationOutput{nullptr};
    const void* source{nullptr};
    const std::list<void*>* backups{nullptr};
    uint32_t deviceId{0U};
};
ArgsCopyDriverState* argsCopyState = nullptr;

rtError_t CheckCopySupport(const Device*) { return argsCopyState->capabilityError; }

rtError_t AllocateArgsBackup(
    Driver*, void** address, uint64_t size, rtMemType_t type, uint32_t deviceId, DevMemBackupType backupType,
    const DevMemAllocConfig* config)
{
    ++argsCopyState->allocationCalls;
    EXPECT_EQ(type, RT_MEMORY_DEFAULT);
    EXPECT_EQ(backupType, DevMemBackupType::SNAPSHOT_REQUIRED_BACKUP);
    EXPECT_NE(config, nullptr);
    if (config != nullptr) {
        EXPECT_EQ(config->moduleId, MODULEID_RUNTIME);
    }
    EXPECT_EQ(deviceId, argsCopyState->deviceId);
    if (argsCopyState->allocError != RT_ERROR_NONE) {
        *address = argsCopyState->failedAllocationOutput;
        return argsCopyState->allocError;
    }
    std::unique_ptr<uint8_t[]> buffer(new uint8_t[size]);
    *address = buffer.get();
    argsCopyState->allocations.emplace(*address, std::move(buffer));
    return RT_ERROR_NONE;
}

rtError_t CopyArgsBackup(
    Driver*, void* dst, uint64_t maxSize, const void* src, uint64_t size, rtMemcpyKind_t kind, bool, uint32_t deviceId)
{
    EXPECT_EQ(argsCopyState->backups->size() + 1U, argsCopyState->allocations.size());
    ++argsCopyState->copies;
    EXPECT_EQ(kind, RT_MEMCPY_DEVICE_TO_DEVICE);
    EXPECT_EQ(maxSize, size);
    EXPECT_EQ(deviceId, INVALID_COPY_MODULEID);
    argsCopyState->source = src;
    if (argsCopyState->copyError != RT_ERROR_NONE) {
        return argsCopyState->copyError;
    }
    std::memcpy(dst, src, size);
    return RT_ERROR_NONE;
}

rtError_t FreeArgsBackup(Driver*, void* address, uint32_t deviceId)
{
    EXPECT_EQ(deviceId, argsCopyState->deviceId);
    EXPECT_EQ(argsCopyState->allocations.count(address), 1U);
    ++argsCopyState->frees;
    if (argsCopyState->failedFrees > 0U) {
        --argsCopyState->failedFrees;
        return RT_ERROR_DRV_ERR;
    }
    argsCopyState->allocations.erase(address);
    return RT_ERROR_NONE;
}
} // namespace

#ifdef COPY_ARGS_DAVID
#define ArgsCopyTest ModelTaskCopyArgsDeviceBufferDavidTest
#else
#define ArgsCopyTest ModelTaskCopyArgsDeviceBuffer910BTest
#endif

class ArgsCopyTest : public testing::Test {
protected:
    void SetUp() override
    {
        GlobalMockObject::verify();
        runtime_ = const_cast<Runtime*>(Runtime::Instance());
        savedChip_ = runtime_->GetChipType();
        savedGlobalChip_ = GlobalContainer::GetRtChipType();
        savedSoc_ = runtime_->socVersion_;
        savedGlobalSoc_ = GlobalContainer::GetSocVersion();
        savedUserSoc_ = GlobalContainer::GetUserSocVersion();
        savedHardwareSoc_ = GlobalContainer::GetHardwareSocVersion();
        savedUserSet_ = runtime_->GetIsUserSetSocVersion();
        savedDisableThread_ = runtime_->GetDisableThread();
        savedConnectUb_ = runtime_->GetConnectUbFlag();
#ifdef COPY_ARGS_DAVID
        runtime_->SetDisableThread(true);
        runtime_->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        runtime_->SetConnectUbFlag(false);
        MockDavidDriverSetup();
        (void)rtSetSocVersion("Ascend950PR_9599");
#else
        (void)rtSetSocVersion("Ascend910B1");
#endif
        runtime_->SetIsUserSetSocVersion(false);
        ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
        ASSERT_EQ(rtStreamCreate(&streamHandle_, 0), RT_ERROR_NONE);
        stream_ = rt_ut::UnwrapOrNull<Stream>(streamHandle_);
        ASSERT_NE(stream_, nullptr);
        model_ = new CaptureModel;
        model_->context_ = stream_->Context_();
        model_->SetCaptureModelStatus(RtCaptureModelStatus::READY);
        stream_->SetModel(model_);
        task_.stream = stream_;
        task_.id = 7U;
        task_.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);
        task_.type = TS_TASK_TYPE_KERNEL_AICORE;
        task_.typeName = const_cast<char*>("KERNEL_AICORE");
        for (size_t i = 0U; i < source_.size(); ++i) {
            source_[i] = static_cast<uint8_t>(i + 1U);
        }
        task_.u.aicTaskInfo.comm.args = source_.data();
        task_.u.aicTaskInfo.comm.argsSize = source_.size();
        argsCopyState = &state_;
        state_.backups = &model_->argsDeviceBufferBackups_;
        state_.deviceId = stream_->Device_()->Id_();
        MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(invoke(CheckCopySupport));
        Driver* driver = stream_->Device_()->Driver_();
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(AllocateArgsBackup));
        MOCKER_CPP_VIRTUAL(driver, &Driver::MemCopySync).stubs().will(invoke(CopyArgsBackup));
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemFree).stubs().will(invoke(FreeArgsBackup));
    }

    void TearDown() override
    {
        DestroyModel();
        EXPECT_TRUE(state_.allocations.empty());
        GlobalMockObject::verify();
#ifdef COPY_ARGS_DAVID
        uint16_t head = 0U;
        MOCKER_CPP_VIRTUAL(stream_->Device_()->Driver_(), &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(head), mockcpp::any())
            .will(returnValue(RT_ERROR_NONE));
#endif
        EXPECT_EQ(rtStreamDestroy(streamHandle_), RT_ERROR_NONE);
        EXPECT_EQ(rtDeviceReset(0), RT_ERROR_NONE);
        runtime_->SetChipType(savedChip_);
        GlobalContainer::SetRtChipType(savedGlobalChip_);
        runtime_->SetSocVersion(savedSoc_);
        GlobalContainer::SetSocVersion(savedGlobalSoc_);
        GlobalContainer::SetUserSocVersion(savedUserSoc_);
        GlobalContainer::SetHardwareSocVersion(savedHardwareSoc_);
        runtime_->SetDisableThread(savedDisableThread_);
        runtime_->SetConnectUbFlag(savedConnectUb_);
        runtime_->SetIsUserSetSocVersion(savedUserSet_);
        GlobalMockObject::verify();
        argsCopyState = nullptr;
    }

    void DestroyModel()
    {
        if (model_ != nullptr) {
            stream_->SetModel(nullptr);
            delete model_;
            model_ = nullptr;
        }
    }

    void* Copy(Api* api = nullptr)
    {
        void* result = nullptr;
        size_t size = 0U;
        const rtError_t error = (api == nullptr) ? rtModelTaskCopyArgsDeviceBuffer(&task_, &result, &size) :
                                                   api->ModelTaskCopyArgsDeviceBuffer(&task_, &result, &size);
        EXPECT_EQ(error, RT_ERROR_NONE);
        EXPECT_NE(result, nullptr);
        if (error == RT_ERROR_NONE && result != nullptr) {
            EXPECT_NE(result, state_.source);
            EXPECT_EQ(state_.source, task_.u.aicTaskInfo.comm.args);
            EXPECT_EQ(size, task_.u.aicTaskInfo.comm.argsSize);
            if (size == task_.u.aicTaskInfo.comm.argsSize) {
                EXPECT_EQ(std::memcmp(result, state_.source, size), 0);
            }
        }
        return result;
    }

    void ExpectFailure(rtError_t expected = RT_ERROR_NONE)
    {
        void* result = source_.data();
        size_t size = 99U;
        const rtError_t error = rtModelTaskCopyArgsDeviceBuffer(&task_, &result, &size);
        EXPECT_NE(error, RT_ERROR_NONE);
        if (expected != RT_ERROR_NONE) {
            EXPECT_EQ(error, expected);
        }
        EXPECT_EQ(result, nullptr);
        EXPECT_EQ(size, 0U);
    }

    Runtime* runtime_{nullptr};
    rtChipType_t savedChip_{};
    rtChipType_t savedGlobalChip_{};
    std::string savedSoc_;
    std::string savedGlobalSoc_;
    std::string savedUserSoc_;
    std::string savedHardwareSoc_;
    bool savedUserSet_{false};
    bool savedDisableThread_{false};
    bool savedConnectUb_{false};
    rtStream_t streamHandle_{nullptr};
    Stream* stream_{nullptr};
    CaptureModel* model_{nullptr};
    TaskInfo task_{};
    std::array<uint8_t, 65> source_{};
    ArgsCopyDriverState state_;
};

TEST_F(ArgsCopyTest, IndependentSnapshotsSurviveSourceChangeAndTaskDestruction)
{
    const auto original = source_;
    ApiDecorator decorator(Api::Instance());
    model_->refCount_ = 1U;
    void* first = Copy(&decorator);
    EXPECT_EQ(model_->refCount_, 1U);
    model_->refCount_ = 0U;
    ASSERT_NE(first, nullptr);
    std::array<uint8_t, 11> replacement{};
    replacement.fill(0xE5U);
    task_.u.aicTaskInfo.comm.args = replacement.data();
    task_.u.aicTaskInfo.comm.argsSize = replacement.size();
    void* second = Copy();
    ASSERT_NE(second, nullptr);
    EXPECT_NE(first, second);
    EXPECT_EQ(std::memcmp(first, original.data(), original.size()), 0);
    EXPECT_EQ(state_.copies, 2U);
    EXPECT_EQ(state_.frees, 0U);
    EXPECT_EQ(source_, original);
    std::memset(&task_, 0, sizeof(task_));
    DestroyModel();
    EXPECT_EQ(state_.frees, 2U);
}

TEST_F(ArgsCopyTest, CopiesKernelTypesAndExactLengths)
{
    for (auto type : {TS_TASK_TYPE_KERNEL_AICORE, TS_TASK_TYPE_KERNEL_AIVEC}) {
        task_.type = type;
        for (uint32_t size : {1U, 7U, 63U, 64U, 65U}) {
            task_.u.aicTaskInfo.comm.argsSize = size;
            Copy();
        }
    }
}

TEST_F(ArgsCopyTest, CopiesLoadedArgsDespitePendingParamsDisableOrUploadHandle)
{
    TaskUpdateInfo update{};
    std::array<uint8_t, 8> cached{};
    update.latestParams.isValid = 1U;
    update.latestParams.type = RT_TASK_KERNEL;
    auto& pending = update.latestParams.u.kernelUpdateParams;
    task_.updateInfo = &update;
    task_.updateFlag = static_cast<uint8_t>(TaskUpdateFlag::RT_TASK_DISABLE);
    model_->SetCaptureModelStatus(RtCaptureModelStatus::UPDATING);
    H2DCopyMgr loader(stream_->Device_(), COPY_POLICY_SYNC);
    Handle handle{};
    handle.freeArgs = true;
    handle.argsAlloc = &loader;
    handle.kerArgs = source_.data();
    MOCKER_CPP(&H2DCopyMgr::H2DMemCopyWaitFinish).expects(never());
    task_.u.aicTaskInfo.comm.argHandle = &handle;
    for (auto argsType : {RT_KERNEL_ARGS_DEVICE_BUFFER, RT_KERNEL_ARGS_HOST_BUFFER}) {
        pending.argsType = argsType;
        if (argsType == RT_KERNEL_ARGS_HOST_BUFFER) {
            pending.hostBuffer = {cached.data(), cached.size(), nullptr, 0U};
        } else {
            pending.deviceBuffer = {cached.data(), cached.size()};
        }
        Copy();
    }
    task_.u.aicTaskInfo.comm.argHandle = nullptr;
    model_->PushbackArgHandle(static_cast<uint16_t>(stream_->Id_()), task_.id, &handle);
    Copy();
    EXPECT_EQ(model_->GetAndEraseArgHandle(static_cast<uint16_t>(stream_->Id_()), task_.id), &handle);
    EXPECT_EQ(update.latestParams.isValid, 1U);
    EXPECT_EQ(task_.updateFlag, static_cast<uint8_t>(TaskUpdateFlag::RT_TASK_DISABLE));
    task_.updateInfo = nullptr;
}

TEST_F(ArgsCopyTest, RejectsNonKernelAndInnerTasksWithoutAllocating)
{
    for (auto type :
         {TS_TASK_TYPE_EVENT_RECORD, TS_TASK_TYPE_MEMCPY, TS_TASK_TYPE_KERNEL_AICPU, TS_TASK_TYPE_CCU_LAUNCH,
          TS_TASK_TYPE_FLIP}) {
        task_.type = type;
        ExpectFailure();
    }
    task_.type = TS_TASK_TYPE_KERNEL_AIVEC;
    task_.u.aicTaskInfo.simtParamOffset = SIMT_IMPLICIT_PARAM_SIZE;
    ExpectFailure(ACL_ERROR_RT_PARAM_INVALID);
    task_.u.aicTaskInfo.simtParamOffset = 0U;
    task_.type = TS_TASK_TYPE_KERNEL_AICORE;
    task_.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    ExpectFailure();
    EXPECT_EQ(state_.allocationCalls, 0U);
    EXPECT_EQ(state_.copies, 0U);
}

TEST_F(ArgsCopyTest, RejectsNullArgumentsAndEmptyLoadedBuffer)
{
    void* result = source_.data();
    size_t size = 99U;
    EXPECT_NE(rtModelTaskCopyArgsDeviceBuffer(nullptr, &result, &size), RT_ERROR_NONE);
    EXPECT_EQ(result, nullptr);
    EXPECT_EQ(size, 0U);
    EXPECT_NE(rtModelTaskCopyArgsDeviceBuffer(&task_, nullptr, &size), RT_ERROR_NONE);
    EXPECT_NE(rtModelTaskCopyArgsDeviceBuffer(&task_, &result, nullptr), RT_ERROR_NONE);
    task_.u.aicTaskInfo.comm.args = nullptr;
    ExpectFailure();
    task_.u.aicTaskInfo.comm.args = source_.data();
    task_.u.aicTaskInfo.comm.argsSize = 0U;
    ExpectFailure();
    EXPECT_EQ(state_.allocationCalls, 0U);
    EXPECT_EQ(state_.copies, 0U);
}

TEST_F(ArgsCopyTest, RejectsMissingStreamOrModelAndSubgraph)
{
    task_.stream = nullptr;
    ExpectFailure();
    task_.stream = stream_;
    stream_->SetModel(nullptr);
    ExpectFailure(ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    stream_->SetModel(model_);
    model_->isSubCaptureModel_ = true;
    ExpectFailure(ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    model_->isSubCaptureModel_ = false;
    EXPECT_EQ(state_.allocationCalls, 0U);
}

TEST_F(ArgsCopyTest, CopiesLoadedArgsWithoutChangingFaultState)
{
    model_->SetCaptureModelStatus(RtCaptureModelStatus::FAULT);
    ASSERT_NE(Copy(), nullptr);
    EXPECT_EQ(model_->GetCaptureModelStatus(), RtCaptureModelStatus::FAULT);
    EXPECT_EQ(state_.allocationCalls, 1U);
}

TEST_F(ArgsCopyTest, AllocationFailuresDoNotCopyOrFreeStaleOutput)
{
    ASSERT_NE(Copy(), nullptr);
    state_.failedAllocationOutput = source_.data();
    for (auto error : {RT_ERROR_MEMORY_ALLOCATION, RT_ERROR_DRV_ERR}) {
        state_.allocError = error;
        void* result = source_.data();
        size_t size = 99U;
        EXPECT_EQ(model_->CopyTaskArgsDeviceBuffer(&task_, &result, &size), error);
        EXPECT_EQ(result, source_.data());
        EXPECT_EQ(size, 99U);
        ExpectFailure();
    }
    EXPECT_EQ(state_.allocations.size(), 1U);
    EXPECT_EQ(state_.copies, 1U);
    EXPECT_EQ(state_.frees, 0U);
}

TEST_F(ArgsCopyTest, CopyFailureRollsBackOnlyNewAllocation)
{
    Copy();
    state_.copyError = RT_ERROR_DRV_ERR;
    ExpectFailure();
    EXPECT_EQ(state_.allocations.size(), 1U);
    EXPECT_EQ(state_.frees, 1U);
    EXPECT_EQ(model_->GetCaptureModelStatus(), RtCaptureModelStatus::READY);
}

TEST_F(ArgsCopyTest, CleanupContinuesAfterOneFinalFreeFailure)
{
    Copy();
    Copy();
    state_.failedFrees = 1U;
    DestroyModel();
    EXPECT_EQ(state_.frees, 2U);
    EXPECT_EQ(state_.allocations.size(), 1U);
    // Terminal driver failure is not reported as successful resource reclamation.
    state_.allocations.clear();
}

TEST_F(ArgsCopyTest, ExitCleanupDeletesHostRecordsWithoutFreeingDeviceBuffers)
{
    Copy();
    model_->FinalizeHostStateOnExit();
    EXPECT_EQ(state_.frees, 0U);
    EXPECT_TRUE(model_->argsDeviceBufferBackups_.empty());
    state_.allocations.clear();
    // A second cleanup is safe after records have been removed.
    model_->ReleaseArgsDeviceBufferBackups(true);
    EXPECT_EQ(state_.frees, 0U);
}

TEST_F(ArgsCopyTest, UnsupportedCapabilityMapsToExternalError)
{
    for (auto error : {RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_DRV_NOT_SUPPORT}) {
        state_.capabilityError = error;
        ExpectFailure(ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    }
    EXPECT_EQ(state_.allocationCalls, 0U);
}

#undef ArgsCopyTest
