/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cerrno>
#include <cstdlib>
#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "api.hpp"
#include "thread_local_container.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr int32_t STREAM_SYNC_WAIT_INTERVAL_MS = 5;
constexpr uint32_t STREAM_SYNC_EXPECTED_COUNT = 1U;
constexpr uint64_t NANOSECONDS_PER_SECOND = static_cast<uint64_t>(RT_MS_PER_S) * RT_MS_TO_NS;
} // namespace

rtError_t CreateSyncFuncArgs(SyncFuncArgs*& args)
{
    args = nullptr;
    auto* syncArgs = static_cast<SyncFuncArgs*>(malloc(sizeof(SyncFuncArgs)));
    COND_RETURN_ERROR(syncArgs == nullptr, RT_ERROR_MEMORY_ALLOCATION, "Allocate sync callback args failed.");
    ScopeGuard argsGuard([syncArgs]() { free(syncArgs); });

    pthread_condattr_t attr;
    COND_RETURN_ERROR(pthread_condattr_init(&attr) != 0, RT_ERROR_OS_HANDLE, "Init sync condition attributes failed.");
    ScopeGuard attrGuard([&attr]() { (void)pthread_condattr_destroy(&attr); });

    COND_RETURN_ERROR(
        pthread_condattr_setclock(&attr, CLOCK_MONOTONIC) != 0, RT_ERROR_OS_HANDLE, "Set sync condition clock failed.");
    COND_RETURN_ERROR(
        pthread_cond_init(&syncArgs->cond, &attr) != 0, RT_ERROR_OS_HANDLE, "Init sync condition failed.");
    ScopeGuard condGuard([syncArgs]() { (void)pthread_cond_destroy(&syncArgs->cond); });

    attrGuard.ReleaseGuard();
    COND_RETURN_ERROR(
        pthread_condattr_destroy(&attr) != 0, RT_ERROR_OS_HANDLE, "Destroy sync condition attributes failed.");
    COND_RETURN_ERROR(
        pthread_mutex_init(&syncArgs->mutex, nullptr) != 0, RT_ERROR_OS_HANDLE, "Init sync mutex failed.");

    syncArgs->currentCnt = 0U;
    condGuard.ReleaseGuard();
    argsGuard.ReleaseGuard();
    args = syncArgs;
    return RT_ERROR_NONE;
}

void DestroySyncFuncArgs(SyncFuncArgs* args)
{
    if (args == nullptr) {
        return;
    }
    const int32_t condRet = pthread_cond_destroy(&args->cond);
    const int32_t mutexRet = pthread_mutex_destroy(&args->mutex);
    COND_LOG_ERROR(
        (condRet != 0) || (mutexRet != 0), "Destroy sync arguments failed, cond=%d, mutex=%d.", condRet, mutexRet);
    free(args);
}

static void syncCallback(void* userData)
{
    auto* args = static_cast<SyncFuncArgs*>(userData);
    const int32_t lockRet = pthread_mutex_lock(&args->mutex);
    COND_RETURN_VOID(lockRet != 0, "Lock sync arguments failed, ret=%d.", lockRet);
    ++args->currentCnt;
    const int32_t signalRet = pthread_cond_signal(&args->cond);
    COND_LOG_ERROR(signalRet != 0, "Signal sync arguments failed, ret=%d.", signalRet);
    // The waiter may destroy args after acquiring this mutex. Do not access it after unlock.
    (void)pthread_mutex_unlock(&args->mutex);
}

rtError_t Stream::CheckSyncStatus() const
{
    const rtError_t error = CheckContextStatus(false);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    if (GetAbortStatus() == RT_ERROR_STREAM_ABORT) {
        return RT_ERROR_STREAM_ABORT;
    }
    if (device_->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT) {
        return RT_ERROR_DEVICE_TASK_ABORT;
    }
    return (GetStreamStatus() == StreamStatus::NORMAL) ? RT_ERROR_NONE : RT_ERROR_STREAM_SYNC;
}

rtError_t Stream::SynchronizeBlocking(int32_t timeout)
{
    device_->WakeUpRecycleThread();
    ScopeGuard wakeGuard([this]() { device_->WakeUpRecycleThread(); });

    const mmTimespec beginTime = mmGetTickCount();
    SyncFuncArgs* args = nullptr;
    rtError_t error = CreateSyncFuncArgs(args);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Create sync callback args failed, device_id=%u, stream_id=%d, retCode=%#x.",
        device_->Id_(), streamId_, error);
    ScopeGuard argsGuard([args]() { DestroySyncFuncArgs(args); });
    std::list<SyncFuncArgs*> syncArgs;
    try {
        syncArgs.push_back(args);
    } catch (const std::bad_alloc&) {
        RT_LOG(
            RT_LOG_ERROR, "Allocate sync callback args list node failed, device_id=%u, stream_id=%d.", device_->Id_(),
            streamId_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    error = CheckSyncStatus();
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Check sync status failed, device_id=%u, stream_id=%d, retCode=%#x.",
        device_->Id_(), streamId_, error);

    COND_PROC_RETURN_ERROR(
        IsProcessTimeout(beginTime, timeout), RT_ERROR_STREAM_SYNC_TIMEOUT, SetNeedSyncFlag(true),
        "Stream synchronize timeout, device_id=%u, stream_id=%d, timeout=%dms.", device_->Id_(), streamId_, timeout);

    error = Runtime::Instance()->ApiImpl_()->LaunchHostFunc(this, syncCallback, args, false);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Launch sync callback failed, device_id=%u, stream_id=%d, retCode=%#x.",
        device_->Id_(), streamId_, error);
    argsGuard.ReleaseGuard();

    const int32_t lockRet = pthread_mutex_lock(&args->mutex);
    COND_PROC_RETURN_ERROR(
        lockRet != 0, RT_ERROR_OS_HANDLE, device_->AppendSyncArgs(syncArgs),
        "Lock sync callback mutex failed, device_id=%u, stream_id=%d, ret=%d.", device_->Id_(), streamId_, lockRet);

    while (args->currentCnt < STREAM_SYNC_EXPECTED_COUNT) {
        error = CheckSyncStatus();
        COND_PROC((error != RT_ERROR_NONE), break);

        // Sample the deadline before calculating the remaining total timeout.
        timespec deadline{};
        if (unlikely(clock_gettime(CLOCK_MONOTONIC, &deadline) != 0)) {
            RT_LOG(
                RT_LOG_ERROR, "Get sync wait clock failed, device_id=%u, stream_id=%d, errno=%d.", device_->Id_(),
                streamId_, errno);
            error = RT_ERROR_OS_HANDLE;
            break;
        }

        int32_t remainTime = timeout;
        if (IsProcessTimeout(beginTime, timeout, &remainTime)) {
            SetNeedSyncFlag(true);
            error = RT_ERROR_STREAM_SYNC_TIMEOUT;
            RT_LOG(
                RT_LOG_ERROR, "Stream synchronize timeout, device_id=%u, stream_id=%d, timeout=%dms.", device_->Id_(),
                streamId_, timeout);
            break;
        }

        const int32_t waitTime =
            (remainTime > 0) ? std::min(remainTime, STREAM_SYNC_WAIT_INTERVAL_MS) : STREAM_SYNC_WAIT_INTERVAL_MS;
        const uint64_t deadlineNs =
            static_cast<uint64_t>(deadline.tv_nsec) + static_cast<uint64_t>(waitTime) * RT_MS_TO_NS;
        deadline.tv_sec += static_cast<decltype(deadline.tv_sec)>(deadlineNs / NANOSECONDS_PER_SECOND);
        deadline.tv_nsec = static_cast<decltype(deadline.tv_nsec)>(deadlineNs % NANOSECONDS_PER_SECOND);

        const int32_t waitRet = pthread_cond_timedwait(&args->cond, &args->mutex, &deadline);
        if (unlikely((waitRet != 0) && (waitRet != ETIMEDOUT))) {
            RT_LOG(
                RT_LOG_ERROR, "Wait for sync condition failed, device_id=%u, stream_id=%d, ret=%d.", device_->Id_(),
                streamId_, waitRet);
            error = RT_ERROR_OS_HANDLE;
            break;
        }
    }

    if (args->currentCnt >= STREAM_SYNC_EXPECTED_COUNT) {
        error = RT_ERROR_NONE;
    }
    (void)pthread_mutex_unlock(&args->mutex);

    if (error == RT_ERROR_NONE) {
        DestroySyncFuncArgs(args);
    } else {
        COND_LOG_ERROR(
            error != RT_ERROR_STREAM_SYNC_TIMEOUT,
            "Wait for sync callback failed, device_id=%u, stream_id=%d, retCode=%#x.", device_->Id_(), streamId_,
            error);
        device_->AppendSyncArgs(syncArgs);
    }

    return error;
}

void Device::AppendSyncArgs(std::list<SyncFuncArgs*>& args)
{
    const std::lock_guard<std::mutex> lock(syncArgsMutex_);
    syncArgs_.splice(syncArgs_.end(), args);
}

void Device::DestroySyncArgs(const bool force)
{
    std::list<SyncFuncArgs*> args;
    {
        const std::lock_guard<std::mutex> lock(syncArgsMutex_);
        args.splice(args.end(), syncArgs_);
    }
    for (auto it = args.begin(); it != args.end();) {
        SyncFuncArgs* const item = *it;
        if (!force) {
            if (pthread_mutex_lock(&item->mutex) != 0) {
                ++it;
                continue;
            }
            const bool completed = item->currentCnt != 0U;
            (void)pthread_mutex_unlock(&item->mutex);
            if (!completed) {
                ++it;
                continue;
            }
        }
        DestroySyncFuncArgs(item);
        it = args.erase(it);
    }
    // An aborted task can still have an unread callback report; retain its arguments.
    AppendSyncArgs(args);
}

} // namespace runtime
} // namespace cce
