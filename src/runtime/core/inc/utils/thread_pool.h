/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_THREAD_POOL_H
#define CCE_RUNTIME_THREAD_POOL_H

#include <condition_variable>
#include <cstddef>
#include <cstdint>
#include <deque>
#include <future>
#include <functional>
#include <memory>
#include <mutex>
#include <vector>
#include "base.hpp"
#include "osal.hpp"

namespace cce {
namespace runtime {

// 非核心线程空闲超时（秒）：超时仍无任务即退出，回落核心线程数
constexpr uint32_t THREAD_POOL_DEFAULT_IDLE_TIMEOUT_SEC = 60U;
// 线程名长度上限（含结尾 '\0'，与 mmpa 线程名限制一致）
constexpr size_t THREAD_POOL_NAME_MAX_LEN = 16U;

// 通用线程池：共享任务队列，线程数可固定或弹性（1→N，非核心线程空闲超时退出）
class ThreadPool : public NoCopy {
public:
    ThreadPool();
    ~ThreadPool() override;

    // Init and external Shutdown/destruction must be serialized by the owner.
    rtError_t Init(const char_t* name, uint32_t threadCount);
    rtError_t Init(
        const char_t* name, uint32_t minThreads, uint32_t maxThreads,
        uint32_t idleTimeoutSec = THREAD_POOL_DEFAULT_IDLE_TIMEOUT_SEC);
    std::future<void> Submit(std::function<void()>&& fn);
    // Cancels queued tasks. A worker caller requests stop without waiting for peers.
    void Shutdown();
    bool IsRunning() const;
    uint32_t ThreadCount() const;
    size_t PendingCount() const;

private:
    struct Worker;
    void WorkerLoop(Worker& worker);
    rtError_t AddThreadLocked();
    static thread_local Worker* currentWorker_;

    mutable std::mutex mutex_;
    std::condition_variable cv_;
    std::deque<std::function<void()>> tasks_;
    std::vector<std::unique_ptr<Worker>> workers_;
    char_t name_[THREAD_POOL_NAME_MAX_LEN] = {0};                   // 线程名（Init 时拷贝）
    uint32_t maxThreads_{0U};                                       // 线程数上限
    uint32_t coreThreads_{0U};                                      // 核心线程数（= Init 的 minThreads）
    uint32_t aliveThreads_{0U};                                     // 仍在 WorkerLoop 中的线程数
    uint32_t idleTimeoutSec_{THREAD_POOL_DEFAULT_IDLE_TIMEOUT_SEC}; // 非核心线程空闲退出时长
    uint32_t idleThreads_{0U};                                      // 当前阻塞在 cv_.wait 上的线程数
    bool running_{false};
};

} // namespace runtime
} // namespace cce

#endif
