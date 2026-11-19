/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CC_AIVEC_TASK_QUEUE_H
#define CC_AIVEC_TASK_QUEUE_H

#include "kernel_operator_scalar_intf.h"     // ReadGmByPassDCache / WriteGmByPassDCache
#include "kernel_operator_sys_var_intf.h"    // GetSystemCycle
#include "kernel_operator_block_sync_intf.h" // SyncAll
#include "task_queue_abi.h"                  // 跨端 ABI：机密 Task Queue 下发契约

static constexpr int64_t POP_BAR_TASK_TIMEOUT = 60L * 1024L * 1024L * 1024L;
static constexpr int64_t POP_BAR_TASK_DELAY = 100L;

static inline __aicore__ bool IsBarTaskQueueTerminated(const __gm__ BarTaskQueue* const queue)
{
    uint32_t hostStatus = AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->hostStatus);
    uint32_t deviceStatus = AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->deviceStatus);
    return (hostStatus == (uint32_t)TaskQueueStatus::TASK_QUEUE_STATUS_TERMINATED) ||
           (deviceStatus == (uint32_t)TaskQueueStatus::TASK_QUEUE_STATUS_TERMINATED);
}

static inline __aicore__ void TerminateBarTaskQueue(__gm__ BarTaskQueue* const queue)
{
    AscendC::WriteGmByPassDCache(
        (__gm__ uint32_t*)&queue->deviceStatus, (uint32_t)TaskQueueStatus::TASK_QUEUE_STATUS_TERMINATED);
}

// 与 Pop 成对使用；仅 0 号核写 deviceStatus、tail 和 complete。
static inline __aicore__ bool UpdateBarTaskComplete(__gm__ BarTaskQueue* const queue)
{
    uint32_t depth = AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->depth);
    if (IsBarTaskQueueTerminated(queue) || depth == 0) {
        return false;
    }

    uint32_t complete = AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->complete) + 1;
    AscendC::WriteGmByPassDCache((__gm__ uint32_t*)&queue->complete, complete);

    AscendC::WriteGmByPassDCache(
        (__gm__ uint32_t*)&queue->deviceStatus, (uint32_t)TaskQueueStatus::TASK_QUEUE_STATUS_WAITING);

    uint32_t tail = (AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->tail) + 1) % depth;
    AscendC::WriteGmByPassDCache((__gm__ uint32_t*)&queue->tail, tail);
    return true;
}

// 所有核使用相同的发布/终止判据，避免片尾 barrier 参与者不一致。
static inline __aicore__ bool WaitBarTaskSlot(__gm__ BarTaskQueue* const queue, const uint32_t slot)
{
    int64_t startTime = AscendC::GetSystemCycle();
    for (;;) {
        if (IsBarTaskQueueTerminated(queue)) {
            return false;
        }
        const uint32_t depth = AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->depth);
        if (depth == 0U) {
            return false; // 控制头尚未初始化
        }
        if (AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->head) != (slot % depth)) {
            return true; // 该槽位已发布（head 已越过）
        }
        if (startTime + POP_BAR_TASK_TIMEOUT < AscendC::GetSystemCycle()) {
            return false; // 超时兜底
        }
        for (volatile int i = 0; i < POP_BAR_TASK_DELAY; i++) {
            ; // 空指令，用于延时，避免高频 ReadGmByPassDCache
        }
    }
}

// 仅 0 号核领取；其余核使用只读的 PeekBarTaskAt。
static inline __aicore__ __gm__ uint8_t* PopBarTaskAt(__gm__ BarTaskQueue* const queue, const uint32_t slot)
{
    if (!WaitBarTaskSlot(queue, slot)) {
        return nullptr;
    }
    const uint32_t depth = AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->depth);
    if (depth == 0U) {
        return nullptr;
    }
    const uint32_t taskDescSize = AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->taskDescSize);
    __gm__ uint8_t* const desc = queue->taskDescList + ((slot % depth) * taskDescSize);
    AscendC::WriteGmByPassDCache(
        (__gm__ uint32_t*)&queue->deviceStatus, (uint32_t)TaskQueueStatus::TASK_QUEUE_STATUS_WORKING);
    return desc;
}

static inline __aicore__ __gm__ uint8_t* PeekBarTaskAt(__gm__ BarTaskQueue* const queue, const uint32_t slot)
{
    if (!WaitBarTaskSlot(queue, slot)) {
        return nullptr;
    }
    const uint32_t depth = AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->depth);
    if (depth == 0U) {
        return nullptr;
    }
    const uint32_t taskDescSize = AscendC::ReadGmByPassDCache((__gm__ uint32_t*)&queue->taskDescSize);
    return queue->taskDescList + ((slot % depth) * taskDescSize);
}

#endif // CC_AIVEC_TASK_QUEUE_H
