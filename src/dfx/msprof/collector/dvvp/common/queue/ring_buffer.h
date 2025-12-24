/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_QUEUE_RING_BUFFER_H
#define ANALYSIS_DVVP_COMMON_QUEUE_RING_BUFFER_H

#include <atomic>
#include <cstdio>
#include <thread>
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#include <windows.h>
#else
#include <unistd.h>
#endif
#include <vector>
#include "logger/msprof_dlog.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace queue {
static const size_t RING_BUFFER_DEFAULT_MAX_PUSH_CYCLES = 2048;
enum class DataStatus {
    DATA_STATUS_NOT_READY = 0,
    DATA_STATUS_READY = 1
};
// NOTE:
// The ring buffer is only for multiple producers and single consumer model
// The capacity must be a power of two
template <class T>
class RingBuffer {
public:
    explicit RingBuffer(const T& initialVal, size_t maxCycles = RING_BUFFER_DEFAULT_MAX_PUSH_CYCLES)
        : capacity_(0),
          initialVal_(initialVal),
          maxCycles_(maxCycles),
          mask_(0),
          readIndex_(0),
          writeIndex_(0),
          idleWriteIndex_(0),
          isQuit_(false),
          isInited_(false),
          name_("RingBuffer")
    {
    }

    virtual ~RingBuffer()
    {
        UnInit();
    }
public:
    void Init(size_t capacity, const std::string &name)
    {
        capacity_ = capacity;
        name_ = name;
        MSPROF_LOGI("Init ring buffer[%s] size: %zu", name_.c_str(), capacity_);
        mask_ = capacity - 1;
        std::vector<T> data(capacity_, initialVal_);
        dataQueue_.swap(data);
        std::vector<uint64_t> dataAail(capacity_, static_cast<uint64_t>(DataStatus::DATA_STATUS_NOT_READY));
        dataAvails_.swap(dataAail);
        isInited_ = true;
    }

    void UnInit()
    {
        if (isInited_) {
            MSPROF_LOGI("UnInit ring buffer[%s] size: %zu", name_.c_str(), capacity_);
            isInited_ = false;
            isQuit_ = true;
            dataQueue_.clear();
            dataAvails_.clear();
        }
    }

    void SetName(const std::string& name)
    {
        name_ = name;
        MSPROF_LOGI("Ring buffer[%s] size: %zu", name_.c_str(), capacity_);
    }

    void SetQuit()
    {
        isQuit_ = true;
    }

    bool TryPush(const T& data)
    {
        size_t currReadCusor = 0;
        size_t currWriteCusor = 0;
        size_t nextWriteCusor = 0;
        size_t cycles = 0;

        do {
            if (!isInited_ || isQuit_) {
                MSPROF_LOGI("Ring buffer is not initialized.");
                return false;
            }

            cycles++;
            if (cycles >= maxCycles_) {
                size_t size = GetUsedSize();
                MSPROF_LOGW("QueueName: %s, QueueCapacity:%" PRIu64 ", QueueSize:%" PRIu64,
                            name_.c_str(), capacity_, size);
                return false;
            }

            currReadCusor = readIndex_.load(std::memory_order_relaxed);
            currWriteCusor = idleWriteIndex_.load(std::memory_order_relaxed);
            nextWriteCusor = currWriteCusor + 1;
            if ((nextWriteCusor & mask_) == (currReadCusor & mask_)) {
                MSPROF_LOGW("IsFull, QueueName:%s, QueueCapacity:%" PRIu64 ", Read:%" PRIu64 ", Write:%lld, Used:%"
                    PRIu64, name_.c_str(), capacity_, currReadCusor, currWriteCusor, GetUsedSize());
                return false;
            }
        } while (!idleWriteIndex_.compare_exchange_weak(currWriteCusor, nextWriteCusor));

        size_t index = currWriteCusor & mask_;
        dataQueue_[index] = data;
        writeIndex_++;
        dataAvails_[index] = static_cast<uint64_t>(DataStatus::DATA_STATUS_READY);

        return true;
    }

    bool TryPop(T& data)
    {
        if (!isInited_) {
            return false;
        }

        const size_t currReadCusor = readIndex_.load(std::memory_order_relaxed);
        const size_t currWriteCusor = writeIndex_.load(std::memory_order_relaxed);
        if ((currReadCusor & mask_) == (currWriteCusor & mask_)) {
            return false;
        }

        size_t index = currReadCusor & mask_;
        if (dataAvails_[index] == static_cast<uint64_t>(DataStatus::DATA_STATUS_READY)) {
            data = dataQueue_[index];
            dataAvails_[index] = static_cast<uint64_t>(DataStatus::DATA_STATUS_NOT_READY);
            readIndex_++;
            return true;
        }

        return false;
    }

    size_t GetUsedSize()
    {
        const size_t readIndex = readIndex_.load(std::memory_order_relaxed);
        const size_t writeIndex = writeIndex_.load(std::memory_order_relaxed);
        if (readIndex > writeIndex) {
            return capacity_ - ((readIndex & mask_) - (writeIndex & mask_));
        }

        return writeIndex - readIndex;
    }

private:
    size_t capacity_;
    T initialVal_;
    size_t maxCycles_;
    size_t mask_;
    std::atomic<size_t> readIndex_;
    std::atomic<size_t> writeIndex_;
    std::atomic<size_t> idleWriteIndex_;
    volatile bool isQuit_;
    bool isInited_;
    std::string name_;
    std::vector<T> dataQueue_;
    std::vector<uint64_t> dataAvails_;
};
}  // namespace queue
}  // namespace common
}  // namespace dvvp
}  // namespace analysis

#endif