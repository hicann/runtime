/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_xpu.hpp"
#include "task_res_da.hpp"
#include "stream_xpu.hpp"
#include "stream.hpp"
#include "tprt_api.h"
#include "tprt_error_code.h"
#include "xpu_context.hpp"
#include "task_manager_xpu.hpp"

namespace cce {
namespace runtime {
constexpr uint16_t TASK_QUERY_INTERVAL_NUM = 64U;     // Shared memory query interval.

void XpuTaskRollBack(Stream * const stm, uint32_t pos)
{
    if ((unlikely(stm == nullptr)) || (unlikely(stm->taskResMang_ == nullptr)) || (pos >= stm->taskResMang_->taskPoolNum_)) {
        RT_LOG(RT_LOG_ERROR, "stream is invalid, pos=%u.", pos);
        return;
    }
    TaskResManageDavid *taskResMang = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(stm->taskResMang_);
    taskResMang->RollbackTail(pos);
}

rtError_t XpuAllocTaskInfo(TaskInfo **taskInfo, Stream * const stm, uint32_t &pos, uint32_t sqeNum)
{
    if ((taskInfo == nullptr) || (stm == nullptr) || (stm->taskResMang_ == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "stream is invalid.");
        return RT_ERROR_INVALID_VALUE;
    }

    TaskResManageDavid *taskResMang = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(stm->taskResMang_);
    rtError_t error = taskResMang->AllocTaskInfoAndPos(sqeNum, pos, taskInfo);

    while (error == RT_ERROR_TASKRES_QUEUE_FULL) {
        stm->StreamUnLock();
        rtError_t status = stm->CheckContextStatus();
        ERROR_RETURN(status, "context is abort, stream_id=%d, status=%#x.", stm->Id_(), static_cast<uint32_t>(status));
        if (!stm->Device_()->GetIsDoingRecycling()) {
            stm->Device_()->WakeUpRecycleThread();
        }
        stm->StreamLock();
        error = taskResMang->AllocTaskInfoAndPos(sqeNum, pos, taskInfo, false);
    }
    return error;
}

static void XpuSendTaskPostProc(Stream *const stream, uint32_t prePos, uint32_t sqeNum)
{
    TaskResManageDavid *taskResMang = dynamic_cast<TaskResManageDavid *>(stream->taskResMang_);
    if ((stream->GetPendingNum() != 0U) && (((taskResMang->GetAllocNum()) % TASK_QUERY_INTERVAL_NUM) == 0U)) {
        stream->Device_()->WakeUpRecycleThread();
    }
    if ((prePos + sqeNum) < (stream->GetSqDepth())) {
        return;
    }
    // update flip num
    stream->SetTaskIdFlipNum(stream->GetTaskIdFlipNum() + 1U);
    return;
}

rtError_t XpuSendTask(TaskInfo *taskInfo, Stream * const stm)
{
    TprtSqe_t tprtSqe[SQE_NUM_PER_DAVID_TASK_MAX] = {};
    TprtSqe_t *sqeAddr = tprtSqe;
    const uint16_t pos = taskInfo->id;
    const Device *dev = stm->Device_();
    const uint32_t devId = dev->Id_();
    const uint32_t sqId = stm->GetSqId();
    ToConstructXpuSqe(taskInfo, sqeAddr);
    // update the host-side head and tail
    const rtError_t error = stm->StarsAddTaskToStream(taskInfo, taskInfo->sqeNum);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Add task failed stream_id=%d, task_id=%u.", stm->Id_(), taskInfo->id);
        return error;
    }

    TprtTaskSendInfo_t sendInfo = {};
    sendInfo.sqeNum = taskInfo->sqeNum;
    sendInfo.sqId = sqId;
    sendInfo.sqeAddr = RtPtrToPtr<uint8_t *, TprtSqe_t *>(sqeAddr);
    uint32_t result = TprtSqPushTask(devId, &sendInfo);
    if (result == TPRT_SUCCESS) {
        XpuSendTaskPostProc(stm, pos, taskInfo->sqeNum);
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%hu, latest flip_num=%u, task_type=%u(%s),"
        " drvRet=%u.", devId, stm->Id_(), taskInfo->id, stm->GetTaskIdFlipNum(), static_cast<uint32_t>(taskInfo->type),
        GetTaskDescByType(taskInfo->type), result);
    return result != TPRT_SUCCESS ? RT_ERROR_DRV_ERR : RT_ERROR_NONE;
}

rtError_t XpuCheckTaskCanSend(Stream * const stm)
{
    TaskResManageDavid *taskResManag = RtPtrToPtr<TaskResManageDavid *, TaskResManage *>(stm->taskResMang_);
    if (unlikely(taskResManag == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "device_id=%u stream_id=%d(flags=0x%x) does not support send task.",
            stm->Device_()->Id_(), stm->Id_(), stm->Flags());
        return RT_ERROR_STREAM_INVALID;
    }

    rtError_t status = stm->CheckContextStatus();
    ERROR_RETURN(status, "context is abort, stream_id=%u, status=%#x.", stm->Id_(), static_cast<uint32_t>(status));
    return RT_ERROR_NONE;
}

void XpuSaveTaskCommonInfo(TaskInfo *taskInfo, Stream * const stm, uint32_t pos, uint32_t sqeNum)
{
    InitByStream(taskInfo, stm);
    taskInfo->id = pos;
    taskInfo->sqeNum = static_cast<uint8_t>(sqeNum);
    taskInfo->flipNum = stm->GetTaskIdFlipNum();
    taskInfo->taskSn = taskInfo->flipNum * stm->GetSqDepth() + (taskInfo->id);
    taskInfo->needPostProc = false;
}

void XpuSetArgsAicpu(const rtAicpuArgsEx_t * const aicpuArgsInfo, TaskInfo * const taskInfo, DavidArgLoaderResult * const result)
{
    AicpuTaskInfo *aicpuTask = &(taskInfo->u.aicpuTaskInfo);
    aicpuTask->comm.args = result->kerArgs;

    if (aicpuArgsInfo != nullptr) {
        aicpuTask->comm.argsSize = aicpuArgsInfo->argsSize;
    }

    if (result->handle != nullptr) {
        aicpuTask->comm.argHandle = result->handle;
    }
    taskInfo->stmArgPos = static_cast<XpuStream *>(taskInfo->stream)->GetArgPos();
    result->stmArgPos = UINT32_MAX;
    result->handle = nullptr;
}

}  // namespace runtime
}  // namespace cce
