/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BLOCK_BUFFER_H
#define BLOCK_BUFFER_H

#include <atomic>
#include <string>
#include "securec.h"
#include "logger/msprof_dlog.h"
#include "prof_api.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace queue {
const size_t BLOCK_BUFFER_MAX_CYCLES    = 2048;
const size_t BLOCK_BUFF_CAPACITY        = 16384; // 16K length queue
const size_t MAX_DRV_REPORT_SIZE        = 524032; // 512K - 256 byte pack
const uint32_t BLOCK_PUSH_WAIT_TIME     = 1;
const std::string BLOCK_BUFFER_NAME = "BlockBuffer";

/**
 * @brief Customized buffer using for report api, compact or additional data
 */
template <class T>
class BlockBuffer {
public:
    explicit BlockBuffer(size_t maxCycles = BLOCK_BUFFER_MAX_CYCLES)
        : capacity_(BLOCK_BUFF_CAPACITY),
          maxCycles_(maxCycles),
          mask_(0),
          readIndex_(0),
          writeIndex_(0),
          idleWriteIndex_(0),
          isInited_(false),
          name_(BLOCK_BUFFER_NAME),
          dataBuffer_(nullptr)
    {}

    virtual ~BlockBuffer()
    {
        UnInit();
    }

public:
    /**
    * @brief Init block buffer
    * @param [in] name: the name of block buffer
    * @param [in] capacity: the length of block buffer, which need to be 2^n and larger than MAX_DRV_REPORT_SIZE
    * @return true: success, false: failed
    */
    bool Init(const std::string &name, size_t capacity = BLOCK_BUFF_CAPACITY)
    {
        if (capacity <= (MAX_DRV_REPORT_SIZE / sizeof(T))) {
            MSPROF_LOGE("Failed to init block buffer, capacity: %zu, buffer name: %s", capacity, name.c_str());
            return false;
        }

        if (isInited_) {
            MSPROF_LOGW("Repeat init block buffer, capacity: %zu, buffer name: %s", capacity, name.c_str());
            return true;
        }

        capacity_ = capacity;
        name_ = name;
        mask_ = capacity - 1;
        dataBuffer_ = new (std::nothrow) T[capacity];
        if (dataBuffer_ == nullptr) {
            MSPROF_LOGE("Failed to new block buffer, capacity: %zu, buffer name: %s", capacity, name.c_str());
            return false;
        }

        isInited_ = true;
        MSPROF_EVENT("Init block buffer successfully, capacity: %zu, buffer name: %s", capacity_, name_.c_str());
        return true;
    }
    /**
    * @brief UnInit block buffer
    */
    void UnInit()
    {
        if (isInited_) {
            isInited_ = false;
            size_t currReadCursor = readIndex_.load(std::memory_order_relaxed);
            size_t currWriteCursor = writeIndex_.load(std::memory_order_relaxed);
            if ((currWriteCursor - currReadCursor) >= capacity_) {
                MSPROF_LOGE("Block buffer overflow, [%s] capacity: %zu, read count: %zu, "
                    "write count: %zu", name_.c_str(), capacity_, currReadCursor, currWriteCursor);
            }

            if (dataBuffer_ != nullptr) {
                delete[] dataBuffer_;
            }

            MSPROF_EVENT("total_size_report [%s] read count: %zu, write count: %zu",
                name_.c_str(), readIndex_.exchange(0), writeIndex_.exchange(0));
            idleWriteIndex_.exchange(0);
        }
    }
    /**
    * @brief Print read and write count of block buffer
    */
    void Print()
    {
        if (isInited_) {
            size_t currReadCursor = readIndex_.load(std::memory_order_relaxed);
            size_t currWriteCursor = writeIndex_.load(std::memory_order_relaxed);
            MSPROF_EVENT("print_report_count [%s] read count: %zu, write count: %zu",
                name_.c_str(), currReadCursor, currWriteCursor);
        }
    }
    /**
    * @brief Batch push data into block buffer
    * @param [in] data: the data need to be pushed
    * @param [in] dataSize: the size of data, which need to be aligned with sizeof(T)
    * @return MSPROF_ERROR_NONE: success, MSPROF_ERROR_UNINITIALIZE: uninitialized
    */
    int32_t BatchPush(const T *data, size_t dataSize)
    {
        if (!isInited_) {
            MSPROF_LOGW("Block buffer %s is not initialized.", name_.c_str());
            return MSPROF_ERROR_UNINITIALIZE;
        }
        size_t currWriteCursor = 0;
        size_t nextWriteCursor = 0;
        size_t currReadCursor = 0;
        size_t cycles = 0;
        size_t inSize = dataSize / sizeof(T);
        size_t packSize = MAX_DRV_REPORT_SIZE / sizeof(T);
        do {
            cycles++;
            if (cycles >= maxCycles_) {
                MSPROF_LOGW("Block cycle overflow, buffer name: %s, buffer capacity: %u", name_.c_str(), capacity_);
                return MSPROF_ERROR_NONE;
            }

            currWriteCursor = idleWriteIndex_.load();
            currReadCursor = readIndex_.load();
            nextWriteCursor = currWriteCursor + inSize;
            // check if block buffer about to overflow
            // packSize is used to ensure that the data of the previous pop packet is cleared
            if ((currWriteCursor - currReadCursor) + inSize > capacity_ - packSize) {
                MSPROF_LOGW("Block buffer about to overflow, buffer name: %s, buffer capacity: %u, "
                    "currWriteCursor: %zu, currReadCursor: %zu, inSize: %zu", name_.c_str(), capacity_,
                    currWriteCursor, currReadCursor, inSize);
                usleep(BLOCK_PUSH_WAIT_TIME);
            }
        } while (((currWriteCursor - currReadCursor) + inSize > capacity_ - packSize) ||
                 (!idleWriteIndex_.compare_exchange_strong(currWriteCursor, nextWriteCursor)));

        size_t index = currWriteCursor & mask_;
        if (index + inSize > capacity_) {
            size_t endSize = capacity_ - index;
            size_t frontSize = inSize - endSize;
            (void)memcpy_s(dataBuffer_ + index, endSize * sizeof(T), data, endSize * sizeof(T));
            (void)memcpy_s(dataBuffer_, frontSize * sizeof(T), data + endSize, frontSize * sizeof(T));
        } else {
            (void)memcpy_s(dataBuffer_ + index, dataSize, data, dataSize);
        }
        writeIndex_.fetch_add(inSize);
        return MSPROF_ERROR_NONE;
    }
    /**
    * @brief Batch pop data from block buffer
    * @param [out] popSize: pop size of data, which need to be aligned with sizeof(T)
    * @param [in] popForce: whether force pop data when data size is not enough
    */
    void *BatchPop(size_t &popSize, bool popForce)
    {
        if (!isInited_ || popSize == 0) {
            return nullptr;
        }

        size_t currReadCursor = readIndex_.load(std::memory_order_relaxed);
        size_t currWriteCursor = writeIndex_.load(std::memory_order_relaxed);
        // check if read cursor is equal to write cursor
        if ((currReadCursor & mask_) == (currWriteCursor & mask_)) {
            return nullptr;
        }

        size_t availSize = (currWriteCursor - currReadCursor) * sizeof(T);
        size_t offerSize = (availSize >= popSize) ? popSize : availSize;
        // check if offer size is not enough and popForce is false
        if (offerSize < popSize && !popForce) {
            return nullptr;
        }

        size_t currIndex = currReadCursor & mask_;
        size_t outIndex = (currReadCursor + offerSize / sizeof(T)) & mask_;
        // check if data is available
        if (currIndex < outIndex) {
            if (!IsAvail(currIndex, outIndex)) {
                return nullptr;
            }
            popSize = offerSize;
        } else {
            if (!IsAvail(currIndex, capacity_)) {
                return nullptr;
            }
            popSize = (capacity_ - currIndex) * sizeof(T);
        }

        return dataBuffer_ + currIndex;
    }
    /**
    * @brief Adapt read index and clear data
    * @param [in] popPtr: pop start ptr
    * @param [in] popSize: pop size of data
    */
    void BatchPopBufferIndexShift(void *popPtr, const size_t popSize)
    {
        if (popPtr == nullptr || popSize == 0) {
            return;
        }

        (void)memset_s(popPtr, popSize, 0, popSize);
        readIndex_.fetch_add(popSize / sizeof(T));
    }
    /**
    * @brief Get used size of block buffer
    * @return size_t: used size of block buffer
    */
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
    /**
    * @brief Use MSPROF_REPORT_DATA_MAGIC_NUM head to check data is available
    * @param [in] startIndex: start index of data
    * @param [in] endIndex: end index of data
    * @return true: available, false: unavailable
    */
    bool IsAvail(const size_t startIndex, const size_t endIndex) const
    {
        for (size_t i = startIndex; i < endIndex; i++) {
            if (*(reinterpret_cast<uint16_t *>(dataBuffer_ + i)) != MSPROF_REPORT_DATA_MAGIC_NUM) {
                return false;
            }
        }

        return true;
    }

private:
    size_t capacity_;
    size_t maxCycles_;
    size_t mask_;
    std::atomic<size_t> readIndex_;
    std::atomic<size_t> writeIndex_;
    std::atomic<size_t> idleWriteIndex_;
    volatile bool isInited_;
    std::string name_;
    T *dataBuffer_;
};
}
}
}
}

#endif
