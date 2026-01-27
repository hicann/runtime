/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPUSD_WORKER_H
#define AICPUSD_WORKER_H

#include <cstdint>
#include <vector>
#include <semaphore.h>
#include <string>
#include <thread>
#include <atomic>

#include "aicpusd_info.h"
#include "aicpusd_common.h"
#include "aicpu_context.h"

namespace AicpuSchedule {
constexpr int32_t EXECUTE_CMD_ERROR = 127; // 与system实现保持一致
class ThreadPool {
public:
    static ThreadPool &Instance();

    int32_t CreateWorker(const AicpuSchedMode schedMode);

    void WaitForStop();

    void PostSem(const size_t threadIndex);

    void SetThreadSchedModeByTsd();
    ThreadPool(const ThreadPool&) = delete;
    ThreadPool &operator=(const ThreadPool&) = delete;
    ThreadPool(const ThreadPool&&) = delete;
    ThreadPool &operator=(const ThreadPool&&) = delete;
private:
    ThreadPool();
    ~ThreadPool();
    int32_t CreateOneWorker(const size_t threadIndex, const uint32_t deviceId);
    static void Work(const size_t threadIndex, const uint32_t deviceId, const AicpuSchedMode schedMode);
    int32_t SetAffinity(const size_t threadIndex, const uint32_t deviceId);
    int32_t WriteTidForAffinity(const size_t threadIndex);
    int32_t AddPidToTask(const size_t threadIndex);
    int32_t SetAffinityByPm(const size_t threadIndex, const uint32_t deviceId);
    int32_t SetAffinityBySelf(const size_t threadIndex, const uint32_t deviceId);
    void SetThreadStatus(const size_t threadIndex, const ThreadStatus threadStat);
    void SetThreadIdRelation(const size_t threadIndex, const pid_t threadId);
    static int32_t InitInterruptWorker(const uint32_t deviceId, const size_t threadIndex);
    static int32_t InitMessageQueueWorker(const size_t threadIndex);

    void Clear();

    std::vector<std::thread> workers_;
    std::vector<sem_t> sems_;
    size_t semInitedNum_;
    std::vector<ThreadStatus> threadStatusList_;
    std::vector<pid_t> threadIdLists_;
    bool hasAicpu_ = true;
    AicpuSchedMode schedMode_ = SCHED_MODE_INTERRUPT;
};
}  // namespace AicpuSchedule
#endif  // AICPUSD_WORKER_H
