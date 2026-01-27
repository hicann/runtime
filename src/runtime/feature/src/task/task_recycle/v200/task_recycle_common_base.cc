/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_david.hpp"
#include "stream_sqcq_manage.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "fwk_adpt_struct.h"
#include "rt_stars_define.h"
#include "context.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "device/device_error_proc.hpp"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "context.hpp"
#include "tsch_defines.h"
#include "profiler.hpp"
#include "stars.hpp"
#include "stars_david.hpp"
#include "hwts.hpp"
#include "device.hpp"
#include "davinci_kernel_task.h"
#include "event_task.h"
#include "task_info.h"
#include "task_recycle.hpp"
#include "engine.hpp"
#include "task_res_da.hpp"
#include "stream.hpp"
#include "stream_david.hpp"

namespace cce {
namespace runtime {

// =================================================== static 函数区 ======================================== //
constexpr uint16_t TASK_RECLAIM_MAX_NUM = 64U;     // Max reclaim num per query.
static void GetRecycleHead(const uint16_t taskHead, const uint16_t sqHead, uint32_t const rtsqDepth, uint16_t &recycleHead)
{
    if (sqHead >= taskHead) {
        if ((TASK_ID_SUB(sqHead, taskHead)) > TASK_RECLAIM_MAX_NUM) {
            recycleHead = TASK_ID_ADD(taskHead, static_cast<uint16_t>(TASK_RECLAIM_MAX_NUM));
        }
    } else {
        // flip occurs
        const uint16_t needRecycleTask = rtsqDepth - taskHead + sqHead;
        if (needRecycleTask > TASK_RECLAIM_MAX_NUM) {
            recycleHead = (taskHead + TASK_RECLAIM_MAX_NUM) % rtsqDepth;
        }
    }
}

bool GetPublicTask(Stream * const stm, const uint16_t endTaskSqPos, uint16_t &delPos,
    TaskInfo **workTask, bool &earlyBreakFlag)
{
    rtError_t error = RT_ERROR_NONE;
    const uint32_t streamId = stm->Id_();
    error = stm->StarsGetPublicTaskHead(nullptr, false, endTaskSqPos, &delPos);
    if (error != RT_ERROR_NONE) {
        // 当异常只有：1、空队列  2、已经取到最大值时，都是正常情况，不需要做异常处理
        RT_LOG(RT_LOG_INFO, "public task proc down, stream_id=%u, endTaskSqPos=%hu, delPos=%hu, retCode=%#x.",
            streamId, endTaskSqPos, delPos, error);
        if (error == RT_ERROR_INVALID_VALUE) {
            earlyBreakFlag = true;
        }
        return true;
    }
    TaskInfo *delWorkTask =
        (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskInfo(static_cast<uint32_t>(delPos));
    if (unlikely(delWorkTask == nullptr)) {
        // maybe random order occurred
        RT_LOG(RT_LOG_ERROR, "workTask is not valid, stream_id=%u, isHasArgPool_=%d, delPos=%u, endTaskSqPos=%hu.",
            streamId, static_cast<DavidStream *>(stm)->GetIsHasArgPool(),  static_cast<uint32_t>(delPos), endTaskSqPos);
        // 先不更新public  break 之后，这个任务就再也无法回收，后面会卡住，便于定位
        earlyBreakFlag = true;
        return true;
    }

    // check task is can be recycled
    if ((delWorkTask->isCqeNeedConcern == 1) &&
        unlikely((stm->GetFailureMode() != ABORT_ON_FAILURE) && (!stm->isForceRecycle_))) {
        RT_LOG(RT_LOG_DEBUG, "Task delay recycle until CQE received, stream_id=%d, task_id=%hu.", stm->Id_(),
               delWorkTask->id);
        stm->SetNeedRecvCqeFlag(true);
        earlyBreakFlag = true;
        return true;
    }
    error = stm->DavidUpdatePublicQueue();
    if (unlikely(error != RT_ERROR_NONE)) {
        RT_LOG(RT_LOG_WARNING, "Delete public member failed, stream_id=%u, endTaskSqPos=%hu, delPos=%hu, retCode=%#x.",
            streamId, endTaskSqPos, delPos, error);
        earlyBreakFlag = true;
        return true;
    }
    *workTask = delWorkTask;
    return false;
}

static void TrigerAsyncRecycle(Stream * const stm)
{
    /* no task need recycle */
    if (stm->GetRecycleEndTaskId() == MAX_UINT16_NUM) {
        return;
    }
    stm->Device_()->WakeUpRecycleThread();
    return;
}

// only proc non model task
void TryReclaimToTaskForDvppGrp(TaskInfo *workTask)
{
    Stream * const stm = workTask->stream;
    const uint16_t endTaskSqPos = workTask->id;
    uint16_t delPos = 0U;
    TaskInfo *delWorkTask = nullptr;
    bool earlyBreakFlag = false;
    bool argsAsyncTriggerFlag = false;
    do {
        const bool breakFlag = GetPublicTask(stm, endTaskSqPos, delPos, &delWorkTask, earlyBreakFlag);
        if (breakFlag) {
            break;
        }

        // 支持PCIEBAR > 4k的args  和 不支持PCIEBAR的所有args  归一处理,pub中davinci args 放入argshandlelist
        const bool checkTaskType = (stm->IsDavinciTask(delWorkTask) || stm->IsFusionKernelTask(delWorkTask));
        if ((checkTaskType) && (stm->AddArgToRecycleList(delWorkTask))) {
            argsAsyncTriggerFlag = true;
        }

        // docomplete + taskRes等资源的回收  非davinci的其他需要回收的任务，在此回收处理
        TaskUnInitProc(delWorkTask);
    } while (delPos != endTaskSqPos);
    
    // batch recycle
    if (!earlyBreakFlag) {
        delWorkTask = workTask;
    }
    
    if (delWorkTask != nullptr) {
        stm->SetRecycleEndTaskId(delWorkTask->id);
        DavidStream *davidStm = static_cast<DavidStream *>(stm);
        if (davidStm->GetIsHasArgPool()) {
            davidStm->ArgReleaseStmPool(delWorkTask);
        }
        (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->RecycleTaskInfo(static_cast<uint32_t>(delWorkTask->id),
            delWorkTask->sqeNum);
    }

    if (argsAsyncTriggerFlag) {
        TrigerAsyncRecycle(stm);
    }
    RT_LOG(RT_LOG_DEBUG, "stream_id=%d, delPos=%hu.", stm->Id_(), delPos);
    return;
}

// =================================================== static 函数区 ======================================== //

// ================================================== 对外出口区 ======================================== //
void TryReclaimToTask(TaskInfo *workTask)
{
    Stream * const stm = workTask->stream;
    const uint16_t endTaskSqPos = workTask->id;
    uint16_t delPos = 0U;
    TaskInfo *delWorkTask = nullptr;
    bool earlyBreakFlag = false;
    do {
        const bool breakFlag = GetPublicTask(stm, endTaskSqPos, delPos, &delWorkTask, earlyBreakFlag);
        if (breakFlag) {
            break;
        }

        if (stm->GetArgHandle() != nullptr) {
            static_cast<DavidStream *>(stm)->ArgManagePtr()->RecycleDevLoader(stm->GetArgHandle());
            stm->SetArgHandle(nullptr);
        }

        // docomplete + taskRes等资源的回收  非davinci的其他需要回收的任务，在此回收处理
        TaskUnInitProc(delWorkTask);
        stm->latestConcernedTaskId.CompareExchange(delWorkTask->id, MAX_UINT16_NUM);
    } while (delPos != endTaskSqPos);

    // batch recycle
    if (!earlyBreakFlag) {
        delWorkTask = workTask;
    }
    
    if (delWorkTask != nullptr) {
        stm->SetRecycleEndTaskId(delWorkTask->id);
        DavidStream *davidStm = static_cast<DavidStream *>(stm);
        if (davidStm->GetIsHasArgPool()) {
            davidStm->ArgReleaseStmPool(delWorkTask);
        }
        (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->RecycleTaskInfo(static_cast<uint32_t>(delWorkTask->id),
            delWorkTask->sqeNum);
    }

    RT_LOG(RT_LOG_DEBUG, "finish stream_id=%d, delPos=%hu.", stm->Id_(), delPos);
    return;
}

rtError_t AdjustRecycleTaskID(const Stream * const stm, const uint32_t endTaskId, const uint16_t recyclePos)
{
    COND_RETURN_ERROR(stm->taskResMang_ == nullptr, RT_ERROR_INVALID_VALUE, "taskResMang_ of stm is nullptr");

    const uint32_t rtsqDepth = Runtime::macroValue_.rtsqDepth;
    const uint16_t nextPos = ((recyclePos + 1) % rtsqDepth);
    bool taskIsFinished = true;
    uint16_t nextTaskId = 0;
    TaskResManageDavid *taskResMang = dynamic_cast<TaskResManageDavid *>(stm->taskResMang_);
    if (taskResMang->GetTaskPosTail() != nextPos) {
        TaskInfo *curentTaskInfo = taskResMang->GetTaskInfo(recyclePos);
        if ((curentTaskInfo != nullptr) && (curentTaskInfo->type == TS_TASK_TYPE_MEM_WAIT_VALUE)) {
            TaskInfo *nextTaskInfo = taskResMang->GetTaskInfo(nextPos);
            if ((nextTaskInfo != nullptr)) {
                nextTaskId = nextTaskInfo->id;
                if (nextTaskId == endTaskId) {
                    taskIsFinished = false;
                }
            }
        }
    }
    COND_RETURN_INFO(taskIsFinished == false,
        RT_ERROR_INVALID_VALUE, "stream_id=%d, endTaskId=%u, recyclePos=%u nextTaskId=%u",
        stm->Id_(), endTaskId, recyclePos, nextTaskId);

    return RT_ERROR_NONE;
}

/**
 * curPos: Pos of the taskRes Head, which to be reclaimed.
 * tarPos: Pos of the rtsq Head, which to be reclaimed.
 * finishPos: return the pos of the taskRes actually reclaimed.
*/
rtError_t FinishedTaskReclaim(const Stream * const stm, const bool limited, const uint16_t curPos,
    const uint16_t tarPos)
{
    const rtError_t ret = RT_ERROR_NONE;
    if (curPos == tarPos) {     // no new task.
        return ret;
    }

    uint16_t recycleHead = tarPos;
    if (limited) {
        GetRecycleHead(curPos, tarPos, stm->GetSqDepth(), recycleHead);
    }

    const uint32_t pos = (recycleHead == 0U) ? (stm->GetSqDepth() - 1U) : (recycleHead - 1U);
    TaskInfo * const workTask = (dynamic_cast<TaskResManageDavid *>(stm->taskResMang_))->GetTaskInfo(pos);
    if (workTask == nullptr) {  // Released already.
        RT_LOG(RT_LOG_WARNING, "Get null task from stream_id=%u, pos=%u.", stm->Id_(), pos);
        return ret;
    }

    const tsTaskType_t taskType = workTask->type;
    if ((taskType == TS_TASK_TYPE_MULTIPLE_TASK) && (!(CheckPackageState(workTask)))) {     // no new task.
        RT_LOG(RT_LOG_DEBUG, "multiple task recvpkg has not enough, cannot recycle");
        return ret;
    }

    if (stm->Id_() != workTask->stream->Id_()) {
        RT_LOG(RT_LOG_WARNING, "stream id:%d and task stream id: %d not equal.",
            stm->Id_(), workTask->stream->Id_());
    }
    COND_PROC((AdjustRecycleTaskID(stm, workTask->id, pos) != RT_ERROR_NONE), return RT_ERROR_NONE;);
    if (const_cast<Stream *>(stm)->IsSeparateSendAndRecycle()) {
        TryReclaimToTask(workTask);
    } else {
        TryReclaimToTaskForDvppGrp(workTask);
    }

    RT_LOG(RT_LOG_DEBUG, "recycle task, stream_id=%d, limited=%d, curPos=%hu, tarPos=%hu, recycleHead=%hu,"
        " task_type=%u(%s).", stm->Id_(), limited, curPos, tarPos, recycleHead,
        static_cast<uint32_t>(taskType), workTask->typeName);
    return ret;
}

TaskInfo* GetTaskInfo(const Device * const dev, uint32_t streamId, uint32_t pos)
{
    TaskInfo *reportTask = nullptr;
    Stream *recycleStm = nullptr;
    (void)dev->GetStreamSqCqManage()->GetStreamById(streamId, &recycleStm);
    if ((recycleStm != nullptr) && (recycleStm->taskResMang_ != nullptr)) {
        reportTask = (dynamic_cast<TaskResManageDavid *>(recycleStm->taskResMang_))->GetTaskInfo(pos);
    }
    return reportTask;
}

rtError_t GetDrvSqHead(const Stream * const stm, uint16_t &sqHead, bool needLog)
{
    Device * const dev = stm->Device_();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t tsId = dev->DevGetTsId();
    const rtError_t error = dev->Driver_()->GetSqHead(dev->Id_(), tsId, sqId, sqHead, needLog);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x.",
        static_cast<uint32_t>(error));
    TaskResManageDavid *taskManager = dynamic_cast<TaskResManageDavid *>(stm->taskResMang_);
    COND_RETURN_ERROR_MSG_INNER(taskManager == nullptr, RT_ERROR_STREAM_INVALID, 
        "stream_id=%d does not have task manager", stm->Id_());

    const bool valid = taskManager->IsRecyclePosValid(sqHead);
    if (!valid) {
        RT_LOG(RT_LOG_WARNING, "drv sqHead is invalid, deviceId=%u, sqId=%u, sqHead=%hu.",
            dev->Id_(), sqId, sqHead);
        return RT_ERROR_DRV_ERR;
    }
    return RT_ERROR_NONE;
}

// ================================================== 对外出口区 ======================================== //
}  // namespace runtime
}  // namespace cce