/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef REPORT_BUFFER_H
#define REPORT_BUFFER_H

#include <limits>
#include <atomic>
#include <string>
#include "logger/msprof_dlog.h"
#include "prof_api.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace queue {
#define DELETE_REPORT_MEM(queue, action) do {                   \
    if (queue != nullptr) {                                     \
        action;                                                 \
    }                                                           \
} while (0)

static const size_t MAX_RING_BUFF_CAPACITY      = 2097152; // 2097152: 2M
static const size_t MIN_RING_BUFF_CAPACITY      = 2048;    // 2048: 2K
static const size_t API_RING_BUFF_CAPACITY      = 131072;  // 131072: 128K
static const size_t COM_RING_BUFF_CAPACITY      = 262144;  // 262144: 256K
static const size_t ADD_RING_BUFF_CAPACITY      = 262144;  // 262144: 256K
static const size_t REPORT_BUFFER_MAX_CYCLES    = 2048;
static const uint32_t NEG_RING_BUFF_PERCENT     = 1000;    // 1000: (1/0.1%)
static const uint32_t CARDINALITY_RING_BUFF     = 2;       // 2^n cardinal number
static const std::string REPORT_RINGBUFFER_NAME = "ReportBuffer";
static const uint8_t DATA_STATUS_IS_NOT_READY      = 0;
static const uint8_t DATA_STATUS_IS_READY       = 1;
static const uint32_t PUSH_WAIT_TIME            = 1;

template <class T>
class ReportBuffer {
public:
    explicit ReportBuffer(const T& initialVal, size_t maxCycles = REPORT_BUFFER_MAX_CYCLES)
        : capacity_(0),
          initialVal_(initialVal),
          maxCycles_(maxCycles),
          mask_(0),
          readIndex_(0),
          writeIndex_(0),
          idleWriteIndex_(0),
          isQuit_(false),
          isInited_(false),
          name_(REPORT_RINGBUFFER_NAME)
    {}

    virtual ~ReportBuffer()
    {
        UnInit();
    }

    struct ReportDataChunk {
        T data;
        uint8_t aging = 0;
        uint8_t avail = DATA_STATUS_IS_NOT_READY;
    };

public:
    // capacity must be 2^n
    void Init(const size_t capacity, const std::string &name)
    {
        if (isInited_) {
            MSPROF_LOGW("Repeat init report buffer capacity: %zu, buffer name: %s", capacity, name.c_str());
            return;
        }
        capacity_ = capacity;
        name_ = name;
        MSPROF_EVENT("Init report buffer capacity: %zu, buffer name: %s", capacity_, name_.c_str());
        mask_ = capacity - 1;
        dataQueue_ = new (std::nothrow) ReportDataChunk[capacity]();

        if (dataQueue_ == nullptr) {
            MSPROF_LOGE("Failed to init report buffer");
            DELETE_REPORT_MEM(dataQueue_, delete[] dataQueue_);
            return;
        }
        isInited_ = true;
        isQuit_ = false;
    }

    void UnInit()
    {
        if (isInited_) {
            isInited_ = false;
            isQuit_ = true;
            const size_t currReadCusor = readIndex_.load(std::memory_order_relaxed);
            const size_t currWriteCusor = writeIndex_.load(std::memory_order_relaxed);
            if ((currWriteCusor - currReadCusor) >= capacity_) {
                MSPROF_LOGE("Report buffer overflow, [%s] capacity: %zu, read count: %zu, "
                    "write count: %zu", name_.c_str(), capacity_, currReadCusor, currWriteCusor);
            }
            DELETE_REPORT_MEM(dataQueue_, delete[] dataQueue_);
            MSPROF_EVENT("total_size_report [%s] read count: %zu, write count: %zu",
                name_.c_str(), readIndex_.exchange(0), writeIndex_.exchange(0));
            idleWriteIndex_.exchange(0);
        }
    }

    void Print()
    {
        if (isInited_) {
            const size_t currReadCusor = readIndex_.load(std::memory_order_relaxed);
            const size_t currWriteCusor = writeIndex_.load(std::memory_order_relaxed);
            MSPROF_EVENT("print_report_count [%s] read count: %zu, write count: %zu",
                name_.c_str(), currReadCusor, currWriteCusor);
        }
    }

    int32_t Push(uint32_t aging, const T& data)
    {
        if (!isInited_ || isQuit_) {
            MSPROF_LOGW("Ring buffer %s is not initialized.", name_.c_str());
            return MSPROF_ERROR_UNINITIALIZE;
        }

        size_t currWriteCusor = 0;
        size_t nextWriteCusor = 0;
        size_t currReadCusor = 0;
        size_t cycles = 0;
        do {
            cycles++;
            if (cycles >= maxCycles_) {
                MSPROF_LOGW("Cycle overflow, QueueName: %s, QueueCapacity: %u", name_.c_str(), capacity_);
                return MSPROF_ERROR_NONE;
            }

            currWriteCusor = idleWriteIndex_.load();
            currReadCusor = readIndex_.load();
            nextWriteCusor = currWriteCusor + 1;
            if ((nextWriteCusor & mask_) == (currReadCusor & mask_)) {
                usleep(PUSH_WAIT_TIME);
            }
        } while (((nextWriteCusor & mask_) == (currReadCusor & mask_)) ||
                 (!idleWriteIndex_.compare_exchange_strong(currWriteCusor, nextWriteCusor)));

        size_t index = currWriteCusor & mask_;
        dataQueue_[index].data = data;
        dataQueue_[index].aging = aging;

        writeIndex_.fetch_add(1);
        dataQueue_[index].avail = DATA_STATUS_IS_READY;
        return MSPROF_ERROR_NONE;
    }

    int32_t TryPush(uint32_t aging, const T& data)
    {
        if (!isInited_ || isQuit_) {
            MSPROF_LOGW("Ring buffer %s is not initialized.", name_.c_str());
            return MSPROF_ERROR_UNINITIALIZE;
        }

        size_t currWriteCusor = 0;
        size_t nextWriteCusor = 0;
        size_t cycles = 0;
        do {
            cycles++;
            if (cycles >= maxCycles_) {
                MSPROF_LOGW("Cycle overflow, QueueName: %s, QueueCapacity: %u", name_.c_str(), capacity_);
                return MSPROF_ERROR_NONE;
            }
            currWriteCusor = idleWriteIndex_.load(std::memory_order_relaxed);
            nextWriteCusor = currWriteCusor + 1;
        } while (!idleWriteIndex_.compare_exchange_weak(currWriteCusor, nextWriteCusor));

        const size_t index = currWriteCusor & mask_;
        dataQueue_[index].data = data;
        dataQueue_[index].aging = aging;

        writeIndex_.fetch_add(1);
        dataQueue_[index].avail = DATA_STATUS_IS_READY;
        return MSPROF_ERROR_NONE;
    }

    bool TryPop(uint32_t &aging, T& data)
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
        if (dataQueue_[index].avail == DATA_STATUS_IS_READY) {
            data = dataQueue_[index].data;
            aging = dataQueue_[index].aging;
            dataQueue_[index].avail = DATA_STATUS_IS_NOT_READY;
            readIndex_.fetch_add(1);
            return true;
        }

        return false;
    }

    size_t GetUsedSize()
    {
        size_t readIndex = readIndex_.load(std::memory_order_relaxed);
        size_t writeIndex = writeIndex_.load(std::memory_order_relaxed);
        if (readIndex > writeIndex) {
            return ((std::numeric_limits<size_t>::max() - readIndex + writeIndex) % capacity_);
        }

        return ((writeIndex - readIndex) % capacity_);
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
    ReportDataChunk* dataQueue_;
};
}
}
}
}

#endif
