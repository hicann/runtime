/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COMM_CHANNEL_QUEUE_H
#define COMM_CHANNEL_QUEUE_H

#include <atomic>
#include <cstdint>
#include "hccl/hccl_types_in.h"
#include "driver/ascend_hal.h"
#include "fsm/state_define.h"

namespace dgw {
// max queue depth
constexpr uint32_t MAX_QUEUE_DEPTH = 8U * 1024U * 2U + 1U;

template<typename T>
class CommChannelQueue {
public:
    /**
     * @brief Construct a new Comm Channel Queue object
     * @param depth queue depth
     */
    explicit CommChannelQueue() : depth_(1U), head_(0U), tail_(0U), ring_(nullptr)
    {}

    /**
     * @brief Destroy the Comm Channel Queue object
     */
    ~CommChannelQueue()
    {
        try {
            Uninit();
        } catch(...) {
            BQS_LOG_ERROR("CommChannelQueue destructor exception.");
        }
    }

    CommChannelQueue(const CommChannelQueue &) = delete;
    CommChannelQueue(const CommChannelQueue &&) = delete;
    CommChannelQueue &operator = (const CommChannelQueue &) = delete;
    CommChannelQueue &operator = (CommChannelQueue &&) = delete;

    /**
     * @brief init queue
     * @return FSM_SUCCESS: success, other: failed
     */
    FsmStatus Init(const uint32_t depth)
    {
        if ((depth == 0U) || (depth > MAX_QUEUE_DEPTH)) {
            BQS_LOG_ERROR("Invalid parameter, depth:[%u].", depth);
            return FsmStatus::FSM_FAILED;
        }
        depth_ = depth;

        ring_ = new (std::nothrow) T[depth_];
        if (ring_ == nullptr) {
            BQS_LOG_ERROR("Failed to kzalloc memory for queue, depth=[%u].", depth_);
            return FsmStatus::FSM_FAILED;
        }
        BQS_LOG_DEBUG("Succes to alloc memory[%zu].", sizeof(T) * depth_);

        head_ = 0U;
        tail_ = 0U;
        BQS_LOG_DEBUG("Success to init comm channel queue, depth:[%u].", depth_);
        return FsmStatus::FSM_SUCCESS;
    }

    /**
     * @brief uninit queue
     */
    void Uninit()
    {
        if (ring_ != nullptr) {
            delete []ring_;
            ring_ = nullptr;
            BQS_LOG_DEBUG("Success to free memory[%zu].", sizeof(T) * depth_);
        }
        head_ = 0U;
        tail_ = 0U;
        depth_ = 1U;
        BQS_LOG_DEBUG("Success to uninit comm channel queue.");
    }

    /**
     * @brief push one element to queue
     * @param buff buff
     * @return current enqueue success count, 0 failed
     */
    int32_t Push(T &buff)
    {
        BQS_LOG_DEBUG("Push queue, head:[%u], tail:[%u], depth:[%u].",
            head_.load(), tail_.load(), depth_);
        if (IsFull()) {
            return 0;
        }
        ring_[tail_] = std::move(buff);
        // ++tail_ cannot be used because of time sequence problem(pop concurrently)
        tail_ = (tail_ + 1) % depth_;
        return 1;
    }

    /**
     * @brief get first element from queue
     * @return T* first element
     */
    T *Front()
    {
        BQS_LOG_DEBUG("Get front element from queue, head:[%u], tail:[%u], depth:[%u].",
            head_.load(), tail_.load(), depth_);
        if (IsEmpty()) {
            return nullptr;
        }
        return &ring_[head_];
    }

    /**
     * @brief pop first element from queue
     * @return current pop success count, 0 failed
     */
    int32_t Pop()
    {
        BQS_LOG_DEBUG("Pop queue, head:[%u], tail:[%u], depth:[%u].",
            head_.load(), tail_.load(), depth_);
        if (IsEmpty()) {
            return 0;
        }
        // ++head_ cannot be used because of time sequence problem(push concurrently)
        head_ = (head_ + 1) % depth_;
        return 1;
    }

    /**
     * @brief check queue empty
     * @return true or false
     */
    bool IsEmpty() const
    {
        BQS_LOG_DEBUG("Check queue empty, head:[%u], tail:[%u], depth:[%u].",
            head_.load(), tail_.load(), depth_);
        return (head_ == tail_);
    }

    /**
     * @brief check queue full
     * @return true or false
     */
    bool IsFull() const
    {
        BQS_LOG_DEBUG("Check queue full, head:[%u], tail:[%u], depth:[%u].",
            head_.load(), tail_.load(), depth_);
        return (((tail_ + 1) % depth_) == head_);
    }

    /**
     * @brief get queue elements count
     * @return queue elements count
     */
    uint32_t Size() const
    {
        return ((tail_ - head_) + depth_) % depth_;
    }

private:
    // max store (depth_ - 1) elements
    uint32_t depth_;
    // head: point to where the effective memory on the ring begins
    // tail: point to the released ring position
    std::atomic<uint32_t> head_;
    std::atomic<uint32_t> tail_;
    T *ring_;
};
} // namespace dgw
#endif