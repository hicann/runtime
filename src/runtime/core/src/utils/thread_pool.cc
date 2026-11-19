/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "utils/thread_pool.h"

#include <algorithm>
#include <chrono>
#include <cstring>
#include <new>
#include <thread>
#include <utility>
#include "securec.h"

namespace cce {
namespace runtime {
struct ThreadPool::Worker final : ThreadRunnable {
    explicit Worker(ThreadPool& owner) : pool(owner) {}
    ~Worker() override
    {
        if (thread != nullptr) {
            thread->Join();
        }
    }
    void Run(const void* param) override
    {
        (void)param;
        currentWorker_ = this;
        pool.WorkerLoop(*this);
        currentWorker_ = nullptr;
    }

    ThreadPool& pool;
    std::unique_ptr<Thread> thread;
    bool retired{false};       // Protected by pool.mutex_.
    bool exitAfterTask{false}; // Accessed only by this worker.
};

thread_local ThreadPool::Worker* ThreadPool::currentWorker_ = nullptr;

ThreadPool::ThreadPool() = default;

ThreadPool::~ThreadPool()
{
    Shutdown();
    if (!workers_.empty()) {
        std::unique_ptr<Worker> self;
        for (auto& worker : workers_) {
            if (worker.get() == currentWorker_) {
                self = std::move(worker);
            }
        }
        workers_.clear();
        // Self-destruction: keep the active runner alive until its thread returns.
        std::thread([worker = std::move(self)]() mutable { worker.reset(); }).detach();
    }
}

rtError_t ThreadPool::Init(const char_t* name, uint32_t threadCount) { return Init(name, threadCount, threadCount); }

rtError_t ThreadPool::Init(const char_t* name, uint32_t minThreads, uint32_t maxThreads, uint32_t idleTimeoutSec)
{
    if ((name == nullptr) || (minThreads == 0U) || (maxThreads < minThreads) || (idleTimeoutSec == 0U) ||
        ((currentWorker_ != nullptr) && (&currentWorker_->pool == this))) {
        RT_LOG(RT_LOG_ERROR, "Invalid thread pool parameters or Init called from its worker");
        return RT_ERROR_INVALID_VALUE;
    }
    if (strlen(name) >= THREAD_POOL_NAME_MAX_LEN) {
        RT_LOG(RT_LOG_ERROR, "Thread pool name length exceeds %zu", THREAD_POOL_NAME_MAX_LEN - 1U);
        return RT_ERROR_INVALID_VALUE;
    }

    Shutdown();
    rtError_t ret = RT_ERROR_NONE;
    {
        std::lock_guard<std::mutex> lock(mutex_);
        (void)strcpy_s(name_, sizeof(name_), name);
        maxThreads_ = maxThreads;
        coreThreads_ = minThreads;
        idleTimeoutSec_ = idleTimeoutSec;
        running_ = true;
        for (uint32_t i = 0U; (i < minThreads) && (ret == RT_ERROR_NONE); ++i) {
            ret = AddThreadLocked();
        }
    }
    if (ret != RT_ERROR_NONE) {
        Shutdown();
    }
    return ret;
}

rtError_t ThreadPool::AddThreadLocked()
{
    workers_.erase(
        std::remove_if(
            workers_.begin(), workers_.end(), [](const std::unique_ptr<Worker>& worker) { return worker->retired; }),
        workers_.end());
    std::unique_ptr<Worker> worker(new (std::nothrow) Worker(*this));
    if (worker == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Thread pool failed to allocate worker");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    workers_.push_back(std::move(worker));
    Worker& added = *workers_.back();
    added.thread.reset(OsalFactory::CreateThread(name_, &added, nullptr));
    if ((added.thread == nullptr) || (added.thread->Start() != EN_OK)) {
        added.thread.reset();
        workers_.pop_back();
        RT_LOG(RT_LOG_ERROR, "Thread pool failed to create or start thread");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    ++aliveThreads_;
    return RT_ERROR_NONE;
}

std::future<void> ThreadPool::Submit(std::function<void()>&& fn)
{
    auto task = std::make_shared<std::packaged_task<void()>>(std::move(fn));
    std::future<void> future = task->get_future();
    {
        std::lock_guard<std::mutex> lock(mutex_);
        if (!running_) {
            return std::future<void>();
        }
        tasks_.emplace_back([task]() { (*task)(); });
        // Admission and Start share the lock, so no separate spawn reservation is needed.
        if ((tasks_.size() > idleThreads_) && (aliveThreads_ < maxThreads_)) {
            if (AddThreadLocked() != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_WARNING, "Thread pool grow failed, threads=%u, max=%u", aliveThreads_, maxThreads_);
            }
        }
    }
    cv_.notify_one();
    return future;
}

void ThreadPool::Shutdown()
{
    std::vector<std::unique_ptr<Worker>> workers;
    std::deque<std::function<void()>> cancelled;
    {
        std::lock_guard<std::mutex> lock(mutex_);
        running_ = false;
        cancelled.swap(tasks_);
        if ((currentWorker_ != nullptr) && (&currentWorker_->pool == this)) {
            if (!currentWorker_->exitAfterTask) {
                currentWorker_->exitAfterTask = true;
                --aliveThreads_;
            }
        } else {
            workers.swap(workers_);
        }
    }
    cv_.notify_all();
    // Destruct queued closures and Join workers outside the pool lock.
}

bool ThreadPool::IsRunning() const
{
    std::lock_guard<std::mutex> lock(mutex_);
    return running_;
}

uint32_t ThreadPool::ThreadCount() const
{
    std::lock_guard<std::mutex> lock(mutex_);
    return aliveThreads_;
}

size_t ThreadPool::PendingCount() const
{
    std::lock_guard<std::mutex> lock(mutex_);
    return tasks_.size();
}

void ThreadPool::WorkerLoop(Worker& worker)
{
    while (!worker.exitAfterTask) {
        std::function<void()> task;
        {
            std::unique_lock<std::mutex> lock(mutex_);
            ++idleThreads_;
            const bool ready = cv_.wait_for(
                lock, std::chrono::seconds(idleTimeoutSec_), [this]() { return !running_ || !tasks_.empty(); });
            --idleThreads_;
            if (!running_ || (!ready && (aliveThreads_ > coreThreads_))) {
                --aliveThreads_;
                worker.retired = true;
                return;
            }
            if (tasks_.empty()) {
                continue;
            }
            task = std::move(tasks_.front());
            tasks_.pop_front();
        }
        task(); // packaged_task stores user exceptions in the future.
    }
}

} // namespace runtime
} // namespace cce
