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
#include "timeout_set_task.h"

namespace cce {
namespace runtime {

#if F_DESC("TaskTimeoutSetTask")
void TimeoutSetTaskInitV1(TaskInfo* taskInfo)
{
    TimeoutSetTaskInfo *timeoutSetTask = &(taskInfo->u.timeoutSetTask);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_TASK_TIMEOUT_SET;
    taskInfo->typeName = "TASK_TIMEOUT_SET";
    timeoutSetTask->opWaitTimeoutEn = false;
    timeoutSetTask->opWaitTimeout = 0U;
    timeoutSetTask->opExecuteTimeoutEn = false;
    timeoutSetTask->opExecuteTimeout = 0U;
}

rtError_t TimeoutSetTaskInit(TaskInfo* taskInfo, const rtTaskTimeoutType_t type, const uint32_t timeout)
{
    TimeoutSetTaskInitV1(taskInfo);
    TimeoutSetTaskUpdate(taskInfo, type, timeout);
    return RT_ERROR_NONE;
}

void TimeoutSetTaskUpdate(TaskInfo* taskInfo, const rtTaskTimeoutType_t type, const uint32_t timeout)
{
    TimeoutSetTaskInfo *timeoutSetTask = &(taskInfo->u.timeoutSetTask);
    switch (type) {
        case RT_TIMEOUT_TYPE_OP_WAIT:
            timeoutSetTask->opWaitTimeoutEn = true;
            timeoutSetTask->opWaitTimeout = timeout;
            break;
        case RT_TIMEOUT_TYPE_OP_EXECUTE:
            timeoutSetTask->opExecuteTimeoutEn = true;
            timeoutSetTask->opExecuteTimeout = timeout;
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "Invalid task timeout type=%d", type);
            break;
    }
    RT_LOG(RT_LOG_DEBUG, "Create TaskTimeout task, task_id=%u, task_type=%d(%s), stream_id=%d, timeout=%us, type=%d",
           static_cast<uint32_t>(taskInfo->id), static_cast<int32_t>(taskInfo->type), taskInfo->typeName,
           taskInfo->stream->Id_(), timeout, type);
}

void ToCommandBodyForTimeoutSetTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    TimeoutSetTaskInfo * const timeoutSetTask = &(taskInfo->u.timeoutSetTask);
    command->u.timeoutSetTask.opWaitTimeoutEn = timeoutSetTask->opWaitTimeoutEn;
    command->u.timeoutSetTask.opExecuteTimeoutEn = timeoutSetTask->opExecuteTimeoutEn;

    command->u.timeoutSetTask.opWaitTimeout = timeoutSetTask->opWaitTimeout;
    command->u.timeoutSetTask.opExecuteTimeout = timeoutSetTask->opExecuteTimeout;
}
#endif
}  // namespace runtime
}  // namespace cce
