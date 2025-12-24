/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <chrono>
#include "thread_manager.h"
#include "log/adx_log.h"

namespace Adx{
constexpr uint32_t WAIT_THREAD_TIMEOUT = 60;
ThreadManager::~ThreadManager() {
    WaitAll();
}

void ThreadManager::TaskAdd(int32_t tid) {
    std::lock_guard<std::mutex> lock(mtx_);
    threads_.insert(tid);
    IDE_LOGD("Task: %d Added! %zu tasks are running.", tid, threads_.size());
    cv_.notify_all();
}

void ThreadManager::TaskDone(int32_t tid) {
    std::lock_guard<std::mutex> lock(mtx_);
    threads_.erase(tid);
    IDE_LOGD( "Task: %d Done! %zu tasks remain.", tid, threads_.size());
    cv_.notify_all();
}

void ThreadManager::WaitAll() {
    std::unique_lock<std::mutex> lock(mtx_);
    cv_.wait_for(lock, std::chrono::seconds(WAIT_THREAD_TIMEOUT * threads_.size()), [this]() { return threads_.empty(); });
}
}
