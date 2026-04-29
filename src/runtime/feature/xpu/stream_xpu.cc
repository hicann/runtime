/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <thread>
#include "stream_xpu.hpp"
#include "stream_sqcq_manage_xpu.hpp"
#include "xpu_device.hpp"
#include "arg_manage_xpu.hpp"
#include "base.hpp"
#include "error_message_manage.hpp"
#include "tprt_type.h"
#include "task_res_da.hpp"
#include "xpu_context.hpp"
#include "thread_local_container.hpp"
#include "task_xpu_recycle.hpp"
#include "runtime_handle_guard.h"

namespace cce {
namespace runtime {

XpuStream::XpuStream(Device *const dev, const uint32_t stmFlags)
    : Stream(dev, RT_STREAM_PRIORITY_DEFAULT, stmFlags, nullptr)
{
    SetLastTaskId(MAX_UINT32_NUM);
}

XpuStream::~XpuStream()
{
    XpuFreeStreamId();

    XpuReleaseStreamArgRes();

    SetContext(nullptr);

    ReleaseStreamTaskRes();
    device_ = nullptr;
}

void XpuStream::XpuReleaseStreamArgRes()
{
    isHasArgPool_ = false;
    if (argManage_ != nullptr) {
        argManage_->ReleaseArgRes();
        DELETE_O(argManage_);
    }
}

void XpuStream::XpuFreeStreamId() const
{
    rtError_t error = static_cast<XpuStreamSqCqManage *>(Device_()->GetStreamSqCqManage())
                          ->DeAllocXpuStreamSqCq(Device_()->Id_(), streamId_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "del stream fail, stream_id=%d", streamId_);
    }
    static_cast<XpuDevice *>(Device_())->FreeStreamIdBitmap(streamId_);
}

rtError_t XpuStream::Setup(void)
{
    XpuDevice *xpuDevice = static_cast<XpuDevice *>(Device_());
    streamId_ = xpuDevice->AllocStreamId(); 
    COND_RETURN_AND_MSG_INNER(streamId_ == -1, RT_ERROR_DRV_NO_STREAM_RESOURCES,
        "Failed to allocate stream ID. No available stream resources.");
    sqId_ = static_cast<uint32_t>(streamId_);
    cqId_ = static_cast<uint32_t>(streamId_);

    taskPublicBuffSize_ = xpuDevice->GetXpuStreamDepth();
    taskPublicBuff_ = new (std::nothrow) uint32_t[taskPublicBuffSize_];
    COND_RETURN_AND_MSG_OUTER(taskPublicBuff_ == nullptr, RT_ERROR_STREAM_NEW, ErrorCode::EE1013,
        std::to_string(sizeof(uint32_t) * taskPublicBuffSize_));

    rtError_t error = CreateStreamTaskRes();
    COND_RETURN_AND_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_STREAM_NEW,
        "Failed to create or initialize task resource manager, stream_id=%d.", streamId_);
    error = CreateStreamArgRes();
    COND_RETURN_AND_MSG_INNER(
        error != RT_ERROR_NONE, error, "Failed to create arg resource, stream_id=%d.", streamId_);
    SetFailureMode(STOP_ON_FAILURE);

    XpuStreamSqCqManage *stmSqCqManage = static_cast<XpuStreamSqCqManage *>(Device_()->GetStreamSqCqManage());
    stmSqCqManage->SetStreamIdToStream(static_cast<uint32_t>(streamId_), this); 
    RT_LOG(RT_LOG_DEBUG, "Alloc stream, stream_id=%d", streamId_);
    error = stmSqCqManage->AllocXpuStreamSqCq(this);
    COND_RETURN_AND_MSG_INNER(error != RT_ERROR_NONE, error,
        "Failed to allocate SQ/CQ resources, stream_id=%d, retCode=%#x.", streamId_, static_cast<uint32_t>(error));
    InitEmbeddedInnerHandle<Stream>(this);
    return RT_ERROR_NONE;
}

rtError_t XpuStream::AddTaskToList(const TaskInfo *const tsk)
{
    if (tsk->needPostProc == true) {
        const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
        const uint32_t tail = (publicQueueTail_ + 1U) % taskPublicBuffSize_;
        if (unlikely(publicQueueHead_ == tail)) {
            RT_LOG(RT_LOG_WARNING,
                "task public buff full, stream_id=%d, task_id=%hu, head=%u, tail=%u",
                streamId_, tsk->id, publicQueueHead_, publicQueueTail_);
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1019,
                "stream task public buffer is full");
            return RT_ERROR_STREAM_FULL;
        }
        taskPublicBuff_[publicQueueTail_ % taskPublicBuffSize_] = tsk->id;
        publicQueueTail_ = tail;
        RT_LOG(RT_LOG_INFO,
            "public task, stream_id=%d, task_id=%hu, task_type=%d (%s), head=%u, "
            "tail=%u",
            streamId_,
            tsk->id,
            static_cast<int32_t>(tsk->type),
            tsk->typeName,
            publicQueueHead_,
            publicQueueTail_);
    }

    return RT_ERROR_NONE;
}

rtError_t XpuStream::StarsAddTaskToStream(TaskInfo *const tsk, const uint32_t sendSqeNum)
{
    COND_RETURN_AND_MSG_INNER(tsk == nullptr, RT_ERROR_TASK_NULL,
        "Task info is null, stream_id=%d.", streamId_);
    const rtError_t ret = AddTaskToList(tsk);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    RT_LOG(RT_LOG_INFO,
        "single-operator stream, stream_id=%d, task_id=%hu, task_sn=%u, type=%d(%s), "
        "sqe_num=%u, device_id=%u",
        streamId_,
        tsk->id,
        tsk->taskSn,
        static_cast<int32_t>(tsk->type),
        tsk->typeName,
        sendSqeNum,
        tsk->stream->Device_()->Id_());
    SetLastTaskId(tsk->taskSn);
    return RT_ERROR_NONE;
}

uint32_t XpuStream::GetCurSqPos() const
{
    TaskResManageDavid *taskRes = RtPtrToPtr<TaskResManageDavid *>(taskResMang_);
    return static_cast<uint32_t>(taskRes->GetTaskPosTail());
}

rtError_t XpuStream::StarsGetPublicTaskHead(
    TaskInfo *workTask, const bool isTaskBind, const uint16_t tailTaskId, uint16_t *const delTaskId)
{
    (void)workTask;
    (void)isTaskBind;
    COND_RETURN_AND_MSG_INNER(delTaskId == nullptr, RT_ERROR_TASK_NULL,
        "delTaskId is null, stream_id=%d.", streamId_);
    NULL_PTR_RETURN_MSG_OUTER(taskResMang_, RT_ERROR_INVALID_VALUE);
    TaskResManageDavid *taskRes = RtPtrToPtr<TaskResManageDavid *>(taskResMang_);
    const uint32_t taskResTail = taskRes->GetTaskPosTail();
    const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
    if (publicQueueHead_ != publicQueueTail_) {
        const uint32_t fixTaskPos = taskPublicBuff_[publicQueueHead_];
        const uint16_t relTaskPos = static_cast<uint16_t>(fixTaskPos & 0xFFFFU);
        if (tailTaskId < taskResTail) {
            if (tailTaskId >= relTaskPos || relTaskPos > taskResTail) {
                *delTaskId = relTaskPos;
                return RT_ERROR_NONE;
            }
            RT_LOG(RT_LOG_DEBUG,
                "relTask is not executed in scenario 1, stream_id=%d, tailTaskId=%u, relTaskPos=%u, "
                "publicHead=%u, publicTail=%u, taskResTail=%u.",
                streamId_, tailTaskId, relTaskPos, publicQueueHead_, publicQueueTail_, taskResTail);
            return RT_ERROR_STREAM_INVALID;
        } else if (tailTaskId > taskResTail) {
            if (relTaskPos <= tailTaskId && relTaskPos > taskResTail) {
                *delTaskId = relTaskPos;
                return RT_ERROR_NONE;
            }
            RT_LOG(RT_LOG_DEBUG,
                "relTask is not executed in scenario 2, stream_id=%d, tailTaskId=%u, relTaskPos=%u, "
                "publicHead=%u, publicTail=%u, taskResTail=%u.",
                streamId_, tailTaskId, relTaskPos, publicQueueHead_, publicQueueTail_, taskResTail);
            return RT_ERROR_STREAM_INVALID;
        } else {
            // no operation
        }

        RT_LOG(RT_LOG_ERROR,
            "tailTaskId[%u] == taskResTail[%u] is invalid, stream_id=%d, publicHead=%u, publicTail=%u, "
            "taskResTail=%u.", tailTaskId, taskResTail, streamId_, publicQueueHead_, publicQueueTail_, taskResTail);
        return RT_ERROR_INVALID_VALUE;
    } else {
        // no operation
    }
    RT_LOG(RT_LOG_DEBUG,
        "public task list null, stream_id=%d, tailTaskId=%u, publicHead=%u, publicTail=%u, taskResTail=%u",
        streamId_, static_cast<uint32_t>(tailTaskId), publicQueueHead_, publicQueueTail_, taskResTail);
    return RT_ERROR_STREAM_EMPTY;
}

rtError_t XpuStream::DavidUpdatePublicQueue()
{
    const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
    if (publicQueueHead_ != publicQueueTail_) {
        const uint32_t fixTaskPos = taskPublicBuff_[publicQueueHead_];
        const uint16_t relTaskPos = static_cast<uint16_t>(fixTaskPos & 0xFFFFU);
        publicQueueHead_ = ((publicQueueHead_ + 1U) % taskPublicBuffSize_);
        finishTaskId_ = relTaskPos;
        RT_LOG(RT_LOG_DEBUG,
            "public task list update, stream_id=%d, finishTaskId_=%u, head=%u, tail=%u",
            streamId_,
            finishTaskId_,
            publicQueueHead_,
            publicQueueTail_);
        return RT_ERROR_NONE;
    } else {
        RT_LOG(RT_LOG_DEBUG,
            "public task list null, stream_id=%d, head=%u, tail=%u",
            streamId_,
            publicQueueHead_,
            publicQueueTail_);
        return RT_ERROR_STREAM_EMPTY;
    }
}

bool XpuStream::IsExistCqe(void) const
{
    bool status = false;
    const uint32_t sqId = GetSqId();
    const uint32_t tsId = Device_()->DevGetTsId();

    rtError_t error = Device_()->Driver_()->GetCqeStatus(Device_()->Id_(), tsId, sqId, status);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "sq_id=%u get cqe status failed, retCode=%#x.", sqId, error);
    }
    return status;
}

rtError_t XpuStream::CreateStreamTaskRes()
{
    taskResMang_ = new (std::nothrow) TaskResManageDavid();
    COND_RETURN_AND_MSG_OUTER(taskResMang_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        sizeof(TaskResManageDavid));
    uint32_t rtsqDepth = (RtPtrToPtr<XpuDevice *>(Device_()))->GetXpuStreamDepth();
    taskResMang_->taskPoolNum_ = static_cast<uint16_t>(rtsqDepth);
    SetSqDepth(rtsqDepth);
    const bool isSuccess = taskResMang_->CreateTaskRes(this);
    if (!isSuccess) {
        RT_LOG(RT_LOG_ERROR, "Failed to create task resource, stream_id=%d.", streamId_);
        return RT_ERROR_STREAM_NEW;
    }
    taskResMang_->streamId_ = streamId_;
    return RT_ERROR_NONE;
}

rtError_t XpuStream::CreateStreamArgRes()
{
    argManage_ = new (std::nothrow) XpuArgManage(this);
    COND_RETURN_AND_MSG_OUTER(argManage_ == nullptr, RT_ERROR_CALLOC, ErrorCode::EE1013, sizeof(XpuArgManage));

    isHasArgPool_ = argManage_->CreateArgRes();
    if (isHasArgPool_ == false) {
        RT_LOG(RT_LOG_ERROR, "Failed to create arg resource, stream_id=%d.", streamId_);
        return RT_ERROR_CALLOC;
    }
    return RT_ERROR_NONE;
}

rtError_t XpuStream::TearDown(const bool terminal, bool flag)
{
    UNUSED(terminal);
    rtError_t error = RT_ERROR_NONE;
    XpuStreamSqCqManage *xpuSqCqManage = static_cast<XpuStreamSqCqManage *>(Device_()->GetStreamSqCqManage());
    XpuDriver *xpuDrv = static_cast<XpuDriver *>(Device_()->Driver_());
    bool isForceRecycle = GetForceRecycleFlag(flag);
    if (isForceRecycle) {
        xpuSqCqManage->SetXpuTprtSqCqStatus(Device_()->Id_(), GetSqId());
    }

    uint32_t sqStatus = static_cast<uint32_t>(TPRT_SQ_STATE_IS_RUNNING);
    while (!((dynamic_cast<TaskResManageDavid *>(taskResMang_))->IsEmpty())) {
        error = xpuDrv->GetSqState(Device_()->Id_(), GetSqId(), sqStatus);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "Failed to query SQ status, stream_id=%d, retCode=%#x.", streamId_, static_cast<uint32_t>(error));
        if ((GetFailureMode() == ABORT_ON_FAILURE) && (sqStatus != static_cast<uint32_t>(TPRT_SQ_STATE_IS_QUITTED))) {
            xpuSqCqManage->SetXpuTprtSqCqStatus(Device_()->Id_(), GetSqId());
        }

        StreamRecycleLock();
        XpuRecycleTaskProcCqe(this);
        XpuRecycleTaskBySqHead(this);
        StreamRecycleUnlock();
    }
    return RT_ERROR_NONE;
}

void XpuStream::ArgRelease(TaskInfo * const taskInfo, bool freeStmPool) const
{
    if (freeStmPool) {
        if (argManage_ != nullptr) {
            (void)argManage_->RecycleStmArgPos(taskInfo->id, taskInfo->stmArgPos);
        }
        taskInfo->stmArgPos = UINT32_MAX;
    }
    auto commDavinciInfo = (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) ? &(taskInfo->u.aicpuTaskInfo.comm)
                                                                         : &(taskInfo->u.aicTaskInfo.comm);
    if (argManage_ != nullptr) {
        argManage_->RecycleDevLoader(commDavinciInfo->argHandle);
    }
    commDavinciInfo->argHandle = nullptr;
}

uint32_t XpuStream::GetArgPos() const
{
    if (argManage_ != nullptr) {
        return argManage_->GetStmArgPos();
    }
    return UINT32_MAX;
}
uint32_t XpuStream::GetPendingNum() const
{
    if (likely(taskResMang_ != nullptr)) {
        return (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetPendingNum();
    }
    return 0U;
}

uint32_t XpuStream::GetTaskPosHead() const
{
    if (likely(taskResMang_ != nullptr)) {
        return (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetTaskPosHead();
    }
    return 0U;
}

uint32_t XpuStream::GetTaskPosTail() const
{
    if (likely(taskResMang_ != nullptr)) {
        return (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetTaskPosTail();
    }
    return 0U;
}

rtError_t XpuStream::CheckContextStatus(const bool isBlockDefaultStream) const
{
    if (Context_() != nullptr) {
        return Context_()->CheckStatus(this, isBlockDefaultStream);
    } else {
        return RT_ERROR_CONTEXT_NULL;
    }
}

rtError_t XpuStream::GetFinishedTaskIdBySqHead(const uint16_t sqHead, uint32_t &finishedId)
{
    // sqHead indicates the current position of execution; it has not yet been completed.
    const uint32_t rtsqDepth = GetSqDepth();
    uint16_t posTail = GetTaskPosTail();
    uint16_t posHead = GetTaskPosHead();
    if (((posTail + rtsqDepth - sqHead) % rtsqDepth) > (posTail + rtsqDepth - posHead) % rtsqDepth) {
        RT_LOG(RT_LOG_WARNING, "Invalid task position relation, stream_id=%d, sqHead=%u.", streamId_, sqHead);
        return RT_ERROR_INVALID_VALUE;
    }
    uint32_t endTaskId = MAX_UINT32_NUM;
    uint32_t nextTaskId = MAX_UINT32_NUM;
    TaskInfo *exeWorkTask =
        (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetTaskInfo(static_cast<uint32_t>(sqHead));
    if (unlikely(exeWorkTask != nullptr)) {
        nextTaskId = exeWorkTask->taskSn;
    } else {
        RT_LOG(RT_LOG_WARNING, "Failed to get task info at sqHead, stream_id=%d, sqHead=%u.", streamId_, sqHead);
        return RT_ERROR_INVALID_VALUE;
    }

    uint16_t finishedPos = (sqHead + rtsqDepth - 1) % rtsqDepth;
    TaskInfo *latestRecyleTask =
        (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetTaskInfo(static_cast<uint32_t>(finishedPos));
    if (unlikely(latestRecyleTask != nullptr)) {
        endTaskId = latestRecyleTask->taskSn;
    } else {
        RT_LOG(RT_LOG_WARNING, "Failed to get task info at finishedPos, stream_id=%d, finishedPos=%u.", streamId_,
               finishedPos);
        return RT_ERROR_INVALID_VALUE;
    }
    if (sqHead == posTail || nextTaskId != endTaskId) {
        finishedId = endTaskId;
    }
    return RT_ERROR_NONE;
}

rtError_t XpuStream::GetSynchronizeError(rtError_t error)
{
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = GetError();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    if (Context_() == nullptr) {
        return RT_ERROR_CONTEXT_NULL;
    }
    return Context_()->GetFailureError();
}

rtError_t XpuStream::SynchronizeExecutedTask(const uint32_t taskId, const mmTimespec &beginTime, int32_t timeout)
{
    uint16_t sqHead = MAX_UINT16_NUM;
    uint32_t tryCount = 0U;
    rtError_t error = RT_ERROR_NONE;
    const uint16_t perSchedYield = 1000U;
    int32_t reportTime = 180 * 1000;  // report timeout 3 min.
    while (true) {
        COND_RETURN_AND_MSG_OUTER(IsProcessTimeout(beginTime, timeout),
            RT_ERROR_STREAM_SYNC_TIMEOUT, ErrorCode::EE1002,
            "exceeded the specified timeout");
        if (IsProcessTimeout(beginTime, reportTime)) {
            reportTime += reportTime;
            RT_LOG(RT_LOG_EVENT,
                "report three minutes timeout! stream_id=%u, task_id=%u, pendingNum=%u.",
                Id_(),
                taskId,
                GetPendingNum());
        }

        error = CheckContextStatus(false);
        COND_RETURN_AND_MSG_INNER(error != RT_ERROR_NONE, error,
            "Context is in abort state, stream_id=%d, status=%#x.", streamId_, static_cast<uint32_t>(error));
        if (TASK_ID_GEQ(recycleFinishTaskId_, taskId) || sqHead == GetTaskPosTail()) {
            return RT_ERROR_NONE;
        }
        if (!Device_()->GetIsDoingRecycling()) {
            Device_()->WakeUpRecycleThread();
        }
        error = Device_()->Driver_()->GetSqHead(Device_()->Id_(), Device_()->DevGetTsId(), sqId_, sqHead);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "Failed to query SQ head, stream_id=%d, retCode=%#x.", streamId_, static_cast<uint32_t>(error));
        uint32_t finishedId = MAX_UINT32_NUM;
        error = GetFinishedTaskIdBySqHead(sqHead, finishedId);
        RT_LOG(RT_LOG_DEBUG,
                "stream_id=%u, task_id=%u, pendingNum=%u, sqHead=%u, recycleFinishTaskId_=%u.",
                Id_(), taskId, GetPendingNum(), sqHead, recycleFinishTaskId_);
        COND_PROC((error != RT_ERROR_NONE || finishedId == MAX_UINT32_NUM), continue);
        if (TASK_ID_GEQ(finishedId, taskId)) {
            return RT_ERROR_NONE;
        }
        tryCount++;
        if (tryCount % perSchedYield == 0) {
            std::this_thread::yield();
        }
    }
}

rtError_t XpuStream::Synchronize(const bool isNeedWaitSyncCq, int32_t timeout)
{
    (void)isNeedWaitSyncCq;
    if (GetPendingNum() == 0U) {
        return GetSynchronizeError(RT_ERROR_NONE);
    }
    rtError_t error = RT_ERROR_NONE;
    const mmTimespec beginTime = mmGetTickCount();
    error = SynchronizeExecutedTask(GetLastTaskId(), beginTime, timeout);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "Stream synchronize failed, stream_id=%d, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
    return GetSynchronizeError(error);
}

void XpuStream::EnterFailureAbort()
{
    if (GetFailureMode() != STOP_ON_FAILURE) {
        return;
    }
    SetFailureMode(ABORT_ON_FAILURE);
    const rtError_t err = GetError();
    if ((Context_() != nullptr) && (err != RT_ERROR_NONE)) {
        Context_()->SetFailureError(err);
    }
    RT_LOG(RT_LOG_ERROR, "stream_id=%d enter failure abort.", Id_());
}

void XpuStream::ArgReleaseStmPool(TaskInfo * const taskInfo) const
{
    if (argManage_ != nullptr) {
        (void)argManage_->RecycleStmArgPos(taskInfo->id, taskInfo->stmArgPos);
    }
    taskInfo->stmArgPos = UINT32_MAX;
}

void XpuStream::ArgReleaseSingleTask(TaskInfo * const taskInfo, bool freeStmPool) const
{
    if (freeStmPool) {
        if (argManage_ != nullptr) {
            (void)argManage_->RecycleStmArgPos(taskInfo->id, taskInfo->stmArgPos);
        }
        taskInfo->stmArgPos = UINT32_MAX;
    }
    auto commDavinciInfo = (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) ? &(taskInfo->u.aicpuTaskInfo.comm) :
            &(taskInfo->u.aicTaskInfo.comm);
    if (argManage_ != nullptr) {
        argManage_->RecycleDevLoader(commDavinciInfo->argHandle);
    }
    commDavinciInfo->argHandle = nullptr;
}

}  // namespace runtime
}  // namespace cce