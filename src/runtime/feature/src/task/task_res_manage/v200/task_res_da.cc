/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "error_message_manage.hpp"
#include "arg_loader.hpp"
#include "task_res_da.hpp"

#define TASK_NUM_FOR_HEAD_UPDATE (64U)
namespace cce {
namespace runtime {

TaskResManageDavid::TaskResManageDavid():TaskResManage()
{
}

TaskResManageDavid::~TaskResManageDavid()
{
}

bool TaskResManageDavid::CreateTaskRes(Stream* stm)
{
    const uint32_t taskPoolSize = taskPoolNum_ * sizeof(TaskRes);
    CreateTaskResBaseAddr(taskPoolSize);
    COND_RETURN_WARN((GetTaskResBaseAddr() == nullptr), false, "no memory for taskRes,"
        "taskResSize=%u, taskPoolNum_=%u.", sizeof(TaskRes), taskPoolNum_);

    streamId_ = stm->Id_();
    deviceId_ = stm->Device_()->Id_();
    taskRes_ = RtPtrToPtr<TaskRes *>(GetTaskResBaseAddr());
    RT_LOG(RT_LOG_DEBUG, "TaskInfo Buffer alloc success.");
    return true;
}

bool TaskResManageDavid::IsRecyclePosValid(uint16_t recyclePos) const
{
    uint16_t head = taskResAHead_.Value();
    uint16_t tail = taskResATail_.Value();
    const bool flag1 = (head <= tail) && (!((recyclePos >= head) && (recyclePos <= tail)));
    const bool flag2 = (head > tail) && ((recyclePos > tail) && (recyclePos < head));
    if (unlikely(flag1 || flag2)) {
        RT_LOG(RT_LOG_WARNING, "recyclePos is invalid, sqHead=%hu, taskResHead=%hu, taskResTail=%hu.",
            recyclePos, head, tail);
        return false;
    }
    return true;
}
TaskInfo* TaskResManageDavid::GetTaskInfo(uint32_t taskId) const
{
    if (unlikely(taskId >= taskPoolNum_)) {
        RT_LOG(RT_LOG_WARNING, "taskId is invalid, device_id=%u, stream_id=%d, taskId=%u",
            deviceId_, streamId_, taskId);
        return nullptr;
    }

    const uint16_t head = taskResAHead_.Value();
    const uint16_t tail = taskResATail_.Value();
    if (unlikely(head == tail)) {
        RT_LOG(RT_LOG_WARNING, "head==tail, device_id=%u, stream_id=%d, taskId=%u, head=%hu, tail=%hu, "
            "taskResAHead=%hu, taskResATail=%hu, taskInfo_id=%hu.",
            deviceId_, streamId_,  taskId, head, tail, taskResAHead_.Value(), taskResATail_.Value(),
            taskRes_[taskId].taskInfo.id);
        return nullptr;
    }

    RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, taskId=%u, "
        "head=%hu, tail=%hu, taskResAHead=%hu, taskResATail=%hu, taskInfo_id=%hu.",
        deviceId_, streamId_, taskId, head, tail, taskResAHead_.Value(), taskResATail_.Value(),
        taskRes_[taskId].taskInfo.id);
    if (unlikely(taskRes_[taskId].taskInfo.id == 0xFFFFU)) {
        RT_LOG(RT_LOG_WARNING, "taskId is recycled, device_id=%u, stream_id=%d, taskId=%u, "
            "head=%hu, tail=%hu, taskResAHead=%hu, taskResATail=%hu, taskInfo_id=%hu.",
            deviceId_, streamId_, taskId, head, tail, taskResAHead_.Value(), taskResATail_.Value(),
            taskRes_[taskId].taskInfo.id);
        return nullptr;
    }
    const bool flip = (head < tail) ? false : true;
    bool flag1 = (!flip) && (!((taskId >= head) && (taskId < tail)));
    bool flag2 = flip && ((taskId >= tail) && (taskId < head));
    if (flag1 || flag2) {
        RT_LOG(RT_LOG_WARNING, "taskId is invalid, device_id=%u, stream_id=%d, taskId=%u, "
            "head=%hu, tail=%hu, taskResAHead=%hu, taskResATail=%hu, taskInfo_id=%hu.",
            deviceId_, streamId_, taskId, head, tail, taskResAHead_.Value(), taskResATail_.Value(),
            taskRes_[taskId].taskInfo.id);
        return nullptr;
    }

    // In a multi-task scenario, regardless of whether taskId represents a position (pos) or an actual task ID,
    // the obtained realPos is always the position corresponding to the actual taskInfo.
    const uint32_t realPos = taskRes_[taskId].taskInfo.id;
    if (taskId != realPos) {
        flag1 = (!flip) && (!((realPos >= head) && (realPos < tail)));
        flag2 = flip && ((realPos >= tail) && (realPos < head));
        if (flag1 || flag2) {
            RT_LOG(RT_LOG_WARNING, "realPos is invalid, device_id=%u, stream_id=%d, taskId=%u, realPos=%u, "
                "head=%hu, tail=%hu, taskResAHead=%hu, taskResATail=%hu, taskInfo_id=%hu.",
                deviceId_, streamId_, taskId, realPos, head, tail, taskResAHead_.Value(), taskResATail_.Value(),
                taskRes_[taskId].taskInfo.id);
            return nullptr;
        }
    }

    return &taskRes_[realPos].taskInfo;
}

rtError_t TaskResManageDavid::AllocTaskInfoAndPos(uint32_t sqeNum, uint32_t &pos, TaskInfo **task, bool needLog)
{
    if (sqeNum > SQE_NUM_PER_DAVID_TASK_MAX) {
        RT_LOG(RT_LOG_ERROR, "sqeNum is invalid, sqeNum=%u, maxSqeNum=%u.", sqeNum, SQE_NUM_PER_DAVID_TASK_MAX);
        return RT_ERROR_INVALID_VALUE;
    }

    const uint16_t head = taskResAHead_.Value();
    uint16_t tail = taskResATail_.Value();
    const uint32_t taskDesTailIdx = (tail + sqeNum) % taskPoolNum_;
    if (((tail < head) && ((tail + sqeNum) >= head)) ||
        ((tail > head) && ((tail + sqeNum) >= taskPoolNum_) && (taskDesTailIdx >= head))) {
        if (needLog) {
            RT_LOG(RT_LOG_DEBUG, "taskRes Queue full, head=%hu, tail=%hu, sqeNum=%u.", head, tail, sqeNum);
        }
        return RT_ERROR_TASKRES_QUEUE_FULL;
    }

    pos = tail;
    *task = &taskRes_[pos].taskInfo;
    (void)memset_s(*task, sizeof(TaskInfo), 0, sizeof(TaskInfo));

    while (tail != taskDesTailIdx) {
        taskRes_[tail].taskInfo.id = pos;
        tail = (tail + 1U) % taskPoolNum_;
    }
    
    taskResATail_.Set(tail);
    allocNum_++;

    RT_LOG(RT_LOG_INFO, "alloc taskinfo success, device_id=%u, stream_id=%u, pos=%u, sqeNum=%u, head=%u, "
        "taskResATail=%u, allocNum=%llu.", deviceId_, streamId_, pos, sqeNum, head,
        taskResATail_.Value(), allocNum_);
    return RT_ERROR_NONE;
}

bool TaskResManageDavid::RecycleTaskInfo(uint32_t pos, uint32_t sqeNum)
{
    const uint16_t tail = taskResATail_.Value();
    const uint16_t headBeforeRecycle = taskResAHead_.Value();
    if (unlikely((pos >= taskPoolNum_) || (tail == headBeforeRecycle))) {
        RT_LOG(RT_LOG_WARNING, "input is invalid, device_id=%u, stream_id=%u, pos=%u, sqeNum=%u, "
            "taskResAHead=%u, taskResATail=%u.", deviceId_, streamId_, pos, sqeNum, headBeforeRecycle, tail);
        return false;
    }

    const uint32_t taskDesHeadIdx = (pos + sqeNum) % taskPoolNum_;
    const bool flag1 = (headBeforeRecycle < tail) && (!((taskDesHeadIdx >= headBeforeRecycle) && (taskDesHeadIdx <= tail)));
    const bool flag2 = (headBeforeRecycle > tail) && ((taskDesHeadIdx > tail) && (taskDesHeadIdx < headBeforeRecycle));
    if (unlikely(flag1 || flag2)) {
        RT_LOG(RT_LOG_WARNING, "taskDesHeadIdx is invalid, device_id=%u, stream_id=%u, pos=%u, sqeNum=%u,"
            "taskDesHeadIdx=%u, headBeforeRecycle=%u, taskResATail=%u.",
            deviceId_, streamId_, pos, sqeNum, taskDesHeadIdx, headBeforeRecycle, tail);
        return false;
    }
    
    uint16_t head = headBeforeRecycle;
    // Temporarily used for dfx，using taskResHead_ = taskDesHeadIdx later
    while (head != taskDesHeadIdx) {
        taskRes_[head].taskInfo.id = UINT16_MAX;
        taskRes_[head].taskInfo.stmArgPos = UINT32_MAX;
        head = (head + 1U) % taskPoolNum_;
    }
    taskResAHead_.Set(head);

    RT_LOG(RT_LOG_INFO, "recycle taskinfo success, pos=%u, sqeNum=%u, headBeforeRecycle=%hu, taskResAHead=%hu, "
        "tail=%hu, stream_id=%u.", pos, sqeNum, headBeforeRecycle, taskResAHead_.Value(), tail, streamId_);
    return true;
}

void TaskResManageDavid::GetHeadTail(uint16_t &head, uint16_t &tail) const
{
    head = taskResAHead_.Value();
    tail = taskResATail_.Value();
}

// only used for errors after AllocTaskInfoAndPos in StreamLock domain
void TaskResManageDavid::RollbackTail(uint16_t pos)
{
    taskResATail_.Set(pos);
    allocNum_ = allocNum_ >= 1U ? (allocNum_ - 1U) : 0U;
}

uint16_t TaskResManageDavid::GetPendingNum()
{
    return (taskResATail_.Value() + taskPoolNum_ - taskResAHead_.Value()) % taskPoolNum_;
}

void TaskResManageDavid::ResetTaskRes()
{
    taskResAHead_.Set(0);
    taskResATail_.Set(0);
    allocNum_ = 0U;
}
}  // namespace runtime
}  // namespace cce
