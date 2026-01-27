/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DATAPREPROCESS_TASK_QUEUE_H
#define DATAPREPROCESS_TASK_QUEUE_H

#include <functional>
#include <string>
#include <list>
#include <cstdint>
#include <atomic>
#include <mutex>
#include <pthread.h>
#include <queue>
#include "driver/ascend_hal_define.h"

namespace DataPreprocess {
using Closure = std::function<void ()>;

enum TaskQueuePriority {
    TASK_QUEUE_LOW_PRIORITY = 0,
    TASK_QUEUE_HIGH_PRIORITY,
    TASK_QUEUE_MAX_PRIORITY,
};

enum TaskEventID {
    TASK_QUEUE_LOW_EVENT_ID = 1,
    TASK_QUEUE_HIGH_EVENT_ID
};

struct TaskInfo {
    std::string name;
    Closure taskFunc;
};

class TaskQueueMgr {
public:
    /*****************************************************************************
    Description  : get the instance of TaskQueueMgr
    Input        : NA
    Output       : NA
    Return Value : TaskQueueMgr instance
    *****************************************************************************/
    static TaskQueueMgr &GetInstance();

    /*****************************************************************************
    Description  : init the task queue fd
    Input        : maxEventfd
                 : allEventfdSets
    Output       : maxEventfd
                 : allEventfdSets
    Return Value : true or false
    *****************************************************************************/
    bool InitTaskQueueFd(int32_t &maxEventfd, fd_set &allEventfdSets);

    /*****************************************************************************
     Description  : close the task queue fd
     Input        : NA
     Output       : NA
     Return Value : NA
    *****************************************************************************/
    void CloseTaskQueueFd();

    /*****************************************************************************
    Description  : enqueue the closure func to process on cur thread after cur task end
    Input        : task function
    Output       : NA
    *****************************************************************************/
    void LocalTaskEnqueue(const Closure c);

    /*****************************************************************************
    Description  : enqueue the closure func by priority
    Input        : task priority
                 : task function
                 : task name
    Output       : NA
    *****************************************************************************/
    void TaskEnqueue(const TaskQueuePriority priority,
                     const Closure taskFunc,
                     const std::string &taskName);

    /*****************************************************************************
    Description  : enqueue the closure func by different priority
    Input        : priority: task priority
                 : taskFunc: the closure need to enqueue
                 : taskName: task name that need to be enqueued
    Output       : NA
    Return Value : NA
    *****************************************************************************/
    void TaskOnlyEnqueue(const TaskQueuePriority priority,
                         const Closure taskFunc,
                         const std::string &taskName);

    /*****************************************************************************
    Description  : execute the closure function directly
    Input        : task function
                 : task name
    Output       : NA
    Return Value : NA
    *****************************************************************************/
    void TaskDirectExecute(const Closure taskFunc, const std::string &taskName) const;

    /*****************************************************************************
    Description  : preprocess event
    Input        : eventfdSets
    Output       : NA
    Return Value : NA
    *****************************************************************************/
    void OnPreprocessEvent(const fd_set &eventfdSets);

    /*****************************************************************************
    Description  : preprocess event
    Input        : eventId
    Output       : NA
    Return Value : NA
    *****************************************************************************/
    void OnPreprocessEvent(uint32_t eventId);

    /*****************************************************************************
    Description  : clear all task queues
    Input        : NA
    Output       : NA
    Return Value : NA
    *****************************************************************************/
    void ClearTaskQueues();

private:
    /*****************************************************************************
    Description  : process event by priority
    Input        : priority
    Output       : NA
    Return Value : NA
    *****************************************************************************/
    void ProcPreprocessEvent(const TaskQueuePriority priority);

    static inline void DoLocalSelfTask()
    {
        while (!closures_.empty()) {
            auto it = closures_.front();
            it();
            closures_.pop();
        }
    }

private:
    TaskQueueMgr();
    ~TaskQueueMgr();
    // not allow copy constructor and assignment operators
    TaskQueueMgr(const TaskQueueMgr &) = delete;
    TaskQueueMgr &operator=(const TaskQueueMgr &) = delete;
#ifndef TASK_SCHEDULE_BY_COMPUTE_PROCESS
    void SubmitEventToTs(const TaskQueuePriority priority);
#endif
    void WriteEvent(const TaskQueuePriority priority);

private:
    std::mutex taskQueueMutex_;
    // different priority task queues
    std::queue<TaskInfo> taskQueues_[TASK_QUEUE_MAX_PRIORITY];
    thread_local static std::queue<Closure> closures_;
    // different priority task queues event fd
    int32_t preprocessEventfds_[TASK_QUEUE_MAX_PRIORITY];
    uint64_t sendEventTimes_[TASK_QUEUE_MAX_PRIORITY];
    std::atomic<uint64_t> sendEventFailedTimes_;
    uint64_t recvEventTimes_[TASK_QUEUE_MAX_PRIORITY];
    std::function<void()> cancelLastword_ = nullptr;
};
} // namespace DataPreprocess

extern "C" __attribute__((weak)) __attribute__((visibility("default"))) void LocalTaskEnqueue(
    const DataPreprocess::Closure c);
#endif // DATAPREPROCESS_TASK_QUEUE_H
