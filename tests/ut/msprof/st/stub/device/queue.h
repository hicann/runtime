/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CANN_DVVP_TEST_QUEUE_H
#define CANN_DVVP_TEST_QUEUE_H
#include <queue>
#include <mutex>
#include <condition_variable>
namespace Cann {
namespace Dvvp {
namespace Test {
template<class T>
class Queue {
public:
    Queue(): quit_(false) {}
    void Push(T &value)
    {
        std::lock_guard<std::mutex> lk(mtx_);
        queue_.push(value);
        cond_.notify_one();
    }

    bool Empty()
    {
        std::lock_guard<std::mutex> lk(mtx_);
        return queue_.empty();
    }

    int32_t Pop(T *value, int32_t num)
    {
        std::unique_lock<std::mutex> lk(mtx_);
        cond_.wait(lk, [this]{ return !queue_.empty() || quit_; });
        int32_t count = 0;
        for (; count < num; ++count) {
            if (queue_.empty()) {
                break;
            }
            value[count] = queue_.front();
            queue_.pop();
        }
        return count;
    }

    bool TryPop(T &value)
    {
        std::lock_guard<std::mutex> lk(mtx_);
        if (queue_.empty()) {
            return false;
        }
        queue_ = queue_.front();
        queue_.pop();
        return true;
    }

    void NotifyQuit()
    {
        std::lock_guard<std::mutex> lk(mtx_);
        if (quit_) {
            return;
        }
        quit_ = true;
        cond_.notify_all();
    }

private:
    mutable bool quit_;
    std::condition_variable cond_;
    mutable std::mutex mtx_;
    std::queue<T> queue_;
};
}
}
}
#endif
