/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_TASK_QUEUE_H
#define CORE_AICPUSD_TASK_QUEUE_H

#include <mutex>
#include <unordered_map>
#include <queue>
#include "aicpusd_info.h"
#include "aicpu_sharder.h"

namespace AicpuSchedule {
struct HashKey {
    std::size_t operator() (const AICPUSharderTaskInfo &sharderTaskInfo) const noexcept
    {
        std::size_t h1 = std::hash<uint32_t>()(sharderTaskInfo.parallelId);
        return h1;
    }
};

class TaskMap {
public:
    void Clear();
    std::string DebugString();
    bool BatchAddTask(const AICPUSharderTaskInfo &taskInfo, const std::queue<aicpu::Closure> &queue);
    bool PopTask(const AICPUSharderTaskInfo &taskInfo, aicpu::Closure &closure);

    TaskMap() = default;
    ~TaskMap() = default;

private:
    TaskMap(const TaskMap &) = delete;
    TaskMap &operator=(const TaskMap &) = delete;
    TaskMap(TaskMap &&) = delete;
    TaskMap &operator=(TaskMap &&) = delete;

    std::mutex mapMutex_;
    std::unordered_map<AICPUSharderTaskInfo, std::queue<aicpu::Closure>, HashKey> taskMap_;
};

class TaskQueue {
public:
    void Clear();
    std::string DebugString();
    bool Enqueue(const aicpu::Closure &closure);
    bool Dequeue(aicpu::Closure &closure);

    TaskQueue() = default;
    ~TaskQueue() = default;

private:
    TaskQueue(const TaskQueue &) = delete;
    TaskQueue &operator=(const TaskQueue &) = delete;
    TaskQueue(TaskQueue&&) = delete;
    TaskQueue& operator=(TaskQueue&&) = delete;

    std::mutex mtxQue_;
    std::queue<aicpu::Closure> taskQueue_;
};
}
#endif
