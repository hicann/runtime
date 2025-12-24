/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_CTRL_RES_POOL_HPP__
#define __CCE_RUNTIME_CTRL_RES_POOL_HPP__

#include <mutex>
#include <map>
#include <cstdlib>
#include <cmath>
#include <atomic>
#include <unordered_map>
#include "base.hpp"
#include "osal.hpp"
#include "rw_lock.h"
#include "driver/ascend_hal.h"
#include "reference.hpp"
#include "stream.hpp"
#include "task_info.hpp"

#define CTRL_TASK_POOL_SIZE (1022U)
#define CTRL_TASK_INVALID  (0U)
#define CTRL_TASK_VALID  (1U)
#define CTRL_INVALID_TASK_ID (0xFFFFFFFFU)
#define CTRL_BUFF_ASSING_NUM (64U) // 64字节对其

namespace cce {
namespace runtime {
class Device;
class TaskFactory;

class CtrlTaskPoolEntry {
public:
    uint8_t *taskBuff_{nullptr};

    CtrlTaskPoolEntry();

    ~CtrlTaskPoolEntry();

    void Init(uint8_t * const ctrlTaskBuff, const uint32_t len);
    TaskInfo* Alloc(Stream * const stm, const uint32_t taskId, const tsTaskType_t taskType) const;
};

class CtrlResEntry {
private:
    uint32_t taskBuffCellSize_ = 0;
    uint8_t *taskBaseAddr_{nullptr};
    Device  *dev_{nullptr};
    CtrlTaskPoolEntry *taskPool_{nullptr};
    uint8_t *taskList_{nullptr};

    uint32_t resHeadIndex_ = 0; // Head is the alloc index
    uint32_t resTailIndex_ = 0; // Tail is the recycle index
    std::mutex headMutex_;
    std::mutex tailMutex_;

    uint32_t lastTaskId_ = 0;

public:
    CtrlResEntry(void);
    ~CtrlResEntry(void) noexcept;

    void AllocTaskId(uint32_t &taskId);
    void RecycleTask(const uint32_t taskId);
    rtError_t Init(Device * const dev);
    TaskInfo* GetTask(const uint32_t taskId) const;
    void TryTaskReclaim(Stream *const stm) const;

    TaskInfo *CreateTask(Stream *stream, tsTaskType_t taskType)
    {
        uint32_t countNum = 0U;
        uint32_t taskId = CTRL_INVALID_TASK_ID;
        while (1) {
            AllocTaskId(taskId);
            if (taskId != CTRL_INVALID_TASK_ID) {
                break;
            }

            TryTaskReclaim(stream);
            if (countNum > 2000000U) { // try 200w times
                return nullptr;
            }
            countNum++;
        }

        TaskInfo *task = taskPool_[taskId].Alloc(stream, taskId, taskType);
        RT_LOG(RT_LOG_INFO, "[ctrlsq]create ctrl resHeadIndex_=%u, resTailIndex_=%u, task task_id=%u. ",
            resHeadIndex_, resTailIndex_, taskId);

        if (task == nullptr) {
            RT_LOG(RT_LOG_ERROR, "Failed to init ctrl task.");
            return nullptr;
        }

        return task;
    }
};
}
}
#endif  // __CCE_RUNTIME_CTRL_RES_POOL_HPP__
