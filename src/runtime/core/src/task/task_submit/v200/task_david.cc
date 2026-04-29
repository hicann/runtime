/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_david.hpp"
#include "task_res_da.hpp"
#include "task_submit.hpp"
#include "task_recycle.hpp"
#include "task.hpp"
#include "stream_david.hpp"
#include "engine.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "arg_loader.hpp"
#include "stars_engine.hpp"
#include "profiler_c.hpp"
#include "cond_c.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {
constexpr uint16_t TASK_QUERY_INTERVAL_NUM = 64U; // task recyle interval.

static rtError_t AddTaskToPublicQueue(TaskInfo * const workTask, const uint32_t sendSqeNum)
{
    Stream * const stm = workTask->stream;
    const rtError_t error = stm->StarsAddTaskToStream(workTask, sendSqeNum);
    if (unlikely(error != RT_ERROR_NONE)) {
        stm->StarsShowPublicQueueDfxInfo();
    }
    return error;
}

static void SyncTaskCheckResult(const rtError_t error, const Stream * const stm, const uint16_t pos)
{
    if (error != RT_ERROR_STREAM_SYNC_TIMEOUT) {
        return;
    }

    TaskInfo * const procTask = stm ->taskResMang_->GetTaskInfo(pos);
    if (procTask != nullptr) {
        procTask->isCqeNeedConcern = false;
    }
    return;
}
static rtError_t CheckTaskisValid(TaskInfo *submitTask, const Stream * const stm, uint32_t *sendSqeNum)
{
    if (stm->Device_()->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)) {
        RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(stm->Device_()->Id_())});
        submitTask->error = TASK_ERROR_SUBMIT_FAIL; // todo:confirm
        return RT_ERROR_DRV_ERR;
    }
    const rtError_t status = stm->abortStatus_;
    if (status != RT_ERROR_NONE) {
        return status;
    }
    *sendSqeNum = GetSendDavidSqeNum(submitTask);
    // set stream for task after task alloc
    if (*sendSqeNum > SQE_NUM_PER_DAVID_TASK_MAX) {
        RT_LOG(RT_LOG_ERROR, "sendSqeNum %u more than max num %d, task_type=%d(%s).",
            *sendSqeNum, SQE_NUM_PER_DAVID_TASK_MAX,static_cast<int32_t>(submitTask->type),
            GetTaskDescByType(submitTask->type));
        return RT_ERROR_INVALID_VALUE;
    }
     return RT_ERROR_NONE;
}

void TaskRollBack(Stream * const stm, uint32_t pos)
{
    if (unlikely(stm == nullptr)) {
        return;
    }

    if (stm->IsSoftwareSqEnable() || stm->IsAutoSplitSq()) {
        Device *dev = stm->Device_();
        TaskInfo *taskInfo = dev->GetTaskFactory()->GetTask(stm->Id_(), static_cast<uint16_t>(pos));
        if (taskInfo == nullptr) {
            RT_LOG(RT_LOG_DEBUG, "task info is null, stream_id=%hu, task_id=%hu", stm->Id_(), pos);
            return;
        }

        if (taskInfo->isUpdateSinkSqe == 0U) {
            (void)dev->GetTaskFactory()->Recycle(taskInfo);
            taskInfo = nullptr;
        } else {
            taskInfo->isUpdateSinkSqe = 0U;
        }
        return;
    }

    if ((unlikely(stm->taskResMang_ == nullptr) || (pos >= stm->GetSqDepth()))) {
        return;
    }

    TaskResManageDavid *taskResMang = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(stm->taskResMang_);
    taskResMang->RollbackTail(pos);
}

static inline void UpdateNeedLogStatus(bool *needLog, uint32_t *needLogCnt, const uint32_t intervalCnt)
{
    (*needLogCnt)++;
    *needLog = false;
    if (*needLogCnt >= intervalCnt) {
        *needLog = true;
        *needLogCnt = 0U;
    }
}

// 注意：此函数假设调用者已持有 ctx->mutex 锁
static rtError_t ExpandHostSqeBufferLocked(Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "Enter ExpandHostSqeBufferLocked, master_stream_id=%d, cur_stream_id=%d",
        stm->GetExposedStreamId(), stm->Id_());
    AutoSplitSqContext *ctx = stm->GetAutoSplitCtx();
    if (ctx == nullptr) {
        RT_LOG(RT_LOG_ERROR, "AutoSplitSqContext is null, master_stream_id=%d, cur_stream_id=%d",
            stm->GetExposedStreamId(), stm->Id_());
        return RT_ERROR_INVALID_VALUE;
    }

    uint32_t newSize = stm->GetSqeBufferSize() + STREAM_SQE_BUFFER_INIT_SIZE;
    uint8_t *newBuffer = new (std::nothrow) uint8_t[newSize];
    COND_RETURN_ERROR(newBuffer == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "new sqeBuffer failed, newSize=%u", newSize);

    errno_t ret = memset_s(newBuffer, newSize, 0U, newSize);
    if (ret != EOK) {
        delete[] newBuffer;
        RT_LOG(RT_LOG_ERROR, "Memset new sqeBuffer failed, master_stream_id=%d, cur_stream_id=%d, retCode=%d.",
            stm->GetExposedStreamId(), stm->Id_(), ret);
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    // 复制原有数据
    uint8_t *oldBuffer = stm->GetSqeBuffer();
    if (oldBuffer != nullptr) {
        ret = memcpy_s(newBuffer, newSize,
            oldBuffer, ctx->curStreamSqeCount * sizeof(rtDavidSqe_t));
        if (ret != EOK) {
            DELETE_A(newBuffer);
            RT_LOG(RT_LOG_ERROR, "memcpy_s sqeBuffer failed, master_stream_id=%d, cur_stream_id=%d, retCode=%d.",
                stm->GetExposedStreamId(), stm->Id_(), ret);
            return RT_ERROR_MEMORY_ALLOCATION;
        }
        DELETE_A(oldBuffer);
    }

    stm->SetSqeBuffer(newBuffer);
    stm->SetSqeBufferSize(newSize);
    RT_LOG(RT_LOG_INFO, "Expanded host SQ buffer, master_stream_id=%d, cur_stream_id=%d, newSize=%u",
        stm->GetExposedStreamId(), stm->Id_(), newSize);
    return RT_ERROR_NONE;
}

// 获取 auto-split stream 的当前活跃 stream（可能是 master 或最新的 slave）
// 注意：调用此函数前必须持有 StreamLock()
static Stream *GetAutoSplitCurStream(AutoSplitSqContext *masterCtx) noexcept
{
    if (!masterCtx->slaveStreams.empty()) {
        return masterCtx->slaveStreams.back();
    }
    return nullptr;  // 返回 nullptr 表示使用 master stream
}

// 检查容量并在需要时创建新的 slave stream
// 返回值：RT_ERROR_NONE 成功，其他值失败
// 注意: 调用方已持有 StreamLock()，保护了对 slaveStreams 的访问
// 输出参数：curStream 更新后的当前 stream
static rtError_t TryCreateAutoSplitSlaveStream(Stream * const masterStm, uint32_t sqeNum,
    Stream *&curStream)
{
    RT_LOG(RT_LOG_DEBUG, "Enter TryCreateAutoSplitSlaveStream, master_stream_id=%d, cur_stream_id=%d, sqeNum=%u",
        masterStm->GetExposedStreamId(), curStream->Id_(), sqeNum);
    AutoSplitSqContext *splitCtx = curStream->GetAutoSplitCtx();
    COND_RETURN_ERROR(splitCtx == nullptr, RT_ERROR_INVALID_VALUE,
        "curStream AutoSplitSqContext is null, stream_id=%d", curStream->Id_());

    if ((splitCtx->curStreamSqeCount + sqeNum + CAPTURE_TASK_RESERVED_NUM + masterStm->Device_()->GetDevProperties().expandStreamRsvTaskNum) < HOST_SQ_MAX_COUNT) {
        return RT_ERROR_NONE;  // 容量充足，无需创建
    }

    Stream *prevStream = curStream;
    Context *ctx = masterStm->Context_();

    // 必须先释放 StreamLock 再调用 CreateAutoSplitSlaveStream，否则会在
    // 持有 StreamLock 的同时尝试获取 context 内部锁，导致 AB-BA 死锁。
    // 不可删除此处的 UnLock/Lock 对。
    masterStm->StreamUnLock();
    Stream *newSlaveStream = nullptr;
    rtError_t error = ctx->CreateAutoSplitSlaveStream(masterStm, &newSlaveStream);
    masterStm->StreamLock();  // 立即重新获取锁

    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Create slave stream failed, master_stream_id=%d, cur_stream_id=%d, retCode=%#x.",
            masterStm->GetExposedStreamId(), prevStream->Id_(), error);
        return error;  // 返回时锁被持有
    }

    // 添加到列表
    masterStm->GetSlaveStreams().push_back(newSlaveStream);

    // 释放锁执行 stream active
    masterStm->StreamUnLock();
    error = CondStreamActive(newSlaveStream, prevStream, nullptr, true);
    masterStm->StreamLock();  // 立即重新获取锁

    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CondStreamActive failed, master_stream_id=%d, slave_stream_id=%d, retCode=%#x.",
            masterStm->GetExposedStreamId(), newSlaveStream->Id_(), error);
        return error;  // 返回时锁被持有
    }

    curStream = newSlaveStream;
    return RT_ERROR_NONE;  // 锁保持持有状态
}

// 在 auto-split stream 上分配 TaskInfo
rtError_t AllocTaskInfoOnAutoSplitStream(Stream *curStream, uint32_t sqeNum, TaskInfo **taskInfo, uint32_t &pos)
{
    RT_LOG(RT_LOG_DEBUG, "Enter AllocTaskInfoOnAutoSplitStream, master_stream_id=%d, cur_stream_id=%d, sqeNum=%u",
        curStream->GetExposedStreamId(), curStream->Id_(), sqeNum);
    AutoSplitSqContext *splitCtx = curStream->GetAutoSplitCtx();
    // 检查是否需要扩容 host SQ buffer
    if ((splitCtx->curStreamSqeCount + sqeNum) > (curStream->GetSqeBufferSize() / sizeof(rtDavidSqe_t))) {
        rtError_t error = ExpandHostSqeBufferLocked(curStream);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Expand host SQ buffer failed, retCode=%#x.", error);
    }

    rtError_t error = RT_ERROR_NONE;
    *taskInfo = curStream->Device_()->GetTaskFactory()->Alloc(curStream, TS_TASK_TYPE_RESERVED, error);
    if (*taskInfo == nullptr) {
        // 如果 Alloc 返回 nullptr 但 error 为 RT_ERROR_NONE，设置正确的错误码
        if (error == RT_ERROR_NONE) {
            error = RT_ERROR_MEMORY_ALLOCATION;
        }
        RT_LOG(RT_LOG_ERROR, "Alloc task info failed, master_stream_id=%d, cur_stream_id=%d, error=%#x",
            curStream->GetExposedStreamId(), curStream->Id_(), error);
        return error;
    }
    (*taskInfo)->stream = curStream;
    Runtime::Instance()->AllocTaskSn((*taskInfo)->taskSn);
    pos = (*taskInfo)->id;

    splitCtx->curStreamSqeCount += sqeNum;
    return RT_ERROR_NONE;
}

static rtError_t AllocAutoSplitTaskInfo(TaskInfo **taskInfo, Stream * const stm, uint32_t &pos, Stream *&dstStm, uint32_t sqeNum)
{
    RT_LOG(RT_LOG_DEBUG, "Enter AllocAutoSplitTaskInfo, master_stream_id=%d, sqeNum=%u",
        stm->GetExposedStreamId(), sqeNum);

    AutoSplitSqContext *masterCtx = stm->GetAutoSplitCtx();
    COND_RETURN_ERROR(masterCtx == nullptr, RT_ERROR_INVALID_VALUE,
        "AutoSplitSqContext is null, stream_id=%d", stm->Id_());

    // 获取当前活跃的 stream
    // 注意: 调用方已持有 StreamLock()，保护了对 slaveStreams 的访问
    Stream *curStream = stm;
    Stream *slaveStream = GetAutoSplitCurStream(masterCtx);
    if (slaveStream != nullptr) {
        curStream = slaveStream;
        RT_LOG(RT_LOG_DEBUG, "Auto-split using slave stream, master_stream_id=%d, cur_stream_id=%d",
            stm->GetExposedStreamId(), curStream->Id_());
    }

    // 检查容量并创建 slave stream
    rtError_t error = TryCreateAutoSplitSlaveStream(stm, sqeNum, curStream);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Try create slave stream failed.");

    AutoSplitSqContext *splitCtx = curStream->GetAutoSplitCtx();
    COND_RETURN_ERROR(splitCtx == nullptr, RT_ERROR_INVALID_VALUE,
        "curStream AutoSplitSqContext is null, stream_id=%d", curStream->Id_());

    // 分配 TaskInfo
    error = AllocTaskInfoOnAutoSplitStream(curStream, sqeNum, taskInfo, pos);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Alloc task info failed.");

    dstStm = curStream;
    RT_LOG(RT_LOG_DEBUG, "Alloc auto-split task, master_stream_id=%d, cur_stream_id=%d, sqeNum=%u, ctxSqeNum=%u",
        stm->GetExposedStreamId(), curStream->Id_(), sqeNum, splitCtx->curStreamSqeCount);
    return RT_ERROR_NONE;
}

static rtError_t AllocCaptureTaskInfo(TaskInfo **taskInfo, Stream * const stm, uint32_t &pos, Stream *&dstStm, uint32_t sqeNum)
{
    std::unique_lock<std::mutex> lk(stm->GetCaptureLock());
    Stream *curCaptureStream = stm->GetCaptureStream();
    rtError_t ret = RT_ERROR_NONE;
    if (curCaptureStream == nullptr) {
        /* stm exit capture mode */
        return RT_ERROR_STREAM_CAPTURE_EXIT;
    }
    if (unlikely(curCaptureStream->Flags() & RT_STREAM_PERSISTENT) == 0U) {
        return RT_ERROR_STREAM_INVALID;
    }

    if (curCaptureStream->IsSoftwareSqEnable()) {
        // david taskType传无效值，后面填充参数的时候会刷新
        ret = stm->AllocCaptureTask(TS_TASK_TYPE_RESERVED, sqeNum, taskInfo, false);
        ERROR_RETURN(ret, "alloc capture task failed, retCode=%#x, device_id=%u, stream_id=%d, sqeNum=%u",
           ret, stm->Device_()->Id_(), stm->Id_(), sqeNum);

        pos = (*taskInfo)->id; // 这里返回task id作为pos，主要是为了任务下发失败时的任务回收。
        dstStm = stm->GetCaptureStream();
        return RT_ERROR_NONE;
    }

    COND_PROC_RETURN_ERROR(stm->IsTaskGroupBreak(), RT_ERROR_STREAM_TASKGRP_INTR,
        stm->SetTaskGroupErrCode(RT_ERROR_STREAM_TASKGRP_INTR), "the task group interrupted.");

    const uint32_t rtsqDepth = stm->GetSqDepth();
    TaskResManageDavid *taskResMang = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(curCaptureStream->taskResMang_);
    if ((static_cast<uint32_t>(taskResMang->GetTaskPosTail()) + CAPTURE_TASK_RESERVED_NUM) >= rtsqDepth) {
        Stream *newCaptureStream = nullptr;
        rtError_t error = stm->AllocCascadeCaptureStream(newCaptureStream, curCaptureStream);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        Context * const ctx = stm->Context_();
        if (ctx == nullptr) {
            stm->SingleStreamTerminateCapture();
            RT_LOG(RT_LOG_ERROR, "context is null, device_id=%u, original stream_id=%d.", stm->Device_()->Id_(), stm->Id_());
            return RT_ERROR_CONTEXT_NULL;
        }
        error = CondStreamActive(newCaptureStream, curCaptureStream);
        if (error != RT_ERROR_NONE) {
            ctx->FreeCascadeCaptureStream(newCaptureStream);
            stm->SingleStreamTerminateCapture();
            RT_LOG(RT_LOG_ERROR, "stream active failed, device_id=%u, original stream_id=%d.", stm->Device_()->Id_(), stm->Id_());
            return error;
        }
        stm->UpdateCascadeCaptureStreamInfo(newCaptureStream, curCaptureStream);
        curCaptureStream = newCaptureStream;
    }
    dstStm = curCaptureStream;
    taskResMang = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(curCaptureStream->taskResMang_);
    if (taskResMang->AllocTaskInfoAndPos(sqeNum, pos, taskInfo) == RT_ERROR_NONE) {
        Runtime::Instance()->AllocTaskSn((*taskInfo)->taskSn);
    } else {
        stm->SingleStreamTerminateCapture();
    }
    return ret;
}

rtError_t AllocTaskInfoForCapture(TaskInfo **taskInfo, Stream * const stm, uint32_t &pos, Stream *&dstStm,
                                  uint32_t sqeNum, bool isKernelLaunch)
{
    if ((taskInfo == nullptr) || (stm == nullptr) ||
        ((stm->taskResMang_ == nullptr) && (!stm->IsSoftwareSqEnable()) && (!stm->IsAutoSplitSq()))) {
        return RT_ERROR_INVALID_VALUE;
    }

    rtError_t error = RT_ERROR_NONE;

    // 处理 TaskGroupUpdate
    if (stm->IsTaskGroupUpdate()) {
        if (isKernelLaunch) {
            error = stm->UpdateTask(taskInfo);
            return error;
        } else {
            RT_LOG(RT_LOG_ERROR, "Unsupported task type for task update.");
            return RT_ERROR_TASK_NOT_SUPPORT;
        }
    }

    // 自动切分场景单独处理
    if (stm->IsAutoSplitSq()) {
        return AllocAutoSplitTaskInfo(taskInfo, stm, pos, dstStm, sqeNum);
    }

    if (stm->GetCaptureStatus() != RT_STREAM_CAPTURE_STATUS_NONE) {
        error = AllocCaptureTaskInfo(taskInfo, stm, pos, dstStm, sqeNum);
        if (error != RT_ERROR_STREAM_CAPTURE_EXIT) {
            return error;
        }
    }
    dstStm = stm;

    if (stm->taskResMang_ == nullptr) { // 模型流上下发的notify要从这里申请task
        *taskInfo = stm->Device_()->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_RESERVED, error);
        NULL_PTR_RETURN_MSG(*taskInfo, error);
        stm->AddCaptureSqeNum(sqeNum);
        (*taskInfo)->stream = stm;
        Runtime::Instance()->AllocTaskSn((*taskInfo)->taskSn);
        pos = (*taskInfo)->id;

        return RT_ERROR_NONE;
    }

    return AllocTaskInfo(taskInfo, stm, pos, sqeNum);
}

static void TryToReclaimTask(Stream * const stm, bool needLog)
{
    stm->StreamSyncLock();
    if (stm->IsSeparateSendAndRecycle()) {
        if (!stm->Device_()->GetIsDoingRecycling()) {
            stm->Device_()->WakeUpRecycleThread();
        }
    } else {
        TaskReclaimByStream(stm, true, needLog);
    }
    stm->StreamSyncUnLock();

    return;
}

rtError_t AllocTaskInfo(TaskInfo **taskInfo, Stream * const stm, uint32_t &pos, uint32_t sqeNum)
{
    if ((taskInfo == nullptr) || (stm == nullptr) || (stm->taskResMang_ == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }

    TaskResManageDavid *taskResMang = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(stm->taskResMang_);
    rtError_t error = taskResMang->AllocTaskInfoAndPos(sqeNum, pos, taskInfo);
    const int32_t stmId = stm->Id_();
    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;

    bool needLog = true;
    uint32_t needLogCnt = 0U;
    while (error == RT_ERROR_TASKRES_QUEUE_FULL) {
        if ((stm->Flags() & RT_STREAM_PERSISTENT) != 0U) {
            return RT_ERROR_STREAM_FULL;
        }
        error = stm->CheckContextStatus();
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<uint32_t>(error)); 
        COND_RETURN_ERROR_MSG_INNER((stm->abortStatus_ != RT_ERROR_NONE), stm->abortStatus_,
            "stream_id=%d is ABORT.", stmId);
        stm->StreamUnLock();
        stm->StarsStmDfxCheck(beginCnt, endCnt, checkCount);
        TryToReclaimTask(stm, needLog);
        stm->StreamLock();
        error = taskResMang->AllocTaskInfoAndPos(sqeNum, pos, taskInfo, needLog);

        UpdateNeedLogStatus(&needLog, &needLogCnt, 100000U); // 100000U Print once per second.
    }
    /* alloc dfx task id for current process, if send failed, no need to roll back */
    if (error == RT_ERROR_NONE) {
        Runtime::Instance()->AllocTaskSn((*taskInfo)->taskSn);
    }

    RT_LOG(RT_LOG_DEBUG, "alloc taskinfo success, stream_id=%d, task_id=%hu, task_sn=%u.",
        stmId, (*taskInfo)->id, (*taskInfo)->taskSn);

    return error;
}

rtError_t ProcAicpuTask(TaskInfo *submitTask)
{
    if ((submitTask->stream->Flags() & RT_STREAM_AICPU) == 0U) {
        return RT_ERROR_NONE;
    }
    if (submitTask->stream->NeedSaveTask(submitTask)) {
        rtCommand_t command;
        ToCommand(submitTask, &command);
        COND_RETURN_ERROR_MSG_INNER((submitTask->stream->Model_() == nullptr), RT_ERROR_MODEL_NULL,
            "SubmitTask fail for model null, stream_id=%d.", submitTask->stream->Id_());
        (void)submitTask->stream->Model_()->SaveAicpuStreamTask(submitTask->stream, &command);
    }
    RT_LOG(RT_LOG_DEBUG, "aicpu stream,no need sent to ts,stream_id=%d,task_type=%d (%s).",
            submitTask->stream->Id_(), static_cast<int32_t>(submitTask->type), GetTaskDescByType(submitTask->type));
    TaskUnInitProc(submitTask);
    return RT_ERROR_NONE;
}

static rtError_t AllocTaskAndSendDavid(TaskInfo *submitTask, Stream * const stm)
{
    uint32_t sendSqeNum = 0U;
    TaskInfo *taskInfo = nullptr;
    rtError_t error = CheckTaskisValid(submitTask, stm, &sendSqeNum);
    ERROR_RETURN_MSG_INNER(error, "AllocTask Check Failed. retCode=%#x.", static_cast<uint32_t>(error));

    /* save task to model for ACL */
    if ((submitTask->stream->Flags() & RT_STREAM_AICPU) != 0U) {
        if (submitTask->stream->NeedSaveTask(submitTask)) {
            rtCommand_t command;
            ToCommand(submitTask, &command);
            COND_RETURN_ERROR_MSG_INNER((submitTask->stream->Model_() == nullptr), RT_ERROR_MODEL_NULL,
                "SubmitTask fail for model null, stream_id=%d.", submitTask->stream->Id_());
            (void)submitTask->stream->Model_()->SaveAicpuStreamTask(submitTask->stream, &command);
        }
        RT_LOG(RT_LOG_DEBUG, "aicpu stream,no need sent to ts,stream_id=%d,task_type=%d (%s).",
              submitTask->stream->Id_(), static_cast<int32_t>(submitTask->type), GetTaskDescByType(submitTask->type));
        Complete(submitTask, RT_MAX_DEV_NUM); // todo:confirm
        TaskUnInitProc(submitTask);
        return RT_ERROR_NONE;
    }

    TaskResManageDavid *taskResMang = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(stm->taskResMang_);
    Device *dev = stm->Device_();
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t cqId = stm->GetCqId();
    uint32_t pos = 0xFFFFU;
    stm->StreamLock();
    error = taskResMang->AllocTaskInfoAndPos(sendSqeNum, pos, &taskInfo);

    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;

    while (error == RT_ERROR_TASKRES_QUEUE_FULL) {
        stm->StreamUnLock();
        if ((stm->Flags() & RT_STREAM_PERSISTENT) != 0U) {
            return RT_ERROR_STREAM_FULL;
        }
        stm->StarsStmDfxCheck(beginCnt, endCnt, checkCount);
        stm->StreamSyncLock();
        TaskReclaimByStream(stm, true);
        stm->StreamSyncUnLock();
        error = stm->CheckContextTaskSend(submitTask);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));
        COND_RETURN_ERROR_MSG_INNER((stm->abortStatus_ != RT_ERROR_NONE), stm->abortStatus_, "stream in abort status.");
        stm->StreamLock();
        error = taskResMang->AllocTaskInfoAndPos(sendSqeNum, pos, &taskInfo);
    }

    if (!(stm->IsDavinciTask(submitTask)) && !(stm->IsFusionKernelTask(submitTask))) {
        submitTask->stmArgPos = static_cast<DavidStream *>(stm)->GetArgPos();
    }

    submitTask->id = pos;
    submitTask->profEn = Runtime::Instance()->GetProfileEnableFlag();
    InitByStream(taskInfo, stm);
    SaveTaskInfo(taskInfo, submitTask);
    taskInfo->sqeNum = sendSqeNum;
    SetSqPos(taskInfo, pos);

    Profiler *profilerPtr = Runtime::Instance()->Profiler_();
    if ((profilerPtr != nullptr) && (!dev->IsDeviceRelease())) {
        profilerPtr->ReportTaskTrack(taskInfo, devId);
    }
    rtDavidSqe_t davidSqe[SQE_NUM_PER_DAVID_TASK_MAX];
    rtDavidSqe_t *sqeAddr = davidSqe;
    const uint64_t sqBaseAddr = stm->GetSqBaseAddr();
    if (sqBaseAddr != 0U) {
        sqeAddr = RtValueToPtr<rtDavidSqe_t *>(sqBaseAddr + (pos << SHIFT_SIX_SIZE));
    }
    ToConstructDavidSqe(taskInfo, sqeAddr, sqBaseAddr);
    // update the host-side head and tail
    error = AddTaskToPublicQueue(taskInfo, sendSqeNum);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Add task failed stream_id=%d, task_id=%u.", stm->Id_(), taskInfo->id);
        taskResMang->RollbackTail(static_cast<uint16_t>(pos));
        stm->StreamUnLock();
        return error;
    }

    // 调用driver接口发送sqe
    struct halTaskSendInfo sendInfo = {};
    sendInfo.type = DRV_NORMAL_TYPE;
    sendInfo.sqe_num = sendSqeNum;
    sendInfo.tsId = tsId;
    sendInfo.sqId = sqId;
    sendInfo.sqe_addr = RtPtrToPtr<uint8_t *, rtDavidSqe_t *>(sqeAddr);
    drvError_t drvRet = halSqTaskSend(devId, &sendInfo);
    beginCnt = 0ULL;
    endCnt = 0ULL;
    checkCount = 0U;
    uint32_t tryCount = 0U;
    while (unlikely(drvRet == DRV_ERROR_NO_RESOURCES)) {
        RT_LOG(RT_LOG_WARNING, "halSqTaskSend fail. device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u,"
            " stream_id=%d, task_id=%hu, task_type=%u(%s), retCode=%#x, drvRetCode=%d, tryCount=%u",
            devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id, static_cast<uint32_t>(taskInfo->type), 
            taskInfo->typeName, static_cast<uint32_t>(error), static_cast<int32_t>(drvRet), tryCount);
        tryCount++;
        if (stm->PrintStmDfxAndCheckDevice(beginCnt, endCnt, checkCount, tryCount) != RT_ERROR_NONE) {
            taskResMang->RollbackTail(static_cast<uint16_t>(pos));
            stm->StreamUnLock();
            RT_LOG(RT_LOG_ERROR, "device status error in sq task send, device_id=%u, stream_id=%d.", devId, stm->Id_());
            return RT_ERROR_DRV_ERR;
        }
        drvRet = halSqTaskSend(devId, &sendInfo);
    }
    stm->StreamUnLock();
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, sq_id=%u, stream_id=%d, task_id=%hu, task_type=%u(%s).",
        devId, tsId, sqId, stm->Id_(), taskInfo->id, static_cast<uint32_t>(taskInfo->type), GetTaskDescByType(taskInfo->type));
    error = TryRecycleTask(stm);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Try recycle task failed, retCode=%#x.",
        static_cast<uint32_t>(error));
    return error;
}

static void SetFlipTaskNum(Stream *const stream, uint32_t prePos, uint32_t sqeNum)
{
    if (stream->GetBindFlag()) {
        return;
    }

    if ((prePos + sqeNum) < stream->Device_()->GetDevProperties().rtsqDepth) {
        return;
    }

    // update flip num
    stream->SetTaskIdFlipNum(stream->GetTaskIdFlipNum() + 1U);
    return;
}

static rtError_t WriteAutoSplitSqeToHostBuffer(TaskInfo *taskInfo, Stream * const stm, rtDavidSqe_t *sqeAddr)
{
    AutoSplitSqContext *ctx = stm->GetAutoSplitCtx();
    uint8_t *sqeBuffer = stm->GetSqeBuffer();
    if (ctx == nullptr || sqeBuffer == nullptr) {
        RT_LOG(RT_LOG_ERROR, "auto-split ctx or sqeBuffer is null, stream_id=%d, task_id=%u",
            stm->Id_(), taskInfo->id);
        return RT_ERROR_INVALID_VALUE;
    }
    const uint32_t hostPos = ctx->curStreamSqeCount - taskInfo->sqeNum;
    // 边界检查：确保写入位置在有效范围内
    uint32_t hostSqeCapacity = stm->GetSqeBufferSize() / sizeof(rtDavidSqe_t);
    if ((hostPos + taskInfo->sqeNum) > hostSqeCapacity) {
        RT_LOG(RT_LOG_ERROR, "hostSqeBuffer boundary check failed, stream_id=%d, task_id=%u, "
            "hostPos=%u, sqeNum=%u, capacity=%u",
            stm->Id_(), taskInfo->id, hostPos, taskInfo->sqeNum, hostSqeCapacity);
        return RT_ERROR_INVALID_VALUE;
    }
    uint8_t *hostSqPos = sqeBuffer + hostPos * sizeof(rtDavidSqe_t);
    const errno_t ret = memcpy_s(hostSqPos, taskInfo->sqeNum * sizeof(rtDavidSqe_t),
        sqeAddr, taskInfo->sqeNum * sizeof(rtDavidSqe_t));
    if (ret != EOK) {
        RT_LOG(RT_LOG_ERROR, "memcpy_s to host SQ buffer failed, stream_id=%d, task_id=%u, error=%d",
            stm->Id_(), taskInfo->id, ret);
        return RT_ERROR_INVALID_VALUE;
    }
    RT_LOG(RT_LOG_DEBUG, "Auto-split SQE written to host buffer, stream_id=%d, task_id=%u, sqeNum=%u, hostPos=%u",
        stm->Id_(), taskInfo->id, taskInfo->sqeNum, hostPos);
    return RT_ERROR_NONE;
}

rtError_t DavidSendTask(TaskInfo *taskInfo, Stream * const stm)
{
    rtDavidSqe_t davidSqe[SQE_NUM_PER_DAVID_TASK_MAX];
    rtDavidSqe_t *sqeAddr = davidSqe;
    const uint16_t pos = taskInfo->id; // aclgraph扩流场景用不上这个字段
    const Device *dev = stm->Device_();
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
    const uint32_t sqId = stm->GetSqId();
    const uint32_t cqId = stm->GetCqId();
    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;
    uint64_t sqBaseAddr = stm->GetSqBaseAddr();
    Profiler *profilerPtr = Runtime::Instance()->Profiler_();

    if (stm->IsSoftwareSqEnable() || stm->IsAutoSplitSq()) {
        dev->GetTaskFactory()->SetSerialId(stm, taskInfo);
        sqBaseAddr = 0ULL;
    } else {
        if (sqBaseAddr != 0ULL) { // 非扩流场景
            sqeAddr = RtValueToPtr<rtDavidSqe_t *>(sqBaseAddr + (pos << SHIFT_SIX_SIZE));
        }
    }

    if ((profilerPtr != nullptr) && (!dev->IsDeviceRelease())) {
        profilerPtr->ReportTaskTrack(taskInfo, devId);
    }

    ToConstructDavidSqe(taskInfo, sqeAddr, sqBaseAddr);
    // update the host-side head and tail
    rtError_t error = AddTaskToPublicQueue(taskInfo, taskInfo->sqeNum);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Add task failed stream_id=%d, task_id=%u.", stm->Id_(), taskInfo->id);
        return error;
    }

    // auto-split stream 处理：SQE 写入 host SQ buffer
    if (stm->IsAutoSplitSq()) {
        return WriteAutoSplitSqeToHostBuffer(taskInfo, stm, sqeAddr);
    }

    if (stm->IsSoftwareSqEnable()) {
        const auto ret = memcpy_s(RtPtrToPtr<void *>(stm->GetSqeBuffer() + sizeof(rtStarsSqe_t) * taskInfo->pos),
            taskInfo->sqeNum * sizeof(rtStarsSqe_t), RtPtrToPtr<void *, rtDavidSqe_t *>(sqeAddr), 
            taskInfo->sqeNum * sizeof(rtStarsSqe_t));
        if (ret != EOK) {
            RT_LOG(RT_LOG_ERROR, "memcpy_s failed, device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u,"
                " stream_id=%d, task_id=%hu, task_type=%u(%s), error=%d",
                devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id,
                static_cast<uint32_t>(taskInfo->type), taskInfo->typeName, ret);
            error = RT_ERROR_INVALID_VALUE;
        }

        RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, sq_id=%u, stream_id=%d, task_id=%hu, flip_num=%u, task_sn=%u, task_type=%u(%s)",
            devId, tsId, sqId, stm->Id_(), taskInfo->id, stm->GetTaskIdFlipNum(), taskInfo->taskSn,
            static_cast<uint32_t>(taskInfo->type), GetTaskDescByType(taskInfo->type));
        return error;
    }

    // 调用driver接口发送sqe
    uint32_t tryCount = 0U;
    struct halTaskSendInfo sendInfo = {};
    sendInfo.type = DRV_NORMAL_TYPE;
    sendInfo.sqe_num = taskInfo->sqeNum;
    sendInfo.tsId = tsId;
    sendInfo.sqId = sqId;
    sendInfo.sqe_addr = RtPtrToPtr<uint8_t *, rtDavidSqe_t *>(sqeAddr);
    drvError_t drvRet = halSqTaskSend(devId, &sendInfo);
    COND_RETURN_ERROR_MSG_INNER((drvRet != DRV_ERROR_NO_RESOURCES) && (drvRet != DRV_ERROR_NONE),
        RT_ERROR_DRV_ERR, "[drv api] device_id=%u, stream_id=%d send task fail retCode=%d.", devId, stm->Id_(), drvRet);
    while (unlikely(drvRet == DRV_ERROR_NO_RESOURCES)) {
        RT_LOG(RT_LOG_WARNING, "halSqTaskSend fail. device_id=%u, ts_id=%u, sq_id=%u, cq_id=%u,"
            " stream_id=%d, task_id=%hu, task_type=%u(%s), error=%#x, drvRetCode=%d, tryCount=%u",
            devId, tsId, sqId, cqId, stm->Id_(), taskInfo->id, static_cast<uint32_t>(taskInfo->type),
            GetTaskDescByType(taskInfo->type), static_cast<uint32_t>(error), static_cast<int32_t>(drvRet), tryCount);
        tryCount++;
        if (stm->PrintStmDfxAndCheckDevice(beginCnt, endCnt, checkCount, tryCount) != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "device status error in sq task send, device_id=%u, stream_id=%d.", devId, stm->Id_());
            return RT_ERROR_DRV_ERR;
        }
        drvRet = halSqTaskSend(devId, &sendInfo);
    }
    if (drvRet == DRV_ERROR_NONE) {
        SetFlipTaskNum(stm, pos, taskInfo->sqeNum);
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, ts_id=%u, sq_id=%u, stream_id=%d, task_id=%hu, flip_num=%u, task_sn=%u, task_type=%u(%s),"
        " drvRet=%u.", devId, tsId, sqId, stm->Id_(), taskInfo->id, stm->GetTaskIdFlipNum(), taskInfo->taskSn,
        static_cast<uint32_t>(taskInfo->type), GetTaskDescByType(taskInfo->type), drvRet);
    return drvRet != DRV_ERROR_NONE ? RT_ERROR_DRV_ERR : RT_ERROR_NONE;
}

rtError_t CheckTaskCanSend(Stream * const stm)
{
    rtError_t errorCode = RT_ERROR_NONE;
    errorCode = stm->CheckContextStatus(false);
    COND_RETURN_ERROR(errorCode != RT_ERROR_NONE, errorCode, "context is abort, status=%#x.", static_cast<uint32_t>(errorCode));
    const rtError_t streamAbortStatus = stm->GetAbortStatus();
    COND_RETURN_ERROR((streamAbortStatus == RT_ERROR_STREAM_ABORT),
        RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL,
        "stream is in stream abort status, send task fail, device_id=%u, stream_id=%d",
        stm->Device_()->Id_(), stm->Id_());

    TaskResManageDavid *taskResManag = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(stm->taskResMang_);
    if (unlikely(taskResManag == nullptr) && (!stm->IsSoftwareSqEnable()) && (!stm->IsAutoSplitSq())) {
        RT_LOG(RT_LOG_WARNING, "device_id=%u stream_id=%d(flags=0x%x) does not support send task.",
            stm->Device_()->Id_(), stm->Id_(), stm->Flags());
        return RT_ERROR_STREAM_INVALID;
    }
    return RT_ERROR_NONE;
}


rtError_t SubmitTaskDavid(TaskInfo *submitTask, Stream * const stm, int32_t timeout)
{
    rtError_t error = stm->CheckContextTaskSend(submitTask);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));
    COND_RETURN_ERROR_MSG_INNER((stm->abortStatus_ == RT_ERROR_DEVICE_TASK_ABORT), RT_ERROR_DEVICE_TASK_ABORT,
        "Device is in abort status.");
    error = AllocTaskAndSendDavid(submitTask, stm);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "AllocTaskAndSendDavid fail, streamId=%d, task pos=%hu,"
        "taskType=%u(%s), retCode=%#x", stm->Id_(), submitTask->id, submitTask->type,
        GetTaskDescByType(submitTask->type), error);

    if (submitTask->isNeedStreamSync != 0U) {
        stm->StreamSyncLock();
        // isStreamSync para set true if need wait cq in unsink stream
        error = SyncTask(stm, static_cast<uint32_t>(submitTask->id), timeout);
        SyncTaskCheckResult(error, stm, submitTask->id);
        stm->StreamSyncUnLock();
        return error;
    }
    return RT_ERROR_NONE;
}
void SaveTaskCommonInfo(TaskInfo *taskInfo, Stream * const stm, uint32_t pos, uint32_t sqeNum)
{
    InitByStream(taskInfo, stm);
    taskInfo->id = pos;
    taskInfo->sqeNum = static_cast<uint8_t>(sqeNum);
    taskInfo->flipNum = stm->GetTaskIdFlipNum();
    SetTaskTag(taskInfo);
}

rtError_t SubmitTaskPostProc(Stream * const stm, uint32_t pos, bool isNeedStreamSync, int32_t timeout)
{
    if (stm->GetBindFlag()) {
        return RT_ERROR_NONE;
    }
    rtError_t error;
    if (isNeedStreamSync) {
        stm->StreamSyncLock();
        // isStreamSync para set true if need wait cq in unsink stream
        error = SyncTask(stm, pos, timeout);
        SyncTaskCheckResult(error, stm, pos);
        stm->StreamSyncUnLock();
        return error;
    }

    if (stm->IsSeparateSendAndRecycle()) {
        COND_RETURN_INFO((stm->taskResMang_ == nullptr), RT_ERROR_NONE, "taskResMang_ is null device_id=%u, stream_id=%d",
            stm->Device_()->Id_(), stm->Id_());

        TaskResManageDavid *taskResMang = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(stm->taskResMang_);
        if (((taskResMang->GetAllocNum()) % TASK_QUERY_INTERVAL_NUM) != 0U) {
            return RT_ERROR_NONE;
        }

        stm->Device_()->WakeUpRecycleThread();
        return RT_ERROR_NONE;
    }

    error = TryRecycleTask(stm);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Try recycle task failed, retCode=%#x.",
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

int32_t GetTaskIdBitWidth()
{
    const int32_t taskIdBitWidthForDavid = 32;
    return taskIdBitWidthForDavid;
}

const char_t* TaskIdDesc()
{
    return "task_pos";
}

const char_t* TaskIdCamelbackNaming()
{
    return "taskPos";
}

void PrintStarsCqeInfo(const rtLogicCqReport_t &cqe, const uint32_t devId, const uint32_t cqId)
{
    RT_LOG(RT_LOG_DEBUG, "device_id=%u,sq_id=%hu,sq_head=%hu,cq_id=%u,sqe_type=%hhu",
        devId, cqe.sqId, cqe.sqHead, cqId, cqe.sqeType);
    return;
}

uint32_t GetProfTaskId(const TaskInfo * const taskInfo)
{
    return taskInfo->taskSn;
}

uint32_t GetTaskId(const TaskInfo* const taskInfo) { return taskInfo->taskSn; }

}  // namespace runtime
}  // namespace cce
