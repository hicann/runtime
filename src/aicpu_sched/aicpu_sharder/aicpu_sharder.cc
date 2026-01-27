/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_sharder.h"

#include <atomic>
#include <semaphore.h>
#include <unistd.h>
#ifndef _AOSCORE_
#include <error.h>
#endif
#include <cstring>
#include <algorithm>
#include <cerrno>

#include "aicpu_sharder_log.h"
#include "aicpu_context.h"

namespace aicpu {
constexpr uint32_t GET_EVENT_LIMITED_NUM = 1000U;

SharderNonBlock::SharderNonBlock() : cpuCoreNum_(0U),
                                     randomKernelScheduler_(nullptr),
                                     splitKernelScheduler_(nullptr),
                                     splitKernelGetProcesser_(nullptr),
                                     parallelId_(0U)
{
}

void SharderNonBlock::Register(const uint32_t cpuCoreNum, const RandomKernelScheduler &randomKernelScheduler,
                               const SplitKernelScheduler &splitKernelScheduler,
                               const SplitKernelGetProcesser &splitKernelGetProcesser)
{
    cpuCoreNum_ = cpuCoreNum;
    randomKernelScheduler_ = randomKernelScheduler;
    splitKernelScheduler_ = splitKernelScheduler;
    splitKernelGetProcesser_ = splitKernelGetProcesser;
}

void SharderNonBlock::Schedule(const Closure &aicpuClosure)
{
    if (randomKernelScheduler_ == nullptr) {
        aicpuClosure();
        return;
    }

    const uint32_t ret = randomKernelScheduler_(aicpuClosure);
    if (ret != 0U) {
        aicpuClosure();
        AICPUE_LOGE("Schedule random kernel event failed, do it by self. ret=%u", ret);
    }

    return;
}

uint32_t SharderNonBlock::GetCPUNum()
{
    return cpuCoreNum_;
}

SharderNonBlock &SharderNonBlock::GetInstance()
{
    static SharderNonBlock sharderNonBlock;
    return sharderNonBlock;
}

inline int64_t SharderNonBlock::CeilMultiple(const int64_t x, const int64_t base) const
{
    int64_t ret = x / base;
    if ((x % base) != 0) {
        ret++;
    }

    return ret;
}

void SharderNonBlock::ParallelFor(const int64_t total, const int64_t perUnitSize, const SharderWork &work)
{
    uint32_t parallelId = 0U;
    {
        const std::lock_guard<std::mutex> lk(parallelIdMutex_);
        ++parallelId_;
        parallelId = parallelId_.load();
    }

    AICPUE_LOGI("In parallel for. parallelId=%u, total=%ld, perUnitSize=%ld", parallelId, total, perUnitSize);
    if ((total <= 0) || (work == nullptr)) {
        AICPUE_LOGE("Invalid param. parallelId=%u, total=%ld", parallelId, total);
        return;
    }

    if ((splitKernelScheduler_ == nullptr) || (splitKernelGetProcesser_ == nullptr) || (cpuCoreNum_ <= 1U)) {
        AICPUE_LOGI("Work itself all. parallelId=%u, cpuCoreNum=%u", parallelId, cpuCoreNum_);
        work(0, total);
        return;
    }

    // In order to ensure a smaller scheduling delay, the maximum number of slices is twice the number of CPU cores
    const int64_t maxShardNum = static_cast<int64_t>(cpuCoreNum_) * 2;

    // calculate shard number and block size
    // i.e., if total is 118, perUintSize is 2, and cpuCoreNum_ is 13
    // then shardNum is 24, blockSize is 5
    int64_t blockSize = std::max(int64_t{1}, std::min(total, perUnitSize));
    int64_t shardNum = CeilMultiple(total, blockSize);
    shardNum = std::min(maxShardNum, shardNum);
    blockSize = CeilMultiple(total, shardNum);
    shardNum = CeilMultiple(total, blockSize);
    // There is no need to submit an event if shardNum is 1
    if (shardNum == 1) {
        AICPUE_LOGI("Executes on the current thread by shardNum is 1. parallelId=%u, total=%ld, perUnitSize=%ld",
                    parallelId, total, perUnitSize);
        work(0, total);
        return;
    }

    ExecuteParallelFor(total, shardNum, blockSize, work, parallelId);
    return;
}

void SharderNonBlock::ExecuteParallelFor(const int64_t total, const int64_t shardNum,
                                         const int64_t blockSize, const SharderWork &work,
                                         const uint32_t parallelId)
{
    AICPUE_LOGI("Op parallel process start. parallelId=%u, shardNum=%ld, blockSize=%ld",
                parallelId, shardNum, blockSize);

    std::atomic<int64_t> cpuNumCounter(shardNum);
    sem_t aicpuSem;
    const int32_t semInitRet = sem_init(&aicpuSem, 0, 0U);
    if (semInitRet == -1) {
        AICPUE_LOGE("sem_init error with message: %s", strerror(errno));
        work(0, total);
        return;
    }

    uint32_t taskIndex = 0U;
    std::queue<aicpu::Closure> taskQueue;
    for (int64_t start = 0; start < total; start += blockSize) {
        const auto limit = std::min(start + blockSize, total);
        const Closure aicpuClosure = [&aicpuSem, &work, &cpuNumCounter, start, limit,
                                      parallelId, shardNum, taskIndex]() {
            cpuNumCounter--;
            // In order to ensure that user's work function exception does not affect multithread services,
            // exception capture is needed. Exception type is not cared here, and error log is printed.
            AICPUE_LOGI("Start call work func. parallelId=%u, shardNum=%ld, taskIndex=%u",
                        parallelId, shardNum, taskIndex);
            try {
                work(start, limit);
            } catch (std::exception &e) {
                AICPUE_LOGE("Exception occurred in work func. parallelId=%u, shardNum=%ld, taskIndex=%u, "
                            "exception=%s", parallelId, shardNum, taskIndex, e.what());
            }

            const int32_t semPostRet = sem_post(&aicpuSem);
            if (semPostRet == -1) {
                AICPUE_LOGE("sem_post error with message: %s", strerror(errno));
            }
            AICPUE_LOGI("End call work func. parallelId=%u, shardNum=%ld, taskIndex=%u",
                        parallelId, shardNum, taskIndex);
        };

        taskQueue.push(aicpuClosure);
        ++taskIndex;
    }

    const uint32_t ret = splitKernelScheduler_(parallelId, shardNum, taskQueue);
    if (ret != 0U) {
        AICPUE_LOGE("Submit split kernel task failed, ret=%u, parallelId=%u", ret, parallelId);
        (void)sem_destroy(&aicpuSem);
        return;
    }

    DoTaskItself(parallelId, cpuNumCounter, shardNum);

    for (int64_t i = 0; i < shardNum; ++i) {
        const int32_t semWaitRet = sem_wait(&aicpuSem);
        if (semWaitRet == -1) {
            AICPUE_LOGE("sem_wait error with message: %s", strerror(errno));
        }
    }
    const int32_t semDesRet = sem_destroy(&aicpuSem);
    if (semDesRet == -1) {
        AICPUE_LOGE("sem_destroy error with message: %s", strerror(errno));
    }

    AICPUE_LOGI("Op parallel process finished. parallelId=%u", parallelId);

    return;
}

void SharderNonBlock::DoTaskItself(const uint32_t parallelId, std::atomic<int64_t> &cpuNumCounter,
                                   const int64_t shardNum) const
{
    uint32_t getEventCnt = 0U;
    bool ret = true;
    bool logPrintFlag = true;
    while ((cpuNumCounter > 0) && ret) {
        ret = splitKernelGetProcesser_();
        ++getEventCnt;
        if ((getEventCnt >= GET_EVENT_LIMITED_NUM) && (logPrintFlag)) {
            logPrintFlag = false;
            std::string opname("");
            (void)GetOpname(GetAicpuThreadIndex(), opname);
            AICPUE_RUN_LOGW("Get event num has exceeded %u. parallelId=%u, cpuNumCounter=%ld, shardNum=%ld, "
                            "opName=%s", GET_EVENT_LIMITED_NUM, parallelId, cpuNumCounter.load(), shardNum,
                            opname.c_str());
        }
    }
}

void SharderNonBlock::ExecuteParallelForHash(const int64_t total, const int64_t cpuNums, const SharderWork &work,
                                             const uint32_t parallelId)
{
    AICPUE_LOGI("Op hash parallel process start. parallelId=%u, total=%ld, cpuNums=%ld",
                parallelId, total, cpuNums);

    std::atomic<int64_t> cpuNumCounter(cpuNums);
    sem_t aicpuSem;
    const int32_t semInitRet = sem_init(&aicpuSem, 0, 0U);
    if (semInitRet == -1) {
        AICPUE_LOGE("sem_init error with message: %s", strerror(errno));
        return;
    }

    std::queue<aicpu::Closure> taskQueue;
    for (int64_t cur = 0; cur < cpuNums; cur++) {
        const Closure aicpuClosure = [&aicpuSem, &work, &cpuNumCounter, total, cur, parallelId]() {
            cpuNumCounter--;
            AICPUE_LOGI("Start call work func. parallelId=%u, cur=%ld, cpuNumCounter=%ld",
                        parallelId, cur, cpuNumCounter.load());
            work(total, cur);

            const int32_t semPostRet = sem_post(&aicpuSem);
            if (semPostRet == -1) {
                AICPUE_LOGE("sem_post error with message: %s", strerror(errno));
            }
        };
        
        taskQueue.push(aicpuClosure);
    }

    const uint32_t ret = splitKernelScheduler_(parallelId, cpuNums, taskQueue);
    if (ret != 0U) {
        AICPUE_LOGE("Submit hash split kernel task failed, ret=%u, parallelId=%u", ret, parallelId);
        (void)sem_destroy(&aicpuSem);
        return;
    }

    DoTaskItself(parallelId, cpuNumCounter, cpuNums);

    for (int64_t i = 0; i < cpuNums; i++) {
        const int32_t semWaitRet = sem_wait(&aicpuSem);
        if (semWaitRet == -1) {
            AICPUE_LOGE("sem_wait error with message: %s", strerror(errno));
        }
    }
    const int32_t semDesRet = sem_destroy(&aicpuSem);
    if (semDesRet == -1) {
        AICPUE_LOGE("sem_destroy error with message: %s", strerror(errno));
    }

    AICPUE_LOGI("Op hash parallel process finished. parallelId=%u", parallelId);
    return;
}

void SharderNonBlock::ParallelForHash(const int64_t total, const int64_t cpuNums, const SharderWork &work)
{
    uint32_t parallelId = 0U;
    {
        const std::lock_guard<std::mutex> lk(parallelIdMutex_);
        ++parallelId_;
        parallelId = parallelId_.load();
    }

    if ((total <= 0) || (work == nullptr)) {
        AICPUE_LOGE("invalid param: total<=0 or work is nullptr");
        return;
    }

    if ((splitKernelScheduler_ == nullptr) || (splitKernelGetProcesser_ == nullptr) || (cpuCoreNum_ <= 1U)) {
        AICPUE_LOGE("schedule is nullptr or cpu core num is not enough");
        return;
    }

    ExecuteParallelForHash(total, cpuNums, work, parallelId);
    return;
}
}

/**
 * Shards the "total" unit of work refer "perUintSize"
 */
void ParallelFor(int64_t total, int64_t perUnitSize, const aicpu::SharderWork &work)
{
    aicpu::SharderNonBlock::GetInstance().ParallelFor(total, perUnitSize, work);
}

/**
 * Get CPU number
 */
uint32_t GetCPUNum()
{
    return aicpu::SharderNonBlock::GetInstance().GetCPUNum();
}