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

#include <limits>
#include <arpa/inet.h>
#include <cstdlib>
#include <dirent.h>
#include <fcntl.h>
#include <stdexcept>
#include <sys/stat.h>
#include <sys/wait.h>
#include <vector>
#include <atomic>
#include <cerrno>
#include <chrono>
#include <functional>
#include <poll.h>
#include <pwd.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/un.h>
#include <thread>
#include <unistd.h>

#include "api_impl_snapshot.hpp"
#include "api_snapshot.hpp"
#include "global_state_manager.hpp"
#include "inner_thread_local.hpp"
#include "npu_driver.hpp"
#include "runtime_keeper.h"
#include "snapshot_callback_manager.hpp"
#include "snapshot_process_helper.hpp"
#include "snapshot_socket.hpp"

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

int32_t ConnectAgain(mmSockHandle, mmSockAddr*, mmSocklen_t)
{
    errno = EAGAIN;
    return EN_ERROR;
}

int32_t ConnectWithSystemCall(mmSockHandle fd, mmSockAddr* address, mmSocklen_t length)
{
    return connect(fd, reinterpret_cast<struct sockaddr*>(address), length);
}

std::atomic<bool> g_featureBackupEntered{false};
std::atomic<bool> g_featureBackupReleased{true};
rtError_t DelayFeatureBackup(const rtSnapShotBackupArgs*)
{
    g_featureBackupEntered.store(true);
    while (!g_featureBackupReleased.load()) {
        std::this_thread::yield();
    }
    return RT_ERROR_NONE;
}

std::atomic<bool> g_delaySnapshotThread{false};
int32_t DelaySnapshotThreadStart(const char_t*)
{
    while (g_delaySnapshotThread.load()) {
        std::this_thread::yield();
    }
    return EN_OK;
}

std::atomic<uint32_t> g_acceptAttempts{0U};
std::atomic<uint32_t> g_backoffWaits{0U};
std::atomic<bool> g_interruptPoll{false};
std::atomic<int32_t> g_acceptError{EMFILE};

int32_t AcceptAfterResourceFailures(int32_t fd, struct sockaddr* address, socklen_t* length, int32_t flags)
{
    if (++g_acceptAttempts <= 2U) {
        errno = g_acceptError.load();
        return EN_ERROR;
    }
    return static_cast<int32_t>(syscall(SYS_accept4, fd, address, length, flags));
}

int32_t PollRecordingBackoff(struct pollfd* fds, nfds_t count, int32_t timeoutMs)
{
    if (g_interruptPoll.exchange(false)) {
        errno = EINTR;
        return EN_ERROR;
    }
    const bool backoff = (count == 2U) && (fds[0].fd == EN_ERROR) && (fds[0].events == 0);
    if (backoff) {
        EXPECT_GE(fds[1].fd, 0);
        EXPECT_EQ(fds[1].events, POLLIN);
        EXPECT_EQ(timeoutMs, 100);
        ++g_backoffWaits;
    }
    struct timespec timeout = {timeoutMs / 1000, (timeoutMs % 1000) * 1000000L};
    return ppoll(fds, count, timeoutMs < 0 ? nullptr : &timeout, nullptr);
}

class ApiSnapshotRouteStub : public ApiImplSnapshot {
public:
    rtError_t SnapShotProcessGetState(rtProcessState* state) override
    {
        *state = GlobalStateManager::GetInstance().GetCurrentState();
        return RT_ERROR_NONE;
    }
    rtError_t SnapShotProcessGetRestoreThreadId(int32_t* tid) override
    {
        if (threadId_ <= 0) {
            return RT_ERROR_OS_HANDLE;
        }
        *tid = threadId_;
        return RT_ERROR_NONE;
    }
    int32_t threadId_ = 1234;
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

    rtError_t SnapShotProcessBackup(const rtSnapShotBackupArgs* args) override
    {
        backupArgs_ = args;
        ++backupCount_;
        if (onBackup_) {
            onBackup_(args);
        }
        return backupRet_;
    }

    rtError_t SnapShotProcessRestore(const rtSnapShotRestoreArgs* args) override
    {
        restoreArgs_ = args;
        ++restoreCount_;
        if (onRestore_) {
            onRestore_(args);
        }
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
    const rtSnapShotBackupArgs* backupArgs_ = nullptr;
    const rtSnapShotRestoreArgs* restoreArgs_ = nullptr;
    rtError_t lockRet_ = RT_ERROR_NONE;
    std::function<void(const rtSnapShotBackupArgs*)> onBackup_;
    std::function<void(const rtSnapShotRestoreArgs*)> onRestore_;
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
        oldState_ = GlobalStateManager::GetInstance().GetCurrentState();
        oldGlobalError_ = InnerThreadLocalContainer::PeekGlobalErr();
    }

    void TearDown() override
    {
        runtime_->api_ = oldApi_;
        runtime_->apiSnapshot_ = oldApiSnapshot_;
        runtime_->SetChipType(oldRuntimeChipType_);
        GlobalContainer::SetRtChipType(oldGlobalChipType_);
        GlobalStateManager::GetInstance().SetCurrentState(oldState_);
        runtime_->SetGlobalErr(oldGlobalError_);
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
    rtProcessState oldState_ = RT_PROCESS_STATE_RUNNING;
    rtError_t oldGlobalError_ = ACL_RT_SUCCESS;
};
} // namespace

TEST_F(ApiSnapshotRouteTest, RestoreThreadIdNullOutputRecordsLastError)
{
    runtime_->SetGlobalErr(ACL_RT_SUCCESS);
    EXPECT_EQ(rtSnapShotProcessGetRestoreThreadId(nullptr), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(InnerThreadLocalContainer::PeekGlobalErr(), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiSnapshotRouteTest, RestoreThreadIdUnavailablePreservesOutputAndRecordsLastError)
{
    apiSnapshot_.threadId_ = 0;
    runtime_->SetGlobalErr(ACL_RT_SUCCESS);
    int32_t tid = -1;
    EXPECT_EQ(rtSnapShotProcessGetRestoreThreadId(&tid), ACL_ERROR_RT_INTERNAL_ERROR);
    EXPECT_EQ(tid, -1);
    EXPECT_EQ(InnerThreadLocalContainer::PeekGlobalErr(), ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(ApiSnapshotRouteTest, RestoreThreadIdQueryUsesRuntimeInitialization)
{
    const ScopeGuard restoreRuntime([this] { Runtime::runtime_ = runtime_; });
    Runtime::runtime_ = nullptr;
    MOCKER(RuntimeKeeperGetRuntime).expects(once()).will(returnValue(runtime_));
    apiSnapshot_.threadId_ = 1234;
    int32_t tid = -1;
    EXPECT_EQ(rtSnapShotProcessGetRestoreThreadId(&tid), ACL_RT_SUCCESS);
    EXPECT_EQ(tid, 1234);
    EXPECT_EQ(Runtime::runtime_, runtime_);
}

TEST_F(ApiSnapshotRouteTest, RestoreThreadIdSuccessPreservesLastError)
{
    apiSnapshot_.threadId_ = 1234;
    runtime_->SetGlobalErr(ACL_ERROR_RT_PARAM_INVALID);
    int32_t tid = -1;
    EXPECT_EQ(rtSnapShotProcessGetRestoreThreadId(&tid), ACL_RT_SUCCESS);
    EXPECT_EQ(tid, 1234);
    EXPECT_EQ(InnerThreadLocalContainer::PeekGlobalErr(), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiSnapshotRouteTest, RoutesApisToApiSnapshot)
{
    int32_t callbackArgs = 7;
    rtSnapShotBackupArgs backupArgs = {};
    rtSnapShotRestoreArgs restoreArgs = {};

    EXPECT_EQ(rtSnapShotProcessLock(), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSnapShotProcessBackupWithArgs(&backupArgs), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSnapShotProcessRestoreWithArgs(&restoreArgs), ACL_RT_SUCCESS);
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
    rtSnapShotBackupArgs backupArgs = {};
    rtSnapShotRestoreArgs restoreArgs = {};

    apiSnapshot_.lockRet_ = RT_ERROR_SNAPSHOT_LOCK_FAILED;
    EXPECT_EQ(rtSnapShotProcessLock(), ACL_ERROR_SNAPSHOT_LOCK_FAILED);

    apiSnapshot_.backupRet_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    EXPECT_EQ(rtSnapShotProcessBackupWithArgs(&backupArgs), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    apiSnapshot_.restoreRet_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    EXPECT_EQ(rtSnapShotProcessRestoreWithArgs(&restoreArgs), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiSnapshotRouteTest, LegacyBackupRestoreApisPassNullArgs)
{
    EXPECT_EQ(rtSnapShotProcessBackup(), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSnapShotProcessRestore(), ACL_RT_SUCCESS);

    EXPECT_EQ(apiSnapshot_.backupCount_, 1U);
    EXPECT_EQ(apiSnapshot_.backupArgs_, nullptr);
    EXPECT_EQ(apiSnapshot_.restoreCount_, 1U);
    EXPECT_EQ(apiSnapshot_.restoreArgs_, nullptr);
}

TEST_F(ApiSnapshotRouteTest, ReturnsNotSupportBeforeRoutingOnUnsupportedChip)
{
    SetChipType(kSnapshotUnsupportedChip);

    EXPECT_EQ(rtSnapShotProcessLock(), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiSnapshot_.lockCount_, 0U);
    int32_t tid = -1;
    EXPECT_EQ(rtSnapShotProcessGetRestoreThreadId(&tid), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(tid, -1);
}

TEST_F(ApiSnapshotRouteTest, ReturnsInternalErrorWhenApiSnapshotMissing)
{
    runtime_->apiSnapshot_ = nullptr;

    EXPECT_EQ(rtSnapShotProcessLock(), ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(ApiSnapshotRouteTest, LockInvokesPreCallbackBeforeRejectingLockedState)
{
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_LOCKED);
    MOCKER_CPP(&SnapshotCallbackManager::InvokeCallbacks)
        .expects(once())
        .with(eq(RT_SNAPSHOT_LOCK_PRE))
        .will(returnValue(RT_ERROR_NONE));
    ApiImplSnapshot impl;
    EXPECT_EQ(impl.SnapShotProcessLock(), RT_ERROR_SNAPSHOT_LOCK_FAILED);
    EXPECT_EQ(GlobalStateManager::GetInstance().GetCurrentState(), RT_PROCESS_STATE_LOCKED);
}

TEST_F(ApiSnapshotRouteTest, FailedStateRejectsOrdinaryOperations)
{
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_FAILED);
    ApiImplSnapshot impl;
    EXPECT_EQ(impl.SnapShotProcessLock(), RT_ERROR_SNAPSHOT_LOCK_FAILED);
    EXPECT_EQ(impl.SnapShotProcessUnlock(), RT_ERROR_SNAPSHOT_UNLOCK_FAILED);
    EXPECT_EQ(impl.SnapShotProcessBackup(nullptr), RT_ERROR_SNAPSHOT_BACKUP_FAILED);
    EXPECT_EQ(impl.SnapShotProcessRestore(nullptr), RT_ERROR_SNAPSHOT_RESTORE_FAILED);
    rtProcessState state = RT_PROCESS_STATE_RUNNING;
    EXPECT_EQ(rtSnapShotProcessGetState(&state), ACL_RT_SUCCESS);
    EXPECT_EQ(state, RT_PROCESS_STATE_FAILED);
}

TEST_F(ApiSnapshotRouteTest, InvalidMemoryFlagsNeverReachImplementation)
{
    rtSnapShotBackupArgs backupArgs = {};
    rtSnapShotRestoreArgs restoreArgs = {};
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_LOCKED);
    for (const uint32_t flags : {2U, std::numeric_limits<uint32_t>::max()}) {
        SCOPED_TRACE(flags);
        backupArgs.backupFlags = flags;
        restoreArgs.restoreFlags = flags;
        EXPECT_EQ(rtSnapShotProcessBackupWithArgs(&backupArgs), ACL_ERROR_RT_PARAM_INVALID);
        EXPECT_EQ(rtSnapShotProcessRestoreWithArgs(&restoreArgs), ACL_ERROR_RT_PARAM_INVALID);
        EXPECT_EQ(GlobalStateManager::GetInstance().GetCurrentState(), RT_PROCESS_STATE_LOCKED);
    }
    EXPECT_EQ(apiSnapshot_.backupCount_, 0U);
    EXPECT_EQ(apiSnapshot_.restoreCount_, 0U);
}

TEST_F(ApiSnapshotRouteTest, BackupDriverFailureCommitsFailedState)
{
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_LOCKED);
    MOCKER(SnapShotPreProcessBackup).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(NpuDriver::ProcessResBackup).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    ApiImplSnapshot impl;
    EXPECT_EQ(impl.SnapShotProcessBackup(nullptr), RT_ERROR_DRV_ERR);
    EXPECT_EQ(GlobalStateManager::GetInstance().GetCurrentState(), RT_PROCESS_STATE_FAILED);
    EXPECT_EQ(impl.SnapShotProcessUnlock(), RT_ERROR_SNAPSHOT_UNLOCK_FAILED);
}

TEST_F(ApiSnapshotRouteTest, BackupPreconditionFailureCommitsFailedState)
{
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_LOCKED);
    MOCKER(SnapShotPreProcessBackup).stubs().will(returnValue(RT_ERROR_CONTEXT_NULL));
    MOCKER(NpuDriver::ProcessResBackup).expects(never());
    ApiImplSnapshot impl;
    EXPECT_EQ(impl.SnapShotProcessBackup(nullptr), RT_ERROR_CONTEXT_NULL);
    EXPECT_EQ(GlobalStateManager::GetInstance().GetCurrentState(), RT_PROCESS_STATE_FAILED);
    EXPECT_EQ(impl.SnapShotProcessUnlock(), RT_ERROR_SNAPSHOT_UNLOCK_FAILED);
}

TEST_F(ApiSnapshotRouteTest, BackupResourceNotSupportedStillCommitsFailedState)
{
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_LOCKED);
    MOCKER(SnapShotPreProcessBackup).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(NpuDriver::ProcessResBackup).stubs().will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));
    ApiImplSnapshot impl;
    EXPECT_EQ(impl.SnapShotProcessBackup(nullptr), RT_ERROR_DRV_NOT_SUPPORT);
    EXPECT_EQ(GlobalStateManager::GetInstance().GetCurrentState(), RT_PROCESS_STATE_FAILED);
    EXPECT_EQ(impl.SnapShotProcessUnlock(), RT_ERROR_SNAPSHOT_UNLOCK_FAILED);
}

TEST_F(ApiSnapshotRouteTest, SocketDispatchPreservesNullAndFullMemoryArgs)
{
    SnapshotService service;
    service.handler_ = &apiSnapshot_;
    uint32_t value = 0U;
    EXPECT_EQ(service.DispatchSnapshotRequest(rtSnapshotOp::BACKUP, nullptr, value), ACL_RT_SUCCESS);
    EXPECT_EQ(apiSnapshot_.backupArgs_, nullptr);
    SnapshotMemoryArgs args = {};
    args.flags = 1U;
    for (size_t i = 0U; i < sizeof(args.reserved); ++i) {
        args.reserved[i] = static_cast<char>(i);
    }
    apiSnapshot_.onBackup_ = [&args](const rtSnapShotBackupArgs* local) {
        ASSERT_NE(local, nullptr);
        EXPECT_EQ(local->backupFlags, args.flags);
        EXPECT_EQ(memcmp(local->reserved, args.reserved, sizeof(args.reserved)), 0);
    };
    apiSnapshot_.onRestore_ = [&args](const rtSnapShotRestoreArgs* local) {
        ASSERT_NE(local, nullptr);
        EXPECT_EQ(local->restoreFlags, args.flags);
        EXPECT_EQ(memcmp(local->reserved, args.reserved, sizeof(args.reserved)), 0);
    };
    for (const uint32_t flags : {0U, 1U}) {
        args.flags = flags;
        EXPECT_EQ(service.DispatchSnapshotRequest(rtSnapshotOp::BACKUP, &args, value), ACL_RT_SUCCESS);
        EXPECT_EQ(service.DispatchSnapshotRequest(rtSnapshotOp::RESTORE, &args, value), ACL_RT_SUCCESS);
    }
    EXPECT_EQ(apiSnapshot_.backupCount_, 3U);
    EXPECT_EQ(apiSnapshot_.restoreCount_, 2U);
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_BACKED_UP);
    EXPECT_EQ(service.DispatchSnapshotRequest(rtSnapshotOp::GET_STATE, nullptr, value), ACL_RT_SUCCESS);
    EXPECT_EQ(value, static_cast<uint32_t>(RT_PROCESS_STATE_BACKED_UP));
}

TEST_F(ApiSnapshotRouteTest, RestoreDriverFailureCommitsFailedState)
{
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_BACKED_UP);
    MOCKER(NpuDriver::ProcessResRestore).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    ApiImplSnapshot impl;
    EXPECT_EQ(impl.SnapShotProcessRestore(nullptr), RT_ERROR_DRV_ERR);
    EXPECT_EQ(GlobalStateManager::GetInstance().GetCurrentState(), RT_PROCESS_STATE_FAILED);
    EXPECT_EQ(impl.SnapShotProcessUnlock(), RT_ERROR_SNAPSHOT_UNLOCK_FAILED);
}

TEST_F(ApiSnapshotRouteTest, RestorePreconditionFailureCommitsFailedState)
{
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_BACKED_UP);
    MOCKER_CPP(&Runtime::GetDevice).stubs().will(returnValue(static_cast<Device*>(nullptr)));
    MOCKER(SnapShotDeviceRestore).expects(never());
    rtSnapShotRestoreArgs args = {};
    ApiImplSnapshot impl;
    EXPECT_EQ(impl.SnapShotProcessRestore(&args), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(GlobalStateManager::GetInstance().GetCurrentState(), RT_PROCESS_STATE_FAILED);
    EXPECT_EQ(impl.SnapShotProcessUnlock(), RT_ERROR_SNAPSHOT_UNLOCK_FAILED);
}

TEST_F(ApiSnapshotRouteTest, RestoreResourceNotSupportedStillCommitsFailedState)
{
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_BACKED_UP);
    MOCKER(NpuDriver::ProcessResRestore).stubs().will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));
    ApiImplSnapshot impl;
    EXPECT_EQ(impl.SnapShotProcessRestore(nullptr), RT_ERROR_DRV_NOT_SUPPORT);
    EXPECT_EQ(GlobalStateManager::GetInstance().GetCurrentState(), RT_PROCESS_STATE_FAILED);
    EXPECT_EQ(impl.SnapShotProcessUnlock(), RT_ERROR_SNAPSHOT_UNLOCK_FAILED);
}

class SnapshotCallbackFailureTest : public ApiSnapshotRouteTest, public WithParamInterface<rtSnapShotStage> {};

TEST_P(SnapshotCallbackFailureTest, FailureCommitsFailedStateAndStopsLaterStages)
{
    const rtSnapShotStage failedStage = GetParam();
    const bool restore = (failedStage == RT_SNAPSHOT_RESTORE_PRE) || (failedStage == RT_SNAPSHOT_RESTORE_POST);
    const rtSnapShotStage preStage = restore ? RT_SNAPSHOT_RESTORE_PRE : RT_SNAPSHOT_BACKUP_PRE;
    const rtSnapShotStage postStage = restore ? RT_SNAPSHOT_RESTORE_POST : RT_SNAPSHOT_BACKUP_POST;
    const bool preFails = failedStage == preStage;
    GlobalStateManager::GetInstance().SetCurrentState(restore ? RT_PROCESS_STATE_BACKED_UP : RT_PROCESS_STATE_LOCKED);
    MOCKER_CPP(&SnapshotCallbackManager::InvokeCallbacks)
        .expects(once())
        .with(eq(preStage))
        .will(returnValue(preFails ? RT_ERROR_INVALID_VALUE : RT_ERROR_NONE));
    if (preFails) {
        MOCKER_CPP(&SnapshotCallbackManager::InvokeCallbacks).expects(never()).with(eq(postStage));
        MOCKER(cce::runtime::SnapShotProcessBackup).expects(never());
        MOCKER(cce::runtime::SnapShotProcessRestore).expects(never());
    } else {
        MOCKER_CPP(&SnapshotCallbackManager::InvokeCallbacks)
            .expects(once())
            .with(eq(postStage))
            .will(returnValue(RT_ERROR_INVALID_VALUE));
        if (restore) {
            MOCKER(cce::runtime::SnapShotProcessRestore)
                .expects(once())
                .with(eq(static_cast<const rtSnapShotRestoreArgs*>(nullptr)))
                .will(returnValue(RT_ERROR_NONE));
            MOCKER(cce::runtime::SnapShotProcessBackup).expects(never());
        } else {
            MOCKER(cce::runtime::SnapShotProcessBackup)
                .expects(once())
                .with(eq(static_cast<const rtSnapShotBackupArgs*>(nullptr)))
                .will(returnValue(RT_ERROR_NONE));
            MOCKER(cce::runtime::SnapShotProcessRestore).expects(never());
        }
    }

    ApiImplSnapshot impl;
    EXPECT_EQ(
        restore ? impl.SnapShotProcessRestore(nullptr) : impl.SnapShotProcessBackup(nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(GlobalStateManager::GetInstance().GetCurrentState(), RT_PROCESS_STATE_FAILED);
    EXPECT_EQ(impl.SnapShotProcessUnlock(), RT_ERROR_SNAPSHOT_UNLOCK_FAILED);
    rtProcessState state = RT_PROCESS_STATE_RUNNING;
    EXPECT_EQ(rtSnapShotProcessGetState(&state), ACL_RT_SUCCESS);
    EXPECT_EQ(state, RT_PROCESS_STATE_FAILED);
}

INSTANTIATE_TEST_SUITE_P(
    FourStages, SnapshotCallbackFailureTest,
    Values(RT_SNAPSHOT_BACKUP_PRE, RT_SNAPSHOT_BACKUP_POST, RT_SNAPSHOT_RESTORE_PRE, RT_SNAPSHOT_RESTORE_POST));

TEST_F(ApiSnapshotRouteTest, SuccessfulBackupAndRestoreCommitExpectedState)
{
    GlobalStateManager& state = GlobalStateManager::GetInstance();
    state.SetCurrentState(RT_PROCESS_STATE_LOCKED);
    MOCKER_CPP(&SnapshotCallbackManager::InvokeCallbacks)
        .expects(once())
        .with(eq(RT_SNAPSHOT_BACKUP_PRE))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(cce::runtime::SnapShotProcessBackup)
        .expects(once())
        .with(eq(static_cast<const rtSnapShotBackupArgs*>(nullptr)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&SnapshotCallbackManager::InvokeCallbacks)
        .expects(once())
        .with(eq(RT_SNAPSHOT_BACKUP_POST))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&SnapshotCallbackManager::InvokeCallbacks)
        .expects(once())
        .with(eq(RT_SNAPSHOT_RESTORE_PRE))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(cce::runtime::SnapShotProcessRestore)
        .expects(once())
        .with(eq(static_cast<const rtSnapShotRestoreArgs*>(nullptr)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&SnapshotCallbackManager::InvokeCallbacks)
        .expects(once())
        .with(eq(RT_SNAPSHOT_RESTORE_POST))
        .will(returnValue(RT_ERROR_NONE));
    ApiImplSnapshot impl;
    EXPECT_EQ(impl.SnapShotProcessBackup(nullptr), RT_ERROR_NONE);
    EXPECT_EQ(state.GetCurrentState(), RT_PROCESS_STATE_BACKED_UP);
    EXPECT_EQ(impl.SnapShotProcessRestore(nullptr), RT_ERROR_NONE);
    EXPECT_EQ(state.GetCurrentState(), RT_PROCESS_STATE_LOCKED);
}

TEST_F(ApiSnapshotRouteTest, StateNullOutputRecordsLastError)
{
    EXPECT_EQ(rtSnapShotProcessGetState(nullptr), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(InnerThreadLocalContainer::PeekGlobalErr(), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiSnapshotRouteTest, StartReturnsBeforeTidPublicationAndRemoteQuerySeesPublishedTid)
{
    SnapshotService service;
    class TidHandler : public ApiSnapshotRouteStub {
    public:
        explicit TidHandler(SnapshotService& service) : service_(service) {}
        rtError_t SnapShotProcessGetRestoreThreadId(int32_t* tid) override
        {
            *tid = service_.GetSnapshotThreadId();
            return (*tid > 0) ? RT_ERROR_NONE : RT_ERROR_OS_HANDLE;
        }
        SnapshotService& service_;
    } handler(service);
    std::atomic<bool> returned{false};
    rtError_t startResult = RT_ERROR_INVALID_VALUE;
    g_delaySnapshotThread.store(true);
    MOCKER(mmSetCurrentThreadName).expects(once()).will(invoke(DelaySnapshotThreadStart));
    std::thread starter;
    const ScopeGuard finish([&] {
        g_delaySnapshotThread.store(false);
        if (starter.joinable()) {
            starter.join();
        }
        service.StopSnapshotService();
    });
    starter = std::thread([&] {
        startResult = service.StartSnapshotService(&handler);
        returned.store(true);
    });
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(2);
    while (!returned.load() && std::chrono::steady_clock::now() < deadline) {
        std::this_thread::yield();
    }
    ASSERT_TRUE(returned.load()); // ThreadMain cannot publish its TID until the gate is released.
    EXPECT_EQ(startResult, RT_ERROR_NONE);
    EXPECT_EQ(service.GetSnapshotThreadId(), 0);
    g_delaySnapshotThread.store(false);
    starter.join();
    uint32_t tid = 0U;
    EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::GET_RESTORE_THREAD_ID, nullptr, tid), ACL_RT_SUCCESS);
    EXPECT_GT(tid, 0U);
    EXPECT_EQ(tid, static_cast<uint32_t>(service.GetSnapshotThreadId()));
}

TEST_F(ApiSnapshotRouteTest, SocketClientBlockingConnectFailurePreservesOutputWithoutRetry)
{
    SnapshotService service;
    ASSERT_EQ(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()), 0);
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_RUNNING);
    MOCKER(mmConnect).expects(once()).will(invoke(ConnectAgain));
    uint32_t value = 99U;
    EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::GET_STATE, nullptr, value), RT_ERROR_OS_HANDLE);
    EXPECT_EQ(value, 99U);
}

TEST_F(ApiSnapshotRouteTest, SocketClientBlockingConnectSuccessUsesSingleAttempt)
{
    SnapshotService service;
    ASSERT_EQ(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()), 0);
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_RUNNING);
    MOCKER(mmConnect).expects(once()).will(invoke(ConnectWithSystemCall));
    uint32_t value = 99U;
    EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::GET_STATE, nullptr, value), ACL_RT_SUCCESS);
    EXPECT_EQ(value, static_cast<uint32_t>(RT_PROCESS_STATE_RUNNING));
}

TEST_F(ApiSnapshotRouteTest, WireLayoutAndMemoryArgumentsRemainCompatible)
{
    SnapshotService service;
    service.handler_ = &apiSnapshot_;
    EXPECT_EQ(sizeof(SnapshotRequestHeader), 16U);
    EXPECT_EQ(sizeof(SnapshotResponse), 16U);
    EXPECT_EQ(sizeof(SnapshotMemoryArgs), 64U);
    EXPECT_EQ(sizeof(SnapshotMemoryArgs), sizeof(rtSnapShotBackupArgs));
    EXPECT_EQ(sizeof(SnapshotMemoryArgs), sizeof(rtSnapShotRestoreArgs));
    EXPECT_EQ(offsetof(SnapshotMemoryArgs, reserved), sizeof(uint32_t));
    uint32_t value = 99U;
    EXPECT_EQ(service.DispatchSnapshotRequest(static_cast<rtSnapshotOp>(0U), nullptr, value), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(value, 99U);
}

TEST_F(ApiSnapshotRouteTest, TransportReturnsInternalErrorsWithoutInitializingCallerRuntime)
{
    SnapshotService service;
    ASSERT_EQ(service.StartSnapshotService(&apiSnapshot_), RT_ERROR_NONE);
    apiSnapshot_.lockRet_ = RT_ERROR_INVALID_VALUE;
    const ScopeGuard restoreRuntime([this] { Runtime::runtime_ = runtime_; });
    Runtime::runtime_ = nullptr;
    MOCKER(RuntimeKeeperGetRuntime).expects(never());
    uint32_t value = 99U;
    EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::LOCK, nullptr, value), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(value, 99U);
    EXPECT_EQ(Runtime::runtime_, nullptr);
    EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::GET_STATE, nullptr, value), RT_ERROR_NONE);
    EXPECT_EQ(value, static_cast<uint32_t>(GlobalStateManager::GetInstance().GetCurrentState()));
    EXPECT_EQ(Runtime::runtime_, nullptr);
}

TEST_F(ApiSnapshotRouteTest, ClientWaitsForResultWithoutReceiveDeadline)
{
    SnapshotService service;
    ASSERT_EQ(service.StartSnapshotService(&apiSnapshot_), RT_ERROR_NONE);
    // Observe the actual connected client socket, rather than replacing recv or the operation.
    MOCKER(mmConnect).expects(once()).will(invoke(+[](mmSockHandle fd, mmSockAddr* address, mmSocklen_t length) {
        struct timeval timeout = {};
        socklen_t size = sizeof(timeout);
        EXPECT_EQ(getsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, &size), 0);
        EXPECT_EQ(timeout.tv_sec, 0);
        EXPECT_EQ(timeout.tv_usec, 0);
        EXPECT_EQ(getsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeout, &size), 0);
        EXPECT_EQ(timeout.tv_sec, 5);
        return connect(fd, reinterpret_cast<struct sockaddr*>(address), length);
    }));
    uint32_t value = 99U;
    EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::GET_STATE, nullptr, value), RT_ERROR_NONE);
    EXPECT_EQ(value, static_cast<uint32_t>(GlobalStateManager::GetInstance().GetCurrentState()));
}

TEST_F(ApiSnapshotRouteTest, RuntimeDestructionWaitsBeforeReleasingFeatureCallbacks)
{
    std::unique_ptr<Runtime> owned(new Runtime());
    ApiSnapshot* featureApi = CreateImplSnapshotAndGet();
    ASSERT_NE(featureApi, nullptr);
    owned->apiImplSnapshot_ = featureApi;
    owned->apiSnapshot_ = featureApi;
    g_featureBackupEntered.store(false);
    g_featureBackupReleased.store(false);
    const ScopeGuard resetBackup([] {
        g_featureBackupReleased.store(true);
        g_featureBackupEntered.store(false);
    });
    std::atomic<bool> destroyed{false};
    ASSERT_EQ(featureApi->SnapShotCallbackRegister(RT_SNAPSHOT_BACKUP_PRE, SnapshotCallback, nullptr), RT_ERROR_NONE);
    MOCKER(cce::runtime::SnapShotProcessBackup).stubs().will(invoke(DelayFeatureBackup));
    featureApi->StartSnapshotService(owned->GetChipType());
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_LOCKED);
    std::thread client;
    std::thread destroyer;
    const ScopeGuard finish([&] {
        g_featureBackupReleased.store(true);
        if (client.joinable()) {
            client.join();
        }
        if (destroyer.joinable()) {
            destroyer.join();
        }
    });
    client = std::thread([&] {
        uint32_t value = 99U;
        EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::BACKUP, nullptr, value), RT_ERROR_OS_HANDLE);
        EXPECT_EQ(value, 99U);
    });
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(2);
    while (!g_featureBackupEntered.load() && std::chrono::steady_clock::now() < deadline) {
        std::this_thread::yield();
    }
    ASSERT_TRUE(g_featureBackupEntered.load());
    int32_t tid = 0;
    EXPECT_EQ(featureApi->SnapShotProcessGetRestoreThreadId(&tid), RT_ERROR_NONE);
    EXPECT_GT(tid, 0);
    destroyer = std::thread([&] {
        owned.reset();
        destroyed.store(true);
    });
    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    EXPECT_FALSE(destroyed.load());
    g_featureBackupReleased.store(true);
    destroyer.join();
    client.join();
    EXPECT_TRUE(destroyed.load());
    uint32_t value = 123U;
    EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::GET_STATE, nullptr, value), RT_ERROR_OS_HANDLE);
    EXPECT_EQ(value, 123U);
}

class SnapshotAcceptFailureTest : public ApiSnapshotRouteTest, public WithParamInterface<int32_t> {};

TEST_P(SnapshotAcceptFailureTest, OnlyResourceExhaustionWaitsBeforeRetryAndAllCasesRecover)
{
    const ScopeGuard resetCounters([] {
        g_acceptAttempts.store(0U);
        g_backoffWaits.store(0U);
        g_interruptPoll.store(false);
        g_acceptError = EMFILE;
    });
    SnapshotService service;
    ASSERT_EQ(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()), 0);
    g_acceptError = GetParam();
    g_interruptPoll.store(true);
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_RUNNING);
    MOCKER(accept4).expects(exactly(3)).will(invoke(AcceptAfterResourceFailures));
    MOCKER(poll).stubs().will(invoke(PollRecordingBackoff));
    uint32_t value = 99U;
    const auto start = std::chrono::steady_clock::now();
    EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::GET_STATE, nullptr, value), ACL_RT_SUCCESS);
    const auto elapsed = std::chrono::steady_clock::now() - start;
    service.StopSnapshotService();
    EXPECT_EQ(value, static_cast<uint32_t>(RT_PROCESS_STATE_RUNNING));
    EXPECT_EQ(g_acceptAttempts.load(), 3U);
    const int32_t error = GetParam();
    const bool resourceFailure = (error == EMFILE) || (error == ENFILE) || (error == ENOBUFS) || (error == ENOMEM);
    EXPECT_EQ(g_backoffWaits.load(), resourceFailure ? 2U : 0U);
    if (resourceFailure) {
        EXPECT_GE(elapsed, std::chrono::milliseconds(180));
    }
    GlobalMockObject::verify();
}

INSTANTIATE_TEST_SUITE_P(
    AcceptErrors, SnapshotAcceptFailureTest, Values(EMFILE, ENFILE, ENOBUFS, ENOMEM, EAGAIN, EINTR, ECONNABORTED));

TEST_F(ApiSnapshotRouteTest, SocketStopWakesResourceBackoff)
{
    const ScopeGuard resetCounters([] {
        g_acceptAttempts.store(0U);
        g_backoffWaits.store(0U);
        g_acceptError = EMFILE;
    });
    SnapshotService service;
    ASSERT_EQ(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()), 0);
    MOCKER(accept4).expects(atLeast(1)).will(invoke(AcceptAfterResourceFailures));
    MOCKER(poll).stubs().will(invoke(PollRecordingBackoff));
    const int32_t client = mmSocket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
    ASSERT_GE(client, 0);
    const ScopeGuard closeClient([client] { (void)mmCloseSocket(client); });
    // The failing accept must run with a real pending connection.
    struct passwd* const entry = getpwuid(geteuid());
    ASSERT_NE(entry, nullptr);
    const std::string path = std::string(entry->pw_dir) + "/.cann_snapshot/" + std::to_string(mmGetPid()) + ".sock";
    struct sockaddr_un address = {};
    address.sun_family = AF_UNIX;
    ASSERT_EQ(memcpy_s(address.sun_path, sizeof(address.sun_path), path.c_str(), path.size() + 1U), EOK);
    ASSERT_EQ(connect(client, reinterpret_cast<struct sockaddr*>(&address), sizeof(address)), 0);
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(2);
    while ((g_backoffWaits.load() == 0U) && (std::chrono::steady_clock::now() < deadline)) {
        std::this_thread::yield();
    }
    ASSERT_GT(g_backoffWaits.load(), 0U);
    const auto start = std::chrono::steady_clock::now();
    service.StopSnapshotService();
    EXPECT_LT(std::chrono::steady_clock::now() - start, std::chrono::milliseconds(500));
    EXPECT_EQ(service.GetSnapshotThreadId(), 0);
    EXPECT_LE(g_acceptAttempts.load(), 2U);
    GlobalMockObject::verify();
}

class SnapshotTimeoutFailureTest : public ApiSnapshotRouteTest, public WithParamInterface<bool> {};

TEST_P(SnapshotTimeoutFailureTest, TimeoutSetupFailureDoesNotConnectOrChangeOutput)
{
    SnapshotService service;
    ASSERT_EQ(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()), 0);
    const bool receiveFails = GetParam();
    MOCKER(setsockopt)
        .expects(once())
        .with(mockcpp::any(), eq(SOL_SOCKET), eq(SO_RCVTIMEO))
        .will(returnValue(receiveFails ? -1 : 0));
    if (receiveFails) {
        MOCKER(setsockopt).expects(never()).with(mockcpp::any(), eq(SOL_SOCKET), eq(SO_SNDTIMEO));
    } else {
        MOCKER(setsockopt).expects(once()).with(mockcpp::any(), eq(SOL_SOCKET), eq(SO_SNDTIMEO)).will(returnValue(-1));
    }
    MOCKER(mmConnect).expects(never());
    uint32_t value = 99U;
    EXPECT_EQ(SnapshotSocketCall(mmGetPid(), rtSnapshotOp::GET_STATE, nullptr, value), RT_ERROR_OS_HANDLE);
    EXPECT_EQ(value, 99U);
}

INSTANTIATE_TEST_SUITE_P(ReceiveAndSend, SnapshotTimeoutFailureTest, Values(true, false));

namespace {
#define SOCKET_CHECK(condition)                                                                          \
    do {                                                                                                 \
        if (!(condition)) {                                                                              \
            throw std::runtime_error(std::string("line ") + std::to_string(__LINE__) + ": " #condition); \
        }                                                                                                \
    } while (false)

SnapshotService* g_service = nullptr;
uint32_t g_state = 0U;
std::atomic<bool> g_inCallback{false};
std::atomic<bool> g_releaseCallback{true};
std::atomic<bool> g_callbackTimedOut{false};

int32_t Dispatch(rtSnapshotOp op, const SnapshotMemoryArgs* args, uint32_t& value)
{
    if (op == rtSnapshotOp::GET_STATE) {
        value = g_state;
        return 0;
    }
    if (op == rtSnapshotOp::GET_RESTORE_THREAD_ID) {
        value = g_service->GetSnapshotThreadId();
        return 0;
    }
    if (op == rtSnapshotOp::LOCK) {
        if (g_state != 0U) {
            return RT_ERROR_SNAPSHOT_LOCK_FAILED;
        }
        g_state = 1U;
    } else if (op == rtSnapshotOp::BACKUP) {
        if (g_state != 1U) {
            return RT_ERROR_SNAPSHOT_BACKUP_FAILED;
        }
        if ((args != nullptr) && (args->reserved[0] == 'S')) {
            g_inCallback.store(true);
            const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(5);
            while (!g_releaseCallback.load() && (std::chrono::steady_clock::now() < deadline)) {
                std::this_thread::yield();
            }
            g_callbackTimedOut.store(!g_releaseCallback.load());
        }
        g_state = 2U;
    } else if (op == rtSnapshotOp::RESTORE) {
        if (g_state != 2U) {
            return RT_ERROR_SNAPSHOT_RESTORE_FAILED;
        }
        g_state = 1U;
    } else if (op == rtSnapshotOp::UNLOCK) {
        if (g_state != 1U) {
            return RT_ERROR_SNAPSHOT_UNLOCK_FAILED;
        }
        g_state = 0U;
    }
    // Verify null vs flags=0 and all reserved bytes survive transport.
    if (args != nullptr) {
        for (size_t i = 1U; i < sizeof(args->reserved); ++i) {
            if (args->reserved[i] != static_cast<char>(i)) {
                return -1234567;
            }
        }
    }
    return 0;
}

std::string Path(pid_t pid)
{
    struct passwd* entry = getpwuid(geteuid());
    SOCKET_CHECK(entry != nullptr);
    return std::string(entry->pw_dir) + "/.cann_snapshot/" + std::to_string(pid) + ".sock";
}

int32_t Connect(pid_t pid)
{
    struct sockaddr_un address = {};
    address.sun_family = AF_UNIX;
    const std::string path = Path(pid);
    SOCKET_CHECK(path.size() < sizeof(address.sun_path));
    SOCKET_CHECK(memcpy_s(address.sun_path, sizeof(address.sun_path), path.c_str(), path.size() + 1U) == EOK);
    const int32_t fd = socket(AF_UNIX, SOCK_STREAM, 0);
    SOCKET_CHECK(fd >= 0);
    SOCKET_CHECK(connect(fd, reinterpret_cast<struct sockaddr*>(&address), sizeof(address)) == 0);
    struct timeval timeout = {2, 0};
    SOCKET_CHECK(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout)) == 0);
    return fd;
}

class ChildServer {
public:
    explicit ChildServer(uid_t uid = static_cast<uid_t>(-1))
    {
        int32_t control[2];
        int32_t ready[2];
        SOCKET_CHECK(pipe(control) == 0);
        SOCKET_CHECK(pipe(ready) == 0);
        std::cout.flush();
        std::cerr.flush();
        pid_ = fork();
        SOCKET_CHECK(pid_ >= 0);
        if (pid_ == 0) {
            (void)close(control[1]);
            (void)close(ready[0]);
            if (uid != static_cast<uid_t>(-1)) {
                struct passwd* user = getpwuid(uid);
                if ((user == nullptr) || (setgid(user->pw_gid) != 0) || (setuid(uid) != 0)) {
                    _exit(2);
                }
            }
            SnapshotService service;
            g_state = 0U;
            g_service = &service;
            const int32_t result = service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_());
            (void)write(ready[1], &result, sizeof(result));
            char finish = 0;
            (void)read(control[0], &finish, sizeof(finish));
            service.StopSnapshotService();
            _exit(result == 0 ? 0 : 1);
        }
        (void)close(control[0]);
        (void)close(ready[1]);
        control_ = control[1];
        int32_t result = -1;
        SOCKET_CHECK(read(ready[0], &result, sizeof(result)) == sizeof(result));
        (void)close(ready[0]);
        SOCKET_CHECK(result == 0);
    }
    ~ChildServer()
    {
        const char finish = 1;
        (void)write(control_, &finish, sizeof(finish));
        (void)close(control_);
        (void)waitpid(pid_, nullptr, 0);
    }
    pid_t Pid() const { return pid_; }

private:
    pid_t pid_ = 0;
    int32_t control_ = -1;
};

void TestCrossProcess()
{
    ChildServer target;
    uint32_t value = 123U;
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_STATE, nullptr, value) == 0);
    SOCKET_CHECK(value == 0U);
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_RESTORE_THREAD_ID, nullptr, value) == 0);
    SOCKET_CHECK((value > 0U) && (value != static_cast<uint32_t>(target.Pid())));
    SOCKET_CHECK(
        access(("/proc/" + std::to_string(target.Pid()) + "/task/" + std::to_string(value)).c_str(), F_OK) == 0);
    SOCKET_CHECK(
        SnapshotSocketCall(target.Pid(), rtSnapshotOp::BACKUP, nullptr, value) == RT_ERROR_SNAPSHOT_BACKUP_FAILED);
    for (int32_t mode = -1; mode <= 1; ++mode) {
        SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::LOCK, nullptr, value) == 0);
        SOCKET_CHECK(
            SnapshotSocketCall(target.Pid(), rtSnapshotOp::LOCK, nullptr, value) == RT_ERROR_SNAPSHOT_LOCK_FAILED);
        SnapshotMemoryArgs args = {};
        args.flags = mode < 0 ? 0U : static_cast<uint32_t>(mode);
        for (size_t i = 1U; i < sizeof(args.reserved); ++i) {
            args.reserved[i] = static_cast<char>(i);
        }
        const auto* pointer = mode < 0 ? nullptr : &args;
        SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::BACKUP, pointer, value) == 0);
        SOCKET_CHECK(value == 0U);
        SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_STATE, nullptr, value) == 0);
        SOCKET_CHECK(value == 2U);
        SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::RESTORE, pointer, value) == 0);
        SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::UNLOCK, nullptr, value) == 0);
    }
    struct stat node = {};
    SOCKET_CHECK(lstat(Path(target.Pid()).c_str(), &node) == 0);
    SOCKET_CHECK(S_ISSOCK(node.st_mode) && ((node.st_mode & 0777U) == 0600U));
    std::vector<std::thread> clients;
    std::atomic<int32_t> failures{0};
    for (int32_t i = 0; i < 8; ++i) {
        clients.emplace_back([&] {
            uint32_t state = 99U;
            if ((SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_STATE, nullptr, state) != 0) || (state != 0U)) {
                failures.fetch_add(1);
            }
        });
    }
    for (auto& thread : clients) {
        thread.join();
    }
    SOCKET_CHECK(failures.load() == 0);
    std::cout << "PASS cross-process commands, args/reserved, TID, state, concurrent clients\n";
}

void TestMalformedProtocol()
{
    ChildServer target;
    const SnapshotRequestHeader malformed[] = {
        {0U, htonl(1U), htonl(5U), 0U},
        {htonl(0x534E4150U), htonl(2U), htonl(5U), 0U},
        {htonl(0x534E4150U), htonl(1U), htonl(99U), 0U},
        {htonl(0x534E4150U), htonl(1U), htonl(1U), htonl(64U)},
        {htonl(0x534E4150U), htonl(1U), htonl(2U), htonl(0xFFFFFFFFU)},
    };
    for (const auto& request : malformed) {
        const int32_t fd = Connect(target.Pid());
        SOCKET_CHECK(send(fd, &request, sizeof(request), MSG_NOSIGNAL) == sizeof(request));
        char response = 0;
        SOCKET_CHECK(recv(fd, &response, sizeof(response), 0) == 0);
        (void)close(fd);
    }
    // A truncated request must not execute LOCK.
    int32_t fd = Connect(target.Pid());
    SnapshotRequestHeader request = {htonl(0x534E4150U), htonl(1U), htonl(1U), 0U};
    SOCKET_CHECK(send(fd, &request, 5U, MSG_NOSIGNAL) == 5);
    SOCKET_CHECK(shutdown(fd, SHUT_WR) == 0);
    char byte = 0;
    SOCKET_CHECK(recv(fd, &byte, 1U, 0) == 0);
    (void)close(fd);
    uint32_t value = 99U;
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_STATE, nullptr, value) == 0);
    SOCKET_CHECK(value == 0U);
    // A complete BACKUP header with a truncated body must not reach the RT dispatcher.
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::LOCK, nullptr, value) == 0);
    fd = Connect(target.Pid());
    request.op = htonl(static_cast<uint32_t>(rtSnapshotOp::BACKUP));
    request.argsSize = htonl(sizeof(SnapshotMemoryArgs));
    const SnapshotMemoryArgs partialArgs = {};
    SOCKET_CHECK(send(fd, &request, sizeof(request), MSG_NOSIGNAL) == sizeof(request));
    SOCKET_CHECK(send(fd, &partialArgs, sizeof(partialArgs) - 1U, MSG_NOSIGNAL) == sizeof(partialArgs) - 1U);
    SOCKET_CHECK(shutdown(fd, SHUT_WR) == 0);
    SOCKET_CHECK(recv(fd, &byte, 1U, 0) == 0);
    (void)close(fd);
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_STATE, nullptr, value) == 0);
    SOCKET_CHECK(value == 1U);
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::UNLOCK, nullptr, value) == 0);
    // Raw socket clients bypass the public ACL validation; reject invalid flags before dispatch.
    fd = Connect(target.Pid());
    request.op = htonl(static_cast<uint32_t>(rtSnapshotOp::BACKUP));
    request.argsSize = htonl(sizeof(SnapshotMemoryArgs));
    SnapshotMemoryArgs invalid = {};
    invalid.flags = htonl(2U);
    SOCKET_CHECK(send(fd, &request, sizeof(request), MSG_NOSIGNAL) == sizeof(request));
    SOCKET_CHECK(send(fd, &invalid, sizeof(invalid), MSG_NOSIGNAL) == sizeof(invalid));
    SOCKET_CHECK(recv(fd, &byte, 1U, 0) == 0);
    (void)close(fd);
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_STATE, nullptr, value) == 0);
    SOCKET_CHECK(value == 0U);
    // Preserve a signed error and leave the caller's output untouched on failure.
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::LOCK, nullptr, value) == 0);
    SnapshotMemoryArgs badReserved = {};
    value = 77U;
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::BACKUP, &badReserved, value) == -1234567);
    SOCKET_CHECK(value == 77U);
    // Force the production receive loop to assemble a fragmented header.
    fd = Connect(target.Pid());
    request.op = htonl(5U);
    request.argsSize = 0U;
    for (size_t i = 0U; i < sizeof(request); ++i) {
        SOCKET_CHECK(send(fd, reinterpret_cast<char*>(&request) + i, 1U, MSG_NOSIGNAL) == 1);
    }
    SnapshotResponse response = {};
    SOCKET_CHECK(recv(fd, &response, sizeof(response), MSG_WAITALL) == sizeof(response));
    SOCKET_CHECK(ntohl(response.magic) == 0x534E4150U);
    (void)close(fd);
    std::cout << "PASS malformed/truncated/fragmented protocol\n";
}

void TestPerReceiveTimeout()
{
    ChildServer target;
    const int32_t fd = Connect(target.Pid());
    SnapshotRequestHeader request = {htonl(0x534E4150U), htonl(1U), htonl(5U), 0U};
    const auto* bytes = reinterpret_cast<const char*>(&request);
    SOCKET_CHECK(send(fd, bytes, 4U, MSG_NOSIGNAL) == 4);
    std::this_thread::sleep_for(std::chrono::seconds(3));
    SOCKET_CHECK(send(fd, bytes + 4U, 4U, MSG_NOSIGNAL) == 4);
    std::this_thread::sleep_for(std::chrono::seconds(3));
    SOCKET_CHECK(send(fd, bytes + 8U, sizeof(request) - 8U, MSG_NOSIGNAL) == sizeof(request) - 8U);
    SnapshotResponse response = {};
    SOCKET_CHECK(recv(fd, &response, sizeof(response), MSG_WAITALL) == sizeof(response));
    SOCKET_CHECK(ntohl(response.magic) == 0x534E4150U);
    SOCKET_CHECK(response.result == 0);
    SOCKET_CHECK(ntohl(response.value) == 0U);
    (void)close(fd);
    std::cout << "PASS fragmented request beyond 5 seconds with per-receive timeout\n";
}

void TestStopForkAndDisconnect()
{
    SnapshotService service;
    std::thread stopper;
    std::atomic<bool> stopReturned{false};
    const uint32_t oldState = g_state;
    SnapshotService* const oldService = g_service;
    const ScopeGuard finish([&] {
        g_releaseCallback.store(true);
        if (stopper.joinable()) {
            stopper.join();
        }
        g_service = oldService;
        g_state = oldState;
    });
    g_service = &service;
    SOCKET_CHECK(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()) == 0);
    // Starting the same service twice must not remove its active endpoint.
    SOCKET_CHECK(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()) != 0);
    SOCKET_CHECK(access(Path(getpid()).c_str(), F_OK) == 0);
    std::cout.flush();
    const pid_t child = fork();
    SOCKET_CHECK(child >= 0);
    if (child == 0) {
        const bool invalidTid = service.GetSnapshotThreadId() == 0;
        service.StopSnapshotService();
        _exit(invalidTid ? 0 : 1);
    }
    int32_t status = 0;
    SOCKET_CHECK(waitpid(child, &status, 0) == child);
    SOCKET_CHECK(WIFEXITED(status) && (WEXITSTATUS(status) == 0));
    uint32_t value = 0U;
    SOCKET_CHECK(SnapshotSocketCall(getpid(), rtSnapshotOp::LOCK, nullptr, value) == 0);
    g_inCallback.store(false);
    g_releaseCallback.store(false);
    g_callbackTimedOut.store(false);
    const int32_t fd = Connect(getpid());
    SnapshotRequestHeader request = {htonl(0x534E4150U), htonl(1U), htonl(2U), htonl(64U)};
    SnapshotMemoryArgs args = {};
    args.reserved[0] = 'S';
    for (size_t i = 1U; i < sizeof(args.reserved); ++i) {
        args.reserved[i] = static_cast<char>(i);
    }
    SOCKET_CHECK(send(fd, &request, sizeof(request), MSG_NOSIGNAL) == sizeof(request));
    SOCKET_CHECK(send(fd, &args, sizeof(args), MSG_NOSIGNAL) == sizeof(args));
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(2);
    while (!g_inCallback.load() && (std::chrono::steady_clock::now() < deadline)) {
        std::this_thread::yield();
    }
    SOCKET_CHECK(g_inCallback.load());
    (void)close(fd); // Disconnect only after the RT operation has definitely started.
    stopper = std::thread([&] {
        service.StopSnapshotService();
        stopReturned.store(true);
    });
    const auto stopDeadline = std::chrono::steady_clock::now() + std::chrono::seconds(2);
    while ((service.GetSnapshotThreadId() != 0) && (std::chrono::steady_clock::now() < stopDeadline)) {
        std::this_thread::yield();
    }
    SOCKET_CHECK(service.GetSnapshotThreadId() == 0); // Stop has set its stopping flag.
    SOCKET_CHECK(!stopReturned.load());               // It must still wait for the executing callback.
    SOCKET_CHECK(!g_callbackTimedOut.load());
    g_releaseCallback.store(true);
    stopper.join();
    SOCKET_CHECK(stopReturned.load());
    SOCKET_CHECK(!g_callbackTimedOut.load());
    SOCKET_CHECK(g_state == 2U);
    SOCKET_CHECK(service.GetSnapshotThreadId() == 0);
    SOCKET_CHECK(access(Path(getpid()).c_str(), F_OK) != 0);
    SOCKET_CHECK(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()) == 0);
    const int32_t idleFd = Connect(getpid());
    const char partialHeader = 'S';
    SOCKET_CHECK(send(idleFd, &partialHeader, sizeof(partialHeader), MSG_NOSIGNAL) == sizeof(partialHeader));
    // Let the service enter receive waiting for the rest of the header.
    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    const auto start = std::chrono::steady_clock::now();
    service.StopSnapshotService();
    SOCKET_CHECK(std::chrono::steady_clock::now() - start < std::chrono::seconds(1));
    (void)close(idleFd);
    service.StopSnapshotService();
    std::cout << "PASS endpoint conflict, fork isolation, disconnect, in-flight/idle stop, restart\n";
}

void TestIncompleteRequestTimesOutAndServiceRecovers()
{
    ChildServer target;
    const int32_t fd = Connect(target.Pid());
    const ScopeGuard closeClient([fd] { (void)close(fd); });
    struct timeval timeout = {8, 0};
    SOCKET_CHECK(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout)) == 0);
    const SnapshotRequestHeader request = {htonl(0x534E4150U), htonl(1U), htonl(1U), 0U};
    SOCKET_CHECK(send(fd, &request, 1U, MSG_NOSIGNAL) == 1);
    char byte = 0;
    const auto start = std::chrono::steady_clock::now();
    SOCKET_CHECK(recv(fd, &byte, 1U, 0) == 0);
    const auto elapsed = std::chrono::steady_clock::now() - start;
    SOCKET_CHECK(elapsed >= std::chrono::seconds(4));
    SOCKET_CHECK(elapsed < std::chrono::seconds(8));
    uint32_t value = 99U;
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_STATE, nullptr, value) == 0);
    SOCKET_CHECK(value == 0U);
    std::cout << "PASS incomplete request times out without dispatch; next request succeeds\n";
}

void TestResponseValidation()
{
    // Use a real same-PID/same-UID peer so credential checks pass before response validation.
    SnapshotService service;
    SOCKET_CHECK(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()) == 0);
    service.StopSnapshotService();
    const std::string path = Path(getpid());
    for (uint32_t fault = 0U; fault < 5U; ++fault) {
        const int32_t listener = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
        SOCKET_CHECK(listener >= 0);
        bool bound = false;
        const ScopeGuard cleanup([&] {
            (void)close(listener);
            if (bound) {
                (void)unlink(path.c_str());
            }
        });
        struct sockaddr_un address = {};
        address.sun_family = AF_UNIX;
        SOCKET_CHECK(memcpy_s(address.sun_path, sizeof(address.sun_path), path.c_str(), path.size() + 1U) == EOK);
        SOCKET_CHECK(bind(listener, reinterpret_cast<struct sockaddr*>(&address), sizeof(address)) == 0);
        bound = true;
        SOCKET_CHECK(chmod(path.c_str(), 0600U) == 0);
        SOCKET_CHECK(listen(listener, 1) == 0);
        bool peerOk = false;
        std::thread peer([&] {
            struct pollfd ready = {listener, POLLIN, 0};
            if (poll(&ready, 1U, 5000) != 1) {
                return;
            }
            const int32_t fd = accept(listener, nullptr, nullptr);
            if (fd < 0) {
                return;
            }
            const ScopeGuard closePeer([fd] { (void)close(fd); });
            struct timeval timeout = {2, 0};
            (void)setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout));
            SnapshotRequestHeader request = {};
            if (recv(fd, &request, sizeof(request), MSG_WAITALL) != sizeof(request)) {
                return;
            }
            SnapshotResponse response = {htonl(0x534E4150U), htonl(1U), 0, htonl(42U)};
            if (fault == 0U) {
                response.magic = 0U;
            } else if (fault == 1U) {
                response.version = htonl(2U);
            }
            char bytes[sizeof(response) + 1U] = {};
            (void)memcpy_s(bytes, sizeof(bytes), &response, sizeof(response));
            const size_t size = fault == 2U ? sizeof(response) - 1U : (fault == 3U ? sizeof(bytes) : sizeof(response));
            peerOk = send(fd, bytes, size, MSG_NOSIGNAL) == static_cast<ssize_t>(size);
            if ((fault == 4U) && peerOk) {
                // Keep the connection open until the client has consumed its complete response and closed it.
                char byte = 0;
                peerOk = recv(fd, &byte, sizeof(byte), 0) == 0;
            }
        });
        const ScopeGuard joinPeer([&peer] {
            if (peer.joinable()) {
                peer.join();
            }
        });
        uint32_t value = 77U;
        const auto start = std::chrono::steady_clock::now();
        const int32_t result = SnapshotSocketCall(getpid(), rtSnapshotOp::GET_STATE, nullptr, value);
        const auto elapsed = std::chrono::steady_clock::now() - start;
        peer.join();
        SOCKET_CHECK(peerOk);
        if (fault < 3U) {
            SOCKET_CHECK(result == RT_ERROR_OS_HANDLE);
            SOCKET_CHECK(value == 77U);
        } else {
            SOCKET_CHECK(result == 0);
            SOCKET_CHECK(value == 42U);
            SOCKET_CHECK(elapsed < std::chrono::seconds(1));
        }
    }
    std::cout << "PASS invalid responses preserve output; complete responses return without waiting for EOF\n";
}

void TestInvalidEndpointsPreserveOutput()
{
    SnapshotService service;
    SOCKET_CHECK(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()) == 0);
    service.StopSnapshotService();
    uint32_t value = 77U;
    SOCKET_CHECK(SnapshotSocketCall(INT32_MAX, rtSnapshotOp::GET_STATE, nullptr, value) == RT_ERROR_OS_HANDLE);
    SOCKET_CHECK(value == 77U);
    SOCKET_CHECK(SnapshotSocketCall(getpid(), rtSnapshotOp::GET_STATE, nullptr, value) == RT_ERROR_OS_HANDLE);
    SOCKET_CHECK(value == 77U);
    const std::string path = Path(getpid());
    for (uint32_t fault = 0U; fault < 3U; ++fault) {
        const int32_t fd = fault == 0U ? open(path.c_str(), O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC, 0600U) :
                                         socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
        SOCKET_CHECK(fd >= 0);
        bool bound = fault == 0U;
        const ScopeGuard cleanup([&] {
            (void)close(fd);
            if (bound) {
                (void)unlink(path.c_str());
            }
        });
        if (fault != 0U) {
            struct sockaddr_un address = {};
            address.sun_family = AF_UNIX;
            SOCKET_CHECK(memcpy_s(address.sun_path, sizeof(address.sun_path), path.c_str(), path.size() + 1U) == EOK);
            SOCKET_CHECK(bind(fd, reinterpret_cast<struct sockaddr*>(&address), sizeof(address)) == 0);
            bound = true;
            SOCKET_CHECK(chmod(path.c_str(), fault == 1U ? 0640U : 0600U) == 0);
        }
        SOCKET_CHECK(SnapshotSocketCall(getpid(), rtSnapshotOp::GET_STATE, nullptr, value) == RT_ERROR_OS_HANDLE);
        SOCKET_CHECK(value == 77U);
        struct stat node = {};
        SOCKET_CHECK(lstat(path.c_str(), &node) == 0); // The client must not delete a rejected endpoint.
    }
    std::cout << "PASS missing PID/endpoint, ordinary file, wrong permissions, refused connection preserve output\n";
}

size_t CountEntries(const char* path)
{
    DIR* const directory = opendir(path);
    SOCKET_CHECK(directory != nullptr);
    const ScopeGuard closeDirectory([directory] { (void)closedir(directory); });
    size_t count = 0U;
    while (readdir(directory) != nullptr) {
        ++count;
    }
    return count;
}

void TestRepeatedLifecycleReleasesResources()
{
    const size_t descriptors = CountEntries("/proc/self/fd");
    const size_t threads = CountEntries("/proc/self/task");
    const uint32_t expectedState = g_state;
    SnapshotService service;
    for (uint32_t round = 0U; round < 100U; ++round) {
        SOCKET_CHECK(service.StartSnapshotService(Runtime::Instance()->ApiSnapshot_()) == 0);
        uint32_t value = 99U;
        SOCKET_CHECK(SnapshotSocketCall(getpid(), rtSnapshotOp::GET_STATE, nullptr, value) == 0);
        SOCKET_CHECK(value == expectedState);
        SOCKET_CHECK(service.GetSnapshotThreadId() > 0);
        const auto start = std::chrono::steady_clock::now();
        service.StopSnapshotService();
        SOCKET_CHECK(std::chrono::steady_clock::now() - start < std::chrono::seconds(1));
        service.StopSnapshotService();
        SOCKET_CHECK(service.GetSnapshotThreadId() == 0);
        SOCKET_CHECK(access(Path(getpid()).c_str(), F_OK) != 0);
    }
    SOCKET_CHECK(CountEntries("/proc/self/fd") == descriptors);
    SOCKET_CHECK(CountEntries("/proc/self/task") == threads);
    std::cout << "PASS 100 start/query/idle stop/repeated stop cycles without FD/thread/endpoint leaks\n";
}

void TestRootAuthorization(uid_t targetUid)
{
    SOCKET_CHECK(geteuid() == 0U);
    SOCKET_CHECK(targetUid != 0U);
    ChildServer target(targetUid);
    uint32_t value = 99U;
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_STATE, nullptr, value) == 0);
    SOCKET_CHECK(value == 0U);
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::LOCK, nullptr, value) == 0);
    SOCKET_CHECK(SnapshotSocketCall(target.Pid(), rtSnapshotOp::UNLOCK, nullptr, value) == 0);
    const pid_t unauthorized = fork();
    SOCKET_CHECK(unauthorized >= 0);
    if (unauthorized == 0) {
        const uid_t otherUid = targetUid == 65534U ? 65533U : 65534U;
        if ((setgid(otherUid) != 0) || (setuid(otherUid) != 0)) {
            _exit(2);
        }
        const int32_t ret = SnapshotSocketCall(target.Pid(), rtSnapshotOp::GET_STATE, nullptr, value);
        _exit(ret == 0 ? 1 : 0);
    }
    int32_t status = 0;
    SOCKET_CHECK(waitpid(unauthorized, &status, 0) == unauthorized);
    SOCKET_CHECK(WIFEXITED(status) && (WEXITSTATUS(status) == 0));
    std::cout << "PASS root controls target user's socket; other user rejected\n";
}

class SocketApi : public ApiSnapshotRouteStub {
public:
    rtError_t SnapShotProcessLock() override { return Call(rtSnapshotOp::LOCK); }
    rtError_t SnapShotProcessUnlock() override { return Call(rtSnapshotOp::UNLOCK); }
    rtError_t SnapShotProcessBackup(const rtSnapShotBackupArgs* args) override
    {
        return Call(rtSnapshotOp::BACKUP, args);
    }
    rtError_t SnapShotProcessRestore(const rtSnapShotRestoreArgs* args) override
    {
        return Call(rtSnapshotOp::RESTORE, args);
    }
    rtError_t SnapShotProcessGetState(rtProcessState* state) override
    {
        *state = static_cast<rtProcessState>(g_state);
        return RT_ERROR_NONE;
    }
    rtError_t SnapShotProcessGetRestoreThreadId(int32_t* tid) override
    {
        *tid = g_service->GetSnapshotThreadId();
        return RT_ERROR_NONE;
    }

private:
    rtError_t Call(rtSnapshotOp op, const void* args = nullptr)
    {
        uint32_t value = 0U;
        return Dispatch(op, static_cast<const SnapshotMemoryArgs*>(args), value);
    }
};

class SnapshotSocketTransportTest : public Test {
protected:
    void SetUp() override
    {
        g_state = 0U;
        g_service = nullptr;
        g_inCallback.store(false);
        g_releaseCallback.store(true);
        g_callbackTimedOut.store(false);
        runtime_ = Runtime::Instance();
        ASSERT_NE(runtime_, nullptr);
        oldApi_ = runtime_->apiSnapshot_;
        runtime_->apiSnapshot_ = &api_;
    }

    void TearDown() override
    {
        runtime_->apiSnapshot_ = oldApi_;
        GlobalMockObject::verify();
        g_state = 0U;
        g_service = nullptr;
        g_inCallback.store(false);
        g_releaseCallback.store(true);
        g_callbackTimedOut.store(false);
    }
    Runtime* runtime_ = nullptr;
    ApiSnapshot* oldApi_ = nullptr;
    SocketApi api_;
};

std::string g_socketTestHome;

class SnapshotSocketUnlinkTest : public SnapshotSocketTransportTest, public WithParamInterface<uint32_t> {
protected:
    void SetUp() override
    {
        SnapshotSocketTransportTest::SetUp();
        char home[] = "/tmp/rt-snapshot-unlink-XXXXXX";
        ASSERT_NE(mkdtemp(home), nullptr);
        g_socketTestHome = home;
        directory_ = g_socketTestHome + "/.cann_snapshot";
        ASSERT_EQ(mkdir(directory_.c_str(), 0700U), 0);
        path_ = directory_ + "/" + std::to_string(getpid()) + ".sock";
        MOCKER(getpwuid_r)
            .stubs()
            .will(invoke(+[](uid_t uid, struct passwd* entry, char*, size_t, struct passwd** found) {
                entry->pw_uid = uid;
                entry->pw_dir = const_cast<char*>(g_socketTestHome.c_str());
                *found = entry;
                return 0;
            }));
    }

    void TearDown() override
    {
        (void)unlink(path_.c_str());
        EXPECT_EQ(rmdir(directory_.c_str()), 0);
        EXPECT_EQ(rmdir(g_socketTestHome.c_str()), 0);
        g_socketTestHome.clear();
        SnapshotSocketTransportTest::TearDown();
    }

    std::string directory_;
    std::string path_;
};

TEST_P(SnapshotSocketUnlinkTest, ReplacesOldNodeAndServesRequestsAtTheOriginalPath)
{
    if (GetParam() == 0U) {
        const int32_t fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
        ASSERT_GE(fd, 0);
        const ScopeGuard closeSocket([fd] { (void)close(fd); });
        struct sockaddr_un address = {};
        address.sun_family = AF_UNIX;
        ASSERT_EQ(memcpy_s(address.sun_path, sizeof(address.sun_path), path_.c_str(), path_.size() + 1U), EOK);
        ASSERT_EQ(bind(fd, reinterpret_cast<struct sockaddr*>(&address), sizeof(address)), 0);
    } else if (GetParam() == 1U) {
        const int32_t fd = open(path_.c_str(), O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC, 0600U);
        ASSERT_GE(fd, 0);
        ASSERT_EQ(close(fd), 0);
    } else {
        ASSERT_EQ(symlink("missing-snapshot-endpoint", path_.c_str()), 0);
    }
    const size_t descriptors = CountEntries("/proc/self/fd");
    SnapshotService service;
    ASSERT_EQ(service.StartSnapshotService(&api_), RT_ERROR_NONE);
    struct stat node = {};
    ASSERT_EQ(lstat(path_.c_str(), &node), 0);
    EXPECT_TRUE(S_ISSOCK(node.st_mode));
    EXPECT_EQ(node.st_uid, geteuid());
    EXPECT_EQ(node.st_mode & 0777U, 0600U);
    uint32_t value = 99U;
    EXPECT_EQ(SnapshotSocketCall(getpid(), rtSnapshotOp::GET_STATE, nullptr, value), RT_ERROR_NONE);
    EXPECT_EQ(value, 0U);
    service.StopSnapshotService();
    EXPECT_NE(access(path_.c_str(), F_OK), 0);
    EXPECT_EQ(CountEntries("/proc/self/fd"), descriptors);
}

INSTANTIATE_TEST_SUITE_P(StaleSocketFileAndSymlink, SnapshotSocketUnlinkTest, Values(0U, 1U, 2U));

TEST_F(SnapshotSocketUnlinkTest, UnlinkFailureStillAttemptsBindAndClosesResources)
{
    ASSERT_EQ(mkdir(path_.c_str(), 0700U), 0);
    const ScopeGuard removeDirectory([this] { (void)rmdir(path_.c_str()); });
    const size_t descriptors = CountEntries("/proc/self/fd");
    MOCKER(mmBind).expects(once()).will(invoke(+[](mmSockHandle fd, mmSockAddr* address, mmSocklen_t length) {
        return bind(fd, reinterpret_cast<struct sockaddr*>(address), length);
    }));
    SnapshotService service;
    EXPECT_EQ(service.StartSnapshotService(&api_), RT_ERROR_OS_HANDLE);
    struct stat node = {};
    ASSERT_EQ(lstat(path_.c_str(), &node), 0);
    EXPECT_TRUE(S_ISDIR(node.st_mode));
    EXPECT_EQ(CountEntries("/proc/self/fd"), descriptors);
}

TEST_F(SnapshotSocketUnlinkTest, MissingPathSkipsUnlinkAndBindsSuccessfully)
{
    const size_t descriptors = CountEntries("/proc/self/fd");
    MOCKER(unlinkat).expects(never());
    SnapshotService service;
    ASSERT_EQ(service.StartSnapshotService(&api_), RT_ERROR_NONE);
    uint32_t value = 99U;
    EXPECT_EQ(SnapshotSocketCall(getpid(), rtSnapshotOp::GET_STATE, nullptr, value), RT_ERROR_NONE);
    EXPECT_EQ(value, 0U);
    GlobalMockObject::verify();
    service.StopSnapshotService();
    EXPECT_NE(access(path_.c_str(), F_OK), 0);
    EXPECT_EQ(CountEntries("/proc/self/fd"), descriptors);
}

TEST_F(SnapshotSocketUnlinkTest, ListenFailureRemovesTheRecreatedEndpointAndClosesResources)
{
    ASSERT_EQ(symlink("missing-snapshot-endpoint", path_.c_str()), 0);
    const size_t descriptors = CountEntries("/proc/self/fd");
    MOCKER(mmListen).expects(once()).will(returnValue(EN_ERROR));
    SnapshotService service;
    EXPECT_EQ(service.StartSnapshotService(&api_), RT_ERROR_OS_HANDLE);
    EXPECT_NE(access(path_.c_str(), F_OK), 0);
    EXPECT_EQ(CountEntries("/proc/self/fd"), descriptors);
}

#undef SOCKET_CHECK
} // namespace

TEST_F(SnapshotSocketTransportTest, CrossProcess) { EXPECT_NO_THROW(TestCrossProcess()); }

TEST_F(SnapshotSocketTransportTest, MalformedProtocol) { EXPECT_NO_THROW(TestMalformedProtocol()); }

TEST_F(SnapshotSocketTransportTest, PerReceiveTimeout) { EXPECT_NO_THROW(TestPerReceiveTimeout()); }

TEST_F(SnapshotSocketTransportTest, StopForkAndDisconnect) { EXPECT_NO_THROW(TestStopForkAndDisconnect()); }

TEST_F(SnapshotSocketTransportTest, IncompleteRequestTimesOutAndServiceRecovers)
{
    EXPECT_NO_THROW(TestIncompleteRequestTimesOutAndServiceRecovers());
}

TEST_F(SnapshotSocketTransportTest, ResponseValidation) { EXPECT_NO_THROW(TestResponseValidation()); }

TEST_F(SnapshotSocketTransportTest, InvalidEndpointsPreserveOutput)
{
    EXPECT_NO_THROW(TestInvalidEndpointsPreserveOutput());
}

TEST_F(SnapshotSocketTransportTest, RepeatedLifecycleReleasesResources)
{
    EXPECT_NO_THROW(TestRepeatedLifecycleReleasesResources());
}

TEST_F(SnapshotSocketTransportTest, RootAuthorization)
{
    const char* const originalUid = std::getenv("SUDO_UID");
    if ((geteuid() != 0U) || (originalUid == nullptr) || (std::string(originalUid) == "0")) {
        GTEST_SKIP() << "Run with sudo from a non-root account to test cross-user authorization.";
    }
    EXPECT_NO_THROW(TestRootAuthorization(static_cast<uid_t>(std::stoul(originalUid))));
}

TEST_F(ApiSnapshotRouteTest, CallbackOwnershipIsScopedToTheFeatureInstance)
{
    ApiImplSnapshot first;
    ApiImplSnapshot second;
    EXPECT_EQ(first.SnapShotCallbackRegister(RT_SNAPSHOT_BACKUP_PRE, SnapshotCallback, nullptr), RT_ERROR_NONE);
    EXPECT_EQ(second.SnapShotCallbackRegister(RT_SNAPSHOT_BACKUP_PRE, SnapshotCallback, nullptr), RT_ERROR_NONE);
    EXPECT_EQ(first.SnapShotCallbackUnregister(RT_SNAPSHOT_BACKUP_PRE, SnapshotCallback), RT_ERROR_NONE);
    EXPECT_EQ(second.SnapShotCallbackUnregister(RT_SNAPSHOT_BACKUP_PRE, SnapshotCallback), RT_ERROR_NONE);
}
