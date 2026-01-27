/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_SCHEDULER_HPP__
#define __CCE_RUNTIME_SCHEDULER_HPP__

#include <queue>
#include <mutex>
#include <condition_variable>
#include "base.hpp"
#include "osal.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {
class Task;

// Schedule tasks submitd from user thread to driver queues.
class Scheduler : public NoCopy {
public:
    Scheduler() = default;
    ~Scheduler() override = default;

    // Called in user thread for submiting task.
    virtual rtError_t PushTask(TaskInfo *tsk) = 0;

    // Called in sending thread for retrieving submited task.
    virtual TaskInfo *PopTask() = 0;

    // Called in receiving thread when task complete.
    virtual void TaskCompleted(TaskInfo* const tsk) const;
};

// Schedule tasks in first in first out mode, without qos consideration.
class FifoScheduler : public Scheduler {
public:
    FifoScheduler() = default;
    ~FifoScheduler() override = default;

    rtError_t PushTask(TaskInfo * const tsk) override;
    TaskInfo *PopTask() override;
private:
    std::mutex taskQueMutex_;
    std::condition_variable emptyCond_;
    std::queue<TaskInfo *> taskQueue_;
};
}
}

#endif  // __CCE_RUNTIME_SCHEDULER_HPP__
