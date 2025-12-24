/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"

namespace cce {
namespace runtime {

#if F_DESC("MaintenanceTask")
rtError_t MaintenanceTaskInit(TaskInfo * const taskInfo, const MtType type, const uint32_t id,
                              bool flag, const uint32_t idType)
{
    MaintenanceTaskInfo *maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MAINTENANCE;
    taskInfo->typeName = "MAINTENANCE";

    maintenanceTaskInfo->mtType = type;
    maintenanceTaskInfo->mtId = id;
    maintenanceTaskInfo->mtIdType = idType;
    maintenanceTaskInfo->flag = flag;
    maintenanceTaskInfo->waitCqId = MAX_UINT16_NUM;

    if (taskInfo->stream->Device_()->IsStarsPlatform()) {
        taskInfo->isNeedStreamSync = true;
        taskInfo->needPostProc = true;
    } else {
        if ((type == MT_STREAM_DESTROY) || (type == MT_STREAM_RECYCLE_TASK)) {
            taskInfo->isNeedStreamSync = true;
        }
        if ((type == MT_STREAM_RECYCLE_TASK) && flag) {
            taskInfo->isForceCycle = true;
        }
    }

    return RT_ERROR_NONE;
}

void ToCommandBodyForMaintenanceTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    MaintenanceTaskInfo *maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);

    command->u.maintenanceTask.goal = maintenanceTaskInfo->mtType;
    command->u.maintenanceTask.targetID = static_cast<uint16_t>(maintenanceTaskInfo->mtId);
    command->u.maintenanceTask.terminal = taskInfo->terminal;
    command->u.maintenanceTask.waitCqId = maintenanceTaskInfo->waitCqId;
    command->u.maintenanceTask.threadId = PidTidFetcher::GetCurrentTid();
    if (maintenanceTaskInfo->flag && (maintenanceTaskInfo->mtType == MT_STREAM_RECYCLE_TASK)) {
        command->u.maintenanceTask.flag = FORCE_RECYCLE_TASK_FLAG; // for force recycle
    }
}

void ConstructSqeForMaintenanceTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    MaintenanceTaskInfo *maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    if (maintenanceTaskInfo->flag && (maintenanceTaskInfo->mtType == MT_STREAM_RECYCLE_TASK)) {
        sqe->u.maintaince_info.sub_type = FORCE_RECYCLE_TASK_FLAG;
        sqe->u.maintaince_info.target_id = static_cast<uint16_t>(maintenanceTaskInfo->mtId);
        sqe->pre_p = 1U; // for force recycle
    } else {
        sqe->pre_p = 0U;
    }

    sqe->post_p = 0U;
    sqe->wr_cqe = 1U;       // need write cqe for recycle task
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_MAINTENANCE;

    uint16_t streamId = static_cast<uint16_t>(stream->Id_());
    if (!stream->IsSeparateSendAndRecycle()) {
        streamId |= RT_SYNC_TASK_FLAG;
    }
    sqe->rt_streamID = streamId;
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    PrintSqe(command, "MaintenanceTask");
    RT_LOG(RT_LOG_INFO, "MaintenanceTask stream_id:%d task_id:%u.", stream->Id_(), static_cast<uint32_t>(taskInfo->id));
}

void DoCompleteSuccessForMaintenanceTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    MaintenanceTaskInfo *maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    const Device *const devicePtr = stream->Device_();

    if ((!Runtime::Instance()->GetDisableThread()) && (maintenanceTaskInfo->mtType == MT_EVENT_DESTROY)) {
        const rtError_t errorCode = driver->EventIdFree(static_cast<int32_t>(maintenanceTaskInfo->mtId),
            devicePtr->Id_(), devicePtr->DevGetTsId());
        COND_RETURN_VOID(errorCode != RT_ERROR_NONE, "event id free errorCode, id=%u, deviceId=%u, retCode=%#x",
            maintenanceTaskInfo->mtId, devicePtr->Id_(), errorCode);
    }
}

#endif

}  // namespace runtime
}  // namespace cce