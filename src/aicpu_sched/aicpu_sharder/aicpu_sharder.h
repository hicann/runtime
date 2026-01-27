/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_SHARDER_H
#define AICPU_SHARDER_H

#include <mutex>
#include <atomic>
#include <functional>
#include <vector>
#include <queue>

namespace aicpu {
using Closure = std::function<void()>;
using SharderWork = std::function<void(int64_t, int64_t)>;
using RandomKernelScheduler = std::function<uint32_t(const aicpu::Closure &task)>;
using SplitKernelScheduler = std::function<uint32_t(const uint32_t parallelId, const int64_t shardNum,
                                                    const std::queue<Closure> &queue)>;
using SplitKernelGetProcesser =  std::function<bool()>;

class SharderNonBlock {
public:
    /**
     * Get the unique object of this class
     */
    static SharderNonBlock &GetInstance();

    /**
     * Register schedule callback function, doTask function and cpu core number
     * called by compute process
     * @param cpuCoreNum aicpu core number
     * @param randomKernelScheduler random kernel event submit and task enqueue
     * @param splitKernelScheduler random kernel event submit and task add
     * @param splitKernelScheduler get and process split kernel for main thread
     */
    void Register(const uint32_t cpuCoreNum, const RandomKernelScheduler &randomKernelScheduler,
                  const SplitKernelScheduler &splitKernelScheduler,
                  const SplitKernelGetProcesser &splitKernelGetProcesser);

    /**
     * Shards the "total" unit of work refer "perUintSize"
     * @param total Total unit of work
     * @param perUnitSize Minimum shard unit
     * @param work should be a callable taking (int64, int64) arguments.
                   work(start, limit) computes the work units from [start, limit),
                   i.e., [start, limit) is a shard.
     */
    void ParallelFor(const int64_t total, const int64_t perUnitSize, const SharderWork &work);

    /**
     * Shards the unit of work refer for hash
     * @param total, Total unit of work
     * @param cpuNums Number of cpu cores
     * @param work should be a callable taking (int64, int64) arguments.
                   work(cur, cpuNums) computes the work units with input hash with (cpuNums-1) equals cur,
                   i.e. specially used by parallel unique op
     */
    void ParallelForHash(const int64_t total, const int64_t cpuNums, const SharderWork &work);

    /**
     * Schedule a task use schedule function registered by compute process,
     * note that the task will actually executed asynchronously
     * @param closure Closure function with nothrow
     */
    void Schedule(const Closure &aicpuClosure);

    /**
     * Get CPU number
     * @param None
     * @return CPU number
     */
    uint32_t GetCPUNum();

private:
    SharderNonBlock();
    ~SharderNonBlock() = default;

    SharderNonBlock(const SharderNonBlock &) = delete;
    SharderNonBlock &operator = (const SharderNonBlock &) = delete;
    SharderNonBlock(SharderNonBlock &&) = delete;
    SharderNonBlock &operator = (SharderNonBlock &&) = delete;

    void DoTaskItself(const uint32_t parallelId, std::atomic<int64_t> &cpuNumCounter,
                      const int64_t shardNum) const;

    /**
     * Calculate how many times, which ceiled, "x" is "base".
     * i.e., x is 1, base is 2, this function will return 1
     * @param x An integral
     * @param base An integral as base when cal multiple
     * @return ceiled multiple
     */
    inline int64_t CeilMultiple(const int64_t x, const int64_t base) const;

    /**
     * Shards the "total" unit of work refer "perUintSize"
     * @param total Total unit of work
     * @param shardNum parralle number
     * @param blockSize Minimum shard unit
     * @param work should be a callable taking (int64, int64) arguments.
                   work(start, limit) computes the work units from [start, limit),
                   i.e., [start, limit) is a shard.
     */
    void ExecuteParallelFor(const int64_t total, const int64_t shardNum,
                            const int64_t blockSize, const SharderWork &work, const uint32_t parallelId);

    void ExecuteParallelForHash(const int64_t total, const int64_t cpuNums, const SharderWork &work,
                                const uint32_t parallelId);

private:
    uint32_t cpuCoreNum_; // aicpu core number
    RandomKernelScheduler randomKernelScheduler_;
    SplitKernelScheduler splitKernelScheduler_;
    SplitKernelGetProcesser splitKernelGetProcesser_;
    std::atomic<uint32_t> parallelId_; // the id for parallel run kernel
    std::mutex parallelIdMutex_;
};                        // SharderNonBlock
} // namespace aicpu

extern "C" {
/**
 * Shards the "total" unit of work refer "perUintSize"
 * @param total Total unit of work
 * @param perUnitSize Minimum shard unit
 * @param work should be a callable taking (int64, int64) arguments.
                 work(start, limit) computes the work units from [start, limit),
                i.e., [start, limit) is a shard.
 */
__attribute__((visibility("default"))) void ParallelFor(int64_t total, int64_t perUnitSize,
    const aicpu::SharderWork &work);

/**
 * Get CPU number
 * @param None
 * @return CPU number
 */
__attribute__((visibility("default"))) uint32_t GetCPUNum();
}

#endif // AICPU_SHARDER_H_
