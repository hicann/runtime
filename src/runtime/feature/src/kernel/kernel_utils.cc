/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "kernel_utils.hpp"

namespace cce {
namespace runtime {
void ComputeRatio(uint16_t ratio[2], uint32_t mixType, uint32_t taskRatio) 
{
    ratio[0] = 0U;
    ratio[1] = 0U;
    switch (mixType) {
        case NO_MIX:
            break;
        case MIX_AIC:
            ratio[0] = 1U;
            ratio[1] = 0U;
            break;
        case MIX_AIV:
            ratio[0] = 0U;
            ratio[1] = 1U;
            break;
        case MIX_AIC_AIV_MAIN_AIC:
            if (taskRatio == 1U) {
                ratio[0] = 1U;
                ratio[1] = 1U;
            } else if (taskRatio == 2U) {
                ratio[0] = 1U;
                ratio[1] = 2U;
            } else {
                RT_LOG(RT_LOG_WARNING, "Unsupported mixType=%u, taskRatio=%u", mixType, taskRatio);
            }
            break;
        case MIX_AIC_AIV_MAIN_AIV:
            if (taskRatio == 1U) {
                ratio[0] = 1U;
                ratio[1] = 1U;
            } else if (taskRatio == 2U) {
                ratio[0] = 2U;
                ratio[1] = 1U;
            } else {
                RT_LOG(RT_LOG_WARNING, "Unsupported mixType=%u, taskRatio=%u", mixType, taskRatio);
            }
            break;
        default:
            RT_LOG(RT_LOG_WARNING, "Unsupported mixType=%u, taskRatio=%u", mixType, taskRatio);
            break;
    }
}

rtError_t GetTaskType(const TaskInfo * const task, rtTaskType *type)
{
    if (task->stream == nullptr) {
        RT_LOG(RT_LOG_ERROR, "The stream associated with the task does not exist, taskId=%u.", task->id);
        return RT_ERROR_INVALID_VALUE;
    }
    rtTaskType taskType = rtTaskType::RT_TASK_DEFAULT;
    switch(task->type) {
        case TS_TASK_TYPE_KERNEL_AICORE: 
        case TS_TASK_TYPE_KERNEL_AIVEC:
            taskType = RT_TASK_KERNEL;
            break;
        case TS_TASK_TYPE_CAPTURE_WAIT:
        case TS_TASK_TYPE_STREAM_WAIT_EVENT:
            taskType = RT_TASK_EVENT_WAIT;
            break;
        case TS_TASK_TYPE_MEM_WAIT_VALUE: 
            taskType = RT_TASK_VALUE_WAIT;
            break;
        case TS_TASK_TYPE_EVENT_RECORD:
        case TS_TASK_TYPE_CAPTURE_RECORD:
            taskType = RT_TASK_EVENT_RECORD;
            break;
        case TS_TASK_TYPE_EVENT_RESET:
            taskType = RT_TASK_EVENT_RESET;
            break;
        case TS_TASK_TYPE_MEM_WRITE_VALUE:
            taskType = strcmp(task->typeName, "EVENT_RESET") != 0 ? RT_TASK_VALUE_WRITE : RT_TASK_EVENT_RESET;
            break;
        default:
            break;
    }
    *type = taskType;
    RT_LOG(RT_LOG_INFO, "end to get task type, streamId=%d, taskId=%u, alloc taskType=%d, taskName=%s, convert to rtTaskType=%d.",
        task->stream->Id_(), task->id, task->type, task->typeName, taskType);
    return RT_ERROR_NONE;
}

}
}