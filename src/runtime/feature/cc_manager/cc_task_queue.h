/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_TASK_QUEUE_H
#define CCE_RUNTIME_CC_TASK_QUEUE_H

#include <cstdint>
#include <cstddef>
#include <queue>
#include <mutex>
#include <condition_variable>
#include "base.hpp"
#include "rt_external_mem.h"
#include "crypto/cc_crypto.h"
#include "task_queue/task_queue_abi.h"

namespace cce {
namespace runtime {

constexpr uint32_t CC_SLICE_DESC_SLOT_NUM = 3U;
// 密文 buffer 大小（header + plaintext）
constexpr uint32_t CC_SLICE_SIZE = 2U * 1024U * 1024U;
// 单分片密文头大小
constexpr uint32_t CC_CIPHER_HEADER_SIZE = static_cast<uint32_t>(sizeof(AiccCiphertextHeader));
// 单分片最大明文字节数
constexpr uint32_t CC_PLAINTEXT_SLICE_SIZE = CC_SLICE_SIZE - CC_CIPHER_HEADER_SIZE;

// Host 侧内存拷贝任务（CCMemcpyTaskQueue 的节点，由 CCWorker 消费）。
struct CCMemcpyTask {
    const void* src;                // 源地址
    void* dst;                      // 目标地址
    size_t totalSize;               // 总拷贝大小
    rtMemcpyKind_t kind;            // H2D 或 D2H
    uint32_t streamId;              // Worker 通过 StreamSqCqManage 获取 Stream shared_ptr
    std::shared_ptr<void> guardMem; // Memset场景下保活Host侧的临时Buffer
};

// Host 侧任务队列（per-device，1 个共享队列，结构为纯数据 + 内联方法）。
struct CCMemcpyTaskQueue {
    bool Push(const CCMemcpyTask& task)
    {
        {
            std::lock_guard<std::mutex> lock(mutex_);
            if (closed_) {
                return false;
            }
            queue_.push(task);
        }
        cv_.notify_one();
        return true;
    }

    bool Pop(CCMemcpyTask& task)
    {
        std::unique_lock<std::mutex> lock(mutex_);
        cv_.wait(lock, [&]() { return !queue_.empty() || closed_; });
        if (queue_.empty()) {
            return false;
        }
        task = queue_.front();
        queue_.pop();
        return true;
    }

    // 关闭队列 + 清空未领取任务 + 唤醒所有 worker 立即退出
    void Shutdown()
    {
        {
            std::lock_guard<std::mutex> lock(mutex_);
            closed_ = true;
            std::queue<CCMemcpyTask> empty;
            queue_.swap(empty);
        }
        cv_.notify_all();
    }

    // 按 streamId 移除尚未被 worker 领取的任务
    void CancelTasksByStream(uint32_t streamId)
    {
        std::lock_guard<std::mutex> lock(mutex_);
        std::queue<CCMemcpyTask> remainingTasks;
        while (!queue_.empty()) {
            const CCMemcpyTask& task = queue_.front();
            if (task.streamId != streamId) {
                remainingTasks.push(task);
            }
            queue_.pop();
        }
        queue_.swap(remainingTasks);
    }

    std::queue<CCMemcpyTask> queue_;
    mutable std::mutex mutex_;
    std::condition_variable cv_;
    bool closed_{false};
};

} // namespace runtime
} // namespace cce

#endif
