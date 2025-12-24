/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ctrl_res_pool.hpp"

#include <mutex>
#include <cstdlib>
#include <cmath>
#include <atomic>
#include <vector>
#include "base.hpp"
#include "osal.hpp"
#include "device.hpp"
#include "ctrl_stream.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {
CtrlTaskPoolEntry::CtrlTaskPoolEntry()
{
    return;
}

CtrlTaskPoolEntry::~CtrlTaskPoolEntry()
{
    taskBuff_ = nullptr;
    return;
}

void CtrlTaskPoolEntry::Init(uint8_t * const ctrlTaskBuff, const uint32_t len)
{
    taskBuff_ = ctrlTaskBuff;
    (void)memset_s(taskBuff_, static_cast<size_t>(len), 0, static_cast<size_t>(len));
    return;
}

CtrlResEntry::CtrlResEntry()
{
    return;
}

CtrlResEntry::~CtrlResEntry() noexcept
{
    RT_LOG(RT_LOG_INFO, "free ctrl stream pool.");
    DELETE_A(taskPool_);
    DELETE_A(taskList_);
    DELETE_A(taskBaseAddr_);
    dev_ = nullptr;
    return;
}

rtError_t CtrlResEntry::Init(Device* const dev)
{
    if (taskBaseAddr_ != nullptr) {
        RT_LOG(RT_LOG_WARNING, "re-init ctrl stream pool");
        return RT_ERROR_NONE;
    }

    dev_ = dev;
    resHeadIndex_ = 0U;
    resTailIndex_ = 0U;

    taskPool_ = new (std::nothrow) CtrlTaskPoolEntry[CTRL_TASK_POOL_SIZE];
    if (taskPool_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Init ctrl stream lite pool, new res fail! taskPool_ is nullptr.");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    taskList_ = new (std::nothrow) uint8_t[CTRL_TASK_POOL_SIZE];
    if (taskList_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Init ctrl stream lite pool, new res fail! taskList_ is nullptr.");
        DELETE_A(taskPool_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    taskBuffCellSize_ = TaskFactory::GetTaskMaxSize();
    if ((taskBuffCellSize_ & (CTRL_BUFF_ASSING_NUM - 1U)) > 0) {
        taskBuffCellSize_ += CTRL_BUFF_ASSING_NUM;
        taskBuffCellSize_ &= (~(CTRL_BUFF_ASSING_NUM - 1U));
    }

    const uint64_t buffSize = static_cast<uint64_t>(taskBuffCellSize_ * CTRL_TASK_POOL_SIZE);
    taskBaseAddr_ = new (std::nothrow) uint8_t[buffSize];
    if (taskBaseAddr_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Init ctrl stream lite pool fail! size=%u", buffSize);
        DELETE_A(taskPool_);
        DELETE_A(taskList_);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    RT_LOG(RT_LOG_DEBUG, "[ctrlSq]taskBaseAddr_=0x%x taskBuffCellSize_=%u.", taskBaseAddr_, taskBuffCellSize_);

    for (uint32_t i = 0U; i < CTRL_TASK_POOL_SIZE; i++) {
        taskPool_[i].Init((taskBaseAddr_ + i * taskBuffCellSize_), taskBuffCellSize_);
        taskList_[i] = CTRL_TASK_INVALID;
    }
    RT_LOG(RT_LOG_INFO, "[ctrlSq]CtrlResEntry is initialized.");
    return RT_ERROR_NONE;
}

void CtrlResEntry::AllocTaskId(uint32_t &taskId)
{
    headMutex_.lock();
    if ((resHeadIndex_ + 1U) % CTRL_TASK_POOL_SIZE == resTailIndex_) {
        taskId = CTRL_INVALID_TASK_ID;
        headMutex_.unlock();
        return;
    }

    // res pool max size is equal to taskid max size, so use resId instead of taskId
    lastTaskId_ = resHeadIndex_;
    resHeadIndex_ = ((resHeadIndex_ + 1U) % CTRL_TASK_POOL_SIZE);
    taskId = lastTaskId_;
    taskList_[taskId] = CTRL_TASK_VALID;

    headMutex_.unlock();
    return;
}

void CtrlResEntry::RecycleTask(const uint32_t taskId)
{
    if (taskId >= CTRL_TASK_POOL_SIZE) {
        return;
    }

    RT_LOG(RT_LOG_INFO, "[ctrlSq]recycle ctrl taskId=%u.", taskId);

    tailMutex_.lock();

    taskList_[taskId] = CTRL_TASK_INVALID;

    while ((taskList_[resTailIndex_] == CTRL_TASK_INVALID) && (resTailIndex_ != resHeadIndex_)) {
        resTailIndex_ = ((resTailIndex_ + 1U) % CTRL_TASK_POOL_SIZE);
    }

    tailMutex_.unlock();

    return;
}

TaskInfo* CtrlResEntry::GetTask(const uint32_t taskId) const
{
    if (taskId >= CTRL_TASK_POOL_SIZE) {
        return nullptr;
    }
    if (taskList_[taskId] == CTRL_TASK_INVALID) {
        return nullptr;
    }
    return RtPtrToPtr<TaskInfo *, uint8_t *>(taskPool_[taskId].taskBuff_);
}


void CtrlResEntry::TryTaskReclaim(Stream *const stm) const
{
    stm->StreamSyncLock();
    (void)stm->Device_()->CtrlTaskReclaim(dynamic_cast<CtrlStream* const>(stm));
    stm->StreamSyncUnLock();
}

TaskInfo* CtrlTaskPoolEntry::Alloc(Stream * const stm, const uint32_t taskId, const tsTaskType_t taskType) const
{
    TaskInfo *tskInfo = RtPtrToPtr<TaskInfo *, uint8_t *>(taskBuff_);
    (void)memset_s(tskInfo, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    tskInfo->type = taskType;
    InitByStream(tskInfo, stm);
    tskInfo->id = static_cast<uint16_t>(taskId);

    return tskInfo;
}

}
}