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

#include <aicpusd_common.h>

namespace AicpuSchedule {
class ThreadPool {
public:
    static ThreadPool &Instance();

    int32_t CreateWorker();

    void PostSem(const uint32_t threadIndex);

    ThreadPool(const ThreadPool&) = delete;
    ThreadPool &operator=(const ThreadPool&) = delete;
    ThreadPool(const ThreadPool&&) = delete;
    ThreadPool &operator=(const ThreadPool&&) = delete;

private:
    ThreadPool();
    ~ThreadPool();
    int32_t CreateOneWorker(const uint32_t threadIndex);
    static void Work(const uint32_t threadIndex);
    int32_t SetAffinity(const size_t threadIndex, const uint32_t deviceId);
    int32_t WriteTidForAffinity(const size_t threadIndex);
    int32_t AddPidToTask(const size_t threadIndex);
    int32_t SecureCompute(const uint32_t threadIndex);
    int32_t SetAffinityByPm(const size_t threadIndex);
    int32_t SetAffinityBySelf(const size_t threadIndex);

    std::vector<std::thread> workers_;
    std::vector<sem_t> sems_;
    uint32_t semInitedNum_;
    std::vector<ThreadStatus> threadStatus_;
};
}  // namespace AicpuSchedule
#endif  // AICPUSD_WORKER_H