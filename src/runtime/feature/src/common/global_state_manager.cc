/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "global_state_manager.hpp"
#include <chrono>
#include <thread>
#include "base.hpp"

namespace cce {
namespace runtime {
GlobalStateManager &GlobalStateManager::GetInstance()
{
    static GlobalStateManager instance;
    return instance;
}

std::mutex &GlobalStateManager::GetStateMtx()
{
    return stateMtx_;
}

const char *GlobalStateManager::StateToString(const rtProcessState state)
{
    const char *result = "UNKNOWN";
    switch (state) {
        case RT_PROCESS_STATE_RUNNING:
            result = "RUNNING";
            break;
        case RT_PROCESS_STATE_LOCKED:
            result = "LOCKED";
            break;
        case RT_PROCESS_STATE_BACKED_UP:
            result = "BACKED_UP";
            break;
        default:
            break;
    }
    return result;
}

rtError_t GlobalStateManager::Locked()
{
    {
        std::unique_lock<std::mutex> lock(stateMtx_);
        if (currentState_.load() != RT_PROCESS_STATE_RUNNING) {
            RT_LOG(RT_LOG_ERROR,
                "current state is not the running state, current state is %s",
                StateToString(currentState_.load()));
            return RT_ERROR_SNAPSHOT_LOCK_FAILED;
        }

        currentState_.store(RT_PROCESS_STATE_LOCKED);
        lockedBackgroundThreadCount_.store(0);
    }
    const auto ret = WaitForAllBackgroundThreadLocked();
    if (ret != RT_ERROR_NONE) {
        std::unique_lock<std::mutex> lock(stateMtx_);
        currentState_.store(RT_PROCESS_STATE_RUNNING);
        // 解除阻塞，通知所有等待的线程
        globalLockCv_.notify_all();
        return ret;
    }
    RT_LOG(RT_LOG_EVENT, "locked success.");
    return RT_ERROR_NONE;
}

rtError_t GlobalStateManager::Unlocked()
{
    {
        std::unique_lock<std::mutex> lock(stateMtx_);
        if ((currentState_.load() != RT_PROCESS_STATE_LOCKED) && (currentState_.load() != RT_PROCESS_STATE_BACKED_UP)) {
            RT_LOG(RT_LOG_ERROR,
                "current state is not the RT_PROCESS_STATE_LOCKED or RT_PROCESS_STATE_BACKED_UP, current state is %s",
                StateToString(currentState_.load()));
            return RT_ERROR_SNAPSHOT_UNLOCK_FAILED;
        }
        currentState_.store(RT_PROCESS_STATE_RUNNING);
        // 解除阻塞，通知所有等待的线程
        globalLockCv_.notify_all();
    }
    const auto ret = WaitForAllBackgroundThreadUnlocked();
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);
    RT_LOG(RT_LOG_EVENT, "unlocked success.");
    return RT_ERROR_NONE;
}

void GlobalStateManager::ForceUnlocked()
{
    std::unique_lock<std::mutex> lock(stateMtx_);
    if (currentState_.load() == RT_PROCESS_STATE_RUNNING) {
        RT_LOG(RT_LOG_INFO, "already in RUNNING state, no action needed");
        return;
    }

    RT_LOG(RT_LOG_EVENT, "forcing state transition from %s to RUNNING", StateToString(currentState_.load()));
    currentState_.store(RT_PROCESS_STATE_RUNNING);
    lockedBackgroundThreadCount_.store(0);
    globalLockCv_.notify_all();
    return;
}

// 检查状态，如果阻塞则等待
void GlobalStateManager::WaitIfLocked(const char *name)
{
    if (likely(currentState_.load() == RT_PROCESS_STATE_RUNNING)) {
        return;
    }
    std::unique_lock<std::mutex> lock(stateMtx_);
    if (currentState_.load() != RT_PROCESS_STATE_RUNNING) {
        RT_LOG(RT_LOG_INFO, "%s wait until unlocked.", name);
        globalLockCv_.wait(lock, [this]() { return (currentState_.load() == RT_PROCESS_STATE_RUNNING); });
        RT_LOG(RT_LOG_INFO, "%s wait finish.", name);
    }
}

void GlobalStateManager::IncBackgroundThreadCount(const char *name)
{
    (void)backgroundThreadCount_.fetch_add(1);
    RT_LOG(RT_LOG_INFO, "%s thread needs to be locked. Total:%u.", name, backgroundThreadCount_.load());
}

void GlobalStateManager::DecBackgroundThreadCount(const char *name)
{
    (void)backgroundThreadCount_.fetch_sub(1);
    RT_LOG(RT_LOG_INFO, "%s thread does not need to be locked. Total:%u", name, backgroundThreadCount_.load());
}

void GlobalStateManager::BackgroundThreadWaitIfLocked(const char *name)
{
    if (likely(currentState_.load() == RT_PROCESS_STATE_RUNNING)) {
        return;
    }
    std::unique_lock<std::mutex> lock(stateMtx_);
    if (currentState_.load() != RT_PROCESS_STATE_RUNNING) {
        RT_LOG(RT_LOG_INFO, "%s background thread wait until unlocked.", name);
        (void)lockedBackgroundThreadCount_.fetch_add(1);
        globalLockCv_.wait(lock, 
            [this]() {
                return (currentState_.load() == RT_PROCESS_STATE_RUNNING);
            }
        );
        (void)lockedBackgroundThreadCount_.fetch_sub(1);
        RT_LOG(RT_LOG_INFO, "%s background thread wait finish.", name);
    }
}

rtError_t GlobalStateManager::WaitForAllBackgroundThreadLocked() const
{
    const uint32_t totalCount = backgroundThreadCount_.load();
    if (totalCount == 0U) {
        RT_LOG(RT_LOG_INFO, "No background threads to wait for.");
        return RT_ERROR_NONE;
    }

    constexpr auto timeout = std::chrono::seconds(60); // 60s
    constexpr auto checkInterval = std::chrono::milliseconds(20); // 20ms 检查一次
    auto startTime = std::chrono::steady_clock::now();

    while (lockedBackgroundThreadCount_.load() < totalCount) {
        if (currentState_.load() != RT_PROCESS_STATE_LOCKED) {
            RT_LOG(RT_LOG_ERROR,
                "State changed during background thread waiting, now state is %s",
                StateToString(currentState_.load()));
            return RT_ERROR_SNAPSHOT_LOCK_FAILED;
        }

        if (std::chrono::steady_clock::now() - startTime >= timeout) {
            RT_LOG(RT_LOG_ERROR,
                "Timeout: only %u/%u background threads locked",
                lockedBackgroundThreadCount_.load(),
                totalCount);
            return RT_ERROR_SNAPSHOT_LOCK_TIMEOUT;
        }

        std::this_thread::sleep_for(checkInterval);
    }
    RT_LOG(RT_LOG_INFO,
        "All background thread locked, background thread num=%u, locked background thread num=%u.",
        totalCount,
        lockedBackgroundThreadCount_.load());
    return RT_ERROR_NONE;
}

rtError_t GlobalStateManager::WaitForAllBackgroundThreadUnlocked() const
{
    constexpr auto timeout = std::chrono::seconds(60); // 60s
    constexpr auto checkInterval = std::chrono::milliseconds(20); // 20ms 检查一次
    auto startTime = std::chrono::steady_clock::now();

    while (lockedBackgroundThreadCount_.load() != 0U) {
        if (currentState_.load() != RT_PROCESS_STATE_RUNNING) {
            RT_LOG(RT_LOG_ERROR,
                "State changed during background thread unlocked, now state is %s",
                StateToString(currentState_.load()));
            return RT_ERROR_SNAPSHOT_UNLOCK_FAILED;
        }

        if (std::chrono::steady_clock::now() - startTime >= timeout) {
            RT_LOG(RT_LOG_ERROR, "There are still %u threads in the locked state.", lockedBackgroundThreadCount_.load());
            return RT_ERROR_SNAPSHOT_UNLOCK_FAILED;
        }

        std::this_thread::sleep_for(checkInterval);
    }
    RT_LOG(RT_LOG_INFO, "All background thread unlocked success.");
    return RT_ERROR_NONE;
}

void GlobalStateManager::SetCurrentState(const rtProcessState state)
{
    currentState_.store(state);
}

rtProcessState GlobalStateManager::GetCurrentState() const
{
    return currentState_.load();
}
}  // namespace runtime
}  // namespace cce