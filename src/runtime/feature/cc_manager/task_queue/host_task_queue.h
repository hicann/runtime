/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CC_HOST_TASK_QUEUE_H
#define CC_HOST_TASK_QUEUE_H

#include <stddef.h>
#include <stdint.h>

#include "base.hpp"         // Runtime API
#include "common/enum_log.h"
#include "task_queue_abi.h" // 跨端 ABI：机密 Task Queue 下发契约

namespace cce {
namespace runtime {

// Host-side log names for enum TaskQueueStatus from task_queue_abi.h.
RT_ENUM_LOG_DECLARE(TaskQueueStatusToString, uint32_t)

class Device;

constexpr int32_t BAR_TASK_QUEUE_DEFAULT_TIMEOUT_MS = 30000;

rtError_t CreateBarTaskQueue(BarTaskQueue** queue, Device* device, uint32_t depth, uint32_t taskDescSize);

// 调用方须先收尾双侧终止信号。
rtError_t ResetBarTaskQueue(BarTaskQueue* queue);

bool IsBarTaskQueueTerminated(const BarTaskQueue* queue);

rtError_t FreeBarTaskQueue(BarTaskQueue* queue);

rtError_t IsBarTaskQueueFull(BarTaskQueue* queue, bool* isFull);

rtError_t IsBarTaskQueueEmpty(BarTaskQueue* queue, bool* isEmpty);

// SPSC：timeoutMs<0 无限等待，0 只尝试一次；终止后拒绝发布。
rtError_t PushBarTask(
    BarTaskQueue* queue, const void* taskDesc, size_t taskDescSize,
    int32_t timeoutMs = BAR_TASK_QUEUE_DEFAULT_TIMEOUT_MS);

rtError_t GetCompletedBarTaskNum(BarTaskQueue* queue, uint32_t* completedNum);

rtError_t GetBarTaskQueueDevAddr(BarTaskQueue* queue, uint64_t* devAddr);

} // namespace runtime
} // namespace cce

#endif // CC_HOST_TASK_QUEUE_H
