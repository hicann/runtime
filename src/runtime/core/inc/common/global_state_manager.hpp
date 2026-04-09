/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_GLOBAL_STATE_MANAGER_HPP
#define RUNTIME_GLOBAL_STATE_MANAGER_HPP

#include <condition_variable>
#include <mutex>
#include <atomic>
#include "base.h"
#include "rts_snapshot.h"

// For any api that involves modifications to device resources, this should be added
#define GLOBAL_STATE_WAIT_IF_LOCKED() \
    GlobalStateManager::GetInstance().WaitIfLocked(__func__)

namespace cce {
namespace runtime {
class GlobalStateManager {
public:
    static GlobalStateManager &GetInstance();
    std::mutex &GetStateMtx();
    rtError_t Locked();
    rtError_t Unlocked();
    // Called when the process exits, unblocks unconditionally, and does not report errors.
    void ForceUnlocked();
    // Check the status; if blocked, wait.
    void WaitIfLocked(const char *name);
    rtProcessState GetCurrentState() const;
    void SetCurrentState(const rtProcessState state);
    void IncBackgroundThreadCount(const char *name);
    void DecBackgroundThreadCount(const char *name);
    // Background thread checks the status and waits if it is blocked.
    void BackgroundThreadWaitIfLocked(const char *name);
    static const char *StateToString(const rtProcessState state);

private:
    GlobalStateManager(const GlobalStateManager &) = delete;
    GlobalStateManager &operator=(const GlobalStateManager &) = delete;
    GlobalStateManager() = default;
    ~GlobalStateManager() = default;
    rtError_t WaitForAllBackgroundThreadLocked() const;
    rtError_t WaitForAllBackgroundThreadUnlocked() const;

    std::mutex stateMtx_;
    std::condition_variable globalLockCv_;
    std::atomic<rtProcessState> currentState_{RT_PROCESS_STATE_RUNNING};

    // 监控线程的管理
    std::atomic<uint32_t> backgroundThreadCount_{0};        // 需要阻塞的背景线程个数
    std::atomic<uint32_t> lockedBackgroundThreadCount_{0};  // 已经阻塞的背景线程个数
};
}  // namespace runtime
}  // namespace cce

#endif