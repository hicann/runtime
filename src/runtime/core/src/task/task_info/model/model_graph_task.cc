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
#include "model_graph_task.h"

namespace cce {
namespace runtime {

#if F_DESC("AddEndGraphTask")

rtError_t AddEndGraphTaskInit(TaskInfo* taskInfo, const uint32_t modelId, const uint32_t exeFlag,
                              const uint64_t argParam, const uint64_t endGraphName,
                              const uint8_t flags)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "MODEL_END_GRAPH";
    taskInfo->type = TS_TASK_TYPE_MODEL_END_GRAPH;
    taskInfo->u.addEndGraphTask.modelId = modelId;
    taskInfo->u.addEndGraphTask.executorFlag = exeFlag;
    taskInfo->u.addEndGraphTask.argptr = argParam;
    taskInfo->u.addEndGraphTask.endGraphNamePtr = endGraphName;
    taskInfo->u.addEndGraphTask.datadumpFlag = flags;
    RT_LOG(RT_LOG_DEBUG, "Create end graph task,mode_id=%u,executor flag=%u,task_id=%u,task_type=%d(%s),"
        "stream_id=%d,datadumpFlag=%u.",
        modelId, exeFlag, static_cast<uint32_t>(taskInfo->id), static_cast<int32_t>(taskInfo->type),
        taskInfo->typeName, taskInfo->stream->Id_(),
        static_cast<uint32_t>(taskInfo->u.addEndGraphTask.datadumpFlag));
    return RT_ERROR_NONE;
}

void ToCmdBodyForAddEndGraphTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    Stream *stm = taskInfo->stream;

    command->u.modelEndGraphTask.modelId = taskInfo->u.addEndGraphTask.modelId;
    command->u.modelEndGraphTask.executorFlag = taskInfo->u.addEndGraphTask.executorFlag;
    command->u.modelEndGraphTask.argptr = taskInfo->u.addEndGraphTask.argptr;
    command->u.modelEndGraphTask.endGraphNamePtr = taskInfo->u.addEndGraphTask.endGraphNamePtr;
    command->u.modelEndGraphTask.priority = static_cast<uint8_t>(stm->Priority());
    command->u.modelEndGraphTask.flag = taskInfo->u.addEndGraphTask.datadumpFlag;
    command->taskInfoFlag |= static_cast<uint8_t>(ENDGRAPH_INFO_FLAG);
}

#endif

#if F_DESC("AddModelExitTask")

rtError_t AddModelExitTaskInit(TaskInfo* taskInfo, const uint32_t modelId)
{
    TaskCommonInfoInit(taskInfo);
    Stream *stm = taskInfo->stream;
    taskInfo->typeName = "MODEL_EXIT_GRAPH";
    taskInfo->type = TS_TASK_TYPE_MODEL_EXIT_GRAPH;
    taskInfo->u.addModelExitTask.modelId = modelId;
    taskInfo->u.addModelExitTask.streamId = static_cast<uint32_t>(stm->Id_());
    RT_LOG(RT_LOG_DEBUG, "Create model exit task,mode_id=%u,task_id=%u,task_type=%d(%s),stream_id=%d.",
        modelId, static_cast<uint32_t>(taskInfo->id), static_cast<int32_t>(taskInfo->type),
        taskInfo->typeName, static_cast<uint32_t>(taskInfo->stream->Id_()));
    return RT_ERROR_NONE;
}

void ToCmdBodyForAddModelExitTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    command->u.modelExitTask.modelId = taskInfo->u.addModelExitTask.modelId;
    command->u.modelExitTask.streamId = taskInfo->u.addModelExitTask.streamId;
    command->taskInfoFlag |= static_cast<uint8_t>(ENDGRAPH_INFO_FLAG);
}

#endif

}  // namespace runtime
}  // namespace cce
