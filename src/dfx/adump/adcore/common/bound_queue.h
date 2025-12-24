/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_COMMON_UTILS_BOUND_QUEUE_H
#define ADX_COMMON_UTILS_BOUND_QUEUE_H
#include <condition_variable>
#include <queue>
#include <mutex>
namespace Adx {
template<typename T>
class BoundQueue {
public:
    explicit BoundQueue (uint32_t capacity)
        : quit_(false), capacity_(capacity) {}
    virtual ~BoundQueue() {}
    bool TryPush(T &value)
    {
        std::lock_guard<std::mutex> lk(mtx_);
        if (this->IsFull()) {
            return false;
        }

        dataQueue_.push(value);
        cvPush_.notify_all();
        return true;
    }

    bool Push(T &value)
    {
        std::unique_lock<std::mutex> lk(mtx_);
        cvPop_.wait(lk, [=] { return !this->IsFull() || quit_;});
        dataQueue_.push(value);
        cvPush_.notify_all();
        return true;
    }

    bool TryPop(T &value)
    {
        std::lock_guard<std::mutex> lk(mtx_);
        if (dataQueue_.empty()) {
            return false;
        }

        value = dataQueue_.front();
        dataQueue_.pop();
        cvPop_.notify_all();
        return true;
    }

    bool Pop(T &value)
    {
        std::unique_lock<std::mutex> lk(mtx_);
        cvPush_.wait(lk, [=] { return !this->IsEmpty() || quit_; });
        if (!this->IsEmpty()) {
            value = this->dataQueue_.front();
            this->dataQueue_.pop();
            cvPop_.notify_all();
            return true;
        }

        return false;
    }

    bool IsEmpty() const
    {
        return dataQueue_.empty();
    }

    bool IsFull() const
    {
        return dataQueue_.size() == capacity_;
    }

    void Quit()
    {
        std::lock_guard<std::mutex> lk(mtx_);
        if (!quit_) {
            quit_ = true;
            cvPush_.notify_all();
            cvPop_.notify_all();
        }
    }

    uint32_t Size()
    {
        return dataQueue_.size();
    }
private:
    mutable bool quit_;
    mutable std::mutex mtx_;
    std::queue<T> dataQueue_;
    std::condition_variable cvPop_;
    std::condition_variable cvPush_;
    uint32_t capacity_;
};
}
#endif
