/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_WORKSPACE_LOCK_FREE_QUEUE_H
#define OP_API_WORKSPACE_LOCK_FREE_QUEUE_H
#include <atomic>
#include <array>

namespace op {
namespace internal {
template <typename T, size_t Size = 1000>
class LockFreeQueue {
public:
    LockFreeQueue() : head(0), tail(0)
    {}

    bool Enqueue(const T &value)
    {
        size_t currentTail = tail.load(std::memory_order_relaxed);
        size_t nextTail = (currentTail + 1) % Size;
        if (nextTail == head.load(std::memory_order_acquire)) {
            return false;  // 队列已满
        }
        buffer[currentTail] = value;
        tail.store(nextTail, std::memory_order_release);
        return true;
    }

    bool Dequeue(T &result)
    {
        size_t currentHead = head.load(std::memory_order_relaxed);
        if (currentHead == tail.load(std::memory_order_acquire)) {
            return false;  // 队列为空
        }
        result = buffer[currentHead];
        head.store((currentHead + 1) % Size, std::memory_order_release);
        return true;
    }

private:
    std::array<T, Size> buffer;
    std::atomic<size_t> head;
    std::atomic<size_t> tail;
};

}  // namespace internal
}  // namespace op
#endif  // OP_API_WORKSPACE_LOCK_FREE_QUEUE_H