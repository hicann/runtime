/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
#include "maintenance_task.h"

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

#endif

}  // namespace runtime
}  // namespace cce
