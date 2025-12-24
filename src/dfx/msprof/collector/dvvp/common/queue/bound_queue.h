/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_QUEUE_BOUND_QUEUE_H
#define ANALYSIS_DVVP_COMMON_QUEUE_BOUND_QUEUE_H

#include <condition_variable>
#include <mutex>
#include <queue>
#include <vector>
#include "logger/msprof_dlog.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace queue {
constexpr int32_t QUEUE_INFO_PRINT_FREQUENCY = 500;  // 500 : print freq
constexpr int32_t QUEUE_CAPACITY_SIZE = 100;

template<class T>
class QueueBase {
public:
    explicit QueueBase(size_t capacity) : capacity_(capacity) {}
    virtual ~QueueBase() {}

protected:
    bool IsQueueFull() const
    {
        bool isFull = (queue_.size() == capacity_);
        if (isFull) {
            MSPROF_LOGW("IsFULL, QueueName: %s, QueueCapacity:%zu, QueueSize:%zu",
                        queueName_.c_str(), capacity_, capacity_);
        }
        return isFull;
    }

    bool IsQueueEmpty() const
    {
        return queue_.empty();
    }

    size_t capacity_;
    std::queue<T> queue_;
    std::string queueName_;
};

template<class T>
class BoundQueue : public QueueBase<T> {
public:
    explicit BoundQueue(size_t capacity)
        : QueueBase<T>(capacity),
          quit_(false),
          pushCnt_(0),
          hisMaxCnt_(0)
    {
        static const std::string BOUND_QUEUE_NAME = "BoundQueue";
        this->queueName_ = BOUND_QUEUE_NAME;
    }

    bool TryPush(const T &data)
    {
        std::lock_guard<std::mutex> lk(mtx_);

        if (this->IsQueueFull()) {
            return false;
        }

        this->queue_.push(data);
        cvPush_.notify_all();
        return true;
    }

    bool Push(const T &data)
    {
        std::unique_lock<std::mutex> lk(mtx_);
        pushCnt_++;
        size_t size = this->queue_.size();
        hisMaxCnt_ = (size > hisMaxCnt_) ? size : hisMaxCnt_;
        if ((pushCnt_ % QUEUE_INFO_PRINT_FREQUENCY) == 0) {
            pushCnt_ = 0;
            if (this->capacity_ > 0) {
                MSPROF_LOGI("QueueName: %s, QueueCapacity:%zu, QueueSize:%zu, HisMaxCut:%zu, Percent:%-7.4f%%",
                    this->queueName_.c_str(), this->capacity_, size, hisMaxCnt_,
                    (static_cast<double>(size) / this->capacity_) * QUEUE_CAPACITY_SIZE);
            }
        }
        if (this->IsQueueFull() && (this->capacity_ > 0)) {
            MSPROF_LOGW("QueueFull,QueueName: %s, QueueCapacity:%zu, QueueSize:%zu, Percent:%-7.4f%%",
                this->queueName_.c_str(), this->capacity_, size,
                (static_cast<double>(size) / this->capacity_) * QUEUE_CAPACITY_SIZE);
        }
        // if queue is full, wait until notify from pop, then check again
        cvPop_.wait(lk, [this] { return !this->IsQueueFull() || quit_; });
        if (!quit_) {
            this->queue_.push(data);
            cvPush_.notify_all();
            return true;
        }

        return false;
    }

    bool TryPop(T &data)
    {
        std::lock_guard<std::mutex> lk(mtx_);

        if (this->IsQueueEmpty()) {
            return false;
        }

        data = this->queue_.front();
        this->queue_.pop();
        cvPop_.notify_all();

        return true;
    }

    bool TryBatchPop(int32_t batchCount, std::vector<T> &data)
    {
        std::lock_guard<std::mutex> lk(mtx_);

        if (this->IsQueueEmpty()) {
            return false;
        }

        int32_t count = 0;
        while (!this->IsQueueEmpty() && (count < batchCount)) {
            data.push_back(this->queue_.front());
            this->queue_.pop();
            count++;
        }

        cvPop_.notify_all();

        return true;
    }

    bool Pop(T &data)
    {
        std::unique_lock<std::mutex> lk(mtx_);

        // if queue is empty, wait until notify from Push
        cvPush_.wait(lk, [this] { return !this->IsQueueEmpty() || quit_; });
        if (!this->IsQueueEmpty()) {
            data = this->queue_.front();
            this->queue_.pop();
            cvPop_.notify_all();
            return true;
        }

        return false;
    }

    void Quit()
    {
        std::lock_guard<std::mutex> lk(mtx_);

        if (quit_) {
            return;
        }
        quit_ = true;
        cvPush_.notify_all();
        cvPop_.notify_all();
    }

    void SetQuit()
    {
        std::lock_guard<std::mutex> lk(mtx_);

        if (!quit_) {
            quit_ = true;
            cvPush_.notify_all();
            cvPop_.notify_all();
        }
    }

    size_t Size()
    {
        std::lock_guard<std::mutex> lk(mtx_);
        return this->queue_.size();
    }

    void SetQueueName(const std::string &name)
    {
        std::lock_guard<std::mutex> lk(mtx_);
        if (!name.empty()) {
            this->queueName_ = name;
        }
    }

private:
    volatile bool quit_;
    uint64_t pushCnt_;
    size_t hisMaxCnt_;
    std::mutex mtx_;
    std::condition_variable cvPush_;
    std::condition_variable cvPop_;
};
}  // namespace queue
}  // namespace common
}  // namespace dvvp
}  // namespace analysis

#endif
