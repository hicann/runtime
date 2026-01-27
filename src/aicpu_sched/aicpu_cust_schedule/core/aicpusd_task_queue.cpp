/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sstream>
#include "aicpusd_status.h"
#include "aicpusd_task_queue.h"
namespace {
// list queue max size 1024
constexpr uint32_t MAX_TASK_QUEUE_SIZE = 1024U;
}

namespace AicpuSchedule {
bool TaskMap::BatchAddTask(const AICPUSharderTaskInfo &taskInfo, const std::queue<aicpu::Closure> &queue)
{
    const std::lock_guard<std::mutex> lk(mapMutex_);
    const auto &iter = taskMap_.find(taskInfo);
    if (iter == taskMap_.end()) {
        (void)taskMap_.emplace(taskInfo, queue);
        return true;
    }
    
    if (!iter->second.empty()) {
        aicpusd_err("Try to add new task queue, but last queue is not been consumed. parallelId=%u, "
                    "size=%lu, shardNum=%ld", taskInfo.parallelId, iter->second.size(), taskInfo.shardNum);
        return false;
    }

    iter->second = queue;

    return true;
}

bool TaskMap::PopTask(const AICPUSharderTaskInfo &taskInfo, aicpu::Closure &closure)
{
    const std::lock_guard<std::mutex> lk(mapMutex_);
    const auto &iter = taskMap_.find(taskInfo);
    if (iter == taskMap_.end()) {
        aicpusd_run_warn("Get task from map failed. parallelId=%u", taskInfo.parallelId);
        return false;
    }

    auto &taskQueue = iter->second;
    if (taskQueue.empty()) {
        aicpusd_run_warn("Pop task queue from empty.");
        return false;
    }

    closure = taskQueue.front();
    taskQueue.pop();

    if (taskQueue.empty()) {
        (void)taskMap_.erase(taskInfo);
    }

    return true;
}

void TaskMap::Clear()
{
    const std::lock_guard<std::mutex> lk(mapMutex_);
    for (auto iter = taskMap_.begin(); iter != taskMap_.end(); ++iter) {
        auto &taskQueue = iter->second;
        while (!taskQueue.empty()) {
            taskQueue.pop();
        }
    }
    taskMap_.clear();
}

std::string TaskMap::DebugString()
{
    const std::lock_guard<std::mutex> lk(mapMutex_);
    std::ostringstream oss;
    oss << "Split kernel TaskMapSize=" << taskMap_.size() << ". ";
    uint32_t i = 0U;
    for (const auto &iter : taskMap_) {
        oss << "task=" << i++ << ", parallelId=" << iter.first.parallelId
            << ", size=" << iter.second.size()
            << ", shardNum=" << iter.first.shardNum;
    }
    return oss.str();
}

bool TaskQueue::Enqueue(const aicpu::Closure &closure)
{
    const std::lock_guard<std::mutex> queLock(mtxQue_);
    if (taskQueue_.size() >= MAX_TASK_QUEUE_SIZE) {
        aicpusd_err("Queue is too large");
        return false;
    }
    taskQueue_.push(closure);
    return true;
}

bool TaskQueue::Dequeue(aicpu::Closure &closure)
{
    const std::lock_guard<std::mutex> queLock(mtxQue_);
    if (taskQueue_.empty()) {
        aicpusd_err("Dequeue from empty");
        return false;
    }
    closure = taskQueue_.front();
    taskQueue_.pop();
    return true;
}

void TaskQueue::Clear()
{
    const std::lock_guard<std::mutex> queLock(mtxQue_);
    while (!taskQueue_.empty()) {
        taskQueue_.pop();
    }
}

std::string TaskQueue::DebugString()
{
    const std::lock_guard<std::mutex> queLock(mtxQue_);
    std::ostringstream oss;
    oss << "queueSize=" << taskQueue_.size();
    return oss.str();
}
}
