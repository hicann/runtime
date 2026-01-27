/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "scheduler.hpp"

namespace cce {
namespace runtime {
void Scheduler::TaskCompleted(TaskInfo * const tsk) const
{
    UNUSED(tsk);
    // default, we do nothing for task complete
}

rtError_t FifoScheduler::PushTask(TaskInfo * const tsk)
{
    const std::unique_lock<std::mutex> queueLock(taskQueMutex_);
    taskQueue_.push(tsk);

    emptyCond_.notify_one();

    return RT_ERROR_NONE;
}

TIMESTAMP_EXTERN(PopTask);
TaskInfo *FifoScheduler::PopTask()
{
    std::unique_lock<std::mutex> queueLock(taskQueMutex_);

    // wait for new task come
    while (taskQueue_.empty()) {
        emptyCond_.wait(queueLock);
    }

    TIMESTAMP_BEGIN(PopTask);
    TaskInfo * const frontTask = taskQueue_.front();
    taskQueue_.pop();
    TIMESTAMP_END(PopTask);
    return frontTask;
}
}
}
